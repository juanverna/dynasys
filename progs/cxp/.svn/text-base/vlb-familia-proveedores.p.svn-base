/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE Familias de proveedores                     */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_familia AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Familia_proveedor WHERE ROWID(Familia_proveedor) = rid_familia NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Proveedor WHERE Proveedor.cdg_famprove = Familia_proveedor.cdg_famprove)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.

