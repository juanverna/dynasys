
/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:Convenio                             */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Convenio AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Convenio WHERE ROWID(Convenio) = rid_Convenio NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Concepto_Convenio WHERE Concepto_Convenio.cdg_convenio = convenio.cdg_convenio) OR
     CAN-FIND(FIRST Convenio-liquidacion WHERE Convenio-liquidacion.cdg_convenio = convenio.cdg_convenio) OR
     CAN-FIND(FIRST Empleado WHERE Empleado.cdg_convenio = convenio.cdg_convenio) OR
     CAN-FIND(FIRST Prepaga_convenio WHERE Prepaga_convenio.cdg_convenio = convenio.cdg_convenio) OR
     CAN-FIND(FIRST Sindicato_convenio WHERE Sindicato_convenio.cdg_convenio = convenio.cdg_convenio)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.
