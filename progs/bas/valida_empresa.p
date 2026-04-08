/*========================================================================================*/
/*                     VALIDA UN EMPRESA CON EL CODIGO SELECCIONADO                       */
/*========================================================================================*/

DEFINE INPUT  PARAMETER cdg_empersa    AS CHARACTER.
DEFINE INPUT  PARAMETER hubo_error-in  AS LOGICAL.
DEFINE OUTPUT PARAMETER hubo_error-out AS LOGICAL.

IF hubo_error-in = NO AND (cdg_empersa <> "" AND cdg_empersa <> "*") THEN DO:
    FIND FIRST Empresa WHERE Empresa.cdg_empresa = cdg_empersa NO-LOCK NO-ERROR.
    IF NOT AVAILABLE Empresa THEN DO:
        RUN PONMENSJ.P (INPUT "EMPR001").
        hubo_error-out = YES.
    END.
END.
ELSE DO:
    hubo_error-out = hubo_error-in.
END.
