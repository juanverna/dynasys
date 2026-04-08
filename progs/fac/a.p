    FIND articulo WHERE cdg_articulo = "01f".
    FOR EACH fac_header WHERE mes = 01 AND ano = 2017:
        FIND fac_detalle OF fac_header WHERE fac_detalle.nro_articulo = articulo.nro_articulo AND precio <> 50 NO-ERROR.
        IF AVAILABLE fac_detalle THEN DISPLAY nro_comprob direccion.

END.
