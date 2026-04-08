/*desasignareventosnorealizados.p*/
{tiempo.i}
DEFINE VAR ff AS DATE.
OUTPUT TO c:\dynasys10\logs\desasignareventosnorealizados.LOG APPEND.
DISPLAY "Fecha corrida" NOW.
ff = resta_dia_habil(TODAY,2,"23456").
FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "RL" NO-LOCK NO-ERROR.
IF NOT AVAILABLE tipo_evento THEN DISPLAY "Tipo RL no registrado".
FOR EACH evento WHERE evento.nro_tipo_evento = tipo_evento.nro_tipo_evento AND evento.fasignado < ff AND
    evento.frealizado = ? AND NOT evento.anulado :
    FOR EACH recurso_agenda OF evento:
        DELETE recurso_agenda.
    END.
    evento.fasignado = ?.
END.
ff = resta_dia_habil(TODAY,50,"23456").
FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "EV" NO-LOCK NO-ERROR.
IF NOT AVAILABLE tipo_evento THEN DISPLAY "Tipo EV no registrado".
FOR EACH evento WHERE evento.nro_tipo_evento = tipo_evento.nro_tipo_evento AND evento.fasignado < ff AND
    evento.frealizado = ? AND NOT evento.anulado :
    FOR EACH recurso_agenda OF evento:
        DELETE recurso_agenda.
    END.
    DELETE evento.
END.
{advtexto.i}
    DEFINE BUFFER bevento FOR evento.
    FOR EACH evento WHERE nro_tipo_evento = 10 AND frealizado = ? AND NOT anulado AND evento.refevento <> 0:
        FIND bevento WHERE bevento.nro_evento = evento.refevento NO-ERROR.
        IF NOT AVAILABLE bevento OR bevento.anulado OR bevento.frealizado <> ? THEN DO:
            evento.anulado = TRUE.
            evento.observacion = agregaAdvTexto("Evento principal realizado/anulado " ,bevento.observacion).
            FOR EACH recurso_agenda OF evento:
                DELETE recurso_agenda.
            END.
        END.
END.
/*
ff = resta_dia_habil(TODAY,4,"23456").
FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "EC" NO-LOCK NO-ERROR.
IF NOT AVAILABLE tipo_evento THEN DISPLAY "Tipo EC no registrado".
FOR EACH evento WHERE evento.nro_tipo_evento = tipo_evento.nro_tipo_evento AND evento.fasignado < ff AND
    evento.frealizado = ? AND NOT evento.anulado :
    FOR EACH recurso_agenda OF evento:
        DELETE recurso_agenda.
    END.
    DELETE evento.
END.
*/
