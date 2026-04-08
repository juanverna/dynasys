    DEFINE VAR d AS DATE.
    FOR EACH Acumulado_punto_venta: DELETE Acumulado_punto_venta. END.
    d = TODAY - 32.
FOR EACH fac_header NO-LOCK where NOT fac_header.anulado AND fac_header.fecha >=  d, FIRST tipocomprobante OF fac_header NO-LOCK:
       IF Tipocomprobante.afecta_cc THEN DO:
              FIND Acumulado_punto_venta WHERE 
                  Acumulado_punto_venta.cdg_puntovta = fac_header.prf_comprob and
                  Acumulado_punto_venta.cdg_empresa = fac_header.cdg_empresa and
                  Acumulado_punto_venta.periodo = YEAR(fac_header.fecha) * 100 + MONTH(fac_header.fecha) NO-ERROR.
              IF NOT AVAILABLE Acumulado_punto_venta THEN DO:
                  CREATE acumulado_punto_venta.
                  ASSIGN Acumulado_punto_venta.cdg_puntovta = fac_header.prf_comprob 
                         Acumulado_punto_venta.cdg_empresa = fac_header.cdg_empresa 
                         Acumulado_punto_venta.periodo = YEAR(fac_header.fecha) * 100 + MONTH(fac_header.fecha).
              END.
              IF Tipocomprobante.debita THEN Acumulado_punto_venta.importe = Acumulado_punto_venta.importe - fac_header.imp_total.
              ELSE Acumulado_punto_venta.importe = Acumulado_punto_venta.importe + fac_header.imp_total.          END.
END.

