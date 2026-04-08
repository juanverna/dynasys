
DEFINE VAR v-vie_tip_comprob  LIKE fac_header.tip_comprob initial "FC".
DEFINE VAR v-vie_prf_comprob  LIKE fac_header.prf_comprob INITIAL 64.
DEFINE VAR v-vie_nro_comprob  LIKE fac_header.nro_comprob.
DEFINE VAR v-vie_nro_comprob-2 LIKE fac_header.nro_comprob.        
DEFINE VAR v-nue_tip_comprob LIKE fac_header.tip_comprob INITIAL "FC".
DEFINE VAR v-nue_prf_comprob  LIKE fac_header.prf_comprob INITIAL 64.
DEFINE VAR v-nue_nro_comprob LIKE fac_header.nro_comprob.
DEFINE BUFFER bfac_header FOR fac_header.
    DEFINE VAR ultnro AS INT NO-UNDO.
    DEFINE VAR prefcndor AS CHAR NO-UNDO.
    {findempresa.i}
    DEFINE VAR k AS INT NO-UNDO.
DEF VAR ultimo AS INT NO-UNDO.    
    FOR LAST fac_header WHERE prf_comprob = 64 AND tip_comprob = "FC":
                              ultimo = fac_header.nro_comprob.
                              FIND tipocomprobante WHERE tipocomprobante.cdg_comprobante = fac_header.cdg_comprobante NO-LOCK.
prefcndor = replace(prefijo_contador,"*", SUBSTRING(fac_header.tip_comprob,2,1) + STRING(fac_header.prf_comprob,"9999")).
RUN getparametro_n.p ( prefcndor, OUTPUT ultnro).

    END.


    

    FOR EACH bfac_header WHERE bfac_header.prf_comprob = 64 AND bfac_header.tip_comprob = "FC" AND bfac_header.imp_total > 1000 AND bfac_header.cod_docu <> "CUIT"
AND bfac_header.cod_docu <> "CUIL" BY bfac_header.nro_comprob DESC:
DISPLAY bfac_header.nro_comprob.

        FOR EACH Fac_detalle OF bFac_header EXCLUSIVE-LOCK:
                     DELETE Fac_detalle.
                 END.
       FOR EACH Sub_header_vta
                     WHERE Sub_header_vta.cdg_empresa = bfac_header.cdg_empresa
                       AND Sub_header_vta.tip_comprob = bfac_header.tip_comprob
                       AND Sub_header_vta.prf_comprob = bfac_header.prf_comprob
                       AND Sub_header_vta.nro_comprob = bfac_header.nro_comprob 
                           EXCLUSIVE-LOCK:

                     DELETE Sub_header_vta.

                 END.    

                 FOR EACH Sub_detalle_vta
                     WHERE Sub_detalle_vta.cdg_empresa = bfac_header.cdg_empresa
                       AND Sub_detalle_vta.tip_comprob = bfac_header.tip_comprob
                       AND Sub_detalle_vta.prf_comprob = bfac_header.prf_comprob
                       AND Sub_detalle_vta.nro_comprob = bfac_header.nro_comprob 
                           EXCLUSIVE-LOCK:

                     DELETE Sub_detalle_vta.

                 END.    

                 FOR EACH Sub_header_inv
                     WHERE Sub_header_inv.cdg_empresa = bfac_header.cdg_empresa
                       AND Sub_header_inv.tip_comprob = bfac_header.tip_comprob
                       AND Sub_header_inv.prf_comprob = bfac_header.prf_comprob
                       AND Sub_header_inv.nro_comprob = bfac_header.nro_comprob
                           EXCLUSIVE-LOCK:

                     DELETE Sub_header_inv.

                 END.    

                 FOR EACH Sub_detalle_inv
                     WHERE Sub_detalle_inv.cdg_empresa = bfac_header.cdg_empresa
                       AND Sub_detalle_inv.tip_comprob = bfac_header.tip_comprob
                       AND Sub_detalle_inv.prf_comprob = bfac_header.prf_comprob
                       AND Sub_detalle_inv.nro_comprob = bfac_header.nro_comprob
                           EXCLUSIVE-LOCK:

                     DELETE Sub_detalle_inv.

                 END.    
                 FOR EACH Cta_cte
                       WHERE Cta_cte.cdg_empresa = bfac_header.cdg_empresa
                         AND Cta_cte.tip_comprob = bfac_header.tip_comprob
                         AND Cta_cte.prf_comprob = bfac_header.prf_comprob
                         AND Cta_cte.nro_comprob = bfac_header.nro_comprob
                             EXCLUSIVE-LOCK:

                     DELETE Cta_cte.

                 END. 

                 FOR EACH cct_stock 
                       WHERE cct_stock.cdg_empresa = bfac_header.cdg_empresa
                         AND cct_stock.tip_comprob = bfac_header.tip_comprob 
                         AND cct_stock.prf_comprob = bfac_header.prf_comprob 
                         AND cct_stock.nro_comprob = bFac_header.nro_comprob
                             EXCLUSIVE-LOCK:

                       DELETE Cct_stock.

                 END.
                 bfac_header.prf_comprob = 8888.



  


        v-vie_nro_comprob = bfac_header.nro_comprob + 1.
        v-vie_nro_comprob-2 = ultimo.
        v-nue_nro_comprob = bfac_header.nro_comprob.
        ultimo = ultimo - 1.

    

            DO k = 0 TO  v-vie_nro_comprob-2 - v-vie_nro_comprob :

            FIND Fac_header WHERE Fac_header.cdg_empresa = Empresa.cdg_empresa
                                  AND Fac_header.tip_comprob = v-vie_tip_comprob 
                                  AND Fac_header.prf_comprob = v-vie_prf_comprob
                                  AND Fac_header.nro_comprob = v-vie_nro_comprob + k
                                      EXCLUSIVE-LOCK.
                 IF fac_header.nro_contrato <> 0  THEN DO:
                     FIND contrato_hd WHERE contrato_hd.nro_contrato = fac_header.nro_contrato no-error.
                     IF AVAILABLE contrato_hd THEN DO:
                         IF contrato_hd.cant_periodos <> 0 THEN
                             contrato_hd.resto_periodos = contrato_hd.resto_periodos + 1.
                     END.
                 END.
                ASSIGN Fac_header.tip_comprob = v-nue_tip_comprob 
                       Fac_header.prf_comprob = v-nue_prf_comprob
                       Fac_header.nro_comprob = v-nue_nro_comprob + k.
                IF fac_header.tip_comprob BEGINS "F" OR fac_header.tip_comprob BEGINS "C" THEN do:
                    FIND aplicacion_pagos WHERE 
                        aplicacion_pagos.tip_cancela = fac_header.tip_comprob AND
                        aplicacion_pagos.prf_cancela = fac_header.prf_comprob AND
                        aplicacion_pagos.nro_cancela = fac_header.nro_comprob NO-ERROR.
                    IF AVAILABLE aplicacion_pagos  THEN DO:
                        aplicacion_pagos.nro_cancela = aplicacion_pagos.nro_comprob + k.
                    END.
                end.
                IF fac_header.tip_comprob BEGINS "C" THEN do:
                    FIND aplicacion_pagos WHERE 
                        aplicacion_pagos.tip_comprob = fac_header.tip_comprob AND
                        aplicacion_pagos.prf_comprob = fac_header.prf_comprob AND
                        aplicacion_pagos.nro_comprob = fac_header.nro_comprob NO-ERROR.
                    IF AVAILABLE aplicacion_pagos  THEN DO:
                        aplicacion_pagos.nro_comprob = aplicacion_pagos.nro_comprob + k.
                    END.
                end.        

                FOR EACH Sub_header_vta WHERE Sub_header_vta.cdg_empresa = Empresa.cdg_empresa
                                          AND Sub_header_vta.tip_comprob = v-vie_tip_comprob 
                                          AND Sub_header_vta.prf_comprob = v-vie_prf_comprob
                                          AND Sub_header_vta.nro_comprob = v-vie_nro_comprob + k
                                              EXCLUSIVE-LOCK:
                 
                    ASSIGN Sub_header_vta.tip_comprob = v-nue_tip_comprob 
                           Sub_header_vta.prf_comprob = v-nue_prf_comprob
                           Sub_header_vta.nro_comprob = v-nue_nro_comprob + k .
                END.

                FOR EACH Sub_detalle_vta WHERE Sub_detalle_vta.cdg_empresa = Empresa.cdg_empresa
                                          AND Sub_detalle_vta.tip_comprob = v-vie_tip_comprob 
                                          AND Sub_detalle_vta.prf_comprob = v-vie_prf_comprob
                                          AND Sub_detalle_vta.nro_comprob = v-vie_nro_comprob + k
                                              EXCLUSIVE-LOCK:

                    ASSIGN Sub_detalle_vta.tip_comprob = v-nue_tip_comprob 
                           Sub_detalle_vta.prf_comprob = v-nue_prf_comprob
                           Sub_detalle_vta.nro_comprob = v-nue_nro_comprob + k .

                END.

                FOR EACH Cta_cte WHERE Cta_cte.cdg_empresa = Empresa.cdg_empresa
                                   AND Cta_cte.tip_comprob = v-vie_tip_comprob 
                                   AND Cta_cte.prf_comprob = v-vie_prf_comprob
                                   AND Cta_cte.nro_comprob = v-vie_nro_comprob + k
                                              EXCLUSIVE-LOCK:

                    ASSIGN Cta_cte.tip_comprob = v-nue_tip_comprob 
                           Cta_cte.prf_comprob = v-nue_prf_comprob
                           Cta_cte.nro_comprob = v-nue_nro_comprob + k.

                END.

                FOR EACH Rec_detalle WHERE Rec_detalle.cdg_emprecancela = Empresa.cdg_empresa
                                       AND Rec_detalle.tip_cancela = v-vie_tip_comprob
                                       AND Rec_detalle.prf_cancela = v-vie_prf_comprob
                                       AND Rec_detalle.nro_cancela = v-vie_nro_comprob + k
                                              EXCLUSIVE-LOCK:

                    ASSIGN Rec_detalle.tip_cancela = v-nue_tip_comprob 
                           Rec_detalle.prf_cancela = v-nue_prf_comprob
                           Rec_detalle.nro_cancela = v-nue_nro_comprob + k .

                END.

                FOR EACH Cct_stock WHERE Cct_stock.cdg_empresa = Empresa.cdg_empresa
                                     AND Cct_stock.tip_comprob = v-vie_tip_comprob 
                                     AND Cct_stock.prf_comprob = v-vie_prf_comprob
                                     AND Cct_stock.nro_comprob = v-vie_nro_comprob + k
                                              EXCLUSIVE-LOCK:

                    ASSIGN Cct_stock.tip_comprob = v-nue_tip_comprob 
                           Cct_stock.prf_comprob = v-nue_prf_comprob
                           Cct_stock.nro_comprob = v-nue_nro_comprob + k.

                END. 
            END.

        END.
      /*      RUN setparametro.p ( prefcndor,"",0,false,ultnro - 1).*/
            MESSAGE "La Proxima NUEVA factura a imprimirse sera " ultnro SKIP
                    "sino es asi verifique el parametro "  prefcndor VIEW-AS ALERT-BOX INFORMATION. 
        
      FOR EACH fac_header WHERE fac_header.prf_comprob = 8888:
          DELETE fac_header.
      END.
    






  
