    DEFINE VAR ttt AS INT.
    DEFINE VAR rr AS INT NO-UNDO.
    DEFINE VAR iii AS DECIMAL NO-UNDO.
    DEFINE STREAM aaaa.
    OUTPUT STREAM aaaa TO e:\conterrora.txt.
    sigue:
    FOR EACH contrato_hd WHERE fecha_baja = ? AND rige_hasta >= TODAY AND nro_tipo_evento = 3 
        AND rige_desde > 04/01/2018 BY nro_contrato:
        rr = 0.
        iii = 0.
        FOR EACH fac_header OF contrato_hd WHERE fac_header.nro_cliente = contrato_hd.nro_cliente AND tip_comprob BEGINS "F" BY fac_header.fecha:
            IF rr = 0 THEN iii = imp_total.
            rr = rr + 1.
        END.
        FOR EACH fac_header OF contrato_hd WHERE tip_comprob BEGINS "C":
            rr = rr - 1.
        END.
        IF rr > 1 THEN
        FOR last fac_header OF contrato_hd WHERE fac_header.nro_cliente = contrato_hd.nro_cliente AND tip_comprob BEGINS "F" BY fac_header.fecha:
             IF fac_header.imp_total = iii THEN DO:
                 PUT STREAM aaaa "Mal" contrato_hd.nro_contrato SKIP.
                 next sigue.
             END.
        END.

        IF cant_periodos - rr > 0 THEN NEXT.
        /*resto_periodos = cant_periodos - rr.*/
    
        IF resto_periodo <> cant_periodos - rr THEN DO:
            PUT STREAM aaaa contrato_hd.nro_contrato  rr FORMAT "-999" ( cant_periodos - rr) FORMAT "->9"
            resto_periodos SKIP.
        ttt = ttt + 1.
        END.
    END.
DISPLAY ttt.
