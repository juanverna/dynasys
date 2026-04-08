/*============================================================================================*/
/*              REEXPRESA UN IMPORTE DADO EN MONEDA LOCAL                                     */                                                                                      
/*============================================================================================*/

DEFINE INPUT  PARAMETER i-nro_moneda LIKE Moneda.nro_moneda.
DEFINE INPUT  PARAMETER i-cambio     LIKE Cotizacion.cambio.
DEFINE INPUT  PARAMETER i-fecha      AS DATE.
DEFINE INPUT  PARAMETER i-importe    AS DECIMAL.
DEFINE OUTPUT PARAMETER o-importe    AS DECIMAL.


DEFINE VARIABLE o-cambio_local LIKE Cotizacion.cambio    INITIAL 0 NO-UNDO.
DEFINE VARIABLE o-cambio       LIKE Cotizacion.cambio    INITIAL 0 NO-UNDO.
DEFINE VARIABLE p-xx AS DATE . /* Por Compatibilidad */


{findempresa.i}
FIND FIRST Moneda     
     WHERE Moneda.nro_moneda = i-nro_moneda 
     NO-LOCK NO-ERROR.
IF AVAILABLE Moneda THEN
DO:
   IF Moneda.es_local = YES  THEN
      ASSIGN o-cambio_local = i-cambio
             o-cambio       = i-cambio.
   ELSE
   DO:
       RUN cambiolocal.p(INPUT  i-fecha,
                         OUTPUT o-cambio_local).
       RUN cotizar_moneda.p ( INPUT  Moneda.cdg_moneda,
                              INPUT  Empresa.cdg_empresa, 
                              INPUT  i-fecha,       
                              OUTPUT o-cambio,  
                              OUTPUT p-xx ). 

   END.
END.
o-importe = ROUND(i-importe * (o-cambio_local / o-cambio),2). 
