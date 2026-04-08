&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW

/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Rem_header NO-UNDO LIKE Rem_header.


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
DEFINE VARIABLE v-punto_venta-org LIKE Punto-venta.cdg_puntovta.
DEFINE VARIABLE lista_origenes AS CHARACTER.

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
&Scoped-define EXTERNAL-TABLES Cliente
&Scoped-define FIRST-EXTERNAL-TABLE Cliente


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Cliente.
/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Rem_header Ped_header Imputacion Domicilio

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Rem_header.tip_comprob ~
Rem_header.prf_comprob Rem_header.nro_comprob Rem_header.fecha ~
Rem_header.fch_conformado Ped_header.tip_comprob Ped_header.prf_comprob ~
Ped_header.nro_comprob Ped_header.fecha Imputacion.abrevia 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table 
&Scoped-define QUERY-STRING-br_table FOR EACH Rem_header OF Cliente WHERE ~{&KEY-PHRASE} ~
      AND Rem_header.cdg_empresa = que_empresa ~
  AND Rem_header.estado = "E" ~
 AND Rem_header.tip_comprob = que_comprobante ~
 AND CAN-DO(lista_origenes,Rem_header.origen) ~
 AND Rem_header.anulado <> TRUE ~
 AND Rem_header.sin_cargo <> TRUE NO-LOCK, ~
      EACH Ped_header WHERE TRUE /* Join to Rem_header incomplete */ ~
      AND Ped_header.nro_pedido = Rem_header.nro_pedido OUTER-JOIN NO-LOCK, ~
      EACH Imputacion OF Rem_header NO-LOCK, ~
      EACH Domicilio OF Rem_header NO-LOCK ~
    ~{&SORTBY-PHRASE}
&Scoped-define OPEN-QUERY-br_table OPEN QUERY br_table FOR EACH Rem_header OF Cliente WHERE ~{&KEY-PHRASE} ~
      AND Rem_header.cdg_empresa = que_empresa ~
  AND Rem_header.estado = "E" ~
 AND Rem_header.tip_comprob = que_comprobante ~
 AND CAN-DO(lista_origenes,Rem_header.origen) ~
 AND Rem_header.anulado <> TRUE ~
 AND Rem_header.sin_cargo <> TRUE NO-LOCK, ~
      EACH Ped_header WHERE TRUE /* Join to Rem_header incomplete */ ~
      AND Ped_header.nro_pedido = Rem_header.nro_pedido OUTER-JOIN NO-LOCK, ~
      EACH Imputacion OF Rem_header NO-LOCK, ~
      EACH Domicilio OF Rem_header NO-LOCK ~
    ~{&SORTBY-PHRASE}.
&Scoped-define TABLES-IN-QUERY-br_table Rem_header Ped_header Imputacion ~
Domicilio
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Rem_header
&Scoped-define SECOND-TABLE-IN-QUERY-br_table Ped_header
&Scoped-define THIRD-TABLE-IN-QUERY-br_table Imputacion
&Scoped-define FOURTH-TABLE-IN-QUERY-br_table Domicilio


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br_table v-cdg_deposito que_comprobante ~
btn_conformar v-fecha v-cdg_concepto v-punto_venta v-fecha_factura RECT-1 ~
RECT-17 RECT-18 RECT-19 RECT-20 RECT-21 
&Scoped-Define DISPLAYED-OBJECTS v-cdg_deposito v-nom_deposito ~
que_comprobante que_conformado v-fecha v-cdg_concepto v-punto_venta ~
v-fecha_minima v-fecha_factura 

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
nro_area||y|sic.Rem_header.nro_area
nombre||y|sic.Rem_header.nombre
nro_cliente||y|sic.Rem_header.nro_cliente
cdg_condiva||y|sic.Rem_header.cdg_condiva
nro_cndventa||y|sic.Rem_header.nro_cndventa
cdg_consignatario||y|sic.Rem_header.cdg_consignatario
mes||y|sic.Rem_header.mes
cdg_postal||y|sic.Rem_header.cdg_postal
nro_deposito||y|sic.Rem_header.nro_deposito
cdg_empresa||y|sic.Rem_header.cdg_empresa
nro_entidad||y|sic.Rem_header.nro_entidad
cdg_estado||y|sic.Rem_header.cdg_estado
nro_factura||y|sic.Rem_header.nro_factura
fecha||y|sic.Rem_header.fecha
cdg_formapago||y|sic.Rem_header.cdg_formapago
cdg_imputacion||y|sic.Rem_header.cdg_imputacion
cdg_lista||y|sic.Rem_header.cdg_lista
nro_moneda||y|sic.Rem_header.nro_moneda
nro_pedido||y|sic.Rem_header.nro_pedido
cdg_planta||y|sic.Rem_header.cdg_planta
nro_plazo||y|sic.Rem_header.nro_plazo
cdg_provincia||y|sic.Rem_header.cdg_provincia
nro_remito||y|sic.Rem_header.nro_remito
cdg_solicitante||y|sic.Rem_header.cdg_solicitante
num_sucursal||y|sic.Rem_header.num_sucursal
cdg_utran||y|sic.Rem_header.cdg_utran
nro_usuario||y|sic.Rem_header.nro_usuario
nro_vendedor||y|sic.Rem_header.nro_vendedor
cdg_zonag||y|sic.Rem_header.cdg_zonag
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = ,
     Keys-Supplied = "nro_area,nombre,nro_cliente,cdg_condiva,nro_cndventa,cdg_consignatario,mes,cdg_postal,nro_deposito,cdg_empresa,nro_entidad,cdg_estado,nro_factura,fecha,cdg_formapago,cdg_imputacion,cdg_lista,nro_moneda,nro_pedido,cdg_planta,nro_plazo,cdg_provincia,nro_remito,cdg_solicitante,num_sucursal,cdg_utran,nro_usuario,nro_vendedor,cdg_zonag"':U).

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
DEFINE BUTTON btn_cancelar 
     LABEL "Ca&ncelar" 
     SIZE 13 BY 1.14.

DEFINE BUTTON btn_conformar 
     LABEL "Con&formar" 
     SIZE 13 BY 1.14.

DEFINE BUTTON btn_generarfactura 
     LABEL "&Generar Factura" 
     SIZE 27 BY 1.14.

DEFINE BUTTON btn_sincargo 
     LABEL "Marcar &Sin Cargo" 
     SIZE 27 BY 1.14.

DEFINE VARIABLE que_comprobante AS CHARACTER FORMAT "X(256)":U INITIAL "RM" 
     VIEW-AS COMBO-BOX INNER-LINES 2
     LIST-ITEM-PAIRS "Remitos","RM",
                     "Devoluciones","DV",
                     "Ajustes","AJ"
     DROP-DOWN-LIST
     SIZE 33 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE que_conformado AS LOGICAL FORMAT "yes/no":U INITIAL YES 
     VIEW-AS COMBO-BOX INNER-LINES 2
     LIST-ITEM-PAIRS "Conformados",yes,
                     "Pendientes",no
     DROP-DOWN-LIST
     SIZE 33 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE v-cdg_concepto AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Item 1",0
     DROP-DOWN-LIST
     SIZE 62 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cdg_deposito AS CHARACTER FORMAT "X(256)" 
     LABEL "Depósito" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 15.4 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-fecha AS DATE FORMAT "99/99/9999":U 
     LABEL "Conformación" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 17 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 6 NO-UNDO.

DEFINE VARIABLE v-fecha_factura AS DATE FORMAT "99/99/99":U 
     LABEL "Fecha Factura" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 17 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 6 NO-UNDO.

DEFINE VARIABLE v-fecha_minima AS DATE FORMAT "99/99/99":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 6 NO-UNDO.

DEFINE VARIABLE v-nom_deposito AS CHARACTER FORMAT "X(25)" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 33 BY 1
     BGCOLOR 3 FGCOLOR 15 .

DEFINE VARIABLE v-punto_venta AS INTEGER FORMAT "9999":U INITIAL 0 
     LABEL "Pto Vta:" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 7 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 65 BY 1.48.

DEFINE RECTANGLE RECT-17
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 35 BY 1.62.

DEFINE RECTANGLE RECT-18
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 65 BY 1.62.

DEFINE RECTANGLE RECT-19
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 30 BY 3.24.

DEFINE RECTANGLE RECT-20
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 65 BY 3.67.

DEFINE RECTANGLE RECT-21
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 35 BY 1.62.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Rem_header, 
      Ped_header, 
      Imputacion, 
      Domicilio SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _STRUCTURED
  QUERY br_table NO-LOCK DISPLAY
      Rem_header.tip_comprob FORMAT "X(3)":U WIDTH 3.2
      Rem_header.prf_comprob FORMAT "9999":U
      Rem_header.nro_comprob FORMAT "ZZZZZZZ9":U
      Rem_header.fecha FORMAT "99/99/99":U
      Rem_header.fch_conformado COLUMN-LABEL "Confor-!mado" FORMAT "99/99/9999":U
      Ped_header.tip_comprob COLUMN-LABEL "Ti-!po" FORMAT "X(3)":U
      Ped_header.prf_comprob COLUMN-LABEL "Pre-!fijo" FORMAT "9999":U
      Ped_header.nro_comprob COLUMN-LABEL "Número!Pedido" FORMAT "ZZZZZZZ9":U
      Ped_header.fecha COLUMN-LABEL "Fecha!Pedido" FORMAT "99/99/99":U
      Imputacion.abrevia COLUMN-LABEL "Concepto!Remito" FORMAT "X(5)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS MULTIPLE SIZE 86 BY 10.62
         TITLE "Remitos pendientes del Cliente Actual".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     br_table AT ROW 1.24 COL 1
     v-cdg_deposito AT ROW 1.52 COL 99.6 COLON-ALIGNED
     v-nom_deposito AT ROW 1.52 COL 116 COLON-ALIGNED NO-LABEL
     btn_generarfactura AT ROW 3.1 COL 90
     que_comprobante AT ROW 3.1 COL 117 COLON-ALIGNED NO-LABEL
     btn_sincargo AT ROW 4.67 COL 90
     que_conformado AT ROW 4.67 COL 117 COLON-ALIGNED NO-LABEL
     btn_cancelar AT ROW 6.62 COL 90
     btn_conformar AT ROW 6.62 COL 104
     v-fecha AT ROW 6.62 COL 133 COLON-ALIGNED
     v-cdg_concepto AT ROW 9.52 COL 88 COLON-ALIGNED NO-LABEL
     v-punto_venta AT ROW 10.67 COL 96 COLON-ALIGNED
     v-fecha_minima AT ROW 10.67 COL 104 COLON-ALIGNED NO-LABEL
     v-fecha_factura AT ROW 10.67 COL 133 COLON-ALIGNED
     RECT-1 AT ROW 1.24 COL 88
     RECT-17 AT ROW 4.43 COL 118
     RECT-18 AT ROW 6.33 COL 88
     RECT-19 AT ROW 2.81 COL 88
     RECT-20 AT ROW 8.19 COL 88
     RECT-21 AT ROW 2.81 COL 118
     "  Indique el Concepto, Fecha y C.Emisor" VIEW-AS TEXT
          SIZE 62 BY 1 AT ROW 8.48 COL 90
          BGCOLOR 5 FGCOLOR 15 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartBrowser
   External Tables: sic.Cliente
   Allow: Basic,Browse
   Frames: 1
   Add Fields to: EXTERNAL-TABLES
   Other Settings: PERSISTENT-ONLY COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Rem_header T "?" NO-UNDO sic Rem_header
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
         HEIGHT             = 11.76
         WIDTH              = 153.8.
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

/* SETTINGS FOR BUTTON btn_cancelar IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_generarfactura IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_sincargo IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX que_conformado IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-fecha_minima IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-nom_deposito IN FRAME F-Main
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _TblList          = "sic.Rem_header OF sic.Cliente,sic.Ped_header WHERE sic.Rem_header ...,sic.Imputacion OF sic.Rem_header,sic.Domicilio OF sic.Rem_header"
     _Options          = "NO-LOCK KEY-PHRASE SORTBY-PHRASE"
     _TblOptList       = ", OUTER,,"
     _Where[1]         = "Rem_header.cdg_empresa = que_empresa
  AND Rem_header.estado = ""E""
 AND Rem_header.tip_comprob = que_comprobante
 AND CAN-DO(lista_origenes,Rem_header.origen)
 AND Rem_header.anulado <> TRUE
 AND Rem_header.sin_cargo <> TRUE"
     _Where[2]         = "Ped_header.nro_pedido = Rem_header.nro_pedido"
     _FldNameList[1]   > sic.Rem_header.tip_comprob
"Rem_header.tip_comprob" ? ? "character" ? ? ? ? ? ? no ? no no "3.2" yes no no "U" "" ""
     _FldNameList[2]   = sic.Rem_header.prf_comprob
     _FldNameList[3]   = sic.Rem_header.nro_comprob
     _FldNameList[4]   = sic.Rem_header.fecha
     _FldNameList[5]   > sic.Rem_header.fch_conformado
"Rem_header.fch_conformado" "Confor-!mado" "99/99/9999" "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[6]   > sic.Ped_header.tip_comprob
"Ped_header.tip_comprob" "Ti-!po" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[7]   > sic.Ped_header.prf_comprob
"Ped_header.prf_comprob" "Pre-!fijo" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[8]   > sic.Ped_header.nro_comprob
"Ped_header.nro_comprob" "Número!Pedido" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[9]   > sic.Ped_header.fecha
"Ped_header.fecha" "Fecha!Pedido" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[10]   > sic.Imputacion.abrevia
"Imputacion.abrevia" "Concepto!Remito" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
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
ON ROW-ENTRY OF br_table IN FRAME F-Main /* Remitos pendientes del Cliente Actual */
DO:
  /* This code displays initial values for newly added or copied rows. */
  {src/adm/template/brsentry.i} 

 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-LEAVE OF br_table IN FRAME F-Main /* Remitos pendientes del Cliente Actual */
DO:
    /* Do not disable this code or no updates will take place except
     by pressing the Save button on an Update SmartPanel. */
   {src/adm/template/brsleave.i}
      
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON VALUE-CHANGED OF br_table IN FRAME F-Main /* Remitos pendientes del Cliente Actual */
DO:
  /* This ADM trigger code must be preserved in order to notify other
     objects when the browser's current row changes. */
  {src/adm/template/brschnge.i}
  IF AVAILABLE Rem_header THEN
  RUN traer_deposito.
    
  
  RUN habilitar_botones.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_cancelar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_cancelar B-table-Win
ON CHOOSE OF btn_cancelar IN FRAME F-Main /* Cancelar */
DO:
   RUN dispatch IN THIS-PROCEDURE ('open-query':U). 
   RUN habilitar_botones.
   v-cdg_concepto = 0.
   DISPLAY v-cdg_concepto
           WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_conformar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_conformar B-table-Win
ON CHOOSE OF btn_conformar IN FRAME F-Main /* Conformar */
DO:
  ASSIGN FRAME {&FRAME-NAME} v-fecha.
  
  DEFINE VARIABLE s AS LOGICAL.

  IF br_table:NUM-SELECTED-ROWS > 0
  THEN DO:  
       s = NO.
       MESSAGE "Desea proceder a cambiar el estado de conformación de estos comprobantes?" 
               VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE s.
       IF s
       THEN DO:     
           RUN cambiar_conformacion.
           RUN dispatch IN THIS-PROCEDURE ('open-query':U).
           RUN habilitar_botones.
       END.
  END.
  ELSE DO:
       MESSAGE "NO se han seleccionado comprobantes" VIEW-AS ALERT-BOX ERROR.
  END.  

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_generarfactura
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_generarfactura B-table-Win
ON CHOOSE OF btn_generarfactura IN FRAME F-Main /* Generar Factura */
DO:
  DEFINE VARIABLE s AS LOGICAL.
  DEFINE VARIABLE hay_error AS LOGICAL.

  IF br_table:NUM-SELECTED-ROWS > 0
  THEN DO:  
       s = NO.
       MESSAGE "Desea proceder a facturar?" VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE s.
       IF s
       THEN DO:   
           RUN validar_datos ( OUTPUT hay_error ).
           IF NOT hay_error
           THEN DO:
               RUN generar_facturacion.
               RUN dispatch IN THIS-PROCEDURE ('open-query':U).
               RUN habilitar_botones.
           END.
       END.
  END.
  ELSE DO:
       MESSAGE "NO se han seleccionado remitos" VIEW-AS ALERT-BOX ERROR.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_sincargo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_sincargo B-table-Win
ON CHOOSE OF btn_sincargo IN FRAME F-Main /* Marcar Sin Cargo */
DO:
  DEFINE VARIABLE s AS LOGICAL.
  DEFINE VARIABLE hay_error AS LOGICAL.

  IF br_table:NUM-SELECTED-ROWS > 0
  THEN DO:  
       s = NO.
       MESSAGE "Desea proceder a MARCAR SIN CARGO estos remitos?" VIEW-AS ALERT-BOX WARNING BUTTONS YES-NO TITLE "Confirmación" UPDATE s.
       IF s
       THEN DO:   
            RUN marcar_sincargo.
            RUN dispatch IN THIS-PROCEDURE ('open-query':U).
            RUN habilitar_botones.
       END.
  END.
  ELSE DO:
       MESSAGE "NO se han seleccionado remitos" VIEW-AS ALERT-BOX ERROR.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME que_comprobante
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_comprobante B-table-Win
ON VALUE-CHANGED OF que_comprobante IN FRAME F-Main
DO:

  ASSIGN que_comprobante.
  CASE que_comprobante:
      WHEN "RM" THEN RUN cargar_conceptos ( INPUT "FACTUCLI").
      WHEN "DV" THEN RUN cargar_conceptos ( INPUT "CREDICLI").
      WHEN "AJ" THEN RUN cargar_conceptos ( INPUT "DEBITCLI").
  END.

  v-cdg_concepto = 0.
  DISPLAY v-cdg_concepto
          WITH FRAME {&FRAME-NAME} .
  RUN dispatch IN THIS-PROCEDURE('open-query').
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME que_conformado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_conformado B-table-Win
ON VALUE-CHANGED OF que_conformado IN FRAME F-Main
DO:
  ASSIGN que_conformado.
  RUN dispatch IN THIS-PROCEDURE('open-query').
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_deposito
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_deposito B-table-Win
ON LEAVE OF v-cdg_deposito IN FRAME F-Main /* Depósito */
DO:
   DISPLAY v-cdg_deposito WITH FRAME {&FRAME-NAME}.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_deposito B-table-Win
ON LEFT-MOUSE-DBLCLICK OF v-cdg_deposito IN FRAME F-Main /* Depósito */
OR "+" OF v-cdg_deposito IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_deposito IN FRAME {&FRAME-NAME}

DO:
  
  DEFINE VARIABLE rid_deposito AS ROWID.
  RUN seldepos.p ( INPUT-OUTPUT rid_deposito, INPUT YES).
  IF rid_deposito <> ?
  THEN DO:
       FIND Deposito WHERE ROWID(Deposito) = rid_deposito NO-LOCK.
       DISPLAY Deposito.cdg_deposito @ v-cdg_deposito
               WITH FRAME {&FRAME-NAME}.
       APPLY "RETURN" TO SELF.
       RETURN NO-APPLY.
  END.             
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_deposito B-table-Win
ON RETURN OF v-cdg_deposito IN FRAME F-Main /* Depósito */
DO:

  FIND Deposito WHERE Deposito.cdg_deposito = INPUT FRAME F-Main v-cdg_deposito NO-LOCK NO-ERROR.
  IF NOT AVAILABLE Deposito 
  THEN DO:
       RUN PONMENSJ.P ( '1036' ).
       RETURN NO-APPLY.
  END.
  
  ASSIGN v-cdg_deposito.
  v-nom_deposito = Deposito.nombre.
  DISPLAY v-nom_deposito 
          WITH FRAME F-Main.     
          
/*   DEFINE VARIABLE h AS HANDLE NO-UNDO.                     */
/*   DEFINE VARIABLE c AS CHAR   NO-UNDO.                     */
/*                                                            */
/*   RUN get-link-handle IN adm-broker-hdl                    */
/*        (THIS-PROCEDURE, 'Posicionar-Target':U, OUTPUT c).  */
/*   IF NUM-ENTRIES (c) eq 1 THEN DO:                         */
/*     h = WIDGET-HANDLE (c).                                 */
/*     RUN posicionar_query IN h (INPUT ROWID(Deposito)).     */
/*   END.                                                     */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-punto_venta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-punto_venta B-table-Win
ON ENTRY OF v-punto_venta IN FRAME F-Main /* Pto Vta: */
DO:
  v-punto_venta-org = v-punto_venta:INPUT-VALUE IN FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-punto_venta B-table-Win
ON LEAVE OF v-punto_venta IN FRAME F-Main /* Pto Vta: */
DO:
    IF INPUT FRAME {&FRAME-NAME} v-punto_venta <> v-punto_venta-org
    THEN DO:
         FIND Punto-venta WHERE Punto-venta.cdg_empresa  = que_empresa 
                            AND Punto-venta.cdg_puntovta = INPUT FRAME {&FRAME-NAME} v-punto_venta
                                NO-LOCK NO-ERROR.
         IF NOT AVAILABLE Punto-venta
         THEN DO:
              MESSAGE "No existe el punto de venta indicado" VIEW-AS ALERT-BOX ERROR.
              DISPLAY v-punto_venta-org @ v-punto_venta
                      WITH FRAME {&FRAME-NAME}.
         END.
         ELSE DO:
              ASSIGN FRAME {&FRAME-NAME} v-punto_venta.
              v-fecha_minima = IF Punto-venta.modo_fecha = "T" THEN Punto-venta.fch_cierre + 1 ELSE TODAY.
              v-fecha_factura = v-fecha_minima.
              DISPLAY v-fecha_minima
                      v-fecha_factura
                      WITH FRAME {&FRAME-NAME}.
         END.
    END.
  
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE cambiar_conformacion B-table-Win 
PROCEDURE cambiar_conformacion :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE j             AS INTEGER.

  DO WITH FRAME {&FRAME-NAME}:
     DO j = 1 TO br_table:NUM-SELECTED-ROWS:
        
        br_table:SCROLL-TO-SELECTED-ROW(j).
        br_table:FETCH-SELECTED-ROW(j).
        FIND CURRENT Rem_header EXCLUSIVE-LOCK.
        Rem_header.conformado = NOT que_conformado.
        IF Rem_header.conformado 
           THEN Rem_header.fch_conformado = v-fecha.
           ELSE Rem_header.fch_conformado = ?.

     END.
  END.
  

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE cambiar_lista_origenes B-table-Win 
PROCEDURE cambiar_lista_origenes :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER p-lista AS CHARACTER.

  DEFINE VARIABLE j AS INTEGER.

  lista_origenes = "".
  DO j = 1 TO LENGTH(p-lista):
      lista_origenes = lista_origenes + "," + SUBSTRING(p-lista,j,1).
  END.
  lista_origenes = SUBSTRING(lista_origenes,2).

   RUN dispatch IN THIS-PROCEDURE ('open-query':U).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE cargar_conceptos B-table-Win 
PROCEDURE cargar_conceptos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   DEFINE INPUT PARAMETER que_concepto LIKE Tipocomprobante.cdg_comprobante.

   DEFINE VARIABLE lista AS CHARACTER.

   lista = ",[Seleccione un Concepto],0".

   FIND Tipocomprobante WHERE Tipocomprobante.cdg_comprobante = que_concepto
                          AND Tipocomprobante.cdg_empresa = que_empresa NO-LOCK.

   FOR EACH Comprobante_concepto OF Tipocomprobante, Imputacion OF Comprobante_concepto:
       lista = lista + "," + Imputacion.dsc_imputacion + "," + TRIM(STRING(Imputacion.cdg_imputacion,">>>>>>9")).
   END.
   v-cdg_concepto:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = SUBSTRING(lista,2).

   RUN getptovta_comprobante.p ( INPUT Tipocomprobante.cdg_comprobante, OUTPUT v-punto_venta).
   DISPLAY v-punto_venta
       WITH FRAME {&FRAME-NAME}.

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE generar_facturacion B-table-Win 
PROCEDURE generar_facturacion :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE lista_errores   AS CHARACTER.
  DEFINE VARIABLE j               AS INTEGER.
  DEFINE VARIABLE v-cant_lineas   AS INTEGER.
  DEFINE VARIABLE v-max_lineas       AS INTEGER.
  
  {parlocales.i}

   RUN getparametro.p (  INPUT  "PEDMXLIN",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).
    IF v-valor_n <> ? 
        THEN v-max_lineas = v-valor_n.
        ELSE v-max_lineas = 0.

  
    FIND Deposito WHERE Deposito.cdg_deposito = v-cdg_deposito.
    DO WITH FRAME {&FRAME-NAME}:
     DO j = 1 TO br_table:NUM-SELECTED-ROWS:
        br_table:SCROLL-TO-SELECTED-ROW(j).
        br_table:FETCH-SELECTED-ROW(j).
        FIND CURRENT Rem_header NO-LOCK.

        FOR EACH Rem_detalle OF Rem_header, Articulo OF Rem_detalle BREAK BY Articulo.cdg_articulo:

            IF Cliente.condensado_sino /* El cliente agrupa articulos en la factura */
            THEN DO:
                IF LAST-OF(Articulo.cdg_articulo)
                    THEN v-cant_lineas = v-cant_lineas + 1.
            END.
            ELSE DO:
                v-cant_lineas = v-cant_lineas + 1.
            END.

        END.
        CREATE T-Rem_header.
        BUFFER-COPY Rem_header TO T-Rem_header
            ASSIGN T-Rem_header.nro_deposito = Deposito.nro_deposito.
     END.
  END.

  IF ( v-max_lineas > 0 AND v-cant_lineas > v-max_lineas ) 
  THEN DO:

      EMPTY TEMP-TABLE T-Rem_header.

      RUN ponmensj.p ( INPUT "FACT034" ).
      RETURN ERROR.
  END.
  ELSE DO:
      RUN facturar_remitos.p ( INPUT TABLE T-Rem_header, 
                               INPUT v-cdg_concepto, 
                               INPUT v-punto_venta, 
                               INPUT v-fecha_factura , 
                               OUTPUT lista_errores).
    
      DO j = 1 TO NUM-ENTRIES(lista_errores,",").
         RUN ponmensj.p ( INPUT ENTRY(j,lista_errores,",")).
      END.
    
      EMPTY TEMP-TABLE T-Rem_header.
  END.



END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE habilitar_botones B-table-Win 
PROCEDURE habilitar_botones :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  IF AVAILABLE Rem_header
  THEN DO:
       btn_conformar:LABEL IN FRAME {&FRAME-NAME} = IF Rem_header.conformado THEN "&Desconf" ELSE "Con&formar".
       btn_conformar:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
  END.
  ELSE DO:
       btn_conformar:LABEL IN FRAME {&FRAME-NAME} = IF que_conformado THEN "&Desconf" ELSE "Con&formar".
       btn_conformar:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
  END.

  btn_generarfactura:SENSITIVE IN FRAME {&FRAME-NAME} = que_conformado 
        AND br_table:NUM-SELECTED-ROWS > 0.
  btn_cancelar:SENSITIVE IN FRAME {&FRAME-NAME} = que_conformado 
        AND br_table:NUM-SELECTED-ROWS > 0.
  btn_sincargo:SENSITIVE IN FRAME {&FRAME-NAME} = que_conformado 
        AND br_table:NUM-SELECTED-ROWS > 0.

  v-fecha:SENSITIVE IN FRAME {&FRAME-NAME} = NOT que_conformado AND AVAILABLE Rem_header.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize B-table-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

   DEFINE VARIABLE lista AS CHARACTER.

  /* Code placed here will execute PRIOR to standard behavior. */

   {findempresa.i}
   que_empresa = Empresa.cdg_empresa.

   que_conformado = YES.
   que_comprobante = "RM".

   v-fecha = TODAY - 1. 

   FIND FIRST deposito.
   v-cdg_deposito = deposito.cdg_deposito.
   v-nom_deposito = Deposito.nombre.
   DISPLAY v-cdg_deposito
        v-nom_deposito
        WITH FRAME {&FRAME-NAME}.
   
   RUN cargar_conceptos ( INPUT "FACTUCLI").

   v-cdg_concepto = 1.

   FIND Punto-venta WHERE Punto-venta.cdg_empresa  = que_empresa 
                      AND Punto-venta.cdg_puntovta = v-punto_venta
                          NO-LOCK NO-ERROR.
   v-fecha_minima = Punto-venta.fch_cierre + 1.
   v-fecha_factura = TODAY.

   /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  DISPLAY que_conformado
          v-fecha
          v-punto_venta
          v-fecha_factura
          v-fecha_minima
          que_comprobante
          v-cdg_deposito
         
          WITH FRAME {&FRAME-NAME}.

  RUN habilitar_botones.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-open-query B-table-Win 
PROCEDURE local-open-query :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'open-query':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  APPLY "VALUE-CHANGED" TO {&BROWSE-NAME} IN FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE marcar_sincargo B-table-Win 
PROCEDURE marcar_sincargo :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE lista_errores AS CHARACTER.
  DEFINE VARIABLE j             AS INTEGER.
  
  DO WITH FRAME {&FRAME-NAME}:
     DO j = 1 TO br_table:NUM-SELECTED-ROWS:
        br_table:SCROLL-TO-SELECTED-ROW(j).
        br_table:FETCH-SELECTED-ROW(j).
        FIND CURRENT Rem_header NO-LOCK.
        CREATE T-Rem_header.
        BUFFER-COPY Rem_header TO T-Rem_header.
     END.
  END.

  RUN marcar_sincargo.p ( INPUT TABLE T-Rem_header, 
                          OUTPUT lista_errores).

  DO j = 1 TO NUM-ENTRIES(lista_errores,",").
     RUN ponmensj.p ( INPUT ENTRY(j,lista_errores,",")).
  END.

  EMPTY TEMP-TABLE T-Rem_header.

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
  {src/adm/template/sndkycas.i "cdg_utran" "Rem_header" "cdg_utran"}
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
  {src/adm/template/snd-list.i "Cliente"}
  {src/adm/template/snd-list.i "Rem_header"}
  {src/adm/template/snd-list.i "Ped_header"}
  {src/adm/template/snd-list.i "Imputacion"}
  {src/adm/template/snd-list.i "Domicilio"}

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_deposito B-table-Win 
PROCEDURE traer_deposito :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  
  FIND Deposito WHERE Deposito.nro_deposito = Rem_header.nro_deposito NO-LOCK NO-ERROR.
  IF NOT AVAILABLE Deposito 
  THEN DO:
       RUN PONMENSJ.P ( '1036' ).
       RETURN NO-APPLY.
  END.
  
  v-cdg_deposito = Deposito.cdg_deposito.
  v-nom_deposito = Deposito.nombre.

  DISPLAY v-cdg_deposito
          v-nom_deposito 
          WITH FRAME F-Main.   

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE validar_datos B-table-Win 
PROCEDURE validar_datos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE OUTPUT PARAMETER p-error AS LOGICAL.

  DEFINE VARIABLE sin_imputacion AS LOGICAL.

  p-error = YES.

  ASSIGN FRAME {&FRAME-NAME} v-cdg_concepto v-punto_venta v-fecha_factura.
  IF v-cdg_concepto = 0
  THEN DO:
      RUN ponmensj.p ( INPUT "REMI060" ).
      RETURN ERROR.
  END.

  FIND Punto-venta WHERE Punto-venta.cdg_empresa  = que_empresa
                     AND Punto-venta.cdg_puntovta = v-punto_venta
                         NO-LOCK NO-ERROR.
  IF NOT AVAILABLE Punto-venta
  THEN DO:
    RUN ponmensj.p ( INPUT "REMI063" ).
    RETURN ERROR.
  END.
  ELSE DO:
    IF v-fecha_factura > TODAY
    THEN DO:
        RUN ponmensj.p ( INPUT "REMI065" ).
        RETURN ERROR.
    END.
    ELSE DO:
        IF v-fecha_factura <= Punto-venta.fch_cierre
        THEN DO:
            RUN ponmensj.p ( INPUT "REMI062" ).
            RETURN ERROR.
        END.
        ELSE DO:
            FIND Condicion_impos OF Cliente NO-LOCK.
            IF CAN-FIND(FIRST Fac_header
                              WHERE Fac_header.cdg_empresa = que_empresa
                                AND Fac_header.tip_comprob = "F" + Condicion_impos.tipo_factura  
                                AND Fac_header.prf_comprob = v-punto_venta
                                AND Fac_header.fecha > v-fecha_factura)
            THEN DO:
                RUN ponmensj.p ( INPUT "REMI061" ).
                RETURN ERROR.
            END.
            ELSE DO:
                IF br_table:NUM-SELECTED-ROWS > 1 AND NOT Cliente.agrupa_remitos
                THEN DO:
                    RUN ponmensj.p ( INPUT "REMI064" ).
                    RETURN ERROR.
                END.
                ELSE DO:
                    RUN validar_imputaciones ( OUTPUT sin_imputacion ).
                    IF sin_imputacion 
                    THEN DO: 
                        RUN ponmensj.p ( INPUT "FAPR061" ).
                        RETURN ERROR.
                    END.
                END.
            END.
        END.
    END.
  END.

  p-error = NO.
/*
  v-cdg_concepto <> 0. 060
  fecha_factura: contra cierre pto_vta 062 Y otros registros de fac_header 061. 
*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE validar_imputaciones B-table-Win 
PROCEDURE validar_imputaciones :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE OUTPUT PARAMETER hay_error AS LOGICAL.

  DEFINE VARIABLE j AS INTEGER.

  hay_error = NO.

  DO WITH FRAME {&FRAME-NAME}:
     DO j = 1 TO br_table:NUM-SELECTED-ROWS:
        br_table:SCROLL-TO-SELECTED-ROW(j).
        br_table:FETCH-SELECTED-ROW(j).
        FIND CURRENT Rem_header NO-LOCK.
        FOR EACH Rem_detalle OF Rem_header, Articulo OF Rem_detalle, Familia_articulo OF Articulo:
             FIND FIRST Familia_cuenta OF Familia_articulo 
                  WHERE Familia_cuenta.cdg_imputacion = v-cdg_concepto
                        NO-ERROR.
             IF NOT AVAILABLE Familia_cuenta
             THEN DO:
                 hay_error = YES.
             END.

        END.
     END.
  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

