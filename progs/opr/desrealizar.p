DEF VAR i AS INT NO-undo.
FIND evento 12345678.
    evento.frealizado = ?. /* mm/dd/aaaa o _ para desrealizar */
FOR EACH recurso_agenda OF evento : DELETE recurso_agenda. END.
        DO i = 1 TO NUM-ENTRIES(evento.recursos):
                      CREATE recurso_agenda.
                      ASSIGN recurso_agenda.cdg_recurso = ENTRY(i,evento.recurso)
                             recurso_agenda.fecha = IF evento.frealizado = ? THEN 
                                     evento.fasignado ELSE evento.frealizado
                             recurso_agenda.nro_evento = evento.nro_evento
                             recurso_agenda.observacion = evento.observacion.
        END.
