
/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:Moneda                             */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Moneda AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Moneda WHERE ROWID(Moneda) = rid_Moneda NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Acumulado_ccte WHERE Acumulado_ccte.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Acumulado_ccte_prv WHERE Acumulado_ccte_prv.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Acumulado_ctapsp WHERE Acumulado_ctapsp.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Acumulado_cuenta WHERE Acumulado_cuenta.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Amd_detalle WHERE Amd_detalle.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Aps_detalle WHERE Aps_detalle.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Aps_totales WHERE Aps_totales.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Asn_detalle WHERE Asn_detalle.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Asn_header WHERE Asn_header.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Asn_totales WHERE Asn_totales.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Bduso_valor WHERE Bduso_valor.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Bono WHERE Bono.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Caj_header WHERE Caj_header.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Contrato_hd WHERE Contrato_hd.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Cotizacion WHERE Cotizacion.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Ctapsp-moneda WHERE Ctapsp-moneda.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Cta_cte WHERE Cta_cte.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Cta_cte_com WHERE Cta_cte_com.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Cta_cte_prv WHERE Cta_cte_prv.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Cuadro_resultados WHERE Cuadro_resultados.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Cuenta-moneda WHERE Cuenta-moneda.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Emb_header_prv WHERE Emb_header_prv.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Fac_header WHERE Fac_header.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Fac_header_prv WHERE Fac_header_prv.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Hst_caj_header WHERE Hst_caj_header.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Hst_opg_header WHERE Hst_opg_header.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Hst_rendgastos WHERE Hst_rendgastos.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Imputacion_difcambios WHERE Imputacion_difcambios.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Lista_Precios WHERE Lista_Precios.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Lote_pago WHERE Lote_pago.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Ocm_header WHERE Ocm_header.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Opg_header WHERE Opg_header.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Ped_header WHERE Ped_header.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Rec_header WHERE Rec_header.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Rem_header WHERE Rem_header.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Rem_header_prv WHERE Rem_header_prv.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Rendgastos_hd WHERE Rendgastos_hd.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Rescuenta_hd WHERE Rescuenta_hd.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Rqs_header WHERE Rqs_header.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Rubro WHERE Rubro.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Saldos_x_cuenta WHERE Saldos_x_cuenta.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Sre_header WHERE Sre_header.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Sub_header_prv WHERE Sub_header_prv.nro_moneda = Moneda.nro_moneda) OR
     CAN-FIND(FIRST Sub_header_vta WHERE Sub_header_vta.nro_moneda = Moneda.nro_moneda)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.
