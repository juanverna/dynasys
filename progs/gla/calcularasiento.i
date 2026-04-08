FOR EACH {1}Asn_totales:
    DELETE {1}Asn_totales.
END.
    
FOR EACH {1}Asn_detalle OF {1}Asn_header:
    
    FIND {1}Asn_totales WHERE {1}Asn_totales.nro_moneda = {1}Asn_detalle.nro_moneda NO-ERROR.
    IF NOT AVAILABLE {1}Asn_totales
    THEN DO:
         CREATE {1}Asn_totales.
         ASSIGN {1}Asn_totales.nro_moneda = {1}Asn_detalle.nro_moneda.
    END.

    {1}Asn_totales.tot_debitos  = {1}Asn_totales.tot_debitos  + {1}Asn_detalle.debito.
    {1}Asn_totales.tot_creditos = {1}Asn_totales.tot_creditos + {1}Asn_detalle.credito.


END.       

FOR EACH {1}Asn_totales:
    {1}Asn_totales.diferencia = {1}Asn_totales.tot_debitos - {1}Asn_totales.tot_creditos.
END.

