/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE clienteS                                    */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_grupo-empresario AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Grupo-empresario WHERE ROWID(Grupo-empresario) = rid_grupo-empresario NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Cliente WHERE Cliente.cdg_grupoemp = Grupo-empresario.cdg_grupoemp) OR
     CAN-FIND(FIRST Proveedor WHERE Proveedor.cdg_grupoemp = Grupo-empresario.cdg_grupoemp)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.

