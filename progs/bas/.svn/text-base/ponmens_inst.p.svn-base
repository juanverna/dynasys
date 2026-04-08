/*=================================================================================*/
/*                    MANDA A PANTALLA UN MENSAJE DE ERROR                         */
/*=================================================================================*/

DEFINE INPUT PARAMETER que_mensaje LIKE Mensaje.cdg_mensaje.
DEFINE INPUT PARAMETER que_tabla   AS CHARACTER.
DEFINE INPUT PARAMETER que_codigo  AS CHARACTER.

DEFINE VARIABLE titulo    AS CHARACTER FORMAT "X(15)".
DEFINE VARIABLE exit_mens AS INTEGER.
DEFINE VARIABLE sino      AS LOGICAL FORMAT "X(15)".

FIND Mensaje WHERE Mensaje.cdg_mensaje = que_mensaje NO-LOCK NO-ERROR.
IF NOT AVAILABLE Mensaje
THEN DO:
   CREATE Mensaje.
   ASSIGN
      Mensaje.cdg_mensaje = que_mensaje
      Mensaje.tipo        = "E"
      Mensaje.texto       = "No fue hallado el mensaje de referencia".
END.

exit_mens = 1.

RUN TOCARSND.P (INPUT "SOUND\ERROR.WAV").
CASE tipo:
  WHEN "E"
  THEN DO:
     titulo = "Error:" + cdg_mensaje.
     MESSAGE texto SKIP 
             "En la Tabla : " que_tabla skip
             "el codigo : "  que_codigo VIEW-AS ALERT-BOX  ERROR BUTTONS OK TITLE titulo.
  END.
  WHEN "A"
  THEN DO:
     titulo = "Aviso:" + cdg_mensaje.
     MESSAGE texto skip
             "En la Tabla : " que_tabla skip
             "el codigo : "  que_codigo VIEW-AS ALERT-BOX WARNING BUTTONS OK TITLE titulo.
  END.
  WHEN "M"
  THEN DO:
     titulo = "Mensaje:" + cdg_mensaje.
     MESSAGE texto skip
             "En la Tabla : " que_tabla skip
             "el codigo : "  que_codigo 
         VIEW-AS ALERT-BOX MESSAGE BUTTONS OK TITLE titulo.
  END.
  WHEN "P"
  THEN DO:
     CASE exit_mens:
          WHEN 0 THEN sino = YES.
          WHEN 1 THEN sino = NO.
          WHEN 2 THEN sino = ?.
     END CASE.
     titulo = "Confirmacion:" + cdg_mensaje.
     MESSAGE texto SKIP 
         "En la Tabla : " que_tabla skip
         "el codigo : "  que_codigo 
         VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO-CANCEL TITLE titulo UPDATE sino.
     CASE sino:
          WHEN YES THEN exit_mens = 0.
          WHEN NO  THEN exit_mens = 1.
          WHEN ?   THEN exit_mens = 2.
     END CASE.

  END.
END.

