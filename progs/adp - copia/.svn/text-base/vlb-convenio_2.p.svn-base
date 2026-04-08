
/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:Convenio                             */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Convenio AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Convenio WHERE ROWID(Convenio) = rid_Convenio NO-LOCK.

RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  /*hay_error = YES.*/
  hay_error = NO.

  IF CAN-FIND(FIRST Concepto_Convenio WHERE Concepto_Convenio.cdg_convenio = convenio.cdg_convenio)
     THEN DO:
      RUN ponmensj.p ( "CONV003" ).
      hay_error = YES.
  END.
      
  IF CAN-FIND(FIRST Convenio-liquidacion WHERE Convenio-liquidacion.cdg_convenio = convenio.cdg_convenio)
     THEN DO:
      RUN ponmensj.p ( "CONV004" ).
      hay_error = YES. 
  END.
      
  IF CAN-FIND(FIRST Empleado WHERE Empleado.cdg_convenio = convenio.cdg_convenio)
     THEN DO:
      RUN ponmensj.p ( "CONV003" ).
      hay_error = YES.
  END.
      
  IF CAN-FIND(FIRST Prepaga_convenio WHERE Prepaga_convenio.cdg_convenio = convenio.cdg_convenio)
     THEN DO:
      RUN ponmensj.p ( "CONV003" ).
      hay_error = YES.
  END.

  IF CAN-FIND(FIRST Sindicato_convenio WHERE Sindicato_convenio.cdg_convenio = convenio.cdg_convenio)
     THEN DO:
      RUN ponmensj.p ( "CONV003" ).
      hay_error = YES.
  END.
  
  IF hay_error
       THEN RETURN ERROR.

  /*THEN RETURN.*/

  hay_error = NO.

END PROCEDURE.


/*La idea es darle más precisión al mensaje de error.


  CONV003: "No se puede eliminar el Convenio porque esta siendo utilizado en la Tabla Concepto"

  CONV004: "No se puede eliminar el Convenio porque esta siendo utilizado en la Tabla Liquidación"
  
  Así sucesivamente se informa con más precisión el error.*/
