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
DEF VAR qstr0 AS CHAR NO-UNDO INITIAL "for each fac_header where true ".
DEF VAR qstr AS CHAR NO-UNDO.
DEF VAR paga AS CHAR FORMAT "X".


qstr = qstr0. /*valor inicial*/

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
&Scoped-define INTERNAL-TABLES Fac_header Cliente

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Fac_header.anulado ~
Fac_header.impreso pagado() @ paga Fac_header.fecha Fac_header.tip_comprob ~
Fac_header.prf_comprob Fac_header.nro_comprob Fac_header.imp_total ~
Fac_header.nro_contrato Cliente.cdg_cliente Fac_header.nombre ~
Fac_header.direccion 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table 
&Scoped-define QUERY-STRING-br_table FOR EACH Fac_header WHERE ~{&KEY-PHRASE} NO-LOCK, ~
      EACH Cliente OF Fac_header NO-LOCK ~
    ~{&SORTBY-PHRASE}
&Scoped-define OPEN-QUERY-br_table OPEN QUERY br_table FOR EACH Fac_header WHERE ~{&KEY-PHRASE} NO-LOCK, ~
      EACH Cliente OF Fac_header NO-LOCK ~
    ~{&SORTBY-PHRASE}.
&Scoped-define TABLES-IN-QUERY-br_table Fac_header Cliente
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Fac_header
&Scoped-define SECOND-TABLE-IN-QUERY-br_table Cliente


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br_table fblogico b-query fbdesde fbusqueda ~
b-nueva fbhasta 
&Scoped-Define DISPLAYED-OBJECTS fblabel fblogico fbdesde fbusqueda fbhasta 

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
<FOREIGN-KEYS></FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = ,
     Keys-Supplied = ':U).

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
fecha|y||sic.Fac_header.fecha|no
</SORTBY-OPTIONS>
<SORTBY-RUN-CODE>
************************
* Set attributes related to SORTBY-OPTIONS */
RUN set-attribute-list (
    'SortBy-Options = "':U + 'fecha' + '",
     SortBy-Case = ':U + 'fecha').

/* Tell the ADM to use the OPEN-QUERY-CASES. */
&Scoped-define OPEN-QUERY-CASES RUN dispatch ('open-query-cases':U).

/************************
</SORTBY-RUN-CODE>
<FILTER-ATTRIBUTES>
</FILTER-ATTRIBUTES> */   

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD pagado B-table-Win 
FUNCTION pagado RETURNS CHARACTER
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE BUTTON b-nueva 
     LABEL "Nueva" 
     SIZE 10.8 BY 1.14.

DEFINE BUTTON b-query 
     LABEL "Query" 
     SIZE 10 BY 1.14.

DEFINE VARIABLE fbdesde AS CHARACTER FORMAT "X(256)":U 
     LABEL "Desde" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 22 BY 1 NO-UNDO.

DEFINE VARIABLE fbhasta AS CHARACTER FORMAT "X(256)":U 
     LABEL "-" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 22 BY 1 NO-UNDO.

DEFINE VARIABLE fblabel AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 16 BY 1 NO-UNDO.

DEFINE VARIABLE fbusqueda AS CHARACTER FORMAT "X(256)":U 
     LABEL "Numero" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 91 BY 1 NO-UNDO.

DEFINE VARIABLE fblogico AS CHARACTER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Todos", "*",
"Si", "TRUE",
"No", "FALSE"
     SIZE 38 BY 1 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Fac_header, 
      Cliente SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _STRUCTURED
  QUERY br_table NO-LOCK DISPLAY
      Fac_header.anulado COLUMN-LABEL "Anu-!lado" FORMAT "Si/No":U
      Fac_header.impreso COLUMN-LABEL "I" FORMAT "X":U
      pagado() @ paga COLUMN-LABEL "Pag." WIDTH 4
      Fac_header.fecha COLUMN-LABEL "Fecha!Emisión" FORMAT "99/99/9999":U
      Fac_header.tip_comprob COLUMN-LABEL "Ti-!po" FORMAT "X(3)":U
      Fac_header.prf_comprob COLUMN-LABEL "Pre-!fijo" FORMAT "9999":U
      Fac_header.nro_comprob COLUMN-LABEL "Número!Comprob" FORMAT "ZZZZZZZ9":U
      Fac_header.imp_total COLUMN-LABEL "Importe!Total" FORMAT "->,>>>,>>>,>>9.99":U
      Fac_header.nro_contrato COLUMN-LABEL "Numero!Contrato" FORMAT "ZZZZZ9":U
      Cliente.cdg_cliente FORMAT "X(8)":U
      Fac_header.nombre COLUMN-LABEL "Razón!Social" FORMAT "X(40)":U
      Fac_header.direccion COLUMN-LABEL "Dirección!Facturación" FORMAT "X(45)":U
            WIDTH 38.2
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 157 BY 23.52 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     br_table AT ROW 2.71 COL 1
     fblabel AT ROW 1.48 COL 2 NO-LABEL WIDGET-ID 24 NO-TAB-STOP 
     fblogico AT ROW 1.48 COL 18 NO-LABEL WIDGET-ID 20
     b-query AT ROW 1.33 COL 123 WIDGET-ID 16 NO-TAB-STOP 
     fbdesde AT ROW 1.33 COL 16.2 COLON-ALIGNED WIDGET-ID 10
     fbusqueda AT ROW 1.33 COL 16.2 COLON-ALIGNED WIDGET-ID 2
     b-nueva AT ROW 1.33 COL 111.2 WIDGET-ID 4 NO-TAB-STOP 
     fbhasta AT ROW 1.33 COL 41.2 COLON-ALIGNED WIDGET-ID 12
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
         HEIGHT             = 27.67
         WIDTH              = 160.
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
   NOT-VISIBLE FRAME-NAME Size-to-Fit Custom                            */
/* BROWSE-TAB br_table 1 F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

ASSIGN 
       br_table:ALLOW-COLUMN-SEARCHING IN FRAME F-Main = TRUE.

ASSIGN 
       fbdesde:HIDDEN IN FRAME F-Main           = TRUE.

ASSIGN 
       fbhasta:HIDDEN IN FRAME F-Main           = TRUE.

/* SETTINGS FOR FILL-IN fblabel IN FRAME F-Main
   NO-ENABLE ALIGN-L                                                    */
ASSIGN 
       fblabel:HIDDEN IN FRAME F-Main           = TRUE
       fblabel:READ-ONLY IN FRAME F-Main        = TRUE.

ASSIGN 
       fblogico:HIDDEN IN FRAME F-Main           = TRUE.

ASSIGN 
       fbusqueda:HIDDEN IN FRAME F-Main           = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _TblList          = "sic.Fac_header,sic.Cliente OF sic.Fac_header"
     _Options          = "NO-LOCK KEY-PHRASE SORTBY-PHRASE"
     _FldNameList[1]   > sic.Fac_header.anulado
"Fac_header.anulado" "Anu-!lado" ? "logical" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[2]   > sic.Fac_header.impreso
"Fac_header.impreso" "I" "X" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[3]   > "_<CALC>"
"pagado() @ paga" "Pag." ? ? ? ? ? ? ? ? no ? no no "4" yes no no "U" "" ""
     _FldNameList[4]   > sic.Fac_header.fecha
"Fac_header.fecha" "Fecha!Emisión" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[5]   > sic.Fac_header.tip_comprob
"Fac_header.tip_comprob" "Ti-!po" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[6]   > sic.Fac_header.prf_comprob
"Fac_header.prf_comprob" "Pre-!fijo" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[7]   > sic.Fac_header.nro_comprob
"Fac_header.nro_comprob" "Número!Comprob" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[8]   > sic.Fac_header.imp_total
"Fac_header.imp_total" "Importe!Total" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[9]   > sic.Fac_header.nro_contrato
"Fac_header.nro_contrato" "Numero!Contrato" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[10]   = sic.Cliente.cdg_cliente
     _FldNameList[11]   > sic.Fac_header.nombre
"Fac_header.nombre" "Razón!Social" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[12]   > sic.Fac_header.direccion
"Fac_header.direccion" "Dirección!Facturación" ? "character" ? ? ? ? ? ? no ? no no "38.2" yes no no "U" "" ""
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

&Scoped-define SELF-NAME b-nueva
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b-nueva B-table-Win
ON CHOOSE OF b-nueva IN FRAME F-Main /* Nueva */
DO:
DEF VAR qc AS HANDLE NO-UNDO.
DEF VAR qb AS HANDLE NO-UNDO.
DEF VAR qh AS HANDLE NO-UNDO.

qb = {&BROWSE-NAME}:HANDLE IN FRAME {&FRAME-NAME}.
qh = QUERY {&BROWSE-NAME}:HANDLE IN FRAME {&FRAME-NAME}.
qstr = qstr0. /*blanqueo*/
qc = qb:FIRST-COLUMN.
DO WHILE valid-handle(qc):
    qc:PRIVATE-DATA = ?.
    qc:LABEL-BGCOLOR = ?.
  qc = qc:NEXT-COLUMN.
END.
fbusqueda:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
fbdesde:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
fbhasta:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
qstr = qstr + " BY Fac_header.fecha DESCENDING".
qh:QUERY-PREPARE(qstr).
qh:QUERY-OPEN.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME b-query
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b-query B-table-Win
ON CHOOSE OF b-query IN FRAME F-Main /* Query */
DO:
  MESSAGE qstr
      VIEW-AS ALERT-BOX INFO BUTTONS OK.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_table
&Scoped-define SELF-NAME br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON MOUSE-SELECT-DBLCLICK OF br_table IN FRAME F-Main
OR "RETURN" OF br_table IN FRAME {&FRAME-NAME}
DO:
    DEF VAR act_fac_head AS ROWID.
    DEF VAR ant_anulado AS LOGICAL.
    DEF VAR act_rec_head AS ROWID.
              
    act_fac_head = ROWID(Fac_header).
    ant_anulado = Fac_header.anulado. 
    RUN ocultar_window.
    RUN c-pos_cliente.w ( INPUT-OUTPUT act_fac_head , INPUT 2, INPUT Fac_header.cdg_comprobante ).
    RUN mostrar_window.
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
ON START-SEARCH OF br_table IN FRAME F-Main
DO:
  IF SUBSTRING(SELF:PRIVATE-DATA,1,2)<> "1" + CHR(1) THEN DO:
      SELF:PRIVATE-DATA = "1" + chr(1) + STRING(SELF:CURRENT-COLUMN).
      fblabel:screen-value IN FRAME {&FRAME-NAME} = SELF:CURRENT-COLUMN:LABEL.
      fblabel:hidden IN FRAME {&FRAME-NAME} = FALSE.
      CASE SELF:CURRENT-COLUMN:DATA-TYPE:
          WHEN "DATE" OR WHEN "INTEGER" or WHEN "DECIMAL"  THEN DO:
                fbdesde:SCREEN-VALUE IN FRAME {&FRAME-NAME} = entry(1,entry(1,SELF:CURRENT-COLUMN:PRIVATE-DATA,CHR(1)),"|").
                fbdesde:hidden IN FRAME {&FRAME-NAME} = FALSE.
                fbdesde:sensitive IN FRAME {&FRAME-NAME} = TRUE.
                fbhasta:SCREEN-VALUE IN FRAME {&FRAME-NAME} = entry(2,entry(1,SELF:CURRENT-COLUMN:PRIVATE-DATA,CHR(1)),"|").
                fbhasta:hidden IN FRAME {&FRAME-NAME} = FALSE.
                fbhasta:sensitive IN FRAME {&FRAME-NAME} = TRUE.
                APPLY "entry" TO fbdesde.
          END.
          WHEN "CHARACTER" THEN DO:
              fbusqueda:SCREEN-VALUE IN FRAME {&FRAME-NAME} = entry(1,SELF:CURRENT-COLUMN:PRIVATE-DATA,CHR(1)).
              fbusqueda:hidden IN FRAME {&FRAME-NAME} = FALSE.
              fbusqueda:sensitive IN FRAME {&FRAME-NAME} = TRUE.
              APPLY "entry" TO fbusqueda.
          END.
          WHEN "LOGICAL" THEN DO:
            IF entry(1,SELF:CURRENT-COLUMN:PRIVATE-DATA,CHR(1)) <> ? THEN
            fblogico:SCREEN-VALUE IN FRAME {&FRAME-NAME} = entry(1,SELF:CURRENT-COLUMN:PRIVATE-DATA,CHR(1)).
            fblogico:hidden IN FRAME {&FRAME-NAME} = FALSE.
            fblogico:sensitive IN FRAME {&FRAME-NAME} = TRUE.
            APPLY "entry" TO fblogico.
          END.
      END.
  END. 
  ELSE 
      SELF:CURRENT-COLUMN = WIDGET-HANDLE( ENTRY( 2 , SELF:private-data , CHR(1) )).
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


&Scoped-define SELF-NAME fbdesde
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fbdesde B-table-Win
ON LEAVE OF fbdesde IN FRAME F-Main /* Desde */
DO:
  APPLY "entry" TO fbhasta.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fbdesde B-table-Win
ON RETURN OF fbdesde IN FRAME F-Main /* Desde */
DO:
  APPLY "entry" TO fbhasta.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fbhasta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fbhasta B-table-Win
ON LEAVE OF fbhasta IN FRAME F-Main /* - */
DO:
DEF VAR i AS INT NO-UNDO.
DEF VAR dd AS DECIMAL NO-UNDO.
DEF VAR dh AS DECIMAL NO-UNDO.
DEF VAR pdd AS DATE NO-UNDO.
DEF VAR pdh AS DATE NO-UNDO.

DEF VAR qh AS HANDLE NO-UNDO.
DEF VAR qc AS HANDLE NO-UNDO.
DEF VAR qb AS HANDLE NO-UNDO.
DEF VAR todook AS LOGICAL NO-UNDO.
DEF VAR bgok AS INT NO-UNDO INITIAL 14.
  qb = {&BROWSE-NAME}:HANDLE IN FRAME {&FRAME-NAME}.
  qh = QUERY {&BROWSE-NAME}:HANDLE IN FRAME {&FRAME-NAME}.
  qc = WIDGET-HANDLE(entry(2, qb:PRIVATE-DATA, CHR(1) )).
IF fbdesde:MODIFIED OR fbhasta:MODIFIED THEN DO:
  ASSIGN FRAME {&FRAME-NAME} fbdesde fbhasta.
  IF qc:DATA-TYPE = "INTEGER" OR qc:DATA-TYPE = "DECIMAL" THEN DO:
      IF fbdesde <> "" OR fbhasta <> "" THEN DO:
          dd = DECIMAL(fbdesde) NO-ERROR.
          todook = error-status:ERROR.
          dh = DECIMAL(fbhasta) NO-ERROR.
          todook = todook OR error-status:ERROR.
          IF NOT todook THEN DO:
             qc:PRIVATE-DATA = fbdesde + "|" + fbhasta + chr(1) + "and fac_header." + qc:NAME + " >= " + fbdesde + " and fac_header." + qc:NAME + " <= " + fbhasta + " ".
             qc:LABEL-BGCOLOR = bgok.
          END.
          ELSE DO:
             qc:PRIVATE-DATA = ?.
             qc:LABEL-BGCOLOR = 12.
          END.
      END.
          ELSE DO:
             qc:PRIVATE-DATA = ?.
             qc:LABEL-BGCOLOR = ?.
          END.
  END.
  IF qc:DATA-TYPE = "DATE" THEN DO:
      IF fbdesde <> "" OR fbhasta <> "" THEN DO:
          pdd = DATE( fbdesde ) NO-ERROR.
          todook = error-status:ERROR.
          pdh = DATE( fbhasta ) NO-ERROR.
          todook = todook OR error-status:ERROR.
          IF NOT todook THEN DO:
             qc:PRIVATE-DATA = fbdesde + "|" + fbhasta + chr(1) + "and fac_header." + qc:NAME + " >= " +  string(pdd) + " and fac_header." + qc:NAME + " <= " +  string(pdh) + " ".
             qc:LABEL-BGCOLOR = bgok.
          END.
          ELSE DO:
             qc:PRIVATE-DATA = ?.
             qc:LABEL-BGCOLOR = 12.
          END.
      END.
          ELSE DO:
             qc:PRIVATE-DATA = ?.
             qc:LABEL-BGCOLOR = ?.
          END.
  END.
END.
  fbdesde:HIDDEN IN FRAME {&FRAME-NAME} = TRUE.
  fbdesde:SENSITIVE IN FRAME {&FRAME-NAME} = FALSE.
  fbhasta:HIDDEN IN FRAME {&FRAME-NAME} = TRUE.
  fbhasta:SENSITIVE IN FRAME {&FRAME-NAME} = FALSE.

  RUN reposicionar.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fbhasta B-table-Win
ON return OF fbhasta IN FRAME F-Main /* - */
DO:
    APPLY "leave" TO fbhasta.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fblogico
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fblogico B-table-Win
ON LEAVE OF fblogico IN FRAME F-Main
DO:
DEF VAR i AS INT NO-UNDO.
DEF VAR dd AS DECIMAL NO-UNDO.
DEF VAR qh AS HANDLE NO-UNDO.
DEF VAR qc AS HANDLE NO-UNDO.
DEF VAR qb AS HANDLE NO-UNDO.
DEF VAR bgok AS INT NO-UNDO INITIAL 14.
  qb = {&BROWSE-NAME}:HANDLE IN FRAME {&FRAME-NAME}.
  qh = QUERY {&BROWSE-NAME}:HANDLE IN FRAME {&FRAME-NAME}.
  qc = WIDGET-HANDLE(entry(2, qb:PRIVATE-DATA, CHR(1) )).
  
  ASSIGN FRAME {&FRAME-NAME} fblogico.
  IF fblogico=? or fblogico = "*" THEN DO:
                 qc:PRIVATE-DATA = ?.
                 qc:LABEL-BGCOLOR = ?.
  END.
  ELSE DO:
      qc:PRIVATE-DATA = fblogico + chr(1) + "and fac_header." + qc:NAME + " = " + fblogico + " ".
      qc:LABEL-BGCOLOR = bgok.
  END.
  fblogico:HIDDEN IN FRAME {&FRAME-NAME} = TRUE.
  fblogico:SENSITIVE IN FRAME {&FRAME-NAME} = FALSE.
  
  RUN reposicionar.

  END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fbusqueda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fbusqueda B-table-Win
ON LEAVE OF fbusqueda IN FRAME F-Main /* Numero */
DO:
DEF VAR i AS INT NO-UNDO.
DEF VAR dd AS DECIMAL NO-UNDO.
DEF VAR qh AS HANDLE NO-UNDO.
DEF VAR qc AS HANDLE NO-UNDO.
DEF VAR qb AS HANDLE NO-UNDO.
DEF VAR bgok AS INT NO-UNDO INITIAL 14.
  qb = {&BROWSE-NAME}:HANDLE IN FRAME {&FRAME-NAME}.
  qh = QUERY {&BROWSE-NAME}:HANDLE IN FRAME {&FRAME-NAME}.
  qc = WIDGET-HANDLE(entry(2, qb:PRIVATE-DATA, CHR(1) )).
IF fbusqueda:MODIFIED THEN DO:
  ASSIGN FRAME {&FRAME-NAME} fbusqueda.
  IF fbusqueda="" THEN DO:
               qc:PRIVATE-DATA = ?.
               qc:LABEL-BGCOLOR = ?.
  END.
  ELSE DO:
      CASE qc:NAME:
          WHEN "direccion" THEN DO:
                   qc:PRIVATE-DATA = fbusqueda + chr(1) + "and fac_header.direccion contains '" + fbusqueda + "' ".
                   qc:LABEL-BGCOLOR = bgok.
          END.
          WHEN "nombre" THEN DO:
                 qc:PRIVATE-DATA = fbusqueda + chr(1) + "and fac_header.nombre contains '" + fbusqueda + "' ".
                 qc:LABEL-BGCOLOR = bgok.
              END. 
          OTHERWISE DO:
              qc:PRIVATE-DATA = fbusqueda + chr(1) + "and fac_header." + QC:NAME + " >= " + fbusqueda + "' ".
              qc:LABEL-BGCOLOR = bgok.
          END.
      END.
  END.
END.
  
  fbusqueda:HIDDEN IN FRAME {&FRAME-NAME} = TRUE.
  fbusqueda:SENSITIVE IN FRAME {&FRAME-NAME} = FALSE.
  RUN reposicionar.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fbusqueda B-table-Win
ON RETURN OF fbusqueda IN FRAME F-Main /* Numero */
DO:
  APPLY "leave" TO SELF.
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

  RUN get-attribute ('SortBy-Case':U).
  CASE RETURN-VALUE:
    WHEN 'fecha':U THEN DO:
      &Scope SORTBY-PHRASE BY Fac_header.fecha DESCENDING
      {&OPEN-QUERY-{&BROWSE-NAME}}
    END.
    OTHERWISE DO:
      &Undefine SORTBY-PHRASE
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE mostrar_window B-table-Win 
PROCEDURE mostrar_window :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE p-link-hdls AS CHARACTER.
  DEFINE VARIABLE h-handle    AS HANDLE.

  RUN get-link-handle IN adm-broker-hdl
    ( INPUT THIS-PROCEDURE /* HANDLE */,
      INPUT "Container-Source" /* CHARACTER */,
      OUTPUT p-link-hdls /* CHARACTER */).

  h-handle = WIDGET-HANDLE(p-link-hdls).
  IF VALID-HANDLE(h-handle)
      THEN RUN mostrar_window IN h-handle.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ocultar_window B-table-Win 
PROCEDURE ocultar_window :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  
  DEFINE VARIABLE p-link-hdls AS CHARACTER.
  DEFINE VARIABLE h-handle    AS HANDLE.

  RUN get-link-handle IN adm-broker-hdl
    ( INPUT THIS-PROCEDURE /* HANDLE */,
      INPUT "Container-Source" /* CHARACTER */,
      OUTPUT p-link-hdls /* CHARACTER */).

  h-handle = WIDGET-HANDLE(p-link-hdls).
  IF VALID-HANDLE(h-handle)
      THEN RUN ocultar_window IN h-handle.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE reposicionar B-table-Win 
PROCEDURE reposicionar :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR qh AS HANDLE NO-UNDO.
DEF VAR qc AS HANDLE NO-UNDO.
DEF VAR qb AS HANDLE NO-UNDO.
  qb = {&BROWSE-NAME}:HANDLE IN FRAME {&FRAME-NAME}.
  qh = QUERY {&BROWSE-NAME}:HANDLE IN FRAME {&FRAME-NAME}.


  fblabel:hidden IN FRAME {&FRAME-NAME} = TRUE.
  qstr = qstr0. /*blanqueo*/
  qc = qb:FIRST-COLUMN.
  DO WHILE valid-handle(qc):
      IF qc:PRIVATE-DATA <> ? AND qc:PRIVATE-DATA <> "" THEN qstr = qstr + entry(2,qc:PRIVATE-DATA,CHR(1)).
    qc = qc:NEXT-COLUMN.
  END.
  qstr = qstr + " BY Fac_header.fecha DESCENDING".
  qh:QUERY-PREPARE(qstr).
  qh:QUERY-OPEN.
  qb:PRIVATE-DATA = ?.
  APPLY "ENTRY" TO br_table.
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

  /* There are no foreign keys supplied by this SmartObject. */

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
  {src/adm/template/snd-list.i "Fac_header"}
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ver_ctacte B-table-Win 
PROCEDURE ver_ctacte :
/*------------------------------------------------------------------------------
  Purpose:     ver como se abono el contrato
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DEFINE INPUT PARAMETER rid AS ROWID.
DEFINE OUTPUT PARAMETER tot_debitogr AS DECIMAL.
DEFINE OUTPUT PARAMETER tot_creditogr AS DECIMAL.

DEF BUFFER bfac_header FOR fac_header.
DEF BUFFER b-cta_cte FOR cta_cte.


   tot_debitogr = 0.
   tot_creditogr = 0.

   FIND bfac_header WHERE ROWID(bfac_header) = rid NO-LOCK NO-ERROR.
   IF AVAILABLE bfac_header THEN DO:
   /* Busca por Movimiento en la ctacte */
   FOR EACH B-Cta_cte OF Cliente 
      WHERE B-Cta_cte.cdg_empresa = bfac_header.cdg_empresa
        AND B-Cta_cte.prf_comprob = bfac_header.prf_comprob:
      IF CAN-DO(str_debitan,B-Cta_cte.tip_comprob)
         THEN  tot_debitogr  = tot_debitogr + B-Cta_cte.debito.
         ELSE  tot_creditogr = tot_creditogr + B-Cta_cte.credito.
   END.
   END.    */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION pagado B-table-Win 
FUNCTION pagado RETURNS CHARACTER
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
  FIND cta_cte WHERE
      cta_cte.cdg_empresa = fac_header.cdg_empresa AND
      cta_cte.tip_comprob = fac_header.tip_comprob AND
      cta_cte.prf_comprob = fac_header.prf_comprob AND
      cta_cte.nro_comprob = fac_header.nro_comprob NO-LOCK NO-ERROR.
  IF AVAILABLE cta_cte THEN DO:
IF cta_cte.credito = 0 and cta_cte.debito = 0  then paga = "S".
else
      IF cta_cte.credito = 0 OR cta_cte.debito = 0 
          THEN paga = "N".
          ELSE IF cta_cte.credito = cta_cte.debito 
              THEN paga = "S".
              ELSE paga = "P".
  END.
  ELSE paga = "?".
     
  RETURN paga.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

