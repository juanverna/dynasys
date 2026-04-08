{advtexto.i}
{extrae.i}
DEFINE var nro AS INT.
DEFINE VAR tipo AS CHAR.
DEFINE STREAM aa.
DEFINE STREAM borevento.
DEFINE STREAM bortarea.
DEFINE BUFFER bevento FOR evento.
DEFINE VAR b1 AS CHAR FORMAT "X(20)".
DEFINE VAR b2 AS CHAR FORMAT "X(20)".
OUTPUT STREAM borevento TO value("c:\ev" + STRING(TIME) + ".d").
FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "EL".
FOR EACH evento WHERE evento.nro_tipo_evento = tipo_evento.nro_tipo_evento:
    FIND tarea WHERE tarea.nro_tarea = evento.nro_identificacion NO-ERROR.
    IF NOT AVAILABLE tarea THEN DO:
        EXPORT STREAM borevento evento.
        DELETE evento.
    END.
END.









