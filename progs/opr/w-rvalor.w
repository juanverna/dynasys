&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
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

{tablasTT-opr.i}
    

DEFINE INPUT PARAMETER TABLE FOR analizado.
DEFINE INPUT PARAMETER TABLE FOR rvalor.
DEFINE VARIABLE dias AS CHARACTER EXTENT 7 INITIAL [ "Dom" , "Lun" , "Mar" , "Mie" , "Jue" , "Vie" , "Sab" ].

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartWindow
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER WINDOW

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME F-Main
&Scoped-define BROWSE-NAME BROWSE-7

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES rvalor evento Contrato_Restriccion ~
Restriccion

/* Definitions for BROWSE BROWSE-7                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-7 rvalor.fecha /*fecha de analisis*/ dias[WEEKDAY ( rvalor.fecha ) ] rvalor.nro_evento /*nro de evento a analizar*/ rvalor.valor /*es la suma de los valores de satisfaccion obtenido 0 es lo minimo*/ evento.origen evento.nro_identificacion evento.sub_evento rvalor.mobs   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-7   
&Scoped-define SELF-NAME BROWSE-7
&Scoped-define OPEN-QUERY-BROWSE-7 DEF VAR t AS INT NO-UNDO. DEFINE VAR sev AS INT NO-UNDO. ASSIGN v-identificacion v-evento. t = INT(entry(1, ~
      v-identificacion, ~
      "-")) NO-ERROR. IF NUM-ENTRIES(v-identificacion, ~
      "-") = 2 THEN   sev = int(entry(2, ~
      v-identificacion, ~
      "-")). ELSE   sev = 0.      IF v-identificacion = "" THEN         IF v-evento = "" THEN             OPEN QUERY {&SELF-NAME} FOR EACH rvalor NO-LOCK , ~
       FIRST evento WHERE evento.nro_evento = rvalor.nro_evento  BY rvalor.fecha .         ELSE             OPEN QUERY {&SELF-NAME} FOR EACH rvalor  WHERE rvalor.nro_evento = int(v-evento) NO-LOCK, ~
       FIRST evento WHERE evento.nro_evento = rvalor.nro_evento BY rvalor.fecha .     ELSE             OPEN QUERY {&SELF-NAME} FOR EACH rvalor NO-LOCK, ~
       FIRST evento WHERE evento.nro_evento = rvalor.nro_evento AND evento.nro_identificacion = t AND (evento.sub_evento = sev OR sev = 0)BY rvalor.fecha .   {&OPEN-QUERY-browse-9}.
&Scoped-define TABLES-IN-QUERY-BROWSE-7 rvalor evento
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-7 rvalor
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-7 evento


/* Definitions for BROWSE BROWSE-9                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-9 Contrato_Restriccion.nro_contrato Contrato_Restriccion.Prioridad Contrato_Restriccion.nro_restriccion Contrato_Restriccion.sub_evento Contrato_Restriccion.Valor Restriccion.cdg_restriccion Restriccion.evaluar Restriccion.esrestriccion   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-9   
&Scoped-define SELF-NAME BROWSE-9
&Scoped-define QUERY-STRING-BROWSE-9 FOR EACH Evento       WHERE  rvalor.nro_evento = evento.nro_evento NO-LOCK, ~
             EACH Contrato_Restriccion WHERE Contrato_Restriccion.nro_contrato = evento.nro_identificacion AND contrato_restriccion.sub_evento = evento.sub_evento  NO-LOCK, ~
             EACH Restriccion OF Contrato_Restriccion NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-9 OPEN QUERY {&SELF-NAME} FOR EACH Evento       WHERE  rvalor.nro_evento = evento.nro_evento NO-LOCK, ~
             EACH Contrato_Restriccion WHERE Contrato_Restriccion.nro_contrato = evento.nro_identificacion AND contrato_restriccion.sub_evento = evento.sub_evento  NO-LOCK, ~
             EACH Restriccion OF Contrato_Restriccion NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-9 Evento Contrato_Restriccion ~
Restriccion
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-9 Evento
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-9 Contrato_Restriccion
&Scoped-define THIRD-TABLE-IN-QUERY-BROWSE-9 Restriccion


/* Definitions for FRAME F-Main                                         */
&Scoped-define OPEN-BROWSERS-IN-QUERY-F-Main ~
    ~{&OPEN-QUERY-BROWSE-7}~
    ~{&OPEN-QUERY-BROWSE-9}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS BUTTON-8 v-evento v-identificacion BROWSE-7 ~
BROWSE-9 
&Scoped-Define DISPLAYED-OBJECTS v-evento v-identificacion 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD tope W-Win 
FUNCTION tope RETURNS LOGICAL
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR W-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON BUTTON-8 
     IMAGE-UP FILE "img/excel.gif":U
     LABEL "Button 8" 
     SIZE 15 BY 1.14.

DEFINE VARIABLE v-evento AS CHARACTER FORMAT "X(256)":U 
     LABEL "Evento" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 14  NO-UNDO.

DEFINE VARIABLE v-identificacion AS CHARACTER FORMAT "X(256)":U 
     LABEL "Identificacion" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 14  NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-7 FOR 
      rvalor, 
      evento SCROLLING.

DEFINE QUERY BROWSE-9 FOR 
      Evento, 
      Contrato_Restriccion, 
      Restriccion SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-7
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-7 W-Win _FREEFORM
  QUERY BROWSE-7 DISPLAY
      rvalor.fecha LABEL "Fecha" /*fecha de analisis*/
dias[WEEKDAY ( rvalor.fecha ) ] LABEL "Dia" FORMAT "X(3)"
rvalor.nro_evento LABEL "Evento"  /*nro de evento a analizar*/
rvalor.valor LABEL "Valor" /*es la suma de los valores de satisfaccion obtenido 0 es lo minimo*/
evento.origen LABEL "Origen"
evento.nro_identificacion LABEL "Identificacion"
evento.sub_evento label "SE"
rvalor.mobs LABEL "Mobs" FORMAT "X(40)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 102 BY 11.67 FIT-LAST-COLUMN.

DEFINE BROWSE BROWSE-9
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-9 W-Win _FREEFORM
  QUERY BROWSE-9 NO-LOCK DISPLAY
      Contrato_Restriccion.nro_contrato FORMAT "ZZZZZ9":U
      Contrato_Restriccion.Prioridad FORMAT "9":U
      Contrato_Restriccion.nro_restriccion FORMAT ">9":U
      Contrato_Restriccion.sub_evento FORMAT "->,>>>,>>9":U
      Contrato_Restriccion.Valor FORMAT "X(20)":U
      Restriccion.cdg_restriccion FORMAT "X(8)":U
      Restriccion.evaluar FORMAT "yes/no":U
      Restriccion.esrestriccion FORMAT "yes/no":U WIDTH 16
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 102 BY 5.71 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     BUTTON-8 AT ROW 1.24 COL 61 WIDGET-ID 6
     v-evento AT ROW 1.33 COL 41 COLON-ALIGNED WIDGET-ID 8
     v-identificacion AT ROW 1.38 COL 15.4 COLON-ALIGNED WIDGET-ID 4
     BROWSE-7 AT ROW 2.67 COL 4 WIDGET-ID 200
     BROWSE-9 AT ROW 14.57 COL 4 WIDGET-ID 300
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 107.4 BY 19.71 WIDGET-ID 100.


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
         TITLE              = "Valorizacion Satisfaccion Diaria"
         HEIGHT             = 19.71
         WIDTH              = 107.4
         MAX-HEIGHT         = 19.71
         MAX-WIDTH          = 136
         VIRTUAL-HEIGHT     = 19.71
         VIRTUAL-WIDTH      = 136
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
/* BROWSE-TAB BROWSE-7 v-identificacion F-Main */
/* BROWSE-TAB BROWSE-9 BROWSE-7 F-Main */
ASSIGN 
       BROWSE-7:COLUMN-RESIZABLE IN FRAME F-Main       = TRUE
       BROWSE-7:COLUMN-MOVABLE IN FRAME F-Main         = TRUE.

ASSIGN 
       BROWSE-9:COLUMN-RESIZABLE IN FRAME F-Main       = TRUE
       BROWSE-9:COLUMN-MOVABLE IN FRAME F-Main         = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(W-Win)
THEN W-Win:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-7
/* Query rebuild information for BROWSE BROWSE-7
     _START_FREEFORM
DEF VAR t AS INT NO-UNDO.
DEFINE VAR sev AS INT NO-UNDO.
ASSIGN v-identificacion v-evento.
t = INT(entry(1,v-identificacion,"-")) NO-ERROR.
IF NUM-ENTRIES(v-identificacion,"-") = 2 THEN
  sev = int(entry(2,v-identificacion,"-")).
ELSE
  sev = 0.

    IF v-identificacion = "" THEN
        IF v-evento = "" THEN
            OPEN QUERY {&SELF-NAME} FOR EACH rvalor NO-LOCK , FIRST evento WHERE evento.nro_evento = rvalor.nro_evento  BY rvalor.fecha .
        ELSE
            OPEN QUERY {&SELF-NAME} FOR EACH rvalor  WHERE rvalor.nro_evento = int(v-evento) NO-LOCK, FIRST evento WHERE evento.nro_evento = rvalor.nro_evento BY rvalor.fecha .
    ELSE
            OPEN QUERY {&SELF-NAME} FOR EACH rvalor NO-LOCK, FIRST evento WHERE evento.nro_evento = rvalor.nro_evento AND evento.nro_identificacion = t AND (evento.sub_evento = sev OR sev = 0)BY rvalor.fecha .
  {&OPEN-QUERY-browse-9}
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE BROWSE-7 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-9
/* Query rebuild information for BROWSE BROWSE-9
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH Evento
      WHERE  rvalor.nro_evento = evento.nro_evento NO-LOCK,
      EACH Contrato_Restriccion WHERE Contrato_Restriccion.nro_contrato = evento.nro_identificacion AND contrato_restriccion.sub_evento = evento.sub_evento  NO-LOCK,
      EACH Restriccion OF Contrato_Restriccion NO-LOCK INDEXED-REPOSITION.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "of rvalor"
     _Query            is OPENED
*/  /* BROWSE BROWSE-9 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON END-ERROR OF W-Win /* Valorizacion Satisfaccion Diaria */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-CLOSE OF W-Win /* Valorizacion Satisfaccion Diaria */
DO:
    /* Modificado para que el control retorne a la window padre al cerrar una windows hija */
    DEFINE VARIABLE h_parent AS HANDLE      NO-UNDO.
    h_parent = THIS-PROCEDURE:CURRENT-WINDOW:PARENT.
    IF VALID-HANDLE(h_parent) THEN DO:
        CURRENT-WINDOW = h_parent.
        APPLY 'ENTRY' TO h_parent.
    END.
    APPLY "CLOSE":U TO THIS-PROCEDURE.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-7
&Scoped-define SELF-NAME BROWSE-7
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-7 W-Win
ON VALUE-CHANGED OF BROWSE-7 IN FRAME F-Main
DO:
  {&OPEN-QUERY-browse-9}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-8
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-8 W-Win
ON CHOOSE OF BUTTON-8 IN FRAME F-Main /* Button 8 */
DO:
  run excel-export (browse-7:handle).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-evento
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-evento W-Win
ON LEAVE OF v-evento IN FRAME F-Main /* Evento */
DO:
    ASSIGN v-evento.
  {&OPEN-QUERY-browse-7}
  {&OPEN-QUERY-browse-9}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-evento W-Win
ON RETURN OF v-evento IN FRAME F-Main /* Evento */
DO:
      ASSIGN v-identificacion.
  {&OPEN-QUERY-browse-7}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-identificacion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-identificacion W-Win
ON LEAVE OF v-identificacion IN FRAME F-Main /* Identificacion */
DO:
    ASSIGN v-identificacion.
  {&OPEN-QUERY-browse-7}
  {&OPEN-QUERY-browse-9}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-identificacion W-Win
ON return OF v-identificacion IN FRAME F-Main /* Identificacion */
DO:
      ASSIGN v-identificacion.
  {&OPEN-QUERY-browse-7}
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
  DISPLAY v-evento v-identificacion 
      WITH FRAME F-Main IN WINDOW W-Win.
  ENABLE BUTTON-8 v-evento v-identificacion BROWSE-7 BROWSE-9 
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

  /* Define variables needed by this internal procedure.               */
  {src/adm/template/snd-head.i}

  /* For each requested table, put it's ROWID in the output list.      */
  {src/adm/template/snd-list.i "Evento"}
  {src/adm/template/snd-list.i "Contrato_Restriccion"}
  {src/adm/template/snd-list.i "Restriccion"}
  {src/adm/template/snd-list.i "rvalor"}

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

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION tope W-Win 
FUNCTION tope RETURNS LOGICAL
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
    w-win:WINDOW-STATE = 3.
    w-win:MOVE-TO-TOP().
    RETURN TRUE.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

