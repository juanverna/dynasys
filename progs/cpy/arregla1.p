DEFINE INPUT PARAMETER r AS INT.
DEFINE VAR r05m AS INT NO-UNDO.
DEFINE VAR r01f AS INT NO-UNDO.
DEFINE VAR rp AS DECIMAL NO-UNDO.
DEFINE BUFFER barticulo FOR articulo.
FIND contrato_hd WHERE contrato_hd.nro_contrato = r.
FIND articulo WHERE articulo.cdg_articulo = "05m".
r05m = articulo.nro_articulo.
FIND articulo WHERE articulo.cdg_articulo = "01f".
r01f = articulo.nro_articulo.
FIND FIRST contrato_dt WHERE contrato_dt.nro_contrato = r AND ( contrato_dt.nro_articulo <> r01f AND contrato_dt.nro_articulo <> r05m ) NO-ERROR.
IF NOT AVAILABLE contrato_dt THEN do:
    LEAVE.
END.
FIND FIRST contrato_dt WHERE contrato_dt.nro_contrato = r AND contrato_dt.nro_articulo = r05m NO-ERROR.
IF NOT AVAILABLE contrato_dt THEN do:
    MESSAGE contrato_dt.nro_contrato VIEW-AS ALERT-BOX ERROR.
        LEAVE.
        END.
rp = contrato_dt.precio_cf.
DELETE contrato_dt.
FIND FIRST contrato_dt WHERE contrato_dt.nro_contrato = r AND ( contrato_dt.nro_articulo <> r01f AND contrato_dt.nro_articulo <> r05m ) NO-ERROR.
IF NOT AVAILABLE contrato_dt THEN do:
    MESSAGE contrato_dt.nro_contrato VIEW-AS ALERT-BOX ERROR.
    LEAVE.
END.
FIND articulo OF contrato_dt.
FIND barticulo WHERE barticulo.cdg_articulo = trim(articulo.cdg_articulo) + "m"  NO-ERROR.
IF NOT AVAILABLE barticulo THEN DO: 
    CREATE barticulo.
    BUFFER-COPY articulo to barticulo ASSIGN barticulo.nro_articulo = NEXT-VALUE(proximo_articulo)
                                             barticulo.cdg_articulo = trim(articulo.cdg_articulo) + "m".
END.

contrato_dt.precio_cf = contrato_dt.precio_cf + rp.
contrato_dt.nro_articulo = barticulo.nro_articulo.
 ASSIGN  contrato_dt.precio = TRUNCATE( contrato_dt.precio_cf / 1.21 , 2 )
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
        
