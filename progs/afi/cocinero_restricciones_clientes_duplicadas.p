DEFINE BUFFER b FOR cliente_restriccion.
    DEFINE VAR d AS LOGICAL.
    FOR EACH cliente_restriccion  :
        FIND cliente OF cliente_restriccion  NO-ERROR.
        IF NOT AVAILABLE cliente THEN NEXT.
        
        FIND FIRST b WHERE 
            b.nro_cliente = cliente_restriccion.nro_cliente AND
            b.nro_restriccion = cliente_restriccion.nro_restriccion AND
            ROWID(b) <> ROWID(cliente_restriccion) NO-LOCK NO-ERROR.
        IF AVAILABLE b THEN DO:
        
            DISPLAY cdg_cliente b.nro_restriccion b.nro_cliente b.valor.
        UPDATE d .
        IF d THEN DELETE cliente_restriccion.
        END.
    END.
