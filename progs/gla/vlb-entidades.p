/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE clienteS                                    */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_entidad AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Entidad WHERE ROWID(Entidad) = rid_entidad NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.


PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Acumulado_ctapsp WHERE Acumulado_ctapsp.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Acumulado_cuenta WHERE Acumulado_cuenta.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Ajusteinv_dt WHERE Ajusteinv_dt.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Ajusteinv_hd WHERE Ajusteinv_hd.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Amd_detalle WHERE Amd_detalle.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Amp_detalle WHERE Amp_detalle.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Aps_detalle WHERE Aps_detalle.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Aps_header WHERE Aps_header.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Area WHERE Area.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Asn_detalle WHERE Asn_detalle.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Asn_header WHERE Asn_header.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Caj_detalle WHERE Caj_detalle.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Caj_header WHERE Caj_header.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Cct_stock WHERE Cct_stock.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Cliente WHERE Cliente.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Concepto-cuenta WHERE Concepto-cuenta.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Deposito WHERE Deposito.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Destino WHERE Destino.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Dsp_header WHERE Dsp_header.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Emb_detalle_prv WHERE Emb_detalle_prv.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Emb_header_prv WHERE Emb_header_prv.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Emb_prv-gasto WHERE Emb_prv-gasto.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Empleado WHERE Empleado.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Empleado-entidad WHERE Empleado-entidad.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Fac_cli-gasto WHERE Fac_cli-gasto.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Fac_detalle WHERE Fac_detalle.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Fac_detalle_prv WHERE Fac_detalle_prv.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Fac_header WHERE Fac_header.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Fac_header_prv WHERE Fac_header_prv.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Fac_prv-gasto WHERE Fac_prv-gasto.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Obra WHERE Obra.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Ocm_header WHERE Ocm_header.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Opg_header WHERE Opg_header.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Ped_header WHERE Ped_header.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Proveedor WHERE Proveedor.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Rcb_header WHERE Rcb_header.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Rec_header WHERE Rec_header.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Rem_detalle_prv WHERE Rem_detalle_prv.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Rem_header WHERE Rem_header.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Rem_header_prv WHERE Rem_header_prv.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Rqs_header WHERE Rqs_header.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Sub_detalle_bco WHERE Sub_detalle_bco.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Sub_detalle_inv WHERE Sub_detalle_inv.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Sub_detalle_prv WHERE Sub_detalle_prv.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Sub_detalle_syj WHERE Sub_detalle_syj.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Sub_detalle_vta WHERE Sub_detalle_vta.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Sub_header_bco WHERE Sub_header_bco.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Sub_header_inv WHERE Sub_header_inv.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Sub_header_prv WHERE Sub_header_prv.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Sub_header_syj WHERE Sub_header_syj.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Sub_header_vta WHERE Sub_header_vta.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Transdep_dt WHERE Transdep_dt.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Transdep_hd WHERE Transdep_hd.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Valeinv_dt WHERE Valeinv_dt.nro_entidad = Entidad.nro_entidad) OR
     CAN-FIND(FIRST Valeinv_hd WHERE Valeinv_hd.nro_entidad = Entidad.nro_entidad)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.

