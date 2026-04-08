/*recuento obleas*/
DEFINE TEMP-TABLE tt 
    FIELD mes AS INT
    FIELD nro_tipoevento AS INT
    FIELD url1 AS char.
DEFINE TEMP-TABLE res
    FIELD mes AS INT
    FIELD cant AS INT
    FIELD nro_tipoevento AS INT
    INDEX mes mes nro_tipoevento.
FOR EACH evento WHERE evento.letraprefijo = "ELE" AND nro_certif <> 0 AND NOT anulado:
    FIND tt WHERE tt.url1 = evento.url1 NO-ERROR.
    IF NOT AVAILABLE tt THEN do:
        CREATE tt.
        DISPLAY string(base64-DECODE(EVENTO.URL1)).
            ASSIGN tt.mes = MONTH(evento.foblea)
                   tt.nro_tipoevento = evento.nro_tipo_evento
                   tt.url1 = evento.url1.
            IF tt.mes = ? THEN tt.mes = MONTH(evento.frealizado).
    END.
END.
FOR EACH tt:
    FIND res WHERE res.mes = tt.mes AND tt.nro_tipoevento = res.nro_tipoevento NO-ERROR.
    IF NOT AVAILABLE res THEN DO:
        CREATE res.
        BUFFER-COPY tt TO res.
    END.
    res.cant = res.cant + 1.
END.
FOR EACH res BY mes:
    DISPLAY res.
END.
