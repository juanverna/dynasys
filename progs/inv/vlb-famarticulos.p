/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE PARTIDAS                                    */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_familia AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Familia_articulo WHERE ROWID(Familia_articulo) = rid_familia NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Articulo WHERE Articulo.nro_familia = Familia_articulo.nro_familia)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.

