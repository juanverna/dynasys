/*=================================================================================================*/
/*       DEFINICION DE LA TABLA TEMPORAL DE PAGOS POR ACTIVIDAD PARA RETENCION DE GANANCIAS        */
/*=================================================================================================*/

DEFINE TEMP-TABLE T-Pagos_por_actividad
    FIELD cdg_tiporetgan LIKE Tipo_actividad.cdg_tiporetgan
    FIELD imp_estepago   AS DECIMAL
    FIELD tot_pagado     AS DECIMAL /* Cn este acumulado busca el rango de ganancias que aplica */
    FIELD tot_retenido   AS DECIMAL /* Es el total ya retenido excluyendo esta O/P */
    FIELD tot_a_retener  AS DECIMAL /* Es el total a retener incluyendo esta O/P */
    FIELD imp_estareten  AS DECIMAL /* Es la diferencia anterior, o sea la retencion, si supera el mínimo */

    FIELD desde_importe  LIKE Rango_retgan.desde_importe
    FIELD hasta_importe  LIKE Rango_retgan.hasta_importe
    FIELD imp_basico     LIKE Rango_retgan.imp_basico 
    FIELD alicuota       LIKE Rango_retgan.alicuota   

    INDEX por_actividad IS UNIQUE PRIMARY cdg_tiporetgan.
