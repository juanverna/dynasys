DEFINE BUFFER cli1 FOR cliente.
DEFINE VAR desde AS CHAR.
DEFINE VAR hasta AS CHAR.
REPEAT:
    UPDATE desde hasta.
    FIND cliente WHERE cliente.cdg_cliente = desde NO-ERROR.
    IF NOT AVAILABLE cliente THEN DO:
            MESSAGE "Cliente desde no encontrado" VIEW-AS ALERT-BOX ERROR.
            UNDO,NEXT.
    END.
    FIND cli1 WHERE cli1.cdg_cliente = hasta NO-ERROR.
    IF NOT AVAILABLE cli1 THEN DO:
            MESSAGE "Cliente hasta no encontrado" VIEW-AS ALERT-BOX ERROR.
            UNDO,NEXT.
    END.
    FOR EACH rem_header WHERE rem_header.nro_cliente = cliente.nro_cliente:
    rem_header.nro_cliente = cli1.nro_cliente.
    rem_header.nro_admin = cli1.nro_admin.
    END.
    FOR EACH contrato_hd WHERE contrato_hd.nro_cliente = cliente.nro_cliente:
        contrato_hd.nro_cliente = cli1.nro_cliente.
    END.
    FOR EACH evento WHERE evento.nro_cliente = cliente.nro_cliente:
        evento.nro_cliente = cli1.nro_cliente.
    END.
    FOR EACH tarea WHERE tarea.nro_cliente = cliente.nro_cliente:
        tarea.nro_cliente = cli1.nro_cliente.
        tarea.nro_admin = cli1.nro_admin.
        IF tarea.cdg_tipotarea = "B" THEN do: DELETE tarea. NEXT. END.
        IF tarea.cdg_tipotarea = "C" THEN do: DELETE tarea. NEXT. END.
    END.
    FOR EACH fac_header WHERE fac_header.nro_cliente = cliente.nro_cliente.
        fac_header.nro_cliente = cli1.nro_cliente.
        fac_header.nro_admin = cli1.nro_admin.
    END.
    FOR EACH cta_cte WHERE cta_cte.nro_cliente = cliente.nro_cliente.
        cta_cte.nro_cliente = cli1.nro_cliente.
        cta_cte.nro_admin = cli1.nro_admin.
    END.
DELETE cliente.
END.
