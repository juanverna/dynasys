/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE clienteS                                    */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_grupo_bduso AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Grupo_bduso WHERE ROWID(Grupo_bduso) = rid_grupo_bduso NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.


PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Bduso WHERE Bduso.cdg_grpbduso = Grupo_bduso.cdg_grpbduso)
     THEN RETURN.
     
  hay_error = NO.

END PROCEDURE.

