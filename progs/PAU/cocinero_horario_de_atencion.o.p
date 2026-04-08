DEFINE BUFFER bcliente FOR cliente.
FOR EACH cliente NO-LOCK, FIRST tarea OF cliente WHERE tarea.estado = "A" NO-LOCK:
 DEFINE VAR k AS INT NO-UNDO.
DEFINE VAR a AS INT NO-UNDO.
IF LENGTH(cliente.horario_de_atencion) > 0 THEN DO:
    DO k = 1 TO NUM-ENTRIES(cliente.horario_de_atencion,";"):
        a = INT(ENTRY(1,ENTRY(k,cliente.horario_de_atencion ,";"),":")) NO-ERROR .
        IF ERROR-STATUS:ERROR OR NUM-ENTRIES(ENTRY(k,cliente.horario_de_atencion,";"),":") < 2 THEN DO:
                 FIND  bcliente WHERE rowid(cliente) = rowid(bcliente) EXCLUSIVE-LOCK.
                 DISPLAY cliente.cdg_cliente. UPDATE bcliente.horario_de_atencion        .
                 NEXT.
        END.
        IF a <= 0 OR a >= 2359 THEN DO:
                 FIND  bcliente WHERE rowid(cliente) = rowid(bcliente) EXCLUSIVE-LOCK.
                 DISPLAY  cliente.cdg_cliente. UPDATE bcliente.horario_de_atencion.
                 NEXT.
        END.
    END.
END.
END.
