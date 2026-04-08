DEFINE VARIABLE es_orden_pago AS LOGICAL    INITIAL NO NO-UNDO.

es_orden_pago = NO.
FIND FIRST Tipocomprobante
     WHERE Tipocomprobante.cdg_comprobante = i_cdg_comprobante 
     NO-LOCK NO-ERROR.
IF AVAILABLE Tipocomprobante   AND 
   Tipocomprobante.debita =    YES and
   Tipocomprobante.es_monetario = YES THEN
    es_orden_pago = YES.

