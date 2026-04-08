    DEFINE VAR rr AS DECIMAL.
    FOR EACH fac_header WHERE imp_total = 0 AND NOT anulado:
        Rr = 0.
            FOR EACH fac_detalle OF fac_header:
                IF precio_cf = 0 THEN DO:
                    Rr = rr + fac_detalle.precio.
                    fac_detalle.precio_cf = fac_detalle.precio.
                END.
                ELSE DO:
                    Rr = rr + fac_detalle.precio_cf.
                END.
                END.

            fac_header.imp_bruto = rr.
                fac_header.imp_iva = 0.
                fac_header.imp_neto = rr.
                fac_header.imp_total = rr.
            END.
       
    












