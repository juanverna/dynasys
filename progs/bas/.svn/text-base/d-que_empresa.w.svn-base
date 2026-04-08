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
  DEFINE VARIABLE p-que_empresa               LIKE Empresa.cdg_empresa.
  DEFINE VARIABLE p-modo_bajada               AS CHARACTER.
  DEFINE VARIABLE p-modo_importar             AS CHARACTER.
  &ELSE
  DEFINE OUTPUT PARAMETER p-que_empresa       LIKE Empresa.cdg_empresa.
  DEFINE OUTPUT PARAMETER p-modo_bajada       AS CHARACTER.
  DEFINE OUTPUT PARAMETER p-modo_importar     AS CHARACTER.
  &ENDIF

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS v-cdg_empresa v-modo_bajada Btn_OK Btn_Done ~
RECT-1 RECT-2 RECT-3 RECT-4 RECT-5 
&Scoped-Define DISPLAYED-OBJECTS v-cdg_empresa v-modo_bajada ~
v-modo_importar 

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
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE VARIABLE v-cdg_empresa AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Item 1","Item 1"
     DROP-DOWN-LIST
     SIZE 50 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-modo_bajada AS CHARACTER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Reemplazar menu completo", "reemplazar",
"Actualizar items existentes y agregar nuevos", "actualizar",
"Sólo agregar nuevos items", "agregar"
     SIZE 47 BY 3 NO-UNDO.

DEFINE VARIABLE v-modo_importar AS CHARACTER INITIAL "absoluto" 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Relativo dependiendo de la rama actual", "relativo",
"Absoluto tal cual como fue exportado", "absoluto"
     SIZE 42 BY 1.81 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 4 GRAPHIC-EDGE  NO-FILL 
     SIZE 56 BY 14.48.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 52 BY 4.86.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 52 BY 3.67.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 52 BY 1.67.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 52 BY 2.86.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     v-cdg_empresa AT ROW 3.38 COL 3 COLON-ALIGNED NO-LABEL
     v-modo_bajada AT ROW 6.48 COL 6 NO-LABEL
     v-modo_importar AT ROW 11.38 COL 6 NO-LABEL
     Btn_OK AT ROW 14 COL 5
     Btn_Done AT ROW 14 COL 40
     RECT-1 AT ROW 1.29 COL 2
     RECT-2 AT ROW 4.81 COL 4
     RECT-3 AT ROW 9.86 COL 4
     RECT-4 AT ROW 13.76 COL 4
     RECT-5 AT ROW 1.71 COL 4
     "            Tratamiento del menu existente" VIEW-AS TEXT
          SIZE 50 BY 1 AT ROW 5.1 COL 5
          BGCOLOR 5 FGCOLOR 15 
     "            Ubicación del nuevo menú importado" VIEW-AS TEXT
          SIZE 50 BY 1 AT ROW 10.1 COL 5
          BGCOLOR 5 FGCOLOR 15 
     "            Empresa a asignar al menú" VIEW-AS TEXT
          SIZE 50 BY 1 AT ROW 2.19 COL 5
          BGCOLOR 5 FGCOLOR 15 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 17.71
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
         TITLE              = "Identificación de Empresa"
         HEIGHT             = 15.05
         WIDTH              = 58.2
         MAX-HEIGHT         = 17.71
         MAX-WIDTH          = 80
         VIRTUAL-HEIGHT     = 17.71
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
/* SETTINGS FOR RADIO-SET v-modo_importar IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Identificación de Empresa */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Identificación de Empresa */
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
  p-que_empresa = ?.
  
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
  
  IF NOT CAN-FIND(Empresa WHERE Empresa.cdg_empresa = INPUT FRAME {&FRAME-NAME} v-cdg_empresa)
  THEN DO:
       MESSAGE "No existe la Empresa indicada" VIEW-AS ALERT-BOX ERROR.
       RETURN NO-APPLY.
  END.
  ELSE DO:
       ASSIGN FRAME {&FRAME-NAME} v-cdg_empresa v-modo_bajada v-modo_importar.
       p-que_empresa = v-cdg_empresa.
       p-modo_bajada = v-modo_bajada.
       p-modo_importar = v-modo_importar.
  END.
  APPLY "CLOSE":U TO THIS-PROCEDURE.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-modo_bajada
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-modo_bajada C-Win
ON VALUE-CHANGED OF v-modo_bajada IN FRAME DEFAULT-FRAME
DO:
  ASSIGN v-modo_bajada.
  IF v-modo_bajada = "agregar"
  THEN DO:
      v-modo_importar:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
  END.
  ELSE DO:
      v-modo_importar:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
  END.
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
  RUN inicia_combo.
  {findempresa.i}
  v-cdg_empresa = Empresa.cdg_empresa.
  DISPLAY v-cdg_empresa 
      WITH FRAME {&FRAME-NAME}.
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
  DISPLAY v-cdg_empresa v-modo_bajada v-modo_importar 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE v-cdg_empresa v-modo_bajada Btn_OK Btn_Done RECT-1 RECT-2 RECT-3 
         RECT-4 RECT-5 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE inicia_combo C-Win 
PROCEDURE inicia_combo :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  
  DEFINE VARIABLE ok AS LOGICAL.
  DEFINE VARIABLE lista AS CHARACTER.

  DO WITH FRAME {&FRAME-NAME}:
     {levantacombo.i &TABLA=Empresa &NOMBRE=nombre &CODIGO=cdg_empresa &OBJETO=v-cdg_empresa}
  END.          
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

