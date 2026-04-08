/* ============================================================================================= */
/*                      HACE EL CALCULO DE LOS IMPORTES DE UN RECIBO                             */
/* ============================================================================================= */

/* ============================================================================================= */
/*                                   TABLAS TEMPORALES                                           */
/* ============================================================================================= */

DEFINE TEMP-TABLE T-Opg_header     NO-UNDO LIKE Opg_header.
DEFINE TEMP-TABLE T-Opg_detalle    NO-UNDO LIKE Opg_detalle.
DEFINE TEMP-TABLE T-Totales_opago  NO-UNDO LIKE Totales_opago.

/* ============================================================================================= */
/*                                       PARAMETROS                                              */
/* ============================================================================================= */

DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Opg_header.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Opg_detalle.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Totales_opago.

DEFINE VARIABLE o-importe LIKE Cotizacion.cambio.

/* ============================================================================================= */
/*                                        PROCESO                                                */
/* ============================================================================================= */

EMPTY TEMP-TABLE T-Totales_opago.

FIND FIRST T-Opg_header.
IF T-Opg_header.tipo_pago = 1
THEN DO:

   T-Opg_header.imp_bruto     = 0.
   T-Opg_header.imp_total     = 0.
   T-Opg_header.imp_pesos     = 0.
   T-Opg_header.imp_difcambio = 0.

   FOR EACH T-Opg_detalle OF T-Opg_header, Moneda OF T-Opg_detalle NO-LOCK:

       FIND T-Totales_opago WHERE T-Totales_opago.nro_moneda = T-Opg_detalle.nro_moneda NO-ERROR.
       IF NOT AVAILABLE T-Totales_opago
       THEN DO:
           CREATE T-Totales_opago.
           BUFFER-COPY T-Opg_detalle TO T-Totales_opago
               ASSIGN T-Totales_opago.imp_total = 0
                      T-Totales_opago.imp_pesos = 0.
       END.

       T-Opg_header.imp_bruto  = T-Opg_header.imp_bruto + T-Opg_detalle.importe.
       T-Opg_detalle.imp_pesos = IF Moneda.es_local 
                                    THEN T-Opg_detalle.importe
                                    ELSE ROUND((T-Opg_detalle.importe - T-Opg_detalle.descuento ) * 
                                        T-Opg_detalle.cambio, 2).

       T-Opg_header.imp_pesos  = T-Opg_header.imp_pesos + T-Opg_detalle.imp_pesos.

       T-Totales_opago.imp_total  = T-Totales_opago.imp_total + 
                                      T-Opg_detalle.importe - 
                                      T-Opg_detalle.descuento.
       T-Totales_opago.imp_difcambio = T-Totales_opago.imp_difcambio + T-Opg_detalle.difcambio.

       T-Totales_opago.imp_pesos  = T-Totales_opago.imp_pesos + T-Opg_detalle.imp_pesos.

       T-Opg_header.imp_difcambio = T-Opg_header.imp_difcambio + T-Opg_detalle.difcambio.

       T-Opg_header.imp_total = T-Opg_header.imp_total + T-Opg_detalle.imp_pesos + T-Opg_detalle.difcambio.

   END.

   T-Opg_header.imp_total = T-Opg_header.imp_pesos + T-Opg_header.imp_difcambio.

END.       
ELSE DO:
   
   FIND Moneda OF T-Opg_header NO-LOCK.

   RUN reexpresar_cotizacion.p (INPUT  T-Opg_header.nro_moneda,
                                INPUT  T-Opg_header.cambio,
                                INPUT  T-Opg_header.fch_cambio,
                                INPUT  T-Opg_header.imp_total,
                                OUTPUT o-importe).
   ASSIGN
      T-Opg_header.imp_pesos     = IF Moneda.es_local 
                                       THEN T-Opg_header.imp_total 
                                       ELSE  ROUND(o-importe,2)
                                           /* ROUND(T-Opg_header.imp_total  * T-Opg_header.cambio, 2) */

      T-Opg_header.imp_difcambio = 0
      T-Opg_header.imp_bruto     = T-Opg_header.imp_total.

END.
