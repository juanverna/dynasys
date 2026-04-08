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
DEFINE VAR asignado AS LOGICAL NO-UNDO.
DEFINE VAR realizado AS LOGICAL NO-UNDO.
DEFINE VAR h_agenda_recurso AS HANDLE NO-UNDO.
DEFINE VAR nro_aviso_tipo_evento LIKE tipo_evento.nro_tipo_evento NO-UNDO.
DEFINE VAR nro_cobranza_tipo_evento LIKE tipo_evento.nro_tipo_evento NO-UNDO.
DEFINE VAR c_nro_tipo_evento AS INT NO-UNDO.

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
&Scoped-define INTERNAL-TABLES recurso_agenda Evento Cliente Tipo_evento

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Tipo_evento.cdg_tipo_evento recurso_agenda.cdg_recurso Evento.nro_evento Evento.nro_evento_padre Evento.Origen Evento.nro_identificacion Evento.Duracion Evento.FMin Evento.FMax Evento.Periodo   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table   
&Scoped-define SELF-NAME br_table
&Scoped-define OPEN-QUERY-br_table IF NOT tpendiente THEN    OPEN QUERY {&SELF-NAME} FOR EACH recurso_agenda       WHERE recurso_agenda.fecha = f_asignado and can-do(p_recursos, ~
      recurso_agenda.cdg_recurso) NO-LOCK, ~
             EACH Evento WHERE recurso_agenda.fecha = f_asignado and recurso_agenda.cdg_recurso = p_recursos       AND evento.frealizado = ? and ( evento.nro_tipo_evento = c_nro_tipo_evento or c_nro_tipo_evento = 0 ) and       nro_cobranza_tipo_evento <> evento.nro_tipo_evento AND NOT evento.anulado NO-LOCK, ~
             EACH Cliente OF Evento NO-LOCK, ~
             EACH Tipo_evento OF Evento NO-LOCK. ELSE    OPEN QUERY {&SELF-NAME} FOR EACH recurso_agenda       WHERE recurso_agenda.fecha = f_asignado NO-LOCK, ~
             EACH Evento WHERE recurso_agenda.fecha = f_asignado       AND evento.frealizado = ? and ( evento.nro_tipo_evento = c_nro_tipo_evento or c_nro_tipo_evento = 0 ) and       nro_cobranza_tipo_evento <> evento.nro_tipo_evento AND NOT evento.anulado NO-LOCK, ~
             EACH Cliente OF Evento NO-LOCK, ~
             EACH Tipo_evento OF Evento NO-LOCK.
&Scoped-define TABLES-IN-QUERY-br_table recurso_agenda Evento Cliente ~
Tipo_evento
&Scoped-define FIRST-TABLE-IN-QUERY-br_table recurso_agenda
&Scoped-define SECOND-TABLE-IN-QUERY-br_table Evento
&Scoped-define THIRD-TABLE-IN-QUERY-br_table Cliente
&Scoped-define FOURTH-TABLE-IN-QUERY-br_table Tipo_evento


/* Definitions for FRAME F-Main                                         */
&Scoped-define OPEN-BROWSERS-IN-QUERY-F-Main ~
    ~{&OPEN-QUERY-br_table}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS p_Recursos BRECURSOS br_table f_Asignado ~
Bagenda_recurso TPendiente 
&Scoped-Define DISPLAYED-OBJECTS p_Recursos f_Asignado TPendiente 

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
cdg_recurso|y|y|sic.recurso_agenda.cdg_recurso
nro_cliente||y|sic.Evento.nro_cliente
nro_evento||y|sic.recurso_agenda.nro_evento
fecha||y|sic.recurso_agenda.fecha
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = "cdg_recurso",
     Keys-Supplied = "nro_evento,cdg_recurso,nro_cliente,nro_evento,fecha"':U).

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

/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD cerrar B-table-Win 
FUNCTION cerrar RETURNS LOGICAL
  ( hh AS WIDGET-HANDLE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD PEVENTO B-table-Win 
FUNCTION PEVENTO RETURNS LOGICAL
  ( pevento AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD que_evento B-table-Win 
FUNCTION que_evento RETURNS ROWID
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE BUTTON Bagenda_recurso 
     LABEL "Agenda" 
     SIZE 16 BY 1.

DEFINE BUTTON BRECURSOS 
     LABEL "Recursos" 
     SIZE 10 BY 1.

DEFINE VARIABLE f_Asignado AS DATE FORMAT "99/99/9999" 
     LABEL "Asignado" 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1.

DEFINE VARIABLE p_Recursos AS CHARACTER FORMAT "X(20)" 
     LABEL "Recursos" 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1 TOOLTIP "Recursos asignados para realizar el evento".

DEFINE VARIABLE TPendiente AS LOGICAL INITIAL no 
     LABEL "Pendiente" 
     VIEW-AS TOGGLE-BOX
     SIZE 16 BY .81 TOOLTIP "Muestra si quedo algo pendiente de algun operario en la rendicion de hoy" NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      recurso_agenda, 
      Evento, 
      Cliente, 
      Tipo_evento SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _FREEFORM
  QUERY br_table NO-LOCK DISPLAY
      Tipo_evento.cdg_tipo_evento FORMAT "X(4)":U
      recurso_agenda.cdg_recurso FORMAT "X(8)":U
      Evento.nro_evento FORMAT ">>>>>>>9":U
      Evento.nro_evento_padre FORMAT ">>>>>>>9":U WIDTH 10.8
      Evento.Origen FORMAT "X(15)":U
      Evento.nro_identificacion FORMAT ">>>>>>>9":U
      Evento.Duracion FORMAT ">,>>9":U
      Evento.FMin FORMAT "99/99/9999":U
      Evento.FMax FORMAT "99/99/9999":U
      Evento.Periodo FORMAT "999999":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 115 BY 6.24.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     p_Recursos AT ROW 1.24 COL 10 COLON-ALIGNED WIDGET-ID 26
     BRECURSOS AT ROW 1.24 COL 20.4 WIDGET-ID 36
     br_table AT ROW 1.24 COL 32
     f_Asignado AT ROW 2.38 COL 10 COLON-ALIGNED WIDGET-ID 78
     Bagenda_recurso AT ROW 3.86 COL 12 WIDGET-ID 38
     TPendiente AT ROW 5.29 COL 12 WIDGET-ID 82
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
         HEIGHT             = 6.86
         WIDTH              = 146.4.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB B-table-Win 
/* ************************* Included-Libraries *********************** */

{src/adm/method/browser.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW B-table-Win
  NOT-VISIBLE,,RUN-PERSISTENT                                           */
/* SETTINGS FOR FRAME F-Main
   NOT-VISIBLE FRAME-NAME Size-to-Fit                                   */
/* BROWSE-TAB br_table BRECURSOS F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

ASSIGN 
       br_table:COLUMN-MOVABLE IN FRAME F-Main         = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _START_FREEFORM
IF NOT tpendiente THEN
   OPEN QUERY {&SELF-NAME} FOR EACH recurso_agenda
      WHERE recurso_agenda.fecha = f_asignado and can-do(p_recursos,recurso_agenda.cdg_recurso) NO-LOCK,
      EACH Evento WHERE recurso_agenda.fecha = f_asignado and recurso_agenda.cdg_recurso = p_recursos
      AND evento.frealizado = ? and ( evento.nro_tipo_evento = c_nro_tipo_evento or c_nro_tipo_evento = 0 ) and
      nro_cobranza_tipo_evento <> evento.nro_tipo_evento AND NOT evento.anulado NO-LOCK,
      EACH Cliente OF Evento NO-LOCK,
      EACH Tipo_evento OF Evento NO-LOCK.
ELSE
   OPEN QUERY {&SELF-NAME} FOR EACH recurso_agenda
      WHERE recurso_agenda.fecha = f_asignado NO-LOCK,
      EACH Evento WHERE recurso_agenda.fecha = f_asignado
      AND evento.frealizado = ? and ( evento.nro_tipo_evento = c_nro_tipo_evento or c_nro_tipo_evento = 0 ) and
      nro_cobranza_tipo_evento <> evento.nro_tipo_evento AND NOT evento.anulado NO-LOCK,
      EACH Cliente OF Evento NO-LOCK,
      EACH Tipo_evento OF Evento NO-LOCK.
     _END_FREEFORM
     _Options          = "NO-LOCK"
     _TblOptList       = ",,,"
     _Where[1]         = "recurso_agenda.fecha = f_asignado and ( can-do(p_recursos,recurso_agenda.cdg_recurso) or tpendiente )"
     _JoinCode[2]      = "recurso_agenda.fecha = f_asignado and ( recurso_agenda.cdg_recurso = p_recursos or tpendiente )"
     _Where[2]         = "evento.frealizado = ? and ( evento.nro_tipo_evento = c_nro_tipo_evento or c_nro_tipo_evento = 0 ) and
nro_cobranza_tipo_evento <> evento.nro_tipo_evento"
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

&Scoped-define SELF-NAME Bagenda_recurso
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bagenda_recurso B-table-Win
ON CHOOSE OF Bagenda_recurso IN FRAME F-Main /* Agenda */
DO:
  IF NOT VALID-HANDLE(h_agenda_recurso) THEN DO:
      RUN w-agenda_recurso.w PERSISTENT SET h_agenda_recurso.
      IF VALID-HANDLE(h_agenda_recurso) THEN
         RUN dispatch IN h_agenda_recurso ( INPUT 'initialize':U ) .
  END.
  ELSE DYNAMIC-FUNCTION("tope" IN h_agenda_recurso ). 
  
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BRECURSOS
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BRECURSOS B-table-Win
ON CHOOSE OF BRECURSOS IN FRAME F-Main /* Recursos */
DO:
  DEF VAR lista AS CHAR.
  lista = p_recursos:SCREEN-VALUE.
  FIND tipo_evento WHERE cdg_tipo_evento = "EV" NO-LOCK NO-ERROR.
IF NOT AVAILABLE tipo_evento THEN DO:
        MESSAGE "No se encuentra el Tipo Evento EV" VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
END.
  RUN d-recursos.w (INPUT-OUTPUT lista,STRING(tipo_evento.nro_tipo_evento)).
  p_recursos:SCREEN-VALUE = entry(1,lista).
  ASSIGN p_recursos.
  RUN adm-open-query.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_table
&Scoped-define SELF-NAME br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-DISPLAY OF br_table IN FRAME F-Main
DO:
DEFINE BUFFER baevento FOR evento.
DEFINE BUFFER btipo_evento FOR tipo_evento.
DEFINE  VAR ctipo LIKE Tipo_evento.cdg_tipo_evento NO-UNDO.
DEFINE  VAR letra LIKE Tipo_evento.color_letra NO-UNDO.
DEFINE  VAR fondo LIKE Tipo_evento.color_fondo NO-UNDO.
      ctipo = Tipo_evento.cdg_tipo_evento.
      letra = Tipo_evento.color_letra.
      fondo = Tipo_evento.color_fondo.
      IF  evento.nro_tipo_evento = nro_aviso_tipo_evento THEN DO:
            FIND baevento WHERE baevento.nro_evento = evento.refevento NO-LOCK NO-ERROR.
            IF AVAILABLE baevento THEN DO:
                FIND btipo_evento OF baevento.
                letra = bTipo_evento.color_letra.
                fondo = bTipo_evento.color_fondo.
            END.
      END.
      Tipo_evento.cdg_tipo_evento:FGCOLOR IN BROWSE {&BROWSE-NAME} = letra.
      Tipo_evento.cdg_tipo_evento:BGCOLOR IN BROWSE {&BROWSE-NAME} = fondo.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


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


&Scoped-define SELF-NAME f_Asignado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL f_Asignado B-table-Win
ON LEAVE OF f_Asignado IN FRAME F-Main /* Asignado */
DO:
   ASSIGN {&SELF-NAME}.
   RUN adm-open-query.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL f_Asignado B-table-Win
ON MOUSE-MENU-DOWN OF f_Asignado IN FRAME F-Main /* Asignado */
DO:
   {selfecha.i}
   ASSIGN {&SELF-NAME}.
   RUN adm-open-query.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME p_Recursos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL p_Recursos B-table-Win
ON LEAVE OF p_Recursos IN FRAME F-Main /* Recursos */
DO:
  ASSIGN {&SELF-NAME}.
  RUN adm-open-query.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME TPendiente
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL TPendiente B-table-Win
ON VALUE-CHANGED OF TPendiente IN FRAME F-Main /* Pendiente */
DO:
  ASSIGN tpendiente.
  RUN adm-open-query.
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
  DEF VAR key-value AS CHAR NO-UNDO.

  /* Look up the current key-value. */
  RUN get-attribute ('Key-Value':U).
  key-value = RETURN-VALUE.

  /* Find the current record using the current Key-Name. */
  RUN get-attribute ('Key-Name':U).
  CASE RETURN-VALUE:
    WHEN 'cdg_recurso':U THEN DO:
       &Scope KEY-PHRASE recurso_agenda.cdg_recurso eq key-value
       {&OPEN-QUERY-{&BROWSE-NAME}}
    END. /* cdg_recurso */
    OTHERWISE DO:
       &Scope KEY-PHRASE TRUE
       {&OPEN-QUERY-{&BROWSE-NAME}}
    END. /* OTHERWISE...*/
  END CASE.

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-destroy B-table-Win 
PROCEDURE local-destroy :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */
cerrar(h_agenda_recurso).

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'destroy':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-disable-fields B-table-Win 
PROCEDURE local-disable-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'disable-fields':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
brecursos:SENSITIVE IN FRAME {&FRAME-NAME}= FALSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-enable-fields B-table-Win 
PROCEDURE local-enable-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'enable-fields':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
brecursos:SENSITIVE IN FRAME {&FRAME-NAME} = TRUE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize B-table-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
f_asignado = TODAY.

FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "EV" NO-LOCK NO-ERROR.
IF AVAILABLE tipo_evento THEN DO:
        nro_cobranza_tipo_evento = tipo_evento.nro_tipo_evento.
END.
c_nro_tipo_evento = tipo_evento.nro_tipo_evento.

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

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
  {src/adm/template/sndkycas.i "cdg_recurso" "recurso_agenda" "cdg_recurso"}
  {src/adm/template/sndkycas.i "nro_cliente" "Evento" "nro_cliente"}
  {src/adm/template/sndkycas.i "nro_evento" "recurso_agenda" "nro_evento"}
  {src/adm/template/sndkycas.i "fecha" "recurso_agenda" "fecha"}

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
  {src/adm/template/snd-list.i "recurso_agenda"}
  {src/adm/template/snd-list.i "Evento"}
  {src/adm/template/snd-list.i "Cliente"}
  {src/adm/template/snd-list.i "Tipo_evento"}

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

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION cerrar B-table-Win 
FUNCTION cerrar RETURNS LOGICAL
  ( hh AS WIDGET-HANDLE ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
IF VALID-HANDLE(hh) THEN   do:
    RUN dispatch IN hh ( INPUT 'destroy':U ) . 
    RETURN TRUE.
END.
ELSE RETURN FALSE.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION PEVENTO B-table-Win 
FUNCTION PEVENTO RETURNS LOGICAL
  ( pevento AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
RUN adm-open-query.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION que_evento B-table-Win 
FUNCTION que_evento RETURNS ROWID
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

  RETURN ROWID(evento).   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

