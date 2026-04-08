{findempresa.i}
FIND proveedor 668.
FOR EACH fac_header_prv OF proveedor
    WHERE Fac_header_prv.cdg_empresa = empresa.cdg_empresa
    AND Fac_header_prv.fecha >= 08/01/2014 
    NO-LOCK,
    FIRST Moneda OF Fac_header_prv NO-LOCK,
    EACH Fac_detalle_prv OF Fac_header_prv, 
    FIRST Articulo OF Fac_detalle_prv,
    FIRST Familia_ganancias OF Articulo:
    FIND FIRST Famganancias_regimen OF Familia_ganancias
        wHERE Famganancias_regimen.cdg_condiva = proveedor.cdg_condiva.
        
    
END.
