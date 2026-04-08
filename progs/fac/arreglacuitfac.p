/*arregla cuits*/
DEFINE VAR prf AS INT FORMAT "9999" INITIAL 3.
    DEFINE VAR tip AS CHAR FORMAT "XX" INITIAL "FB".
    DEFINE VAR nro AS INT FORMAT "99999999".
    REPEAT :
        UPDATE tip prf nro.
        FIND fac_header WHERE tip_comprob = tip AND prf_comprob = prf AND nro_comprob = nro NO-ERROR.
        IF AVAILABLE fac_header THEN DO:
            UPDATE cuit.
            fac_header.cod_docu = "CUIT".
        END.
    END.
