FUNCTION DOW returns int (dd as date , fwd as int ):
    IF weekday(dd) < fwd THEN return weekday(dd) + 8 - fwd .
    else return weekday(dd) - fwd + 1 .
END function.

FUNCTION fechado returns date ( tnMes AS int, tnAnio AS INT , tnDiaSem AS INT , tnOrdinal AS INT ) :
define variable dd as date.
define var daju as int.

return DATE(  tnMes , 1 , tnAnio ) + tnOrdinal * 7 - dow( DATE(  tnMes , 1, tnAnio ) + tnOrdinal * 7 - 1 ,tnDiasem ).

END function.

