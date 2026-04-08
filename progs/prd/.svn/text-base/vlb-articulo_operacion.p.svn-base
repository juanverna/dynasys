/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:Articulo_operacion                             */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Articulo_operacion AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Articulo_operacion WHERE ROWID(Articulo_operacion) = rid_Articulo_operacion NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Especif_operacion WHERE Especif_operacion.nro_operacion = Articulo_operacion.nro_operacion) OR
     CAN-FIND(FIRST Especif_operarticulo WHERE Especif_operarticulo.nro_operacion = Articulo_operacion.nro_operacion) OR
     CAN-FIND(FIRST Especif_rutaproceso WHERE Especif_rutaproceso.nro_operacion = Articulo_operacion.nro_operacion) OR
     CAN-FIND(FIRST Formula_articulo WHERE Formula_articulo.nro_operacion = Articulo_operacion.nro_operacion)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.
