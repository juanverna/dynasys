
/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:Parametro                             */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Parametro AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Parametro WHERE ROWID(Parametro) = rid_Parametro NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

     IF CAN-FIND(FIRST Parametro-excep WHERE Parametro-excep.cdg_parametro = Parametro.cdg_parametro)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.
