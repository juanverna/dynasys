
    FIND tipo_evento WHERE cdg_tipo_evento = "RT".
    OUTPUT TO c:\temp\contratos.txt.

    FOR EACH contrato_hd  WHERE fecha_alta > 06/01/2014 AND contrato_hd.nro_tipo_evento = tipo_evento.nro_tipo_evento
        AND contrato_hd.estado = "A"  BREAK BY contrato_hd.fecha_alta :
        FIND FIRST evento WHERE evento.origen = "CONTRATO"AND evento.nro_identificacion = contrato_hd.nro_contrato AND
            evento.frealizado <> ? AND NOT evento.anulado NO-LOCK NO-ERROR.
        IF AVAILABLE evento THEN NEXT.
        DISPLAY contrato_hd.fecha_alta nro_contrato .
END.
