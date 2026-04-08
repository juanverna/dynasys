DEFINE VAR i LIKE valor.nro_valor.
find valor WHERE Valor.numero_cheque = 98039782 .
i = valor.nro_valor.
DISPLAY i .

FIND opg_header WHERE opg_header.nro_comprob = 157.
FIND Caj_header WHERE Caj_header.nro_transaccion = opg_header.nro_transaccion NO-LOCK.
FOR EACH Caj_detalle OF Caj_header, Rubro OF Caj_detalle:
IF rubro.tipo = "V" THEN FIND Valor OF Caj_detalle NO-ERROR.
IF NOT AVAILABLE valor THEN UPDATE caj_detalle.
END.
