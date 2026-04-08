&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win


/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Copias_pedido NO-UNDO LIKE Copias_pedido.
DEFINE TEMP-TABLE T-Ped_detalle NO-UNDO LIKE Ped_detalle.
DEFINE TEMP-TABLE T-Ped_detalle-bon NO-UNDO LIKE Ped_detalle-bon.
DEFINE TEMP-TABLE T-Ped_header NO-UNDO LIKE Ped_header.
DEFINE TEMP-TABLE T-Ped_header-bon NO-UNDO LIKE Ped_header-bon.
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
DEFINE VARIABLE                rid_pedido    AS ROWID.
DEFINE VARIABLE                modo           AS INTEGER.
DEFINE VARIABLE                p-cdg_comprobante  AS CHARACTER.
&ELSE
DEFINE INPUT-OUTPUT PARAMETER  rid_pedido    AS ROWID.
DEFINE INPUT        PARAMETER  modo           AS INTEGER.
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
DEFINE VARIABLE v-dfl_lineanegocio        LIKE Lineanegocio.cdg_lineanegocio.
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
DEFINE VARIABLE v-debug                   AS LOGICAL INITIAL NO.


DEFINE VARIABLE v-nombre_comprobante      AS CHARACTER.
DEFINE VARIABLE v-fgcolor_comprobante     AS INTEGER.
DEFINE VARIABLE v-bgcolor_comprobante     AS INTEGER.
DEFINE VARIABLE v-primera_letra           AS CHARACTER.
DEFINE VARIABLE v-prefijo_contador        AS CHARACTER.
DEFINE VARIABLE v-leyenda                 AS CHARACTER.

DEFINE VARIABLE cntrl_deuda               AS LOGICAL.
DEFINE VARIABLE saldo_cc                  AS DECIMAL.
DEFINE VARIABLE saldo_ccv                 AS DECIMAL.
DEFINE VARIABLE tot_valores               AS DECIMAL.
DEFINE VARIABLE tot_remitos               AS DECIMAL.
DEFINE VARIABLE tot_pedidos               AS DECIMAL.
DEFINE VARIABLE tot_credito               AS DECIMAL.
DEFINE VARIABLE dis_credito               AS DECIMAL.
DEFINE VARIABLE cant_rech                 AS INTEGER.
DEFINE VARIABLE max_lidet                 AS INTEGER.
DEFINE VARIABLE max_chley                 AS INTEGER.

DEFINE VARIABLE equiv_granel              LIKE Ped_detalle.granel.
DEFINE VARIABLE que_empresa               LIKE Empresa.cdg_empresa.
DEFINE VARIABLE x-primero                 LIKE T-Ped_header.cdg_imputacion.
DEFINE VAR proceso-ok AS LOGICAL. /* smh*/
DEFINE VARIABLE p-impuestos AS LOGICAL INITIAL YES.
DEFINE VARIABLE v-control_habilitado AS LOGICAL.

DEFINE BUFFER T-B-Ped_detalle FOR T-Ped_detalle.
DEFINE BUFFER Dolar FOR Moneda.

DEFINE TEMP-TABLE T-Ped_header_impuesto LIKE Ped_header_impuesto.
DEFINE TEMP-TABLE T-Ped_detalle_impuesto LIKE Ped_detalle_impuesto.


{findempresa.i}
que_empresa = Empresa.cdg_empresa.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME BROWSE-2

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Ped_detalle Articulo T-Ped_header

/* Definitions for BROWSE BROWSE-2                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-2 T-Ped_detalle.nro_linea ~
Articulo.cdg_articulo Articulo.descripcion Articulo.cdg_umed ~
T-Ped_detalle.cantidad_sol T-Ped_detalle.granel_sol T-Ped_detalle.precio ~
T-Ped_detalle.cdg_estado T-Ped_detalle.fecha_temprana ~
T-Ped_detalle.fecha_tardia 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-2 
&Scoped-define QUERY-STRING-BROWSE-2 FOR EACH T-Ped_detalle OF T-Ped_header NO-LOCK, ~
      EACH Articulo OF T-Ped_detalle NO-LOCK ~
    BY T-Ped_detalle.fecha_temprana ~
       BY Articulo.cdg_articulo
&Scoped-define OPEN-QUERY-BROWSE-2 OPEN QUERY BROWSE-2 FOR EACH T-Ped_detalle OF T-Ped_header NO-LOCK, ~
      EACH Articulo OF T-Ped_detalle NO-LOCK ~
    BY T-Ped_detalle.fecha_temprana ~
       BY Articulo.cdg_articulo.
&Scoped-define TABLES-IN-QUERY-BROWSE-2 T-Ped_detalle Articulo
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-2 T-Ped_detalle
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-2 Articulo


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define FIELDS-IN-QUERY-DEFAULT-FRAME T-Ped_header.clausula_dolar ~
T-Ped_header.tip_comprob T-Ped_header.prf_comprob T-Ped_header.nro_comprob ~
T-Ped_header.fecha T-Ped_header.cdg_estado ~
T-Ped_header.permitir_cambio_domicilio T-Ped_header.fecha_embarque ~
T-Ped_header.nro_ocm T-Ped_header.fecha_ocm T-Ped_header.cambio ~
T-Ped_header.cdg_imputacion T-Ped_header.modo_abasto ~
T-Ped_header.cdg_lineanegocio T-Ped_header.transportista ~
T-Ped_header.imp_neto T-Ped_header.imp_total T-Ped_header.cambio_dolar 
&Scoped-define ENABLED-FIELDS-IN-QUERY-DEFAULT-FRAME ~
T-Ped_header.clausula_dolar T-Ped_header.tip_comprob ~
T-Ped_header.prf_comprob T-Ped_header.permitir_cambio_domicilio ~
T-Ped_header.cdg_imputacion T-Ped_header.modo_abasto ~
T-Ped_header.cdg_lineanegocio T-Ped_header.cambio_dolar 
&Scoped-define ENABLED-TABLES-IN-QUERY-DEFAULT-FRAME T-Ped_header
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-DEFAULT-FRAME T-Ped_header
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-BROWSE-2}
&Scoped-define QUERY-STRING-DEFAULT-FRAME FOR EACH T-Ped_header SHARE-LOCK
&Scoped-define OPEN-QUERY-DEFAULT-FRAME OPEN QUERY DEFAULT-FRAME FOR EACH T-Ped_header SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-DEFAULT-FRAME T-Ped_header
&Scoped-define FIRST-TABLE-IN-QUERY-DEFAULT-FRAME T-Ped_header


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS T-Ped_header.clausula_dolar ~
T-Ped_header.tip_comprob T-Ped_header.prf_comprob ~
T-Ped_header.permitir_cambio_domicilio T-Ped_header.cdg_imputacion ~
T-Ped_header.modo_abasto T-Ped_header.cdg_lineanegocio ~
T-Ped_header.cambio_dolar 
&Scoped-define ENABLED-TABLES T-Ped_header
&Scoped-define FIRST-ENABLED-TABLE T-Ped_header
&Scoped-Define ENABLED-OBJECTS Btn_salir BROWSE-2 RECT-2 RECT-3 RECT-4 ~
RECT-5 
&Scoped-Define DISPLAYED-FIELDS T-Ped_header.clausula_dolar ~
T-Ped_header.tip_comprob T-Ped_header.prf_comprob T-Ped_header.nro_comprob ~
T-Ped_header.fecha T-Ped_header.cdg_estado ~
T-Ped_header.permitir_cambio_domicilio T-Ped_header.fecha_embarque ~
T-Ped_header.nro_ocm T-Ped_header.fecha_ocm T-Ped_header.cambio ~
T-Ped_header.cdg_imputacion T-Ped_header.modo_abasto ~
T-Ped_header.cdg_lineanegocio T-Ped_header.transportista ~
T-Ped_header.imp_neto T-Ped_header.imp_total T-Ped_header.cambio_dolar 
&Scoped-define DISPLAYED-TABLES T-Ped_header
&Scoped-define FIRST-DISPLAYED-TABLE T-Ped_header
&Scoped-Define DISPLAYED-OBJECTS v-credito_maximo v-cdg_cliente v-pto_venta ~
v-dsc_cliente v-cdg_domicilio v-dsc_domicilio v-cdg_condicion_impos ~
v-dsc_condicion_impos v-cdg_condicion_venta v-dsc_condicion_venta ~
v-cdg_moneda v-dsc_moneda v-cdg_vendedor v-dsc_vendedor v-cdg_deposito ~
v-dsc_deposito v-cdg_lista_precios v-dsc_lista_precios v-cdg_articulo ~
v-credito_disponible v-credito_consumido 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
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

DEFINE BUTTON btn_copiasxsector 
     LABEL "C&opias" 
     SIZE 15 BY 1.

DEFINE BUTTON btn_documentos 
     LABEL "&Especificaciones" 
     SIZE 22 BY 1.

DEFINE BUTTON btn_grabar 
     LABEL "&Grabar" 
     SIZE 21 BY 1.33.

DEFINE BUTTON btn_imprim 
     LABEL "&Reimprimir" 
     SIZE 21 BY 1.33.

DEFINE BUTTON btn_observ 
     LABEL "&Leyenda" 
     SIZE 21 BY 1.33.

DEFINE BUTTON btn_porclasificacion 
     LABEL "X &Clasificación" 
     SIZE 18 BY 1.

DEFINE BUTTON Btn_salir DEFAULT 
     LABEL "&Salir" 
     SIZE 21 BY 1.33
     BGCOLOR 8 .

DEFINE BUTTON btn_verbonificaciones 
     LABEL "&Bonificaciones" 
     SIZE 18 BY 1.

DEFINE VARIABLE v-cdg_articulo AS CHARACTER FORMAT "X(12)":U 
     LABEL "Artículo" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 22 BY 1
     BGCOLOR 14 FGCOLOR 12 FONT 6 NO-UNDO.

DEFINE VARIABLE v-cdg_cliente AS CHARACTER FORMAT "X(8)" 
     LABEL "Cliente" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_condicion_impos AS INTEGER FORMAT "->,>>>,>>9" INITIAL 0 
     LABEL "C.Iva." 
     VIEW-AS FILL-IN NATIVE 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_condicion_venta AS CHARACTER FORMAT "X(8)" 
     LABEL "C.Venta" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_deposito AS CHARACTER FORMAT "X(8)" 
     LABEL "Depósito" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_domicilio AS INTEGER FORMAT ">>>>>>9" INITIAL 0 
     LABEL "Domicilio" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_lista_precios AS INTEGER FORMAT "->,>>>,>>9" INITIAL 0 
     LABEL "Lista" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_moneda AS CHARACTER FORMAT "X(3)" 
     LABEL "Moneda" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_vendedor AS CHARACTER FORMAT "X(4)" 
     LABEL "Vendedor" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-credito_consumido AS DECIMAL FORMAT "-Z,ZZZ,ZZZ,ZZ9.99":U INITIAL 0 
     LABEL "Consumido" 
     VIEW-AS FILL-IN 
     SIZE 25 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-credito_disponible AS DECIMAL FORMAT "-Z,ZZZ,ZZZ,ZZ9.99":U INITIAL 0 
     LABEL "Disponible" 
     VIEW-AS FILL-IN 
     SIZE 25 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-credito_maximo AS DECIMAL FORMAT "-Z,ZZZ,ZZZ,ZZ9.99":U INITIAL 0 
     LABEL "Máximo" 
     VIEW-AS FILL-IN 
     SIZE 25 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-dsc_cliente AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 86 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_condicion_impos AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 86 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_condicion_venta AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 86 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_deposito AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 53 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_domicilio AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 53 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_lista_precios AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 53 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_moneda AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 53 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_vendedor AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 53 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-pto_venta AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN NATIVE 
     SIZE 7 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 0 NO-UNDO.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 133 BY 1.86.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 24 BY 1.86.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 157 BY 13.57.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 157 BY 1.33.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-2 FOR 
      T-Ped_detalle, 
      Articulo SCROLLING.

DEFINE QUERY DEFAULT-FRAME FOR 
      T-Ped_header SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-2 C-Win _STRUCTURED
  QUERY BROWSE-2 NO-LOCK DISPLAY
      T-Ped_detalle.nro_linea COLUMN-LABEL "Nro!Lin" FORMAT ">>9":U
      Articulo.cdg_articulo FORMAT "X(12)":U WIDTH 16.8
      Articulo.descripcion FORMAT "X(28)":U WIDTH 49
      Articulo.cdg_umed FORMAT "X(12)":U
      T-Ped_detalle.cantidad_sol FORMAT "->>>,>>>,>>9.99":U
      T-Ped_detalle.granel_sol FORMAT "->,>>>,>>9.99":U
      T-Ped_detalle.precio FORMAT "->>,>>9.9999":U
      T-Ped_detalle.cdg_estado COLUMN-LABEL "Es-!tado" FORMAT "X(2)":U
      T-Ped_detalle.fecha_temprana COLUMN-LABEL "Fecha!Entrega" FORMAT "99/99/99":U
      T-Ped_detalle.fecha_tardia COLUMN-LABEL "Ultima!Fecha" FORMAT "99/99/99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 157 BY 9.52
         BGCOLOR 15 FGCOLOR 9 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     T-Ped_header.clausula_dolar AT ROW 8.38 COL 140
          VIEW-AS TOGGLE-BOX
          SIZE 18 BY 1.19
     v-credito_maximo AT ROW 11.95 COL 130 COLON-ALIGNED
     v-cdg_cliente AT ROW 4.81 COL 13 COLON-ALIGNED
     btn_grabar AT ROW 1.48 COL 4
     btn_copiar AT ROW 1.48 COL 26
     btn_cancel AT ROW 1.48 COL 48
     btn_anular AT ROW 1.48 COL 70
     btn_observ AT ROW 1.48 COL 92
     btn_imprim AT ROW 1.48 COL 114
     Btn_salir AT ROW 1.48 COL 138
     T-Ped_header.tip_comprob AT ROW 3.62 COL 13 COLON-ALIGNED
          LABEL "Pedido"
          VIEW-AS FILL-IN NATIVE 
          SIZE 6 BY 1
          BGCOLOR 7 FGCOLOR 15 
     T-Ped_header.prf_comprob AT ROW 3.62 COL 20 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 7 BY 1
          BGCOLOR 7 FGCOLOR 15 
     T-Ped_header.nro_comprob AT ROW 3.62 COL 28 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 13 BY 1
          BGCOLOR 7 FGCOLOR 15 
     T-Ped_header.fecha AT ROW 3.62 COL 138 COLON-ALIGNED
          LABEL "Pedido el" FORMAT "99/99/9999"
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-pto_venta AT ROW 3.62 COL 42 COLON-ALIGNED NO-LABEL
     T-Ped_header.cdg_estado AT ROW 3.62 COL 67 COLON-ALIGNED
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Sujeto a Aprobación","HH",
                     "Pasar a Producción","AA"
          DROP-DOWN-LIST
          SIZE 47 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-dsc_cliente AT ROW 4.81 COL 28 COLON-ALIGNED NO-LABEL
     v-cdg_domicilio AT ROW 6 COL 13 COLON-ALIGNED
     v-dsc_domicilio AT ROW 6 COL 28 COLON-ALIGNED NO-LABEL
     T-Ped_header.permitir_cambio_domicilio AT ROW 6 COL 84
          LABEL "Permitir cambiar al entregar"
          VIEW-AS TOGGLE-BOX
          SIZE 32 BY .81
     T-Ped_header.fecha_embarque AT ROW 4.81 COL 138 COLON-ALIGNED
          LABEL "Entrega el"
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_condicion_impos AT ROW 7.19 COL 13 COLON-ALIGNED
     v-dsc_condicion_impos AT ROW 7.19 COL 28 COLON-ALIGNED NO-LABEL
     T-Ped_header.nro_ocm AT ROW 6 COL 138 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_condicion_venta AT ROW 8.38 COL 13 COLON-ALIGNED
     v-dsc_condicion_venta AT ROW 8.38 COL 28 COLON-ALIGNED NO-LABEL
     T-Ped_header.fecha_ocm AT ROW 7.19 COL 138 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_moneda AT ROW 9.57 COL 13 COLON-ALIGNED
     v-dsc_moneda AT ROW 9.57 COL 28 COLON-ALIGNED NO-LABEL
     T-Ped_header.cambio AT ROW 9.57 COL 97 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Ped_header.cdg_imputacion AT ROW 10.76 COL 13 COLON-ALIGNED
          LABEL "Concepto"
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Item",1,
                     "Punto",2
          DROP-DOWN-LIST
          SIZE 68 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_vendedor AT ROW 11.95 COL 13 COLON-ALIGNED
     v-dsc_vendedor AT ROW 11.95 COL 28 COLON-ALIGNED NO-LABEL
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 160 BY 27.33.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME DEFAULT-FRAME
     T-Ped_header.modo_abasto AT ROW 11.95 COL 82 COLON-ALIGNED NO-LABEL
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "No Aplicable","N",
                     "A/C Vendedor","D",
                     "A/C Cliente","S"
          DROP-DOWN-LIST
          SIZE 32 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_deposito AT ROW 13.14 COL 13 COLON-ALIGNED
     v-dsc_deposito AT ROW 13.14 COL 28 COLON-ALIGNED NO-LABEL
     v-cdg_lista_precios AT ROW 14.33 COL 13 COLON-ALIGNED
     v-dsc_lista_precios AT ROW 14.33 COL 28 COLON-ALIGNED NO-LABEL
     T-Ped_header.cdg_lineanegocio AT ROW 14.33 COL 82 COLON-ALIGNED NO-LABEL FORMAT "X(15)"
          VIEW-AS COMBO-BOX 
          LIST-ITEM-PAIRS "Venta Especial","Venta Especial",
                     "Licitación","Licitación"
          DROP-DOWN-LIST
          SIZE 32 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Ped_header.transportista AT ROW 15.52 COL 13 COLON-ALIGNED FORMAT "X(75)"
          VIEW-AS FILL-IN NATIVE 
          SIZE 101 BY 1
          BGCOLOR 15 FGCOLOR 9 
     btn_documentos AT ROW 17.19 COL 118
     btn_copiasxsector AT ROW 17.19 COL 142
     v-cdg_articulo AT ROW 17.14 COL 13 COLON-ALIGNED
     T-Ped_header.imp_neto AT ROW 17.19 COL 89 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 25 BY 1
          BGCOLOR 7 FGCOLOR 14 
     T-Ped_header.imp_total AT ROW 14.33 COL 130 COLON-ALIGNED
          LABEL "Este Pedido" FORMAT "-Z,ZZZ,ZZZ,ZZ9.99"
          VIEW-AS FILL-IN 
          SIZE 25 BY 1
          BGCOLOR 7 FGCOLOR 14 
     btn_porclasificacion AT ROW 17.19 COL 39
     btn_verbonificaciones AT ROW 17.19 COL 58
     BROWSE-2 AT ROW 18.38 COL 3
     v-credito_disponible AT ROW 15.52 COL 130 COLON-ALIGNED
     v-credito_consumido AT ROW 13.14 COL 130 COLON-ALIGNED
     T-Ped_header.cambio_dolar AT ROW 9.57 COL 138 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 17 BY 1
          BGCOLOR 15 FGCOLOR 9 
     "  Línea de Negocios" VIEW-AS TEXT
          SIZE 32 BY 1 AT ROW 13.14 COL 84
          BGCOLOR 5 FGCOLOR 15 
     "  Tasa de Abasto Municipal" VIEW-AS TEXT
          SIZE 32 BY 1 AT ROW 10.76 COL 84
          BGCOLOR 5 FGCOLOR 15 
     "  Información de crédito del cliente" VIEW-AS TEXT
          SIZE 38 BY 1 AT ROW 10.76 COL 119
          BGCOLOR 5 FGCOLOR 15 
     RECT-2 AT ROW 1.24 COL 3
     RECT-3 AT ROW 1.24 COL 136
     RECT-4 AT ROW 3.38 COL 3
     RECT-5 AT ROW 16.95 COL 3
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 160 BY 27.33.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Copias_pedido T "?" NO-UNDO sic Copias_pedido
      TABLE: T-Ped_detalle T "?" NO-UNDO sic Ped_detalle
      TABLE: T-Ped_detalle-bon T "?" NO-UNDO sic Ped_detalle-bon
      TABLE: T-Ped_header T "?" NO-UNDO sic Ped_header
      TABLE: T-Ped_header-bon T "?" NO-UNDO sic Ped_header-bon
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
         TITLE              = "Pedidos de Clientes"
         HEIGHT             = 27.33
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
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB BROWSE-2 btn_verbonificaciones DEFAULT-FRAME */
/* SETTINGS FOR BUTTON btn_anular IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_cancel IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_copiar IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_copiasxsector IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_documentos IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_grabar IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_imprim IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_observ IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_porclasificacion IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_verbonificaciones IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Ped_header.cambio IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX T-Ped_header.cdg_estado IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX T-Ped_header.cdg_imputacion IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR COMBO-BOX T-Ped_header.cdg_lineanegocio IN FRAME DEFAULT-FRAME
   EXP-LABEL EXP-FORMAT                                                 */
ASSIGN 
       T-Ped_header.cdg_lineanegocio:PRIVATE-DATA IN FRAME DEFAULT-FRAME     = 
                "Venta Esp.".

/* SETTINGS FOR FILL-IN T-Ped_header.fecha IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL EXP-FORMAT                                       */
/* SETTINGS FOR FILL-IN T-Ped_header.fecha_embarque IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN T-Ped_header.fecha_ocm IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Ped_header.imp_neto IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Ped_header.imp_total IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL EXP-FORMAT                                       */
/* SETTINGS FOR FILL-IN T-Ped_header.nro_comprob IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Ped_header.nro_ocm IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR TOGGLE-BOX T-Ped_header.permitir_cambio_domicilio IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN T-Ped_header.tip_comprob IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN T-Ped_header.transportista IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-FORMAT                                                 */
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
/* SETTINGS FOR FILL-IN v-credito_consumido IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-credito_disponible IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-credito_maximo IN FRAME DEFAULT-FRAME
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
/* SETTINGS FOR FILL-IN v-pto_venta IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-2
/* Query rebuild information for BROWSE BROWSE-2
     _TblList          = "Temp-Tables.T-Ped_detalle OF Temp-Tables.T-Ped_header,sic.Articulo OF Temp-Tables.T-Ped_detalle"
     _Options          = "NO-LOCK"
     _OrdList          = "Temp-Tables.T-Ped_detalle.fecha_temprana|yes,sic.Articulo.cdg_articulo|yes"
     _FldNameList[1]   > Temp-Tables.T-Ped_detalle.nro_linea
"T-Ped_detalle.nro_linea" "Nro!Lin" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[2]   > sic.Articulo.cdg_articulo
"Articulo.cdg_articulo" ? ? "character" ? ? ? ? ? ? no ? no no "16.8" yes no no "U" "" ""
     _FldNameList[3]   > sic.Articulo.descripcion
"Articulo.descripcion" ? "X(28)" "character" ? ? ? ? ? ? no ? no no "49" yes no no "U" "" ""
     _FldNameList[4]   = sic.Articulo.cdg_umed
     _FldNameList[5]   = Temp-Tables.T-Ped_detalle.cantidad_sol
     _FldNameList[6]   > Temp-Tables.T-Ped_detalle.granel_sol
"T-Ped_detalle.granel_sol" ? "->,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[7]   = Temp-Tables.T-Ped_detalle.precio
     _FldNameList[8]   > Temp-Tables.T-Ped_detalle.cdg_estado
"T-Ped_detalle.cdg_estado" "Es-!tado" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[9]   > Temp-Tables.T-Ped_detalle.fecha_temprana
"T-Ped_detalle.fecha_temprana" "Fecha!Entrega" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[10]   > Temp-Tables.T-Ped_detalle.fecha_tardia
"T-Ped_detalle.fecha_tardia" "Ultima!Fecha" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _Query            is OPENED
*/  /* BROWSE BROWSE-2 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME DEFAULT-FRAME
/* Query rebuild information for FRAME DEFAULT-FRAME
     _TblList          = "Temp-Tables.T-Ped_header"
     _Query            is OPENED
*/  /* FRAME DEFAULT-FRAME */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Pedidos de Clientes */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Pedidos de Clientes */
DO:
  /* This event will close the window and terminate the procedure.  */
  /* APPLY "CLOSE":U TO THIS-PROCEDURE. */
  APPLY "CHOOSE":U TO Btn_salir IN FRAME {&FRAME-NAME}.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-2
&Scoped-define SELF-NAME BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-2 C-Win
ON DELETE-CHARACTER OF BROWSE-2 IN FRAME DEFAULT-FRAME
DO:
    IF modo = MD_ALTA
    THEN DO:
        sino-msg = NO.
        MESSAGE "Desea eliminar este renglón de detalle?" 
                VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
        IF sino-msg
        THEN DO:
             DELETE T-Ped_detalle.
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-2 C-Win
ON MOUSE-SELECT-DBLCLICK OF BROWSE-2 IN FRAME DEFAULT-FRAME
OR RETURN OF {&BROWSE-NAME} IN FRAME {&FRAME-NAME}
DO:

   DEFINE VARIABLE n-fila AS INTEGER.

   IF NOT AVAILABLE T-Ped_detalle
   THEN DO:
          MESSAGE "no disponible." VIEW-AS ALERT-BOX MESSAGE.
       n-fila = {&BROWSE-NAME}:FOCUSED-ROW.
       {&BROWSE-NAME}:FETCH-SELECTED-ROW(n-fila).
   END.

   RUN corregir_detalle.
   RUN refrescar_browse.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_anular
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_anular C-Win
ON CHOOSE OF btn_anular IN FRAME DEFAULT-FRAME /* Anular */
DO:

    DEFINE VARIABLE pudo_anular AS INTEGER.
    sino-msg = NO.
    MESSAGE "Desea ANULAR este pedido" 
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
    IF sino-msg
    THEN DO:
         RUN anular_pedido.p (INPUT ROWID(Ped_header), OUTPUT pudo_anular).
         IF pudo_anular = 0
         THEN DO:
              MESSAGE "El pedido ha sido anulado" 
                      VIEW-AS ALERT-BOX MESSAGE TITLE "Aviso".

         END.

         RUN borrar_tablas_temporales.
         {&OPEN-QUERY-{&BROWSE-NAME}}

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

  RUN d-seleccionar_pedido.w (INPUT-OUTPUT rid_pedido).
  IF rid_pedido <> ?
  THEN DO:
     FIND Ped_header WHERE ROWID(Ped_header) = rid_pedido NO-LOCK.
     DISPLAY Ped_header.nro_comprob @ T-Ped_header.nro_comprob
             WITH FRAME {&FRAME-NAME}.
     RUN traer_documento.
  END.  
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_copiasxsector
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_copiasxsector C-Win
ON CHOOSE OF btn_copiasxsector IN FRAME DEFAULT-FRAME /* Copias */
DO:
  RUN d-copias_sector.w ( INPUT-OUTPUT TABLE T-Copias_pedido, INPUT modo ).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_documentos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_documentos C-Win
ON CHOOSE OF btn_documentos IN FRAME DEFAULT-FRAME /* Especificaciones */
DO:
  RUN d-copias_sector.w ( INPUT-OUTPUT TABLE T-Copias_pedido, INPUT modo ).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_grabar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_grabar C-Win
ON CHOOSE OF btn_grabar IN FRAME DEFAULT-FRAME /* Grabar */
DO:

  ASSIGN FRAME {&FRAME-NAME}
         T-Ped_header.cambio
         T-Ped_header.cdg_imputacion
         T-Ped_header.fecha 
         T-Ped_header.fecha_ocm 
         T-Ped_header.fecha_embarque 
         T-Ped_header.nro_ocm
         T-Ped_header.transportista
         T-Ped_header.modo_abasto
         T-Ped_header.cdg_estado
         T-Ped_header.permitir_cambio_domicilio
         T-Ped_header.cdg_lineanegocio
         T-Ped_header.clausula_dolar
         T-Ped_header.cambio_dolar. 
         
  RUN validar_datos ( OUTPUT hay_error ).
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
    MESSAGE "Desea REIMPRIMIR esta factura?" 
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
    IF sino-msg
    THEN DO:
         RUN imprimir_pedido.p (ROWID(Ped_header)).
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_observ
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_observ C-Win
ON CHOOSE OF btn_observ IN FRAME DEFAULT-FRAME /* Leyenda */
DO:

   DEFINE VARIABLE puso_ok AS LOGICAL.
   RUN c-edttexto.w ( INPUT-OUTPUT T-Ped_header.leyenda,
                      INPUT "Leyenda de la Factura de Cliente",
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
    RUN d-bonificaciones_pedido.w ( INPUT-OUTPUT TABLE T-Ped_header-bon, INPUT modo ).
    RUN calculos.
    RUN refrescar_browse.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Ped_header.cdg_imputacion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Ped_header.cdg_imputacion C-Win
ON VALUE-CHANGED OF T-Ped_header.cdg_imputacion IN FRAME DEFAULT-FRAME /* Concepto */
DO:
  ASSIGN T-Ped_header.cdg_imputacion.
  FIND Imputacion WHERE Imputacion.cdg_imputacion = T-Ped_header.cdg_imputacion NO-LOCK.
  RUN asignar_imputacion.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Ped_header.clausula_dolar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Ped_header.clausula_dolar C-Win
ON VALUE-CHANGED OF T-Ped_header.clausula_dolar IN FRAME DEFAULT-FRAME /* Cláusula Dólar */
DO:
    ASSIGN FRAME {&FRAME-NAME} T-Ped_header.clausula_dolar.
    IF T-Ped_header.clausula_dolar
    THEN DO:
        RUN asignar_dolar.
    END.
    ELSE DO:
        T-Ped_header.cambio_dolar = 1.
        DISPLAY T-Ped_header.cambio_dolar
                 WITH FRAME {&FRAME-NAME}.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Ped_header.fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Ped_header.fecha C-Win
ON LEAVE OF T-Ped_header.fecha IN FRAME DEFAULT-FRAME /* Pedido el */
DO:
  
  ASSIGN T-Ped_header.fecha.
  ASSIGN T-Ped_header.fecha_carga    = T-Ped_header.fecha 
         T-Ped_header.fecha_embarque = T-Ped_header.fecha
         T-Ped_header.fecha_iva      = T-Ped_header.fecha.

  DISPLAY
         T-Ped_header.fecha_embarque 
         WITH FRAME {&FRAME-NAME}.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Ped_header.nro_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Ped_header.nro_comprob C-Win
ON MOUSE-SELECT-DBLCLICK OF T-Ped_header.nro_comprob IN FRAME DEFAULT-FRAME /* nro_comprob */
OR MOUSE-MENU-DOWN,"." OF T-Ped_header.nro_comprob IN FRAME {&FRAME-NAME}
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
          titulo_window = "Selección de Pedidos".
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
          titulo_window = "Selección de Pedidos".
          lista_estados = "*".
     END.
     WHEN MD_CAMBIO        
     THEN DO:
          titulo_window = "".
          lista_estados = "".
     END.
     WHEN MD_ANULACION        
     THEN DO:
          titulo_window = "Selección de Pedidos".
          lista_estados = "P,E".
     END.
     WHEN MD_EMISION        
     THEN DO:
          titulo_window = "Selección de Pedidos".
          lista_estados = "".
     END.
  END CASE.     

  RUN d-seleccionar_pedido.w (INPUT titulo_window, INPUT lista_estados, INPUT "P*", INPUT-OUTPUT rid_pedido).
  IF rid_pedido <> ?
  THEN DO:
     FIND Ped_header WHERE ROWID(Ped_header) = rid_pedido NO-LOCK.
     DISPLAY Ped_header.tip_comprob @ T-Ped_header.tip_comprob 
             Ped_header.prf_comprob @ T-Ped_header.prf_comprob
             Ped_header.nro_comprob @ T-Ped_header.nro_comprob
             WITH FRAME {&FRAME-NAME}.
     IF modo = MD_ANULACION AND Ped_header.anulado
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Ped_header.nro_comprob C-Win
ON RETURN OF T-Ped_header.nro_comprob IN FRAME DEFAULT-FRAME /* nro_comprob */
DO:

   IF LOOKUP(INPUT FRAME {&FRAME-NAME} T-Ped_header.tip_comprob,"PD,PV") = 0 
   THEN DO:
      RUN PONMENSJ.P (INPUT "DOCS010").
      RETURN NO-APPLY.
   END.

   FIND Ped_header 
        WHERE Ped_header.cdg_empresa = Empresa.cdg_empresa
          AND Ped_header.tip_comprob = INPUT T-Ped_header.tip_comprob 
          AND Ped_header.prf_comprob = INPUT T-Ped_header.prf_comprob
          AND Ped_header.nro_comprob = INPUT T-Ped_header.nro_comprob
              NO-ERROR.

   IF NOT AVAILABLE Ped_header 
   THEN DO:
        IF LOCKED Ped_header
           THEN RUN PONMENSJ.P (INPUT "DOCS000").
           ELSE RUN PONMENSJ.P (INPUT "DOCS001").
        RETURN NO-APPLY.
   END.
   ELSE DO:
        rid_pedido = ROWID(Ped_header).
        RUN traer_documento.
   END.
  
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
       RETURN NO-APPLY.
  END.
  ELSE DO:
    APPLY "ENTRY" TO SELF.
    RETURN NO-APPLY.
  END.
  

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

   IF Articulo.extendida
   THEN DO:
      RUN PONMENSJ.P (INPUT "PEDI039").
      RETURN NO-APPLY.
   END.

/***************/


   IF NOT CAN-DO(Articulo.lista_empresas,Empresa.cdg_empresa)
   THEN DO:
         RUN PONMENSJ.P ( INPUT "ARTI017" ).
         RETURN NO-APPLY.
   END.

   FIND Familia_articulo OF Articulo NO-LOCK NO-ERROR.
   FIND FIRST Familia_cuenta 
       WHERE Familia_cuenta.cdg_imputacion = T-Ped_header.cdg_imputacion
         AND Familia_cuenta.nro_familia    = Familia_articulo.nro_familia
         AND Familia_cuenta.cdg_empresa    = T-Ped_header.cdg_empresa
             NO-LOCK NO-ERROR.
   
   IF NOT AVAILABLE Familia_cuenta
   THEN DO:
      RUN PONMENSJ.P (INPUT "FAPR061").
      RETURN NO-APPLY.
   END.
 /*******************/
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
ON MOUSE-SELECT-DBLCLICK OF v-cdg_condicion_impos IN FRAME DEFAULT-FRAME /* C.Iva. */
OR "." OF v-cdg_condicion_impos IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_condicion_impos IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "condicion_impos" "cdg_condiva" "SELCNDIV-v.P"}
  
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
      ASSIGN  T-Ped_header.nro_domicilio = Domicilio.nro_domicilio
              T-Ped_header.direccion     = Domicilio.direccion
              T-Ped_header.cdg_provincia = Domicilio.cdg_provincia
              T-Ped_header.localidad     = Domicilio.localidad
              T-Ped_header.cdg_postal    = Domicilio.cdg_postal
              T-Ped_header.cdg_zonag     = Domicilio.cdg_zonag
              T-Ped_header.cdg_recorrido = Domicilio.cdg_recorrido
              v-cdg_domicilio            = Domicilio.nro_domicilio
              v-dsc_domicilio            = Domicilio.nombre.
      DISPLAY v-cdg_domicilio 
              v-dsc_domicilio
              WITH FRAME {&FRAME-NAME}.
      RUN calculos.
      {&OPEN-QUERY-{&BROWSE-NAME}}
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
  IF INPUT FRAME {&FRAME-NAME} v-pto_venta <> v-pto_venta-org
  THEN DO:
       IF NOT CAN-FIND(Punto-venta WHERE Punto-venta.cdg_empresa  = Empresa.cdg_empresa 
                                     AND Punto-venta.cdg_puntovta = INPUT FRAME {&FRAME-NAME} v-pto_venta)
       THEN DO:
            MESSAGE "No existe el punto de venta indicado" VIEW-AS ALERT-BOX ERROR.
            DISPLAY v-pto_venta-org @ v-pto_venta
                    WITH FRAME {&FRAME-NAME}.
       END.
       ELSE DO:
            ASSIGN FRAME {&FRAME-NAME} v-pto_venta.
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

RUN iniciar_combos.    


/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
REPEAT ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
       ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  RUN cargar_comprobante.
  RUN iniciar_documento.
  RUN cargar_conceptos.
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
                         INPUT  T-Ped_header.cdg_empresa, 
                         INPUT  T-Ped_header.fecha,       
                         OUTPUT T-Ped_header.cambio,  
                         OUTPUT p-xx ).

  DISPLAY T-Ped_header.cambio WITH FRAME {&FRAME-NAME}.

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

   T-Ped_header.nro_cndventa = Condicion_venta.nro_cndventa.
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
                         INPUT  T-Ped_header.cdg_empresa, 
                         INPUT  T-Ped_header.fecha,       
                         OUTPUT T-Ped_header.cambio_dolar,  
                         OUTPUT p-xx ).

  DISPLAY T-Ped_header.cambio_dolar WITH FRAME {&FRAME-NAME}.

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

  T-Ped_header.cdg_imputacion = Imputacion.cdg_imputacion.
  T-Ped_header.cta_cte        = Imputacion.cta_cte.
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
   T-Ped_header.cdg_lista =  v-cdg_lista_precios.
   FIND Lista_precios WHERE Lista_precios.cdg_lista = T-Ped_header.cdg_lista NO-LOCK.
   FOR EACH T-Ped_detalle OF T-Ped_header EXCLUSIVE-LOCK, EACH Articulo OF T-Ped_detalle:

        CASE Articulo.modo_volumen:
             WHEN ""  /* No hay descuentos por volumen */
             THEN DO: 
                  FIND FIRST Articulo_precio OF Articulo 
                       WHERE Articulo_precio.cdg_lista = Lista_precio.cdg_lista 
                         AND Articulo_precio.cdg_empresa = Empresa.cdg_empresa
                             NO-LOCK NO-ERROR. 
                  IF AVAILABLE Articulo_precio 
                  THEN DO:
                       T-Ped_detalle.precio    = Articulo_precio.precio.
                  END.
                  ELSE DO:
                       T-Ped_detalle.precio    = ?.
                  END.
             END.                                  
    
             WHEN "D"  /* Descuentos directos en base a cantidad */
             THEN DO: 
                  FIND FIRST Articulo_precio OF Articulo 
                       WHERE Articulo_precio.cdg_lista = Lista_precio.cdg_lista 
                         AND Articulo_precio.cdg_empresa = Empresa.cdg_empresa
                         AND Articulo_precio.desde_cantidad <= T-Ped_detalle.cantidad
                         AND Articulo_precio.hasta_cantidad >= T-Ped_detalle.cantidad
                             NO-LOCK NO-ERROR. 
                  IF AVAILABLE Articulo_precio 
                  THEN DO:
                       T-Ped_detalle.precio    = Articulo_precio.precio.
                  END.
                  ELSE DO:
                       T-Ped_detalle.precio    = ?.
                  END.
             END.                                  
    
             WHEN "E"  /* Descuentos escalados en base a cantidad */
             THEN DO: 
                    /*
                  subtotal_item = 0.
                  remanente_cantidad = T-Ped_detalle.cantidad.
    
                  FOR EACH Articulo_precio OF Articulo 
                       WHERE Articulo_precio.cdg_lista = Lista_precio.cdg_lista 
                         AND Articulo_precio.cdg_empresa = Empresa.cdg_empresa
                         BY Articulo-precio.desde_cantidad
                             NO-LOCK NO-ERROR: 
    
                      T-Ped_detalle.cantidad
    
    
                  IF AVAILABLE Articulo_precio 
                  THEN DO:
                       T-Ped_detalle.precio    = Articulo_precio.precio.
                  END.
                  ELSE DO:
                       T-Ped_detalle.precio    = ?.
                  END.
                  */
                            T-Ped_detalle.precio = ?. /* Sacar */
             END.                                  
 
        END CASE.
   END.
   
   RUN calculos.
   RUN refrescar_browse.

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

  T-Ped_header.nro_moneda = Moneda.nro_moneda.
  T-Ped_header.cambio = ROUND(Moneda.cambio / Moneda.unidades , 4 ) .
  DISPLAY T-Ped_header.cambio WITH FRAME {&FRAME-NAME}.
  /*
  IF Moneda.cdg_moneda = codigo_dolar
  THEN DO:
     T-Ped_header.cambio_dolar = Moneda.cambio.
     DISPLAY T-Ped_header.cambio_dolar WITH FRAME {&FRAME-NAME}.
     DISABLE T-Ped_header.cambio_dolar WITH FRAME {&FRAME-NAME}.
  END.
  ELSE DO:
     ENABLE T-Ped_header.cambio_dolar WITH FRAME {&FRAME-NAME}.
  END.     
  */

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

  EMPTY TEMP-TABLE T-Ped_header NO-ERROR.
  EMPTY TEMP-TABLE T-Ped_header-bon NO-ERROR.
  EMPTY TEMP-TABLE T-Ped_detalle NO-ERROR.
  EMPTY TEMP-TABLE T-Ped_detalle-bon NO-ERROR.  
  EMPTY TEMP-TABLE T-Sub_detalle_vta NO-ERROR.
  EMPTY TEMP-TABLE T-Sub_header_vta NO-ERROR.
  EMPTY TEMP-TABLE T-Copias_pedido NO-ERROR.

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

  EMPTY TEMP-TABLE T-Sub_header_vta NO-ERROR.
  EMPTY TEMP-TABLE T-Sub_detalle_vta NO-ERROR.
/*
  { calculapedido.i "T-"}
*/  

 RUN calcular_pedido.p ( INPUT-OUTPUT  TABLE  T-Ped_header,
                         INPUT-OUTPUT  TABLE  T-Ped_detalle,
                         INPUT-OUTPUT  TABLE  T-Sub_header_vta,
                         INPUT-OUTPUT  TABLE  T-Sub_detalle_vta,
                         INPUT-OUTPUT  TABLE  T-Ped_header-bon,
                         INPUT-OUTPUT  TABLE  T-Ped_detalle-bon,
                         INPUT-OUTPUT  TABLE  T-Ped_header_impuesto,
                         INPUT-OUTPUT  TABLE  T-Ped_detalle_impuesto).

  FIND FIRST T-Ped_header NO-LOCK.

  IF v-control_habilitado
  THEN DO:
      v-credito_disponible = v-credito_maximo - v-credito_consumido - T-Ped_header.imp_total.
      RUN poner_credito_disponible.
  END.

  DISPLAY T-Ped_header.imp_neto 
          T-Ped_header.imp_total
          WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE cargar_comprobante C-Win 
PROCEDURE cargar_comprobante :
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
/*     ELSE DO:                                                                 */
/*                                                                              */
/*     FIND Tipocomprobante                                                     */
/*         WHERE Tipocomprobante.cdg_empresa     = que_empresa                  */
/*           AND Tipocomprobante.cdg_comprobante = "PEDIDCLI" NO-LOCK NO-ERROR. */
/*                                                                              */
/*        IF AVAILABLE Tipocomprobante                                          */
/*        THEN DO:                                                              */
/*            ASSIGN                                                            */
/*                   v-nombre_comprobante  = Tipocomprobante.rotulo             */
/*                   v-fgcolor_comprobante = Tipocomprobante.color_letra        */
/*                   v-bgcolor_comprobante = Tipocomprobante.color_fondo        */
/*                   v-primera_letra       = Tipocomprobante.tip_comprob        */
/*                   v-prefijo_contador    = Tipocomprobante.prefijo_contador.  */
/*                                                                              */
/*        END.                                                                  */
/*        ELSE DO:                                                              */
/*                                                                              */
/*            ASSIGN                                                            */
/*               v-nombre_comprobante  = "  PEDIDO "                            */
/*               v-fgcolor_comprobante = 9                                      */
/*               v-bgcolor_comprobante = 15                                     */
/* /*               v-primera_letra       = "F*"        */                      */
/* /*               v-prefijo_contador    = "PRF*".     */                      */
/*                                                                              */
/*                                                                              */
/*        END.                                                                  */
/*     END.                                                                     */
/*                                                                              */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE cargar_conceptos C-Win 
PROCEDURE cargar_conceptos :
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
       T-Ped_header.cdg_imputacion:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = x-listas.      

       RUN getptovta_comprobante.p ( INPUT Tipocomprobante.cdg_comprobante, OUTPUT v-pto_venta ).
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

     RUN detalle_pedido.p ( INPUT T-Ped_detalle.nro_articulo,
                            INPUT T-Ped_detalle.nro_linea,
                            INPUT modo,
                            INPUT 1,
                            OUTPUT v-nro_linea,
                            INPUT-OUTPUT TABLE T-Ped_header,
                            INPUT-OUTPUT TABLE T-Ped_detalle,
                            INPUT-OUTPUT TABLE T-Ped_detalle-bon).

    IF v-nro_linea <> 0
    THEN DO:
          FIND FIRST T-Ped_header.
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

    RUN detalle_pedido.p ( INPUT  Articulo.nro_articulo,
                           INPUT  0, /* No sabemos el nro de linea */
                           INPUT  modo,
                           INPUT  0, /* modo detalle = CREAR */
                           OUTPUT v-nro_linea,
                           INPUT-OUTPUT TABLE T-Ped_header,
                           INPUT-OUTPUT TABLE T-Ped_detalle,
                           INPUT-OUTPUT TABLE T-Ped_detalle-bon
                           ).

    FIND FIRST T-Ped_header.

    IF v-nro_linea <> 0
    THEN DO:
         RUN calculos.
         RUN refrescar_browse.
         btn_copiar:SENSITIVE IN FRAME {&FRAME-NAME}        = NO.
         T-Ped_header.cdg_imputacion:SENSITIVE IN FRAME {&FRAME-NAME}        = NO.

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

  DO TRANSACTION:
    
      CREATE T-Ped_header.
      ASSIGN T-Ped_header.nro_usuario       = Usuario.nro_usuario 
             T-Ped_header.cdg_empresa       = Empresa.cdg_empresa
             T-Ped_header.fecha             = TODAY 
             T-Ped_header.fecha_carga       = T-Ped_header.fecha 
             T-Ped_header.fecha_embarque    = T-Ped_header.fecha 
             T-Ped_header.fecha_iva         = T-Ped_header.fecha 
             T-Ped_header.cdg_empresa       = Empresa.cdg_empresa 
             T-Ped_header.nro_deposito      = Deposito.nro_deposito 
             T-Ped_header.tip_comprob       = "" 
             T-Ped_header.nro_pedido        = 0 
             T-Ped_header.sin_cargo         = NO
             T-Ped_header.estado            = "E" 
             T-Ped_header.cdg_estado        = "AA"              
             T-Ped_header.nro_comprob       = T-Ped_header.nro_pedido
             T-Ped_header.prf_comprob       = v-pto_venta 
             T-Ped_header.nro_moneda        = Moneda.nro_moneda 
             T-Ped_header.cambio            = Moneda.cambio  
             T-Ped_header.cta_cte           = Imputacion.cta_cte
             T-Ped_header.num_sucursal      = sucursal-id    
             T-Ped_header.origen            = "M"
             T-Ped_header.cdg_comprobante   = Tipocomprobante.cdg_comprobante
             T-Ped_header.cdg_lineanegocio  = v-dfl_lineanegocio
             v-cdg_moneda                   = Moneda.cdg_moneda
             v-dsc_moneda                   = Moneda.descripcion
             T-Ped_header.cdg_imputacion    = Imputacion.cdg_imputacion 
             v-cdg_deposito                 = Deposito.cdg_deposito
             v-dsc_deposito                 = Deposito.nombre.

      IF SEARCH("cargar_copias_pedido.p") <> ? OR
         SEARCH("cargar_copias_pedido.r") <> ?
      THEN DO:
           RUN cargar_copias_pedido.p ( OUTPUT TABLE T-Copias_pedido).
      END.
      FIND FIRST T-Copias_pedido NO-ERROR.

  END.

  DISPLAY
         T-Ped_header.fecha 
         T-Ped_header.fecha_embarque
         T-Ped_header.cambio  
         T-Ped_header.cdg_estado
         T-Ped_header.cdg_lineanegocio
         T-Ped_header.cdg_imputacion
         v-cdg_moneda
         v-dsc_moneda      
         v-cdg_deposito
         v-dsc_deposito 
         v-pto_venta
         WITH FRAME {&FRAME-NAME}.

  codigo_salir = ?.

  IF    modo = MD_MULTIPLE
     OR modo = MD_ANULACION
     OR modo = MD_EMISION
  THEN DO:
       DO WITH FRAME {&FRAME-NAME}:
          
          T-Ped_header.tip_comprob:FGCOLOR = 9.
          T-Ped_header.tip_comprob:BGCOLOR = 15.

          T-Ped_header.prf_comprob:FGCOLOR = 9.
          T-Ped_header.prf_comprob:BGCOLOR = 15.
                    
          T-Ped_header.nro_comprob:FGCOLOR = 9.
          T-Ped_header.nro_comprob:BGCOLOR = 15.

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
  DISPLAY v-credito_maximo v-cdg_cliente v-pto_venta v-dsc_cliente 
          v-cdg_domicilio v-dsc_domicilio v-cdg_condicion_impos 
          v-dsc_condicion_impos v-cdg_condicion_venta v-dsc_condicion_venta 
          v-cdg_moneda v-dsc_moneda v-cdg_vendedor v-dsc_vendedor v-cdg_deposito 
          v-dsc_deposito v-cdg_lista_precios v-dsc_lista_precios v-cdg_articulo 
          v-credito_disponible v-credito_consumido 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE T-Ped_header THEN 
    DISPLAY T-Ped_header.clausula_dolar T-Ped_header.tip_comprob 
          T-Ped_header.prf_comprob T-Ped_header.nro_comprob T-Ped_header.fecha 
          T-Ped_header.cdg_estado T-Ped_header.permitir_cambio_domicilio 
          T-Ped_header.fecha_embarque T-Ped_header.nro_ocm 
          T-Ped_header.fecha_ocm T-Ped_header.cambio T-Ped_header.cdg_imputacion 
          T-Ped_header.modo_abasto T-Ped_header.cdg_lineanegocio 
          T-Ped_header.transportista T-Ped_header.imp_neto 
          T-Ped_header.imp_total T-Ped_header.cambio_dolar 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE T-Ped_header.clausula_dolar Btn_salir T-Ped_header.tip_comprob 
         T-Ped_header.prf_comprob T-Ped_header.permitir_cambio_domicilio 
         T-Ped_header.cdg_imputacion T-Ped_header.modo_abasto 
         T-Ped_header.cdg_lineanegocio BROWSE-2 T-Ped_header.cambio_dolar 
         RECT-2 RECT-3 RECT-4 RECT-5 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE evaluar_credito C-Win 
PROCEDURE evaluar_credito :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   DEFINE VARIABLE v-titulo_anterior AS CHARACTER.

   v-titulo_anterior = {&WINDOW-NAME}:TITLE.
   {&WINDOW-NAME}:TITLE = "Recuperando datos de crédito ...".

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
   
  {&WINDOW-NAME}:TITLE = v-titulo_anterior.

   v-credito_consumido = tot_credito.

   /*IF saldo_ccv <> 0 THEN RUN PONMENSJ.P ( INPUT "FACT021" ). modificado por mmo 30/05/05*/
   IF saldo_ccv > 0 THEN RUN PONMENSJ.P ( INPUT "FACT021" ).


   FIND LAST Creditomaximo OF Cliente 
    WHERE Creditomaximo.cdg_empresa = T-Ped_header.cdg_empresa
      AND Creditomaximo.desde_fecha <= T-Ped_header.fecha
          NO-LOCK NO-ERROR.

   IF AVAILABLE Creditomaximo 
   THEN DO:
        ASSIGN v-credito_maximo = Creditomaximo.credito_maximo
               v-credito_disponible = Creditomaximo.credito_maximo - tot_credito.
   END.
   ELSE DO:
        ASSIGN v-credito_maximo = 0
               v-credito_disponible = 0.
   END.

   DISPLAY v-credito_maximo
           v-credito_consumido
           WITH FRAME {&FRAME-NAME}.

   RUN poner_credito_disponible.

   /*IF v-credito_disponible <= 0 modificado por mmo 30/05/05 */
   IF v-credito_disponible < 0 
   THEN DO:
      RUN PONMENSJ.P ( INPUT "FACT020" ).
      /*RUN d-ver_estado_crediticio.w ( INPUT ROWID(Cliente)).*/
   END.


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
                T-Ped_header.tip_comprob:SENSITIVE        = NO
                T-Ped_header.prf_comprob:SENSITIVE        = NO
                T-Ped_header.nro_comprob:SENSITIVE        = NO
                T-Ped_header.fecha:SENSITIVE              = NO
                T-Ped_header.transportista:SENSITIVE      = NO
                T-Ped_header.cambio:SENSITIVE             = NO
                T-Ped_header.modo_abasto:SENSITIVE        = NO
                T-Ped_header.cdg_estado:SENSITIVE         = NO
                v-cdg_articulo:SENSITIVE                  = NO
                v-cdg_condicion_impos:SENSITIVE           = NO
                v-cdg_domicilio:SENSITIVE                 = NO
                T-Ped_header.cdg_imputacion:SENSITIVE     = NO
                v-cdg_moneda:SENSITIVE                    = NO
                v-cdg_cliente:SENSITIVE                   = NO
                v-cdg_vendedor:SENSITIVE                  = NO
                v-cdg_deposito:SENSITIVE                  = NO
                v-cdg_lista_precios:SENSITIVE             = NO
                btn_copiasxsector:SENSITIVE               = NO
                btn_porclasificacion:SENSITIVE            = NO
                btn_verbonificaciones:SENSITIVE           = NO.
     END.
     ELSE DO:
            CASE modo:
       
                WHEN MD_ALTA          
                THEN DO:
                     ASSIGN
                        
                        v-cdg_cliente:SENSITIVE                 = YES
                        v-pto_venta:SENSITIVE                   = YES.
         
                END.
                WHEN MD_MULTIPLE      
                THEN DO:
                     ASSIGN
                        T-Ped_header.tip_comprob:SENSITIVE        = YES
                        T-Ped_header.prf_comprob:SENSITIVE        = YES
                        T-Ped_header.nro_comprob:SENSITIVE        = YES
                        v-pto_venta:SENSITIVE                     = NO.

                END.
                WHEN MD_DEFINIDA      
                THEN DO:
                     ASSIGN
                        btn_verbonificaciones:SENSITIVE           = YES
                        v-pto_venta:SENSITIVE                     = NO.
         
                END.
                WHEN MD_RELACION      
                THEN DO:
                     ASSIGN
                        btn_verbonificaciones:SENSITIVE           = YES
                        v-pto_venta:SENSITIVE                     = NO.
         
                END.
                WHEN MD_READONLY      
                THEN DO:
                     ASSIGN
                        btn_verbonificaciones:SENSITIVE           = YES
                        v-pto_venta:SENSITIVE                     = NO.
         
                END.
                WHEN MD_CAMBIO        
                THEN DO:
                     ASSIGN
                        btn_verbonificaciones:SENSITIVE           = YES
                        v-pto_venta:SENSITIVE                     = NO.

                END.
                WHEN MD_ANULACION        
                THEN DO:
                     ASSIGN
                        T-Ped_header.tip_comprob:SENSITIVE        = YES
                        T-Ped_header.prf_comprob:SENSITIVE        = YES
                        T-Ped_header.nro_comprob:SENSITIVE        = YES
                        btn_verbonificaciones:SENSITIVE           = YES
                        v-pto_venta:SENSITIVE                     = NO.
                END.
                WHEN MD_EMISION        
                THEN DO:
                     ASSIGN
                        T-Ped_header.tip_comprob:SENSITIVE        = YES
                        T-Ped_header.prf_comprob:SENSITIVE        = YES
                        T-Ped_header.nro_comprob:SENSITIVE        = YES
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

   DEFINE VARIABLE texto_error AS CHARACTER.

   DO TRANSACTION:

       ASSIGN FRAME {&FRAME-NAME} v-pto_venta.
       
       ASSIGN T-Ped_header.tip_comprob = "PD"
              T-Ped_header.prf_comprob = v-pto_venta.
    
       RUN grabar_pedido.p ( INPUT TABLE T-Ped_header,
                             INPUT TABLE T-Ped_detalle,
                             INPUT TABLE T-Ped_header-bon,
                             INPUT TABLE T-Ped_detalle-bon,
                             INPUT TABLE T-Copias_pedido,
                             OUTPUT proceso-ok,
                             OUTPUT texto_error).
   END.
   IF proceso-ok <> YES
   THEN DO:
/*        MESSAGE "Hubo rechazos en el envío" SKIP                                                                  */
/*                "Verifique el archivo C:\SIC-TEMP\PEDIDO.TXT" VIEW-AS ALERT-BOX ERROR TITLE "Error de interface". */
       texto_error = REPLACE(texto_error,CHR(1),CHR(13) + CHR(13)).
       MESSAGE texto_error VIEW-AS ALERT-BOX ERROR TITLE "Error de interface".
   END.
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
          T-Ped_header.tip_comprob:SENSITIVE        = NO
          T-Ped_header.prf_comprob:SENSITIVE        = NO
          T-Ped_header.nro_comprob:SENSITIVE        = NO
          T-Ped_header.fecha:SENSITIVE              = NO
          T-Ped_header.fecha_embarque:SENSITIVE     = NO
          T-Ped_header.fecha_ocm:SENSITIVE          = NO
          T-Ped_header.nro_ocm:SENSITIVE            = NO
          T-Ped_header.cambio:SENSITIVE             = NO
          T-Ped_header.transportista:SENSITIVE      = NO
          T-Ped_header.cdg_estado:SENSITIVE         = NO
          T-Ped_header.cdg_lineanegocio:SENSITIVE             = NO
          T-Ped_header.permitir_cambio_domicilio:SENSITIVE    = NO
          v-cdg_articulo:SENSITIVE                  = NO
          v-cdg_condicion_impos:SENSITIVE           = NO
          v-cdg_domicilio:SENSITIVE                 = NO
          T-Ped_header.cdg_imputacion:SENSITIVE     = NO
          v-cdg_moneda:SENSITIVE                    = NO
          v-cdg_cliente:SENSITIVE                   = NO
          v-cdg_vendedor:SENSITIVE                  = NO
          v-cdg_deposito:SENSITIVE                  = NO
          v-cdg_lista_precios:SENSITIVE             = NO
          btn_verbonificaciones:SENSITIVE           = NO
          btn_copiasxsector:SENSITIVE               = NO
          btn_porclasificacion:SENSITIVE            = NO.

     CASE modo:

       WHEN MD_ALTA          
       THEN DO:
            ASSIGN
                T-Ped_header.tip_comprob:SENSITIVE        = NO
                T-Ped_header.prf_comprob:SENSITIVE        = NO
                T-Ped_header.nro_comprob:SENSITIVE        = NO
                T-ped_header.cdg_imputacion:SENSITIVE     = YES
                T-Ped_header.cdg_estado:SENSITIVE         = YES
                T-Ped_header.fecha:SENSITIVE              = YES
                T-Ped_header.fecha_embarque:SENSITIVE     = NO
                T-Ped_header.cdg_imputacion:SENSITIVE     = YES
                T-Ped_header.cambio:SENSITIVE             = YES
                T-Ped_header.transportista:SENSITIVE      = YES
                T-Ped_header.fecha_ocm:SENSITIVE          = YES
                T-Ped_header.nro_ocm:SENSITIVE            = YES
                T-Ped_header.modo_abasto:SENSITIVE        = T-Ped_header.modo_abasto <> "N" 
                T-Ped_header.clausula_dolar               = YES
                T-Ped_header.cambio_dolar                 = T-Ped_header.clausula_dolar:INPUT-VALUE
                v-cdg_articulo:SENSITIVE                  = YES
                v-cdg_condicion_impos:SENSITIVE           = NO
                v-cdg_condicion_venta:SENSITIVE           = YES
                v-cdg_domicilio:SENSITIVE                 = YES        
                v-cdg_moneda:SENSITIVE                    = YES
                v-cdg_cliente:SENSITIVE                   = NO
                v-cdg_vendedor:SENSITIVE                  = YES
                v-cdg_lista_precios:SENSITIVE             = NO
                v-cdg_deposito:SENSITIVE                  = NO
                btn_grabar:SENSITIVE                      = YES
                btn_copiar:SENSITIVE                      = YES
                btn_cancel:SENSITIVE                      = YES
                btn_anular:SENSITIVE                      = NO
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = NO
                btn_copiasxsector:SENSITIVE               = YES
                btn_porclasificacion:SENSITIVE            = YES
                btn_verbonificaciones:SENSITIVE           = YES.

       END.
       WHEN MD_MULTIPLE      
       THEN DO:
            ASSIGN
                btn_cancel:SENSITIVE                      = YES
                btn_observ:SENSITIVE                      = YES
/*                 btn_imprim:SENSITIVE                      = YES  */
                T-ped_header.cdg_imputacion:SENSITIVE     = NO
                T-Ped_header.tip_comprob:SENSITIVE        = NO
                T-Ped_header.prf_comprob:SENSITIVE        = NO
                T-Ped_header.nro_comprob:SENSITIVE        = NO
                btn_copiasxsector:SENSITIVE               = YES
                btn_verbonificaciones:SENSITIVE           = YES.
       END.
       WHEN MD_DEFINIDA      
       THEN DO:
            ASSIGN
                btn_observ:SENSITIVE                      = YES
/*                 btn_imprim:SENSITIVE                      = YES  */
                btn_copiasxsector:SENSITIVE               = YES
                btn_verbonificaciones:SENSITIVE           = YES.
       END.
       WHEN MD_RELACION      
       THEN DO:
            ASSIGN
                btn_observ:SENSITIVE                      = YES
/*                 btn_imprim:SENSITIVE                      = YES  */
                btn_copiasxsector:SENSITIVE               = YES
                btn_verbonificaciones:SENSITIVE           = YES.
       END.
       WHEN MD_READONLY      
       THEN DO:
            ASSIGN
                btn_observ:SENSITIVE                      = YES
/*                 btn_imprim:SENSITIVE                      = YES  */
                btn_copiasxsector:SENSITIVE               = YES
                btn_verbonificaciones:SENSITIVE           = YES.
       END.
       WHEN MD_CAMBIO        
       THEN DO:
            ASSIGN
                btn_observ:SENSITIVE                      = YES
/*                 btn_imprim:SENSITIVE                      = YES  */
                btn_copiasxsector:SENSITIVE               = YES
                btn_verbonificaciones:SENSITIVE           = YES.
       END.
       WHEN MD_ANULACION        
       THEN DO:
            ASSIGN
                btn_anular:SENSITIVE                      = YES
                btn_observ:SENSITIVE                      = YES
/*                 btn_imprim:SENSITIVE                      = YES  */
                btn_copiasxsector:SENSITIVE               = YES
                btn_verbonificaciones:SENSITIVE           = YES.
       END.
       WHEN MD_EMISION        
       THEN DO:
            ASSIGN
                btn_grabar:SENSITIVE                      = YES
                btn_observ:SENSITIVE                      = YES
/*                 btn_imprim:SENSITIVE                      = YES  */
                btn_copiasxsector:SENSITIVE               = YES
                btn_verbonificaciones:SENSITIVE           = YES.

       END.

    END CASE.     

  END.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE iniciar_combos C-Win 
PROCEDURE iniciar_combos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/


  DEFINE VARIABLE ok AS LOGICAL.
  DEFINE VARIABLE lista AS CHARACTER.

  DO WITH FRAME {&FRAME-NAME}:
         {levantacombo.i &TABLA=Lineanegocio &NOMBRE=dsc_lineanegocio &CODIGO=cdg_lineanegocio &OBJETO=T-Ped_header.cdg_lineanegocio &CONDICION=CAN-DO(Lineanegocio.lista_empresas,Empresa.cdg_empresa)}  
         {levantacombo.i &TABLA=Estado_pedido &NOMBRE=descripcion &CODIGO=cdg_estado &OBJETO=T-Ped_header.cdg_estado}
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

   /*
   RUN getptovta.p ( INPUT "PED",
                     OUTPUT v-pto_venta).
   */
                     
   RUN getptovta_comprobante.p ( INPUT Tipocomprobante.cdg_comprobante, OUTPUT v-pto_venta ).

   RUN getparametro.p (  INPUT  "CNDEUPED",
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

/*    RUN getparametro.p (  INPUT  "DFCNVENT",                             */
/*                          OUTPUT v-valor_c,                              */
/*                          OUTPUT v-valor_d,                              */
/*                          OUTPUT v-valor_l,                              */
/*                          OUTPUT v-valor_n,                              */
/*                          OUTPUT v-observacion ).                        */
/*                                                                         */
/*    FIND Imputacion WHERE Imputacion.cdg_imputacion = v-valor_n NO-LOCK. */

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


   RUN getparametro.p (  INPUT  "DFLINEGO",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).

   IF v-valor_c <> ?
       THEN FIND Lineanegocio WHERE Lineanegocio.cdg_lineanegocio = v-valor_c NO-LOCK.
       ELSE FIND FIRST Lineanegocio NO-LOCK.
    

   v-dfl_lineanegocio = Lineanegocio.cdg_lineanegocio.
/*   RUN iniciar_combos.     */

   RUN getparametro_l.p ( INPUT "HABAUTPD", OUTPUT v-control_habilitado ).

   RUN titulo_window ( "Pedidos de Clientes" ).

   /*
   IF modo <> MD_ALTA
       THEN RUN levantar_estados.
   */    

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE levantar_estados C-Win 
PROCEDURE levantar_estados :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE lista AS CHARACTER.

  lista = "".
  FOR EACH Estado_pedido:
      lista = lista +  "," +  Estado_pedido.descripcion + "," + Estado_pedido.cdg_estado.
  END.
  T-Ped_header.cdg_estado:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = SUBSTRING(lista,2).

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
 IF LOOKUP(Cliente.cdg_estado,"I") <> 0 
       THEN DO: 
             RUN PONMENSJ.P ( INPUT "CLIE051" ). 
             RETURN ERROR. 
 END. /* 13/05/05*/

  FIND Condicion_venta WHERE Condicion_venta.cdg_cndventa = Cliente.dfl_cndventa NO-LOCK.

  FIND Familia_cliente OF Cliente NO-LOCK.

  FIND Condicion_impos   OF Cliente NO-LOCK.
  v-tip_comprob = "PD".
  v-prox_docum = "PEDI" + STRING(pto_venta,"9999").
  
  ASSIGN
      T-Ped_header.cdg_condiva          = Condicion_impos.cdg_condiva
      T-Ped_header.nro_cndventa         = Condicion_venta.nro_cndventa
      T-Ped_header.nombre               = Cliente.nom_cliente
      T-Ped_header.cuit                 = Cliente.cuit
      T-Ped_header.nro_cliente          = Cliente.nro_cliente
      T-Ped_header.cdg_lista            = Cliente.dfl_lista
      T-Ped_header.nro_vendedor         = Cliente.nro_vendedor
      T-Ped_header.clausula_dolar       = Cliente.clausula_dolar
      T-Ped_header.tip_comprob          = v-tip_comprob.

  CASE Cliente.paga_abasto:
      WHEN "N" THEN T-Ped_header.modo_abasto = "N".  /* El cliente no paga abasto */
      WHEN "D" THEN T-Ped_header.modo_abasto = "S".  /* El cliente paga abasto a veces si y otras no */
      WHEN "S" THEN T-Ped_header.modo_abasto = "S".  /* El cliente siempre paga abasto */
  END CASE.

  RUN traer_cliente.
  RUN traer_condicion_venta.
  RUN traer_imputacion.
  RUN traer_condicion_impos.
  RUN traer_lista.
  RUN traer_vendedor.

  FOR EACH Cliente-bonificacion OF Cliente 
     WHERE Cliente-bonificacion.cdg_empresa = Empresa.cdg_empresa
       AND Cliente-bonificacion.desde_fecha <= T-Ped_header.fecha 
       AND Cliente-bonificacion.hasta_fecha >= T-Ped_header.fecha 
          NO-LOCK:
    
       CREATE T-Ped_header-bon.
       ASSIGN T-Ped_header-bon.cdg_bonificacion = Cliente-bonificacion.cdg_bonificacion
              T-Ped_header-bon.importe          = 0
              T-Ped_header-bon.nro_pedido       = T-Ped_header.nro_pedido
              T-Ped_header-bon.porcentaje       = Cliente-bonificacion.porcentaje.
  END.

  IF T-Ped_header.clausula_dolar
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

           T-Ped_header.tip_comprob
           T-Ped_header.modo_abasto
           T-Ped_header.fecha_embarque
           T-Ped_header.cdg_imputacion
           T-Ped_header.clausula_dolar
           T-Ped_header.cambio_dolar
           WITH FRAME {&FRAME-NAME}.

   FIND Domicilio OF Cliente NO-LOCK NO-ERROR.
   IF AVAILABLE Domicilio 
   THEN DO:
      FIND Provincia OF Domicilio NO-LOCK.
      ASSIGN  T-Ped_header.nro_domicilio = Domicilio.nro_domicilio
              T-Ped_header.direccion     = Domicilio.direccion
              T-Ped_header.cdg_provincia = Domicilio.cdg_provincia
              T-Ped_header.localidad     = Domicilio.localidad
              T-Ped_header.cdg_postal    = Domicilio.cdg_postal
              T-Ped_header.cdg_zonag     = Domicilio.cdg_zonag
              v-cdg_domicilio            = Domicilio.nro_domicilio
              v-dsc_domicilio            = Domicilio.nombre.
      DISABLE v-cdg_domicilio WITH FRAME {&FRAME-NAME}.      
   END.
   ELSE DO:  /* No hay ninguno o hay mas de uno */
      ASSIGN  T-Ped_header.nro_domicilio = 0
              T-Ped_header.direccion     = ""
              T-Ped_header.cdg_provincia = ""
              T-Ped_header.localidad     = ""
              T-Ped_header.cdg_postal    = ""
              T-Ped_header.cdg_zonag     = ""
              v-cdg_domicilio            = 0
              v-dsc_domicilio            = "".
      v-cdg_domicilio:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
   END.   

   DISPLAY v-cdg_domicilio
           v-dsc_domicilio
           WITH FRAME {&FRAME-NAME}.

   RUN habilitar_campos ( YES ).

   /*
   RUN calculos.   
   */
   
   IF v-control_habilitado
       THEN RUN evaluar_credito.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_credito_disponible C-Win 
PROCEDURE poner_credito_disponible :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  IF v-credito_disponible > 0
  THEN DO:
      
      ASSIGN v-credito_disponible:FGCOLOR IN FRAME {&FRAME-NAME} = 9
             v-credito_disponible:BGCOLOR IN FRAME {&FRAME-NAME} = 15
             T-Ped_header.cdg_estado = "AA".
  END.
  ELSE DO:
      ASSIGN v-credito_disponible:FGCOLOR IN FRAME {&FRAME-NAME} = 15
             v-credito_disponible:BGCOLOR IN FRAME {&FRAME-NAME} = 12
             T-Ped_header.cdg_estado = "D1".
  END.

  DISPLAY v-credito_disponible
          T-Ped_header.imp_neto 
          T-Ped_header.imp_total
          T-Ped_header.cdg_estado
          WITH FRAME {&FRAME-NAME}.


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

 FIND FIRST T-Ped_header EXCLUSIVE-LOCK.
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

 IF AVAILABLE Usuario THEN DO:
     {&WINDOW-NAME}:TITLE = "DYNASYS/FAC " + NRO_RELEASE + " - " + Usuario.cdg_empresa + " - " + v-txtitulo + " User:" + USERID("sic").
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

    FIND Cliente OF T-Ped_header NO-LOCK.
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

    FIND Condicion_impos  OF T-Ped_header NO-LOCK.
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

    FIND Condicion_venta  OF T-Ped_header NO-LOCK.
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

   FIND Ped_header WHERE ROWID(Ped_header) = rid_pedido NO-LOCK.
   BUFFER-COPY Ped_header TO T-Ped_header.

   FOR EACH Ped_detalle OF Ped_header:
       CREATE T-Ped_detalle.
       BUFFER-COPY Ped_detalle TO T-Ped_detalle.
   END.    

   FOR EACH Ped_header-bon  OF Ped_header:
       CREATE T-Ped_header-bon.
       BUFFER-COPY Ped_header-bon TO T-Ped_header-bon.
   END.
    
   FOR EACH Ped_detalle-bon  OF Ped_header:
       CREATE T-Ped_detalle-bon.
       BUFFER-COPY Ped_detalle-bon TO T-Ped_detalle-bon.
   END.
   
   FOR EACH Copias_pedido  WHERE Copias_pedido.nro_pedido = Ped_header.nro_pedido:
       CREATE T-Copias_pedido.
       BUFFER-COPY Copias_pedido TO T-Copias_pedido.
   END.

   FIND Sub_header_vta 
        WHERE Sub_header_vta.cdg_empresa = Ped_header.cdg_empresa
          AND Sub_header_vta.tip_comprob = Ped_header.tip_comprob
          AND Sub_header_vta.prf_comprob = Ped_header.prf_comprob
          AND Sub_header_vta.nro_comprob = Ped_header.nro_comprob
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
   
   RUN traer_tablas.
   DISPLAY
        T-Ped_header.cambio 
        T-Ped_header.fecha 
        T-Ped_header.fecha_ocm 
        T-Ped_header.fecha_embarque 
        T-Ped_header.nro_ocm
        T-Ped_header.imp_neto 
        T-Ped_header.imp_total 
        T-Ped_header.transportista 
        T-Ped_header.nro_comprob 
        T-Ped_header.prf_comprob 
        T-Ped_header.tip_comprob 
        T-Ped_header.transportista
        T-Ped_header.modo_abasto
        T-Ped_header.cdg_estado
        T-Ped_header.cdg_lineanegocio 
        T-Ped_header.cdg_imputacion
        T-Ped_header.permitir_cambio_domicilio
        v-cdg_condicion_impos 
        v-cdg_condicion_venta 
        v-cdg_domicilio 
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
        /*
        v-tip_remito WHEN v-tip_remito <> "" 
        v-prf_remito WHEN v-tip_remito <> "" 
        v-nro_remito WHEN v-tip_remito <> "" 
        */
        WITH FRAME {&FRAME-NAME}.

   RUN refrescar_browse.
       
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

    FIND Domicilio OF T-Ped_header NO-LOCK.
    ASSIGN
        v-cdg_domicilio = Domicilio.nro_domicilio
        v-dsc_domicilio = Domicilio.nombre.
    
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

    FIND FIRST Imputacion OF T-Ped_header NO-LOCK.
    ASSIGN
        T-Ped_header.cdg_imputacion = Imputacion.cdg_imputacion.
    
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

    FIND Lista_precios  OF T-Ped_header NO-LOCK.
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

    FIND Moneda    OF T-Ped_header   NO-LOCK.
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
/*
  FIND Rem_header WHERE Rem_header.nro_remito = Ped_header.nro_remito NO-LOCK NO-ERROR.
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
*/
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

    FIND Vendedor    OF T-Ped_header   NO-LOCK.
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
/*     {validartabla.i "Imputacion"        "cdg_imputacion"  "dsc_imputacion" "FAPR024"}  */

    /*
    {IFNOTEXS.I "Provincia" "cdg_provincia" "frm-documento" "T-Ped_header" "cdg_provincia " "FACT009"}
    */

    IF T-Ped_header.nombre = ""
    THEN DO:
       RUN PONMENSJ.P (INPUT "FACT027").
       RETURN.
    END.  
  
    IF T-Ped_header.cuit = ""
    THEN DO:
       RUN PONMENSJ.P (INPUT "FACT028").
       RETURN.
    END.  
  
    IF T-Ped_header.cambio = 0
    THEN DO:
       RUN PONMENSJ.P (INPUT "FACT029").
       RETURN.
    END.  
   
    IF ROWID(T-Ped_header) = ?
    THEN DO:
       RUN PONMENSJ.P (INPUT "FACT007").
       RETURN.
    END.
  
    IF NOT CAN-FIND(FIRST T-Ped_detalle OF T-Ped_header)
    THEN DO:
       RUN PONMENSJ.P (INPUT "FACT005").
       RETURN.
    END.
  
    /*
    IF T-Ped_header.cambio_dolar = 0
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
    ELSE DO:
       ASSIGN
           T-Ped_header.nro_domicilio = Domicilio.nro_domicilio
           T-Ped_header.direccion     = Domicilio.direccion
           T-Ped_header.cdg_provincia = Domicilio.cdg_provincia
           T-Ped_header.localidad     = Domicilio.localidad
           T-Ped_header.cdg_postal    = Domicilio.cdg_postal
           T-Ped_header.cdg_zonag     = Domicilio.cdg_zonag.
    END.
  
    /* Error 26 reservado para fecha invalida */

 
    IF NOT CAN-FIND(FIRST T-Ped_detalle OF  T-Ped_header)
    THEN DO:
       RUN PONMENSJ.P (INPUT "FAPR005").
       RETURN.
    END.

    IF max_lidet > 0 
    THEN DO:
        DEFINE VARIABLE kl AS INTEGER.
        kl = 0.
        FOR EACH T-Ped_detalle OF T-Ped_header:
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
        IF LENGTH(T-Ped_header.leyenda) > max_chley
        THEN DO:
           RUN PONMENSJ.P (INPUT "FACT035").
           RETURN.
        END.

    END.

    hubo_error = NO.

    &SCOPED-DEFINE TABLA-MAESTRA  T-Ped_header

    {asignartabla.i "Cliente"           "nro_cliente"     "nro_cliente"      }
    {asignartabla.i "Vendedor"          "nro_vendedor"    "nro_vendedor"     }
    {asignartabla.i "Deposito"          "nro_deposito"    "nro_deposito"     }
    {asignartabla.i "Lista_precios"     "cdg_lista"       "cdg_lista"        }
    {asignartabla.i "Condicion_impos"   "cdg_condiva"     "cdg_condiva"      }
    {asignartabla.i "Moneda"            "nro_moneda"      "nro_moneda"       }
    {asignartabla.i "Condicion_venta"   "nro_cndventa"    "nro_cndventa"     }
    {asignartabla.i "Imputacion"        "cdg_imputacion"  "cdg_imputacion"   }
 
    &UNDEFINE TABLA-MAESTRA


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

