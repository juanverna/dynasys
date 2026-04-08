define variable tf as integer.
define variable tp as decimal.
form
  fac_header.tip_comprob Fac_header.prf_comprob Fac_header.nro_comprob cliente.cdg_cliente fac_header.nombre fac_header.imp_total
  with frame aa down.



output to printer.
for each fac_header where cdg_empresa = "A" and not anulado, cliente of fac_header:
  display tip_comprob prf_comprob nro_comprob cdg_cliente fac_header.nombre
   imp_total format ">>>>9.99"
    with stream-io width 132 frame aa.
  down with frame aa.  
  tf = tf + 1.
  tp = tp + imp_total.
end.
underline   
  Fac_header.tip_comprob 
  Fac_header.prf_comprob 
  Fac_header.nro_comprob 
  Cliente.cdg_cliente 
  Fac_header.nombre 
  Fac_header.imp_total 
  with frame aa.

display tf @ Cliente.cdg_cliente
        tp @ Fac_header.imp_total
        with frame aa.
 
