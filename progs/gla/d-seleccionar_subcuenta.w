&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
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

&IF DEFINED(UIB_is_Running) NE 0
&THEN
DEFINE VARIABLE          p-nro_cuenta    LIKE Cuenta.nro_cuenta INITIAL 27.
DEFINE VARIABLE          p-cdg_subcuenta LIKE Subcuenta.cdg_subcuenta.
&ELSE
DEFINE INPUT  PARAMETER  p-nro_cuenta    LIKE Cuenta.nro_cuenta.
DEFINE OUTPUT PARAMETER  p-cdg_subcuenta LIKE Subcuenta.cdg_subcuenta.
&ENDIF

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame
&Scoped-define BROWSE-NAME BROWSE-10

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Subcuenta

/* Definitions for BROWSE BROWSE-10                                     */
&Scoped-define FIELDS-IN-QUERY-BROWSE-10 Subcuenta.cdg_subcuenta ~
Subcuenta.nom_subcuenta 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-10 
&Scoped-define FIELD-PAIRS-IN-QUERY-BROWSE-10
&Scoped-define OPEN-QUERY-BROWSE-10 OPEN QUERY BROWSE-10 FOR EACH Subcuenta ~
      WHERE Subcuenta.nro_cuenta = p-nro_cuenta NO-LOCK.
&Scoped-define TABLES-IN-QUERY-BROWSE-10 Subcuenta
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-10 Subcuenta


/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define OPEN-BROWSERS-IN-QUERY-Dialog-Frame ~
    ~{&OPEN-QUERY-BROWSE-10}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-17 BROWSE-10 Btn_OK Btn_Cancel 
&Scoped-Define DISPLAYED-OBJECTS v-cdg_cuenta v-dsc_cuenta 

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
     LABEL "&Elegir" 
     SIZE 15 BY 1.15
     BGCOLOR 8 .

DEFINE VARIABLE v-cdg_cuenta AS CHARACTER FORMAT "X(256)":U 
     LABEL "Cuenta" 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 7 FGCOLOR 14  NO-UNDO.

DEFINE VARIABLE v-dsc_cuenta AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 47 BY .81
     BGCOLOR 7 FGCOLOR 14  NO-UNDO.

DEFINE RECTANGLE RECT-17
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 73 BY 8.08.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-10 FOR 
      Subcuenta SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-10
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-10 Dialog-Frame _STRUCTURED
  QUERY BROWSE-10 DISPLAY
      Subcuenta.cdg_subcuenta FORMAT "X(10)"
      Subcuenta.nom_subcuenta FORMAT "X(47)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 62 BY 4.5.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     v-cdg_cuenta AT ROW 1.54 COL 8 COLON-ALIGNED
     v-dsc_cuenta AT ROW 1.54 COL 23 COLON-ALIGNED NO-LABEL
     BROWSE-10 AT ROW 2.62 COL 10
     Btn_OK AT ROW 7.46 COL 10
     Btn_Cancel AT ROW 7.46 COL 57
     RECT-17 AT ROW 1 COL 1
     SPACE(0.85) SKIP(0.26)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Selección de Subcuentas de una Cuenta".


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
/* BROWSE-TAB BROWSE-10 v-dsc_cuenta Dialog-Frame */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN v-cdg_cuenta IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_cuenta IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-10
/* Query rebuild information for BROWSE BROWSE-10
     _TblList          = "sic.Subcuenta"
     _Where[1]         = "Subcuenta.nro_cuenta = p-nro_cuenta"
     _FldNameList[1]   > sic.Subcuenta.cdg_subcuenta
"Subcuenta.cdg_subcuenta" ? "X(10)" "character" ? ? ? ? ? ? no ?
     _FldNameList[2]   > sic.Subcuenta.nom_subcuenta
"Subcuenta.nom_subcuenta" ? "X(47)" "character" ? ? ? ? ? ? no ?
     _Query            is OPENED
*/  /* BROWSE BROWSE-10 */
&ANALYZE-RESUME

 




/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Selección de Subcuentas de una Cuenta */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel Dialog-Frame
ON CHOOSE OF Btn_Cancel IN FRAME Dialog-Frame /* Salir */
DO:
   p-cdg_subcuenta = ?.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* Elegir */
DO:
  IF AVAILABLE Subcuenta
     THEN p-cdg_subcuenta = Subcuenta.cdg_subcuenta.
     ELSE p-cdg_subcuenta = ?.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-10
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
  
  FIND Cuenta WHERE Cuenta.nro_cuenta = p-nro_cuenta NO-LOCK.
  ASSIGN
       v-cdg_cuenta = Cuenta.cdg_cuenta
       v-dsc_cuenta = Cuenta.nombre_cta.

  DISPLAY 
       v-cdg_cuenta
       v-dsc_cuenta
       WITH FRAME {&FRAME-NAME}.
  {&OPEN-QUERY-{&BROWSE-NAME}}
  
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
  DISPLAY v-cdg_cuenta v-dsc_cuenta 
      WITH FRAME Dialog-Frame.
  ENABLE RECT-17 BROWSE-10 Btn_OK Btn_Cancel 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


