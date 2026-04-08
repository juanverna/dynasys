
DEFINE BUFFER barticulo FOR articulo.
DEFINE BUFFER bcontrato_dt FOR contrato_dt.
FIND barticulo WHERE barticulo.cdg_articulo = "23F".
FIND articulo WHERE articulo.cdg_articulo = "11".
FOR EACH evento WHERE evento.nro_tipo_evento = 3 AND frealizado = ? AND fasignado >= 12/16/2010 AND evento.orige = "CONTRATO" AND NOT evento.anulado:
FIND contrato_hd WHERE contrato_hd.nro_contrato = evento.nro_identificacion NO-ERROR.
IF NOT AVAILABLE contrato_hd THEN MESSAGE "Ver evento " evento.nro_evento VIEW-AS ALERT-BOX ERROR.
FIND contrato_dt OF contrato_hd WHERE contrato_dt.nro_articulo = barticulo.nro_articulo NO-ERROR.
IF AVAILABLE contrato_dt THEN  NEXT.
DEFINE VAR sig AS logical.
sig = FALSE.
FOR EACH fac_header WHERE NOT fac_header.anulado AND fac_header.nro_cliente = contrato_hd.nro_cliente and fac_header.fecha > 12/01/2010,
 FIRST fac_detalle OF fac_header WHERE fac_detalle.nro_articulo = barticulo.nro_articulo:
 sig = TRUE.
 LEAVE.
END.

IF sig THEN NEXT.

FIND cliente OF evento.
DISPLAY cliente.direccion contrato_hd.nro_contrato evento.nro_evento evento.frealizado.
END.
