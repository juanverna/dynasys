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
OUTPUT STREAM bortarea TO value("c:\ta" + STRING(TIME) + ".d").

INPUT STREAM aa FROM c:\borrar.txt NO-ECHO.
REPEAT:
    SET STREAM aa nro tipo.
IF tipo = "E" THEN DO:
        FIND evento WHERE evento.nro_evento = nro NO-ERROR.
        IF NOT AVAILABLE evento THEN NEXT.
        EXPORT STREAM borevento evento.
        FOR EACH recurso_agenda OF evento:
            DELETE recurso_agenda.
        END.
        DELETE evento.
END.
ELSE DO:
        FIND tarea WHERE tarea.nro_tarea = nro NO-ERROR.
        IF NOT AVAILABLE tarea THEN NEXT.
        EXPORT STREAM bortarea tarea.
        DELETE tarea.

END.
END.
