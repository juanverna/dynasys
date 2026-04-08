/*=================================================================================================*/
/*                EDITA LA LISTA DE SECUENCIAS SELECCIONADAS PARA UN A IMPRESORA DADA              */
/*=================================================================================================*/

  DEFINE INPUT-OUTPUT PARAMETER p-seleccion AS CHARACTER.
  DEFINE INPUT PARAMETER p-impresora LIKE Impresora.cdg_impresora.

  DEFINE VARIABLE selectados AS CHARACTER.
  DEFINE VARIABLE disponibles AS CHARACTER.  

  DEFINE VARIABLE k AS INTEGER.

  FIND Impresora WHERE Impresora.cdg_impresora = p-impresora NO-LOCK NO-ERROR.
     MESSAGE AVAILABLE impresora VIEW-AS ALERT-BOX MESSAGE TITLE "Impresora - Procedure".
  FOR EACH Ctrl_impresora OF Impresora: 
      IF LOOKUP(Ctrl_impresora.cdg_funcion,p-seleccion) = 0
      THEN DO:
          disponibles = disponibles + "," + Ctrl_impresora.descripcion.
      END.
      ELSE DO:
          selectados = selectados + "," + Ctrl_impresora.descripcion.
      END.
  END.
  selectados = SUBSTRING(selectados,2).
  disponibles = SUBSTRING(disponibles,2).
  RUN d-selectar.w ( INPUT-OUTPUT selectados, 
                     INPUT-OUTPUT disponibles, 
                     INPUT "Selección de secuencias de escape").

  p-seleccion = "".
  DO k = 1 TO NUM-ENTRIES(selectados,","):
      FIND Ctrl_impresora 
          WHERE Ctrl_impresora.cdg_impresora = p-impresora
            AND Ctrl_impresora.descripcion = ENTRY(k,selectados,",") NO-LOCK.
      p-seleccion = p-seleccion + "," + Ctrl_impresora.cdg_funcion.
  END.
  p-seleccion = SUBSTRING(p-seleccion,2).

