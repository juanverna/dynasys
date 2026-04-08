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

  &IF DEFINED(UIB_is_Running) NE 0
  &THEN
  DEFINE VARIABLE seleccion        AS CHARACTER.
  DEFINE VARIABLE disponibles      AS CHARACTER.
  DEFINE VARIABLE titulo_seleccion AS CHARACTER INITIAL "Seleccion de Chorizos".
  &ELSE
  DEFINE INPUT-OUTPUT PARAMETER seleccion        AS CHARACTER.
  DEFINE INPUT-OUTPUT PARAMETER disponibles      AS CHARACTER.
  DEFINE INPUT PARAMETER        titulo_seleccion AS CHARACTER.
  &ENDIF

/* Local Variable Definitions ---                                       */

  DEFINE VARIABLE item     AS CHARACTER.
  DEFINE VARIABLE como_fue AS LOGICAL.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS dispo selec Btn_Cancel btn_seltodos ~
btn_destodos Btn_OK RECT-2 RECT-3 
&Scoped-Define DISPLAYED-OBJECTS dispo selec 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "&Cancelar" 
     SIZE 15 BY 1
     BGCOLOR 8 .

DEFINE BUTTON btn_destodos 
     LABEL "<== Deseleccionar Todos" 
     SIZE 26 BY 1.

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "&Elegir" 
     SIZE 15 BY 1
     BGCOLOR 8 .

DEFINE BUTTON btn_seltodos 
     LABEL "Seleccionar Todos ==>" 
     SIZE 26 BY 1.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 48 BY 16.43.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 48 BY 16.43.

DEFINE VARIABLE dispo AS CHARACTER 
     VIEW-AS SELECTION-LIST SINGLE SORT SCROLLBAR-VERTICAL 
     SIZE 43 BY 12.91 NO-UNDO.

DEFINE VARIABLE selec AS CHARACTER 
     VIEW-AS SELECTION-LIST SINGLE SORT SCROLLBAR-VERTICAL 
     SIZE 43 BY 12.91 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     dispo AT ROW 2.91 COL 5 NO-LABEL
     selec AT ROW 2.91 COL 53 NO-LABEL
     Btn_Cancel AT ROW 16.33 COL 5
     btn_seltodos AT ROW 16.33 COL 21
     btn_destodos AT ROW 16.33 COL 54
     Btn_OK AT ROW 16.33 COL 81
     RECT-2 AT ROW 1.29 COL 2
     RECT-3 AT ROW 1.29 COL 51
     "                 Registros Seleccionados" VIEW-AS TEXT
          SIZE 43 BY 1 AT ROW 1.48 COL 53
          BGCOLOR 7 FGCOLOR 15 
     "                   Registros Disponibles" VIEW-AS TEXT
          SIZE 43 BY 1 AT ROW 1.48 COL 5
          BGCOLOR 7 FGCOLOR 15 
     SPACE(51.85) SKIP(15.63)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         FONT 4
         TITLE "Seleccion de Entidades"
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: DIALOG-BOX
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

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
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Seleccion de Entidades */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_destodos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_destodos Dialog-Frame
ON CHOOSE OF btn_destodos IN FRAME Dialog-Frame /* <== Deseleccionar Todos */
DO:
  
  IF selec:NUM-ITEMS = 0
  THEN DO:
     BELL.
  END.
  ELSE DO:                     
     DO WHILE selec:NUM-ITEMS <> 0:
        item = selec:ENTRY(1).
        como_fue = dispo:ADD-LAST(item).
        como_fue = selec:DELETE(item).
     END.   
  END.   

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* Elegir */
DO:
  seleccion = selec:LIST-ITEMS.
  disponibles = dispo:LIST-ITEMS.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_seltodos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_seltodos Dialog-Frame
ON CHOOSE OF btn_seltodos IN FRAME Dialog-Frame /* Seleccionar Todos ==> */
DO:
  
  IF dispo:NUM-ITEMS = 0
  THEN DO:
     BELL.
  END.
  ELSE DO:                     
     DO WHILE dispo:NUM-ITEMS <> 0:
        item = dispo:ENTRY(1).
        como_fue = selec:ADD-LAST(item).
        como_fue = dispo:DELETE(item).
     END.   
  END.   
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME dispo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL dispo Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF dispo IN FRAME Dialog-Frame
DO:

  IF dispo:NUM-ITEMS = 0
  THEN DO:
     BELL.
  END.
  ELSE DO:
     item = dispo:SCREEN-VALUE.
     IF item <> ?
     THEN DO:
        como_fue = selec:ADD-LAST(item).
        como_fue = dispo:DELETE(item).
     END.   
  END.   

  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME selec
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL selec Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF selec IN FRAME Dialog-Frame
DO:

  IF selec:NUM-ITEMS = 0
  THEN DO:
     BELL.
  END.
  ELSE DO:
     item = selec:SCREEN-VALUE.
     IF item <> ?
     THEN DO:
        como_fue = dispo:ADD-LAST(item).
        como_fue = selec:DELETE(item).
     END.   
  END.   

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

selec:LIST-ITEMS = seleccion.
dispo:LIST-ITEMS = disponibles.

FRAME {&FRAME-NAME}:TITLE = titulo_seleccion.
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  WAIT-FOR GO OF FRAME {&FRAME-NAME}.
END.
RUN disable_UI.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI Dialog-Frame  _DEFAULT-DISABLE
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI Dialog-Frame  _DEFAULT-ENABLE
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
  DISPLAY dispo selec 
      WITH FRAME Dialog-Frame.
  ENABLE dispo selec Btn_Cancel btn_seltodos btn_destodos Btn_OK RECT-2 RECT-3 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

