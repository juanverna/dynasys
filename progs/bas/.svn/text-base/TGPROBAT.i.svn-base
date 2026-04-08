ON VALUE-CHANGED OF procesar IN FRAME frm-rango
DO:

   ASSIGN procesar.
   IF procesar = "B"
   THEN DO:
      BELL.
      MESSAGE "Esta instalacion no soporta el procesamiento Batch."
              "La especificacion es ignorada."
              VIEW-AS ALERT-BOX WARNING TITLE "Aviso del sistema".
   END.

END.