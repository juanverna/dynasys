DEFINE VAR d AS DATE.
DEFINE VAR h AS DATE.
UPDATE d  h.
OUTPUT TO c:\temp\pedafip.csv.

FOR EACH fac_header WHERE fac_header.prf_comprob = 3 AND fac_header.fecha >= d AND fac_header.fecha <= h:
    FIND tipocomprobanteAFIP WHERE tipocomprobanteAFIP.tip_comprob = fac_header.tip_comprob NO-LOCK.
    put UNFORMATTED 
        YEAR( fac_header.fecha ) 
        MONTH( fac_header.fecha) 
        DAY( fac_header.fecha )
        string(tipocomprobanteafip.cdg_afip, "0XX")
        STRING(prf_comprob,"99999")
        STRING(nro_comprob,"99999999")
        STRING(truncate( imp_neto * 100 , 0),"999999999999999")
        STRING(truncate( imp_iva * 100 ,0),"999999999999999")
        STRING(truncate( imp_total * 100 ,0),"999999999999999")  SKIP.
END.
 OUTPUT CLOSE.
