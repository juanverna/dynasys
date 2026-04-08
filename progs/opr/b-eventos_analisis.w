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
define var pcons as char  format "X(15)" no-undo.

DEFINE BUFFER bevento FOR evento.
DEFINE VAR ctipo LIKE Tipo_evento.cdg_tipo_evento LABEL "TE" NO-UNDO.
DEFINE VAR lista AS CHAR NO-UNDO.
DEFINE VAR ahora AS DATE NO-UNDO.
DEFINE VAR hcproc AS CHARACTER NO-UNDO.
DEFINE VAR hproc AS HANDLE NO-UNDO.
DEFINE VAR diassel AS CHAR NO-UNDO.

DEFINE VAR ultrecursos AS CHAR NO-UNDO LABEL "Ult.Rec".
DEFINE VAR Rturno AS CHAR NO-UNDO LABEL "RTurno".
DEFINE VAR Rdur AS INT NO-UNDO LABEL "RDur".
DEFINE VAR pp AS INT NO-UNDO INITIAL 5. /*numero de periodos*/

{tiempo.i}
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
&Scoped-define BROWSE-NAME this-procedurebr_table

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES recurso_agenda Evento Cliente

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE this-procedurebr_table                        */
&Scoped-define FIELDS-IN-QUERY-this-procedurebr_table Cliente.direccion ~
Evento.Recursos ultrecursos() @ ultrecursos Evento.hora_desde ~
Evento.hora_hasta Evento.Turno rturno() @ rturno Evento.Duracion ~
rdur(recurso_agenda.nro_evento) @ rdur Evento.Origen ~
Evento.nro_identificacion Evento.sub_evento Cliente.nom_cliente ~
comprest(evento.nro_evento) @ comprest 
&Scoped-define ENABLED-FIELDS-IN-QUERY-this-procedurebr_table 
&Scoped-define QUERY-STRING-this-procedurebr_table FOR EACH recurso_agenda WHERE ~{&KEY-PHRASE} ~
      AND can-do(lista,recurso_agenda.cdg_recurso) and can-do(diassel,string(recurso_agenda.fecha)) NO-LOCK, ~
      EACH Evento OF recurso_agenda ~
      WHERE Evento.Anulado = FALSE NO-LOCK, ~
      EACH Cliente OF Evento NO-LOCK ~
    BY Evento.Turno
&Scoped-define OPEN-QUERY-this-procedurebr_table OPEN QUERY this-procedurebr_table FOR EACH recurso_agenda WHERE ~{&KEY-PHRASE} ~
      AND can-do(lista,recurso_agenda.cdg_recurso) and can-do(diassel,string(recurso_agenda.fecha)) NO-LOCK, ~
      EACH Evento OF recurso_agenda ~
      WHERE Evento.Anulado = FALSE NO-LOCK, ~
      EACH Cliente OF Evento NO-LOCK ~
    BY Evento.Turno.
&Scoped-define TABLES-IN-QUERY-this-procedurebr_table recurso_agenda Evento ~
Cliente
&Scoped-define FIRST-TABLE-IN-QUERY-this-procedurebr_table recurso_agenda
&Scoped-define SECOND-TABLE-IN-QUERY-this-procedurebr_table Evento
&Scoped-define THIRD-TABLE-IN-QUERY-this-procedurebr_table Cliente


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS this-procedurebr_table 

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
nro_evento|y|y|sic.recurso_agenda.nro_evento
cdg_recurso|y|y|sic.recurso_agenda.cdg_recurso
fecha||y|sic.recurso_agenda.fecha
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = "nro_evento,cdg_recurso",
     Keys-Supplied = "nro_evento,cdg_recurso,fecha"':U).

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
<FILTER-ATTRIBUTES></FILTER-ATTRIBUTES> */   

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD duref B-table-Win 
FUNCTION duref RETURNS INT
  ( d AS CHAR, h AS CHAR )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD rdur B-table-Win 
FUNCTION rdur RETURNS INTEGER
  ( rr AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD rturno B-table-Win 
FUNCTION rturno RETURNS CHAR
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD rturno1 B-table-Win 
FUNCTION rturno1 RETURNS CHAR
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD ultrecursos B-table-Win 
FUNCTION ultrecursos RETURNS CHARACTER
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY this-procedurebr_table FOR 
      recurso_agenda, 
      Evento, 
      Cliente SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE this-procedurebr_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS this-procedurebr_table B-table-Win _STRUCTURED
  QUERY this-procedurebr_table NO-LOCK DISPLAY
      Cliente.direccion FORMAT "X(45)":U
      Evento.Recursos COLUMN-LABEL "Rec." FORMAT "X(8)":U
      ultrecursos() @ ultrecursos
      Evento.hora_desde FORMAT "x(5)":U
      Evento.hora_hasta FORMAT "x(5)":U
      Evento.Turno COLUMN-LABEL "Tu" FORMAT "x(2)":U
      rturno() @ rturno
      Evento.Duracion COLUMN-LABEL "Durac" FORMAT ">>,>>9":U
      rdur(recurso_agenda.nro_evento) @ rdur COLUMN-LABEL "Rdur"
      Evento.Origen FORMAT "X(15)":U
      Evento.nro_identificacion COLUMN-LABEL "Ident." FORMAT ">>>>>>>9":U
      Evento.sub_evento FORMAT ">>9":U
      Cliente.nom_cliente FORMAT "X(40)":U
      comprest(evento.nro_evento) @ comprest
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 66 BY 6.71 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     this-procedurebr_table AT ROW 1 COL 1
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
         WIDTH              = 95.4.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB B-table-Win 
/* ************************* Included-Libraries *********************** */

{excel-export.i}
{src/adm/method/browser.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW B-table-Win
  NOT-VISIBLE,,RUN-PERSISTENT                                           */
/* SETTINGS FOR FRAME F-Main
   NOT-VISIBLE FRAME-NAME Size-to-Fit                                   */
/* BROWSE-TAB this-procedurebr_table 1 F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

ASSIGN 
       this-procedurebr_table:COLUMN-RESIZABLE IN FRAME F-Main       = TRUE
       this-procedurebr_table:COLUMN-MOVABLE IN FRAME F-Main         = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME F-Main
/* Query rebuild information for FRAME F-Main
     _Options          = "NO-LOCK"
     _Query            is NOT OPENED
*/  /* FRAME F-Main */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE this-procedurebr_table
/* Query rebuild information for BROWSE this-procedurebr_table
     _TblList          = "sic.recurso_agenda,sic.Evento OF sic.recurso_agenda,sic.Cliente OF sic.Evento"
     _Options          = "NO-LOCK KEY-PHRASE"
     _TblOptList       = ",,"
     _OrdList          = "sic.Evento.Turno|yes"
     _Where[1]         = "can-do(lista,recurso_agenda.cdg_recurso) and can-do(diassel,string(recurso_agenda.fecha))"
     _Where[2]         = "sic.Evento.Anulado = FALSE"
     _FldNameList[1]   = sic.Cliente.direccion
     _FldNameList[2]   > sic.Evento.Recursos
"Evento.Recursos" "Rec." ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > "_<CALC>"
"ultrecursos() @ ultrecursos" ? ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   = sic.Evento.hora_desde
     _FldNameList[5]   = sic.Evento.hora_hasta
     _FldNameList[6]   > sic.Evento.Turno
"Evento.Turno" "Tu" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > "_<CALC>"
"rturno() @ rturno" ? ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > sic.Evento.Duracion
"Evento.Duracion" "Durac" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > "_<CALC>"
"rdur(recurso_agenda.nro_evento) @ rdur" "Rdur" ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   = sic.Evento.Origen
     _FldNameList[11]   > sic.Evento.nro_identificacion
"Evento.nro_identificacion" "Ident." ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   = sic.Evento.sub_evento
     _FldNameList[13]   = sic.Cliente.nom_cliente
     _FldNameList[14]   > "_<CALC>"
"comprest(evento.nro_evento) @ comprest" ? ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE this-procedurebr_table */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define BROWSE-NAME this-procedurebr_table
&Scoped-define SELF-NAME this-procedurebr_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL this-procedurebr_table B-table-Win
ON MOUSE-SELECT-DBLCLICK OF this-procedurebr_table IN FRAME F-Main
DO:
    RUN d-eventocli.w (THIS-PROCEDURE) .
    RUN dispatch IN THIS-PROCEDURE ( INPUT 'row-available':U ) .
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL this-procedurebr_table B-table-Win
ON ROW-DISPLAY OF this-procedurebr_table IN FRAME F-Main
DO:
  DEFINE VAR dmin AS INT NO-UNDO.
  DEFINE VAR dmax AS INT NO-UNDO.
  DEFINE VAR kk AS INT NO-UNDO.
  dmin = evento.duracion * 0.9.
  dmax = evento.duracion * 1.10.
  kk = rdur(evento.nro_evento).

  IF  kk <> 0 THEN DO:
      IF  kk < dmin THEN
              rdur:BGCOLOR IN BROWSE {&BROWSE-NAME}= 10.
          ELSE 
              IF  kk > dmax THEN
                  rdur:BGCOLOR = 12.
          ELSE
              rdur:BGCOLOR = ?.
  END.
  ELSE rdur:BGCOLOR = ?.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL this-procedurebr_table B-table-Win
ON ROW-ENTRY OF this-procedurebr_table IN FRAME F-Main
DO:
  /* This code displays initial values for newly added or copied rows. */
  {src/adm/template/brsentry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL this-procedurebr_table B-table-Win
ON ROW-LEAVE OF this-procedurebr_table IN FRAME F-Main
DO:
    /* Do not disable this code or no updates will take place except
     by pressing the Save button on an Update SmartPanel. */
   {src/adm/template/brsleave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL this-procedurebr_table B-table-Win
ON VALUE-CHANGED OF this-procedurebr_table IN FRAME F-Main
DO:
  /* This ADM trigger code must be preserved in order to notify other
     objects when the browser's current row changes. */
  {src/adm/template/brschnge.i}

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
    WHEN 'nro_evento':U THEN DO:
       &Scope KEY-PHRASE recurso_agenda.nro_evento eq INTEGER(key-value)
       {&OPEN-QUERY-{&BROWSE-NAME}}
    END. /* nro_evento */
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize B-table-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
{&OPEN-QUERY-{&BROWSE-NAME}}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-row-available B-table-Win 
PROCEDURE local-row-available :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR i AS INT NO-UNDO.
  /* Code placed here will execute PRIOR to standard behavior. */

RUN get-link-handle IN adm-broker-hdl
    ( INPUT THIS-PROCEDURE,
      INPUT "record-source",
      OUTPUT hcproc ).
DO i = 1 TO NUM-ENTRIES(hcproc):
    hproc = WIDGET-HANDLE( entry( i , hcproc , CHR( 1 ) )).
    IF VALID-HANDLE(hProc) THEN 
        diassel = DYNAMIC-FUNCTION( "diassel" IN hproc).
END.

RUN get-link-handle IN adm-broker-hdl
    ( INPUT THIS-PROCEDURE,
      INPUT "recursos-source",
      OUTPUT hcproc ).
    hproc = WIDGET-HANDLE( hcproc ).
    IF VALID-HANDLE(hProc) THEN RUN seleccionados IN hproc ( OUTPUT lista ).
    {&OPEN-QUERY-{&BROWSE-NAME}}

  /* Dispatch standard ADM method.                             */
/*   RUN dispatch IN THIS-PROCEDURE ( INPUT 'row-available':U ) . */

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
  {src/adm/template/sndkycas.i "nro_evento" "recurso_agenda" "nro_evento"}
  {src/adm/template/sndkycas.i "cdg_recurso" "recurso_agenda" "cdg_recurso"}
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION duref B-table-Win 
FUNCTION duref RETURNS INT
  ( d AS CHAR, h AS CHAR ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEFINE VAR hh1 AS DECIMAL NO-UNDO.
DEFINE VAR mm1 AS DECIMAL NO-UNDO.
DEFINE VAR hh2 AS DECIMAL NO-UNDO.
DEFINE VAR mm2 AS DECIMAL NO-UNDO.


h = REPLACE(h,":","").
d = REPLACE(d,":","").
hh1 = INT(h).
h = STRING(hh1,"9999").
hh1 = INT(d).
d = STRING(hh1,"9999").

hh1 = INT( SUBSTRING(d,1,2) ).
mm1 = INT( SUBSTRING(d,3,2) ).
hh2 = INT( SUBSTRING(h,1,2) ).
mm2 = INT( SUBSTRING(h,3,2) ).

mm1 = mm1 / 60.
mm2 = mm2 / 60.
hh1 = hh1 + mm1.
hh2 = hh2 + mm2.

RETURN INT((hh2 - hh1) * 60 ).   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION rdur B-table-Win 
FUNCTION rdur RETURNS INTEGER
  ( rr AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  Duracion media
    Notes:  Se tiene en cuenta de descartar valores  alejados +- 20% de la media
------------------------------------------------------------------------------*/

DEFINE VAR kk AS INT NO-UNDO.
DEFINE VAR pp1 AS INT NO-UNDO.
DEFINE VAR media AS INT NO-UNDO.
DEFINE VAR suma AS INT NO-UNDO.
DEFINE VAR pp AS INT INITIAL 10 NO-UNDO. /*cantidad de periodos maximos de analisis*/
DEFINE BUFFER bevento FOR evento.
DEFINE BUFFER weve FOR evento.
DEFINE VAR fmin AS INT.
DEFINE VAR fmax AS INT.
DEFINE VAR ffmin AS INT.
DEFINE VAR ffmax AS INT.

pp1 = 0.
suma = 0.
fmin = 99999.
FIND weve WHERE weve.nro_evento = rr NO-LOCK.
FOR EACH bevento WHERE bevento.origen = weve.origen AND 
    bevento.nro_cliente = weve.nro_cliente AND
    bevento.nro_tipo_evento = weve.nro_tipo_evento AND
    bevento.sub_evento = weve.sub_evento AND
    NOT bevento.anulado AND bevento.frealizado<>? BY bevento.fasignado DESCENDING:
    kk = abs(adur(bevento.hora_desde, bevento.hora_hasta)).
    IF kk = 0 OR kk = ? THEN NEXT.
    pp1 = pp1 + 1.
    suma = suma + kk.
    IF fmin > kk THEN do: fmin = kk. ffmin = pp1. END.
    IF fmax < kk THEN DO: fmax = kk. ffmax = pp1. END.
    IF pp1 > pp THEN LEAVE.
END.
media = ( suma - fmin - fmax ) / ( pp1 - 2 ).
pp1 = 0.
suma = 0.
ffmin = 0.
FOR EACH bevento WHERE bevento.origen = weve.origen AND 
    bevento.nro_cliente = weve.nro_cliente AND
    bevento.nro_tipo_evento = weve.nro_tipo_evento AND
     NOT bevento.anulado AND bevento.frealizado<>? BY bevento.fasignado DESCENDING:
        kk = adur(bevento.hora_desde, bevento.hora_hasta).
        IF kk = ? THEN NEXT.
        IF kk <= media * .8 OR kk >= media * 1.2 THEN NEXT.
        pp1 = pp1 + 1.
        IF pp1 = ffmin OR pp1 = ffmax THEN NEXT.
        suma = suma + adur(bevento.hora_desde, bevento.hora_hasta).
        ffmin = ffmin + 1.
    IF ffmin > pp THEN LEAVE.
END.
media = suma / ffmin.
RETURN media.
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION rturno B-table-Win 
FUNCTION rturno RETURNS CHAR
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose:  Duracion media
    Notes:  Se tiene en cuanta de descartar valores muy alejados de la media
------------------------------------------------------------------------------*/
DEFINE VAR kk AS INT NO-UNDO.
DEFINE VAR pp1 AS INT NO-UNDO.
DEFINE VAR media AS INT NO-UNDO.
DEFINE VAR suma AS INT NO-UNDO.
DEFINE BUFFER bevento FOR evento.
DEFINE BUFFER baevento FOR evento.
DEFINE BUFFER brecurso_agenda FOR recurso_agenda.
DEFINE VAR lista AS CHAR NO-UNDO.
DEFINE VAR dlista AS CHAR NO-UNDO.
DEFINE VAR rr1 AS CHAR NO-UNDO.
DEFINE VAR rr2 AS INT NO-UNDO.
pp1 = 0.
suma = 0.
IF evento.origen = "CONTRATO" THEN DO:
    FOR EACH bevento WHERE bevento.origen = evento.origen AND 
        bevento.nro_identificacion = evento.nro_identificacion AND
        bevento.sub_evento = evento.sub_evento AND
         NOT bevento.anulado AND bevento.frealizado<>? BY bevento.fasignado DESCENDING:
        pp1 = pp1 + 1.
        suma = suma + duref(bevento.hora_desde, bevento.hora_hasta).
        IF pp1 > pp THEN LEAVE.
    END.
    media = suma / pp1.
    pp1 = 0.
    suma = 0.
    FOR EACH bevento WHERE bevento.origen = evento.origen AND 
        bevento.nro_identificacion = evento.nro_identificacion AND
         NOT bevento.anulado AND bevento.frealizado<>? BY bevento.fasignado DESCENDING:
            kk = duref(bevento.hora_desde, bevento.hora_hasta).
            IF kk < media * .8 OR kk > media * 1.2 THEN NEXT.
            pp1 = pp1 + 1.
            IF pp1 > pp THEN LEAVE.
            rr2 = 0.
            FOR EACH brecurso_agenda NO-LOCK WHERE 
                brecurso_agenda.cdg_recurso = ENTRY(1,bEvento.Recursos) AND
                brecurso_agenda.fecha = bevento.frealizado,
                EACH baevento OF brecurso_agenda BY baevento.hora_desde:
                rr2 = rr2 + 1.
                IF baevento.origen = bevento.origen AND
                    baevento.nro_identificacion = bevento.nro_identificacion AND
                    baevento.sub_evento = baevento.sub_evento THEN DO:
                       rr1 = IF INT(REPLACE( baevento.hora_desde,":","")) > 1200 THEN "T" ELSE "M".
                       rr1 = rr1 + STRING(rr2,"9").
                       lista = lista + "," + rr1.
                END.
            END.
    END.
    /*depurar la lista*/
    DO kk = 1 TO  NUM-ENTRIES(lista):
        IF LOOKUP( ENTRY(kk,lista),dlista) = 0 THEN
            dlista = dlista + "," + ENTRY(kk,lista).
    END.
    RETURN substr(dlista,2).
END.
ELSE  RETURN ?.
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION rturno1 B-table-Win 
FUNCTION rturno1 RETURNS CHAR
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose:  Duracion media
    Notes:  Se tiene en cuanta de descartar valores muy alejados de la media
------------------------------------------------------------------------------*/
DEFINE VAR kk AS INT NO-UNDO.
DEFINE VAR pp1 AS INT NO-UNDO.
DEFINE BUFFER bevento FOR evento.
DEFINE BUFFER brecurso_agenda FOR recurso_agenda.
DEFINE VAR lista AS CHAR NO-UNDO.
DEFINE VAR dlista AS CHAR NO-UNDO.
DEFINE VAR rr1 AS CHAR NO-UNDO.
DEFINE VAR rr2 AS INT NO-UNDO.

FOR EACH brecurso_agenda NO-LOCK WHERE 
                brecurso_agenda.cdg_recurso = ENTRY(1,Evento.Recursos) AND
                brecurso_agenda.fecha = evento.frealizado,
                EACH bevento OF brecurso_agenda BY bevento.hora_desde:
                IF aint(bevento.hora_desde) <= aint(evento.hora_desde) THEN
                        rr2 = rr2 + 1.
                ELSE 
                 return ( IF INT(REPLACE( bevento.hora_desde,":","")) > 1200 THEN "T" ELSE "M" ) + STRING(rr2,"9").
END.
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION ultrecursos B-table-Win 
FUNCTION ultrecursos RETURNS CHARACTER
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose: Recursos ultilizados en los ultimos meses  que aun existen
    Notes:  
------------------------------------------------------------------------------*/
DEFINE VAR lista AS CHAR NO-UNDO.
DEFINE VAR dlista AS CHAR NO-UNDO.
DEFINE VAR kk AS INT NO-UNDO.
DEFINE VAR pp1 AS INT NO-UNDO.
DEFINE BUFFER bevento FOR evento.
lista = "".
dlista = "".
pp1 = 0.
IF evento.origen = "CONTRATO" THEN DO:
    FOR EACH bevento WHERE bevento.origen = evento.origen AND 
        bevento.nro_identificacion = evento.nro_identificacion AND
        bevento.sub_evento = evento.sub_evento AND
         NOT bevento.anulado BY bevento.fasignado DESCENDING:
        lista = lista + "," + bevento.recursos.
        pp1 = pp1 + 1.
        IF pp1 > pp THEN LEAVE.
    END.
    lista = SUBSTRING(lista,2).
    DO kk = 1 TO NUM-ENTRIES(lista):
        IF LOOKUP( ENTRY( kk , lista ),dlista) = 0 THEN DO:
            FIND recurso WHERE recurso.cdg_recurso = ENTRY( kk , lista ) NO-LOCK NO-ERROR.
            IF AVAILABLE recurso THEN 
                dlista = dlista + "," + ENTRY( kk , lista ).
        END.
    END.
    dlista = SUBSTR(dlista,2).
END.
RETURN dlista.   /* Function return value. */
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

