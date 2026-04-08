
/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:Tanques                             */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Tanques AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Tanques WHERE ROWID(Tanques) = rid_Tanques NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.
     
    IF
     CAN-FIND(FIRST Tanque_Tapas WHERE Tanque_Tapas.nro_tanque = tanques.nro_tanque)
    THEN RETURN.

  hay_error = NO.

END PROCEDURE.
