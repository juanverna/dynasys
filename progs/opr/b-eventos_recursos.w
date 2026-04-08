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
DEFINE VAR ctipo LIKE Tipo_evento.cdg_tipo_evento COLUMN-LABEL "TE" NO-UNDO.
DEFINE VAR lista AS CHAR NO-UNDO.
DEFINE VAR ahora AS DATE NO-UNDO.
DEFINE VAR hcproc AS CHARACTER NO-UNDO.
DEFINE VAR hproc AS HANDLE NO-UNDO.
DEFINE VAR diassel AS CHAR NO-UNDO.

DEFINE VAR duref AS INT NO-UNDO.
DEFINE VAR rdur AS INT NO-UNDO.
DEFINE VAR tienevortex AS LOGICAL NO-UNDO.
{stavisado.i}
DEFINE VAR stasignado AS CHAR NO-UNDO.
DEFINE VAR evavisado AS INTEGER FORMAT ">>>>>>>9"  NO-UNDO.
DEFINE VAR realizado AS LOGICAL NO-UNDO.
DEFINE VAR asignado AS LOGICAL NO-UNDO.
DEFINE VAR unidades AS INT NO-UNDO.
DEFINE VAR nro_aviso_tipo_evento LIKE tipo_evento.nro_tipo_evento NO-UNDO.
DEFINE VAR nrotipo AS CHAR INITIAL "*" NO-UNDO.
DEFINE VAR leyenda_contrato LIKE contrato_hd.leyenda.
DEFINE VAR fcertif AS CHAR FORMAT "X(15)" COLUMN-LABEL "CERTIFICADO" NO-UNDO.
DEFINE VAR precio AS DECIMAL DECIMALS 2 FORMAT ">>>>>9.99" COLUMN-LABEL "Precio" NO-UNDO.
DEFINE VAR inforeservada AS LOGICAL NO-UNDO INITIAL TRUE.
DEFINE VAR nom_admin LIKE cliente.nom_cliente COLUMN-LABEL "Administracion" NO-UNDO.
DEFINE BUFFER administrador FOR cliente.
{restricciones.i}
{advtexto.i}
{tiempo.i}
{findempresa.i}

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

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Tipo_evento.cdg_tipo_evento Cliente.direccion comprest(evento.nro_evento) @ comprest Evento.Recursos Evento.Turno Evento.Duracion duref(evento.hora_desde,evento.hora_hasta) @ duref rdur(evento.nro_evento) @ rdur unidades(evento.nro_cliente) @ unidades Evento.FAsignado Evento.Anulado stavisado(Evento.nro_evento) @ stasignado evavisado(evento.nro_evento) @ evavisado Evento.Bloqueado evento.fasignado<>? @ asignado perant(evento.nro_evento) @ perant Evento.nro_evento Evento.nro_evento_padre Evento.nro_identificacion Evento.sub_evento evento.frealizado <> ? @ realizado Evento.FRealizado tienevortex() @ tienevortex Evento.hora_desde Evento.hora_hasta Evento.FMin Evento.FMax Evento.Evaluar Evento.nro_planasignar Evento.FCreado Cliente.nom_cliente Evento.Origen Evento.Observaciones Evento.Leyenda leyctr(evento.nro_evento) @ leyenda_contrato fcertif( evento.nro_evento) @ fcertif precio( evento.nro_evento ) @ precio nombre_admin(evento.nro_evento) @ nom_admin   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table   
&Scoped-define SELF-NAME br_table
&Scoped-define QUERY-STRING-br_table FOR EACH recurso_agenda WHERE ~{&KEY-PHRASE}       AND can-do(lista, ~
      recurso_agenda.cdg_recurso) and can-do(diassel, ~
      string(recurso_agenda.fecha)) NO-LOCK, ~
             EACH Evento OF recurso_agenda       WHERE Evento.Anulado = FALSE AND can-do( nrotipo , ~
       STRING(evento.nro_tipo_evento)) NO-LOCK, ~
             EACH Cliente OF Evento NO-LOCK, ~
             EACH Tipo_evento WHERE Tipo_evento.nro_tipo_evento = Evento.nro_tipo_evento NO-LOCK     BY Evento.Turno INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_table OPEN QUERY {&SELF-NAME} FOR EACH recurso_agenda WHERE ~{&KEY-PHRASE}       AND can-do(lista, ~
      recurso_agenda.cdg_recurso) and can-do(diassel, ~
      string(recurso_agenda.fecha)) NO-LOCK, ~
             EACH Evento OF recurso_agenda       WHERE Evento.Anulado = FALSE AND can-do( nrotipo , ~
       STRING(evento.nro_tipo_evento)) NO-LOCK, ~
             EACH Cliente OF Evento NO-LOCK, ~
             EACH Tipo_evento WHERE Tipo_evento.nro_tipo_evento = Evento.nro_tipo_evento NO-LOCK     BY Evento.Turno INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_table recurso_agenda Evento Cliente ~
Tipo_evento
&Scoped-define FIRST-TABLE-IN-QUERY-br_table recurso_agenda
&Scoped-define SECOND-TABLE-IN-QUERY-br_table Evento
&Scoped-define THIRD-TABLE-IN-QUERY-br_table Cliente
&Scoped-define FOURTH-TABLE-IN-QUERY-br_table Tipo_evento


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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD exrdur B-table-Win 
FUNCTION exrdur RETURNS INTEGER
  ( rr AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fcertif B-table-Win 
FUNCTION fcertif RETURNS CHARACTER
  ( nro AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD leyctr B-table-Win 
FUNCTION leyctr RETURNS CHARACTER
  ( nro AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD nombre_admin B-table-Win 
FUNCTION nombre_admin RETURNS CHARACTER
  ( nro AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD precio B-table-Win 
FUNCTION precio RETURNS DECIMAL
  ( nro AS int64 )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD rdur B-table-Win 
FUNCTION rdur RETURNS INTEGER
  ( rr AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD setnrotipo B-table-Win 
FUNCTION setnrotipo RETURNS CHARACTER
  ( tipo AS CHAR )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD tienevortex B-table-Win 
FUNCTION tienevortex RETURNS CHARACTER
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD unidades B-table-Win 
FUNCTION unidades RETURNS INTEGER
  ( pnro AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
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
      Tipo_evento.cdg_tipo_evento COLUMN-LABEL "Ti!Ev" FORMAT "X(3)":U
      Cliente.direccion FORMAT "X(45)":U WIDTH 35.4
      comprest(evento.nro_evento) @ comprest COLUMN-LABEL "Restricciones" WIDTH 46.2
      Evento.Recursos COLUMN-LABEL "Rec." FORMAT "X(8)":U
      Evento.Turno COLUMN-LABEL "Tu" FORMAT "x(2)":U
      Evento.Duracion COLUMN-LABEL "Durac" FORMAT ">>,>>9":U
      duref(evento.hora_desde,evento.hora_hasta) @ duref COLUMN-LABEL "DurRef"
      rdur(evento.nro_evento)  @ rdur COLUMN-LABEL "Rdur"
      unidades(evento.nro_cliente) @ unidades COLUMN-LABEL "Unid" FORMAT ">>9":U
      Evento.FAsignado FORMAT "99/99/9999":U
      Evento.Anulado FORMAT "si/no":U 
      stavisado(Evento.nro_evento) @ stasignado COLUMN-LABEL "AV" FORMAT "X":U
      evavisado(evento.nro_evento) @ evavisado COLUMN-LABEL "AVISO" FORMAT ">>>>>>>9":U
      Evento.Bloqueado COLUMN-LABEL "Blk" FORMAT "Si/No":U 
      evento.fasignado<>? @ asignado COLUMN-LABEL "AS" FORMAT "S/N":U
      perant(evento.nro_evento) @ perant COLUMN-LABEL "As.Anterior"
      Evento.nro_evento FORMAT ">>>>>>>9":U
      Evento.nro_evento_padre FORMAT ">>>>>>>9":U
      Evento.nro_identificacion COLUMN-LABEL "Ident." FORMAT ">>>>>>>9":U
      Evento.sub_evento FORMAT ">>9":U
      evento.frealizado <> ? @ realizado COLUMN-LABEL "RE" FORMAT "S/N":U
      Evento.FRealizado FORMAT "99/99/9999":U
      tienevortex() @ tienevortex COLUMN-LABEL "VTX" FORMAT "S/N":U
            WIDTH 4.8
      Evento.hora_desde FORMAT "x(5)":U
      Evento.hora_hasta FORMAT "x(5)":U
      Evento.FMin FORMAT "99/99/9999":U
      Evento.FMax FORMAT "99/99/9999":U
      Evento.Evaluar FORMAT "si/no":U 
      Evento.nro_planasignar FORMAT "->,>>>,>>9":U
      Evento.FCreado FORMAT "99/99/9999":U
      Cliente.nom_cliente FORMAT "X(40)":U
      Evento.Origen FORMAT "X(15)":U
      Evento.Observaciones FORMAT "x(60)":U
      Evento.Leyenda FORMAT "x(60)":U
      leyctr(evento.nro_evento) @ leyenda_contrato FORMAT "x(60)":U
      fcertif( evento.nro_evento) @ fcertif
      precio( evento.nro_evento ) @ precio
      nombre_admin(evento.nro_evento) @ nom_admin
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS MULTIPLE SIZE 109 BY 6.67 ROW-HEIGHT-CHARS .62 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     br_table AT ROW 1 COL 109 RIGHT-ALIGNED
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
         HEIGHT             = 6.81
         WIDTH              = 109.2.
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
/* BROWSE-TAB br_table 1 F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR BROWSE br_table IN FRAME F-Main
   ALIGN-R                                                              */
ASSIGN 
       br_table:COLUMN-RESIZABLE IN FRAME F-Main       = TRUE
       br_table:COLUMN-MOVABLE IN FRAME F-Main         = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH recurso_agenda WHERE ~{&KEY-PHRASE}
      AND can-do(lista,recurso_agenda.cdg_recurso) and can-do(diassel,string(recurso_agenda.fecha)) NO-LOCK,
      EACH Evento OF recurso_agenda
      WHERE Evento.Anulado = FALSE AND can-do( nrotipo , STRING(evento.nro_tipo_evento)) NO-LOCK,
      EACH Cliente OF Evento NO-LOCK,
      EACH Tipo_evento WHERE Tipo_evento.nro_tipo_evento = Evento.nro_tipo_evento NO-LOCK
    BY Evento.Turno INDEXED-REPOSITION.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION KEY-PHRASE"
     _TblOptList       = ",,,"
     _OrdList          = "sic.Evento.Turno|yes"
     _Where[1]         = "can-do(lista,recurso_agenda.cdg_recurso) and can-do(diassel,string(recurso_agenda.fecha))"
     _Where[2]         = "sic.Evento.Anulado = FALSE"
     _JoinCode[4]      = "sic.Tipo_evento.nro_tipo_evento = sic.Evento.nro_tipo_evento"
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
ON MOUSE-MENU-CLICK OF br_table IN FRAME F-Main
DO:
/*tiene aviso relacionado*/
APPLY "MOUSE-SELECT-CLICK" TO SELF.
DEFINE BUFFER b-relacionado FOR evento.
IF evento.anulado THEN DO:
        MESSAGE "El evento esta anulado, la info es solo a modo referencia" VIEW-AS ALERT-BOX ERROR.
END.

IF evento.origen <> "AVISO" THEN DO:
    FIND FIRST b-relacionado WHERE b-relacionado.REFevento = evento.nro_evento and NOT b-relacionado.anulado NO-LOCK NO-ERROR.
    IF NOT AVAILABLE b-relacionado THEN DO:
            MESSAGE "No hay evento relacionado" VIEW-AS ALERT-BOX INFORMATION.
            RETURN NO-APPLY.
    END.
      RUN d-zoom-evento.w ( b-relacionado.nro_evento, "Evento relacionado al " + string(evento.nro_evento) ).
END.
ELSE DO:
    FIND FIRST b-relacionado WHERE b-relacionado.nro_evento = evento.refevento and NOT b-relacionado.anulado NO-LOCK NO-ERROR.
    IF NOT AVAILABLE b-relacionado THEN DO:
            MESSAGE "No hay aviso relacionado" VIEW-AS ALERT-BOX INFORMATION.
            RETURN NO-APPLY.
    END.
      RUN d-zoom-evento.w ( b-relacionado.nro_evento, "Aviso relacionado al " + string(evento.refevento) ).
END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON MOUSE-SELECT-DBLCLICK OF br_table IN FRAME F-Main
DO:

IF AVAILABLE evento THEN   
   RUN d-padrehijo.w(evento.nro_evento).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-DISPLAY OF br_table IN FRAME F-Main
DO:
   DEFINE VAR dmin AS INT NO-UNDO.
   DEFINE VAR dmax AS INT NO-UNDO.
  DEFINE VAR letra AS INT NO-UNDO.
  DEFINE VAR fondo AS INT NO-UNDO.
  DEFINE VAR kk AS INT NO-UNDO.

  DEF VAR vv AS INT NO-UNDO.
DEFINE BUFFER baevento FOR evento.
DEFINE BUFFER btipo_evento FOR tipo_evento.
  IF NOT AVAILABLE evento THEN RETURN NO-APPLY.
       dmin = evento.duracion * 0.9.
       dmax = evento.duracion * 1.10.
       vv = duref(evento.hora_desde,hora_hasta).
       IF vv <> 0 THEN DO:
           IF vv < dmin THEN
                   duref:BGCOLOR IN BROWSE {&BROWSE-NAME} = 12.
               ELSE 
                   IF vv > dmax THEN
                       duref:BGCOLOR = 12.
               ELSE
                   duref:BGCOLOR = 10.
       END.
       ELSE duref:BGCOLOR = 10.
       IF avisoentregado(evento.nro_evento) OR evento.bloqueado THEN
           cliente.direccion:BGCOLOR = 8.
       FIND administrador WHERE administrador.nro_cliente = cliente.nro_admin NO-LOCK NO-ERROR.
      FIND tipo_evento WHERE evento.nro_tipo_evento = tipo_evento.nro_tipo_evento NO-LOCK.
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

    RUN get-link-handle IN adm-broker-hdl
     ( INPUT THIS-PROCEDURE,
       INPUT "record-source",
       OUTPUT hcproc ).
       hproc = WIDGET-HANDLE( hcproc ).
       IF VALID-HANDLE(hProc) THEN RUN local-display-fields IN hproc NO-ERROR.

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE desasignar_avisos B-table-Win 
PROCEDURE desasignar_avisos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAMETER fechad AS DATE.
DEFINE INPUT PARAMETER recursod AS CHAR.
FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "AV" NO-LOCK.
/*desasignar todos los eventos avisos del origen*/
        FOR EACH recurso_agenda WHERE recurso_agenda.fecha = fechad AND recurso_agenda.cdg_recurso = recursod,
            bevento OF recurso_agenda WHERE bevento.nro_tipo_evento = tipo_evento.nro_tipo_evento:
                DELETE recurso_agenda.
                bevento.observacion = agregaAdvTexto("Desasignado al cambiar los eventos del dia " + STRING(fechad,"99/99/9999") ,bevento.observacion).
                bevento.fasignado = ?.
            FOR EACH tarea OF evento WHERE tarea.estado = "A" AND ( tarea.cdg_tipotarea = "T" OR tarea.cdg_tipotarea = "Z" ):
                    DELETE tarea.
            END.
        END.

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE export-excel B-table-Win 
PROCEDURE export-excel :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
   run excel-export ( {&BROWSE-NAME}:HANDLE IN FRAME {&FRAME-NAME} ).
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize B-table-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
 
 FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "AV" NO-LOCK NO-ERROR.
IF AVAILABLE tipo_evento THEN DO:
        nro_aviso_tipo_evento = tipo_evento.nro_tipo_evento.
END.
FIND usuario OF empresa WHERE sic.Usuario.cdg_usuario = userid("sic") NO-LOCK.
inforeservada = CAN-find( usuario_funcion WHERE usuario_funcion.nro_usuario = usuario.nro_usuario AND Usuario_funcion.cdg_funcion = "CFAC" AND
                                                                                     usuario_funcion.cdg_empresa = empresa.cdg_empresa ).
  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
{&OPEN-QUERY-{&BROWSE-NAME}}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-open-query-cases B-table-Win 
PROCEDURE local-open-query-cases :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

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

diassel = ?.
lista = "".
RUN get-link-handle IN adm-broker-hdl
    ( INPUT THIS-PROCEDURE,
      INPUT "record-source",
      OUTPUT hcproc ).
hproc = WIDGET-HANDLE( hcproc ).
IF VALID-HANDLE(hProc) THEN DO:
   diassel = DYNAMIC-FUNCTION( "diassel" IN hproc) NO-ERROR.
   RUN seleccionados IN hproc ( OUTPUT lista ) NO-ERROR.
   {&OPEN-QUERY-{&BROWSE-NAME}}
END.

/* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'row-available':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE moviendo B-table-Win 
PROCEDURE moviendo :
/*------------------------------------------------------------------------------
  Purpose:  mueve las asignaciones de los eventos seleccionado a la fecha del parametro  
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAMETER  fechah AS DATE.
DEFINE VAR fechad AS DATE.
DEFINE VAR recursod AS CHAR.
DEF VAR i AS INT NO-UNDO.
DEFINE BUFFER bevento FOR evento.
DEFINE VAR nro_tipo_evento_aviso LIKE evento.nro_tipo_evento.
DEFINE VAR eve-rela AS CHAR no-undo.
DEFINE VAR fasigevsigue AS DATE NO-UNDO.
DEFINE VAR opt AS LOGICAL NO-UNDO.
DEFINE BUFFER baevento FOR evento.
DEFINE VAR operdesde AS CHAR NO-UNDO.


FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "AV" NO-LOCK.
nro_tipo_evento_aviso = tipo_evento.nro_tipo_evento.
IF NOT AVAILABLE evento THEN RETURN.

DO i = 1 TO br_table:NUM-SELECTED-ROWS IN FRAME {&FRAME-NAME} TRANSACTION:
    br_table:FETCH-SELECTED-ROW ( i ) NO-ERROR.
    IF NOT AVAILABLE evento THEN NEXT.

    IF  fechad = ? THEN DO:
        fechad = recurso_agenda.fecha.
        recursod =  recurso_agenda.cdg_recurso.
    END.
    eve-rela = "".
    FOR EACH bevento WHERE bevento.RefEvento = evento.nro_evento AND
        NOT bevento.anulado NO-LOCK:
        IF avisoentregado(bevento.nro_evento) OR bevento.bloqueado OR bevento.frealizado <> ? THEN
        eve-rela = eve-rela + STRING(bevento.nro_evento,">>>>>>>>9").
    END.
    FOR EACH bevento WHERE bevento.evsigue = evento.nro_evento AND
        NOT bevento.anulado NO-LOCK:
        IF avisoentregado(bevento.nro_evento) OR bevento.bloqueado OR bevento.frealizado <> ? THEN
        eve-rela = eve-rela + STRING(bevento.nro_evento,">>>>>>>>9").
    END.

    IF evento.evsigue <> 0 THEN DO:
            FIND bevento WHERE bevento.nro_evento = evento.evsigue and
                NOT bevento.anulado and
                ( avisoentregado(bevento.nro_evento) OR bevento.bloqueado OR bevento.frealizado <> ? ) NO-LOCK NO-ERROR.
            IF AVAILABLE bevento THEN
                eve-rela = eve-rela + STRING(evento.evsigue,">>>>>>>>9").
    END.
    eve-rela = SUBSTRING(eve-rela,2). 
    IF num-entries(eve-rela) > 0  THEN DO:
      MESSAGE "El evento " + string(evento.nro_evento) + " posee los siguientes eventos relacionados" SKIP
              eve-rela SKIP
              "con acciones en curso o acciones relacionadas ya ejecutadas" skip
              "que deben realizarse nuevamente y no puede ser modificado" skip
              "hasta que no resuelva las mismas" VIEW-AS ALERT-BOX ERROR.
       undo , RETURN ERROR.
    END.    
    
    fasigevsigue=?.
    eve-rela = "".
    FOR EACH bevento WHERE bevento.evsigue = evento.nro_evento AND
        bevento.fasignado = evento.fasignado AND
        bevento.frealizado = ? AND
        NOT bevento.anulado NO-LOCK:
        eve-rela = eve-rela + STRING(bevento.nro_evento,">>>>>>>>9").
    END.
    IF evento.evsigue <> 0 THEN DO:
        FIND bevento WHERE bevento.nro_evento = evento.evsigue and
            NOT bevento.anulado and
            ( avisoentregado(bevento.nro_evento) OR bevento.bloqueado OR bevento.frealizado <> ? ) NO-LOCK NO-ERROR.
            IF AVAILABLE bevento THEN
                eve-rela = eve-rela + STRING(evento.evsigue,">>>>>>>>9").
    END.
    eve-rela = SUBSTRING(eve-rela,2). 
    IF num-entries(eve-rela) > 0  THEN DO:
      MESSAGE "Esta mofificacion arrastra cambios en el/los evento" SKIP
              eve-rela SKIP
              "Se asignaran en la misma fecha, modificando ambos eventos"
              VIEW-AS ALERT-BOX QUESTION BUTTON YES-NO SET opt.
      IF NOT opt  THEN RETURN ERROR.
      fasigevsigue = evento.fasignado.
    END.
    
    IF NOT evento.anulado AND 
        evento.frealizado = ? AND
        evento.fasignado <> ? THEN DO:
        FIND CURRENT evento EXCLUSIVE-LOCK.
        IF evento.nro_tipo_evento = nro_tipo_evento_aviso THEN DO:
            FOR EACH recurso_agenda WHERE recurso_agenda.nro_evento = evento.nro_evento:
                DELETE recurso_agenda.
            END.
            ASSIGN evento.recursos = ""
                   evento.fasignado = ?.
        END.
        ELSE
            ASSIGN evento.fasignado = fechah.
        /*borrar los avisos*/
        FOR EACH tarea OF evento WHERE tarea.estado = "A" AND ( tarea.cdg_tipotarea = "T" OR tarea.cdg_tipotarea = "Z" ):
                DELETE tarea.
        END.
        FOR EACH bevento WHERE bevento.refevento = evento.nro_evento:
            DELETE bevento.
        END.
        FOR EACH tarea OF bevento WHERE tarea.estado = "A":
            tarea.estado = "D".
            tarea.descripcion = agregaAdvTexto("Descartada al anular evento " , tarea.descripcion).
        END.

        RUN recrea_agenda (evento.nro_evento).

        /*reasignar los eventos relacionados*/
        FOR EACH bevento WHERE bevento.evsigue = evento.nro_evento AND
                bevento.fasignado = fasigevsigue AND
                bevento.frealizado = ? AND
                NOT bevento.anulado:
                bevento.fasignado = evento.fasignado.
                RUN recrea_agenda (bevento.nro_evento).
        
                /*ver si tenia a su vez un aviso*/
                FOR EACH baevento WHERE bevento.refevento = baevento.nro_evento:
                    RUN recrea_agenda (baevento.nro_evento).
                END.
        END.
        IF evento.evsigue <> 0 THEN DO:
                FIND bevento WHERE bevento.nro_evento = evento.evsigue and
                     NOT bevento.anulado and
                     ( avisoentregado(bevento.nro_evento) OR bevento.bloqueado OR bevento.frealizado <> ?) NO-ERROR.
                IF AVAILABLE bevento THEN DO:
                  bevento.fasignado = evento.fasignado.
                /*ver si tenia a su vez un aviso*/
                 RUN recrea_agenda (bevento.nro_evento).
                 FOR EACH baevento WHERE bevento.refevento = baevento.nro_evento:
                     RUN recrea_agenda (baevento.nro_evento).
                 END.
                END.
        END.
        
        RUN desasignar_avisos(fechad,recursod).

    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE recrea_agenda B-table-Win 
PROCEDURE recrea_agenda :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAMETER pevento LIKE evento.nro_evento.
DEFINE BUFFER recevento FOR evento.
DEFINE VAR i AS INT NO-UNDO.
    FIND recevento WHERE recevento.nro_evento = pevento NO-ERROR.
    IF NOT AVAILABLE recevento  THEN RETURN.

    DO i = 1 TO NUM-ENTRIES(recevento.recursos):
          FIND recurso_agenda WHERE recurso_agenda.cdg_recurso = ENTRY(i,recevento.recurso) AND
              recurso_agenda.nro_evento = recevento.nro_evento NO-ERROR.
          IF NOT AVAILABLE recurso_agenda THEN DO:
              CREATE recurso_agenda.
              ASSIGN recurso_agenda.cdg_recurso = ENTRY(i,recevento.recurso)
                     recurso_agenda.nro_evento = recevento.nro_evento.
          END.
          ASSIGN  recurso_agenda.fecha = recevento.fasignado.
      END.
          /*crear el aviso si corresponde a ese evento.*/
      RUN crea_aviso_evento.p ( INPUT ROWID(recevento) ).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE selevento B-table-Win 
PROCEDURE selevento :
/*------------------------------------------------------------------------------
  Purpose: nos da el dia en la agenda del evento bajo el cursor del periodo solicitado  
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAMETER pperiodo AS INT NO-UNDO.
DEFINE OUTPUT PARAMETER selevento AS DATE NO-UNDO.

DEFINE BUFFER bevento FOR evento.

selevento = ?.
    IF AVAILABLE evento THEN DO:
        FIND bevento WHERE bevento.nro_identificacion = evento.nro_identificacion AND
                           bevento.sub_evento = evento.sub_evento AND
                           bevento.periodo = pperiodo NO-LOCK NO-ERROR.
        IF AVAILABLE bevento THEN DO:
                IF bevento.frealizado <> ?  THEN selevento = bevento.frealizado.
                ELSE
                   IF bevento.fasignado <> ? THEN selevento = bevento.fasignado.
        END.
    END.
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

RETURN adur( d , h)  .   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION exrdur B-table-Win 
FUNCTION exrdur RETURNS INTEGER
  ( rr AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  Duracion media
    Notes:  Se tiene en cuenta de descartar valores  alejados +- 20% de la media
------------------------------------------------------------------------------*/
RETURN 0.
DEFINE VAR kk AS INT NO-UNDO.
DEFINE VAR pp1 AS INT NO-UNDO.
DEFINE VAR media AS INT NO-UNDO.
DEFINE VAR suma AS INT NO-UNDO.
DEFINE VAR pp AS INT INITIAL 5 NO-UNDO. /*cantidad de periodos maximos de analisis*/
DEFINE BUFFER bevento FOR evento.
DEFINE BUFFER weve FOR evento.
pp1 = 0.
suma = 0.
FIND weve WHERE weve.nro_evento = rr NO-LOCK.
CASE weve.origen:
WHEN "CONTRATO" THEN DO:
    FOR EACH bevento WHERE bevento.origen = weve.origen AND 
        bevento.nro_cliente = weve.nro_cliente AND
        bevento.nro_tipo_evento = evento.nro_tipo_evento AND
        bevento.sub_evento = weve.sub_evento AND
        NOT bevento.anulado AND bevento.frealizado<>? BY bevento.fasignado DESCENDING:
        kk = abs(adur(bevento.hora_desde, bevento.hora_hasta)).
        IF kk = 0 OR kk = ? THEN NEXT.
        pp1 = pp1 + 1.
        suma = suma + kk.
        IF pp1 > pp THEN LEAVE.
    END.
    media = suma / pp1.
    pp1 = 0.
    suma = 0.
        FOR EACH bevento WHERE bevento.origen = weve.origen AND 
        bevento.nro_cliente = weve.nro_cliente AND
        bevento.nro_tipo_evento = evento.nro_tipo_evento AND
         NOT bevento.anulado AND bevento.frealizado<>? BY bevento.fasignado DESCENDING:
            kk = adur(bevento.hora_desde, bevento.hora_hasta).
            IF kk = ? THEN NEXT.
            IF kk <= media * .8 OR kk >= media * 1.2 THEN NEXT.
        pp1 = pp1 + 1.
        suma = suma + adur(bevento.hora_desde, bevento.hora_hasta).
        IF pp1 > pp THEN LEAVE.
    END.
    media = suma / pp1.
    RETURN media.
END.
WHEN "COBRANZA" THEN DO:
    FOR EACH bevento WHERE bevento.nro_cliente = weve.nro_cliente AND 
        bevento.nro_tipo_evento = weve.nro_tipo_evento AND
        NOT bevento.anulado AND bevento.frealizado<>? BY bevento.fasignado DESCENDING:
        kk = abs(adur(bevento.hora_desde, bevento.hora_hasta)).
        IF kk = 0 OR kk = ? THEN NEXT.
        pp1 = pp1 + 1.
        suma = suma + kk.
        IF pp1 > pp THEN LEAVE.
    END.
    media = suma / pp1.
    pp1 = 0.
    suma = 0.
        FOR EACH bevento WHERE bevento.nro_cliente = weve.nro_cliente AND 
        bevento.nro_tipo_evento = weve.nro_tipo_evento AND
        NOT bevento.anulado AND bevento.frealizado<>? BY bevento.fasignado DESCENDING:
            kk = adur(bevento.hora_desde, bevento.hora_hasta).
            IF kk = ? THEN NEXT.
            IF kk <= media * .8 OR kk >= media * 1.2 THEN NEXT.
        pp1 = pp1 + 1.
        suma = suma + adur(bevento.hora_desde, bevento.hora_hasta).
        IF pp1 > pp THEN LEAVE.
    END.
    media = suma / pp1.
    RETURN media.
END.
OTHERWISE RETURN ?.
END.
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fcertif B-table-Win 
FUNCTION fcertif RETURNS CHARACTER
  ( nro AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
  FIND evento WHERE evento.nro_evento = nro NO-LOCK NO-ERROR.
  
  RETURN Evento.LetraPrefijo + STRING(evento.nro_certificado).   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION leyctr B-table-Win 
FUNCTION leyctr RETURNS CHARACTER
  ( nro AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
  FIND evento WHERE evento.nro_evento = nro NO-LOCK NO-ERROR.
  IF evento.origen = "CONTRATO" THEN DO:
      FIND contrato_hd WHERE contrato_hd.nro_contrato = evento.nro_identificacion NO-LOCK NO-ERROR.
      IF AVAILABLE contrato_hd THEN RETURN contrato_hd.leyenda.
  END.
  RETURN "".   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION nombre_admin B-table-Win 
FUNCTION nombre_admin RETURNS CHARACTER
  ( nro AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
  FIND evento WHERE evento.nro_evento = nro NO-LOCK NO-ERROR.
  IF AVAILABLE evento THEN DO: 
      FIND cliente OF evento NO-LOCK NO-ERROR.
      IF AVAILABLE cliente THEN do:
        FIND administrador WHERE administrador.nro_cliente = cliente.nro_admin NO-LOCK NO-ERROR.
        IF AVAILABLE administrador THEN 
            RETUrn administrador.nom_cliente.
    END.
  END.
  RETURN "".   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION precio B-table-Win 
FUNCTION precio RETURNS DECIMAL
  ( nro AS int64 ) :
/*------------------------------------------------------------------------------
  Purpose:  sin 01f,23f o 05m
    Notes:  
------------------------------------------------------------------------------*/
DEFINE VAR ac AS DECIMAL NO-UNDO.
IF NOT inforeservada  THEN RETURN ?.
FIND evento WHERE nro_evento = nro NO-LOCK.
  IF evento.origen = "Contrato" THEN DO:
      FIND contrato_hd WHERE contrato_hd.nro_contrato = evento.nro_identificacion NO-LOCK.
      IF AVAILABLE contrato_hd THEN DO:
          FOR EACH contrato_dt OF contrato_hd, articulo OF contrato_dt NO-LOCK:
              IF CAN-DO("01f,05m,23F",articulo.cdg_articulo) THEN NEXT.
              ac = ac + contrato_dt.subtotal_neto_cf.
          END.
      END.
          RETURN ac.
  END.
  RETURN 0.00.   /* Function return value. */

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
RETURN 0.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION setnrotipo B-table-Win 
FUNCTION setnrotipo RETURNS CHARACTER
  ( tipo AS CHAR ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
  nrotipo = IF tipo = "0" THEN "*" ELSE tipo.
  RETURN nrotipo.   /* Function return value. */
  {&OPEN-QUERY-{&BROWSE-NAME}}
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION tienevortex B-table-Win 
FUNCTION tienevortex RETURNS CHARACTER
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
IF NOT AVAILABLE evento THEN RETURN ?.
RETURN IF can-find( first vortex where vortex.carpeta = "EVENTOS" and vortex.indice = string(evento.nro_evento)) THEN "S" ELSE "N".

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION unidades B-table-Win 
FUNCTION unidades RETURNS INTEGER
  ( pnro AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
  FIND cliente_otros_datos WHERE cliente_otros_datos.nro_cliente = pnro NO-LOCK NO-ERROR.
  IF AVAILABLE cliente_otros_datos THEN RETURN cliente_otros_datos.unidades.
  RETURN ?.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

