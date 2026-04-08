DEFINE VAR v-cli AS INT NO-UNDO.
DEFINE VAR v-mon AS INT NO-UNDO.
DEFINE VAR v-cla AS LOG NO-UNDO.

FOR EACH Cta_cte:
    ASSIGN Cta_cte.clausula_dolar = NO
           Cta_cte.cambio_dolar = 1.
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
FOR EACH cliente:
    ASSIGN cliente.clausula_dolar = NO.
END.

INPUT FROM "C:\desa\dynasys\r3.5.2\db\clientes2.dd.txt".

REPEAT :
    IMPORT DELIMITER "," v-cli v-mon v-cla.
    FIND Cliente WHERE Cliente.cdg_cliente = TRIM(STRING(v-cli)).
    ASSIGN Cliente.clausula_dolar = v-cla
           Cliente.dfl_lista = v-mon.
    FOR EACH cta_cte OF cliente, FIRST moneda OF cta_cte WHERE moneda.es_local:
            ASSIGN cta_cte.clausula_dolar = Cliente.clausula_dolar.
            IF cta_cte.clausula_dolar
                THEN cta_cte.cambio_dolar = cta_cte.cambio.
    END.
    
END.

 
