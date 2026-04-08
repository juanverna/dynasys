  IF ver_por = por_cod 
     THEN OPEN QUERY qry_cobrador 
               FOR EACH Cobrador NO-LOCK WHERE Cobrador.cdg_cobrador >= des_codigo
                    AND Cobrador.cdg_cobrador <= has_codigo
                     BY Cobrador.cdg_cobrador.
     ELSE OPEN QUERY qry_cobrador 
              FOR EACH Cobrador NO-LOCK WHERE Cobrador.nom_cobrador >= des_nombre
                   AND Cobrador.nom_cobrador <= has_nombre
                    BY Cobrador.nom_cobrador.
