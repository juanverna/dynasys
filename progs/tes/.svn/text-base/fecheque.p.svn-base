DEFINE INPUT PARAMETER que_cheque AS ROWID.

DEFINE VARIABLE suma_habil AS INTEGER.
DEFINE VARIABLE diasem     AS INTEGER.

FIND Cheque WHERE ROWID(Cheque) = que_cheque.

DO WHILE WEEKDAY(Cheque.fecha_deposito) = 1 OR WEEKDAY(Cheque.fecha_deposito) = 7
   OR CAN-FIND(FIRST Feriado WHERE Feriado.fecha = Cheque.fecha_deposito):
   Cheque.fecha_deposito = Cheque.fecha_deposito + 1.
END.
   
Cheque.fecha_acredita = Cheque.fecha_deposito.
suma_habil = 0.
DO WHILE suma_habil < Cheque.dias_clearing - 1 :
   Cheque.fecha_acredita = Cheque.fecha_acredita + 1.
   diasem = WEEKDAY(Cheque.fecha_acredita).
   IF diasem <> 7 AND diasem <> 1 
      AND NOT CAN-FIND(First Feriado WHERE Feriado.fecha = Cheque.fecha_acredita)
      THEN suma_habil = suma_habil + 1.
END.   
