/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:FComercial                             */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_FComercial AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND FComercial WHERE ROWID(FComercial) = rid_FComercial NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Articulo WHERE Articulo.cdg_marcacom = FComercial.cdg_marcacom) OR
     CAN-FIND(FIRST Marca_comercial WHERE Marca_comercial.cdg_marcacom = FComercial.cdg_marcacom)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.
