        FOR EACH {1} WHERE {1}.nro_articulo = Articulo.nro_articulo EXCLUSIVE-LOCK: 
              DELETE {1}.
        END.
