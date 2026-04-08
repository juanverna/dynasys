/*=================================================================================*/
/*                                                                                 */
/*          EVALUA EL MONTO TOTAL DE LA RETENCION DEL IMPUESTO AL VALOR            */
/*          AGREGADO PARA UN IMPORTE NETO DATO                                     */
/*                                                                                 */
/*=================================================================================*/

DEFINE INPUT  PARAMETER base_imponible  AS DECIMAL.
DEFINE INPUT  PARAMETER que_actividad   LIKE Rango_retiva.cdg_tiporetiva.
DEFINE INPUT  PARAMETER fecha_vigencia  AS DATE.
DEFINE OUTPUT PARAMETER aux_importe     AS DECIMAL.

{VPERSINM.I}
 
   FIND FIRST Rango_retiva 
        WHERE Rango_retiva.cdg_tiporetiva = que_actividad
          AND Rango_retiva.desde_fecha   <= fecha_vigencia
          AND Rango_retiva.hasta_fecha   >= fecha_vigencia
          AND Rango_retiva.desde_importe <= base_imponible
          AND Rango_retiva.hasta_importe >= base_imponible NO-LOCK.

   aux_importe = ROUND(base_imponible * Rango_retiva.alicuota / 100, 2).
   IF aux_importe <= Rango_retiva.imp_basico 
      THEN aux_importe = 0.


                      

