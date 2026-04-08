RETURN.
{advtexto.i}
{extrae.i}
DEFINE TEMP-TABLE et
FIELD nro AS INT
FIELD tipo AS CHAR.
DEFINE STREAM aa.
DEFINE BUFFER bevento FOR evento.
DEFINE VAR b1 AS CHAR FORMAT "X(20)".
DEFINE VAR b2 AS CHAR FORMAT "X(20)".
DEFINE VAR a AS INT.

INPUT STREAM aa FROM c:\dupli.txt NO-ECHO.
REPEAT:
    SET STREAM aa a.
    FIND evento_protocolo WHERE evento_protocolo.nro_protocolo = a.
    FIND evento OF evento_protocolo.
    IF evento.frealizado >= 06/01/2011 THEN NEXT.
    evento.trae_libro = TRUE.
    /*por camino corto*/
    FIND tarea WHERE tarea.cdg_tipotarea = "H" AND tarea.nro_identificacion = evento.nro_evento NO-ERROR.
    IF AVAILABLE tarea THEN DO:
            CREATE et. et.nro = tarea.nro_tarea. et.tipo = "T".
            FIND bevento WHERE bevento.nro_identificacion = tarea.nro_tarea AND bevento.origen = "TAREA" AND NOT bevento.anulado NO-ERROR.
            IF AVAILABLE bevento THEN do:
                FIND tipo_evento OF bevento no-lock.
               CREATE et. et.nro = evento.nro_evento. et.tipo = "E".
            END.
    END.
    ELSE DO: /*camino largo*/
        IF AMBIGUOUS tarea THEN DO:
            FOR EACH tarea WHERE tarea.cdg_tipotarea = "H" AND tarea.nro_identificacion = evento.nro_evento:
                CREATE et. et.nro = tarea.nro_tarea. et.tipo = "T".
            END.
        END.
        ELSE do:
            FIND tarea WHERE tarea.cdg_tipotarea = "J" AND tarea.origen = "EVENTO" and tarea.nro_identificacion = evento.nro_evento NO-ERROR.
            IF NOT AVAILABLE tarea THEN DO:
                FOR EACH tarea WHERE tarea.cdg_tipotarea = "J" AND tarea.origen = "EVENTO" and tarea.nro_identificacion = evento.nro_evento:
                    CREATE et. et.nro = tarea.nro_tarea. et.tipo = "T".
                END.
            END.
            ELSE do:
                    CREATE et. et.nro = tarea.nro_tarea. et.tipo = "T".
                FIND bevento WHERE bevento.nro_identificacion = tarea.nro_tarea AND bevento.origen = "TAREA" AND NOT bevento.anulado NO-ERROR.
                IF AVAILABLE bevento THEN do:
                        FIND tipo_evento OF bevento no-lock.
                        CREATE et. et.nro = evento.nro_evento. et.tipo = "E".
                        IF tipo_evento.cdg_tipo_evento <> "EC" THEN DO:
                            FIND tarea WHERE tarea.cdg_tipotarea = "H" AND bevento.nro_evento = tarea.nro_identificacion AND tarea.estado <> "D" NO-ERROR.
                            IF AVAILABLE tarea THEN DO:
                                    FOR EACH tarea WHERE tarea.cdg_tipotarea = "H" AND tarea.nro_identificacion = evento.nro_evento:
                                        CREATE et. et.nro = tarea.nro_tarea. et.tipo = "T".
                                    END.
                                END.
                                ELSE do:
                                    CREATE et. et.nro = tarea.nro_tarea. et.tipo = "T".                                    FIND bevento WHERE bevento.nro_identificacion = tarea.nro_tarea AND bevento.origen = "TAREA" AND NOT bevento.anulado NO-ERROR.
                                    IF AVAILABLE bevento THEN do:
                                        FIND tipo_evento OF bevento no-lock.
                                        CREATE et. et.nro = evento.nro_evento. et.tipo = "E".
                                    END.
                                END.
                            END.
                        END.
                END.
              END.
        END.

END.
OUTPUT TO c:\borrar.txt.
FOR EACH et:
DISPLAY et.nro et.tipo.
END.
