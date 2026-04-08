{VRSHARED.I}

DEFINE SHARED VARIABLE MAIN-WINDOW  AS WIDGET-HANDLE NO-UNDO.
DEFINE SHARED VARIABLE titulo       AS CHARACTER INITIAL "Ingreso al sistema".

   FIND Usuario WHERE Usuario.cdg_usuario = USERID("SIC") NO-LOCK.
   titulo = ENTRY(1,titulo,"-") + "- " + Usuario.cdg_usuario.
   MAIN-WINDOW:TITLE = titulo.        
  
