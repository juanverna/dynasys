DEFINE INPUT-OUTPUT PARAMETER que_fecha AS DATE.

DEFINE VARIABLE que_dia AS INTEGER.
DEFINE VARIABLE que_mes AS INTEGER.
DEFINE VARIABLE que_ano AS INTEGER.

que_dia = DAY(que_fecha).
que_mes = MONTH(que_fecha).
que_ano = YEAR(que_fecha).

IF que_mes <> 1
THEN DO:
   que_mes = que_mes - 1.
END.
ELSE DO:   
   que_mes = 12.
   que_ano = que_ano - 1.   
END.

que_fecha = DATE(que_mes,que_dia,que_ano)