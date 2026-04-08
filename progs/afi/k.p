DEFINE BUFFER admin FOR cliente.
FIND admin where admin.cdg_cliente = "A1535".
FOR EACH fac_header WHERE fac_header.nro_admin = admin.nro_cliente AND
fac_header.fecha >= 04/01/2010 AND 
fac_header.fecha < 05/01/2010 :
DISPLAY Fac_header.estado_2_impresion.

 
