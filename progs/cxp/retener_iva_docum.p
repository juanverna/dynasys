/*=================================================================================*/
/* CALCULO DE LA RETENCION DE IVA DE UN PAGO APLICADO A UN DOCUMENTO DE  CTA_CTE   */
/*=================================================================================*/

    DEFINE INPUT  PARAMETER rid_ctacte AS ROWID. 
    DEFINE INPUT  PARAMETER este_pago  AS DECIMAL. 
    DEFINE INPUT  PARAMETER fecha_pago AS DATE. 
    DEFINE OUTPUT PARAMETER a_retener  AS DECIMAL. 
    DEFINE OUTPUT PARAMETER alicuota   AS DECIMAL. 

/*=================================================================================*/
/*                                 VARIABLES                                       */
/*=================================================================================*/

    DEFINE VARIABLE aux_importe        AS DECIMAL.
    DEFINE VARIABLE pago_iva           AS DECIMAL.

/*=================================================================================*/
/*                               BLOQUE PRINCIPAL                                  */
/*=================================================================================*/

    a_retener = 0. /* Asume que no hay retencion */
    
    FIND Cta_cte_prv WHERE ROWID(Cta_cte_prv) = rid_ctacte NO-LOCK.
    IF Cta_cte_prv.imp_iva <> 0
    THEN DO:

        IF este_pago = Cta_cte_prv.imp_total
        THEN DO:
             pago_iva = Cta_cte_prv.imp_iva.
        END.
        ELSE DO:
             pago_iva = ROUND( este_pago * ( Cta_cte_prv.imp_iva / Cta_cte_prv.imp_total ), 2) .
        END.

        FIND Proveedor OF Cta_cte_prv NO-LOCK.
    
        RUN retener_iva_monto.p (INPUT  Cta_cte_prv.cdg_tiporetiva,
                                 INPUT  fecha_pago,
                                 INPUT  pago_iva,
                                 OUTPUT aux_importe,
                                 OUTPUT alicuota).

        CASE Proveedor.plib_iva:
           WHEN 100.0
           THEN DO:
               a_retener = 0.
           END.
           WHEN 0.0
           THEN DO:
               a_retener = aux_importe.
           END.
           OTHERWISE
           DO:
               a_retener = ROUND( aux_importe * ( 1 - Proveedor.plib_iva / 100 ), 2).
           END.
        END CASE.

    END.
