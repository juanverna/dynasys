DEFINE VAR cto AS INT.
DEFINE VAR imp AS DECIMAL.
DEFINE VAR oblea AS DECIMAL.

INPUT FROM c:\temp\precios.csv.
REPEAT:
    IMPORT DELIMITER ";" cto imp oblea.
    FIND contrato_hd WHERE contrato_hd.nro_contrato = cto.
    FIND contrato_dt OF contrato_hd WHERE nro_articulo = 167 NO-ERROR.
    IF oblea = 0 AND AVAILABLE contrato_dt THEN MESSAGE "error existe 01f" cto VIEW-AS ALERT-BOX ERROR.
    IF oblea <> 0 THEN do:
        if NOT AVAILABLE contrato_dt THEN MESSAGE "error no existe 01f" cto VIEW-AS ALERT-BOX ERROR. 
        ELSE DO:
            IF contrato_hd.prf_contrato = 1 THEN DO:
                contrato_dt.precio_cf = oblea.
                contrato_dt.precio =  round( contrato_dt.precio_cf /  1.2100 , 2 ).
                END.
            ELSE DO: 
                contrato_dt.precio_cf = oblea.
                contrato_dt.precio =  contrato_dt.precio_cf .
            END.
            ASSIGN
            contrato_dt.subtotal_bruto = contrato_dt.precio
            contrato_dt.subtotal_bruto_cf = contrato_dt.precio_cf
            contrato_dt.subtotal_neto_cf = contrato_dt.precio_cf
            contrato_dt.subtotal_gral = contrato_dt.subtotal_bruto_cf
            contrato_dt.subtotal_neto = contrato_dt.precio.
        END.
    END.
    
    FIND contrato_dt OF contrato_hd WHERE nro_articulo <> 0 AND nro_articulo <> 167.
    IF AVAILABLE contrato_dt THEN do:
        IF contrato_hd.prf_contrato = 1 THEN DO:
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
        contrato_dt.subtotal_neto = contrato_dt.precio.
    END.
    FOR EACH CONTRATO_HD WHERE contrato_hd.nro_contrato = cto:
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
END.
