/*=================================================================================*/
/* CARGA EN UNA TABLA TEMPORAL LAS EQUIVALENCIAS A REEMPLAZAR EN UN ARCHIVO        */
/*=================================================================================*/

DEFINE TEMP-TABLE T-Cambios
    FIELD old_string AS CHARACTER
    FIELD new_string AS CHARACTER.

/*=================================================================================*/
/*                             P A R A M E T R O S                                 */
/*=================================================================================*/

DEFINE INPUT PARAMETER que_nombres AS CHARACTER INITIAL "".
DEFINE OUTPUT PARAMETER TABLE FOR T-Cambios.

/*=================================================================================*/
/*                              V A R I A B L E S                                  */
/*=================================================================================*/

DEFINE VARIABLE v-old_string  AS CHARACTER FORMAT "X(35)".
DEFINE VARIABLE v-new_string  AS CHARACTER FORMAT "X(35)".

DEFINE STREAM Cambios.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

INPUT STREAM Cambios FROM VALUE(que_nombres). /* "\\milenium\progress\wrk\tablas_renombradas.txt" */
REPEAT:
    IMPORT STREAM Cambios DELIMITER "," v-new_string v-old_string.
    CREATE T-Cambios.
    ASSIGN T-Cambios.old_string = v-old_string
           T-Cambios.new_string = v-new_string.
END.
INPUT STREAM Cambios CLOSE.

