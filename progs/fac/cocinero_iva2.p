    FIND articulo WHERE cdg_articulo = "01" NO-LOCK.
    FOR EACH fac_header WHERE fecha >= 12/01/2016:
    FOR EACH fac_detalle OF fac_header WHERE
        fac_detalle.nro_articulo = articulo.nro_articulo.
        IF precio_cf <> TRUNCATE(precio * 1.21,2)   THEN
        DO:
            ASSIGN
            Fac_detalle.subtotal_bruto_cf = TRUNCATE(precio * 1.21,2)
            Fac_detalle.subtotal_gral_cf = TRUNCATE(precio * 1.21,2)
            Fac_detalle.subtotal_neto_cf = TRUNCATE(precio * 1.21,2)
            precio_cf = TRUNCATE(precio * 1.21,2).
        END.
    END.
END.
