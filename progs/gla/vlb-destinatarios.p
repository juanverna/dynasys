
/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:Destinatario                             */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Destinatario AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Destinatario WHERE ROWID(Destinatario) = rid_Destinatario NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

     IF CAN-FIND(FIRST Sre_header WHERE Sre_header.nro_destinatario = Destinatario.nro_destinatario)
     THEN RETURN.

     hay_error = NO.

END PROCEDURE.
