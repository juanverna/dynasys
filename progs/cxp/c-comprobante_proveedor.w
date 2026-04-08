&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win


/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Asn_detalle NO-UNDO LIKE Asn_detalle.
DEFINE TEMP-TABLE T-Asn_header NO-UNDO LIKE Asn_header.
DEFINE TEMP-TABLE T-Asn_totales NO-UNDO LIKE Asn_totales.
DEFINE TEMP-TABLE T-Fac_detalle_prv NO-UNDO LIKE Fac_detalle_prv.
DEFINE TEMP-TABLE T-Fac_detalle_prv_bon NO-UNDO LIKE Fac_detalle_prv_bon.
DEFINE TEMP-TABLE T-Fac_detalle_prv_impuesto NO-UNDO LIKE Fac_detalle_prv_impuesto.
DEFINE TEMP-TABLE T-Fac_header_prv NO-UNDO LIKE Fac_header_prv.
DEFINE TEMP-TABLE T-Fac_header_prv_bon NO-UNDO LIKE Fac_header_prv_bon.
DEFINE TEMP-TABLE T-Fac_header_prv_impuesto NO-UNDO LIKE Fac_header_prv_impuesto.
DEFINE NEW SHARED TEMP-TABLE T-Sub_detalle_prv NO-UNDO LIKE Sub_detalle_prv.
DEFINE NEW SHARED TEMP-TABLE T-Sub_header_prv NO-UNDO LIKE Sub_header_prv.



&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------

  File: 

  Description: 

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: 

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

&IF DEFINED(UIB_is_Running) NE 0
&THEN
DEFINE VARIABLE                rid_facprov        AS ROWID.
DEFINE VARIABLE                modo               AS INTEGER.
DEFINE VARIABLE                p-cdg_comprobante  AS CHARACTER.
&ELSE
DEFINE INPUT-OUTPUT        PARAMETER  rid_facprov        AS ROWID.
DEFINE INPUT        PARAMETER  modo               AS INTEGER.
DEFINE INPUT        PARAMETER  p-cdg_comprobante  AS CHARACTER. 
&ENDIF

/* Local Variable Definitions ---                                       */

{VRSHARED.I "NEW"}

{nrorelea.i}
{valoresmodo.i}
{valoressalida.i}

DEFINE VARIABLE cotiza_dolar              AS DECIMAL.
DEFINE VARIABLE codigo_dolar              LIKE Moneda.cdg_moneda.
DEFINE VARIABLE v-tip_comprob             AS CHARACTER.
DEFINE VARIABLE dfl_leyenda               AS CHARACTER.

DEFINE VARIABLE sino-msg                  AS LOGICAL NO-UNDO.
DEFINE VARIABLE st_seleccionado           AS CHARACTER.

DEFINE VARIABLE v-prox_docum              LIKE Parametro.cdg_parametro INITIAL "PROXNASN".
DEFINE VARIABLE v-debito                  AS CHARACTER FORMAT "X(14)".
DEFINE VARIABLE v-credito                 AS CHARACTER FORMAT "X(14)".

DEFINE VARIABLE rid_tabla                 AS ROWID.

DEFINE VARIABLE v-nro_linea               AS INTEGER.
DEFINE VARIABLE v-nro_cuenta              AS INTEGER.
DEFINE VARIABLE aux_importe               AS DECIMAL.
DEFINE VARIABLE codigo_iva                AS INTEGER INITIAL 1.
DEFINE VARIABLE hay_canje                 AS LOGICAL.

DEFINE VARIABLE v-nombre_comprobante      AS CHARACTER.
DEFINE VARIABLE v-fgcolor_comprobante     AS INTEGER.
DEFINE VARIABLE v-bgcolor_comprobante     AS INTEGER.
DEFINE VARIABLE v-primera_letra           AS CHARACTER.
DEFINE VARIABLE v-prefijo_contador        AS CHARACTER.

DEFINE VARIABLE x-primero                 LIKE T-Fac_header_prv.cdg_imputacion.

DEFINE VARIABLE rid_rendgastos            AS ROWID.

DEFINE VARIABLE que_empresa               LIKE Empresa.cdg_empresa.

DEFINE BUFFER Dolar FOR Moneda.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME BROWSE-5

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Fac_detalle_prv Articulo T-Fac_header_prv

/* Definitions for BROWSE BROWSE-5                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-5 T-Fac_detalle_prv.nro_linea ~
Articulo.cdg_articulo Articulo.descripcion Articulo.cdg_umed ~
T-Fac_detalle_prv.cantidad T-Fac_detalle_prv.granel ~
T-Fac_detalle_prv.precio T-Fac_detalle_prv.subtotal_neto 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-5 
&Scoped-define QUERY-STRING-BROWSE-5 FOR EACH T-Fac_detalle_prv OF T-Fac_header_prv NO-LOCK, ~
      EACH Articulo OF T-Fac_detalle_prv NO-LOCK
&Scoped-define OPEN-QUERY-BROWSE-5 OPEN QUERY BROWSE-5 FOR EACH T-Fac_detalle_prv OF T-Fac_header_prv NO-LOCK, ~
      EACH Articulo OF T-Fac_detalle_prv NO-LOCK.
&Scoped-define TABLES-IN-QUERY-BROWSE-5 T-Fac_detalle_prv Articulo
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-5 T-Fac_detalle_prv
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-5 Articulo


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define FIELDS-IN-QUERY-DEFAULT-FRAME T-Fac_header_prv.tip_comprob ~
T-Fac_header_prv.prf_comprob T-Fac_header_prv.nro_comprob ~
T-Fac_header_prv.fecha T-Fac_header_prv.fecha_iva ~
T-Fac_header_prv.prc_canje T-Fac_header_prv.mes T-Fac_header_prv.ano ~
T-Fac_header_prv.cdg_lista T-Fac_header_prv.nro_ocm T-Fac_header_prv.cambio ~
T-Fac_header_prv.clausula_dolar T-Fac_header_prv.cambio_dolar ~
T-Fac_header_prv.cdg_imputacion T-Fac_header_prv.leyenda_cc ~
T-Fac_header_prv.imp_neto T-Fac_header_prv.imp_total 
&Scoped-define ENABLED-FIELDS-IN-QUERY-DEFAULT-FRAME ~
T-Fac_header_prv.clausula_dolar T-Fac_header_prv.cambio_dolar ~
T-Fac_header_prv.cdg_imputacion T-Fac_header_prv.leyenda_cc 
&Scoped-define ENABLED-TABLES-IN-QUERY-DEFAULT-FRAME T-Fac_header_prv
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-DEFAULT-FRAME T-Fac_header_prv
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-BROWSE-5}
&Scoped-define QUERY-STRING-DEFAULT-FRAME FOR EACH T-Fac_header_prv SHARE-LOCK
&Scoped-define OPEN-QUERY-DEFAULT-FRAME OPEN QUERY DEFAULT-FRAME FOR EACH T-Fac_header_prv SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-DEFAULT-FRAME T-Fac_header_prv
&Scoped-define FIRST-TABLE-IN-QUERY-DEFAULT-FRAME T-Fac_header_prv


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS T-Fac_header_prv.clausula_dolar ~
T-Fac_header_prv.cambio_dolar T-Fac_header_prv.cdg_imputacion ~
T-Fac_header_prv.leyenda_cc 
&Scoped-define ENABLED-TABLES T-Fac_header_prv
&Scoped-define FIRST-ENABLED-TABLE T-Fac_header_prv
&Scoped-Define ENABLED-OBJECTS RECT-2 RECT-3 RECT-4 RECT-5 Btn_salir ~
BROWSE-5 
&Scoped-Define DISPLAYED-FIELDS T-Fac_header_prv.tip_comprob ~
T-Fac_header_prv.prf_comprob T-Fac_header_prv.nro_comprob ~
T-Fac_header_prv.fecha T-Fac_header_prv.fecha_iva ~
T-Fac_header_prv.prc_canje T-Fac_header_prv.mes T-Fac_header_prv.ano ~
T-Fac_header_prv.cdg_lista T-Fac_header_prv.nro_ocm T-Fac_header_prv.cambio ~
T-Fac_header_prv.clausula_dolar T-Fac_header_prv.cambio_dolar ~
T-Fac_header_prv.cdg_imputacion T-Fac_header_prv.leyenda_cc ~
T-Fac_header_prv.imp_neto T-Fac_header_prv.imp_total 
&Scoped-define DISPLAYED-TABLES T-Fac_header_prv
&Scoped-define FIRST-DISPLAYED-TABLE T-Fac_header_prv
&Scoped-Define DISPLAYED-OBJECTS v-pago v-comprobante v-cdg_proveedor ~
v-dsc_proveedor v-cdg_domicilio v-dsc_domicilio v-abv_provincia ~
v-tip_rendicion v-prf_rendicion v-nro_rendicion v-cdg_condicion_impos ~
v-dsc_condicion_impos v-cdg_moneda v-dsc_moneda v-cdg_condicion_venta ~
v-dsc_condicion_venta v-cdg_articulo 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD pagado C-Win 
FUNCTION pagado RETURNS CHARACTER
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btn_anular 
     LABEL "&Anular" 
     SIZE 21 BY 1.33.

DEFINE BUTTON btn_cancel 
     LABEL "&Cancelar" 
     SIZE 21 BY 1.33.

DEFINE BUTTON btn_copiar 
     LABEL "&Copiar" 
     SIZE 21 BY 1.33.

DEFINE BUTTON btn_grabar 
     LABEL "&Grabar" 
     SIZE 21 BY 1.33.

DEFINE BUTTON btn_imprim 
     LABEL "&Reimprimir" 
     SIZE 21 BY 1.33.

DEFINE BUTTON btn_nominar 
     LABEL "&Otros Datos" 
     SIZE 22 BY 1.

DEFINE BUTTON btn_observ 
     LABEL "&Leyenda" 
     SIZE 21 BY 1.33.

DEFINE BUTTON btn_porclasificacion 
     LABEL "X &Clasificación" 
     SIZE 21 BY 1.

DEFINE BUTTON Btn_salir DEFAULT 
     LABEL "&Salir" 
     SIZE 21 BY 1.33
     BGCOLOR 8 .

DEFINE BUTTON btn_verbonificaciones 
     LABEL "&Bonificaciones" 
     SIZE 21 BY 1.

DEFINE BUTTON btn_verimputacion 
     LABEL "Ver &Imputación" 
     SIZE 22 BY 1.

DEFINE VARIABLE v-abv_provincia AS CHARACTER FORMAT "X(40)" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-cdg_articulo AS CHARACTER FORMAT "X(12)":U 
     LABEL "Artículo" 
     VIEW-AS FILL-IN 
     SIZE 32 BY 1
     BGCOLOR 14 FGCOLOR 12 FONT 6 NO-UNDO.

DEFINE VARIABLE v-cdg_condicion_impos AS INTEGER FORMAT "->,>>>,>>9" INITIAL 0 
     LABEL "C.Iva." 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_condicion_venta AS CHARACTER FORMAT "X(8)" 
     LABEL "C.Venta" 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_domicilio AS INTEGER FORMAT ">>>>>>9" INITIAL 0 
     LABEL "Domicilio" 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_moneda AS CHARACTER FORMAT "X(3)" 
     LABEL "Moneda" 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_proveedor AS CHARACTER FORMAT "X(8)" 
     LABEL "Proveedor" 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-comprobante AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 30 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE v-dsc_condicion_impos AS CHARACTER FORMAT "X(25)" 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_condicion_venta AS CHARACTER FORMAT "X(25)" 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_domicilio AS CHARACTER FORMAT "X(40)" 
     VIEW-AS FILL-IN 
     SIZE 45 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_moneda AS CHARACTER FORMAT "X(20)" 
     VIEW-AS FILL-IN 
     SIZE 36 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_proveedor AS CHARACTER FORMAT "X(40)" 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-nro_rendicion AS INTEGER FORMAT ">>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-pago AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE v-prf_rendicion AS INTEGER FORMAT ">>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-tip_rendicion AS CHARACTER FORMAT "X(3)":U 
     LABEL "Rendición" 
     VIEW-AS FILL-IN 
     SIZE 7 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 133 BY 1.86.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 23 BY 1.86.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 156 BY 8.52.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 156 BY 1.43.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-5 FOR 
      T-Fac_detalle_prv, 
      Articulo SCROLLING.

DEFINE QUERY DEFAULT-FRAME FOR 
      T-Fac_header_prv SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-5 C-Win _STRUCTURED
  QUERY BROWSE-5 NO-LOCK DISPLAY
      T-Fac_detalle_prv.nro_linea COLUMN-LABEL "N.Li-!nea" FORMAT ">>9":U
      Articulo.cdg_articulo FORMAT "X(18)":U
      Articulo.descripcion FORMAT "X(60)":U WIDTH 48.2
      Articulo.cdg_umed FORMAT "X(12)":U WIDTH 13
      T-Fac_detalle_prv.cantidad COLUMN-LABEL "Cantidad!Facturada" FORMAT "->>>,>>>,>>9.99":U
      T-Fac_detalle_prv.granel COLUMN-LABEL "Granel!Facturado" FORMAT "->>>,>>>,>>9.99":U
      T-Fac_detalle_prv.precio COLUMN-LABEL "Precio!de Venta" FORMAT ">>>>>>>9.999999":U
      T-Fac_detalle_prv.subtotal_neto FORMAT "->,>>>,>>>,>>9.99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 156 BY 14.52
         BGCOLOR 15 FGCOLOR 9 
         TITLE BGCOLOR 15 FGCOLOR 9 "Artículos Facturados".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btn_copiar AT ROW 1.48 COL 26
     btn_cancel AT ROW 1.48 COL 48
     btn_anular AT ROW 1.48 COL 70
     btn_observ AT ROW 1.48 COL 92
     btn_imprim AT ROW 1.48 COL 114
     Btn_salir AT ROW 1.48 COL 137
     btn_grabar AT ROW 1.52 COL 4
     T-Fac_header_prv.tip_comprob AT ROW 3.62 COL 13 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Fac_header_prv.prf_comprob AT ROW 3.62 COL 20 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 8 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Fac_header_prv.nro_comprob AT ROW 3.62 COL 29 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Fac_header_prv.fecha AT ROW 3.62 COL 54.2 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 14 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-pago AT ROW 3.62 COL 74.6 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     T-Fac_header_prv.fecha_iva AT ROW 3.62 COL 109 COLON-ALIGNED
          LABEL "Fecha Contable"
          VIEW-AS FILL-IN 
          SIZE 15 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-comprobante AT ROW 3.62 COL 126 COLON-ALIGNED NO-LABEL
     v-cdg_proveedor AT ROW 4.81 COL 13 COLON-ALIGNED
     v-dsc_proveedor AT ROW 4.81 COL 29 COLON-ALIGNED NO-LABEL
     T-Fac_header_prv.prc_canje AT ROW 4.81 COL 142 COLON-ALIGNED
          LABEL "% Canje"
          VIEW-AS FILL-IN 
          SIZE 14 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_domicilio AT ROW 6 COL 13 COLON-ALIGNED
     v-dsc_domicilio AT ROW 6 COL 29 COLON-ALIGNED NO-LABEL
     v-abv_provincia AT ROW 6 COL 75 COLON-ALIGNED NO-LABEL
     v-tip_rendicion AT ROW 6 COL 102 COLON-ALIGNED
     v-prf_rendicion AT ROW 6 COL 110 COLON-ALIGNED NO-LABEL
     v-nro_rendicion AT ROW 6 COL 118 COLON-ALIGNED NO-LABEL
     T-Fac_header_prv.mes AT ROW 6 COL 142 COLON-ALIGNED
          LABEL "Período"
          VIEW-AS FILL-IN 
          SIZE 5 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Fac_header_prv.ano AT ROW 6 COL 148 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 8 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_condicion_impos AT ROW 7.19 COL 13 COLON-ALIGNED
     v-dsc_condicion_impos AT ROW 7.19 COL 29 COLON-ALIGNED NO-LABEL
     T-Fac_header_prv.cdg_lista AT ROW 7.19 COL 102 COLON-ALIGNED
          LABEL "Lista Nro."
          VIEW-AS FILL-IN 
          SIZE 15 BY 1
          BGCOLOR 8 FGCOLOR 15 
     T-Fac_header_prv.nro_ocm AT ROW 7.19 COL 142 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 14 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_moneda AT ROW 8.38 COL 13 COLON-ALIGNED
     v-dsc_moneda AT ROW 8.38 COL 29 COLON-ALIGNED NO-LABEL
     T-Fac_header_prv.cambio AT ROW 8.38 COL 75 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 14 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Fac_header_prv.clausula_dolar AT ROW 8.38 COL 104
          VIEW-AS TOGGLE-BOX
          SIZE 20 BY 1.05
     T-Fac_header_prv.cambio_dolar AT ROW 8.38 COL 142 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 14 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_condicion_venta AT ROW 9.57 COL 13 COLON-ALIGNED
     v-dsc_condicion_venta AT ROW 9.57 COL 29 COLON-ALIGNED NO-LABEL
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.2 ROW 1
         SIZE 162.4 BY 27.67.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME DEFAULT-FRAME
     T-Fac_header_prv.cdg_imputacion AT ROW 9.57 COL 102 COLON-ALIGNED
          LABEL "Concepto"
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "0",1
          DROP-DOWN-LIST
          SIZE 54 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Fac_header_prv.leyenda_cc AT ROW 10.76 COL 13 COLON-ALIGNED
          LABEL "Obs."
          VIEW-AS FILL-IN 
          SIZE 76 BY 1
          BGCOLOR 15 FGCOLOR 9 
     btn_verimputacion AT ROW 10.76 COL 104
     btn_nominar AT ROW 10.76 COL 136
     v-cdg_articulo AT ROW 12.19 COL 13 COLON-ALIGNED
     btn_porclasificacion AT ROW 12.19 COL 48
     btn_verbonificaciones AT ROW 12.19 COL 70
     T-Fac_header_prv.imp_neto AT ROW 12.19 COL 102 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 22 BY 1
          BGCOLOR 7 FGCOLOR 14 
     T-Fac_header_prv.imp_total AT ROW 12.19 COL 134 COLON-ALIGNED
          LABEL "Total" FORMAT "->>,>>>,>>9.99"
          VIEW-AS FILL-IN 
          SIZE 22 BY 1
          BGCOLOR 7 FGCOLOR 14 
     BROWSE-5 AT ROW 13.62 COL 3
     RECT-2 AT ROW 1.24 COL 3
     RECT-3 AT ROW 1.24 COL 136
     RECT-4 AT ROW 3.43 COL 3
     RECT-5 AT ROW 11.95 COL 3
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.2 ROW 1
         SIZE 162.4 BY 27.67.

DEFINE FRAME FRAME-A
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 134 ROW 20.29
         SIZE 11 BY 2
         TITLE "Frame A" WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Asn_detalle T "?" NO-UNDO sic Asn_detalle
      TABLE: T-Asn_header T "?" NO-UNDO sic Asn_header
      TABLE: T-Asn_totales T "?" NO-UNDO sic Asn_totales
      TABLE: T-Fac_detalle_prv T "?" NO-UNDO sic Fac_detalle_prv
      TABLE: T-Fac_detalle_prv_bon T "?" NO-UNDO sic Fac_detalle_prv_bon
      TABLE: T-Fac_detalle_prv_impuesto T "?" NO-UNDO sic Fac_detalle_prv_impuesto
      TABLE: T-Fac_header_prv T "?" NO-UNDO sic Fac_header_prv
      TABLE: T-Fac_header_prv_bon T "?" NO-UNDO sic Fac_header_prv_bon
      TABLE: T-Fac_header_prv_impuesto T "?" NO-UNDO sic Fac_header_prv_impuesto
      TABLE: T-Sub_detalle_prv T "NEW SHARED" NO-UNDO sic Sub_detalle_prv
      TABLE: T-Sub_header_prv T "NEW SHARED" NO-UNDO sic Sub_header_prv
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Facturas de Proveedor"
         HEIGHT             = 26.86
         WIDTH              = 158
         MAX-HEIGHT         = 27.67
         MAX-WIDTH          = 170.2
         VIRTUAL-HEIGHT     = 27.67
         VIRTUAL-WIDTH      = 170.2
         RESIZE             = yes
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         KEEP-FRAME-Z-ORDER = yes
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* REPARENT FRAME */
ASSIGN FRAME FRAME-A:FRAME = FRAME DEFAULT-FRAME:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME                                                           */
/* BROWSE-TAB BROWSE-5 imp_total DEFAULT-FRAME */
/* SETTINGS FOR FILL-IN T-Fac_header_prv.ano IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_anular IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_cancel IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_copiar IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_grabar IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_imprim IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_nominar IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_observ IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_porclasificacion IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_verbonificaciones IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_verimputacion IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Fac_header_prv.cambio IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX T-Fac_header_prv.cdg_imputacion IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN T-Fac_header_prv.cdg_lista IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN T-Fac_header_prv.fecha IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Fac_header_prv.fecha_iva IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN T-Fac_header_prv.imp_neto IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Fac_header_prv.imp_total IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL EXP-FORMAT                                       */
/* SETTINGS FOR FILL-IN T-Fac_header_prv.leyenda_cc IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN T-Fac_header_prv.mes IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN T-Fac_header_prv.nro_comprob IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Fac_header_prv.nro_ocm IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Fac_header_prv.prc_canje IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN T-Fac_header_prv.prf_comprob IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Fac_header_prv.tip_comprob IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-abv_provincia IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_articulo IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_condicion_impos IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_condicion_venta IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_domicilio IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_moneda IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_proveedor IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-comprobante IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_condicion_impos IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_condicion_venta IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_domicilio IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_moneda IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_proveedor IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-nro_rendicion IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-pago IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-prf_rendicion IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-tip_rendicion IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FRAME FRAME-A
                                                                        */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-5
/* Query rebuild information for BROWSE BROWSE-5
     _TblList          = "Temp-Tables.T-Fac_detalle_prv OF Temp-Tables.T-Fac_header_prv,sic.Articulo OF Temp-Tables.T-Fac_detalle_prv"
     _Options          = "NO-LOCK"
     _FldNameList[1]   > Temp-Tables.T-Fac_detalle_prv.nro_linea
"T-Fac_detalle_prv.nro_linea" "N.Li-!nea" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > sic.Articulo.cdg_articulo
"Articulo.cdg_articulo" ? "X(18)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > sic.Articulo.descripcion
"Articulo.descripcion" ? "X(60)" "character" ? ? ? ? ? ? no ? no no "48.2" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > sic.Articulo.cdg_umed
"Articulo.cdg_umed" ? ? "character" ? ? ? ? ? ? no ? no no "13" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > Temp-Tables.T-Fac_detalle_prv.cantidad
"T-Fac_detalle_prv.cantidad" "Cantidad!Facturada" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > Temp-Tables.T-Fac_detalle_prv.granel
"T-Fac_detalle_prv.granel" "Granel!Facturado" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > Temp-Tables.T-Fac_detalle_prv.precio
"T-Fac_detalle_prv.precio" "Precio!de Venta" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   = Temp-Tables.T-Fac_detalle_prv.subtotal_neto
     _Query            is OPENED
*/  /* BROWSE BROWSE-5 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME DEFAULT-FRAME
/* Query rebuild information for FRAME DEFAULT-FRAME
     _TblList          = "Temp-Tables.T-Fac_header_prv"
     _Query            is OPENED
*/  /* FRAME DEFAULT-FRAME */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Facturas de Proveedor */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Facturas de Proveedor */
DO:
  /* This event will close the window and terminate the procedure.  */
  /* APPLY "CLOSE":U TO THIS-PROCEDURE. */
  APPLY "CHOOSE":U TO Btn_salir IN FRAME {&FRAME-NAME}.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-5
&Scoped-define SELF-NAME BROWSE-5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-5 C-Win
ON DELETE-CHARACTER OF BROWSE-5 IN FRAME DEFAULT-FRAME /* Artículos Facturados */
DO:
    IF modo = MD_ALTA
    THEN DO:
        sino-msg = NO.
        MESSAGE "Desea eliminar este renglón de detalle?" 
                VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
        IF sino-msg
        THEN DO:
             DELETE T-Fac_detalle_prv.
             {&OPEN-QUERY-{&BROWSE-NAME}}
             RUN calculos.
        END.
    END.
    ELSE DO:
        BELL.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-5 C-Win
ON MOUSE-SELECT-DBLCLICK OF BROWSE-5 IN FRAME DEFAULT-FRAME /* Artículos Facturados */
OR RETURN OF {&BROWSE-NAME} IN FRAME {&FRAME-NAME}
DO:
    RUN corregir_detalle.
   {&OPEN-QUERY-{&BROWSE-NAME}}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_anular
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_anular C-Win
ON CHOOSE OF btn_anular IN FRAME DEFAULT-FRAME /* Anular */
DO:

    DEFINE VARIABLE pudo_anular AS INTEGER.
    sino-msg = NO.
    MESSAGE "Desea ANULAR este comprobante" 
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
    IF sino-msg
    THEN DO:
         RUN anular_comprobante_proveedor.p (INPUT ROWID(Fac_header_prv), OUTPUT pudo_anular).
         IF pudo_anular = 0
         THEN DO:
              DO TRANSACTION:
                 RUN borrar_tablas_temporales.
              END.
              MESSAGE "EL comprobante ha sido anulado" 
                      VIEW-AS ALERT-BOX MESSAGE TITLE "Aviso".
              
         END.
         ASSIGN codigo_salir = CD_GRABAR.
         APPLY "U1":U TO THIS-PROCEDURE.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_cancel C-Win
ON CHOOSE OF btn_cancel IN FRAME DEFAULT-FRAME /* Cancelar */
DO:
    sino-msg = NO.
    MESSAGE "Desea cancelar la operación en curso?" 
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
    IF sino-msg
    THEN DO:

        RUN borrar_tablas_temporales.

        ASSIGN codigo_salir = CD_CANCELAR.
        APPLY "U1" TO THIS-PROCEDURE.

    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_copiar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_copiar C-Win
ON CHOOSE OF btn_copiar IN FRAME DEFAULT-FRAME /* Copiar */
DO:

  RUN d-seleccionar_facprov.w (INPUT-OUTPUT rid_facprov).
  IF rid_facprov <> ?
  THEN DO:
     FIND Fac_header_prv WHERE ROWID(Fac_header_prv) = rid_facprov NO-LOCK.
     DISPLAY Fac_header_prv.tip_comprob @ T-Fac_header_prv.tip_comprob 
             Fac_header_prv.prf_comprob @ T-Fac_header_prv.prf_comprob
             Fac_header_prv.nro_comprob @ T-Fac_header_prv.nro_comprob
             WITH FRAME {&FRAME-NAME}.
     RUN traer_documento.
  END.  
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_grabar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_grabar C-Win
ON CHOOSE OF btn_grabar IN FRAME DEFAULT-FRAME /* Grabar */
DO:

  ASSIGN FRAME {&FRAME-NAME}
         T-Fac_header_prv.ano 
         T-Fac_header_prv.cambio 
         T-Fac_header_prv.cambio_dolar
         T-Fac_header_prv.clausula_dolar
         T-Fac_header_prv.cdg_lista 
         T-Fac_header_prv.fecha 
         T-Fac_header_prv.fecha_iva 
         T-Fac_header_prv.mes 
         T-Fac_header_prv.nro_comprob 
         T-Fac_header_prv.nro_ocm 
         T-Fac_header_prv.prc_canje 
         T-Fac_header_prv.prf_comprob 
         T-Fac_header_prv.tip_comprob
         T-Fac_header_prv.fecha 
         T-Fac_header_prv.leyenda_cc.
         
  RUN validar_datos ( OUTPUT hay_error).
  IF NOT hay_error
  THEN DO:

       RUN grabar_datos.

       ASSIGN codigo_salir = CD_GRABAR.
       APPLY "U1" TO THIS-PROCEDURE.
  
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_imprim
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_imprim C-Win
ON CHOOSE OF btn_imprim IN FRAME DEFAULT-FRAME /* Reimprimir */
DO:
    sino-msg = NO.
    MESSAGE "Desea REIMPRIMIR este comprobante" 
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
    IF sino-msg
    THEN DO:
         RUN imprimir_comprobante_proveedor.p (ROWID(Fac_header_prv)).
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_nominar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_nominar C-Win
ON CHOOSE OF btn_nominar IN FRAME DEFAULT-FRAME /* Otros Datos */
DO:
      RUN  d-nominar_facprov.w ( INPUT modo, INPUT 1, INPUT-OUTPUT TABLE T-Fac_header_prv).
  FIND FIRST T-Fac_header_prv.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_observ
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_observ C-Win
ON CHOOSE OF btn_observ IN FRAME DEFAULT-FRAME /* Leyenda */
DO:

   DEFINE VARIABLE puso_ok AS LOGICAL.
   RUN c-edttexto.w ( INPUT-OUTPUT T-Fac_header_prv.leyenda,
                      INPUT "Observaciones del Comprobante de Proveedor",
                      INPUT modo,
                      OUTPUT puso_ok).
   RETURN NO-APPLY.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_porclasificacion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_porclasificacion C-Win
ON CHOOSE OF btn_porclasificacion IN FRAME DEFAULT-FRAME /* X Clasificación */
DO:
  DEFINE VARIABLE que_clase   AS CHARACTER.
  DEFINE VARIABLE modo_salida AS INTEGER.
  RUN d-selarticulosxclase.w ( INPUT-OUTPUT que_clase,
                               INPUT-OUTPUT rid_tabla,
                               OUTPUT modo_salida).
  IF modo_salida = 1
  THEN DO:
       FIND Articulo WHERE ROWID(Articulo) = rid_tabla NO-LOCK.
       DISPLAY Articulo.cdg_articulo @ v-cdg_articulo
               WITH FRAME {&FRAME-NAME}.
       APPLY "RETURN" TO v-cdg_articulo.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_salir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_salir C-Win
ON CHOOSE OF Btn_salir IN FRAME DEFAULT-FRAME /* Salir */
DO:

    sino-msg = NO.
    MESSAGE "Desea abandonar esta función?" 
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
    IF sino-msg
    THEN DO:
        &IF DEFINED (adm-panel) <> 0 &THEN
            RUN dispatch IN THIS-PROCEDURE ('exit').
        &ELSE
/*          APPLY "CLOSE":U TO THIS-PROCEDURE.*/
            ASSIGN codigo_salir = CD_SALIR.
            APPLY "U1":U TO THIS-PROCEDURE.

        &ENDIF

    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_verbonificaciones
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_verbonificaciones C-Win
ON CHOOSE OF btn_verbonificaciones IN FRAME DEFAULT-FRAME /* Bonificaciones */
DO:
  RUN d-bonificaciones_facprov.w (INPUT-OUTPUT TABLE T-Fac_header_prv, INPUT-OUTPUT TABLE T-Fac_header_prv_bon, INPUT modo ).
  IF modo = MD_ALTA
  THEN DO:
      RUN calculos.
      {&OPEN-QUERY-{&BROWSE-NAME}}
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_verimputacion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_verimputacion C-Win
ON CHOOSE OF btn_verimputacion IN FRAME DEFAULT-FRAME /* Ver Imputación */
DO:
/*RUN d-ver_imputacion_comprobante_proveedor.w ( INPUT TABLE T-Sub_header_prv,
                                                 INPUT TABLE T-Sub_detalle_prv) .*/

  RUN d-ver_asiento_contable.w ( INPUT TABLE T-Asn_header,
                                 INPUT TABLE T-Asn_detalle,
                                 INPUT TABLE T-Asn_totales).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Fac_header_prv.cambio
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Fac_header_prv.cambio C-Win
ON LEAVE OF T-Fac_header_prv.cambio IN FRAME DEFAULT-FRAME /* Cambio */
DO:
  ASSIGN T-Fac_header_prv.cambio.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Fac_header_prv.cdg_imputacion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Fac_header_prv.cdg_imputacion C-Win
ON VALUE-CHANGED OF T-Fac_header_prv.cdg_imputacion IN FRAME DEFAULT-FRAME /* Concepto */
DO:
    ASSIGN T-Fac_header_prv.cdg_imputacion.
    FIND Imputacion WHERE Imputacion.cdg_imputacion = T-Fac_header_prv.cdg_imputacion NO-LOCK.
    RUN asignar_imputacion.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Fac_header_prv.clausula_dolar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Fac_header_prv.clausula_dolar C-Win
ON VALUE-CHANGED OF T-Fac_header_prv.clausula_dolar IN FRAME DEFAULT-FRAME /* Cláusula Dólar */
DO:
    ASSIGN FRAME {&FRAME-NAME} T-Fac_header_prv.clausula_dolar.
    IF T-Fac_header_prv.clausula_dolar
    THEN DO:
        RUN asignar_dolar.
    END.
    ELSE DO:
        T-Fac_header_prv.cambio_dolar = 1.
        DISPLAY T-Fac_header_prv.cambio_dolar
                 WITH FRAME {&FRAME-NAME}.
    END.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Fac_header_prv.fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Fac_header_prv.fecha C-Win
ON LEAVE OF T-Fac_header_prv.fecha IN FRAME DEFAULT-FRAME /* Fecha */
DO:
    ASSIGN T-Fac_header_prv.fecha.
    T-Fac_header_prv.fecha_iva = T-Fac_header_prv.fecha.
    DISPLAY T-Fac_header_prv.fecha_iva
        WITH FRAME {&FRAME-NAME}.
    RUN asignar_cambio.
    RUN calculos.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Fac_header_prv.nro_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Fac_header_prv.nro_comprob C-Win
ON MOUSE-SELECT-DBLCLICK OF T-Fac_header_prv.nro_comprob IN FRAME DEFAULT-FRAME /* nro_comprob */
OR MOUSE-MENU-DOWN,"." OF T-Fac_header_prv.nro_comprob IN FRAME {&FRAME-NAME}
DO:
  DEFINE VARIABLE lista_estados AS CHARACTER.
  DEFINE VARIABLE titulo_window AS CHARACTER.

  CASE modo:
     WHEN MD_ALTA          
     THEN DO:
          titulo_window = "".     /* Esta opcion la contemlamos por unicidad pero no debería producirse nunca */
          lista_estados = "".
     END.
     WHEN MD_MULTIPLE      
     THEN DO:
          titulo_window = "Selección de Facturas de Proveedores en General".
          lista_estados = " ,E".
     END.
     WHEN MD_DEFINIDA             /* Esta opcion la contemlamos por unicidad pero no debería producirse nunca */
     THEN DO:
          titulo_window = "".
          lista_estados = "Consulta Individual de Facturas de Proveedores".
     END.
     WHEN MD_RELACION             /* Esta opcion la contemlamos por unicidad pero no debería producirse nunca */
     THEN DO:
          titulo_window = "".
          lista_estados = "".
     END.
     WHEN MD_READONLY      
     THEN DO:
          titulo_window = "Selección de Facturas de Proveedores en General".
          lista_estados = " ,E".
     END.
     WHEN MD_CAMBIO        
     THEN DO:
          titulo_window = "".
          lista_estados = "".
     END.
     WHEN MD_ANULACION        
     THEN DO:
          titulo_window = "Selección de Facturas de Proveedores Emitidas".
          lista_estados = "E".
     END.
     WHEN MD_EMISION        
     THEN DO:
          titulo_window = "Selección de Facturas de Proveedores Pendientes".
          lista_estados = " ".
     END.
  END CASE.     

  RUN d-seleccionar_facprov.w (INPUT titulo_window, INPUT p-cdg_comprobante, INPUT-OUTPUT rid_facprov).
  IF rid_facprov <> ?
  THEN DO:
     FIND Fac_header_prv WHERE ROWID(Fac_header_prv) = rid_facprov NO-LOCK.
     DISPLAY Fac_header_prv.tip_comprob @ T-Fac_header_prv.tip_comprob 
             Fac_header_prv.prf_comprob @ T-Fac_header_prv.prf_comprob
             Fac_header_prv.nro_comprob @ T-Fac_header_prv.nro_comprob
             WITH FRAME {&FRAME-NAME}.
     RUN traer_documento.
  END.  
  RETURN NO-APPLY.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Fac_header_prv.nro_comprob C-Win
ON RETURN OF T-Fac_header_prv.nro_comprob IN FRAME DEFAULT-FRAME /* nro_comprob */
DO:
  
   IF NOT CAN-DO( Tipocomprobante.tip_comprob, INPUT FRAME {&FRAME-NAME} T-Fac_header_prv.tip_comprob) 
   THEN DO:
      RUN PONMENSJ.P (INPUT "DOCS010").
      RETURN NO-APPLY.
   END.
   
   FIND Fac_header_prv 
        WHERE Fac_header_prv.cdg_empresa = Empresa.cdg_empresa
          AND Fac_header_prv.tip_comprob = T-Fac_header_prv.tip_comprob:INPUT-VALUE 
          AND Fac_header_prv.prf_comprob = T-Fac_header_prv.prf_comprob:INPUT-VALUE
          AND Fac_header_prv.nro_comprob = T-Fac_header_prv.nro_comprob:INPUT-VALUE
              NO-ERROR.

   IF NOT AVAILABLE Fac_header_prv 
   THEN DO:
       IF AMBIGUOUS Fac_header_prv
       THEN DO:
           RUN d-sel_facprov_ambigua.w ( INPUT T-Fac_header_prv.tip_comprob:INPUT-VALUE,  
                                         INPUT T-Fac_header_prv.prf_comprob:INPUT-VALUE,  
                                         INPUT T-Fac_header_prv.nro_comprob:INPUT-VALUE,
                                         INPUT-OUTPUT rid_facprov ).
           IF rid_facprov <> ?
           THEN DO:
               FIND Fac_header_prv WHERE ROWID(Fac_header_prv) = rid_facprov NO-LOCK.
               RUN traer_documento.
           END.
           ELSE DO:
               RETURN NO-APPLY.
           END.
       END.
       ELSE DO:
           IF LOCKED Fac_header_prv
              THEN RUN PONMENSJ.P (INPUT "DOCS000").
              ELSE RUN PONMENSJ.P (INPUT "DOCS001").
           RETURN NO-APPLY.
       END.
   END.
   ELSE DO:
        rid_facprov = ROWID(Fac_header_prv).
        RUN traer_documento.
   END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Fac_header_prv.prf_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Fac_header_prv.prf_comprob C-Win
ON MOUSE-SELECT-DBLCLICK OF T-Fac_header_prv.prf_comprob IN FRAME DEFAULT-FRAME /* prf_comprob */
OR MOUSE-MENU-DOWN,"." OF T-Fac_header_prv.prf_comprob IN FRAME {&FRAME-NAME}
DO:
  APPLY "MOUSE-SELECT-DBLCLICK" TO T-Fac_header_prv.tip_comprob IN FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Fac_header_prv.tip_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Fac_header_prv.tip_comprob C-Win
ON LEAVE OF T-Fac_header_prv.tip_comprob IN FRAME DEFAULT-FRAME /* Tipo */
DO:
  T-Fac_header_prv.tip_comprob:SCREEN-VALUE IN FRAME {&FRAME-NAME} = 
           CAPS(T-Fac_header_prv.tip_comprob:SCREEN-VALUE IN FRAME {&FRAME-NAME}).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Fac_header_prv.tip_comprob C-Win
ON MOUSE-SELECT-DBLCLICK OF T-Fac_header_prv.tip_comprob IN FRAME DEFAULT-FRAME /* Tipo */
OR MOUSE-MENU-DOWN,"." OF T-Fac_header_prv.tip_comprob IN FRAME {&FRAME-NAME}
DO:
  APPLY "MOUSE-SELECT-DBLCLICK" TO T-Fac_header_prv.tip_comprob IN FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_articulo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_articulo C-Win
ON * OF v-cdg_articulo IN FRAME DEFAULT-FRAME /* Artículo */
DO:
  APPLY "CHOOSE" TO btn_porclasificacion.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_articulo C-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_articulo IN FRAME DEFAULT-FRAME /* Artículo */
OR MOUSE-MENU-DOWN,"." OF v-cdg_articulo IN FRAME {&FRAME-NAME}
DO:

  DEFINE VARIABLE rid_articulo AS ROWID.

  RUN selartic.p ( INPUT-OUTPUT rid_articulo, 
                   "C", 
                   INPUT YES ).

  IF rid_articulo <> ?
  THEN DO:
       FIND Articulo WHERE ROWID(Articulo) = rid_articulo NO-LOCK.
       DISPLAY Articulo.cdg_articulo  @ v-cdg_articulo
               WITH FRAME {&FRAME-NAME}.
       APPLY "RETURN" TO v-cdg_articulo IN FRAME {&FRAME-NAME}.
  END.
  RETURN NO-APPLY.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_articulo C-Win
ON RETURN OF v-cdg_articulo IN FRAME DEFAULT-FRAME /* Artículo */
DO:

   ASSIGN FRAME {&FRAME-NAME}
         v-cdg_articulo.

   FIND Articulo WHERE Articulo.cdg_articulo = v-cdg_articulo NO-LOCK NO-ERROR.

   IF NOT AVAILABLE Articulo
   THEN DO:
      RUN PONMENSJ.P (INPUT "FACT004").
      RETURN NO-APPLY.
   END.

   IF Articulo.cdg_estado <> ""
   THEN DO:
      RUN PONMENSJ.P (INPUT "FACT032").
      RETURN NO-APPLY.
   END.

   FIND Familia_articulo OF Articulo NO-LOCK.
   FIND FIRST Familia_cuenta 
       WHERE Familia_cuenta.cdg_imputacion = T-Fac_header_prv.cdg_imputacion
         AND Familia_cuenta.nro_familia = Familia_articulo.nro_familia
             NO-LOCK NO-ERROR.
   
   IF NOT AVAILABLE Familia_cuenta
   THEN DO:
      RUN PONMENSJ.P (INPUT "FAPR061").
      RETURN NO-APPLY.
   END.

   RUN crear_detalle.
   
   DISPLAY " " @ v-cdg_articulo
           WITH FRAME {&FRAME-NAME}.
   APPLY "ENTRY" TO v-cdg_articulo  IN FRAME {&FRAME-NAME}.
   RETURN NO-APPLY.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_condicion_impos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_condicion_impos C-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_condicion_impos IN FRAME DEFAULT-FRAME /* C.Iva. */
OR "." OF v-cdg_condicion_impos IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_condicion_impos IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "condicion_impos" "cdg_condiva" "SELCNDIV.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_condicion_impos C-Win
ON RETURN OF v-cdg_condicion_impos IN FRAME DEFAULT-FRAME /* C.Iva. */
DO:
    &SCOPED-DEFINE PONER-TABLA RUN calculos.
    {traducetabla.i "condicion_impos" "cdg_condiva" "descripcion"} 
    &UNDEFINE PONER-TABLA
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_condicion_venta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_condicion_venta C-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_condicion_venta IN FRAME DEFAULT-FRAME /* C.Venta */
OR "." OF v-cdg_condicion_venta IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_condicion_venta IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "condicion_venta" "cdg_cndventa" "SELCNDVN.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_condicion_venta C-Win
ON RETURN OF v-cdg_condicion_venta IN FRAME DEFAULT-FRAME /* C.Venta */
DO:
   {traducetabla.i "condicion_venta" "cdg_cndventa" "descripcion"} 
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_domicilio
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_domicilio C-Win
ON MOUSE-MENU-DOWN OF v-cdg_domicilio IN FRAME DEFAULT-FRAME /* Domicilio */
DO:
    DEFINE VARIABLE x-domicilio LIKE Domicilio_prv.nro_domicilio.
    RUN d-seldomicilio_proveedor.w ( INPUT ROWID(Proveedor) , OUTPUT x-domicilio).
    IF x-domicilio <> ?
    THEN DO:
         DISPLAY x-domicilio @ v-cdg_domicilio
                 WITH FRAME {&FRAME-NAME}.
         APPLY "RETURN" TO v-cdg_domicilio IN FRAME {&FRAME-NAME}.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_domicilio C-Win
ON RETURN OF v-cdg_domicilio IN FRAME DEFAULT-FRAME /* Domicilio */
DO:
    FIND Domicilio_prv OF Proveedor WHERE Domicilio_prv.nro_domicilio = INPUT FRAME {&FRAME-NAME} v-cdg_domicilio NO-ERROR.
    IF AVAILABLE Domicilio_prv
    THEN DO:
        FIND Provincia OF Domicilio_prv NO-LOCK.
        ASSIGN  T-Fac_header_prv.nro_domicilio = Domicilio_prv.nro_domicilio
                T-Fac_header_prv.direccion     = Domicilio_prv.direccion
                T-Fac_header_prv.cdg_provincia = Domicilio_prv.cdg_provincia
                T-Fac_header_prv.localidad     = Domicilio_prv.localidad
                T-Fac_header_prv.cdg_postal    = Domicilio_prv.cdg_postal
                T-Fac_header_prv.cdg_zonag     = Domicilio_prv.cdg_zonag
                v-cdg_domicilio                = Domicilio_prv.nro_domicilio
                v-dsc_domicilio                = Domicilio_prv.nombre
                v-abv_provincia                = Provincia.nombre.
        DISPLAY v-cdg_domicilio 
                v-dsc_domicilio
                v-abv_provincia
                WITH FRAME {&FRAME-NAME}.  
        RUN calculos.
    END.
    ELSE DO:
        RUN PONMENSJ.P (INPUT "FACT006").
        RETURN NO-APPLY.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_moneda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_moneda C-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_moneda IN FRAME DEFAULT-FRAME /* Moneda */
OR "." OF v-cdg_moneda IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_moneda IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Moneda" "cdg_moneda" "SELMONED.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_moneda C-Win
ON RETURN OF v-cdg_moneda IN FRAME DEFAULT-FRAME /* Moneda */
DO:
   &SCOPED-DEFINE PONER-TABLA RUN asignar_moneda.
   {traducetabla.i "Moneda" "cdg_moneda" "descripcion"} 
   &UNDEFINE PONER-TABLA

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_proveedor
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_proveedor C-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_proveedor IN FRAME DEFAULT-FRAME /* Proveedor */
OR "." OF v-cdg_proveedor IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_proveedor IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "proveedor" "cdg_proveedor" "SELPROVE.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_proveedor C-Win
ON RETURN OF v-cdg_proveedor IN FRAME DEFAULT-FRAME /* Proveedor */
DO:
   &SCOPED-DEFINE PONER-TABLA RUN poner_proveedor.
   {traducetabla.i "proveedor" "cdg_proveedor" "nombre"} 
   &UNDEFINE PONER-TABLA
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-nro_rendicion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-nro_rendicion C-Win
ON MOUSE-SELECT-DBLCLICK OF v-nro_rendicion IN FRAME DEFAULT-FRAME
OR MOUSE-MENU-DOWN,"." OF v-nro_rendicion IN FRAME {&FRAME-NAME}
DO:
  DEFINE VARIABLE lista_tipos   AS CHARACTER INITIAL "*".  
  DEFINE VARIABLE lista_estados AS CHARACTER INITIAL "*".
  DEFINE VARIABLE titulo_window AS CHARACTER INITIAL "Seleccion de Rendiciones de Gastos".

  RUN d-seleccionar_rendgastos.w (INPUT titulo_window, INPUT lista_estados, INPUT lista_tipos, INPUT-OUTPUT rid_rendgastos).
  IF rid_rendgastos <> ?
  THEN DO:
     FIND Rendgastos_hd WHERE ROWID(Rendgastos_hd) = rid_rendgastos NO-LOCK.
     ASSIGN  v-tip_rendicion = Rendgastos_hd.tip_comprob 
             v-prf_rendicion = Rendgastos_hd.prf_comprob
             v-nro_rendicion = Rendgastos_hd.nro_comprob
             T-Fac_header_prv.nro_rendgastos = Rendgastos_hd.nro_rendgastos
             T-Fac_header_prv.cta_cte = NO.

     DISPLAY v-tip_rendicion 
             v-prf_rendicion
             v-nro_rendicion
             WITH FRAME {&FRAME-NAME}.

     
  END.  
  RETURN NO-APPLY.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-nro_rendicion C-Win
ON RETURN OF v-nro_rendicion IN FRAME DEFAULT-FRAME
DO:
  ASSIGN v-tip_rendicion v-prf_rendicion v-nro_rendicion.
  RUN asignar_rendicion ( INPUT  T-Fac_header_prv.cdg_empresa,
                          INPUT  v-tip_rendicion,
                          INPUT  v-prf_rendicion,
                          INPUT  v-nro_rendicion,
                          OUTPUT T-Fac_header_prv.nro_rendgastos).
  IF T-Fac_header_prv.nro_rendgastos = ? 
      THEN RETURN NO-APPLY.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.

/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
   RUN disable_UI.

{findempresa.i}
que_empresa = Empresa.cdg_empresa.

RUN carga_comprobante.
RUN carga_conceptos.
FIND Imputacion WHERE IMputacion.cdg_imputacion = x-primero NO-LOCK.
/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
REPEAT ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
       ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  RUN iniciar_documento.
  RUN frame_sensitiva ( INPUT NO ).  
  CLEAR FRAME {&FRAME-NAME} ALL.
  RUN crear_registro.
  IF modo = MD_DEFINIDA
     THEN RUN traer_documento.
     ELSE RUN frame_sensitiva ( INPUT YES ).
  WAIT-FOR U1 OF THIS-PROCEDURE.
  CASE codigo_salir:
       WHEN CD_SALIR THEN UNDO,LEAVE.
       WHEN CD_CANCELAR THEN UNDO,RETRY.
       WHEN CD_GRABAR THEN NEXT.
  END CASE.
   
END.
APPLY "CLOSE" TO THIS-PROCEDURE. /* hay que ver si realmente hace falta */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE asignar_cambio C-Win 
PROCEDURE asignar_cambio :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE p-xx AS DATE . /* Por Compatibilidad */

  RUN cotizar_moneda.p ( INPUT  Moneda.cdg_moneda,
                         INPUT  T-Fac_header_prv.cdg_empresa, 
                         INPUT  T-Fac_header_prv.fecha,       
                         OUTPUT T-Fac_header_prv.cambio,  
                         OUTPUT p-xx ).

  DISPLAY T-Fac_header_prv.cambio WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE asignar_dolar C-Win 
PROCEDURE asignar_dolar :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE p-xx AS DATE . /* Por Compatibilidad */

  RUN cotizar_moneda.p ( INPUT  Dolar.cdg_moneda,
                         INPUT  T-Fac_header_prv.cdg_empresa, 
                         INPUT  T-Fac_header_prv.fecha,       
                         OUTPUT T-Fac_header_prv.cambio_dolar,  
                         OUTPUT p-xx ).

  DISPLAY T-Fac_header_prv.cambio_dolar WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE asignar_imputacion C-Win 
PROCEDURE asignar_imputacion :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  T-Fac_header_prv.cdg_imputacion = Imputacion.cdg_imputacion.
  T-Fac_header_prv.cta_cte        = Imputacion.cta_cte.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE asignar_moneda C-Win 
PROCEDURE asignar_moneda :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  
  T-Fac_header_prv.nro_moneda = Moneda.nro_moneda.
  RUN asignar_cambio.
  RUN calculos.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE asignar_rendicion C-Win 
PROCEDURE asignar_rendicion :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE INPUT  PARAMETER p-cdg_empresa    LIKE Rendgastos_hd.cdg_empresa. 
    DEFINE INPUT  PARAMETER p-tip_rendicion  LIKE Rendgastos_hd.tip_comprob. 
    DEFINE INPUT  PARAMETER p-prf_rendicion  LIKE Rendgastos_hd.prf_comprob. 
    DEFINE INPUT  PARAMETER p-nro_rendicion  LIKE Rendgastos_hd.nro_comprob. 
    DEFINE OUTPUT PARAMETER p-nro_rendgastos LIKE Rendgastos_hd.nro_rendgastos. 

    p-nro_rendgastos = ?.

    FIND Rendgastos_hd WHERE Rendgastos_hd.cdg_empresa = p-cdg_empresa
                         AND Rendgastos_hd.tip_comprob = p-tip_rendicion
                         AND Rendgastos_hd.prf_comprob = p-prf_rendicion
                         AND Rendgastos_hd.nro_comprob = p-nro_rendicion
                             NO-ERROR.

    IF NOT AVAILABLE Rendgastos_hd
    THEN DO:
        RUN ponmensj.p ( INPUT "FAPR034").
        RETURN ERROR.
    END.
    ELSE DO:
        IF NOT Rendgastos_hd.abierta
        THEN DO:
            RUN ponmensj.p ( INPUT "FAPR035").
            RETURN ERROR.
        END.
        ELSE DO:
            IF FALSE /* Aqui debe validarse el dueño de la rendicion */
            THEN DO:
                RUN ponmensj.p ( INPUT "FAPR036").
                RETURN ERROR.
            END.
            ELSE DO:
                p-nro_rendgastos = Rendgastos_hd.nro_rendgastos.
            END.
        END.
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE borrar_tablas_temporales C-Win 
PROCEDURE borrar_tablas_temporales :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    EMPTY TEMP-TABLE T-Fac_detalle_prv.
    EMPTY TEMP-TABLE T-Fac_header_prv.
    EMPTY TEMP-TABLE T-Fac_header_prv_bon.
    EMPTY TEMP-TABLE T-Fac_detalle_prv.
    EMPTY TEMP-TABLE T-Fac_detalle_prv_bon.
    EMPTY TEMP-TABLE T-Fac_header_prv.
    EMPTY TEMP-TABLE T-Sub_detalle_prv.
    EMPTY TEMP-TABLE T-Sub_header_prv.
    EMPTY TEMP-TABLE T-Asn_header.
    EMPTY TEMP-TABLE T-Asn_detalle.
    EMPTY TEMP-TABLE T-Asn_totales.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE calculos C-Win 
PROCEDURE calculos :
/*------------------------------------------------------------------------------
  Purpose: Realiza el calculo del importe final de una factura     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  RUN calcular_comprobante_proveedor.p (
                             INPUT-OUTPUT TABLE T-Fac_header_prv,
                             INPUT-OUTPUT TABLE T-Fac_detalle_prv,
                             INPUT-OUTPUT TABLE T-Sub_header_prv,
                             INPUT-OUTPUT TABLE T-Sub_detalle_prv,
                             INPUT-OUTPUT TABLE T-Fac_header_prv_bon,
                             INPUT-OUTPUT TABLE T-Fac_detalle_prv_bon,
                             INPUT-OUTPUT TABLE T-Fac_header_prv_impuesto,
                             INPUT-OUTPUT TABLE T-Fac_detalle_prv_impuesto,
                             INPUT-OUTPUT TABLE T-Asn_header,
                             INPUT-OUTPUT TABLE T-Asn_detalle,
                             INPUT-OUTPUT TABLE T-Asn_totales).
                         
  FIND FIRST T-Fac_header_prv.

  DISPLAY T-Fac_header_prv.imp_neto 
          T-Fac_header_prv.imp_total
          WITH FRAME {&FRAME-NAME}.
  btn_verimputacion:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
  {&OPEN-QUERY-{&BROWSE-NAME}}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE carga_comprobante C-Win 
PROCEDURE carga_comprobante :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND Tipocomprobante 
        WHERE Tipocomprobante.cdg_empresa     = que_empresa
          AND Tipocomprobante.cdg_comprobante = p-cdg_comprobante
               NO-LOCK NO-ERROR.

    IF AVAILABLE Tipocomprobante 
    THEN DO:
        ASSIGN
               v-nombre_comprobante  = Tipocomprobante.rotulo
               v-fgcolor_comprobante = Tipocomprobante.color_letra
               v-bgcolor_comprobante = Tipocomprobante.color_fondo
               v-primera_letra       = Tipocomprobante.tip_comprob
               v-prefijo_contador    = Tipocomprobante.prefijo_contador.

         RUN titulo_window ( INPUT Tipocomprobante.titulo_window ).           
    END.
    ELSE DO:
    
       FIND Tipocomprobante WHERE Tipocomprobante.cdg_comprobante = "FACTUPRO" NO-LOCK NO-ERROR.
       IF AVAILABLE Tipocomprobante
       THEN DO:
           ASSIGN
                  v-nombre_comprobante  = Tipocomprobante.rotulo
                  v-fgcolor_comprobante = Tipocomprobante.color_letra
                  v-bgcolor_comprobante = Tipocomprobante.color_fondo
                  v-primera_letra       = Tipocomprobante.tip_comprob
                  v-prefijo_contador    = Tipocomprobante.prefijo_contador.

       END.
       ELSE DO:
          
           /*
           MESSAGE 1 PROGRAM-NAME(1) SKIP 
                   2 PROGRAM-NAME(2) SKIP
                   3 PROGRAM-NAME(3) SKIP
                   4 PROGRAM-NAME(4) SKIP
                   5 PROGRAM-NAME(5) SKIP
                   6 PROGRAM-NAME(6) SKIP
                   VIEW-AS ALERT-BOX ERROR
                   TITLE "ERROR DE IMPLEMENTACION".
           */
    
           ASSIGN
              v-nombre_comprobante  = "  FACTURA "
              v-fgcolor_comprobante = 9
              v-bgcolor_comprobante = 15
              v-primera_letra       = "F*"
              v-prefijo_contador    = "PRF*".
           
    
       END.
    END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE carga_conceptos C-Win 
PROCEDURE carga_conceptos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   DEFINE VARIABLE lOK      AS LOGICAL.
   DEFINE VARIABLE x-listas AS CHARACTER.

   x-listas = "".
   x-primero = ?.
   FOR EACH Comprobante_concepto OF Tipocomprobante, 
       Imputacion OF Comprobante_concepto:

       x-listas = x-listas + "," + Imputacion.dsc_imputacion + "," + STRING(Imputacion.cdg_imputacion).
       IF x-primero = ? THEN x-primero = Imputacion.cdg_imputacion.
        /*lOK = T-Fac_header.cdg_imputacion:ADD-LAST(Imputacion.dsc_imputacion,Imputacion.cdg_imputacion) IN FRAME {&FRAME-NAME}.*/
   END.
   T-Fac_header_prv.cdg_imputacion:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = SUBSTRING(x-listas,2).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE corregir_detalle C-Win 
PROCEDURE corregir_detalle :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

     RUN d-detalle_facprov.w ( INPUT-OUTPUT TABLE T-Fac_header_prv,          
                               INPUT-OUTPUT TABLE T-Fac_detalle_prv,         
                               INPUT-OUTPUT TABLE T-Fac_detalle_prv_bon,     
                               INPUT T-Fac_detalle_prv.nro_articulo,
                               INPUT T-Fac_detalle_prv.nro_linea,
                               INPUT modo,
                               INPUT 1,
                               OUTPUT v-nro_linea).
    FIND FIRST T-Fac_header_prv.
    IF v-nro_linea <> 0
    THEN DO:
         {&OPEN-QUERY-{&BROWSE-NAME}}
         RUN calculos.
    END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE crear_detalle C-Win 
PROCEDURE crear_detalle :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    RUN d-detalle_facprov.w ( INPUT-OUTPUT TABLE T-Fac_header_prv,
                              INPUT-OUTPUT TABLE T-Fac_detalle_prv,
                              INPUT-OUTPUT TABLE T-Fac_detalle_prv_bon,        
                              INPUT  Articulo.nro_articulo,
                              INPUT  0, /* No sabemos el nro de linea */
                              INPUT  modo,
                              INPUT  0, /* modo detalle = CREAR */
                              OUTPUT v-nro_linea).

    IF v-nro_linea <> 0
    THEN DO:
         {&OPEN-QUERY-{&BROWSE-NAME}}
         RUN calculos.
         btn_copiar:SENSITIVE IN FRAME {&FRAME-NAME}        = NO.
         btn_verimputacion:SENSITIVE IN FRAME {&FRAME-NAME} = YES.

    END.
    ELSE DO:
        FIND FIRST T-Fac_header_prv.
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE crear_registro C-Win 
PROCEDURE crear_registro :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DO WITH FRAME {&FRAME-NAME}:
     v-comprobante = v-nombre_comprobante.
     v-comprobante:FGCOLOR = v-fgcolor_comprobante.
     v-comprobante:BGCOLOR = v-bgcolor_comprobante.
  END.

  DO TRANSACTION:
    
      CREATE T-Fac_header_prv.
      ASSIGN T-Fac_header_prv.nro_usuario      = Usuario.nro_usuario 
             T-Fac_header_prv.cdg_empresa      = Empresa.cdg_empresa
             T-Fac_header_prv.cdg_comprobante  = Tipocomprobante.cdg_comprobante
             T-Fac_header_prv.fecha            = TODAY 
             T-Fac_header_prv.fecha_iva        = T-Fac_header_prv.fecha 
             T-Fac_header_prv.mes              = MONTH(T-Fac_header_prv.fecha) 
             T-Fac_header_prv.ano              = YEAR(T-Fac_header_prv.fecha)
             T-Fac_header_prv.cdg_empresa      = Empresa.cdg_empresa 
             T-Fac_header_prv.tip_comprob      = "" 
             T-Fac_header_prv.nro_facprov      = 0  
             T-Fac_header_prv.estado           = "E"  
             T-Fac_header_prv.nro_comprob      = T-Fac_header_prv.nro_facprov
             T-Fac_header_prv.prf_comprob      = 0
             T-Fac_header_prv.nro_moneda       = Moneda.nro_moneda 
             T-Fac_header_prv.cambio           = Moneda.cambio
             T-Fac_header_prv.cta_cte          = Imputacion.cta_cte
             T-Fac_header_prv.num_sucursal     = sucursal-id    
             T-Fac_header_prv.origen           = "M"
             v-cdg_moneda                      = Moneda.cdg_moneda
             v-dsc_moneda                      = Moneda.descripcion
             T-Fac_header_prv.cdg_imputacion   = Imputacion.cdg_imputacion. 

  END.

  RUN asignar_cambio.

  ASSIGN v-tip_rendicion = ""
         v-prf_rendicion = 0
         v-nro_rendicion = 0.

  DISPLAY
         T-Fac_header_prv.fecha   
         T-Fac_header_prv.fecha_iva
         T-Fac_header_prv.mes      
         T-Fac_header_prv.ano
         T-Fac_header_prv.cambio  
         T-Fac_header_prv.cdg_imputacion
         v-cdg_moneda
         v-dsc_moneda      
         v-comprobante
         v-tip_rendicion
         v-prf_rendicion
         v-nro_rendicion
         WITH FRAME {&FRAME-NAME}.

  codigo_salir = ?.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI C-Win  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Delete the WINDOW we created */
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
  THEN DELETE WIDGET C-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI C-Win  _DEFAULT-ENABLE
PROCEDURE enable_UI :
/*------------------------------------------------------------------------------
  Purpose:     ENABLE the User Interface
  Parameters:  <none>
  Notes:       Here we display/view/enable the widgets in the
               user-interface.  In addition, OPEN all queries
               associated with each FRAME and BROWSE.
               These statements here are based on the "Other 
               Settings" section of the widget Property Sheets.
------------------------------------------------------------------------------*/

  {&OPEN-QUERY-DEFAULT-FRAME}
  GET FIRST DEFAULT-FRAME.
  DISPLAY v-pago v-comprobante v-cdg_proveedor v-dsc_proveedor v-cdg_domicilio 
          v-dsc_domicilio v-abv_provincia v-tip_rendicion v-prf_rendicion 
          v-nro_rendicion v-cdg_condicion_impos v-dsc_condicion_impos 
          v-cdg_moneda v-dsc_moneda v-cdg_condicion_venta v-dsc_condicion_venta 
          v-cdg_articulo 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE T-Fac_header_prv THEN 
    DISPLAY T-Fac_header_prv.tip_comprob T-Fac_header_prv.prf_comprob 
          T-Fac_header_prv.nro_comprob T-Fac_header_prv.fecha 
          T-Fac_header_prv.fecha_iva T-Fac_header_prv.prc_canje 
          T-Fac_header_prv.mes T-Fac_header_prv.ano T-Fac_header_prv.cdg_lista 
          T-Fac_header_prv.nro_ocm T-Fac_header_prv.cambio 
          T-Fac_header_prv.clausula_dolar T-Fac_header_prv.cambio_dolar 
          T-Fac_header_prv.cdg_imputacion T-Fac_header_prv.leyenda_cc 
          T-Fac_header_prv.imp_neto T-Fac_header_prv.imp_total 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE RECT-2 RECT-3 RECT-4 RECT-5 Btn_salir T-Fac_header_prv.clausula_dolar 
         T-Fac_header_prv.cambio_dolar T-Fac_header_prv.cdg_imputacion 
         T-Fac_header_prv.leyenda_cc BROWSE-5 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW FRAME FRAME-A IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-FRAME-A}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE frame_sensitiva C-Win 
PROCEDURE frame_sensitiva :
/*------------------------------------------------------------------------------
  Purpose: habilita o deshabilita los campos de la frame para el estado inicial
           de la misma que se da cuando comienza el ciclo de transaccion. El es-
           tado definitivo de los campos lo ajusta la rutina habilitar_campos ( INPUT YES ).   
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER habilitado AS LOGICAL.

  DO WITH FRAME {&FRAME-NAME}:

     IF NOT habilitado
     THEN DO:
          ASSIGN
                btn_grabar:SENSITIVE                      = NO
                btn_copiar:SENSITIVE                      = NO
                btn_cancel:SENSITIVE                      = NO
                btn_anular:SENSITIVE                      = NO
                btn_observ:SENSITIVE                      = NO
                btn_imprim:SENSITIVE                      = NO
                T-Fac_header_prv.tip_comprob:SENSITIVE    = NO
                T-Fac_header_prv.prf_comprob:SENSITIVE    = NO
                T-Fac_header_prv.nro_comprob:SENSITIVE    = NO
                T-Fac_header_prv.fecha:SENSITIVE          = NO
                T-Fac_header_prv.fecha_iva:SENSITIVE      = NO
                T-Fac_header_prv.ano:SENSITIVE            = NO
                T-Fac_header_prv.cambio:SENSITIVE         = NO
                T-Fac_header_prv.cambio:SENSITIVE         = NO
                T-Fac_header_prv.cambio_dolar:SENSITIVE   = NO
                T-Fac_header_prv.leyenda_cc:SENSITIVE     = NO
                T-Fac_header_prv.mes:SENSITIVE            = NO
                T-Fac_header_prv.cdg_imputacion:SENSITIVE = NO
                v-cdg_articulo:SENSITIVE                  = NO
                v-cdg_condicion_impos:SENSITIVE           = NO
                v-cdg_domicilio:SENSITIVE                 = NO
                v-cdg_moneda:SENSITIVE                    = NO
                v-cdg_proveedor:SENSITIVE                 = NO
                v-tip_rendicion:SENSITIVE                 = NO
                v-prf_rendicion:SENSITIVE                 = NO
                v-nro_rendicion:SENSITIVE                 = NO
                btn_nominar:SENSITIVE                     = NO
                btn_porclasificacion:SENSITIVE            = NO
                btn_verimputacion:SENSITIVE               = NO.
     END.
     ELSE DO:
            CASE modo:
       
                WHEN MD_ALTA          
                THEN DO:
                     ASSIGN
                        v-cdg_proveedor:SENSITIVE                 = YES.
         
                END.
                WHEN MD_MULTIPLE      
                THEN DO:
                     ASSIGN
                        T-Fac_header_prv.tip_comprob:SENSITIVE    = YES
                        T-Fac_header_prv.prf_comprob:SENSITIVE    = YES
                        T-Fac_header_prv.nro_comprob:SENSITIVE    = YES.
                END.
                WHEN MD_DEFINIDA      
                THEN DO:
                     /* Nada habilitado */
                END.
                WHEN MD_RELACION      
                THEN DO:
                     /* Nada habilitado */
                END.
                WHEN MD_READONLY      
                THEN DO:
                     /* Nada habilitado */         
                END.
                WHEN MD_CAMBIO        
                THEN DO:
                     /* Nada habilitado */
                END.
                WHEN MD_ANULACION        
                THEN DO:
                     ASSIGN
                        T-Fac_header_prv.tip_comprob:SENSITIVE    = YES
                        T-Fac_header_prv.prf_comprob:SENSITIVE    = YES
                        T-Fac_header_prv.nro_comprob:SENSITIVE    = YES.
                END.
                WHEN MD_EMISION        
                THEN DO:
                     ASSIGN
                        T-Fac_header_prv.tip_comprob:SENSITIVE    = YES
                        T-Fac_header_prv.prf_comprob:SENSITIVE    = YES
                        T-Fac_header_prv.nro_comprob:SENSITIVE    = YES.
                END.
       
           END CASE.     
     END.
  END.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE grabar_datos C-Win 
PROCEDURE grabar_datos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

       /*
       ASSIGN FRAME {&FRAME-NAME} v-pto_venta.
       T-Fac_header_prv.prf_comprob = v-pto_venta.
       */       
       
       RUN emitir_comprobante_proveedor.p ( 
                                 INPUT TABLE T-Fac_header_prv,
                                 INPUT TABLE T-Fac_detalle_prv,
                                 INPUT TABLE T-Sub_header_prv,
                                 INPUT TABLE T-Sub_detalle_prv,
                                 INPUT TABLE T-Fac_header_prv_bon,
                                 INPUT TABLE T-Fac_detalle_prv_bon,
                                 INPUT TABLE T-Fac_header_prv_impuesto,
                                 INPUT TABLE T-Fac_detalle_prv_impuesto).
       
       RUN borrar_tablas_temporales.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE habilitar_campos C-Win 
PROCEDURE habilitar_campos :
/*------------------------------------------------------------------------------
  Purpose: habilita o deshabilita los campos de la frame para el estado final
           de la misma que se da cuando se ejecuta el ciclo de transaccion. El es-
           tado inicial de los campos lo ajusta la rutina frame_sensitiva.   
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER habilitado AS LOGICAL.

  DO WITH FRAME {&FRAME-NAME}:

     ASSIGN
        btn_grabar:SENSITIVE                      = NO
        btn_copiar:SENSITIVE                      = NO
        btn_cancel:SENSITIVE                      = NO
        btn_anular:SENSITIVE                      = NO
        btn_observ:SENSITIVE                      = NO
        btn_imprim:SENSITIVE                      = NO
        T-Fac_header_prv.tip_comprob:SENSITIVE    = NO
        T-Fac_header_prv.prf_comprob:SENSITIVE    = NO
        T-Fac_header_prv.nro_comprob:SENSITIVE    = NO
        T-Fac_header_prv.fecha:SENSITIVE          = NO
        T-Fac_header_prv.fecha_iva:SENSITIVE      = NO
        T-Fac_header_prv.ano:SENSITIVE            = NO
        T-Fac_header_prv.cambio:SENSITIVE         = NO
        T-Fac_header_prv.cambio_dolar:SENSITIVE   = NO
        T-Fac_header_prv.clausula_dolar:SENSITIVE = NO
        T-Fac_header_prv.leyenda_cc:SENSITIVE     = NO
        T-Fac_header_prv.mes:SENSITIVE            = NO
        v-cdg_articulo:SENSITIVE                  = NO
        v-cdg_condicion_impos:SENSITIVE           = NO
        v-cdg_condicion_venta:SENSITIVE           = NO
        v-cdg_domicilio:SENSITIVE                 = NO
        T-Fac_header_prv.cdg_imputacion:SENSITIVE = NO
        v-cdg_moneda:SENSITIVE                    = NO
        v-cdg_proveedor:SENSITIVE                 = NO
        v-tip_rendicion:SENSITIVE                 = NO
        v-prf_rendicion:SENSITIVE                 = NO
        v-nro_rendicion:SENSITIVE                 = NO
        btn_nominar:SENSITIVE                     = NO
        btn_porclasificacion:SENSITIVE            = NO
        btn_verimputacion:SENSITIVE               = NO
        btn_verbonificaciones:SENSITIVE           = NO.

     CASE modo:

       WHEN MD_ALTA          
       THEN DO:
           ASSIGN
                btn_grabar:SENSITIVE                      = YES
                btn_copiar:SENSITIVE                      = YES
                btn_cancel:SENSITIVE                      = YES
                btn_anular:SENSITIVE                      = NO
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = NO
                T-Fac_header_prv.tip_comprob:SENSITIVE    = YES
                T-Fac_header_prv.prf_comprob:SENSITIVE    = YES
                T-Fac_header_prv.nro_comprob:SENSITIVE    = YES
                T-Fac_header_prv.fecha:SENSITIVE          = YES
                T-Fac_header_prv.fecha_iva:SENSITIVE      = YES
                T-Fac_header_prv.ano:SENSITIVE            = YES
                T-Fac_header_prv.cambio:SENSITIVE         = YES
                T-Fac_header_prv.cambio_dolar:SENSITIVE   = YES
                T-Fac_header_prv.clausula_dolar:SENSITIVE = YES
                T-Fac_header_prv.leyenda_cc:SENSITIVE     = YES
                T-Fac_header_prv.mes:SENSITIVE            = YES
                T-Fac_header_prv.prc_canje:SENSITIVE      = hay_canje
                T-Fac_header_prv.cdg_imputacion:SENSITIVE = YES
                v-cdg_articulo:SENSITIVE                  = YES
                v-cdg_condicion_impos:SENSITIVE           = YES
                v-cdg_condicion_venta:SENSITIVE           = YES
                v-cdg_domicilio:SENSITIVE                 = YES
                v-cdg_moneda:SENSITIVE                    = YES
                v-cdg_proveedor:SENSITIVE                 = NO
                v-tip_rendicion:SENSITIVE                 = YES
                v-prf_rendicion:SENSITIVE                 = YES
                v-nro_rendicion:SENSITIVE                 = YES
                btn_porclasificacion:SENSITIVE            = YES
                btn_nominar:SENSITIVE                     = YES
                btn_verimputacion:SENSITIVE               = YES
                btn_verbonificaciones:SENSITIVE           = YES.
       END.
       WHEN MD_MULTIPLE      
       THEN DO:
            ASSIGN
                btn_cancel:SENSITIVE                      = YES
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES
                btn_nominar:SENSITIVE                     = YES
                btn_verimputacion:SENSITIVE               = YES
                btn_verbonificaciones:SENSITIVE           = YES.

       END.
       WHEN MD_DEFINIDA      
       THEN DO:
            ASSIGN
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES
                btn_nominar:SENSITIVE                     = YES
                btn_verimputacion:SENSITIVE               = YES
                btn_verbonificaciones:SENSITIVE           = YES.
       END.
       WHEN MD_RELACION      
       THEN DO:
            ASSIGN
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES
                btn_nominar:SENSITIVE                     = YES
                btn_verimputacion:SENSITIVE               = YES
                btn_verbonificaciones:SENSITIVE           = YES.
       END.
       WHEN MD_READONLY      
       THEN DO:
            ASSIGN
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES
                btn_nominar:SENSITIVE                     = YES
                btn_verimputacion:SENSITIVE               = YES
                btn_verbonificaciones:SENSITIVE           = YES.
       END.
       WHEN MD_CAMBIO        
       THEN DO:
            ASSIGN
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES
                btn_nominar:SENSITIVE                     = YES
                btn_verimputacion:SENSITIVE               = YES
                btn_verbonificaciones:SENSITIVE           = YES.
       END.
       WHEN MD_ANULACION        
       THEN DO:
            ASSIGN
                btn_cancel:SENSITIVE                      = YES
                btn_anular:SENSITIVE                      = YES
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES
                btn_nominar:SENSITIVE                     = YES
                btn_verimputacion:SENSITIVE               = YES
                btn_verbonificaciones:SENSITIVE           = YES.
       END.
       WHEN MD_EMISION        
       THEN DO:
            ASSIGN
                btn_grabar:SENSITIVE                      = YES
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES
                btn_nominar:SENSITIVE                     = YES
                btn_verimputacion:SENSITIVE               = YES
                btn_verbonificaciones:SENSITIVE           = YES.
       END.

    END CASE.     

  END.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE iniciar_documento C-Win 
PROCEDURE iniciar_documento :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/


    RUN getparametro.p (  INPUT  "HABCANJE",
                          OUTPUT v-valor_c,
                          OUTPUT v-valor_d,
                          OUTPUT v-valor_l,
                          OUTPUT v-valor_n,
                          OUTPUT v-observacion ).
    IF v-valor_l = ? 
       THEN hay_canje = NO.
       ELSE hay_canje = v-valor_l.
       
    RUN getparametro.p (  INPUT  "DFMONEDA",
                          OUTPUT v-valor_c,
                          OUTPUT v-valor_d,
                          OUTPUT v-valor_l,
                          OUTPUT v-valor_n,
                          OUTPUT v-observacion ).
    FIND Moneda WHERE Moneda.cdg_moneda = v-valor_c NO-LOCK.
    act_moneda = ROWID(Moneda).
    
    RUN getparametro.p (  INPUT  "CDGDOLAR",
                          OUTPUT v-valor_c,
                          OUTPUT v-valor_d,
                          OUTPUT v-valor_l,
                          OUTPUT v-valor_n,
                          OUTPUT v-observacion ).
    codigo_dolar = v-valor_c.
    FIND Dolar WHERE Dolar.cdg_moneda = codigo_dolar NO-LOCK.

    RUN getparametro.p (  INPUT  "DFNROCAJ",
                          OUTPUT v-valor_c,
                          OUTPUT v-valor_d,
                          OUTPUT v-valor_l,
                          OUTPUT v-valor_n,
                          OUTPUT v-observacion ).
    
    FIND Caja WHERE Caja.cdg_caja = v-valor_n NO-LOCK.
    act_caja = ROWID(Caja).
    
    /*---------------- Depende del Proveedor-------------------------------------------*/
    
    RUN getparametro.p (  INPUT  "DFCNCOMP",
                          OUTPUT v-valor_c,
                          OUTPUT v-valor_d,
                          OUTPUT v-valor_l,
                          OUTPUT v-valor_n,
                          OUTPUT v-observacion ).
    
    act_imputacion = ROWID(Imputacion).
    act_cuenta = ROWID(Cuenta).

    /*---------------------------------------------------------------------------------*/

   RUN titulo_window ( INPUT Tipocomprobante.titulo_window ).           

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_pago C-Win 
PROCEDURE poner_pago :
/*------------------------------------------------------------------------------
  Purpose: PONE EL STATUS DE LA FACTURA CON RESPECTO A LA CTA_CTE.
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR cartel AS CHAR NO-UNDO.
DEF VAR ccolor AS INT NO-UNDO.
    CASE PAGADO():
    WHEN "S" THEN do: cartel = "PAGADO". ccolor = 10. END.
    WHEN "P" THEN do: cartel = "PARCIAL". ccolor = 14. END.
        OTHERWISE do: cartel = "IMPAGO". ccolor = 12. END.
END.
v-pago:SCREEN-VALUE IN FRAME {&FRAME-NAME}= cartel.
v-pago:BGCOLOR = ccolor.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_proveedor C-Win 
PROCEDURE poner_proveedor :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  FIND Condicion_venta WHERE Condicion_venta.cdg_cndventa = Proveedor.dfl_cndventa NO-LOCK.

  FIND Familia_proveedor OF Proveedor NO-LOCK.
  
  FIND Condicion_impos   OF Proveedor NO-LOCK.
  v-tip_comprob = "F" + Condicion_impos.tipo_factura.
  
  ASSIGN
      T-Fac_header_prv.cdg_condiva          = Condicion_impos.cdg_condiva
      T-Fac_header_prv.nro_cndventa         = Condicion_venta.nro_cndventa
      T-Fac_header_prv.prc_canje            = IF hay_canje THEN Proveedor.prc_canje ELSE 0
      T-Fac_header_prv.nombre               = Proveedor.nombre
      T-Fac_header_prv.cuit                 = Proveedor.cuit
      T-Fac_header_prv.nro_proveedor        = Proveedor.nro_proveedor
      T-Fac_header_prv.cdg_tiporetiva       = Proveedor.cdg_tiporetiva
      T-Fac_header_prv.cdg_tiporetibr       = Proveedor.cdg_tiporetibr
      T-Fac_header_prv.cdg_tiporetsus       = Proveedor.cdg_tiporetsus
      T-Fac_header_prv.clausula_dolar       = Proveedor.clausula_dolar.

  RUN traer_proveedor.
  RUN traer_condicion_venta.
  RUN traer_condicion_impos.
  
  IF T-Fac_header_prv.clausula_dolar
    THEN RUN asignar_dolar.
    ELSE T-Fac_header_prv.cambio_dolar = 1.

  DISPLAY  v-cdg_proveedor 
           v-dsc_proveedor

           v-cdg_condicion_venta
           v-dsc_condicion_venta

           v-cdg_condicion_impos
           v-dsc_condicion_impos

           T-Fac_header_prv.cdg_imputacion
           T-Fac_header_prv.prc_canje WHEN hay_canje
           T-Fac_header_prv.clausula_dolar
           T-Fac_header_prv.cambio_dolar

           WITH FRAME {&FRAME-NAME}.
           
   RUN habilitar_campos ( YES ).

   FIND Domicilio_prv OF Proveedor NO-LOCK NO-ERROR.
   IF AVAILABLE Domicilio_prv 
   THEN DO:
      FIND Provincia OF Domicilio_prv NO-LOCK.
      ASSIGN  T-Fac_header_prv.nro_domicilio = Domicilio_prv.nro_domicilio
              T-Fac_header_prv.direccion     = Domicilio_prv.direccion
              T-Fac_header_prv.cdg_provincia = Domicilio_prv.cdg_provincia
              T-Fac_header_prv.localidad     = Domicilio_prv.localidad
              T-Fac_header_prv.cdg_postal    = Domicilio_prv.cdg_postal
              T-Fac_header_prv.cdg_zonag     = Domicilio_prv.cdg_zonag
              v-cdg_domicilio                = Domicilio_prv.nro_domicilio
              v-dsc_domicilio                = Domicilio_prv.nombre.
      DISPLAY v-cdg_domicilio
              v-dsc_domicilio
              WITH FRAME {&FRAME-NAME}.
      DISABLE v-cdg_domicilio WITH FRAME {&FRAME-NAME}.      
   END.
   ELSE DO:  /* No hay ninguno o hay mas de uno */
      ASSIGN  T-Fac_header_prv.nro_domicilio = 0
              T-Fac_header_prv.direccion     = ""
              T-Fac_header_prv.cdg_provincia = ""
              T-Fac_header_prv.localidad     = ""
              T-Fac_header_prv.cdg_postal    = ""
              T-Fac_header_prv.cdg_zonag     = ""
              v-cdg_domicilio                = 0
              v-dsc_domicilio                = "".
      DISPLAY v-cdg_domicilio
              v-dsc_domicilio
              WITH FRAME {&FRAME-NAME}.
      ENABLE v-cdg_domicilio WITH FRAME {&FRAME-NAME}.
   END.   

   RUN calculos.   

   APPLY "ENTRY" TO T-Fac_header_prv.tip_comprob IN FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE titulo_window C-Win 
PROCEDURE titulo_window :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

 DEFINE INPUT PARAMETER txtitulo AS CHARACTER.

 DEFINE VARIABLE v-txtitulo AS CHARACTER.

 CASE modo:
    
     WHEN MD_ALTA      THEN v-txtitulo = " Ingreso de " + txtitulo.
     WHEN MD_MULTIPLE  THEN v-txtitulo = " Consulta Múltiple de " + txtitulo.
     WHEN MD_DEFINIDA  THEN v-txtitulo = " Consulta Individual de " + txtitulo.
     WHEN MD_RELACION  THEN v-txtitulo = " Consulta Relacionada de " + txtitulo.
     WHEN MD_READONLY  THEN v-txtitulo = " Consulta Sólo Lectura de " + txtitulo.
     WHEN MD_CAMBIO    THEN v-txtitulo = " Modificación y Reemisión de " + txtitulo.
     WHEN MD_ANULACION THEN v-txtitulo = " Anulación de " + txtitulo.
     WHEN MD_EMISION   THEN v-txtitulo = " Emisión de " + txtitulo + "Pendientes".

 END CASE.     

 {&WINDOW-NAME}:TITLE = "DYNASYS/CXP " + NRO_RELEASE + " - " + Usuario.cdg_empresa + " - " + v-txtitulo + " User:" + USERID("sic").

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_condicion_impos C-Win 
PROCEDURE traer_condicion_impos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND Condicion_impos  OF T-Fac_header_prv NO-LOCK.
    ASSIGN
        v-cdg_condicion_impos = Condicion_impos.cdg_condiva
        v-dsc_condicion_impos = Condicion_impos.descripcion.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_condicion_venta C-Win 
PROCEDURE traer_condicion_venta :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND Condicion_venta  OF T-Fac_header_prv NO-LOCK.
    ASSIGN
        v-cdg_condicion_venta = Condicion_venta.cdg_cndventa
        v-dsc_condicion_venta = Condicion_venta.descripcion.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_documento C-Win 
PROCEDURE traer_documento :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   FIND Fac_header_prv WHERE ROWID(Fac_header_prv) = rid_facprov NO-LOCK.
   BUFFER-COPY Fac_header_prv TO T-Fac_header_prv.
   FOR EACH Fac_detalle_prv OF Fac_header_prv:

       CREATE T-Fac_detalle_prv.
       BUFFER-COPY Fac_detalle_prv TO T-Fac_detalle_prv.

       FOR EACH Fac_detalle_prv_bon OF Fac_detalle_prv:
           CREATE T-Fac_detalle_prv_bon.
           BUFFER-COPY Fac_detalle_prv_bon TO T-Fac_detalle_prv_bon.
       END.    

   END.    

   FOR EACH Fac_header_prv_bon OF Fac_header_prv:
       CREATE T-Fac_header_prv_bon.
       BUFFER-COPY Fac_header_prv_bon TO T-Fac_header_prv_bon.
   END.    

   FIND Sub_header_prv 
        WHERE Sub_header_prv.nro_proveedor = Fac_header_prv.nro_proveedor
          AND Sub_header_prv.cdg_empresa   = Fac_header_prv.cdg_empresa
          AND Sub_header_prv.tip_comprob   = Fac_header_prv.tip_comprob
          AND Sub_header_prv.prf_comprob   = Fac_header_prv.prf_comprob
          AND Sub_header_prv.nro_comprob   = Fac_header_prv.nro_comprob
              NO-LOCK NO-ERROR.
   IF AVAILABLE Sub_header_prv
   THEN DO:
        CREATE T-Sub_header_prv.
        BUFFER-COPY Sub_header_prv TO T-Sub_header_prv.           
     
        FOR EACH Sub_detalle_prv 
             WHERE Sub_detalle_prv.nro_proveedor = Sub_header_prv.nro_proveedor
               AND Sub_detalle_prv.cdg_empresa   = Sub_header_prv.cdg_empresa
               AND Sub_detalle_prv.tip_comprob   = Sub_header_prv.tip_comprob
               AND Sub_detalle_prv.prf_comprob   = Sub_header_prv.prf_comprob
               AND Sub_detalle_prv.nro_comprob   = Sub_header_prv.nro_comprob
                   NO-LOCK.
     
            CREATE T-Sub_detalle_prv.
            BUFFER-COPY Sub_detalle_prv TO T-Sub_detalle_prv.           
     
        END.
   END.

   FIND FIRST Asn_header 
       WHERE Asn_header.tabla_comprobante = "Fac_header_prv"
         AND Asn_header.nro_idcabecera = Fac_header_prv.nro_facprov
             NO-LOCK NO-ERROR.
   IF AVAILABLE Asn_header
   THEN DO:
       CREATE T-Asn_header.
       BUFFER-COPY Asn_header TO T-Asn_header.
       FOR EACH Asn_detalle OF Asn_header NO-LOCK:
           CREATE T-Asn_detalle.
           BUFFER-COPY Asn_detalle TO T-Asn_detalle.
       END.
       FOR EACH Asn_totales OF Asn_header NO-LOCK:
           CREATE T-Asn_totales.
           BUFFER-COPY Asn_totales TO T-Asn_totales.
       END.
   END.


   RUN traer_tablas.
   DISPLAY
        T-Fac_header_prv.ano 
        T-Fac_header_prv.cambio 
        T-Fac_header_prv.cambio_dolar
        T-Fac_header_prv.clausula_dolar
        T-Fac_header_prv.fecha 
        T-Fac_header_prv.fecha_iva 
        T-Fac_header_prv.imp_neto 
        T-Fac_header_prv.imp_total 
        T-Fac_header_prv.leyenda_cc 
        T-Fac_header_prv.mes 
        T-Fac_header_prv.nro_comprob 
        T-Fac_header_prv.prc_canje 
        T-Fac_header_prv.prf_comprob 
        T-Fac_header_prv.tip_comprob 
        T-Fac_header_prv.cdg_imputacion 
        v-cdg_condicion_impos 
        v-cdg_condicion_venta 
        v-cdg_domicilio 
        v-cdg_moneda 
        v-cdg_proveedor 
        v-dsc_condicion_impos 
        v-dsc_condicion_venta
        v-dsc_domicilio 
        v-dsc_moneda 
        v-dsc_proveedor 
        v-tip_rendicion
        v-prf_rendicion
        v-nro_rendicion
        WITH FRAME {&FRAME-NAME}.
   RUN poner_pago.

   {&OPEN-QUERY-{&BROWSE-NAME}}
       
   RUN habilitar_campos ( INPUT YES ).
   
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_domicilio C-Win 
PROCEDURE traer_domicilio :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND Domicilio_prv OF T-Fac_header_prv NO-LOCK.
    ASSIGN
        v-cdg_domicilio = Domicilio_prv.nro_domicilio
        v-dsc_domicilio = Domicilio_prv.nombre.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_imputacion C-Win 
PROCEDURE traer_imputacion :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND Imputacion       OF T-Fac_header_prv NO-LOCK.
    ASSIGN
        T-Fac_header_prv.cdg_imputacion      = Imputacion.cdg_imputacion.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_moneda C-Win 
PROCEDURE traer_moneda :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND Moneda    OF T-Fac_header_prv   NO-LOCK.
    ASSIGN
        v-cdg_moneda          = Moneda.cdg_moneda
        v-dsc_moneda          = Moneda.descripcion.
         
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_proveedor C-Win 
PROCEDURE traer_proveedor :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND Proveedor OF T-Fac_header_prv NO-LOCK.
    ASSIGN
        v-cdg_proveedor = Proveedor.cdg_proveedor
        v-dsc_proveedor = Proveedor.nombre.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_rendicion C-Win 
PROCEDURE traer_rendicion :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  IF T-Fac_header_prv.nro_rendgastos <> 0
  THEN DO:
      FIND Rendgastos_hd WHERE Rendgastos_hd.nro_rendgastos = T-Fac_header_prv.nro_rendgastos NO-LOCK.
      ASSIGN v-tip_rendicion = Rendgastos_hd.tip_comprob
             v-prf_rendicion = Rendgastos_hd.prf_comprob
             v-nro_rendicion = Rendgastos_hd.nro_comprob.
  END.
  ELSE DO:
      ASSIGN v-tip_rendicion = ""
             v-prf_rendicion = 0
             v-prf_rendicion = 0.
  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_tablas C-Win 
PROCEDURE traer_tablas :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  RUN traer_condicion_impos.
  RUN traer_condicion_venta.
  RUN traer_moneda.
  RUN traer_proveedor.
  RUN traer_domicilio.
  RUN traer_rendicion.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE validar_datos C-Win 
PROCEDURE validar_datos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE OUTPUT PARAMETER hubo_error AS LOGICAL.
      
    hubo_error = YES.
  
    IF NOT CAN-FIND(FIRST T-Fac_detalle_prv OF  T-Fac_header_prv)
    THEN DO:
       RUN PONMENSJ.P (INPUT "FAPR005").
       RETURN.
    END.
  
    IF NOT Tipocomprobante.autonumerado
    THEN DO:

        IF NOT CAN-DO(Tipocomprobante.tip_comprob,T-Fac_header_prv.tip_comprob)
        THEN DO:
           RUN PONMENSJ.P (INPUT "REMI031").
           RETURN.
        END.
/*
        IF NOT CAN-FIND(FIRST Tipo_puntovta 
                        WHERE Tipo_puntovta.cdg_empresa     = T-Fac_header_prv.cdg_empresa 
                          AND Tipo_puntovta.cdg_comprobante = Tipocomprobante.cdg_comprobante 
                          AND Tipo_puntovta.cdg_puntovta    = T-Fac_header_prv.prf_comprob)
        THEN DO:
           RUN PONMENSJ.P (INPUT "REMI070").
           RETURN.
        END.
*/
        IF T-Fac_header_prv.tip_comprob:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "" OR
           T-Fac_header_prv.prf_comprob:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "" OR
           T-Fac_header_prv.prf_comprob:SCREEN-VALUE IN FRAME {&FRAME-NAME} = ""
        THEN DO:
            RUN ponmensj.p ( INPUT "FAPR023").
            RETURN.
        END.
        ELSE DO:
            IF CAN-FIND(FIRST Fac_header_prv WHERE Fac_header_prv.cdg_empresa   = T-Fac_header_prv.cdg_empresa
                                               AND Fac_header_prv.tip_comprob   = T-Fac_header_prv.tip_comprob
                                               AND Fac_header_prv.prf_comprob   = T-Fac_header_prv.prf_comprob
                                               AND Fac_header_prv.nro_comprob   = T-Fac_header_prv.nro_comprob
                                               AND Fac_header_prv.nro_proveedor = T-Fac_header_prv.nro_proveedor)
            THEN DO:
                RUN ponmensj.p ( INPUT "FAPR024" ).
                RETURN.
            END.
        END.

    END.
  
    ASSIGN FRAME {&FRAME-NAME}
       v-tip_rendicion v-prf_rendicion v-nro_rendicion.

    IF v-tip_rendicion  <> "" OR
       v-prf_rendicion  <> 0 OR
       v-nro_rendicion  <> 0
    THEN DO:
         RUN asignar_rendicion ( INPUT  T-Fac_header_prv.cdg_empresa,
                                 INPUT  v-tip_rendicion,
                                 INPUT  v-prf_rendicion,
                                 INPUT  v-nro_rendicion,
                                 OUTPUT T-Fac_header_prv.nro_rendgastos).
         IF T-Fac_header_prv.nro_rendgastos = ? 
             THEN RETURN.
             ELSE T-Fac_header_prv.cta_cte = NO.
    END.

   {validartabla.i "Condicion_impos"   "cdg_condiva"     "descripcion"    "FAPR008"}
   {validartabla.i "Moneda"            "cdg_moneda"      "descripcion"    "FAPR032"}
   {validartabla.i "Condicion_venta"   "cdg_cndventa"    "descripcion"    "FAPR009"}
   /*
   {validartabla.i "Imputacion"        "cdg_imputacion"  "dsc_imputacion" "FAPR031"}
   */

    FIND FIRST Domicilio_prv OF Proveedor WHERE Domicilio_prv.nro_domicilio = INPUT FRAME {&FRAME-NAME} v-cdg_domicilio NO-LOCK NO-ERROR.
    IF NOT AVAILABLE Domicilio_prv
    THEN DO:
       RUN PONMENSJ.P (INPUT "FACT006").
       RETURN.
    END.
    ELSE DO:
       IF T-Fac_header_prv.nro_domicilio <> Domicilio_prv.nro_domicilio
       THEN DO:
           ASSIGN
               T-Fac_header_prv.nro_domicilio = Domicilio_prv.nro_domicilio
               T-Fac_header_prv.direccion     = Domicilio_prv.direccion
               T-Fac_header_prv.cdg_provincia = Domicilio_prv.cdg_provincia
               T-Fac_header_prv.localidad     = Domicilio_prv.localidad
               T-Fac_header_prv.cdg_postal    = Domicilio_prv.cdg_postal
               T-Fac_header_prv.cdg_zonag     = Domicilio_prv.cdg_zonag.
       END.
    END.

   hubo_error = NO.

   &SCOPED-DEFINE TABLA-MAESTRA  T-Fac_header_prv

   {asignartabla.i "Condicion_impos"   "cdg_condiva"     "cdg_condiva"      }
   {asignartabla.i "Moneda"            "nro_moneda"      "nro_moneda"       }
   {asignartabla.i "Condicion_venta"   "nro_cndventa"    "nro_cndventa"     }
   /*
   {asignartabla.i "Imputacion"        "cdg_imputacion"  "cdg_imputacion"   }
   */

   &UNDEFINE TABLA-MAESTRA
      
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION pagado C-Win 
FUNCTION pagado RETURNS CHARACTER
  ( /* parameter-definitions */ ) :
    DEF VAR PAGA AS CHAR NO-UNDO.
      FIND cta_cte_prv WHERE
      cta_cte_prv.cdg_empresa = t-fac_header_prv.cdg_empresa AND
      cta_cte_prv.tip_comprob = t-fac_header_prv.tip_comprob AND
      cta_cte_prv.prf_comprob = t-fac_header_prv.prf_comprob AND
      cta_cte_prv.nro_comprob = t-fac_header_prv.nro_comprob NO-LOCK NO-ERROR.
   
IF AVAILABLE cta_cte_prv THEN DO:
      IF cta_cte_prv.credito = 0 AND cta_cte_prv.debito = 0 THEN paga = "S".
      ELSE DO:
          IF cta_cte_prv.credito = 0 OR cta_cte_prv.debito = 0 
              THEN paga = "N".
              ELSE IF cta_cte_prv.credito = cta_cte_prv.debito 
                  THEN paga = "S".
                  ELSE paga = "P".
      END.
  END.
  ELSE paga = "?".
     
RETURN paga.
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

