/*==============================================================================================*/
/*         VERIFICACION DE POSIBILIDAD DE PROCEDER AL CIERRE CONTABLE POR CADA MODULO           */
/*==============================================================================================*/

DEFINE INPUT  PARAMETER p-cdg_empresa   LIKE Empresa.cdg_empresa.
DEFINE INPUT  PARAMETER p-fch_cierre    LIKE Cierre_diario.fch_cierre.
DEFINE OUTPUT PARAMETER p-cierre_ok     AS INTEGER.

/*==============================================================================================*/
/*         VERIFICACION DE POSIBILIDAD DE PROCEDER AL CIERRE CONTABLE POR CADA MODULO           */
/*==============================================================================================*/

    p-cierre_ok = 0.

    /* Chequeo de la condicion de cierre de cada módulo */

    IF FALSE
        THEN p-cierre_ok = 1.
