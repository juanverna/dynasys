/*==========================================================================================================*/
/*                 TRADUCE EN UN TEXTO EL VALOR DE ESTADO DE UN CHEQUE DE TERCERO                           */
/*==========================================================================================================*/

DEFINE INPUT PARAMETER p-cdg_estado AS CHARACTER.
DEFINE OUTPUT PARAMETER p-txt_estado AS CHARACTER.

{valoresvalor.i}

CASE p-cdg_estado:

    WHEN valor_sin_estado        THEN p-txt_estado = "SIN ESTADO DEFINIDO" .                 /* "**" */
    WHEN valor_en_cartera        THEN p-txt_estado = "EN CARTERA - DISPONIBLE" .             /* "00" */
    WHEN valor_a_autorizar       THEN p-txt_estado = "EN CARTERA - POR AUTORIZAR" .          /* "0A" */
    WHEN valor_depositado        THEN p-txt_estado = "EN CARTERA - DEPOSITADO" .             /* "01" */
    WHEN valor_acreditado        THEN p-txt_estado = "EN CARTERA - ACREDITADO" .             /* "02" */
    WHEN valor_rechazado         THEN p-txt_estado = "EN CARTERA - RECHAZADO POR LEVANTAR" . /* "03" */
    WHEN valor_levantado         THEN p-txt_estado = "EN CARTERA - RECHAZADO LEVANTADO" .    /* "04" */
    WHEN valor_cedido            THEN p-txt_estado = "CEDIDO" .                              /* "10" */
    WHEN valor_borrado           THEN p-txt_estado = "BORRADO" .                             /* "NN" */

END CASE.
