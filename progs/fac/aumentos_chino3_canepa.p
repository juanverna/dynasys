INPUT FROM e:\wproceso\canepa01-09-20.csv. /*En la columna A va el precio y en la columna B va el número de contrato*/
/* REVISAR AL FINAL DEL ARCHIVO QUE NO HAYA VALORES SUELTOS */
DEFINE VAR pp AS DECIMAL NO-UNDO.
DEFINE VAR n01f AS INT NO-UNDO.
DEFINE VAR n05m AS INT NO-UNDO.
FIND articulo WHERE articulo.cdg_articulo = "01f".
n01f = nro_articulo.
FIND articulo WHERE articulo.cdg_articulo = "05m".
n05m = nro_articulo.
DEFINE VAR a AS INT.
DEFINE VAR b AS char.
DEFINE VAR c AS DECIMAL decimals 2.
DEFINE VAR tiene AS LOGICAL.


REPEAT:
    IMPORT DELIMITER ";" b a.
    
    FIND contrato_hd WHERE nro_contrato = a NO-ERROR.
    IF NOT AVAILABLE contrato_hd THEN do:
        DISPLAY a.
        NEXT.
    END.
   
    FIND FIRST contrato_dt WHERE contrato_dt.nro_contrato = a. /*AND
       contrato_dt.nro_articulo = n01f NO-LOCK NO-ERROR.*/
    IF NOT AVAILABLE contrato_dt THEN next.
    /*FIND FIRST contrato_dt WHERE contrato_dt.nro_contrato = a AND
       (contrato_dt.nro_articulo <> n01f AND  contrato_dt.nro_articulo <> n05m ) NO-ERROR.
    IF NOT AVAILABLE contrato_dt THEN next.*/
    ELSE DO:
            pp = decimal(b).
            /*pp = contrato_dt.precio_cf + decimal(b).*/
            
   ASSIGN  contrato_dt.precio = TRUNCATE( pp / 1.21 , 2 )
            contrato_dt.precio_cf = pp
            contrato_dt.subtotal_bruto = contrato_dt.precio
            contrato_dt.subtotal_bruto_cf = contrato_dt.precio_cf
            contrato_dt.subtotal_neto_cf = contrato_dt.precio_cf
            contrato_dt.subtotal_gral = contrato_dt.subtotal_bruto_cf
            contrato_dt.subtotal_neto = contrato_dt.precio
            contrato_dt.subtotal_neto_cf = contrato_dt.precio_cf.
      
    END.
    
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



