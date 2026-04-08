/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:Convenio                             */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Convenio AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

DEFINE VARIABLE nombretabla AS CHARACTER EXTENT 5.
DEFINE VARIABLE en_uso      AS LOGICAL EXTENT 5.
DEFINE VARIABLE numero_tabla AS INTEGER.

ASSIGN nombretabla [ 1 ] = "Concepto_Convenio"
       nombretabla [ 2 ] = "Convenio-liquidacion"
       nombretabla [ 3 ] = "Empleado"
       nombretabla [ 4 ] = "Prepaga_convenio"
       nombretabla [ 5 ] = "Sindicato_convenio".


FIND Convenio WHERE ROWID(Convenio) = rid_Convenio NO-LOCK.

RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = NO.

  ASSIGN en_uso [ 1 ] = CAN-FIND(FIRST Concepto_Convenio WHERE Concepto_Convenio.cdg_convenio = convenio.cdg_convenio)
         en_uso [ 2 ] = CAN-FIND(FIRST Convenio-liquidacion WHERE Convenio-liquidacion.cdg_convenio = convenio.cdg_convenio)
         en_uso [ 3 ] = CAN-FIND(FIRST Empleado WHERE Empleado.cdg_convenio = convenio.cdg_convenio)
         en_uso [ 4 ] = CAN-FIND(FIRST Prepaga_convenio WHERE Prepaga_convenio.cdg_convenio = convenio.cdg_convenio)
         en_uso [ 5 ] = CAN-FIND(FIRST Sindicato_convenio WHERE Sindicato_convenio.cdg_convenio = convenio.cdg_convenio).
      
      
  DO numero_tabla = 1 TO 5:
      IF en_uso [ numero_tabla ]
      THEN DO:
          RUN ponmensj.p ( nombretabla [ numero_tabla ], "CONV003" ).
          hay_error = YES.
      END.
  END.

END PROCEDURE.


/*La idea es darle más precisión al mensaje de error.


  CONV003: "No se puede eliminar el Convenio porque esta siendo utilizado en la Tabla Concepto"

  CONV004: "No se puede eliminar el Convenio porque esta siendo utilizado en la Tabla Liquidación"
  
  Así sucesivamente se informa con más precisión el error.*/

/* ------------------------------------------------------------------------------------------------

DEFINE VARIABLE nombretabla AS CHARACTER EXTENT 5.

DEFINE VARIABLE numero_tabla AS INTEGER.

ASSIGN nombretabla [ 1 ] = "Concepto_Convenio"
       nombretabla [ 2 ] = "Convenio-liquidacion"
       nombretabla [ 3 ] = "Empleado"
       nombretabla [ 4 ] = "Prepaga_convenio"
       nombretabla [ 5 ] = "Sindicato_convenio".


      
  DO numero_tabla = 1 TO 5:
      MESSAGE "La tabla " numero_tabla " se llama " nombretabla [ numero_tabla ]
          VIEW-AS ALERT-BOX INFO BUTTONS OK.
  END.
  
*/  
