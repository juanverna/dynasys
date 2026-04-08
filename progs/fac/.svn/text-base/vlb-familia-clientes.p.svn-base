/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE Familias de cliente                         */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_familia AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Familia_cliente WHERE ROWID(Familia_cliente) = rid_familia NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.


PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Cliente WHERE Cliente.cdg_famclie = Familia_cliente.cdg_famclie)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.

