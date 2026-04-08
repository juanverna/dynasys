
/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:Condicion_venta                             */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Condicion_venta AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Condicion_venta WHERE ROWID(Condicion_venta) = rid_Condicion_venta NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Cliente_cndventa WHERE Cliente_cndventa.nro_cndventa = Condicion_venta.nro_cndventa) OR
     CAN-FIND(FIRST Contrato_hd WHERE Contrato_hd.nro_cndventa = Condicion_venta.nro_cndventa) OR
     CAN-FIND(FIRST Emb_header_prv WHERE Emb_header_prv.nro_cndventa = Condicion_venta.nro_cndventa) OR
     CAN-FIND(FIRST Fac_header WHERE Fac_header.nro_cndventa = Condicion_venta.nro_cndventa) OR
     CAN-FIND(FIRST Fac_header_prv WHERE Fac_header_prv.nro_cndventa = Condicion_venta.nro_cndventa) OR
     CAN-FIND(FIRST Ocm_header WHERE Ocm_header.nro_cndventa = Condicion_venta.nro_cndventa) OR
     CAN-FIND(FIRST Oferta-condicion WHERE Oferta-condicion.nro_cndventa = Condicion_venta.nro_cndventa) OR
     CAN-FIND(FIRST Opg_header WHERE Opg_header.nro_cndventa = Condicion_venta.nro_cndventa) OR
     CAN-FIND(FIRST Ped_header WHERE Ped_header.nro_cndventa = Condicion_venta.nro_cndventa) OR
     CAN-FIND(FIRST Proveedor_cndventa WHERE Proveedor_cndventa.nro_cndventa = Condicion_venta.nro_cndventa) OR
     CAN-FIND(FIRST Rec_header WHERE Rec_header.nro_cndventa = Condicion_venta.nro_cndventa) OR
     CAN-FIND(FIRST Rem_header WHERE Rem_header.nro_cndventa = Condicion_venta.nro_cndventa) OR
     CAN-FIND(FIRST Rem_header_prv WHERE Rem_header_prv.nro_cndventa = Condicion_venta.nro_cndventa) OR
     CAN-FIND(FIRST Subcondicion WHERE Subcondicion.nro_cndventa = Condicion_venta.nro_cndventa)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.
