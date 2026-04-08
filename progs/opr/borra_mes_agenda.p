    DEFINE BUFFER aviso FOR evento.
    FOR EACH evento WHERE periodo = 201704 AND nro_tipo_evento = 1:
    FOR EACH aviso WHERE aviso.refevento = evento.nro_evento:
        DELETE aviso.
    END.
    FOR EACH recurso_agenda OF evento:
        DELETE recurso_agenda.
    END.
    DELETE evento.
END.
