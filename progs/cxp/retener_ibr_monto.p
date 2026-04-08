/*=================================================================================*/
/*  CALCULA LA RETENCION TOTAL DE INGRESOS BRUTOS PARA UN MONTO Y ACTIVIDAD DADOS  */
/*=================================================================================*/

DEFINE INPUT  PARAMETER p-cdg_tiporetibr        LIKE Cta_cte_prv.cdg_tiporetibr.
DEFINE INPUT  PARAMETER p-fecha_vencimiento     LIKE Cta_cte_prv.fecha_vencimiento.
DEFINE INPUT  PARAMETER p-imp_neto              LIKE Cta_cte_prv.imp_neto.
DEFINE INPUT  PARAMETER p-convenio              LIKE Proveedor.convenio_sino.
DEFINE INPUT  PARAMETER p-minimo_activo         AS LOGICAL.
DEFINE OUTPUT PARAMETER p-retencion             AS DECIMAL.
DEFINE OUTPUT PARAMETER p-alicuota              AS DECIMAL.

/*=================================================================================*/
/*                                BLOQUE PRINCIPAL                                 */
/*=================================================================================*/

FIND Tipo_retibr WHERE Tipo_retibr.cdg_tiporetibr = p-cdg_tiporetibr NO-LOCK.  

IF p-imp_neto < Tipo_retibr.imp_retmin AND p-minimo_activo
THEN DO:
    p-retencion = 0.
END.
ELSE DO:
    FIND FIRST Rango_retibr OF Tipo_retibr
         WHERE Rango_retibr.desde_fecha   <= p-fecha_vencimiento
           AND Rango_retibr.hasta_fecha   >= p-fecha_vencimiento
           AND Rango_retibr.desde_importe <= p-imp_neto
           AND Rango_retibr.hasta_importe >= p-imp_neto NO-LOCK.
    
    IF p-convenio = "S"
       THEN p-alicuota = Rango_retibr.alicuota_cm.
       ELSE p-alicuota = Rango_retibr.alicuota.   
    
    p-retencion = ROUND(p-imp_neto * p-alicuota / 100, 2).
END.

                     

