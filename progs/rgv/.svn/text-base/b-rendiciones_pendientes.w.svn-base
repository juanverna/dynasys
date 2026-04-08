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

DEFINE VARIABLE que_empresa LIKE Empresa.cdg_empresa.
DEFINE VARIABLE sino AS LOGICAL.
DEFINE VARIABLE txt AS CHARACTER.

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
&Scoped-define INTERNAL-TABLES Rendgastos_hd Proveedor Moneda

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Rendgastos_hd.tip_comprob ~
Rendgastos_hd.prf_comprob Rendgastos_hd.nro_comprob ~
Rendgastos_hd.fch_rendicion Rendgastos_hd.des_fecha Rendgastos_hd.has_fecha ~
Rendgastos_hd.imp_anticipo Rendgastos_hd.imp_rendicion ~
Rendgastos_hd.imp_imputado Moneda.abrevia Proveedor.cdg_proveedor ~
Proveedor.nombre 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table 
&Scoped-define QUERY-STRING-br_table FOR EACH Rendgastos_hd WHERE ~{&KEY-PHRASE} ~
      AND Rendgastos_hd.abierta = TRUE ~
 AND Rendgastos_hd.cdg_estado = v-que_estado ~
 AND Rendgastos_hd.cdg_empresa = que_empresa NO-LOCK, ~
      EACH Proveedor OF Rendgastos_hd NO-LOCK, ~
      EACH Moneda OF Rendgastos_hd NO-LOCK ~
    ~{&SORTBY-PHRASE}
&Scoped-define OPEN-QUERY-br_table OPEN QUERY br_table FOR EACH Rendgastos_hd WHERE ~{&KEY-PHRASE} ~
      AND Rendgastos_hd.abierta = TRUE ~
 AND Rendgastos_hd.cdg_estado = v-que_estado ~
 AND Rendgastos_hd.cdg_empresa = que_empresa NO-LOCK, ~
      EACH Proveedor OF Rendgastos_hd NO-LOCK, ~
      EACH Moneda OF Rendgastos_hd NO-LOCK ~
    ~{&SORTBY-PHRASE}.
&Scoped-define TABLES-IN-QUERY-br_table Rendgastos_hd Proveedor Moneda
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Rendgastos_hd
&Scoped-define SECOND-TABLE-IN-QUERY-br_table Proveedor
&Scoped-define THIRD-TABLE-IN-QUERY-br_table Moneda


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS v-que_estado btn_aprobar btn_rechazar ~
br_table RECT-1 
&Scoped-Define DISPLAYED-OBJECTS v-que_estado 

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
nro_proveedor|y|y|sic.Rendgastos_hd.nro_proveedor
tip_comprob||y|sic.Rendgastos_hd.tip_comprob
cdg_empresa||y|sic.Rendgastos_hd.cdg_empresa
cdg_estado||y|sic.Rendgastos_hd.cdg_estado
nro_moneda||y|sic.Rendgastos_hd.nro_moneda
nro_rendgastos||y|sic.Rendgastos_hd.nro_rendgastos
num_sucursal||y|sic.Rendgastos_hd.num_sucursal
cdg_comprobante||y|sic.Rendgastos_hd.cdg_comprobante
cdg_tiporendgastos||y|sic.Rendgastos_hd.cdg_tiporendgastos
nro_usuario||y|sic.Rendgastos_hd.nro_usuario
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = "nro_proveedor",
     Keys-Supplied = "nro_proveedor,tip_comprob,cdg_empresa,cdg_estado,nro_moneda,nro_rendgastos,num_sucursal,cdg_comprobante,cdg_tiporendgastos,nro_usuario"':U).

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
DEFINE BUTTON btn_aprobar 
     LABEL "&Aprobar" 
     SIZE 18 BY 1.14
     FONT 5.

DEFINE BUTTON btn_rechazar 
     LABEL "&Rechazar" 
     SIZE 18 BY 1.14
     FONT 5.

DEFINE VARIABLE v-que_estado AS CHARACTER FORMAT "X(256)":U 
     LABEL "Rendiciones" 
     VIEW-AS COMBO-BOX INNER-LINES 2
     LIST-ITEM-PAIRS "Anticipos a Pagar","IN",
                     "Rendiciones Cerradas","CE"
     DROP-DOWN-LIST
     SIZE 28 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 155 BY 1.67.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Rendgastos_hd, 
      Proveedor, 
      Moneda SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _STRUCTURED
  QUERY br_table NO-LOCK DISPLAY
      Rendgastos_hd.tip_comprob COLUMN-LABEL "Ti-!po" FORMAT "X(3)":U
      Rendgastos_hd.prf_comprob COLUMN-LABEL "Pre-!fijo" FORMAT "9999":U
      Rendgastos_hd.nro_comprob COLUMN-LABEL "Numero!Rendición" FORMAT "ZZZZZZZ9":U
      Rendgastos_hd.fch_rendicion FORMAT "99/99/99":U
      Rendgastos_hd.des_fecha FORMAT "99/99/99":U
      Rendgastos_hd.has_fecha FORMAT "99/99/99":U
      Rendgastos_hd.imp_anticipo FORMAT "->,>>>,>>9.99":U
      Rendgastos_hd.imp_rendicion COLUMN-LABEL "Total!Rendición" FORMAT "->,>>>,>>9.99":U
      Rendgastos_hd.imp_imputado COLUMN-LABEL "Total!Comprobante" FORMAT "->,>>>,>>9.99":U
      Moneda.abrevia FORMAT "X(5)":U
      Proveedor.cdg_proveedor COLUMN-LABEL "Código!Beneficiario" FORMAT "X(8)":U
            WIDTH 11.2
      Proveedor.nombre COLUMN-LABEL "Nombre!Beneficiario" FORMAT "X(40)":U
            WIDTH 40.6
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 155 BY 6.71
         TITLE "Rendiciones Pendientes de Aprobación" EXPANDABLE.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     v-que_estado AT ROW 1.24 COL 17 COLON-ALIGNED
     btn_aprobar AT ROW 1.24 COL 113
     btn_rechazar AT ROW 1.24 COL 135
     br_table AT ROW 2.91 COL 1
     RECT-1 AT ROW 1 COL 1
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
         HEIGHT             = 10.48
         WIDTH              = 155.
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
/* BROWSE-TAB br_table btn_rechazar F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _TblList          = "sic.Rendgastos_hd,sic.Proveedor OF sic.Rendgastos_hd,sic.Moneda OF sic.Rendgastos_hd"
     _Options          = "NO-LOCK KEY-PHRASE SORTBY-PHRASE"
     _Where[1]         = "Rendgastos_hd.abierta = TRUE
 AND Rendgastos_hd.cdg_estado = v-que_estado
 AND Rendgastos_hd.cdg_empresa = que_empresa"
     _FldNameList[1]   > sic.Rendgastos_hd.tip_comprob
"Rendgastos_hd.tip_comprob" "Ti-!po" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[2]   > sic.Rendgastos_hd.prf_comprob
"Rendgastos_hd.prf_comprob" "Pre-!fijo" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[3]   > sic.Rendgastos_hd.nro_comprob
"Rendgastos_hd.nro_comprob" "Numero!Rendición" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[4]   = sic.Rendgastos_hd.fch_rendicion
     _FldNameList[5]   = sic.Rendgastos_hd.des_fecha
     _FldNameList[6]   = sic.Rendgastos_hd.has_fecha
     _FldNameList[7]   = sic.Rendgastos_hd.imp_anticipo
     _FldNameList[8]   > sic.Rendgastos_hd.imp_rendicion
"Rendgastos_hd.imp_rendicion" "Total!Rendición" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[9]   > sic.Rendgastos_hd.imp_imputado
"Rendgastos_hd.imp_imputado" "Total!Comprobante" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[10]   = sic.Moneda.abrevia
     _FldNameList[11]   > sic.Proveedor.cdg_proveedor
"Proveedor.cdg_proveedor" "Código!Beneficiario" ? "character" ? ? ? ? ? ? no ? no no "11.2" yes no no "U" "" ""
     _FldNameList[12]   > sic.Proveedor.nombre
"Proveedor.nombre" "Nombre!Beneficiario" ? "character" ? ? ? ? ? ? no ? no no "40.6" yes no no "U" "" ""
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
ON ROW-ENTRY OF br_table IN FRAME F-Main /* Rendiciones Pendientes de Aprobación */
DO:
  /* This code displays initial values for newly added or copied rows. */
  {src/adm/template/brsentry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-LEAVE OF br_table IN FRAME F-Main /* Rendiciones Pendientes de Aprobación */
DO:
    /* Do not disable this code or no updates will take place except
     by pressing the Save button on an Update SmartPanel. */
   {src/adm/template/brsleave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON VALUE-CHANGED OF br_table IN FRAME F-Main /* Rendiciones Pendientes de Aprobación */
DO:
  /* This ADM trigger code must be preserved in order to notify other
     objects when the browser's current row changes. */
  {src/adm/template/brschnge.i}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_aprobar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_aprobar B-table-Win
ON CHOOSE OF btn_aprobar IN FRAME F-Main /* Aprobar */
DO:
  sino = NO.
  IF Rendgastos_hd.cdg_estado = "IN"
       THEN txt = "Desea aprobar el pago de este anticipo".
       ELSE txt = "Desea aprobar el pago de esta rendición".
  MESSAGE txt VIEW-AS ALERT-BOX MESSAGE BUTTONS YES-NO TITLE "Confirmacion" UPDATE sino.
  IF sino
  THEN DO:
      RUN generar_cuenta_proveedor.p ( ROWID (Rendgastos_hd) ).
      RUN dispatch IN THIS-PROCEDURE ( 'open-query' ).
  END.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_rechazar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_rechazar B-table-Win
ON CHOOSE OF btn_rechazar IN FRAME F-Main /* Rechazar */
DO:

  sino = NO.
  IF Rendgastos_hd.cdg_estado = "IN"
       THEN txt = "Desea rechazar el pago de este anticipo".
       ELSE txt = "Desea rechazar el pago de esta rendición".
  MESSAGE txt VIEW-AS ALERT-BOX MESSAGE BUTTONS YES-NO TITLE "Confirmacion" UPDATE sino.
  IF sino
  THEN DO:
      DO TRANSACTION:
          FIND CURRENT Rendgastos_hd EXCLUSIVE-LOCK.
          Rendgastos_hd.cdg_estado = "ZZ".
          FIND CURRENT Rendgastos_hd NO-LOCK.
      END.
      RUN dispatch IN THIS-PROCEDURE ( 'open-query' ).
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-que_estado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-que_estado B-table-Win
ON VALUE-CHANGED OF v-que_estado IN FRAME F-Main /* Rendiciones */
DO:
  ASSIGN v-que_estado.
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
    WHEN 'nro_proveedor':U THEN DO:
       &Scope KEY-PHRASE Rendgastos_hd.nro_proveedor eq INTEGER(key-value)
       {&OPEN-QUERY-{&BROWSE-NAME}}
    END. /* nro_proveedor */
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
    {findempresa.i}
    que_empresa = Empresa.cdg_empresa.

    v-que_estado = "IN".

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  DISPLAY v-que_estado
      WITH FRAME {&FRAME-NAME} .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE refrescar_browse B-table-Win 
PROCEDURE refrescar_browse :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  RUN dispatch IN THIS-PROCEDURE ('open-query':U).

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
  {src/adm/template/sndkycas.i "nro_proveedor" "Rendgastos_hd" "nro_proveedor"}
  {src/adm/template/sndkycas.i "tip_comprob" "Rendgastos_hd" "tip_comprob"}
  {src/adm/template/sndkycas.i "cdg_empresa" "Rendgastos_hd" "cdg_empresa"}
  {src/adm/template/sndkycas.i "cdg_estado" "Rendgastos_hd" "cdg_estado"}
  {src/adm/template/sndkycas.i "nro_moneda" "Rendgastos_hd" "nro_moneda"}
  {src/adm/template/sndkycas.i "nro_rendgastos" "Rendgastos_hd" "nro_rendgastos"}
  {src/adm/template/sndkycas.i "num_sucursal" "Rendgastos_hd" "num_sucursal"}
  {src/adm/template/sndkycas.i "cdg_comprobante" "Rendgastos_hd" "cdg_comprobante"}
  {src/adm/template/sndkycas.i "cdg_tiporendgastos" "Rendgastos_hd" "cdg_tiporendgastos"}
  {src/adm/template/sndkycas.i "nro_usuario" "Rendgastos_hd" "nro_usuario"}

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
  {src/adm/template/snd-list.i "Rendgastos_hd"}
  {src/adm/template/snd-list.i "Proveedor"}
  {src/adm/template/snd-list.i "Moneda"}

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

