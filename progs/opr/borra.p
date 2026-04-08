FOR EACH tarea WHERE tarea.origen = "COBRANZA":
DELETE tarea.
END.
FOR EACH evento WHERE evento.origen = "COBRANZa":
DELETE evento.
END.
DEFINE VAR i AS INT NO-UNDO.
    FOR EACH recurso_agenda: DELETE recurso_agenda.
    END.
    FOR EACH evento WHERE evento.fasignado<>? OR evento.bloqueado OR evento.frealizado<>?:
        DO i = 1 TO NUM-ENTRIES(evento.recursos):
                      CREATE recurso_agenda.
                      ASSIGN recurso_agenda.cdg_recurso = ENTRY(i,evento.recurso)
                             recurso_agenda.fecha = IF evento.frealizado = ? THEN evento.fasignado ELSE evento.frealizado
                             recurso_agenda.nro_evento = evento.nro_evento
                             recurso_agenda.observacion = evento.observacion.
        END.
END.
