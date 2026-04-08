&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
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

  DEFINE VARIABLE intentos AS INTEGER INITIAL 0 NO-UNDO.

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
     SIZE 15 BY 1.12
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 15 BY 1.15
     BGCOLOR 8 .

DEFINE VARIABLE v-cdg_empresa AS CHARACTER FORMAT "X(256)":U 
     LABEL "Entidad" 
     VIEW-AS FILL-IN 
     SIZE 7 BY .81
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cdg_usuario AS CHARACTER FORMAT "X(256)":U 
     LABEL "Usuario" 
     VIEW-AS FILL-IN 
     SIZE 41 BY .81
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-clave AS CHARACTER FORMAT "X(256)":U 
     LABEL "Clave" 
     VIEW-AS FILL-IN 
     SIZE 25 BY .81
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-dsc_empresa AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 32 BY .81
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 53 BY 7.

DEFINE VARIABLE v-reconectar AS LOGICAL INITIAL no 
     LABEL "Reconectar" 
     VIEW-AS TOGGLE-BOX
     SIZE 13 BY .77 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     v-cdg_usuario AT ROW 2.08 COL 10 COLON-ALIGNED
     v-clave AT ROW 3.42 COL 10 COLON-ALIGNED BLANK 
     v-reconectar AT ROW 3.42 COL 40
     v-cdg_empresa AT ROW 4.77 COL 10 COLON-ALIGNED
     v-dsc_empresa AT ROW 4.77 COL 19 COLON-ALIGNED NO-LABEL
     Btn_OK AT ROW 6.38 COL 12
     Btn_Done AT ROW 6.38 COL 38
     RECT-1 AT ROW 1.27 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 16
         FONT 4
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
         HEIGHT             = 8.42
         WIDTH              = 55
         MAX-HEIGHT         = 16
         MAX-WIDTH          = 80
         VIRTUAL-HEIGHT     = 16
         VIRTUAL-WIDTH      = 80
         RESIZE             = yes
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
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
  
  ASSIGN FRAME {&FRAME-NAME} v-cdg_empresa v-reconectar.
  FIND Empresa WHERE Empresa.cdg_empresa = v-cdg_empresa NO-LOCK NO-ERROR.
  IF NOT AVAILABLE Empresa 
  THEN DO:
        MESSAGE "No existe la empresa indicada" VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
  END.
  ELSE DO:
        v-dsc_empresa = Empresa.nombre.
        DISPLAY v-dsc_empresa WITH FRAME {&FRAME-NAME}.
        ASSIGN FRAME {&FRAME-NAME} v-cdg_usuario v-clave.
        ok = SETUSERID(v-cdg_usuario, v-clave, "SIC").
        IF NOT ok 
        THEN DO:
             intentos = intentos + 1.
             MESSAGE "No existe el usuario indicado o la clave no coincide " STRING(intentos)
                      VIEW-AS ALERT-BOX ERROR TITLE "Error de acceso al sistema".
             IF intentos < 3 
                THEN RETURN NO-APPLY.
        END.     
        ELSE DO:
             FIND Usuario WHERE Usuario.cdg_usuario = USERID("sic") NO-LOCK NO-ERROR.
             IF Usuario.cdg_empresa <> "" AND NOT v-reconectar
             THEN DO:
                MESSAGE "El usuario ya se halla conectado o bien tiene una sesión anterior" 
                        "que termino anormalmente"
                        VIEW-AS ALERT-BOX ERROR.
                ok = FALSE.        
                RETURN NO-APPLY.
             END.
             ELSE DO:
                IF CAN-DO(Usuario.lista_empresas,Empresa.cdg_empresa)
                THEN DO:
                   DO TRANSACTION:
                      FIND CURRENT Usuario EXCLUSIVE-LOCK.                 
                      Usuario.cdg_empresa = Empresa.cdg_empresa.
                      FIND Entidad WHERE Entidad.cdg_entidad = Empresa.cdg_empresa NO-LOCK.
                      p-entidad_logon = Entidad.nro_entidad.
                      RELEASE Usuario.
                      /*
                      RUN mostrar_frase.
                      */
                      APPLY "CHOOSE" TO Btn_Done IN FRAME {&FRAME-NAME}.
                   END.
                END.
                ELSE DO:
                    MESSAGE "El usuario no ya se halla habilitado para conectarse a la empresa indicada" 
                            VIEW-AS ALERT-BOX ERROR.
                    ok = FALSE.        
                    RETURN NO-APPLY.
                 END.   
             END.
        END.     
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_empresa
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_empresa C-Win
ON LEAVE OF v-cdg_empresa IN FRAME DEFAULT-FRAME /* Entidad */
DO:

  ASSIGN FRAME {&FRAME-NAME} v-cdg_empresa.
  FIND Empresa WHERE Empresa.cdg_empresa = v-cdg_empresa NO-LOCK NO-ERROR.
  IF NOT AVAILABLE Empresa 
  THEN DO:
       MESSAGE "No existe la Empresa indicada" VIEW-AS ALERT-BOX ERROR.
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
  /* Delete the WINDOW we created */
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
  THEN DELETE WIDGET C-Win.
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

