    DEFINE BUFFER bcta FOR cta_cte.
    DEFINE BUFFER bfac FOR fac_header.
    FOR EACH cta_cte WHERE  cta_cte.tip_comprob = "RC":
        FIND bcta WHERE bcta.tip_comprob = "FC" AND bcta.nro_comprob = cta_cte.nro_comprob AND bcta.prf_comprob = cta_cte.prf_comprob NO-ERROR.
        IF NOT AVAILABLE bcta THEN 
        DO:
            FIND rec_header WHERE bcta.nro_comprob = rec_header.nro_comprob AND rec_header.prf_comprob = cta_cte.prf_comprob NO-ERROR.
            IF AVAILABLE rec_header THEN DELETE rec_header.
            DELETE cta_cte.
        END.
            
    END.
