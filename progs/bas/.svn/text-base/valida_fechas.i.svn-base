/*trigguer generico de validacion de fechas*/
DEFINE VAR max__fech AS INT NO-UNDO.
DEFINE VAR min__fech AS INT NO-UNDO.

ON LEAVE ANYWHERE DO:
IF CAN-QUERY(SELF,"DATA-TYPE") AND CAN-QUERY(SELF,"INPUT-VALUE") THEN DO:
    IF self:DATA-TYPE = "date" THEN DO:
        RUN getparametro_n.p("FECHMAX0",OUTPUT max__fech).
        RUN getparametro_n.p("FECHMIN0",OUTPUT min__fech).
        IF SELF:INPUT-VALUE > TODAY + MAX__fech THEN DO:
            MESSAGE "La fecha supera la maxima admitida por FECHMAX0" max__fech VIEW-AS ALERT-BOX ERROR.
            RETURN NO-APPLY.
        END.
        IF SELF:INPUT-VALUE < TODAY - MIN__fech THEN DO:
            MESSAGE "La fecha es menor que la minima admitida por FECHMIN0" min__fech VIEW-AS ALERT-BOX ERROR.
            RETURN NO-APPLY.
        END.
    END.
END.
END.
