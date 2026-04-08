FIND planprod_hd WHERE nro_comprob = 9.
FOR EACH ofabrica_hd WHERE ofabrica_hd.nro_planprod = planprod_hd.nro_planprod:
    FOR EACH ofabrica_dt OF ofabrica_hd, articulo OF ofabrica_dt:
        DELETE ofabrica_dt.
    END.
    DELETE ofabrica_hd.
END.
Planprod_hd.cdg_estado = "AA".

