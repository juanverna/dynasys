
DEFINE VAR pp AS DECIMAL NO-UNDO.
DEFINE VAR n01f AS INT NO-UNDO.
DEFINE VAR n05m AS INT NO-UNDO.
DEFINE VAR a AS INT.
DEFINE VAR b AS char.
DEFINE VAR c AS DECIMAL decimals 2.
DEFINE VAR tiene AS LOGICAL.


FOR EACH contrato_hd WHERE contrato_hd.nro_tipo_evento = 1:

     ASSIGN 
        contrato_hd.imp_bruto = 0
        contrato_hd.imp_iva = 0
        contrato_hd.imp_neto = 0
        contrato_hd.imp_total = 0.
     FOR EACH contrato_dt OF contrato_hd:
        ASSIGN
        contrato_hd.imp_bruto = contrato_hd.imp_bruto + contrato_dt.subtotal_bruto
        contrato_hd.imp_iva = contrato_hd.imp_iva + contrato_dt.precio_cf - contrato_dt.precio
        contrato_hd.imp_neto = contrato_hd.imp_neto + contrato_dt.subtotal_neto
        contrato_hd.imp_total = contrato_hd.imp_total + contrato_dt.subtotal_gral.
    END.
END. 



