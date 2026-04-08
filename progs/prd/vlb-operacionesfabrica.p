
/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:Operacionfabrica                             */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Operacionfabrica AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Operacionfabrica WHERE ROWID(Operacionfabrica) = rid_Operacionfabrica NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Articulo_operacion WHERE Articulo_operacion.nro_operacion = Operacionfabrica.nro_operacion) OR
     CAN-FIND(FIRST Especif_operacion WHERE Especif_operacion.nro_operacion = Operacionfabrica.nro_operacion) OR
     CAN-FIND(FIRST Formula_articulo WHERE Formula_articulo.nro_operacion = Operacionfabrica.nro_operacion) OR
     CAN-FIND(FIRST Ofabrica_hd WHERE Ofabrica_hd.nro_operacion = Operacionfabrica.nro_operacion) OR
     CAN-FIND(FIRST Rutaproceso WHERE Rutaproceso.nro_operacion = Operacionfabrica.nro_operacion)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.
