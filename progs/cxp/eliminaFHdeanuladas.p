    {findempresa.i}
        {vrshared.i NEW}
        DEFINE VAR rok AS INTEGER.
    FOR EACH rendicion_hd WHERE Rendicion_hd.st_tesoreria = "A":
    FIND fac_header_prv WHERE fac_header_prv.tip_comprob = "FH" AND fac_header_prv.cdg_empresa = empresa.cdg_empresa 
        AND fac_header_prv.nro_comprob = rendicion_hd.nro_rendicion NO-ERROR.
    IF AVAILABLE fac_header_prv THEN do:
        DISPLAY fac_header_prv.nro_comprob fac_header_prv.estado.
        RUN anular_comprobante_proveedor.p (INPUT ROWID(Fac_header_prv), OUTPUT rok).
        DISPLAY rok rendicion_hd.nro_rendicion.
    END.
    END.
