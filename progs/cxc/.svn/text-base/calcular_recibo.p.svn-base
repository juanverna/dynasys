/* ============================================================================================= */
/*                      HACE EL CALCULO DE LOS IMPORTES DE UN RECIBO                             */
/* ============================================================================================= */

/* ============================================================================================= */
/*                                   TABLAS TEMPORALES                                           */
/* ============================================================================================= */

DEFINE TEMP-TABLE T-Rec_header     NO-UNDO LIKE Rec_header.
DEFINE TEMP-TABLE T-Rec_detalle    NO-UNDO LIKE Rec_detalle.
DEFINE TEMP-TABLE T-Totales_recibo NO-UNDO LIKE Totales_recibo.

/* ============================================================================================= */
/*                                       PARAMETROS                                              */
/* ============================================================================================= */

DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Rec_header.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Rec_detalle.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Totales_recibo.

DEFINE VARIABLE o-importe LIKE Cotizacion.cambio.

/* ============================================================================================= */
/*                                        PROCESO                                                */
/* ============================================================================================= */

EMPTY TEMP-TABLE T-Totales_recibo.

FIND FIRST T-Rec_header.
IF T-Rec_header.tipo_pago = 1
THEN DO:

   T-Rec_header.imp_bruto     = 0.
   T-Rec_header.imp_total     = 0.
   T-Rec_header.imp_pesos     = 0.
   T-Rec_header.imp_difcambio = 0.

   FOR EACH T-Rec_detalle OF T-Rec_header, Moneda OF T-Rec_detalle NO-LOCK:
       /*, 
       FIRST Cta_cte WHERE Cta_cte.nro_cliente     = T-Rec_header.nro_cliente 
                       AND Cta_cte.tip_comprob     = T-Rec_detalle.tip_cancela
                       AND Cta_cte.prf_comprob     = T-Rec_detalle.prf_cancela
                       AND Cta_cte.nro_comprob     = T-Rec_detalle.nro_cancela
                       AND Cta_cte.nro_vencimiento = T-Rec_detalle.nro_vencimiento:
        */                                                                

       FIND T-Totales_recibo WHERE T-Totales_recibo.nro_moneda = T-Rec_detalle.nro_moneda NO-ERROR.
       IF NOT AVAILABLE T-Totales_recibo
       THEN DO:
           CREATE T-Totales_recibo.
           BUFFER-COPY T-Rec_detalle TO T-Totales_recibo
               ASSIGN T-Totales_recibo.imp_total = 0
                      T-Totales_recibo.imp_pesos = 0.
       END.

       T-Rec_header.imp_bruto  = T-Rec_header.imp_bruto + T-Rec_detalle.importe.
       T-Rec_detalle.imp_pesos = IF Moneda.es_local 
                                    THEN T-Rec_detalle.importe
                                    ELSE ROUND((T-Rec_detalle.importe - T-Rec_detalle.descuento ) * 
                                        T-Rec_detalle.cambio, 2).

       T-Rec_header.imp_pesos  = T-Rec_header.imp_pesos + T-Rec_detalle.imp_pesos.

       T-Totales_recibo.imp_total  = T-Totales_recibo.imp_total + 
                                      T-Rec_detalle.importe - 
                                      T-Rec_detalle.descuento.
       T-Totales_recibo.imp_difcambio = T-Totales_recibo.imp_difcambio + T-Rec_detalle.difcambio.

       T-Totales_recibo.imp_pesos  = T-Totales_recibo.imp_pesos + T-Rec_detalle.imp_pesos.

       T-Rec_header.imp_difcambio = T-Rec_header.imp_difcambio + T-Rec_detalle.difcambio.

   END.

END.       
ELSE DO:
   
   FIND Moneda OF T-Rec_header NO-LOCK.

   RUN reexpresar_cotizacion.p (INPUT  T-Rec_header.nro_moneda,
                                INPUT  T-Rec_header.cambio,
                                INPUT  T-Rec_header.fch_cambio,
                                INPUT  T-Rec_header.imp_total,
                                OUTPUT o-importe).
   ASSIGN
      T-Rec_header.imp_pesos     = IF Moneda.es_local 
                                       THEN T-Rec_header.imp_total 
                                       ELSE  ROUND(o-importe,2)
                                           /* ROUND(T-Rec_header.imp_total  * T-Rec_header.cambio, 2) */

      T-Rec_header.imp_difcambio = 0
      T-Rec_header.imp_bruto     = T-Rec_header.imp_total.

END.
