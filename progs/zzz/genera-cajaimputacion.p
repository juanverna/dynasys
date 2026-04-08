for each caj_header where not can-find(FIRST Caja-imputacion WHERE Caja-imputacion.nro_transaccion = Caj_header.nro_transaccion):

    CREATE Caja-imputacion.
    ASSIGN Caja-imputacion.nro_cuenta       = Caj_header.nro_cuenta
           Caja-imputacion.nro_entidad      = 0
           Caja-imputacion.nro_obra         = 0
           Caja-imputacion.nro_transaccion  = Caj_header.nro_transaccion
           Caja-imputacion.observacion      = Caj_header.observacion
           Caja-imputacion.valor            = Caj_header.importe.

end.
