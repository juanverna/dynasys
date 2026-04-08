FOR EACH contrato_hd :
    ASSIGN 
            contrato_hd.imp_bruto = 0
            contrato_hd.imp_iva = 0
            contrato_hd.imp_neto = 0
            contrato_hd.imp_total = 0.
    FOR EACH contrato_dt OF contrato_hd:
        FIND articulo OF contrato_dt.
        IF articulo.nro_familimpos = 1 THEN
            contrato_dt.precio = TRUNCATE( contrato_dt.precio_cf / 1.21 , 2 ).
            ELSE
                contrato_dt.precio = contrato_dt.precio_cf .
        ASSIGN  
            contrato_dt.subtotal_bruto = contrato_dt.precio
            contrato_dt.subtotal_bruto_cf = contrato_dt.precio_cf
            contrato_dt.subtotal_neto_cf = contrato_dt.precio_cf
            contrato_dt.subtotal_gral = contrato_dt.subtotal_bruto_cf
            contrato_dt.subtotal_neto = contrato_dt.precio
            contrato_dt.subtotal_neto_cf = contrato_dt.precio_cf.
        ASSIGN
        contrato_hd.imp_bruto = contrato_hd.imp_bruto + contrato_dt.subtotal_bruto
        contrato_hd.imp_iva = contrato_hd.imp_iva + contrato_dt.precio_cf - contrato_dt.precio
        contrato_hd.imp_neto = contrato_hd.imp_neto + contrato_dt.subtotal_neto
        contrato_hd.imp_total = contrato_hd.imp_total + contrato_dt.subtotal_gral.
            
    END.
END.
