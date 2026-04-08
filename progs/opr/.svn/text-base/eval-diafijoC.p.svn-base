/*evaluador de v-diajoC.w*/

define input parameter nroE as int no-undo.
DEFINE INPUT PARAMETER fecha1 AS DATE NO-UNDO.
DEFINE INPUT PARAMETER ss AS character NO-UNDO.
DEFINE OUTPUT PARAMETER v AS DECIMAL NO-UNDO.
DEFINE OUTPUT PARAMETER esdesborde AS LOGICAL NO-UNDO.
DEFINE OUTPUT PARAMETER vmobs AS CHAR NO-UNDO.
{tiempo.i}

DEFINE VAR diaposterior AS DATE.
DEFINE VAR I AS INT NO-UNDO.
DEFINE VAR j AS INT NO-UNDO.

vmobs = "".
esdesborde = FALSE.
i = DAY(fecha1).
j = INT(ss) NO-ERROR.
v = 0.
IF j = 0  THEN RETURN.
IF NOT es_habil(fecha1,"23456") THEN do:
    v = 0.
    RETURN.
END.
IF NOT es_habil(DATE(MONTH(fecha1),j,YEAR(fecha1)),"23456") THEN DO:
    diaposterior = suma_dia_habil(DATE(MONTH(fecha1),j,YEAR(fecha1)),1,"23456").
    IF diaposterior = fecha1 THEN do:
           v = 1.
           RETURN.
    END.
END.
IF i = j THEN do:
    v = 1.
    RETURN.
END.


