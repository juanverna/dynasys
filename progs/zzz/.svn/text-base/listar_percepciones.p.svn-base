DEF VAR t AS DEC.
DEF VAR c AS INT.
DO WITH FRAME aa:
OUTPUT TO PRINTER.
FOR EACH fac_header_impuesto WHERE cdg_impuesto = 6, fac_header OF fac_header_impuesto:
    t = t + importe.
    c = c +  1.
    DISPLAY cdg_impuesto tip_comprob prf_comprob nro_comprob importe WITH STREAM-IO FRAME aa DOWN.
    DOWN WITH FRAME aa.
END.
UNDERLINE fac_header.nro_comprob fac_header_impuesto.importe WITH FRAME aa.
DISPLAY t @ fac_header_impuesto.importe 
        c @ fac_header.nro_comprob 
    WITH FRAME aa.

END.
