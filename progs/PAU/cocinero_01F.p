DEFINE VAR imp_firma AS DECIMAL INITIAL 50.00.
DEFINE VAR n01f AS INT .
FIND articulo WHERE articulo.cdg_articulo = "01F".
n01f = articulo.nro_articulo.
FOR EACH contrato_hd WHERE contrato_hd.estado = "A" AND contrato_hd.cant_periodos = 0 AND NOT contrato_hd.anulado AND contrato_hd.fecha_baja = ?:
IF contrato_hd.nro_tipo_evento <> 1 THEN NEXT.
FIND cliente OF contrato_hd.
IF cliente.cdg_prov <> "01" THEN NEXT.
FIND FIRST contrato_dt OF contrato_hd.
FIND articulo OF contrato_dt.
IF LOOKUP(articulo.cdg_articulo,"01,02,35,09,03,10") = 0 THEN NEXT.

FIND Punto-venta WHERE punto-venta.cdg_punto = contrato_hd.prf_contrato NO-LOCK NO-ERROR.
    
    FIND FIRST contrato_dt OF contrato_hd WHERE contrato_dt.nro_articulo = n01f NO-ERROR.
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
             contrato_dt.nro_articulo = n01f.
             contrato_dt.detallada = articulo.detallada.
             contrato_dt.nro_linea = 3.
             contrato_dt.cantidad = 1.
             contrato_dt.granel = 1.
             contrato_dt.solocuota1 = FALSE.
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

