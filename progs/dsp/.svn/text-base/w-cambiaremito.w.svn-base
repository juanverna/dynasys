&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS W-Win 
/*------------------------------------------------------------------------

  File: 

  Description: from cntnrwin.w - ADM SmartWindow Template

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  History: 
          
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

&Scoped-define PROCEDURE-TYPE SmartWindow
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER WINDOW

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME F-Main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS tipo_a prefijo_a numero_a prefijo numero ~
BUTTON-1 RECT-1 RECT-2 
&Scoped-Define DISPLAYED-OBJECTS tipo_a prefijo_a numero_a tipo prefijo ~
numero 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR W-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON BUTTON-1 
     LABEL "Modificar" 
     SIZE 13 BY 1.

DEFINE VARIABLE numero AS INTEGER FORMAT "99999999":U INITIAL 0 
     LABEL "Número" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 10 BY .81
     BGCOLOR 15 FGCOLOR 9 FONT 2 NO-UNDO.

DEFINE VARIABLE numero_a AS INTEGER FORMAT "99999999":U INITIAL 0 
     LABEL "Número" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 10 BY .81
     BGCOLOR 15 FGCOLOR 9 FONT 2 NO-UNDO.

DEFINE VARIABLE prefijo AS INTEGER FORMAT "9999":U INITIAL 0 
     LABEL "Prefijo" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 9.86 BY .81
     BGCOLOR 15 FGCOLOR 9 FONT 2 NO-UNDO.

DEFINE VARIABLE prefijo_a AS INTEGER FORMAT "9999":U INITIAL 0 
     LABEL "Prefijo" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 10 BY .81
     BGCOLOR 15 FGCOLOR 9 FONT 2 NO-UNDO.

DEFINE VARIABLE tipo AS CHARACTER FORMAT "X(3)":U 
     LABEL "Tipo" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 10 BY .81
     BGCOLOR 15 FGCOLOR 9 FONT 2 NO-UNDO.

DEFINE VARIABLE tipo_a AS CHARACTER FORMAT "X(3)":U 
     LABEL "Tipo" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 10 BY .81
     BGCOLOR 15 FGCOLOR 9 FONT 2 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 25 BY 4.04.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 25 BY 4.04.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     tipo_a AT ROW 3.42 COL 13 COLON-ALIGNED
     prefijo_a AT ROW 4.5 COL 13 COLON-ALIGNED
     numero_a AT ROW 5.58 COL 13 COLON-ALIGNED
     tipo AT ROW 3.42 COL 42 COLON-ALIGNED
     prefijo AT ROW 4.42 COL 42.14 COLON-ALIGNED
     numero AT ROW 5.42 COL 42 COLON-ALIGNED
     BUTTON-1 AT ROW 7.46 COL 47
     RECT-1 AT ROW 2.88 COL 5
     RECT-2 AT ROW 2.88 COL 35
     "    Datos del Remito Anterior" VIEW-AS TEXT
          SIZE 25 BY .81 AT ROW 1.81 COL 5
          BGCOLOR 7 FGCOLOR 15 
     "     Datos del Remito Actual" VIEW-AS TEXT
          SIZE 25 BY .81 AT ROW 1.81 COL 35
          BGCOLOR 7 FGCOLOR 15 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 17.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartWindow
   Allow: Basic,Browse,DB-Fields,Query,Smart,Window
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW W-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Modificacion de Remito"
         HEIGHT             = 9.31
         WIDTH              = 62.72
         MAX-HEIGHT         = 18
         MAX-WIDTH          = 88.86
         VIRTUAL-HEIGHT     = 18
         VIRTUAL-WIDTH      = 88.86
         RESIZE             = no
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB W-Win 
/* ************************* Included-Libraries *********************** */

{src/adm/method/containr.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW W-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME F-Main
   Custom                                                               */
/* SETTINGS FOR FILL-IN tipo IN FRAME F-Main
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(W-Win)
THEN W-Win:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON END-ERROR OF W-Win /* Modificacion de Remito */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-CLOSE OF W-Win /* Modificacion de Remito */
DO:
  /* This ADM code must be left here in order for the SmartWindow
     and its descendents to terminate properly on exit. */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-1 W-Win
ON CHOOSE OF BUTTON-1 IN FRAME F-Main /* Modificar */
DO:
  DEFINE VARIABLE puede_cambiar AS LOGICAL INITIAL NO.
  
  {findempresa.i}
                                                  
  FIND Parametro WHERE Parametro.cdg_parametro = "REMIMANU"
                   AND Parametro.cdg_empresa   = "M".

  IF  LOOKUP(STRING(prefijo,"9999"),Parametro.observacion) <> 0
  AND LOOKUP(STRING(prefijo_a,"9999"),Parametro.observacion) <> 0
  THEN DO:
    DEFINE BUFFER B-Rem_header FOR Rem_header.
    FIND Rem_header WHERE Rem_header.tip_comprob = tipo_a
                      AND Rem_header.prf_comprob = prefijo_a
                      AND Rem_header.nro_comprob = numero_a NO-ERROR.
    IF AVAILABLE Rem_header
    THEN DO:
         FIND B-Rem_header WHERE B-Rem_header.tip_comprob = tipo
                             AND B-Rem_header.prf_comprob = prefijo
                             AND B-Rem_header.nro_comprob = numero NO-ERROR.
         IF NOT AVAILABLE B-Rem_header
              THEN RUN cambiar_numeracion_remitos.p (INPUT tipo_a,
                                                     INPUT prefijo_a,
                                                     INPUT numero_a,
                                                     INPUT tipo,
                                                     INPUT prefijo,
                                                     INPUT numero).                                    
              ELSE RUN PONMENSJ.P ("REMI029").
    END.
    ELSE DO:
        RUN PONMENSJ.P ( INPUT "REMI025" ).
    END.
  END.
  ELSE DO:
    RUN PONMENSJ.P ("REMI030").
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME numero
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL numero W-Win
ON LEAVE OF numero IN FRAME F-Main /* Número */
DO:
    ASSIGN numero.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME numero_a
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL numero_a W-Win
ON LEAVE OF numero_a IN FRAME F-Main /* Número */
DO:
    ASSIGN numero_a.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME prefijo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL prefijo W-Win
ON LEAVE OF prefijo IN FRAME F-Main /* Prefijo */
DO:
    ASSIGN prefijo.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME prefijo_a
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL prefijo_a W-Win
ON LEAVE OF prefijo_a IN FRAME F-Main /* Prefijo */
DO:
   ASSIGN prefijo_a.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME tipo_a
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tipo_a W-Win
ON LEAVE OF tipo_a IN FRAME F-Main /* Tipo */
DO:
  ASSIGN tipo_a.
  tipo = tipo_a.
  DISPLAY tipo WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK W-Win 


/* ***************************  Main Block  *************************** */

/* Include custom  Main Block code for SmartWindows. */
{src/adm/template/windowmn.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-create-objects W-Win  _ADM-CREATE-OBJECTS
PROCEDURE adm-create-objects :
/*------------------------------------------------------------------------------
  Purpose:     Create handles for all SmartObjects used in this procedure.
               After SmartObjects are initialized, then SmartLinks are added.
  Parameters:  <none>
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available W-Win  _ADM-ROW-AVAILABLE
PROCEDURE adm-row-available :
/*------------------------------------------------------------------------------
  Purpose:     Dispatched to this procedure when the Record-
               Source has a new row available.  This procedure
               tries to get the new row (or foriegn keys) from
               the Record-Source and process it.
  Parameters:  <none>
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.             */
  {src/adm/template/row-head.i}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI W-Win  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(W-Win)
  THEN DELETE WIDGET W-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI W-Win  _DEFAULT-ENABLE
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
  DISPLAY tipo_a prefijo_a numero_a tipo prefijo numero 
      WITH FRAME F-Main IN WINDOW W-Win.
  ENABLE tipo_a prefijo_a numero_a prefijo numero BUTTON-1 RECT-1 RECT-2 
      WITH FRAME F-Main IN WINDOW W-Win.
  {&OPEN-BROWSERS-IN-QUERY-F-Main}
  VIEW W-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-exit W-Win 
PROCEDURE local-exit :
/* -----------------------------------------------------------
  Purpose:  Starts an "exit" by APPLYing CLOSE event, which starts "destroy".
  Parameters:  <none>
  Notes:    If activated, should APPLY CLOSE, *not* dispatch adm-exit.   
-------------------------------------------------------------*/
   APPLY "CLOSE":U TO THIS-PROCEDURE.
   
   RETURN.
       
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records W-Win  _ADM-SEND-RECORDS
PROCEDURE send-records :
/*------------------------------------------------------------------------------
  Purpose:     Send record ROWID's for all tables used by
               this file.
  Parameters:  see template/snd-head.i
------------------------------------------------------------------------------*/

  /* SEND-RECORDS does nothing because there are no External
     Tables specified for this SmartWindow, and there are no
     tables specified in any contained Browse, Query, or Frame. */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE state-changed W-Win 
PROCEDURE state-changed :
/* -----------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-------------------------------------------------------------*/
  DEFINE INPUT PARAMETER p-issuer-hdl AS HANDLE NO-UNDO.
  DEFINE INPUT PARAMETER p-state AS CHARACTER NO-UNDO.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

