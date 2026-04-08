/*gen_tarea_cobranzasH.p*/
/*genera la tarea/evento si tiene deuda de un cliente teniendo en cuenta la fecha de coerte*/
{listaconf.i}
{findempresa.i}
{tiempo.i}
FUNCTION cdate RETURNS DATE ( mm AS INT , dd AS INT ,yy AS INT,vdef AS CHAR):
    DEFINE VAR ff AS DATE NO-UNDO.
    ff = DATE ( mm ,  dd , yy ) NO-ERROR.
    IF NOT ERROR-STATUS:ERROR THEN RETURN ff.
    ff = DATE ( mm , dd - 1, yy ) NO-ERROR.
    IF NOT ERROR-STATUS:ERROR THEN RETURN ff.
    ff = DATE ( mm ,  dd - 2, yy ) NO-ERROR. 
    IF NOT ERROR-STATUS:ERROR THEN RETURN ff.
    ff = DATE ( mm , dd - 3, yy ) NO-ERROR. 
    IF NOT ERROR-STATUS:ERROR THEN RETURN ff.
    ff = DATE ( mm , dd - 4, yy ) NO-ERROR. 
    IF NOT ERROR-STATUS:ERROR THEN RETURN ff.
    IF vdef = "PRI" THEN
        RETURN DATE( mm, 1, yy).
    ELSE
        RETURN ultimodia( DATE( mm , 1 , yy )).
END FUNCTION.
FUNCTION DOW RETURNS INT (dd AS DATE , fwd AS INT ):
    IF WEEKDAY(dd) < fwd THEN RETURN WEEKDAY(dd) + 8 - fwd .
    ELSE RETURN WEEKDAY(dd) - fwd + 1 .
END FUNCTION.
FUNCTION fechado RETURNS DATE ( tnMes AS INT, tnAnio AS INT , tnDiaSem AS INT , tnOrdinal AS INT ) :
    /*retorna una fecha data un dia de la semana y su ordinal en el mes*/
    DEFINE VARIABLE dd   AS DATE.
    DEFINE VAR      daju AS INT.
    RETURN DATE(  tnMes , 1 , tnAnio ) + tnOrdinal * 7 - dow( DATE(  tnMes , 1, tnAnio ) + tnOrdinal * 7 - 1 ,tnDiasem ).
END FUNCTION.

{advTexto.i}
DEFINE INPUT PARAMETER nro LIKE cliente.nro_cliente.
DEFINE INPUT PARAMETER p-info AS CHARACTER.
DEFINE INPUT PARAMETER hoy AS DATE NO-UNDO.
DEFINE BUFFER btipo_evento  FOR tipo_evento.
DEFINE BUFFER administrador FOR cliente.
DEFINE VAR frecursos            AS CHAR NO-UNDO.
DEFINE VAR k                    AS INT   NO-UNDO.
DEFINE VAR fmin                 AS DATE      NO-UNDO.
DEFINE VAR fmax                 AS DATE      NO-UNDO.
DEFINE VAR minmoroso AS DECIMAL INITIAL 10 NO-UNDO.

DEFINE VAR pdurac               AS INT   NO-UNDO.
DEFINE VAR horac                AS CHAR NO-UNDO.

DEFINE VAR ct                   AS LOGICAL   NO-UNDO.
DEFINE VAR ce                   AS LOGICAL   NO-UNDO.
DEFINE VAR dfldurac             AS INT   INITIAL 30 NO-UNDO.
DEF    VAR kk                   AS INT   NO-UNDO.
DEFINE VAR pvisualizar          AS INT   NO-UNDO.
DEFINE VAR confc_valor          AS CHAR NO-UNDO.
DEFINE VAR prest                AS CHAR NO-UNDO.
DEFINE VAR daux                 AS DATE      NO-UNDO.

DEFINE VAR fperiodo1            AS DATE      NO-UNDO.
DEFINE VAR fanal                AS DATE.
DEFINE VAR fbase                AS DATE      NO-UNDO.
DEFINE VAR meshoy               AS INT   NO-UNDO.
DEFINE VAR anohoy               AS INT   NO-UNDO.

DEFINE VAR fmoroso              AS DATE      NO-UNDO.
DEFINE VAR totdeuda             AS DECIMAL   NO-UNDO.
DEFINE VAR totmoroso            AS DECIMAL   NO-UNDO.
DEFINE VAR pevsigue             LIKE evento.nro_evento NO-UNDO.
DEFINE VAR pmobs                LIKE evento.mobs NO-UNDO.
DEFINE VAR pperiodo             AS INT   NO-UNDO.
DEFINE VAR p-precorte           AS DATE      NO-UNDO.
DEFINE VAR fpremoroso           AS DATE      NO-UNDO.
DEFINE VAR p-corte              AS DATE      NO-UNDO.
DEFINE VAR tipo_evento_cobranza LIKE tipo_evento.nro_tipo_evento NO-UNDO.
DEFINE BUFFER bevento FOR evento.

DEFINE VAR i     AS INT   NO-UNDO.
DEFINE VAR soloh AS CHAR NO-UNDO.
DEFINE VAR solog AS INT   NO-UNDO.
DEFINE TEMP-TABLE tt NO-UNDO
    FIELD cdg_recurso LIKE recurso.cdg_recurso
    FIELD nom_recurso LIKE Recurso.nom_recurso
    FIELD grado       AS INT
    INDEX grado grado.
FOR EACH Recurso BY Recurso.interno DESCENDING :
    soloh = "".
    solog = 0.
    DO i = 1 TO NUM-ENTRIES(recurso.habilidades):
        soloh = ENTRY(1,ENTRY(i,recurso.habilidades),"@").
        solog = int(ENTRY(2,ENTRY(i,recurso.habilidades),"@")) NO-ERROR.
        IF NOT CAN-DO(soloh, "C" ) THEN NEXT.
        CREATE tt.
        ASSIGN 
            tt.cdg_recurso = recurso.cdg_recurso
            tt.nom_recurso = Recurso.nom_recurso.
        tt.grado = solog.
    END.
END.


fperiodo1 = ultimodia(sumarmeses(hoy,2)).
meshoy = MONTH(hoy).
anohoy = YEAR(hoy).
pperiodo = anohoy * 100 + meshoy.
p-precorte = DATE(meshoy,1,anohoy) - 1.
p-precorte = DATE(MONTH(p-precorte),1,YEAR(p-precorte)).
fpremoroso = DATE(MONTH(p-precorte - 1 ),1,YEAR(p-precorte - 1)).
FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "CO" NO-LOCK.
tipo_evento_cobranza = tipo_evento.nro_tipo_evento.

fanal = resta_dia_habil(hoy,2,"23456").
FIND administrador NO-LOCK WHERE administrador.nro_cliente = nro NO-ERROR.
IF NOT AVAILABLE administrador THEN RETURN.

FIND restriccion NO-LOCK WHERE restriccion.cdg_restriccion = "CORTE"  NO-ERROR.
FIND cliente_restriccion NO-LOCK OF administrador WHERE cliente_restriccion.nro_restriccion = restriccion.nro_restriccion  NO-ERROR.
IF NOT AVAILABLE cliente_restriccion THEN p-corte = p-precorte + 9.
ELSE 
DO:
    p-corte = p-precorte + INT(cliente_restriccion.valor) - 1 NO-ERROR.
    IF ERROR-STATUS:ERROR THEN p-corte = p-precorte + INT(cliente_restriccion.valor) - 2 NO-ERROR.
    IF ERROR-STATUS:ERROR THEN p-corte = p-precorte + INT(cliente_restriccion.valor) - 3 NO-ERROR.
    IF ERROR-STATUS:ERROR THEN p-corte = p-precorte + INT(cliente_restriccion.valor) - 4 NO-ERROR.
END.
REPEAT:
    IF es_habil(p-corte,"23456") THEN LEAVE.
    p-corte = p-corte + 1.
END.
/*p-corte esta ok*/
FIND cliente_restriccion OF administrador WHERE cliente_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
IF NOT AVAILABLE cliente_restriccion THEN fmoroso = fpremoroso + 9.
ELSE 
DO:
    fmoroso = fpremoroso + INT(cliente_restriccion.valor) - 1 NO-ERROR.
    IF ERROR-STATUS:ERROR THEN fmoroso = fpremoroso + INT(cliente_restriccion.valor) - 2 NO-ERROR.
    IF ERROR-STATUS:ERROR THEN fmoroso = fpremoroso + INT(cliente_restriccion.valor) - 3 NO-ERROR.
    IF ERROR-STATUS:ERROR THEN fmoroso = fpremoroso + INT(cliente_restriccion.valor) - 4 NO-ERROR.
END.
REPEAT:
    IF es_habil(fmoroso,"23456") THEN LEAVE.
    fmoroso = fmoroso + 1.
END.

totdeuda = 0.0.
totmoroso = 0.0.
/*esto esta mal porque no tiene en cuenta la fecha de vencimiento de las facturas*/
RUN deuda_administracion-corte.p ( nro, p-corte , OUTPUT totdeuda ).
RUN deuda_administracion-corte.p ( nro, fmoroso , OUTPUT totmoroso ).

IF totdeuda > 0 THEN 
DO:
    FIND FIRST evento WHERE evento.nro_tipo_evento = tipo_evento_cobranza AND 
        evento.nro_cliente = administrador.nro_cliente AND
        evento.fasignado < fanal AND evento.frealizado <> ? AND
        evento.periodo = pperiodo AND NOT anulado NO-LOCK NO-ERROR.
        IF AVAILABLE evento THEN return.
    /*hay eventos abiertos*/
    FOR EACH evento WHERE evento.nro_tipo_evento = tipo_evento_cobranza AND 
        evento.nro_cliente = administrador.nro_cliente AND
        evento.fasignado < fanal AND evento.frealizado = ? AND
        NOT anulado:
        FOR EACH recurso_agenda OF evento: 
            DELETE recurso_agenda. 
        END.
        /*se adiciona una observacion por no cumplimiento*/   
        evento.observacion = agregaAdvTexto("No se cobro en la fecha prevista[" + STRING(evento.recursos) + " " + STRING(evento.fasignado) + "]" , evento.observacion ).
        evento.fasignado = ?.
        evento.recursos = "".
        evento.anulado = TRUE.
    END.
    /*    FOR EACH evento WHERE evento.nro_tipo_evento = tipo_evento_cobranza AND 
            evento.nro_cliente = administrador.nro_cliente AND
            evento.fmax < fanal AND evento.frealizado = ? AND
            NOT anulado:
            FOR EACH recurso_agenda OF evento: 
                DELETE recurso_agenda. 
            END.
            /*se adiciona una observacion por no cumplimiento*/   
            evento.observacion = agregaAdvTexto("No se cobro en la fecha prevista[" + string(evento.recursos) + " " + string(evento.fasignado) + "]" , evento.observacion ).
            evento.fasignado = ?.
            evento.recursos = "".
            evento.anulado = TRUE.
        END.*/
    FOR EACH evento WHERE evento.nro_tipo_evento = tipo_evento_cobranza AND 
        evento.nro_cliente = administrador.nro_cliente AND
        evento.fasignado = ? AND evento.frealizado = ? AND
        NOT anulado AND evento.periodo <> pperiodo :
        evento.periodo = pperiodo.
        evento.fmin = DATE(meshoy,1,anohoy).
        evento.fmax = ultimodia(evento.fmin).
    END.
    RELEASE evento.
END.
ELSE 
DO: /*borrar evento y tareas que no tiene mas sentido no hay deuda*/
    FOR EACH tarea WHERE tarea.nro_cliente = administrador.nro_cliente AND
        tarea.cdg_tipotarea="C" AND tarea.estado = "A":
        tarea.estado = "D".
        tarea.descripcion = agregaAdvTexto("Se Anula deuda cancelada",tarea.descripcion ).
    END.
    sale:
    FOR EACH evento WHERE evento.nro_tipo_evento = tipo_evento_cobranza AND 
        evento.nro_cliente = administrador.nro_cliente AND evento.evsigue <> 0 AND  
        evento.frealizado = ? AND NOT anulado:
        /*ver si no es coper*/
        prest="COPER".
        FIND restriccion WHERE restriccion.nro_tipo_evento = tipo_evento_cobranza AND restriccion.cdg_restriccion = prest NO-LOCK NO-ERROR.
        IF NOT AVAILABLE restriccion THEN 
        DO:
            DISPLAY "No se encuentra restriccion " + prest.
        END.
        FIND cliente_restriccion NO-LOCK OF administrador 
            WHERE cliente_restriccion.nro_restriccion = restriccion.nro_restriccion NO-ERROR.
        IF AVAILABLE cliente_restriccion THEN 
            IF cliente_restriccion.valor = "S" THEN NEXT sale.
        FOR EACH recurso_agenda OF evento: 
            DELETE recurso_agenda. 
        END.
        DELETE evento.
        RELEASE cliente_restriccion.
    END.
    prest="COPER".
    FIND restriccion WHERE restriccion.nro_tipo_evento = tipo_evento_cobranza AND restriccion.cdg_restriccion = prest NO-LOCK NO-ERROR.
    IF NOT AVAILABLE restriccion THEN 
    DO:
        DISPLAY "No se encuentra restriccion " + prest.
        RETURN.
    END.
    FIND cliente_restriccion NO-LOCK OF administrador 
        WHERE cliente_restriccion.nro_restriccion = restriccion.nro_restriccion NO-ERROR.
    IF AVAILABLE cliente_restriccion THEN 
    DO:
        IF cliente_restriccion.valor <> "S" THEN RETURN.
    END.
    ELSE RETURN.
END.
/*terminada la limpieza verificar si ya esta creado el evento porque va en ambos casos*/
FIND FIRST evento NO-LOCK WHERE evento.nro_tipo_evento = tipo_evento_cobranza AND 
    evento.nro_cliente = administrador.nro_cliente AND 
    ( evento.fasignado = ? OR ( evento.fasignado >= fanal AND evento.fasignado <= fperiodo1 )) AND NOT anulado AND
    evento.frealizado = ? NO-ERROR.
IF AVAILABLE evento THEN RETURN.

FIND FIRST domicilio OF administrador NO-LOCK.
FIND first Cliente-contacto OF Domicilio WHERE can-do(Cliente-contacto.canal-email,"COB")  NO-LOCK NO-ERROR.
IF AVAILABLE cliente-contacto THEN 
DO:
    FIND Persona OF Cliente-contacto NO-LOCK NO-ERROR.
END.
ELSE 
DO:
    FIND FIRST cliente-contacto OF domicilio NO-LOCK NO-ERROR.
    IF AVAILABLE cliente-contacto THEN 
    DO:
        FIND Persona OF Cliente-contacto NO-LOCK NO-ERROR.
    END.
END.
/*busca la ultima rendicion para obterel ultimo cobrador en caso necesario*/
FOR EACH rendicion_hd NO-LOCK WHERE rendicion_hd.nro_administrador = administrador.nro_cliente AND Rendicion_hd.st_tesoreria <> "A", evento OF rendicion_hd WHERE nro_evento <> 0 AND evento.frealizado <> ? AND NOT evento.anulado BY rendicion_hd.fch_rendicion DESC:
    LEAVE.
END.
IF AVAILABLE evento THEN
    frecursos = evento.recursos.
ct = FALSE.
ce = FALSE.
pvisualizar=0.
confc_valor="".
pdurac = dfldurac.
fmin = ?.
fmax = ?.
pevsigue = 0.
/*el caso del COPER el administrador tiene coper pero los eventos son EVSIGUE a cada evento que genero la deuda y uno por cada evento*/
prest="COPER".
FIND restriccion WHERE restriccion.nro_tipo_evento = tipo_evento_cobranza AND restriccion.cdg_restriccion = prest NO-LOCK NO-ERROR.
IF NOT AVAILABLE restriccion THEN 
DO:
    DISPLAY "No se encuentra restriccion " + prest.
END.
FIND cliente_restriccion NO-LOCK OF administrador 
    WHERE cliente_restriccion.nro_restriccion = restriccion.nro_restriccion NO-ERROR.
IF AVAILABLE cliente_restriccion THEN 
DO:
    IF cliente_restriccion.valor="S" THEN 
    DO:
        FOR EACH evento WHERE evento.nro_cliente = administrador.nro_cliente AND
            evento.frealizado = ? AND
            evento.fasignado <> ? AND
            NOT evento.anulado NO-LOCK BY evento.fasignado :
            IF evento.fasignado < hoy THEN NEXT.
            FIND btipo_evento OF evento NO-LOCK.
            IF NOT bTipo_evento.factura THEN NEXT.
            FIND FIRST bevento WHERE bevento.nro_tipo_evento = tipo_evento_cobranza AND evento.evsigue = evento.nro_evento AND
                NOT bevento.anulado AND bevento.frealizado = ? AND
                bevento.nro_cliente = administrador.nro_cliente NO-LOCK NO-ERROR.
            IF AVAILABLE bevento THEN NEXT.

            CREATE bevento.
            ASSIGN 
                bevento.nro_evento         = NEXT-VALUE(proximo_evento)
                bevento.nro_tipo_evento    = tipo_evento_cobranza
                bevento.nro_identificacion = 0 /*tiene 0 porque es directa, no proviene de la tarea*/
                bevento.origen             = "COBRANZA"
                bevento.nro_cliente        = administrador.nro_cliente
                bEvento.FCreado            = TODAY
                bevento.periodo            = evento.periodo
                bevento.fmin               = evento.fmin
                bevento.fmax               = evento.fmax
                bevento.duracion           = evento.duracion
                bevento.evsigue            = evento.nro_evento
                pevsigue                   = evento.nro_evento
                bevento.fasignado          = evento.fasignado.
            bevento.mobs = "COPER".
            bevento.recurso = ENTRY(1,evento.recurso).
            bevento.turno = evento.turno.
            bevento.hora_desde = evento.hora_desde.
            bevento.hora_hasta = evento.hora_hasta.
            bevento.observacion = agregaAdvTexto("CREADO COPER", bevento.observacion ).
            IF bevento.fasignado <> ? THEN 
            DO:
                FIND recurso_agenda OF bevento NO-LOCK NO-ERROR.
                IF NOT AVAILABLE recurso_agenda THEN 
                DO:
                    CREATE recurso_agenda.
                    ASSIGN 
                        recurso_agenda.cdg_recurso = bevento.recurso
                        recurso_agenda.fecha       = IF bevento.frealizado = ? THEN bevento.fasignado ELSE bevento.frealizado
                        recurso_agenda.nro_evento  = bevento.nro_evento
                        recurso_agenda.observacion = bevento.observacion.
                END.
            END.
        END.
        pevsigue = 0.
        totdeuda = 0. /*para salida del ciclo.*/
    END.
END.
IF pevsigue = 0 AND totdeuda <= 0 THEN RETURN.
IF pevsigue = 0 THEN 
DO:  /*si pevesigue <> 0 hay coper valido nada mas que analizar.*/
    prest="DURACC".
    FIND restriccion WHERE restriccion.nro_tipo_evento = tipo_evento_cobranza AND restriccion.cdg_restriccion = prest NO-LOCK NO-ERROR.
    IF NOT AVAILABLE restriccion THEN 
    DO:
        DISPLAY "No se encuentra restriccion " + prest .
    END.
    FIND cliente_restriccion OF administrador 
        WHERE cliente_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
    IF AVAILABLE cliente_restriccion THEN 
        pdurac = INT(cliente_restriccion.valor) NO-ERROR.
    IF ERROR-STATUS:ERROR THEN pdurac = dfldurac.
    /*si tiene una fecha valida se procesa esta vez como fechai es evento fijo*/
    prest="FECHAI".
    FIND restriccion WHERE restriccion.nro_tipo_evento = tipo_evento_cobranza AND restriccion.cdg_restriccion = prest NO-LOCK NO-ERROR.
    IF NOT AVAILABLE restriccion THEN 
    DO:
        DISPLAY "No se encuentra restriccion " + prest .
    END.
    FOR EACH cliente_restriccion OF restriccion WHERE DATE(cliente_restriccion.valor) < hoy :
        DELETE cliente_restriccion.
    END.
    FIND cliente_restriccion OF administrador 
        WHERE cliente_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
    IF AVAILABLE cliente_restriccion THEN 
    DO:
        daux = DATE(cliente_restriccion.valor) NO-ERROR.
        IF daux <> ? THEN 
        DO:
            IF daux >= hoy THEN 
            DO:
                fmin = daux.
                fmax = daux.
                ce = TRUE.
            END.
        END.
    END.
    ELSE 
    DO:
        prest="CONFC".
        FIND restriccion WHERE restriccion.nro_tipo_evento = tipo_evento_cobranza AND restriccion.cdg_restriccion = prest NO-LOCK NO-ERROR.
        IF NOT AVAILABLE restriccion THEN 
        DO:
            DISPLAY "No se encuentra restriccion " + prest .
        END.
        FIND cliente_restriccion OF administrador 
            WHERE cliente_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
        IF AVAILABLE cliente_restriccion THEN 
        DO: 
            ct = TRUE.
            confc_valor = cliente_restriccion.valor.
            IF NUM-ENTRIES(cliente_restriccion.valor,"|") >= 2 THEN DO:
                pvisualizar = INT(ENTRY(2,cliente_restriccion.valor,"|")).
                IF pvisualizar = 0 THEN pvisualizar=1.
            END.
        END.
        prest="CONFCD".
        FIND restriccion WHERE restriccion.nro_tipo_evento = tipo_evento_cobranza AND restriccion.cdg_restriccion = prest NO-LOCK NO-ERROR.
        IF NOT AVAILABLE restriccion THEN 
        DO:
            DISPLAY "No se encuentra restriccion " + prest .
        END.
        FIND cliente_restriccion OF administrador 
            WHERE cliente_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
        IF AVAILABLE cliente_restriccion THEN 
        DO: 
            ct = TRUE.
        /*      confc_valor = cliente_restriccion.valor.
              IF NUM-ENTRIES(cliente_restriccion.valor,"|") >= 2 THEN DO:
                     /*Corresponde crear la tarea*/
/*no esta implementado*/
                     pvisualizar = INT(ENTRY(2,cliente_restriccion.valor,"|")). 
    
              END.*/
        END.
        prest="RDiasSem".
        FIND restriccion WHERE restriccion.nro_tipo_evento = tipo_evento_cobranza AND restriccion.cdg_restriccion = prest NO-LOCK NO-ERROR.
        IF NOT AVAILABLE restriccion THEN 
        DO:
            DISPLAY "No se encuentra restriccion " + prest .
        END.
        FIND cliente_restriccion OF administrador 
            WHERE cliente_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
        IF AVAILABLE cliente_restriccion THEN 
        DO:
            ce = TRUE.
            daux = fechado( meshoy , anohoy , int(SUBSTRING( ENTRY( 3 , cliente_restriccion.valor , "|" ), LENGTH( ENTRY( 3 , cliente_restriccion.valor , "|" )) , 1 )),int( SUBSTRING( ENTRY( 2 , cliente_restriccion.valor , "|" ),LENGTH( ENTRY( 2 , cliente_restriccion.valor ,"|" )) , 1 ))).
            fmax = IF daux < cdate(meshoy, INT(ENTRY( 6 , cliente_restriccion.valor , "|" )), anohoy,"ULT") THEN daux ELSE cdate(meshoy, INT(ENTRY( 6 , cliente_restriccion.valor , "|" )), anohoy,"ULT").
            daux = fechado( meshoy , anohoy , int(SUBSTRING( ENTRY( 3 , cliente_restriccion.valor , "|" ), 1 , 1 )),int( SUBSTRING( ENTRY( 2 , cliente_restriccion.valor , "|" ), 1 ))).
            fmin = IF daux < cdate(meshoy, INT(ENTRY( 5 , cliente_restriccion.valor , "|" )), anohoy,"PRI") THEN daux ELSE cdate(meshoy, INT(ENTRY( 5 , cliente_restriccion.valor , "|" )), anohoy,"PRI").
            IF fmax < hoy OR fmax = ? OR fmin = ? THEN 
            DO:
                ct = TRUE.
                ce = FALSE.
            END.
        END.
        prest="DFIJOC".
        FIND restriccion WHERE restriccion.nro_tipo_evento = tipo_evento_cobranza AND restriccion.cdg_restriccion = prest NO-LOCK NO-ERROR.
        IF NOT AVAILABLE restriccion THEN 
        DO:
            DISPLAY "No se encuentra restriccion " + prest .
        END.
        FIND cliente_restriccion OF administrador 
            WHERE cliente_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
        IF AVAILABLE cliente_restriccion THEN 
        DO:
            ce = TRUE.
            fmin = cDATE ( meshoy , int(ENTRY( 1 , cliente_restriccion.valor , "|" )) , anohoy,? ).
            fmax = fmin.
            IF fmax < hoy OR fmin = ? THEN 
            DO:
                ct = TRUE.
                ce = FALSE.
            END.
        END. 
        prest="RANGOC".
        FIND restriccion WHERE restriccion.nro_tipo_evento = tipo_evento_cobranza AND restriccion.cdg_restriccion = prest NO-LOCK NO-ERROR.
        IF NOT AVAILABLE restriccion THEN 
        DO:
            DISPLAY "No se encuentra restriccion " + prest .
        END.
        FIND cliente_restriccion OF administrador 
            WHERE cliente_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
        IF AVAILABLE cliente_restriccion THEN 
        DO:
            ce = TRUE.
            fmin = cDATE ( meshoy , int(ENTRY( 1 , cliente_restriccion.valor , "|" )) , anohoy ,"PRI").
            fmax = cDATE ( meshoy , int(ENTRY( 2 , cliente_restriccion.valor , "|" )) , anohoy,"ULT" ).
            IF fmax < hoy OR fmin = ? OR fmax = ? THEN 
            DO:
                ct = TRUE.
                ce = FALSE.
            END.
        END.
        prest="CRONO".
        FIND restriccion WHERE restriccion.nro_tipo_evento = tipo_evento_cobranza AND restriccion.cdg_restriccion = prest NO-LOCK NO-ERROR.
        IF NOT AVAILABLE restriccion THEN 
        DO:
            DISPLAY "No se encuentra restriccion " + prest .
        END.
            
        FIND cliente_restriccion OF administrador 
            WHERE cliente_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
        IF AVAILABLE cliente_restriccion THEN 
        DO:
            ce = TRUE.
            fmin = cDATE ( meshoy , int(ENTRY(1,ENTRY( meshoy , cliente_restriccion.valor , "|" ))) , anohoy ,"PRI").
            IF NUM-ENTRIES(ENTRY( meshoy , cliente_restriccion.valor , "|" ),",") > 1 THEN
                fmax = cDATE ( meshoy , int(ENTRY(2,ENTRY( meshoy , cliente_restriccion.valor , "|" ))) , anohoy,"ULT" ).
            ELSE fmax = fmin.
            IF fmax < hoy OR fmin = ? OR fmax = ? THEN 
            DO:
                ct = TRUE.
                ce = FALSE.
            END.
        END.
        prest="HORAC".
        FIND restriccion WHERE restriccion.nro_tipo_evento = tipo_evento_cobranza AND restriccion.cdg_restriccion = prest NO-LOCK NO-ERROR.
        IF NOT AVAILABLE restriccion THEN 
        DO:
            DISPLAY "No se encuentra restriccion " + prest .
        END.
        FIND restriccion WHERE restriccion.nro_tipo_evento = tipo_evento_cobranza AND restriccion.cdg_restriccion = "HORAC" NO-LOCK.
        FIND cliente_restriccion OF administrador 
            WHERE cliente_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
        IF AVAILABLE cliente_restriccion THEN DO:
            horac = ENTRY(1,cliente_restriccion.valor,";").
            /*horac = ENTRY(1,horaccliente_restriccion.valor,1,4) + ":" +
                SUBSTRING(cliente_restriccion.valor,LENGTH(cliente_restriccion.valor) - 3,4).*/
        END.
        ELSE horac = "0900:1230".
        IF pvisualizar = 0 THEN
            pvisualizar = 10. /*dia diez cableado*/    
        IF pvisualizar < DAY(hoy) THEN 
            pvisualizar = DAY(hoy).
        IF fmin = ?  THEN 
        DO:
            /*que hacemos cuando no tiene fecha fija*/
            fmin = cDATE(meshoy,pvisualizar,anohoy,?).
        END.
        IF fmax < hoy OR fmax = ? THEN 
        DO:
            fmin = DATE(meshoy,pvisualizar,anohoy).
            fmax = ultimodia(hoy).
        END.
        IF fmax < fmin THEN fmax = fmin.
        IF fmax < hoy OR fmin = ? OR fmax = ? THEN 
        DO:
            ct = TRUE.
            ce = FALSE.
        END.
    END.
    /*si se le cobro este mes y quedo con deuda genero tarea*/
    IF AVAILABLE rendicion_hd THEN 
    DO:
        IF YEAR(rendicion_hd.fch_rendicion) * 100 + MONTH(rendicion_hd.fch_rendicion) = pperiodo THEN ct = TRUE.
    END.

    IF totmoroso > minmoroso THEN do: /*si tiene deuda moroso ignora las restricciones y le genera una tarea*/
        ce = FALSE.
        ct = TRUE.
    END.

END.
/*vemos si mantenemos la tarea por unos dias mas o creamos el evento*/
IF ce THEN 
DO:
    IF hoy + 7 < fmin AND totmoroso > minmoroso THEN 
    DO:
        ce = FALSE.
        FIND FIRST tarea WHERE tarea.nro_cliente = administrador.nro_cliente AND
            tarea.cdg_tipotarea="C" AND  tarea.estado = "A" AND 
            date(Tarea.Visualizar) <= hoy NO-ERROR.
        IF AVAILABLE tarea THEN
            ct = FALSE.
    END.
END.
IF NOT ce THEN 
DO:
    /*crea una tarea si no existe ni tarea ni evento y si hay deuda*/
    FIND FIRST tarea WHERE tarea.nro_cliente = administrador.nro_cliente AND
        tarea.cdg_tipotarea="C" AND  tarea.estado = "A" NO-ERROR. 
    IF AVAILABLE tarea THEN 
    DO:
        IF horac = "" THEN horac = "0900:1400".
        ASSIGN 
            Tarea.datos-template = "fmin|" + STRING(fmin) + "|"  +
                                       "fmax|" + STRING(fmax) + "|" +
                                       "frecurso|" + frecursos + "|" + 
                                       "hora_fin|" + ENTRY(2,horac,":") + "|" +
                                       "CP|" + entry(1,confc_valor,"|").
        /*Tarea.visualizar = IF totmoroso > minmoroso THEN hoy ELSE DATE(MONTH(fmin),pvisualizar,YEAR(fmin)).*/
        tarea.turnogestion = aturno(administrador.horario_de_atencion).
        RETURN.
    END.
    FIND FIRST evento WHERE evento.nro_tipo_evento = tipo_evento_cobranza AND 
        evento.nro_cliente = administrador.nro_cliente AND frealizado = ? AND
        ( fasignado = ? OR ( evento.fasignado >= hoy AND evento.fasignado <= fperiodo1 )) AND NOT anulado NO-ERROR.
    IF AVAILABLE evento THEN RETURN.

    CREATE tarea.
    ASSIGN
        Tarea.nro_identificacion = 0
        tarea.origen             = "COBRANZA"
        Tarea.cdg_tipotarea      = "C" 
        Tarea.comunicarsepor     = SUBSTRING(confc_valor,1,1).
    IF p-info <> "" THEN tarea.descripcion = STRING(NOW) + "|" + usuario.cdg_usuario + "|" + p-info.  
    IF administrador.observacion <> "" THEN 
        tarea.descripcion = agregaAdvTexto(administrador.observacion,tarea.descripcion ).
    IF totmoroso > minmoroso THEN 
        tarea.descripcion = agregaAdvTexto("Creada por MOROSO:" + STRING(totmoroso),tarea.descripcion ).
    ASSIGN
        Tarea.direccion       = administrador.direccion 
        Tarea.estado          = "A" 
        Tarea.fecha_alta      = TODAY
        Tarea.hora_alta       = STRING(TIME,"HH:MM") 
        Tarea.fecha_reportado = hoy 
        Tarea.fecha_resuelto  = ? 
        Tarea.geolat          = administrador.geolat
        Tarea.geolong         = administrador.geolong
        Tarea.geoX            = administrador.geoX
        Tarea.geoY            = administrador.geoY
        Tarea.localidad       = administrador.localidad
        Tarea.nom_cliente     = administrador.nom_cliente
        Tarea.nro_cliente     = administrador.nro_cliente
        Tarea.nro_tarea       = NEXT-VALUE(proxima_tarea)
        tarea.nro_persona     = IF AVAILABLE persona THEN persona.nro_persona ELSE ?
        Tarea.telefonos       = IF AVAILABLE persona THEN ( IF Persona.numeros_telefono <> "" THEN Persona.numeros_telefono ELSE administrador.telefono ) ELSE administrador.telefono
        tarea.email           = IF AVAILABLE persona THEN persona.email ELSE ""
        tarea.nro_admini      = administrador.nro_administrador
        Tarea.cdg_proyecto    = "G"
        tarea.nro_tipo_evento = tipo_evento_cobranza
        Tarea.titulo          = Tarea.descripcion
        tarea.visualizar      = NOW.
    IF pvisualizar = 0  THEN pvisualizar = 1.
    Tarea.fecha_prevista = ?.
    Tarea.hora_prevista = ENTRY(1,horac,":").
    Tarea.visualizar = IF totmoroso > minmoroso THEN hoy ELSE DATE(MONTH(fmin),pvisualizar,YEAR(fmin)).
    REPEAT:
        IF NOT es_habil(DATE(tarea.visualizar),"23456") THEN
            tarea.visualizar = ADD-INTERVAL(tarea.visualizar,-1,"days").
        ELSE LEAVE.
    END.
    tarea.turnogestion = aturno(administrador.horario_de_atencion).
    FOR EACH tt BY tt.grado:
        tarea.cdg_recurso = tt.cdg_recurso.
        LEAVE.
    END.
    /*completando la info especifica de esta cobranza*/

    tarea.horas_estimadas = 30.
    IF horac = "" THEN horac = "900:1230".
    Tarea.datos-template = "fmin|" + STRING(fmin) + "|"  +
        "fmax|" + STRING(fmax) + "|" +
        "frecurso|" + frecursos + "|" + 
        "hora_fin|" + ENTRY(2,horac,":") + "|" +
        "CP|" + entry(1,confc_valor,"|").
END.
ELSE 
DO:
    /*CREAR EL EVENTO SEGUN RESTRICCIONES*/
    FIND FIRST evento WHERE evento.nro_tipo_evento = tipo_evento_cobranza AND 
        evento.nro_cliente = administrador.nro_cliente AND evento.frealizado = ? AND
        ( fasignado = ? OR ( evento.fasignado >= hoy AND evento.fasignado <= fperiodo1 )) AND NOT anulado NO-ERROR.
    IF AVAILABLE evento THEN RETURN.
    /*eliminar todas las tareas abiertas que no tiene sentido*/
    FOR EACH tarea WHERE tarea.nro_cliente = administrador.nro_cliente AND
        tarea.cdg_tipotarea="C" AND tarea.estado = "A" : 
        tarea.estado = "D".
        tarea.descripcion = agregaAdvTexto("Se Cancela tarea para crear evento",tarea.descripcion ).
    END.
    
    CREATE evento.
    ASSIGN 
        evento.nro_evento         = NEXT-VALUE(proximo_evento)
        evento.nro_tipo_evento    = tipo_evento_cobranza
        evento.nro_identificacion = 0 /*tiene 0 porque es directa, no proviene de la tarea*/
        evento.origen             = "COBRANZA"
        evento.nro_cliente        = administrador.nro_cliente
        Evento.FCreado            = TODAY
        evento.periodo            = pperiodo
        evento.fmin               = fmin
        evento.fmax               = fmax
        evento.duracion           = pdurac
        evento.evsigue            = pevsigue
        evento.fasignado          = IF fmin = fmax AND frecursos <> "" THEN fmin ELSE ?
        evento.mobs               = pmobs
        evento.recurso            = frecursos.
    IF p-info <> "" THEN evento.observacion = STRING(NOW) + "|" + usuario.cdg_usuario + "|" + p-info.  
    IF administrador.observacion <> "" THEN
        evento.observacion =  STRING(NOW) + "|" + usuario.cdg_usuario + "|" + administrador.observacion.
    evento.turno = "**".
    IF horac <> "" THEN 
    DO:
        evento.hora_desde = ajuh(ENTRY(1,horac,":")).
        evento.hora_hasta = ajuh(ENTRY(2,horac,":")).
        /*procesando las horas para convertirlas a turnos*/
        evento.turno = IF int(aint(evento.hora_desde)) < 1230 THEN "M*" ELSE "T*".
        IF INT(aint(evento.hora_hasta)) > 1230 THEN 
            evento.turno = IF evento.turno BEGINS "M" THEN "**" ELSE evento.turno.
    END.
    IF evento.fasignado <> ? THEN 
    DO:
        FIND recurso_agenda OF evento NO-LOCK NO-ERROR.
        IF NOT AVAILABLE recurso_agenda THEN 
        DO:
            CREATE recurso_agenda.
            ASSIGN 
                recurso_agenda.cdg_recurso = evento.recurso
                recurso_agenda.fecha       = IF evento.frealizado = ? THEN evento.fasignado ELSE evento.frealizado
                recurso_agenda.nro_evento  = evento.nro_evento
                recurso_agenda.observacion = evento.observacion.
        END.
    END.
END.




