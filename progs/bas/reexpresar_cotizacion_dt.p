DEFINE INPUT  PARAMETER i-nro_moneda_hd  LIKE Moneda.nro_moneda.
DEFINE INPUT  PARAMETER i-nro_moneda_dt  LIKE Moneda.nro_moneda.
DEFINE INPUT  PARAMETER i-cambio_hd  AS DECIMAL.
DEFINE INPUT  PARAMETER i-cambio_dt  AS DECIMAL.
DEFINE INPUT  PARAMETER i-fecha      AS DATE.
DEFINE INPUT  PARAMETER i-importe    AS DECIMAL.
DEFINE OUTPUT PARAMETER o-importe    AS DECIMAL.

DEFINE BUFFER b_moneda FOR moneda.

DEFINE VARIABLE o-cambio_local AS DECIMAL    INITIAL 0 NO-UNDO.
DEFINE VARIABLE o-cambio       AS DECIMAL    INITIAL 0 NO-UNDO.
DEFINE VARIABLE p-xx AS DATE . /* Por Compatibilidad */
DEFINE VARIABLE distintas_monedas AS LOGICAL    NO-UNDO.


{findempresa.i}
FIND FIRST b_Moneda     
     WHERE b_Moneda.nro_moneda = i-nro_moneda_dt  /* de la detalle */
     NO-LOCK NO-ERROR.

FIND FIRST Moneda     
     WHERE Moneda.nro_moneda = i-nro_moneda_hd  /* de la cabecera */
     NO-LOCK NO-ERROR.

distintas_monedas = NO.
IF b_moneda.nro_moneda <> moneda.nro_moneda THEN
   distintas_monedas = YES.

IF AVAILABLE Moneda THEN
DO:
   IF Moneda.es_local = YES  THEN
   DO:
      IF distintas_monedas = NO THEN
         ASSIGN o-cambio_local = i-cambio_hd
                o-cambio       = i-cambio_hd.
      ELSE /* => importe * cotizacion_local / cotizacion_rubro  pej : 10 * 2.92 / 1  o 10 * 2.92 / .87 */
      DO:
      
         RUN cambiolocal.p(INPUT  i-fecha,
                           OUTPUT o-cambio_local).
         RUN cotizar_moneda.p   ( INPUT  b_Moneda.cdg_moneda,
                                  INPUT  Empresa.cdg_empresa, 
                                  INPUT  i-fecha,       
                                  OUTPUT o-cambio,  
                                  OUTPUT p-xx ). 
      END.
   END.
   ELSE
   DO: 
     
         /* => importe * cotizacion_local / cotizacion_rubro  pej : 10 * 2.92 / 1  o 10 * 2.92 / .87 */
         RUN cambiolocal.p(INPUT  i-fecha,
                           OUTPUT o-cambio_local).
         RUN cotizar_moneda.p   ( INPUT  b_Moneda.cdg_moneda,
                                  INPUT  Empresa.cdg_empresa, 
                                  INPUT  i-fecha,       
                                  OUTPUT o-cambio,  
                                  OUTPUT p-xx ). 
     
   END.
END.
o-importe = i-importe * (o-cambio_local / o-cambio). 
