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

DEFINE VAR p-nro_cliente AS INT NO-UNDO INITIAL 0.
DEFINE VAR p-nro-identificacion AS INT NO-UNDO INITIAL 0.

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
&Scoped-define INTERNAL-TABLES Rem_header Cliente evento

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Rem_header.tip_comprob Rem_header.prf_comprob Rem_header.nro_comprob evento.nro_evento evento.fasignado evento.frealizado Rem_header.fecha Cliente.cdg_cliente Cliente.nom_cliente Cliente.cuit   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table   
&Scoped-define SELF-NAME br_table
&Scoped-define QUERY-STRING-br_table FOR EACH Rem_header WHERE ~{&KEY-PHRASE} AND      Rem_header.origen = "M" AND      ( ( Rem_header.estado = "E" AND NOT tnf ) or ( rem_header.estado = "-" AND tnf )) AND      rem_header.sin_cargo = tsc AND      ( rem_header.nro_cliente = p-nro_cliente OR p-nro_cliente = 0 ) AND      ( rem_header.nro_comprob =  p-nro-identificacion OR p-nro-identificacion = 0 ) AND      Rem_header.anulado <> TRUE NO-LOCK, ~
            FIRST Cliente OF Rem_header NO-LOCK, ~
            FIRST evento WHERE evento.nro_identificacion = rem_header.nro_remito AND            evento.origen = rem_header.cdg_comprobante             BY rem_header.fecha DESCENDING BY rem_header.prf_comprob
&Scoped-define OPEN-QUERY-br_table OPEN QUERY {&SELF-NAME} FOR EACH Rem_header WHERE ~{&KEY-PHRASE} AND      Rem_header.origen = "M" AND      ( ( Rem_header.estado = "E" AND NOT tnf ) or ( rem_header.estado = "-" AND tnf )) AND      rem_header.sin_cargo = tsc AND      ( rem_header.nro_cliente = p-nro_cliente OR p-nro_cliente = 0 ) AND      ( rem_header.nro_comprob =  p-nro-identificacion OR p-nro-identificacion = 0 ) AND      Rem_header.anulado <> TRUE NO-LOCK, ~
            FIRST Cliente OF Rem_header NO-LOCK, ~
            FIRST evento WHERE evento.nro_identificacion = rem_header.nro_remito AND            evento.origen = rem_header.cdg_comprobante             BY rem_header.fecha DESCENDING BY rem_header.prf_comprob.
&Scoped-define TABLES-IN-QUERY-br_table Rem_header Cliente evento
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Rem_header
&Scoped-define SECOND-TABLE-IN-QUERY-br_table Cliente
&Scoped-define THIRD-TABLE-IN-QUERY-br_table evento


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS v-cdg_cliente v-identificacion v-evento ~
BUTTON-8 Tsc Tnf br_table 
&Scoped-Define DISPLAYED-OBJECTS v-cdg_cliente v-identificacion v-evento ~
Tsc Tnf 

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
cdg_comprobante|y|y|SIC.Rem_header.cdg_comprobante
cdg_utran|y|y|SIC.Rem_header.cdg_utran
nro_area||y|SIC.Rem_header.nro_area
nombre||y|SIC.Rem_header.nombre
nro_cliente||y|SIC.Rem_header.nro_cliente
cdg_condiva||y|SIC.Rem_header.cdg_condiva
nro_cndventa||y|SIC.Rem_header.nro_cndventa
cdg_consignatario||y|SIC.Rem_header.cdg_consignatario
mes||y|SIC.Rem_header.mes
cdg_postal||y|SIC.Rem_header.cdg_postal
nro_deposito||y|SIC.Rem_header.nro_deposito
cdg_empresa||y|SIC.Rem_header.cdg_empresa
nro_entidad||y|SIC.Rem_header.nro_entidad
cdg_estado||y|SIC.Rem_header.cdg_estado
nro_factura||y|SIC.Rem_header.nro_factura
fecha||y|SIC.Rem_header.fecha
cdg_formapago||y|SIC.Rem_header.cdg_formapago
cdg_imputacion||y|SIC.Rem_header.cdg_imputacion
cdg_lista||y|SIC.Rem_header.cdg_lista
nro_moneda||y|SIC.Rem_header.nro_moneda
nro_pedido||y|SIC.Rem_header.nro_pedido
cdg_planta||y|SIC.Rem_header.cdg_planta
nro_plazo||y|SIC.Rem_header.nro_plazo
cdg_provincia||y|SIC.Rem_header.cdg_provincia
nro_remito||y|SIC.Rem_header.nro_remito
cdg_solicitante||y|SIC.Rem_header.cdg_solicitante
num_sucursal||y|SIC.Rem_header.num_sucursal
nro_usuario||y|SIC.Rem_header.nro_usuario
nro_vendedor||y|SIC.Rem_header.nro_vendedor
cdg_zonag||y|SIC.Rem_header.cdg_zonag
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = "cdg_comprobante,cdg_utran",
     Keys-Supplied = "cdg_comprobante,cdg_utran,nro_area,nombre,nro_cliente,cdg_condiva,nro_cndventa,cdg_consignatario,mes,cdg_postal,nro_deposito,cdg_empresa,nro_entidad,cdg_estado,nro_factura,fecha,cdg_formapago,cdg_imputacion,cdg_lista,nro_moneda,nro_pedido,cdg_planta,nro_plazo,cdg_provincia,nro_remito,cdg_solicitante,num_sucursal,nro_usuario,nro_vendedor,cdg_zonag"':U).

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
DEFINE BUTTON BUTTON-8 
     IMAGE-UP FILE "img/excel.gif":U
     LABEL "Button 8" 
     SIZE 15 BY 1.14.

DEFINE VARIABLE v-cdg_cliente AS CHARACTER FORMAT "X(256)":U 
     LABEL "Cliente" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 14  NO-UNDO.

DEFINE VARIABLE v-evento AS CHARACTER FORMAT "X(256)":U 
     LABEL "Evento" 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     BGCOLOR 14  NO-UNDO.

DEFINE VARIABLE v-identificacion AS CHARACTER FORMAT "X(256)":U 
     LABEL "Remito" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 14  NO-UNDO.

DEFINE VARIABLE Tnf AS LOGICAL INITIAL no 
     LABEL "No facturar" 
     VIEW-AS TOGGLE-BOX
     SIZE 15 BY .81 NO-UNDO.

DEFINE VARIABLE Tsc AS LOGICAL INITIAL no 
     LABEL "Sin Cargo" 
     VIEW-AS TOGGLE-BOX
     SIZE 13.4 BY .81 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Rem_header, 
      Cliente, 
      evento SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _FREEFORM
  QUERY br_table NO-LOCK DISPLAY
      Rem_header.tip_comprob FORMAT "X(3)":U
      Rem_header.prf_comprob FORMAT "9999":U
      Rem_header.nro_comprob FORMAT "ZZZZZZZ9":U
      evento.nro_evento 
      evento.fasignado 
      evento.frealizado 
      Rem_header.fecha FORMAT "99/99/99":U
      Cliente.cdg_cliente FORMAT "X(8)":U WIDTH 14.2
      Cliente.nom_cliente FORMAT "X(40)":U
      Cliente.cuit COLUMN-LABEL "Número de!C.U.I.T." FORMAT "X(15)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 142 BY 8.57
         TITLE "Remitos Pendientes de Informe de Precios y Facturación" ROW-HEIGHT-CHARS .52.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     v-cdg_cliente AT ROW 1.14 COL 7.2 COLON-ALIGNED WIDGET-ID 12
     v-identificacion AT ROW 1.14 COL 33 COLON-ALIGNED WIDGET-ID 10
     v-evento AT ROW 1.14 COL 53 WIDGET-ID 4
     BUTTON-8 AT ROW 1.14 COL 117 WIDGET-ID 14
     Tsc AT ROW 1.19 COL 80.4 WIDGET-ID 8
     Tnf AT ROW 1.19 COL 96.6 WIDGET-ID 6
     br_table AT ROW 2.43 COL 1
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
         HEIGHT             = 11.1
         WIDTH              = 158.4.
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
   NOT-VISIBLE Size-to-Fit                                              */
/* BROWSE-TAB br_table Tnf F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

ASSIGN 
       br_table:ALLOW-COLUMN-SEARCHING IN FRAME F-Main = TRUE
       br_table:COLUMN-RESIZABLE IN FRAME F-Main       = TRUE
       br_table:COLUMN-MOVABLE IN FRAME F-Main         = TRUE.

/* SETTINGS FOR FILL-IN v-evento IN FRAME F-Main
   ALIGN-L                                                              */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH Rem_header WHERE ~{&KEY-PHRASE} AND
     Rem_header.origen = "M" AND
     ( ( Rem_header.estado = "E" AND NOT tnf ) or ( rem_header.estado = "-" AND tnf )) AND
     rem_header.sin_cargo = tsc AND
     ( rem_header.nro_cliente = p-nro_cliente OR p-nro_cliente = 0 ) AND
     ( rem_header.nro_comprob =  p-nro-identificacion OR p-nro-identificacion = 0 ) AND
     Rem_header.anulado <> TRUE NO-LOCK,
     FIRST Cliente OF Rem_header NO-LOCK,
     FIRST evento WHERE evento.nro_identificacion = rem_header.nro_remito AND
           evento.origen = rem_header.cdg_comprobante
            BY rem_header.fecha DESCENDING BY rem_header.prf_comprob.
     _END_FREEFORM
     _Options          = "NO-LOCK KEY-PHRASE SORTBY-PHRASE"
     _Where[1]         = "Rem_header.origen = ""M""
 AND ( Rem_header.estado = ""E"" or rem_header.estado = ""-"" )
 AND Rem_header.anulado <> TRUE"
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
ON MOUSE-MENU-DBLCLICK OF br_table IN FRAME F-Main /* Remitos Pendientes de Informe de Precios y Facturación */
DO:
/*tiene aviso relacionado*/
APPLY "MOUSE-SELECT-CLICK" TO SELF.
DEFINE BUFFER b-relacionado FOR evento.
    IF evento.anulado THEN DO:
            MESSAGE "El evento esta anulado, la info es solo a modo referencia" VIEW-AS ALERT-BOX ERROR.
    END.
      RUN d-zoom-evento.w ( evento.nro_evento, "" ).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON MOUSE-SELECT-DBLCLICK OF br_table IN FRAME F-Main /* Remitos Pendientes de Informe de Precios y Facturación */
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
    ELSE DO:    
        IF evento.origen = "CONTRATO" THEN DO:
              FIND contrato_hd WHERE contrato_hd.nro_contrato = evento.nro_identificacion NO-ERROR.
                  IF NOT AVAILABLE contrato_hd THEN DO:
                  MESSAGE "Cotrato no registrato" VIEW-AS ALERT-BOX ERROR.
                  RETURN NO-APPLY.
              END.
              /*RUN ocultar_window.*/
              RUN d-zoom-contrato.w ( contrato_hd.nro_contrato ).
              /*RUN mostrar_window.*/
        END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-ENTRY OF br_table IN FRAME F-Main /* Remitos Pendientes de Informe de Precios y Facturación */
DO:
  /* This code displays initial values for newly added or copied rows. */
  {src/adm/template/brsentry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-LEAVE OF br_table IN FRAME F-Main /* Remitos Pendientes de Informe de Precios y Facturación */
DO:
    /* Do not disable this code or no updates will take place except
     by pressing the Save button on an Update SmartPanel. */
   {src/adm/template/brsleave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON VALUE-CHANGED OF br_table IN FRAME F-Main /* Remitos Pendientes de Informe de Precios y Facturación */
DO:
  /* This ADM trigger code must be preserved in order to notify other
     objects when the browser's current row changes. */
  {src/adm/template/brschnge.i}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-8
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-8 B-table-Win
ON CHOOSE OF BUTTON-8 IN FRAME F-Main /* Button 8 */
DO:
  run excel-export ({&BROWSE-NAME}:handle).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Tnf
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Tnf B-table-Win
ON VALUE-CHANGED OF Tnf IN FRAME F-Main /* No facturar */
DO:
  ASSIGN FRAME {&FRAME-NAME} tnf .
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Tsc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Tsc B-table-Win
ON VALUE-CHANGED OF Tsc IN FRAME F-Main /* Sin Cargo */
DO:
    ASSIGN FRAME {&FRAME-NAME} tsc .
    RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_cliente
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_cliente B-table-Win
ON LEAVE OF v-cdg_cliente IN FRAME F-Main /* Cliente */
DO:
    ASSIGN v-cdg_cliente.
    p-nro_cliente = 0.
    IF v-cdg_cliente <> "" THEN DO:
        FIND cliente WHERE cliente.cdg_cliente = v-cdg_cliente NO-ERROR.
        IF NOT AVAILABLE cliente THEN DO:
            MESSAGE "Cliente desconocido, Reintente" VIEW-AS ALERT-BOX ERROR.
            RETURN NO-APPLY.
        END.
        p-nro_cliente = cliente.nro_cliente.
        RUN dispatch IN THIS-PROCEDURE ('open-query':U).
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_cliente B-table-Win
ON MOUSE-MENU-DOWN OF v-cdg_cliente IN FRAME F-Main /* Cliente */
DO:

  &SCOPED-DEFINE ROWID_TABLA        rid_cliente
  &SCOPED-DEFINE SELECCION          SELCLIEN.P
  &SCOPED-DEFINE TABLA              Cliente
  &SCOPED-DEFINE CDG_TABLA          cdg_cliente
  &SCOPED-DEFINE DSC_TABLA          nom_cliente
  &SCOPED-DEFINE V-CDG_TABLA        v-cdg_cliente    
  &SCOPED-DEFINE MOSTRAR_DSC        NO

  {hlptabla-var.i}      

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_cliente B-table-Win
ON return OF v-cdg_cliente IN FRAME F-Main /* Cliente */
DO:
    ASSIGN v-cdg_cliente. 
    p-nro_cliente = 0.
    IF v-cdg_cliente <> "" THEN DO:
        FIND cliente WHERE cliente.cdg_cliente = v-cdg_cliente NO-ERROR.
        IF NOT AVAILABLE cliente THEN DO:
            MESSAGE "Cliente desconocido, Reintente" VIEW-AS ALERT-BOX ERROR.
            RETURN NO-APPLY.
        END.
        p-nro_cliente = cliente.nro_cliente.
        RUN dispatch IN THIS-PROCEDURE ('open-query':U).
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-evento
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-evento B-table-Win
ON LEAVE OF v-evento IN FRAME F-Main /* Evento */
DO:
  ASSIGN FRAME {&FRAME-NAME} v-evento .
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-evento B-table-Win
ON RETURN OF v-evento IN FRAME F-Main /* Evento */
DO:
    ASSIGN FRAME {&FRAME-NAME} v-evento .
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-identificacion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-identificacion B-table-Win
ON LEAVE OF v-identificacion IN FRAME F-Main /* Remito */
DO:
 ASSIGN v-identificacion.
p-nro-identificacion = 0.
ASSIGN p-nro-identificacion = INT(v-identificacion) NO-ERROR.
IF ERROR-STATUS:ERROR THEN p-nro-identificacion = 0.
 RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-identificacion B-table-Win
ON RETURN OF v-identificacion IN FRAME F-Main /* Remito */
DO:
 ASSIGN v-identificacion.
p-nro-identificacion = 0.
ASSIGN p-nro-identificacion = INT(v-identificacion) NO-ERROR.
IF ERROR-STATUS:ERROR THEN p-nro-identificacion = 0.
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
  DEF VAR key-value AS CHAR NO-UNDO.

  /* Look up the current key-value. */
  RUN get-attribute ('Key-Value':U).
  key-value = RETURN-VALUE.

  /* Find the current record using the current Key-Name. */
  RUN get-attribute ('Key-Name':U).
  CASE RETURN-VALUE:
    WHEN 'cdg_comprobante':U THEN DO:
       &Scope KEY-PHRASE Rem_header.cdg_comprobante eq key-value
       {&OPEN-QUERY-{&BROWSE-NAME}}
    END. /* cdg_comprobante */
    WHEN 'cdg_utran':U THEN DO:
       &Scope KEY-PHRASE Rem_header.cdg_utran eq key-value
       {&OPEN-QUERY-{&BROWSE-NAME}}
    END. /* cdg_utran */
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
  {src/adm/template/sndkycas.i "cdg_comprobante" "Rem_header" "cdg_comprobante"}
  {src/adm/template/sndkycas.i "cdg_utran" "Rem_header" "cdg_utran"}
  {src/adm/template/sndkycas.i "nro_area" "Rem_header" "nro_area"}
  {src/adm/template/sndkycas.i "nombre" "Rem_header" "nombre"}
  {src/adm/template/sndkycas.i "nro_cliente" "Rem_header" "nro_cliente"}
  {src/adm/template/sndkycas.i "cdg_condiva" "Rem_header" "cdg_condiva"}
  {src/adm/template/sndkycas.i "nro_cndventa" "Rem_header" "nro_cndventa"}
  {src/adm/template/sndkycas.i "cdg_consignatario" "Rem_header" "cdg_consignatario"}
  {src/adm/template/sndkycas.i "mes" "Rem_header" "mes"}
  {src/adm/template/sndkycas.i "cdg_postal" "Rem_header" "cdg_postal"}
  {src/adm/template/sndkycas.i "nro_deposito" "Rem_header" "nro_deposito"}
  {src/adm/template/sndkycas.i "cdg_empresa" "Rem_header" "cdg_empresa"}
  {src/adm/template/sndkycas.i "nro_entidad" "Rem_header" "nro_entidad"}
  {src/adm/template/sndkycas.i "cdg_estado" "Rem_header" "cdg_estado"}
  {src/adm/template/sndkycas.i "nro_factura" "Rem_header" "nro_factura"}
  {src/adm/template/sndkycas.i "fecha" "Rem_header" "fecha"}
  {src/adm/template/sndkycas.i "cdg_formapago" "Rem_header" "cdg_formapago"}
  {src/adm/template/sndkycas.i "cdg_imputacion" "Rem_header" "cdg_imputacion"}
  {src/adm/template/sndkycas.i "cdg_lista" "Rem_header" "cdg_lista"}
  {src/adm/template/sndkycas.i "nro_moneda" "Rem_header" "nro_moneda"}
  {src/adm/template/sndkycas.i "nro_pedido" "Rem_header" "nro_pedido"}
  {src/adm/template/sndkycas.i "cdg_planta" "Rem_header" "cdg_planta"}
  {src/adm/template/sndkycas.i "nro_plazo" "Rem_header" "nro_plazo"}
  {src/adm/template/sndkycas.i "cdg_provincia" "Rem_header" "cdg_provincia"}
  {src/adm/template/sndkycas.i "nro_remito" "Rem_header" "nro_remito"}
  {src/adm/template/sndkycas.i "cdg_solicitante" "Rem_header" "cdg_solicitante"}
  {src/adm/template/sndkycas.i "num_sucursal" "Rem_header" "num_sucursal"}
  {src/adm/template/sndkycas.i "nro_usuario" "Rem_header" "nro_usuario"}
  {src/adm/template/sndkycas.i "nro_vendedor" "Rem_header" "nro_vendedor"}
  {src/adm/template/sndkycas.i "cdg_zonag" "Rem_header" "cdg_zonag"}

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
  {src/adm/template/snd-list.i "Rem_header"}
  {src/adm/template/snd-list.i "Cliente"}
  {src/adm/template/snd-list.i "evento"}

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

