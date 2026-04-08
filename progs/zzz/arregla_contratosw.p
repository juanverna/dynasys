/*corrige importes contratos por oblea excenta*/
DEFINE VAR rr AS INT.
DEFINE VAR tiene AS LOGICAL NO-UNDO.
DEFINE TEMP-TABLE compara
    FIELD nro_contrato LIKE contrato_hd.nro_contrato
    FIELD ant AS DECIMAL
    FIELD post AS DECIMAL.
FOR EACH Contrato_hd 
        WHERE contrato_hd.estado = "A" AND 
              NOT contrato_hd.suspendido AND 
          ( Contrato_hd.primer_ano * 100 + Contrato_hd.primer_mes <= 2016 * 100 + 3 ) AND
          Contrato_hd.cant_periodos > 0 AND contrato_hd.fecha_baja = ? AND
    contrato_hd.rige_hasta >= TODAY AND 
    contrato_hd.nro_tipo_evento = 3 ,
    FIRST punto-venta WHERE Punto-venta.cdg_puntovta = Contrato_hd.prf_contrato AND punto-venta.habilitado :
    IF contrato_hd.nro_contrato = 27685  THEN NEXT.
    IF contrato_hd.nro_contrato = 27688  THEN NEXT.
    IF contrato_hd.nro_contrato = 27690  THEN NEXT.
    CREATE compara.
    ASSIGN compara.nro_contrato = contrato_hd.nro_contrato
         compara.ant = contrato_hd.imp_total.
    FIND articulo WHERE articulo.cdg_articulo = "23f" NO-LOCK.
    tiene = FALSE.
    FOR FIRST contrato_dt OF contrato_hd WHERE contrato_dt.nro_articulo = articulo.nro_articulo:
       ASSIGN contrato_dt.precio_cf = 200
              contrato_dt.precio = 200
              Contrato_dt.subtotal_bruto = 200
              Contrato_dt.subtotal_bruto_cf = 200
              Contrato_dt.subtotal_gral = 200
              Contrato_dt.subtotal_neto = 0
              Contrato_dt.subtotal_neto_cf = 0
       tiene = TRUE.
    END.
    IF tiene THEN DO:
        ASSIGN 
        contrato_hd.imp_bruto = 0
        contrato_hd.imp_iva = 0
        contrato_hd.imp_neto = 0
        contrato_hd.imp_total = 0.
    
        FOR EACH contrato_dt OF contrato_hd:
            ASSIGN
            contrato_hd.imp_bruto = contrato_hd.imp_bruto + contrato_dt.subtotal_bruto
            contrato_hd.imp_iva = contrato_hd.imp_iva + contrato_dt.precio_cf - contrato_dt.precio
            contrato_hd.imp_neto = contrato_hd.imp_neto + contrato_dt.subtotal_neto
            contrato_hd.imp_total = contrato_hd.imp_total + contrato_dt.subtotal_gral.
            compara.post = contrato_hd.imp_total.
        END.
    END.
END.
/*
FOR EACH compara WHERE compara.ant <> compara.post:
    DISPLAY compara.
END.
*/
    FOR EACH contrato_hd WHERE rige_desde = 03/01/2016 AND nro_tipo_evento = 3 AND
    resto_periodos = cant_periodos - 1:
        resto_periodos = cant_periodos.
    END.
