INPUT FROM c:\tanquesfin.csv.
DEFINE STREAM mal.
OUTPUT STREAM mal TO c:\tanquesmalfin.csv.
DEFINE VAR a1 AS CHAR FORMAT "X(40)" NO-UNDO.
DEFINE VAR a4 AS CHAR FORMAT "X(40)" NO-UNDO.
DEFINE VAR a5 AS CHAR FORMAT "X(40)" NO-UNDO.
DEFINE VAR a7 AS CHAR FORMAT "X(40)"  NO-UNDO.
DEFINE VAR a8 AS CHAR FORMAT "X(40)"  NO-UNDO.
DEFINE VAR a10 AS CHAR FORMAT "X(40)"  NO-UNDO.
DEFINE VAR a11 AS CHAR FORMAT "X(40)"  NO-UNDO.
DEFINE VAR a12 AS CHAR FORMAT "X(40)"  NO-UNDO.
DEFINE VAR a13 AS CHAR FORMAT "X(40)"  NO-UNDO.
DEFINE VAR a6 AS CHAR FORMAT "X(50)" NO-UNDO.
DEFINE VAR aac AS CHAR FORMAT "X(50)" NO-UNDO.
DEFINE VAR f5 AS DATE NO-UNDO.
DEFINE VAR nn AS INT.
DEFINE VAR k AS INT NO-UNDO.
DEFINE VAR i AS INT NO-UNDO.
SESSION:IMMEDIATE-DISPLAY = TRUE.
REPEAT :
    k = k + 1.
    IF k > 1047 THEN LEAVE.
    IMPORT DELIMITER ";" a1 ^ ^ a4 a5 a6 aac a7 a8 ^ a10 a11 a12 a13.
    FIND contrato_hd WHERE contrato_hd.nro_contrato = INT(aac) NO-LOCK NO-ERROR.
    IF NOT AVAILABLE contrato_hd  THEN DO:
        PUT STREAM mal "No registrado;" k ";" a1 SKIP.
        NEXT.
    END.
    FIND cliente OF contrato_hd .
    f5 = DATE(a5) NO-ERROR.
    IF ERROR-STATUS:ERROR THEN DO:
        PUT STREAM mal "Fecha invalida ;" k ";" a1 ";" a6 ";" a5  SKIP.
        NEXT.
    END.
    nn = 0.
    IF f5 >= TODAY THEN DO: 
        PUT STREAM mal "Fecha a futuro;"  k ";" a1 ";" a6 ";" a5 SKIP.
        NEXT.
    END.
/*creando*/

    CREATE evento.
          ASSIGN 
              evento.origen = "CONTRATO"
              Evento.Duracion = 240
              Evento.FAsignado = f5
              Evento.FRealizado = f5
              Evento.FCreado = TODAY
              evento.fmin = f5
              evento.fmax = f5
              Evento.nro_evento = NEXT-VALUE(proximo_evento)
              Evento.nro_evento_padre = 0
              Evento.nro_identificacion = contrato_hd.nro_contrato
              Evento.nro_tipo_evento = 3 
              Evento.Recursos = a10
              evento.sub_evento = 1
              evento.evaluar = true
              evento.nro_cliente = contrato_hd.nro_cliente.
              evento.observacion = a4.
              evento.observacion = evento.observacion + ( IF evento.observacion <> "" THEN "-" ELSE "" ) +  IF a11 <> "" THEN " Analisis Agua:" + a11 ELSE "" .
              evento.observacion = evento.observacion + ( IF evento.observacion <> "" THEN "-" ELSE "" ) +  IF a7 <> "" THEN "Tanques:" + a7 ELSE "".
              FIND cliente_otros_datos OF cliente NO-ERROR.
              IF NOT AVAILABLE cliente_otros_datos THEN DO:
                  CREATE cliente_otros_datos.
                  ASSIGN cliente_otros_datos.nro_cliente = cliente.nro_cliente
                         cliente_otros_datos.cuerpo = "".
              END.
              cliente_otros_datos.tanques = INT(a7) NO-ERROR.

              DO i = 1 TO NUM-ENTRIES(evento.recursos):
              FIND recurso_agenda WHERE recurso_agenda.cdg_recurso = ENTRY(i,evento.recurso) AND
                  recurso_agenda.fecha = evento.fasignado AND
                  recurso_agenda.nro_evento = evento.nro_evento NO-LOCK NO-ERROR.
                  IF NOT AVAILABLE recurso_agenda THEN do:
                      CREATE recurso_agenda.
                      ASSIGN recurso_agenda.cdg_recurso = ENTRY(i,evento.recurso)
                             recurso_agenda.fecha = evento.fasignado
                             recurso_agenda.nro_evento = evento.nro_evento.
                  END.
          END.
END.
