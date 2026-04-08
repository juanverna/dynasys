/*------------------------------------------------------------------------------------*/
/* Pone los Codigos de Control de la Impresora actual en el port                      */
/*------------------------------------------------------------------------------------*/
PROCEDURE PONE_CODIGO:

DEFINE INPUT PARAMETER cod_ctrl AS CHARACTER.

DEFINE VARIABLE j           AS INTEGER.
DEFINE VARIABLE var_funcion AS CHARACTER.

IF AVAILABLE (Impresora)
THEN DO:

   DO j = 1 TO NUM-ENTRIES(cod_ctrl):
      var_funcion = ENTRY(j,cod_ctrl).
      FIND Ctrl_impresora WHERE Ctrl_impresora.cdg_funcion = var_funcion
                             AND Ctrl_impresora.cdg_impresora = Impresora.cdg_impresora
                             NO-LOCK NO-ERROR.
      IF NOT AVAILABLE (Ctrl_impresora) 
      THEN DO:
         MESSAGE "La funcion" var_funcion "no es soportada por esta Impresora!"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK TITLE "Advertencia!".
      END.
      ELSE DO:
         PUT CONTROL Ctrl_impresora.secuencia.
      END.
   END.
   
END.   

END PROCEDURE.
