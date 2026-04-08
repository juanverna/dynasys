&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r2 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
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

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME BROWSE-1

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Extracto Cuenta_bancaria

/* Definitions for BROWSE BROWSE-1                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-1 Extracto.tip_comprob ~
Extracto.nro_comprob Extracto.credito Extracto.debito ~
Extracto.fecha_movimto Extracto.leyenda 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-1 
&Scoped-define FIELD-PAIRS-IN-QUERY-BROWSE-1
&Scoped-define ENABLED-TABLES-IN-QUERY-BROWSE-1 
&Scoped-define OPEN-QUERY-BROWSE-1 OPEN QUERY BROWSE-1 FOR EACH Extracto OF Cuenta_bancaria ~
      WHERE Extracto.fecha_movimto >= des_fecha ~
 AND Extracto.fecha_movimto <= has_fecha NO-LOCK.
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-1 Extracto
&Scoped-define TABLES-IN-QUERY-BROWSE-1 Extracto

/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define FIELDS-IN-QUERY-DEFAULT-FRAME Cuenta_bancaria.cdg_cuenta_ban ~
Cuenta_bancaria.denominacion_cta 
&Scoped-define ENABLED-FIELDS-IN-QUERY-DEFAULT-FRAME ~
Cuenta_bancaria.cdg_cuenta_ban 
&Scoped-define ENABLED-TABLES-IN-QUERY-DEFAULT-FRAME Cuenta_bancaria
&Scoped-define FIELD-PAIRS-IN-QUERY-DEFAULT-FRAME ~
      ~{&FP1}cdg_cuenta_ban ~{&FP2}cdg_cuenta_ban  ~{&FP3}
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-BROWSE-1}
&Scoped-define OPEN-QUERY-DEFAULT-FRAME OPEN QUERY DEFAULT-FRAME FOR EACH Cuenta_bancaria SHARE-LOCK.
&Scoped-define FIRST-TABLE-IN-QUERY-DEFAULT-FRAME Cuenta_bancaria
&Scoped-define TABLES-IN-QUERY-DEFAULT-FRAME Cuenta_bancaria

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Cuenta_bancaria.cdg_cuenta_ban 
&Scoped-define FIELD-PAIRS ~
      ~{&FP1}cdg_cuenta_ban ~{&FP2}cdg_cuenta_ban  ~{&FP3}
&Scoped-Define ENABLED-TABLES Cuenta_bancaria
&Scoped-Define ENABLED-OBJECTS RECT-1 btn_terminar btn_terminar-2 ~
btn_imprimir Btn_Done des_fecha has_fecha BROWSE-1 
&Scoped-Define DISPLAYED-FIELDS Cuenta_bancaria.cdg_cuenta_ban ~
Cuenta_bancaria.denominacion_cta 
&Scoped-Define DISPLAYED-OBJECTS des_fecha has_fecha 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Done DEFAULT 
     LABEL "&Salir" 
     SIZE 15 BY .88
     BGCOLOR 8 .

DEFINE BUTTON btn_imprimir 
     LABEL "&Listado" 
     SIZE 15 BY .88.

DEFINE BUTTON btn_terminar 
     LABEL "&Cancelar" 
     SIZE 15 BY .88.

DEFINE BUTTON btn_terminar-2 
     LABEL "&Otra cuenta" 
     SIZE 15 BY .88.

DEFINE VARIABLE des_fecha AS DATE FORMAT "99/99/99":U INITIAL ? 
     LABEL "Desde Fecha" 
     VIEW-AS FILL-IN 
     SIZE 10.56 BY .81
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE has_fecha AS DATE FORMAT "99/99/99":U INITIAL ? 
     LABEL "Hasta Fecha" 
     VIEW-AS FILL-IN 
     SIZE 10.56 BY .81
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 66 BY 1.5.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-1 FOR 
      Extracto SCROLLING.

DEFINE QUERY DEFAULT-FRAME FOR 
      Cuenta_bancaria SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-1 C-Win _STRUCTURED
  QUERY BROWSE-1 NO-LOCK DISPLAY
      Extracto.tip_comprob
      Extracto.nro_comprob
      Extracto.credito
      Extracto.debito
      Extracto.fecha_movimto
      Extracto.leyenda
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 55 BY 9.75
         FONT 4.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btn_terminar AT ROW 1.5 COL 12
     btn_terminar-2 AT ROW 1.5 COL 28
     btn_imprimir AT ROW 1.5 COL 44
     Btn_Done AT ROW 1.5 COL 60
     Cuenta_bancaria.cdg_cuenta_ban AT ROW 3 COL 18 COLON-ALIGNED
          LABEL "Cuenta Bancaria"
          VIEW-AS FILL-IN 
          SIZE 12 BY .75
          BGCOLOR 15 FGCOLOR 9 FONT 4
     Cuenta_bancaria.denominacion_cta AT ROW 3 COL 32 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 36.33 BY .75
          BGCOLOR 7 FGCOLOR 15 FONT 4
     des_fecha AT ROW 4.25 COL 18 COLON-ALIGNED
     has_fecha AT ROW 4.25 COL 41 COLON-ALIGNED
     BROWSE-1 AT ROW 5.75 COL 12
     RECT-1 AT ROW 1.25 COL 11
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 88.89 BY 18
         FONT 4
         DEFAULT-BUTTON Btn_Done.

 

/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Consulta de Extracto Bancario"
         HEIGHT             = 16
         WIDTH              = 80
         MAX-HEIGHT         = 18
         MAX-WIDTH          = 88.89
         VIRTUAL-HEIGHT     = 18
         VIRTUAL-WIDTH      = 88.89
         RESIZE             = yes
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         KEEP-FRAME-Z-ORDER = yes
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
&ANALYZE-RESUME


/* ***************  Runtime Attributes and UIB Settings  ************** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FILL-IN Cuenta_bancaria.cdg_cuenta_ban IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cuenta_bancaria.denominacion_cta IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-1
/* Query rebuild information for BROWSE BROWSE-1
     _TblList          = "sic.Extracto OF sic.Cuenta_bancaria"
     _Options          = "NO-LOCK"
     _Where[1]         = "Extracto.fecha_movimto >= des_fecha
 AND Extracto.fecha_movimto <= has_fecha"
     _FldNameList[1]   = sic.Extracto.tip_comprob
     _FldNameList[2]   = sic.Extracto.nro_comprob
     _FldNameList[3]   = sic.Extracto.credito
     _FldNameList[4]   = sic.Extracto.debito
     _FldNameList[5]   = sic.Extracto.fecha_movimto
     _FldNameList[6]   = sic.Extracto.leyenda
     _Query            is OPENED
*/  /* BROWSE BROWSE-1 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME DEFAULT-FRAME
/* Query rebuild information for FRAME DEFAULT-FRAME
     _TblList          = "sic.Cuenta_bancaria"
     _Query            is OPENED
*/  /* FRAME DEFAULT-FRAME */
&ANALYZE-RESUME

 




/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Consulta de Extracto Bancario */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Consulta de Extracto Bancario */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Done
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Done C-Win
ON CHOOSE OF Btn_Done IN FRAME DEFAULT-FRAME /* Salir */
DO:
  &IF DEFINED (adm-panel) <> 0 &THEN
      RUN dispatch IN THIS-PROCEDURE ('exit').
  &ELSE
      APPLY "CLOSE":U TO THIS-PROCEDURE.
  &ENDIF
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-1
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.

/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
   RUN disable_UI.

/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI C-Win _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Delete the WINDOW we created */
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
  THEN DELETE WIDGET C-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI C-Win _DEFAULT-ENABLE
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

  {&OPEN-QUERY-DEFAULT-FRAME}
  GET FIRST DEFAULT-FRAME.
  DISPLAY des_fecha has_fecha 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE Cuenta_bancaria THEN 
    DISPLAY Cuenta_bancaria.cdg_cuenta_ban Cuenta_bancaria.denominacion_cta 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE RECT-1 btn_terminar btn_terminar-2 btn_imprimir Btn_Done 
         Cuenta_bancaria.cdg_cuenta_ban des_fecha has_fecha BROWSE-1 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


