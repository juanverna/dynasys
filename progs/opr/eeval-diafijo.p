/*evaluador de v-diajo.w probabilidades de que no ocurra*/
/*la campana solo es a derecha*/
/*devuelve 1 para el dia 
0,8 para el entorno de undia 0,6 para dos dias 0.4 para tres dias salvo si es sabado no puede desbordar en sabado ni domingo
0.2 para cuatro dias sino 0 */
/*camana a izq y derecha*/
define input parameter nroE as int no-undo.
DEFINE INPUT PARAMETER fecha AS DATE NO-UNDO.
DEFINE INPUT PARAMETER ss AS character NO-UNDO.
DEFINE OUTPUT PARAMETER v AS DECIMAL NO-UNDO.

DEFINE VAR I AS INT NO-UNDO.
DEFINE VAR j AS INT NO-UNDO.
DEFINE VAR f AS INT NO-UNDO.

f = day(date(month(DATE(MONTH(fecha),1,YEAR(fecha)) + 32 ),1,YEAR(DATE(MONTH(fecha),1,YEAR(fecha)) + 32 )) - 1).
i = DAY(fecha).
j = INT(ss) NO-ERROR.
v = ( j - 1 + IF ( f - j ) < 5 THEN f - j ELSE 5 ) / f .
