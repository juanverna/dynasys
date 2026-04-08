  IF ver_por = por_cod 
     THEN OPEN QUERY qry_cliente 
               FOR EACH Cliente NO-LOCK WHERE Cliente.cdg_cliente >= des_codigo
                    AND Cliente.cdg_cliente <= has_codigo
                    AND CAN-DO(Cliente.lista_empresas,Empresa.cdg_empresa)
                    AND LOOKUP(que_sector, Cliente.lista_sectores) <> 0
                     BY Cliente.cdg_cliente.
     ELSE OPEN QUERY qry_cliente 
              FOR EACH Cliente NO-LOCK WHERE Cliente.nom_cliente >= des_nombre
                   AND Cliente.nom_cliente <= has_nombre
                   AND CAN-DO(Cliente.lista_empresas,Empresa.cdg_empresa)
                   AND LOOKUP(que_sector, Cliente.lista_sectores) <> 0
                    BY Cliente.nom_cliente.
