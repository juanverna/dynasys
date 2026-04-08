
DEFINE VARIABLE que_cambio    LIKE   Fac_header.cambio.
DEFINE VARIABLE v-nro_comprob LIKE   Fac_header.nro_comprob.
DEFINE VARIABLE v-prf_comprob LIKE   Fac_header.prf_comprob.
DEFINE VARIABLE v-tip_comprob LIKE   Fac_header.tip_comprob.

UPDATE v-tip_comprob v-prf_comprob.
SESSION:NUMERIC-FORMAT = "AMERICAN".
REPEAT :

    UPDATE v-nro_comprob que_cambio.

    FOR EACH Fac_header 
        WHERE Fac_header.nro_comprob = v-nro_comprob
          AND Fac_header.prf_comprob = v-prf_comprob
          AND Fac_header.tip_comprob = v-tip_comprob
          AND Fac_header.cdg_empresa = "B":

        ASSIGN Fac_header.cambio = que_cambio.

    END.

    FOR EACH Sub_header_vta 
        WHERE Sub_header_vta.nro_comprob = v-nro_comprob
          AND Sub_header_vta.prf_comprob = v-prf_comprob
          AND Sub_header_vta.tip_comprob = v-tip_comprob
          AND Sub_header_vta.cdg_empresa = "B":

        ASSIGN Sub_header_vta.cambio = que_cambio.


    END.

    FOR EACH Cta_cte 
        WHERE Cta_cte.nro_comprob = v-nro_comprob
          AND Cta_cte.prf_comprob = v-prf_comprob
          AND Cta_cte.tip_comprob = v-tip_comprob
          AND Cta_cte.cdg_empresa = "B":

        ASSIGN Cta_cte.cambio = que_cambio.

    END.

END.
