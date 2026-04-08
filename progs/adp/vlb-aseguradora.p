
/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:Aseguradora                             */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Aseguradora AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Aseguradora WHERE ROWID(Aseguradora) = rid_Aseguradora NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Empleado WHERE Empleado.cdg_aseguradora = aseguradora.cdg_aseguradora)
  THEN RETURN.

  hay_error = NO.

END PROCEDURE.
