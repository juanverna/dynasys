/*lee el archivo y aplica el aumento para que e el precio total
el archivo tiene 
nro_contrato,precio_total
Primero verifica que todo lo enviado este correcto y sino informa el error
*/
DEFINE VAR oblea AS INT.
DEFINE VAR archivo AS CHAR FORMAT "X(50)" INITIAL "c:\temp\au.csv".
DEFINE VAR nro LIKE contrato_hd.nro_contrato.
DEFINE VAR imp AS decimal.
DEFINE VAR tiene AS LOGICAL NO-UNDO.
FIND articulo WHERE articulo.cdg_articulo = "01f".
oblea = articulo.nro_articulo.
UPDATE archivo.
INPUT FROM value(archivo) NO-ECHO.
REPEAT:
    IMPORT DELIMITER ";" nro imp .
    if nro = 0 THEN NEXT.
    FIND contrato_hd WHERE contrato_hd.nro_contrato = nro NO-LOCK NO-ERROR.
    IF NOT AVAILABLE contrato_hd THEN DO:
        DISPLAY nro.
    END.
    FIND FIRST contrato_dt OF contrato_hd WHERE contrato_dt.nro_articulo <> oblea NO-ERROR.
    IF NOT AVAILABLE contrato_dt THEN MESSAGE contrato_hd.nro_contrato.
END.
INPUT CLOSE.
PAUSE.
INPUT FROM value(archivo) NO-ECHO.
REPEAT:
    IMPORT DELIMITER ";" nro imp .
    if nro = 0 THEN NEXT.
    FIND contrato_hd WHERE contrato_hd.nro_contrato = nro NO-ERROR.
    IF NOT AVAILABLE contrato_hd THEN DO:
        DISPLAY nro.
    END.
    tiene = FALSE.
    FIND FIRST  contrato_dt OF contrato_hd WHERE contrato_dt.nro_articulo = oblea NO-ERROR.
    IF AVAILABLE contrato_dt THEN DO: 
    
        IF contrato_hd.prf_contrato = 3 THEN DO:
                contrato_dt.precio_cf = 100.
                contrato_dt.precio =  round( contrato_dt.precio_cf /  1.2100 , 2 ).
                END.
        ELSE DO: 
            contrato_dt.precio_cf = 100 .
            contrato_dt.precio =  contrato_dt.precio_cf .
        END.
        ASSIGN contrato_dt.subtotal_bruto = contrato_dt.precio
            contrato_dt.subtotal_bruto_cf = contrato_dt.precio_cf
            contrato_dt.subtotal_neto_cf = contrato_dt.precio_cf
            contrato_dt.subtotal_gral = contrato_dt.subtotal_bruto_cf
            contrato_dt.subtotal_neto = contrato_dt.precio
            contrato_dt.subtotal_neto_cf = contrato_dt.precio_cf
            tiene = TRUE.
    END.
    FIND FIRST  contrato_dt OF contrato_hd WHERE contrato_dt.nro_articulo <> oblea.
    IF contrato_hd.prf_contrato = 3 THEN DO:
            IF tiene  THEN imp = imp - 100.
            contrato_dt.precio_cf = imp.
            contrato_dt.precio =  round( contrato_dt.precio_cf /  1.2100 , 2 ).
            END.
    ELSE DO: 
        contrato_dt.precio_cf = imp .
        contrato_dt.precio =  contrato_dt.precio_cf .
    END.

    ASSIGN
        contrato_dt.subtotal_bruto = contrato_dt.precio
        contrato_dt.subtotal_bruto_cf = contrato_dt.precio_cf
        contrato_dt.subtotal_neto_cf = contrato_dt.precio_cf
        contrato_dt.subtotal_gral = contrato_dt.subtotal_bruto_cf
        contrato_dt.subtotal_neto = contrato_dt.precio
        contrato_dt.subtotal_neto_cf = contrato_dt.precio_cf.
    ASSIGN 
        contrato_hd.imp_bruto = 0
        contrato_hd.imp_iva = 0
        contrato_hd.imp_neto = 0
        contrato_hd.imp_total = 0.
    
    FOR EACH contrato_dt OF contrato_hd:
        ASSIGN
        contrato_hd.imp_bruto = contrato_hd.imp_bruto + contrato_dt.subtotal_bruto
        contrato_hd.imp_iva = contrato_hd.imp_iva + contrato_dt.precio_cf - contrato_dt.precio
        contrato_hd.imp_neto = contrato_hd.imp_neto + contrato_dt.subtotal_neto
        contrato_hd.imp_total = contrato_hd.imp_total + contrato_dt.subtotal_gral.
    END.
END.
INPUT CLOSE.
