
 DEFINE VAR a AS CHAR.
 DEFINE BUFFER barticulo FOR articulo.
 DEFINE BUFFER bcontrato_dt FOR contrato_hd.
DEFINE VAR r05m AS INT.
DEFINE VAR rp AS DECIMAL NO-UNDO.
DEFINE TEMP-TABLE r
    FIELD r AS INT
    FIELD n AS int
    FIELD c AS CHAR.
FIND articulo WHERE cdg_articulo = "05m".
r05m = articulo.nro_articulo.
   FOR EACH contrato_hd WHERE contrato_hd.nro_tipo_evento = 1 AND fecha_baja = ? AND rige_hasta > TODAY AND estado = "A" and
        cant_periodo = 0 NO-LOCK:
       FOR EACH contrato_dt OF contrato_hd.
           IF NOT CAN-FIND(contrato_dt OF contrato_hd WHERE contrato_dt.nro_articulo = r05m ) THEN NEXT.
           FIND articulo OF contrato_dt.
           IF cdg_articulo = "01F" THEN NEXT.
           IF cdg_articulo = "05m" THEN NEXT.
           FIND r WHERE r.r = contrato_hd.nro_contrato NO-ERROR.
           IF NOT AVAILABLE r THEN DO: 
               CREATE r.
               ASSIGN r.r = contrato_hd.nro_contrato
                      r.c = articulo.cdg_articulo
                      r.n = articulo.nro_articulo.
           END.
       END.
   END.
   
   FOR EACH r:
       FIND contrato_hd WHERE contrato_hd.nro_contrato = r.r.
       FIND FIRST contrato_dt WHERE contrato_dt.nro_contrato = r.r AND contrato_dt.nro_articulo = r05m.
       rp = contrato_dt.precio_cf.
       DELETE contrato_dt.
       FIND contrato_dt OF contrato_hd WHERE contrato_dt.nro_articulo = r.n.
       contrato_dt.precio_cf = contrato_dt.precio_cf + rp.
       FIND articulo WHERE articulo.cdg_articulo = r.c + "m".
       contrato_dt.nro_articulo = articulo.nro_articulo.
       contrato_dt.detallada  = articulo.detallada.
       contrato_dt.documental  = articulo.documental.
       ASSIGN  contrato_dt.precio = TRUNCATE( contrato_dt.precio_cf / 1.21 , 2 )
            contrato_dt.subtotal_bruto = contrato_dt.precio
            contrato_dt.subtotal_bruto_cf = contrato_dt.precio_cf
            contrato_dt.subtotal_neto_cf = contrato_dt.precio_cf
            contrato_dt.subtotal_gral = contrato_dt.subtotal_bruto_cf
            contrato_dt.subtotal_neto = contrato_dt.precio
            contrato_dt.subtotal_neto_cf = contrato_dt.precio_cf.
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
            END.
    END.
 
   
 
