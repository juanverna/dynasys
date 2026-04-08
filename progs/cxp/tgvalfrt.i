     IF Proveedor.ret_{1}:SENSITIVE IN FRAME frm-entidad
     THEN DO:
        aux_fecha = DATE(Proveedor.fmax_{1}:SCREEN-VALUE IN FRAME frm-entidad) NO-ERROR.
        IF ERROR-STATUS:ERROR
        THEN DO:
           RUN PONMENSJ.P (INPUT "{2}").
           RETURN.
        END.
     END.