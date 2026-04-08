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
DEFINE VAR ctipo LIKE Tipo_evento.cdg_tipo_evento COLUMN-LABEL "TE".
DEFINE VAR durEF AS INT NO-UNDO FORMAT ">>9".
{stavisado.i}
    DEFINE VAR stavisado AS CHAR NO-UNDO.
    DEFINE VAR realizado AS LOGICAL NO-UNDO.
DEFINE VAR asignado AS LOGICAL NO-UNDO.
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

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES Cliente
&Scoped-define FIRST-EXTERNAL-TABLE Cliente


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Cliente.
/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Evento Tipo_evento

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Tipo_evento.cdg_tipo_evento ~
Evento.nro_evento Evento.nro_evento_padre Evento.Origen ~
Evento.nro_identificacion Evento.sub_evento Evento.Duracion Evento.Recursos ~
Evento.Anulado evento.fasignado <> ? @ asignado ~
perant(evento.nro_evento) @ perant stavisado(evento.nro_evento) @ stavisado ~
Evento.Bloqueado evento.frealizado <> ? @ realizado Evento.FRealizado ~
Evento.hora_desde Evento.hora_hasta ~
duref(evento.hora_desde,evento.hora_hasta) @ duref Evento.FAsignado ~
Evento.Turno Evento.FMin Evento.FMax Evento.Evaluar Evento.Mobs ~
Evento.nro_planasignar Evento.Observaciones Evento.FCreado Evento.RefEvento ~
comprest(evento.nro_evento) @ comprest 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table 
&Scoped-define QUERY-STRING-br_table FOR EACH Evento OF Cliente WHERE ~{&KEY-PHRASE} NO-LOCK, ~
      EACH Tipo_evento WHERE Tipo_evento.nro_tipo_evento = Evento.nro_tipo_evento NO-LOCK ~
    BY Evento.FAsignado DESCENDING INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_table OPEN QUERY br_table FOR EACH Evento OF Cliente WHERE ~{&KEY-PHRASE} NO-LOCK, ~
      EACH Tipo_evento WHERE Tipo_evento.nro_tipo_evento = Evento.nro_tipo_evento NO-LOCK ~
    BY Evento.FAsignado DESCENDING INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_table Evento Tipo_evento
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Evento
&Scoped-define SECOND-TABLE-IN-QUERY-br_table Tipo_evento


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br_table 

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
nro_cliente||y|sic.Cliente.nro_cliente
nro_evento||y|sic.Evento.nro_evento
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = ,
     Keys-Supplied = "nro_cliente,nro_evento"':U).

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD duref B-table-Win 
FUNCTION duref RETURNS INT
  ( d AS CHAR, h AS CHAR )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD que_cliente B-table-Win 
FUNCTION que_cliente RETURNS INTEGER
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Evento, 
      Tipo_evento SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _STRUCTURED
  QUERY br_table NO-LOCK DISPLAY
      Tipo_evento.cdg_tipo_evento FORMAT "X(4)":U
      Evento.nro_evento FORMAT ">>>>>>9":U
      Evento.nro_evento_padre FORMAT ">>>>>>9":U
      Evento.Origen FORMAT "X(15)":U WIDTH 11.8
      Evento.nro_identificacion COLUMN-LABEL "Identif." FORMAT ">>>>>>>9":U
            WIDTH 8.8
      Evento.sub_evento COLUMN-LABEL "S!E" FORMAT ">>9":U WIDTH 1.8
      Evento.Duracion COLUMN-LABEL "Dur" FORMAT ">>9":U WIDTH 4.2
      Evento.Recursos FORMAT "X(8)":U
      Evento.Anulado FORMAT "si/no":U VIEW-AS TOGGLE-BOX
      evento.fasignado <> ? @ asignado COLUMN-LABEL "AS" FORMAT "S/N":U
      perant(evento.nro_evento) @ perant
      stavisado(evento.nro_evento) @ stavisado
      Evento.Bloqueado FORMAT "Si/No":U VIEW-AS TOGGLE-BOX
      evento.frealizado <> ? @ realizado COLUMN-LABEL "RE" FORMAT "S/N":U
      Evento.FRealizado COLUMN-LABEL "FRealiz." FORMAT "99/99/99":U
      Evento.hora_desde FORMAT "X(5)":U
      Evento.hora_hasta FORMAT "x(5)":U
      duref(evento.hora_desde,evento.hora_hasta) @ duref COLUMN-LABEL "DEF" FORMAT ">>9":U
      Evento.FAsignado FORMAT "99/99/99":U
      Evento.Turno FORMAT "x(2)":U
      Evento.FMin FORMAT "99/99/99":U
      Evento.FMax FORMAT "99/99/99":U
      Evento.Evaluar COLUMN-LABEL "Ev" FORMAT "si/no":U VIEW-AS TOGGLE-BOX
      Evento.Mobs FORMAT "x(50)":U
      Evento.nro_planasignar FORMAT "->,>>>,>>9":U
      Evento.Observaciones FORMAT "x(60)":U
      Evento.FCreado FORMAT "99/99/9999":U
      Evento.RefEvento FORMAT ">>>>>>>9":U
      comprest(evento.nro_evento) @ comprest
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 122 BY 6.71
         FGCOLOR 0 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     br_table AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE  WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartBrowser
   External Tables: sic.Cliente
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
         WIDTH              = 125.
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
/* BROWSE-TAB br_table 1 F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

ASSIGN 
       br_table:COLUMN-RESIZABLE IN FRAME F-Main       = TRUE
       br_table:COLUMN-MOVABLE IN FRAME F-Main         = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _TblList          = "sic.Evento OF sic.Cliente,sic.Tipo_evento WHERE sic.Evento ..."
     _Options          = "NO-LOCK INDEXED-REPOSITION KEY-PHRASE"
     _OrdList          = "sic.Evento.FAsignado|no"
     _JoinCode[2]      = "sic.Tipo_evento.nro_tipo_evento = sic.Evento.nro_tipo_evento"
     _FldNameList[1]   = sic.Tipo_evento.cdg_tipo_evento
     _FldNameList[2]   > sic.Evento.nro_evento
"Evento.nro_evento" ? ">>>>>>9" "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > sic.Evento.nro_evento_padre
"Evento.nro_evento_padre" ? ">>>>>>9" "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > sic.Evento.Origen
"Evento.Origen" ? ? "character" ? ? ? ? ? ? no ? no no "11.8" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > sic.Evento.nro_identificacion
"Evento.nro_identificacion" "Identif." ? "integer" ? ? ? ? ? ? no ? no no "8.8" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > sic.Evento.sub_evento
"Evento.sub_evento" "S!E" ? "integer" ? ? ? ? ? ? no ? no no "1.8" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > sic.Evento.Duracion
"Evento.Duracion" "Dur" ">>9" "integer" ? ? ? ? ? ? no ? no no "4.2" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   = sic.Evento.Recursos
     _FldNameList[9]   > sic.Evento.Anulado
"Evento.Anulado" ? ? "logical" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "TOGGLE-BOX" "," ? ? 5 no 0 no no
     _FldNameList[10]   > "_<CALC>"
"evento.fasignado <> ? @ asignado" "AS" "S/N" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > "_<CALC>"
"perant(evento.nro_evento) @ perant" ? ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > "_<CALC>"
"stavisado(evento.nro_evento) @ stavisado" ? ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > sic.Evento.Bloqueado
"Evento.Bloqueado" ? ? "logical" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "TOGGLE-BOX" "," ? ? 5 no 0 no no
     _FldNameList[14]   > "_<CALC>"
"evento.frealizado <> ? @ realizado" "RE" "S/N" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[15]   > sic.Evento.FRealizado
"Evento.FRealizado" "FRealiz." "99/99/99" "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[16]   > sic.Evento.hora_desde
"Evento.hora_desde" ? "X(5)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[17]   = sic.Evento.hora_hasta
     _FldNameList[18]   > "_<CALC>"
"duref(evento.hora_desde,evento.hora_hasta) @ duref" "DEF" ">>9" ? ? ? ? ? ? ? no "Duracion Efectiva" no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[19]   > sic.Evento.FAsignado
"Evento.FAsignado" ? "99/99/99" "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[20]   = sic.Evento.Turno
     _FldNameList[21]   > sic.Evento.FMin
"Evento.FMin" ? "99/99/99" "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[22]   > sic.Evento.FMax
"Evento.FMax" ? "99/99/99" "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[23]   > sic.Evento.Evaluar
"Evento.Evaluar" "Ev" ? "logical" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "TOGGLE-BOX" "," ? ? 5 no 0 no no
     _FldNameList[24]   = sic.Evento.Mobs
     _FldNameList[25]   = sic.Evento.nro_planasignar
     _FldNameList[26]   = sic.Evento.Observaciones
     _FldNameList[27]   = sic.Evento.FCreado
     _FldNameList[28]   = sic.Evento.RefEvento
     _FldNameList[29]   > "_<CALC>"
"comprest(evento.nro_evento) @ comprest" ? ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
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
ON MOUSE-SELECT-DBLCLICK OF br_table IN FRAME F-Main
DO:
DEF VAR rrowid AS ROWID NO-UNDO.
    IF evento.origen BEGINS "REMIT" THEN DO:
              FIND rem_header WHERE rem_header.nro_remito = evento.nro_identificacion NO-ERROR.
              IF NOT AVAILABLE rem_header THEN DO:
                  MESSAGE "Remito no registrato" VIEW-AS ALERT-BOX ERROR.
                  RETURN NO-APPLY.
              END.
              rrowid = ROWID(Rem_header).
              /*RUN ocultar_window.*/
              RUN c-comprobante_despacho.w ( INPUT-OUTPUT rrowid , INPUT 2, INPUT Rem_header.cdg_comprobante ).
              /*RUN mostrar_window.*/
    END.
    ELSE     IF evento.origen = "CONTRATO" THEN DO:
              FIND contrato_hd WHERE contrato_hd.nro_contrato = evento.nro_identificacion NO-ERROR.
                  IF NOT AVAILABLE contrato_hd THEN DO:
                  MESSAGE "Cotrato no registrato" VIEW-AS ALERT-BOX ERROR.
                  RETURN NO-APPLY.
              END.
              rrowid = ROWID(contrato_hd).
              /*RUN ocultar_window.*/
              RUN w-contratos-nro.w ( INPUT rrowid ).
              /*RUN mostrar_window.*/
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-DISPLAY OF br_table IN FRAME F-Main
DO:
  DEFINE VAR dmin AS INT NO-UNDO.
  DEFINE VAR dmax AS INT NO-UNDO.
  comprest:SCREEN-VALUE IN BROWSE {&BROWSE-NAME} = "".
  perant:SCREEN-VALUE IN BROWSE {&BROWSE-NAME} = "".

  dmin = evento.duracion * 0.9.
  dmax = evento.duracion * 1.10.
  duref = duref(evento.hora_desde,hora_hasta).
  IF duref <> 0 THEN DO:
      IF duref < dmin THEN
              duref:BGCOLOR = 10.
          ELSE 
              IF duref > dmax THEN
                  duref:BGCOLOR = 12.
          ELSE
              duref:BGCOLOR = ?.
  END.
  ELSE duref:BGCOLOR = ?.


      FIND tipo_evento WHERE evento.nro_tipo_evento = tipo_evento.nro_tipo_evento NO-LOCK.
      ctipo = Tipo_evento.cdg_tipo_evento.
      IF evento.origen = "CONTRATO" 
          THEN do:
            find contrato_hd where Contrato_hd.nro_contrato = Evento.nro_identificacion NO-ERROR.
            comprest = "".
            FOR EACH contrato_restriccion WHERE contrato_restriccion.nro_contrato = evento.nro_identificacion AND
              contrato_restriccion.sub_evento = evento.sub_evento:
              FIND restriccion no-lock OF contrato_restriccion.
              comprest = comprest + " " + restriccion.cdg_restriccion + "[" + contrato_restriccion.valor + "]".
            END.
            comprest:SCREEN-VALUE IN BROWSE {&BROWSE-NAME} = SUBSTR(comprest,2).
            perant:SCREEN-VALUE IN BROWSE {&BROWSE-NAME}=string(perant(evento.nro_evento)).

/*            FOR LAST bevento WHERE bevento.nro_identificacion = evento.nro_identificacion AND
                         bevento.sub_evento = evento.sub_evento AND
                         bevento.origen = evento.origen AND
                         NOT bevento.anulado AND
                         bevento.fmax < evento.fmin NO-LOCK BY evento.fmin BY bevento.fasignado BY bevento.frealizado:
               perant:SCREEN-VALUE IN BROWSE {&BROWSE-NAME} = IF bevento.frealizado = ? THEN string(bevento.fasignado) ELSE string(bevento.frealizado).
            END.
*/             
          END. 
          
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

  /* Create a list of all the tables that we need to get.            */
  {src/adm/template/row-list.i "Cliente"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Cliente"}

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
  {src/adm/template/sndkycas.i "nro_cliente" "Cliente" "nro_cliente"}
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
  {src/adm/template/snd-list.i "Cliente"}
  {src/adm/template/snd-list.i "Evento"}
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION duref B-table-Win 
FUNCTION duref RETURNS INT
  ( d AS CHAR, h AS CHAR ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
h = REPLACE(h,":","").
d = REPLACE(d,":","").

  RETURN INT(h) - int(d).   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION que_cliente B-table-Win 
FUNCTION que_cliente RETURNS INTEGER
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose: Retorna el numero de cliente de la tabla externa que coincide con la de eventos
  eso permitira el alta en cualquier otro objeto relacionado. 
    Notes:  
------------------------------------------------------------------------------*/

  RETURN IF AVAILABLE cliente THEN cliente.nro_cliente ELSE ?.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

