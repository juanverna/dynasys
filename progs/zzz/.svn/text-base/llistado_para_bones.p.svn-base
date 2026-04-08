
OUTPUT TO "c:\sic-temp\bons.txt" PAGED.
FOR EACH Fac_header WHERE Fac_header.cdg_empresa = "R" AND nro_comprob > 200, FIRST Cliente OF fac_header:

    DISPLAY Fac_header.tip_comprob Fac_header.prf_comprob Fac_header.nro_comprob Fac_header.imp_neto Fac_header.imp_iva Fac_header.imp_total Cliente.cdg_cliente Cliente.nom_cliente
        WITH STREAM-IO WIDTH 160.

    FOR EACH Fac_header-bon OF Fac_header:
        DISPLAY space(7) Fac_header-bon.cdg_bonificacion Fac_header-bon.porcentaje Fac_header-bon.importe
            WITH STREAM-IO WIDTH 160.
    END.

    FOR EACH Fac_detalle OF Fac_header, Articulo OF Fac_detalle:
        DISPLAY SPACE(7) Articulo.cdg_articulo Articulo.descripcion Fac_detalle.cantidad Fac_detalle.precio Fac_detalle.subtotal_neto
                        WITH STREAM-IO WIDTH 160.
    END.

END.
/*RUN veresult.w ( INPUT "c:\sic-temp\bons.txt", INPUT 22 ).*/
