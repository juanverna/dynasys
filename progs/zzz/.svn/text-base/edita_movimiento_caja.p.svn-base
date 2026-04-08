OUTPUT TO "c:\sic-temp\carlos2.txt".
FOR EACH caj_header WHERE caj_header.cdg_empresa = "R" AND Caj_header.fecha = 06/16/05
  AND caj_header.tip_comprob = "CJ":
    DISPLAY caj_header.nro_comprob caj_header.importe FORMAT "->>>>>>>>9.99" WITH TITLE "CAJ-HEADER" SIDE-LABELS.
    /*UPDATE caj_header.importe ingreso WITH SIDE-LABELS TITLE "CAJ-HEADER".*/
    
    FOR EACH caja-imputacion 
        WHERE caja-imputacion.nro_transaccion = caj_header.nro_transaccion:
        DISPLAY caja-imputacion.valor FORMAT "->>>>>>>>9.99".
        DISPLAY Caja-imputacion WITH SIDE-LABELS TITLE "CAJA-IMPUTACION".
    END.
    FOR EACH caj_detalle OF caj_header:
        DISPLAY caj_detalle.importe  FORMAT "->>>>>>>>9.99".
        DISPLAY caj_detalle WITH SIDE-LABELS TITLE "CAJ-DETALLE".
    END.
END.



