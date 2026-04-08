/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE CUENTAS BANCARIAS                           */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_rubro AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Rubro WHERE ROWID(Rubro) = rid_rubro NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.


PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Caj_detalle WHERE Caj_detalle.cdg_rubro = Rubro.cdg_rubro) OR
     CAN-FIND(FIRST Acumulado_caja WHERE Acumulado_caja.cdg_rubro = Rubro.cdg_rubro)
     THEN RETURN.
  
  hay_error = NO.
  
END PROCEDURE.

