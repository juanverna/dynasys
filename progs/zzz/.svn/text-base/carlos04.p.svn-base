DEF VAR tt AS DECIMAL FORMAT "->>>>>>9.99".
OUTPUT TO "clipboard".
FOR EACH articulo, EACH fac_detalle OF articulo, FIRST fac_header OF fac_detalle WHERE MONTH(fac_header.fecha) = 4 AND YEAR(fac_header.fecha) = 2007
    AND NOT fac_header.anulado,
    FIRST tipocomprobante OF fac_header BREAK BY articulo.cdg_articulo:
    /*DISPLAY cdg_articulo articulo.descripcion subtotal_neto tipocomprobante.cdg_comprobante.*/
    tt = IF tipocomprobante.debita THEN tt + subtotal_neto ELSE tt - subtotal_neto.
    IF LAST-OF(Articulo.cdg_articulo)
    THEN DO:
        DISPLAY articulo.descripcion tt WITH STREAM-IO.
        tt = 0.
    END.
END.
DISPLAY tt.
