DEFINE INPUT PARAMETER p-fecha       AS DATE.
DEFINE OUTPUT PARAMETER o-cambio     AS DECIMAL.

FIND FIRST Moneda 
     WHERE Moneda.es_local 
     NO-LOCK NO-ERROR.
IF AVAILABLE Moneda THEN
DO:
  {findempresa.i}
  DEFINE VARIABLE p-xx AS DATE . /* Por Compatibilidad */
  RUN cotizar_moneda.p ( INPUT  Moneda.cdg_moneda,
                         INPUT  Empresa.cdg_empresa, 
                         INPUT  p-fecha,       
                         OUTPUT o-cambio,  
                         OUTPUT p-xx ).
END.
