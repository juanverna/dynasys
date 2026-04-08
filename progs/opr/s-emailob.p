DEFINE INPUT PARAM rr AS ROWID.

FIND BATCH WHERE ROWID(BATCH) = rr NO-LOCK.
FIND evento WHERE evento.nro_evento = INT(batch.parametro[1]) AND NOT evento.anulado AND evento.frealizado <> ? NO-ERROR.

IF NOT AVAILABLE evento THEN 
    RETURN "W".
IF Evento.Envio_email THEN RETURN "".
RELEASE evento.
RUN qrcodemcba.p(INT(BATCH.parametro[1]), "").
RETURN "".

