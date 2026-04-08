DEFINE VARIABLE aa AS CHARACTER.
DEFINE VARIABLE t AS DECIMAL.
DEFINE VARIABLE c AS DECIMAL.
DEFINE VARIABLE sino-msg AS LOGICAL.
sino-msg = YES.
t=0.
c=0.
    
aa="FA,FB".

/* Para cambiar la empresa remplaza la F con la empresa que quieras */

FOR EACH fac_header WHERE CAN-DO (aa, fac_header.tip_comprob) 
                          AND fac_header.cdg_empresa = "F"
                          AND fac_header.anulado = NO:
            FOR EACH cta_cte WHERE
                            cta_cte.cdg_empresa = fac_header.cdg_empresa
                            AND cta_cte.tip_comprob=fac_header.tip_comprob
                            AND cta_cte.prf_comprob=fac_header.prf_comprob
                            AND cta_cte.nro_comprob=fac_header.nro_comprob:
                            t= t + cta_cte.debito.
            END.

    IF Fac_header.imp_total <> t THEN DO:
    FIND cliente OF fac_header.
        MESSAGE "Cliente Codigo: " cliente.cdg_cliente VIEW-AS ALERT-BOX.
        MESSAGE "FACTURA:" fac_header.tip_comprob Fac_header.prf_comprob Fac_header.nro_comprob "con importe total: " Fac_header.imp_total "suma debitos = " t VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
            IF sino-msg THEN
              t = 0.
            ELSE QUIT.
    END.
    ELSE t = 0.
END.
 


















