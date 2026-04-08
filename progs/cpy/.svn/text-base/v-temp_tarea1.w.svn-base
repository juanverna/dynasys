&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS V-table-Win 
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

  Description: from VIEWER.W - Template for SmartViewer Objects

  Input Parameters:
      <none>

  Output Parameters:
      <none>

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

DEFINE VAR h_zoom AS HANDLE NO-UNDO.
{advtexto.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartViewer
&Scoped-define DB-AWARE no

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME sF-Main
&Scoped-define BROWSE-NAME BROWSE-7

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES Tarea
&Scoped-define FIRST-EXTERNAL-TABLE Tarea


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Tarea.
/* Definitions for FRAME sF-Main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Tarea.nro_evento Tarea.Origen ~
Tarea.nro_identificacion Tarea.Destino Tarea.nro_destino 
&Scoped-define ENABLED-TABLES Tarea
&Scoped-define FIRST-ENABLED-TABLE Tarea
&Scoped-Define ENABLED-OBJECTS BUTTON-12 BROWSE-7 
&Scoped-Define DISPLAYED-FIELDS Tarea.nro_evento Tarea.Origen ~
Tarea.nro_identificacion Tarea.Destino Tarea.nro_destino Tarea.estado 
&Scoped-define DISPLAYED-TABLES Tarea
&Scoped-define FIRST-DISPLAYED-TABLE Tarea
&Scoped-Define DISPLAYED-OBJECTS v-texto 

/* Custom List Definitions                                              */
/* ADM-CREATE-FIELDS,ADM-ASSIGN-FIELDS,List-3,List-4,List-5,List-6      */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _XFTR "Foreign Keys" V-table-Win _INLINE
/* Actions: ? adm/support/keyedit.w ? ? ? */
/* STRUCTURED-DATA
<KEY-OBJECT>
THIS-PROCEDURE
</KEY-OBJECT>
<FOREIGN-KEYS>
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = "",
     Keys-Supplied = ""':U).
/**************************
</EXECUTING-CODE> */   

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE BUTTON b-agrega 
     IMAGE-UP FILE "img/add.gif":U
     LABEL "Agrega" 
     SIZE 7 BY 3.57.

DEFINE BUTTON Bresuelto 
     LABEL "Resuelto" 
     SIZE 14 BY 1.14.

DEFINE BUTTON BUTTON-12 
     IMAGE-UP FILE "iconos24/zoom_in.jpg":U
     IMAGE-DOWN FILE "iconos24i/zoom_in.jpg":U
     LABEL "Button 12" 
     SIZE 6 BY 1.14.

DEFINE VARIABLE v-texto AS CHARACTER 
     VIEW-AS EDITOR SCROLLBAR-VERTICAL
     SIZE 140 BY 3.57
     BGCOLOR 15 FGCOLOR 9 .


/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-7
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-7 V-table-Win _STRUCTURED
  
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 148 BY 4.52 ROW-HEIGHT-CHARS .68.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME sF-Main
     BUTTON-12 AT ROW 1.14 COL 40 WIDGET-ID 28
     Bresuelto AT ROW 1.19 COL 51 WIDGET-ID 64
     Tarea.nro_evento AT ROW 1.24 COL 21 COLON-ALIGNED WIDGET-ID 26
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
     Tarea.Origen AT ROW 1.24 COL 74.4 COLON-ALIGNED WIDGET-ID 18
          VIEW-AS FILL-IN 
          SIZE 17 BY 1
     Tarea.nro_identificacion AT ROW 1.24 COL 93.8 COLON-ALIGNED WIDGET-ID 12
          LABEL "-"
          VIEW-AS FILL-IN 
          SIZE 13.6 BY 1
     Tarea.Destino AT ROW 1.24 COL 118 COLON-ALIGNED WIDGET-ID 16
          LABEL "Destino"
          VIEW-AS FILL-IN 
          SIZE 17 BY 1
     Tarea.nro_destino AT ROW 1.24 COL 136 COLON-ALIGNED WIDGET-ID 14
          LABEL "-"
          VIEW-AS FILL-IN 
          SIZE 13.6 BY 1
     BROWSE-7 AT ROW 2.67 COL 3 WIDGET-ID 200
     v-texto AT ROW 7.43 COL 3 NO-LABEL WIDGET-ID 2
     b-agrega AT ROW 7.43 COL 144 WIDGET-ID 22
     Tarea.estado AT ROW 1.43 COL 8.2 COLON-ALIGNED WIDGET-ID 24
           VIEW-AS TEXT 
          SIZE 4.2 BY .62
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE  WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Tarea
   Allow: Basic,DB-Fields
   Frames: 1
   Add Fields to: EXTERNAL-TABLES
   Other Settings: PERSISTENT-ONLY COMPILE
 */

/* This procedure should always be RUN PERSISTENT.  Report the error,  */
/* then cleanup and return.                                            */
IF NOT THIS-PROCEDURE:PERSISTENT THEN DO:
  MESSAGE "{&FILE-NAME} should only be RUN PERSISTENT.":U
          VIEW-AS ALERT-BOX ERROR BUTTONS OK.
  RETURN.
END.

&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
/* DESIGN Window definition (used by the UIB) 
  CREATE WINDOW V-table-Win ASSIGN
         HEIGHT             = 10.19
         WIDTH              = 150.8.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB V-table-Win 
/* ************************* Included-Libraries *********************** */

{src/adm/method/viewer.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW V-table-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME sF-Main
   NOT-VISIBLE FRAME-NAME Size-to-Fit                                   */
/* BROWSE-TAB BROWSE-7 nro_destino sF-Main */
ASSIGN 
       FRAME sF-Main:SCROLLABLE       = FALSE
       FRAME sF-Main:HIDDEN           = TRUE.

/* SETTINGS FOR BUTTON b-agrega IN FRAME sF-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON Bresuelto IN FRAME sF-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Tarea.Destino IN FRAME sF-Main
   EXP-LABEL                                                            */
ASSIGN 
       Tarea.Destino:READ-ONLY IN FRAME sF-Main        = TRUE.

/* SETTINGS FOR FILL-IN Tarea.estado IN FRAME sF-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Tarea.nro_destino IN FRAME sF-Main
   EXP-LABEL                                                            */
ASSIGN 
       Tarea.nro_destino:READ-ONLY IN FRAME sF-Main        = TRUE.

/* SETTINGS FOR FILL-IN Tarea.nro_identificacion IN FRAME sF-Main
   EXP-LABEL                                                            */
ASSIGN 
       Tarea.nro_identificacion:READ-ONLY IN FRAME sF-Main        = TRUE.

ASSIGN 
       Tarea.Origen:READ-ONLY IN FRAME sF-Main        = TRUE.

/* SETTINGS FOR EDITOR v-texto IN FRAME sF-Main
   NO-ENABLE                                                            */
ASSIGN 
       v-texto:RETURN-INSERTED IN FRAME sF-Main  = TRUE
       v-texto:READ-ONLY IN FRAME sF-Main        = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-7
/* Query rebuild information for BROWSE BROWSE-7
     _Query            is NOT OPENED
*/  /* BROWSE BROWSE-7 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME sF-Main
/* Query rebuild information for FRAME sF-Main
     _Options          = "NO-LOCK"
     _Query            is NOT OPENED
*/  /* FRAME sF-Main */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME b-agrega
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b-agrega V-table-Win
ON CHOOSE OF b-agrega IN FRAME sF-Main /* Agrega */
DO:
  v-texto = "".
  v-texto:READ-ONLY = FALSE.
  b-agrega:SENSITIVE = FALSE.
  DISPLAY v-texto WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bresuelto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bresuelto V-table-Win
ON CHOOSE OF Bresuelto IN FRAME sF-Main /* Resuelto */
DO:
  RUN d-tarearesol.w (INPUT tarea.nro_tarea).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-7
&Scoped-define SELF-NAME BROWSE-7
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-7 V-table-Win
ON VALUE-CHANGED OF BROWSE-7 IN FRAME sF-Main
DO:
    IF AVAILABLE tttexto THEN v-texto = tttexto.ttexto.
    DISPLAY v-texto WITH FRAME {&FRAME-NAME}. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-12
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-12 V-table-Win
ON CHOOSE OF BUTTON-12 IN FRAME sF-Main /* Button 12 */
DO:
  RUN d-zoom-evento.w(tarea.nro_evento,"ZOOM").
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK V-table-Win 


/* ***************************  Main Block  *************************** */

  &IF DEFINED(UIB_IS_RUNNING) <> 0 &THEN          
    RUN dispatch IN THIS-PROCEDURE ('initialize':U).        
  &ENDIF         
  
  /************************ INTERNAL PROCEDURES ********************/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available V-table-Win  _ADM-ROW-AVAILABLE
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

  /* Create a list of all the tables that we need to get.            */
  {src/adm/template/row-list.i "Tarea"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Tarea"}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ass V-table-Win 
PROCEDURE ass :
/* /*------------------------------------------------------------------------------         */
/*   Purpose:     Override standard ADM method                                              */
/*   Notes:                                                                                 */
/* ------------------------------------------------------------------------------*/         */
/* DEFINE VAR k AS INT NO-UNDO.                                                             */
/* DEFINE VARIABLE hWidget AS HANDLE     NO-UNDO.                                           */
/* DEFINE VARIABLE hField  AS HANDLE     NO-UNDO.                                           */
/*                                                                                          */
/* RUN dispatch IN THIS-PROCEDURE ( INPUT 'display-fields':U ) .                            */
/*                                                                                          */
/*   hWidget = phFrame:CURRENT-ITERATION:FIRST-CHILD.                                       */
/*   DO WHILE VALID-HANDLE(hWidget):                                                        */
/*     k = lookup(hWidget:NAME ,tareas.datos-template, chr(1)).                             */
/*     IF  k<> 0                                                                            */
/*       AND CAN-QUERY(hWidget, 'SCREEN-VALUE':U) THEN                                      */
/*     DO:                                                                                  */
/*       hField = phBuffer:BUFFER-FIELD(hWidget:NAME).                                      */
/*       IF VALID-HANDLE(hField) THEN                                                       */
/*       DO:                                                                                */
/*         IF hWidget:TYPE = 'COMBO-BOX'                                                    */
/*           AND hWidget:SCREEN-VALUE = ENTRY(2,ENTRY(k , tareas.datos-template , CHR(1) )) */
/*           AND hWidget:LOOKUP('') > 0 THEN                                                */
/*           hField:BUFFER-VALUE = ''.                                                      */
/*         ELSE IF CAN-QUERY(hWidget, 'INPUT-VALUE':U) THEN                                 */
/*           hField:BUFFER-VALUE = hWidget:INPUT-VALUE.                                     */
/*         ELSE IF CAN-QUERY(hWidget, 'CHECKED':U) THEN                                     */
/*           hField:BUFFER-VALUE = hWidget:CHECKED.                                         */
/*         ELSE IF CAN-QUERY(hWidget, 'SCREEN-VALUE') THEN                                  */
/*           hField:BUFFER-VALUE = hWidget:SCREEN-VALUE.                                    */
/*       END.                                                                               */
/*     END.                                                                                 */
/*     hWidget = hWidget:NEXT-SIBLING.                                                      */
/*   END.                                                                                   */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI V-table-Win  _DEFAULT-DISABLE
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
  HIDE FRAME sF-Main.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-add-record V-table-Win 
PROCEDURE local-add-record :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */
  RUN loadAdvTexto ("",BROWSE BROWSE-7:HANDLE,OUTPUT TABLE tttexto,OUTPUT v-texto).
  DISPLAY v-texto WITH FRAME {&FRAME-NAME}.
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'add-record':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-assign-statement V-table-Win 
PROCEDURE local-assign-statement :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR k AS INT NO-UNDO.
DEFINE VARIABLE hWidget AS HANDLE     NO-UNDO.
DEFINE VARIABLE hField  AS HANDLE     NO-UNDO.
DEFINE VAR phframe AS HANDLE NO-UNDO.
DEFINE VAR sal AS CHAR NO-UNDO.
DEFINE VAR dformat AS CHAR NO-UNDO.

RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

phframe = FRAME {&FRAME-NAME}:HANDLE.
hWidget = phFrame:CURRENT-ITERATION:FIRST-CHILD.

  DO WHILE VALID-HANDLE(hWidget):
    k = lookup(hWidget:NAME ,Tarea.datos-template, "|").
    IF  k > 0 AND CAN-QUERY( hWidget, 'SCREEN-VALUE' ) THEN
    DO:
        IF hWidget:TYPE = 'COMBO-BOX'  THEN
          sal = sal + "|" + hWidget:NAME + "|" + hWidget:SCREEN-VALUE.
        ELSE IF CAN-QUERY( hWidget, 'INPUT-VALUE':U ) THEN
          sal = sal + "|" +  hWidget:NAME + "|" + hWidget:SCREEN-VALUE.
        ELSE IF CAN-QUERY( hWidget, 'CHECKED':U ) THEN
          sal = sal + "|" +  hWidget:NAME + "|" +  IF hWidget:CHECKED THEN "yes" ELSE "no".
        ELSE IF CAN-QUERY( hWidget, 'SCREEN-VALUE' ) THEN
          sal = sal + "|" +  hWidget:NAME + "|" + hWidget:SCREEN-VALUE.
    END.
    hWidget = hWidget:NEXT-SIBLING.
  END.
  Tarea.datos-template = substring(sal,2).
  tarea.descripcion = saveAdvTexto(v-texto:INPUT-VALUE,TABLE tttexto).
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-destroy V-table-Win 
PROCEDURE local-destroy :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'destroy':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-disable-fields V-table-Win 
PROCEDURE local-disable-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR k AS INT NO-UNDO.
DEFINE VARIABLE hWidget AS HANDLE     NO-UNDO.
DEFINE VARIABLE hField  AS HANDLE     NO-UNDO.
DEFINE VAR phframe AS HANDLE NO-UNDO.

  RUN dispatch IN THIS-PROCEDURE ( INPUT 'disable-fields':U ) .

phframe = FRAME {&FRAME-NAME}:HANDLE.
hWidget = phFrame:CURRENT-ITERATION:FIRST-CHILD.

  DO WHILE VALID-HANDLE(hWidget):
    IF  CAN-QUERY( hWidget, 'SCREEN-VALUE' ) THEN
        hWidget:SENSITIVE = FALSE.
    hWidget = hWidget:NEXT-SIBLING.
  END.
  v-texto:READ-ONLY = TRUE.
  b-agrega:SENSITIVE = FALSE.

  END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-display-fields V-table-Win 
PROCEDURE local-display-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR k AS INT NO-UNDO.
DEFINE VARIABLE hWidget AS HANDLE     NO-UNDO.
DEFINE VARIABLE hField  AS HANDLE     NO-UNDO.
DEFINE VAR phframe AS HANDLE NO-UNDO.

RUN dispatch IN THIS-PROCEDURE ( INPUT 'display-fields':U ) .

phframe = FRAME {&FRAME-NAME}:HANDLE.
hWidget = phFrame:CURRENT-ITERATION:FIRST-CHILD.
IF AVAILABLE tarea THEN DO:
  DO WHILE VALID-HANDLE(hWidget):
    k = lookup(hWidget:NAME ,Tarea.datos-template, "|").
    IF  k > 0 AND CAN-QUERY( hWidget, 'SCREEN-VALUE' ) THEN
    DO:
        IF hWidget:TYPE = 'COMBO-BOX'  THEN
          hWidget:SCREEN-VALUE = ENTRY( k + 1 , tarea.datos-template , "|" ).
        ELSE IF CAN-QUERY( hWidget, 'INPUT-VALUE':U ) THEN
          hWidget:SCREEN-VALUE = ENTRY( k + 1  , tarea.datos-template  , "|" ).
        ELSE IF CAN-QUERY( hWidget, 'CHECKED':U ) THEN
          hWidget:CHECKED = LOGICAL(ENTRY( k + 1 , tarea.datos-template , "|" ) ).
        ELSE IF CAN-QUERY( hWidget, 'SCREEN-VALUE' ) THEN
          hWidget:SCREEN-VALUE = ENTRY( k + 1 , tarea.datos-template , "|" ).
    END.
    hWidget = hWidget:NEXT-SIBLING.
    bresuelto:SENSITIVE = tarea.fecha_resuelto <> ?. 
  END.
  RUN loadAdvTexto ( IF AVAILABLE tarea THEN tarea.descripcion ELSE "" ,BROWSE BROWSE-7:HANDLE,OUTPUT TABLE tttexto,OUTPUT v-texto).
  DISPLAY v-texto WITH FRAME {&FRAME-NAME}.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-enable-fields V-table-Win 
PROCEDURE local-enable-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR k AS INT NO-UNDO.
DEFINE VARIABLE hWidget AS HANDLE     NO-UNDO.
DEFINE VARIABLE hField  AS HANDLE     NO-UNDO.
DEFINE VAR phframe AS HANDLE NO-UNDO.

  RUN dispatch IN THIS-PROCEDURE ( INPUT 'enable-fields':U ) .

phframe = FRAME {&FRAME-NAME}:HANDLE.
hWidget = phFrame:CURRENT-ITERATION:FIRST-CHILD.

  DO WHILE VALID-HANDLE(hWidget):
    IF  CAN-QUERY( hWidget, 'SCREEN-VALUE' ) THEN
        hWidget:SENSITIVE = TRUE.
    hWidget = hWidget:NEXT-SIBLING.
  END.
  b-agrega:SENSITIVE = TRUE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records V-table-Win  _ADM-SEND-RECORDS
PROCEDURE send-records :
/*------------------------------------------------------------------------------
  Purpose:     Send record ROWID's for all tables used by
               this file.
  Parameters:  see template/snd-head.i
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.               */
  {src/adm/template/snd-head.i}

  /* For each requested table, put it's ROWID in the output list.      */
  {src/adm/template/snd-list.i "Tarea"}

  /* Deal with any unexpected table requests before closing.           */
  {src/adm/template/snd-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE state-changed V-table-Win 
PROCEDURE state-changed :
/* -----------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-------------------------------------------------------------*/
  DEFINE INPUT PARAMETER p-issuer-hdl AS HANDLE    NO-UNDO.
  DEFINE INPUT PARAMETER p-state      AS CHARACTER NO-UNDO.

  CASE p-state:
      /* Object instance CASEs can go here to replace standard behavior
         or add new cases. */
      {src/adm/template/vstates.i}
  END CASE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

