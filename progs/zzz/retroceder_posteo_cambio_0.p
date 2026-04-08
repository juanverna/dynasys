    FOR EACH Asn_header 
        WHERE Asn_header.tabla_comprobante = "Caj_header"
          AND Asn_header.cdg_empresa = "R", 
        FIRST Caj_header 
              WHERE caj_header.nro_transaccion = asn_header.nro_idcabecera
                AND caj_header.cambio = 0:

        DISPLAY caj_header.tip_comprob caj_header.nro_comprob caj_header.fecha
            WITH STREAM-IO.
        
        
        FOR EACH asn_detalle OF asn_header:
            DELETE asn_detalle.
        END.
        
        FOR EACH asn_totales OF asn_header:
            DELETE asn_totales.
        END.
        
        DELETE asn_header.

        Caj_header.contable = NO.
        caj_header.cambio = 1.
        
    
    END.

