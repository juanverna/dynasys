
/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:Estado_empleado                             */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Estado_empleado AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Estado_empleado WHERE ROWID(Estado_empleado) = rid_Estado_empleado NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Empleado WHERE Empleado.cdg_estado = estado_empleado.cdg_estado) OR
     CAN-FIND(FIRST Estado WHERE Estado.cdg_estado = estado_empleado.cdg_estado)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.
