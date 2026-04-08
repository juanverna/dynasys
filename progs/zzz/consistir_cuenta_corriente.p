DEFINE VARIABLE v-total AS DECIMAL.
DEFINE VARIABLE v-regs  AS INTEGER.
DEFINE VARIABLE v-mismo AS LOGICAL.

DEFINE TEMP-TABLE T-Fac_header NO-UNDO LIKE Fac_header.

OUTPUT TO "c:\sic-temp\nocoincidecc.txt".

FOR EACH Fac_header WHERE NOT Fac_header.anulado:

    v-total = 0.
    v-regs  = 0.

    FIND Tipocomprobante OF Fac_header.
    FOR EACH Cta_cte WHERE Cta_cte.cdg_empresa = Fac_header.cdg_empresa
                       AND Cta_cte.tip_comprob = Fac_header.tip_comprob
                       AND Cta_cte.prf_comprob = Fac_header.prf_comprob
                       AND Cta_cte.nro_comprob = Fac_header.nro_comprob
                       AND Cta_cte.nro_vencimiento <> 0:

        v-mismo = Fac_header.nro_cliente = Cta_cte.nro_cliente.

        v-regs = v-regs + 1.

        IF Tipocomprobante.debita 
        THEN DO:
            v-total = v-total + Cta_cte.debito.
        END.
        ELSE DO:
            v-total = v-total + Cta_cte.credito.
        END.

    END.

    IF Fac_header.imp_total <> v-total
    THEN DO:
        CREATE T-Fac_header.
        BUFFER-COPY Fac_header TO T-Fac_header.
    END.

END.

FOR EACH T-Fac_header:

    FOR EACH Cta_cte WHERE Cta_cte.cdg_empresa = T-Fac_header.cdg_empresa
                       AND Cta_cte.tip_comprob = T-Fac_header.tip_comprob
                       AND Cta_cte.prf_comprob = T-Fac_header.prf_comprob
                       AND Cta_cte.nro_comprob = T-Fac_header.nro_comprob:
        /*
        DISPLAY Cta_cte EXCEPT cod_diaria imputado liberada selectado usuario-sel
                WITH STREAM-IO FRAME aa DOWN WIDTH 360.
        */

        DISPLAY  Cta_cte.cdg_empresa
                 Cta_cte.tip_comprob
                 Cta_cte.prf_comprob
                 Cta_cte.nro_comprob
                 Cta_cte.debito
                 Cta_cte.credito
                 T-Fac_header.imp_total
                  WITH STREAM-IO FRAME aa DOWN WIDTH 360.

        DOWN WITH FRAME aa.


    END.

END.
