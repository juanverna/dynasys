FOR EACH Cta_cte:
    Cta_cte.clausula_dolar = NO.
    CASE SUBSTRING(Cta_cte.tip_comprob,1,1):
        WHEN "F" THEN Cta_cte.cdg_comprobante = "FACTUCLI".
        WHEN "D" THEN Cta_cte.cdg_comprobante = "DEBITCLI".
        WHEN "C" THEN Cta_cte.cdg_comprobante = "CREDICLI".
        WHEN "R" THEN Cta_cte.cdg_comprobante = "RECIBCLI".
        OTHERWISE
            MESSAGE "EN EL HORNO" Cta_cte.tip_comprob
                VIEW-AS ALERT-BOX INFO BUTTONS OK.
    END CASE.
END.

FOR EACH Cliente WHERE Cliente.clausula_dolar:
    FOR EACH Cta_cte OF Cliente WHERE Cta_cte.cambio <> 1, 
        FIRST Moneda OF Cta_cte WHERE Moneda.es_local:
        Cta_cte.clausula_dolar = YES.

    END.
END.
