
/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:Seccion                             */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Seccion AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Seccion WHERE ROWID(Seccion) = rid_Seccion NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Empleado WHERE Empleado.cdg_seccion = seccion.cdg_seccion)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.
