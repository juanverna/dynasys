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
DEFINE INPUT PARAMETER nom_reporte AS CHARACTER INITIAL "lsasnven.txt".
DEFINE INPUT PARAMETER modo_hoja   AS INTEGER.
DEFINE INPUT PARAMETER linpag      AS INTEGER.
DEFINE INPUT PARAMETER v-font      AS INTEGER.

&ELSE
DEFINE VARIABLE nom_reporte AS CHARACTER INITIAL "lsasnven.txt".
DEFINE VARIABLE modo_hoja  AS INTEGER INITIAL 2.
DEFINE VARIABLE linpag     AS INTEGER INITIAL 55.
DEFINE VARIABLE v-font     AS INTEGER INITIAL 14.
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
&Scoped-Define ENABLED-OBJECTS RECT-2 RECT-1 v-linpag v-modo_hoja Btn_OK ~
Btn_Cancel 
&Scoped-Define DISPLAYED-OBJECTS v-nom_reporte v-linpag v-modo_hoja 

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

DEFINE VARIABLE v-linpag AS INTEGER FORMAT ">>9":U INITIAL 0 
     LABEL "Lineas" 
     VIEW-AS FILL-IN 
     SIZE 5 BY .81
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-nom_reporte AS CHARACTER FORMAT "X(256)":U 
     LABEL "Reporte" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 52 BY .81
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-modo_hoja AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Vertical", 0,
"Horizontal", 2,
"Según Impresora", 1
     SIZE 40 BY .54 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 63 BY 5.38.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 42 BY 1.08.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     v-nom_reporte AT ROW 1.81 COL 9 COLON-ALIGNED
     v-linpag AT ROW 3.15 COL 9 COLON-ALIGNED
     v-modo_hoja AT ROW 3.42 COL 22 NO-LABEL
     Btn_OK AT ROW 5.04 COL 11
     Btn_Cancel AT ROW 5.04 COL 48
     RECT-2 AT ROW 3.15 COL 21
     RECT-1 AT ROW 1.27 COL 2
     SPACE(1.71) SKIP(0.30)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         FONT 4
         TITLE "Ingrese parámetros del reporte"
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

/* SETTINGS FOR FILL-IN v-nom_reporte IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 




/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Ingrese parámetros del reporte */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* OK */
DO:

    DO TRANSACTION: 

        ASSIGN FRAME {&FRAME-NAME} v-nom_reporte v-linpag v-modo_hoja.
        FIND Ctl_reporte 
             WHERE Ctl_reporte.nom_reporte = v-nom_reporte
                   EXCLUSIVE-LOCK NO-ERROR.
        IF NOT AVAILABLE Ctl_reporte
        THEN DO:
             CREATE Ctl_reporte.
             ASSIGN Ctl_reporte.nom_reporte = v-nom_reporte.
        END.
                
        ASSIGN
            Ctl_reporte.modo_impresion = v-modo_hoja  
            Ctl_reporte.numero_font    = v-font
            Ctl_reporte.lineas_pp      = v-linpag.
        
        RELEASE Ctl_reporte.

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
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:

  v-nom_reporte = nom_reporte.
  v-linpag = linpag.
  v-modo_hoja = modo_hoja.
  DISPLAY v-nom_reporte 
          v-linpag
          v-modo_hoja
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
  DISPLAY v-nom_reporte v-linpag v-modo_hoja 
      WITH FRAME Dialog-Frame.
  ENABLE RECT-2 RECT-1 v-linpag v-modo_hoja Btn_OK Btn_Cancel 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


