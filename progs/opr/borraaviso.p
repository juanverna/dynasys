    {advtexto.i}
    DEFINE BUFFER bevento FOR evento.
    FOR EACH evento WHERE nro_tipo_evento = 10 AND frealizado <> ? AND NOT anulado AND evento.refevento <> 0:
        FIND bevento WHERE bevento.nro_evento = evento.refevento NO-ERROR.
            
        IF NOT AVAILABLE bevento OR bevento.anulado OR bevento.frealizado <> ? THEN DO:
            evento.anulado = TRUE.
            evento.observacion = agregaAdvTexto("Evento principal realizado/anulado " ,bevento.observacion).
            FOR EACH recurso_agenda OF evento:
                DELETE recurso_agenda.
            END.
        END.
END.
