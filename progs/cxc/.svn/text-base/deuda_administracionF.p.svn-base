/*Fecha de la ultima cobranza a una administracion*/
DEFINE INPUT PARAMETER pnro LIKE cliente.nro_cliente NO-UNDO.
DEFINE OUTPUT PARAMETER ultcob AS DATE NO-UNDO.
{findempresa.i}
FIND cliente WHERE cliente.nro_cliente = pnro NO-LOCK NO-ERROR.
IF NOT AVAILABLE cliente THEN DO:
        ultcob = ?.
        RETURN.
END.
FOR EACH rendicion_hd WHERE Rendicion_hd.nro_administrador = pnro AND Rendicion_hd.st_tesoreria <> 'A' BY Rendicion_hd.fch_rendicion DESC:
    IF Rendicion_hd.fch_rendicion = ? THEN NEXT.
    ultcob = Rendicion_hd.fch_rendicion.
    RETURN.
END.

