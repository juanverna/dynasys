
DEFINE BUFFER B-Fac_header FOR Fac_header.

FOR EACH B-Fac_header WHERE B-Fac_header.fecha >= TODAY:

     DISPLAY B-Fac_header.cdg_empresa  
             B-Fac_header.tip_comprob 
             B-Fac_header.prf_comprob 
             B-Fac_header.nro_comprob.

     FOR EACH Fac_header 
        WHERE Fac_header.cdg_empresa = B-Fac_header.cdg_empresa 
          AND Fac_header.tip_comprob = B-Fac_header.tip_comprob 
          AND Fac_header.prf_comprob = B-Fac_header.prf_comprob 
          AND Fac_header.nro_comprob = B-Fac_header.nro_comprob:
          
    
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
     


          FOR EACH Sub_header_inv
              WHERE Sub_header_inv.cdg_empresa = Fac_header.cdg_empresa
                AND Sub_header_inv.tip_comprob = Fac_header.tip_comprob
                AND Sub_header_inv.prf_comprob = Fac_header.prf_comprob
                AND Sub_header_inv.nro_comprob = Fac_header.nro_comprob:
             
              DELETE Sub_header_inv.
             
          END.    
     
          FOR EACH Sub_detalle_inv
              WHERE Sub_detalle_inv.cdg_empresa = Fac_header.cdg_empresa
                AND Sub_detalle_inv.tip_comprob = Fac_header.tip_comprob
                AND Sub_detalle_inv.prf_comprob = Fac_header.prf_comprob
                AND Sub_detalle_inv.nro_comprob = Fac_header.nro_comprob:
              
              DELETE Sub_detalle_inv.
             
          END.    
          FOR EACH Cta_cte
                WHERE Cta_cte.cdg_empresa = Fac_header.cdg_empresa
                  AND Cta_cte.tip_comprob = Fac_header.tip_comprob
                  AND Cta_cte.prf_comprob = Fac_header.prf_comprob
                  AND Cta_cte.nro_comprob = Fac_header.nro_comprob:
            
              DELETE Cta_cte.
            
          END. 

          FOR EACH cct_stock 
                WHERE cct_stock.cdg_empresa = Fac_header.cdg_empresa
                  AND cct_stock.tip_comprob = Fac_header.tip_comprob 
                  AND cct_stock.prf_comprob = Fac_header.prf_comprob 
                  AND cct_stock.nro_comprob = Fac_header.nro_comprob:
              
                DELETE cct_stock.
            
          END.

          DELETE Fac_header.
     
     END.      
     
     

END.
