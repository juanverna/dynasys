&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW


/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Registrable-remito NO-UNDO LIKE Registrable-remito.
DEFINE TEMP-TABLE T-Remito-pedido NO-UNDO LIKE Remito-pedido.
DEFINE TEMP-TABLE T-Rem_detalle NO-UNDO LIKE Rem_detalle.
DEFINE TEMP-TABLE T-Rem_detalle-bon NO-UNDO LIKE Rem_detalle-bon.
DEFINE TEMP-TABLE T-Rem_header NO-UNDO LIKE Rem_header.
DEFINE TEMP-TABLE T-Rem_header-bon NO-UNDO LIKE Rem_header-bon.
DEFINE TEMP-TABLE T-Sub_detalle_inv NO-UNDO LIKE Sub_detalle_inv.
DEFINE TEMP-TABLE T-Sub_header_inv NO-UNDO LIKE Sub_header_inv.



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

DEFINE VARIABLE fgcolor_inc AS INTEGER INITIAL 14.
DEFINE VARIABLE bgcolor_inc AS INTEGER INITIAL 2.

DEFINE VARIABLE fgcolor_pen AS INTEGER INITIAL 9.
DEFINE VARIABLE bgcolor_pen AS INTEGER INITIAL 11.

DEFINE VARIABLE que_empresa LIKE Empresa.cdg_empresa.
DEFINE VARIABLE que_sector  LIKE Area.cdg_area.
DEFINE NEW SHARED VARIABLE codigo_iva     AS INTEGER INITIAL 1.
DEFINE NEW SHARED VARIABLE emitir_remito  AS LOGICAL.
DEFINE NEW SHARED VARIABLE emitir_factura AS LOGICAL INITIAL YES.

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
&Scoped-define EXTERNAL-TABLES Recorrido Deposito
&Scoped-define FIRST-EXTERNAL-TABLE Recorrido


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Recorrido, Deposito.
/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Ped_header Cliente

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Ped_header.fecha Ped_header.tip_comprob Ped_header.prf_comprob Ped_header.nro_comprob Cliente.cdg_cliente Cliente.nom_cliente   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table   
&Scoped-define SELF-NAME br_table
&Scoped-define QUERY-STRING-br_table FOR EACH Ped_header OF Recorrido       WHERE LOOKUP(Ped_header.cdg_estado, ~
      "AA/AM", ~
      "/") <> 0  AND Ped_header.cdg_empresa = que_empresa  AND Ped_header.nro_deposito = Deposito.nro_deposito NO-LOCK, ~
       /*AGREGADO*/       EACH Cliente OF Ped_header            WHERE LOOKUP(que_sector, ~
       Cliente.lista_sectores) <> 0 NO-LOCK     BY Ped_header.nro_comprob
&Scoped-define OPEN-QUERY-br_table OPEN QUERY {&SELF-NAME} FOR EACH Ped_header OF Recorrido       WHERE LOOKUP(Ped_header.cdg_estado, ~
      "AA/AM", ~
      "/") <> 0  AND Ped_header.cdg_empresa = que_empresa  AND Ped_header.nro_deposito = Deposito.nro_deposito NO-LOCK, ~
       /*AGREGADO*/       EACH Cliente OF Ped_header            WHERE LOOKUP(que_sector, ~
       Cliente.lista_sectores) <> 0 NO-LOCK     BY Ped_header.nro_comprob .
&Scoped-define TABLES-IN-QUERY-br_table Ped_header Cliente
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Ped_header
&Scoped-define SECOND-TABLE-IN-QUERY-br_table Cliente


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-13 RECT-9 v-pto_venta btn_renovar ~
btn_imprimir btn_remito v-transportista br_table v-bultos v-valor v-leyenda 
&Scoped-Define DISPLAYED-OBJECTS v-pto_venta v-ocupado v-transportista ~
v-bultos v-valor v-leyenda 

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
nro_area||y|sic.Ped_header.nro_area
nombre||y|sic.Ped_header.nombre
cdg_banco||y|sic.Ped_header.cdg_banco
nro_cliente||y|sic.Ped_header.nro_cliente
cdg_condiva||y|sic.Ped_header.cdg_condiva
nro_cndventa||y|sic.Ped_header.nro_cndventa
cdg_consignatario||y|sic.Ped_header.cdg_consignatario
cdg_postal||y|sic.Ped_header.cdg_postal
nro_deposito||y|sic.Ped_header.nro_deposito
nro_entidad||y|sic.Ped_header.nro_entidad
cdg_estado||y|sic.Ped_header.cdg_estado
nro_factura||y|sic.Ped_header.nro_factura
fecha||y|sic.Ped_header.fecha
cdg_formapago||y|sic.Ped_header.cdg_formapago
cdg_imputacion||y|sic.Ped_header.cdg_imputacion
cdg_lista||y|sic.Ped_header.cdg_lista
nro_moneda||y|sic.Ped_header.nro_moneda
nro_pedido||y|sic.Ped_header.nro_pedido
cdg_planta||y|sic.Ped_header.cdg_planta
nro_plazo||y|sic.Ped_header.nro_plazo
cdg_provincia||y|sic.Ped_header.cdg_provincia
cdg_recorrido||y|sic.Ped_header.cdg_recorrido
nro_remito||y|sic.Ped_header.nro_remito
cdg_solicitante||y|sic.Ped_header.cdg_solicitante
nro_usuario||y|sic.Ped_header.nro_usuario
nro_vendedor||y|sic.Ped_header.nro_vendedor
cdg_zonag||y|sic.Ped_header.cdg_zonag
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = ,
     Keys-Supplied = "nro_area,nombre,cdg_banco,nro_cliente,cdg_condiva,nro_cndventa,cdg_consignatario,cdg_postal,nro_deposito,nro_entidad,cdg_estado,nro_factura,fecha,cdg_formapago,cdg_imputacion,cdg_lista,nro_moneda,nro_pedido,cdg_planta,nro_plazo,cdg_provincia,cdg_recorrido,nro_remito,cdg_solicitante,nro_usuario,nro_vendedor,cdg_zonag"':U).

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
DEFINE BUTTON btn_imprimir 
     LABEL "&Imprimir" 
     SIZE 15 BY 1.14
     FONT 4.

DEFINE BUTTON btn_remito 
     LABEL "Cerrar R&emito" 
     SIZE 15 BY 1.14
     FONT 4.

DEFINE BUTTON btn_renovar 
     LABEL "&Renovar" 
     SIZE 15 BY 1.14
     FONT 4.

DEFINE VARIABLE v-leyenda AS CHARACTER 
     VIEW-AS EDITOR SCROLLBAR-VERTICAL
     SIZE 61 BY 4.24
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-bultos AS INTEGER FORMAT ">>>9":U INITIAL 0 
     LABEL "Bultos" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 8 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-ocupado AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE v-pto_venta AS INTEGER FORMAT "9999":U INITIAL 0 
     LABEL "Pto.Vta." 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 6 NO-UNDO.

DEFINE VARIABLE v-transportista AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 61 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-valor AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "$" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE RECTANGLE RECT-13
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 66 BY 8.81.

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 87 BY 1.62.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Ped_header, 
      Cliente SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _FREEFORM
  QUERY br_table NO-LOCK DISPLAY
      Ped_header.fecha       COLUMN-LABEL "Fecha!Entrega"
      Ped_header.tip_comprob COLUMN-LABEL "Tipo!Pedido"
      Ped_header.prf_comprob COLUMN-LABEL "Pre-!fijo"
      Ped_header.nro_comprob COLUMN-LABEL "Número!Pedido"
      Cliente.cdg_cliente    COLUMN-LABEL "Código!Cliente"
      Cliente.nom_cliente    COLUMN-LABEL "Razón!Social"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 87 BY 6.95
         BGCOLOR 15 FGCOLOR 9 FONT 4
         TITLE BGCOLOR 15 FGCOLOR 9 "Pedidos Pendientes".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     v-pto_venta AT ROW 1.24 COL 75 COLON-ALIGNED
     btn_renovar AT ROW 1.29 COL 2
     btn_imprimir AT ROW 1.29 COL 18
     btn_remito AT ROW 1.29 COL 34
     v-ocupado AT ROW 1.29 COL 48 COLON-ALIGNED NO-LABEL
     v-transportista AT ROW 2.43 COL 90 COLON-ALIGNED NO-LABEL
     br_table AT ROW 2.86 COL 1
     v-bultos AT ROW 3.62 COL 120 COLON-ALIGNED
     v-valor AT ROW 3.62 COL 136 COLON-ALIGNED
     v-leyenda AT ROW 5.05 COL 92 NO-LABEL
     "   Transportista, cantidad de bultos, valor declarado y leyenda" VIEW-AS TEXT
          SIZE 61 BY 1 AT ROW 1.24 COL 92
          BGCOLOR 5 FGCOLOR 15 
     RECT-13 AT ROW 1 COL 89
     RECT-9 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartBrowser
   External Tables: sic.Recorrido,sic.Deposito
   Allow: Basic,Browse
   Frames: 1
   Add Fields to: EXTERNAL-TABLES
   Other Settings: PERSISTENT-ONLY COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Registrable-remito T "?" NO-UNDO sic Registrable-remito
      TABLE: T-Remito-pedido T "?" NO-UNDO sic Remito-pedido
      TABLE: T-Rem_detalle T "?" NO-UNDO sic Rem_detalle
      TABLE: T-Rem_detalle-bon T "?" NO-UNDO sic Rem_detalle-bon
      TABLE: T-Rem_header T "?" NO-UNDO sic Rem_header
      TABLE: T-Rem_header-bon T "?" NO-UNDO sic Rem_header-bon
      TABLE: T-Sub_detalle_inv T "?" NO-UNDO sic Sub_detalle_inv
      TABLE: T-Sub_header_inv T "?" NO-UNDO sic Sub_header_inv
   END-TABLES.
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
         HEIGHT             = 12.05
         WIDTH              = 157.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB B-table-Win 
/* ************************* Included-Libraries *********************** */

{setsensitivo.i}
{src/adm/method/browser.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW B-table-Win
  NOT-VISIBLE,,RUN-PERSISTENT                                           */
/* SETTINGS FOR FRAME F-Main
   NOT-VISIBLE FRAME-NAME Size-to-Fit                                   */
/* BROWSE-TAB br_table v-transportista F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN v-ocupado IN FRAME F-Main
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH Ped_header OF Recorrido
      WHERE LOOKUP(Ped_header.cdg_estado,"AA/AM","/") <> 0
 AND Ped_header.cdg_empresa = que_empresa
 AND Ped_header.nro_deposito = Deposito.nro_deposito NO-LOCK, /*AGREGADO*/
      EACH Cliente OF Ped_header
           WHERE LOOKUP(que_sector, Cliente.lista_sectores) <> 0 NO-LOCK
    BY Ped_header.nro_comprob .
     _END_FREEFORM
     _Options          = "NO-LOCK KEY-PHRASE"
     _TblOptList       = ",,,"
     _Where[1]         = "Ped_header.estado = v-estados
 AND Ped_header.cdg_empresa = que_empresa"
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
ON ROW-DISPLAY OF br_table IN FRAME F-Main /* Pedidos Pendientes */
DO:
    RUN poner_color.
  /*
    IF Ped_Detalle.ult_remito <> 0 
       THEN RUN poner_incluido.
       ELSE RUN poner_excluido.
  */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-ENTRY OF br_table IN FRAME F-Main /* Pedidos Pendientes */
DO:
  /* This code displays initial values for newly added or copied rows. */
  {src/adm/template/brsentry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-LEAVE OF br_table IN FRAME F-Main /* Pedidos Pendientes */
DO:
    /* Do not disable this code or no updates will take place except
     by pressing the Save button on an Update SmartPanel. */
   {src/adm/template/brsleave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON VALUE-CHANGED OF br_table IN FRAME F-Main /* Pedidos Pendientes */
DO:
  /* This ADM trigger code must be preserved in order to notify other
     objects when the browser's current row changes. */
  {src/adm/template/brschnge.i}

  v-transportista = Ped_header.transportista.
  v-leyenda = Ped_header.leyenda.
  DISPLAY 
     v-transportista
     v-leyenda
     WITH FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_imprimir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_imprimir B-table-Win
ON CHOOSE OF btn_imprimir IN FRAME F-Main /* Imprimir */
DO:
  v-ocupado = "Imprimiendo...".
  DISPLAY v-ocupado
          WITH FRAME {&FRAME-NAME}.
  RUN imprimir_pedido.p ( ROWID(Ped_header) ).
  v-ocupado = "".
  DISPLAY v-ocupado
          WITH FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_remito
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_remito B-table-Win
ON CHOOSE OF btn_remito IN FRAME F-Main /* Cerrar Remito */
DO:

  DEFINE VARIABLE sino AS LOGICAL.
  
  MESSAGE "Desea remitir este pedido" VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación"
           SET sino.
  IF sino 
  THEN DO:
        v-ocupado = "Cerrando ...".
        DISPLAY v-ocupado
                WITH FRAME {&FRAME-NAME}.
        RUN cerrar_pedido.
        RUN dispatch IN THIS-PROCEDURE ('open-query':U).
        v-ocupado = "".
        DISPLAY v-ocupado
                WITH FRAME {&FRAME-NAME}.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_renovar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_renovar B-table-Win
ON CHOOSE OF btn_renovar IN FRAME F-Main /* Renovar */
DO:
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
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
  {src/adm/template/row-list.i "Recorrido"}
  {src/adm/template/row-list.i "Deposito"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Recorrido"}
  {src/adm/template/row-find.i "Deposito"}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE borrar_tablas_temporales B-table-Win 
PROCEDURE borrar_tablas_temporales :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    EMPTY TEMP-TABLE T-Rem_header.         
    EMPTY TEMP-TABLE T-Rem_detalle.        
    EMPTY TEMP-TABLE T-Registrable-remito. 
    EMPTY TEMP-TABLE T-Rem_header-bon.     
    EMPTY TEMP-TABLE T-Rem_detalle-bon.    
    EMPTY TEMP-TABLE T-Remito-pedido.      
    EMPTY TEMP-TABLE T-Sub_header_inv.     
    EMPTY TEMP-TABLE T-Sub_detalle_inv.    

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE cerrar_pedido B-table-Win 
PROCEDURE cerrar_pedido :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE a-ncopias AS INTEGER.
  DEFINE VARIABLE b-ncopias AS INTEGER.
  DEFINE VARIABLE que_pedido LIKE Ped_header.nro_pedido.
  DEFINE VARIABLE v-prox_docum LIKE Parametro.cdg_parametro.

  {parlocales.i}

  DO TRANSACTION:

        ASSIGN FRAME {&FRAME-NAME}        
               v-transportista 
               v-bultos
               v-valor
               v-leyenda.
        
        RUN generar_remito. /* Genera el remito */
      
        FIND CURRENT T-Rem_header EXCLUSIVE-LOCK.
        FIND Tipocomprobante OF T-Rem_header NO-LOCK.
      
        ASSIGN
            T-Rem_header.transportista = v-transportista
            T-Rem_header.imp_total     = v-valor
            T-Rem_header.leyenda       = v-leyenda
            T-Rem_header.tot_bultos    = v-bultos.
      
        {findempresa.i}

        /* ---------------------------------------------------------------- */
        /*          Invoca la emision del remito propiamente dicha          */
        /* ---------------------------------------------------------------- */

       RUN emitir_compdespacho.p (  INPUT-OUTPUT TABLE T-Rem_header,
                                    INPUT TABLE T-Rem_detalle,
                                    INPUT TABLE T-Registrable-remito, 
                                    INPUT TABLE T-Rem_header-bon,
                                    INPUT TABLE T-Rem_detalle-bon,
                                    INPUT TABLE T-Remito-pedido,
                                    INPUT TABLE T-Sub_header_inv,
                                    INPUT TABLE T-Sub_detalle_inv
                                   ).     


       RUN borrar_tablas_temporales.


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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE generar_remito B-table-Win 
PROCEDURE generar_remito :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DO TRANSACTION:

       {findempresa.i}

       ASSIGN FRAME {&FRAME-NAME} v-pto_venta.

       FIND Cliente OF Ped_header NO-LOCK.

       FIND FIRST Relacion_comprobante 
            WHERE Relacion_comprobante.cdg_comproborigen = Ped_header.cdg_comprobante
              AND Relacion_comprobante.cdg_empresa       = Ped_header.cdg_empresa
              AND Relacion_comprobante.modo_relacion     = "S" . /* (S)iguiente o (A)nula */

       CREATE T-Rem_header.
       BUFFER-COPY Ped_header TO T-Rem_header
            ASSIGN T-Rem_header.cdg_empresa     = Empresa.cdg_empresa 
                   T-Rem_header.nro_usuario     = Usuario.nro_usuario 
                   T-Rem_header.nro_entidad     = Cliente.nro_entidad
                   T-Rem_header.fecha           = TODAY 
                   T-Rem_header.nro_remito      = 0 /*NEXT-VALUE(proxima_transaccion) */
                   T-Rem_header.nro_pedido      = Ped_header.nro_pedido 
                   T-Rem_header.prf_comprob     = v-pto_venta
                   T-Rem_header.origen          = "M"
                   T-Rem_header.estado          = "E"
                   T-Rem_header.modo_factura    = "SI" /* Fijamos para que pueda emitirse la factura */
                   T-Rem_header.conformado      = YES
                   T-Rem_header.nro_comprob     = T-Rem_header.nro_remito
                   T-Rem_header.cdg_comprobante = Relacion_comprobante.cdg_comprobdestino.

       /*  asignacion hasta el 07/11/05
       CASE Ped_header.cdg_comprobante:
           WHEN "PEDIDCLI" THEN T-Rem_header.cdg_comprobante = "REMITCLI".
           WHEN "NDEVOCLI" THEN T-Rem_header.cdg_comprobante = "DEVOLCLI".

       END CASE.
       */

       FIND Vendedor OF T-Rem_header NO-LOCK.
       FIND Obra WHERE Obra.cdg_obra = Vendedor.cdg_vendedor NO-LOCK NO-ERROR.

       FOR EACH Ped_header-bon OF Ped_header:
            CREATE T-Rem_header-bon.
            BUFFER-COPY Ped_header-bon TO T-Rem_header-bon
                  ASSIGN T-Rem_header-bon.nro_remito = T-Rem_header.nro_remito.
       END.

       FOR EACH Ped_detalle OF Ped_header, Articulo OF Ped_detalle:
          
            CREATE T-Rem_detalle.
            BUFFER-COPY Ped_detalle TO T-Rem_detalle
                 ASSIGN T-Rem_detalle.nro_remito    = T-Rem_header.nro_remito
                        T-Rem_detalle.cantidad      = Ped_detalle.cantidad_ult
                        T-Rem_detalle.granel        = Ped_detalle.granel_ult
                        Ped_detalle.cantidad_cum    = Ped_detalle.cantidad_cum + Ped_detalle.cantidad_ult
                        Ped_detalle.granel_cum      = Ped_detalle.granel_cum   + Ped_detalle.granel_ult
                        Ped_detalle.cantidad_ult    = Ped_detalle.cantidad - Ped_detalle.cantidad_ult
                        Ped_detalle.granel_ult      = Ped_detalle.granel   - Ped_detalle.granel_ult
                        T-Rem_detalle.costo         = Ped_detalle.precio.

            IF AVAILABLE Obra 
                THEN T-Rem_detalle.nro_obra = Obra.nro_obra.
                   
            CREATE T-Remito-pedido.
            ASSIGN T-Remito-pedido.nro_remito       = T-Rem_detalle.nro_remito
                   T-Remito-pedido.nro_linea-rem    = T-Rem_detalle.nro_linea
                   T-Remito-pedido.cantidad         = Ped_detalle.cantidad_ult
                   T-Remito-pedido.granel           = Ped_detalle.granel_ult
                   T-Remito-pedido.nro_pedido       = Ped_detalle.nro_pedido
                   T-Remito-pedido.nro_linea-ped    = Ped_detalle.nro_linea.
                   
            IF Ped_detalle.cantidad_cum >= Ped_detalle.cantidad AND
               Ped_detalle.granel_cum >= Ped_detalle.granel
            THEN DO:
                 Ped_detalle.cdg_estado = "CC".
            END.
            ELSE DO:
                 Ped_detalle.cdg_estado = "AA".
            END.

            ASSIGN Ped_detalle.cumplido           = Ped_detalle.cdg_estado = "CC"
                   Ped_detalle.ult_remito         = T-Rem_detalle.nro_remito.

            FOR EACH Ped_detalle-bon OF Ped_detalle:
                  CREATE T-Rem_detalle-bon.
                  BUFFER-COPY Ped_detalle-bon TO T-Rem_detalle-bon
                       ASSIGN T-Rem_detalle-bon.nro_remito = T-Rem_detalle.nro_remito.
            END.

       END.

  END.

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

   RUN getparametro_n.p ( INPUT "DFPTOVTA", OUTPUT v-pto_venta ).

   {findsector.i}
   que_sector = Area.cdg_area.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  DISPLAY v-pto_venta
          WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_color B-table-Win 
PROCEDURE poner_color :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  FIND Tipocomprobante OF Ped_header NO-LOCK.
  IF Tipocomprobante.debita


      THEN ASSIGN  Ped_header.fecha:FGCOLOR IN BROWSE {&BROWSE-NAME} = 9
                   Ped_header.tip_comprob:FGCOLOR IN BROWSE {&BROWSE-NAME} = 9
                   Ped_header.prf_comprob:FGCOLOR IN BROWSE {&BROWSE-NAME} = 9
                   Ped_header.nro_comprob:FGCOLOR IN BROWSE {&BROWSE-NAME} = 9
                   Cliente.cdg_cliente:FGCOLOR IN BROWSE {&BROWSE-NAME} = 9
                   Cliente.nom_cliente:FGCOLOR IN BROWSE {&BROWSE-NAME} = 9

                   Ped_header.fecha:BGCOLOR IN BROWSE {&BROWSE-NAME} = 15
                   Ped_header.tip_comprob:BGCOLOR IN BROWSE {&BROWSE-NAME} = 15
                   Ped_header.prf_comprob:BGCOLOR IN BROWSE {&BROWSE-NAME} = 15
                   Ped_header.nro_comprob:BGCOLOR IN BROWSE {&BROWSE-NAME} = 15
                   Cliente.cdg_cliente:BGCOLOR IN BROWSE {&BROWSE-NAME} = 15
                   Cliente.nom_cliente:BGCOLOR IN BROWSE {&BROWSE-NAME} = 15.

      ELSE ASSIGN  Ped_header.fecha:FGCOLOR IN BROWSE {&BROWSE-NAME} = 15
                   Ped_header.tip_comprob:FGCOLOR IN BROWSE {&BROWSE-NAME} = 15
                   Ped_header.prf_comprob:FGCOLOR IN BROWSE {&BROWSE-NAME} = 15
                   Ped_header.nro_comprob:FGCOLOR IN BROWSE {&BROWSE-NAME} = 15
                   Cliente.cdg_cliente:FGCOLOR IN BROWSE {&BROWSE-NAME} = 15
                   Cliente.nom_cliente:FGCOLOR IN BROWSE {&BROWSE-NAME} = 15

                   Ped_header.fecha:BGCOLOR IN BROWSE {&BROWSE-NAME} = 12
                   Ped_header.tip_comprob:BGCOLOR IN BROWSE {&BROWSE-NAME} = 12
                   Ped_header.prf_comprob:BGCOLOR IN BROWSE {&BROWSE-NAME} = 12
                   Ped_header.nro_comprob:BGCOLOR IN BROWSE {&BROWSE-NAME} = 12
                   Cliente.cdg_cliente:BGCOLOR IN BROWSE {&BROWSE-NAME} = 12
                   Cliente.nom_cliente:BGCOLOR IN BROWSE {&BROWSE-NAME} = 12.

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
  {src/adm/template/sndkycas.i "nro_area" "Ped_header" "nro_area"}
  {src/adm/template/sndkycas.i "nombre" "Ped_header" "nombre"}
  {src/adm/template/sndkycas.i "cdg_banco" "Ped_header" "cdg_banco"}
  {src/adm/template/sndkycas.i "nro_cliente" "Ped_header" "nro_cliente"}
  {src/adm/template/sndkycas.i "cdg_condiva" "Ped_header" "cdg_condiva"}
  {src/adm/template/sndkycas.i "nro_cndventa" "Ped_header" "nro_cndventa"}
  {src/adm/template/sndkycas.i "cdg_consignatario" "Ped_header" "cdg_consignatario"}
  {src/adm/template/sndkycas.i "cdg_postal" "Ped_header" "cdg_postal"}
  {src/adm/template/sndkycas.i "nro_deposito" "Ped_header" "nro_deposito"}
  {src/adm/template/sndkycas.i "nro_entidad" "Ped_header" "nro_entidad"}
  {src/adm/template/sndkycas.i "cdg_estado" "Ped_header" "cdg_estado"}
  {src/adm/template/sndkycas.i "nro_factura" "Ped_header" "nro_factura"}
  {src/adm/template/sndkycas.i "fecha" "Ped_header" "fecha"}
  {src/adm/template/sndkycas.i "cdg_formapago" "Ped_header" "cdg_formapago"}
  {src/adm/template/sndkycas.i "cdg_imputacion" "Ped_header" "cdg_imputacion"}
  {src/adm/template/sndkycas.i "cdg_lista" "Ped_header" "cdg_lista"}
  {src/adm/template/sndkycas.i "nro_moneda" "Ped_header" "nro_moneda"}
  {src/adm/template/sndkycas.i "nro_pedido" "Ped_header" "nro_pedido"}
  {src/adm/template/sndkycas.i "cdg_planta" "Ped_header" "cdg_planta"}
  {src/adm/template/sndkycas.i "nro_plazo" "Ped_header" "nro_plazo"}
  {src/adm/template/sndkycas.i "cdg_provincia" "Ped_header" "cdg_provincia"}
  {src/adm/template/sndkycas.i "cdg_recorrido" "Ped_header" "cdg_recorrido"}
  {src/adm/template/sndkycas.i "nro_remito" "Ped_header" "nro_remito"}
  {src/adm/template/sndkycas.i "cdg_solicitante" "Ped_header" "cdg_solicitante"}
  {src/adm/template/sndkycas.i "nro_usuario" "Ped_header" "nro_usuario"}
  {src/adm/template/sndkycas.i "nro_vendedor" "Ped_header" "nro_vendedor"}
  {src/adm/template/sndkycas.i "cdg_zonag" "Ped_header" "cdg_zonag"}

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
  {src/adm/template/snd-list.i "Recorrido"}
  {src/adm/template/snd-list.i "Deposito"}
  {src/adm/template/snd-list.i "Ped_header"}
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

