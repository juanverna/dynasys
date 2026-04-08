&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win


/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Registrable-remito NO-UNDO LIKE Registrable-remito.
DEFINE TEMP-TABLE T-Remito-pedido NO-UNDO LIKE Remito-pedido.
DEFINE TEMP-TABLE T-Rem_detalle NO-UNDO LIKE Rem_detalle.
DEFINE TEMP-TABLE T-Rem_detalle-bon NO-UNDO LIKE Rem_detalle-bon.
DEFINE TEMP-TABLE T-Rem_header NO-UNDO LIKE Rem_header.
DEFINE TEMP-TABLE T-Rem_header-bon NO-UNDO LIKE Rem_header-bon.
DEFINE TEMP-TABLE T-Sub_detalle_inv NO-UNDO LIKE Sub_detalle_inv.
DEFINE TEMP-TABLE T-Sub_header_inv NO-UNDO LIKE Sub_header_inv.



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
DEFINE VARIABLE                rid_remito     AS ROWID.
DEFINE VARIABLE                modo           AS INTEGER.
DEFINE VARIABLE                p-cdg_comprobante  AS CHARACTER.
&ELSE
DEFINE INPUT-OUTPUT PARAMETER  rid_remito     AS ROWID.
DEFINE INPUT        PARAMETER  modo           AS INTEGER.
DEFINE INPUT        PARAMETER  p-cdg_comprobante  AS CHARACTER.
&ENDIF

/* Local Variable Definitions ---                                       */

{VRSHARED.I "NEW"}

{nrorelea.i}
{valoresmodo.i}
{valoressalida.i}

DEFINE NEW SHARED VARIABLE codigo_iva     AS INTEGER INITIAL 1.
DEFINE NEW SHARED VARIABLE emitir_remito  AS LOGICAL.
DEFINE NEW SHARED VARIABLE emitir_factura AS LOGICAL INITIAL NO.

DEFINE VARIABLE cotiza_dolar              AS DECIMAL.
DEFINE VARIABLE codigo_dolar              LIKE Moneda.cdg_moneda.
DEFINE VARIABLE v-tip_comprob             AS CHARACTER.
DEFINE VARIABLE dfl_leyenda               AS CHARACTER.
DEFINE VARIABLE prciva                    LIKE Impuesto.tasa FORMAT "Z,ZZZ,ZZ9.99-".

DEFINE VARIABLE sino-msg                  AS LOGICAL NO-UNDO.
DEFINE VARIABLE st_seleccionado           AS CHARACTER.

DEFINE VARIABLE v-prox_docum              LIKE Parametro.cdg_parametro INITIAL "PROXNASN".
DEFINE VARIABLE v-debito                  AS CHARACTER FORMAT "X(14)".
DEFINE VARIABLE v-credito                 AS CHARACTER FORMAT "X(14)".

DEFINE VARIABLE rid_tabla                 AS ROWID.

DEFINE VARIABLE v-pto_venta-org           AS INTEGER.
DEFINE VARIABLE v-nro_linea               AS INTEGER.
DEFINE VARIABLE v-nro_cuenta              AS INTEGER.
DEFINE VARIABLE aux_importe               AS DECIMAL.
DEFINE VARIABLE hay_canje                 AS LOGICAL.
DEFINE VARIABLE v-debug                   AS LOGICAL INITIAL NO.
DEFINE VARIABLE mod_cambio                AS LOGICAL.

DEFINE VARIABLE cntrl_deuda               AS LOGICAL.
DEFINE VARIABLE saldo_cc                  AS DECIMAL.
DEFINE VARIABLE saldo_ccv                 AS DECIMAL.
DEFINE VARIABLE tot_valores               AS DECIMAL.
DEFINE VARIABLE tot_remitos               AS DECIMAL.
DEFINE VARIABLE tot_pedidos               AS DECIMAL.
DEFINE VARIABLE tot_credito               AS DECIMAL.
DEFINE VARIABLE dis_credito               AS DECIMAL.
DEFINE VARIABLE cant_rech                 AS INTEGER.

DEFINE VARIABLE v-nombre_comprobante      AS CHARACTER.
DEFINE VARIABLE v-fgcolor_comprobante     AS INTEGER.
DEFINE VARIABLE v-bgcolor_comprobante     AS INTEGER.
DEFINE VARIABLE v-primera_letra           AS CHARACTER.
DEFINE VARIABLE v-prefijo_contador        AS CHARACTER.

DEFINE VARIABLE equiv_granel              LIKE Rem_detalle.granel.
DEFINE VARIABLE que_empresa               LIKE Empresa.cdg_empresa.
DEFINE VARIABLE que_sector                LIKE Area.cdg_area.
DEFINE VARIABLE v-tipo_remito             AS CHARACTER.

DEFINE BUFFER Dolar FOR Moneda.
DEFINE BUFFER administrador FOR cliente.

DEFINE TEMP-TABLE t-evento like evento
    FIELD nro_linea LIKE t-rem_detalle.nro_linea
    INDEX por_linea nro_linea.


DEFINE TEMP-TABLE T-Sub_header_vta like Sub_header_vta.
DEFINE TEMP-TABLE T-Sub_detalle_vta LIKE Sub_detalle_vta.
DEFINE TEMP-TABLE T-Rem_header_impuesto LIKE Rem_header_impuesto.
DEFINE TEMP-TABLE T-Rem_detalle_impuesto LIKE Rem_detalle_impuesto.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME BROWSE-1

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Rem_detalle Articulo T-Rem_header Evento

/* Definitions for BROWSE BROWSE-1                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-1 T-Rem_detalle.nro_linea ~
Articulo.cdg_articulo Articulo.descripcion Articulo.cdg_umed ~
T-Rem_detalle.cantidad T-Rem_detalle.precio T-Rem_detalle.costo ~
T-Rem_detalle.subtotal_neto 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-1 
&Scoped-define QUERY-STRING-BROWSE-1 FOR EACH T-Rem_detalle OF T-Rem_header NO-LOCK, ~
      EACH Articulo OF T-Rem_detalle NO-LOCK
&Scoped-define OPEN-QUERY-BROWSE-1 OPEN QUERY BROWSE-1 FOR EACH T-Rem_detalle OF T-Rem_header NO-LOCK, ~
      EACH Articulo OF T-Rem_detalle NO-LOCK.
&Scoped-define TABLES-IN-QUERY-BROWSE-1 T-Rem_detalle Articulo
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-1 T-Rem_detalle
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-1 Articulo


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define FIELDS-IN-QUERY-DEFAULT-FRAME T-Rem_header.cdg_formapago ~
T-Rem_header.tip_comprob T-Rem_header.nro_comprob T-Rem_header.mes ~
T-Rem_header.ano T-Rem_header.fecha T-Rem_header.nro_ocm ~
T-Rem_header.fecha_ocm T-Rem_header.cambio T-Rem_header.cambio_dolar ~
T-Rem_header.clausula_dolar T-Rem_header.leyenda_cc T-Rem_header.sin_cargo 
&Scoped-define ENABLED-FIELDS-IN-QUERY-DEFAULT-FRAME ~
T-Rem_header.cdg_formapago T-Rem_header.tip_comprob ~
T-Rem_header.nro_comprob T-Rem_header.mes T-Rem_header.ano ~
T-Rem_header.fecha T-Rem_header.cambio_dolar T-Rem_header.clausula_dolar ~
T-Rem_header.leyenda_cc T-Rem_header.sin_cargo 
&Scoped-define ENABLED-TABLES-IN-QUERY-DEFAULT-FRAME T-Rem_header
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-DEFAULT-FRAME T-Rem_header
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-BROWSE-1}
&Scoped-define QUERY-STRING-DEFAULT-FRAME FOR EACH T-Rem_header SHARE-LOCK, ~
      EACH Evento WHERE TRUE /* Join to T-Rem_header incomplete */ SHARE-LOCK
&Scoped-define OPEN-QUERY-DEFAULT-FRAME OPEN QUERY DEFAULT-FRAME FOR EACH T-Rem_header SHARE-LOCK, ~
      EACH Evento WHERE TRUE /* Join to T-Rem_header incomplete */ SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-DEFAULT-FRAME T-Rem_header Evento
&Scoped-define FIRST-TABLE-IN-QUERY-DEFAULT-FRAME T-Rem_header
&Scoped-define SECOND-TABLE-IN-QUERY-DEFAULT-FRAME Evento


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS T-Rem_header.cdg_formapago ~
T-Rem_header.tip_comprob T-Rem_header.nro_comprob T-Rem_header.mes ~
T-Rem_header.ano T-Rem_header.fecha T-Rem_header.cambio_dolar ~
T-Rem_header.clausula_dolar T-Rem_header.leyenda_cc T-Rem_header.sin_cargo 
&Scoped-define ENABLED-TABLES T-Rem_header
&Scoped-define FIRST-ENABLED-TABLE T-Rem_header
&Scoped-Define ENABLED-OBJECTS BROWSE-1 Bevento tFacturar e-evento ~
Btn_salir v-cdg_imputacion b-verrem RECT-2 RECT-3 RECT-4 RECT-5 
&Scoped-Define DISPLAYED-FIELDS T-Rem_header.cdg_formapago ~
T-Rem_header.tip_comprob T-Rem_header.nro_comprob T-Rem_header.mes ~
T-Rem_header.ano T-Rem_header.fecha T-Rem_header.nro_ocm ~
T-Rem_header.fecha_ocm T-Rem_header.cambio T-Rem_header.cambio_dolar ~
T-Rem_header.clausula_dolar T-Rem_header.leyenda_cc T-Rem_header.sin_cargo 
&Scoped-define DISPLAYED-TABLES T-Rem_header
&Scoped-define FIRST-DISPLAYED-TABLE T-Rem_header
&Scoped-Define DISPLAYED-OBJECTS tFacturar e-evento v-pto_venta v-anulado ~
v-comprobante v-cdg_cliente v-dsc_cliente v-cdg_domicilio v-dsc_domicilio ~
v-cdg_condicion_impos v-dsc_condicion_impos v-tip_factura v-prf_factura ~
v-nro_factura v-cdg_condicion_venta v-dsc_condicion_venta v-cdg_deposito ~
v-dsc_deposito v-cdg_moneda v-dsc_moneda v-cdg_lista_precios ~
v-dsc_lista_precios v-cdg_imputacion v-cdg_vendedor v-dsc_vendedor ~
v-cdg_administrador v-dsc_administrador v-cdg_articulo 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD lee_evento C-Win 
FUNCTION lee_evento RETURNS CHARACTER
  ( INPUT pnro_linea AS INT  )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON b-verrem 
     LABEL "Ver" 
     SIZE 5 BY 1.

DEFINE BUTTON Bevento 
     LABEL "E" 
     SIZE 5 BY 3.33.

DEFINE BUTTON btn_anular 
     LABEL "&Anular" 
     SIZE 18 BY 1.33.

DEFINE BUTTON btn_cancel 
     LABEL "&Cancelar" 
     SIZE 18 BY 1.33.

DEFINE BUTTON btn_copiar 
     LABEL "&Copiar" 
     SIZE 18 BY 1.33.

DEFINE BUTTON btn_grabar 
     LABEL "&Grabar" 
     SIZE 18 BY 1.33.

DEFINE BUTTON btn_imprim 
     LABEL "&Reimprimir" 
     SIZE 18 BY 1.33.

DEFINE BUTTON btn_leyenda 
     LABEL "&Leyenda" 
     SIZE 18 BY 1.33.

DEFINE BUTTON btn_nominar 
     LABEL "&Nominar" 
     SIZE 15 BY 1.

DEFINE BUTTON btn_observ 
     LABEL "&Observaciones" 
     SIZE 18 BY 1.33.

DEFINE BUTTON btn_porclasificacion 
     LABEL "X &Clasificación" 
     SIZE 19 BY 1.

DEFINE BUTTON Btn_salir DEFAULT 
     LABEL "&Salir" 
     SIZE 18 BY 1.33
     BGCOLOR 8 .

DEFINE BUTTON btn_verbonificaciones 
     LABEL "&Bonificaciones" 
     SIZE 19 BY 1.

DEFINE BUTTON btn_verimputacion 
     LABEL "Ver &Asiento" 
     SIZE 14 BY 1.

DEFINE VARIABLE v-cdg_imputacion AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Concepto" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Item",1,
                     "Punto",2
     DROP-DOWN-LIST
     SIZE 68 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE e-evento AS CHARACTER 
     VIEW-AS EDITOR SCROLLBAR-VERTICAL
     SIZE 64 BY 3.48
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-anulado AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     FGCOLOR 12 FONT 6 NO-UNDO.

DEFINE VARIABLE v-cdg_administrador AS CHARACTER FORMAT "X(8)" 
     LABEL "Administ." 
     VIEW-AS FILL-IN NATIVE 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_articulo AS CHARACTER FORMAT "X(12)":U 
     LABEL "Artículo" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 22 BY 1
     BGCOLOR 14 FGCOLOR 12 FONT 6 NO-UNDO.

DEFINE VARIABLE v-cdg_cliente AS CHARACTER FORMAT "X(8)" 
     LABEL "Cliente" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_condicion_impos AS INTEGER FORMAT "->,>>>,>>9" INITIAL 0 
     LABEL "C.Iva." 
     VIEW-AS FILL-IN NATIVE 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_condicion_venta AS CHARACTER FORMAT "X(8)" 
     LABEL "C.Venta" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_deposito AS CHARACTER FORMAT "X(8)" 
     LABEL "Depósito" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_domicilio AS INTEGER FORMAT ">>>>>>9" INITIAL 0 
     LABEL "Domicilio" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_lista_precios AS INTEGER FORMAT "->,>>>,>>9" INITIAL 0 
     LABEL "Lista" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_moneda AS CHARACTER FORMAT "X(3)" 
     LABEL "Moneda" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_vendedor AS CHARACTER FORMAT "X(4)" 
     LABEL "Vendedor" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-comprobante AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 32 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE v-dsc_administrador AS CHARACTER FORMAT "X(35)" 
     VIEW-AS FILL-IN 
     SIZE 54 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_cliente AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 52 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_condicion_impos AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 52 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_condicion_venta AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 52 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_deposito AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 47 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_domicilio AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 52 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_lista_precios AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 47 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_moneda AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 52 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_vendedor AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 52 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-nro_factura AS INTEGER FORMAT ">>>>>>>9":U INITIAL 0 
     VIEW-AS FILL-IN NATIVE 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE v-prf_factura AS INTEGER FORMAT ">>>9":U INITIAL 0 
     VIEW-AS FILL-IN NATIVE 
     SIZE 8 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE v-pto_venta AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN NATIVE 
     SIZE 8 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 6 NO-UNDO.

DEFINE VARIABLE v-tip_factura AS CHARACTER FORMAT "X(3)":U 
     LABEL "Factura" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 6 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 134 BY 1.86.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 20 BY 1.91.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 156 BY 12.14.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 156 BY 1.43.

DEFINE VARIABLE tFacturar AS LOGICAL INITIAL no 
     LABEL "No Facturar" 
     VIEW-AS TOGGLE-BOX
     SIZE 17 BY .81 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-1 FOR 
      T-Rem_detalle, 
      Articulo SCROLLING.

DEFINE QUERY DEFAULT-FRAME FOR 
      T-Rem_header, 
      Evento SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-1 C-Win _STRUCTURED
  QUERY BROWSE-1 NO-LOCK DISPLAY
      T-Rem_detalle.nro_linea COLUMN-LABEL "Nro.!Linea" FORMAT ">>9":U
      Articulo.cdg_articulo FORMAT "X(20)":U WIDTH 19.2
      Articulo.descripcion COLUMN-LABEL "Descripcion!Asociada" FORMAT "X(60)":U
            WIDTH 67.2
      Articulo.cdg_umed COLUMN-LABEL "Unidad!Medida" FORMAT "X(12)":U
      T-Rem_detalle.cantidad COLUMN-LABEL "Cantidad!Vendida" FORMAT ">>9.99":U
      T-Rem_detalle.precio FORMAT ">,>>9.9999":U
      T-Rem_detalle.costo FORMAT ">>,>>9.9999":U
      T-Rem_detalle.subtotal_neto FORMAT ">>,>>>,>>9.99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH SIZE 156 BY 11.43
         BGCOLOR 15 FGCOLOR 9 FONT 4.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     BROWSE-1 AT ROW 17.19 COL 3
     T-Rem_header.cdg_formapago AT ROW 15.91 COL 75.4 COLON-ALIGNED NO-LABEL WIDGET-ID 66
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "0",1
          DROP-DOWN-LIST
          SIZE 16 BY 1 TOOLTIP "Forma de pago"
          BGCOLOR 15 FGCOLOR 9 
     Bevento AT ROW 10.52 COL 152.8 WIDGET-ID 62
     tFacturar AT ROW 16 COL 110.8 WIDGET-ID 64
     e-evento AT ROW 10.52 COL 87 NO-LABEL WIDGET-ID 60
     btn_grabar AT ROW 1.48 COL 4
     btn_copiar AT ROW 1.48 COL 23
     btn_cancel AT ROW 1.48 COL 42
     btn_anular AT ROW 1.48 COL 61
     btn_leyenda AT ROW 1.48 COL 80
     btn_observ AT ROW 1.48 COL 99
     btn_imprim AT ROW 1.48 COL 118
     Btn_salir AT ROW 1.48 COL 140
     T-Rem_header.tip_comprob AT ROW 3.62 COL 13 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 6 BY 1
          BGCOLOR 7 FGCOLOR 15 
     v-pto_venta AT ROW 3.62 COL 20 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     T-Rem_header.nro_comprob AT ROW 3.62 COL 29 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 16 BY 1
          BGCOLOR 7 FGCOLOR 15 
     T-Rem_header.mes AT ROW 3.62 COL 69 COLON-ALIGNED
          LABEL "Período"
          VIEW-AS FILL-IN NATIVE 
          SIZE 4 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Rem_header.ano AT ROW 3.62 COL 74 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 7 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-anulado AT ROW 3.62 COL 82 COLON-ALIGNED NO-LABEL
     v-comprobante AT ROW 3.62 COL 103 COLON-ALIGNED NO-LABEL
     v-cdg_cliente AT ROW 4.81 COL 13 COLON-ALIGNED
     v-dsc_cliente AT ROW 4.81 COL 29 COLON-ALIGNED NO-LABEL
     T-Rem_header.fecha AT ROW 3.62 COL 143 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_domicilio AT ROW 6 COL 13 COLON-ALIGNED
     v-dsc_domicilio AT ROW 6 COL 29 COLON-ALIGNED NO-LABEL
     T-Rem_header.nro_ocm AT ROW 4.81 COL 116 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Rem_header.fecha_ocm AT ROW 4.81 COL 143 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Rem_header.cambio AT ROW 5.95 COL 116.2 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Rem_header.cambio_dolar AT ROW 5.95 COL 137.2 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 18.8 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_condicion_impos AT ROW 7.19 COL 13 COLON-ALIGNED
     v-dsc_condicion_impos AT ROW 7.19 COL 29 COLON-ALIGNED NO-LABEL
     T-Rem_header.clausula_dolar AT ROW 6.1 COL 90.2
          VIEW-AS TOGGLE-BOX
          SIZE 19 BY .81
     v-tip_factura AT ROW 7.05 COL 121.2 COLON-ALIGNED
     v-prf_factura AT ROW 7.05 COL 128.2 COLON-ALIGNED NO-LABEL
     v-nro_factura AT ROW 7.05 COL 137.2 COLON-ALIGNED NO-LABEL
     v-cdg_condicion_venta AT ROW 8.38 COL 13 COLON-ALIGNED
     v-dsc_condicion_venta AT ROW 8.38 COL 29 COLON-ALIGNED NO-LABEL
     v-cdg_deposito AT ROW 8.19 COL 95 COLON-ALIGNED
     v-dsc_deposito AT ROW 8.19 COL 109 COLON-ALIGNED NO-LABEL
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 160 BY 27.62.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME DEFAULT-FRAME
     v-cdg_moneda AT ROW 9.57 COL 13 COLON-ALIGNED
     v-dsc_moneda AT ROW 9.57 COL 29 COLON-ALIGNED NO-LABEL
     v-cdg_lista_precios AT ROW 9.38 COL 95 COLON-ALIGNED
     v-dsc_lista_precios AT ROW 9.38 COL 109 COLON-ALIGNED NO-LABEL
     v-cdg_imputacion AT ROW 10.76 COL 13 COLON-ALIGNED
     v-cdg_vendedor AT ROW 11.95 COL 13 COLON-ALIGNED
     v-dsc_vendedor AT ROW 11.95 COL 29 COLON-ALIGNED NO-LABEL
     v-cdg_administrador AT ROW 13.05 COL 13 COLON-ALIGNED WIDGET-ID 6
     v-dsc_administrador AT ROW 13.05 COL 27 COLON-ALIGNED HELP
          "Denominacion" NO-LABEL WIDGET-ID 4
     T-Rem_header.leyenda_cc AT ROW 14.19 COL 13 COLON-ALIGNED
          LABEL "Obs."
          VIEW-AS FILL-IN NATIVE 
          SIZE 142 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_articulo AT ROW 15.91 COL 11 COLON-ALIGNED
     btn_porclasificacion AT ROW 15.91 COL 36.2
     btn_verbonificaciones AT ROW 15.91 COL 56.2
     btn_verimputacion AT ROW 15.91 COL 128.6
     btn_nominar AT ROW 15.91 COL 143
     b-verrem AT ROW 7.05 COL 153 WIDGET-ID 50
     T-Rem_header.sin_cargo AT ROW 16 COL 95.8 WIDGET-ID 52
          VIEW-AS TOGGLE-BOX
          SIZE 14.2 BY .81
     RECT-2 AT ROW 1.29 COL 3
     RECT-3 AT ROW 1.24 COL 139
     RECT-4 AT ROW 3.38 COL 3
     RECT-5 AT ROW 15.67 COL 3
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 160 BY 27.62.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
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
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Comprobante de despacho"
         HEIGHT             = 27.62
         WIDTH              = 160
         MAX-HEIGHT         = 35.67
         MAX-WIDTH          = 204.8
         VIRTUAL-HEIGHT     = 35.67
         VIRTUAL-WIDTH      = 204.8
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
/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB BROWSE-1 1 DEFAULT-FRAME */
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
/* SETTINGS FOR BUTTON btn_leyenda IN FRAME DEFAULT-FRAME
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
/* SETTINGS FOR FILL-IN T-Rem_header.cambio IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
ASSIGN 
       e-evento:RETURN-INSERTED IN FRAME DEFAULT-FRAME  = TRUE
       e-evento:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR FILL-IN T-Rem_header.fecha_ocm IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Rem_header.leyenda_cc IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN T-Rem_header.mes IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN T-Rem_header.nro_ocm IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-anulado IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_administrador IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_articulo IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_cliente IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_condicion_impos IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_condicion_venta IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_deposito IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_domicilio IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_lista_precios IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_moneda IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_vendedor IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-comprobante IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_administrador IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_cliente IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_condicion_impos IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_condicion_venta IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_deposito IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_domicilio IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_lista_precios IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_moneda IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_vendedor IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-nro_factura IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-prf_factura IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-pto_venta IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-tip_factura IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-1
/* Query rebuild information for BROWSE BROWSE-1
     _TblList          = "Temp-Tables.T-Rem_detalle OF Temp-Tables.T-Rem_header,sic.Articulo OF Temp-Tables.T-Rem_detalle"
     _Options          = "NO-LOCK"
     _FldNameList[1]   > Temp-Tables.T-Rem_detalle.nro_linea
"T-Rem_detalle.nro_linea" "Nro.!Linea" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > sic.Articulo.cdg_articulo
"Articulo.cdg_articulo" ? "X(20)" "character" ? ? ? ? ? ? no ? no no "19.2" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > sic.Articulo.descripcion
"Articulo.descripcion" "Descripcion!Asociada" "X(60)" "character" ? ? ? ? ? ? no ? no no "67.2" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > sic.Articulo.cdg_umed
"Articulo.cdg_umed" "Unidad!Medida" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > Temp-Tables.T-Rem_detalle.cantidad
"T-Rem_detalle.cantidad" "Cantidad!Vendida" ">>9.99" "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > Temp-Tables.T-Rem_detalle.precio
"T-Rem_detalle.precio" ? ">,>>9.9999" "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > Temp-Tables.T-Rem_detalle.costo
"T-Rem_detalle.costo" ? ">>,>>9.9999" "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > Temp-Tables.T-Rem_detalle.subtotal_neto
"T-Rem_detalle.subtotal_neto" ? ">>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is OPENED
*/  /* BROWSE BROWSE-1 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME DEFAULT-FRAME
/* Query rebuild information for FRAME DEFAULT-FRAME
     _TblList          = "Temp-Tables.T-Rem_header,sic.Evento WHERE Temp-Tables.T-Rem_header ..."
     _Query            is OPENED
*/  /* FRAME DEFAULT-FRAME */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Comprobante de despacho */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Comprobante de despacho */
DO:
  /* This event will close the window and terminate the procedure.  */
  /* APPLY "CLOSE":U TO THIS-PROCEDURE. */
  APPLY "CHOOSE":U TO Btn_salir IN FRAME {&FRAME-NAME}.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME b-verrem
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b-verrem C-Win
ON CHOOSE OF b-verrem IN FRAME DEFAULT-FRAME /* Ver */
DO:
  DEF VAR que_programa AS CHAR NO-UNDO.
  RUN getparametro_c.p("CONCOMCL", OUTPUT que_programa).

  IF que_programa = "" THEN que_programa = "c-comprobante_cliente.w".

  ASSIGN v-tip_factura v-prf_factura v-nro_factura.
  DEF VAR act_fac_head AS ROWID NO-UNDO.
  FIND fac_header WHERE  fac_header.cdg_empresa = empresa.cdg_empresa
                         AND  fac_header.tip_comprob = v-tip_factura
                         AND fac_header.prf_comprob = v-prf_factura
                         AND fac_header.nro_comprob = v-nro_factura NO-ERROR.
  IF AVAILABLE fac_header
     THEN DO:                  
          act_fac_head = ROWID(fac_header).
          /*RUN ocultar_window.*/
          RUN value(que_programa) ( INPUT-OUTPUT act_fac_head , INPUT 2, INPUT Fac_header.cdg_comprobante ).
          /*RUN mostrar_window.*/
END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bevento
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bevento C-Win
ON CHOOSE OF Bevento IN FRAME DEFAULT-FRAME /* E */
DO:
  DEFINE VAR puso_ok AS LOGICAL NO-UNDO.
  RUN d-evento.w (INPUT-OUTPUT TABLE t-evento, t-rem_detalle.nro_linea , modo , OUTPUT puso_ok).
  e-evento = lee_evento( INPUT t-rem_detalle.nro_linea ).
  FIND t-evento WHERE t-rem_detalle.nro_linea = t-evento.nro_linea NO-ERROR.
  BEVENTO:SENSITIVE  = AVAILABLE t-evento.
  DISPLAY e-evento WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-1
&Scoped-define SELF-NAME BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-1 C-Win
ON DELETE-CHARACTER OF BROWSE-1 IN FRAME DEFAULT-FRAME
DO:
    IF modo = MD_ALTA
    THEN DO:
        sino-msg = NO.
        MESSAGE "Desea eliminar este renglón de detalle?" 
                VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
        IF sino-msg
        THEN DO:
             FIND t-evento WHERE t-evento.nro_identificacion = t-rem_detalle.nro_linea NO-ERROR.
             IF AVAILABLE t-evento THEN DELETE t-evento.
             DELETE T-Rem_detalle.
             RUN refrescar_browse.
             RUN calculos.
             
        END.
    END.
    ELSE DO:
        BELL.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-1 C-Win
ON MOUSE-SELECT-DBLCLICK OF BROWSE-1 IN FRAME DEFAULT-FRAME
OR RETURN OF {&BROWSE-NAME} IN FRAME {&FRAME-NAME}
DO:
    RUN corregir_detalle.
   RUN refrescar_browse.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-1 C-Win
ON ROW-DISPLAY OF BROWSE-1 IN FRAME DEFAULT-FRAME
DO:
    e-evento:SCREEN-VALUE = lee_evento(INPUT t-rem_detalle.nro_linea).
    FIND t-evento WHERE t-rem_detalle.nro_linea = t-evento.nro_linea NO-ERROR.
    BEVENTO:SENSITIVE  = AVAILABLE t-evento.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_anular
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_anular C-Win
ON CHOOSE OF btn_anular IN FRAME DEFAULT-FRAME /* Anular */
DO:
    DEFINE VAR k AS INT NO-UNDO.
    DEFINE VARIABLE pudo_anular AS INTEGER.
    DEFINE VAR texto AS CHARACTER NO-UNDO.
    DEF VAR puso_ok AS LOGICAL NO-UNDO.
    sino-msg = NO.
    MESSAGE "Desea ANULAR este comprobante" 
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
    IF sino-msg
    THEN DO:
         /* antes de anular ver si no hay realizado alguno de los eventos*/
        pudo_anular = 0.
         FOR EACH rem_detalle OF rem_header , each evento WHERE evento.nro_evento = rem_detalle.nro_evento:
             IF evento.frealizado <> ? THEN  do: pudo_anular = 1. leave. END.
         END.
         IF pudo_anular <> 0 THEN DO:
             RUN ponmensj.p ("EVENT01").
             RETURN NO-APPLY.
         END.
         RUN c-editar_leyenda_comprobante.w ( INPUT-OUTPUT texto,
                                            INPUT "Observaciones de la anulacion",
                                            INPUT MD_ALTA,
                                            OUTPUT puso_ok).
         RUN anular_compdespacho.p (INPUT ROWID(Rem_header), OUTPUT pudo_anular).
         IF pudo_anular = 0
         THEN DO:
              ASSIGN rem_header.observacion = rem_header.observacion + 
                CHR(13) + CHR(10) + 
                "----------------------" +
                CHR(13) + CHR(10) +
                texto.

              /*tiene un evento por suceder en el futuro? cancelarlo y limpiar agendas*/
              FOR each rem_detalle OF rem_header , EACH evento WHERE evento.nro_evento = rem_detalle.nro_evento:
                      evento.anulado = TRUE.
                      FOR EACH recurso_agenda WHERE recurso_agenda.nro_evento = evento.nro_evento:
                          DELETE recurso_agenda.
                      END. 
              END.
              RUN borrar_tablas_temporales.
              MESSAGE "El comprobante ha sido anulado" 
                      VIEW-AS ALERT-BOX MESSAGE TITLE "Aviso".
         END.
         ASSIGN codigo_salir = CD_GRABAR.
         APPLY "U1":U TO THIS-PROCEDURE.
         END.
         ELSE MESSAGE "No se puede anular, el remito ya ha salido" 
            VIEW-AS ALERT-BOX MESSAGE TITLE "Aviso".
  

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

  RUN d-seleccionar_remito.w (INPUT-OUTPUT rid_remito).
  IF rid_remito <> ?
  THEN DO:
     FIND Rem_header WHERE ROWID(Rem_header) = rid_remito NO-LOCK.
     DISPLAY Rem_header.tip_comprob @ T-Rem_header.tip_comprob 
             Rem_header.prf_comprob @ v-pto_venta
             Rem_header.nro_comprob @ T-Rem_header.nro_comprob
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
         T-Rem_header.ano 
         T-Rem_header.cambio 
         T-Rem_header.fecha 
         T-Rem_header.mes 
         T-Rem_header.fecha_ocm 
         T-Rem_header.nro_ocm 
         T-Rem_header.fecha 
         T-Rem_header.leyenda_cc
         T-Rem_header.clausula_dolar
         T-Rem_header.cambio_dolar.
         

  IF NOT Tipocomprobante.autonumerado
  THEN DO:
       ASSIGN FRAME {&FRAME-NAME}
             T-Rem_header.tip_comprob 
             v-pto_venta 
             T-Rem_header.nro_comprob.     
  END.

  RUN validar_datos ( OUTPUT hay_error ).
  IF NOT hay_error
  THEN DO:

       v-cdg_imputacion:SENSITIVE = NO. /* Ya no puede cambiarse el concepto de imputacion */
     
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
    MESSAGE "Desea REIMPRIMIR este comprobante?" 
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
    IF sino-msg
    THEN DO:
         RUN imprimir_compdespacho.p (ROWID(Rem_header)).
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_leyenda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_leyenda C-Win
ON CHOOSE OF btn_leyenda IN FRAME DEFAULT-FRAME /* Leyenda */
DO:
   DEFINE VARIABLE puso_ok AS LOGICAL.
   RUN c-edttexto.w ( INPUT-OUTPUT T-Rem_header.leyenda,
                      INPUT "Leyenda del Comprobante Actual",
                      INPUT modo,
                      OUTPUT puso_ok).
   RETURN NO-APPLY.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_nominar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_nominar C-Win
ON CHOOSE OF btn_nominar IN FRAME DEFAULT-FRAME /* Nominar */
DO:
  RUN d-nominar_compdespacho.w ( INPUT modo, INPUT 1, INPUT-OUTPUT TABLE T-Rem_header ).
    FIND FIRST T-Rem_header.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_observ
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_observ C-Win
ON CHOOSE OF btn_observ IN FRAME DEFAULT-FRAME /* Observaciones */
DO:

   DEFINE VARIABLE puso_ok AS LOGICAL.

   RUN c-edttexto-avanzado.w ( INPUT-OUTPUT T-Rem_header.observacion,
                      INPUT "Observación del Comprobante Actual",
                      INPUT modo,
                      OUTPUT puso_ok).
   IF puso_ok THEN DO:
       FIND rem_header WHERE rem_header.nro_remito = t-rem_header.nro_remito NO-ERROR.
       IF AVAILABLE rem_header THEN ASSIGN rem_header.observacion = T-Rem_header.observacion.
   END.
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
        &IF DEFINED (adm-panel) <> 0 &THEN
            RUN dispatch IN THIS-PROCEDURE ('exit').
        &ELSE
            ASSIGN codigo_salir = CD_SALIR.
            APPLY "U1":U TO THIS-PROCEDURE.
        &ENDIF
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_verbonificaciones
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_verbonificaciones C-Win
ON CHOOSE OF btn_verbonificaciones IN FRAME DEFAULT-FRAME /* Bonificaciones */
DO:
  RUN d-bonificaciones_compdespacho.w ( INPUT-OUTPUT TABLE T-Rem_header-bon, INPUT modo ).
  RUN calculos.
  RUN refrescar_browse.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_verimputacion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_verimputacion C-Win
ON CHOOSE OF btn_verimputacion IN FRAME DEFAULT-FRAME /* Ver Asiento */
DO:
  RUN d-ver_imputacion_compdespacho.w ( INPUT TABLE T-Sub_header_inv, INPUT TABLE T-Sub_detalle_inv).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Rem_header.clausula_dolar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Rem_header.clausula_dolar C-Win
ON VALUE-CHANGED OF T-Rem_header.clausula_dolar IN FRAME DEFAULT-FRAME /* Cláusula Dólar */
DO:
    ASSIGN FRAME {&FRAME-NAME} T-Rem_header.clausula_dolar.
    IF T-Rem_header.clausula_dolar
    THEN DO:
        RUN asignar_dolar.
    END.
    ELSE DO:
        T-Rem_header.cambio_dolar = 1.
        DISPLAY T-Rem_header.cambio_dolar
                 WITH FRAME {&FRAME-NAME}.
    END.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Rem_header.fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Rem_header.fecha C-Win
ON LEAVE OF T-Rem_header.fecha IN FRAME DEFAULT-FRAME /* Fecha */
DO:
  T-Rem_header.fecha_iva = T-Rem_header.fecha:INPUT-VALUE IN FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Rem_header.nro_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Rem_header.nro_comprob C-Win
ON MOUSE-SELECT-DBLCLICK OF T-Rem_header.nro_comprob IN FRAME DEFAULT-FRAME /* nro_comprob */
OR MOUSE-MENU-DOWN,"." OF T-Rem_header.nro_comprob IN FRAME {&FRAME-NAME}
DO:
  DEFINE VARIABLE lista_estados AS CHARACTER.
  DEFINE VARIABLE titulo_window AS CHARACTER.

  IF modo <> MD_ALTA
  THEN DO:
      CASE modo:
         WHEN MD_ALTA          
         THEN DO:
              titulo_window = "".     /* Esta opcion la contemplamos por unicidad pero no debería producirse nunca */
              lista_estados = "".
         END.
         WHEN MD_MULTIPLE      
         THEN DO:
              titulo_window = "Selección de Remitos".
              lista_estados = "*".
         END.
         WHEN MD_DEFINIDA             /* Esta opcion la contemplamos por unicidad pero no debería producirse nunca */
         THEN DO:
              titulo_window = "".
              lista_estados = "".
         END.
         WHEN MD_RELACION             /* Esta opcion la contemplamos por unicidad pero no debería producirse nunca */
         THEN DO:
              titulo_window = "".
              lista_estados = "".
         END.
         WHEN MD_READONLY      
         THEN DO:
              titulo_window = "Selección Comprobantes".
              lista_estados = "*".
         END.
         WHEN MD_CAMBIO        
         THEN DO:
              titulo_window = "".
              lista_estados = "".
         END.
         WHEN MD_ANULACION        
         THEN DO:
              titulo_window = "Selección de Comprobantes".
              lista_estados = "P,E,S".
         END.
         WHEN MD_EMISION        
         THEN DO:
              titulo_window = "Selección de Comprobantes".
              lista_estados = "".
         END.
      END CASE.     

      RUN d-seleccionar_compdespacho.w (INPUT titulo_window, INPUT lista_estados, INPUT Tipocomprobante.tip_comprob, INPUT-OUTPUT rid_remito).         

      IF rid_remito <> ?
      THEN DO:

             FIND Rem_header WHERE ROWID(Rem_header) = rid_remito NO-LOCK NO-ERROR.

             DISPLAY 
                 Rem_header.tip_comprob @ T-Rem_header.tip_comprob 
                 Rem_header.prf_comprob @ v-pto_venta
                 Rem_header.nro_comprob @ T-Rem_header.nro_comprob
             WITH FRAME {&FRAME-NAME}.

                     IF modo = MD_ANULACION AND Rem_header.anulado
                     THEN DO:
                          RUN PONMENSJ.P (INPUT "DOCS002").
                          RETURN NO-APPLY.
                     END.
                     ELSE DO:
                          RUN traer_documento.
                     END.
      END.  
      RETURN NO-APPLY.  
  END. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Rem_header.nro_comprob C-Win
ON RETURN OF T-Rem_header.nro_comprob IN FRAME DEFAULT-FRAME /* nro_comprob */
DO:

   IF modo <> MD_ALTA
   THEN DO:
       IF LOOKUP(INPUT FRAME {&FRAME-NAME} T-Rem_header.tip_comprob,"RM,DV") = 0 
       THEN DO:
          RUN PONMENSJ.P (INPUT "DOCS010").
          RETURN NO-APPLY.
       END.
    
      
       FIND Rem_header 
            WHERE Rem_header.cdg_empresa = Empresa.cdg_empresa
              AND Rem_header.tip_comprob = INPUT T-Rem_header.tip_comprob 
              AND Rem_header.prf_comprob = INPUT v-pto_venta
              AND Rem_header.nro_comprob = INPUT T-Rem_header.nro_comprob
                  NO-ERROR.
    
       IF NOT AVAILABLE Rem_header 
       THEN DO:
            IF LOCKED Rem_header
               THEN RUN PONMENSJ.P (INPUT "DOCS000").
               ELSE RUN PONMENSJ.P (INPUT "DOCS001").
            RETURN NO-APPLY.
       END.
       ELSE DO:
            rid_remito = ROWID(Rem_header).
            RUN traer_documento.
       END.
     
   END.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Rem_header.tip_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Rem_header.tip_comprob C-Win
ON LEAVE OF T-Rem_header.tip_comprob IN FRAME DEFAULT-FRAME /* Tipo */
DO:
  T-Rem_header.tip_comprob:SCREEN-VALUE = CAPS(T-Rem_header.tip_comprob:SCREEN-VALUE).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Rem_header.tip_comprob C-Win
ON MOUSE-SELECT-DBLCLICK OF T-Rem_header.tip_comprob IN FRAME DEFAULT-FRAME /* Tipo */
OR MOUSE-MENU-DOWN,"." OF T-Rem_header.tip_comprob IN FRAME {&FRAME-NAME}
DO:
  APPLY "MOUSE-SELECT-DBLCLICK" TO T-Rem_header.nro_comprob IN FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_administrador
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_administrador C-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_administrador IN FRAME DEFAULT-FRAME /* Administ. */
OR "." OF v-cdg_administrador IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_administrador IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "Administrador" "cdg_cliente" "SELadminis.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_administrador C-Win
ON RETURN OF v-cdg_administrador IN FRAME DEFAULT-FRAME /* Administ. */
DO:
   {traducetabla.i "Administrador" "cdg_cliente" "nom_cliente"} 
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
                   "V",
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
       WHERE Familia_cuenta.cdg_imputacion = T-Rem_header.cdg_imputacion
         AND Familia_cuenta.nro_familia    = Familia_articulo.nro_familia
         AND Familia_cuenta.cdg_empresa    = T-Rem_header.cdg_empresa
             NO-LOCK NO-ERROR.
   
   IF NOT AVAILABLE Familia_cuenta
   THEN DO:
      RUN PONMENSJ.P (INPUT "FAPR061").
      RETURN NO-APPLY.
   END.

   RUN crear_detalle.
       IF v-nro_linea <> 0
    THEN DO:
           IF articulo.nro_tipo_evento <> 0 THEN do:
               /*crear el evento correspondiente*/
               CREATE t-evento.
               ASSIGN t-evento.nro_tipo_evento = articulo.nro_tipo_evento
                      t-evento.origen = p-cdg_comprobante
                      t-evento.nro_evento = v-nro_linea
                      T-Evento.nro_linea = v-nro_linea
                      t-evento.nro_cliente = cliente.nro_cliente
                      T-Evento.FCreado = TODAY
                      t-evento.periodo = YEAR(TODAY) * 100 + MONTH(TODAY)
                      t-evento.fmin = TODAY
                      t-evento.fmax = TODAY + 7. /*por default son 7 dias fijos pero perdon...*/ 
               bevento:SENSITIVE = TRUE.
               e-evento:SCREEN-VALUE = lee_evento(INPUT t-rem_detalle.nro_linea).
           END.
       END.
   DISPLAY " " @ v-cdg_articulo
           WITH FRAME {&FRAME-NAME}.
   APPLY "ENTRY" TO v-cdg_articulo  IN FRAME {&FRAME-NAME}.
   RETURN NO-APPLY.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_cliente
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_cliente C-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_cliente IN FRAME DEFAULT-FRAME /* Cliente */
OR "." OF v-cdg_cliente IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_cliente IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "cliente" "cdg_cliente" "SELCLIEN.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_cliente C-Win
ON RETURN OF v-cdg_cliente IN FRAME DEFAULT-FRAME /* Cliente */
DO:
  IF v-cdg_cliente:SCREEN-VALUE IN FRAME {&FRAME-NAME} <> ""
  THEN DO:

      FIND Cliente WHERE Cliente.cdg_cliente = INPUT FRAME {&FRAME-NAME} v-cdg_cliente 
           /* AND LOOKUP(que_sector, Cliente.lista_sectores) <> 0 */NO-LOCK NO-ERROR.

      IF NOT AVAILABLE Cliente 
      THEN DO:
          v-dsc_cliente:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
          RUN PONMENSJ.P ( 'IREF002' ).
          RETURN NO-APPLY.
      END.
      ELSE DO:
          v-dsc_cliente = Cliente.nom_cliente.
          DISPLAY v-dsc_cliente 
                WITH FRAME {&FRAME-NAME}. 
          RUN poner_cliente.
      END.

  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_condicion_impos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_condicion_impos C-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_condicion_impos IN FRAME DEFAULT-FRAME /* C.Iva. */
OR "." OF v-cdg_condicion_impos IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_condicion_impos IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "condicion_impos" "cdg_condiva" "SELCNDIV-V.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_condicion_impos C-Win
ON RETURN OF v-cdg_condicion_impos IN FRAME DEFAULT-FRAME /* C.Iva. */
DO:
   &SCOPED-DEFINE PONER-TABLA RUN asignar_lista_precios.
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
   &SCOPED-DEFINE PONER-TABLA RUN asignar_condicion_venta.
   {traducetabla.i "condicion_venta" "cdg_cndventa" "descripcion"} 
   &UNDEFINE PONER-TABLA
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_deposito
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_deposito C-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_deposito IN FRAME DEFAULT-FRAME /* Depósito */
OR "." OF v-cdg_deposito IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_deposito IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Deposito" "cdg_deposito" "SELDEPOS.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_deposito C-Win
ON RETURN OF v-cdg_deposito IN FRAME DEFAULT-FRAME /* Depósito */
DO:
   {traducetabla.i "Deposito" "cdg_deposito" "nombre"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_domicilio
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_domicilio C-Win
ON MOUSE-MENU-DOWN OF v-cdg_domicilio IN FRAME DEFAULT-FRAME /* Domicilio */
DO:
  DEFINE VARIABLE x-domicilio LIKE Domicilio.nro_domicilio.
  RUN d-seldomicilio_cliente.w ( INPUT ROWID(Cliente) , OUTPUT x-domicilio).
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
  FIND Domicilio OF Cliente WHERE Domicilio.nro_domicilio = INPUT FRAME {&FRAME-NAME} v-cdg_domicilio NO-ERROR.
  IF AVAILABLE Domicilio
  THEN DO:
      ASSIGN  T-Rem_header.nro_domicilio = Domicilio.nro_domicilio
              T-Rem_header.direccion     = Domicilio.direccion
              T-Rem_header.cdg_provincia = Domicilio.cdg_provincia
              T-Rem_header.localidad     = Domicilio.localidad
              T-Rem_header.cdg_postal    = Domicilio.cdg_postal
              T-Rem_header.cdg_zonag     = Domicilio.cdg_zonag
              v-cdg_domicilio            = Domicilio.nro_domicilio
              v-dsc_domicilio            = Domicilio.nombre.
      DISPLAY v-cdg_domicilio 
              v-dsc_domicilio
              WITH FRAME {&FRAME-NAME}.      
  END.
  ELSE DO:
      RUN PONMENSJ.P (INPUT "FACT006").
      RETURN NO-APPLY.
  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_imputacion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_imputacion C-Win
ON VALUE-CHANGED OF v-cdg_imputacion IN FRAME DEFAULT-FRAME /* Concepto */
DO:
  ASSIGN v-cdg_imputacion.
  FIND Imputacion WHERE Imputacion.cdg_imputacion = v-cdg_imputacion NO-LOCK.
  RUN asignar_imputacion.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_lista_precios
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_lista_precios C-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_lista_precios IN FRAME DEFAULT-FRAME /* Lista */
OR "." OF v-cdg_lista_precios IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_lista_precios IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "Lista_precios" "cdg_lista" "SELLISTA.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_lista_precios C-Win
ON RETURN OF v-cdg_lista_precios IN FRAME DEFAULT-FRAME /* Lista */
DO:
   &SCOPED-DEFINE PONER-TABLA RUN asignar_lista_precios.
   {traducetabla.i "Lista_precios" "cdg_lista" "descripcion"} 
   &UNDEFINE PONER-TABLA

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


&Scoped-define SELF-NAME v-cdg_vendedor
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_vendedor C-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_vendedor IN FRAME DEFAULT-FRAME /* Vendedor */
OR "." OF v-cdg_vendedor IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_vendedor IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Vendedor" "cdg_vendedor" "SELVENDR.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_vendedor C-Win
ON RETURN OF v-cdg_vendedor IN FRAME DEFAULT-FRAME /* Vendedor */
DO:
   {traducetabla.i "Vendedor" "cdg_vendedor" "nombre"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-pto_venta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-pto_venta C-Win
ON ENTRY OF v-pto_venta IN FRAME DEFAULT-FRAME
DO:
  v-pto_venta-org = INPUT FRAME {&FRAME-NAME} v-pto_venta.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-pto_venta C-Win
ON LEAVE OF v-pto_venta IN FRAME DEFAULT-FRAME
DO:
   IF modo =MD_ALTA /* MD_MULTIPLE  MD_DEFINIDA    MD_RELACION   MD_READONLY MD_CAMBIO MD_ANULACION MD_EMISION */ THEN DO:
      IF INPUT FRAME {&FRAME-NAME} v-pto_venta <> v-pto_venta-org
      THEN DO:
           IF NOT CAN-FIND(Punto-venta WHERE Punto-venta.cdg_empresa  = T-rem_header.cdg_empresa 
                                         AND Punto-venta.cdg_puntovta = INPUT FRAME {&FRAME-NAME} v-pto_venta)
           THEN DO:
                RUN ponmensj.p ( INPUT "PVTA001").
                DISPLAY v-pto_venta-org @ v-pto_venta
                        WITH FRAME {&FRAME-NAME}.
           END.
           ELSE DO:
                IF NOT CAN-FIND(FIRST Tipo_puntovta WHERE Tipo_puntovta.cdg_empresa  = T-rem_header.cdg_empresa 
                                                      AND Tipo_puntovta.cdg_puntovta = INPUT FRAME {&FRAME-NAME} v-pto_venta
                                                      AND Tipo_puntovta.cdg_comprobante = T-rem_header.cdg_comprobante)
                THEN DO:
                     RUN ponmensj.p ( INPUT "PVTA004").
                     DISPLAY v-pto_venta-org @ v-pto_venta
                             WITH FRAME {&FRAME-NAME}.
                END.
                ELSE DO:
                     ASSIGN FRAME {&FRAME-NAME} v-pto_venta.
                     RUN asignar_fecha_puntovta.
                END.
         END.
      END.
      IF Cliente.dfl_cdg_puntovta <> int(INPUT FRAME {&FRAME-NAME} v-pto_venta) THEN DO:
          sino-msg = NO.
          RUN mensajepregunta.p ( INPUT "",INPUT "CLIPVTA", INPUT-OUTPUT sino-msg ). 
              IF NOT sino-msg THEN RETURN NO-APPLY.
      END.
      ASSIGN v-pto_venta.
  END.
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
{findsector.i}
que_sector = Area.cdg_area.

RUN carga_comprobante.
RUN carga_conceptos.
RUN carga_forma_pago.

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
  IF modo = MD_ALTA THEN APPLY "ENTRY" TO v-cdg_cliente.
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
                         INPUT  T-Rem_header.cdg_empresa, 
                         INPUT  T-Rem_header.fecha,       
                         OUTPUT T-Rem_header.cambio,  
                         OUTPUT p-xx ).

  DISPLAY T-Rem_header.cambio WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE asignar_condicion_venta C-Win 
PROCEDURE asignar_condicion_venta :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   T-Rem_header.nro_cndventa = Condicion_venta.nro_cndventa.

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
                         INPUT  T-Rem_header.cdg_empresa, 
                         INPUT  T-Rem_header.fecha,       
                         OUTPUT T-Rem_header.cambio_dolar,  
                         OUTPUT p-xx ).

  DISPLAY T-Rem_header.cambio_dolar WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE asignar_fecha_puntovta C-Win 
PROCEDURE asignar_fecha_puntovta :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

     FIND Punto-venta WHERE Punto-venta.cdg_empresa  = Empresa.cdg_empresa 
                        AND Punto-venta.cdg_puntovta = v-pto_venta
                            NO-LOCK.
     T-rem_header.fecha = IF Punto-venta.modo_fecha = "T" THEN Punto-venta.fch_cierre + 1 ELSE TODAY.
     DISPLAY T-rem_header.fecha
         WITH FRAME {&FRAME-NAME}.


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

  T-Rem_header.cdg_imputacion = Imputacion.cdg_imputacion.
  T-Rem_header.cta_cte        = Imputacion.cta_cte.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE asignar_lista_precios C-Win 
PROCEDURE asignar_lista_precios :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   ASSIGN FRAME {&FRAME-NAME} v-cdg_lista_precios.
   FIND Lista_precios WHERE Lista_precios.cdg_lista = v-cdg_lista_precios NO-LOCK.
   IF NOT CAN-DO(Lista_precios.lista_empresas,T-Rem_header.cdg_empresa)
   THEN DO:
         RUN PONMENSJ.P ( INPUT "ARTI017" ).
         no_aplicar = YES.
         RETURN ERROR.
   END.

   T-Rem_header.fecha_precios = T-Rem_header.fecha.
   T-Rem_header.cdg_lista =  v-cdg_lista_precios.
   FOR EACH T-Rem_detalle OF T-Rem_header EXCLUSIVE-LOCK, FIRST Articulo OF T-Rem_detalle WHERE Articulo.stock_sino:

        CASE Articulo.modo_volumen:
             WHEN ""  /* No hay descuentos por volumen */
             THEN DO: 
                  FIND LAST Articulo_precio OF Articulo 
                       WHERE Articulo_precio.cdg_lista = Lista_precio.cdg_lista 
                         AND Articulo_precio.cdg_empresa = T-Rem_header.cdg_empresa
                         AND Articulo_precio.fch_desde <= T-Rem_header.fecha_precios
                             NO-LOCK NO-ERROR. 
                  IF AVAILABLE Articulo_precio 
                  THEN DO:
                       T-Rem_detalle.precio    = Articulo_precio.precio.
                       T-Rem_detalle.precio_cf = Articulo_precio.precio_cf.
                  END.
                  ELSE DO:
                       T-Rem_detalle.precio    = ?.
                       T-Rem_detalle.precio_cf = ?.
                  END.
             END.                                  
    
             WHEN "D"  /* Descuentos directos en base a cantidad */
             THEN DO: 
                  FIND FIRST Articulo_precio OF Articulo 
                       WHERE Articulo_precio.cdg_lista = Lista_precio.cdg_lista 
                         AND Articulo_precio.cdg_empresa = T-Rem_header.cdg_empresa
                         AND Articulo_precio.desde_cantidad <= T-Rem_detalle.cantidad
                         AND Articulo_precio.hasta_cantidad >= T-Rem_detalle.cantidad
                         AND Articulo_precio.fch_desde <= T-Rem_header.fecha_precios
                             NO-LOCK NO-ERROR. 
                  IF AVAILABLE Articulo_precio 
                  THEN DO:
                       T-Rem_detalle.precio    = Articulo_precio.precio.
                       T-Rem_detalle.precio_cf = Articulo_precio.precio_cf.
                  END.
                  ELSE DO:
                       T-Rem_detalle.precio    = ?.
                       T-Rem_detalle.precio_cf = ?.
                  END.
             END.                                  
    
             WHEN "E"  /* Descuentos escalados en base a cantidad */
             THEN DO: 
                    /*
                  subtotal_item = 0.
                  remanente_cantidad = T-Rem_detalle.cantidad.
    
                  FOR EACH Articulo_precio OF Articulo 
                       WHERE Articulo_precio.cdg_lista = Lista_precio.cdg_lista 
                         AND Articulo_precio.cdg_empresa = T-Rem_header.cdg_empresa
                         BY Articulo-precio.desde_cantidad
                             NO-LOCK NO-ERROR: 
    
                      T-Rem_detalle.cantidad
    
    
                  IF AVAILABLE Articulo_precio 
                  THEN DO:
                       T-Rem_detalle.precio    = Articulo_precio.precio.
                       T-Rem_detalle.precio_cf = Articulo_precio.precio_cf.
                  END.
                  ELSE DO:
                       T-Rem_detalle.precio    = ?.
                       T-Rem_detalle.precio_cf = ?.
                  END.
                  */
                            T-Rem_detalle.precio = ?. /* Sacar */
             END.                                  
 
        END CASE.
   END.
   
   FIND Moneda WHERE Moneda.nro_moneda = Lista_precio.nro_moneda NO-LOCK.
   v-cdg_moneda = Moneda.cdg_moneda.
   DISPLAY v-cdg_moneda
       WITH FRAME {&FRAME-NAME}.
   APPLY "RETURN" TO v-cdg_moneda IN FRAME {&FRAME-NAME}.

   RUN calculos.
   {&OPEN-QUERY-{&BROWSE-NAME}}

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

  T-Rem_header.nro_moneda = Moneda.nro_moneda.
  RUN asignar_cambio.


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

  EMPTY TEMP-TABLE T-Rem_header.
  EMPTY TEMP-TABLE T-Rem_detalle.
  EMPTY TEMP-TABLE T-Registrable-remito.
  EMPTY TEMP-TABLE T-Rem_header-bon.
  EMPTY TEMP-TABLE T-Rem_detalle-bon.
  EMPTY TEMP-TABLE T-Remito-pedido.
  EMPTY TEMP-TABLE T-Sub_header_inv.
  EMPTY TEMP-TABLE T-Sub_detalle_inv.
  EMPTY TEMP-TABLE T-evento.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE calculos C-Win 
PROCEDURE calculos :
/*------------------------------------------------------------------------------
  Purpose: Realiza el calculo del importe final del remito y del asiento de inventario     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  EMPTY TEMP-TABLE T-Sub_header_inv NO-ERROR. 
  EMPTY TEMP-TABLE T-Sub_detalle_inv NO-ERROR.       

  { calcularemito.i "T-"}

  btn_verimputacion:SENSITIVE IN FRAME {&FRAME-NAME} = YES.

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
          AND Tipocomprobante.cdg_comprobante = p-cdg_comprobante NO-LOCK NO-ERROR.

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

        FIND Tipocomprobante 
            WHERE Tipocomprobante.cdg_empresa     = que_empresa
              AND Tipocomprobante.cdg_comprobante = "REMITCLI" NO-LOCK NO-ERROR.

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

            MESSAGE "No se encontro el tipo de comprobante" p-cdg_comprobante
                VIEW-AS ALERT-BOX INFO BUTTONS OK.
     
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

   DEFINE VARIABLE x-primero LIKE Rem_header.cdg_imputacion.

/* v-cdg_imputacion:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = "". */

   x-listas = "".
   x-primero = ?.
   FOR EACH Comprobante_concepto OF Tipocomprobante 
       WHERE Comprobante_concepto.cdg_empresa = Empresa.cdg_empresa, 
       Imputacion OF Comprobante_concepto:

       x-listas = x-listas + "," + Imputacion.dsc_imputacion + "," + STRING(Imputacion.cdg_imputacion).
       IF x-primero = ? THEN x-primero = Imputacion.cdg_imputacion.
        /*lOK = v-cdg_imputacion:ADD-LAST(Imputacion.dsc_imputacion,Imputacion.cdg_imputacion) IN FRAME {&FRAME-NAME}.*/
   END.
   IF x-listas <> ""
   THEN DO:
       x-listas = SUBSTRING(x-listas,2).
       v-cdg_imputacion:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = x-listas.
       v-cdg_imputacion = x-primero.
   END.
   ELSE DO:
       MESSAGE "No hay conceptos definidos para este tipo de comprobante"
         VIEW-AS ALERT-BOX ERROR TITLE "ERROR DE IMPLEMENTACION".
   END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE carga_forma_pago C-Win 
PROCEDURE carga_forma_pago :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   DEFINE VARIABLE x-listas AS CHARACTER.

  

   x-listas = "".
   FOR EACH forma_pago :
       x-listas = x-listas + "," + Forma_pago.denominacion + "," + STRING(forma_pago.cdg_formapago).
   END.
   IF x-listas <> ""
   THEN DO:
       x-listas = SUBSTRING(x-listas,2).
       t-rem_header.cdg_formapago:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = x-listas.
   END.

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

    RUN detalle_remito.p ( INPUT T-Rem_detalle.nro_articulo,
                           INPUT T-Rem_detalle.nro_linea,
                           INPUT modo,
                           INPUT 1,
                           OUTPUT v-nro_linea,
                           INPUT-OUTPUT TABLE T-Rem_header,
                           INPUT-OUTPUT TABLE T-Rem_detalle,
                           INPUT-OUTPUT TABLE T-Registrable-remito,
                           INPUT-OUTPUT TABLE T-Rem_detalle-bon,
                           INPUT-OUTPUT TABLE T-Remito-pedido                           
                           ).

    FIND FIRST T-Rem_header.
    IF v-nro_linea <> 0
    THEN DO:
         RUN calculos.
         RUN refrescar_browse.
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

    RUN detalle_remito.p ( INPUT  Articulo.nro_articulo,
                           INPUT  0, /* No sabemos el nro de linea */
                           INPUT  modo,
                           INPUT  0, /* modo detalle = CREAR */
                           OUTPUT v-nro_linea,
                           INPUT-OUTPUT TABLE T-Rem_header,
                           INPUT-OUTPUT TABLE T-Rem_detalle,
                           INPUT-OUTPUT TABLE T-Registrable-remito,
                           INPUT-OUTPUT TABLE T-Rem_detalle-bon,
                           INPUT-OUTPUT TABLE T-Remito-pedido                           
                           ).
    FIND FIRST T-Rem_header.
    IF v-nro_linea <> 0
    THEN DO:
         
         RUN calculos.
         RUN refrescar_browse.
         btn_copiar:SENSITIVE IN FRAME {&FRAME-NAME}        = NO.
         btn_verimputacion:SENSITIVE IN FRAME {&FRAME-NAME} = YES.

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
    
  FIND Imputacion WHERE Imputacion.cdg_imputacion = INTEGER(ENTRY(2,v-cdg_imputacion:LIST-ITEM-PAIRS,",")) NO-LOCK /* Primer Item */.

  CREATE T-Rem_header.
  ASSIGN T-Rem_header.cdg_comprobante = Tipocomprobante.cdg_comprobante
         t-rem_header.sin_cargo
         T-Rem_header.nro_usuario    = Usuario.nro_usuario 
         T-Rem_header.cdg_empresa    = Empresa.cdg_empresa
         T-Rem_header.fecha          = TODAY 
         T-Rem_header.fecha_iva      = TODAY 
         T-Rem_header.mes            = MONTH(T-Rem_header.fecha) 
         T-Rem_header.ano            = YEAR(T-Rem_header.fecha)
         T-Rem_header.nro_deposito   = Deposito.nro_deposito 
         T-Rem_header.tip_comprob    = "" 
         T-Rem_header.estado         = "E"
         T-Rem_header.nro_comprob    = T-Rem_header.nro_remito
         T-Rem_header.prf_comprob    = v-pto_venta
         T-Rem_header.nro_moneda     = Moneda.nro_moneda 
         T-Rem_header.cambio         = Moneda.cambio  
         T-Rem_header.num_sucursal   = sucursal-id 
         T-Rem_header.cdg_imputacion = Imputacion.cdg_imputacion 
         T-Rem_header.cta_cte        = Imputacion.cta_cte
         T-Rem_header.origen         = "M"
         v-cdg_moneda                = Moneda.cdg_moneda
         v-dsc_moneda                = Moneda.descripcion
         v-cdg_imputacion            = Imputacion.cdg_imputacion 
         v-cdg_deposito              = Deposito.cdg_deposito
         v-dsc_deposito              = Deposito.nombre.
         
  
  DISPLAY
         T-Rem_header.fecha   
         T-Rem_header.mes      
         T-Rem_header.ano
         T-Rem_header.cambio
         v-cdg_imputacion
         v-cdg_moneda
         v-dsc_moneda      
         v-cdg_deposito
         v-dsc_deposito 
         v-pto_venta
         v-comprobante
         WITH FRAME {&FRAME-NAME}.

  codigo_salir = ?.

  IF    modo = MD_MULTIPLE
     OR modo = MD_ANULACION
     OR modo = MD_EMISION
     OR NOT Tipocomprobante.autonumerado
  THEN DO:
       DO WITH FRAME {&FRAME-NAME}:
          T-Rem_header.tip_comprob:FGCOLOR = 9.
          T-Rem_header.tip_comprob:BGCOLOR = 15.

          v-pto_venta:FGCOLOR = 9.
          v-pto_venta:BGCOLOR = 15.

          T-Rem_header.nro_comprob:FGCOLOR = 9.
          T-Rem_header.nro_comprob:BGCOLOR = 15.
       END.
  END.

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
  DISPLAY tFacturar e-evento v-pto_venta v-anulado v-comprobante v-cdg_cliente 
          v-dsc_cliente v-cdg_domicilio v-dsc_domicilio v-cdg_condicion_impos 
          v-dsc_condicion_impos v-tip_factura v-prf_factura v-nro_factura 
          v-cdg_condicion_venta v-dsc_condicion_venta v-cdg_deposito 
          v-dsc_deposito v-cdg_moneda v-dsc_moneda v-cdg_lista_precios 
          v-dsc_lista_precios v-cdg_imputacion v-cdg_vendedor v-dsc_vendedor 
          v-cdg_administrador v-dsc_administrador v-cdg_articulo 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE T-Rem_header THEN 
    DISPLAY T-Rem_header.cdg_formapago T-Rem_header.tip_comprob 
          T-Rem_header.nro_comprob T-Rem_header.mes T-Rem_header.ano 
          T-Rem_header.fecha T-Rem_header.nro_ocm T-Rem_header.fecha_ocm 
          T-Rem_header.cambio T-Rem_header.cambio_dolar 
          T-Rem_header.clausula_dolar T-Rem_header.leyenda_cc 
          T-Rem_header.sin_cargo 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE BROWSE-1 T-Rem_header.cdg_formapago Bevento tFacturar e-evento 
         Btn_salir T-Rem_header.tip_comprob T-Rem_header.nro_comprob 
         T-Rem_header.mes T-Rem_header.ano T-Rem_header.fecha 
         T-Rem_header.cambio_dolar T-Rem_header.clausula_dolar v-cdg_imputacion 
         T-Rem_header.leyenda_cc b-verrem T-Rem_header.sin_cargo RECT-2 RECT-3 
         RECT-4 RECT-5 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
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
                T-Rem_header.tip_comprob:SENSITIVE        = NO
                v-pto_venta:SENSITIVE        = NO
                T-Rem_header.nro_comprob:SENSITIVE        = NO
                T-Rem_header.fecha:SENSITIVE              = NO
                T-Rem_header.ano:SENSITIVE                = NO
                T-Rem_header.cambio:SENSITIVE             = NO
                T-Rem_header.leyenda_cc:SENSITIVE         = NO
                T-Rem_header.mes:SENSITIVE                = NO
                v-cdg_articulo:SENSITIVE                  = NO
                v-cdg_condicion_impos:SENSITIVE           = NO
                v-cdg_domicilio:SENSITIVE                 = NO
                v-cdg_imputacion:SENSITIVE                = NO
                v-cdg_moneda:SENSITIVE                    = NO
                v-cdg_cliente:SENSITIVE                   = NO
                v-cdg_vendedor:SENSITIVE                  = NO
                v-cdg_deposito:SENSITIVE                  = NO
                v-cdg_lista_precios:SENSITIVE             = NO
                btn_porclasificacion:SENSITIVE            = NO
                btn_verimputacion:SENSITIVE               = NO
                v-cdg_administrador:SENSITIVE             = NO
                btn_verbonificaciones:SENSITIVE           = NO.

     END.
     ELSE DO:
            CASE modo:
       
                WHEN MD_ALTA          
                THEN DO:
                     ASSIGN
                        T-Rem_header.tip_comprob:SENSITIVE        = NOT Tipocomprobante.autonumerado
                        T-Rem_header.nro_comprob:SENSITIVE        = NOT Tipocomprobante.autonumerado
                        v-cdg_cliente:SENSITIVE                   = YES
                        v-pto_venta:SENSITIVE                     = NO.
         
                END.
                WHEN MD_MULTIPLE      
                THEN DO:
                     ASSIGN
                        T-Rem_header.tip_comprob:SENSITIVE        = YES
                        v-pto_venta:SENSITIVE        = YES
                        T-Rem_header.nro_comprob:SENSITIVE        = YES.
                        

                END.
                WHEN MD_DEFINIDA      
                THEN DO:
                     ASSIGN
                        btn_verimputacion:SENSITIVE               = YES
                        btn_verbonificaciones:SENSITIVE           = YES
                        v-pto_venta:SENSITIVE                     = NO.
         
                END.
                WHEN MD_RELACION      
                THEN DO:
                     ASSIGN
                        btn_verimputacion:SENSITIVE               = YES
                        btn_verbonificaciones:SENSITIVE           = YES
                        v-pto_venta:SENSITIVE                     = NO.
         
                END.
                WHEN MD_READONLY      
                THEN DO:
                     ASSIGN
                        btn_verimputacion:SENSITIVE               = YES
                        btn_verbonificaciones:SENSITIVE           = YES
                        v-pto_venta:SENSITIVE                     = NO.
         
                END.
                WHEN MD_CAMBIO        
                THEN DO:
                     ASSIGN
                        btn_verimputacion:SENSITIVE               = YES
                        btn_verbonificaciones:SENSITIVE           = YES
                        v-pto_venta:SENSITIVE                     = NO.

                END.
                WHEN MD_ANULACION        
                THEN DO:
                     ASSIGN
                        T-Rem_header.tip_comprob:SENSITIVE        = YES
                        v-pto_venta:SENSITIVE        = YES
                        T-Rem_header.nro_comprob:SENSITIVE        = YES
                        btn_verbonificaciones:SENSITIVE           = YES.
                        
                END.
                WHEN MD_EMISION        
                THEN DO:
                     ASSIGN
                        T-Rem_header.tip_comprob:SENSITIVE        = YES
                        v-pto_venta:SENSITIVE        = YES
                        T-Rem_header.nro_comprob:SENSITIVE        = YES
                        btn_verbonificaciones:SENSITIVE           = YES.
                        
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
    DO TRANSACTION:

       ASSIGN FRAME {&FRAME-NAME} v-pto_venta
       t-rem_header.prf_comprob = v-pto_venta.
       T-Rem_header.nro_administrador = administrador.nro_cliente.
       
       RUN valuar_remito.p ( 
            INPUT-OUTPUT  TABLE  T-Rem_header,
            INPUT-OUTPUT  TABLE  T-Rem_detalle,
            INPUT-OUTPUT  TABLE  T-Sub_header_vta,
            INPUT-OUTPUT  TABLE  T-Sub_detalle_vta,
            INPUT-OUTPUT  TABLE  T-Rem_header-bon,
            INPUT-OUTPUT  TABLE  T-Rem_detalle-bon,
            INPUT-OUTPUT  TABLE  T-Rem_header_impuesto,
            INPUT-OUTPUT  TABLE  T-Rem_detalle_impuesto ).

       IF tFacturar THEN t-rem_header.estado = "-".

       RUN emitir_compdespacho.p (  INPUT-OUTPUT TABLE T-Rem_header,
                                    INPUT TABLE T-Rem_detalle,
                                    INPUT TABLE T-Registrable-remito, 
                                    INPUT TABLE T-Rem_header-bon,
                                    INPUT TABLE T-Rem_detalle-bon,
                                    INPUT TABLE T-Remito-pedido,
                                    INPUT TABLE T-Sub_header_inv,
                                    INPUT TABLE T-Sub_detalle_inv
                                   ).   

       /*si dispara un evento evaluar*/
       RUN grabar_evento.
       RUN borrar_tablas_temporales.

   END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE grabar_evento C-Win 
PROCEDURE grabar_evento :
/*------------------------------------------------------------------------------
  Purpose:  grabar todos los eventos generados en el proceso   
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR k AS INT NO-UNDO.
DEF VAR pok AS LOGICAL NO-UNDO.

FIND FIRST t-rem_header.
FOR EACH t-evento:
    CREATE evento.
    BUFFER-COPY t-evento TO evento 
        ASSIGN evento.nro_evento = NEXT-VALUE( proximo_evento)
               evento.nro_identificacion = t-rem_header.nro_remito
               evento.nro_cliente = t-rem_header.nro_cliente.

    FIND rem_detalle WHERE rem_detalle.nro_remito = t-rem_header.nro_remito AND
            rem_detalle.nro_linea = t-evento.nro_linea NO-ERROR.
        ASSIGN rem_detalle.nro_evento = evento.nro_evento.
    IF evento.fasignado <> ? THEN   /*hay un evento esignar*/
    DO k = 1 TO NUM-ENTRIES(evento.recursos):
        FIND recurso WHERE recurso.cdg_recurso = ENTRY(k,evento.recursos) NO-ERROR.
        IF NOT AVAILABLE recurso THEN DO:
            RUN ponmesj("NORECUR1").
            RETURN ERROR.
        END.
        FOR EACH recurso_agenda WHERE recurso_agenda.nro_evento = evento.nro_evento:
            DELETE recurso_agenda.
        END.
        CREATE recurso_agenda.
        ASSIGN recurso_agenda.cdg_recurso = ENTRY(k,evento.recursos)
               recurso_agenda.fecha = Evento.FAsignado
               recurso_agenda.nro_evento = Evento.nro_evento.
    END.
END.
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
          btn_leyenda:SENSITIVE                     = NO
          btn_imprim:SENSITIVE                      = NO
          T-Rem_header.tip_comprob:SENSITIVE        = NO
          v-pto_venta:SENSITIVE        = NO
          T-Rem_header.nro_comprob:SENSITIVE        = NO
          T-Rem_header.fecha:SENSITIVE              = NO
          T-Rem_header.fecha_ocm:SENSITIVE          = NO
          T-Rem_header.nro_ocm:SENSITIVE            = NO
        /*T-Rem_header.prc_canje:SENSITIVE          = NO*/
          T-Rem_header.clausula_dolar:SENSITIVE     = NO
          T-Rem_header.ano:SENSITIVE                = NO
          T-Rem_header.cambio:SENSITIVE             = NO
          T-Rem_header.leyenda_cc:SENSITIVE         = NO
          T-Rem_header.mes:SENSITIVE                = NO
          v-cdg_articulo:SENSITIVE                  = NO
          v-cdg_condicion_impos:SENSITIVE           = NO
          v-cdg_domicilio:SENSITIVE                 = NO
          v-cdg_imputacion:SENSITIVE                = NO
          v-cdg_moneda:SENSITIVE                    = NO
          v-cdg_cliente:SENSITIVE                   = NO
          v-cdg_vendedor:SENSITIVE                  = NO
          v-cdg_deposito:SENSITIVE                  = NO
          v-cdg_lista_precios:SENSITIVE             = NO
          btn_nominar:SENSITIVE                     = NO
          btn_verbonificaciones:SENSITIVE           = NO
          v-cdg_administrador:SENSITIVE             = NO
          btn_porclasificacion:SENSITIVE            = NO.


     CASE modo:

       WHEN MD_ALTA          
       THEN DO:
            ASSIGN
                btn_grabar:SENSITIVE                      = YES
                btn_copiar:SENSITIVE                      = YES
                btn_cancel:SENSITIVE                      = YES
                btn_leyenda:SENSITIVE                     = YES
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = NO
                T-Rem_header.tip_comprob:SENSITIVE        = NOT Tipocomprobante.autonumerado
                v-pto_venta:SENSITIVE        = YES /* NOT Tipocomprobante.autonumerado*/
                T-Rem_header.nro_comprob:SENSITIVE        = NOT Tipocomprobante.autonumerado
                T-Rem_header.fecha:SENSITIVE              = YES
                T-Rem_header.ano:SENSITIVE                = YES
                T-Rem_header.cambio:SENSITIVE             = mod_cambio
                T-Rem_header.leyenda_cc:SENSITIVE         = YES
                T-Rem_header.mes:SENSITIVE                = YES
                T-Rem_header.fecha_ocm:SENSITIVE          = YES
                T-Rem_header.nro_ocm:SENSITIVE            = YES
                T-Rem_header.clausula_dolar:SENSITIVE     = YES
                T-Rem_header.cambio_dolar:SENSITIVE       = T-Rem_header.clausula_dolar
                v-cdg_articulo:SENSITIVE                  = YES
                v-cdg_condicion_impos:SENSITIVE           = YES
                v-cdg_condicion_venta:SENSITIVE           = YES
                v-cdg_domicilio:SENSITIVE                 = YES
                v-cdg_imputacion:SENSITIVE                = YES
                v-cdg_moneda:SENSITIVE                    = NO
                v-cdg_cliente:SENSITIVE                   = NO
                v-cdg_vendedor:SENSITIVE                  = YES
                v-cdg_lista_precios:SENSITIVE             = YES
                v-cdg_deposito:SENSITIVE                  = YES
                btn_porclasificacion:SENSITIVE            = YES
                btn_nominar:SENSITIVE                     = Cliente.permite_nominar
                btn_verbonificaciones:SENSITIVE           = YES
                v-cdg_administrador:SENSITIVE             = YES
                btn_verimputacion:SENSITIVE               = YES.
       END.
       WHEN MD_MULTIPLE      
       THEN DO:
            ASSIGN
                btn_cancel:SENSITIVE                      = YES
                btn_observ:SENSITIVE                      = YES
                btn_leyenda:SENSITIVE                     = YES
                btn_imprim:SENSITIVE                      = YES
                T-Rem_header.tip_comprob:SENSITIVE        = NO
                v-pto_venta:SENSITIVE        = NO
                T-Rem_header.nro_comprob:SENSITIVE        = NO
                btn_nominar:SENSITIVE                     = YES
                btn_verbonificaciones:SENSITIVE           = YES
                btn_verimputacion:SENSITIVE               = YES.
       END.
       WHEN MD_DEFINIDA      
       THEN DO:
            ASSIGN
                btn_observ:SENSITIVE                      = YES
                btn_leyenda:SENSITIVE                     = YES
                btn_imprim:SENSITIVE                      = YES
                btn_nominar:SENSITIVE                     = YES
                btn_verbonificaciones:SENSITIVE           = YES
                btn_verimputacion:SENSITIVE               = YES.
       END.
       WHEN MD_RELACION      
       THEN DO:
            ASSIGN
                btn_observ:SENSITIVE                      = YES
                btn_leyenda:SENSITIVE                     = YES
                btn_imprim:SENSITIVE                      = YES
                btn_nominar:SENSITIVE                     = YES
                btn_verbonificaciones:SENSITIVE           = YES
                btn_verimputacion:SENSITIVE               = YES.
       END.
       WHEN MD_READONLY      
       THEN DO:
            ASSIGN
                btn_observ:SENSITIVE                      = YES
                btn_leyenda:SENSITIVE                     = YES
                btn_imprim:SENSITIVE                      = YES
                btn_nominar:SENSITIVE                     = YES
                btn_verbonificaciones:SENSITIVE           = YES
                btn_verimputacion:SENSITIVE               = YES.
       END.
       WHEN MD_CAMBIO        
       THEN DO:
            ASSIGN
                btn_observ:SENSITIVE                      = YES
                btn_leyenda:SENSITIVE                     = YES
                btn_imprim:SENSITIVE                      = YES
                btn_nominar:SENSITIVE                     = YES
                btn_verbonificaciones:SENSITIVE           = YES
                btn_verimputacion:SENSITIVE               = YES.
       END.
       WHEN MD_ANULACION        
       THEN DO:
            ASSIGN
                btn_anular:SENSITIVE                      = YES
                btn_observ:SENSITIVE                      = YES
                btn_leyenda:SENSITIVE                     = YES
                btn_imprim:SENSITIVE                      = YES
                btn_nominar:SENSITIVE                     = YES
                btn_verbonificaciones:SENSITIVE           = YES
                btn_verimputacion:SENSITIVE               = YES.
       END.
       WHEN MD_EMISION        
       THEN DO:
            ASSIGN
                btn_grabar:SENSITIVE                      = YES
                btn_observ:SENSITIVE                      = YES
                btn_leyenda:SENSITIVE                     = YES
                btn_imprim:SENSITIVE                      = YES
                btn_nominar:SENSITIVE                     = YES
                btn_verbonificaciones:SENSITIVE           = YES
                btn_verimputacion:SENSITIVE               = YES.

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

   RUN getparametro.p (  INPUT  "CNDEUREM",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).
   cntrl_deuda = v-valor_n > 0.

   RUN getparametro.p (  INPUT  "CDGDOLAR",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).
   codigo_dolar = v-valor_c.
   FIND Dolar WHERE Dolar.cdg_moneda = codigo_dolar NO-LOCK.
   
   RUN getparametro.p (  INPUT  "DFMONEDA",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).
   FIND Moneda WHERE Moneda.cdg_moneda = v-valor_c NO-LOCK.
   act_moneda = ROWID(Moneda).

   RUN getparametro.p (  INPUT  "DFDEPOSI",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).
   FIND Deposito WHERE Deposito.nro_deposito = v-valor_n 
                       NO-LOCK.
   act_deposito = ROWID(Deposito).
   
   RUN getparametro.p (  INPUT  "MDCAMBIO",
                          OUTPUT v-valor_c,
                          OUTPUT v-valor_d,
                          OUTPUT v-valor_l,
                          OUTPUT v-valor_n,
                          OUTPUT v-observacion ).
   IF v-valor_l = ? 
      THEN mod_cambio = NO.
      ELSE mod_cambio = v-valor_l.

   RUN getptovta_comprobante.p ( INPUT Tipocomprobante.cdg_comprobante, OUTPUT v-pto_venta ).

   RUN titulo_window ( INPUT Tipocomprobante.titulo_window ).           

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_cliente C-Win 
PROCEDURE poner_cliente :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    IF NOT CAN-DO(Cliente.lista_empresas,Empresa.cdg_empresa)
    THEN DO:
        RUN PONMENSJ.P ( INPUT "CLIE050" ).
        no_aplicar = YES.
        RETURN ERROR.
    END.
    IF NOT Cliente.permite_nominar  THEN DO:
    run validar_cuit_param.p ( Cliente.cuit, ? ).
     if return-value <> "OK"
     THEN DO:
      RETURN NO-APPLY.
     END.  
    END.

    IF LOOKUP(Cliente.cdg_estado,",A") = 0
        THEN DO:
            RUN PONMENSJ.P ( INPUT "CLIE051" ).
            no_aplicar = YES.
            RETURN ERROR.
        END.
        ELSE DO:
            IF LOOKUP(que_sector, Cliente.lista_sectores) = 0
            THEN DO:
                RUN PONMENSJ.P ( INPUT "IREF002" ).
                no_aplicar = YES.
                RETURN NO-APPLY.
            END.
            ELSE DO:
    
                FIND Condicion_venta WHERE Condicion_venta.cdg_cndventa = Cliente.dfl_cndventa NO-LOCK.
                
                FIND Familia_cliente OF Cliente NO-LOCK.
                FIND Condicion_impos   OF Cliente NO-LOCK.
                
                ASSIGN 
                  T-Rem_header.cdg_condiva    = Condicion_impos.cdg_condiva
                  T-Rem_header.nro_cndventa   = Condicion_venta.nro_cndventa
                  T-Rem_header.prc_canje      = IF hay_canje THEN Cliente.prc_canje ELSE 0
                  T-Rem_header.nombre         = Cliente.nom_cliente
                  T-Rem_header.cuit           = Cliente.cuit
                  T-Rem_header.nro_cliente    = Cliente.nro_cliente
                  T-Rem_header.cdg_lista      = Cliente.dfl_lista
                  T-Rem_header.nro_vendedor   = Cliente.nro_vendedor
                  T-Rem_header.clausula_dolar = Cliente.clausula_dolar
                  T-Rem_header.nro_administrador = cliente.nro_administrador.
                  
                RUN traer_cliente.
                RUN traer_condicion_venta.
                RUN traer_condicion_impos.
                RUN traer_vendedor.
                RUN traer_administrador.
                
                FOR EACH Cliente-bonificacion OF Cliente 
                 WHERE Cliente-bonificacion.cdg_empresa = Empresa.cdg_empresa
                   AND Cliente-bonificacion.desde_fecha <= T-Rem_header.fecha 
                   AND Cliente-bonificacion.hasta_fecha >= T-Rem_header.fecha 
                      NO-LOCK:
                
                   CREATE T-Rem_header-bon.
                   ASSIGN T-Rem_header-bon.cdg_bonificacion = Cliente-bonificacion.cdg_bonificacion
                          T-Rem_header-bon.importe          = 0
                          T-Rem_header-bon.nro_remito       = T-Rem_header.nro_remito
                          T-Rem_header-bon.porcentaje       = Cliente-bonificacion.porcentaje.
                END.
                
                RUN traer_lista.

                T-Rem_header.nro_moneda = Lista_precios.nro_moneda.

                RUN traer_moneda.
                RUN asignar_moneda.

                IF T-Rem_header.clausula_dolar
                    THEN RUN asignar_dolar.

                DISPLAY  v-cdg_cliente 
                         v-dsc_cliente
                
                         v-cdg_condicion_venta
                         v-dsc_condicion_venta
                
                         v-cdg_condicion_impos
                         v-dsc_condicion_impos
                
                         v-cdg_lista_precios
                         v-dsc_lista_precios
                
                         v-cdg_vendedor
                         v-dsc_vendedor
                
                         v-cdg_deposito
                         v-dsc_deposito
                
                         v-cdg_moneda
                         v-dsc_moneda

                         T-Rem_header.cambio
                         T-Rem_header.cambio_dolar
                         T-Rem_header.clausula_dolar

                         WITH FRAME {&FRAME-NAME}.
                
                FIND Domicilio OF Cliente NO-LOCK NO-ERROR.
                IF AVAILABLE Domicilio 
                THEN DO:
                    FIND Provincia OF Domicilio NO-LOCK.
                    ASSIGN  T-Rem_header.nro_domicilio = Domicilio.nro_domicilio
                            T-Rem_header.direccion     = Domicilio.direccion
                            T-Rem_header.cdg_provincia = Domicilio.cdg_provincia
                            T-Rem_header.localidad     = Domicilio.localidad
                            T-Rem_header.cdg_postal    = Domicilio.cdg_postal
                            T-Rem_header.cdg_zonag     = Domicilio.cdg_zonag
                            v-cdg_domicilio            = Domicilio.nro_domicilio
                            v-dsc_domicilio            = Domicilio.nombre.
                    DISABLE v-cdg_domicilio 
                            v-dsc_domicilio
                            WITH FRAME {&FRAME-NAME}.      
                END.
                ELSE DO:  /* No hay ninguno o hay mas de uno */
                    ASSIGN  T-Rem_header.nro_domicilio = 0
                            T-Rem_header.direccion     = ""
                            T-Rem_header.cdg_provincia = ""
                            T-Rem_header.localidad     = ""
                            T-Rem_header.cdg_postal    = ""
                            T-Rem_header.cdg_zonag     = ""
                            v-cdg_domicilio            = 0
                            v-dsc_domicilio            = "".
                    v-cdg_domicilio:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
                END.   
                
                DISPLAY v-cdg_domicilio
                       v-dsc_domicilio
                       WITH FRAME {&FRAME-NAME}.

                /*
                RUN calculos.   
                */
                
                IF cntrl_deuda 
                  THEN RUN sumar_estadocred.p ( INPUT ROWID(Cliente),
                                                INPUT YES, /* Si, quiero el saldo consolidado para todas las empresas */
                                                OUTPUT saldo_cc,
                                                OUTPUT saldo_ccv,
                                                OUTPUT tot_valores,
                                                OUTPUT tot_remitos,
                                                OUTPUT tot_pedidos,
                                                OUTPUT cant_rech,
                                                OUTPUT tot_credito ).
                
                IF saldo_ccv <> 0 THEN RUN PONMENSJ.P ( INPUT "FACT021" ).
                
                IF Cliente.credito_maximo < tot_credito 
                THEN DO:
                  RUN PONMENSJ.P ( INPUT "FACT020" ).
                  RUN d-ver_estado_crediticio.w ( INPUT ROWID(Cliente)).
                END.

                RUN habilitar_campos ( INPUT YES ).

            END.
        END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE refrescar_browse C-Win 
PROCEDURE refrescar_browse :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  
  FIND FIRST T-Rem_header EXCLUSIVE-LOCK.
  
  {&OPEN-QUERY-{&BROWSE-NAME}}

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

 {&WINDOW-NAME}:TITLE = "DYNASYS/DSP " + NRO_RELEASE + " - " + Usuario.cdg_empresa + " - " + v-txtitulo + " User:" + USERID("sic").

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_administrador C-Win 
PROCEDURE traer_administrador :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND administrador WHERE T-Rem_header.nro_administrador = administrador.nro_cliente NO-LOCK NO-ERROR.
    IF AVAILABLE administrador THEN DO:
        ASSIGN v-cdg_administrador = administrador.cdg_cliente
               v-dsc_administrador = administrador.nom_cliente.
               
        DISPLAY v-cdg_administrador v-dsc_administrador WITH FRAME {&FRAME-NAME}.
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_cliente C-Win 
PROCEDURE traer_cliente :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND Cliente OF T-Rem_header NO-LOCK.
    ASSIGN
        v-cdg_cliente = Cliente.cdg_cliente
        v-dsc_cliente = Cliente.nom_cliente.
    
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

    FIND Condicion_impos  OF T-Rem_header NO-LOCK.
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

    FIND Condicion_venta  OF T-Rem_header NO-LOCK.
    ASSIGN
        v-cdg_condicion_venta = Condicion_venta.cdg_cndventa
        v-dsc_condicion_venta = Condicion_venta.descripcion.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_deposito C-Win 
PROCEDURE traer_deposito :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND Deposito    OF T-Rem_header   NO-LOCK.
    ASSIGN
        v-cdg_deposito          = Deposito.cdg_deposito
        v-dsc_deposito          = Deposito.nombre.


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

   FIND Rem_header WHERE ROWID(Rem_header) = rid_remito NO-LOCK.
   BUFFER-COPY Rem_header TO T-Rem_header.
   v-pto_venta = rem_header.prf_comprob.
   tFacturar = T-Rem_header.estado = "-".
   FOR EACH Rem_detalle OF Rem_header:
       CREATE T-Rem_detalle.
       BUFFER-COPY Rem_detalle TO T-Rem_detalle.
       FOR EACH evento OF rem_detalle:
           CREATE t-evento.
            BUFFER-COPY evento TO t-evento
            ASSIGN t-evento.nro_linea = t-rem_detalle.nro_linea.
       END.
   END.    

   FOR EACH Rem_header-bon  OF Rem_header:
       CREATE T-Rem_header-bon.
       BUFFER-COPY Rem_header-bon TO T-Rem_header-bon.
   END.
    
   FOR EACH Rem_detalle-bon  OF Rem_header:
       CREATE T-Rem_detalle-bon.
       BUFFER-COPY Rem_detalle-bon TO T-Rem_detalle-bon.
   END.

   FOR EACH Remito-pedido OF Rem_header:
       CREATE T-Remito-pedido.
       BUFFER-COPY Remito-pedido TO T-Remito-pedido.
   END.

   FOR EACH Registrable-remito OF Rem_header:
       CREATE T-Registrable-remito.
       BUFFER-COPY Registrable-remito TO T-Registrable-remito.
   END.

   FIND Sub_header_inv 
        WHERE Sub_header_inv.cdg_empresa = Rem_header.cdg_empresa
          AND Sub_header_inv.tip_comprob = Rem_header.tip_comprob
          AND Sub_header_inv.prf_comprob = Rem_header.prf_comprob
          AND Sub_header_inv.nro_comprob = Rem_header.nro_comprob
              NO-LOCK NO-ERROR.
   IF AVAILABLE Sub_header_inv
   THEN DO:
        CREATE T-Sub_header_inv.
        BUFFER-COPY Sub_header_inv TO T-Sub_header_inv.           
     
        FOR EACH Sub_detalle_inv 
             WHERE Sub_detalle_inv.cdg_empresa = Sub_header_inv.cdg_empresa
               AND Sub_detalle_inv.tip_comprob = Sub_header_inv.tip_comprob
               AND Sub_detalle_inv.prf_comprob = Sub_header_inv.prf_comprob
               AND Sub_detalle_inv.nro_comprob = Sub_header_inv.nro_comprob
                   NO-LOCK.
     
            CREATE T-Sub_detalle_inv.
            BUFFER-COPY Sub_detalle_inv TO T-Sub_detalle_inv.           
     
        END.
   END.
   
   v-anulado = IF Rem_header.anulado THEN "ANULADA" ELSE "".

   RUN traer_tablas.
   DISPLAY
        T-Rem_header.ano 
        T-Rem_header.cambio 
        T-Rem_header.fecha 
        T-Rem_header.fecha_ocm 
        T-Rem_header.nro_ocm
        T-Rem_header.leyenda_cc 
        T-Rem_header.mes 
        T-Rem_header.nro_comprob 
        v-pto_venta 
        T-Rem_header.tip_comprob 
        v-cdg_condicion_impos 
        v-cdg_condicion_venta 
        v-cdg_domicilio 
        v-cdg_Imputacion 
        v-cdg_moneda 
        v-cdg_cliente 
        v-cdg_lista_precios 
        v-cdg_deposito 
        v-cdg_vendedor 
        v-dsc_condicion_impos 
        v-dsc_condicion_venta
        v-dsc_domicilio 
        v-dsc_moneda 
        v-dsc_cliente 
        v-dsc_lista_precios 
        v-dsc_deposito 
        v-dsc_vendedor 
        v-anulado
        v-tip_factura WHEN v-tip_factura <> "" 
        v-prf_factura WHEN v-tip_factura <> "" 
        v-nro_factura WHEN v-tip_factura <> "" 
        e-evento
        v-cdg_administrador
        v-dsc_administrador
        tFacturar
        T-Rem_header.sin_cargo
        WITH FRAME {&FRAME-NAME}.

   RUN refrescar_browse.
       
   IF v-anulado = "" THEN
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

    FIND Domicilio OF T-Rem_header NO-LOCK.
    ASSIGN
        v-cdg_domicilio = Domicilio.nro_domicilio
        v-dsc_domicilio = Domicilio.nombre.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_factura C-Win 
PROCEDURE traer_factura :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  FIND Fac_header WHERE Fac_header.nro_factura = Rem_header.nro_factura NO-LOCK NO-ERROR.
  IF AVAILABLE Fac_header
  THEN DO:
       ASSIGN
            v-tip_factura = Fac_header.tip_comprob 
            v-prf_factura = Fac_header.prf_comprob 
            v-nro_factura = Fac_header.nro_comprob. 
  END.
  ELSE DO:
       ASSIGN
            v-tip_factura = "" 
            v-prf_factura = ? 
            v-nro_factura = ?. 
  END.
  RELEASE Fac_header.

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

    FIND Imputacion       OF T-Rem_header NO-LOCK.
    ASSIGN
        v-cdg_imputacion      = Imputacion.cdg_imputacion.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_lista C-Win 
PROCEDURE traer_lista :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND Lista_precios  OF T-Rem_header NO-LOCK.
    ASSIGN
        v-cdg_lista_precios = Lista_precios.cdg_lista
        v-dsc_lista_precios = Lista_precios.descripcion.

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

    FIND Moneda    OF T-Rem_header   NO-LOCK.
    ASSIGN
        v-cdg_moneda          = Moneda.cdg_moneda
        v-dsc_moneda          = Moneda.descripcion.
         
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
  RUN traer_cliente.
  RUN traer_domicilio.
  RUN traer_lista.
  RUN traer_vendedor.
  RUN traer_factura.
  RUN traer_deposito.
  RUN traer_administrador.



END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_vendedor C-Win 
PROCEDURE traer_vendedor :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND Vendedor    OF T-Rem_header   NO-LOCK.
    ASSIGN
        v-cdg_vendedor          = Vendedor.cdg_vendedor
        v-dsc_vendedor          = Vendedor.nombre.

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
  
    {validartabla.i "Cliente"           "cdg_cliente"     "nom_cliente"    "FACT001"}
    {validartabla.i "Vendedor"          "cdg_vendedor"    "nombre"         "FACT003"}
    {validartabla.i "Deposito"          "cdg_deposito"    "nombre"         "FACT023"}
    {validartabla.i "Lista_precios"     "cdg_lista"       "descripcion"    "FACT009"}
    {validartabla.i "Condicion_impos"   "cdg_condiva"     "descripcion"    "FACT008"}
    {validartabla.i "Moneda"            "cdg_moneda"      "descripcion"    "FACT019"}
    {validartabla.i "Condicion_venta"   "cdg_cndventa"    "descripcion"    "FACT002"}
    /*
    {validartabla.i "Imputacion"        "cdg_imputacion"  "dsc_imputacion" "FAPR024"}
    {IFNOTEXS.I "Provincia" "cdg_provincia" "frm-documento" "T-Rem_header" "cdg_provincia " "FACT009"}
    */

    IF T-Rem_header.nombre = ""
    THEN DO:
       RUN PONMENSJ.P (INPUT "FACT027").
       RETURN.
    END.  
  
  /*IF T-Rem_header.cuit = ""
    THEN DO:
       RUN PONMENSJ.P (INPUT "FACT028").
       RETURN.
    END.  */
  
    IF T-Rem_header.cambio = 0
    THEN DO:
       RUN PONMENSJ.P (INPUT "FACT029").
       RETURN.
    END.  
   
    IF ROWID(T-Rem_header) = ?
    THEN DO:
       RUN PONMENSJ.P (INPUT "FACT007").
       RETURN.
    END.
  
    IF NOT CAN-FIND(FIRST T-Rem_detalle OF T-Rem_header)
    THEN DO:
       RUN PONMENSJ.P (INPUT "FACT005").
       RETURN.
    END.
  
    IF NOT Tipocomprobante.autonumera
    THEN DO:
        IF NOT CAN-DO(Tipocomprobante.tip_comprob,T-Rem_header.tip_comprob)
        THEN DO:
           RUN PONMENSJ.P (INPUT "REMI031").
           RETURN.
        END.
    END.
    
    IF NOT Tipocomprobante.autonumera
    THEN DO:
        IF NOT CAN-FIND(FIRST Tipo_puntovta 
                        WHERE Tipo_puntovta.cdg_empresa     = T-Rem_header.cdg_empresa 
                          AND Tipo_puntovta.cdg_comprobante = Tipocomprobante.cdg_comprobante 
                          AND Tipo_puntovta.cdg_puntovta    = v-pto_venta)
        THEN DO:
           RUN PONMENSJ.P (INPUT "REMI070").
           RETURN.
        END.
    END.
    ELSE DO:
        IF NOT CAN-FIND(FIRST Tipo_puntovta 
                        WHERE Tipo_puntovta.cdg_empresa     = T-Rem_header.cdg_empresa 
                          AND Tipo_puntovta.cdg_comprobante = Tipocomprobante.cdg_comprobante 
                          AND Tipo_puntovta.cdg_puntovta    = v-pto_venta)
        THEN DO:
           RUN PONMENSJ.P (INPUT "REMI070").
           RETURN.
        END.
    END.

    /*
    IF T-Rem_header.cambio_dolar = 0
    THEN DO:
       RUN PONMENSJ.P (INPUT "FACT030").
       RETURN.
    END.  

    IF NOT ( cliente_sinesp OR AVAILABLE Cliente )
    THEN DO:
       RUN PONMENSJ.P (INPUT "FACT001").
       RETURN.
    END.

    IF AVAILABLE Cliente AND NOT AVAILABLE Domicilio
    THEN DO:
       RUN PONMENSJ.P (INPUT "FACT010").
       RETURN.
    END.
    */

    FIND FIRST Domicilio OF Cliente WHERE Domicilio.nro_domicilio = INPUT FRAME {&FRAME-NAME} v-cdg_domicilio NO-LOCK NO-ERROR.
    IF NOT AVAILABLE Domicilio
    THEN DO:
       RUN PONMENSJ.P (INPUT "FACT006").
       RETURN.
    END.
  
    /* Error 26 reservado para fecha invalida */

    IF NOT Tipocomprobante.autonumerado
    THEN DO:
        IF T-Rem_header.tip_comprob:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "" OR
           v-pto_venta:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "" 
        THEN DO:
            RUN ponmensj.p ( INPUT "REMI028").
            RETURN.
        END.
        ELSE DO:
            IF CAN-FIND(FIRST Rem_header WHERE Rem_header.cdg_empresa = T-Rem_header.cdg_empresa
                                           AND Rem_header.tip_comprob = T-Rem_header.tip_comprob
                                           AND Rem_header.prf_comprob = v-pto_venta
                                           AND Rem_header.nro_comprob = T-Rem_header.nro_comprob)
            THEN DO:
                RUN ponmensj.p ( INPUT "REMI029" ).
                RETURN.
            END.
        END.
    END.

    hubo_error = NO.

    &SCOPED-DEFINE TABLA-MAESTRA  T-Rem_header

    {asignartabla.i "Cliente"           "nro_cliente"     "nro_cliente"      }
    {asignartabla.i "Vendedor"          "nro_vendedor"    "nro_vendedor"     }
    {asignartabla.i "Deposito"          "nro_deposito"    "nro_deposito"     }
    {asignartabla.i "Lista_precios"     "cdg_lista"       "cdg_lista"        }
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION lee_evento C-Win 
FUNCTION lee_evento RETURNS CHARACTER
  ( INPUT pnro_linea AS INT  ) :
/*------------------------------------------------------------------------------
  Purpose: Lee los eventos relacionados y genera el texto resumen 
    Notes: si el numero de linea es 0 genera un resumen general 
------------------------------------------------------------------------------*/
DEF VAR lista AS CHAR NO-UNDO.
DEF VAR dummy AS CHAR NO-UNDO.
DEF VAR ret AS CHAR NO-UNDO.
DEF VAR k AS INT NO-UNDO.
DEF VAR enro AS CHAR NO-UNDO.
DEF VAR lnro AS int NO-UNDO.
DEFINE BUFFER b-evento FOR t-evento.
ret = CHR(13) + CHR(10).
lista = "".
FOR EACH b-evento:
    IF pnro_linea <> 0 AND b-evento.nro_linea <> pnro_linea THEN NEXT.
    enro = IF b-evento.nro_evento <> 0 THEN STRING(b-evento.nro_evento) ELSE "L" + string(b-evento.nro_linea).
    lista = "**** EVENTO:" + enro + " ****" + ret.
    IF NOT b-evento.evaluar THEN lista = lista + "NO EVALUAR" + ret.
    IF b-evento.frealizado <> ? THEN do:
        lista = lista + IF b-evento.frealizado <> ? THEN "Realz:" + STRING(b-evento.frealizado) + ret ELSE "". 
        dummy = dummy + "Hora:" + b-evento.hora_desde + "-" + b-evento.hora_hasta + ret. 
        dummy = dummy + "Durac:" + string(b-evento.duracion) + ret.
        IF dummy <> ? THEN lista = lista + dummy. 
    END.
    IF b-evento.fasignado <> ? THEN DO:
          lista = lista + "Asig:" + STRING(b-evento.fasignado) + ret . 
    END.
    ELSE DO:
        lista = lista + "No ASIGNADO" + ret.
        IF b-evento.fmax <> ? THEN dummy = "FMax:" + STRING(b-evento.fmax).
        IF b-evento.fmin <> ? THEN dummy = dummy + " FMin:" + STRING(b-evento.fmin).
        IF dummy <> "" THEN lista = lista + dummy + ret.
    END.
    DO k = 1 TO NUM-ENTRIES(b-evento.recursos):
        FIND recurso WHERE recurso.cdg_recurso = ENTRY(k,b-evento.recursos) NO-ERROR.
        IF AVAILABLE recurso THEN lista = lista + Recurso.nom_recurso + ret.
    END.
END.
IF lista = "" THEN Lista = "No se registran eventos".
RETURN lista.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

