/*CONTRATO-OPR RESUELVE EL GRADO DE SATISFACCION DE UN clientes EN CADA DIA INDICADO EN RVALOR, SEGUN RESTRICCIONES*/
/*recibe como entrada la tabla analizado con los eventos(contratos) a analizar 
y debe barrer las restricciones y evaluarla poniendo su valor en la tabla rvalor*/
/*tener en cuenta que cada analizado es restrictor de si mismo o de un grupo
Las restricciones del restrictor son las analizadas, la de los eventos que lo acompañan son
ignoradas*/
/*Se contabilizan los resultados en donde las muestras dan algun valor positivo*/


{tablasTT-opr.i}
PROCEDURE calculo:
define input param ppnro_evento as int no-undo.
define output param pacumula as decimal no-undo.
define output param pmuestras as integer no-undo.
define var flg as logical no-undo.
define var v as decimal no-undo.
DEFINE VAR vmobs AS CHAR NO-UNDO.
DEFINE VAR esdesborde AS logical NO-UNDO.
DEFINE BUFFER bevento FOR evento.
DEFINE VAR fesdesborde AS logical NO-UNDO. /*flag de si es un valor de muestra o de desborde para el evento en la fecha dada*/
find evento where evento.nro_evento = ppnro_evento AND evento.fasignado=? AND NOT anulado NO-ERROR.
IF NOT AVAILABLE evento THEN DO:
    MESSAGE "Error evento pasado nro:" ppnro_evento " no existe" VIEW-AS ALERT-BOX ERROR.
    LEAVE.
END.
IF evento.evsigue <> 0 THEN DO:
    FIND bevento WHERE bevento.nro_evento = evento.evsigue AND bevento.fasignado<>? NO-LOCK.
    IF NOT AVAILABLE bevento THEN DO:
        MESSAGE "Evento relacionado " evento.evsigue " No encontrado o no asignado" VIEW-AS ALERT-BOX ERROR.
        LEAVE.
    END.
END.

pacumula = 0.
pmuestras = 0.
    /*el flg es porque si un contrato no tiene restricciones su valor es 1*/
FOR EACH rvalor WHERE rvalor.nro_evento = evento.nro_evento:
           flg=false.
           fesdesborde = FALSE.
           IF evento.evsigue = 0  THEN DO:
               FOR EACH cliente_restriccion WHERE cliente_restriccion.nro_cliente = evento.nro_cliente 
                        , EACH restriccion OF cliente_restriccion where restriccion.evaluar AND restriccion.esrestriccion
                            AND Restriccion.nro_tipo_evento = evento.nro_tipo_evento :
                           IF search(Restriccion.Pgm_eval)=? THEN do:
                               NEXT.
                           END.
                           else do:
                               
                               RUN  value(Restriccion.Pgm_eval) ( 
                                                                 input evento.nro_evento, 
                                                                 INPUT rvalor.fecha , 
                                                                 INPUT cliente_restriccion.valor , 
                                                                 OUTPUT v ,
                                                                 OUTPUT esdesborde,
                                                                 OUTPUT vmobs
                                                                 ) NO-ERROR.
                               /* MESSAGE Restriccion.Pgm_eval cliente_restriccion.valor fecha v VIEW-AS ALERT-BOX ERROR.*/
                               IF error-status:ERROR THEN do: 
                                   v = 0.
                                   rvalor.mobs = rvalor.mobs + " ERROR " + Restriccion.Pgm_eval.
                               END.
                               ELSE DO:
                                   rvalor.valor = rvalor.valor + v. /*se acumula satisfaccion para ese dia*/
                                   rvalor.mobs = IF rvalor.mobs <> "" THEN rvalor.mobs + " " + vmobs ELSE vmobs.
                                   fesdesborde = fesdesborde OR esdesborde.
                               END.
                           END.
                           flg=true.
               END.
               
                               
        /*restricciones general por diferencia de dias con el evento anterior*/
        /*La importante es intentar mantener una diferencia de dias igual a la cantidad de dias del mes anterior
        si por ejemplo se realizo el 1/2 se realizara el 1/3 dependera ademas de otras restricciones
        Esto solo acumula satisfaccion para cuando se cumpla segun una distribucion determinada*/
        /*solo suma  restricciones de segundo orden cuando no hay desbordes*/

                     RUN eval-diasdif.p ( input evento.nro_evento,
                                          INPUT rvalor.fecha , 
                                          INPUT IF NUM-ENTRIES(evento.recursos) = 1 THEN "10" ELSE "15" ,  
                                          OUTPUT v ,
                                          OUTPUT esdesborde,
                                          OUTPUT vmobs ).
                     
                     /*solo le suma si hay alguna satisfaccion sino no*/
                     /*siempre lo tomo como desborde aun para el valor dia correcto ya que es una restriccion 
                     de segundo orden es decir una restriccion anterior le asigno posibilidad*/
                     rvalor.mobs = IF rvalor.mobs <> "" THEN rvalor.mobs + " " + vmobs ELSE vmobs.
                     IF v <> 0 THEN DO:
                         rvalor.valor = if rvalor.valor > 0 then rvalor.valor + v ELSE 0.
                     END.
                     ELSE DO:
                         rvalor.valor = 0.
                     END.
               
        /*fin restricciones generales*/
           END.
                     
    /*acumulamos la suma para priorizar*/
           ELSE DO:
                FIND restriccion no-lock WHERE restriccion.evaluar AND cdg_restriccion = "DfEV" NO-ERROR.
                IF AVAILABLE restriccion THEN DO:
                    FIND cliente_restriccion WHERE cliente_restriccion.nro_cliente = evento.nro_cliente AND
                                                    cliente_restriccion.nro_restriccion = restriccion.nro_restriccion.
                    rvalor.valor = IF rvalor.fecha = bevento.fasignado + integer(entry(3,cliente_restriccion.valor, "|" )) THEN 1 ELSE 0.
                    vmobs  = IF rvalor.valor <> 0 THEN "dfEV[" + STRING(bevento.fasignado) + "," + ENTRY(3,cliente_restriccion.valor, "|") + "]" ELSE "".
                    rvalor.mobs = IF rvalor.mobs <> "" THEN rvalor.mobs + " " + vmobs ELSE vmobs.
                    fesdesborde = FALSE.
                    flg = TRUE.
                END.
           END.
           ASSIGN   rvalor.valor = if not flg AND weekday(fecha) <> 7 then 1 else rvalor.valor . 
                    pacumula = pacumula + rvalor.valor.
                    pmuestras = if NOT fesdesborde AND rvalor.valor > 0 then pmuestras + 1 else pmuestras.
END.
END procedure.

/*############################################
comienzo de la VALUACION masiva de eventos
############################################*/

DEFINE INPUT-OUTPUT PARAMETER TABLE FOR analizado.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR rvalor.
define input parameter wh as HANDLE NO-UNDO.
DEFINE INPUT PARAMETER pnro_evento as integer no-undo.
DEFINE INPUT PARAMETER nplan AS INT NO-UNDO.

DEFINE BUFFER bevento FOR evento.
define buffer banalizado for analizado.
DEFINE VAR rbevento AS ROWID NO-UNDO.
DEF VAR i AS INT NO-UNDO.
DEF var kkk as int no-undo.
define var pacumula as DECIMAL NO-UNDO.
define var pmuestras as INT NO-UNDO.
kkk = 0.

IF pnro_evento = ? THEN 
    do:
    /*son solo eventos del tipo sub_evento = 1 o que EVsigue es 0 , otro nro de sub_evento mayor se hace despues pasando en numero de evento ya que la asignacion depende de este*/
    /*valorizamos primero los sub_evento 1 sin dependencia, despues los 2 sin dependencia despues con dependencia 1 y dos*/
        FOR EACH analizado use-index idx2:
            find evento OF analizado.
            
            if evento.sub_evento > 1 OR evento.evsigue <> 0 then next. /*porque aun no estan asignados*/
            ASSIGN analizado.muestras = 0
                   analizado.sumas = 0.
        
            /*buscamos el ultimo evento asignado para este contrato, se utilizara en las restricciones generales*/
            /*intentamos mantener el mismo recurso que el evento anteriora si no se forzaron recursos nuevos*/
           
            rbevento = ?.
            FOR LAST bevento WHERE 
                bevento.nro_tipo_evento = evento.nro_tipo_evento AND
                bevento.origen = evento.origen AND 
                bevento.nro_cliente = evento.nro_cliente AND
                bevento.sub_evento = evento.sub_evento AND
                NOT bevento.anulado AND 
                bevento.frealizado <>? AND 
                bevento.nro_evento <= evento.nro_evento AND
                ROWID(bevento) <> ROWID(evento) BY bevento.frealizado DESC:
                         rbevento = ROWID(bevento).
                         LEAVE.
            END.
            if rbevento <> ? then do:
               FIND bevento WHERE ROWID(bevento) = rbevento.
               if analizado.recursos = "" then analizado.recursos = bevento.recursos.
               /*evento.duracion = bevento.duracion.*/
            END.

            /*fin datos de los eventos anteriores*/ 

            run calculo(analizado.nro_evento,output pacumula,output pmuestras).
            analizado.muestras = pmuestras  * 1000 / analizado.hduracion.
            analizado.sumas = pacumula.
            FOR first rvalor WHERE rvalor.nro_evento = analizado.nro_evento and
                rvalor.valor <> 0 USE-INDEX idx2: 
            /*Los dias con valores mas alto con los que mas satisfacen la ubicacion, solo para estadistica de satisfaccion general*/
            ASSIGN analizado.FMSatif = rvalor.fecha
                   analizado.maxsatif = rvalor.valor.
            END.
            kkk = kkk + 1.
            run incprog3 in wh ( kkk ).
        END.
    END.
else 
    do: 
        run calculo(pnro_evento,output pacumula,output pmuestras).
        find analizado where analizado.nro_evento = pnro_evento NO-ERROR.
        IF NOT AVAILABLE analizado THEN do: /* no es un restrictor buscar el padre*/
            MESSAGE "Error de datos.Un evento de nivel > 1 DEBE ser padre" skip pnro_evento VIEW-AS ALERT-BOX ERROR.
            FIND evento WHERE evento.nro_evento = pnro_evento.
            FIND analizado WHERE analizado.nro_evento = evento.nro_evento_padre NO-ERROR.
            IF NOT AVAILABLE analizado OR evento.nro_evento_padre = 0 THEN MESSAGE  "Error interno.No se encuentra el evento padre " skip pnro_evento evento.nro_evento_padre VIEW-AS ALERT-BOX ERROR.
        END.    
        analizado.muestras=pmuestras * 1000 / analizado.hduracion.
        analizado.sumas = pacumula.
        FOR first rvalor WHERE rvalor.nro_evento = analizado.nro_evento and
            rvalor.valor <> 0 USE-INDEX idx2: 
            /*Los dias con valores mas alto con los que mas satisfacen la ubicacion, solo para estadistica de satisfaccion general*/
            ASSIGN analizado.FMSatif = rvalor.fecha
                   analizado.maxsatif = rvalor.valor.
        END.

    END.
