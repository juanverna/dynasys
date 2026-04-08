/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE clienteS                                    */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_imputacion AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Imputacion WHERE ROWID(Imputacion) = rid_imputacion NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Ajusteinv_hd WHERE Ajusteinv_hd.cdg_imputacion = Imputacion.cdg_imputacion) OR
     CAN-FIND(FIRST Comprobante_concepto WHERE Comprobante_concepto.cdg_imputacion = Imputacion.cdg_imputacion) OR
     CAN-FIND(FIRST Cta_cte WHERE Cta_cte.cdg_imputacion = Imputacion.cdg_imputacion) OR
     CAN-FIND(FIRST Cta_cte_com WHERE Cta_cte_com.cdg_imputacion = Imputacion.cdg_imputacion) OR
     CAN-FIND(FIRST Cta_cte_prv WHERE Cta_cte_prv.cdg_imputacion = Imputacion.cdg_imputacion) OR
     CAN-FIND(FIRST Emb_header_prv WHERE Emb_header_prv.cdg_imputacion = Imputacion.cdg_imputacion) OR
     CAN-FIND(FIRST Fac_header WHERE Fac_header.cdg_imputacion = Imputacion.cdg_imputacion) OR
     CAN-FIND(FIRST Fac_header_prv WHERE Fac_header_prv.cdg_imputacion = Imputacion.cdg_imputacion) OR
     CAN-FIND(FIRST Familia_cuenta WHERE Familia_cuenta.cdg_imputacion = Imputacion.cdg_imputacion) OR
     CAN-FIND(FIRST Impuesto_concepto WHERE Impuesto_concepto.cdg_imputacion = Imputacion.cdg_imputacion) OR
     CAN-FIND(FIRST Ocm_header WHERE Ocm_header.cdg_imputacion = Imputacion.cdg_imputacion) OR
     CAN-FIND(FIRST Opg_header WHERE Opg_header.cdg_imputacion = Imputacion.cdg_imputacion) OR
     CAN-FIND(FIRST Ped_header WHERE Ped_header.cdg_imputacion = Imputacion.cdg_imputacion) OR
     CAN-FIND(FIRST Rec_header WHERE Rec_header.cdg_imputacion = Imputacion.cdg_imputacion) OR
     CAN-FIND(FIRST Rem_header WHERE Rem_header.cdg_imputacion = Imputacion.cdg_imputacion) OR
     CAN-FIND(FIRST Rem_header_prv WHERE Rem_header_prv.cdg_imputacion = Imputacion.cdg_imputacion) OR
     CAN-FIND(FIRST Transdep_hd WHERE Transdep_hd.cdg_imputacion = Imputacion.cdg_imputacion) OR
     CAN-FIND(FIRST Valeinv_hd WHERE Valeinv_hd.cdg_imputacion = Imputacion.cdg_imputacion)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.
