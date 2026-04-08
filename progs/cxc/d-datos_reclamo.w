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

/* Local Variable Definitions ---                                       */

{parlocales.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-1 v-lugar-y-fecha v-firma v-cargo ~
v-por-empresa Btn_OK Btn_Cancel 
&Scoped-Define DISPLAYED-OBJECTS v-lugar-y-fecha v-firma v-cargo ~
v-por-empresa 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "&Salir" 
     SIZE 15 BY 1.15
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "&Grabar" 
     SIZE 15 BY 1.15
     BGCOLOR 8 .

DEFINE VARIABLE v-cargo AS CHARACTER FORMAT "X(256)":U 
     LABEL "Cargo" 
     VIEW-AS FILL-IN 
     SIZE 64 BY .81
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-firma AS CHARACTER FORMAT "X(256)":U 
     LABEL "Firma" 
     VIEW-AS FILL-IN 
     SIZE 64 BY .81
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-lugar-y-fecha AS CHARACTER FORMAT "X(256)":U 
     LABEL "Lugar y Fecha" 
     VIEW-AS FILL-IN 
     SIZE 64 BY .81
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-por-empresa AS CHARACTER FORMAT "X(256)":U 
     LABEL "Por Empresa" 
     VIEW-AS FILL-IN 
     SIZE 64 BY .81
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 6 GRAPHIC-EDGE  NO-FILL 
     SIZE 82 BY 6.46.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     v-lugar-y-fecha AT ROW 1.81 COL 15 COLON-ALIGNED
     v-firma AT ROW 2.88 COL 15 COLON-ALIGNED
     v-cargo AT ROW 3.96 COL 15 COLON-ALIGNED
     v-por-empresa AT ROW 5.04 COL 15 COLON-ALIGNED
     Btn_OK AT ROW 6.12 COL 17
     Btn_Cancel AT ROW 6.12 COL 66
     RECT-1 AT ROW 1.27 COL 2
     SPACE(1.28) SKIP(0.30)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Edición de datos fijos de las cartas de reclamo"
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
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Edición de datos fijos de las cartas de reclamo */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* Grabar */
DO:

  ASSIGN FRAME {&FRAME-NAME}
    /*
    v-carta  
    v-piecarta
    */
    v-lugar-y-fecha
    v-firma 
    v-cargo 
    v-por-empresa.

  DO TRANSACTION:
        /* 
        {GRABATEXTOS.I "RECLTCAR" "v-carta" "Primer parrafo de texto de la carta"}
        {GRABATEXTOS.I "RECLPIEC" "v-piecarta" "Segundo parrafo de texto de la carta"}
        */

        {GRABATEXTOS.I "RECLLYFE" "v-lugar-y-fecha" "Lugar y Fecha de las cartas de reclamo"}
        {GRABATEXTOS.I "RECLFIRM" "v-firma" "Firmante de las cartas de reclamo"}
        {GRABATEXTOS.I "RECLCARG" "v-cargo" "Cargo del firmante de las cartas de reclamo"}
        {GRABATEXTOS.I "RECLPEMP" "v-por-empresa" "Por Empresa de las cartas de reclamo"}

        
        OUTPUT TO ".\prl\modelo-reclamo.txt" PAGE-SIZE 0.

             /* {FILETEXTOS.I "carta"} */
                {FILETEXTOS.I "lugar-y-fecha"}
             /* {FILETEXTOS.I "cliente-nombre"} 
                {FILETEXTOS.I "cliente-domicilio"}
                {FILETEXTOS.I "cliente-localidad"}
                {FILETEXTOS.I "cliente-provincia"} 
                {FILETEXTOS.I "piecarta"} */
                {FILETEXTOS.I "firma"}
                {FILETEXTOS.I "cargo"}
                {FILETEXTOS.I "por-empresa"}
                 
        OUTPUT CLOSE. 
        
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

{findempresa.i}

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.

  {cargatextos.i "RECLLYFE" "v-lugar-y-fecha"}
  {cargatextos.i "RECLFIRM" "v-firma"}
  {cargatextos.i "RECLCARG" "v-cargo"}
  {cargatextos.i "RECLPEMP" "v-por-empresa"}

  DISPLAY
      v-lugar-y-fecha
      v-firma 
      v-cargo 
      v-por-empresa
      WITH FRAME {&FRAME-NAME}.
  
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
  DISPLAY v-lugar-y-fecha v-firma v-cargo v-por-empresa 
      WITH FRAME Dialog-Frame.
  ENABLE RECT-1 v-lugar-y-fecha v-firma v-cargo v-por-empresa Btn_OK Btn_Cancel 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


