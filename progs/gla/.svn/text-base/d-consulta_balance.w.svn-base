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

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Dialog-Box
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame
&Scoped-define BROWSE-NAME BROWSE-7

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Lst_sumysal

/* Definitions for BROWSE BROWSE-7                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-7 Lst_sumysal.que_codigo ~
Lst_sumysal.que_nombre Lst_sumysal.acm_debitos_per ~
Lst_sumysal.acm_creditos_per Lst_sumysal.saldo_per ~
Lst_sumysal.acm_debitos_tot Lst_sumysal.acm_creditos_tot ~
Lst_sumysal.saldo_tot 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-7 
&Scoped-define QUERY-STRING-BROWSE-7 FOR EACH Lst_sumysal NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-7 OPEN QUERY BROWSE-7 FOR EACH Lst_sumysal NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-7 Lst_sumysal
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-7 Lst_sumysal


/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define OPEN-BROWSERS-IN-QUERY-Dialog-Frame ~
    ~{&OPEN-QUERY-BROWSE-7}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS Btn_Cancel Btn_OK BROWSE-7 

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

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-7 FOR 
      Lst_sumysal SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-7
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-7 Dialog-Frame _STRUCTURED
  QUERY BROWSE-7 NO-LOCK DISPLAY
      Lst_sumysal.que_codigo FORMAT "X(20)":U
      Lst_sumysal.que_nombre FORMAT "X(40)":U
      Lst_sumysal.acm_debitos_per FORMAT "ZZZ,ZZZ,ZZ9.99":U
      Lst_sumysal.acm_creditos_per FORMAT "ZZZ,ZZZ,ZZ9.99":U
      Lst_sumysal.saldo_per FORMAT "-ZZZ,ZZZ,ZZ9.99":U
      Lst_sumysal.acm_debitos_tot FORMAT "ZZZ,ZZZ,ZZ9.99":U
      Lst_sumysal.acm_creditos_tot FORMAT "ZZZ,ZZZ,ZZ9.99":U
      Lst_sumysal.saldo_tot FORMAT "ZZZ,ZZZ,ZZ9.99-":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 157 BY 24.76 EXPANDABLE.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     Btn_Cancel AT ROW 1.48 COL 125
     Btn_OK AT ROW 1.48 COL 144
     BROWSE-7 AT ROW 3.38 COL 2
     SPACE(0.59) SKIP(0.14)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "<insert dialog title>"
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
/* BROWSE-TAB BROWSE-7 Btn_OK Dialog-Frame */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

ASSIGN 
       BROWSE-7:NUM-LOCKED-COLUMNS IN FRAME Dialog-Frame     = 1.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-7
/* Query rebuild information for BROWSE BROWSE-7
     _TblList          = "sic.Lst_sumysal"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   = sic.Lst_sumysal.que_codigo
     _FldNameList[2]   = sic.Lst_sumysal.que_nombre
     _FldNameList[3]   = sic.Lst_sumysal.acm_debitos_per
     _FldNameList[4]   = sic.Lst_sumysal.acm_creditos_per
     _FldNameList[5]   > sic.Lst_sumysal.saldo_per
"Lst_sumysal.saldo_per" ? "-ZZZ,ZZZ,ZZ9.99" "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[6]   = sic.Lst_sumysal.acm_debitos_tot
     _FldNameList[7]   = sic.Lst_sumysal.acm_creditos_tot
     _FldNameList[8]   > sic.Lst_sumysal.saldo_tot
"Lst_sumysal.saldo_tot" ? "ZZZ,ZZZ,ZZ9.99-" "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _Query            is OPENED
*/  /* BROWSE BROWSE-7 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* <insert dialog title> */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-7
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
  ENABLE Btn_Cancel Btn_OK BROWSE-7 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

