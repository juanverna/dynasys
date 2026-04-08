FIND cliente WHERE cdg_cliente = "A4067".
FOR EACH fac_header 
    WHERE cdg_empresa = "P"
      AND tip_comprob = "FB"
      AND prf_comprob = 1
      AND nro_comprob = 71364:

    fac_header.nro_administrador = Cliente.nro_cliente.

END.

FOR EACH cta_cte 
    WHERE cdg_empresa = "P"
      AND tip_comprob = "FB"
      AND prf_comprob = 1
      AND nro_comprob = 71364:

    cta_cte.nro_administrador = Cliente.nro_cliente.

END.

