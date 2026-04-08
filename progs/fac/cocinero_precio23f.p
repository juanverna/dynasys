    FIND articulo WHERE cdg_articulo = "23f".
    FOR EACH fac_header WHERE fecha >= 07/01/2017 , EACH fac_detalle OF fac_header WHERE nro_articulo = articulo.nro_articulo AND
    precio_cf <> 260:
        FIND contrato_dt WHERE contrato_dt.nro_contrato = fac_header.nro_contrato AND contrato_dt.nro_articulo = articulo.nro_articulo.
       ASSIGN contrato_dt.precio = 260
        contrato_dt.precio_cf = 260
        contrato_dt.subtotal_bruto    = contrato_dt.precio                                                                                                               
        contrato_dt.subtotal_bruto_cf = contrato_dt.precio_cf                                                                                                            
        contrato_dt.subtotal_neto_cf  = contrato_dt.precio_cf                                                                                                            
        contrato_dt.subtotal_gral     = contrato_dt.subtotal_bruto_cf                                                                                                    
        contrato_dt.subtotal_neto     = contrato_dt.precio                                                                                                               
        contrato_dt.subtotal_neto_cf  = contrato_dt.precio_cf. 
        FOR EACH contrato_hd WHERE contrato_hd.nro_contrato = fac_header.nro_contrato:
    ASSIGN  Contrato_hd.imp_iva      = 0
           Contrato_hd.imp_neto     = 0 
           Contrato_hd.imp_total    = 0 
           Contrato_hd.imp_bruto    = 0.
   FOR EACH contrato_dt OF contrato_hd:
       ASSIGN 
              Contrato_hd.imp_neto     = Contrato_hd.imp_neto     + Contrato_dt.subtotal_neto  
              Contrato_hd.imp_total    = Contrato_hd.imp_total    + Contrato_dt.subtotal_gral 
              Contrato_hd.imp_bruto    = Contrato_hd.imp_bruto    + Contrato_dt.subtotal_bruto
              Contrato_hd.imp_iva      = Contrato_hd.imp_total    - Contrato_hd.imp_neto.  
   END.
END.
    END.
    
