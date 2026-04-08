DEFINE VAR d AS DATE.
DEFINE VAR h AS DATE.
UPDATE d  h.
OUTPUT TO c:\temp\pedafip2.csv.

FOR EACH fac_header WHERE fac_header.prf_comprob = 3 AND fac_header.fecha >= d AND fac_header.fecha <= h:
    FIND tipocomprobanteAFIP WHERE tipocomprobanteAFIP.tip_comprob = fac_header.tip_comprob NO-LOCK.
    EXPORT DELIMITER ";" 
        YEAR( fac_header.fecha ) *  10000 + MONTH( fac_header.fecha) * 100 + DAY( fac_header.fecha )
        string(tipocomprobanteafip.cdg_afip, "0XX")
        STRING(prf_comprob,"99999")
        STRING(nro_comprob,"99999999")
        string(imp_neto,">>>>>>>>>>9.99")
        string(imp_iva , ">>>>>>>>>>9.99")
        string(imp_total,">>>>>>>>>>9.99").
END.
 OUTPUT CLOSE.
