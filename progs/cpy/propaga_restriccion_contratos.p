    DEFINE BUFFER b FOR contrato_restriccion.
    DEFINE VAR d AS INT64.
    DEFINE TEMP-TABLE cc
        FIELD n AS INT64
        INDEX n n .

    FOR EACH contrato_hd WHERE contrato_hd.rige_desde >= 01/01/2016 AND nro_tipo_evento = 3 BREAK BY nro_cliente:
        IF FIRST-OF(contrato_hd.nro_cliente) THEN
            EMPTY TEMP-TABLE cc.
        CREATE cc.
        cc.n = contrato_hd.nro_contrato.
        IF LAST-OF(contrato_hd.nro_cliente) THEN DO:
            FIND FIRST cc.
            d = cc.n.
            FOR EACH cc WHERE cc.n > d:
                FOR EACH contrato_restriccion WHERE contrato_restriccion.nro_contrato = d:
                    FIND b WHERE b.nro_contrato = cc.n AND b.nro_restriccion = contrato_restriccion.nro_restriccion AND
                        b.sub_evento = contrato_restriccion.sub_evento NO-ERROR.
                    IF AVAILABLE b THEN next.
                    CREATE b.
                    BUFFER-COPY contrato_restriccion EXCEPT contrato_restriccion.nro_contrato TO b
                        ASSIGN b.nro_contrato  = cc.n.
                END.
                d = cc.n.
            END.
        END.
    END.
