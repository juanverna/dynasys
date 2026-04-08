/*======================================================================================*/
/*        REALIZA LA CONECCION (OPCIONAL) DE LA BASE DE AFILIADOS E INVOCA EL MENU      */
/*======================================================================================*/

DEFINE VARIABLE hubo_logon AS LOGICAL.

SESSION:TIME-SOURCE = "probs".
SESSION:DATA-ENTRY-RETURN = YES.

RUN c-logon.w ( OUTPUT hubo_logon).
IF hubo_logon THEN RUN w-probs.w.
QUIT.
