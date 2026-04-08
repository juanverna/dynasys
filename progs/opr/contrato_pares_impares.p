OUTPUT TO c:\parimpar.txt.
DEFINE BUFFER administracion FOR cliente.
FOR EACH contrato_hd WHERE contrato_hd.estado = "A" AND Contrato_hd.fecha_baja = ?  AND Contrato_hd.rige_hasta > TODAY AND
     ( contrato_hd.cant_periodos  = contrato_hd.resto_periodos OR
       contrato_hd.resto_periodos > 0 ) AND modo_facturacion <> "1", cliente OF contrato_hd:
FIND administracion WHERE administracion.nro_cliente = cliente.nro_admin.
export nro_contrato ( IF ( primer_mes MOD 2 ) = 0 THEN "Impar" ELSE "Par" ) cliente.direccion administracion.nom_cliente Contrato_hd.imp_total.



        
