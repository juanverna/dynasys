FOR EACH Asn_header WHERE Asn_header.cdg_sigla-sic = "FAC" AND Asn_header.fecha >= 08/01/2005:
    FOR EACH Asn_detalle OF Asn_header:
        DELETE Asn_detalle.
    END.
    
    FOR EACH Asn_totales  OF Asn_header:
        DELETE Asn_totales.
    END.
    DELETE Asn_header.
END.


