/* ========================================================================== */
/* CALCULO DE LA FECHA EN LA QUE CAE SEMANA SANTA PARA ACTUALIZAR FERIADOS    */
/* ========================================================================== */
/* ------------------------------------------------------------------------------------------------------
Primero se determina la Epacta correspondiente al año de interés. 
Para cumplir este objetivo se ejecutan los siguientes pasos:

                            Ejemplo para el año 2001

1) A = Año - 1596           A = 2001 - 1596 = 405

2) B = A + 96               B = 405 + 96 = 501

3) C = A - 4                C = 405 - 4 = 401


Con el valor obtenido de la Epacta se evalúa N = 44 - Epacta; para el 2001, N = 44 - 5 = 39

Entonces

a)       Si N es menor que 21, la Pascua se celebra el domingo siguiente al (N - 1) de abril.

b)       Si N está comprendido entre 21 y 31, ambos valores inclusive, la Pascua se celebra el domingo 
         siguiente al N de marzo.

c)       Si N es mayor que 31, la Pascua se celebra el domingo siguiente al (N - 31) de abril.

Para el 2001, N = 39, la Pascua se celebrará el domingo siguiente al (39 - 31) de abril = 8 de abril

A continuación utilizando el procedimiento de Dershowitz y Reingold se encuentra el día de la semana 
correspondiente a la fecha anteior mediante las siguientes operaciones:

                        Ejemplo para el 8 de abril de 2001
	

Año = 2001; N° del mes = 4; día = 8

1) A = Año - 1                                  A = 2001 - 1 = 2000

2) B = 365 l A                                  B = 730.000

3) C = (A / 4) - (A / 100) + (A / 400)          C = (2000 / 4) - (2000 / 100) + (2000 / 400) = 485

4) D = ((367 · N° del mes - 362) / 12)          D = ((367 · 4 - 362) / 12) = 92

5) E =                                          E = -2 (para el 2001)

6) F = Día                                      F = 8

7) G = B + C + D + E + F                        G = 730.000 + 485 + 92 - 2 + 8 = 730.583

8) H = resto de (G / 7)                         H = resto de (730.583 / 7) = 0
		

Seguidamente utilizando la tabla adjunta se obtiene el dato buscado

Valor de H           Día de la semana

0                    Domingo
1                    Lunes
2                    Martes
3                    Miércoles
4                    Jueves
5                    Viernes
6                    Sábado

El 8 de abril de 2001 es domingo, para el próximo domingo deben transcurrir 7 días, por lo tanto la fecha
de Pascua será el 15 de abril.

Si la Epacta es 25 con número de oro mayor que 11 (número de oro = 1 + resto de (Año / 19), 
ejemplo: para el año 2001 el número de oro = 1 + resto de (2001 / 19) = 1 + 6 = 7),
se restan 7 días a la fecha obtenida.

------------------------------------------------------------------------------------------------------------*/

/*
DEF VAR p AS DATE FORMAT "99/99/9999".
RUN semana_santa.p ( INPUT 1992, OUTPUT p ).
MESSAGE p
    VIEW-AS ALERT-BOX INFO BUTTONS OK.
*/
DEFINE INPUT PARAMETER p-ano        AS INTEGER.
DEFINE OUTPUT PARAMETER p-pascua    AS DATE.


FUNCTION fnpascua RETURNS DATE ( v-lunacion AS DATE ).

    DEFINE VARIABLE v-pascua AS DATE.

    v-pascua = v-lunacion.
    DO WHILE WEEKDAY(v-pascua) <> 1:
        v-pascua = v-pascua + 1.
    END.

    RETURN v-pascua.

END FUNCTION.

DEFINE VARIABLE v-ano               AS INTEGER.
                                    
DEFINE VARIABLE v-a                 AS INTEGER.
DEFINE VARIABLE v-b                 AS INTEGER.
DEFINE VARIABLE v-c                 AS INTEGER.
DEFINE VARIABLE v-d                 AS INTEGER.
DEFINE VARIABLE v-e                 AS INTEGER.
DEFINE VARIABLE v-f                 AS INTEGER.
DEFINE VARIABLE v-g                 AS INTEGER.
DEFINE VARIABLE v-h                 AS INTEGER.
DEFINE VARIABLE v-i                 AS INTEGER.
DEFINE VARIABLE v-epacta            AS INTEGER.
DEFINE VARIABLE v-n                 AS INTEGER.
DEFINE VARIABLE v-lunacion          AS DATE.

ASSIGN v-a = p-ano - 1596
       v-b = v-a + 96
       v-c = v-a - 4
       v-d = TRUNC(v-a / 19,0)
       v-e = TRUNC(v-b / 300,0)
       v-f = TRUNC(v-c / 100,0)
       v-g = TRUNC(v-c / 400,0)
       v-h = ( v-a * 11 + 1 ) MOD 30
       v-i = v-d + v-e - v-f + v-g + v-h + 30
       v-epacta = v-i MOD 30
       v-n = 44 - v-epacta.

IF v-n < 21 /* Si N es menor que 21, la Pascua se celebra el domingo siguiente al (N - 1) de abril. */
THEN DO:
    p-pascua = fnpascua(DATE(4,v-n - 1,p-ano)).
    
END.
ELSE DO:
     /* Si N está comprendido entre 21 y 31, ambos valores inclusive, 
        la Pascua se celebra el domingo siguiente al N de marzo.      */
    IF v-n >= 21 AND v-n <= 31 
    THEN DO:
        p-pascua = fnpascua(DATE(3,v-n,p-ano)).
    END.
    ELSE DO: /* Si N es mayor que 31, la Pascua se celebra el domingo siguiente al (N - 31) de abril. */
        p-pascua = fnpascua(DATE(4,v-n - 31,p-ano)).
    END.
END.


