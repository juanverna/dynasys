FIND rubro WHERE rubro.cdg_rubro = 100 NO-LOCK.
DEFINE BUFFER cc FOR caj_header.


FOR EACH cc WHERE cc.nro_comprob >= 89909:
    FIND FIRST rendicion_hd OF cc.
    if Rendicion_hd.st_tesoreria = "A" THEN NEXT.
    FIND FIRST caj_detalle Of cc WHERE rubro.cdg_rubro = caj_detalle.cdg_rubro NO-LOCK NO-ERROR.
        IF AVAILABLE caj_detalle THEN DO:
            FIND FIRST fac_header_prv WHERE Fac_header_prv.nro_comprob = rendicion_hd.nro_rendicion AND
                fac_header_prv.tip_comprob = "FH" NO-ERROR.
            IF NOT AVAILABLE fac_header_prv THEN DO:
                RUN pgenerahatprov.p ( cc.nro_transaccion ).
            DISPLAY cc.nro_comprob.
            END. 
        END.
END.





