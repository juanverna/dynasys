{advtexto.i}
{extrae.i}
OUTPUT TO c:\k.txt.

DEFINE STREAM aa.
DEFINE BUFFER bevento FOR evento.
DEFINE VAR b1 AS CHAR FORMAT "X(20)".
DEFINE VAR b2 AS CHAR FORMAT "X(20)".
DEFINE VAR traza AS CHAR FORMAT "X(50)".
DEFINE VAR a AS INT.
INPUT STREAM aa FROM c:\dupli.txt.
REPEAT:
    SET STREAM aa a.
    FIND evento_protocolo WHERE evento_protocolo.nro_protocolo = a.
    FIND evento OF evento_protocolo NO-LOCK.

    traza = "LT:" + STRING(evento.nro_evento).
/*IF evento.nro_evento = 244907 THEN DO:
END.*/
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
            traza = traza + ",H:" + STRING(tarea.nro_tarea).
            FIND bevento WHERE bevento.nro_identificacion = tarea.nro_tarea AND bevento.origen = "TAREA" AND NOT bevento.anulado NO-ERROR.
            IF AVAILABLE bevento THEN do:
                FIND tipo_evento OF bevento no-lock.
                traza = traza + "," + tipo_evento.cdg_tipo_evento + ":"  + string(bevento.nro_evento).
                                IF bevento.frealizado = ? THEN DO:
                                    bevento.frealizado = TODAY.
                                    bevento.fasignado = TODAY.
                                    agregaAdvTexto( "Cerrado por control",bevento.observacion). 
                                END.
            END.
            ELSE DO:
                RUN crea_EL.
            END.
    END.
    ELSE DO: /*camino largo*/
        IF AMBIGUOUS tarea THEN DO:
            traza = traza + ",Tarea H DUPLICADA".
        END.
        ELSE do:
            FIND tarea WHERE tarea.cdg_tipotarea = "J" AND tarea.origen = "EVENTO" and tarea.nro_identificacion = evento.nro_evento AND tarea.estado <> "D" NO-ERROR.
            IF NOT AVAILABLE tarea THEN DO:
                IF AMBIGUOUS tarea THEN DO:
                    traza = traza + ",Tarea J DUPLICADA".
                END.
            END.
            ELSE do:
                traza = traza + ",J:" + STRING(tarea.nro_tarea).
                FIND bevento WHERE bevento.nro_identificacion = tarea.nro_tarea AND bevento.origen = "TAREA" AND NOT bevento.anulado NO-ERROR.
                IF AVAILABLE bevento THEN do:
                        FIND tipo_evento OF bevento no-lock.
                        traza = traza + "," + tipo_evento.cdg_tipo_evento + ":"  + string(bevento.nro_evento).
                        IF tipo_evento.cdg_tipo_evento <> "EC" THEN DO:
                            FIND tarea WHERE tarea.cdg_tipotarea = "H" AND bevento.nro_evento = tarea.nro_identificacion AND tarea.estado <> "D" NO-ERROR.
                            IF AVAILABLE tarea THEN DO:
                                IF AMBIGUOUS tarea THEN DO:
                                    traza = traza + ",Tarea H DUPLICADA".
                                END.
                                ELSE do:
                                    traza = traza + ",H:" + STRING(tarea.nro_tarea).
                                    FIND bevento WHERE bevento.nro_identificacion = tarea.nro_tarea AND bevento.origen = "TAREA" AND NOT bevento.anulado NO-ERROR.
                                    IF AVAILABLE bevento THEN do:
                                        FIND tipo_evento OF bevento no-lock.
                                        traza = traza + "," + tipo_evento.cdg_tipo_evento + ":"  + string(bevento.nro_evento).
                                        IF bevento.frealizado = ? THEN DO:
                                            bevento.frealizado = TODAY.
                                            bevento.fasignado = TODAY.
                                            agregaAdvTexto( "Cerrado por control",bevento.observacion). 
                                        END.
                                    END.
                                    ELSE DO:
                                          RUN crea_EL.
                                    END.
                                END.
                            END.
                            ELSE DO: /*no hay tarea H para el RL debe estas abierto*/
                                            IF bevento.frealizado = ? THEN DO:
                                            bevento.frealizado = TODAY.
                                            bevento.fasignado = TODAY.
                                            agregaAdvTexto( "Cerrado por control",bevento.observacion). 
                                        END.
                            END.
                        END.
                END.
              END.
        END.
    END.

    DISPLAY a traza.
END.

PROCEDURE crea_EL:
DEFINE VAR precursos AS CHAR.
FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "EL" NO-LOCK.
 precursos  =  entry(1,extrae("frecursos" , tarea.dato)) .
IF precursos = "" THEN precursos = "500".
IF tarea.fecha_prevista = ? THEN tarea.fecha_prevista = TODAY.
CREATE bevento.
        ASSIGN bevento.nro_evento = NEXT-VALUE(proximo_evento)
               bevento.nro_tipo_evento = tipo_evento.nro_tipo_evento
               bevento.fasignado = tarea.fecha_prevista
               bevento.nro_identificacion = tarea.nro_tarea /*porque deviene de una tarea tiene numero de tarea sino tiene 0*/
               bevento.origen = "TAREA"
               bevento.nro_cliente = tarea.nro_cliente
               bevento.FCreado = TODAY
               bevento.periodo = YEAR(today) * 100 + MONTH(today)
               bevento.fmin = TODAY
               bevento.fmax = TODAY + 20 /*fijo cualquier cosa se vera*/
               bevento.recurso = precursos
               bevento.observacion = tarea.descripcion.
               bevento.duracion = 15.
               bevento.leyenda = tarea.leyenda.
               tarea.destino = "EVENTO".
               tarea.nro_destino = bevento.nro_evento.
               bevento.turno = "**".
               Tarea.estado = "R".
               tarea.descripcion = agregaAdvTexto("Cerro " + "EventoEL:" + string(bevento.nro_evento),tarea.descripcion).
              IF Tarea.fecha_resuelto = ? THEN Tarea.fecha_resuelto = TODAY.

                CREATE recurso_agenda.
                ASSIGN recurso_agenda.cdg_recurso = precursos
                       recurso_agenda.Fecha = bevento.fasignado
                       recurso_agenda.nro_evento = bevento.nro_evento.
                RELEASE recurso_agenda.
END PROCEDURE.


