&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS B-table-Win 
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

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Fac_header

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Fac_header.cdg_empresa ~
Fac_header.tip_comprob Fac_header.prf_comprob Fac_header.nro_comprob ~
Fac_header.imp_total 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table 
&Scoped-define QUERY-STRING-br_table FOR EACH Fac_header WHERE ~{&KEY-PHRASE} ~
      AND Fac_header.cdg_empresa = v-cdg_empresa ~
 AND Fac_header.tip_comprob = v-tip_comprob ~
 AND Fac_header.prf_comprob = v-prf_comprob ~
 AND Fac_header.nro_comprob = v-nro_comprob NO-LOCK ~
    BY Fac_header.cdg_empresa ~
       BY Fac_header.tip_comprob ~
        BY Fac_header.prf_comprob ~
         BY Fac_header.nro_comprob
&Scoped-define OPEN-QUERY-br_table OPEN QUERY br_table FOR EACH Fac_header WHERE ~{&KEY-PHRASE} ~
      AND Fac_header.cdg_empresa = v-cdg_empresa ~
 AND Fac_header.tip_comprob = v-tip_comprob ~
 AND Fac_header.prf_comprob = v-prf_comprob ~
 AND Fac_header.nro_comprob = v-nro_comprob NO-LOCK ~
    BY Fac_header.cdg_empresa ~
       BY Fac_header.tip_comprob ~
        BY Fac_header.prf_comprob ~
         BY Fac_header.nro_comprob.
&Scoped-define TABLES-IN-QUERY-br_table Fac_header
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Fac_header


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS v-cdg_empresa v-tip_comprob v-prf_comprob ~
v-nro_comprob br_table 
&Scoped-Define DISPLAYED-OBJECTS v-cdg_empresa v-tip_comprob v-prf_comprob ~
v-nro_comprob 

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
nro_contrato|y|y|sic.Fac_header.nro_contrato
nombre||y|sic.Fac_header.nombre
nro_transaccion||y|sic.Fac_header.nro_transaccion
nro_cliente||y|sic.Fac_header.nro_cliente
tip_comprob||y|sic.Fac_header.tip_comprob
cdg_condiva||y|sic.Fac_header.cdg_condiva
nro_cndventa||y|sic.Fac_header.nro_cndventa
mes||y|sic.Fac_header.mes
cdg_postal||y|sic.Fac_header.cdg_postal
nro_deposito||y|sic.Fac_header.nro_deposito
cdg_empresa||y|sic.Fac_header.cdg_empresa
nro_entidad||y|sic.Fac_header.nro_entidad
nro_factura||y|sic.Fac_header.nro_factura
fecha||y|sic.Fac_header.fecha
cdg_imputacion||y|sic.Fac_header.cdg_imputacion
cdg_lista||y|sic.Fac_header.cdg_lista
nro_moneda||y|sic.Fac_header.nro_moneda
nro_obra||y|sic.Fac_header.nro_obra
cdg_provincia||y|sic.Fac_header.cdg_provincia
nro_remito||y|sic.Fac_header.nro_remito
num_sucursal||y|sic.Fac_header.num_sucursal
nro_usuario||y|sic.Fac_header.nro_usuario
nro_vendedor||y|sic.Fac_header.nro_vendedor
cdg_zonag||y|sic.Fac_header.cdg_zonag
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = "nro_contrato",
     Keys-Supplied = "nro_contrato,nombre,nro_transaccion,nro_cliente,tip_comprob,cdg_condiva,nro_cndventa,mes,cdg_postal,nro_deposito,cdg_empresa,nro_entidad,nro_factura,fecha,cdg_imputacion,cdg_lista,nro_moneda,nro_obra,cdg_provincia,nro_remito,num_sucursal,nro_usuario,nro_vendedor,cdg_zonag"':U).

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
DEFINE VARIABLE v-cdg_empresa AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 7 BY 1 NO-UNDO.

DEFINE VARIABLE v-nro_comprob AS INTEGER FORMAT "->,>>>>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE v-prf_comprob AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE v-tip_comprob AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Fac_header SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _STRUCTURED
  QUERY br_table NO-LOCK DISPLAY
      Fac_header.cdg_empresa FORMAT "X(8)":U
      Fac_header.tip_comprob FORMAT "X(3)":U
      Fac_header.prf_comprob FORMAT "9999":U
      Fac_header.nro_comprob FORMAT "ZZZZZZZ9":U
      Fac_header.imp_total FORMAT "->,>>>,>>9.99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 49 BY 4.57.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     v-cdg_empresa AT ROW 1.48 COL 2 NO-LABEL
     v-tip_comprob AT ROW 1.48 COL 8 COLON-ALIGNED NO-LABEL
     v-prf_comprob AT ROW 1.48 COL 19 COLON-ALIGNED NO-LABEL
     v-nro_comprob AT ROW 1.48 COL 34 COLON-ALIGNED NO-LABEL
     br_table AT ROW 3.14 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


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
         WIDTH              = 71.6.
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
/* BROWSE-TAB br_table v-nro_comprob F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN v-cdg_empresa IN FRAME F-Main
   ALIGN-L                                                              */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _TblList          = "sic.Fac_header"
     _Options          = "NO-LOCK KEY-PHRASE"
     _OrdList          = "sic.Fac_header.cdg_empresa|yes,sic.Fac_header.tip_comprob|yes,sic.Fac_header.prf_comprob|yes,sic.Fac_header.nro_comprob|yes"
     _Where[1]         = "Fac_header.cdg_empresa = v-cdg_empresa
 AND Fac_header.tip_comprob = v-tip_comprob
 AND Fac_header.prf_comprob = v-prf_comprob
 AND Fac_header.nro_comprob = v-nro_comprob"
     _FldNameList[1]   = sic.Fac_header.cdg_empresa
     _FldNameList[2]   = sic.Fac_header.tip_comprob
     _FldNameList[3]   = sic.Fac_header.prf_comprob
     _FldNameList[4]   = sic.Fac_header.nro_comprob
     _FldNameList[5]   = sic.Fac_header.imp_total
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


&Scoped-define SELF-NAME v-nro_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-nro_comprob B-table-Win
ON RETURN OF v-nro_comprob IN FRAME F-Main
DO:
  ASSIGN v-cdg_empresa v-tip_comprob v-prf_comprob v-nro_comprob.
  RUN dispatch IN THIS-PROCEDURE ('open-query').
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
    WHEN 'nro_contrato':U THEN DO:
       &Scope KEY-PHRASE Fac_header.nro_contrato eq INTEGER(key-value)
       {&OPEN-QUERY-{&BROWSE-NAME}}
    END. /* nro_contrato */
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
  {src/adm/template/sndkycas.i "nro_contrato" "Fac_header" "nro_contrato"}
  {src/adm/template/sndkycas.i "nombre" "Fac_header" "nombre"}
  {src/adm/template/sndkycas.i "nro_transaccion" "Fac_header" "nro_transaccion"}
  {src/adm/template/sndkycas.i "nro_cliente" "Fac_header" "nro_cliente"}
  {src/adm/template/sndkycas.i "tip_comprob" "Fac_header" "tip_comprob"}
  {src/adm/template/sndkycas.i "cdg_condiva" "Fac_header" "cdg_condiva"}
  {src/adm/template/sndkycas.i "nro_cndventa" "Fac_header" "nro_cndventa"}
  {src/adm/template/sndkycas.i "mes" "Fac_header" "mes"}
  {src/adm/template/sndkycas.i "cdg_postal" "Fac_header" "cdg_postal"}
  {src/adm/template/sndkycas.i "nro_deposito" "Fac_header" "nro_deposito"}
  {src/adm/template/sndkycas.i "cdg_empresa" "Fac_header" "cdg_empresa"}
  {src/adm/template/sndkycas.i "nro_entidad" "Fac_header" "nro_entidad"}
  {src/adm/template/sndkycas.i "nro_factura" "Fac_header" "nro_factura"}
  {src/adm/template/sndkycas.i "fecha" "Fac_header" "fecha"}
  {src/adm/template/sndkycas.i "cdg_imputacion" "Fac_header" "cdg_imputacion"}
  {src/adm/template/sndkycas.i "cdg_lista" "Fac_header" "cdg_lista"}
  {src/adm/template/sndkycas.i "nro_moneda" "Fac_header" "nro_moneda"}
  {src/adm/template/sndkycas.i "nro_obra" "Fac_header" "nro_obra"}
  {src/adm/template/sndkycas.i "cdg_provincia" "Fac_header" "cdg_provincia"}
  {src/adm/template/sndkycas.i "nro_remito" "Fac_header" "nro_remito"}
  {src/adm/template/sndkycas.i "num_sucursal" "Fac_header" "num_sucursal"}
  {src/adm/template/sndkycas.i "nro_usuario" "Fac_header" "nro_usuario"}
  {src/adm/template/sndkycas.i "nro_vendedor" "Fac_header" "nro_vendedor"}
  {src/adm/template/sndkycas.i "cdg_zonag" "Fac_header" "cdg_zonag"}

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
  {src/adm/template/snd-list.i "Fac_header"}

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

