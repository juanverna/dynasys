/*=================================================================================*/
/*                                                                                 */
/*    BUSCA EN LA TABLA EL VALOR DE LA GANANCIA NETA Y DEVUELVE EL IMPUESTO NETO   */
/*                                                                                 */
/*=================================================================================*/

DEFINE INPUT PARAMETER  ganancia AS DECIMAL.
DEFINE INPUT PARAMETER  que_mes  AS INTEGER.
DEFINE OUTPUT PARAMETER impuesto AS DECIMAL.

IF ganancia > 0
THEN DO:
     FIND FIRST Rango-cuarta WHERE Rango-cuarta.desde_importe <= ganancia
                               AND Rango-cuarta.hasta_importe >= ganancia
                               AND Rango-cuarta.mes = que_mes NO-LOCK NO-ERROR.

     IF AVAILABLE Rango-cuarta
        THEN impuesto = Rango-cuarta.imp_basico + 
                       ( Rango-cuarta.alicuota / 100.0 * ( ganancia - Rango-cuarta.desde_importe ) ).
        ELSE MESSAGE "No se hallo rango para Ganancia:" STRING(ganancia) " mes:" STRING(que_mes).
END.
ELSE DO:
     impuesto = 0.
END.     
