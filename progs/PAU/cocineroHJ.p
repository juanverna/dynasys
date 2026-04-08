OUTPUT TO "CLIPBOARD".
DEFINE BUFFER bevento FOR evento.
DEFINE BUFFER btarea FOR tarea.
DEFINE VAR a1 AS INT LABEL "J".
DEFINE VAR a2 AS INT LABEL "H".
  
FOR EACH evento WHERE evento.nro_tipo_evento = 3 AND evento.sub_evento = 1 AND evento.frealizado > 12/16/2010 AND evento.frealizado <> ? AND NOT evento.anulado:
    FIND cliente OF evento.
    
    FIND FIRST tarea WHERE tarea.nro_cliente = cliente.nro_cliente AND tarea.cdg_tipotarea = "J" AND tarea.estado <> "D" NO-LOCK NO-ERROR.
    FIND btarea WHERE btarea.nro_cliente = cliente.nro_cliente AND btarea.cdg_tipotarea = "H" AND btarea.estado <> "D" NO-LOCK NO-ERROR.
/*IF AMBIGUOUS tarea OR AMBIGUOUS btarea THEN DO:
    DISPLAY cliente.direccion FORMAT "X(30)".
    DISPLAY "AJ" WHEN AMBIGUOUS tarea.
    DISPLAY "AH" WHEN AMBIGUOUS btarea.
END.*/

IF AVAILABLE tarea OR AVAILABLE btarea THEN NEXT.

EXPORT  evento.nro_evento evento.frealizado cliente.direccion FORMAT "X(30)" SKIP.
IF AVAILABLE tarea THEN put tarea.nro_tarea .
IF AVAILABLE btarea THEN put btarea.nro_tarea .
END. 

/*
FIND evento 237366.
FIND cliente OF evento.
FIND tarea OF cliente WHERE tarea.nro_identificacion = evento.nro_evento AND tarea.origen = "EVENTO" AND tarea.cdg_tipotarea = "H" AND tarea.estado <> "D".

DISPLAY evento.nro_evento tarea.nro_identificacion.
  */
