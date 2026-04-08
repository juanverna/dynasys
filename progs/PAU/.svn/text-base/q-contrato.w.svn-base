&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS q-tables 
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

  Description: from QUERY.W - Template For Query objects in the ADM

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

DEFINE VAR gcontrato LIKE contrato_hd.nro_contrato NO-UNDO.
DEFINE VAR gcliente LIKE cliente.nro_cliente NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartQuery
&Scoped-define DB-AWARE no

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,Navigation-Target

&Scoped-define QUERY-NAME Query-Main

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Contrato_hd Cliente

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for QUERY Query-Main                                     */
&Scoped-define SELF-NAME Query-Main
&Scoped-define QUERY-STRING-Query-Main FOR EACH Contrato_hd WHERE ~{&KEY-PHRASE}     AND contrato_hd.nro_contrato = gcontrato NO-LOCK, ~
           EACH Cliente OF contrato_hd NO-LOCK     ~{&SORTBY-PHRASE}
&Scoped-define OPEN-QUERY-Query-Main OPEN QUERY {&SELF-NAME} FOR EACH Contrato_hd WHERE ~{&KEY-PHRASE}     AND contrato_hd.nro_contrato = gcontrato NO-LOCK, ~
           EACH Cliente OF contrato_hd NO-LOCK     ~{&SORTBY-PHRASE}.
&Scoped-define TABLES-IN-QUERY-Query-Main Contrato_hd Cliente
&Scoped-define FIRST-TABLE-IN-QUERY-Query-Main Contrato_hd
&Scoped-define SECOND-TABLE-IN-QUERY-Query-Main Cliente


/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _XFTR "Foreign Keys" q-tables _INLINE
/* Actions: ? adm/support/keyedit.w ? ? ? */
/* STRUCTURED-DATA
<KEY-OBJECT>
&QUERY-NAME
</KEY-OBJECT>
<FOREIGN-KEYS>
nro_cliente|y|y|sic.Contrato_hd.nro_cliente
nro_obra|y|y|sic.Contrato_hd.nro_obra
nombre||y|sic.Contrato_hd.nombre
nro_area||y|sic.Contrato_hd.nro_area
cdg_banco||y|sic.Contrato_hd.cdg_banco
cdg_condiva||y|sic.Contrato_hd.cdg_condiva
nro_cndventa||y|sic.Contrato_hd.nro_cndventa
cdg_consignatario||y|sic.Contrato_hd.cdg_consignatario
nro_contrato||y|sic.Contrato_hd.nro_contrato
cdg_postal||y|sic.Contrato_hd.cdg_postal
cdg_empresa||y|sic.Contrato_hd.cdg_empresa
cdg_formapago||y|sic.Contrato_hd.cdg_formapago
cdg_imputacion||y|sic.Contrato_hd.cdg_imputacion
cdg_lista||y|sic.Contrato_hd.cdg_lista
nro_moneda||y|sic.Contrato_hd.nro_moneda
nro_persona||y|sic.Contrato_hd.nro_persona
cdg_planta||y|sic.Contrato_hd.cdg_planta
nro_plazo||y|sic.Contrato_hd.nro_plazo
cdg_provincia||y|sic.Contrato_hd.cdg_provincia
nro_remito||y|sic.Contrato_hd.nro_remito
cdg_solicitante||y|sic.Contrato_hd.cdg_solicitante
num_sucursal||y|sic.Contrato_hd.num_sucursal
cdg_embarque||y|sic.Contrato_hd.cdg_embarque
nro_usuario||y|sic.Contrato_hd.nro_usuario
nro_vendedor||y|sic.Contrato_hd.nro_vendedor
cdg_zonag||y|sic.Contrato_hd.cdg_zonag
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = "nro_cliente,nro_obra",
     Keys-Supplied = "nro_cliente,nro_obra,nombre,nro_area,cdg_banco,cdg_condiva,nro_cndventa,cdg_consignatario,nro_contrato,cdg_postal,cdg_empresa,cdg_formapago,cdg_imputacion,cdg_lista,nro_moneda,nro_persona,cdg_planta,nro_plazo,cdg_provincia,nro_remito,cdg_solicitante,num_sucursal,cdg_embarque,nro_usuario,nro_vendedor,cdg_zonag"':U).

/* Tell the ADM to use the OPEN-QUERY-CASES. */
&Scoped-define OPEN-QUERY-CASES RUN dispatch ('open-query-cases':U).
/**************************
</EXECUTING-CODE> */
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _XFTR "Advanced Query Options" q-tables _INLINE
/* Actions: ? adm/support/advqedit.w ? ? ? */
/* STRUCTURED-DATA
<KEY-OBJECT>
&QUERY-NAME
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD pcontrato q-tables 
FUNCTION pcontrato RETURNS LOGICAL
  ( pcontrato AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD que_contrato q-tables 
FUNCTION que_contrato RETURNS INTEGER
  (  )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY Query-Main FOR 
      Contrato_hd, 
      Cliente SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartQuery
   Allow: Basic,Query
   Frames: 1
   Add Fields to: NEITHER
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
  CREATE WINDOW q-tables ASSIGN
         HEIGHT             = 1.33
         WIDTH              = 22.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB q-tables 
/* ************************* Included-Libraries *********************** */

{src/adm/method/query.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW q-tables
  VISIBLE,,RUN-PERSISTENT                                               */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK QUERY Query-Main
/* Query rebuild information for QUERY Query-Main
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH Contrato_hd WHERE ~{&KEY-PHRASE}
    AND contrato_hd.nro_contrato = gcontrato NO-LOCK,
    EACH Cliente OF contrato_hd NO-LOCK
    ~{&SORTBY-PHRASE}.
     _END_FREEFORM
     _Options          = "NO-LOCK KEY-PHRASE SORTBY-PHRASE"
     _Design-Parent    is WINDOW q-tables @ ( 1.1 , 9.8 )
*/  /* QUERY Query-Main */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Query-Main
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK q-tables 


/* ***************************  Main Block  *************************** */

  &IF DEFINED(UIB_IS_RUNNING) <> 0 &THEN          
    RUN dispatch IN THIS-PROCEDURE ('initialize':U).
  &ENDIF

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-open-query-cases q-tables  adm/support/_adm-opn.p
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
    WHEN 'nro_cliente':U THEN DO:
       &Scope KEY-PHRASE Contrato_hd.nro_cliente eq INTEGER(key-value)
       {&OPEN-QUERY-{&QUERY-NAME}}
    END. /* nro_cliente */
    WHEN 'nro_obra':U THEN DO:
       &Scope KEY-PHRASE Contrato_hd.nro_obra eq INTEGER(key-value)
       {&OPEN-QUERY-{&QUERY-NAME}}
    END. /* nro_obra */
    OTHERWISE DO:
       &Scope KEY-PHRASE TRUE
       {&OPEN-QUERY-{&QUERY-NAME}}
    END. /* OTHERWISE...*/
  END CASE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available q-tables  _ADM-ROW-AVAILABLE
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI q-tables  _DEFAULT-DISABLE
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
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-key q-tables  adm/support/_key-snd.p
PROCEDURE send-key :
/*------------------------------------------------------------------------------
  Purpose:     Sends a requested KEY value back to the calling
               SmartObject.
  Parameters:  <see adm/template/sndkytop.i>
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.             */
  {src/adm/template/sndkytop.i}

  /* Return the key value associated with each key case.             */
  {src/adm/template/sndkycas.i "nro_cliente" "Contrato_hd" "nro_cliente"}
  {src/adm/template/sndkycas.i "nro_obra" "Contrato_hd" "nro_obra"}
  {src/adm/template/sndkycas.i "nombre" "Contrato_hd" "nombre"}
  {src/adm/template/sndkycas.i "nro_area" "Contrato_hd" "nro_area"}
  {src/adm/template/sndkycas.i "cdg_banco" "Contrato_hd" "cdg_banco"}
  {src/adm/template/sndkycas.i "cdg_condiva" "Contrato_hd" "cdg_condiva"}
  {src/adm/template/sndkycas.i "nro_cndventa" "Contrato_hd" "nro_cndventa"}
  {src/adm/template/sndkycas.i "cdg_consignatario" "Contrato_hd" "cdg_consignatario"}
  {src/adm/template/sndkycas.i "nro_contrato" "Contrato_hd" "nro_contrato"}
  {src/adm/template/sndkycas.i "cdg_postal" "Contrato_hd" "cdg_postal"}
  {src/adm/template/sndkycas.i "cdg_empresa" "Contrato_hd" "cdg_empresa"}
  {src/adm/template/sndkycas.i "cdg_formapago" "Contrato_hd" "cdg_formapago"}
  {src/adm/template/sndkycas.i "cdg_imputacion" "Contrato_hd" "cdg_imputacion"}
  {src/adm/template/sndkycas.i "cdg_lista" "Contrato_hd" "cdg_lista"}
  {src/adm/template/sndkycas.i "nro_moneda" "Contrato_hd" "nro_moneda"}
  {src/adm/template/sndkycas.i "nro_persona" "Contrato_hd" "nro_persona"}
  {src/adm/template/sndkycas.i "cdg_planta" "Contrato_hd" "cdg_planta"}
  {src/adm/template/sndkycas.i "nro_plazo" "Contrato_hd" "nro_plazo"}
  {src/adm/template/sndkycas.i "cdg_provincia" "Contrato_hd" "cdg_provincia"}
  {src/adm/template/sndkycas.i "nro_remito" "Contrato_hd" "nro_remito"}
  {src/adm/template/sndkycas.i "cdg_solicitante" "Contrato_hd" "cdg_solicitante"}
  {src/adm/template/sndkycas.i "num_sucursal" "Contrato_hd" "num_sucursal"}
  {src/adm/template/sndkycas.i "cdg_embarque" "Contrato_hd" "cdg_embarque"}
  {src/adm/template/sndkycas.i "nro_usuario" "Contrato_hd" "nro_usuario"}
  {src/adm/template/sndkycas.i "nro_vendedor" "Contrato_hd" "nro_vendedor"}
  {src/adm/template/sndkycas.i "cdg_zonag" "Contrato_hd" "cdg_zonag"}

  /* Close the CASE statement and end the procedure.                 */
  {src/adm/template/sndkyend.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records q-tables  _ADM-SEND-RECORDS
PROCEDURE send-records :
/*------------------------------------------------------------------------------
  Purpose:     Send record ROWID's for all tables used by
               this file.
  Parameters:  see template/snd-head.i
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.               */
  {src/adm/template/snd-head.i}

  /* For each requested table, put it's ROWID in the output list.      */
  {src/adm/template/snd-list.i "Contrato_hd"}
  {src/adm/template/snd-list.i "Cliente"}

  /* Deal with any unexpected table requests before closing.           */
  {src/adm/template/snd-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE state-changed q-tables 
PROCEDURE state-changed :
/* -----------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-------------------------------------------------------------*/
  DEFINE INPUT PARAMETER p-issuer-hdl AS HANDLE NO-UNDO.
  DEFINE INPUT PARAMETER p-state AS CHARACTER NO-UNDO.

  CASE p-state:
      /* Object instance CASEs can go here to replace standard behavior
         or add new cases. */
      {src/adm/template/qstates.i}
  END CASE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION pcontrato q-tables 
FUNCTION pcontrato RETURNS LOGICAL
  ( pcontrato AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
gcontrato = pcontrato.
RUN adm-open-query.
  RETURN AVAILABLE contrato_hd.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION que_contrato q-tables 
FUNCTION que_contrato RETURNS INTEGER
  (  ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

RETURN IF AVAILABLE contrato_hd THEN contrato_hd.nro_contrato ELSE ?.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

