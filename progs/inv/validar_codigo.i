/*========================================================================================*/
/*               VALIDA UNA LISTA CON LOS CODIGOS SELECCIONADOS EN UN MAESTRO DADO        */
/*========================================================================================*/

/* DEFINE INPUT PARAMETER lista_codigos AS CHARACTER. */
/* DEFINE INPUT PARAMETER hubo_error    AS LOGICAL.   */

DEFINE VARIABLE j AS INTEGER.
DEFINE VARIABLE i AS INTEGER.

hubo_error = NO.

j = NUM-ENTRIES(lista_codigos, ",").

DO i = 1 TO j:
    IF hubo_error = NO THEN DO:
        FIND FIRST {&TABLA} WHERE {&TABLA}.{&CODIGO} = ENTRY (lista_codigos, j) NO-LOCK NO-ERROR.
        IF NOT AVAILABLE {&TABLA} THEN hubo_error = YES.
    END.
END.

