FUNCTION traza RETURNS CHAR ( nro AS INT):
DEFINE BUFFER bevento FOR evento.
DEFINE VAR traza AS CHAR.
    traza = "".
    FIND evento WHERE evento.nro_evento = nro NO-LOCK NO-ERROR.
    IF NOT AVAILABLE evento THEN RETURN "NO ENCONTRADA".
    FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "EC" NO-LOCK.
    FIND bevento WHERE bevento.nro_identificacion = evento.nro_evento AND
                       bevento.origen = "EVENTO" AND NOT evento.anulado AND
                       bevento.nro_cliente = evento.nro_cliente NO-LOCK NO-ERROR.
    IF AVAILABLE bevento THEN DO:
            traza = traza + ",EC:" + string(bevento.nro_evento).
            RETURN SUBSTRING(traza,2).
    END.
    /*por camino corto*/
    FIND tarea WHERE tarea.cdg_tipotarea = "H" AND tarea.nro_identificacion = evento.nro_evento AND tarea.estado <> "D" NO-ERROR.
    IF AVAILABLE tarea THEN DO:
            traza = traza + ",H:" + STRING(tarea.nro_tarea) + "|" + tarea.estado.
            FIND bevento WHERE bevento.nro_identificacion = tarea.nro_tarea AND bevento.origen = "TAREA" AND NOT bevento.anulado NO-ERROR.
            IF AVAILABLE bevento THEN do:
                FIND tipo_evento OF bevento no-lock.
                traza = traza + "," + tipo_evento.cdg_tipo_evento + ":"  + string(bevento.nro_evento) + "|" + IF evento.frealizado <> ? THEN "R" ELSE IF evento.fasignado <> ? THEN "A" ELSE "N".
            END.
    END.
    ELSE DO: /*camino largo*/
        IF AMBIGUOUS tarea THEN DO:
            traza = traza + ",H DUPLICADA".
        END.
        ELSE do:
            FIND tarea WHERE tarea.cdg_tipotarea = "J" AND tarea.origen = "EVENTO" and tarea.nro_identificacion = evento.nro_evento AND tarea.estado <> "D" NO-ERROR.
            IF NOT AVAILABLE tarea THEN DO:
                IF AMBIGUOUS tarea THEN DO:
                    traza = traza + ",J DUPLICADA".
                END.
            END.
            ELSE do:
                traza = traza + ",J:" + STRING(tarea.nro_tarea) + "|" + tarea.estado.
                FIND bevento WHERE bevento.nro_identificacion = tarea.nro_tarea AND bevento.origen = "TAREA" AND NOT bevento.anulado NO-ERROR.
                IF AVAILABLE bevento THEN do:
                        FIND tipo_evento OF bevento no-lock.
                        traza = traza + "," + tipo_evento.cdg_tipo_evento + ":"  + string(bevento.nro_evento)+ "|" + IF evento.frealizado <> ? THEN "R" ELSE IF evento.fasignado <> ? THEN "A" ELSE "N".
                        IF tipo_evento.cdg_tipo_evento <> "EC" THEN DO:
                            FIND tarea WHERE tarea.cdg_tipotarea = "H" AND bevento.nro_evento = tarea.nro_identificacion AND tarea.estado <> "D" NO-ERROR.
                            IF AVAILABLE tarea THEN DO:
                                IF AMBIGUOUS tarea THEN DO:
                                    traza = traza + ",Tarea H DUPLICADA".
                                END.
                                ELSE do:
                                    traza = traza + ",H:" + STRING(tarea.nro_tarea) + "|" + tarea.estado.
                                    FIND bevento WHERE bevento.nro_identificacion = tarea.nro_tarea AND bevento.origen = "TAREA" AND NOT bevento.anulado NO-ERROR.
                                    IF AVAILABLE bevento THEN do:
                                        FIND tipo_evento OF bevento no-lock.
                                        traza = traza + "," + tipo_evento.cdg_tipo_evento + ":"  + string(bevento.nro_evento) + "|" + IF evento.frealizado <> ? THEN "R" ELSE IF evento.fasignado <> ? THEN "A" ELSE "N".
                                        END.
                                    END.
                                END.
                            END.
                        END.
                END.
              END.
        END.
RETURN SUBSTRING(traza,2).
END.

/*funcion traza entreza la traza completa de un evento LT*/
{extrae.i}
DEFINE STREAM aa.
DEFINE BUFFER bevento FOR evento.
FOR EACH evento_protocolo, evento OF evento_protocolo:
IF evento.frealizado < 06/01/2011 THEN NEXT.
DISPLAY traza(evento.nro_evento) FORMAT "X(50)".
END.

