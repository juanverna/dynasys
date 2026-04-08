DEFINE VAR pok AS LOGICAL NO-UNDO.

FOR EACH fac_header WHERE prf_comprob = 3 AND tip_comprob = "FB" AND cai = "" BY nro_comprob:

    
RUN facturaelectronica(ROWID(fac_header), OUTPUT pok ).
         IF NOT pok OR fac_header.cai = "" THEN DO:
             MESSAGE "Error " + fac_header.tip_comprob + "-" + string(fac_header.prf_comprob,"9999") + "-" + string(fac_header.nro_comprob,"99999999") + " " SKIP  RETURN-VALUE VIEW-AS ALERT-BOX ERROR.
             leave.
         END.
END.
