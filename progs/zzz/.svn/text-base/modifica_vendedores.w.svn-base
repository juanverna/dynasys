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

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-1 v-cdg_cliente v-cdg_vendedor ~
btn_grabar btn_cancelar 
&Scoped-Define DISPLAYED-OBJECTS v-cdg_cliente v-nom_cliente v-cdg_vendedor ~
v-nom_vendedor 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btn_cancelar 
     LABEL "&Cancelar" 
     SIZE 14 BY 1.12.

DEFINE BUTTON btn_grabar 
     LABEL "&Modificar" 
     SIZE 14 BY 1.12.

DEFINE VARIABLE v-cdg_cliente AS CHARACTER FORMAT "X(256)":U 
     LABEL "Cliente" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 12 FONT 6 NO-UNDO.

DEFINE VARIABLE v-cdg_vendedor AS CHARACTER FORMAT "X(256)":U 
     LABEL "Vendedor" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 6 NO-UNDO.

DEFINE VARIABLE v-nom_cliente AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 46 BY 1
     BGCOLOR 7 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE v-nom_vendedor AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 46 BY 1
     BGCOLOR 7 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 8  NO-FILL 
     SIZE 83 BY 7.54.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     v-cdg_cliente AT ROW 2.88 COL 16 COLON-ALIGNED
     v-nom_cliente AT ROW 2.88 COL 31 COLON-ALIGNED NO-LABEL
     v-cdg_vendedor AT ROW 4.77 COL 16 COLON-ALIGNED
     v-nom_vendedor AT ROW 4.77 COL 31 COLON-ALIGNED NO-LABEL
     btn_grabar AT ROW 7.19 COL 18
     btn_cancelar AT ROW 7.19 COL 64
     RECT-1 AT ROW 1.81 COL 3
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 88.29 BY 9.54.


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
         TITLE              = "Cambio de Vendedor"
         HEIGHT             = 9.73
         WIDTH              = 88.29
         MAX-HEIGHT         = 16
         MAX-WIDTH          = 88.29
         VIRTUAL-HEIGHT     = 16
         VIRTUAL-WIDTH      = 88.29
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


/* ***************  Runtime Attributes and UIB Settings  ************** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME DEFAULT-FRAME
                                                                        */
/* SETTINGS FOR FILL-IN v-nom_cliente IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-nom_vendedor IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 




/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Cambio de Vendedor */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Cambio de Vendedor */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_cancelar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_cancelar C-Win
ON CHOOSE OF btn_cancelar IN FRAME DEFAULT-FRAME /* Cancelar */
DO:
  CLEAR FRAME {&FRAME-NAME} ALL.
  APPLY "ENTRY" TO v-cdg_cliente IN FRAME {&FRAME-NAME}.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_grabar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_grabar C-Win
ON CHOOSE OF btn_grabar IN FRAME DEFAULT-FRAME /* Modificar */
DO:
  DO TRANSACTION:
     FIND CURRENT Cliente EXCLUSIVE-LOCK.
     Cliente.nro_vendedor = Vendedor.nro_vendedor.
     RELEASE Cliente.
     RELEASE Vendedor.
  END.
  CLEAR FRAME {&FRAME-NAME} ALL.
  APPLY "ENTRY" TO v-cdg_cliente IN FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_cliente
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_cliente C-Win
ON RETURN OF v-cdg_cliente IN FRAME DEFAULT-FRAME /* Cliente */
DO:
  ASSIGN v-cdg_cliente.
  FIND Cliente WHERE Cliente.cdg_cliente = v-cdg_cliente NO-LOCK NO-ERROR.
  IF NOT AVAILABLE Cliente
  THEN DO:
       MESSAGE "No existe el cliente"
               VIEW-AS ALERT-BOX MESSAGE.
       RETURN NO-APPLY.        
  END.
  ELSE DO:
       FIND Vendedor OF Cliente NO-LOCK.
       v-nom_cliente = Cliente.nom_cliente.
       v-cdg_vendedor = Vendedor.cdg_vendedor.
       v-nom_vendedor = Vendedor.nombre.
       DISPLAY
            v-nom_cliente
            v-cdg_vendedor
            v-nom_vendedor
            WITH FRAME {&FRAME-NAME}.

  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_vendedor
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_vendedor C-Win
ON RETURN OF v-cdg_vendedor IN FRAME DEFAULT-FRAME /* Vendedor */
DO:
  ASSIGN v-cdg_vendedor.
  FIND Vendedor WHERE Vendedor.cdg_vendedor = v-cdg_vendedor NO-LOCK NO-ERROR.
  IF NOT AVAILABLE Vendedor
  THEN DO:
       MESSAGE "No existe el Vendedor"
               VIEW-AS ALERT-BOX MESSAGE.
       RETURN NO-APPLY.        
  END.
  ELSE DO:
       v-nom_vendedor = Vendedor.nombre.
       DISPLAY
            v-nom_vendedor
            WITH FRAME {&FRAME-NAME}.

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

SESSION:DATA-ENTRY-RETURN = YES.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI C-Win _DEFAULT-DISABLE
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI C-Win _DEFAULT-ENABLE
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
  DISPLAY v-cdg_cliente v-nom_cliente v-cdg_vendedor v-nom_vendedor 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE RECT-1 v-cdg_cliente v-cdg_vendedor btn_grabar btn_cancelar 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


