/*=================================================================================*/
/*    CALCULO DE LA RETENCION DE INGRESOS BRUTOS DE UN PAGO APLICADO               */
/*    A UN DOCUMENTO DADO DE CUENTA CORRIENTE                                      */
/*=================================================================================*/

    DEFINE INPUT  PARAMETER rid_ctacte AS ROWID. 
    DEFINE INPUT  PARAMETER este_pago  AS DECIMAL. 
    DEFINE INPUT  PARAMETER fecha_ret  AS DATE. 
    DEFINE OUTPUT PARAMETER a_retener  AS DECIMAL. 
    DEFINE OUTPUT PARAMETER alicuota   AS DECIMAL. 

/*=================================================================================*/
/*                                 VARIABLES                                       */
/*=================================================================================*/

    DEFINE VARIABLE aux_importe        AS DECIMAL.
    DEFINE VARIABLE pago_neto          AS DECIMAL.


/*=================================================================================*/
/*                              BLOQUE PRINCIPAL                                   */
/*=================================================================================*/

    FIND Cta_cte_prv WHERE ROWID(Cta_cte_prv) = rid_ctacte NO-LOCK.
    FIND Proveedor OF Cta_cte_prv NO-LOCK.

    IF Proveedor.ret_ibrutos OR 
       ( NOT Proveedor.ret_ibrutos AND Cta_cte_prv.fecha_vencimiento > Proveedor.fmax_ibrutos)
    THEN DO:

        IF este_pago = Cta_cte_prv.imp_total
        THEN DO:
             pago_neto = Cta_cte_prv.imp_neto.
        END.
        ELSE DO:
             pago_neto = ROUND( este_pago * ( Cta_cte_prv.imp_neto / Cta_cte_prv.imp_total ), 2) .
        END.

        RUN retener_ibr_monto.p (INPUT  Cta_cte_prv.cdg_tiporetibr,
                                 INPUT  fecha_ret,
                                 INPUT  pago_neto,
                                 INPUT  Proveedor.convenio_sino,
                                 INPUT  NO, /* desactiva importe minimo */
                                 OUTPUT aux_importe,
                                 OUTPUT alicuota).

        CASE Proveedor.plib_ibrutos:
           WHEN 0.0
           THEN DO:
               a_retener = aux_importe.
           END.
           WHEN 100.0
           THEN DO:
               a_retener = 0.
           END.
           OTHERWISE
           DO:
               a_retener = ROUND( aux_importe * ( 1 - Proveedor.plib_ibrutos / 100 ), 2).
           END.
        END CASE.   
    END.     
    ELSE DO:
        a_retener = 0.
    END.    
