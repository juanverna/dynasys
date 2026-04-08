/*evaluador de v-csemdiasC.w sin desborde ni cambios es exacto o nada*/
FUNCTION DOW returns int (dd as date , fwd as int ):
    IF weekday(dd) < fwd THEN return weekday(dd) + 8 - fwd .
    else return weekday(dd) - fwd + 1 .
END function.

FUNCTION fechado returns date ( tnMes AS int, tnAnio AS INT , tnDiaSem AS INT , tnOrdinal AS INT ) :
/*retorna una fecha data un dia de la semana y su ordinal en el mes*/
    define variable dd as date.
    define var daju as int.
    return DATE(  tnMes , 1 , tnAnio ) + tnOrdinal * 7 - dow( DATE(  tnMes , 1, tnAnio ) + tnOrdinal * 7 - 1 ,tnDiasem ).
END function.


FUNCTION validafecha returns DECIMAL (ss as character, fecha as date , OUTPUT esdesborde AS LOGICAL , OUTPUT vvmobs AS CHAR ):
/*se utilizarara como evaluador logico si cumple devuelve 1 sino 0 */
    /*1-meses 2 ordinal posicion 3 dias semana 4 manana o tarde 5 posicion*/
    /*si es un sabado retorna un valor de 2 y para los otros dis ade la semana un valor de 1*/
    
define var i as int no-undo.    
define var j as int no-undo.
define variable dd as date no-undo.
define var a0 as char no-undo.
define var a1 as char no-undo.
define var a2 as char no-undo.
DEFINE VAR aa1 AS CHAR NO-UNDO.
DEFINE VAR aa2 AS CHAR NO-UNDO.

DEF VAR k AS INT NO-UNDO.
define var p1 as DECIMAL EXTENT 5 no-undo. /*prioridades de las semanas*/
define var p2 as DECIMAL EXTENT 7 no-undo. /*prioridades de los dias*/

vvmobs = "".
/*meses validos*/
a0 = ENTRY( 1 , ss , "|" ).
IF a0 = "*" THEN a0 = "1.2.3.4.5.6.7.8.9.10.11.12" .
            ELSE IF a0 = "P" THEN a0 = "2.4.6.8.10.12".
            ELSE IF a0 = "I" THEN a0 = "1.3.5.7.9.11".
IF LOOKUP(STRING(MONTH(dd)), a0 , ".") = 0 THEN RETURN 0.
a1 = ENTRY( 2 , ss , "|" ).
a2=ENTRY( 3 , ss , "|" ).
IF a2="" THEN a2="23456".
IF a1="" THEN a1="1234".
a1=replace(a1,"4","45").
aa1 = "00000".
aa2 = "0000000".

/*asignando prioridades a las semanas para los desbordes*/
DO i = 1 to 5:
     p1[ i ] = IF INDEX(a1,STRING(i,"9")) <> 0 THEN 1 ELSE 0. 
     SUBSTRING(aa1,i,1) = STRING(p1[ i ],"9").
END.
DO i = 1 to 7:
     p2[ i ] = IF INDEX(a2,STRING(i,"9")) <> 0 THEN 1 ELSE 0. 
     SUBSTRING(aa2,i,1) = STRING(p2[ i ],"9").
END.

DO k = 1 TO 5:
    IF SUBSTRING( aa1 , k , 1 ) = "1" THEN DO:
        p1[ k ] = 1.
    END.
    ELSE DO:
       p1[ k ] = 0. /*no hay cambio de semana*/
    END. 
END.

DO k = 1 TO 7:
    IF SUBSTRING( aa2 , k , 1 ) = "1" THEN DO:
        p2[ k ] = 1.
    END.
    ELSE DO:
       p2[k] = 0. /*no hay posibilidad de cambio de dia*/
    END. 
END.

DO i = 1 to 5:
    DO j = 1 to 7:
        dd = fechado( month(fecha) , year(fecha),  j , i ).
        IF fecha = dd /*and month(dd) = month(fecha)*/ THEN DO:
            esdesborde = p1[i] * p2[j] <> 1.
            RETURN p1[i] * p2[j].
        END.
    END.
END.
return 0.
END function.
{tiempo.i}
define input parameter nroE as int no-undo.
DEFINE INPUT PARAMETER fecha AS DATE NO-UNDO.
DEFINE INPUT PARAMETER ss AS character NO-UNDO.
DEFINE OUTPUT PARAMETER v AS DECIMAL NO-UNDO.
DEFINE OUTPUT PARAMETER esdesborde AS LOGICAL NO-UNDO. 
DEFINE OUTPUT PARAMETER vmobs AS CHAR NO-UNDO.
DEFINE VAR vpri AS DATE NO-UNDO.
DEFINE VAR vult AS DATE NO-UNDO.
DEFINE VAR i AS INT NO-UNDO.
i = DAY(fecha).
esdesborde = FALSE.
IF NOT es_habil(fecha,"23456") THEN RETURN.
/*veo el rango primero si esta fuera del rango lo hecho*/

v = int( i >= int( ENTRY( 5 , ss , "|" )) AND i <= int( ENTRY( 6 , ss , "|" ))).
IF v = 0 THEN DO:
    vmobs = vmobs + " Fuera de Rango".
    RETURN.
END.

v = validafecha(ss,fecha, OUTPUT esdesborde, OUTPUT vmobs).
IF esdesborde THEN do: 
        v = 0.
        esdesborde = FALSE.
END.

