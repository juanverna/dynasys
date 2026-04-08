FOR EACH caj_header WHERE cambio = 0:
    DISPLAY tip_comprob prf_comprob nro_comprob cdg_caja 
        caj_header.fecha
        WITH STREAM-IO.
    IF Caj_header.contable
    THEN DO:
        FIND asn_header 
                WHERE tabla_comprobante = "Caj_header" AND  nro_idcabecera = caj_header.nro_transaccion. 
        FOR EACH asn_detalle OF asn_header:
            DELETE asn_detalle.
        END.
        FOR EACH asn_totales OF asn_header:
            DELETE asn_totales.
        END.
        DELETE asn_header.
    END.
    ASSIGN Caj_header.contable = NO
           Caj_header.cambio = 1.
END.
