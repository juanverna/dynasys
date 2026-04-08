/*CONTRATO-OPR RESUELVE EL GRADO DE SATISFACCION DE UN CONTRATO EN CADA DIA INDICADO EN RVALOR, SEGUN RESTRICCIONES*/
/*recibe como entrada la tabla analizado con los eventos(contratos) a analizar 
y debe barrer las restricciones y evaluarla poniendo su valor en la tabla rvalor*/
/*tener en cuenta que cada analizado es restrictor de si mismo o de un grupo
Las restricciones del restrictor son las analizadas, la de los eventos que lo acompañan son
ignoradas*/
/*Se contabilizan los resultados en donde las muestras dan algun valor positivo*/


{tablasTT-opr.i}
PROCEDURE calculo:
    DEFINE INPUT PARAMETER ppnro_evento AS INTEGER NO-UNDO.
    DEFINE OUTPUT PARAMETER pacumula AS DECIMAL NO-UNDO.
    DEFINE OUTPUT PARAMETER pmuestras AS INTEGER NO-UNDO.
    DEFINE INPUT PARAMETER nplan AS INTEGER NO-UNDO.
    DEFINE VARIABLE flg        AS LOGICAL   NO-UNDO.
    DEFINE VARIABLE v          AS DECIMAL   NO-UNDO.
    DEFINE VARIABLE vmobs      AS CHARACTER NO-UNDO.
    DEFINE VARIABLE esdesborde AS LOGICAL   NO-UNDO.
    DEFINE BUFFER bevento FOR evento.
    DEFINE VARIABLE fesdesborde AS LOGICAL NO-UNDO. /*flag de si es un valor de muestra o de desborde para el evento en la fecha dada*/
    FIND evento WHERE evento.nro_evento = ppnro_evento AND evento.fasignado=? AND NOT anulado NO-ERROR.
    IF NOT AVAILABLE evento THEN 
    DO:
        OUTPUT TO value("c:\sic-temp\erroresplan" + STRING(nplan) + ".txt" ) APPEND.
        PUT UNFORMATTED NOW " Error evento pasado nro:" ppnro_evento " no existe" SKIP.
        OUTPUT CLOSE.
        RETURN ERROR.
    END.
    IF evento.evsigue <> 0 THEN 
    DO:
        FIND bevento WHERE bevento.nro_evento = evento.evsigue AND bevento.fasignado<>? NO-LOCK.
        IF NOT AVAILABLE bevento THEN 
        DO:
            OUTPUT TO value("c:\sic-temp\erroresplan" + STRING(nplan) + ".txt" ) APPEND.
            PUT UNFORMATTED  "Evento relacionado " evento.evsigue " No encontrado o no asignado" SKIP.
            OUTPUT CLOSE.
            LEAVE.
        END.
    END.

    pacumula = 0.
    pmuestras = 0.
    /*el flg es porque si un contrato no tiene restricciones su valor es 1*/
    FOR EACH rvalor WHERE rvalor.nro_evento = evento.nro_evento:
        flg=FALSE.
        fesdesborde = FALSE.
        IF evento.evsigue = 0  THEN 
        DO:
            FOR EACH contrato_restriccion WHERE contrato_restriccion.nro_contrato = evento.nro_identificacion 
                AND contrato_restriccion.sub_evento = evento.sub_evento
                , EACH restriccion NO-LOCK OF contrato_restriccion WHERE restriccion.evaluar AND restriccion.esrestriccion AND restriccion.tipo = "A" AND
                restriccion.nro_tipo_evento = evento.nro_tipo_evento:
                IF search(Restriccion.Pgm_eval)=? THEN 
                DO:
                    NEXT.
                END.
                ELSE 
                DO:
                               
                    RUN  value(Restriccion.Pgm_eval) ( 
                        INPUT evento.nro_evento, 
                        INPUT rvalor.fecha , 
                        INPUT contrato_restriccion.valor , 
                        OUTPUT v ,
                        OUTPUT esdesborde,
                        OUTPUT vmobs
                        ) NO-ERROR.
                    /* MESSAGE Restriccion.Pgm_eval contrato_restriccion.valor fecha v VIEW-AS ALERT-BOX ERROR.*/
                    IF ERROR-STATUS:ERROR THEN 
                    DO: 
                        v = 0.
                        rvalor.mobs = rvalor.mobs + " ERROR " + Restriccion.Pgm_eval.
                    END.
                    ELSE 
                    DO:
                        rvalor.valor = rvalor.valor + v. /*se acumula satisfaccion para ese dia*/
                        rvalor.mobs = IF rvalor.mobs <> "" THEN rvalor.mobs + " " + vmobs ELSE vmobs.
                        fesdesborde = fesdesborde OR esdesborde.
                    END.
                END.
                flg=TRUE.
            END.
                               
            /*restricciones general por diferencia de dias con el evento anterior*/
            /*La importante es intentar mantener una diferencia de dias igual a la cantidad de dias del mes anterior
            si por ejemplo se realizo el 1/2 se realizara el 1/3 dependera ademas de otras restricciones
            Esto solo acumula satisfaccion para cuando se cumpla segun una distribucion determinada*/
            /*solo suma  restricciones de segundo orden cuando no hay desbordes*/

            RUN eval-diasdif.p ( INPUT evento.nro_evento,
                INPUT rvalor.fecha , 
                INPUT IF NUM-ENTRIES(evento.recursos) = 1 THEN "10" ELSE "15" ,  
                OUTPUT v ,
                OUTPUT esdesborde,
                OUTPUT vmobs ).
                     
            /*solo le suma si hay alguna satisfaccion sino no*/
            /*siempre lo tomo como desborde aun para el valor dia correcto ya que es una restriccion 
            de segundo orden es decir una restriccion anterior le asigno posibilidad*/
            rvalor.mobs = IF rvalor.mobs <> "" THEN rvalor.mobs + " " + vmobs ELSE vmobs.
            IF v <> 0 THEN 
            DO:
                rvalor.valor = IF rvalor.valor > 0 THEN rvalor.valor + v ELSE 0.
            END.
            ELSE 
            DO:
                rvalor.valor = 0.
            END.
               
        /*fin restricciones generales*/
        END.
                     
        /*acumulamos la suma para priorizar*/
        ELSE 
        DO:
            FIND restriccion NO-LOCK WHERE restriccion.evaluar AND cdg_restriccion = "DfEV" 
                AND restriccion.nro_tipo_evento = evento.nro_tipo_evento NO-ERROR.
            IF AVAILABLE restriccion THEN 
            DO:
                FIND contrato_restriccion WHERE contrato_restriccion.nro_contrato = evento.nro_identificacion AND 
                    contrato_restriccion.sub_evento = evento.sub_evento AND
                    contrato_restriccion.nro_restriccion = restriccion.nro_restriccion.
                rvalor.valor = IF rvalor.fecha = bevento.fasignado + integer(entry(3,contrato_restriccion.valor, "|" )) THEN 1 ELSE 0.
                vmobs  = IF rvalor.valor <> 0 THEN "dfEV[" + STRING(bevento.fasignado) + "," + ENTRY(3,contrato_restriccion.valor, "|") + "]" ELSE "".
                rvalor.mobs = IF rvalor.mobs <> "" THEN rvalor.mobs + " " + vmobs ELSE vmobs.
                fesdesborde = FALSE.
                flg = TRUE.
            END.
        END.
        ASSIGN   
            rvalor.valor = IF NOT flg AND weekday(fecha) <> 7 THEN v ELSE rvalor.valor . /*cuando no hay restriccion de dia perdon perdon*/
        pacumula = pacumula + rvalor.valor.
        pmuestras = IF NOT fesdesborde AND rvalor.valor > 0 THEN pmuestras + 1 ELSE pmuestras.
    END.
END PROCEDURE.

/*############################################
comienzo de la VALUACION masiva de eventos
############################################*/

DEFINE INPUT-OUTPUT PARAMETER TABLE FOR analizado.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR rvalor.
DEFINE INPUT PARAMETER wh AS HANDLE NO-UNDO.
DEFINE INPUT PARAMETER pnro_evento AS INTEGER NO-UNDO.
DEFINE INPUT PARAMETER nplan AS INTEGER NO-UNDO.

DEFINE BUFFER bevento    FOR evento.
DEFINE BUFFER banalizado FOR analizado.
DEFINE VARIABLE rbevento  AS ROWID   NO-UNDO.
DEFINE VARIABLE i         AS INTEGER NO-UNDO.
DEFINE VARIABLE kkk       AS INTEGER NO-UNDO.
DEFINE VARIABLE pacumula  AS DECIMAL NO-UNDO.
DEFINE VARIABLE pmuestras AS INTEGER NO-UNDO.
kkk = 0.

IF pnro_evento = ? THEN 
DO:
    /*son solo eventos del tipo sub_evento = 1 o que EVsigue es 0 , otro nro de sub_evento mayor se hace despues pasando en numero de evento ya que la asignacion depende de este*/
    /*valorizamos primero los sub_evento 1 sin dependencia, despues los 2 sin dependencia despues con dependencia 1 y dos*/
    FOR EACH analizado USE-INDEX idx2:
        FIND evento OF analizado.
            
        IF evento.sub_evento > 1 OR evento.evsigue <> 0 THEN NEXT. /*porque aun no estan asignados*/
        ASSIGN 
            analizado.muestras = 0
            analizado.sumas    = 0.
        
        /*buscamos el ultimo evento asignado para este contrato, se utilizara en las restricciones generales*/
        /*intentamos mantener el mismo recurso que el evento anteriora si no se forzaron recursos nuevos*/
           
        rbevento = ?.
        FOR EACH bevento WHERE 
            bevento.nro_tipo_evento = evento.nro_tipo_evento AND
            bevento.origen = evento.origen AND 
            bevento.nro_identificacion = evento.nro_identificacion AND
            bevento.sub_evento = evento.sub_evento AND
            NOT bevento.anulado AND 
            bevento.frealizado <>? AND 
            bevento.nro_evento <= evento.nro_evento AND
            ROWID(bevento) <> ROWID(evento) BY bevento.frealizado DESCENDING:
            rbevento = ROWID(bevento).
            LEAVE.
        END.
        IF rbevento <> ? THEN 
        DO:
            FIND bevento WHERE ROWID(bevento) = rbevento.
            IF analizado.recursos = "" THEN analizado.recursos = bevento.recursos.
        /*evento.duracion = bevento.duracion.*/
        END.

        /*fin datos de los eventos anteriores*/ 
        RUN calculo(analizado.nro_evento,OUTPUT pacumula,OUTPUT pmuestras,INPUT nplan).
        analizado.muestras = pmuestras  * 1000 / analizado.hduracion.
        analizado.sumas = pacumula.
        FOR FIRST rvalor WHERE rvalor.nro_evento = analizado.nro_evento AND
            rvalor.valor <> 0 USE-INDEX idx2: 
            /*Los dias con valores mas alto con los que mas satisfacen la ubicacion, solo para estadistica de satisfaccion general*/
            ASSIGN 
                analizado.FMSatif  = rvalor.fecha
                analizado.maxsatif = rvalor.valor.
        END.
        kkk = kkk + 1.
        RUN incprog3 IN wh ( kkk ).
    END.
END.
ELSE 
DO: 
    RUN calculo(pnro_evento,OUTPUT pacumula,OUTPUT pmuestras,INPUT nplan).
    FIND analizado WHERE analizado.nro_evento = pnro_evento NO-ERROR.
    IF NOT AVAILABLE analizado THEN 
    DO: /* no es un restrictor buscar el padre*/
        OUTPUT TO value("c:\sic-temp\erroresplan" + STRING(nplan) + ".txt" ) APPEND.
        PUT UNFORMATTED NOW " Error de datos.Un evento de nivel > 1 DEBE ser padre" pnro_evento SKIP.
        OUTPUT CLOSE.
        RETURN ERROR.
    END.
    /*
        FIND evento WHERE evento.nro_evento = pnro_evento.
        FIND analizado WHERE analizado.nro_evento = evento.nro_evento_padre NO-ERROR.
        IF NOT AVAILABLE analizado AND evento.nro_evento_padre <> 0 THEN 
        DO:
            OUTPUT TO value("c:\sic-temp\erroresplan" + STRING(nplan) + ".txt" ) APPEND.
            PUT UNFORMATTED NOW " Error interno.No se encuentra el evento padre " evento.nro_evento_padre  " para evento " evento.nro_evento SKIP.
            OUTPUT CLOSE.
            RETURN ERROR.
        END.    
    END.*/
    analizado.muestras=pmuestras * 1000 / analizado.hduracion.
    analizado.sumas = pacumula.
    FOR FIRST rvalor WHERE rvalor.nro_evento = analizado.nro_evento AND
        rvalor.valor <> 0 USE-INDEX idx2: 
        /*Los dias con valores mas alto con los que mas satisfacen la ubicacion, solo para estadistica de satisfaccion general*/
        ASSIGN 
            analizado.FMSatif  = rvalor.fecha
            analizado.maxsatif = rvalor.valor.
    END.
END.
