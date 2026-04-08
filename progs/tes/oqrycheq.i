  CASE ver_pagos:
    WHEN todos
    THEN DO:
        OPEN QUERY qry_cheques
             FOR EACH Cheque
                WHERE Cheque.fecha_emision <= has_fecha
                  AND Cheque.fecha_emision >= des_fecha,
                FIRST Cuenta_bancaria OF Cheque,
                FIRST Banco OF Cuenta_bancaria, FIRST Proveedor LEFT OUTER-JOIN OF Cheque
                   BY Cheque.fecha_emision.
    END.
    WHEN ya_emi
    THEN DO:
        OPEN QUERY qry_cheques
             FOR EACH Cheque
                WHERE Cheque.fecha_emision <= has_fecha
                  AND Cheque.fecha_emision >= des_fecha,
                FIRST Cuenta_bancaria OF Cheque WHERE NOT Cuenta_bancaria.ficticia,
                FIRST Banco OF Cuenta_bancaria, FIRST Proveedor LEFT OUTER-JOIN OF Cheque
                   BY Cheque.fecha_emision.

    END.
    WHEN no_emi
    THEN DO:
        OPEN QUERY qry_cheques
             FOR EACH Cheque
                WHERE Cheque.fecha_emision <= has_fecha
                  AND Cheque.fecha_emision >= des_fecha,
                FIRST Cuenta_bancaria OF Cheque WHERE Cuenta_bancaria.ficticia,
                FIRST Banco OF Cuenta_bancaria, FIRST Proveedor LEFT OUTER-JOIN OF Cheque
                   BY Cheque.fecha_emision.


    END.
  END CASE.