DEFINE VARIABLE  hms_hora AS CHARACTER.
DEFINE VARIABLE  mascara  AS CHARACTER. /* Indica formato y si hay segundos */
DEFINE VARIABLE  hor_hora AS INTEGER.
DEFINE VARIABLE  rc AS INTEGER.

REPEAT:
    UPDATE hms_hora mascara.
    RUN valida_hora.p ( INPUT-OUTPUT hms_hora, INPUT mascara, OUTPUT hor_hora, OUTPUT rc ).
    DISPLAY hor_hora rc hms_hora.
    IF rc <> 0
    THEN RUN ponmensj.p ( "HHMM" + STRING(rc,"999") ).
END.
