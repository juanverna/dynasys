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
    FIND cliente WHERE upper(trim(cliente.cdg_cliente)) = upper(TRIM(a1)) NO-ERROR.
    IF NOT AVAILABLE cliente  THEN DO:
           PUT STREAM mal "No registrado;" k ";" a1 SKIP.
           NEXT.
       END.
                 FIND cliente_otros_datos OF cliente NO-ERROR.
                 IF NOT AVAILABLE cliente_otros_datos THEN DO:
                     CREATE cliente_otros_datos.
                     ASSIGN cliente_otros_datos.nro_cliente = cliente.nro_cliente
                            cliente_otros_datos.cuerpo = "".
                 END.

                 IF cliente_otros_datos.observaciones = "" THEN DO:
                      cliente_otros_datos.observaciones = a8 .
                      Cliente_otros_datos.Acceso = a4.
                 END.
   END.

