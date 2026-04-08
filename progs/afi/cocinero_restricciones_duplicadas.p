/*lista restricciones que se excluyen*/
OUTPUT TO "CLIPBOARD".
DEFINE BUFFER b FOR cliente_restriccion.
    DEFINE VAR a AS CHAR NO-UNDO.
    DEFINE VAR g AS CHAR NO-UNDO.

    FOR EACH cliente_restriccion NO-LOCK, cliente OF cliente_restriccion :
        FIND restriccion OF cliente_restriccion NO-LOCK.
            a = restriccion.etag.
            g = restriccion.cdg_restriccion.
            IF a = "" THEN NEXT.
        FOR each b WHERE 
            b.nro_cliente = cliente_restriccion.nro_cliente AND
            ROWID(b) <> ROWID(cliente_restriccion) NO-LOCK:
            FIND restriccion OF b NO-LOCK.
            IF restriccion.etag = a THEN DO:
                display Cliente.nom_cliente FORMAT "X(25)" cliente.cdg_cliente g 
                restriccion.cdg_restriccion.
            END.
        END.
    END.
   
