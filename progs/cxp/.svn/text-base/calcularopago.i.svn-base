IF {1}Opg_header.tipo_pago = 1
THEN DO:

   {1}Opg_header.imp_bruto     = 0.
   {1}Opg_header.imp_total     = 0.
   {1}Opg_header.imp_pesos     = 0.
   {1}Opg_header.imp_difcambio = 0.

   FOR EACH {1}Opg_detalle OF {1}Opg_header:
       /*, 
       FIRST Cta_cte WHERE Cta_cte.nro_cliente     = {1}Opg_header.nro_cliente 
                       AND Cta_cte.tip_comprob     = {1}Opg_detalle.tip_cancela
                       AND Cta_cte.prf_comprob     = {1}Opg_detalle.prf_cancela
                       AND Cta_cte.nro_comprob     = {1}Opg_detalle.nro_cancela
                       AND Cta_cte.nro_vencimiento = {1}Opg_detalle.nro_vencimiento:
        */                                                                
       {1}Opg_header.imp_bruto  = {1}Opg_header.imp_bruto + 
                                  {1}Opg_detalle.importe.
       {1}Opg_header.imp_total  = {1}Opg_header.imp_total + 
                                  {1}Opg_detalle.importe - 
                                  {1}Opg_detalle.descuento.
       {1}Opg_detalle.imp_pesos = IF NOT Moneda.es_local THEN ROUND(({1}Opg_detalle.importe - {1}Opg_detalle.descuento ) * 
                                               {1}Opg_detalle.cambio, 2) ELSE {1}Opg_detalle.importe - {1}Opg_detalle.descuento.
       {1}Opg_header.imp_pesos  = {1}Opg_header.imp_pesos + {1}Opg_detalle.imp_pesos.
                
       /*
       {1}Opg_detalle.difcambio = ROUND(({1}Opg_detalle.importe - {1}Opg_detalle.descuento ) * 
                                       ( {1}Opg_header.cambio - {1}Opg_detalle.cambio ), 2).
       */                                

   END.
   {1}Opg_header.imp_difcambio = 0.
   FOR EACH T-Fac_header_prv, Tipocomprobante OF T-Fac_header_prv:
       IF Tipocomprobante.debita 
           THEN {1}Opg_header.imp_difcambio = {1}Opg_header.imp_difcambio - T-Fac_header_prv.imp_total.
           ELSE {1}Opg_header.imp_difcambio = {1}Opg_header.imp_difcambio + T-Fac_header_prv.imp_total.
   END.
END.       
ELSE DO:
   ASSIGN
      {1}Opg_header.imp_pesos     = ROUND({1}Opg_header.imp_total  * {1}Opg_header.cambio, 2)
      {1}Opg_header.imp_difcambio = 0
      {1}Opg_header.imp_bruto     = {1}Opg_header.imp_total.

END.
