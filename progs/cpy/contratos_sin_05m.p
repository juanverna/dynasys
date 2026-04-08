DEFINE VAR r AS INT.

/*OUTPUT TO "e:\wproceso\canepa3.txt".*/
    DEFINE BUFFER barticulo FOR articulo.
        DEFINE BUFFER bcontrato_dt FOR contrato_dt.
    FIND articulo WHERE articulo.cdg_articulo = "05m".
    FIND barticulo WHERE barticulo.cdg_articulo = "01f".
    FOR EACH contrato_hd WHERE contrato_hd.nro_tipo_evento = 1 AND fecha_baja = ? AND rige_hasta > TODAY AND estado = "A" and
        cant_periodo = 0 NO-LOCK:
    FIND FIRST contrato_dt WHERE contrato_hd.nro_contrato = contrato_dt.nro_contrato AND contrato_dt.nro_articulo = articulo.nro_articulo  NO-ERROR.
        IF AVAILABLE contrato_dt THEN DO:
            IF precio_cf <> 0 AND NOT CAN-FIND(bcontrato_dt WHERE contrato_hd.nro_contrato = bcontrato_dt.nro_contrato AND ROWID(contrato_dt)<>ROWID(bcontrato_dt) ) THEN DO:
               /* DISPLAY contrato_hd.nro_contrato contrato_hd.imp_total.*/
                RUN arregla1.p ( contrato_hd.nro_contrato).
            END.           
        END.
        
    
END.
        OUTPUT CLOSE.


