
/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:Lista_Precios                             */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Lista_Precios AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Lista_Precios WHERE ROWID(Lista_Precios) = rid_Lista_Precios NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Articulo_precio WHERE Articulo_precio.cdg_lista = Lista_precios.cdg_lista) OR
     CAN-FIND(FIRST Contrato_hd WHERE Contrato_hd.cdg_lista = Lista_precios.cdg_lista) OR
     CAN-FIND(FIRST Emb_header_prv WHERE Emb_header_prv.cdg_lista = Lista_precios.cdg_lista) OR
     CAN-FIND(FIRST Fac_header WHERE Fac_header.cdg_lista = Lista_precios.cdg_lista) OR
     CAN-FIND(FIRST Fac_header_prv WHERE Fac_header_prv.cdg_lista = Lista_precios.cdg_lista) OR
     CAN-FIND(FIRST Lista_comisiones WHERE Lista_comisiones.cdg_lista = Lista_precios.cdg_lista) OR
     CAN-FIND(FIRST Ocm_header WHERE Ocm_header.cdg_lista = Lista_precios.cdg_lista) OR
     CAN-FIND(FIRST Ped_header WHERE Ped_header.cdg_lista = Lista_precios.cdg_lista) OR
     CAN-FIND(FIRST Rem_header WHERE Rem_header.cdg_lista = Lista_precios.cdg_lista) OR
     CAN-FIND(FIRST Rem_header_prv WHERE Rem_header_prv.cdg_lista = Lista_precios.cdg_lista) OR
     CAN-FIND(FIRST Vigencia_precios WHERE Vigencia_precios.cdg_lista = Lista_precios.cdg_lista)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.
