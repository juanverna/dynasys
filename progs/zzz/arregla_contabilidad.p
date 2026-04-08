DEFINE BUFFER Original FOR Asn_detalle.
/*
FOR EACH Asn_detalle WHERE nro_moneda <> 1:
    Asn_detalle.nro_moneda = 1.
    Asn_detalle.cambio = 1.
END.
*/
FOR EACH Asn_detalle WHERE (credito = ? OR debito = ?) AND reexpresion:

    FIND original WHERE Original.nro_asiento = Asn_detalle.nro_asiento
                    AND Original.nro_linea   = Asn_detalle.nro_linea  
                    AND Original.nro_moneda  = Asn_detalle.nro_moneda 
                    AND Original.reexpresion = NO.

    ASSIGN Asn_detalle.debito = Original.debito
           Asn_detalle.credito = Original.credito
           Asn_detalle.cambio = 1
           Original.cambio = 1.
END.

