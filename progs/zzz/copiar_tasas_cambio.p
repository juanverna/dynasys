FOR EACH Fac_header, FIRST Moneda OF Fac_header WHERE Moneda.cdg_moneda = "DO":
    FIND LAST Cotizacion OF Moneda WHERE Cotizacion.cdg_empresa = Fac_header.cdg_empresa
                            AND Cotizacion.fch_cotizacion <= Fac_header.fecha NO-LOCK NO-ERROR.
    Fac_header.cambio = Cotizacion.cambio.

END.

FOR EACH Sub_header_vta, FIRST Moneda OF Sub_header_vta WHERE Moneda.cdg_moneda = "DO":
    FIND LAST Cotizacion OF Moneda WHERE Cotizacion.cdg_empresa = Sub_header_vta.cdg_empresa
                            AND Cotizacion.fch_cotizacion <= Sub_header_vta.fecha NO-LOCK NO-ERROR.
    Sub_header_vta.cambio = Cotizacion.cambio.

END.

FOR EACH Cta_cte, FIRST Moneda OF Cta_cte WHERE Moneda.cdg_moneda = "DO":
    FIND LAST Cotizacion OF Moneda WHERE Cotizacion.cdg_empresa = Cta_cte.cdg_empresa
                            AND Cotizacion.fch_cotizacion <= Cta_cte.fecha_emision NO-LOCK NO-ERROR.
    Cta_cte.cambio = Cotizacion.cambio.

END.
