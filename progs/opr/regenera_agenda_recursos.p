DEFINE VAR i AS INT NO-UNDO.
FOR EACH recurso_agenda:
    FIND evento OF recurso_agenda NO-ERROR.
    IF NOT AVAILABLE evento THEN DELETE recurso_agenda.
END.
    FOR EACH evento WHERE evento.fasignado<>? OR evento.bloqueado OR evento.frealizado<>?:
        FOR EACH recurso_agenda OF evento : DELETE recurso_agenda. END.
        DO i = 1 TO NUM-ENTRIES(evento.recursos) ON error UNDO,NEXT:
                      CREATE recurso_agenda.
                      ASSIGN recurso_agenda.cdg_recurso = ENTRY(i,evento.recurso)
                             recurso_agenda.fecha = IF evento.frealizado = ? THEN 
                                     evento.fasignado ELSE evento.frealizado
                             recurso_agenda.nro_evento = evento.nro_evento
                             recurso_agenda.observacion = evento.observacion NO-ERROR.
        END.
    END.


