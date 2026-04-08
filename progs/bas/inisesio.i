PROCEDURE INICIAR_SESION:

  IF CURRENT-WINDOW <> MAIN-WINDOW THEN ASSIGN CURRENT-WINDOW = MAIN-WINDOW.

  IF cod_aut = 0 
  THEN DO:
     ENABLE  btn_ABA
             btn_FAC
             btn_AFI
             btn_DSP
             btn_CXC
             btn_COM
             btn_IMP
             btn_EXP
             btn_CXP
             btn_OXP
             btn_OXC
             btn_VND
             btn_TES
             btn_ADP
             btn_INV
             btn_GLA
             btn_CPS
             btn_UTL
             WITH FRAME frm-logo.  
  END. 
  ELSE DO:
     DISABLE btn_ABA
             btn_FAC
             btn_AFI
             btn_DSP
             btn_CXC
             btn_COM
             btn_IMP
             btn_EXP
             btn_CXP
             btn_OXP
             btn_OXC
             btn_VND
             btn_TES
             btn_ADP
             btn_INV
             btn_GLA
             btn_CPS
             btn_UTL
             WITH FRAME frm-logo.  
  END. 

  MENU Principal:SENSITIVE = YES.

  IF MAIN-WINDOW:MENUBAR <> MENU Principal:HANDLE
  THEN DO:
     MAIN-WINDOW:TITLE = titulo.     
     MAIN-WINDOW:MENUBAR = MENU Principal:HANDLE.
  END.   

  SUB-MENU  Archivo:SENSITIVE = YES.
  SUB-MENU  Seguridad:SENSITIVE = CONNECTED("SIC").
  MENU-ITEM Conectar:SENSITIVE IN MENU Archivo = YES.
  MENU-ITEM Desconectar:SENSITIVE IN MENU Archivo = CONNECTED("SIC").
  MENU-ITEM Datos:SENSITIVE IN MENU Archivo = CONNECTED("SIC").
  MENU-ITEM Empresa:SENSITIVE IN MENU Archivo = CONNECTED("SIC").
  MENU-ITEM Salir:SENSITIVE IN MENU Archivo = YES.

  STATUS INPUT OFF IN WINDOW MAIN-WINDOW.
  VIEW FRAME frm-logo.

END PROCEDURE.
