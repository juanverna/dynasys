FOR EACH Asn_totales:
    DELETE Asn_totales.
END.
    
FOR EACH Asn_header:
    FOR EACH Asn_detalle OF Asn_header:
        
        FIND FIRST Asn_totales OF Asn_header 
            WHERE Asn_totales.nro_moneda = Asn_detalle.nro_moneda
              AND Asn_totales.reexpresion = Asn_detalle.reexpresion
                  NO-ERROR.
        IF NOT AVAILABLE Asn_totales
        THEN DO:
             CREATE Asn_totales.
             ASSIGN Asn_totales.nro_asiento = Asn_detalle.nro_asiento
                    Asn_totales.reexpresion = Asn_detalle.reexpresion
                    Asn_totales.nro_moneda  = Asn_detalle.nro_moneda.
        END.
    
        Asn_totales.tot_debitos  = Asn_totales.tot_debitos  + Asn_detalle.debito.
        Asn_totales.tot_creditos = Asn_totales.tot_creditos + Asn_detalle.credito.
        Asn_totales.diferencia = Asn_totales.tot_debitos - Asn_totales.tot_creditos.
    
    END.       
END.




