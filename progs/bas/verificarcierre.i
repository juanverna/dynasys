    {stcierrecontable.i}
    DEFINE VARIABLE v-estado_cierre LIKE Cierre_diario.cdg_estado_cierre.

    RUN verificar_cierre_contable.p ( INPUT  {1},
                                      INPUT  "{3}",
                                      INPUT  {2},
                                      OUTPUT v-estado_cierre ).
    IF v-estado_cierre > stcierre_abierto
    THEN DO:
        RUN PONMENSJ.P (INPUT "CIER011").
        RETURN.
    END.
