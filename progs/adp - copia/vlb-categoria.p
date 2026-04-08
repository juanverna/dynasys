
/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:Categoria                             */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Categoria AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Categoria WHERE ROWID(Categoria) = rid_Categoria NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Afiliado WHERE Afiliado.cdg_categoria = categoria.cdg_categoria) OR
     CAN-FIND(FIRST Empleado WHERE Empleado.cdg_categoria = categoria.cdg_categoria) OR
     CAN-FIND(FIRST Rcb_header WHERE Rcb_header.cdg_categoria = categoria.cdg_categoria)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.
