/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE BONIFICACIONES                              */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_bonificacion AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Bonificacion WHERE ROWID(Bonificacion) = rid_bonificacion NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Articulo-bonificacion WHERE Articulo-bonificacion.cdg_bonificacion = Bonificacion.cdg_bonificacion) OR
     CAN-FIND(FIRST Cliente-bonificacion WHERE Cliente-bonificacion.cdg_bonificacion = Bonificacion.cdg_bonificacion) OR
     CAN-FIND(FIRST Cliente-bonxarticulo WHERE Cliente-bonxarticulo.cdg_bonificacion = Bonificacion.cdg_bonificacion) OR
     CAN-FIND(FIRST Fac_detalle-bon WHERE Fac_detalle-bon.cdg_bonificacion = Bonificacion.cdg_bonificacion) OR
     CAN-FIND(FIRST Fac_header-bon WHERE Fac_header-bon.cdg_bonificacion = Bonificacion.cdg_bonificacion) OR
     CAN-FIND(FIRST Pedido_bonificacion WHERE Pedido_bonificacion.cdg_bonificacion = Bonificacion.cdg_bonificacion) OR
     CAN-FIND(FIRST Ped_detalle-bon WHERE Ped_detalle-bon.cdg_bonificacion = Bonificacion.cdg_bonificacion) OR
     CAN-FIND(FIRST Ped_header-bon WHERE Ped_header-bon.cdg_bonificacion = Bonificacion.cdg_bonificacion) OR
     CAN-FIND(FIRST Rem_detalle-bon WHERE Rem_detalle-bon.cdg_bonificacion = Bonificacion.cdg_bonificacion) OR
     CAN-FIND(FIRST Rem_header-bon WHERE Rem_header-bon.cdg_bonificacion = Bonificacion.cdg_bonificacion)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.

