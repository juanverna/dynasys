/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:Tarea                              */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_tarea AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Tarea WHERE ROWID(tarea) = rid_tarea NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Partetarea OF Tarea) OR
     CAN-FIND(FIRST Observacion OF Tarea)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.
