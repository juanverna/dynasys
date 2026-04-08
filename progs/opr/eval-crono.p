/*evaluador de CRONOC*/
/*Es practicamente lo mismo que el dia fijo*/
/*devuelve 1 para el dia y 0 para cualcuier otro dia*/
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
DEFINE VAR k AS CHAR NO-UNDO.
DEFINE VAR kk AS INT NO-UNDO.

vmobs = "".
esdesborde = FALSE.
i = DAY(fecha1).
k = ENTRY( MONTH(fecha1), ss ,"|" ).
DO kk = 1 TO NUM-ENTRIES(k,","):
    j = int( entry( kk , k , "," ) ) NO-ERROR.
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
END.
