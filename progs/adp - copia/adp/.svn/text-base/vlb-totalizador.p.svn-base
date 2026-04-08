
/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:Totalizador                             */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Totalizador AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Totalizador WHERE ROWID(Totalizador) = rid_Totalizador NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Concepto WHERE Concepto.cdg_totalizador = totalizador.cdg_totalizador) OR
     CAN-FIND(FIRST Total-liquidacion WHERE Total-liquidacion.cdg_totalizador = totalizador.cdg_totalizador)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.
