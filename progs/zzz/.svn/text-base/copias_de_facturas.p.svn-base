DEFINE TEMP-TABLE T-Copia
    FIELD cdg_empresa LIKE Fac_header.cdg_empresa
    FIELD nro_comprob LIKE Fac_header.nro_comprob
    FIELD prf_comprob LIKE Fac_header.prf_comprob
    FIELD tip_comprob LIKE Fac_header.tip_comprob
    FIELD num_copia   AS INTEGER
    INDEX por_facturas IS UNIQUE cdg_empresa tip_comprob prf_comprob nro_comprob num_copia.

DEF VAR j AS INT.

FOR EACH fac_header WHERE cdg_empresa = "F" AND tip_comprob = "FA" AND prf_comprob = 2 AND nro_comprob >= 12112 AND nro_comprob <= 12189:
    DO j = 1 TO 2:
        CREATE T-Copia.
        BUFFER-COPY Fac_header TO T-Copia ASSIGN T-Copia.num_copia = j.
    END.
END.


FOR EACH fac_header WHERE cdg_empresa = "F" AND tip_comprob = "FB" AND prf_comprob = 2 AND nro_comprob >= 21989 AND nro_comprob <= 22074:
    DO j = 1 TO 2:
        CREATE T-Copia.
        BUFFER-COPY Fac_header TO T-Copia ASSIGN T-Copia.num_copia = j.
    END.
END.

FOR EACH t-copia, FIRST Fac_header OF T-Copia:

    DISPLAY num_copia 
        cdg_empresa
        nro_comprob
        prf_comprob
        tip_comprob
        WITH STREAM-IO.
END.
