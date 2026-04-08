/*=================================================================================*/
/*                                                                                 */
/*          EVALUA EL MONTO TOTAL DE LA RETENCION DE INGRESOS BRUTOS PARA          */
/*          UN IMPORTE NETO DATO                                                   */
/*                                                                                 */
/*=================================================================================*/

DEFINE INPUT  PARAMETER neto_imponible  AS DECIMAL.
DEFINE INPUT  PARAMETER que_actividad   LIKE Rango_retibr.cdg_tiporetibr.
DEFINE INPUT  PARAMETER fecha_vigencia  AS DATE.
DEFINE OUTPUT PARAMETER aux_importe     AS DECIMAL.

{VPERSINM.I}

 
   FIND FIRST Rango_retibr 
        WHERE Rango_retibr.cdg_tiporetibr = que_actividad
          AND Rango_retibr.desde_fecha   <= fecha_vigencia
          AND Rango_retibr.hasta_fecha   >= fecha_vigencia
          AND Rango_retibr.desde_importe <= neto_imponible
          AND Rango_retibr.hasta_importe >= neto_imponible NO-LOCK.

   aux_importe = ROUND(neto_imponible * Rango_retibr.alicuota / 100, 2).
   IF aux_importe <= Rango_retibr.imp_basico 
      THEN aux_importe = 0.


                      

