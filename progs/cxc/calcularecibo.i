
EMPTY TEMP-TABLE {1}Totales_recibo.

IF {1}Rec_header.tipo_pago = 1
THEN DO:

   {1}Rec_header.imp_bruto     = 0.
   {1}Rec_header.imp_total     = 0.
   {1}Rec_header.imp_pesos     = 0.
   {1}Rec_header.imp_difcambio = 0.

   FOR EACH {1}Rec_detalle OF {1}Rec_header:
       /*, 
       FIRST Cta_cte WHERE Cta_cte.nro_cliente     = {1}Rec_header.nro_cliente 
                       AND Cta_cte.tip_comprob     = {1}Rec_detalle.tip_cancela
                       AND Cta_cte.prf_comprob     = {1}Rec_detalle.prf_cancela
                       AND Cta_cte.nro_comprob     = {1}Rec_detalle.nro_cancela
                       AND Cta_cte.nro_vencimiento = {1}Rec_detalle.nro_vencimiento:
        */                                                                

       FIND {1}Totales_recibo WHERE {1}Totales_recibo.nro_moneda = {1}Rec_detalle.nro_moneda NO-ERROR.
       IF NOT AVAILABLE {1}Totales_recibo
       THEN DO:
           CREATE {1}Totales_recibo.
           BUFFER-COPY {1}Rec_detalle TO {1}Totales_recibo
               ASSIGN {1}Totales_recibo.imp_total = 0
                      {1}Totales_recibo.imp_pesos = 0.
       END.

       {1}Rec_header.imp_bruto  = {1}Rec_header.imp_bruto + {1}Rec_detalle.importe.
       {1}Rec_detalle.imp_pesos = ROUND(({1}Rec_detalle.importe - {1}Rec_detalle.descuento ) * 
                                           {1}Rec_detalle.cambio, 2).

       {1}Rec_header.imp_pesos  = {1}Rec_header.imp_pesos + {1}Rec_detalle.imp_pesos.
                

       {1}Totales_recibo.imp_total  = {1}Totales_recibo.imp_total + 
                                      {1}Rec_detalle.importe - 
                                      {1}Rec_detalle.descuento.

       {1}Totales_recibo.imp_pesos  = {1}Totales_recibo.imp_pesos + {1}Rec_detalle.imp_pesos.

       /*
       {1}Rec_detalle.difcambio = ROUND(({1}Rec_detalle.importe - {1}Rec_detalle.descuento ) * 
                                       ( {1}Rec_header.cambio - {1}Rec_detalle.cambio ), 2).
       */                                

   END.
   {1}Rec_header.imp_difcambio = 0.
   FOR EACH {1}Fac_header, Tipocomprobante OF {1}Fac_header:
       IF Tipocomprobante.debita 
           THEN {1}Rec_header.imp_difcambio = {1}Rec_header.imp_difcambio + {1}Fac_header.imp_total.
           ELSE {1}Rec_header.imp_difcambio = {1}Rec_header.imp_difcambio - {1}Fac_header.imp_total.
   END.
END.       
ELSE DO:
   
   RUN reexpresar_cotizacion.p (INPUT  {1}Rec_header.nro_moneda,
                                INPUT  {1}Rec_header.cambio,
                                INPUT  {1}Rec_header.fch_cambio,
                                INPUT  {1}Rec_header.imp_total,
                                OUTPUT o-importe).
   ASSIGN
      {1}Rec_header.imp_pesos     = IF Moneda.es_local 
                                       THEN {1}Rec_header.imp_total 
                                       ELSE  ROUND(o-importe,2)
                                           /* ROUND({1}Rec_header.imp_total  * {1}Rec_header.cambio, 2) */

      {1}Rec_header.imp_difcambio = 0
      {1}Rec_header.imp_bruto     = {1}Rec_header.imp_total.

END.
