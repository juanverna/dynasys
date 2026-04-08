
/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:Sindicato                             */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Sindicato AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Sindicato WHERE ROWID(Sindicato) = rid_Sindicato NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

   IF CAN-FIND(FIRST Sindicato_convenio WHERE Sindicato_convenio.cdg_sindicato = Sindicato.cdg_sindicato)
      THEN RETURN.

  hay_error = NO.

END PROCEDURE.
