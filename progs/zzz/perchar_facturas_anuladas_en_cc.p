DEF VAR tt AS DECIMAL FORMAT ">>>>>>>9.99".
FOR EACH fac_header WHERE Fac_header.anulado 
    , EACH cta_cte 
                WHERE  Cta_cte.cdg_empresa = Fac_header.cdg_empresa 
                  AND  Cta_cte.tip_comprob = Fac_header.tip_comprob
                  AND  Cta_cte.prf_comprob = Fac_header.prf_comprob
                  AND  Cta_cte.nro_comprob = Fac_header.nro_comprob:
/*
    DISPLAY Fac_header.cdg_empresa
                 Fac_header.tip_comprob
                 Fac_header.prf_comprob
                 Fac_header.nro_comprob
                 Fac_header.anulado
                 cta_cte.credito = 0
        WITH STREAM-IO.
    tt = tt + cta_cte.debito.*/
    DELETE cta_cte.

END.

