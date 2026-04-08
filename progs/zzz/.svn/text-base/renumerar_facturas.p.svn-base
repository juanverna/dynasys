/*=========================================================================================*/
/*                          RENUMERA UN REGISTRO DE FAC_HEADER                             */
/*=========================================================================================*/

DEFINE VARIABLE v-cdg_empresa LIKE Empresa.cdg_empresa.

DEFINE VARIABLE v-vie_tip_comprob LIKE Fac_header.tip_comprob.
DEFINE VARIABLE v-vie_prf_comprob LIKE Fac_header.prf_comprob.
DEFINE VARIABLE v-vie_nro_comprob LIKE Fac_header.nro_comprob.

DEFINE VARIABLE v-nue_tip_comprob LIKE Fac_header.tip_comprob.
DEFINE VARIABLE v-nue_prf_comprob LIKE Fac_header.prf_comprob.
DEFINE VARIABLE v-nue_nro_comprob LIKE Fac_header.nro_comprob.

DEFINE VARIABLE v-borrar_stock    AS LOGICAL.

SET v-cdg_empresa COLON 20 LABEL "Empresa" SKIP 
    
 v-vie_tip_comprob  COLON 20 LABEL "Viejo Número"
 v-vie_prf_comprob  NO-LABEL
 v-vie_nro_comprob  NO-LABEL SKIP

 v-nue_tip_comprob  COLON 20 LABEL "Nuevo Número"
 v-nue_prf_comprob  NO-LABEL
 v-nue_nro_comprob  NO-LABEL
 v-borrar_stock COLON 38 LABEL "Borrar Movimiento de Sotck"
    WITH SIDE-LABELS VIEW-AS DIALOG-BOX THREE-D TITLE "Renumeración de comprobantes".

IF CAN-FIND(Fac_header WHERE Fac_header.cdg_empresa = v-cdg_empresa
                         AND Fac_header.tip_comprob = v-nue_tip_comprob 
                         AND Fac_header.prf_comprob = v-nue_prf_comprob
                         AND Fac_header.nro_comprob = v-nue_nro_comprob)
THEN DO:
    MESSAGE "Ya existe un comprobante con el nuevo número"
        VIEW-AS ALERT-BOX ERROR TITLE "Error de Numeración".
END.
ELSE DO:
    DO TRANSACTION:
    
        FIND Fac_header WHERE Fac_header.cdg_empresa = v-cdg_empresa
                          AND Fac_header.tip_comprob = v-vie_tip_comprob 
                          AND Fac_header.prf_comprob = v-vie_prf_comprob
                          AND Fac_header.nro_comprob = v-vie_nro_comprob
                              EXCLUSIVE-LOCK.
        ASSIGN Fac_header.tip_comprob = v-nue_tip_comprob 
               Fac_header.prf_comprob = v-nue_prf_comprob
               Fac_header.nro_comprob = v-nue_nro_comprob.
        RELEASE Fac_header.
    
        FOR EACH Sub_header_vta WHERE Sub_header_vta.cdg_empresa = v-cdg_empresa
                                  AND Sub_header_vta.tip_comprob = v-vie_tip_comprob 
                                  AND Sub_header_vta.prf_comprob = v-vie_prf_comprob
                                  AND Sub_header_vta.nro_comprob = v-vie_nro_comprob
                                      EXCLUSIVE-LOCK:
    
            ASSIGN Sub_header_vta.tip_comprob = v-nue_tip_comprob 
                   Sub_header_vta.prf_comprob = v-nue_prf_comprob
                   Sub_header_vta.nro_comprob = v-nue_nro_comprob.
    
        END.
    
        FOR EACH Sub_detalle_vta WHERE Sub_detalle_vta.cdg_empresa = v-cdg_empresa
                                  AND Sub_detalle_vta.tip_comprob = v-vie_tip_comprob 
                                  AND Sub_detalle_vta.prf_comprob = v-vie_prf_comprob
                                  AND Sub_detalle_vta.nro_comprob = v-vie_nro_comprob
                                      EXCLUSIVE-LOCK:
    
            ASSIGN Sub_detalle_vta.tip_comprob = v-nue_tip_comprob 
                   Sub_detalle_vta.prf_comprob = v-nue_prf_comprob
                   Sub_detalle_vta.nro_comprob = v-nue_nro_comprob.
    
        END.
    
        FOR EACH Cta_cte WHERE Cta_cte.cdg_empresa = v-cdg_empresa
                           AND Cta_cte.tip_comprob = v-vie_tip_comprob 
                           AND Cta_cte.prf_comprob = v-vie_prf_comprob
                           AND Cta_cte.nro_comprob = v-vie_nro_comprob
                                      EXCLUSIVE-LOCK:
    
            ASSIGN Cta_cte.tip_comprob = v-nue_tip_comprob 
                   Cta_cte.prf_comprob = v-nue_prf_comprob
                   Cta_cte.nro_comprob = v-nue_nro_comprob.
    
        END.

        FOR EACH Cct_stock WHERE Cct_stock.cdg_empresa = v-cdg_empresa
                             AND Cct_stock.tip_comprob = v-vie_tip_comprob 
                             AND Cct_stock.prf_comprob = v-vie_prf_comprob
                             AND Cct_stock.nro_comprob = v-vie_nro_comprob
                                      EXCLUSIVE-LOCK:
    
            IF v-borrar_stock
                THEN DELETE Cct_stock.
                ELSE ASSIGN Cct_stock.tip_comprob = v-nue_tip_comprob 
                            Cct_stock.prf_comprob = v-nue_prf_comprob
                            Cct_stock.nro_comprob = v-nue_nro_comprob.
    
        END.
    
    END.
END.

