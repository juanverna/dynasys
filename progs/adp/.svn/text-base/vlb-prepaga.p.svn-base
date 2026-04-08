
/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:Prepaga                             */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Prepaga AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Prepaga WHERE ROWID(Prepaga) = rid_Prepaga NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Empleado WHERE Empleado.cdg_prepaga = prepaga.cdg_prepaga) OR
     CAN-FIND(FIRST Prepaga_convenio WHERE Prepaga_convenio.cdg_prepaga = prepaga.cdg_prepaga)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.
