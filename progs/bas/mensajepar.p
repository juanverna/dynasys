/*=================================================================================*/
/*                    MANDA A PANTALLA UN MENSAJE DE ERROR                         */ 
/*=================================================================================*/

DEFINE INPUT PARAMETER p-reemplazo AS CHARACTER.
DEFINE INPUT PARAMETER que_mensaje   LIKE Mensaje.cdg_mensaje.

/*=================================================================================*/
/*                        DEFINICION DE VARIABLES                                  */
/*=================================================================================*/

DEFINE VARIABLE titulo_mensaje    AS CHARACTER.
DEFINE VARIABLE texto_mensaje     AS CHARACTER.

DEFINE VARIABLE j-parametro       AS INTEGER.
DEFINE VARIABLE level AS INTEGER NO-UNDO INITIAL 1.
DEFINE VAR msg AS CHAR NO-UNDO.
/*=================================================================================*/
/*                               PROCESO                                           */
/*=================================================================================*/

IF p-reemplazo = "" OR p-reemplazo = ? THEN DO:
     msg = "".
     REPEAT WHILE PROGRAM-NAME(level) <> ?:  
         msg = msg + chr(10) + string(LEVEL) + ":" +  string(PROGRAM-NAME(level),"x(30)").  
         level = level + 1.
     END.
     MESSAGE SUBSTRING(msg,2) VIEW-AS ALERT-BOX ERROR TITLE "Parametro no enviado".

END.
FIND Mensaje WHERE Mensaje.cdg_mensaje = que_mensaje NO-LOCK NO-ERROR.
IF NOT AVAILABLE Mensaje
THEN DO:
    DO TRANSACTION:
        CREATE Mensaje.
        ASSIGN Mensaje.cdg_mensaje = que_mensaje
               Mensaje.tipo        = "E"
               Mensaje.texto       = "No fue hallado el mensaje de referencia".
    END.
END.

texto_mensaje = Mensaje.texto.
DO j-parametro = 1 TO NUM-ENTRIES(p-reemplazo,CHR(1)):
    texto_mensaje = REPLACE(texto_mensaje,"&" + STRING(j-parametro,"9"),ENTRY(j-parametro,p-reemplazo,CHR(1))).
END.

CASE Mensaje.tipo:
  WHEN "E"
  THEN DO:
      titulo_mensaje = "Error:" + Mensaje.cdg_mensaje.
      MESSAGE texto_mensaje VIEW-AS ALERT-BOX ERROR TITLE titulo_mensaje.
  END.
  WHEN "A"
  THEN DO:
      titulo_mensaje = "Aviso:" + Mensaje.cdg_mensaje.
      MESSAGE texto_mensaje VIEW-AS ALERT-BOX WARNING TITLE titulo_mensaje.
  END.
  WHEN "M"
  THEN DO:
      titulo_mensaje = "Mensaje:" + Mensaje.cdg_mensaje.      
      MESSAGE texto_mensaje VIEW-AS ALERT-BOX INFO TITLE titulo_mensaje.
  END.
END.

