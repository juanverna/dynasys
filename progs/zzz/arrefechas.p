
FOR EACH Fac_header 
   WHERE Fac_header.cdg_empresa = "A"
     AND Fac_header.tip_comprob = "FB" 
     AND Fac_header.nro_comprob <= 5914 
     AND Fac_header.nro_comprob >= 5912:

   Fac_header.fecha = DATE("03/10/2000").

   FIND Cta_cte 
        WHERE Cta_cte.cdg_empresa = Fac_header.cdg_empresa
          AND Cta_cte.tip_comprob = Fac_header.tip_comprob
          AND Cta_cte.prf_comprob = Fac_header.prf_comprob
          AND Cta_cte.nro_comprob = Fac_header.nro_comprob
          AND Cta_cte.nro_vencimiento = 1.

   Cta_cte.fecha_emision = Fac_header.fecha.

   FIND Sub_header_vta 
        WHERE Sub_header_vta.cdg_empresa = Fac_header.cdg_empresa
          AND Sub_header_vta.tip_comprob = Fac_header.tip_comprob
          AND Sub_header_vta.prf_comprob = Fac_header.prf_comprob
          AND Sub_header_vta.nro_comprob = Fac_header.nro_comprob.

   Sub_header_vta.fecha = Fac_header.fecha.
   
   display fac_header.imp_total fac_header.imp_neto.
