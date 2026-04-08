FOR each fac_header WHERE nro_comprob = 30498 AND prf_comprob = 3 ,
    EACH fac_detalle OF fac_header, articulo OF fac_detalle :
    /*IF   
        articulo.cdg_articulo = "05m" OR
        articulo.cdg_articulo = "01f" or
        articulo.cdg_articulo = "REDONDEO"
        THEN NEXT.
     ASSIGN fac_detalle.subtotal_bruto = fac_detalle.precio
            fac_detalle.subtotal_bruto_cf = fac_detalle.precio_cf
            fac_detalle.subtotal_neto_cf = fac_detalle.precio_cf
            fac_detalle.subtotal_gral = fac_detalle.subtotal_bruto_cf
            fac_detalle.subtotal_neto = fac_detalle.precio
            fac_detalle.subtotal_neto_cf = fac_detalle.precio_cf.
    END. */
    UPDATE fac_detalle.precio FORMAT "->>>>>.99".
        precio_cf = TRUNCATE( precio * 1.21 ,2).
        UPDATE Precio_cf FORMAT "->>>>>.99".
        ASSIGN fac_detalle.subtotal_bruto = fac_detalle.precio
            fac_detalle.subtotal_bruto_cf = fac_detalle.precio_cf
            fac_detalle.subtotal_neto_cf = fac_detalle.precio_cf
            fac_detalle.subtotal_gral = fac_detalle.subtotal_bruto_cf
            fac_detalle.subtotal_neto = fac_detalle.precio
            fac_detalle.subtotal_neto_cf = fac_detalle.precio_cf.
