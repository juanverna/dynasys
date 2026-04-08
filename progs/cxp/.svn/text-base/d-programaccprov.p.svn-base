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

&IF DEFINED(UIB_is_Running) EQ 0
&THEN
DEFINE INPUT PARAMETER rid_cta_cte_prv  AS ROWID.
&ELSE
DEFINE VARIABLE rid_cta_cte_prv AS ROWID.
FIND FIRST Cta_cte_prv.
rid_cta_cte_prv = ROWID(Cta_cte_prv).
&ENDIF

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Cta_cte_prv

/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define FIELDS-IN-QUERY-Dialog-Frame Cta_cte_prv.tip_comprob ~
Cta_cte_prv.prf_comprob Cta_cte_prv.nro_comprob Cta_cte_prv.nro_vencimiento ~
Cta_cte_prv.mes Cta_cte_prv.ano Cta_cte_prv.credito Cta_cte_prv.debito ~
Cta_cte_prv.fecha_vencimiento Cta_cte_prv.programada ~
Cta_cte_prv.fecha_programada Cta_cte_prv.imp_programado Cta_cte_prv.leyenda 
&Scoped-define ENABLED-FIELDS-IN-QUERY-Dialog-Frame Cta_cte_prv.programada ~
Cta_cte_prv.fecha_programada Cta_cte_prv.imp_programado 
&Scoped-define ENABLED-TABLES-IN-QUERY-Dialog-Frame Cta_cte_prv
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-Dialog-Frame Cta_cte_prv

&Scoped-define FIELD-PAIRS-IN-QUERY-Dialog-Frame~
 ~{&FP1}fecha_programada ~{&FP2}fecha_programada ~{&FP3}~
 ~{&FP1}imp_programado ~{&FP2}imp_programado ~{&FP3}
&Scoped-define OPEN-QUERY-Dialog-Frame OPEN QUERY Dialog-Frame FOR EACH Cta_cte_prv SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-Dialog-Frame Cta_cte_prv
&Scoped-define FIRST-TABLE-IN-QUERY-Dialog-Frame Cta_cte_prv


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Cta_cte_prv.programada ~
Cta_cte_prv.fecha_programada Cta_cte_prv.imp_programado 
&Scoped-define FIELD-PAIRS~
 ~{&FP1}fecha_programada ~{&FP2}fecha_programada ~{&FP3}~
 ~{&FP1}imp_programado ~{&FP2}imp_programado ~{&FP3}
&Scoped-define ENABLED-TABLES Cta_cte_prv
&Scoped-define FIRST-ENABLED-TABLE Cta_cte_prv
&Scoped-Define ENABLED-OBJECTS RECT-7 Btn_OK Btn_Cancel 
&Scoped-Define DISPLAYED-FIELDS Cta_cte_prv.tip_comprob ~
Cta_cte_prv.prf_comprob Cta_cte_prv.nro_comprob Cta_cte_prv.nro_vencimiento ~
Cta_cte_prv.mes Cta_cte_prv.ano Cta_cte_prv.credito Cta_cte_prv.debito ~
Cta_cte_prv.fecha_vencimiento Cta_cte_prv.programada ~
Cta_cte_prv.fecha_programada Cta_cte_prv.imp_programado Cta_cte_prv.leyenda 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 17 BY 1.15
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 17 BY 1.15
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 79 BY 7.54.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY Dialog-Frame FOR 
      Cta_cte_prv SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     Cta_cte_prv.tip_comprob AT ROW 1.81 COL 16 COLON-ALIGNED
          LABEL "Comprobante"
          VIEW-AS FILL-IN NATIVE 
          SIZE 7.72 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_prv.prf_comprob AT ROW 1.81 COL 25 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 8 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_prv.nro_comprob AT ROW 1.81 COL 34 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 10.86 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_prv.nro_vencimiento AT ROW 1.81 COL 46 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 5.14 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_prv.mes AT ROW 1.81 COL 61 COLON-ALIGNED
          LABEL "Período"
          VIEW-AS FILL-IN NATIVE 
          SIZE 5 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_prv.ano AT ROW 1.81 COL 69 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 9 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_prv.credito AT ROW 2.88 COL 16 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_prv.debito AT ROW 2.88 COL 61 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_prv.fecha_vencimiento AT ROW 3.96 COL 16 COLON-ALIGNED
          LABEL "Vencimiento"
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_prv.programada AT ROW 3.96 COL 63
          VIEW-AS TOGGLE-BOX
          SIZE 17 BY .77
     Cta_cte_prv.fecha_programada AT ROW 5.04 COL 16 COLON-ALIGNED
          LABEL "Programación"
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_prv.imp_programado AT ROW 5.04 COL 61 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_prv.leyenda AT ROW 6.12 COL 16 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 62 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Btn_OK AT ROW 7.19 COL 18
     Btn_Cancel AT ROW 7.19 COL 63
     RECT-7 AT ROW 1.27 COL 3
     SPACE(2.13) SKIP(0.49)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Programa un registro de Cta.Cte para el pago"
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

/* SETTINGS FOR FILL-IN Cta_cte_prv.ano IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Cta_cte_prv.credito IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Cta_cte_prv.debito IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Cta_cte_prv.fecha_programada IN FRAME Dialog-Frame
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cta_cte_prv.fecha_vencimiento IN FRAME Dialog-Frame
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN Cta_cte_prv.leyenda IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Cta_cte_prv.mes IN FRAME Dialog-Frame
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN Cta_cte_prv.nro_comprob IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Cta_cte_prv.nro_vencimiento IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Cta_cte_prv.prf_comprob IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Cta_cte_prv.tip_comprob IN FRAME Dialog-Frame
   NO-ENABLE EXP-LABEL                                                  */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX Dialog-Frame
/* Query rebuild information for DIALOG-BOX Dialog-Frame
     _TblList          = "sic.Cta_cte_prv"
     _Options          = "SHARE-LOCK"
     _Query            is NOT OPENED
*/  /* DIALOG-BOX Dialog-Frame */
&ANALYZE-RESUME

 




/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Programa un registro de Cta.Cte para el pago */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* OK */
DO:
    DO WITH FRAME {&FRAME-NAME}:
        IF INPUT Cta_cte_prv.programada
        THEN DO:

            IF INPUT Cta_cte_prv.imp_programado > INPUT Cta_cte_prv.credito - INPUT Cta_cte_prv.debito
            THEN DO:
                 RUN PONMENSJ.P ( INPUT "00000").
                 RETURN NO-APPLY.
            END.

            IF INPUT Cta_cte_prv.fecha_programada = DATE("")
            THEN DO:
                 RUN PONMENSJ.P ( INPUT "00000").
                 RETURN NO-APPLY.
            END.

            ASSIGN 
                  Cta_cte_prv.fecha_programada 
                  Cta_cte_prv.imp_programado 
                  Cta_cte_prv.programada.
        END.
        ELSE DO:      
            ASSIGN 
                  Cta_cte_prv.programada.
            ASSIGN 
                  Cta_cte_prv.fecha_programada    = ?
                  Cta_cte_prv.imp_programado      = 0.
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
  FIND Cta_cte_prv WHERE ROWID(Cta_cte_prv ) = rid_cta_cte_prv EXCLUSIVE-LOCK.
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
  IF AVAILABLE Cta_cte_prv THEN 
    DISPLAY Cta_cte_prv.tip_comprob Cta_cte_prv.prf_comprob 
          Cta_cte_prv.nro_comprob Cta_cte_prv.nro_vencimiento Cta_cte_prv.mes 
          Cta_cte_prv.ano Cta_cte_prv.credito Cta_cte_prv.debito 
          Cta_cte_prv.fecha_vencimiento Cta_cte_prv.programada 
          Cta_cte_prv.fecha_programada Cta_cte_prv.imp_programado 
          Cta_cte_prv.leyenda 
      WITH FRAME Dialog-Frame.
  ENABLE RECT-7 Cta_cte_prv.programada Cta_cte_prv.fecha_programada 
         Cta_cte_prv.imp_programado Btn_OK Btn_Cancel 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


