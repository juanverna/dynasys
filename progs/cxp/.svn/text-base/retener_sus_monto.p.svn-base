/*=================================================================================*/
/*  CALCULA LA RETENCION TOTAL DE INGRESOS BRUTOS PARA UN MONTO Y ACTIVIDAD DADOS  */
/*=================================================================================*/

DEFINE INPUT  PARAMETER p-cdg_tiporetsus        LIKE Cta_cte_prv.cdg_tiporetsus.
DEFINE INPUT  PARAMETER p-fecha_vencimiento     LIKE Cta_cte_prv.fecha_vencimiento.
DEFINE INPUT  PARAMETER p-imp_neto              LIKE Cta_cte_prv.imp_neto.
DEFINE INPUT  PARAMETER p-convenio              LIKE Proveedor.convenio_sino.
DEFINE INPUT  PARAMETER p-minimo_activo         AS LOGICAL.
DEFINE OUTPUT PARAMETER p-retencion             AS DECIMAL.
DEFINE OUTPUT PARAMETER p-alicuota              AS DECIMAL.

FIND Tipo_retsus WHERE Tipo_retsus.cdg_tiporetsus = p-cdg_tiporetsus NO-LOCK.  

/*
        MESSAGE "Neto:" STRING(p-imp_neto) skip
                "Minimo:" STRING(Tipo_retsus.imp_retmin-sus) SKIP
                "ACT:" p-cdg_tiporetsus SKIP
                VIEW-AS ALERT-BOX MESSAGE TITLE "RTsusUMN.P".
*/

/* Si el pago es menor que el minimo y este se halla activo, hace retencion = 0 */

IF p-imp_neto < Tipo_retsus.imp_retmin AND p-minimo_activo
THEN DO:
    p-retencion = 0.
END.
ELSE DO:
    FIND FIRST Rango_retsus OF Tipo_retsus
         WHERE Rango_retsus.desde_fecha   <= p-fecha_vencimiento
           AND Rango_retsus.hasta_fecha   >= p-fecha_vencimiento
           AND Rango_retsus.desde_importe <= p-imp_neto
           AND Rango_retsus.hasta_importe >= p-imp_neto NO-LOCK.
    
    p-alicuota  = Rango_retsus.alicuota.   
    p-retencion = ROUND(p-imp_neto * p-alicuota / 100, 2).
END.

                     

