DEFINE VAR imp_firma AS DECIMAL INITIAL 60.00.
FIND articulo WHERE articulo.cdg_articulo = "23F".
FOR EACH contrato_hd WHERE contrato_hd.estado = "A" AND contrato_hd.cant_periodos > 0 AND contrato_hd.resto_periodos = contrato_hd.cant_periodos AND NOT contrato_hd.anulado AND contrato_hd.fecha_baja = ?:
DISPLAY contrato_hd.nro_contrato.

    FIND Punto-venta WHERE punto-venta.cdg_punto = contrato_hd.prf_contrato NO-LOCK NO-ERROR.
    FIND FIRST contrato_dt OF contrato_hd WHERE contrato_dt.solocuota1 NO-ERROR.
    IF NOT AVAILABLE contrato_dt THEN DO:
            CREATE contrato_dt.
            ASSIGN contrato_dt.nro_contrato = contrato_hd.nro_contrato
             contrato_dt.precio = IF punto-venta.TP = "E" THEN imp_firma / 1.21 ELSE imp_firma
             contrato_dt.precio_cf = imp_firma
             contrato_dt.subtotal_bruto = IF punto-venta.TP = "E" THEN imp_firma / 1.21 ELSE imp_firma
             contrato_dt.subtotal_bruto_cf = imp_firma
             contrato_dt.subtotal_gral = imp_firma
             contrato_dt.subtotal_neto = IF punto-venta.TP = "E" THEN imp_firma / 1.21 ELSE imp_firma
             contrato_dt.subtotal_neto_cf = imp_firma
             contrato_dt.nro_factura_anticipo = 0
             contrato_dt.nro_articulo = articulo.nro_articulo.
             contrato_dt.detallada = articulo.detallada.
             contrato_dt.cantidad = 1.
             contrato_dt.granel = 1.
             contrato_dt.solocuota1 = TRUE.
    END.
    /*recalculo de totales contrato*/
    ASSIGN  Contrato_hd.imp_iva      = 0
           Contrato_hd.imp_neto     = 0 
           Contrato_hd.imp_total    = 0 
           Contrato_hd.imp_bruto    = 0.
   FOR EACH contrato_dt OF contrato_hd:
       ASSIGN 
              Contrato_hd.imp_neto     = Contrato_hd.imp_neto     + Contrato_dt.subtotal_neto  
              Contrato_hd.imp_total    = Contrato_hd.imp_total    + contrato_dt.subtotal_gral 
              Contrato_hd.imp_bruto    = Contrato_hd.imp_bruto    + Contrato_dt.subtotal_bruto.
   END.
END.

