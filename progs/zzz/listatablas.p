DEFINE VARIABLE que_tabla AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE salida    AS CHARACTER.
REPEAT:
    UPDATE que_tabla.
    IF que_tabla <> ""
    THEN DO:
        salida = "c:\sic-temp\" + que_tabla + ".txt".
        OUTPUT TO VALUE(salida).
        FOR EACH _File WHERE _File._File-name = que_tabla:
            FOR EACH _Field OF _File:
                DISPLAY _Field._Field-name
                        _Field._Data-type
                        _Field._Format
                        _Field._Desc
                        WITH STREAM-IO WIDTH 160.
            END.
        END.
        OUTPUT CLOSE.
        OUTPUT TO TERMINAL.
    END.
    ELSE DO:
        MESSAGE "PASANDO ESTABA LA GANZA" VIEW-AS ALERT-BOX TITLE "CUCUCU".
        LEAVE.
    END.
END.
