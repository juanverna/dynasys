
/*asignarEC.p*/
DEFINE INPUT PARAMETER nro LIKE cliente.nro_cliente NO-UNDO.
/*{tiempo.i}
DEFINE VAR ff AS DATE.

DEFINE BUFFER bevento FOR evento.
DEFINE VAR nro_tipocobranza LIKE tipo_evento.nro_tipo_evento.
ff = resta_dia_habil(TODAY,2,"23456").
FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "CO" NO-LOCK NO-ERROR.
IF NOT AVAILABLE tipo_evento THEN do:
    DISPLAY "Tipo CO no registrado".
    RETURN ERROR.
END.
nro_tipocobranza = tipo_evento.nro_tipo_evento.

FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "EC" NO-LOCK NO-ERROR.
IF NOT AVAILABLE tipo_evento THEN do:
    DISPLAY "Tipo EC no registrado".
    RETURN ERROR.
END.

FOR EACH evento WHERE evento.nro_cliente = nro AND evento.nro_tipo_evento = tipo_evento.nro_tipo_evento AND 
    evento.frealizado = ? AND 
    evento.fasignado = ? AND
    NOT evento.anulado :
    
    FOR EACH bevento WHERE bevento.nro_cliente = evento.nro_cliente AND
        NOT bevento.anulado AND
        bevento.frealizado = ? AND 
        bevento.fasignado <> ? AND
        bevento.fasignado >= TODAY AND 
        bevento.nro_tipo_evento = nro_tipocobranza BY bevento.fasignado :
        ASSIGN evento.fasignado = bevento.fasignado
               evento.recurso = bevento.recurso
               evento.evsigue = bevento.nro_evento
               evento.durac = 1.
         FIND recurso_agenda OF evento NO-ERROR.
         IF NOT AVAILABLE recurso_agenda THEN DO:
            CREATE recurso_agenda.
            ASSIGN recurso_agenda.fecha = evento.fasignado
                recurso_agenda.cdg_recurso = evento.recurso
                recurso_agenda.nro_evento = evento.nro_evento.
         END.
         LEAVE.
    END.
END.
*/
