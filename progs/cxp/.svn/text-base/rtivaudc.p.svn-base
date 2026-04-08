/*=================================================================================*/
/*    CALCULO DE LA RETENCION DE IVA DE UN PAGO APLICADO                           */
/*    A UN DOCUMENTO DE  CTA_CTE                                                   */
/*=================================================================================*/

    {VRSHARED.I}
    {VPERSINM.I}

    DEFINE INPUT  PARAMETER rid_ctacte AS ROWID. 
    DEFINE INPUT  PARAMETER este_pago  AS DECIMAL. 
    DEFINE OUTPUT PARAMETER a_retener  AS DECIMAL. 

    DEFINE VARIABLE aux_importe        AS DECIMAL.

    FIND Cta_cte_prv WHERE ROWID(Cta_cte_prv) = rid_ctacte NO-LOCK.
    FIND Proveedor OF Cta_cte_prv NO-LOCK.

    IF Proveedor.ret_iva OR 
       ( NOT Proveedor.ret_iva AND Cta_cte_prv.fecha_vencimiento > Proveedor.fmax_iva)
    THEN DO:
        RUN RTIVAUMN.P (INPUT  Cta_cte_prv.cdg_tiporetiva,
                        INPUT  Cta_cte_prv.fecha_vencimiento,
                        INPUT  este_pago,
                        OUTPUT aux_importe).
        CASE Proveedor.plib_iva:
           WHEN 0.0
           THEN DO:
               a_retener = 0.
           END.
           WHEN 100.0
           THEN DO:
               a_retener = aux_importe.
           END.
           OTHERWISE
           DO:
               a_retener = ROUND( aux_importe * ( 1 - Proveedor.plib_iva / 100 ), 2).
           END.
        END CASE.   
    END.     
    ELSE DO:
        a_retener = 0.
    END.     
