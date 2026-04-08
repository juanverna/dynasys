define temp-table formas
 field cdg_empresa as character
 field n-formas as integer
 field c-clientes as integer.
define variable k as integer.
 
for each cliente where cdg_estado = "":
  k = 0.
  for each cta_cte of cliente where debito <> credito break by cdg_empresa:
    k = k + 1.
    if last-of(cdg_empresa)
    then do:
         find formas where formas.cdg_empresa = cta_cte.cdg_empresa
                       and formas.n-formas = k no-error.
         if not available formas
         then do:
              create formas.
              assign formas.cdg_empresa = cta_cte.cdg_empresa
                     formas.n-formas    = k.
         end.             
         formas.c-clientes = formas.c-clientes + 1.
    end.
  end.
end. 
for each formas by formas.cdg_empresa by formas.n-formas:
  display formas with stream-io.
end.  
