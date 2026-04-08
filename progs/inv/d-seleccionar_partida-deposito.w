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

&IF DEFINED(UIB_is_Running) NE 0
&THEN
DEFINE VARIABLE          p-nro_articulo  LIKE Articulo.nro_articulo INITIAL 161.
DEFINE VARIABLE          p-nro_deposito  LIKE Deposito.nro_deposito INITIAL 1.
DEFINE VARIABLE          p-cdg_partida   LIKE Partida.cdg_partida.
&ELSE
DEFINE INPUT  PARAMETER  p-nro_articulo  LIKE Articulo.nro_articulo.
DEFINE INPUT  PARAMETER  p-nro_deposito  LIKE Deposito.nro_deposito.
DEFINE OUTPUT PARAMETER  p-cdg_partida   LIKE Partida.cdg_partida.
&ENDIF

/* Local Variable Definitions ---                                       */

DEFINE VARIABLE que_empresa LIKE Empresa.cdg_empresa.
DEFINE VARIABLE que_articulo LIKE Articulo.nro_articulo.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Dialog-Box
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame
&Scoped-define BROWSE-NAME BROWSE-9

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Partida-deposito Partida

/* Definitions for BROWSE BROWSE-9                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-9 Partida.cdg_partida ~
Partida.descripcion Partida-deposito.remanente_cantidad ~
Partida-deposito.remanente_granel 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-9 
&Scoped-define QUERY-STRING-BROWSE-9 FOR EACH Partida-deposito ~
      WHERE Partida-deposito.cdg_empresa = que_empresa ~
 AND Partida-deposito.nro_articulo = p-nro_articulo ~
 AND Partida-deposito.nro_deposito = p-nro_deposito NO-LOCK, ~
      FIRST Partida OF Partida-deposito NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-9 OPEN QUERY BROWSE-9 FOR EACH Partida-deposito ~
      WHERE Partida-deposito.cdg_empresa = que_empresa ~
 AND Partida-deposito.nro_articulo = p-nro_articulo ~
 AND Partida-deposito.nro_deposito = p-nro_deposito NO-LOCK, ~
      FIRST Partida OF Partida-deposito NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-9 Partida-deposito Partida
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-9 Partida-deposito
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-9 Partida


/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define OPEN-BROWSERS-IN-QUERY-Dialog-Frame ~
    ~{&OPEN-QUERY-BROWSE-9}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS Btn_OK Btn_Cancel BROWSE-9 RECT-16 
&Scoped-Define DISPLAYED-OBJECTS v-dsc_articulo v-cdg_articulo ~
v-dsc_deposito v-cdg_deposito 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "&Salir" 
     SIZE 15 BY 1
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "&Elegir" 
     SIZE 15 BY 1
     BGCOLOR 8 .

DEFINE VARIABLE v-cdg_articulo AS CHARACTER FORMAT "X(256)":U 
     LABEL "Artículo" 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-cdg_deposito AS CHARACTER FORMAT "X(256)":U 
     LABEL "Depósito" 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_articulo AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 47 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_deposito AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 47 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-16
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 94 BY 2.57.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-9 FOR 
      Partida-deposito, 
      Partida SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-9
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-9 Dialog-Frame _STRUCTURED
  QUERY BROWSE-9 NO-LOCK DISPLAY
      Partida.cdg_partida COLUMN-LABEL "Código!Partida" FORMAT "X(8)":U
            WIDTH 12.2
      Partida.descripcion COLUMN-LABEL "Descripción!Partida" FORMAT "X(40)":U
            WIDTH 38.2
      Partida-deposito.remanente_cantidad FORMAT "->,>>>,>>9.99":U
            WIDTH 17.4
      Partida-deposito.remanente_granel COLUMN-LABEL "Remanente!Granel" FORMAT "->>,>>9.99":U
            WIDTH 18.4
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 94 BY 10.71.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     v-dsc_articulo AT ROW 1.48 COL 31 COLON-ALIGNED NO-LABEL
     Btn_OK AT ROW 1.48 COL 81
     v-cdg_articulo AT ROW 1.52 COL 12 COLON-ALIGNED
     v-dsc_deposito AT ROW 2.67 COL 31 COLON-ALIGNED NO-LABEL
     Btn_Cancel AT ROW 2.67 COL 81
     v-cdg_deposito AT ROW 2.71 COL 12 COLON-ALIGNED
     BROWSE-9 AT ROW 4.1 COL 3
     RECT-16 AT ROW 1.29 COL 3
     SPACE(1.39) SKIP(12.56)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Selección de partidas por depósito".


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
/* BROWSE-TAB BROWSE-9 v-cdg_deposito Dialog-Frame */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN v-cdg_articulo IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_deposito IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_articulo IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_deposito IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-9
/* Query rebuild information for BROWSE BROWSE-9
     _TblList          = "sic.Partida-deposito,sic.Partida OF sic.Partida-deposito"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _TblOptList       = ", FIRST"
     _Where[1]         = "Partida-deposito.cdg_empresa = que_empresa
 AND Partida-deposito.nro_articulo = p-nro_articulo
 AND Partida-deposito.nro_deposito = p-nro_deposito"
     _FldNameList[1]   > sic.Partida.cdg_partida
"Partida.cdg_partida" "Código!Partida" ? "character" ? ? ? ? ? ? no ? no no "12.2" yes no no "U" "" ""
     _FldNameList[2]   > sic.Partida.descripcion
"Partida.descripcion" "Descripción!Partida" ? "character" ? ? ? ? ? ? no ? no no "38.2" yes no no "U" "" ""
     _FldNameList[3]   > sic.Partida-deposito.remanente_cantidad
"Partida-deposito.remanente_cantidad" ? ? "decimal" ? ? ? ? ? ? no ? no no "17.4" yes no no "U" "" ""
     _FldNameList[4]   > sic.Partida-deposito.remanente_granel
"Partida-deposito.remanente_granel" "Remanente!Granel" ? "decimal" ? ? ? ? ? ? no ? no no "18.4" yes no no "U" "" ""
     _Query            is OPENED
*/  /* BROWSE BROWSE-9 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Selección de partidas por depósito */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* Elegir */
DO:
  IF NOT AVAILABLE Partida
  THEN DO:
       RUN ponmensj.p ( INPUT "ARTI008" ).
       RETURN NO-APPLY.
  END.
  ELSE DO:
       p-cdg_partida = Partida.cdg_partida.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-9
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Dialog-Frame 


/* ***************************  Main Block  *************************** */

/* Parent the dialog-box to the ACTIVE-WINDOW, if there is no parent.   */
IF VALID-HANDLE(ACTIVE-WINDOW) AND FRAME {&FRAME-NAME}:PARENT eq ?
THEN FRAME {&FRAME-NAME}:PARENT = ACTIVE-WINDOW.

{findempresa.i}
que_empresa = Empresa.cdg_empresa.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  FIND Articulo WHERE Articulo.nro_articulo = p-nro_articulo NO-LOCK.
  ASSIGN
       que_articulo   = Articulo.nro_articulo
       v-cdg_articulo = Articulo.cdg_articulo
       v-dsc_articulo = Articulo.descripcion.
  FIND Deposito WHERE Deposito.nro_deposito = p-nro_deposito NO-LOCK.
  ASSIGN
       v-cdg_deposito = Deposito.cdg_deposito
       v-dsc_deposito = Deposito.nombre.

  DISPLAY 
       v-cdg_articulo
       v-dsc_articulo
       v-cdg_deposito
       v-dsc_deposito
       WITH FRAME {&FRAME-NAME}.
  {&OPEN-QUERY-{&BROWSE-NAME}}
  
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
  DISPLAY v-dsc_articulo v-cdg_articulo v-dsc_deposito v-cdg_deposito 
      WITH FRAME Dialog-Frame.
  ENABLE Btn_OK Btn_Cancel BROWSE-9 RECT-16 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

