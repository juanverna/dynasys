DEFINE INPUT  PARAMETER p-fecha AS DATE.
DEFINE OUTPUT PARAMETER ultimo_dia_mes AS LOGICAL.  


DEFINE VARIABLE ENCONTRE AS LOGICAL    NO-UNDO.
DEFINE VARIABLE I AS INTEGER    NO-UNDO.
DEFINE VARIABLE J AS INTEGER    NO-UNDO.



DEFINE VARIABLE i-mes  AS INTEGER  FORMAT "99"    NO-UNDO.
DEFINE VARIABLE i-anio AS INTEGER  FORMAT "9999"  NO-UNDO.
DEFINE VARIABLE ultima_fecha AS DATE       NO-UNDO.
DEFINE VARIABLE FECHA AS DATE       NO-UNDO.

/* ultimo_dia_mes = NO. */

IF MONTH(p-fecha) = 12 THEN
  ASSIGN
   i-mes  = 1
   i-anio = YEAR(p-fecha) + 1.
ELSE
   ASSIGN
   i-mes  = MONTH(p-fecha) + 1
   i-anio = YEAR(p-fecha).

   

 FECHA = DATE("01" + STRING(I-MES, "99") + STRING(I-ANIO,"9999")) .
 
 ASSIGN 
 ENCONTRE = NO
 i = 0.
 J = 5.

 DO WHILE I < J AND encontre = NO  :
    i = i + 1.
    fecha = fecha - 1.
    IF WEEKDAY(fecha) = 7 OR
       WEEKDAY(fecha) = 1 OR
       CAN-FIND(First Feriado 
                WHERE Feriado.fecha = fecha) THEN 
       encontre = NO.
    ELSE
       encontre = YES.
 END.
 
  IF p-fecha = fecha THEN 
     ultimo_dia_mes = YES.


