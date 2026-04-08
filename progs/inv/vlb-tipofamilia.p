/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE depositoES                              */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_tipo AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Tipo_familiarticulo WHERE ROWID(Tipo_familiarticulo) = rid_tipo NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Familia_articulo WHERE Familia_articulo.cdg_tipofamilia = Tipo_familiarticulo.cdg_tipofamilia)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.

