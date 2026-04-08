  CASE ver_pagos:
    WHEN p_numero
    THEN DO:
        OPEN QUERY qry_cheques
             FOR EACH Cheque OF Cuenta_bancaria
                WHERE Cheque.fecha_emision <= has_fecha
                  AND Cheque.fecha_emision >= des_fecha
                   BY Cheque.numero_cheque.
    END.
    WHEN p_prove
    THEN DO:
        OPEN QUERY qry_cheques
             FOR EACH Cheque OF Cuenta_bancaria
                WHERE Cheque.fecha_emision <= has_fecha
                  AND Cheque.fecha_emision >= des_fecha
                   BY Proveedor.cdg_proveedor.

    END.
    WHEN p_fecha
    THEN DO:
        OPEN QUERY qry_cheques
             FOR EACH Cheque OF Cuenta_bancaria
                WHERE Cheque.fecha_emision <= has_fecha
                  AND Cheque.fecha_emision >= des_fecha
                   BY Cheque.fecha_emision.
    END.
    WHEN p_salida
    THEN DO:
        OPEN QUERY qry_cheques
             FOR EACH Cheque OF Cuenta_bancaria
                WHERE Cheque.fecha_emision <= has_fecha
                  AND Cheque.fecha_emision >= des_fecha
                   BY Cheque.fecha_salida.
    END.
  END CASE.
