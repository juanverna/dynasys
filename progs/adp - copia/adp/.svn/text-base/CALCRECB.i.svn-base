/*
IF Rcb_header.tipo_pago = 1
THEN DO:
   Rcb_header.imp_total     = 0.
   Rcb_header.imp_bruto     = 0.
   Rcb_header.imp_pesos     = 0.
   Rcb_header.imp_difcambio = 0.

   FOR EACH B-Rcb_detalle OF Rcb_header, 
       Cta_cte WHERE Cta_cte.tip_comprob     = B-Rcb_detalle.tip_factura
                 AND Cta_cte.nro_comprob     = B-Rcb_detalle.nro_factura
                 AND Cta_cte.nro_vencimiento = B-Rcb_detalle.nro_vencimiento:
                                                                        
       Rcb_header.imp_total = Rcb_header.imp_total + B-Rcb_detalle.importe.
       Rcb_header.imp_pesos = Rcb_header.imp_pesos +
                ROUND(B-Rcb_detalle.importe * Rcb_header.cambio, 2).
       Rcb_header.imp_difcambio = Rcb_header.imp_difcambio +
                ROUND(B-Rcb_detalle.importe * ( Rcb_header.cambio - Cta_cte.cambio ), 2).

   END.
END.       
ELSE DO:
   Rcb_header.imp_pesos = ROUND(Rcb_header.imp_total  * Rcb_header.cambio, 2).
   Rcb_header.imp_difcambio = 0.
END.

Rcb_header.imp_bruto = Rcb_header.imp_total.

*/