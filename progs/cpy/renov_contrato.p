/*aca comienza la renovacion*/
DEFINE INPUT PARAMETER imp_servicio AS DECIMAL NO-UNDO.
DEFINE INPUT PARAMETER pcant-periodos AS INT NO-UNDO.
DEFINE INPUT PARAMETER prige_desde AS DATE NO-UNDO.
DEFINE INPUT PARAMETER pprf LIKE contrato_hd.prf_contrato NO-UNDO.
DEFINE INPUT PARAMETER cdg_prod AS char NO-UNDO.
DEFINE INPUT PARAMETER pestado AS CHAR NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER pcontrato LIKE contrato_hd.nro_contrato NO-UNDO.

DEFINE BUFFER b-contrato_hd FOR contrato_hd.
DEFINE BUFFER b-contrato_dt FOR contrato_dt.
DEFINE VAR k AS INT NO-UNDO.
DEFINE BUFFER b-contrato_restriccion FOR contrato_restriccion.
DEF VAR auxm AS INT.
DEF VAR auxy AS INT.
DEFINE VAR rr AS INT NO-UNDO.
DEFINE VAR vmcba AS LOGICAL NO-UNDO.

  FIND contrato_hd WHERE contrato_hd.nro_contrato = pcontrato NO-LOCK NO-ERROR.
  IF NOT AVAILABLE contrato_hd THEN DO:
      MESSAGE "Error interno el contrato " pcontrato " no existe no puede proseguir".
      pcontrato = ?.
      RETURN ERROR.
  END.
  FIND Punto-venta WHERE punto-venta.cdg_punto = pprf NO-LOCK NO-ERROR.
  IF NOT AVAILABLE punto-venta THEN DO:
      MESSAGE "El punto de venta " pprf " no existe" skip
    "Debe cambiarlo!!" VIEW-AS ALERT-BOX ERROR.
      pcontrato = ?.
      RETURN ERROR.
  END.

  IF NOT Punto-venta.habilitado THEN DO:
      MESSAGE "El punto de venta " pprf " no esta habilitado para facturar " skip
          "Debe cambiarlo!!!" VIEW-AS ALERT-BOX ERROR.
  END.
  DO TRANSACTION:
      CREATE b-contrato_hd.
      
      BUFFER-COPY contrato_hd EXCEPT contrato_hd.nro_contrato TO b-contrato_hd  
          ASSIGN b-contrato_hd.nro_contrato = NEXT-VALUE(proximo_contrato)
                 b-Contrato_hd.num_contrato = b-Contrato_hd.nro_contrato
                 b-contrato_hd.fecha_alta = TODAY
                 b-contrato_hd.fecha_baja = ?
                 b-contrato_hd.ultimo_ano = 0
                 b-contrato_hd.ultimo_mes = 0
                 b-contrato_hd.estado = pestado
                 auxy = year(prige_desde).
                 auxm = MONTH(prige_desde).
          ASSIGN
                 b-contrato_hd.rige_desde = IF DATE(auxm ,1, auxy ) > TODAY THEN DATE(auxm ,1, auxy ) ELSE TODAY
                 b-contrato_hd.primer_mes =  IF DATE(auxm ,1, auxy ) > TODAY THEN auxm ELSE MONTH(TODAY)
                 b-contrato_hd.primer_ano = IF DATE(auxm ,1, auxy ) > TODAY THEN  auxy ELSE YEAR(TODAY)
                 b-contrato_hd.resto_periodos = pcant-periodos
                 b-contrato_hd.cant_periodos = pcant-periodos
                 b-contrato_hd.rige_hasta = 01/31/2199
                 b-Contrato_hd.imp_iva = IF punto-venta.TP = "E" THEN imp_servicio  * 0.21 / 1.21 ELSE imp_servicio   
                 b-Contrato_hd.imp_neto = IF punto-venta.TP = "E" THEN imp_servicio / 1.21 ELSE imp_servicio   
                 b-Contrato_hd.imp_bruto = b-Contrato_hd.imp_neto 
                 b-Contrato_hd.imp_total = imp_servicio 
                 rr = int(b-contrato_hd.modo_facturacion) NO-ERROR.
                 IF rr = 0 THEN
                       b-contrato_hd.modo_facturacion = "1".
          FOR EACH contrato_restriccion OF contrato_hd:
              CREATE b-contrato_restriccion.
              BUFFER-COPY contrato_restriccion EXCEPT contrato_restriccion.nro_contrato TO
                  b-contrato_restriccion
                  ASSIGN b-contrato_restriccion.nro_contrato = b-contrato_hd.nro_contrato.
          END.
      
          FIND articulo WHERE articulo.cdg_articulo = cdg_prod NO-LOCK.
          CREATE b-contrato_dt.
              ASSIGN b-contrato_dt.nro_contrato = b-Contrato_hd.nro_contrato
                     b-contrato_dt.nro_articulo = articulo.nro_articulo
                     b-Contrato_dt.precio = IF punto-venta.TP = "E" THEN imp_servicio / 1.21 ELSE imp_servicio
                     b-Contrato_dt.precio_cf = imp_servicio
                     b-Contrato_dt.subtotal_bruto = IF punto-venta.TP = "E" THEN imp_servicio / 1.21 ELSE imp_servicio
                     b-Contrato_dt.subtotal_bruto_cf = imp_servicio
                     b-Contrato_dt.subtotal_gral = imp_servicio
                     b-Contrato_dt.subtotal_neto = IF punto-venta.TP = "E" THEN imp_servicio / 1.21 ELSE imp_servicio
                     b-Contrato_dt.subtotal_neto_cf = imp_servicio
                     b-contrato_dt.detallada = articulo.detallada.
                     b-contrato_dt.documental = articulo.documental.
                     b-contrato_dt.nro_factura_anticipo = 0.
      pcontrato = b-contrato_hd.nro_contrato.
      FIND contrato_hd WHERE contrato_hd.nro_contrato = pcontrato.
      IF contrato_hd.estado = "A" THEN
          RUN poner_primer_evento.p( ROWID(contrato_hd)).
  END.
 RETURN.    







