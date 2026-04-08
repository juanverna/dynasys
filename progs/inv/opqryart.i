  IF ver_por = por_cod 
     THEN OPEN QUERY qry_articulo 
               FOR EACH Articulo NO-LOCK WHERE Articulo.cdg_articulo >= des_codigo
                    AND Articulo.cdg_articulo <= has_codigo
                     BY Articulo.cdg_articulo.
     ELSE OPEN QUERY qry_articulo 
              FOR EACH Articulo NO-LOCK WHERE Articulo.descripcion >= des_nombre
                   AND Articulo.descripcion <= has_nombre
                    BY Articulo.descripcion.
