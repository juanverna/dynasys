&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 Character
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------

  File: 

  Description: 

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: 

------------------------------------------------------------------------*/
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

  &IF DEFINED(UIB_is_Running) NE 0
  &THEN
  DEFINE VARIABLE ok                      AS LOGICAL.
  DEFINE VARIABLE p-entidad_logon         LIKE Entidad.nro_entidad.
  &ELSE
  DEFINE OUTPUT PARAMETER ok              AS LOGICAL.   
  DEFINE OUTPUT PARAMETER p-entidad_logon LIKE Entidad.nro_entidad.
  &ENDIF

  DEFINE VARIABLE intentos         AS INTEGER INITIAL 0 NO-UNDO.
  DEFINE VARIABLE intentos_usuario AS INTEGER INITIAL 0 NO-UNDO.
  DEFINE VARIABLE pcnombre         AS CHARACTER.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS v-cdg_usuario v-clave v-reconectar ~
v-cdg_empresa Btn_OK Btn_Done RECT-1 
&Scoped-Define DISPLAYED-OBJECTS v-cdg_usuario v-clave v-reconectar ~
v-cdg_empresa v-dsc_empresa 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Done DEFAULT 
     LABEL "&Cancelar" 
     &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN SIZE 15 BY 1
     &ELSE SIZE 15 BY 1 &ENDIF.

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN SIZE 15 BY 1
     &ELSE SIZE 15 BY 1 &ENDIF.

DEFINE VARIABLE v-cdg_empresa AS CHARACTER FORMAT "X(256)":U 
     LABEL "Empresa" 
     VIEW-AS FILL-IN NATIVE 
     &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN SIZE 7 BY 1
     &ELSE SIZE 7 BY 1 &ENDIF NO-UNDO.

DEFINE VARIABLE v-cdg_usuario AS CHARACTER FORMAT "X(256)":U 
     LABEL "Usuario" 
     VIEW-AS FILL-IN 
     &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN SIZE 43 BY 1
     &ELSE SIZE 43 BY 1 &ENDIF NO-UNDO.

DEFINE VARIABLE v-clave AS CHARACTER FORMAT "X(256)":U 
     LABEL "Clave" 
     VIEW-AS FILL-IN NATIVE 
     &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN SIZE 25 BY 1
     &ELSE SIZE 25 BY 1 &ENDIF NO-UNDO.

DEFINE VARIABLE v-dsc_empresa AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN SIZE 35 BY 1
     &ELSE SIZE 35 BY 1 &ENDIF NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN SIZE 56 BY 8
     &ELSE SIZE 56 BY 8 &ENDIF.

DEFINE VARIABLE v-reconectar AS LOGICAL INITIAL no 
     LABEL "Reconectar" 
     VIEW-AS TOGGLE-BOX
     &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN SIZE 16 BY 1
     &ELSE SIZE 16 BY 1 &ENDIF NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     v-cdg_usuario
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN AT ROW 2 COL 11 COLON-ALIGNED
          &ELSE AT ROW 2 COL 11 COLON-ALIGNED &ENDIF
     v-clave
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN AT ROW 4 COL 11 COLON-ALIGNED
          &ELSE AT ROW 4 COL 11 COLON-ALIGNED &ENDIF BLANK 
     v-reconectar
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN AT ROW 4 COL 40
          &ELSE AT ROW 4 COL 40 &ENDIF
     v-cdg_empresa
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN AT ROW 5 COL 11 COLON-ALIGNED
          &ELSE AT ROW 5 COL 11 COLON-ALIGNED &ENDIF
     v-dsc_empresa
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN AT ROW 5 COL 19 COLON-ALIGNED
          &ELSE AT ROW 5 COL 19 COLON-ALIGNED &ENDIF NO-LABEL
     Btn_OK
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN AT ROW 7 COL 13
          &ELSE AT ROW 7 COL 13 &ENDIF
     Btn_Done
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN AT ROW 7 COL 41
          &ELSE AT ROW 7 COL 41 &ENDIF
     RECT-1
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN AT ROW 1 COL 2
          &ELSE AT ROW 1 COL 2 &ENDIF
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 16
         DEFAULT-BUTTON Btn_OK.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Identificación del Usuario"
         HEIGHT             = 8.91
         WIDTH              = 59
         MAX-HEIGHT         = 16
         MAX-WIDTH          = 80
         VIRTUAL-HEIGHT     = 16
         VIRTUAL-WIDTH      = 80
         RESIZE             = yes
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = 7
         FGCOLOR            = 15
         KEEP-FRAME-Z-ORDER = yes
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR FRAME DEFAULT-FRAME
                                                                        */
/* SETTINGS FOR FILL-IN v-dsc_empresa IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Identificación del Usuario */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Identificación del Usuario */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Done
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Done C-Win
ON CHOOSE OF Btn_Done IN FRAME DEFAULT-FRAME /* Cancelar */
DO:
  &IF DEFINED (adm-panel) <> 0 &THEN
      RUN dispatch IN THIS-PROCEDURE ('exit').
  &ELSE
      APPLY "CLOSE":U TO THIS-PROCEDURE.
  &ENDIF
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK C-Win
ON CHOOSE OF Btn_OK IN FRAME DEFAULT-FRAME /* OK */
DO:
  DEFINE VARIABLE v-fecha_hoy AS DATE.
  
  ASSIGN FRAME {&FRAME-NAME} v-cdg_usuario v-clave v-cdg_empresa v-reconectar.
  v-fecha_hoy = TODAY.

  FIND Usuario WHERE Usuario.cdg_usuario = v-cdg_usuario NO-LOCK NO-ERROR.
  IF NOT AVAILABLE Usuario
  THEN DO:
      intentos = intentos + 1.
      RUN ponmensj.p ( INPUT "SEGU005" ).
      IF intentos < 2 
          THEN RETURN NO-APPLY.
  END.
  ELSE DO:
      IF Usuario.estado <> "A" 
      THEN DO:
          RUN ponmensj.p ( INPUT "SEGU011").
          RETURN NO-APPLY.
      END.
      ELSE DO:
          intentos = 0.
          ok = SETUSERID(v-cdg_usuario, v-clave, "SIC").
          IF NOT ok 
          THEN DO:
              intentos = intentos + 1.
              RUN ponmensj.p ( INPUT "SEGU006" ).
              IF intentos <  Usuario.cant_loginerroneos 
                  THEN RETURN NO-APPLY.
          END.
          ELSE DO:
              FIND Empresa WHERE Empresa.cdg_empresa = v-cdg_empresa NO-LOCK NO-ERROR.
              IF NOT AVAILABLE Empresa 
              THEN DO:
                  RUN ponmensj.p ( INPUT "SEGU008").
                  RETURN NO-APPLY.
              END.
              ELSE DO:
                  v-dsc_empresa = Empresa.nombre.
                  DISPLAY v-dsc_empresa WITH FRAME {&FRAME-NAME}.
                  FIND FIRST Logusuario OF Usuario WHERE Logusuario.abierta NO-ERROR.
          
                  IF  AVAILABLE Logusuario AND NOT v-reconectar
                  THEN DO:
                      RUN ponmensj.p ( INPUT "SEGU007" ).
                      ok = FALSE.        
                      RETURN NO-APPLY.
                  END.
                  ELSE DO:
                      IF NOT CAN-FIND(FIRST User_empresa OF Usuario 
                                      WHERE User_empresa.cdg_empresa = Empresa.cdg_empresa
                                        AND User_empresa.rige_desde <= v-fecha_hoy
                                        AND User_empresa.rige_hasta >= v-fecha_hoy)
                      THEN DO:
                          RUN ponmensj.p ( INPUT "SEGU013" ).
                          ok = FALSE.        
                          RETURN NO-APPLY.
                      END.
                      ELSE DO:
                          RUN pcname1.p ( OUTPUT pcnombre ).
                          IF NOT CAN-DO(Usuario.estaciones_habilitadas,pcnombre) 
                          THEN DO:
                              RUN ponmensj.p ( INPUT "SEGU009" ).
                              ok = FALSE.        
                              QUIT.
                          END.
                          ELSE DO:
                              IF Usuario.dias_inactivo > 0 AND v-fecha_hoy - Usuario.fch_ultimologin > Usuario.dias_inactivo
                              THEN DO:
                                  RUN ponmensj.p ( INPUT "SEGU012" ).
                                  ok = FALSE.        
                                  RETURN NO-APPLY.
                              END.
                              ELSE DO:
                                  IF Usuario.cambiar_clave OR (Usuario.dias_clave > 0 AND v-fecha_hoy - Usuario.fch_ultimaclave > Usuario.dias_clave )
                                  THEN DO:
                                      RUN d-asignar_clave.w ( OUTPUT ok ).
                                      IF NOT ok
                                      THEN DO:
                                          RUN ponmensj.p ( INPUT "SEGU010" ).
                                          QUIT.
                                      END.
                                  END.
                                  DO TRANSACTION:

                                      FIND CURRENT Usuario EXCLUSIVE-LOCK.  
                                      Usuario.lista_empresas = "".
                                      FOR EACH User_empresa OF Usuario 
                                          WHERE User_empresa.rige_desde <= v-fecha_hoy
                                            AND User_empresa.rige_hasta >= v-fecha_hoy:
                                                Usuario.lista_empresas = Usuario.lista_empresas + "," + User_empresa.cdg_empresa.

                                      END.
                                      Usuario.lista_empresas = SUBSTRING(Usuario.lista_empresas,2).
                                      Usuario.cdg_empresa = Empresa.cdg_empresa.
                                      Usuario.cambiar_clave = NO.
                                      Usuario.fch_ultimologin = v-fecha_hoy.

                                      IF AVAILABLE Logusuario
                                      THEN DO:
                                          FIND CURRENT Logusuario EXCLUSIVE-LOCK.
                                          ASSIGN Logusuario.abierta    = NO
                                                 Logusuario.fch_hasta  = v-fecha_hoy
                                                 Logusuario.hor_hasta  = TIME
                                                 Logusuario.hms_hasta  = STRING(Logusuario.hor_hasta,"HH:MM:SS").
                                      END.

                                      CREATE Logusuario.
                                      ASSIGN Logusuario.abierta          = YES
                                             Logusuario.cdg_empresa      = Empresa.cdg_empresa
                                             Logusuario.fch_desde        = v-fecha_hoy
                                             Logusuario.hor_desde        = TIME
                                             Logusuario.hms_desde        = STRING(Logusuario.hor_desde,"HH:MM:SS")
                                             Logusuario.fch_hasta        = ?
                                             Logusuario.hor_hasta        = ?
                                             Logusuario.hms_hasta        = ?
                                             Logusuario.fecha_sistema    = v-fecha_hoy
                                             Logusuario.nro_sesion       = NEXT-VALUE(proxima_sesion)
                                             Logusuario.nro_usuario      = Usuario.nro_usuario
                                             Logusuario.parametros       = ""
                                             Logusuario.pc_name          = pcnombre.
                                      FIND CURRENT Usuario NO-LOCK.

                                      FIND Entidad WHERE Entidad.cdg_entidad = Empresa.cdg_empresa NO-LOCK.
                                      p-entidad_logon = Entidad.nro_entidad.

                                  END.
                                  IF Usuario.mostrar_frase THEN RUN mostrar_frase.
                                  RELEASE Usuario.
                                  RELEASE Logusuario.
                                  APPLY "CHOOSE" TO Btn_Done IN FRAME {&FRAME-NAME}.
                              END.
                          END.
                      END.
                  END.
              END.
          END.     
      END.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_empresa
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_empresa C-Win
ON LEAVE OF v-cdg_empresa IN FRAME DEFAULT-FRAME /* Empresa */
DO:

  ASSIGN FRAME {&FRAME-NAME} v-cdg_empresa.
  FIND Empresa WHERE Empresa.cdg_empresa = v-cdg_empresa NO-LOCK NO-ERROR.
  IF NOT AVAILABLE Empresa 
  THEN DO:
       RUN ponmensj.p ( INPUT "SEGU008" ).
       RETURN NO-APPLY.
  END.
  ELSE DO:
       v-dsc_empresa = Empresa.nombre.
       DISPLAY v-dsc_empresa WITH FRAME {&FRAME-NAME}.
  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-clave
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-clave C-Win
ON RETURN OF v-clave IN FRAME DEFAULT-FRAME /* Clave */
DO:
  APPLY "CHOOSE" TO btn_ok.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-dsc_empresa
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-dsc_empresa C-Win
ON RETURN OF v-dsc_empresa IN FRAME DEFAULT-FRAME
DO:
  APPLY "CHOOSE" TO btn_ok.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.

/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
   RUN disable_UI.

/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
ASSIGN
         {&WINDOW-NAME}:ROW     = ( SESSION:HEIGHT-PIXELS - {&WINDOW-NAME}:HEIGHT-PIXELS ) / 
                                 SESSION:PIXELS-PER-ROW / 2  
         {&WINDOW-NAME}:COLUMN  = ( SESSION:WIDTH-PIXELS  - {&WINDOW-NAME}:WIDTH-PIXELS  ) / 
                                 SESSION:PIXELS-PER-COLUMN / 2.

IF {&WINDOW-NAME}:COLUMN = 0  THEN {&WINDOW-NAME}:COLUMN = 1.                                 
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI C-Win  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Hide all frames. */
  HIDE FRAME DEFAULT-FRAME.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI C-Win  _DEFAULT-ENABLE
PROCEDURE enable_UI :
/*------------------------------------------------------------------------------
  Purpose:     ENABLE the User Interface
  Parameters:  <none>
  Notes:       Here we display/view/enable the widgets in the
               user-interface.  In addition, OPEN all queries
               associated with each FRAME and BROWSE.
               These statements here are based on the "Other 
               Settings" section of the widget Property Sheets.
------------------------------------------------------------------------------*/
  DISPLAY v-cdg_usuario v-clave v-reconectar v-cdg_empresa v-dsc_empresa 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE v-cdg_usuario v-clave v-reconectar v-cdg_empresa Btn_OK Btn_Done 
         RECT-1 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE mostrar_frase C-Win 
PROCEDURE mostrar_frase :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE ultimo AS INTEGER.
  
  FIND LAST Frase_bienvenida.
  ultimo = Frase_bienvenida.nro_frase.

  FIND FIRST Frase_bienvenida WHERE Frase_bienvenida.nro_frase >= RANDOM(1,ultimo) NO-LOCK.
  MESSAGE Frase_bienvenida.texto VIEW-AS ALERT-BOX MESSAGE TITLE "Bienvenido a SIC. Su frase del día".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

