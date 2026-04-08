/*evaluador de v-fecha1C.w*/
/*Es practicamente lo mismo que el dia fijo*/
/*devuelve 1 para el dia y 0 para cualcuier otro dia*/
/*eval-fechai.p*/
define input parameter nroE as int no-undo.
DEFINE INPUT PARAMETER fecha1 AS DATE NO-UNDO.
DEFINE INPUT PARAMETER ss AS character NO-UNDO.
DEFINE OUTPUT PARAMETER v AS DECIMAL NO-UNDO.
DEFINE OUTPUT PARAMETER esdesborde AS LOGICAL NO-UNDO.
DEFINE OUTPUT PARAMETER vmobs AS CHAR NO-UNDO.
{tiempo.i}
DEFINE VAR diaposterior AS DATE.
DEFINE VAR I AS INT NO-UNDO.
DEFINE VAR j AS date NO-UNDO.

vmobs = "".
esdesborde = FALSE.
v = 0.
j = DATE(ss) NO-ERROR.
IF j = ?  THEN RETURN.

IF fecha1 <> j THEN DO:
    v = 0.
    RETURN.
END.
IF NOT es_habil(fecha1,"23456") THEN do:
    v = 0.
    RETURN.
END.
v = 1.
