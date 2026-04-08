/*=============================================================================*/
/*     CARGA EN UNA TABLA TEMPORAL EL ASIENTO CONTABLE DE UNA TRANSACCION      */
/*=============================================================================*/

   DEFINE TEMP-TABLE T-Asn_header  NO-UNDO LIKE Asn_header.
   DEFINE TEMP-TABLE T-Asn_detalle NO-UNDO LIKE Asn_detalle.
   DEFINE TEMP-TABLE T-Asn_totales NO-UNDO LIKE Asn_totales.
   
/*=============================================================================*/
/*                       DEFINICION DE PARAMETROS                              */
/*=============================================================================*/

   DEFINE INPUT PARAMETER p-tabla_comprobante LIKE Asn_header.tabla_comprobante.
   DEFINE INPUT PARAMETER p-nro_idcabecera    LIKE Asn_header.nro_idcabecera.

   DEFINE OUTPUT PARAMETER TABLE FOR T-Asn_header.
   DEFINE OUTPUT PARAMETER TABLE FOR T-Asn_detalle.
   DEFINE OUTPUT PARAMETER TABLE FOR T-Asn_totales.
   
/*=============================================================================*/
/*      CARGA EN UNA TABLA TEMPORAL EL ASIENTO CONTABLE DE UNA TRANSACCION     */
/*=============================================================================*/

   FIND FIRST Asn_header 
       WHERE Asn_header.tabla_comprobante = p-tabla_comprobante
         AND Asn_header.nro_idcabecera = p-nro_idcabecera
             NO-LOCK NO-ERROR.

   IF AVAILABLE Asn_header
   THEN DO:
       CREATE T-Asn_header.
       BUFFER-COPY Asn_header TO T-Asn_header.
       FOR EACH Asn_detalle OF Asn_header NO-LOCK:
           CREATE T-Asn_detalle.
           BUFFER-COPY Asn_detalle TO T-Asn_detalle.
       END.
       FOR EACH Asn_totales OF Asn_header NO-LOCK:
           CREATE T-Asn_totales.
           BUFFER-COPY Asn_totales TO T-Asn_totales.
       END.
   END.
