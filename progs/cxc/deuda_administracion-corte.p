/*deuda de cuenta corriente de un cliente a una fecha de corte determinada*/
DEFINE INPUT PARAMETER pnro LIKE cliente.nro_cliente NO-UNDO.
DEFINE INPUT PARAMETER p-vencimiento AS DATE NO-UNDO.
DEFINE OUTPUT PARAMETER totdeuda AS DECIMAL NO-UNDO.
{findempresa.i}
FIND cliente WHERE cliente.nro_cliente = pnro NO-LOCK NO-ERROR.
IF NOT AVAILABLE cliente THEN DO:
        totdeuda = ?.
        RETURN.
END.
totdeuda = 0.
FOR EACH Cta_cte NO-LOCK
        WHERE cta_cte.nro_administrador = cliente.nro_cliente
              AND Cta_cte.cdg_empresa  = empresa.cdg_empresa
              AND Cta_cte.debito <> Cta_cte.credito
              AND cta_cte.fecha_emision <= p-vencimiento:
                    totdeuda = totdeuda + Cta_cte.debito - Cta_cte.credito.
END.

