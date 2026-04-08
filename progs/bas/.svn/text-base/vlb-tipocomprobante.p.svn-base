/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE clienteS                                    */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Tipocomprobante AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.
DEFINE OUTPUT PARAMETER archivo AS CHARACTER.

FIND Tipocomprobante WHERE ROWID(Tipocomprobante) = rid_Tipocomprobante NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Comprobante_concepto WHERE Comprobante_concepto.cdg_comprobante = Tipocomprobante.cdg_comprobante) THEN
  DO:
        ARCHIVO = "Comprobante_concepto".
        RETURN.
     END.
  IF    CAN-FIND(FIRST Fac_header WHERE Fac_header.cdg_comprobante = Tipocomprobante.cdg_comprobante) THEN
  DO:
        ARCHIVO = "Fac_header".
        RETURN.
     END.
  IF    CAN-FIND(FIRST Rec_header WHERE Rec_header.cdg_comprobante = Tipocomprobante.cdg_comprobante) THEN
      DO:
        ARCHIVO = "Rec_header".
        RETURN.
     END.
  IF    CAN-FIND(FIRST Rem_header WHERE Rem_header.cdg_comprobante = Tipocomprobante.cdg_comprobante) THEN
     DO:
        ARCHIVO = "Rem_header".
        RETURN.
     END.
  IF    CAN-FIND(FIRST Sub_header_inv WHERE Sub_header_inv.cdg_comprobante = Tipocomprobante.cdg_comprobante) THEN
      DO:
        ARCHIVO = "Sub_header_inv".
        RETURN.
     END.
  IF    CAN-FIND(FIRST Sub_header_vta WHERE Sub_header_vta.cdg_comprobante = Tipocomprobante.cdg_comprobante) THEN
      DO:
        ARCHIVO = "Sub_header_vta".
        RETURN.
     END.
  IF    CAN-FIND(FIRST Tipo_puntovta WHERE Tipo_puntovta.cdg_comprobante = Tipocomprobante.cdg_comprobante) THEN
    DO:
        ARCHIVO = "Tipo_puntovta".
        RETURN.
     END.

  hay_error = NO.

END PROCEDURE.

