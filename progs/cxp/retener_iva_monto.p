/*=================================================================================*/
/*       CALCULA LA RETENCION TOTAL DE IVA PARA UN MONTO Y ACTIVIDAD DADOS         */
/*=================================================================================*/

    DEFINE INPUT  PARAMETER p-cdg_tiporetiva      LIKE Cta_cte_prv.cdg_tiporetiva.
    DEFINE INPUT  PARAMETER p-fecha_vencimiento   LIKE Cta_cte_prv.fecha_vencimiento.
    DEFINE INPUT  PARAMETER p-imp_iva             LIKE Cta_cte_prv.imp_iva.
    DEFINE OUTPUT PARAMETER p-retencion           AS DECIMAL INITIAL 0.0.
    DEFINE OUTPUT PARAMETER p-alicuota            AS DECIMAL.
    
    FIND FIRST Rango_retiva 
         WHERE Rango_retiva.cdg_tiporetiva = p-cdg_tiporetiva
           AND Rango_retiva.desde_fecha   <= p-fecha_vencimiento
           AND Rango_retiva.hasta_fecha   >= p-fecha_vencimiento
           AND Rango_retiva.desde_importe <= p-imp_iva
           AND Rango_retiva.hasta_importe >= p-imp_iva NO-LOCK.
 
    IF p-retencion < Rango_retiva.imp_basico 
    THEN DO:
         p-retencion = 0.
         p-alicuota  = 0.
    END.
    ELSE DO:
         p-retencion = ROUND(p-imp_iva * Rango_retiva.alicuota / 100, 2).
         p-alicuota  = Rango_retiva.alicuota.
    END.     

    /*------------------------------------------------------------------------
    MESSAGE 
             "TIPO" p-cdg_tiporetiva                              SKIP
             "FECHA" STRING(p-fecha_vencimiento,"99/99/9999")     SKIP
             "IMPORTE" STRING(p-imp_iva,"999999.99")              SKIP
             "RETENCION" STRING(p-retencion,"999999.99")          SKIP
             "TASA" STRING(p-alicuota,"999999.99")                SKIP
                VIEW-AS ALERT-BOX MESSAGE TITLE "RETENER_IVA_MONTO".
    --------------------------------------------------------------------------*/
