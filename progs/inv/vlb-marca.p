/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:FComercial                             */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_FComercial AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND FIRST Marca_Comercial WHERE ROWID(Marca_Comercial) = rid_FComercial NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Articulo   WHERE Articulo.cdg_marcacom = Marca_Comercial.cdg_marcacom) OR
     CAN-FIND(FIRST FComercial WHERE  FComercial.cdg_marcacom = Marca_comercial.cdg_marcacom)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.
