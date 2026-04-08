/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE BONIFICACIONES                              */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Municipio AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Municipio WHERE ROWID(Municipio) = rid_Municipio NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.


PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Domicilio WHERE Domicilio.cdg_municipio = Municipio.cdg_municipio) 
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.


