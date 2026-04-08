
/*=================================================================================*/
/*                           PARAMETROS Y DEFINICIONES                             */
/*=================================================================================*/

DEFINE VARIABLE aux_archivo AS CHARACTER.
DEFINE VARIABLE puso_ok     AS LOGICAL.
DEFINE VARIABLE titulo_ed   AS CHARACTER.

{VRSHARED.I}
{VPERSINM.I}

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

    SYSTEM-DIALOG GET-FILE aux_archivo
        TITLE      "Seleccione el archivo a visualizar ..."
        SAVE-AS
        MUST-EXIST
        CREATE-TEST-FILE
        USE-FILENAME
        UPDATE puso_ok.

    IF puso_ok
    THEN DO:
         RUN VERESULT ( INPUT aux_archivo, INPUT 8).
    END.


