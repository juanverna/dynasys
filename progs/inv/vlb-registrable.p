/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:Registrable                             */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Registrable AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Registrable WHERE ROWID(Registrable) = rid_Registrable NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Etiqueta WHERE Etiqueta.nro_registrable = Registrable.nro_registrable) OR
     CAN-FIND(FIRST Hst_estadoregis WHERE Hst_estadoregis.nro_registrable = Registrable.nro_registrable) OR
     CAN-FIND(FIRST Registrable-factura WHERE Registrable-factura.nro_registrable = Registrable.nro_registrable) OR
     CAN-FIND(FIRST Registrable-pedido WHERE Registrable-pedido.nro_registrable = Registrable.nro_registrable) OR
     CAN-FIND(FIRST Registrable-remito WHERE Registrable-remito.nro_registrable = Registrable.nro_registrable) OR
     CAN-FIND(FIRST Registrable-remprov WHERE Registrable-remprov.nro_registrable = Registrable.nro_registrable) OR
     CAN-FIND(FIRST Registrable-solicitud WHERE Registrable-solicitud.nro_registrable = Registrable.nro_registrable) OR
     CAN-FIND(FIRST Registrable-transdep WHERE Registrable-transdep.nro_registrable = Registrable.nro_registrable)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.
