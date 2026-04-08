/*========================================================================================*/
/*               VALIDA UNA LISTA CON LOS CODIGOS SELECCIONADOS EN EMPRESA                */
/*========================================================================================*/

DEFINE INPUT  PARAMETER lista_codigos  AS CHARACTER.
DEFINE INPUT  PARAMETER hubo_error-in  AS LOGICAL.
DEFINE OUTPUT PARAMETER hubo_error-out AS LOGICAL.

DEFINE VARIABLE j AS INTEGER.
DEFINE VARIABLE i AS INTEGER.

j = NUM-ENTRIES(lista_codigos, ",").

IF NOT j > 0 AND hubo_error-in = NO THEN RUN PONMENSJ.P (INPUT "LSEM001").

IF NOT lista_codigos = "*" THEN DO:
    IF hubo_error-in = NO AND j > 0 THEN DO:
        DO i = 1 TO j:    
            IF hubo_error-out = NO THEN DO:
                FIND FIRST Empresa WHERE Empresa.cdg_empresa = ENTRY(i, lista_codigos,",") NO-LOCK NO-ERROR.
                IF NOT AVAILABLE Empresa 
                    THEN DO:
                        hubo_error-out = YES.
                        RUN PONMENSJ.P (INPUT "LSEM001").
                END.
            END.
        END.
    END.
    ELSE DO:
        hubo_error-out = YES.
    END.
END.
ELSE DO:
    hubo_error-out = hubo_error-in.
END.
