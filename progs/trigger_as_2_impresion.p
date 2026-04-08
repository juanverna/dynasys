TRIGGER PROCEDURE FOR ASSIGN OF Fac_header.estado_2_impresion.
if fac_header.estado_2_impresion = "I" then do:
nro_usuario_2_impresion = userid("SIC").
fecha_2_impresion = today.
end.
