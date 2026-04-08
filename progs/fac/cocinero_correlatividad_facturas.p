DEFINE VAR a AS INT.
DEFINE VAR k AS INT.
DEFINE VAR d AS DATE.
FOR EACH fac_header WHERE substring(
    fac_header.tip_comprob,2,1) = "B" AND fac_header.prf_comprob = 1 AND ( fac_header.fecha >= 06/01/2013 AND fac_header.fecha <= 08/30/2013 ) NO-LOCK BY nro_comprob :
    IF tip_comprob <> "FB" AND tip_comprob <> "CB" THEN
        DISPLAY tip_comprob nro_comprob.
    
    k = k + 1.
    IF a = 0 THEN DO:
        a = nro_comprob.
        d = fac_header.fecha.
        NEXT.
    END.
    IF a + 1 <> nro_comprob OR fecha < d THEN DO:
        display  tip_comprob nro_comprob fecha a d .
        a = nro_comprob.
        d = fac_header.fecha.
    END.
    ELSE do: a = a + 1.
             d = fecha.
    END.
END.
DISPLAY k.
/*
FIND fac_header WHERE nro_comprob = 152642.
fac_header.fecha = 08/27/2013.
RUN regenerar_subdiario_ventas.p( ROWID(fac_header)).
*/
