/*=================================================================================*/
/*       EDITA UN ARCHIVO TOMANDO LAS EQUIVALENCIAS DE UNA TABLA TEMPORAL          */
/*=================================================================================*/

DEFINE TEMP-TABLE T-Cambios
    FIELD old_string AS CHARACTER
    FIELD new_string AS CHARACTER.

/*=================================================================================*/
/*                             P A R A M E T R O S                                 */
/*=================================================================================*/

DEFINE INPUT PARAMETER que_archivo AS CHARACTER INITIAL "".
DEFINE INPUT PARAMETER que_salida  AS CHARACTER INITIAL "".
DEFINE INPUT PARAMETER TABLE FOR T-Cambios.
DEFINE OUTPUT PARAMETER rc AS INTEGER.

/*=================================================================================*/
/*                              V A R I A B L E S                                  */
/*=================================================================================*/

DEFINE VARIABLE hubo_cambios AS LOGICAL.

DEFINE VARIABLE como_fue     AS LOGICAL.
DEFINE VARIABLE aux_archivo  AS CHARACTER.
DEFINE VARIABLE puso_ok      AS LOGICAL.
DEFINE VARIABLE titulo_ed    AS CHARACTER.
DEFINE VARIABLE j            AS INTEGER.
DEFINE VARIABLE n_reem       AS INTEGER.

DEFINE VARIABLE resultados AS CHARACTER
                VIEW-AS EDITOR /*SIZE-PIXELS 620 BY 360 */ SIZE 70 BY 10
                        SCROLLBAR-VERTICAL SCROLLBAR-HORIZONTAL LARGE.

FORM
   resultados  FONT 11
   WITH FRAME frm-resultados WIDTH 90 NO-LABEL CENTERED FONT 11
   TITLE titulo_ed.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

FRAME frm-resultados:WIDTH-PIXELS  = CURRENT-WINDOW:WIDTH-PIXELS.
FRAME frm-resultados:HEIGHT-PIXELS = CURRENT-WINDOW:HEIGHT-PIXELS.
resultados:WIDTH-PIXELS  = FRAME frm-resultados:WIDTH-PIXELS - 2.
resultados:HEIGHT-PIXELS = FRAME frm-resultados:HEIGHT-PIXELS - 23.

rc = 0. /* Asumimos que no va a haber error */

como_fue = resultados:READ-FILE(que_archivo) IN FRAME frm-resultados.
IF como_fue 
THEN DO:
    FOR EACH T-Cambios:
        como_fue = resultados:REPLACE(T-Cambios.old_string,T-Cambios.new_string,8) IN FRAME frm-resultados.
        IF como_fue THEN hubo_cambios = YES.
    END.

    IF hubo_cambios 
    THEN DO: 
        como_fue = resultados:SAVE-FILE(que_salida + "\" + que_archivo) IN FRAME frm-resultados.
        IF NOT como_fue 
        THEN DO:
            MESSAGE "No pudo grabarse " que_archivo VIEW-AS ALERT-BOX ERROR.
            rc = 2.
        END.
    END.
END.
ELSE DO:
    MESSAGE "No pudo cargarse " que_archivo VIEW-AS ALERT-BOX ERROR.
    rc = 1.
END.


