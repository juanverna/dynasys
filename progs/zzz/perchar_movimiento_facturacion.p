     FOR EACH Fac_header 
        WHERE Fac_header.cdg_empresa = "M"
          AND Fac_header.tip_comprob = "F"
          AND Fac_header.prf_comprob = 771
          AND Fac_header.nro_comprob >= 1
          AND Fac_header.nro_comprob <= 1:
    
          FOR EACH Fac_detalle OF Fac_header:
              DELETE Fac_detalle.
          END.
         
          FOR EACH Sub_header_vta
              WHERE Sub_header_vta.cdg_empresa = Fac_header.cdg_empresa
                AND Sub_header_vta.tip_comprob = Fac_header.tip_comprob
                AND Sub_header_vta.prf_comprob = Fac_header.prf_comprob
                AND Sub_header_vta.nro_comprob = Fac_header.nro_comprob:
             
              DELETE Sub_header_vta.
             
          END.    
     
          FOR EACH Sub_detalle_vta
              WHERE Sub_detalle_vta.cdg_empresa = Fac_header.cdg_empresa
                AND Sub_detalle_vta.tip_comprob = Fac_header.tip_comprob
                AND Sub_detalle_vta.prf_comprob = Fac_header.prf_comprob
                AND Sub_detalle_vta.nro_comprob = Fac_header.nro_comprob:
              
              DELETE Sub_detalle_vta.
             
          END.    
     
          FOR EACH Cta_cte
                WHERE Cta_cte.cdg_empresa = Fac_header.cdg_empresa
                  AND Cta_cte.tip_comprob = Fac_header.tip_comprob
                  AND Cta_cte.prf_comprob = Fac_header.prf_comprob
                  AND Cta_cte.nro_comprob = Fac_header.nro_comprob:
            
              DELETE Cta_cte.
            
          END.    

          DELETE Fac_header.
     
     END.      

