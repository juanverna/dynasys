DEFINE INPUT PARAM rr AS ROWID.

FIND BATCH WHERE ROWID(BATCH) = rr NO-LOCK.
FIND evento WHERE evento.nro_evento = INT(batch.parametro[1]) AND NOT evento.anulado AND evento.frealizado <> ? NO-WAIT NO-ERROR.
IF NOT AVAILABLE evento THEN 
    RETURN "W".
RELEASE evento.

RUN emailcertiffumi.p(INT(batch.parametro[1]), batch.parametro[2]).
RETURN "".

