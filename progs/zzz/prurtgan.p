/*
define variable c as integer.
FOR EACH OPG_header:
 c = 0.
 for each caj_detalle where caj_detalle.nro_transaccion = opg_header.nro_transaccion:
  c = c + 1.
 end.
  if c> 10 then display c nro_comprob.
end.  
*/

find first certificado_gan.
run prrtg194.p ( input rowid(certificado_gan) ).
