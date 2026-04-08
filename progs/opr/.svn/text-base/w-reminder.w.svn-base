&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS W-Win 
/*********************************************************************
* Copyright (C) 2000 by Progress Software Corporation ("PSC"),       *
* 14 Oak Park, Bedford, MA 01730, and other contributors as listed   *
* below.  All Rights Reserved.                                       *
*                                                                    *
* The Initial Developer of the Original Code is PSC.  The Original   *
* Code is Progress IDE code released to open source December 1, 2000.*
*                                                                    *
* The contents of this file are subject to the Possenet Public       *
* License Version 1.0 (the "License"); you may not use this file     *
* except in compliance with the License.  A copy of the License is   *
* available as of the date of this notice at                         *
* http://www.possenet.org/license.html                               *
*                                                                    *
* Software distributed under the License is distributed on an "AS IS"*
* basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. You*
* should refer to the License for the specific language governing    *
* rights and limitations under the License.                          *
*                                                                    *
* Contributors:                                                      *
*                                                                    *
*********************************************************************/
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

DEFINE TEMP-TABLE tt LIKE evento
    FIELD Freminder AS DATE LABEL "Fecha"
    FIELD cdg_tipo_evento LIKE tipo_evento.cdg_tipo_evento
    FIELD direccion LIKE cliente.direccion
    FIELD nom_cliente LIKE Cliente.nom_cliente
        INDEX idx1 IS PRIMARY freminder ASCENDING fasignado ASCENDING.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartWindow
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER WINDOW

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME F-Main
&Scoped-define BROWSE-NAME BROWSE-2

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tt

/* Definitions for BROWSE BROWSE-2                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-2 tt.cdg_tipo_evento tt.nro_evento tt.freminder tt.FAsignado tt.Reminder tt.recursos tt.nom_cliente tt.direccion   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-2   
&Scoped-define SELF-NAME BROWSE-2
&Scoped-define OPEN-QUERY-BROWSE-2 RUN ttllena. OPEN QUERY {&SELF-NAME} FOR EACH tt.
&Scoped-define TABLES-IN-QUERY-BROWSE-2 tt
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-2 tt


/* Definitions for FRAME F-Main                                         */
&Scoped-define OPEN-BROWSERS-IN-QUERY-F-Main ~
    ~{&OPEN-QUERY-BROWSE-2}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS c_nro_tipo_evento dsc_tipo_evento v-desde ~
BUTTON-8 v-nom_cliente v-operario v-direccion BROWSE-2 
&Scoped-Define DISPLAYED-OBJECTS c_nro_tipo_evento dsc_tipo_evento v-desde ~
v-nom_cliente v-operario v-direccion 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR W-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON BUTTON-8 
     IMAGE-UP FILE "img/excel.gif":U
     LABEL "Button 8" 
     SIZE 6 BY 1.14.

DEFINE VARIABLE c_nro_tipo_evento AS INTEGER FORMAT "->>>>>>>>9" INITIAL 0 
     LABEL "Tipo" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "0",1
     DROP-DOWN-LIST
     SIZE 12 BY 1 TOOLTIP "Tipo de Restriccion o Tipo de Evento"
     BGCOLOR 14 FGCOLOR 0 .

DEFINE VARIABLE dsc_tipo_evento AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 38 BY 1 NO-UNDO.

DEFINE VARIABLE v-desde AS DATE FORMAT "99/99/9999":U 
     LABEL "Desde" 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 14 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE v-direccion AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 106 BY .95
     BGCOLOR 11 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE v-nom_cliente AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 92 BY 1
     BGCOLOR 11  NO-UNDO.

DEFINE VARIABLE v-operario AS CHARACTER FORMAT "X(256)":U 
     LABEL "" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 11 FGCOLOR 0  NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-2 FOR 
      tt SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-2 W-Win _FREEFORM
  QUERY BROWSE-2 NO-LOCK DISPLAY
      tt.cdg_tipo_evento
      tt.nro_evento FORMAT ">>>>>>>9":U
      tt.freminder FORMAT "99/99/9999":U
      tt.FAsignado FORMAT "99/99/9999":U
      tt.Reminder FORMAT "x(200)":U
      tt.recursos
      tt.nom_cliente FORMAT "X(50)"
      tt.direccion FORMAT "X(50)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS MULTIPLE SIZE 106 BY 14.76 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     c_nro_tipo_evento AT ROW 1.24 COL 6 COLON-ALIGNED WIDGET-ID 40
     dsc_tipo_evento AT ROW 1.24 COL 20 COLON-ALIGNED NO-LABEL WIDGET-ID 42
     v-desde AT ROW 1.24 COL 71 COLON-ALIGNED WIDGET-ID 48
     BUTTON-8 AT ROW 1.24 COL 95 WIDGET-ID 6
     v-nom_cliente AT ROW 2.43 COL 1 COLON-ALIGNED NO-LABEL WIDGET-ID 52
     v-operario AT ROW 2.43 COL 93.2 COLON-ALIGNED WIDGET-ID 54
     v-direccion AT ROW 3.38 COL 1 COLON-ALIGNED NO-LABEL WIDGET-ID 50
     BROWSE-2 AT ROW 4.57 COL 3 WIDGET-ID 200
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 110.2 BY 18.38 WIDGET-ID 100.


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
         TITLE              = "Remainder"
         HEIGHT             = 18.38
         WIDTH              = 110.2
         MAX-HEIGHT         = 18.38
         MAX-WIDTH          = 110.2
         VIRTUAL-HEIGHT     = 18.38
         VIRTUAL-WIDTH      = 110.2
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

{excel-export.i}
{src/adm/method/containr.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW W-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME F-Main
   FRAME-NAME                                                           */
/* BROWSE-TAB BROWSE-2 v-direccion F-Main */
ASSIGN 
       dsc_tipo_evento:READ-ONLY IN FRAME F-Main        = TRUE.

ASSIGN 
       v-direccion:READ-ONLY IN FRAME F-Main        = TRUE.

ASSIGN 
       v-nom_cliente:READ-ONLY IN FRAME F-Main        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(W-Win)
THEN W-Win:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-2
/* Query rebuild information for BROWSE BROWSE-2
     _START_FREEFORM
RUN ttllena.
OPEN QUERY {&SELF-NAME} FOR EACH tt.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Query            is OPENED
*/  /* BROWSE BROWSE-2 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON END-ERROR OF W-Win /* Remainder */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-CLOSE OF W-Win /* Remainder */
DO:
  /* This ADM code must be left here in order for the SmartWindow
     and its descendents to terminate properly on exit. */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-2
&Scoped-define SELF-NAME BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-2 W-Win
ON VALUE-CHANGED OF BROWSE-2 IN FRAME F-Main
DO:
  v-direccion:SCREEN-VALUE = tt.direccion.
  v-nom_cliente:SCREEN-VALUE = tt.nom_cliente.
  v-operario:SCREEN-VALUE = STRING(tt.recursos).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-8
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-8 W-Win
ON CHOOSE OF BUTTON-8 IN FRAME F-Main /* Button 8 */
DO:
  run excel-export ( browse-2:HANDLE ).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME c_nro_tipo_evento
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c_nro_tipo_evento W-Win
ON VALUE-CHANGED OF c_nro_tipo_evento IN FRAME F-Main /* Tipo */
DO:
  ASSIGN {&self-name}.
  FIND FIRST tipo_evento WHERE tipo_evento.nro_tipo_evento = c_nro_tipo_evento:INPUT-VALUE NO-ERROR.
  IF AVAILABLE tipo_evento THEN 
       dsc_tipo_evento:SCREEN-VALUE IN FRAME {&FRAME-NAME} = tipo_evento.descripcion.
  {&OPEN-QUERY-{&BROWSE-NAME}}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-desde
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-desde W-Win
ON LEAVE OF v-desde IN FRAME F-Main /* Desde */
DO:
  ASSIGN {&SELF-NAME}.
  {&OPEN-QUERY-{&BROWSE-NAME}}
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
  DISPLAY c_nro_tipo_evento dsc_tipo_evento v-desde v-nom_cliente v-operario 
          v-direccion 
      WITH FRAME F-Main IN WINDOW W-Win.
  ENABLE c_nro_tipo_evento dsc_tipo_evento v-desde BUTTON-8 v-nom_cliente 
         v-operario v-direccion BROWSE-2 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize W-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
  DEFINE VAR lista AS CHAR NO-UNDO.

  DO WITH FRAME {&FRAME-NAME}:
     {levantacombo.i &TABLA=Tipo_evento &NOMBRE=cdg_tipo_evento &CODIGO=nro_tipo_evento &OBJETO=c_nro_tipo_evento}
  END. 
  c_nro_tipo_evento:ADD-FIRST("Todos",-1).
  v-desde = TODAY.
  c_nro_tipo_evento = -1.
  DISPLAY v-desde c_nro_tipo_evento.

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  c_nro_tipo_evento:SCREEN-VALUE = "-1".

  /* Code placed here will execute AFTER standard behavior.    */

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

  /* Define variables needed by this internal procedure.               */
  {src/adm/template/snd-head.i}

  /* For each requested table, put it's ROWID in the output list.      */
  {src/adm/template/snd-list.i "tt"}

  /* Deal with any unexpected table requests before closing.           */
  {src/adm/template/snd-end.i}

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ttllena W-Win 
PROCEDURE ttllena :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
EMPTY TEMP-TABLE tt.
DEFINE VAR ii AS INT NO-UNDO.
DEFINE VAR opt AS LOGICAL NO-UNDO.
FOR EACH evento WHERE NOT evento.anulado AND 
    evento.fasignado >= v-desde AND 
    evento.reminder <> "" AND
    ( evento.nro_tipo_evento = c_nro_tipo_evento OR c_nro_tipo_evento = -1 ) NO-LOCK:
    FIND tipo_evento  WHERE tipo_evento.nro_tipo_evento = evento.nro_tipo_evento NO-LOCK.
    IF evento.fasignado + Evento.dreminder <= v-desde THEN NEXT.
    CREATE tt.
    FIND cliente OF evento NO-LOCK.
    BUFFER-COPY evento TO tt ASSIGN
        tt.freminder = Evento.fasignado + Evento.dreminder
        tt.cdg_tipo_evento = tipo_evento.cdg_tipo_evento. 
        tt.direccion = cliente.direccion.
        tt.nom_cliente = cliente.nom_cliente.
    /*    ii = ii + 1.
    IF ii MOD 100 = 0 THEN DO:
        MESSAGE "Ya van " + STRING(ii) + " recordatorios, continua" VIEW-AS ALERT-BOX QUESTION BUTTON YES-NO SET opt.
        IF NOT opt THEN LEAVE.
    END.*/
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

