/*============================================================================================*/
/*  CALCULAS LAS FECHAS ASOCIADAS A UN CHEQUE DADA LA FECHA DE EMISION Y LOS DIAS DE CLEARING */
/*============================================================================================*/

DEFINE INPUT PARAMETER  p-fecha_emision  AS DATE.
DEFINE INPUT PARAMETER  p-dias_clearing  AS INTEGER.
DEFINE OUTPUT PARAMETER p-fecha_deposito AS DATE.
DEFINE OUTPUT PARAMETER p-fecha_acredita AS DATE.

/*============================================================================================*/
/*                                        VARIABLES                                           */
/*============================================================================================*/

DEFINE VARIABLE suma_habil AS INTEGER.

/*============================================================================================*/
/*                                          PROCESO                                           */
/*============================================================================================*/

p-fecha_deposito = p-fecha_emision.

/*----------------------------------------------------------------------*/
/*  HALLA EL PRIMER DÍA HABIL POSTERIOR A LA EMISION PARA DEPOSITAR     */
/*----------------------------------------------------------------------*/

DO WHILE WEEKDAY(p-fecha_deposito) = 1 OR WEEKDAY(p-fecha_deposito) = 7
   OR CAN-FIND(FIRST Feriado WHERE Feriado.fecha = p-fecha_deposito):
   p-fecha_deposito = p-fecha_deposito + 1.
END.
   
/*----------------------------------------------------------------------*/
/*  SUMA UNA CANTIDAD DE DIAS HABILES IGUAL A LOS DIAS DE CLEARING      */
/*----------------------------------------------------------------------*/

p-fecha_acredita = p-fecha_deposito.
suma_habil = 0.
DO WHILE suma_habil < p-dias_clearing:

   p-fecha_acredita = p-fecha_acredita + 1.
   IF WEEKDAY(p-fecha_acredita) <> 7 AND WEEKDAY(p-fecha_acredita) <> 1 
      AND NOT CAN-FIND(First Feriado WHERE Feriado.fecha = p-fecha_acredita)
      THEN suma_habil = suma_habil + 1.

END.   
