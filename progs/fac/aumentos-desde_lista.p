INPUT FROM c:\temp\ppp.csv.


DEFINE VAR n01f AS INT NO-UNDO.
DEFINE VAR n05m AS INT NO-UNDO.
FIND articulo WHERE articulo.cdg_articulo = "01f".
n01f = nro_articulo.
FIND articulo WHERE articulo.cdg_articulo = "05m".
n05m = nro_articulo.
DEFINE VAR a AS INT.
DEFINE VAR b AS DECIMAL.
REPEAT:
    IMPORT DELIMITER ";" a b.
   
    
    FIND contrato_hd WHERE nro_contrato = a NO-ERROR.
    IF NOT AVAILABLE contrato_hd THEN do:
        DISPLAY a.
    NEXT.
    END.
    FIND FIRST contrato_dt WHERE contrato_dt.nro_contrato = a AND
        contrato_dt.nro_articulo <> n01f AND contrato_dt.nro_articulo <> n05m NO-ERROR.
    IF NOT AVAILABLE contrato_dt  THEN do:
        DISPLAY a.
        NEXT.
    END.
    IF contrato_dt.precio - TRUNCATE( b / 1.21 , 2 ) > 0.01 THEN do:
     /*  DISPLAY a b contrato_dt.precio (b / contrato_dt.precio) - 1.*/
        NEXT.
    END.
NEXT.    
    ASSIGN  contrato_dt.precio = TRUNCATE( b / 1.21 , 2 )
            contrato_dt.precio_cf = b
            contrato_dt.subtotal_bruto = contrato_dt.precio
            contrato_dt.subtotal_bruto_cf = contrato_dt.precio_cf
            contrato_dt.subtotal_neto_cf = contrato_dt.precio_cf
            contrato_dt.subtotal_gral = contrato_dt.subtotal_bruto_cf
            contrato_dt.subtotal_neto = contrato_dt.precio
            contrato_dt.subtotal_neto_cf = contrato_dt.precio_cf.
END.

INPUT CLOSE.
INPUT FROM c:\temp\ppp.csv.
REPEAT:
    IMPORT DELIMITER ";" a b.
    FIND contrato_hd WHERE contrato_hd.nro_contrato = a.
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


