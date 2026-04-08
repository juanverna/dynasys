FOR EACH caj_detalle, FIRST rubro OF caj_detalle WHERE NOT CAN-FIND(cuenta OF rubro):
    FIND caj_header WHERE caj_header.nro_transaccion = caj_detalle.nro_transaccion NO-ERROR.
    IF AVAILABLE caj_header
        THEN DISPLAY tip_comprob prf_comprob nro_comprob anulado rubro.cdg_rubro caj_header.fecha caj_detalle.importe
                     WITH STREAM-IO.
        ELSE DELETE caj_detalle.

    
END.
