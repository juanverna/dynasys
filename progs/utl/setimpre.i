/*------------------------------------------------------------------------------------*/
/* Busca la Impresora correspondiente a este listado, y fija las variables de codigos */
/* de control especificas.                                                            */
/*------------------------------------------------------------------------------------*/

FIND List_impresora WHERE List_impresora.listado + ".P" = PROGRAM-NAME(1) NO-LOCK NO-ERROR.
IF NOT AVAILABLE (List_impresora)
THEN DO:
   IF war_asgprt
      THEN MESSAGE "Este Listado no tiene asignada ninguna Impresora!"
                    VIEW-AS ALERT-BOX WARNING BUTTONS OK TITLE "Advertencia!".
 
END.
ELSE DO:
   FIND Impresora OF List_impresora NO-LOCK NO-ERROR.
   IF NOT AVAILABLE (Impresora) 
   THEN DO:
      MESSAGE "Esta Impresora no se encuentra disponible!"
         VIEW-AS ALERT-BOX WARNING BUTTONS OK TITLE "Advertencia!".
   END.
   ELSE DO:
      port = Impresora.puerto.
   END.
END.
