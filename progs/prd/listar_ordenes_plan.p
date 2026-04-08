FIND planprod_hd WHERE nro_comprob = 9.
FOR EACH ofabrica_hd WHERE ofabrica_hd.nro_planprod = planprod_hd.nro_planprod:
    DISPLAY ofabrica_hd.nro_comprob.
    FOR EACH ofabrica_dt OF ofabrica_hd, articulo OF ofabrica_dt:
        DISPLAY articulo.cdg_articulo ofabrica_dt.tipo_detalle ofabrica_dt.cantidad ofabrica_dt.cantidad_sol.
    END.
    
END.

