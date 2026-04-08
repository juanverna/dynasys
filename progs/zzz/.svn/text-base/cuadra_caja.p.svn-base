
define variable v-saldo as decimal.

for each caj_header :
    caj_header.importe = 0.
    for each caj_detalle of caj_header:
        caj_header.importe = caj_header.importe + caj_detalle.importe.
    end.
    
    v-saldo = caj_header.importe.
    for each caja-imputacion where caja-imputacion.nro_transaccion = caj_header.nro_transaccion break by nro_transaccion:    
        if last(nro_transaccion)
           then caja-imputacion.valor = v-saldo.
           else v-saldo = v-saldo -  caja-imputacion.valor.
    end.               
end.
