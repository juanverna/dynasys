/*evaluador de v-csemdias.w*/
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
DEFINE VAR pr1 AS int NO-UNDO.
DEFINE VAR pr2 AS int NO-UNDO.
DEFINE VAR aa1 AS CHAR NO-UNDO.
DEFINE VAR aa2 AS CHAR NO-UNDO.
DEFINE VAR prSabado AS int NO-UNDO. /*multiplicador de prioridad para el dia sabado si esta explictamente especificado tiene un valor del doble*/
DEF VAR k AS INT NO-UNDO.
define var p1 as DECIMAL EXTENT 5 no-undo. /*prioridades de las semanas*/
define var p2 as DECIMAL EXTENT 7 no-undo. /*prioridades de los dias*/

vvmobs = "".
/*son los puntajes para cada dia en cada posicion, el puntaje final el p1[]*/
/*si la restriccion esta presente y hay coincidencia se le asigna 1 al valor, sino 0.8 EXP a la distancia en semanas ( cuantas semanas la separan del objetivo) */
/*lo mismo ocurre con el cambio de dia estando despues del ultimo cambio de semana si la restriccion esta presente y hay coincidencia se le asigna 1 al valor, sino 0.8 EXP a la distancia en semanas ( cuantas semanas la separan del objetivo) */
/*ejemplos
x   x   x   1   1
.15 .3  .6  1   1

el valor es .6 / distancia al uno.
*/
/*meses validos*/
a0 = ENTRY( 1 , ss , "|" ).
IF a0 = "*" THEN a0 = "1.2.3.4.5.6.7.8.9.10.11.12" .
            ELSE IF a0 = "P" THEN a0 = "2.4.6.8.10.12".
            ELSE IF a0 = "I" THEN a0 = "1.3.5.7.9.11".
IF LOOKUP(STRING(MONTH(dd)), a0 , ".") = 0 THEN RETURN 0.00000000000001. /*no corresponde al mes fuera */
/*completar entradas y normalizar*/
a1 = ENTRY( 2 , ss , "|" ).
a2=ENTRY( 3 , ss , "|" ).
prSabado = IF a2 = "7" THEN 2 ELSE 1. /*aumenta la priodidad de un sabado solo si es Sabado exclusivo*/
                                 /*en caso de queresr tener prioridad alta para el sabado despues el resto de los dias especificar dos restriccion una para el sabado y otra para el resto*/
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
        i = R-INDEX(aa1,"1",k).
        pr1 = IF i > 0 THEN k - i ELSE 0.
        i = INDEX(aa1,"1",k).
        pr2 = IF i > 0 THEN i - k ELSE 0.
        pr1 = ( IF pr1 = 0 AND pr2 <> 0 THEN pr2 ELSE ( IF pr1 <> 0 AND pr2 = 0 THEN pr1 ELSE MIN( pr1, pr2)  ) ).
        p1[ k ] = IF pr1 <= 1 THEN EXP( 0.8 , pr1 ) ELSE 0.  /*solo admite cambios se una semana*/
    END. 
END.

DO k = 1 TO 7:
    IF SUBSTRING( aa2 , k , 1 ) = "1" THEN DO:
        p2[ k ] = 1.
    END.
    ELSE DO:
        /*
        i = R-INDEX(aa2,"1",k).
        pr1 = IF i > 0 THEN k - i ELSE 0.
        i = INDEX(aa2,"1",k).
        pr2 = IF i > 0 THEN i - k ELSE 0.
        p2[ k ] = EXP( 0.4 , ( IF pr1 = 0 AND pr2 <> 0 THEN pr2 ELSE ( IF pr1 <> 0 AND pr2 = 0 THEN pr1 ELSE MIN( pr1, pr2)  ) ) ).
        */
        p2[k] = 0. /*no hay posibilidad de cambio de dia*/
    END. 
END.

DO i = 1 to 5:
    DO j = 1 to 7:
        dd = fechado( month(fecha) , year(fecha),  j , i ).
        IF fecha = dd /*and month(dd) = month(fecha)*/ THEN DO:
            esdesborde = p1[i] * p2[j] <> 1.
            vvmobs = IF p1[i] <> 1 AND p1[i] <> 0 THEN "[" + ss + "<->CS" ELSE "".
            /*por cambio de dia que no se admite vvmobs = IF p2[j] <> 1 AND p1[1] <> 0 AND p2[j] <> 0 THEN ( IF vvmobs <> "" THEN vvmobs + "-CD" ELSE "CD" ) ELSE vvmobs.*/
            vvmobs = IF vvmobs <> "" THEN vvmobs + "]" ELSE "".
            IF j = 7 /*es sabado*/ THEN
                RETURN prSabado * p1[i] * p2[j].
            ELSE
                RETURN p1[i] * p2[j].
        END.
    END.
END.
return 0.
END function.
/*
define VAR nroE as int NO-UNDO INITIAL 20688.
DEFINE VAR fecha AS DATE NO-UNDO INITIAL 12/27/08.
DEFINE VAR ss AS character NO-UNDO INITIAL "*|4|7|M|2".
DEFINE VAR v AS DECIMAL NO-UNDO.
DEFINE VAR esdesborde AS LOGICAL NO-UNDO. 
DEFINE VAR vmobs AS CHAR NO-UNDO.
*/
define input parameter nroE as int no-undo.
DEFINE INPUT PARAMETER fecha AS DATE NO-UNDO.
DEFINE INPUT PARAMETER ss AS character NO-UNDO.
DEFINE OUTPUT PARAMETER v AS DECIMAL NO-UNDO.
DEFINE OUTPUT PARAMETER esdesborde AS LOGICAL NO-UNDO. 
DEFINE OUTPUT PARAMETER vmobs AS CHAR NO-UNDO.

DEFINE VAR vpri AS DATE NO-UNDO.
DEFINE VAR vult AS DATE NO-UNDO.

v = validafecha(ss,fecha, OUTPUT esdesborde, OUTPUT vmobs).
/*NO SUCEDE NUNCA SIEMPRE HAY DESBORDES*/
/*si no valida que el dia posterior sea habil y feriado adoptando dicho valor*/
IF v = 0 THEN DO:
        /*como entro en desbordes justifico porque*/
        esdesborde = TRUE.
        vpri = DATE(MONTH(fecha) , 1 , year(fecha)).
        vult = DATE(MONTH(vpri + 32 ) , 1 , YEAR(vpri + 32 )) - 1. 
        FIND feriado WHERE feriado.fecha = fecha + 1 AND 
            feriado.fecha >= vpri AND feriado.fecha <= vult
            AND WEEKDAY(feriado.fecha) > 1 AND WEEKDAY(feriado.fecha) <> 7
            AND WEEKDAY(fecha) > 1 AND WEEKDAY(fecha) <> 7
            NO-LOCK NO-ERROR.
        IF AVAILABLE feriado THEN v = validafecha(ss,feriado.fecha, OUTPUT esdesborde , OUTPUT vmobs).
        IF v <> 0 THEN vmobs = vmobs + " PorFeriado " + STRING(feriado.fecha).
        ELSE DO:
                /*si no valida que el dia anterior sea habil y feriado adoptando dicho valor*/
                FIND feriado WHERE feriado.fecha = fecha - 1 AND 
                    feriado.fecha >= vpri AND feriado.fecha <= vult
                    AND WEEKDAY(feriado.fecha) > 1 AND WEEKDAY(feriado.fecha) <> 7
                    AND WEEKDAY(fecha) > 1 AND WEEKDAY(fecha) <> 7
                    NO-LOCK NO-ERROR.
                IF AVAILABLE feriado THEN v = validafecha(ss,feriado.fecha, OUTPUT esdesborde , OUTPUT vmobs).
                IF v <> 0 THEN vmobs = vmobs + " Por feriado " + STRING(feriado.fecha).
            END.  
END.
