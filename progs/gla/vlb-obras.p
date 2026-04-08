/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE clienteS                                    */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Obra AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Obra WHERE ROWID(Obra) = rid_obra NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.


PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Ajusteinv_dt WHERE Ajusteinv_dt.nro_obra = Obra.nro_obra) OR
     CAN-FIND(FIRST Amd_detalle WHERE Amd_detalle.nro_obra = Obra.nro_obra) OR
     CAN-FIND(FIRST Amp_detalle WHERE Amp_detalle.nro_obra = Obra.nro_obra) OR
     CAN-FIND(FIRST Aps_detalle WHERE Aps_detalle.nro_obra = Obra.nro_obra) OR
     CAN-FIND(FIRST Asn_detalle WHERE Asn_detalle.nro_obra = Obra.nro_obra) OR
     CAN-FIND(FIRST Caj_header WHERE Caj_header.nro_obra = Obra.nro_obra) OR
     CAN-FIND(FIRST Emb_detalle_prv WHERE Emb_detalle_prv.nro_obra = Obra.nro_obra) OR
     CAN-FIND(FIRST Emb_prv-gasto WHERE Emb_prv-gasto.nro_obra = Obra.nro_obra) OR
     CAN-FIND(FIRST Fac_cli-gasto WHERE Fac_cli-gasto.nro_obra = Obra.nro_obra) OR
     CAN-FIND(FIRST Fac_detalle WHERE Fac_detalle.nro_obra = Obra.nro_obra) OR
     CAN-FIND(FIRST Fac_detalle_prv WHERE Fac_detalle_prv.nro_obra = Obra.nro_obra) OR
     CAN-FIND(FIRST Fac_header_prv WHERE Fac_header_prv.nro_obra = Obra.nro_obra) OR
     CAN-FIND(FIRST Fac_prv-gasto WHERE Fac_prv-gasto.nro_obra = Obra.nro_obra) OR
     CAN-FIND(FIRST Rem_detalle_prv WHERE Rem_detalle_prv.nro_obra = Obra.nro_obra) OR
     CAN-FIND(FIRST Sub_detalle_inv WHERE Sub_detalle_inv.nro_obra = Obra.nro_obra) OR
     CAN-FIND(FIRST Sub_detalle_prv WHERE Sub_detalle_prv.nro_obra = Obra.nro_obra) OR
     CAN-FIND(FIRST Sub_detalle_syj WHERE Sub_detalle_syj.nro_obra = Obra.nro_obra) OR
     CAN-FIND(FIRST Transdep_dt WHERE Transdep_dt.nro_obra = Obra.nro_obra) OR
     CAN-FIND(FIRST Valeinv_dt WHERE Valeinv_dt.nro_obra = Obra.nro_obra)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.

