ON ENTRY OF pto_venta IN FRAME frm-documento
DO:
   pto_venta-chr = pto_venta:SCREEN-VALUE IN FRAME frm-documento.
END.   

ON LEAVE OF pto_venta IN FRAME frm-documento
DO:
   IF pto_venta-chr <> pto_venta:SCREEN-VALUE IN FRAME frm-documento
      AND pto_venta-chr <> ""
   THEN DO:
        FIND Punto-venta 
             WHERE Punto-venta.cdg_puntovta = INPUT FRAME frm-documento pto_venta
               AND Punto-venta.cdg_empresa  = Empresa.cdg_empresa
                   NO-LOCK NO-ERROR.
        IF AVAILABLE Punto-venta
        THEN DO:
             ASSIGN pto_venta.
             SUBSTRING(prox_docum,5,4) = STRING(pto_venta,"9999").
             MESSAGE "Se cambió el punto de venta" VIEW-AS ALERT-BOX MESSAGE.
        END.
        ELSE DO:
             MESSAGE "No existe el punto de venta indicado!!!" VIEW-AS ALERT-BOX ERROR.
             RETURN NO-APPLY.
        END.
   END.
END.   
