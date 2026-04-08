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

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Cta_cte_bco

/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define FIELDS-IN-QUERY-Dialog-Frame Cta_cte_bco.tip_comprob ~
Cta_cte_bco.prf_comprob Cta_cte_bco.nro_comprob Cta_cte_bco.credito ~
Cta_cte_bco.debito Cta_cte_bco.fecha_efectiva Cta_cte_bco.fecha_movimto ~
Cta_cte_bco.leyenda 
&Scoped-define ENABLED-FIELDS-IN-QUERY-Dialog-Frame Cta_cte_bco.tip_comprob ~
Cta_cte_bco.prf_comprob Cta_cte_bco.nro_comprob Cta_cte_bco.credito ~
Cta_cte_bco.debito Cta_cte_bco.fecha_efectiva Cta_cte_bco.fecha_movimto ~
Cta_cte_bco.leyenda 
&Scoped-define ENABLED-TABLES-IN-QUERY-Dialog-Frame Cta_cte_bco
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-Dialog-Frame Cta_cte_bco

&Scoped-define FIELD-PAIRS-IN-QUERY-Dialog-Frame~
 ~{&FP1}tip_comprob ~{&FP2}tip_comprob ~{&FP3}~
 ~{&FP1}prf_comprob ~{&FP2}prf_comprob ~{&FP3}~
 ~{&FP1}nro_comprob ~{&FP2}nro_comprob ~{&FP3}~
 ~{&FP1}credito ~{&FP2}credito ~{&FP3}~
 ~{&FP1}debito ~{&FP2}debito ~{&FP3}~
 ~{&FP1}fecha_efectiva ~{&FP2}fecha_efectiva ~{&FP3}~
 ~{&FP1}fecha_movimto ~{&FP2}fecha_movimto ~{&FP3}~
 ~{&FP1}leyenda ~{&FP2}leyenda ~{&FP3}
&Scoped-define OPEN-QUERY-Dialog-Frame OPEN QUERY Dialog-Frame FOR EACH Cta_cte_bco SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-Dialog-Frame Cta_cte_bco
&Scoped-define FIRST-TABLE-IN-QUERY-Dialog-Frame Cta_cte_bco


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Cta_cte_bco.tip_comprob ~
Cta_cte_bco.prf_comprob Cta_cte_bco.nro_comprob Cta_cte_bco.credito ~
Cta_cte_bco.debito Cta_cte_bco.fecha_efectiva Cta_cte_bco.fecha_movimto ~
Cta_cte_bco.leyenda 
&Scoped-define FIELD-PAIRS~
 ~{&FP1}tip_comprob ~{&FP2}tip_comprob ~{&FP3}~
 ~{&FP1}prf_comprob ~{&FP2}prf_comprob ~{&FP3}~
 ~{&FP1}nro_comprob ~{&FP2}nro_comprob ~{&FP3}~
 ~{&FP1}credito ~{&FP2}credito ~{&FP3}~
 ~{&FP1}debito ~{&FP2}debito ~{&FP3}~
 ~{&FP1}fecha_efectiva ~{&FP2}fecha_efectiva ~{&FP3}~
 ~{&FP1}fecha_movimto ~{&FP2}fecha_movimto ~{&FP3}~
 ~{&FP1}leyenda ~{&FP2}leyenda ~{&FP3}
&Scoped-define ENABLED-TABLES Cta_cte_bco
&Scoped-define FIRST-ENABLED-TABLE Cta_cte_bco
&Scoped-Define ENABLED-OBJECTS RECT-11 v-cdg_cuenta v-dsc_cuenta Btn_OK ~
Btn_Cancel 
&Scoped-Define DISPLAYED-FIELDS Cta_cte_bco.tip_comprob ~
Cta_cte_bco.prf_comprob Cta_cte_bco.nro_comprob Cta_cte_bco.credito ~
Cta_cte_bco.debito Cta_cte_bco.fecha_efectiva Cta_cte_bco.fecha_movimto ~
Cta_cte_bco.leyenda 
&Scoped-Define DISPLAYED-OBJECTS v-cdg_cuenta v-dsc_cuenta 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 15 BY 1.15
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 15 BY 1.15
     BGCOLOR 8 .

DEFINE VARIABLE v-cdg_cuenta AS CHARACTER FORMAT "X(256)":U 
     LABEL "Imputación" 
     VIEW-AS FILL-IN 
     SIZE 15 BY .81 NO-UNDO.

DEFINE VARIABLE v-dsc_cuenta AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 41 BY .81
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-11
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 75 BY 7.54.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY Dialog-Frame FOR 
      Cta_cte_bco SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     Cta_cte_bco.tip_comprob AT ROW 2.08 COL 17 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_bco.prf_comprob AT ROW 2.08 COL 42 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 7 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_bco.nro_comprob AT ROW 2.08 COL 59 COLON-ALIGNED
          LABEL "Número"
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_cuenta AT ROW 3.15 COL 17 COLON-ALIGNED
     v-dsc_cuenta AT ROW 3.15 COL 33 COLON-ALIGNED NO-LABEL
     Cta_cte_bco.credito AT ROW 4.23 COL 17 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_bco.debito AT ROW 4.23 COL 59 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_bco.fecha_efectiva AT ROW 5.31 COL 17 COLON-ALIGNED
          LABEL "Fecha Efectiva"
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_bco.fecha_movimto AT ROW 5.31 COL 59 COLON-ALIGNED
          LABEL "Fecha Movimiento"
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_bco.leyenda AT ROW 6.38 COL 17 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 57 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Btn_OK AT ROW 7.46 COL 19
     Btn_Cancel AT ROW 7.46 COL 61
     RECT-11 AT ROW 1.54 COL 3
     SPACE(1.99) SKIP(0.49)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Alta de Créditos/Débitos de movimientos bancarios"
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

/* SETTINGS FOR FILL-IN Cta_cte_bco.fecha_efectiva IN FRAME Dialog-Frame
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cta_cte_bco.fecha_movimto IN FRAME Dialog-Frame
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cta_cte_bco.nro_comprob IN FRAME Dialog-Frame
   EXP-LABEL                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX Dialog-Frame
/* Query rebuild information for DIALOG-BOX Dialog-Frame
     _TblList          = "sic.Cta_cte_bco"
     _Options          = "SHARE-LOCK"
     _Query            is NOT OPENED
*/  /* DIALOG-BOX Dialog-Frame */
&ANALYZE-RESUME

 




/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Alta de Créditos/Débitos de movimientos bancarios */
DO:
  APPLY "END-ERROR":U TO SELF.
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
  IF AVAILABLE Cta_cte_bco THEN 
    DISPLAY Cta_cte_bco.tip_comprob Cta_cte_bco.prf_comprob 
          Cta_cte_bco.nro_comprob Cta_cte_bco.credito Cta_cte_bco.debito 
          Cta_cte_bco.fecha_efectiva Cta_cte_bco.fecha_movimto 
          Cta_cte_bco.leyenda 
      WITH FRAME Dialog-Frame.
  ENABLE RECT-11 Cta_cte_bco.tip_comprob Cta_cte_bco.prf_comprob 
         Cta_cte_bco.nro_comprob v-cdg_cuenta v-dsc_cuenta Cta_cte_bco.credito 
         Cta_cte_bco.debito Cta_cte_bco.fecha_efectiva 
         Cta_cte_bco.fecha_movimto Cta_cte_bco.leyenda Btn_OK Btn_Cancel 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


