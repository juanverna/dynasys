  IF ver_por = por_cod 
     THEN OPEN QUERY qry_cliente 
               FOR EACH Cliente NO-LOCK OF Cobrador  
                  WHERE Cliente.cdg_cliente >= des_codigo
                    AND Cliente.cdg_cliente <= has_codigo
                    AND CAN-DO(Cliente.lista_empresas,Empresa.cdg_empresa)
                     BY Cliente.cdg_cliente.
     ELSE OPEN QUERY qry_cliente 
               FOR EACH Cliente NO-LOCK OF Cobrador  
                 WHERE Cliente.nom_cliente >= des_nombre
                   AND Cliente.nom_cliente <= has_nombre
                   AND CAN-DO(Cliente.lista_empresas,Empresa.cdg_empresa)
                    BY Cliente.nom_cliente.
