FIND fac_header WHERE prf_comprob = 3 AND nro_comprob = 3 AND tip_comprob = "FA".
DEFINE BUFFER administrador FOR cliente.
FIND cliente OF fac_header.
FIND FIRST domicilio OF cliente.
FIND administrador WHERE administrador.nro_cliente = cliente.nro_admin.
         ASSIGN fac_header.nombre             = IF cliente.factu_admin THEN administrador.nom_cliente ELSE Cliente.nom_cliente
            fac_header.cdg_condiva        = IF cliente.factu_admin THEN administrador.cdg_condiva ELSE Cliente.cdg_condiva
            fac_header.cod_docu           = IF cliente.factu_admin THEN administrador.cod_docu ELSE cliente.cod_docu 
            fac_header.cuit               = IF cliente.factu_admin THEN administrador.cuit ELSE Cliente.cuit
            fac_header.direccion          = IF cliente.factu_admin THEN administrador.direccion ELSE Domicilio.direccion
            fac_header.localidad          = IF cliente.factu_admin THEN administrador.localidad ELSE Domicilio.localidad
            fac_header.cdg_postal         = IF cliente.factu_admin THEN administrador.cdg_postal ELSE cliente.cdg_postal
            fac_header.cdg_lista          = IF cliente.factu_admin THEN administrador.dfl_lista ELSE cliente.dfl_lista.
