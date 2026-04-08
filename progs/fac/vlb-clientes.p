
/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:Cliente                             */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Cliente AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Cliente WHERE ROWID(Cliente) = rid_Cliente NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Acumulado_ccte WHERE Acumulado_ccte.nro_cliente = Cliente.nro_cliente) OR
     CAN-FIND(FIRST Acum_ventas WHERE Acum_ventas.nro_cliente = Cliente.nro_cliente) OR
     CAN-FIND(FIRST Aliart-cliente WHERE Aliart-cliente.nro_cliente = Cliente.nro_cliente) OR
     CAN-FIND(FIRST Caj_header WHERE Caj_header.nro_cliente = Cliente.nro_cliente) OR
     CAN-FIND(FIRST Cliente-bonificacion WHERE Cliente-bonificacion.nro_cliente = Cliente.nro_cliente) OR
     CAN-FIND(FIRST Cliente-bonxarticulo WHERE Cliente-bonxarticulo.nro_cliente = Cliente.nro_cliente) OR
     CAN-FIND(FIRST Cliente-contacto WHERE Cliente-contacto.nro_cliente = Cliente.nro_cliente) OR
     CAN-FIND(FIRST Cliente-observacion WHERE Cliente-observacion.nro_cliente = Cliente.nro_cliente) OR
     CAN-FIND(FIRST Cliente_cndventa WHERE Cliente_cndventa.nro_cliente = Cliente.nro_cliente) OR
     CAN-FIND(FIRST Cliente_excencion WHERE Cliente_excencion.nro_cliente = Cliente.nro_cliente) OR
     CAN-FIND(FIRST Contrato_hd WHERE Contrato_hd.nro_cliente = Cliente.nro_cliente) OR
     CAN-FIND(FIRST Cta_cte WHERE Cta_cte.nro_cliente = Cliente.nro_cliente) OR
     CAN-FIND(FIRST Domicilio WHERE Domicilio.nro_cliente = Cliente.nro_cliente) OR
     CAN-FIND(FIRST Fac_header WHERE Fac_header.nro_cliente = Cliente.nro_cliente) OR
     CAN-FIND(FIRST Lista_comisiones WHERE Lista_comisiones.nro_cliente = Cliente.nro_cliente) OR
     CAN-FIND(FIRST Ped_header WHERE Ped_header.nro_cliente = Cliente.nro_cliente) OR
     CAN-FIND(FIRST Proveedor WHERE Proveedor.nro_cliente = Cliente.nro_cliente) OR
     CAN-FIND(FIRST Rec_header WHERE Rec_header.nro_cliente = Cliente.nro_cliente) OR
     CAN-FIND(FIRST Registrable WHERE Registrable.nro_cliente = Cliente.nro_cliente) OR
     CAN-FIND(FIRST Rem_header WHERE Rem_header.nro_cliente = Cliente.nro_cliente) OR
     CAN-FIND(FIRST Rescuenta_hd WHERE Rescuenta_hd.nro_cliente = Cliente.nro_cliente) OR
     CAN-FIND(FIRST Valor WHERE Valor.nro_cliente = Cliente.nro_cliente)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.
