{stavisado.i}
DEFINE BUFFER refer FOR evento.
FOR EACH evento WHERE evento.nro_tipo_evento = 10 AND fasignado <> ? AND fasignado = 03/03/2010:
/*IF INDEX("BXRMS",stavisado(evento.nro_evento)) <> 0 THEN NEXT.*/
/*IF stavisado(evento.nro_evento) = "I" THEN evento.impreso = FALSE.*/
FIND cliente OF evento.
FIND refer where refer.nro_evento = evento.refevento.
DISPLAY evento.impreso stavisado(evento.nro_evento) cliente.direccion
evento.fasignado refer.fasignado.
END.
