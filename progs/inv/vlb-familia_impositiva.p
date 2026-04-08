
/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:Familia_impositiva                             */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Familia_impositiva AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Familia_impositiva WHERE ROWID(Familia_impositiva) = rid_Familia_impositiva NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Articulo WHERE Articulo.nro_familimpos = Familia_impositiva.nro_familimpos) OR
     CAN-FIND(FIRST Articulo-impuesto WHERE Articulo-impuesto.nro_familimpos = Familia_impositiva.nro_familimpos) OR
     CAN-FIND(FIRST Impuesto_condicion WHERE Impuesto_condicion.nro_familimpos = Familia_impositiva.nro_familimpos)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.
