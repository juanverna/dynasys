&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS Dialog-Frame 
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

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

&IF DEFINED(UIB_is_running) EQ 0
&THEN
DEFINE INPUT-OUTPUT PARAMETER que_buscar AS CHARACTER INITIAL "lsasnven.txt".
DEFINE INPUT-OUTPUT PARAMETER que_poner  AS CHARACTER INITIAL "lsasnven.txt".
DEFINE OUTPUT PARAMETER modo_buscar AS INTEGER.
DEFINE OUTPUT PARAMETER puso_ok AS LOGICAL INITIAL NO.
&ELSE
DEFINE VARIABLE  que_buscar  AS CHARACTER INITIAL "lsasnven.txt".
DEFINE VARIABLE  que_poner   AS CHARACTER INITIAL "lsasnven.txt".
DEFINE VARIABLE  modo_buscar AS INTEGER.
DEFINE VARIABLE  puso_ok     AS LOGICAL INITIAL NO.
&ENDIF

/* Local Variable Definitions ---                                       */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-1 v-que_buscar v-que_poner v-coincidir ~
v-direccion v-redonda v-todas Btn_OK Btn_Cancel 
&Scoped-Define DISPLAYED-OBJECTS v-que_buscar v-que_poner v-coincidir ~
v-direccion v-redonda v-todas 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 15 BY 1.08
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 15 BY 1.08
     BGCOLOR 8 .

DEFINE VARIABLE v-que_buscar AS CHARACTER FORMAT "X(256)":U 
     LABEL "Cambiar" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 52 BY .81
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-que_poner AS CHARACTER FORMAT "X(256)":U 
     LABEL "Por" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 52 BY .81
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-direccion AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Adelante", 1,
"Atráss", 2
     SIZE 12 BY 1.62 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 65 BY 8.35.

DEFINE VARIABLE v-coincidir AS LOGICAL INITIAL no 
     LABEL "Coincidir Mayúsculas" 
     VIEW-AS TOGGLE-BOX
     SIZE 22 BY .77 NO-UNDO.

DEFINE VARIABLE v-redonda AS LOGICAL INITIAL yes 
     LABEL "Recomenzar al Final del Archivo" 
     VIEW-AS TOGGLE-BOX
     SIZE 31 BY .77 NO-UNDO.

DEFINE VARIABLE v-todas AS LOGICAL INITIAL yes 
     LABEL "Reemplazar todas las coincidencias" 
     VIEW-AS TOGGLE-BOX
     SIZE 37 BY .77 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     v-que_buscar AT ROW 2.08 COL 10 COLON-ALIGNED
     v-que_poner AT ROW 3.42 COL 10 COLON-ALIGNED
     v-coincidir AT ROW 4.77 COL 12
     v-direccion AT ROW 4.77 COL 50 NO-LABEL
     v-redonda AT ROW 5.85 COL 12
     v-todas AT ROW 6.92 COL 12
     Btn_OK AT ROW 8 COL 12
     Btn_Cancel AT ROW 8 COL 49
     RECT-1 AT ROW 1.27 COL 2
     SPACE(1.28) SKIP(0.41)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         FONT 4
         TITLE "Indique el reemplazo de texto"
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: DIALOG-BOX
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS


/* ***************  Runtime Attributes and UIB Settings  ************** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
                                                                        */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 




/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Indique el reemplazo de texto */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* OK */
DO:

  ASSIGN FRAME {&FRAME-NAME} v-que_buscar v-que_poner v-coincidir v-direccion v-redonda v-todas.

  modo_buscar = v-direccion.
  IF v-coincidir THEN modo_buscar = modo_buscar + 4. 
  IF v-todas     THEN modo_buscar = modo_buscar + 8. 
  IF v-redonda   THEN modo_buscar = modo_buscar + 16. 

  que_buscar = v-que_buscar.
  que_poner  = v-que_poner.

  puso_ok = YES.

  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Dialog-Frame 


/* ***************************  Main Block  *************************** */

/* Parent the dialog-box to the ACTIVE-WINDOW, if there is no parent.   */
IF VALID-HANDLE(ACTIVE-WINDOW) AND FRAME {&FRAME-NAME}:PARENT eq ?
THEN FRAME {&FRAME-NAME}:PARENT = ACTIVE-WINDOW.


/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:

  v-que_buscar = que_buscar.
  v-que_poner  = que_poner.
  DISPLAY v-que_buscar 
          v-que_poner
          WITH FRAME {&FRAME-NAME}.

  RUN enable_UI.
  WAIT-FOR GO OF FRAME {&FRAME-NAME}.
END.
RUN disable_UI.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI Dialog-Frame _DEFAULT-DISABLE
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
  HIDE FRAME Dialog-Frame.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI Dialog-Frame _DEFAULT-ENABLE
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
  DISPLAY v-que_buscar v-que_poner v-coincidir v-direccion v-redonda v-todas 
      WITH FRAME Dialog-Frame.
  ENABLE RECT-1 v-que_buscar v-que_poner v-coincidir v-direccion v-redonda 
         v-todas Btn_OK Btn_Cancel 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


