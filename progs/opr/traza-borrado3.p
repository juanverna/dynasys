{advtexto.i}
{extrae.i}
DEFINE STREAM bortarea.
DEFINE BUFFER btarea FOR tarea.
OUTPUT STREAM bortarea TO value("c:\ta" + STRING(TIME) + ".d").
FOR EACH tarea WHERE tarea.cdg_tipotarea = "H":
    FIND evento WHERE evento.nro_evento = evento.nro_identificacion NO-ERROR.
    IF NOT AVAILABLE evento THEN DO:
        EXPORT STREAM bortarea tarea.
        DELETE tarea.
    END.
END.









