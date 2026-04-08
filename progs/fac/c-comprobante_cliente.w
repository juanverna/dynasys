&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win


/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Fac_detalle NO-UNDO LIKE Fac_detalle.
DEFINE TEMP-TABLE T-Fac_detalle-bon NO-UNDO LIKE Fac_detalle-bon.
DEFINE TEMP-TABLE T-Fac_detalle_impuesto NO-UNDO LIKE Fac_detalle_impuesto.
DEFINE TEMP-TABLE T-Fac_header NO-UNDO LIKE Fac_header.
DEFINE TEMP-TABLE T-Fac_header-bon NO-UNDO LIKE Fac_header-bon.
DEFINE TEMP-TABLE T-Fac_header_impuesto NO-UNDO LIKE Fac_header_impuesto.
DEFINE TEMP-TABLE T-Registrable-factura NO-UNDO LIKE Registrable-factura.
DEFINE TEMP-TABLE T-Sub_detalle_vta NO-UNDO LIKE Sub_detalle_vta.
DEFINE TEMP-TABLE T-Sub_header_vta NO-UNDO LIKE Sub_header_vta.



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
DEFINE VARIABLE                rid_factura        AS ROWID.
DEFINE VARIABLE                modo               AS INTEGER.
DEFINE VARIABLE                p-cdg_comprobante  AS CHARACTER.
&ELSE
DEFINE INPUT-OUTPUT PARAMETER  rid_factura        AS ROWID.
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
DEFINE VARIABLE codigo_iva                AS INTEGER INITIAL 1.
DEFINE VARIABLE hay_canje                 AS LOGICAL.
DEFINE VARIABLE mod_cambio                AS LOGICAL.

DEFINE VARIABLE v-debug                   AS LOGICAL INITIAL NO.

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
DEFINE VARIABLE v-leyenda                 AS CHARACTER.

DEFINE VARIABLE equiv_granel              LIKE Fac_detalle.granel.
DEFINE VARIABLE x-primero                 LIKE T-Fac_header.cdg_imputacion.

DEFINE VARIABLE fecha_inicial             AS DATE.
DEFINE VARIABLE fecha_elegida             AS DATE.

DEFINE VARIABLE que_empresa               LIKE Empresa.cdg_empresa.

DEFINE VARIABLE max_lidet                 AS INTEGER.
DEFINE VARIABLE max_chley                 AS INTEGER.
DEFINE VARIABLE que_sector                LIKE Area.cdg_area.

DEFINE BUFFER Dolar FOR Moneda.
DEFINE BUFFER administrador FOR cliente.

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
&Scoped-define INTERNAL-TABLES T-Fac_detalle Articulo T-Fac_header Cliente

/* Definitions for BROWSE BROWSE-1                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-1 T-Fac_detalle.nro_linea ~
Articulo.cdg_articulo Articulo.descripcion Articulo.cdg_umed ~
T-Fac_detalle.cantidad T-Fac_detalle.granel T-Fac_detalle.precio ~
T-Fac_detalle.subtotal_neto 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-1 
&Scoped-define QUERY-STRING-BROWSE-1 FOR EACH T-Fac_detalle OF T-Fac_header NO-LOCK, ~
      EACH Articulo OF T-Fac_detalle NO-LOCK
&Scoped-define OPEN-QUERY-BROWSE-1 OPEN QUERY BROWSE-1 FOR EACH T-Fac_detalle OF T-Fac_header NO-LOCK, ~
      EACH Articulo OF T-Fac_detalle NO-LOCK.
&Scoped-define TABLES-IN-QUERY-BROWSE-1 T-Fac_detalle Articulo
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-1 T-Fac_detalle
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-1 Articulo


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define FIELDS-IN-QUERY-DEFAULT-FRAME T-Fac_header.tip_comprob ~
T-Fac_header.nro_comprob T-Fac_header.fecha T-Fac_header.cta_cte ~
T-Fac_header.fecha_iva T-Fac_header.mes T-Fac_header.ano ~
T-Fac_header.fecha_ocm T-Fac_header.nro_ocm T-Fac_header.clausula_dolar ~
T-Fac_header.cambio T-Fac_header.cambio_dolar T-Fac_header.prc_canje ~
T-Fac_header.cdg_imputacion T-Fac_header.nro_contrato ~
T-Fac_header.leyenda_cc T-Fac_header.imp_neto T-Fac_header.imp_total 
&Scoped-define ENABLED-FIELDS-IN-QUERY-DEFAULT-FRAME ~
T-Fac_header.tip_comprob T-Fac_header.nro_comprob T-Fac_header.fecha ~
T-Fac_header.mes T-Fac_header.ano T-Fac_header.clausula_dolar ~
T-Fac_header.cambio_dolar T-Fac_header.cdg_imputacion ~
T-Fac_header.nro_contrato T-Fac_header.leyenda_cc T-Fac_header.imp_total 
&Scoped-define ENABLED-TABLES-IN-QUERY-DEFAULT-FRAME T-Fac_header
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-DEFAULT-FRAME T-Fac_header
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-BROWSE-1}
&Scoped-define QUERY-STRING-DEFAULT-FRAME FOR EACH T-Fac_header SHARE-LOCK, ~
      EACH Cliente WHERE TRUE /* Join to T-Fac_header incomplete */ SHARE-LOCK
&Scoped-define OPEN-QUERY-DEFAULT-FRAME OPEN QUERY DEFAULT-FRAME FOR EACH T-Fac_header SHARE-LOCK, ~
      EACH Cliente WHERE TRUE /* Join to T-Fac_header incomplete */ SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-DEFAULT-FRAME T-Fac_header Cliente
&Scoped-define FIRST-TABLE-IN-QUERY-DEFAULT-FRAME T-Fac_header
&Scoped-define SECOND-TABLE-IN-QUERY-DEFAULT-FRAME Cliente


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS T-Fac_header.tip_comprob ~
T-Fac_header.nro_comprob T-Fac_header.fecha T-Fac_header.mes ~
T-Fac_header.ano T-Fac_header.clausula_dolar T-Fac_header.cambio_dolar ~
T-Fac_header.cdg_imputacion T-Fac_header.nro_contrato ~
T-Fac_header.leyenda_cc T-Fac_header.imp_total 
&Scoped-define ENABLED-TABLES T-Fac_header
&Scoped-define FIRST-ENABLED-TABLE T-Fac_header
&Scoped-Define ENABLED-OBJECTS RECT-2 RECT-3 RECT-4 Btn_salir b-verrem bVer ~
vfactu_admin BROWSE-1 
&Scoped-Define DISPLAYED-FIELDS T-Fac_header.tip_comprob ~
T-Fac_header.nro_comprob T-Fac_header.fecha T-Fac_header.cta_cte ~
T-Fac_header.fecha_iva T-Fac_header.mes T-Fac_header.ano ~
T-Fac_header.fecha_ocm T-Fac_header.nro_ocm T-Fac_header.clausula_dolar ~
T-Fac_header.cambio T-Fac_header.cambio_dolar T-Fac_header.prc_canje ~
T-Fac_header.cdg_imputacion T-Fac_header.nro_contrato ~
T-Fac_header.leyenda_cc T-Fac_header.imp_neto T-Fac_header.imp_total 
&Scoped-define DISPLAYED-TABLES T-Fac_header
&Scoped-define FIRST-DISPLAYED-TABLE T-Fac_header
&Scoped-Define DISPLAYED-OBJECTS v-pto_venta v-comprobante v-anulado ~
v-cdg_cliente v-dsc_cliente v-cdg_domicilio v-dsc_domicilio v-abv_provincia ~
v-cdg_condicion_impos v-dsc_condicion_impos v-cdg_moneda v-dsc_moneda ~
v-cdg_condicion_venta v-dsc_condicion_venta v-tip_remito v-prf_remito ~
v-nro_remito v-cdg_deposito v-dsc_deposito v-cdg_vendedor v-dsc_vendedor ~
v-cdg_lista_precios v-dsc_lista_precios v-cdg_administrador ~
v-dsc_administrador vfactu_admin v-cdg_articulo 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON b-verrem 
     LABEL "Ver" 
     SIZE 5 BY 1.

DEFINE BUTTON btn_anular 
     LABEL "&Anular" 
     SIZE 18 BY 1.43.

DEFINE BUTTON btn_cancel 
     LABEL "&Cancelar" 
     SIZE 18 BY 1.43.

DEFINE BUTTON btn_contador 
     LABEL "Con&t" 
     SIZE 7 BY 1.

DEFINE BUTTON btn_copiar 
     LABEL "&Copiar" 
     SIZE 18 BY 1.43.

DEFINE BUTTON btn_grabar 
     LABEL "&Grabar" 
     SIZE 18 BY 1.43.

DEFINE BUTTON btn_imprim 
     LABEL "&Reimprimir" 
     SIZE 18 BY 1.43.

DEFINE BUTTON btn_leyenda 
     LABEL "&Leyenda" 
     SIZE 18 BY 1.43.

DEFINE BUTTON btn_nominar 
     LABEL "&Nominar" 
     SIZE 20 BY 1.

DEFINE BUTTON btn_observ 
     LABEL "&Observaciones" 
     SIZE 18 BY 1.43.

DEFINE BUTTON btn_porclasificacion 
     LABEL "X &Clasificación" 
     SIZE 19 BY 1.

DEFINE BUTTON Btn_salir DEFAULT 
     LABEL "&Salir" 
     SIZE 18 BY 1.43
     BGCOLOR 8 .

DEFINE BUTTON btn_verbonificaciones 
     LABEL "&Bonificaciones" 
     SIZE 19 BY 1.

DEFINE BUTTON btn_verimputacion 
     LABEL "Ver &Asiento" 
     SIZE 20 BY 1.

DEFINE BUTTON bVer 
     LABEL "Ver" 
     SIZE 5 BY 1.

DEFINE VARIABLE v-abv_provincia AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 29 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-anulado AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     FGCOLOR 12 FONT 6 NO-UNDO.

DEFINE VARIABLE v-cdg_administrador AS CHARACTER FORMAT "X(8)" 
     LABEL "Administ." 
     VIEW-AS FILL-IN NATIVE 
     SIZE 11 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_articulo AS CHARACTER FORMAT "X(15)":U 
     LABEL "Artículo" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 31 BY 1
     BGCOLOR 14 FGCOLOR 12 FONT 6 NO-UNDO.

DEFINE VARIABLE v-cdg_cliente AS CHARACTER FORMAT "X(8)" 
     LABEL "Cliente" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_condicion_impos AS INTEGER FORMAT "->,>>>,>>9" INITIAL 0 
     LABEL "C.Impos." 
     VIEW-AS FILL-IN NATIVE 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_condicion_venta AS CHARACTER FORMAT "X(8)" 
     LABEL "C.Venta" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_deposito AS CHARACTER FORMAT "X(256)" 
     LABEL "Depósito" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_domicilio AS INTEGER FORMAT ">>>>>>9" INITIAL 1 
     LABEL "Domicilio" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 8 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_lista_precios AS INTEGER FORMAT "->,>>>,>>9" INITIAL 0 
     LABEL "Lista" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_moneda AS CHARACTER FORMAT "X(3)" 
     LABEL "Moneda" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_vendedor AS CHARACTER FORMAT "X(4)" 
     LABEL "Vendedor" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-comprobante AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 43 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE v-dsc_administrador AS CHARACTER FORMAT "X(35)" 
     VIEW-AS FILL-IN 
     SIZE 54 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_cliente AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 58 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_condicion_impos AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 52 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_condicion_venta AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 58 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_deposito AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 42 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_domicilio AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 72 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_lista_precios AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 42 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_moneda AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 58 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_vendedor AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 58 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-nro_remito AS INTEGER FORMAT ">>>>>>>9":U INITIAL 0 
     VIEW-AS FILL-IN NATIVE 
     SIZE 11 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE v-prf_remito AS INTEGER FORMAT ">>>9":U INITIAL 0 
     VIEW-AS FILL-IN NATIVE 
     SIZE 7 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE v-pto_venta AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN NATIVE 
     SIZE 8 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 6 NO-UNDO.

DEFINE VARIABLE v-tip_remito AS CHARACTER FORMAT "X(3)":U 
     LABEL "Remito" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 7 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 135 BY 1.91.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 21 BY 1.91.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 156 BY 12.33.

DEFINE VARIABLE vfactu_admin LIKE Cliente.factu_admin
     LABEL "Facturar a Adm." 
     VIEW-AS TOGGLE-BOX
     SIZE 20 BY .81 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-1 FOR 
      T-Fac_detalle, 
      Articulo SCROLLING.

DEFINE QUERY DEFAULT-FRAME FOR 
      T-Fac_header, 
      Cliente SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-1 C-Win _STRUCTURED
  QUERY BROWSE-1 NO-LOCK DISPLAY
      T-Fac_detalle.nro_linea FORMAT ">>9":U
      Articulo.cdg_articulo FORMAT "X(12)":U WIDTH 17.2
      Articulo.descripcion COLUMN-LABEL "Descripcion!Asociada" FORMAT "X(50)":U
            WIDTH 57.2
      Articulo.cdg_umed COLUMN-LABEL "Unidad!Medida" FORMAT "X(12)":U
      T-Fac_detalle.cantidad FORMAT "->>>,>>>,>>9.99":U
      T-Fac_detalle.granel FORMAT "->>>,>>>,>>9.99":U
      T-Fac_detalle.precio FORMAT ">>>>>>9.9999":U
      T-Fac_detalle.subtotal_neto FORMAT "->,>>>,>>>,>>9.99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 156 BY 10
         BGCOLOR 15 FGCOLOR 9 FONT 4.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btn_grabar AT ROW 1.48 COL 4
     btn_copiar AT ROW 1.48 COL 23
     btn_cancel AT ROW 1.48 COL 42
     btn_anular AT ROW 1.48 COL 61
     btn_leyenda AT ROW 1.48 COL 80
     btn_observ AT ROW 1.48 COL 99
     btn_imprim AT ROW 1.48 COL 118
     Btn_salir AT ROW 1.48 COL 140
     T-Fac_header.tip_comprob AT ROW 3.62 COL 13 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 5 BY 1
          BGCOLOR 7 FGCOLOR 15 
     v-pto_venta AT ROW 3.62 COL 18 COLON-ALIGNED NO-LABEL
     T-Fac_header.nro_comprob AT ROW 3.62 COL 26 COLON-ALIGNED NO-LABEL FORMAT ">>>>>>>9"
          VIEW-AS FILL-IN NATIVE 
          SIZE 14 BY 1
          BGCOLOR 7 FGCOLOR 15 
     v-comprobante AT ROW 3.62 COL 42 COLON-ALIGNED NO-LABEL
     v-anulado AT ROW 3.62 COL 87 COLON-ALIGNED NO-LABEL
     btn_contador AT ROW 3.62 COL 105
     T-Fac_header.fecha AT ROW 3.62 COL 139 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_cliente AT ROW 4.81 COL 13 COLON-ALIGNED
     v-dsc_cliente AT ROW 4.81 COL 27 COLON-ALIGNED NO-LABEL
     T-Fac_header.cta_cte AT ROW 4.81 COL 96 COLON-ALIGNED
          LABEL "Pago"
          VIEW-AS COMBO-BOX INNER-LINES 2
          LIST-ITEM-PAIRS "Cuenta.Corriente",yes,
                     "Contado",no
          DROP-DOWN-LIST
          SIZE 29 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Fac_header.fecha_iva AT ROW 4.81 COL 139 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_domicilio AT ROW 6 COL 13 COLON-ALIGNED
     v-dsc_domicilio AT ROW 6 COL 22 COLON-ALIGNED NO-LABEL
     v-abv_provincia AT ROW 6 COL 96 COLON-ALIGNED NO-LABEL
     T-Fac_header.mes AT ROW 6 COL 139 COLON-ALIGNED
          LABEL "Período"
          VIEW-AS FILL-IN NATIVE 
          SIZE 6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Fac_header.ano AT ROW 6 COL 146 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 9 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_condicion_impos AT ROW 7.19 COL 13 COLON-ALIGNED
     v-dsc_condicion_impos AT ROW 7.19 COL 27 COLON-ALIGNED NO-LABEL
     T-Fac_header.fecha_ocm AT ROW 7.19 COL 91 COLON-ALIGNED
          LABEL "Fch. O/C"
          VIEW-AS FILL-IN NATIVE 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Fac_header.nro_ocm AT ROW 7.19 COL 117 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Fac_header.clausula_dolar AT ROW 7.19 COL 140
          VIEW-AS TOGGLE-BOX
          SIZE 18 BY 1.19
     v-cdg_moneda AT ROW 8.38 COL 13 COLON-ALIGNED NO-TAB-STOP 
     v-dsc_moneda AT ROW 8.38 COL 27 COLON-ALIGNED NO-LABEL
     T-Fac_header.cambio AT ROW 8.38 COL 96 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Fac_header.cambio_dolar AT ROW 8.38 COL 139 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_condicion_venta AT ROW 9.57 COL 13 COLON-ALIGNED
     v-dsc_condicion_venta AT ROW 9.57 COL 27 COLON-ALIGNED NO-LABEL
     T-Fac_header.prc_canje AT ROW 9.57 COL 96 COLON-ALIGNED
          LABEL "% Canje"
          VIEW-AS FILL-IN NATIVE 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 160 BY 27.67.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME DEFAULT-FRAME
     v-tip_remito AT ROW 9.57 COL 122.2 COLON-ALIGNED
     v-prf_remito AT ROW 9.57 COL 130.2 COLON-ALIGNED NO-LABEL
     v-nro_remito AT ROW 9.57 COL 138.2 COLON-ALIGNED NO-LABEL
     b-verrem AT ROW 9.57 COL 152 WIDGET-ID 50
     T-Fac_header.cdg_imputacion AT ROW 10.76 COL 13 COLON-ALIGNED
          LABEL "Concepto"
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Item",1,
                     "Punto",2
          DROP-DOWN-LIST
          SIZE 72 BY 1
          BGCOLOR 15 FGCOLOR 9 FONT 4
     v-cdg_deposito AT ROW 10.76 COL 96 COLON-ALIGNED
     v-dsc_deposito AT ROW 10.76 COL 113 COLON-ALIGNED NO-LABEL
     v-cdg_vendedor AT ROW 11.95 COL 13 COLON-ALIGNED
     v-dsc_vendedor AT ROW 11.95 COL 27 COLON-ALIGNED NO-LABEL
     v-cdg_lista_precios AT ROW 12 COL 96 COLON-ALIGNED
     v-dsc_lista_precios AT ROW 12 COL 113 COLON-ALIGNED NO-LABEL
     v-cdg_administrador AT ROW 13.14 COL 13 COLON-ALIGNED WIDGET-ID 2
     bVer AT ROW 13.14 COL 27 WIDGET-ID 6
     v-dsc_administrador AT ROW 13.14 COL 31 COLON-ALIGNED HELP
          "Denominacion" NO-LABEL WIDGET-ID 4
     vfactu_admin AT ROW 13.14 COL 98 HELP
          "" WIDGET-ID 48
          LABEL "Facturar a Adm."
     T-Fac_header.nro_contrato AT ROW 13.14 COL 143 COLON-ALIGNED WIDGET-ID 10
          LABEL "Contrato"
          VIEW-AS FILL-IN NATIVE 
          SIZE 11 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Fac_header.leyenda_cc AT ROW 14.33 COL 13 COLON-ALIGNED
          LABEL "Obs."
          VIEW-AS FILL-IN NATIVE 
          SIZE 99 BY 1
          BGCOLOR 15 FGCOLOR 9 
     btn_verimputacion AT ROW 14.33 COL 115
     btn_nominar AT ROW 14.33 COL 137
     v-cdg_articulo AT ROW 16.24 COL 13 COLON-ALIGNED
     btn_porclasificacion AT ROW 16.24 COL 47
     btn_verbonificaciones AT ROW 16.24 COL 68
     T-Fac_header.imp_neto AT ROW 16.24 COL 96 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 23 BY 1
          BGCOLOR 7 FGCOLOR 14 
     T-Fac_header.imp_total AT ROW 16.24 COL 134 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 21 BY 1
          BGCOLOR 7 FGCOLOR 14 
     BROWSE-1 AT ROW 17.67 COL 3
     RECT-2 AT ROW 1.24 COL 3
     RECT-3 AT ROW 1.24 COL 138
     RECT-4 AT ROW 3.38 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 160 BY 27.67.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Fac_detalle T "?" NO-UNDO sic Fac_detalle
      TABLE: T-Fac_detalle-bon T "?" NO-UNDO sic Fac_detalle-bon
      TABLE: T-Fac_detalle_impuesto T "?" NO-UNDO sic Fac_detalle_impuesto
      TABLE: T-Fac_header T "?" NO-UNDO sic Fac_header
      TABLE: T-Fac_header-bon T "?" NO-UNDO sic Fac_header-bon
      TABLE: T-Fac_header_impuesto T "?" NO-UNDO sic Fac_header_impuesto
      TABLE: T-Registrable-factura T "?" NO-UNDO sic Registrable-factura
      TABLE: T-Sub_detalle_vta T "?" NO-UNDO sic Sub_detalle_vta
      TABLE: T-Sub_header_vta T "?" NO-UNDO sic Sub_header_vta
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Facturas a Clientes"
         HEIGHT             = 27.67
         WIDTH              = 160
         MAX-HEIGHT         = 27.67
         MAX-WIDTH          = 160
         VIRTUAL-HEIGHT     = 27.67
         VIRTUAL-WIDTH      = 160
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
   FRAME-NAME                                                           */
/* BROWSE-TAB BROWSE-1 imp_total DEFAULT-FRAME */
/* SETTINGS FOR BUTTON btn_anular IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_cancel IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_contador IN FRAME DEFAULT-FRAME
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
/* SETTINGS FOR FILL-IN T-Fac_header.cambio IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX T-Fac_header.cdg_imputacion IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR COMBO-BOX T-Fac_header.cta_cte IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN T-Fac_header.fecha_iva IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Fac_header.fecha_ocm IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN T-Fac_header.imp_neto IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Fac_header.leyenda_cc IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN T-Fac_header.mes IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN T-Fac_header.nro_comprob IN FRAME DEFAULT-FRAME
   EXP-FORMAT                                                           */
/* SETTINGS FOR FILL-IN T-Fac_header.nro_contrato IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN T-Fac_header.nro_ocm IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Fac_header.prc_canje IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN v-abv_provincia IN FRAME DEFAULT-FRAME
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
ASSIGN 
       v-cdg_moneda:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

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
/* SETTINGS FOR FILL-IN v-nro_remito IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-prf_remito IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-pto_venta IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-tip_remito IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR TOGGLE-BOX vfactu_admin IN FRAME DEFAULT-FRAME
   LIKE = sic.Cliente.factu_admin EXP-LABEL EXP-SIZE                    */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-1
/* Query rebuild information for BROWSE BROWSE-1
     _TblList          = "Temp-Tables.T-Fac_detalle OF Temp-Tables.T-Fac_header,sic.Articulo OF Temp-Tables.T-Fac_detalle"
     _Options          = "NO-LOCK"
     _FldNameList[1]   = Temp-Tables.T-Fac_detalle.nro_linea
     _FldNameList[2]   > sic.Articulo.cdg_articulo
"Articulo.cdg_articulo" ? ? "character" ? ? ? ? ? ? no ? no no "17.2" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > sic.Articulo.descripcion
"Articulo.descripcion" "Descripcion!Asociada" ? "character" ? ? ? ? ? ? no ? no no "57.2" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > sic.Articulo.cdg_umed
"Articulo.cdg_umed" "Unidad!Medida" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   = Temp-Tables.T-Fac_detalle.cantidad
     _FldNameList[6]   = Temp-Tables.T-Fac_detalle.granel
     _FldNameList[7]   = Temp-Tables.T-Fac_detalle.precio
     _FldNameList[8]   = Temp-Tables.T-Fac_detalle.subtotal_neto
     _Query            is OPENED
*/  /* BROWSE BROWSE-1 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME DEFAULT-FRAME
/* Query rebuild information for FRAME DEFAULT-FRAME
     _TblList          = "Temp-Tables.T-Fac_header,sic.Cliente WHERE Temp-Tables.T-Fac_header ..."
     _Query            is OPENED
*/  /* FRAME DEFAULT-FRAME */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Facturas a Clientes */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Facturas a Clientes */
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
  ASSIGN v-tip_remito v-prf_remito v-nro_remito.
  DEF VAR act_rem_head AS ROWID NO-UNDO.
  FIND Rem_header WHERE  Rem_header.cdg_empresa = empresa.cdg_empresa
                         AND  Rem_header.tip_comprob = v-tip_remito
                         AND Rem_header.prf_comprob = v-prf_remito
                         AND Rem_header.nro_comprob = v-nro_remito NO-ERROR.
  IF AVAILABLE Rem_header
     THEN DO:                  
          act_rem_head = ROWID(Rem_header).
          /*RUN ocultar_window.*/
          RUN c-comprobante_despacho.w ( INPUT-OUTPUT act_Rem_head , INPUT 2, INPUT Rem_header.cdg_comprobante ).
          /*RUN mostrar_window.*/
END.
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
             DELETE T-Fac_detalle.
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-1 C-Win
ON MOUSE-SELECT-DBLCLICK OF BROWSE-1 IN FRAME DEFAULT-FRAME
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
  DEFINE VAR puso_ok AS LOGICAL NO-UNDO.
   {verificarcierre.i "T-Fac_header.cdg_empresa" "T-Fac_header.fecha" "FAC"}

    sino-msg = NO.
    RUN mensajepregunta.p ( INPUT "este comprobante",INPUT "PREG005", INPUT-OUTPUT sino-msg ). 
    IF sino-msg
    THEN DO:
         RUN anular_comprobante_cliente.p (INPUT ROWID(Fac_header), OUTPUT pudo_anular,NO).
         IF pudo_anular = 0
         THEN DO:
              DO TRANSACTION:
                RUN borrar_tablas_temporales.
              END.
              MESSAGE "El comprobante ha sido anulado" 
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
    RUN mensajepregunta.p ( INPUT "",INPUT "PREG002", INPUT-OUTPUT sino-msg ). 
    IF sino-msg
    THEN DO:

        RUN borrar_tablas_temporales.

        ASSIGN codigo_salir = CD_CANCELAR.
        APPLY "U1" TO THIS-PROCEDURE.

    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_contador
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_contador C-Win
ON CHOOSE OF btn_contador IN FRAME DEFAULT-FRAME /* Cont */
DO:
  RUN d-mostrar_contador.w ( T-Fac_header.cdg_comprobante, v-pto_venta , T-Fac_header.nro_cliente ).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_copiar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_copiar C-Win
ON CHOOSE OF btn_copiar IN FRAME DEFAULT-FRAME /* Copiar */
DO:

  RUN d-seleccionar_factura.w (INPUT-OUTPUT rid_factura).
  IF rid_factura <> ?
  THEN DO:
     FIND Fac_header WHERE ROWID(Fac_header) = rid_factura NO-LOCK.
     DISPLAY Fac_header.tip_comprob @ T-Fac_header.tip_comprob 
             Fac_header.prf_comprob @ v-pto_venta
             Fac_header.nro_comprob @ T-Fac_header.nro_comprob
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
         T-Fac_header.ano 
         T-Fac_header.cambio 
         T-Fac_header.fecha 
         T-Fac_header.fecha_iva 
         T-Fac_header.mes 
         T-Fac_header.fecha_ocm 
         T-Fac_header.nro_ocm 
         T-Fac_header.prc_canje 
         T-Fac_header.leyenda_cc
         T-Fac_header.cta_cte
         T-Fac_header.cdg_imputacion
         T-Fac_header.clausula_dolar
         t-fac_header.nro_contrato.
         
  RUN validar_datos ( OUTPUT hay_error ).
  IF NOT hay_error
  THEN DO:

       T-Fac_header.cdg_imputacion:SENSITIVE = NO. /* Ya no puede cambiarse el concepto de imputacion */
       IF NOT T-Fac_header.anulado /* No es una anulación */
       THEN DO:
            IF NOT T-Fac_header.cta_cte
            THEN DO:
                IF NOT AVAILABLE Caj_header
                THEN DO:
                     RUN crear_caja.
                END.
                ELSE DO:
                     RUN asignar_caja.
                END.   
                /*
                act_caj_head = ROWID(Caj_header).
                RUN ALTMCAJA.P (INPUT 1).
                FIND Caj_header WHERE ROWID(Caj_header) = act_caj_head EXCLUSIVE-LOCK.
                IF Caj_header.importe <> Caj_header.ingreso THEN RETURN NO-APPLY.
                */
            END.
       END.
     
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
    RUN mensajepregunta.p ( INPUT "este comprobante",INPUT "PREG003", INPUT-OUTPUT sino-msg ).
    IF sino-msg
    THEN DO:
         RUN imprimir_comprobante_cliente.p (ROWID(Fac_header)).
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_leyenda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_leyenda C-Win
ON CHOOSE OF btn_leyenda IN FRAME DEFAULT-FRAME /* Leyenda */
DO:

   DEFINE VARIABLE puso_ok AS LOGICAL.
   RUN c-editar_leyenda_comprobante.w ( INPUT-OUTPUT T-Fac_header.leyenda,
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
  RUN d-nominar_factura.w ( INPUT modo, INPUT 1, INPUT-OUTPUT TABLE T-Fac_header).
  FIND FIRST T-Fac_header.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_observ
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_observ C-Win
ON CHOOSE OF btn_observ IN FRAME DEFAULT-FRAME /* Observaciones */
DO:

   DEFINE VARIABLE puso_ok AS LOGICAL.
   RUN c-edttexto-avanzado.w /*c-editar_leyenda_comprobante.w*/ ( INPUT-OUTPUT T-Fac_header.observacion,
                                        INPUT "Observaciones del Comprobante Actual",
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
    RUN mensajepregunta.p ( INPUT "",INPUT "PREG001", INPUT-OUTPUT sino-msg ). 
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
  RUN d-bonificaciones_factura.w (INPUT-OUTPUT TABLE T-Fac_header, INPUT-OUTPUT TABLE T-Fac_header-bon, INPUT modo ).
 
  RUN calculos.
 

  {&OPEN-QUERY-{&BROWSE-NAME}}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_verimputacion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_verimputacion C-Win
ON CHOOSE OF btn_verimputacion IN FRAME DEFAULT-FRAME /* Ver Asiento */
DO:
  RUN d-ver_imputacion_comprobante.w ( INPUT TABLE T-Sub_header_vta,
                                       INPUT TABLE T-Sub_detalle_vta) .
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bVer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bVer C-Win
ON CHOOSE OF bVer IN FRAME DEFAULT-FRAME /* Ver */
DO:
  DEFINE BUFFER badminis FOR cliente.
  FIND badminis WHERE badminis.nro_cliente = cliente.nro_administrador NO-LOCK NO-ERROR.
  IF AVAILABLE badminis THEN
  RUN w-zoom_administraciones.w ( INPUT ROWID(badminis) ).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Fac_header.cdg_imputacion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Fac_header.cdg_imputacion C-Win
ON VALUE-CHANGED OF T-Fac_header.cdg_imputacion IN FRAME DEFAULT-FRAME /* Concepto */
DO:
  ASSIGN T-Fac_header.cdg_imputacion.
  FIND Imputacion WHERE Imputacion.cdg_imputacion = T-Fac_header.cdg_imputacion NO-LOCK.
  RUN asignar_imputacion.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Fac_header.clausula_dolar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Fac_header.clausula_dolar C-Win
ON VALUE-CHANGED OF T-Fac_header.clausula_dolar IN FRAME DEFAULT-FRAME /* Cláusula Dólar */
DO:
    ASSIGN FRAME {&FRAME-NAME} T-Fac_header.clausula_dolar.
    IF T-Fac_header.clausula_dolar
    THEN DO:
        RUN asignar_dolar.
    END.
    ELSE DO:
        T-Fac_header.cambio_dolar = 1.
        DISPLAY T-Fac_header.cambio_dolar
                 WITH FRAME {&FRAME-NAME}.
    END.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Fac_header.fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Fac_header.fecha C-Win
ON LEAVE OF T-Fac_header.fecha IN FRAME DEFAULT-FRAME /* Fecha */
DO:
  ASSIGN T-Fac_header.fecha.
  T-Fac_header.fecha_iva = T-Fac_header.fecha.
  DISPLAY T-Fac_header.fecha_iva
      WITH FRAME {&FRAME-NAME}.
  RUN asignar_cambio.
  RUN asignar_lista_precios.
  RUN calculos.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Fac_header.fecha C-Win
ON MOUSE-MENU-DOWN OF T-Fac_header.fecha IN FRAME DEFAULT-FRAME /* Fecha */
DO:
  fecha_inicial = DATE(T-Fac_header.fecha:SCREEN-VALUE IN FRAME {&FRAME-NAME}) NO-ERROR.
  IF fecha_inicial = ? THEN fecha_inicial = TODAY.
  RUN d-calendario.w ( INPUT fecha_inicial, OUTPUT fecha_elegida).
  IF fecha_elegida <> ?
  THEN DO:
       DISPLAY fecha_elegida @ T-Fac_header.fecha 
               WITH FRAME {&FRAME-NAME}.
       APPLY "TAB" TO SELF.        
  END.               
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Fac_header.fecha_iva
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Fac_header.fecha_iva C-Win
ON LEAVE OF T-Fac_header.fecha_iva IN FRAME DEFAULT-FRAME /* Fecha IVA */
DO:
  ASSIGN T-Fac_header.fecha_iva.
  RUN calculos.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Fac_header.fecha_iva C-Win
ON MOUSE-MENU-DOWN OF T-Fac_header.fecha_iva IN FRAME DEFAULT-FRAME /* Fecha IVA */
DO:
  fecha_inicial = DATE(T-Fac_header.fecha_iva:SCREEN-VALUE IN FRAME {&FRAME-NAME}) NO-ERROR.
  IF fecha_inicial = ? THEN fecha_inicial = TODAY.
  RUN d-calendario.w ( INPUT fecha_inicial, OUTPUT fecha_elegida).
  IF fecha_elegida <> ?
  THEN DO:
       DISPLAY fecha_elegida @ T-Fac_header.fecha_iva
               WITH FRAME {&FRAME-NAME}.
       APPLY "TAB" TO SELF.        
  END.                 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Fac_header.nro_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Fac_header.nro_comprob C-Win
ON MOUSE-SELECT-DBLCLICK OF T-Fac_header.nro_comprob IN FRAME DEFAULT-FRAME /* nro_comprob */
OR MOUSE-MENU-DOWN,"." OF T-Fac_header.nro_comprob IN FRAME {&FRAME-NAME}
DO:
  DEFINE VARIABLE lista_estados AS CHARACTER.
  DEFINE VARIABLE titulo_window AS CHARACTER.

  CASE modo:
     WHEN MD_ALTA
     THEN DO:
          titulo_window = "".     /* Esta opcion la contemplamos por unicidad pero no debería producirse nunca */
          lista_estados = "".
     END.
     WHEN MD_MULTIPLE      
     THEN DO:
          titulo_window = "Selección de " + Tipocomprobante.titulo_window.
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
          titulo_window = "Selección " + Tipocomprobante.titulo_window.
          lista_estados = "*".
     END.
     WHEN MD_CAMBIO        
     THEN DO:
          titulo_window = "".
          lista_estados = "".
     END.
     WHEN MD_ANULACION        
     THEN DO:
          titulo_window = "Selección de " + Tipocomprobante.titulo_window.
          lista_estados = "P,E".
     END.
     WHEN MD_EMISION        
     THEN DO:
          titulo_window = "Selección de " + Tipocomprobante.titulo_window.
          lista_estados = "".
     END.
  END CASE.     

  RUN d-selcomprobante_cliente.w (INPUT titulo_window, INPUT lista_estados, INPUT Tipocomprobante.cdg_comprobante, INPUT-OUTPUT rid_factura).
  IF rid_factura <> ?
  THEN DO:
     FIND Fac_header WHERE ROWID(Fac_header) = rid_factura NO-LOCK.
     DISPLAY Fac_header.tip_comprob @ T-Fac_header.tip_comprob 
             Fac_header.prf_comprob @ v-pto_venta
             Fac_header.nro_comprob @ T-Fac_header.nro_comprob
             WITH FRAME {&FRAME-NAME}.
     IF modo = MD_ANULACION AND Fac_header.anulado
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

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Fac_header.nro_comprob C-Win
ON RETURN OF T-Fac_header.nro_comprob IN FRAME DEFAULT-FRAME /* nro_comprob */
DO:

   IF NOT INPUT FRAME {&FRAME-NAME} T-Fac_header.tip_comprob MATCHES Tipocomprobante.tip_comprob
   THEN DO:
       RUN PONMENSJ.P (INPUT "DOCS010").
       RETURN NO-APPLY.
   END.
   ELSE DO:
       FIND Fac_header 
            WHERE Fac_header.cdg_empresa = Empresa.cdg_empresa
              AND Fac_header.tip_comprob = INPUT T-Fac_header.tip_comprob 
              AND Fac_header.prf_comprob = INPUT v-pto_venta
              AND Fac_header.nro_comprob = INPUT T-Fac_header.nro_comprob
                  NO-ERROR.
    
       IF NOT AVAILABLE Fac_header 
       THEN DO:
            IF LOCKED Fac_header
               THEN RUN PONMENSJ.P (INPUT "DOCS000").
               ELSE RUN PONMENSJ.P (INPUT "DOCS001").
            RETURN NO-APPLY.
       END.
       ELSE DO:
            rid_factura = ROWID(Fac_header).
            RUN traer_documento.
            
       END.
   END.

  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Fac_header.nro_contrato
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Fac_header.nro_contrato C-Win
ON MOUSE-SELECT-DBLCLICK OF T-Fac_header.nro_contrato IN FRAME DEFAULT-FRAME /* Contrato */
OR "." OF v-cdg_cliente IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF T-Fac_header.nro_contrato IN FRAME {&FRAME-NAME}
DO :
  DEFINE VARIABLE rid_contrato AS ROWID.
  FIND contrato_hd WHERE contrato_hd.nro_contrato = T-Fac_header.nro_contrato:INPUT-VALUE IN FRAME {&FRAME-NAME} NO-ERROR.
  RUN d-seleccionar_contrato.w     ( INPUT "Contratos Activos" ,
                                     INPUT cliente.cdg_cliente,
                                     INPUT-OUTPUT rid_contrato).
  IF rid_contrato <> ?
  THEN DO:
      FIND contrato_hd WHERE ROWID(contrato_hd) = rid_contrato NO-LOCK.
      DISPLAY contrato_hd.nro_contrato @ t-fac_header.nro_contrato
              WITH FRAME {&FRAME-NAME}.
      APPLY "RETURN" TO SELF IN FRAME {&FRAME-NAME}.

  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Fac_header.tip_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Fac_header.tip_comprob C-Win
ON MOUSE-SELECT-DBLCLICK OF T-Fac_header.tip_comprob IN FRAME DEFAULT-FRAME /* Tipo */
OR MOUSE-MENU-DOWN,"." OF T-Fac_header.tip_comprob IN FRAME {&FRAME-NAME}
DO:
  APPLY "MOUSE-SELECT-DBLCLICK" TO T-Fac_header.nro_comprob IN FRAME {&FRAME-NAME}.
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

   IF NOT CAN-DO(Articulo.lista_empresas,Empresa.cdg_empresa)
   THEN DO:
         RUN PONMENSJ.P ( INPUT "ARTI017" ).
         RETURN NO-APPLY.
   END.

   FIND Familia_articulo OF Articulo NO-LOCK.
   FIND FIRST Familia_cuenta 
       WHERE Familia_cuenta.cdg_imputacion = T-Fac_header.cdg_imputacion
         AND Familia_cuenta.nro_familia    = Familia_articulo.nro_familia
         AND Familia_cuenta.cdg_empresa    = T-Fac_header.cdg_empresa
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
    &SCOPED-DEFINE PONER-TABLA RUN poner_cliente.          
    {traducetabla.i "cliente" "cdg_cliente" "nom_cliente"}
    &UNDEFINE PONER-TABLA                                  

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_condicion_impos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_condicion_impos C-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_condicion_impos IN FRAME DEFAULT-FRAME /* C.Impos. */
OR "." OF v-cdg_condicion_impos IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_condicion_impos IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "condicion_impos" "cdg_condiva" "SELCNDIV-v.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_condicion_impos C-Win
ON RETURN OF v-cdg_condicion_impos IN FRAME DEFAULT-FRAME /* C.Impos. */
DO:
   &SCOPED-DEFINE PONER-TABLA RUN asignar_condicion_impos.
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
    DEFINE QUERY qdom FOR domicilio FIELDS ().
    OPEN QUERY qdom FOR EACH domicilio OF cliente NO-LOCK.
    FIND Domicilio OF Cliente WHERE Domicilio.nro_domicilio = INPUT FRAME {&FRAME-NAME} v-cdg_domicilio NO-ERROR.
  IF AVAILABLE Domicilio
  THEN DO:
      FIND Provincia OF Domicilio NO-LOCK.
      ASSIGN  T-Fac_header.nro_domicilio = Domicilio.nro_domicilio
              T-Fac_header.direccion     = Domicilio.direccion
              T-Fac_header.cdg_provincia = Domicilio.cdg_provincia
              T-Fac_header.localidad     = Domicilio.localidad
              T-Fac_header.cdg_postal    = Domicilio.cdg_postal
              T-Fac_header.cdg_zonag     = Domicilio.cdg_zonag
              v-cdg_domicilio            = Domicilio.nro_domicilio
              v-dsc_domicilio            = IF NUM-RESULTS("qdom") > 1 THEN Domicilio.nombre ELSE Domicilio.direccion
              v-abv_provincia            = Provincia.nombre.
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
   &SCOPED-DEFINE PONER-TABLA RUN poner_vendedor.
   {traducetabla.i "Vendedor" "cdg_vendedor" "nombre"} 
   &UNDEFINE PONER-TABLA
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-nro_remito
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-nro_remito C-Win
ON MOUSE-MENU-DOWN OF v-nro_remito IN FRAME DEFAULT-FRAME
DO:
  DEFINE VARIABLE rid_remito AS ROWID.
  FIND FIRST Relacion_comprobante 
                 WHERE Relacion_comprobante.cdg_comprobdestino = t-fac_header.cdg_comprobante
                   AND Relacion_comprobante.cdg_empresa       = t-fac_header.cdg_empresa
                       NO-LOCK NO-ERROR.
            
  RUN d-seleccionar_compdespacho.w ( INPUT "Remitos pendientes de facturar" ,
                                     INPUT "E",
                                     INPUT (IF AVAILABLE Relacion_comprobante THEN Relacion_comprobante.cdg_comproborigen ELSE ? ),
                                     INPUT-OUTPUT rid_remito).
  IF rid_remito <> ?
  THEN DO:
      
      FIND Rem_header WHERE ROWID(Rem_header) = rid_remito NO-LOCK.
      DISPLAY Rem_header.tip_comprob @ v-tip_remito
              Rem_header.prf_comprob @ v-prf_remito
              Rem_header.nro_comprob @ v-nro_remito
              WITH FRAME {&FRAME-NAME}.
      APPLY "RETURN" TO v-nro_remito IN FRAME {&FRAME-NAME}.

  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-nro_remito C-Win
ON RETURN OF v-nro_remito IN FRAME DEFAULT-FRAME
DO:
    FIND Rem_header 
        WHERE Rem_header.cdg_empresa = T-Fac_header.cdg_empresa
          AND Rem_header.tip_comprob = v-tip_remito:INPUT-VALUE IN FRAME {&FRAME-NAME} 
          AND Rem_header.prf_comprob = v-prf_remito:INPUT-VALUE IN FRAME {&FRAME-NAME} 
          AND Rem_header.nro_comprob = v-nro_remito:INPUT-VALUE IN FRAME {&FRAME-NAME}
              NO-LOCK NO-ERROR.

    IF AVAILABLE Rem_header
    THEN DO:
        IF Rem_header.estado = "E"
        THEN DO:
            FIND FIRST Relacion_comprobante 
                 WHERE Relacion_comprobante.cdg_comproborigen = Rem_header.cdg_comprobante
                   AND Relacion_comprobante.cdg_empresa       = Rem_header.cdg_empresa
                       NO-LOCK NO-ERROR.
            
            IF AVAILABLE Relacion_comprobante 
            THEN DO:
                IF T-Fac_header.cdg_comprobante <> Relacion_comprobante.cdg_comprobdestino THEN DO:
                    RUN ponmensj.p (INPUT "fact038").
                    RETURN NO-apply.
                END.
            END.
            ELSE DO:
                 MESSAGE "No se encuentra el comprobante de destino para el origen " Tipocomprobante.cdg_comprobante
                         "Empresa" T-Fac_header.cdg_empresa 
                     VIEW-AS ALERT-BOX ERROR TITLE "ERROR DE IMPLEMENTACION:FACTURAR_REMITOS.P".
            END.

            RUN copiar_comprobante_despacho.p ( 
                INPUT ROWID(Rem_header),
                INPUT-OUTPUT TABLE T-Fac_header,
                INPUT-OUTPUT TABLE T-Fac_detalle,
                INPUT-OUTPUT TABLE T-Registrable-factura,
                INPUT-OUTPUT TABLE T-Fac_header-bon,
                INPUT-OUTPUT TABLE T-Fac_detalle-bon,
                INPUT-OUTPUT TABLE T-Fac_header_impuesto,
                INPUT-OUTPUT TABLE T-Fac_detalle_impuesto).
        
            FIND FIRST T-Fac_header.
        
            RUN traer_tablas.
        
            DISPLAY T-Fac_header.ano 
                    T-Fac_header.cambio 
                    T-Fac_header.fecha 
                    T-Fac_header.fecha_iva 
                    T-Fac_header.fecha_ocm 
                    T-Fac_header.nro_ocm
                    T-Fac_header.imp_neto 
                    T-Fac_header.imp_total 
                    T-Fac_header.leyenda_cc 
                    T-Fac_header.mes 
                    T-Fac_header.prc_canje 
                    T-Fac_header.cta_cte
                    v-cdg_condicion_impos 
                    v-cdg_condicion_venta 
                    v-cdg_domicilio 
                    T-Fac_header.cdg_imputacion 
                    v-cdg_moneda 
                    v-cdg_cliente 
                    v-cdg_lista_precios 
                    v-cdg_deposito 
                    v-cdg_vendedor 
                    v-dsc_condicion_impos 
                    v-dsc_condicion_venta
                    v-dsc_domicilio 
                    v-abv_provincia
                    
                    v-dsc_moneda 
                    v-dsc_cliente 
                    v-dsc_lista_precios 
                    v-dsc_deposito 
                    v-dsc_vendedor 
                    v-cdg_administrador
                    v-dsc_administrador
                    v-anulado
                    WITH FRAME {&FRAME-NAME}.
        
            {&OPEN-QUERY-{&BROWSE-NAME}}
               
            RUN habilitar_campos ( INPUT YES ).
        
            RUN calculos.  
        END.
        ELSE DO:
            RUN ponmensj.p ( "REMI022" ).
            RETURN NO-APPLY.
        END.
    END.
    ELSE DO:
        RUN ponmensj.p ( "REMI025" ).
        RETURN NO-APPLY.
    END.

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
           IF NOT CAN-FIND(Punto-venta WHERE Punto-venta.cdg_empresa  = T-fac_header.cdg_empresa 
                                         AND Punto-venta.cdg_puntovta = INPUT FRAME {&FRAME-NAME} v-pto_venta)
           THEN DO:
                RUN ponmensj.p ( INPUT "PVTA001").
                DISPLAY v-pto_venta-org @ v-pto_venta
                        WITH FRAME {&FRAME-NAME}.
           END.
           ELSE DO:
                IF NOT CAN-FIND(FIRST Tipo_puntovta WHERE Tipo_puntovta.cdg_empresa  = T-fac_header.cdg_empresa 
                                                      AND Tipo_puntovta.cdg_puntovta = INPUT FRAME {&FRAME-NAME} v-pto_venta
                                                      AND Tipo_puntovta.cdg_comprobante = T-Fac_header.cdg_comprobante)
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE asignar_caja C-Win 
PROCEDURE asignar_caja :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    ASSIGN 
       Caj_header.nro_cuenta      = Cuenta.nro_cuenta
       Caj_header.nro_cliente     = T-Fac_header.nro_cliente
       Caj_header.cdg_empresa     = T-Fac_header.cdg_empresa
       Caj_header.prf_comprob     = T-Fac_header.prf_comprob
       Caj_header.tip_comprob     = T-Fac_header.tip_comprob
       Caj_header.importe         = T-Fac_header.imp_total.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE asignar_cambio C-Win 
PROCEDURE asignar_cambio :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE p-xx AS DATE . /* Por Compatibilidad */

  RUN cotizar_moneda.p ( INPUT  Moneda.cdg_moneda,
                         INPUT  T-Fac_header.cdg_empresa, 
                         INPUT  T-Fac_header.fecha,       
                         OUTPUT T-Fac_header.cambio,  
                         OUTPUT p-xx ).

  DISPLAY T-Fac_header.cambio WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE asignar_condicion_impos C-Win 
PROCEDURE asignar_condicion_impos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  RUN calculos.

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

   T-Fac_header.nro_cndventa = Condicion_venta.nro_cndventa.
   RUN calculos.

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
                         INPUT  T-Fac_header.cdg_empresa, 
                         INPUT  T-Fac_header.fecha,       
                         OUTPUT T-Fac_header.cambio_dolar,  
                         OUTPUT p-xx ).

  DISPLAY T-Fac_header.cambio_dolar WITH FRAME {&FRAME-NAME}.

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
     T-Fac_header.fecha = IF Punto-venta.modo_fecha = "T" THEN Punto-venta.fch_cierre + 1 ELSE TODAY.
     DISPLAY T-Fac_header.fecha
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

  ASSIGN
      T-Fac_header.cdg_imputacion = Imputacion.cdg_imputacion
      T-Fac_header.ibrutos_sino   = Imputacion.ibrutos_sino.

  RUN calculos.

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
   FIND Lista_precios WHERE Lista_precios.cdg_lista = v-cdg_lista_precios NO-LOCK NO-ERROR.
   IF NOT AVAILABLE lista_precios THEN RETURN.
   IF NOT CAN-DO(Lista_precios.lista_empresas,T-Fac_header.cdg_empresa)
   THEN DO:
         RUN PONMENSJ.P ( INPUT "ARTI017" ).
         no_aplicar = YES.
         RETURN ERROR.
   END.

   T-Fac_header.fecha_precios = T-Fac_header.fecha.
   T-Fac_header.cdg_lista =  v-cdg_lista_precios.
   FOR EACH T-Fac_detalle OF T-Fac_header EXCLUSIVE-LOCK, FIRST Articulo OF T-Fac_detalle WHERE Articulo.stock_sino:

        CASE Articulo.modo_volumen:
             WHEN ""  /* No hay descuentos por volumen */
             THEN DO: 
                  FIND LAST Articulo_precio OF Articulo 
                       WHERE Articulo_precio.cdg_lista = Lista_precio.cdg_lista 
                         AND Articulo_precio.cdg_empresa = T-Fac_header.cdg_empresa
                         AND Articulo_precio.fch_desde <= T-Fac_header.fecha_precios
                             NO-LOCK NO-ERROR. 
                  IF AVAILABLE Articulo_precio 
                  THEN DO:
                       T-Fac_detalle.precio    = Articulo_precio.precio.
                       T-Fac_detalle.precio_cf = Articulo_precio.precio_cf.
                  END.
                  ELSE DO:
                       T-Fac_detalle.precio    = ?.
                       T-Fac_detalle.precio_cf = ?.
                  END.
             END.                                  
    
             WHEN "D"  /* Descuentos directos en base a cantidad */
             THEN DO: 
                  FIND FIRST Articulo_precio OF Articulo 
                       WHERE Articulo_precio.cdg_lista = Lista_precio.cdg_lista 
                         AND Articulo_precio.cdg_empresa = T-Fac_header.cdg_empresa
                         AND Articulo_precio.desde_cantidad <= T-Fac_detalle.cantidad
                         AND Articulo_precio.hasta_cantidad >= T-Fac_detalle.cantidad
                         AND Articulo_precio.fch_desde <= T-Fac_header.fecha_precios
                             NO-LOCK NO-ERROR. 
                  IF AVAILABLE Articulo_precio 
                  THEN DO:
                       T-Fac_detalle.precio    = Articulo_precio.precio.
                       T-Fac_detalle.precio_cf = Articulo_precio.precio_cf.
                  END.
                  ELSE DO:
                       T-Fac_detalle.precio    = ?.
                       T-Fac_detalle.precio_cf = ?.
                  END.
             END.                                  
    
             WHEN "E"  /* Descuentos escalados en base a cantidad */
             THEN DO: 
                    /*
                  subtotal_item = 0.
                  remanente_cantidad = T-Fac_detalle.cantidad.
    
                  FOR EACH Articulo_precio OF Articulo 
                       WHERE Articulo_precio.cdg_lista = Lista_precio.cdg_lista 
                         AND Articulo_precio.cdg_empresa = T-Fac_header.cdg_empresa
                         BY Articulo-precio.desde_cantidad
                             NO-LOCK NO-ERROR: 
    
                      T-Fac_detalle.cantidad
    
    
                  IF AVAILABLE Articulo_precio 
                  THEN DO:
                       T-Fac_detalle.precio    = Articulo_precio.precio.
                       T-Fac_detalle.precio_cf = Articulo_precio.precio_cf.
                  END.
                  ELSE DO:
                       T-Fac_detalle.precio    = ?.
                       T-Fac_detalle.precio_cf = ?.
                  END.
                  */
                            T-Fac_detalle.precio = ?. /* Sacar */
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

  T-Fac_header.nro_moneda = Moneda.nro_moneda.
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

   EMPTY TEMP-TABLE T-Fac_header.
   EMPTY TEMP-TABLE T-Fac_detalle.
   EMPTY TEMP-TABLE T-Fac_header-bon.
   EMPTY TEMP-TABLE T-Fac_detalle-bon.
   EMPTY TEMP-TABLE T-Sub_detalle_vta.
   EMPTY TEMP-TABLE T-Sub_header_vta.
   EMPTY TEMP-TABLE T-Fac_header_impuesto.
   EMPTY TEMP-TABLE T-Fac_detalle_impuesto.
       
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

  RUN calcular_comprobante_cliente.p ( 
                           INPUT-OUTPUT TABLE T-Fac_header,
                           INPUT-OUTPUT TABLE T-Fac_detalle,
                           INPUT-OUTPUT TABLE T-Sub_header_vta,
                           INPUT-OUTPUT TABLE T-Sub_detalle_vta,
                           INPUT-OUTPUT TABLE T-Fac_header-bon,
                           INPUT-OUTPUT TABLE T-Fac_detalle-bon,
                           INPUT-OUTPUT TABLE T-Fac_header_impuesto,
                           INPUT-OUTPUT TABLE T-Fac_detalle_impuesto).
                         
  FIND FIRST T-Fac_header.

  DISPLAY T-Fac_header.imp_neto 
          T-Fac_header.imp_total
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
    
        FIND Tipocomprobante 
            WHERE Tipocomprobante.cdg_empresa     = que_empresa
              AND Tipocomprobante.cdg_comprobante = "FACTUCLI" NO-LOCK NO-ERROR.

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

/* T-Fac_header.cdg_imputacion:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = "". */
   
   {findempresa.i}
   x-listas = "".
   x-primero = ?.
   FOR EACH Comprobante_concepto OF Tipocomprobante
       WHERE Comprobante_concepto.cdg_empresa = Empresa.cdg_empresa, Imputacion OF Comprobante_concepto:
       x-listas = x-listas + "," + Imputacion.dsc_imputacion + "," + STRING(Imputacion.cdg_imputacion).
       IF x-primero = ? THEN x-primero = Imputacion.cdg_imputacion.
        /*lOK = T-Fac_header.cdg_imputacion:ADD-LAST(Imputacion.dsc_imputacion,Imputacion.cdg_imputacion) IN FRAME {&FRAME-NAME}.*/
   END.
   IF x-listas <> ""
   THEN DO:
       x-listas = SUBSTRING(x-listas,2).
       T-Fac_header.cdg_imputacion:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = x-listas.
   END.
   ELSE DO:
       MESSAGE "No se han definido conceptos para el comprobante actual" VIEW-AS ALERT-BOX ERROR TITLE "ERROR DE IMPLEMENTACIÓN".
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

     RUN detalle_factura.p ( INPUT-OUTPUT TABLE T-Fac_header,
                             INPUT-OUTPUT TABLE T-Fac_detalle,
                             INPUT-OUTPUT TABLE T-Fac_detalle-bon,        
                             INPUT T-Fac_detalle.nro_articulo,
                             INPUT T-Fac_detalle.nro_linea,
                             INPUT modo,
                             INPUT 1,
                             OUTPUT v-nro_linea).

    FIND FIRST T-Fac_header.
    IF v-nro_linea <> 0
    THEN DO:
         RUN calculos.
         {&OPEN-QUERY-{&BROWSE-NAME}}
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE crear_caja C-Win 
PROCEDURE crear_caja :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   CREATE Caj_header.
   ASSIGN 
          Caj_header.fecha             = TODAY
          Caj_header.hora              = TIME
          Caj_header.nro_cliente       = T-Fac_header.nro_cliente
          Caj_header.cdg_empresa       = T-Fac_header.cdg_empresa
          Caj_header.tip_comprob       = T-Fac_header.tip_comprob
          Caj_header.nro_comprob       = T-Fac_header.nro_comprob
          Caj_header.ultima_linea      = 0
          Caj_header.nro_transaccion   = NEXT-VALUE(proxima_txncaja)
          Caj_header.importe           = T-Fac_header.imp_total
          Caj_header.emitir            = NO
          Caj_header.cdg_caja          = Caja.cdg_caja
          Caj_header.nro_cuenta        = Cuenta.nro_cuenta
          Caj_header.nro_cliente       = Cliente.nro_cliente
          Caj_header.observacion       = STRING(Cliente.cdg_cliente,"99999") + 
                                         "-" + Cliente.nom_cliente
          Caj_header.tipo_mov          = "I"
          T-Fac_header.nro_transaccion = Caj_header.nro_transaccion.

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
RUN detalle_factura.p ( INPUT-OUTPUT TABLE T-Fac_header,
                            INPUT-OUTPUT TABLE T-Fac_detalle,
                            INPUT-OUTPUT TABLE T-Fac_detalle-bon,        
                            INPUT  Articulo.nro_articulo,
                            INPUT  0, /* No sabemos el nro de linea */
                            INPUT  modo,
                            INPUT  0, /* modo detalle = CREAR */
                            OUTPUT v-nro_linea).

    IF v-nro_linea <> 0
    THEN DO:
        RUN calculos.
        {&OPEN-QUERY-{&BROWSE-NAME}}
        T-Fac_header.cdg_imputacion:SENSITIVE IN FRAME {&FRAME-NAME}  = NO.         
        btn_copiar:SENSITIVE IN FRAME {&FRAME-NAME}        = NO.
        btn_verimputacion:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
    END.
    ELSE DO:
        FIND FIRST T-Fac_header.
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
      FIND Punto-venta WHERE Punto-venta.cdg_puntovta = v-pto_venta 
                         AND Punto-venta.cdg_empresa  = Empresa.cdg_empresa
                             NO-LOCK.

      CREATE T-Fac_header.
      ASSIGN T-Fac_header.cdg_comprobante = Tipocomprobante.cdg_comprobante 
             T-Fac_header.nro_usuario     = Usuario.nro_usuario 
             T-Fac_header.cdg_empresa     = Empresa.cdg_empresa
             T-Fac_header.fecha           = IF Punto-venta.modo_fecha = "T" THEN Punto-venta.fch_cierre + 1 ELSE TODAY
             T-Fac_header.fecha_iva       = T-Fac_header.fecha 
             T-Fac_header.fecha_precios   = T-Fac_header.fecha 
             T-Fac_header.mes             = MONTH(T-Fac_header.fecha) 
             T-Fac_header.ano             = YEAR(T-Fac_header.fecha)
             T-Fac_header.cdg_empresa     = Empresa.cdg_empresa 
             T-Fac_header.nro_deposito    = Deposito.nro_deposito 
             T-Fac_header.tip_comprob     = ""                  
             T-Fac_header.nro_factura     = 0  
             T-Fac_header.estado          = "E"  
             T-Fac_header.nro_comprob     = T-Fac_header.nro_factura
             T-Fac_header.prf_comprob     = v-pto_venta
             T-Fac_header.nro_moneda      = Moneda.nro_moneda 
             T-Fac_header.cambio          = Moneda.cambio  
             T-Fac_header.cdg_imputacion  = x-primero
             T-Fac_header.cta_cte         = YES /*Imputacion.cta_cte */
             T-Fac_header.num_sucursal    = sucursal-id    
             T-Fac_header.origen          = "M"
             T-Fac_header.leyenda         = v-leyenda
             v-cdg_moneda                 = Moneda.cdg_moneda 
             v-dsc_moneda                 = Moneda.descripcion
             v-cdg_deposito               = Deposito.cdg_deposito
             v-dsc_deposito               = Deposito.nombre. 

             RUN asignar_cambio.

  END.

  DISPLAY
         T-Fac_header.fecha   
         T-Fac_header.fecha_iva   
         T-Fac_header.mes      
         T-Fac_header.ano
         T-Fac_header.cambio  
         T-Fac_header.cdg_imputacion
         v-cdg_moneda
         v-dsc_moneda      
         v-cdg_deposito
         v-dsc_deposito 
         v-pto_venta
         v-comprobante
         v-cdg_administrador
         v-dsc_administrador
         WITH FRAME {&FRAME-NAME}.
                                       
  codigo_salir = ?.

  IF    modo = MD_MULTIPLE
     OR modo = MD_ANULACION
     OR modo = MD_EMISION
  THEN DO:
       DO WITH FRAME {&FRAME-NAME}:
          T-Fac_header.tip_comprob:FGCOLOR = 9.
          T-Fac_header.tip_comprob:BGCOLOR = 15.

          v-pto_venta:FGCOLOR = 9.
          v-pto_venta:BGCOLOR = 15.

          T-Fac_header.nro_comprob:FGCOLOR = 9.
          T-Fac_header.nro_comprob:BGCOLOR = 15.
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
  DISPLAY v-pto_venta v-comprobante v-anulado v-cdg_cliente v-dsc_cliente 
          v-cdg_domicilio v-dsc_domicilio v-abv_provincia v-cdg_condicion_impos 
          v-dsc_condicion_impos v-cdg_moneda v-dsc_moneda v-cdg_condicion_venta 
          v-dsc_condicion_venta v-tip_remito v-prf_remito v-nro_remito 
          v-cdg_deposito v-dsc_deposito v-cdg_vendedor v-dsc_vendedor 
          v-cdg_lista_precios v-dsc_lista_precios v-cdg_administrador 
          v-dsc_administrador vfactu_admin v-cdg_articulo 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE T-Fac_header THEN 
    DISPLAY T-Fac_header.tip_comprob T-Fac_header.nro_comprob T-Fac_header.fecha 
          T-Fac_header.cta_cte T-Fac_header.fecha_iva T-Fac_header.mes 
          T-Fac_header.ano T-Fac_header.fecha_ocm T-Fac_header.nro_ocm 
          T-Fac_header.clausula_dolar T-Fac_header.cambio 
          T-Fac_header.cambio_dolar T-Fac_header.prc_canje 
          T-Fac_header.cdg_imputacion T-Fac_header.nro_contrato 
          T-Fac_header.leyenda_cc T-Fac_header.imp_neto T-Fac_header.imp_total 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE RECT-2 RECT-3 RECT-4 Btn_salir T-Fac_header.tip_comprob 
         T-Fac_header.nro_comprob T-Fac_header.fecha T-Fac_header.mes 
         T-Fac_header.ano T-Fac_header.clausula_dolar T-Fac_header.cambio_dolar 
         b-verrem T-Fac_header.cdg_imputacion bVer vfactu_admin 
         T-Fac_header.nro_contrato T-Fac_header.leyenda_cc 
         T-Fac_header.imp_total BROWSE-1 
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
                btn_observ:SENSITIVE                      = NO
                btn_observ:SENSITIVE                      = NO
                btn_imprim:SENSITIVE                      = NO
                btn_contador:SENSITIVE                    = NO
                T-Fac_header.tip_comprob:SENSITIVE        = NO
                v-pto_venta:SENSITIVE                     = NO          
                T-Fac_header.nro_comprob:SENSITIVE        = NO
                T-Fac_header.fecha:SENSITIVE              = NO
                T-Fac_header.ano:SENSITIVE                = NO
                T-Fac_header.cambio:SENSITIVE             = NO
                T-Fac_header.leyenda_cc:SENSITIVE         = NO
                T-Fac_header.mes:SENSITIVE                = NO
                T-Fac_header.cta_cte:SENSITIVE            = NO
                v-cdg_articulo:SENSITIVE                  = NO
                v-cdg_condicion_impos:SENSITIVE           = NO
                v-cdg_domicilio:SENSITIVE                 = NO
                T-Fac_header.nro_contrato:SENSITIVE       = NO
                T-Fac_header.cdg_imputacion:SENSITIVE     = NO
                v-cdg_moneda:SENSITIVE                    = NO
                v-cdg_cliente:SENSITIVE                   = NO
                v-cdg_vendedor:SENSITIVE                  = NO
                v-cdg_deposito:SENSITIVE                  = NO
                v-cdg_lista_precios:SENSITIVE             = NO
                btn_porclasificacion:SENSITIVE            = NO
                btn_verimputacion:SENSITIVE               = NO
                btn_verbonificaciones:SENSITIVE           = NO
                fecha_iva:SENSITIVE                       = NO
                v-cdg_administrador:SENSITIVE             = NO
                bVer:SENSITIVE                            = NO.
     END.
     ELSE DO:
            CASE modo:
       
                WHEN MD_ALTA          
                THEN DO:
                     ASSIGN
                        v-cdg_cliente:SENSITIVE                 = YES
                  /*      v-pto_venta:SENSITIVE                   = YES*/
                        v-tip_remito:SENSITIVE                  = YES
                        v-prf_remito:SENSITIVE                  = YES
                        v-nro_remito:SENSITIVE                  = YES.
         
                END.
                WHEN MD_MULTIPLE      
                THEN DO:
                     ASSIGN
                        T-Fac_header.tip_comprob:SENSITIVE        = YES
                        v-pto_venta:SENSITIVE                     = YES
                        T-Fac_header.nro_comprob:SENSITIVE        = YES.

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
                        T-Fac_header.tip_comprob:SENSITIVE        = YES
                        T-Fac_header.nro_comprob:SENSITIVE        = YES
                        btn_verbonificaciones:SENSITIVE           = YES
                        v-pto_venta:SENSITIVE                     = NO.
                END.
                WHEN MD_EMISION        
                THEN DO:
                     ASSIGN
                        T-Fac_header.tip_comprob:SENSITIVE        = YES
                        T-Fac_header.nro_comprob:SENSITIVE        = YES
                        btn_verbonificaciones:SENSITIVE           = YES
                        v-pto_venta:SENSITIVE                     = NO.
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
       ASSIGN FRAME {&FRAME-NAME} v-pto_venta.
       T-Fac_header.prf_comprob = v-pto_venta.
       t-fac_header.nro_administrador = administrador.nro_cliente.
       t-fac_header.cdg_administrador = administrador.cdg_cliente.
       t-Fac_header.direccion_administrador = administrador.direccion.
       t-Fac_header.nom_Administrador = administrador.nom_cliente.
       t-fac_header.mostrar_admin = administrador.mostrar_admin.

       RUN emitir_comprobante_cliente.p ( 
                                 INPUT-OUTPUT TABLE T-Fac_header,
                                 INPUT-OUTPUT TABLE T-Fac_detalle,
                                 INPUT-OUTPUT TABLE T-Registrable-factura,
                                 INPUT-OUTPUT TABLE T-Sub_header_vta,
                                 INPUT-OUTPUT TABLE T-Sub_detalle_vta,
                                 INPUT-OUTPUT TABLE T-Fac_header-bon,
                                 INPUT-OUTPUT TABLE T-Fac_detalle-bon,
                                 INPUT-OUTPUT TABLE T-Fac_header_impuesto,
                                 INPUT-OUTPUT TABLE T-Fac_detalle_impuesto).
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
          btn_observ:SENSITIVE                      = NO
          btn_leyenda:SENSITIVE                     = NO
          btn_imprim:SENSITIVE                      = NO
          T-Fac_header.tip_comprob:SENSITIVE        = NO
          v-pto_venta:SENSITIVE                     = NO
          T-Fac_header.nro_comprob:SENSITIVE        = NO
          T-Fac_header.fecha:SENSITIVE              = NO
          T-Fac_header.fecha_ocm:SENSITIVE          = NO
          T-Fac_header.nro_ocm:SENSITIVE            = NO
          T-Fac_header.prc_canje:SENSITIVE          = NO
          T-Fac_header.ano:SENSITIVE                = NO
          T-Fac_header.cambio:SENSITIVE             = NO
          T-Fac_header.leyenda_cc:SENSITIVE         = NO
          T-Fac_header.mes:SENSITIVE                = NO
          T-Fac_header.cta_cte:SENSITIVE            = NO
          T-Fac_header.clausula_dolar:SENSITIVE     = NO
          T-Fac_header.cambio_dolar:SENSITIVE       = NO
          v-cdg_articulo:SENSITIVE                  = NO
          v-cdg_condicion_impos:SENSITIVE           = NO
          v-cdg_domicilio:SENSITIVE                 = NO
          T-Fac_header.nro_contrato:SENSITIVE       = NO
          T-Fac_header.cdg_imputacion:SENSITIVE     = NO
          v-cdg_moneda:SENSITIVE                    = NO
          v-cdg_cliente:SENSITIVE                   = NO
          v-cdg_vendedor:SENSITIVE                  = NO
          v-cdg_deposito:SENSITIVE                  = NO
          v-cdg_lista_precios:SENSITIVE             = NO
          btn_contador:SENSITIVE                    = NO
          btn_nominar:SENSITIVE                     = NO
          btn_verbonificaciones:SENSITIVE           = NO
          btn_porclasificacion:SENSITIVE            = NO
          v-cdg_administrador:SENSITIVE             = NO
          bVer:SENSITIVE                            = NO.

     CASE modo:

       WHEN MD_ALTA          
       THEN DO:
           ASSIGN
               v-pto_venta:SENSITIVE                     = YES
               btn_grabar:SENSITIVE                      = YES
               btn_copiar:SENSITIVE                      = YES
               btn_cancel:SENSITIVE                      = YES
               btn_leyenda:SENSITIVE                     = YES
               btn_observ:SENSITIVE                      = YES
               btn_imprim:SENSITIVE                      = NO
               T-Fac_header.fecha:SENSITIVE              = YES
               T-Fac_header.ano:SENSITIVE                = YES
               T-Fac_header.cambio:SENSITIVE             = mod_cambio
               T-Fac_header.leyenda_cc:SENSITIVE         = YES
               T-Fac_header.mes:SENSITIVE                = YES
               T-Fac_header.prc_canje:SENSITIVE          = hay_canje
               T-Fac_header.fecha_ocm:SENSITIVE          = YES
               T-Fac_header.nro_ocm:SENSITIVE            = YES
               T-Fac_header.cta_cte:SENSITIVE            = NO /*Cliente.tiene_ctacte*/
               T-Fac_header.clausula_dolar:SENSITIVE     = YES
               T-Fac_header.cambio_dolar:SENSITIVE       = T-Fac_header.clausula_dolar
               v-cdg_articulo:SENSITIVE                  = YES
               v-cdg_condicion_impos:SENSITIVE           = YES
               v-cdg_condicion_venta:SENSITIVE           = YES
               v-cdg_domicilio:SENSITIVE                 = YES
               T-Fac_header.nro_contrato:SENSITIVE       = YES
               T-Fac_header.cdg_imputacion:SENSITIVE     = YES
               v-cdg_moneda:SENSITIVE                    = NO
               v-cdg_cliente:SENSITIVE                   = NO
               v-cdg_vendedor:SENSITIVE                  = YES
               v-cdg_lista_precios:SENSITIVE             = YES
               v-cdg_deposito:SENSITIVE                  = YES
               btn_porclasificacion:SENSITIVE            = YES
               btn_nominar:SENSITIVE                     = Cliente.permite_nominar
               btn_verbonificaciones:SENSITIVE           = YES
               btn_verimputacion:SENSITIVE               = YES
               btn_contador:SENSITIVE                    = YES
               v-tip_remito:SENSITIVE                    = YES
               v-prf_remito:SENSITIVE                    = YES
               v-nro_remito:SENSITIVE                    = YES
               fecha_iva:SENSITIVE                       = YES
               v-cdg_administrador:SENSITIVE             = NO
               bVer:SENSITIVE                            = cliente.nro_administrador <> cliente.nro_cliente.
       END.
       WHEN MD_MULTIPLE      
       THEN DO:
           ASSIGN
                btn_cancel:SENSITIVE                      = YES
                btn_observ:SENSITIVE                      = YES
                btn_leyenda:SENSITIVE                     = YES
                btn_imprim:SENSITIVE                      = YES
                T-Fac_header.tip_comprob:SENSITIVE        = NO
                v-pto_venta:SENSITIVE                     = NO
                T-Fac_header.nro_comprob:SENSITIVE        = NO
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
                btn_leyenda:SENSITIVE                     = YES
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES
                btn_anular:SENSITIVE                      = YES
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

   RUN getparametro.p (  INPUT  "HABCANJE",
                          OUTPUT v-valor_c,
                          OUTPUT v-valor_d,
                          OUTPUT v-valor_l,
                          OUTPUT v-valor_n,
                          OUTPUT v-observacion ).
   IF v-valor_l = ? 
      THEN hay_canje = NO.
      ELSE hay_canje = v-valor_l.

   RUN getparametro.p (  INPUT  "LEYENFAA",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).
   v-leyenda = v-observacion.


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

   RUN getparametro.p (  INPUT  "DFNROCAJ",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).
 
   FIND Caja WHERE Caja.cdg_caja    = v-valor_n 
                  NO-LOCK.
   act_caja = ROWID(Caja).

   RUN getparametro.p (  INPUT  "CNDEUFAC",
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
   FIND Deposito WHERE Deposito.cdg_deposito = v-valor_c 
                       NO-LOCK.
   act_deposito = ROWID(Deposito).

   /*
   RUN getparametro.p (  INPUT  "DFCNVENT",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).

   FIND Imputacion WHERE Imputacion.cdg_imputacion = v-valor_n 
                         NO-LOCK.
   T-Fac_header.cdg_imputacion = Imputacion.cdg_imputacion.
   */
   /*
   FIND Impuesto WHERE Impuesto.cdg_impuesto = codigo_iva NO-LOCK.
   prciva = Impuesto.tasa.
   
   
   message 1 PROGRAM-NAME(1) SKIP 
           2 PROGRAM-NAME(2) SKIP
           3 PROGRAM-NAME(3) SKIP
           4 PROGRAM-NAME(4) SKIP
           5 PROGRAM-NAME(5) SKIP
           6 PROGRAM-NAME(6) SKIP
           VIEW-AS ALERT-BOX MESSAGE
           TITLE "c-factura_cliente:iniciar_documento".

   MESSAGE SUBSTRING(ENTRY(1,PROGRAM-NAME(3),"."),5) VIEW-AS ALERT-BOX.

*/

   RUN getparametro.p (  INPUT  "PEDMXLIN",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).
   IF v-valor_n <> ? THEN max_lidet = v-valor_n.

   RUN getparametro.p (  INPUT  "PEDMXLEY",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).
   IF v-valor_n <> ? THEN max_chley = v-valor_n.

   RUN titulo_window ( INPUT Tipocomprobante.titulo_window ).           

   
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_administrador C-Win 
PROCEDURE poner_administrador :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND administrador WHERE cliente.nro_administrador = administrador.nro_cliente NO-LOCK NO-ERROR.
IF AVAILABLE administrador THEN
    ASSIGN T-fac_header.localidad_administrador = administrador.localidad
           T-fac_header.direccion_adm = administrador.direccion
           T-fac_header.nom_administrador = administrador.nom_cliente.
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

  no_aplicar = NO.

  IF LOOKUP(que_sector, Cliente.lista_sectores) = 0
  THEN DO:
       v-dsc_cliente:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
       RUN PONMENSJ.P ( 'IREF002' ).
        no_aplicar = YES.
        RETURN ERROR.
  END.
  IF NOT cliente.permite_nominar THEN DO:
        IF cliente.cod_docu = ""  THEN DO:
            MESSAGE "El codigo de documento esta en blanco" VIEW-AS ALERT-BOX ERROR.
            RETURN NO-APPLY.
        END.
        IF cliente.cod_docu <> "NO"  THEN DO:
           run validar_cuit_param.p ( cliente.cuit,? ).
            if return-value <> "OK" THEN RETURN NO-APPLY.
        END.
  END.  
  IF NOT CAN-DO(Cliente.lista_empresas,Empresa.cdg_empresa)
  THEN DO:
        RUN PONMENSJ.P ( INPUT "CLIE050" ).
        no_aplicar = YES.
        RETURN ERROR.
  END.
  ELSE DO:
       IF LOOKUP(Cliente.cdg_estado,",A") = 0
       THEN DO:
             RUN PONMENSJ.P ( INPUT "CLIE051" ).
             no_aplicar = YES.
             RETURN ERROR.
       END.
       ELSE DO:
            FIND Condicion_venta WHERE Condicion_venta.cdg_cndventa = Cliente.dfl_cndventa NO-LOCK.
          
            FIND Familia_cliente OF Cliente NO-LOCK.
            FIND Cuenta OF Familia_cliente NO-LOCK.
            
            FIND Condicion_impos   OF Cliente NO-LOCK.
            
            FIND Vendedor OF Cliente NO-LOCK.
            FIND Obra WHERE Obra.cdg_obra = Vendedor.cdg_vendedor NO-LOCK NO-ERROR.
         
            RUN poner_administrador.
            ASSIGN
                T-Fac_header.cdg_condiva        = IF cliente.factu_admin THEN administrador.cdg_condiva ELSE Cliente.cdg_condiva
                T-Fac_header.cuit               = IF cliente.factu_admin THEN administrador.cuit ELSE Cliente.cuit
                T-Fac_header.cod_docu          = IF cliente.factu_admin THEN administrador.cod_docu ELSE Cliente.cod_docu
                T-Fac_header.direccion          = IF cliente.factu_admin THEN administrador.direccion ELSE cliente.direccion
                T-Fac_header.localidad          = IF cliente.factu_admin THEN administrador.localidad ELSE cliente.localidad
                T-Fac_header.cdg_lista          = IF cliente.factu_admin THEN administrador.dfl_lista ELSE cliente.dfl_lista
                T-Fac_header.cdg_condiva          = Condicion_impos.cdg_condiva
                T-Fac_header.nro_cndventa         = Condicion_venta.nro_cndventa
                T-Fac_header.prc_canje            = IF hay_canje THEN Cliente.prc_canje ELSE 0
                T-Fac_header.nombre               = Cliente.nom_cliente
                T-Fac_header.nro_cliente          = Cliente.nro_cliente
                T-Fac_header.nro_vendedor         = Cliente.nro_vendedor
                T-Fac_header.nro_entidad          = Cliente.nro_entidad
                T-Fac_header.cdg_provincia        = IF cliente.factu_admin THEN administrador.cdg_provincia ELSE Cliente.cdg_provincia
                T-Fac_header.cdg_provincia_leg    = IF cliente.factu_admin THEN administrador.cdg_provincia ELSE Cliente.cdg_provincia
                T-Fac_header.localidad_leg        = IF cliente.factu_admin THEN administrador.localidad ELSE Cliente.localidad
                T-Fac_header.cdg_postal_leg       = IF cliente.factu_admin THEN administrador.cdg_postal ELSE Cliente.cdg_postal
                T-Fac_header.clausula_dolar       = Cliente.clausula_dolar
                T-fac_header.nro_administrador    = cliente.nro_administrador.
                vfactu_admin:CHECKED = cliente.factu_admin.
            v-dsc_domicilio = t-fac_header.direccion.
            FIND provincia WHERE provincia.cdg_provincia = t-fac_header.cdg_provincia NO-ERROR.
            v-abv_provincia = sic.Provincia.nombre.

            IF AVAILABLE Obra 
                THEN T-Fac_header.nro_obra        = Obra.nro_obra.
            ASSIGN
                T-Fac_header.tip_comprob          = v-tip_comprob
                T-Fac_header.cta_cte              = Cliente.tiene_ctacte.

            ASSIGN   v-tip_remito:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "" 
                     v-prf_remito:SCREEN-VALUE IN FRAME {&FRAME-NAME} = ""
                     v-nro_remito:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".

          
            RUN traer_cliente.
            RUN traer_condicion_venta.
            RUN traer_condicion_impos.
            RUN traer_lista.
            RUN traer_vendedor.
            RUN traer_administrador.
          
            FOR EACH Cliente-bonificacion OF Cliente 
               WHERE Cliente-bonificacion.cdg_empresa = Empresa.cdg_empresa
                 AND Cliente-bonificacion.desde_fecha <= T-Fac_header.fecha 
                 AND Cliente-bonificacion.hasta_fecha >= T-Fac_header.fecha 
                    NO-LOCK:
              
                 CREATE T-Fac_header-bon.
                 ASSIGN T-Fac_header-bon.cdg_bonificacion = Cliente-bonificacion.cdg_bonificacion
                        T-Fac_header-bon.importe          = 0
                        T-Fac_header-bon.nro_factura      = T-Fac_header.nro_factura
                        T-Fac_header-bon.porcentaje       = Cliente-bonificacion.porcentaje.
            END.

            IF T-Fac_header.clausula_dolar
                THEN RUN asignar_dolar.


            IF CAN-FIND(FIRST Tipo_puntovta 
                        WHERE Tipo_puntovta.cdg_comprobante = T-Fac_header.cdg_comprobante
                          AND Tipo_puntovta.cdg_puntovta = Cliente.dfl_cdg_puntovta)
            THEN DO:
                v-pto_venta = Cliente.dfl_cdg_puntovta.
                RUN asignar_fecha_puntovta.
            END.

            DISPLAY  v-cdg_cliente 
                     v-dsc_cliente
          
                     v-cdg_condicion_venta
                     v-dsc_condicion_venta
          
                     T-Fac_header.cdg_imputacion
                     
                     v-cdg_condicion_impos
                     v-dsc_condicion_impos
          
                     v-cdg_lista_precios
                     v-dsc_lista_precios
          
                     v-cdg_vendedor
                     v-dsc_vendedor
          
                     v-cdg_deposito
                     v-dsc_deposito
          
                     T-Fac_header.prc_canje WHEN hay_canje
                     T-Fac_header.tip_comprob
                     T-Fac_header.cta_cte
                     T-Fac_header.clausula_dolar
                     T-Fac_header.cambio_dolar

                     v-cdg_administrador
                     v-dsc_administrador

                     WITH FRAME {&FRAME-NAME}.
                     
          
             FIND FIRST Domicilio OF Cliente NO-LOCK NO-ERROR.
             IF AVAILABLE Domicilio 
             THEN DO:
                FIND Provincia OF Domicilio NO-LOCK.
                IF NOT cliente.factu_admin THEN 
                ASSIGN  T-Fac_header.nro_domicilio = Domicilio.nro_domicilio
                        T-Fac_header.direccion     = Domicilio.direccion
                        T-Fac_header.cdg_provincia = Domicilio.cdg_provincia
                        T-Fac_header.localidad     = Domicilio.localidad
                        T-Fac_header.cdg_postal    = Domicilio.cdg_postal
                        T-Fac_header.cdg_zonag     = Domicilio.cdg_zonag
                        v-cdg_domicilio            = Domicilio.nro_domicilio
                        v-dsc_domicilio            = Domicilio.direccion
                        v-abv_provincia            = Provincia.nombre.
                DISABLE v-cdg_domicilio 
                        v-dsc_domicilio
                        WITH FRAME {&FRAME-NAME}. 
             END.
             ELSE DO:  /* No hay ninguno o hay mas de uno */
                ASSIGN  T-Fac_header.nro_domicilio = 0
                        T-Fac_header.direccion     = ""
                        T-Fac_header.cdg_provincia = ""
                        T-Fac_header.localidad     = ""
                        T-Fac_header.cdg_postal    = ""
                        T-Fac_header.cdg_zonag     = ""
                        v-cdg_domicilio            = 1
                        v-dsc_domicilio            = ""
                        v-abv_provincia            = ""
                        v-cdg_domicilio:SENSITIVE  = YES
                        T-Fac_header.nro_contrato:SENSITIVE = YES.
             END.   
          
             DISPLAY v-cdg_domicilio
                     v-dsc_domicilio
                     v-abv_provincia
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

             RUN habilitar_campos ( YES ).

       END.
   END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_vendedor C-Win 
PROCEDURE poner_vendedor :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND Obra WHERE Obra.cdg_obra = Vendedor.cdg_vendedor NO-LOCK.
    
    ASSIGN
        T-Fac_header.nro_obra             = Obra.nro_obra.

    FOR EACH T-Fac_detalle:
        T-Fac_detalle.nro_obra = T-Fac_header.nro_obra.
    END.    

    RUN calculos.

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

 {&WINDOW-NAME}:TITLE = "DYNASYS/FAC " + NRO_RELEASE + " - " + Usuario.cdg_empresa + " - " + v-txtitulo + " User:" + USERID("sic").

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

    FIND administrador WHERE T-Fac_header.nro_administrador = administrador.nro_cliente NO-LOCK NO-ERROR.
    IF AVAILABLE administrador THEN DO:
        ASSIGN v-cdg_administrador = administrador.cdg_cliente
               v-dsc_administrador = administrador.nom_cliente.
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

    FIND Cliente OF T-Fac_header NO-LOCK.
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

    FIND Condicion_impos  OF T-Fac_header NO-LOCK.
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

    FIND Condicion_venta  OF T-Fac_header NO-LOCK.
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

   FIND Fac_header WHERE ROWID(Fac_header) = rid_factura NO-LOCK.
   BUFFER-COPY Fac_header TO T-Fac_header.
   v-pto_venta = T-Fac_header.prf_comprob.
   FOR EACH Fac_detalle OF Fac_header:
       CREATE T-Fac_detalle.
       BUFFER-COPY Fac_detalle TO T-Fac_detalle.
   END.    

   FOR EACH Fac_header-bon  OF Fac_header:
       CREATE T-Fac_header-bon.
       BUFFER-COPY Fac_header-bon TO T-Fac_header-bon.
   END.
    
   FOR EACH Fac_detalle-bon  OF Fac_header:
       CREATE T-Fac_detalle-bon.
       BUFFER-COPY Fac_detalle-bon TO T-Fac_detalle-bon.
   END.

   FIND Sub_header_vta 
        WHERE Sub_header_vta.cdg_empresa = Fac_header.cdg_empresa
          AND Sub_header_vta.tip_comprob = Fac_header.tip_comprob
          AND Sub_header_vta.prf_comprob = Fac_header.prf_comprob
          AND Sub_header_vta.nro_comprob = Fac_header.nro_comprob
              NO-LOCK NO-ERROR.
   IF AVAILABLE Sub_header_vta
   THEN DO:
        CREATE T-Sub_header_vta.
        BUFFER-COPY Sub_header_vta TO T-Sub_header_vta.           
     
        FOR EACH Sub_detalle_vta 
             WHERE Sub_detalle_vta.cdg_empresa = Sub_header_vta.cdg_empresa
               AND Sub_detalle_vta.tip_comprob = Sub_header_vta.tip_comprob
               AND Sub_detalle_vta.prf_comprob = Sub_header_vta.prf_comprob
               AND Sub_detalle_vta.nro_comprob = Sub_header_vta.nro_comprob
                   NO-LOCK.
     
            CREATE T-Sub_detalle_vta.
            BUFFER-COPY Sub_detalle_vta TO T-Sub_detalle_vta.           
     
        END.
   END.
   
   v-anulado = IF Fac_header.anulado THEN "ANULADA" ELSE "".

   FIND Deposito OF T-Fac_header NO-ERROR.
   IF AVAILABLE Deposito THEN DO:
   v-cdg_deposito = Deposito.cdg_deposito.
   v-dsc_deposito = Deposito.nombre.
   END.

   RUN traer_tablas.
   DISPLAY
        T-Fac_header.ano 
        T-Fac_header.cambio 
        T-Fac_header.cambio_dolar
        T-Fac_header.clausula_dolar 
        T-Fac_header.fecha 
        T-Fac_header.fecha_iva 
        T-Fac_header.fecha_ocm 
        T-Fac_header.nro_ocm
        T-Fac_header.imp_neto 
        T-Fac_header.imp_total 
        T-Fac_header.leyenda_cc 
        T-Fac_header.mes 
        T-Fac_header.nro_comprob 
        T-Fac_header.prc_canje 
        T-Fac_header.nro_contrato
        v-pto_venta 
        T-Fac_header.tip_comprob 
        T-Fac_header.cta_cte
        v-cdg_condicion_impos 
        v-cdg_administrador
        v-dsc_administrador
        v-cdg_condicion_venta 
        v-cdg_domicilio 
        T-Fac_header.cdg_imputacion 
        v-cdg_moneda 
        v-cdg_cliente 
        v-cdg_lista_precios 
        v-cdg_deposito 
        v-cdg_vendedor 
        v-dsc_condicion_impos 
        v-dsc_condicion_venta
        v-dsc_domicilio 
        v-abv_provincia
        
        v-dsc_moneda 
        v-dsc_cliente 
        v-dsc_lista_precios 
        v-dsc_deposito 
        v-dsc_vendedor 
        v-anulado
        v-tip_remito WHEN v-tip_remito <> "" 
        v-prf_remito WHEN v-tip_remito <> "" 
        v-nro_remito WHEN v-tip_remito <> "" 
        WITH FRAME {&FRAME-NAME}.

   {&OPEN-QUERY-{&BROWSE-NAME}}
       
   RUN habilitar_campos ( INPUT YES ).
/*   RUN calculos. si se habilita reculcula la factura al traerla */


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
    DEFINE QUERY qdom FOR domicilio FIELDS ().
    FIND cliente OF t-fac_header.
    OPEN QUERY qdom FOR EACH domicilio OF cliente NO-LOCK.


    FIND Domicilio OF T-Fac_header NO-LOCK.
    FIND Provincia OF Domicilio NO-LOCK.
    ASSIGN
        v-cdg_domicilio = Domicilio.nro_domicilio
        v-dsc_domicilio = IF NUM-RESULTS("qdom") > 1 THEN Domicilio.nombre ELSE Domicilio.direccion
        v-abv_provincia = Provincia.nombre.
    
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

    FIND Imputacion       OF T-Fac_header NO-LOCK.
    ASSIGN
        T-Fac_header.cdg_imputacion      = Imputacion.cdg_imputacion.
    
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

    FIND Lista_precios  OF T-Fac_header NO-LOCK NO-ERROR.
    IF AVAILABLE lista_precios THEN
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

    FIND Moneda    OF T-Fac_header   NO-LOCK.
    ASSIGN
        v-cdg_moneda          = Moneda.cdg_moneda
        v-dsc_moneda          = Moneda.descripcion.
         
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_remito C-Win 
PROCEDURE traer_remito :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  FIND Rem_header WHERE Rem_header.nro_remito = Fac_header.nro_remito NO-LOCK NO-ERROR.
  IF AVAILABLE Rem_header
  THEN DO:
       ASSIGN
            v-tip_remito = Rem_header.tip_comprob 
            v-prf_remito = Rem_header.prf_comprob 
            v-nro_remito = Rem_header.nro_comprob. 
  END.
  ELSE DO:
       ASSIGN
            v-tip_remito = "" 
            v-prf_remito = ? 
            v-nro_remito = ?. 
  END.
  RELEASE Rem_header.

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
  RUN traer_imputacion.
  RUN traer_moneda.
  RUN traer_cliente.
  RUN traer_administrador.
  RUN traer_domicilio.
  RUN traer_lista.
  RUN traer_vendedor.
  RUN traer_remito.

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

    FIND Vendedor    OF T-Fac_header   NO-LOCK.
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
    DEFINE BUFFER btipocomprobante FOR tipocomprobante.
    DEFINE VAR afmaxv AS DECIMAL NO-UNDO.
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
    */

    /*
    {IFNOTEXS.I "Provincia" "cdg_provincia" "frm-documento" "T-Fac_header" "cdg_provincia " "FACT009"}
    */

    IF T-Fac_header.nombre = ""
    THEN DO:
       RUN PONMENSJ.P (INPUT "FACT027").
       RETURN.
    END.  
    IF   t-fac_header.cod_docu = "" THEN DO:
        MESSAGE "El tipo de documento esta en blanco" VIEW-AS ALERT-BOX ERROR.
        RETURN.
    END.
    IF  t-fac_header.cod_docu <> "NO"  THEN DO:
        run validar_cuit_param.p (input T-Fac_header.cuit,?).
        if return-value <> "OK" THEN RETURN.
    END.
    ELSE DO:
        /*ver si es electronica y respeta el maximo sin cuit*/
        FIND punto-venta WHERE Punto-venta.cdg_empresa = empresa.cdg_empresa
                           AND Punto-venta.cdg_puntovta = INPUT v-pto_venta NO-LOCK.
        IF sic.Punto-venta.impresor = "E" AND Punto-venta.TP = "E" THEN DO:
           RUN getparametro_d.p( "AFMAXV", OUTPUT afmaxv).
           IF t-fac_header.imp_total >= afmaxv THEN DO:
               MESSAGE "Debe identificar con documento al cliente supera el maximo de " afmaxv " permitido [AFMAXV]" VIEW-AS ALERT-BOX ERROR.
               RETURN.
           END.
        END.
    END.
 
  
    IF T-Fac_header.cambio = 0
    THEN DO:
       RUN PONMENSJ.P (INPUT "FACT029").
       RETURN.
    END.  
  
    IF NOT CAN-FIND(FIRST T-Fac_detalle OF T-Fac_header)
    THEN DO:
       RUN PONMENSJ.P (INPUT "FACT005").
       RETURN.
    END.
  
    /* Comentar lo siguiente si se necesita emitir un comprobante con precio en 0 */

/*     IF T-Fac_header.imp_total = 0        */
/*     THEN DO:                             */
/*        RUN PONMENSJ.P (INPUT "FACT007"). */
/*        RETURN.                           */
/*     END.                                 */

    /*
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
    ELSE DO:
       IF T-Fac_header.nro_domicilio <> Domicilio.nro_domicilio
       THEN DO:
           ASSIGN
               T-Fac_header.nro_domicilio = Domicilio.nro_domicilio
               T-Fac_header.direccion     = Domicilio.direccion
               T-Fac_header.cdg_provincia = Domicilio.cdg_provincia
               T-Fac_header.localidad     = Domicilio.localidad
               T-Fac_header.cdg_postal    = Domicilio.cdg_postal
               T-Fac_header.cdg_zonag     = Domicilio.cdg_zonag.
       END.
    END.
  
    FIND Punto-venta WHERE Punto-venta.cdg_empresa  = T-Fac_header.cdg_empresa
                       AND Punto-venta.cdg_puntovta = v-pto_venta
                           NO-LOCK NO-ERROR.
    IF NOT AVAILABLE Punto-venta
    THEN DO:
      RUN ponmensj.p ( INPUT "REMI063" ).
      RETURN ERROR.
    END.
    ELSE DO:
        IF T-Fac_header.fecha > TODAY
        THEN DO:
            RUN ponmensj.p ( INPUT "REMI065" ).
            RETURN ERROR.
        END.
        ELSE DO:
            IF T-Fac_header.fecha <= Punto-venta.fch_cierre
            THEN DO:
                RUN ponmensj.p ( INPUT "REMI062" ).
                RETURN ERROR.
            END.
            ELSE DO:
                T-Fac_header.tip_comprob = Tipocomprobante.tip_comprob.
                IF Tipocomprobante.usa_letra
                THEN DO:
                     T-Fac_header.tip_comprob = REPLACE(T-Fac_header.tip_comprob,"*",Condicion_impos.tipo_factura).
                END.
                /*ver que todos los comprobantes que impriman con el mismo contador no tengan fecha posterior*/
                FIND tipocomprobante OF t-fac_header NO-LOCK.
                FOR EACH btipocomprobante WHERE btipocomprobante.prefijo_contador = tipocomprobante.prefijo_contador :
                    IF CAN-FIND(FIRST Fac_header
                                      WHERE Fac_header.cdg_empresa = T-Fac_header.cdg_empresa
                                        AND Fac_header.tip_comprob = btipocomprobante.tip_comprob
                                        AND Fac_header.prf_comprob = v-pto_venta
                                        AND Fac_header.fecha > T-Fac_header.fecha)
                    THEN DO:
                        RUN ponmensj.p ( INPUT "REMI061" ).
                        RETURN ERROR.
                    END.
                END.
            END.
        END.
    END.
    
    IF max_lidet > 0 
    THEN DO:
        DEFINE VARIABLE kl AS INTEGER.
        kl = 0.
        FOR EACH T-Fac_detalle OF T-Fac_header:
            kl = kl + 1.
        END.
        IF kl > max_lidet
        THEN DO:
           RUN PONMENSJ.P (INPUT "FACT034").
           RETURN.
        END.

    END.

    IF max_chley > 0 
    THEN DO:
        IF LENGTH(T-Fac_header.leyenda) > max_chley
        THEN DO:
           RUN PONMENSJ.P (INPUT "FACT035").
           RETURN.
        END.

    END.

    /* Procede a contar los articulos para que no se pase del máximo permitido */

    hubo_error = NO.

    &SCOPED-DEFINE TABLA-MAESTRA  T-Fac_header

    {asignartabla.i "Cliente"           "nro_cliente"     "nro_cliente"      }
        ASSIGN T-Fac_header.codigo_cliente = Cliente.cdg_cliente.
    {asignartabla.i "Vendedor"          "nro_vendedor"    "nro_vendedor"     }
    {asignartabla.i "Deposito"          "nro_deposito"    "nro_deposito"     }
    {asignartabla.i "Lista_precios"     "cdg_lista"       "cdg_lista"        }
    {asignartabla.i "Condicion_impos"   "cdg_condiva"     "cdg_condiva"      }
        ASSIGN T-Fac_header.texto_iva = Condicion_impos.texto_iva.
    {asignartabla.i "Moneda"            "nro_moneda"      "nro_moneda"       }
    {asignartabla.i "Condicion_venta"   "nro_cndventa"    "nro_cndventa"     }
        ASSIGN T-Fac_header.texto_condicion_venta = Condicion_venta.descripcion.
    /*
    {asignartabla.i "Imputacion"        "cdg_imputacion"  "cdg_imputacion"   }
    */
    
    &UNDEFINE TABLA-MAESTRA


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

