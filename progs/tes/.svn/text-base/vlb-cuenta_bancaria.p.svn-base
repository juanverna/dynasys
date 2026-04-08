/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE CUENTAS BANCARIAS                           */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_cuenta AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

{findempresa.i}

FIND Cuenta_bancaria WHERE ROWID(Cuenta_bancaria) = rid_cuenta NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.


PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Boleta_deposito_hd WHERE Boleta_deposito_hd.cdg_cuenta_ban = Cuenta_bancaria.cdg_cuenta_ban) OR
     CAN-FIND(FIRST Caj_detalle WHERE Caj_detalle.cdg_cuenta_ban = Cuenta_bancaria.cdg_cuenta_ban) OR
     CAN-FIND(FIRST Cheque WHERE Cheque.cdg_cuenta_ban = Cuenta_bancaria.cdg_cuenta_ban) OR
     CAN-FIND(FIRST Chequera WHERE Chequera.cdg_cuenta_ban = Cuenta_bancaria.cdg_cuenta_ban) OR
     CAN-FIND(FIRST Cta_cte_bco WHERE Cta_cte_bco.cdg_cuenta_ban = Cuenta_bancaria.cdg_cuenta_ban) OR
     CAN-FIND(FIRST Extracto WHERE Extracto.cdg_cuenta_ban = Cuenta_bancaria.cdg_cuenta_ban) OR
     CAN-FIND(FIRST Sub_detalle_bco WHERE Sub_detalle_bco.cdg_cuenta_ban = Cuenta_bancaria.cdg_cuenta_ban) OR
     CAN-FIND(FIRST Sub_header_bco WHERE Sub_header_bco.cdg_cuenta_ban = Cuenta_bancaria.cdg_cuenta_ban) OR
     CAN-FIND(FIRST Valor WHERE Valor.cdg_cuenta_ban = Cuenta_bancaria.cdg_cuenta_ban)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.

