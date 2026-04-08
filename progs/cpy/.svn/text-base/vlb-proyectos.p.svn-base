/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:proyecto                              */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_proyecto AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Proyecto WHERE ROWID(Proyecto) = rid_proyecto NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Tarea OF Proyecto)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.
