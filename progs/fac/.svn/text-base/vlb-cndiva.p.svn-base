
/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:Condicion_impos                             */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Condicion_impos AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Condicion_impos WHERE ROWID(Condicion_impos) = rid_Condicion_impos NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Articulo-impuesto WHERE Articulo-impuesto.cdg_condiva = Condicion_impos.cdg_condiva) OR
     CAN-FIND(FIRST Cliente WHERE Cliente.cdg_condiva = Condicion_impos.cdg_condiva) OR
     CAN-FIND(FIRST Contrato_hd WHERE Contrato_hd.cdg_condiva = Condicion_impos.cdg_condiva) OR
     CAN-FIND(FIRST Dsp_header WHERE Dsp_header.cdg_condiva = Condicion_impos.cdg_condiva) OR
     CAN-FIND(FIRST Emb_header_prv WHERE Emb_header_prv.cdg_condiva = Condicion_impos.cdg_condiva) OR
     CAN-FIND(FIRST Fac_header WHERE Fac_header.cdg_condiva = Condicion_impos.cdg_condiva) OR
     CAN-FIND(FIRST Fac_header_prv WHERE Fac_header_prv.cdg_condiva = Condicion_impos.cdg_condiva) OR
     CAN-FIND(FIRST Famganancias_regimen WHERE Famganancias_regimen.cdg_condiva = Condicion_impos.cdg_condiva) OR
     CAN-FIND(FIRST Famretibr_regimen WHERE Famretibr_regimen.cdg_condiva = Condicion_impos.cdg_condiva) OR
     CAN-FIND(FIRST Famretiva_regimen WHERE Famretiva_regimen.cdg_condiva = Condicion_impos.cdg_condiva) OR
     CAN-FIND(FIRST Famretsuss_regimen WHERE Famretsuss_regimen.cdg_condiva = Condicion_impos.cdg_condiva) OR
  /* CAN-FIND(FIRST Grupofam WHERE Grupofam.cdg_condiva = Condicion_impos.cdg_condiva) OR */
     CAN-FIND(FIRST Hst_Cliente WHERE Hst_Cliente.cdg_condiva = Condicion_impos.cdg_condiva) OR
     CAN-FIND(FIRST Hst_Fac_header WHERE Hst_Fac_header.cdg_condiva = Condicion_impos.cdg_condiva) OR
     CAN-FIND(FIRST Hst_opg_header WHERE Hst_opg_header.cdg_condiva = Condicion_impos.cdg_condiva) OR
     CAN-FIND(FIRST Hst_Proveedor WHERE Hst_Proveedor.cdg_condiva = Condicion_impos.cdg_condiva) OR
     CAN-FIND(FIRST Hst_rec_header WHERE Hst_rec_header.cdg_condiva = Condicion_impos.cdg_condiva) OR
     CAN-FIND(FIRST Impuesto_condicion WHERE Impuesto_condicion.cdg_condiva = Condicion_impos.cdg_condiva) OR
     CAN-FIND(FIRST Ocm_header WHERE Ocm_header.cdg_condiva = Condicion_impos.cdg_condiva) OR
     CAN-FIND(FIRST Opg_header WHERE Opg_header.cdg_condiva = Condicion_impos.cdg_condiva) OR
     CAN-FIND(FIRST Ped_header WHERE Ped_header.cdg_condiva = Condicion_impos.cdg_condiva) OR
     CAN-FIND(FIRST Proveedor WHERE Proveedor.cdg_condiva = Condicion_impos.cdg_condiva) OR
     CAN-FIND(FIRST Rec_header WHERE Rec_header.cdg_condiva = Condicion_impos.cdg_condiva) OR
     CAN-FIND(FIRST Rem_header WHERE Rem_header.cdg_condiva = Condicion_impos.cdg_condiva) OR
     CAN-FIND(FIRST Rem_header_prv WHERE Rem_header_prv.cdg_condiva = Condicion_impos.cdg_condiva)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.
