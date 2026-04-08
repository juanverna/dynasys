FIND fac_HEADER WHERE nro_comprob = 14071
     AND prf_comprob = 3.
DISPLAY nro_contrato.
FOR EACH fac_header_impuesto OF fac_header:
    FOR EACH fac_detalle_impuesto OF fac_header:
        DISPLAY fac_detalle_impuesto.
    END.
END.
