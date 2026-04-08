/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE depositoES                              */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_envases AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Envases WHERE ROWID(Envases) = rid_Envases NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Articulo WHERE Articulo.cdg_envases = Envases.cdg_envases)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.

