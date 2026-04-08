/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE CUENTAS BANCARIAS                           */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_caja AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Caja WHERE ROWID(Caja) = rid_caja NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Acumulado_caja WHERE Acumulado_caja.cdg_caja = Caja.cdg_caja) OR
     CAN-FIND(FIRST Boleta_deposito_hd WHERE Boleta_deposito_hd.cdg_caja = Caja.cdg_caja) OR
     CAN-FIND(FIRST Caj_header WHERE Caj_header.cdg_caja = Caja.cdg_caja) OR
     CAN-FIND(FIRST Cheque WHERE Cheque.cdg_caja = Caja.cdg_caja) OR
     CAN-FIND(FIRST Valor WHERE Valor.cdg_caja = Caja.cdg_caja)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.

