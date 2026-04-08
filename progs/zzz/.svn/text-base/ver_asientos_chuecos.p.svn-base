DEF VAR tc AS DECIMAL.
DEF VAR td AS DECIMAL.

/*OUTPUT TO "c:\sic-temp\nobalancean.txt".*/

FOR EACH asn_header:
    tc = 0.
    td = 0.
    FOR EACH asn_detalle OF asn_header:
        tc = tc + asn_detalle.debito.
        td = td + asn_detalle.credito.
    END.
    IF tc <> td  THEN DISPLAY asn_header.nro_comprob.
END.
