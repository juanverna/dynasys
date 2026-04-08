/*===========================================================================================*/
/*       HALLA LA FECHA DE ACREDITACION DE UN VALOR EN FUNCION DE LA FECHA DE DEPOSITO       */
/*===========================================================================================*/

DEFINE INPUT-OUTPUT PARAMETER p-fecha0 AS DATE.
DEFINE INPUT        PARAMETER p-dias   AS INTEGER.
DEFINE OUTPUT       PARAMETER p-fecha1 AS DATE.

DEFINE VARIABLE suma_habil AS INTEGER.
DEFINE VARIABLE diasem     AS INTEGER.

  /* Corre la fecha inicial hasta encontrar el primer día habil, descartando feriados */

DO WHILE WEEKDAY(p-fecha0) = 1 OR WEEKDAY(p-fecha0) = 7
   OR CAN-FIND(FIRST Feriado WHERE Feriado.fecha = p-fecha0):
   p-fecha0 = p-fecha0 + 1.
END.

  /* Va recorriendo los días, sumando los días hábiles hasta alcanzar los días de clearing */
   
p-fecha1 = p-fecha0.
suma_habil = 0.
DO WHILE suma_habil <> p-dias:
   p-fecha1 = p-fecha1 + 1.
   diasem = WEEKDAY(p-fecha1).
   IF diasem <> 7 AND diasem <> 1 
      AND NOT CAN-FIND(FIRST Feriado WHERE Feriado.fecha = p-fecha1)
      THEN suma_habil = suma_habil + 1.
END.   
