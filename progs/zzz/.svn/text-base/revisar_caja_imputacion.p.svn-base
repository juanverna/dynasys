FOR EACH caja-imputacion WHERE NOT CAN-FIND(cuenta OF caja-imputacion):
    FIND caj_header WHERE caj_header.nro_transaccion = caja-imputacion.nro_transaccion
        NO-ERROR.
    IF AVAILABLE caj_header
        THEN DISPLAY tip_comprob prf_comprob nro_comprob anulado WITH STREAM-IO.
        ELSE DELETE caja-imputacion.
END.
