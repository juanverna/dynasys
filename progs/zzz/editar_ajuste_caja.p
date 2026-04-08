DEFINE VARIABLE que_caja LIKE Caja.cdg_caja.
DEFINE VARIABLE que_empresa LIKE empresa.cdg_empresa.
UPDATE que_caja que_empresa.
FOR EACH caj_header WHERE cdg_caja = que_caja AND cdg_empresa = que_empresa AND caj_header.fecha = 01/01/80 BY caj_header.fecha:
    DISPLAY caj_header.fecha caj_header.tipo_mov.
    FOR EACH caj_detalle OF caj_header:
        DISPLAY caj_detalle.cdg_rubro caj_detalle.importe.
        UPDATE caj_detalle.importe.
    END.

END.
