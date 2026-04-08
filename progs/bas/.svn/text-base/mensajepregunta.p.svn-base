/*=================================================================================*/
/*                    MANDA A PANTALLA UN MENSAJE DE ERROR                         */ 
/*=================================================================================*/

DEFINE INPUT PARAMETER p-reemplazo AS CHARACTER.
DEFINE INPUT PARAMETER que_mensaje   LIKE Mensaje.cdg_mensaje.
DEFINE INPUT-OUTPUT PARAMETER sino      AS LOGICAL.

/*=================================================================================*/
/*                        DEFINICION DE VARIABLES                                  */
/*=================================================================================*/

DEFINE VARIABLE titulo_mensaje    AS CHARACTER.
DEFINE VARIABLE texto_mensaje     AS CHARACTER.

DEFINE VARIABLE j-parametro       AS INTEGER.

/*=================================================================================*/
/*                               PROCESO                                           */
/*=================================================================================*/

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
      MESSAGE texto_mensaje VIEW-AS ALERT-BOX ERROR TITLE titulo_mensaje.
  END.
  WHEN "M"
  THEN DO:
      titulo_mensaje = "Mensaje:" + Mensaje.cdg_mensaje.
      MESSAGE texto_mensaje VIEW-AS ALERT-BOX ERROR TITLE titulo_mensaje.
  END.
  WHEN "P"
  THEN DO:
      IF sino = ?
          THEN sino = Mensaje.dfl_respuesta.
      titulo_mensaje = "Consulta:" + Mensaje.cdg_mensaje.
      MESSAGE texto_mensaje VIEW-AS ALERT-BOX 
          QUESTION BUTTONS YES-NO TITLE titulo_mensaje UPDATE sino.
  END.
  WHEN "F"
  THEN DO:
      IF sino = ?
          THEN sino = Mensaje.dfl_respuesta.
      titulo_mensaje = "Confirmacion:" + Mensaje.cdg_mensaje.
      MESSAGE texto_mensaje VIEW-AS ALERT-BOX 
          QUESTION BUTTONS YES-NO-CANCEL TITLE titulo_mensaje UPDATE sino.
  END.
END.

