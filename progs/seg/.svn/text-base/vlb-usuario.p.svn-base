
/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:Usuario                             */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Usuario AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Usuario WHERE ROWID(Usuario) = rid_Usuario NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Ajusteinv_hd WHERE Ajusteinv_hd.nro_usuario = Usuario.nro_usuario) OR
     CAN-FIND(FIRST Amd_header WHERE Amd_header.nro_usuario = Usuario.nro_usuario) OR
     CAN-FIND(FIRST Amp_header WHERE Amp_header.nro_usuario = Usuario.nro_usuario) OR
     CAN-FIND(FIRST Aps_header WHERE Aps_header.nro_usuario = Usuario.nro_usuario) OR
     CAN-FIND(FIRST Asn_header WHERE Asn_header.nro_usuario = Usuario.nro_usuario) OR
     CAN-FIND(FIRST Caj_header WHERE Caj_header.nro_usuario = Usuario.nro_usuario) OR
     CAN-FIND(FIRST Cliente-observacion WHERE Cliente-observacion.nro_usuario = Usuario.nro_usuario) OR
     CAN-FIND(FIRST Contrato_hd WHERE Contrato_hd.nro_usuario = Usuario.nro_usuario) OR
     /*CAN-FIND(FIRST Dev_header WHERE Dev_header.nro_usuario = Usuario.nro_usuario) OR*/
     CAN-FIND(FIRST Emb_header_prv WHERE Emb_header_prv.nro_usuario = Usuario.nro_usuario) OR
     CAN-FIND(FIRST Fac_header WHERE Fac_header.nro_usuario = Usuario.nro_usuario) OR
     CAN-FIND(FIRST Fac_header_prv WHERE Fac_header_prv.nro_usuario = Usuario.nro_usuario) OR
     CAN-FIND(FIRST Hst_estadoregis WHERE Hst_estadoregis.nro_usuario = Usuario.nro_usuario) OR
     CAN-FIND(FIRST Hst_ocompra WHERE Hst_ocompra.nro_usuario = Usuario.nro_usuario) OR
     CAN-FIND(FIRST Hst_pedido WHERE Hst_pedido.nro_usuario = Usuario.nro_usuario) OR
     CAN-FIND(FIRST Hst_requisicion WHERE Hst_requisicion.nro_usuario = Usuario.nro_usuario) OR
     CAN-FIND(FIRST Novedad-opago WHERE Novedad-opago.nro_usuario = Usuario.nro_usuario) OR
     /*CAN-FIND(FIRST Oci_header WHERE Oci_header.nro_usuario = Usuario.nro_usuario) OR*/
     CAN-FIND(FIRST Ocm_header WHERE Ocm_header.nro_usuario = Usuario.nro_usuario) OR
     CAN-FIND(FIRST Opg_header WHERE Opg_header.nro_usuario = Usuario.nro_usuario) OR
     CAN-FIND(FIRST Ped_header WHERE Ped_header.nro_usuario = Usuario.nro_usuario) OR
     CAN-FIND(FIRST Rec_header WHERE Rec_header.nro_usuario = Usuario.nro_usuario) OR
     CAN-FIND(FIRST Rem_header WHERE Rem_header.nro_usuario = Usuario.nro_usuario) OR
     CAN-FIND(FIRST Rem_header_prv WHERE Rem_header_prv.nro_usuario = Usuario.nro_usuario) OR
     CAN-FIND(FIRST Rqs_header WHERE Rqs_header.nro_usuario = Usuario.nro_usuario) OR
     CAN-FIND(FIRST Transdep_hd WHERE Transdep_hd.nro_usuario = Usuario.nro_usuario) OR
     CAN-FIND(FIRST Valeinv_hd WHERE Valeinv_hd.nro_usuario = Usuario.nro_usuario)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.
