/*evaluador de v-crango.w*/
/*se utilizarara como evaluador logico si cumple devuelve 1 sino 0 */
/*tiene una campana decreciente a ambos lados de 5 dias*/
define input parameter nroE as int no-undo.
DEFINE INPUT PARAMETER fecha AS DATE NO-UNDO.
DEFINE INPUT PARAMETER ss AS character NO-UNDO.
DEFINE OUTPUT PARAMETER v AS DECIMAL NO-UNDO.
DEFINE VAR I AS INT NO-UNDO.
DEFINE VAR j AS INT NO-UNDO.
DEFINE VAR f AS INT NO-UNDO.
i = DAY(fecha).
j = INT(ss) NO-ERROR.
f = day(date(month(DATE(MONTH(fecha),1,YEAR(fecha)) + 32 ),1,YEAR(DATE(MONTH(fecha),1,YEAR(fecha)) + 32 )) - 1).
v = (IF int( ENTRY( 1 , ss , "|" )) - 1 > 5 THEN 5 ELSE int( ENTRY( 1 , ss , "|" )) - 1) +
    (IF f - int( ENTRY( 2 , ss , "|" )) > 5 THEN 5 ELSE f - int( ENTRY( 2 , ss , "|" )) - 1) / f.
