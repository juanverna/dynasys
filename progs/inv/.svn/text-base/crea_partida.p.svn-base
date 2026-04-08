for each articulo where not can-find(first partida of articulo where cdg_empresa = "H") exclusive-lock:
/*display cdg_articulo.*/
   create partida.
   assign partida.nro_articulo = articulo.nro_articulo
          partida.nro_partida  = 1
          partida.cdg_partida = cdg_articulo + "-1"
          articulo.ult_partida = 1
          cdg_empresa = "H".
end.          
