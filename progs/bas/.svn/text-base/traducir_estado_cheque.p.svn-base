/*==========================================================================================================*/
/*                 TRADUCE EN UN TEXTO EL VALOR DE ESTADO DE UN CHEQUE DE TERCERO                           */
/*==========================================================================================================*/

DEFINE INPUT PARAMETER p-cdg_estado AS CHARACTER.
DEFINE OUTPUT PARAMETER p-txt_estado AS CHARACTER.

{valoresvalor.i}

CASE p-cdg_estado:
    WHEN cheque_por_emitir        THEN p-txt_estado = "Pendiente de Tesoreria" .                 /* "**" */
    WHEN cheque_por_imprimir      THEN p-txt_estado = "Pendiente de Impresion" .                 /* "**" */
    WHEN cheque_emitido           THEN p-txt_estado = "Cheque Impreso" .                 /* "**" */
    WHEN cheque_entregado         THEN p-txt_estado = "Cheque Entregado" .                 /* "**" */
    WHEN cheque_acreditado        THEN p-txt_estado = "Cheque Acreditado" .                 /* "**" */
    WHEN cheque_rechazado         THEN p-txt_estado = "Cheque Rechazado" .                 /* "**" */
    WHEN cheque_anulado           THEN p-txt_estado = "Cheque Anulado  " .                 /* "**" */
    WHEN cheque_anulacion_externa THEN p-txt_estado = "Anulado - Sin Emision" .                 /* "**" */
    WHEN cheque_emision_externa   THEN p-txt_estado = "Emision Externa" .                 /* "**" */
    WHEN cheque_pend_renumerar    THEN p-txt_estado = "Pendiente Renumerar" .                 /* "**" */

END CASE.
