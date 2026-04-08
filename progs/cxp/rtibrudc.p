/*=================================================================================*/
/*    CALCULO DE LA RETENCION DE INGRESOS BRUTOS DE UN PAGO APLICADO               */
/*    A UN DOCUMENTO DE  CTA_CTE                                                   */
/*=================================================================================*/

    {VRSHARED.I}
    {VPERSINM.I}

    DEFINE INPUT  PARAMETER rid_ctacte AS ROWID. 
    DEFINE INPUT  PARAMETER este_pago  AS DECIMAL. 
    DEFINE OUTPUT PARAMETER a_retener  AS DECIMAL. 
    DEFINE OUTPUT PARAMETER alicuota   AS DECIMAL. 

    DEFINE VARIABLE aux_importe        AS DECIMAL.
    DEFINE VARIABLE neto_pago          AS DECIMAL.

    FIND Cta_cte_prv WHERE ROWID(Cta_cte_prv) = rid_ctacte NO-LOCK.
    FIND Proveedor OF Cta_cte_prv NO-LOCK.

    IF es_agretibr
    THEN DO:
        IF Proveedor.ret_ibrutos OR 
           ( NOT Proveedor.ret_ibrutos AND Cta_cte_prv.fecha_vencimiento > Proveedor.fmax_ibrutos)
        THEN DO:

            IF este_pago = Cta_cte_prv.imp_total
            THEN DO:
                 neto_pago = Cta_cte_prv.imp_neto.
            END.
            ELSE DO:
                 neto_pago = ROUND( este_pago * ( Cta_cte_prv.imp_neto / Cta_cte_prv.imp_total ), 2) .
            END.

            RUN RTIBRUMN.P (INPUT  Cta_cte_prv.cdg_tiporetibr,
                            INPUT  Cta_cte_prv.fecha_vencimiento,
                            INPUT  neto_pago,
                            INPUT  Proveedor.convenio_sino,
                            INPUT  NO, /* desactiva importe minimo */
                            OUTPUT aux_importe).
/*
                       MESSAGE "Retiene:" STRING(Proveedor.ret_ibrutos) skip
                               "Hasta:" STRING(Proveedor.fmax_ibrutos) SKIP
                               "ACT:" Cta_cte_prv.cdg_tiporetibr SKIP
                               "FECHA:" STRING(Cta_cte_prv.fecha_vencimiento) SKIP
                               "PAGO:"  STRING(neto_pago) SKIP
                               "RETENER:" STRING(aux_importe) SKIP
                               VIEW-AS ALERT-BOX MESSAGE TITLE "RTIBRUDC.P".
*/
    
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
    END. 
    ELSE DO:
        a_retener = 0.
    END.    
