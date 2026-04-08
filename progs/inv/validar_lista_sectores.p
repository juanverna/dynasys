/*========================================================================================*/
/*               VALIDA UNA LISTA CON LOS CODIGOS SELECCIONADOS EN SECTOR                 */
/*========================================================================================*/

DEFINE INPUT  PARAMETER lista_codigos  AS CHARACTER.
DEFINE INPUT  PARAMETER hubo_error-in  AS LOGICAL.
DEFINE OUTPUT PARAMETER hubo_error-out AS LOGICAL.

DEFINE VARIABLE j AS INTEGER.
DEFINE VARIABLE i AS INTEGER.

j = NUM-ENTRIES(lista_codigos, ",").

IF NOT (lista_codigos = "" OR lista_codigos = "*") THEN DO:
    IF hubo_error-in = NO THEN DO:
        DO i = 1 TO j:    
            IF hubo_error-out = NO THEN DO:
                FIND FIRST Area WHERE Area.cdg_area = ENTRY(i, lista_codigos,",") NO-LOCK NO-ERROR.
                IF NOT AVAILABLE Area THEN DO:
                    hubo_error-out = YES.
                    RUN PONMENSJ.P (INPUT "LSSC001").
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
