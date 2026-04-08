FOR EACH cuenta-moneda:
    DELETE cuenta-moneda.
END.

FOR EACH moneda:

    FOR EACH cuenta:
        CREATE cuenta-moneda.
        ASSIGN cuenta-moneda.nro_cuenta = cuenta.nro_cuenta
               cuenta-moneda.nro_moneda = moneda.nro_moneda
               cuenta-moneda.admite_movimientos = YES
               cuenta-moneda.reexpresa_saldos = YES.
    END.
END.

