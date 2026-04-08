FIND fac_header WHERE prf_comprob = 3 AND nro_comprob = 7566 AND tip_comprob = "FB" .
update imp_total imp_neto imp_iva.
/*FOR EACH fac_detalle OF fac_header:
    UPDATE precio precio_cf.
END.*/
DISPLAY fac_header.cai fac_header.nro_contrato cuit fecha.
FOR EACH fac_header_impuesto OF fac_header, impuesto OF  fac_header_impuesto :

    UPDATE Fac_header_impuesto.importe monto_imponible Fac_header_impuesto.tasa.
END.
FOR EACH fac_detalle OF fac_header:
    UPDATE precio precio_cf.

END.
