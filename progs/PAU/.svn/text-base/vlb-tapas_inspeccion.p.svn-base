
/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:tapa_Inspeccion                             */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_tapa_Inspeccion AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND tapa_Inspeccion WHERE ROWID(tapa_Inspeccion) = rid_tapa_Inspeccion NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Tanque_Tapas WHERE Tanque_Tapas.cdg_tapa = tapa_inspeccion.cdg_tapa) 
  THEN RETURN.

  hay_error = NO.

END PROCEDURE.
