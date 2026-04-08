    DEFINE VAR r AS INT NO-UNDO.
    FOR EACH Contrato_hd 
    WHERE contrato_hd.estado = "A" AND 01/01/2017 <= Contrato_hd.rige_hasta 
        AND contrato_hd.rige_desde >= 01/01/2018
 
      AND NOT anulado AND contrato_hd.fecha_baja = ? AND
          ((contrato_hd.cant_periodos<>0 AND contrato_hd.resto_periodos <> 0 ) OR
           contrato_hd.cant_periodos = 0 )  
      :
        FIND articulo WHERE articulo.cdg_articulo = "23F" NO-LOCK.
        FIND contrato_dt OF contrato_hd WHERE contrato_dt.nro_articulo = articulo.nro_articulo NO-ERROR.
        IF AVAILABLE contrato_dt AND contrato_dt.precio <> 0 THEN DO:
            ASSIGN  contrato_dt.precio = TRUNCATE( 310 / 1.21 , 2 )
            contrato_dt.precio_cf = 310
            contrato_dt.subtotal_bruto = contrato_dt.precio
            contrato_dt.subtotal_bruto_cf = contrato_dt.precio_cf
            contrato_dt.subtotal_neto_cf = contrato_dt.precio_cf
            contrato_dt.subtotal_gral = contrato_dt.subtotal_bruto_cf
            contrato_dt.subtotal_neto = contrato_dt.precio
            contrato_dt.subtotal_neto_cf = contrato_dt.precio_cf.
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
    END.


