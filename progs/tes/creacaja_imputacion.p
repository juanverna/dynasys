FOR EACH Boleta_deposito_hd, cuenta_bancaria OF boleta_deposito_hd:
    FIND caj_header WHERE caj_header.tip_comprob = "DP" AND nro_boletadep = caj_header.nro_comprob.
    FOR EACH caj_detalle OF caj_header:
        CREATE caja-imputacion.
        ASSIGN  Caja-imputacion.nro_cuenta = Cuenta_bancaria.nro_cuenta_acredita
                Caja-imputacion.nro_entidad = 0
                Caja-imputacion.nro_obra = 0
                Caja-imputacion.nro_transaccion = caj_header.nro_transaccion
                Caja-imputacion.observacion = ""
                Caja-imputacion.valor =    caj_detalle.importe.
    END.
END.
