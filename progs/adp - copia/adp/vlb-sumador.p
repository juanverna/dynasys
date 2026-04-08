
/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:Sumador                             */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Sumador AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Sumador WHERE ROWID(Sumador) = rid_Sumador NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Concepto WHERE Concepto.cdg_sumador = sumador.cdg_sumador)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.
