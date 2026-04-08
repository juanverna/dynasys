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

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME F-Main
&Scoped-define BROWSE-NAME br_table

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES Cliente
&Scoped-define FIRST-EXTERNAL-TABLE Cliente


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Cliente.
/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Contrato_hd

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Contrato_hd.num_contrato   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table   
&Scoped-define SELF-NAME br_table
&Scoped-define OPEN-QUERY-br_table IF vacti:SCREEN-VALUE IN FRAME {&frame-name} = "1" THEN     OPEN QUERY {&SELF-NAME} FOR EACH Contrato_hd OF Cliente         WHERE contrato_hd.estado <> "R" AND Contrato_hd.fecha_baja = ?  AND Contrato_hd.rige_hasta > TODAY AND      ( contrato_hd.cant_periodos  = contrato_hd.resto_periodos OR        contrato_hd.resto_periodos > 0 ) NO-LOCK         BY Contrato_hd.cdg_empresa          BY Contrato_hd.ultimo_ano DESCENDING           BY Contrato_hd.ultimo_mes DESCENDING            BY Contrato_hd.tip_contrato             BY Contrato_hd.prf_contrato              BY Contrato_hd.num_contrato DESCENDING INDEXED-REPOSITION.  ELSE     OPEN QUERY {&SELF-NAME} FOR EACH Contrato_hd OF Cliente NO-LOCK         BY Contrato_hd.cdg_empresa          BY Contrato_hd.ultimo_ano DESCENDING           BY Contrato_hd.ultimo_mes DESCENDING            BY Contrato_hd.tip_contrato             BY Contrato_hd.prf_contrato              BY Contrato_hd.num_contrato DESCENDING INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_table Contrato_hd
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Contrato_hd


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-5 v-numero br_table vacti 
&Scoped-Define DISPLAYED-OBJECTS v-tipo v-numero v-prefijo vacti 

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
nro_area||y|sic.Contrato_hd.nro_area
nombre||y|sic.Contrato_hd.nombre
cdg_banco||y|sic.Contrato_hd.cdg_banco
nro_cliente||y|sic.Contrato_hd.nro_cliente
cdg_condiva||y|sic.Contrato_hd.cdg_condiva
nro_cndventa||y|sic.Contrato_hd.nro_cndventa
cdg_consignatario||y|sic.Contrato_hd.cdg_consignatario
nro_contrato||y|sic.Contrato_hd.nro_contrato
cdg_postal||y|sic.Contrato_hd.cdg_postal
cdg_empresa||y|sic.Contrato_hd.cdg_empresa
cdg_formapago||y|sic.Contrato_hd.cdg_formapago
cdg_lista||y|sic.Contrato_hd.cdg_lista
nro_moneda||y|sic.Contrato_hd.nro_moneda
nro_obra||y|sic.Contrato_hd.nro_obra
cdg_planta||y|sic.Contrato_hd.cdg_planta
nro_plazo||y|sic.Contrato_hd.nro_plazo
cdg_provincia||y|sic.Contrato_hd.cdg_provincia
nro_remito||y|sic.Contrato_hd.nro_remito
cdg_solicitante||y|sic.Contrato_hd.cdg_solicitante
num_sucursal||y|sic.Contrato_hd.num_sucursal
nro_usuario||y|sic.Contrato_hd.nro_usuario
nro_vendedor||y|sic.Contrato_hd.nro_vendedor
cdg_zonag||y|sic.Contrato_hd.cdg_zonag
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = ,
     Keys-Supplied = "nro_area,nombre,cdg_banco,nro_cliente,cdg_condiva,nro_cndventa,cdg_consignatario,nro_contrato,cdg_postal,cdg_empresa,cdg_formapago,cdg_lista,nro_moneda,nro_obra,cdg_planta,nro_plazo,cdg_provincia,nro_remito,cdg_solicitante,num_sucursal,nro_usuario,nro_vendedor,cdg_zonag"':U).

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
DEFINE VARIABLE v-numero AS INTEGER FORMAT ">>>>>>>9":U INITIAL 0 
     VIEW-AS FILL-IN NATIVE 
     SIZE 24 BY 1
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE v-prefijo AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN NATIVE 
     SIZE 6 BY .81
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE v-tipo AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 4 BY .81
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE vacti AS INTEGER INITIAL 1 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Activos", 1,
"Todos", 2
     SIZE 23 BY .95 NO-UNDO.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 27 BY 12.62.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Contrato_hd SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _FREEFORM
  QUERY br_table NO-LOCK DISPLAY
      Contrato_hd.num_contrato FORMAT "ZZZZZZZ9":U WIDTH 19.2
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 24 BY 9.67
         BGCOLOR 15 FGCOLOR 9 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     v-tipo AT ROW 1.24 COL 2 NO-LABEL
     v-numero AT ROW 1.71 COL 2.6 NO-LABEL
     v-prefijo AT ROW 1.95 COL 19 NO-LABEL
     br_table AT ROW 3 COL 2.6
     vacti AT ROW 12.76 COL 3 NO-LABEL
     RECT-5 AT ROW 1.24 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         BGCOLOR 8 FGCOLOR 0 .


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
         HEIGHT             = 13.19
         WIDTH              = 29.8.
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
/* BROWSE-TAB br_table v-prefijo F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN v-numero IN FRAME F-Main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN v-prefijo IN FRAME F-Main
   NO-ENABLE ALIGN-L                                                    */
ASSIGN 
       v-prefijo:HIDDEN IN FRAME F-Main           = TRUE.

/* SETTINGS FOR FILL-IN v-tipo IN FRAME F-Main
   NO-ENABLE ALIGN-L                                                    */
ASSIGN 
       v-tipo:HIDDEN IN FRAME F-Main           = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _START_FREEFORM
IF vacti:SCREEN-VALUE IN FRAME {&frame-name} = "1" THEN
    OPEN QUERY {&SELF-NAME} FOR EACH Contrato_hd OF Cliente
        WHERE contrato_hd.estado <> "R" AND Contrato_hd.fecha_baja = ?  AND Contrato_hd.rige_hasta > TODAY AND
     ( contrato_hd.cant_periodos  = contrato_hd.resto_periodos OR
       contrato_hd.resto_periodos > 0 ) NO-LOCK
        BY Contrato_hd.cdg_empresa
         BY Contrato_hd.ultimo_ano DESCENDING
          BY Contrato_hd.ultimo_mes DESCENDING
           BY Contrato_hd.tip_contrato
            BY Contrato_hd.prf_contrato
             BY Contrato_hd.num_contrato DESCENDING INDEXED-REPOSITION.

ELSE
    OPEN QUERY {&SELF-NAME} FOR EACH Contrato_hd OF Cliente NO-LOCK
        BY Contrato_hd.cdg_empresa
         BY Contrato_hd.ultimo_ano DESCENDING
          BY Contrato_hd.ultimo_mes DESCENDING
           BY Contrato_hd.tip_contrato
            BY Contrato_hd.prf_contrato
             BY Contrato_hd.num_contrato DESCENDING INDEXED-REPOSITION.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION KEY-PHRASE"
     _OrdList          = "sic.Contrato_hd.cdg_empresa|yes,sic.Contrato_hd.ultimo_ano|no,sic.Contrato_hd.ultimo_mes|no,sic.Contrato_hd.tip_contrato|yes,sic.Contrato_hd.prf_contrato|yes,sic.Contrato_hd.num_contrato|no"
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


&Scoped-define SELF-NAME v-numero
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-numero B-table-Win
ON MOUSE-MENU-DOWN OF v-numero IN FRAME F-Main
DO:
/*
  &SCOPED-DEFINE ROWID_TABLA        rid_cliente
  &SCOPED-DEFINE SELECCION          SELCLIEN.P
  &SCOPED-DEFINE TABLA              Cliente
  &SCOPED-DEFINE CDG_TABLA          cdg_cliente
  &SCOPED-DEFINE DSC_TABLA          nom_cliente
  &SCOPED-DEFINE V-CDG_TABLA        v-tipo    
  &SCOPED-DEFINE MOSTRAR_DSC        NO

  {hlptabla-var.i}      
*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-numero B-table-Win
ON RETURN OF v-numero IN FRAME F-Main
OR "TAB" OF v-tipo IN FRAME {&FRAME-NAME}
DO:
 
  &SCOPED-DEFINE CODIGO tip_contrato
 
  IF {&BROWSE-NAME}:SENSITIVE IN FRAME {&FRAME-NAME} 
  THEN DO:

    ASSIGN FRAME {&FRAME-NAME} v-tipo v-prefijo v-numero.
    FIND FIRST Contrato_hd 
         WHERE Contrato_hd.tip_contrato = v-tipo 
           AND Contrato_hd.prf_contrato = v-prefijo
           AND Contrato_hd.num_contrato >= v-numero
           AND Contrato_hd.cdg_empresa  = Empresa.cdg_empresa
                NO-LOCK NO-ERROR.
    IF NOT AVAILABLE Contrato_hd 
       THEN FIND LAST Contrato_hd
                      WHERE Contrato_hd.cdg_empresa  = Empresa.cdg_empresa
                            NO-LOCK.
    REPOSITION {&BROWSE-NAME} TO ROWID ROWID({&FIRST-TABLE-IN-QUERY-{&BROWSE-NAME}}).
    RUN dispatch IN THIS-PROCEDURE ('row-changed').

  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME vacti
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL vacti B-table-Win
ON VALUE-CHANGED OF vacti IN FRAME F-Main
DO:
  assign vacti = INT(vacti:SCREEN-VALUE IN FRAME {&FRAME-NAME} ).
  {&OPEN-QUERY-{&BROWSE-NAME}}
  RUN dispatch IN THIS-PROCEDURE ('row-changed':U).
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
  {src/adm/template/sndkycas.i "nro_area" "Contrato_hd" "nro_area"}
  {src/adm/template/sndkycas.i "nombre" "Contrato_hd" "nombre"}
  {src/adm/template/sndkycas.i "cdg_banco" "Contrato_hd" "cdg_banco"}
  {src/adm/template/sndkycas.i "nro_cliente" "Contrato_hd" "nro_cliente"}
  {src/adm/template/sndkycas.i "cdg_condiva" "Contrato_hd" "cdg_condiva"}
  {src/adm/template/sndkycas.i "nro_cndventa" "Contrato_hd" "nro_cndventa"}
  {src/adm/template/sndkycas.i "cdg_consignatario" "Contrato_hd" "cdg_consignatario"}
  {src/adm/template/sndkycas.i "nro_contrato" "Contrato_hd" "nro_contrato"}
  {src/adm/template/sndkycas.i "cdg_postal" "Contrato_hd" "cdg_postal"}
  {src/adm/template/sndkycas.i "cdg_empresa" "Contrato_hd" "cdg_empresa"}
  {src/adm/template/sndkycas.i "cdg_formapago" "Contrato_hd" "cdg_formapago"}
  {src/adm/template/sndkycas.i "cdg_lista" "Contrato_hd" "cdg_lista"}
  {src/adm/template/sndkycas.i "nro_moneda" "Contrato_hd" "nro_moneda"}
  {src/adm/template/sndkycas.i "nro_obra" "Contrato_hd" "nro_obra"}
  {src/adm/template/sndkycas.i "cdg_planta" "Contrato_hd" "cdg_planta"}
  {src/adm/template/sndkycas.i "nro_plazo" "Contrato_hd" "nro_plazo"}
  {src/adm/template/sndkycas.i "cdg_provincia" "Contrato_hd" "cdg_provincia"}
  {src/adm/template/sndkycas.i "nro_remito" "Contrato_hd" "nro_remito"}
  {src/adm/template/sndkycas.i "cdg_solicitante" "Contrato_hd" "cdg_solicitante"}
  {src/adm/template/sndkycas.i "num_sucursal" "Contrato_hd" "num_sucursal"}
  {src/adm/template/sndkycas.i "nro_usuario" "Contrato_hd" "nro_usuario"}
  {src/adm/template/sndkycas.i "nro_vendedor" "Contrato_hd" "nro_vendedor"}
  {src/adm/template/sndkycas.i "cdg_zonag" "Contrato_hd" "cdg_zonag"}

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
  {src/adm/template/snd-list.i "Contrato_hd"}

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

