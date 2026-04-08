&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS B-table-Win 
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

  Description: from BROWSER.W - Basic SmartBrowser Object Template

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
DEFINE var p-asig AS LOGICAL NO-UNDO.
DEFINE var p-real AS LOGICAL NO-UNDO.
DEFINE var p-origen AS CHAR NO-UNDO.
DEFINE var p-nro_tipo_evento AS int NO-UNDO.
DEFINE var p-mes AS int NO-UNDO.
DEFINE var p-ano AS int NO-UNDO.
DEFINE VAR p-plan AS INT NO-UNDO.
DEFINE VAR p-maxfmax AS DATE NO-UNDO.
DEFINE BUFFER bevento FOR evento.
DEFINE VAR p-nro_cliente LIKE cliente.nro_cliente NO-UNDO.
DEFINE VAR stavisado AS CHAR NO-UNDO.
{stavisado.i}
DEFINE VAR asignado AS LOGICAL NO-UNDO.
DEFINE VAR realizado AS LOGICAL NO-UNDO.
DEFINE VAR padre AS CHAR FORMAT ">>>>>>>9":U NO-UNDO.
{restricciones.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartBrowser
&Scoped-define DB-AWARE no

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME F-Main
&Scoped-define BROWSE-NAME br_table

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Evento cliente tipo_evento

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table tipo_evento.cdg_tipo_evento Evento.nro_evento ( IF Evento.nro_evento_padre = 0 THEN Evento.nro_evento ELSE Evento.nro_evento_padre ) @ padre Evento.fAsignado <> ? @ asignado Evento.Anulado Evento.Evaluar stavisado(evento.nro_evento) @ stavisado Evento.Bloqueado Evento.fRealizado <> ? @ realizado Evento.Origen Evento.nro_identificacion Evento.sub_evento Evento.Recursos Evento.Duracion evento.turno evento.RefEvento Evento.FAsignado Evento.FMin Evento.FMax Evento.Mobs evento.frealizado evento.fcreado cliente.direccion perant(evento.nro_evento) @ perant comprest(evento.nro_evento) @ comprest evento.leyenda cliente.nom_cliente evento.observaciones   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table   
&Scoped-define SELF-NAME br_table
&Scoped-define OPEN-QUERY-br_table DEFINE VAR pridia AS DATE NO-UNDO. DEFINE VAR ultdia AS DATE NO-UNDO. define var vasig as logical no-undo.   ASSIGN FRAME {&FRAME-NAME} v-plan v-cdg_cliente v-identificacion v-evento.  IF v-plan = 0 THEN DO:     IF p-mes = 0 OR p-ano = 0  THEN             OPEN QUERY {&SELF-NAME} FOR EACH Evento NO-LOCK WHERE ~{&KEY-PHRASE}               AND NOT evento.anulado               AND ( p-origen = "" OR evento.origen = p-origen )               AND ( p-nro_tipo_evento = 0 OR p-nro_tipo_evento = evento.nro_tipo_evento )               AND ( p-asig = ? OR p-asig = ( evento.fasignado <> ? ))               AND ( p-real = ? OR p-real = ( evento.frealizado <> ? ))               AND ( v-cdg_cliente = "" OR evento.nro_cliente = p-nro_cliente )               AND ( v-identificacion = "" or int(v-identificacion) = evento.nro_identificacion )               AND ( evento.fasignado <= p-maxfmax OR p-maxfmax = ?)             , ~
       FIRST cliente NO-LOCK WHERE cliente.nro_cliente = evento.nro_cliente             , ~
       FIRST tipo_evento NO-LOCK WHERE tipo_evento.nro_tipo_evento = evento.nro_tipo_evento            BY tipo_evento.cdg_tipo_evento BY evento.fasignado DESC BY evento.fmin DESC.         ELSE DO:             pridia = DATE( p-mes , ~
       1 , ~
       p-ano).             ultdia = pridia + 32.             ultdia = DATE( MONTH(ultdia) , ~
       1 , ~
       YEAR(ultdia) ) - 1 .             IF v-evento = "" THEN               OPEN QUERY {&SELF-NAME} FOR EACH Evento NO-LOCK WHERE ~{&KEY-PHRASE}                   AND NOT evento.anulado                   AND ( p-origen = "" OR evento.origen = p-origen )                   AND ( v-cdg_cliente = "" OR evento.nro_cliente = p-nro_cliente )                   AND ( p-nro_tipo_evento = 0 OR p-nro_tipo_evento = evento.nro_tipo_evento )                   AND ( p-asig = ? OR p-asig = ( evento.fasignado <> ? ))                   AND ( p-real = ? OR p-real = ( evento.frealizado <> ? ))                   AND ( evento.fmax >= pridia AND evento.fmin <= ultdia )                   AND ( v-identificacion = "" or int(v-identificacion) = evento.nro_identificacion )                  , ~
       FIRST cliente NO-LOCK WHERE cliente.nro_cliente = evento.nro_cliente                  , ~
       FIRST tipo_evento NO-LOCK WHERE tipo_evento.nro_tipo_evento = evento.nro_tipo_evento                 BY tipo_evento.cdg_tipo_evento  BY evento.fasignado DESC BY evento.fmin DESC.             ELSE               OPEN QUERY {&SELF-NAME} FOR EACH Evento NO-LOCK WHERE ~{&KEY-PHRASE}                   AND NOT evento.anulado                   AND evento.nro_evento = int(v-evento)                   , ~
       FIRST cliente NO-LOCK WHERE cliente.nro_cliente = evento.nro_cliente                    , ~
       FIRST tipo_evento NO-LOCK WHERE tipo_evento.nro_tipo_evento = evento.nro_tipo_evento                 BY tipo_evento.cdg_tipo_evento BY evento.fasignado DESC BY evento.fmin DESC.     END.               END. ELSE     OPEN QUERY {&SELF-NAME} FOR EACH Evento NO-LOCK WHERE evento.nro_planasig = v-plan                   AND NOT evento.anulado                   , ~
       FIRST cliente NO-LOCK WHERE cliente.nro_cliente = evento.nro_cliente                    , ~
       FIRST tipo_evento NO-LOCK WHERE tipo_evento.nro_tipo_evento = evento.nro_tipo_evento                 BY tipo_evento.cdg_tipo_evento  BY evento.fasignado DESC BY evento.fmin DESC.
&Scoped-define TABLES-IN-QUERY-br_table Evento cliente tipo_evento
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Evento
&Scoped-define SECOND-TABLE-IN-QUERY-br_table cliente
&Scoped-define THIRD-TABLE-IN-QUERY-br_table tipo_evento


/* Definitions for FRAME F-Main                                         */
&Scoped-define OPEN-BROWSERS-IN-QUERY-F-Main ~
    ~{&OPEN-QUERY-br_table}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS v-plan BUTTON-8 v-cdg_cliente ~
v-identificacion v-evento br_table 
&Scoped-Define DISPLAYED-OBJECTS v-plan v-cdg_cliente v-identificacion ~
v-evento 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _XFTR "Foreign Keys" B-table-Win _INLINE
/* Actions: ? adm/support/keyedit.w ? ? ? */
/* STRUCTURED-DATA
<KEY-OBJECT>
&BROWSE-NAME
</KEY-OBJECT>
<FOREIGN-KEYS>
nro_evento||y|sic.Evento.nro_evento
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = ,
     Keys-Supplied = "nro_evento"':U).

/* Tell the ADM to use the OPEN-QUERY-CASES. */
&Scoped-define OPEN-QUERY-CASES RUN dispatch ('open-query-cases':U).
/**************************
</EXECUTING-CODE> */
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _XFTR "Advanced Query Options" B-table-Win _INLINE
/* Actions: ? adm/support/advqedit.w ? ? ? */
/* STRUCTURED-DATA
<KEY-OBJECT>
&BROWSE-NAME
</KEY-OBJECT>
<SORTBY-OPTIONS>
</SORTBY-OPTIONS>
<SORTBY-RUN-CODE>
************************
* Set attributes related to SORTBY-OPTIONS */
RUN set-attribute-list (
    'SortBy-Options = ""':U).
/************************
</SORTBY-RUN-CODE>
<FILTER-ATTRIBUTES>
</FILTER-ATTRIBUTES> */   

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE BUTTON BUTTON-8 
     IMAGE-UP FILE "img/excel.gif":U
     LABEL "Button 8" 
     SIZE 15 BY 1.14.

DEFINE VARIABLE v-cdg_cliente AS CHARACTER FORMAT "X(256)":U 
     LABEL "Cliente" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 14  NO-UNDO.

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

DEFINE VARIABLE v-plan AS INTEGER FORMAT ">>>>>9":U INITIAL 0 
     LABEL "Plan" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 14  NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Evento, 
      cliente, 
      tipo_evento SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _FREEFORM
  QUERY br_table NO-LOCK DISPLAY
      tipo_evento.cdg_tipo_evento 
      Evento.nro_evento FORMAT ">>>>>>>9":U
      ( IF Evento.nro_evento_padre = 0 THEN Evento.nro_evento ELSE Evento.nro_evento_padre ) @ padre  WIDTH 10.8
      Evento.fAsignado <> ? @ asignado COLUMN-LABEL "AS" FORMAT "S/N":U WIDTH 3
      Evento.Anulado COLUMN-LABEL "AN" FORMAT "S/N":U
      Evento.Evaluar COLUMN-LABEL "EV" FORMAT "S/N":U WIDTH 3
      stavisado(evento.nro_evento) @ stavisado COLUMN-LABEL "AV" FORMAT "X":U WIDTH 3
      Evento.Bloqueado COLUMN-LABEL "BK" FORMAT "S/N":U WIDTH 3
      Evento.fRealizado <> ? @ realizado COLUMN-LABEL "RE" FORMAT "S/N":U WIDTH 3
      Evento.Origen FORMAT "X(12)"
      Evento.nro_identificacion FORMAT ">>>>>>>9":U
      Evento.sub_evento column-label "SE" format ">9":U
      Evento.Recursos FORMAT "X(20)":U
      Evento.Duracion FORMAT ">,>>9":U
      evento.turno COLUMN-LABEL "TU" FORMAT "X(4)":U
      evento.RefEvento COLUMN-LABEL "RefEvento":U
      Evento.FAsignado FORMAT "99/99/9999":U
      Evento.FMin FORMAT "99/99/9999":U
      Evento.FMax FORMAT "99/99/9999":U
      Evento.Mobs FORMAT "x(30)":U
      evento.frealizado FORMAT "99/99/9999":U
      evento.fcreado FORMAT "99/99/9999":U
      cliente.direccion
      perant(evento.nro_evento) @ perant 
      comprest(evento.nro_evento) @ comprest
      evento.leyenda FORMAT "X(150)"
      cliente.nom_cliente
      evento.observaciones FORMAT "X(5000)" WIDTH 650
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 128 BY 6.91 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     v-plan AT ROW 1.24 COL 89 COLON-ALIGNED WIDGET-ID 12
     BUTTON-8 AT ROW 1.24 COL 113 WIDGET-ID 6
     v-cdg_cliente AT ROW 1.33 COL 7.2 COLON-ALIGNED WIDGET-ID 10
     v-identificacion AT ROW 1.33 COL 36.8 COLON-ALIGNED WIDGET-ID 4
     v-evento AT ROW 1.33 COL 63.4 COLON-ALIGNED WIDGET-ID 8
     br_table AT ROW 2.67 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE  WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartBrowser
   Allow: Basic,Browse
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
  CREATE WINDOW B-table-Win ASSIGN
         HEIGHT             = 8.71
         WIDTH              = 129.4.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB B-table-Win 
/* ************************* Included-Libraries *********************** */

{src/adm/method/browser.i}
{excel-export.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW B-table-Win
  NOT-VISIBLE,,RUN-PERSISTENT                                           */
/* SETTINGS FOR FRAME F-Main
   NOT-VISIBLE FRAME-NAME Size-to-Fit                                   */
/* BROWSE-TAB br_table v-evento F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

ASSIGN 
       br_table:MAX-DATA-GUESS IN FRAME F-Main         = 2000
       br_table:COLUMN-RESIZABLE IN FRAME F-Main       = TRUE
       br_table:COLUMN-MOVABLE IN FRAME F-Main         = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _START_FREEFORM
DEFINE VAR pridia AS DATE NO-UNDO.
DEFINE VAR ultdia AS DATE NO-UNDO.
define var vasig as logical no-undo.


ASSIGN FRAME {&FRAME-NAME} v-plan v-cdg_cliente v-identificacion v-evento.

IF v-plan = 0 THEN DO:
    IF p-mes = 0 OR p-ano = 0  THEN
            OPEN QUERY {&SELF-NAME} FOR EACH Evento NO-LOCK WHERE ~{&KEY-PHRASE}
              AND NOT evento.anulado
              AND ( p-origen = "" OR evento.origen = p-origen )
              AND ( p-nro_tipo_evento = 0 OR p-nro_tipo_evento = evento.nro_tipo_evento )
              AND ( p-asig = ? OR p-asig = ( evento.fasignado <> ? ))
              AND ( p-real = ? OR p-real = ( evento.frealizado <> ? ))
              AND ( v-cdg_cliente = "" OR evento.nro_cliente = p-nro_cliente )
              AND ( v-identificacion = "" or int(v-identificacion) = evento.nro_identificacion )
              AND ( evento.fasignado <= p-maxfmax OR p-maxfmax = ?)
            , FIRST cliente NO-LOCK WHERE cliente.nro_cliente = evento.nro_cliente
            , FIRST tipo_evento NO-LOCK WHERE tipo_evento.nro_tipo_evento = evento.nro_tipo_evento
           BY tipo_evento.cdg_tipo_evento BY evento.fasignado DESC BY evento.fmin DESC.
        ELSE DO:
            pridia = DATE( p-mes , 1 , p-ano).
            ultdia = pridia + 32.
            ultdia = DATE( MONTH(ultdia) , 1 , YEAR(ultdia) ) - 1 .
            IF v-evento = "" THEN
              OPEN QUERY {&SELF-NAME} FOR EACH Evento NO-LOCK WHERE ~{&KEY-PHRASE}
                  AND NOT evento.anulado
                  AND ( p-origen = "" OR evento.origen = p-origen )
                  AND ( v-cdg_cliente = "" OR evento.nro_cliente = p-nro_cliente )
                  AND ( p-nro_tipo_evento = 0 OR p-nro_tipo_evento = evento.nro_tipo_evento )
                  AND ( p-asig = ? OR p-asig = ( evento.fasignado <> ? ))
                  AND ( p-real = ? OR p-real = ( evento.frealizado <> ? ))
                  AND ( evento.fmax >= pridia AND evento.fmin <= ultdia )
                  AND ( v-identificacion = "" or int(v-identificacion) = evento.nro_identificacion )
                 , FIRST cliente NO-LOCK WHERE cliente.nro_cliente = evento.nro_cliente
                 , FIRST tipo_evento NO-LOCK WHERE tipo_evento.nro_tipo_evento = evento.nro_tipo_evento
                BY tipo_evento.cdg_tipo_evento  BY evento.fasignado DESC BY evento.fmin DESC.
            ELSE
              OPEN QUERY {&SELF-NAME} FOR EACH Evento NO-LOCK WHERE ~{&KEY-PHRASE}
                  AND NOT evento.anulado
                  AND evento.nro_evento = int(v-evento)
                  , FIRST cliente NO-LOCK WHERE cliente.nro_cliente = evento.nro_cliente
                   , FIRST tipo_evento NO-LOCK WHERE tipo_evento.nro_tipo_evento = evento.nro_tipo_evento
                BY tipo_evento.cdg_tipo_evento BY evento.fasignado DESC BY evento.fmin DESC.
    END.
              END.
ELSE
    OPEN QUERY {&SELF-NAME} FOR EACH Evento NO-LOCK WHERE evento.nro_planasig = v-plan
                  AND NOT evento.anulado
                  , FIRST cliente NO-LOCK WHERE cliente.nro_cliente = evento.nro_cliente
                   , FIRST tipo_evento NO-LOCK WHERE tipo_evento.nro_tipo_evento = evento.nro_tipo_evento
                BY tipo_evento.cdg_tipo_evento  BY evento.fasignado DESC BY evento.fmin DESC.
     _END_FREEFORM
     _Options          = "NO-LOCK KEY-PHRASE SORTBY-PHRASE"
     _Where[1]         = "v-identificacion = """" or int(v-identificacion) = evento.nro_identificacion"
     _Query            is OPENED
*/  /* BROWSE br_table */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME F-Main
/* Query rebuild information for FRAME F-Main
     _Options          = "NO-LOCK"
     _Query            is NOT OPENED
*/  /* FRAME F-Main */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define BROWSE-NAME br_table
&Scoped-define SELF-NAME br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-ENTRY OF br_table IN FRAME F-Main
DO:
  /* This code displays initial values for newly added or copied rows. */
  {src/adm/template/brsentry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-LEAVE OF br_table IN FRAME F-Main
DO:
    /* Do not disable this code or no updates will take place except
     by pressing the Save button on an Update SmartPanel. */
   {src/adm/template/brsleave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON VALUE-CHANGED OF br_table IN FRAME F-Main
DO:
  /* This ADM trigger code must be preserved in order to notify other
     objects when the browser's current row changes. */
  {src/adm/template/brschnge.i}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-8
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-8 B-table-Win
ON CHOOSE OF BUTTON-8 IN FRAME F-Main /* Button 8 */
DO:
  run excel-export ({&BROWSE-NAME}:handle).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_cliente
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_cliente B-table-Win
ON LEAVE OF v-cdg_cliente IN FRAME F-Main /* Cliente */
DO:
    ASSIGN v-cdg_cliente.
    IF v-cdg_cliente <> "" THEN DO:
        FIND cliente WHERE cliente.cdg_cliente = v-cdg_cliente NO-ERROR.
        IF NOT AVAILABLE cliente THEN DO:
            MESSAGE "Cliente desconocido, Reintente" VIEW-AS ALERT-BOX ERROR.
            RETURN NO-APPLY.
        END.
        p-nro_cliente = cliente.nro_cliente.
        RUN dispatch IN THIS-PROCEDURE ('open-query':U).
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_cliente B-table-Win
ON MOUSE-MENU-DOWN OF v-cdg_cliente IN FRAME F-Main /* Cliente */
DO:

  &SCOPED-DEFINE ROWID_TABLA        rid_cliente
  &SCOPED-DEFINE SELECCION          SELCLIEN.P
  &SCOPED-DEFINE TABLA              Cliente
  &SCOPED-DEFINE CDG_TABLA          cdg_cliente
  &SCOPED-DEFINE DSC_TABLA          nom_cliente
  &SCOPED-DEFINE V-CDG_TABLA        v-cdg_cliente    
  &SCOPED-DEFINE MOSTRAR_DSC        NO

  {hlptabla-var.i}      

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_cliente B-table-Win
ON return OF v-cdg_cliente IN FRAME F-Main /* Cliente */
DO:
    ASSIGN v-cdg_cliente.
    IF v-cdg_cliente <> "" THEN DO:
        FIND cliente WHERE cliente.cdg_cliente = v-cdg_cliente NO-ERROR.
        IF NOT AVAILABLE cliente THEN DO:
            MESSAGE "Cliente desconocido, Reintente" VIEW-AS ALERT-BOX ERROR.
            RETURN NO-APPLY.
        END.
        p-nro_cliente = cliente.nro_cliente.
        RUN dispatch IN THIS-PROCEDURE ('open-query':U).
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-evento
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-evento B-table-Win
ON LEAVE OF v-evento IN FRAME F-Main /* Evento */
DO:
    ASSIGN v-evento.
RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-evento B-table-Win
ON RETURN OF v-evento IN FRAME F-Main /* Evento */
DO:
    ASSIGN v-evento.
RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-identificacion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-identificacion B-table-Win
ON LEAVE OF v-identificacion IN FRAME F-Main /* Identificacion */
DO:
    ASSIGN v-identificacion.
 RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-identificacion B-table-Win
ON return OF v-identificacion IN FRAME F-Main /* Identificacion */
DO:
      ASSIGN v-identificacion.
 RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-plan
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-plan B-table-Win
ON LEAVE OF v-plan IN FRAME F-Main /* Plan */
DO:
    ASSIGN v-plan.
RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-plan B-table-Win
ON RETURN OF v-plan IN FRAME F-Main /* Plan */
DO:
    ASSIGN v-evento.
RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK B-table-Win 


/* ***************************  Main Block  *************************** */

&IF DEFINED(UIB_IS_RUNNING) <> 0 &THEN          
RUN dispatch IN THIS-PROCEDURE ('initialize':U).        
&ENDIF

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-open-query-cases B-table-Win  adm/support/_adm-opn.p
PROCEDURE adm-open-query-cases :
/*------------------------------------------------------------------------------
  Purpose:     Opens different cases of the query based on attributes
               such as the 'Key-Name', or 'SortBy-Case'
  Parameters:  <none>
------------------------------------------------------------------------------*/

  /* No Foreign keys are accepted by this SmartObject. */

  {&OPEN-QUERY-{&BROWSE-NAME}}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available B-table-Win  _ADM-ROW-AVAILABLE
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI B-table-Win  _DEFAULT-DISABLE
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
  HIDE FRAME F-Main.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-open-query B-table-Win 
PROCEDURE local-open-query :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR hp AS HANDLE NO-UNDO.
DEF VAR hcp AS CHAR NO-UNDO.

  /* Code placed here will execute PRIOR to standard behavior. */

RUN get-link-handle IN adm-broker-hdl
      ( INPUT THIS-PROCEDURE,
        INPUT "state-source",
        OUTPUT hcp ).
    hp = WIDGET-HANDLE(hcp).

    IF VALID-HANDLE(hp) THEN 
        RUN que_datos IN hp ( OUTPUT p-asig , OUTPUT p-real ,OUTPUT p-origen , OUTPUT p-nro_tipo_evento , OUTPUT p-mes , OUTPUT p-ano , OUTPUT p-plan ,OUTPUT p-maxfmax) .
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'open-query':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-key B-table-Win  adm/support/_key-snd.p
PROCEDURE send-key :
/*------------------------------------------------------------------------------
  Purpose:     Sends a requested KEY value back to the calling
               SmartObject.
  Parameters:  <see adm/template/sndkytop.i>
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.             */
  {src/adm/template/sndkytop.i}

  /* Return the key value associated with each key case.             */
  {src/adm/template/sndkycas.i "nro_evento" "Evento" "nro_evento"}

  /* Close the CASE statement and end the procedure.                 */
  {src/adm/template/sndkyend.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records B-table-Win  _ADM-SEND-RECORDS
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
  {src/adm/template/snd-list.i "cliente"}
  {src/adm/template/snd-list.i "tipo_evento"}

  /* Deal with any unexpected table requests before closing.           */
  {src/adm/template/snd-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE state-changed B-table-Win 
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
      {src/adm/template/bstates.i}
  END CASE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

