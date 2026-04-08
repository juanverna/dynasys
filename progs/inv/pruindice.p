find deposito 1.
for EACH Articulo-deposito OF Deposito WHERE  Articulo-deposito.hoja_numero = ""
 AND Articulo-deposito.st_recuento = "P" NO-LOCK ,
      EACH Articulo OF Articulo-deposito NO-LOCK ,
      EACH Partida-deposito OF Articulo-deposito NO-LOCK /*,
      EACH Partida OF Partida-deposito NO-LOCK */
    :
    
    display cdg_articulo.
