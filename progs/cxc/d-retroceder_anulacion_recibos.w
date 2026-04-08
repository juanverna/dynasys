&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
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
/*          This .W file was created with the Progress AppBuilder.       */
/*----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Dialog-Box
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS v-tip_comprob v-prf_comprob v-nro_comprob ~
btn_hacer Btn_Cancel RECT-1 
&Scoped-Define DISPLAYED-OBJECTS v-tip_comprob v-prf_comprob v-nro_comprob 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "&Salir" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON btn_hacer 
     LABEL "&Hacer" 
     SIZE 15 BY 1.14.

DEFINE VARIABLE v-nro_comprob AS INTEGER FORMAT ">>>>>>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE v-prf_comprob AS INTEGER FORMAT ">>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE v-tip_comprob AS CHARACTER FORMAT "X(2)":U 
     LABEL "Recibo" 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 41 BY 5.24.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     v-tip_comprob AT ROW 2.67 COL 10 COLON-ALIGNED
     v-prf_comprob AT ROW 2.67 COL 16 COLON-ALIGNED NO-LABEL
     v-nro_comprob AT ROW 2.67 COL 25 COLON-ALIGNED NO-LABEL
     btn_hacer AT ROW 4.33 COL 4
     Btn_Cancel AT ROW 4.33 COL 26
     RECT-1 AT ROW 1 COL 2
     "         Indique el número de recibo" VIEW-AS TEXT
          SIZE 39 BY 1 AT ROW 1.24 COL 3
          BGCOLOR 5 FGCOLOR 15 
     SPACE(1.99) SKIP(4.18)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Retroceder Anulación de Recibos"
         CANCEL-BUTTON Btn_Cancel.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Dialog-Box
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
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Retroceder Anulación de Recibos */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_hacer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_hacer Dialog-Frame
ON CHOOSE OF btn_hacer IN FRAME Dialog-Frame /* Hacer */
DO:
  {findempresa.i}
  ASSIGN v-tip_comprob v-prf_comprob v-nro_comprob.
  FIND Rec_header WHERE Rec_header.cdg_empresa = Empresa.cdg_empresa
                    AND Rec_header.tip_comprob = v-tip_comprob
                    AND Rec_header.prf_comprob = v-prf_comprob
                    AND Rec_header.nro_comprob = v-nro_comprob
                        NO-LOCK NO-ERROR.
  IF NOT AVAILABLE Rec_header
  THEN DO:
      MESSAGE "No existe el recibo indicado"
          VIEW-AS ALERT-BOX ERROR.
  END.
  ELSE DO:
      IF NOT Rec_header.anulado
      THEN DO:
          MESSAGE "El recibo indicado no está anulado"
              VIEW-AS ALERT-BOX ERROR.
      END.
      ELSE DO:
          DO TRANSACTION:
              FIND CURRENT Rec_header EXCLUSIVE-LOCK.
              FOR EACH Rec_detalle OF Rec_header EXCLUSIVE-LOCK:
                  DELETE Rec_detalle.
              END.
              DELETE Rec_header.
          END.
          CLEAR FRAME {&FRAME-NAME} ALL.
          MESSAGE "El recibo ha sido eliminado"
              VIEW-AS ALERT-BOX MESSAGE.
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
  DISPLAY v-tip_comprob v-prf_comprob v-nro_comprob 
      WITH FRAME Dialog-Frame.
  ENABLE v-tip_comprob v-prf_comprob v-nro_comprob btn_hacer Btn_Cancel RECT-1 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

