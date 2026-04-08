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

DEFINE VAR que_estado AS CHAR NO-UNDO FORMAT "x(10)".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartBrowser
&Scoped-define DB-AWARE no

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME F-Main
&Scoped-define BROWSE-NAME br_table

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES Rendicion_hd
&Scoped-define FIRST-EXTERNAL-TABLE Rendicion_hd


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Rendicion_hd.
/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Caj_header Caj_detalle Rubro Valor

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Rubro.cdg_rubro Rubro.nombre ~
Caj_detalle.importe Valor.fecha_emision Valor.cdg_banco Valor.num_sucursal ~
Valor.numero_cheque que_estado( valor.estado ) @ que_estado ~
Caj_detalle.observacion 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table 
&Scoped-define QUERY-STRING-br_table FOR EACH Caj_header OF Rendicion_hd WHERE ~{&KEY-PHRASE} NO-LOCK, ~
      EACH Caj_detalle OF Caj_header NO-LOCK, ~
      FIRST Rubro OF Caj_detalle NO-LOCK, ~
      FIRST Valor OF Caj_detalle OUTER-JOIN NO-LOCK ~
    BY Rubro.cdg_rubro
&Scoped-define OPEN-QUERY-br_table OPEN QUERY br_table FOR EACH Caj_header OF Rendicion_hd WHERE ~{&KEY-PHRASE} NO-LOCK, ~
      EACH Caj_detalle OF Caj_header NO-LOCK, ~
      FIRST Rubro OF Caj_detalle NO-LOCK, ~
      FIRST Valor OF Caj_detalle OUTER-JOIN NO-LOCK ~
    BY Rubro.cdg_rubro.
&Scoped-define TABLES-IN-QUERY-br_table Caj_header Caj_detalle Rubro Valor
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Caj_header
&Scoped-define SECOND-TABLE-IN-QUERY-br_table Caj_detalle
&Scoped-define THIRD-TABLE-IN-QUERY-br_table Rubro
&Scoped-define FOURTH-TABLE-IN-QUERY-br_table Valor


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
cdg_caja||y|sic.Caj_header.cdg_caja
nro_transaccion||y|sic.Caj_header.nro_transaccion
cdg_circuito||y|sic.Caj_header.cdg_circuito
nro_cliente||y|sic.Caj_header.nro_cliente
tip_comprob||y|sic.Caj_header.tip_comprob
nro_cuenta||y|sic.Caj_header.nro_cuenta
cdg_empresa||y|sic.Caj_header.cdg_empresa
nro_entidad||y|sic.Caj_header.nro_entidad
fecha||y|sic.Caj_header.fecha
nro_moneda||y|sic.Caj_header.nro_moneda
nro_obra||y|sic.Caj_header.nro_obra
nro_proveedor||y|sic.Caj_header.nro_proveedor
num_sucursal||y|sic.Caj_header.num_sucursal
nro_usuario||y|sic.Caj_header.nro_usuario
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = ,
     Keys-Supplied = "cdg_caja,nro_transaccion,cdg_circuito,nro_cliente,tip_comprob,nro_cuenta,cdg_empresa,nro_entidad,fecha,nro_moneda,nro_obra,nro_proveedor,num_sucursal,nro_usuario"':U).

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD que_estado B-table-Win 
FUNCTION que_estado RETURNS CHARACTER
  ( st AS CHAR )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Caj_header, 
      Caj_detalle, 
      Rubro, 
      Valor SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _STRUCTURED
  QUERY br_table NO-LOCK DISPLAY
      Rubro.cdg_rubro COLUMN-LABEL "Còdigo!Rubro" FORMAT ">>9":U
      Rubro.nombre COLUMN-LABEL "Nombre!Rubro" FORMAT "X(35)":U
            WIDTH 18.8
      Caj_detalle.importe COLUMN-LABEL "Importe!Movimiento" FORMAT "->>>,>>>,>>9.99":U
      Valor.fecha_emision FORMAT "99/99/99":U
      Valor.cdg_banco FORMAT "999":U WIDTH 9.4
      Valor.num_sucursal FORMAT "X(4)":U
      Valor.numero_cheque FORMAT ">>>>>>>9":U WIDTH 12.2
      que_estado( valor.estado ) @ que_estado COLUMN-LABEL "Estado" FORMAT "x(10)":U
            WIDTH 12.6
      Caj_detalle.observacion FORMAT "X(50)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 107 BY 6.71
         BGCOLOR 11 FGCOLOR 9 .


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
   External Tables: sic.Rendicion_hd
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
         WIDTH              = 119.4.
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
   NOT-VISIBLE Size-to-Fit                                              */
/* BROWSE-TAB br_table 1 F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

ASSIGN 
       br_table:SEPARATOR-FGCOLOR IN FRAME F-Main      = 8.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _TblList          = "sic.Caj_header OF sic.Rendicion_hd,sic.Caj_detalle OF sic.Caj_header,sic.Rubro OF sic.Caj_detalle,sic.Valor OF sic.Caj_detalle"
     _Options          = "NO-LOCK KEY-PHRASE"
     _TblOptList       = ",, FIRST, FIRST OUTER"
     _OrdList          = "sic.Rubro.cdg_rubro|yes"
     _FldNameList[1]   > sic.Rubro.cdg_rubro
"Rubro.cdg_rubro" "Còdigo!Rubro" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > sic.Rubro.nombre
"Rubro.nombre" "Nombre!Rubro" ? "character" ? ? ? ? ? ? no ? no no "18.8" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > sic.Caj_detalle.importe
"Caj_detalle.importe" "Importe!Movimiento" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   = sic.Valor.fecha_emision
     _FldNameList[5]   > sic.Valor.cdg_banco
"Valor.cdg_banco" ? ? "integer" ? ? ? ? ? ? no ? no no "9.4" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   = sic.Valor.num_sucursal
     _FldNameList[7]   > sic.Valor.numero_cheque
"Valor.numero_cheque" ? ? "integer" ? ? ? ? ? ? no ? no no "12.2" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > "_<CALC>"
"que_estado( valor.estado ) @ que_estado" "Estado" "x(10)" ? ? ? ? ? ? ? no ? no no "12.6" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   = sic.Caj_detalle.observacion
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
ON CTRL-SHIFT-ENTER OF br_table IN FRAME F-Main
DO:
    {findempresa.i}
      FIND CURRENT caj_detalle EXCLUSIVE-LOCK.
  UPDATE caj_detalle WITH 2 COLUMNS SIDE-LABELS THREE-D VIEW-AS DIALOG-BOX WITH FRAME f-actualiza2 OVERLAY.
  CREATE Logmenu.
       ASSIGN Logmenu.accion = "corrige-valores-cobranza"
              Logmenu.cdg_empresa = empresa.cdg_empresa 
              Logmenu.cdg_item  = "" 
              Logmenu.fch_desde = TODAY
              Logmenu.hms_desde = STRING(TIME,"HH:MM:SS")
              Logmenu.hor_desde = TIME
              Logmenu.fch_hasta = Logmenu.fch_desde
              Logmenu.hms_hasta = Logmenu.hms_desde 
              Logmenu.hor_hasta = Logmenu.hor_desde
              Logmenu.nro_usuario = Usuario.nro_usuario.
       RELEASE Logmenu.
  HIDE FRAME f-actualiza2 NO-PAUSE.
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).

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
  {src/adm/template/row-list.i "Rendicion_hd"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Rendicion_hd"}

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
  {src/adm/template/sndkycas.i "cdg_caja" "Caj_header" "cdg_caja"}
  {src/adm/template/sndkycas.i "nro_transaccion" "Caj_header" "nro_transaccion"}
  {src/adm/template/sndkycas.i "cdg_circuito" "Caj_header" "cdg_circuito"}
  {src/adm/template/sndkycas.i "nro_cliente" "Caj_header" "nro_cliente"}
  {src/adm/template/sndkycas.i "tip_comprob" "Caj_header" "tip_comprob"}
  {src/adm/template/sndkycas.i "nro_cuenta" "Caj_header" "nro_cuenta"}
  {src/adm/template/sndkycas.i "cdg_empresa" "Caj_header" "cdg_empresa"}
  {src/adm/template/sndkycas.i "nro_entidad" "Caj_header" "nro_entidad"}
  {src/adm/template/sndkycas.i "fecha" "Caj_header" "fecha"}
  {src/adm/template/sndkycas.i "nro_moneda" "Caj_header" "nro_moneda"}
  {src/adm/template/sndkycas.i "nro_obra" "Caj_header" "nro_obra"}
  {src/adm/template/sndkycas.i "nro_proveedor" "Caj_header" "nro_proveedor"}
  {src/adm/template/sndkycas.i "num_sucursal" "Caj_header" "num_sucursal"}
  {src/adm/template/sndkycas.i "nro_usuario" "Caj_header" "nro_usuario"}

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
  {src/adm/template/snd-list.i "Rendicion_hd"}
  {src/adm/template/snd-list.i "Caj_header"}
  {src/adm/template/snd-list.i "Caj_detalle"}
  {src/adm/template/snd-list.i "Rubro"}
  {src/adm/template/snd-list.i "Valor"}

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION que_estado B-table-Win 
FUNCTION que_estado RETURNS CHARACTER
  ( st AS CHAR ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
  CASE st:
        WHEN "00" THEN RETURN "CARTERA".
        WHEN "10" THEN RETURN "DEPOSITADO".
        WHEN "12" THEN RETURN "ACREDITADO".
        WHEN "13" THEN RETURN "RECHAZADO".
        WHEN "14" THEN RETURN "RCH.LEVANT".
        OTHERWISE RETURN st.
  END CASE.
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

