/*evaluador de v-crangoC.w*/
/*se utilizarara como evaluador logico si cumple devuelve 1 sino 0 no hay desborde*/
define input parameter nroE as int no-undo.
DEFINE INPUT PARAMETER fecha AS DATE NO-UNDO.
DEFINE INPUT PARAMETER ss AS character NO-UNDO.
DEFINE OUTPUT PARAMETER v AS DECIMAL NO-UNDO.
DEFINE OUTPUT PARAMETER esdesborde AS LOGICAL NO-UNDO.
DEFINE OUTPUT PARAMETER vmobs AS CHAR NO-UNDO.
DEFINE VAR I AS INT NO-UNDO.
DEFINE VAR j AS INT NO-UNDO.
{tiempo.i}
esdesborde = FALSE.
i = DAY(fecha).
IF NOT es_habil(fecha,"23456") THEN RETURN.
IF i >= int( ENTRY( 1 , ss , "|" )) AND i <= int( ENTRY( 2 , ss , "|" )) THEN v = 1.0.

