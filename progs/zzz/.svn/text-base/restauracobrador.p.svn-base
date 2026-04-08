FOR EACH Cobrador WHERE LOOKUP(Cobrador.cdg_cobrador,"013,014,024,025") <> 0:
    FOR EACH Rec_header OF Cobrador:
        FIND Cta_cte WHERE Cta_cte.cdg_empresa = Rec_header.cdg_empresa
                       AND Cta_cte.tip_comprob = Rec_header.tip_comprob
                       AND Cta_cte.prf_comprob = Rec_header.prf_comprob
                       AND Cta_cte.nro_comprob = Rec_header.nro_comprob
                           EXCLUSIVE-LOCK NO-ERROR.
        IF AVAILABLE Cta_cte THEN Cta_cte.nro_cobrador = Rec_header.nro_cobrador.
    END.
END.
