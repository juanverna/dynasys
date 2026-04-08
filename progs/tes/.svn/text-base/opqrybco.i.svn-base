  IF ver_por = por_cod 
     THEN OPEN QUERY qry_cuenta 
               FOR EACH Cuenta_bancaria NO-LOCK WHERE Cuenta_bancaria.cdg_cuenta_ban >= des_codigo
                    AND Cuenta_bancaria.cdg_cuenta_ban <= has_codigo
                     BY Cuenta_bancaria.cdg_cuenta_ban.
     ELSE OPEN QUERY qry_cuenta 
              FOR EACH Cuenta_bancaria NO-LOCK WHERE Cuenta_bancaria.denominacion_cta >= des_nombre
                   AND Cuenta_bancaria.denominacion_cta <= has_nombre
                    BY Cuenta_bancaria.denominacion_cta.
