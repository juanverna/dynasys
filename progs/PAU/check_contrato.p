    OUTPUT TO "clipboard".
    FOR EACH fac_header WHERE fecha > TODAY - 800 AND nro_contrato <> 0,
    contrato_hd OF fac_header WHERE  nro_tipo_evento = 3:
    IF nro_plazo <> 6 THEN DISPLAY contrato_hd.nro_contrato nro_plazo.
END.
