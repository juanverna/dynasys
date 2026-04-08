  IF ver_por = por_cod 
     THEN OPEN QUERY qry_vendedor 
               FOR EACH Vendedor NO-LOCK WHERE Vendedor.cdg_vendedor >= des_codigo
                    AND Vendedor.cdg_vendedor <= has_codigo
                     BY Vendedor.cdg_vendedor.
     ELSE OPEN QUERY qry_vendedor 
              FOR EACH Vendedor NO-LOCK WHERE Vendedor.nombre >= des_nombre
                   AND Vendedor.nombre <= has_nombre
                    BY Vendedor.nombre.
