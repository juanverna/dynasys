  IF ver_por = por_cod 
     THEN OPEN QUERY qry_proveedor 
               FOR EACH Proveedor NO-LOCK WHERE Proveedor.cdg_proveedor >= des_codigo
                    AND Proveedor.cdg_proveedor <= has_codigo
                    AND Proveedor.titular_oxp_sino = FALSE
                     BY Proveedor.cdg_proveedor.
     ELSE OPEN QUERY qry_proveedor 
              FOR EACH Proveedor NO-LOCK WHERE Proveedor.nombre >= des_nombre
                   AND Proveedor.nombre <= has_nombre
                   AND Proveedor.titular_oxp_sino = FALSE
                    BY Proveedor.nombre.
