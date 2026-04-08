session:immediate-display = yes.
for each sub_header_vta where not anulado:
    find provincia of sub_header_vta no-error.
    if not available provincia 
    then do:
         display cdg_empresa tip_comprob prf_comprob nro_comprob.
         find fac_header where fac_header.cdg_empresa = sub_header_vta.cdg_empresa
                           and fac_header.tip_comprob = sub_header_vta.tip_comprob
                           and fac_header.prf_comprob = sub_header_vta.prf_comprob
                           and fac_header.nro_comprob = sub_header_vta.nro_comprob
                               no-lock.
         find cliente of fac_header.
         display fac_header.nro_domicilio cliente.cdg_cliente.
         for each domicilio where domicilio.nro_cliente = fac_header.nro_cliente:
             display domicilio.nro_domicilio domicilio.cdg_provincia domicilio.direccion domicilio.localidad.
         end.    
         update fac_header.nro_domicilio sub_header_vta.cdg_provincia.
    end.
end.                                   
