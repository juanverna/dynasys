def var saldo as decimal format "->>,>>>,>>9.99".
for each cta_cte where /*tip_comprob begins "F" and*/ cta_cte.fecha_emision <= 10/31/2000 
     break by cdg_empresa:
  saldo = saldo + debito - credito.
  if last-of(cdg_empresa)
  then do:
       display cta_cte.cdg_empresa saldo with down stream-io.
       saldo = 0.
  end.
end.
