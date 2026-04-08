
/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:Sucursal                             */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Sucursal AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Sucursal WHERE ROWID(Sucursal) = rid_Sucursal NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Ajusteinv_hd WHERE Ajusteinv_hd.num_sucursal = Sucursal.num_sucursal) OR
     CAN-FIND(FIRST Amd_header WHERE Amd_header.num_sucursal = Sucursal.num_sucursal) OR
     CAN-FIND(FIRST Amp_header WHERE Amp_header.num_sucursal = Sucursal.num_sucursal) OR
     CAN-FIND(FIRST Aps_header WHERE Aps_header.num_sucursal = Sucursal.num_sucursal) OR
     CAN-FIND(FIRST Asn_header WHERE Asn_header.num_sucursal = Sucursal.num_sucursal) OR
     CAN-FIND(FIRST Caj_header WHERE Caj_header.num_sucursal = Sucursal.num_sucursal) OR
     CAN-FIND(FIRST Cheque WHERE Cheque.num_sucursal = Sucursal.num_sucursal) OR
     CAN-FIND(FIRST Cliente WHERE Cliente.num_sucursal = Sucursal.num_sucursal) OR
     CAN-FIND(FIRST Contrato_hd WHERE Contrato_hd.num_sucursal = Sucursal.num_sucursal) OR
     CAN-FIND(FIRST Fac_header WHERE Fac_header.num_sucursal = Sucursal.num_sucursal) OR
     CAN-FIND(FIRST Fac_header_prv WHERE Fac_header_prv.num_sucursal = Sucursal.num_sucursal) OR
     CAN-FIND(FIRST Ocm_header WHERE Ocm_header.num_sucursal = Sucursal.num_sucursal) OR
     CAN-FIND(FIRST Opg_header WHERE Opg_header.num_sucursal = Sucursal.num_sucursal) OR
     CAN-FIND(FIRST Ped_header WHERE Ped_header.num_sucursal = Sucursal.num_sucursal) OR
     CAN-FIND(FIRST Rec_header WHERE Rec_header.num_sucursal = Sucursal.num_sucursal) OR
     CAN-FIND(FIRST Rem_header WHERE Rem_header.num_sucursal = Sucursal.num_sucursal) OR
     CAN-FIND(FIRST Rem_header_prv WHERE Rem_header_prv.num_sucursal = Sucursal.num_sucursal) OR
     CAN-FIND(FIRST Rqs_header WHERE Rqs_header.num_sucursal = Sucursal.num_sucursal) OR
     CAN-FIND(FIRST Transdep_hd WHERE Transdep_hd.num_sucursal = Sucursal.num_sucursal) OR
     CAN-FIND(FIRST Valeinv_hd WHERE Valeinv_hd.num_sucursal = Sucursal.num_sucursal) OR
     CAN-FIND(FIRST Valor WHERE Valor.num_sucursal = Sucursal.num_sucursal)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.
