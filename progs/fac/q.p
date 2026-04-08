FIND FIRST articulo WHERE cdg_art="01f".
FOR EACH Contrato_hd 
    WHERE contrato_hd.estado = "A" AND today <= Contrato_hd.rige_hasta 
      AND NOT anulado AND contrato_hd.fecha_baja = ? AND
          ((contrato_hd.cant_periodos<>0 AND contrato_hd.resto_periodos <> 0 ) OR
           contrato_hd.cant_periodos = 0 )  AND contrato_hd.nro_tipo_evento = 1
      :
find contrato_dt OF contrato_hd WHERE contrato_dt.nro_articulo = articulo.nro_articulo AND
    contrato_dt.precio <> 82.64 NO-ERROR.
IF NOT AVAILABLE contrato_dt THEN NEXT.
    contrato_dt.precio = 82.64.
    contrato_dt.precio_cf = 100.
ASSIGN  
       Contrato_hd.imp_bruto = 0
       Contrato_hd.imp_iva = 0
       Contrato_hd.imp_neto = 0
       Contrato_hd.imp_total = 0.
    FOR EACH contrato_dt OF contrato_hd:
                ASSIGN
        contrato_dt.subtotal_bruto    = contrato_dt.precio                                                                                                               
        contrato_dt.subtotal_bruto_cf = contrato_dt.precio_cf                                                                                                            
        contrato_dt.subtotal_neto_cf  = contrato_dt.precio_cf                                                                                                            
        contrato_dt.subtotal_gral     = contrato_dt.subtotal_bruto_cf                                                                                                    
        contrato_dt.subtotal_neto     = contrato_dt.precio                                                                                                               
        contrato_dt.subtotal_neto_cf  = contrato_dt.precio_cf. 
                Contrato_hd.imp_bruto         =Contrato_hd.imp_bruto + contrato_dt.subtotal_bruto.
                Contrato_hd.imp_iva           =Contrato_hd.imp_iva   + contrato_dt.precio_cf - contrato_dt.precio.
                Contrato_hd.imp_neto          =Contrato_hd.imp_neto  + contrato_dt.subtotal_neto.
                Contrato_hd.imp_total         =Contrato_hd.imp_total + contrato_dt.subtotal_gral.
    END.
END.


