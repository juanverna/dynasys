
/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:Afjp                             */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Afjp AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Afjp WHERE ROWID(Afjp) = rid_Afjp NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

 IF  CAN-FIND(FIRST Empleado WHERE Empleado.cdg_afjp = afjp.cdg_afjp) OR
     CAN-FIND(FIRST Hst_afjp WHERE Hst_afjp.cdg_afjp = afjp.cdg_afjp)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.
