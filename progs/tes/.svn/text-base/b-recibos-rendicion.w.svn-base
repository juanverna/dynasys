&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
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
&Scoped-define INTERNAL-TABLES Rec_header Cliente

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Rec_header.tip_comprob ~
Rec_header.prf_comprob Rec_header.nro_comprob Rec_header.fecha ~
Rec_header.mes Rec_header.ano Cliente.cdg_cliente Cliente.nom_cliente ~
Rec_header.imp_total 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table 
&Scoped-define FIELD-PAIRS-IN-QUERY-br_table
&Scoped-define OPEN-QUERY-br_table OPEN QUERY br_table FOR EACH Rec_header WHERE TRUE /* Join to Rendicion_hd incomplete */ ~
      AND Rec_header.nro_rendicion = Rendicion_hd.nro_rendicion NO-LOCK, ~
      EACH Cliente OF Rec_header NO-LOCK ~
    ~{&SORTBY-PHRASE}.
&Scoped-define TABLES-IN-QUERY-br_table Rec_header Cliente
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Rec_header


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
nombre||y|sic.Rec_header.nombre
nro_transaccion||y|sic.Rec_header.nro_transaccion
nro_cliente||y|sic.Rec_header.nro_cliente
nro_cobrador||y|sic.Rec_header.nro_cobrador
cdg_condiva||y|sic.Rec_header.cdg_condiva
nro_cndventa||y|sic.Rec_header.nro_cndventa
mes||y|sic.Rec_header.mes
cdg_postal||y|sic.Rec_header.cdg_postal
cdg_empresa||y|sic.Rec_header.cdg_empresa
nro_entidad||y|sic.Rec_header.nro_entidad
fecha||y|sic.Rec_header.fecha
cdg_imputacion||y|sic.Rec_header.cdg_imputacion
nro_moneda||y|sic.Rec_header.nro_moneda
cdg_provincia||y|sic.Rec_header.cdg_provincia
nro_recibo||y|sic.Rec_header.nro_recibo
nro_rendicion||y|sic.Rec_header.nro_rendicion
nro_resumen||y|sic.Rec_header.nro_resumen
num_sucursal||y|sic.Rec_header.num_sucursal
nro_usuario||y|sic.Rec_header.nro_usuario
nro_vendedor||y|sic.Rec_header.nro_vendedor
cdg_zonag||y|sic.Rec_header.cdg_zonag
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = ,
     Keys-Supplied = "nombre,nro_transaccion,nro_cliente,nro_cobrador,cdg_condiva,nro_cndventa,mes,cdg_postal,cdg_empresa,nro_entidad,fecha,cdg_imputacion,nro_moneda,cdg_provincia,nro_recibo,nro_rendicion,nro_resumen,num_sucursal,nro_usuario,nro_vendedor,cdg_zonag"':U).

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
/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Rec_header, 
      Cliente SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _STRUCTURED
  QUERY br_table NO-LOCK DISPLAY
      Rec_header.tip_comprob COLUMN-LABEL "Tip!Doc"
      Rec_header.prf_comprob COLUMN-LABEL "Pto.!Vta."
      Rec_header.nro_comprob COLUMN-LABEL "Numero!Compbte."
      Rec_header.fecha COLUMN-LABEL "Fecha!Emision"
      Rec_header.mes
      Rec_header.ano
      Cliente.cdg_cliente COLUMN-LABEL "Código!Cliente"
      Cliente.nom_cliente COLUMN-LABEL "Razon!Social" FORMAT "X(20)"
      Rec_header.imp_total COLUMN-LABEL "Importe!Total"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 88 BY 13.19
         BGCOLOR 11 FGCOLOR 9 FONT 4
         TITLE BGCOLOR 11 FGCOLOR 9 "Recibos incluidos en la presente rendicion".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     br_table AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         BGCOLOR 8 FGCOLOR 0 .


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
  MESSAGE "{&FILE-NAME} should only be RUN PERSISTENT."
          VIEW-AS ALERT-BOX ERROR BUTTONS OK.
  RETURN.
END.

&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
/* DESIGN Window definition (used by the UIB) 
  CREATE WINDOW B-table-Win ASSIGN
         HEIGHT             = 13.46
         WIDTH              = 89.57.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME


/* ***************  Runtime Attributes and UIB Settings  ************** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW B-table-Win
  NOT-VISIBLE,,RUN-PERSISTENT                                           */
/* SETTINGS FOR FRAME F-Main
   NOT-VISIBLE Size-to-Fit                                              */
/* BROWSE-TAB br_table 1 F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _TblList          = "sic.Rec_header WHERE sic.Rendicion_hd <external> ...,sic.Cliente OF sic.Rec_header"
     _Options          = "NO-LOCK KEY-PHRASE SORTBY-PHRASE"
     _Where[1]         = "sic.Rec_header.nro_rendicion = Rendicion_hd.nro_rendicion"
     _FldNameList[1]   > sic.Rec_header.tip_comprob
"Rec_header.tip_comprob" "Tip!Doc" ? "character" ? ? ? ? ? ? no ?
     _FldNameList[2]   > sic.Rec_header.prf_comprob
"Rec_header.prf_comprob" "Pto.!Vta." ? "integer" ? ? ? ? ? ? no ?
     _FldNameList[3]   > sic.Rec_header.nro_comprob
"Rec_header.nro_comprob" "Numero!Compbte." ? "integer" ? ? ? ? ? ? no ?
     _FldNameList[4]   > sic.Rec_header.fecha
"Rec_header.fecha" "Fecha!Emision" ? "date" ? ? ? ? ? ? no ?
     _FldNameList[5]   = sic.Rec_header.mes
     _FldNameList[6]   = sic.Rec_header.ano
     _FldNameList[7]   > sic.Cliente.cdg_cliente
"Cliente.cdg_cliente" "Código!Cliente" ? "character" ? ? ? ? ? ? no ?
     _FldNameList[8]   > sic.Cliente.nom_cliente
"Cliente.nom_cliente" "Razon!Social" "X(20)" "character" ? ? ? ? ? ? no ?
     _FldNameList[9]   > sic.Rec_header.imp_total
"Rec_header.imp_total" "Importe!Total" ? "decimal" ? ? ? ? ? ? no ?
     _Query            is NOT OPENED
*/  /* BROWSE br_table */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME F-Main
/* Query rebuild information for FRAME F-Main
     _Options          = "NO-LOCK"
     _Query            is NOT OPENED
*/  /* FRAME F-Main */
&ANALYZE-RESUME

 


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB B-table-Win 
/* ************************* Included-Libraries *********************** */

{src/adm/method/browser.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ************************  Control Triggers  ************************ */

&Scoped-define BROWSE-NAME br_table
&Scoped-define SELF-NAME br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-ENTRY OF br_table IN FRAME F-Main /* Recibos incluidos en la presente rendicion */
DO:
  /* This code displays initial values for newly added or copied rows. */
  {src/adm/template/brsentry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-LEAVE OF br_table IN FRAME F-Main /* Recibos incluidos en la presente rendicion */
DO:
    /* Do not disable this code or no updates will take place except
     by pressing the Save button on an Update SmartPanel. */
   {src/adm/template/brsleave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON VALUE-CHANGED OF br_table IN FRAME F-Main /* Recibos incluidos en la presente rendicion */
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-open-query-cases B-table-Win adm/support/_adm-opn.p
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available B-table-Win _ADM-ROW-AVAILABLE
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI B-table-Win _DEFAULT-DISABLE
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-key B-table-Win adm/support/_key-snd.p
PROCEDURE send-key :
/*------------------------------------------------------------------------------
  Purpose:     Sends a requested KEY value back to the calling
               SmartObject.
  Parameters:  <see adm/template/sndkytop.i>
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.             */
  {src/adm/template/sndkytop.i}

  /* Return the key value associated with each key case.             */
  {src/adm/template/sndkycas.i "nombre" "Rec_header" "nombre"}
  {src/adm/template/sndkycas.i "nro_transaccion" "Rec_header" "nro_transaccion"}
  {src/adm/template/sndkycas.i "nro_cliente" "Rec_header" "nro_cliente"}
  {src/adm/template/sndkycas.i "nro_cobrador" "Rec_header" "nro_cobrador"}
  {src/adm/template/sndkycas.i "cdg_condiva" "Rec_header" "cdg_condiva"}
  {src/adm/template/sndkycas.i "nro_cndventa" "Rec_header" "nro_cndventa"}
  {src/adm/template/sndkycas.i "mes" "Rec_header" "mes"}
  {src/adm/template/sndkycas.i "cdg_postal" "Rec_header" "cdg_postal"}
  {src/adm/template/sndkycas.i "cdg_empresa" "Rec_header" "cdg_empresa"}
  {src/adm/template/sndkycas.i "nro_entidad" "Rec_header" "nro_entidad"}
  {src/adm/template/sndkycas.i "fecha" "Rec_header" "fecha"}
  {src/adm/template/sndkycas.i "cdg_imputacion" "Rec_header" "cdg_imputacion"}
  {src/adm/template/sndkycas.i "nro_moneda" "Rec_header" "nro_moneda"}
  {src/adm/template/sndkycas.i "cdg_provincia" "Rec_header" "cdg_provincia"}
  {src/adm/template/sndkycas.i "nro_recibo" "Rec_header" "nro_recibo"}
  {src/adm/template/sndkycas.i "nro_rendicion" "Rec_header" "nro_rendicion"}
  {src/adm/template/sndkycas.i "nro_resumen" "Rec_header" "nro_resumen"}
  {src/adm/template/sndkycas.i "num_sucursal" "Rec_header" "num_sucursal"}
  {src/adm/template/sndkycas.i "nro_usuario" "Rec_header" "nro_usuario"}
  {src/adm/template/sndkycas.i "nro_vendedor" "Rec_header" "nro_vendedor"}
  {src/adm/template/sndkycas.i "cdg_zonag" "Rec_header" "cdg_zonag"}

  /* Close the CASE statement and end the procedure.                 */
  {src/adm/template/sndkyend.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records B-table-Win _ADM-SEND-RECORDS
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
  {src/adm/template/snd-list.i "Rec_header"}
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


