
    
        
FOR EACH cliente WHERE cdg_cliente = "10107":

    FOR EACH cta_cte OF cliente:
                                         
    DISPLAY cta_cte WITH 1 COL. 

        IF SUBSTRING(cta_cte.tip_comprob,1,1) <> "R" THEN DO:
          FIND fac_header 
              WHERE fac_header.nro_comprob = Cta_cte.nro_comprob 
                AND fac_header.prf_comprob = Cta_cte.prf_comprob 
                AND fac_header.tip_comprob = Cta_cte.tip_comprob 
                AND fac_header.cdg_empresa = Cta_cte.cdg_empresa NO-ERROR. 
          IF NOT AVAILABLE Fac_header THEN DO:
          MESSAGE "no encuentra fac " Cta_cte.tip_comprob Cta_cte.prf_comprob Cta_cte.nro_comprob Cta_cte.imp_total VIEW-AS ALERT-BOX.     
          END.
       END.

        IF SUBSTRING(cta_cte.tip_comprob,1,1) = "R" THEN DO:
            FIND Rem_header      
                WHERE Rem_header.nro_comprob = Cta_cte.nro_comprob 
                  AND Rem_header.prf_comprob = Cta_cte.prf_comprob 
                  AND Rem_header.tip_comprob = Cta_cte.tip_comprob 
                  AND Rem_header.cdg_empresa = Cta_cte.cdg_empresa NO-ERROR.
            IF NOT AVAILABLE Rem_header THEN DO:
            MESSAGE "no encuentra Rem " Cta_cte.tip_comprob Cta_cte.prf_comprob Cta_cte.nro_comprob Cta_cte.imp_total VIEW-AS ALERT-BOX. 
            END. 
        END.

    END.
END.
