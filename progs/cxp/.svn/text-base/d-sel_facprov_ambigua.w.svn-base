&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
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
/*          This .W file was created with the Progress AppBuilder.       */
/*----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

&IF DEFINED(UIB_is_Running) NE 0
&THEN
DEFINE VARIABLE p-tip_comprob LIKE Fac_header_prv.tip_comprob INITIAL "FA".
DEFINE VARIABLE p-prf_comprob LIKE Fac_header_prv.prf_comprob INITIAL 1.
DEFINE VARIABLE p-nro_comprob LIKE Fac_header_prv.nro_comprob INITIAL 15641.
DEFINE VARIABLE                p-rid_facprov        AS ROWID.
&ELSE
DEFINE INPUT PARAMETER p-tip_comprob LIKE Fac_header_prv.tip_comprob INITIAL "FA".
DEFINE INPUT PARAMETER p-prf_comprob LIKE Fac_header_prv.prf_comprob INITIAL 1.
DEFINE INPUT PARAMETER p-nro_comprob LIKE Fac_header_prv.nro_comprob INITIAL 15641.
DEFINE INPUT-OUTPUT PARAMETER  p-rid_facprov        as ROWID.
&ENDIF

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Dialog-Box
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame
&Scoped-define BROWSE-NAME BROWSE-6

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Fac_header_prv Proveedor

/* Definitions for BROWSE BROWSE-6                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-6 Fac_header_prv.tip_comprob ~
Fac_header_prv.prf_comprob Fac_header_prv.nro_comprob ~
Proveedor.cdg_proveedor Proveedor.nombre 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-6 
&Scoped-define QUERY-STRING-BROWSE-6 FOR EACH Fac_header_prv ~
      WHERE Fac_header_prv.tip_comprob = p-tip_comprob ~
 AND Fac_header_prv.prf_comprob = p-prf_comprob ~
 AND Fac_header_prv.nro_comprob = p-nro_comprob NO-LOCK, ~
      EACH Proveedor OF Fac_header_prv NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-6 OPEN QUERY BROWSE-6 FOR EACH Fac_header_prv ~
      WHERE Fac_header_prv.tip_comprob = p-tip_comprob ~
 AND Fac_header_prv.prf_comprob = p-prf_comprob ~
 AND Fac_header_prv.nro_comprob = p-nro_comprob NO-LOCK, ~
      EACH Proveedor OF Fac_header_prv NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-6 Fac_header_prv Proveedor
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-6 Fac_header_prv
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-6 Proveedor


/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define OPEN-BROWSERS-IN-QUERY-Dialog-Frame ~
    ~{&OPEN-QUERY-BROWSE-6}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-6 BROWSE-6 Btn_OK Btn_Cancel 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 6 GRAPHIC-EDGE  NO-FILL 
     SIZE 90 BY 7.38.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-6 FOR 
      Fac_header_prv, 
      Proveedor SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-6
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-6 Dialog-Frame _STRUCTURED
  QUERY BROWSE-6 NO-LOCK DISPLAY
      Fac_header_prv.tip_comprob COLUMN-LABEL "Ti-!po" FORMAT "X(3)":U
      Fac_header_prv.prf_comprob COLUMN-LABEL "Pref-!Fijo" FORMAT "9999":U
      Fac_header_prv.nro_comprob COLUMN-LABEL "Numero!Compbte" FORMAT "ZZZZZZZ9":U
      Proveedor.cdg_proveedor FORMAT "X(8)":U
      Proveedor.nombre FORMAT "X(40)":U WIDTH 46.6
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 84 BY 4.52 EXPANDABLE.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     BROWSE-6 AT ROW 2.43 COL 6
     Btn_OK AT ROW 7.19 COL 6
     Btn_Cancel AT ROW 7.19 COL 75
     RECT-6 AT ROW 1.48 COL 3
     SPACE(2.99) SKIP(0.46)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Selección de facturas de proveedor ambiguas"
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel.


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
/* BROWSE-TAB BROWSE-6 RECT-6 Dialog-Frame */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-6
/* Query rebuild information for BROWSE BROWSE-6
     _TblList          = "sic.Fac_header_prv,sic.Proveedor OF sic.Fac_header_prv"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "Fac_header_prv.tip_comprob = p-tip_comprob
 AND Fac_header_prv.prf_comprob = p-prf_comprob
 AND Fac_header_prv.nro_comprob = p-nro_comprob"
     _FldNameList[1]   > sic.Fac_header_prv.tip_comprob
"Fac_header_prv.tip_comprob" "Ti-!po" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[2]   > sic.Fac_header_prv.prf_comprob
"Fac_header_prv.prf_comprob" "Pref-!Fijo" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[3]   > sic.Fac_header_prv.nro_comprob
"Fac_header_prv.nro_comprob" "Numero!Compbte" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[4]   = sic.Proveedor.cdg_proveedor
     _FldNameList[5]   > sic.Proveedor.nombre
"Proveedor.nombre" ? ? "character" ? ? ? ? ? ? no ? no no "46.6" yes no no "U" "" ""
     _Query            is OPENED
*/  /* BROWSE BROWSE-6 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Selección de facturas de proveedor ambiguas */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel Dialog-Frame
ON CHOOSE OF Btn_Cancel IN FRAME Dialog-Frame /* Cancel */
DO:
  p-rid_facprov = ?.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* OK */
DO:
  p-rid_facprov = ROWID(Fac_header_prv).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-6
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
  ENABLE RECT-6 BROWSE-6 Btn_OK Btn_Cancel 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

