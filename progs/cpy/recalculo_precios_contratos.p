FOR EACH contrato_hd:
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
