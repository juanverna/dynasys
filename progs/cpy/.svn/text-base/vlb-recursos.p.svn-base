/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:Recursos                           */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_recurso AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Recurso WHERE ROWID(Recurso) = rid_Recurso NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Tarea WHERE Tarea.cdg_recurso = Recurso.cdg_recurso)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.
