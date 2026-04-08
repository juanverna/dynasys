/*evaluador de v-diajo.w*/
/*la campana solo es a derecha*/
/*devuelve 1 para el dia 
0,8 para el entorno de undia 0,6 para dos dias 0.4 para tres dias salvo si es sabado no puede desbordar en sabado ni domingo
0.2 para cuatro dias sino 0 */
/*camana a izq y derecha*/
define input parameter nroE as int no-undo.
DEFINE INPUT PARAMETER fecha AS DATE NO-UNDO.
DEFINE INPUT PARAMETER ss AS character NO-UNDO.
DEFINE OUTPUT PARAMETER v AS DECIMAL NO-UNDO.
DEFINE OUTPUT PARAMETER esdesborde AS LOGICAL NO-UNDO.
DEFINE OUTPUT PARAMETER vmobs AS CHAR NO-UNDO.

DEFINE VAR I AS INT NO-UNDO.
DEFINE VAR j AS INT NO-UNDO.

vmobs = "".
esdesborde = FALSE.
i = DAY(fecha).
j = INT(ss) NO-ERROR.
v = 0.


IF j = 0  THEN RETURN.
IF WEEKDAY(fecha) = 7 THEN do:
    v = 0.
    RETURN.
END.
IF WEEKDAY(fecha) = 1 THEN do:
    v = 0.
    RETURN.
END.
IF i >= j THEN DO:
    i = i - j.
    IF  i  <= 5 THEN v  = 1.00 - DECIMAL( i ) * 0.20.
END.
IF v = 1 THEN RETURN.
IF v <> 0 THEN DO:
        esdesborde = TRUE.
        vmobs = "DF[" + ss + ( IF v <> 1 THEN "<->" + string( i , "99" ) ELSE "" ) + "]".
    END.
ELSE esdesborde = FALSE.
