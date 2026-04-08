/*========================================================================================*/
/*                     VALIDA UN EMPRESA CON EL CODIGO SELECCIONADO                       */
/*========================================================================================*/

DEFINE INPUT  PARAMETER cdg_empresa    AS CHARACTER.
DEFINE INPUT  PARAMETER cdg_puntovta   AS INTEGER.
DEFINE INPUT  PARAMETER hubo_error-in  AS LOGICAL.
DEFINE OUTPUT PARAMETER hubo_error-out AS LOGICAL.

IF hubo_error-in = NO THEN DO:
    FIND FIRST Punto-venta WHERE Punto-venta.cdg_puntovta = cdg_puntovta
                             AND Punto-venta.cdg_empresa = cdg_empresa NO-LOCK NO-ERROR.
    IF NOT AVAILABLE Punto-venta THEN DO:
        RUN PONMENSJ.P (INPUT "PTVT001").
        hubo_error-out = YES.
    END.
END.
ELSE DO:
    hubo_error-out = hubo_error-in.
END.
