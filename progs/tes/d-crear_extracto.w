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

DEFINE INPUT PARAMETER rid_cuenta AS ROWID.
DEFINE OUTPUT PARAMETER pusok     AS LOGICAL.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Extracto

/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define OPEN-QUERY-Dialog-Frame OPEN QUERY Dialog-Frame FOR EACH Extracto SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-Dialog-Frame Extracto
&Scoped-define FIRST-TABLE-IN-QUERY-Dialog-Frame Extracto


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-10 v-tip_comprob v-prf_comprob ~
v-nro_comprob v-fecha_movimto v-debito v-credito v-leyenda Btn_OK ~
Btn_Cancel 
&Scoped-Define DISPLAYED-OBJECTS v-tip_comprob v-prf_comprob v-nro_comprob ~
v-fecha_movimto v-debito v-credito v-leyenda 

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

DEFINE VARIABLE v-credito AS DECIMAL FORMAT "->>,>>9.99" INITIAL 0 
     LABEL "Crédito" 
     VIEW-AS FILL-IN 
     SIZE 19 BY .81
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-debito AS DECIMAL FORMAT "->>,>>9.99" INITIAL 0 
     LABEL "Débito" 
     VIEW-AS FILL-IN 
     SIZE 19 BY .81
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-fecha_movimto AS DATE FORMAT "99/99/99" 
     LABEL "Fecha" 
     VIEW-AS FILL-IN 
     SIZE 19 BY .81
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-leyenda AS CHARACTER FORMAT "X(15)" 
     LABEL "Refer." 
     VIEW-AS FILL-IN 
     SIZE 48 BY .81
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-nro_comprob AS INTEGER FORMAT "->,>>>,>>9" INITIAL 0 
     LABEL "Número" 
     VIEW-AS FILL-IN 
     SIZE 19 BY .81
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-prf_comprob AS INTEGER FORMAT "9999" INITIAL 0 
     LABEL "Prefijo" 
     VIEW-AS FILL-IN 
     SIZE 6 BY .81
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-tip_comprob AS CHARACTER FORMAT "X(3)" 
     LABEL "Tipo" 
     VIEW-AS FILL-IN 
     SIZE 6 BY .81
     BGCOLOR 15 FGCOLOR 9 .

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 62 BY 6.46.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY Dialog-Frame FOR 
      Extracto SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     v-tip_comprob AT ROW 1.54 COL 9 COLON-ALIGNED
     v-prf_comprob AT ROW 1.54 COL 22 COLON-ALIGNED
     v-nro_comprob AT ROW 1.54 COL 38 COLON-ALIGNED HELP
          "Nro. de comprobante"
     v-fecha_movimto AT ROW 2.62 COL 9 COLON-ALIGNED
     v-debito AT ROW 3.69 COL 9 COLON-ALIGNED
     v-credito AT ROW 3.69 COL 38 COLON-ALIGNED
     v-leyenda AT ROW 4.77 COL 9 COLON-ALIGNED
     Btn_OK AT ROW 5.85 COL 11
     Btn_Cancel AT ROW 5.85 COL 44
     RECT-10 AT ROW 1 COL 1
     SPACE(2.13) SKIP(0.26)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Alta de registros de Extracto Bancario"
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


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX Dialog-Frame
/* Query rebuild information for DIALOG-BOX Dialog-Frame
     _TblList          = "sic.Extracto"
     _Options          = "SHARE-LOCK"
     _Query            is OPENED
*/  /* DIALOG-BOX Dialog-Frame */
&ANALYZE-RESUME

 




/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Alta de registros de Extracto Bancario */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel Dialog-Frame
ON CHOOSE OF Btn_Cancel IN FRAME Dialog-Frame /* Cancel */
DO:
     pusok = NO.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* OK */
DO:

  FIND Cuenta_bancaria WHERE ROWID(Cuenta_bancaria) = rid_cuenta NO-LOCK.
  ASSIGN FRAME {&FRAME-NAME}
         v-tip_comprob
         v-prf_comprob 
         v-nro_comprob 
         v-credito 
         v-debito 
         v-fecha_movimto 
         v-leyenda.
            
  IF NOT ( v-credito <> 0 OR v-debito <> 0 )
  THEN DO:
       RUN PONMENSJ.P ( INPUT "MOVB006").   
       RETURN NO-APPLY.
  END.
         
  IF v-fecha_movimto = DATE("")
  THEN DO:
       RUN PONMENSJ.P ( INPUT "MOVB007").   
       RETURN NO-APPLY.
  END.

  DO TRANSACTION:

     CREATE Extracto.
     ASSIGN Extracto.cdg_cuenta_ban = Cuenta_bancaria.cdg_cuenta_ban 
            Extracto.credito        = v-credito
            Extracto.debito         = v-debito
            Extracto.fecha_movimto  = v-fecha_movimto
            Extracto.leyenda        = v-leyenda
            Extracto.nro_comprob    = v-nro_comprob
            Extracto.prf_comprob    = v-prf_comprob
            Extracto.tip_comprob    = v-tip_comprob.
     
     pusok = YES.

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
  v-fecha_movimto = TODAY.
  DISPLAY v-fecha_movimto
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

  {&OPEN-QUERY-Dialog-Frame}
  GET FIRST Dialog-Frame.
  DISPLAY v-tip_comprob v-prf_comprob v-nro_comprob v-fecha_movimto v-debito 
          v-credito v-leyenda 
      WITH FRAME Dialog-Frame.
  ENABLE RECT-10 v-tip_comprob v-prf_comprob v-nro_comprob v-fecha_movimto 
         v-debito v-credito v-leyenda Btn_OK Btn_Cancel 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


