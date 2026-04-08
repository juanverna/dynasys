&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win


/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Ped_detalle NO-UNDO LIKE Ped_detalle.
DEFINE TEMP-TABLE T-Ped_detalle-bon NO-UNDO LIKE Ped_detalle-bon.
DEFINE TEMP-TABLE T-Ped_detalle_impuesto NO-UNDO LIKE Ped_detalle_impuesto.
DEFINE TEMP-TABLE T-Ped_header NO-UNDO LIKE Ped_header.
DEFINE TEMP-TABLE T-Ped_header-bon NO-UNDO LIKE Ped_header-bon.
DEFINE TEMP-TABLE T-Ped_header_impuesto NO-UNDO LIKE Ped_header_impuesto.
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
DEFINE VARIABLE                modo          AS INTEGER.
&ELSE
DEFINE INPUT-OUTPUT PARAMETER  rid_pedido    AS ROWID.
DEFINE INPUT        PARAMETER  modo          AS INTEGER.
&ENDIF

/* Local Variable Definitions ---                                       */

{VRSHARED.I "NEW"}

{nrorelea.i}
{valoresmodo.i}
{valoressalida.i}

DEFINE VARIABLE v-prox_docum              LIKE Parametro.cdg_parametro.

DEFINE VARIABLE cotiza_dolar              AS DECIMAL.
DEFINE VARIABLE codigo_dolar              LIKE Moneda.cdg_moneda.
DEFINE VARIABLE v-tip_comprob             AS CHARACTER.
DEFINE VARIABLE dfl_leyenda               AS CHARACTER.
DEFINE VARIABLE prciva                    LIKE Impuesto.tasa FORMAT "Z,ZZZ,ZZ9.99-".

DEFINE VARIABLE sino-msg                  AS LOGICAL NO-UNDO.
DEFINE VARIABLE st_seleccionado           AS CHARACTER.
DEFINE VARIABLE rid_tabla                 AS ROWID.

DEFINE VARIABLE v-pto_venta-org           AS INTEGER.
DEFINE VARIABLE v-nro_linea               AS INTEGER.
DEFINE VARIABLE v-nro_cuenta              AS INTEGER.
DEFINE VARIABLE aux_importe               AS DECIMAL.
DEFINE VARIABLE codigo_iva                AS INTEGER INITIAL 1.
DEFINE VARIABLE hay_canje                 AS LOGICAL.
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
DEFINE VARIABLE v-ch-sinoferta            AS CHARACTER INITIAL "[Sin Oferta]".
DEFINE VARIABLE equiv_granel              LIKE Ped_detalle.granel.
DEFINE VARIABLE v-cdg_comprobante         LIKE Ped_header.cdg_comprobante.
DEFINE VARIABLE max_lidet                 AS INTEGER.

DEFINE TEMP-TABLE T-Color NO-UNDO
       FIELD nro_linea                    LIKE Ped_detalle.nro_linea
       FIELD nro_articulo                 LIKE Ped_detalle.nro_articulo
       FIELD nro_partida                  LIKE Ped_detalle.nro_partida
       FIELD precio                       LIKE Ped_detalle.precio
       FIELD cantidad_sol                 LIKE Ped_detalle.cantidad_sol
       FIELD granel_sol                   LIKE Ped_detalle.granel_sol
       INDEX por_linea nro_linea.

DEFINE TEMP-TABLE T-Sumador_oferta NO-UNDO
       FIELD numero_total       LIKE Oferta-rubro.numero_total
       FIELD importe_maximo     LIKE Oferta-rubro.importe_maximo
       FIELD importe_minimo     LIKE Oferta-rubro.importe_minimo
       FIELD tolerancia_importe LIKE Oferta-rubro.tolerancia_importe
       FIELD total_pesos  AS DECIMAL.

DEFINE BUFFER T-B-Ped_detalle    FOR T-Ped_detalle.
DEFINE BUFFER T-B-Sumador_oferta FOR T-Sumador_oferta.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME BRW-ARTICULOS

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Ped_detalle Articulo T-Color Partida ~
T-Ped_header

/* Definitions for BROWSE BRW-ARTICULOS                                 */
&Scoped-define FIELDS-IN-QUERY-BRW-ARTICULOS Articulo.cdg_articulo ~
Articulo.descripcion Articulo.cdg_umed T-Ped_detalle.cantidad_sol ~
T-Ped_detalle.precio 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BRW-ARTICULOS T-Ped_detalle.precio 
&Scoped-define ENABLED-TABLES-IN-QUERY-BRW-ARTICULOS T-Ped_detalle
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-BRW-ARTICULOS T-Ped_detalle
&Scoped-define QUERY-STRING-BRW-ARTICULOS FOR EACH T-Ped_detalle OF T-Ped_header ~
      WHERE T-Ped_detalle.nro_partida = 0  NO-LOCK, ~
      EACH Articulo OF T-Ped_detalle NO-LOCK
&Scoped-define OPEN-QUERY-BRW-ARTICULOS OPEN QUERY BRW-ARTICULOS FOR EACH T-Ped_detalle OF T-Ped_header ~
      WHERE T-Ped_detalle.nro_partida = 0  NO-LOCK, ~
      EACH Articulo OF T-Ped_detalle NO-LOCK.
&Scoped-define TABLES-IN-QUERY-BRW-ARTICULOS T-Ped_detalle Articulo
&Scoped-define FIRST-TABLE-IN-QUERY-BRW-ARTICULOS T-Ped_detalle
&Scoped-define SECOND-TABLE-IN-QUERY-BRW-ARTICULOS Articulo


/* Definitions for BROWSE BRW-COLORES                                   */
&Scoped-define FIELDS-IN-QUERY-BRW-COLORES Partida.cdg_partida T-Color.cantidad_sol   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BRW-COLORES T-Color.cantidad_sol   
&Scoped-define ENABLED-TABLES-IN-QUERY-BRW-COLORES T-Color
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-BRW-COLORES T-Color
&Scoped-define SELF-NAME BRW-COLORES
&Scoped-define QUERY-STRING-BRW-COLORES FOR EACH T-Color          WHERE T-Color.nro_linea = T-Ped_detalle.nro_linea, ~
       FIRST Partida OF T-Color                BY Partida.cdg_partida
&Scoped-define OPEN-QUERY-BRW-COLORES OPEN QUERY {&SELF-NAME}      FOR EACH T-Color          WHERE T-Color.nro_linea = T-Ped_detalle.nro_linea, ~
       FIRST Partida OF T-Color                BY Partida.cdg_partida.
&Scoped-define TABLES-IN-QUERY-BRW-COLORES T-Color Partida
&Scoped-define FIRST-TABLE-IN-QUERY-BRW-COLORES T-Color
&Scoped-define SECOND-TABLE-IN-QUERY-BRW-COLORES Partida


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define FIELDS-IN-QUERY-DEFAULT-FRAME T-Ped_header.tip_comprob ~
T-Ped_header.prf_comprob T-Ped_header.nro_comprob T-Ped_header.fecha ~
T-Ped_header.cdg_comprobante T-Ped_header.nro_ocm T-Ped_header.version ~
T-Ped_header.cambio T-Ped_header.transportista T-Ped_header.imp_neto ~
T-Ped_header.imp_total 
&Scoped-define ENABLED-FIELDS-IN-QUERY-DEFAULT-FRAME ~
T-Ped_header.tip_comprob T-Ped_header.prf_comprob T-Ped_header.version 
&Scoped-define ENABLED-TABLES-IN-QUERY-DEFAULT-FRAME T-Ped_header
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-DEFAULT-FRAME T-Ped_header
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-BRW-ARTICULOS}~
    ~{&OPEN-QUERY-BRW-COLORES}
&Scoped-define QUERY-STRING-DEFAULT-FRAME FOR EACH T-Ped_header SHARE-LOCK
&Scoped-define OPEN-QUERY-DEFAULT-FRAME OPEN QUERY DEFAULT-FRAME FOR EACH T-Ped_header SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-DEFAULT-FRAME T-Ped_header
&Scoped-define FIRST-TABLE-IN-QUERY-DEFAULT-FRAME T-Ped_header


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS T-Ped_header.tip_comprob ~
T-Ped_header.prf_comprob T-Ped_header.version 
&Scoped-define ENABLED-TABLES T-Ped_header
&Scoped-define FIRST-ENABLED-TABLE T-Ped_header
&Scoped-Define ENABLED-OBJECTS RECT-2 RECT-3 RECT-4 RECT-5 RECT-6 Btn_salir ~
v-pto_venta btn_verificar v-cdg_oferta v-cdg_articulo BRW-ARTICULOS ~
BRW-COLORES 
&Scoped-Define DISPLAYED-FIELDS T-Ped_header.tip_comprob ~
T-Ped_header.prf_comprob T-Ped_header.nro_comprob T-Ped_header.fecha ~
T-Ped_header.cdg_comprobante T-Ped_header.nro_ocm T-Ped_header.version ~
T-Ped_header.cambio T-Ped_header.transportista T-Ped_header.imp_neto ~
T-Ped_header.imp_total 
&Scoped-define DISPLAYED-TABLES T-Ped_header
&Scoped-define FIRST-DISPLAYED-TABLE T-Ped_header
&Scoped-Define DISPLAYED-OBJECTS v-pto_venta v-anulado v-cdg_cliente ~
v-dsc_cliente v-ultimo_pedido v-ultimo_estado v-cdg_domicilio ~
v-dsc_domicilio v-cdg_oferta v-cdg_condicion_venta v-dsc_condicion_venta ~
v-cdg_condicion_impos v-dsc_condicion_impos v-cdg_imputacion ~
v-dsc_imputacion v-cdg_moneda v-dsc_moneda v-cdg_vendedor v-dsc_vendedor ~
v-cdg_deposito v-dsc_deposito v-cdg_lista_precios v-dsc_lista_precios ~
v-cdg_articulo 

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

DEFINE BUTTON btn_leyenda 
     LABEL "Le&yenda" 
     SIZE 18 BY 1.33.

DEFINE BUTTON btn_observ 
     LABEL "&Observaciones" 
     SIZE 18 BY 1.33.

DEFINE BUTTON btn_porclasificacion 
     LABEL "Buscar &X Clasificación" 
     SIZE 35 BY 1.

DEFINE BUTTON Btn_salir DEFAULT 
     LABEL "&Salir" 
     SIZE 17 BY 1.33
     BGCOLOR 8 .

DEFINE BUTTON btn_transferir 
     LABEL "&Transferir" 
     SIZE 18 BY 1.33.

DEFINE BUTTON btn_verbonificaciones 
     LABEL "&Bonificaciones" 
     SIZE 21 BY 1.

DEFINE BUTTON btn_verificar 
     LABEL "Veri&ficar" 
     SIZE 21 BY 1.

DEFINE VARIABLE v-cdg_oferta AS CHARACTER FORMAT "X(256)":U 
     LABEL "Oferta" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "[Sin Oferta]" 
     DROP-DOWN-LIST
     SIZE 43 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-anulado AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 21 BY 1
     FGCOLOR 12 FONT 6 NO-UNDO.

DEFINE VARIABLE v-cdg_articulo AS CHARACTER FORMAT "X(10)" 
     LABEL "&Articulo" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 27 BY 1
     BGCOLOR 14 FGCOLOR 12 FONT 6.

DEFINE VARIABLE v-cdg_cliente AS CHARACTER FORMAT "X(8)" 
     LABEL "Cliente" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_condicion_impos AS INTEGER FORMAT "->,>>>,>>9" INITIAL 0 
     LABEL "C.Iva." 
     VIEW-AS FILL-IN NATIVE 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_condicion_venta AS CHARACTER FORMAT "X(8)" 
     LABEL "C.&Venta" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_deposito AS CHARACTER FORMAT "X(256)" 
     LABEL "Depósito" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_domicilio AS INTEGER FORMAT ">>>>>>9" INITIAL 0 
     LABEL "Domicilio" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_imputacion AS INTEGER FORMAT "->,>>>,>>9" INITIAL 0 
     LABEL "Imputación" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_lista_precios AS INTEGER FORMAT "->,>>>,>>9" INITIAL 0 
     LABEL "&Lista" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_moneda AS CHARACTER FORMAT "X(3)" 
     LABEL "Moneda" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_vendedor AS CHARACTER FORMAT "X(4)" 
     LABEL "Ve&ndedor" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-dsc_cliente AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 49 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_condicion_impos AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 29 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_condicion_venta AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 49 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_deposito AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 51 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_domicilio AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 49 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_imputacion AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 49 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_lista_precios AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 51 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_moneda AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 29 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_vendedor AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 49 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-pto_venta AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 6 NO-UNDO.

DEFINE VARIABLE v-ultimo_estado AS CHARACTER FORMAT "X(2)":U INITIAL "AA" 
     VIEW-AS FILL-IN 
     SIZE 7 BY 1
     BGCOLOR 15 FGCOLOR 12 FONT 6 NO-UNDO.

DEFINE VARIABLE v-ultimo_pedido AS INTEGER FORMAT ">>>>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15 FGCOLOR 12 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 96 BY 1.86.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 19 BY 1.86.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 155 BY 8.57.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 155 BY 1.43.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 39 BY 1.86.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BRW-ARTICULOS FOR 
      T-Ped_detalle, 
      Articulo SCROLLING.

DEFINE QUERY BRW-COLORES FOR 
      T-Color, 
      Partida SCROLLING.

DEFINE QUERY DEFAULT-FRAME FOR 
      T-Ped_header SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BRW-ARTICULOS
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BRW-ARTICULOS C-Win _STRUCTURED
  QUERY BRW-ARTICULOS NO-LOCK DISPLAY
      Articulo.cdg_articulo FORMAT "X(12)":U
      Articulo.descripcion FORMAT "X(38)":U WIDTH 65.4
      Articulo.cdg_umed FORMAT "X(12)":U
      T-Ped_detalle.cantidad_sol FORMAT "->>>,>>>,>>9.99":U
      T-Ped_detalle.precio FORMAT "->>,>>9.9999":U
  ENABLE
      T-Ped_detalle.precio
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 126 BY 14.05
         BGCOLOR 15 FGCOLOR 9 
         TITLE BGCOLOR 15 FGCOLOR 9 "Artículos Solicitados".

DEFINE BROWSE BRW-COLORES
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BRW-COLORES C-Win _FREEFORM
  QUERY BRW-COLORES DISPLAY
      Partida.cdg_partida COLUMN-LABEL "Código!Color" FORMAT "X(12)"
      T-Color.cantidad_sol FORMAT ">>>>>>9"
      ENABLE T-Color.cantidad_sol
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 26 BY 14.05
         BGCOLOR 15 FGCOLOR 9 
         TITLE BGCOLOR 15 FGCOLOR 9 "Subartículos del artículo actual".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btn_grabar AT ROW 1.48 COL 4
     btn_cancel AT ROW 1.48 COL 23
     btn_anular AT ROW 1.48 COL 42
     btn_leyenda AT ROW 1.48 COL 61
     btn_observ AT ROW 1.48 COL 80
     btn_copiar AT ROW 1.48 COL 101
     btn_transferir AT ROW 1.48 COL 120
     Btn_salir AT ROW 1.48 COL 141
     T-Ped_header.tip_comprob AT ROW 3.62 COL 15 COLON-ALIGNED
          LABEL "Pedido"
          VIEW-AS FILL-IN NATIVE 
          SIZE 5 BY 1
          BGCOLOR 7 FGCOLOR 15 
     T-Ped_header.prf_comprob AT ROW 3.62 COL 21 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 7 BY 1
          BGCOLOR 7 FGCOLOR 15 
     T-Ped_header.nro_comprob AT ROW 3.62 COL 29 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 13 BY 1
          BGCOLOR 7 FGCOLOR 15 
     v-pto_venta AT ROW 3.62 COL 43 COLON-ALIGNED NO-LABEL
     T-Ped_header.fecha AT ROW 3.62 COL 63 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 15 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Ped_header.cdg_comprobante AT ROW 3.62 COL 90 COLON-ALIGNED
          LABEL "Operación"
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Pedido","PEDIDCLI",
                     "Devolución","SOLDVCLI"
          DROP-DOWN-LIST
          SIZE 21 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-anulado AT ROW 3.62 COL 112 COLON-ALIGNED NO-LABEL
     v-cdg_cliente AT ROW 4.76 COL 15 COLON-ALIGNED
     v-dsc_cliente AT ROW 4.76 COL 29 COLON-ALIGNED NO-LABEL
     btn_verbonificaciones AT ROW 4.81 COL 92
     btn_verificar AT ROW 4.81 COL 114
     v-ultimo_pedido AT ROW 4.81 COL 135 COLON-ALIGNED NO-LABEL
     v-ultimo_estado AT ROW 4.81 COL 148 COLON-ALIGNED NO-LABEL
     v-cdg_domicilio AT ROW 6 COL 15 COLON-ALIGNED
     v-dsc_domicilio AT ROW 6 COL 29 COLON-ALIGNED NO-LABEL
     v-cdg_oferta AT ROW 6 COL 90 COLON-ALIGNED
     T-Ped_header.nro_ocm AT ROW 6 COL 141 COLON-ALIGNED
          LABEL "O/C"
          VIEW-AS FILL-IN NATIVE 
          SIZE 14 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_condicion_venta AT ROW 7.19 COL 15 COLON-ALIGNED
     v-dsc_condicion_venta AT ROW 7.19 COL 29 COLON-ALIGNED NO-LABEL
     v-cdg_condicion_impos AT ROW 7.19 COL 90 COLON-ALIGNED
     v-dsc_condicion_impos AT ROW 7.19 COL 104 COLON-ALIGNED NO-LABEL
     T-Ped_header.version AT ROW 7.19 COL 148 COLON-ALIGNED
          LABEL "Versión"
          VIEW-AS FILL-IN 
          SIZE 7 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_imputacion AT ROW 8.38 COL 15 COLON-ALIGNED
     v-dsc_imputacion AT ROW 8.38 COL 29 COLON-ALIGNED NO-LABEL
     v-cdg_moneda AT ROW 8.38 COL 90 COLON-ALIGNED
     v-dsc_moneda AT ROW 8.38 COL 104 COLON-ALIGNED NO-LABEL
     T-Ped_header.cambio AT ROW 8.38 COL 141 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 14 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_vendedor AT ROW 9.57 COL 15 COLON-ALIGNED
     v-dsc_vendedor AT ROW 9.57 COL 29 COLON-ALIGNED NO-LABEL
     v-cdg_deposito AT ROW 9.57 COL 90 COLON-ALIGNED
     v-dsc_deposito AT ROW 9.57 COL 104 COLON-ALIGNED NO-LABEL
     T-Ped_header.transportista AT ROW 10.71 COL 15 COLON-ALIGNED
          LABEL "&Transporte" FORMAT "X(75)"
          VIEW-AS FILL-IN NATIVE 
          SIZE 63 BY 1
          BGCOLOR 15 FGCOLOR 9 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 158 BY 27.14.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME DEFAULT-FRAME
     v-cdg_lista_precios AT ROW 10.76 COL 90 COLON-ALIGNED
     v-dsc_lista_precios AT ROW 10.86 COL 104 COLON-ALIGNED NO-LABEL
     v-cdg_articulo AT ROW 12.43 COL 15 COLON-ALIGNED
     btn_porclasificacion AT ROW 12.43 COL 45
     T-Ped_header.imp_neto AT ROW 12.43 COL 90 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 21 BY 1
          BGCOLOR 7 FGCOLOR 14 
     T-Ped_header.imp_total AT ROW 12.43 COL 134 COLON-ALIGNED
          LABEL "Total"
          VIEW-AS FILL-IN 
          SIZE 21 BY 1
          BGCOLOR 7 FGCOLOR 14 
     BRW-ARTICULOS AT ROW 14.1 COL 3
     BRW-COLORES AT ROW 14.1 COL 132
     "      Ultimo Pedido" VIEW-AS TEXT
          SIZE 21 BY .95 AT ROW 3.62 COL 137
          BGCOLOR 5 FGCOLOR 15 
     RECT-2 AT ROW 1.24 COL 3
     RECT-3 AT ROW 1.24 COL 140
     RECT-4 AT ROW 3.38 COL 3
     RECT-5 AT ROW 12.19 COL 3
     RECT-6 AT ROW 1.24 COL 100
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 158 BY 27.14.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Ped_detalle T "?" NO-UNDO sic Ped_detalle
      TABLE: T-Ped_detalle-bon T "?" NO-UNDO sic Ped_detalle-bon
      TABLE: T-Ped_detalle_impuesto T "?" NO-UNDO sic Ped_detalle_impuesto
      TABLE: T-Ped_header T "?" NO-UNDO sic Ped_header
      TABLE: T-Ped_header-bon T "?" NO-UNDO sic Ped_header-bon
      TABLE: T-Ped_header_impuesto T "?" NO-UNDO sic Ped_header_impuesto
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
         HEIGHT             = 27.14
         WIDTH              = 158
         MAX-HEIGHT         = 35.62
         MAX-WIDTH          = 204.8
         VIRTUAL-HEIGHT     = 35.62
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
   FRAME-NAME                                                           */
/* BROWSE-TAB BRW-ARTICULOS imp_total DEFAULT-FRAME */
/* BROWSE-TAB BRW-COLORES BRW-ARTICULOS DEFAULT-FRAME */
/* SETTINGS FOR BUTTON btn_anular IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_cancel IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_copiar IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_grabar IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_leyenda IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_observ IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_porclasificacion IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_transferir IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_verbonificaciones IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Ped_header.cambio IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX T-Ped_header.cdg_comprobante IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN T-Ped_header.fecha IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Ped_header.imp_neto IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Ped_header.imp_total IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN T-Ped_header.nro_comprob IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Ped_header.nro_ocm IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN T-Ped_header.tip_comprob IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN T-Ped_header.transportista IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL EXP-FORMAT                                       */
/* SETTINGS FOR FILL-IN v-anulado IN FRAME DEFAULT-FRAME
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
/* SETTINGS FOR FILL-IN v-cdg_imputacion IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_lista_precios IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_moneda IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_vendedor IN FRAME DEFAULT-FRAME
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
/* SETTINGS FOR FILL-IN v-dsc_imputacion IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_lista_precios IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_moneda IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_vendedor IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-ultimo_estado IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-ultimo_pedido IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Ped_header.version IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BRW-ARTICULOS
/* Query rebuild information for BROWSE BRW-ARTICULOS
     _TblList          = "Temp-Tables.T-Ped_detalle OF Temp-Tables.T-Ped_header,sic.Articulo OF Temp-Tables.T-Ped_detalle"
     _Options          = "NO-LOCK"
     _Where[1]         = "T-Ped_detalle.nro_partida = 0 "
     _FldNameList[1]   = sic.Articulo.cdg_articulo
     _FldNameList[2]   > sic.Articulo.descripcion
"Articulo.descripcion" ? "X(38)" "character" ? ? ? ? ? ? no ? no no "65.4" yes no no "U" "" ""
     _FldNameList[3]   = sic.Articulo.cdg_umed
     _FldNameList[4]   = Temp-Tables.T-Ped_detalle.cantidad_sol
     _FldNameList[5]   > Temp-Tables.T-Ped_detalle.precio
"T-Ped_detalle.precio" ? ? "decimal" ? ? ? ? ? ? yes ? no no ? yes no no "U" "" ""
     _Query            is OPENED
*/  /* BROWSE BRW-ARTICULOS */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BRW-COLORES
/* Query rebuild information for BROWSE BRW-COLORES
     _START_FREEFORM
OPEN QUERY {&SELF-NAME}
     FOR EACH T-Color
         WHERE T-Color.nro_linea = T-Ped_detalle.nro_linea, FIRST Partida OF T-Color
               BY Partida.cdg_partida.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE BRW-COLORES */
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


&Scoped-define BROWSE-NAME BRW-ARTICULOS
&Scoped-define SELF-NAME BRW-ARTICULOS
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BRW-ARTICULOS C-Win
ON DELETE-CHARACTER OF BRW-ARTICULOS IN FRAME DEFAULT-FRAME /* Artículos Solicitados */
DO:
    IF modo = MD_ALTA OR modo = MD_DEFINIDA
    THEN DO:
        sino-msg = NO.
        MESSAGE "Desea eliminar este renglón de detalle?" 
                VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
        IF sino-msg
        THEN DO:
             FOR EACH T-Color WHERE T-Color.nro_linea = T-Ped_detalle.nro_linea:
                 /*T-Color.upd_status = "D".*/
                 DELETE T-Color.
             END.                       
             /*T-Ped_detalle.upd_status = "D".*/
             DELETE T-Ped_detalle.
             RUN calculos.
             {&OPEN-QUERY-{&BROWSE-NAME}}
             RUN poner_colores.
        END.
    END.
    ELSE DO:
        BELL.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BRW-ARTICULOS C-Win
ON MOUSE-SELECT-DBLCLICK OF BRW-ARTICULOS IN FRAME DEFAULT-FRAME /* Artículos Solicitados */
OR RETURN OF {&BROWSE-NAME} IN FRAME {&FRAME-NAME}
DO:
    RUN corregir_detalle.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BRW-ARTICULOS C-Win
ON ROW-LEAVE OF BRW-ARTICULOS IN FRAME DEFAULT-FRAME /* Artículos Solicitados */
DO:
  IF BRW-ARTICULOS:CURRENT-ROW-MODIFIED
  THEN DO:
       T-Ped_detalle.precio = DECIMAL(T-Ped_detalle.precio:SCREEN-VALUE IN BROWSE BRW-ARTICULOS).
       RUN calculos.                                       
  END.        
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BRW-ARTICULOS C-Win
ON VALUE-CHANGED OF BRW-ARTICULOS IN FRAME DEFAULT-FRAME /* Artículos Solicitados */
DO:
  RUN poner_colores.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BRW-COLORES
&Scoped-define SELF-NAME BRW-COLORES
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BRW-COLORES C-Win
ON ROW-LEAVE OF BRW-COLORES IN FRAME DEFAULT-FRAME /* Subartículos del artículo actual */
DO:
    IF BRW-COLORES:CURRENT-ROW-MODIFIED
    THEN DO:
        T-Ped_detalle.cantidad_sol = T-Ped_detalle.cantidad_sol + 
                                     INTEGER(T-Color.cantidad_sol:SCREEN-VALUE IN BROWSE BRW-COLORES) -
                                     T-Color.cantidad_sol.
        T-Ped_detalle.cantidad     = T-Ped_detalle.cantidad_sol.

        DISPLAY T-Ped_detalle.cantidad_sol
                WITH BROWSE BRW-ARTICULOS.

        RUN calculos. 
    END.        
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


&Scoped-define SELF-NAME btn_grabar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_grabar C-Win
ON CHOOSE OF btn_grabar IN FRAME DEFAULT-FRAME /* Grabar */
DO:

  ASSIGN FRAME {&FRAME-NAME}
         T-Ped_header.cambio
         T-Ped_header.fecha
         T-Ped_header.transportista
         T-Ped_header.nro_ocm
         T-Ped_header.cdg_comprobante .
         
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


&Scoped-define SELF-NAME btn_leyenda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_leyenda C-Win
ON CHOOSE OF btn_leyenda IN FRAME DEFAULT-FRAME /* Leyenda */
DO:

   DEFINE VARIABLE puso_ok AS LOGICAL.
   RUN c-edttexto.w ( INPUT-OUTPUT T-Ped_header.leyenda,
                      INPUT "Leyenda del Pedido de Cliente",
                      INPUT modo,
                      OUTPUT puso_ok).
   RETURN NO-APPLY.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_observ
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_observ C-Win
ON CHOOSE OF btn_observ IN FRAME DEFAULT-FRAME /* Observaciones */
DO:
   DEFINE VARIABLE puso_ok AS LOGICAL.
   RUN c-edttexto.w ( INPUT-OUTPUT T-Ped_header.observacion,
                      INPUT "Observación del Pedido de Cliente",
                      INPUT modo,
                      OUTPUT puso_ok).
   RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_porclasificacion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_porclasificacion C-Win
ON CHOOSE OF btn_porclasificacion IN FRAME DEFAULT-FRAME /* Buscar X Clasificación */
DO:
  DEFINE VARIABLE que_clase   AS CHARACTER.
  DEFINE VARIABLE modo_salida AS INTEGER.
  RUN d-selclase_articulos.w ( INPUT-OUTPUT que_clase,
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


&Scoped-define SELF-NAME btn_transferir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_transferir C-Win
ON CHOOSE OF btn_transferir IN FRAME DEFAULT-FRAME /* Transferir */
DO:

  RUN d-selpedido_multiempresa.w  (INPUT "Selección de Pedidos Multiempresa", INPUT "*", INPUT "P*", INPUT-OUTPUT rid_pedido).
  IF rid_pedido <> ?
  THEN DO:
     FIND Ped_header WHERE ROWID(Ped_header) = rid_pedido NO-LOCK.
     DISPLAY Ped_header.nro_comprob @ T-Ped_header.nro_comprob
             WITH FRAME {&FRAME-NAME}.
     RUN copiar_documento.
  END.  
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_verbonificaciones
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_verbonificaciones C-Win
ON CHOOSE OF btn_verbonificaciones IN FRAME DEFAULT-FRAME /* Bonificaciones */
DO:
  
  RUN d-bonificaciones_pedido.w ( INPUT TABLE T-Ped_header,
                                  INPUT-OUTPUT TABLE T-Ped_header-bon, 
                                  INPUT modo ).
  RUN calculos.
  RUN poner_articulos.
  RUN poner_colores.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_verificar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_verificar C-Win
ON CHOOSE OF btn_verificar IN FRAME DEFAULT-FRAME /* Verificar */
DO:
   DEFINE VARIABLE v-cod AS CHARACTER.
   DEFINE VARIABLE v-nom AS CHARACTER.
   RUN validar_pedido ( OUTPUT v-cod ).
   FIND Estado_pedido WHERE Estado_pedido.cdg_estado = v-cod NO-LOCK.
   v-nom = Estado_pedido.descripcion.
   MESSAGE v-cod + "-" + v-nom 
           VIEW-AS ALERT-BOX MESSAGE TITLE "Estado de pedido". 
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Ped_header.cdg_comprobante
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Ped_header.cdg_comprobante C-Win
ON VALUE-CHANGED OF T-Ped_header.cdg_comprobante IN FRAME DEFAULT-FRAME /* Operación */
DO:
    RUN poner_imputacion.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Ped_header.fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Ped_header.fecha C-Win
ON LEAVE OF T-Ped_header.fecha IN FRAME DEFAULT-FRAME /* Fecha */
DO:
  ASSIGN FRAME {&FRAME-NAME} T-Ped_header.fecha.
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
          titulo_window = "Selección de Pedidos".
          lista_estados = "*".
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

  RUN d-seleccionar_pedido.w (INPUT titulo_window, INPUT lista_estados, INPUT "*", INPUT-OUTPUT rid_pedido).
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
ON ENTRY OF v-cdg_articulo IN FRAME DEFAULT-FRAME /* Articulo */
DO:
   
    v-cdg_articulo = "".
    DISPLAY v-cdg_articulo
            WITH FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_articulo C-Win
ON MOUSE-MENU-DOWN OF v-cdg_articulo IN FRAME DEFAULT-FRAME /* Articulo */
OR "+" OF v-cdg_articulo IN FRAME {&FRAME-NAME}
DO:
  
  DEFINE VARIABLE rid_articulo AS ROWID.
  RUN selartic.p ( INPUT-OUTPUT rid_articulo, "V", INPUT YES).
  IF rid_articulo <> ?
  THEN DO:
       FIND Articulo WHERE ROWID(Articulo) = rid_articulo NO-LOCK.
       DISPLAY Articulo.cdg_articulo @ v-cdg_articulo
               WITH FRAME {&FRAME-NAME}.
       APPLY "RETURN" TO SELF.
       RETURN NO-APPLY.
  END.             
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_articulo C-Win
ON RETURN OF v-cdg_articulo IN FRAME DEFAULT-FRAME /* Articulo */
DO:
    DEFINE VARIABLE cont AS INTEGER.
    DEFINE VARIABLE max_detalle AS INTEGER.
    DEFINE VARIABLE que_empresa AS CHARACTER.
    {findempresa.i}
   que_empresa = Empresa.cdg_empresa.
   
  FIND FIRST Articulo WHERE Articulo.cdg_articulo = INPUT FRAME {&FRAME-NAME} v-cdg_articulo
                      AND CAN-DO (Articulo.lista_empresas, que_empresa) NO-LOCK NO-ERROR.
  IF NOT AVAILABLE Articulo 
  THEN DO:
       RUN PONMENSJ.P ( 'CLIE020' ).
       RETURN NO-APPLY.
  END.
  ELSE DO:
        cont = 0.
        FOR EACH T-Ped_detalle:
            cont = cont + 1.       
        END.
    
        RUN getparametro.p (  INPUT  "MXDETPED",
             OUTPUT v-valor_c,
             OUTPUT v-valor_d,
             OUTPUT v-valor_l,
             OUTPUT v-valor_n,
             OUTPUT v-observacion ).
        max_detalle = v-valor_n.

        IF cont >= v-valor_n THEN DO:
            MESSAGE "El pedido supera el numero maximo de lineas (17)" VIEW-AS ALERT-BOX.
            RETURN NO-APPLY.
        END.

       
       FIND FIRST T-Ped_detalle WHERE T-Ped_detalle.nro_articulo = Articulo.nro_articulo NO-ERROR.
    
       RUN crear_detalle.
    
/*
       IF AVAILABLE T-Ped_detalle
       THEN DO:
            RUN situar_detalle.
       END.
       ELSE DO:     
            RUN crear_detalle.
       END.     
*/               
  END.

  v-cdg_articulo = "".
  DISPLAY v-cdg_articulo
          WITH FRAME {&FRAME-NAME}.
  
  APPLY "ENTRY" TO BRW-COLORES.
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

        FIND Cliente WHERE Cliente.cdg_cliente = INPUT FRAME {&FRAME-NAME} v-cdg_cliente NO-LOCK NO-ERROR.
        IF NOT AVAILABLE Cliente 
        THEN DO:
             RUN PONMENSJ.P ( 'IREF002' ).
             RETURN NO-APPLY.
        END.
        
        v-dsc_cliente = Cliente.nom_cliente.
        DISPLAY v-dsc_cliente 
                WITH FRAME {&FRAME-NAME}. 
        RUN poner_cliente.    
        APPLY "ENTRY" TO v-cdg_articulo IN FRAME {&FRAME-NAME}.
        RETURN NO-APPLY.
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
ON MOUSE-SELECT-DBLCLICK OF v-cdg_imputacion IN FRAME DEFAULT-FRAME /* Imputación */
OR "." OF v-cdg_imputacion IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_imputacion IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "imputacion" "cdg_imputacion" "SELCNDOC.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_imputacion C-Win
ON RETURN OF v-cdg_imputacion IN FRAME DEFAULT-FRAME /* Imputación */
DO:
   &SCOPED-DEFINE PONER-TABLA RUN asignar_imputacion.
   {traducetabla.i "imputacion" "cdg_imputacion" "dsc_imputacion"} 
   &UNDEFINE PONER-TABLA
   
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


&Scoped-define SELF-NAME v-cdg_oferta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_oferta C-Win
ON VALUE-CHANGED OF v-cdg_oferta IN FRAME DEFAULT-FRAME /* Oferta */
DO:
    IF v-cdg_oferta:SCREEN-VALUE IN FRAME {&FRAME-NAME} = v-ch-sinoferta
    THEN DO:
         T-Ped_header.cdg_oferta = "". 
    END.
    ELSE DO:
         FIND Oferta WHERE Oferta.dsc_oferta = v-cdg_oferta:SCREEN-VALUE IN FRAME {&FRAME-NAME} NO-LOCK.
         T-Ped_header.cdg_oferta = Oferta.cdg_oferta.
    END.
  
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


&Scoped-define BROWSE-NAME BRW-ARTICULOS
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
 
  IF modo = MD_DEFINIDA OR modo = MD_RELACION OR modo = MD_READONLY
     THEN DO:
      RUN traer_documento.
  END.
     ELSE RUN frame_sensitiva ( INPUT YES ).
  DISPLAY v-ultimo_pedido
          v-ultimo_estado
          WITH FRAME {&FRAME-NAME}.   
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE alta_datos C-Win 
PROCEDURE alta_datos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE v-prox_docum AS CHARACTER.
/*     DEFINE VARIABLE cont AS INTEGER.         */
/*     DEFINE VARIABLE max_detalle AS INTEGER.  */
    DO TRANSACTION:
    
       RUN validar_pedido ( OUTPUT T-Ped_header.cdg_estado ).

       ASSIGN FRAME {&FRAME-NAME} v-pto_venta.
       FIND Tipocomprobante OF T-Ped_header NO-LOCK.
       
       v-prox_docum = "PE" + Tipocomprobante.tip_comprob + STRING(v-pto_venta,"9999").

       FIND Parametro WHERE Parametro.cdg_parametro = v-prox_docum 
                        AND Parametro.cdg_empresa   = Empresa.cdg_empresa 
                            EXCLUSIVE-LOCK NO-ERROR.
  
       IF NOT AVAILABLE Parametro
       THEN DO:
            CREATE Parametro.
            ASSIGN Parametro.cdg_empresa   = Empresa.cdg_empresa
                   Parametro.cdg_parametro = v-prox_docum
                   Parametro.descripcion   = "Contador autoagregado por " + PROGRAM-NAME(1)
                   Parametro.observacion   = ""
                   Parametro.tipo          = "N"
                   Parametro.valor_n       = 1.
       END.         
  
       CREATE Ped_header.
       BUFFER-COPY T-Ped_header TO Ped_header
           ASSIGN  Ped_header.nro_pedido      = NEXT-VALUE(proxima_transaccion)
                   Ped_header.ultima_linea    = 0
                   Ped_header.tip_comprob     = Tipocomprobante.tip_comprob
                   Ped_header.prf_comprob     = v-pto_venta
                   Ped_header.nro_comprob     = Parametro.valor_n
                   Parametro.valor_n          = Parametro.valor_n + 1
                   v-cdg_comprobante          = T-Ped_header.cdg_comprobante.

       RUN bajar_detalle.

       RUN emitir_pedido.p ( ROWID(Ped_header)).
     
       RUN borrar_tablas_temporales.

       RELEASE Parametro.        
       
       v-ultimo_pedido = Ped_header.nro_comprob.
       v-ultimo_estado = Ped_header.cdg_estado.

       RELEASE Ped_header.
       RELEASE Ped_detalle.

   END.

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE asignar_imputacion C-Win 
PROCEDURE asignar_imputacion :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  T-Ped_header.cdg_imputacion = Imputacion.cdg_imputacion.
  T-Ped_header.cta_cte        = Imputacion.cta_cte.
  FIND Cuenta OF Imputacion NO-LOCK NO-ERROR.

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
                  FIND LAST Articulo_precio OF Articulo 
                       WHERE Articulo_precio.cdg_lista = Lista_precio.cdg_lista 
                         AND Articulo_precio.cdg_empresa = Empresa.cdg_empresa
                         AND Articulo_precio.fch_desde <= T-Ped_header.fecha
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE bajar_detalle C-Win 
PROCEDURE bajar_detalle :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   FOR EACH T-Ped_detalle:

       FOR EACH T-Color WHERE T-Color.nro_linea = T-Ped_detalle.nro_linea: 

            IF T-Color.cantidad_sol <> 0
            THEN DO:

                Ped_header.ultima_linea  = Ped_header.ultima_linea + 1.

                CREATE Ped_detalle.
                BUFFER-COPY T-Ped_detalle TO Ped_detalle
                            ASSIGN Ped_detalle.nro_pedido   = Ped_header.nro_pedido
                                   Ped_detalle.nro_linea    = Ped_header.ultima_linea
                                   Ped_detalle.cantidad     = T-Color.cantidad_sol
                                   Ped_detalle.cantidad_sol = T-Color.cantidad_sol
                                   Ped_detalle.cantidad_ult = T-Color.cantidad_sol
                                   Ped_detalle.granel       = T-Color.granel_sol
                                   Ped_detalle.granel_sol   = T-Color.granel_sol
                                   Ped_detalle.granel_ult   = T-Color.granel_sol
                                   Ped_detalle.nro_partida  = T-Color.nro_partida
                                   Ped_detalle.cdg_estado   = Ped_header.cdg_estado.

                CREATE Ped_detalle_entr.
                ASSIGN Ped_detalle_entr.cantidad            = Ped_detalle.cantidad_sol
                       Ped_detalle_entr.cdg_estado          = Ped_detalle.cdg_estado
                       Ped_detalle_entr.fecha_tardia        = Ped_header.fecha
                       Ped_detalle_entr.fecha_temprana      = Ped_header.fecha
                       Ped_detalle_entr.flete_estimado      = 0
                       Ped_detalle_entr.granel              = Ped_detalle.granel
                       Ped_detalle_entr.nro_entrega         = 1
                       Ped_detalle_entr.nro_linea           = Ped_detalle.nro_linea
                       Ped_detalle_entr.nro_linea_remito    = 0
                       Ped_detalle_entr.nro_pedido          = Ped_header.nro_pedido
                       Ped_detalle_entr.nro_remito          = 0
                       Ped_detalle_entr.precio              = Ped_detalle.precio
                       Ped_detalle_entr.ultima_cantidad     = Ped_detalle.cantidad
                       Ped_detalle_entr.ultimo_granel       = Ped_detalle.granel.      
                        
             END.

       END.

   END.

   FOR EACH T-Ped_header-bon:
       CREATE Ped_header-bon.
       BUFFER-COPY T-Ped_header-bon TO Ped_header-bon
           ASSIGN  Ped_header-bon.nro_pedido = Ped_header.nro_pedido.
   END.

   FOR EACH T-Ped_detalle-bon:
       CREATE Ped_detalle-bon.
       BUFFER-COPY T-Ped_detalle-bon TO Ped_detalle-bon
           ASSIGN  Ped_detalle-bon.nro_pedido = Ped_header.nro_pedido.
   END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE borrar_detalle_actual C-Win 
PROCEDURE borrar_detalle_actual :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

       FOR EACH Ped_detalle OF Ped_header:
           DELETE Ped_detalle.
       END.

       FOR EACH Ped_detalle_entr OF Ped_header:
           DELETE Ped_detalle_entr.
       END.

       FOR EACH Ped_header-bon OF Ped_header:
           DELETE Ped_header-bon.
       END.

       FOR EACH Ped_detalle-bon OF Ped_header:
           DELETE Ped_detalle-bon.
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

    EMPTY TEMP-TABLE T-Color NO-ERROR.
    EMPTY TEMP-TABLE T-Ped_detalle NO-ERROR.
    EMPTY TEMP-TABLE T-Ped_header NO-ERROR.
    EMPTY TEMP-TABLE T-Ped_detalle-bon NO-ERROR.
    EMPTY TEMP-TABLE T-Ped_header-bon NO-ERROR.
    EMPTY TEMP-TABLE T-Sub_header_vta NO-ERROR.
    EMPTY TEMP-TABLE T-Sub_detalle_vta NO-ERROR.

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

  EMPTY TEMP-TABLE T-Sub_header_vta.
  EMPTY TEMP-TABLE T-Sub_detalle_vta.

  RUN calcular_pedido.p (INPUT-OUTPUT TABLE T-Ped_header,
                         INPUT TABLE T-Ped_detalle,
                         INPUT TABLE T-Sub_header_vta,
                         INPUT TABLE T-Sub_detalle_vta,
                         INPUT TABLE T-Ped_header-bon,
                         INPUT TABLE T-Ped_detalle-bon,
                         INPUT TABLE T-Ped_header_impuesto,
                         INPUT TABLE T-Ped_detalle_impuesto,
                         INPUT "IMPUESTOS=SI").  

  FIND FIRST T-Ped_header.

  DISPLAY T-Ped_header.imp_neto 
          T-Ped_header.imp_total
          WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE copiar_documento C-Win 
PROCEDURE copiar_documento :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   FIND Ped_header WHERE ROWID(Ped_header) = rid_pedido NO-LOCK.
   BUFFER-COPY Ped_header TO T-Ped_header
        ASSIGN T-Ped_header.nro_usuario    = Usuario.nro_usuario 
               T-Ped_header.cdg_empresa    = Empresa.cdg_empresa
               T-Ped_header.fecha          = TODAY 
               T-Ped_header.fecha_alta     = T-Ped_header.fecha 
               T-Ped_header.nro_deposito   = Deposito.nro_deposito 
               T-Ped_header.tip_comprob    = "" 
               T-Ped_header.nro_pedido     = 0  
               T-Ped_header.estado         = "E" 
               T-Ped_header.cdg_estado     = "AA"              
               T-Ped_header.nro_comprob    = T-Ped_header.nro_pedido
               T-Ped_header.prf_comprob    = 0 /* v-pto_venta */
               T-Ped_header.nro_moneda     = Moneda.nro_moneda 
               T-Ped_header.cambio         = Moneda.cambio  
               T-Ped_header.cdg_imputacion = Imputacion.cdg_imputacion
               T-Ped_header.cta_cte        = Imputacion.cta_cte
               T-Ped_header.num_sucursal   = sucursal-id    
               T-Ped_header.origen         = "M"
               T-Ped_header.ultima_linea   = 0
               v-cdg_moneda                = Moneda.cdg_moneda
               v-dsc_moneda                = Moneda.descripcion
               v-cdg_imputacion            = Imputacion.cdg_imputacion
               v-dsc_imputacion            = Imputacion.dsc_imputacion 
               v-cdg_deposito              = Deposito.cdg_deposito
               v-dsc_deposito              = Deposito.nombre. 

   FOR EACH Ped_detalle OF Ped_header, Articulo OF Ped_detalle BREAK BY Articulo.cdg_articulo 
                                                                     BY Ped_detalle.precio DESCENDING:
       
       IF FIRST-OF(Ped_detalle.precio)
       THEN DO:

            CREATE T-Ped_detalle.
            ASSIGN T-Ped_header.ultima_linea      = T-Ped_header.ultima_linea + 1
                   T-Ped_detalle.nro_articulo     = Articulo.nro_articulo
                   T-Ped_detalle.nro_linea        = T-Ped_header.ultima_linea
                   T-Ped_detalle.nro_partida      = 0
                   T-Ped_detalle.precio           = Ped_detalle.precio.

            FOR EACH Partida OF Articulo:
          
                CREATE T-Color.
                ASSIGN T-Color.nro_linea        = T-Ped_detalle.nro_linea
                       T-Color.nro_articulo     = Articulo.nro_articulo
                       T-Color.nro_partida      = Partida.nro_partida
                       T-Color.precio           = T-Ped_detalle.precio.

            END. 

       END.
       
       FIND T-Color WHERE T-Color.nro_articulo = Ped_detalle.nro_articulo
                      AND T-Color.nro_partida  = Ped_detalle.nro_partida
                      AND T-Color.precio       = Ped_detalle.precio
                          EXCLUSIVE-LOCK.

       ASSIGN T-Color.cantidad = Ped_detalle.cantidad.

       FIND FIRST T-Ped_detalle 
            WHERE T-Ped_detalle.nro_articulo     = Articulo.nro_articulo
              AND T-Ped_detalle.precio           = Ped_detalle.precio.
              
       T-Ped_detalle.cantidad     = T-Ped_detalle.cantidad     + Ped_detalle.cantidad.
       T-Ped_detalle.cantidad_sol = T-Ped_detalle.cantidad_sol + Ped_detalle.cantidad_sol.

   END.    

   FOR EACH Ped_header-bon  OF Ped_header:
       CREATE T-Ped_header-bon.
       BUFFER-COPY Ped_header-bon TO T-Ped_header-bon
                   ASSIGN T-Ped_header-bon.nro_pedido     = 0.

   END.
    
   FOR EACH Ped_detalle-bon  OF Ped_header:
       CREATE T-Ped_detalle-bon.
       BUFFER-COPY Ped_detalle-bon TO T-Ped_detalle-bon
                   ASSIGN T-Ped_detalle-bon.nro_pedido     = 0.
   END.

   /*
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
   */
   
   v-anulado = IF Ped_header.anulado THEN "ANULADO" ELSE "".

   RUN traer_tablas.
   DISPLAY
        T-Ped_header.cambio 
        T-Ped_header.fecha 
        T-Ped_header.imp_neto 
        T-Ped_header.imp_total 
        T-Ped_header.transportista 
        T-Ped_header.nro_comprob 
        T-Ped_header.prf_comprob 
        T-Ped_header.tip_comprob 
        v-cdg_condicion_impos 
        v-cdg_condicion_venta 
        v-cdg_domicilio 
        v-cdg_imputacion 
        v-cdg_moneda 
        v-cdg_cliente 
        v-cdg_lista_precios 
        v-cdg_deposito 
        v-cdg_vendedor 
        v-dsc_condicion_impos 
        v-dsc_condicion_venta
        v-dsc_domicilio 
        v-dsc_imputacion 
        v-dsc_moneda 
        v-dsc_cliente 
        v-dsc_lista_precios 
        v-dsc_deposito 
        v-dsc_vendedor 
        v-anulado
        v-cdg_oferta
        WITH FRAME {&FRAME-NAME}.

   RUN poner_articulos.
   RUN poner_colores.
   RUN calculos.
       
   RUN habilitar_campos ( INPUT YES ).
   
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

     RUN d-bonificaciones_detalle.w ( INPUT T-Ped_detalle.nro_articulo,
                                      INPUT T-Ped_detalle.nro_linea,
                                      INPUT modo,
                                      INPUT 1,
                                      OUTPUT v-nro_linea,
                                      INPUT TABLE T-Ped_header,
                                      INPUT TABLE T-Ped_detalle,
                                      INPUT-OUTPUT TABLE T-Ped_detalle-bon).

    IF v-nro_linea <> 0
    THEN DO:
          FIND FIRST T-Ped_header.
          RUN calculos.
          /*RUN refrescar_browse.*/
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE crear_colores C-Win 
PROCEDURE crear_colores :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FOR EACH Partida OF Articulo WHERE Partida.cdg_empresa = T-Ped_header.cdg_empresa:
    
      CREATE T-Color.
      ASSIGN T-Color.nro_linea        = T-Ped_detalle.nro_linea
             T-Color.precio           = T-Ped_detalle.precio
             T-Color.nro_articulo     = Articulo.nro_articulo
             T-Color.nro_partida      = Partida.nro_partida.

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

  DEFINE VARIABLE rid_detalle AS ROWID.
  DEFINE VARIABLE que_empresa AS CHARACTER.

  {findempresa.i}

  que_empresa = Empresa.cdg_empresa.
   
  DO TRANSACTION:

      FIND FIRST Articulo WHERE Articulo.cdg_articulo = INPUT FRAME {&FRAME-NAME} v-cdg_articulo 
                            AND CAN-DO (Articulo.lista_empresas, que_empresa) 
                                NO-LOCK NO-ERROR.

      IF AVAILABLE Articulo 
      THEN DO:
    
          FIND LAST Articulo_precio 
             WHERE Articulo_precio.nro_articulo = Articulo.nro_articulo
               AND Articulo_precio.cdg_empresa  = Empresa.cdg_empresa
               AND Articulo_precio.cdg_lista    = Lista_precio.cdg_lista
               AND Articulo_precio.fch_desde <= T-Ped_header.fecha
                   NO-LOCK NO-ERROR.
          IF AVAILABLE Articulo_precio 
          THEN DO:
    
              T-Ped_header.ultima_linea = T-Ped_header.ultima_linea + 1.
          
              CREATE T-Ped_detalle.
              ASSIGN T-Ped_detalle.nro_articulo     = Articulo.nro_articulo
                     T-Ped_detalle.nro_pedido       = T-Ped_header.nro_pedido
                     T-Ped_detalle.nro_linea        = T-Ped_header.ultima_linea
                     T-Ped_detalle.nro_partida      = 0
                     T-Ped_detalle.precio           = Articulo_precio.precio.
    
              rid_detalle = ROWID(T-Ped_detalle).
    
              RUN crear_colores.
            
              RUN poner_articulos.
              REPOSITION BRW-ARTICULOS TO ROWID rid_detalle.
              RUN poner_colores.
    
          END.
          ELSE DO:
              MESSAGE "el precio del articulo no esta disponible" VIEW-AS ALERT-BOX.
          END.
      END.
      ELSE DO:
          MESSAGE "El articulo seleccionado no esta habilitado para la lista seleccionada" VIEW-AS ALERT-BOX.
      END.

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
             T-Ped_header.fecha_alta        = T-Ped_header.fecha 
             T-Ped_header.fecha_iva         = T-Ped_header.fecha 
             T-Ped_header.cdg_empresa       = Empresa.cdg_empresa 
             T-Ped_header.nro_deposito      = Deposito.nro_deposito 
             T-Ped_header.tip_comprob       = "" 
             T-Ped_header.nro_pedido        = 0  
             T-Ped_header.estado            = "E" 
             T-Ped_header.cdg_estado        = "AA"   
             T-Ped_header.cdg_comprobante   = v-cdg_comprobante
             T-Ped_header.nro_comprob       = T-Ped_header.nro_pedido
             T-Ped_header.prf_comprob       = 0 /* v-pto_venta */
             T-Ped_header.nro_moneda        = Moneda.nro_moneda 
             T-Ped_header.cambio            = Moneda.cambio  
             T-Ped_header.cdg_imputacion    = Imputacion.cdg_imputacion
             T-Ped_header.cta_cte           = Imputacion.cta_cte
             T-Ped_header.num_sucursal      = sucursal-id    
             T-Ped_header.origen            = "M"
             v-cdg_moneda                   = Moneda.cdg_moneda
             v-dsc_moneda                   = Moneda.descripcion
             v-cdg_imputacion               = Imputacion.cdg_imputacion
             v-dsc_imputacion               = Imputacion.dsc_imputacion 
             v-cdg_deposito                 = Deposito.cdg_deposito
             v-dsc_deposito                 = Deposito.nombre. 

  END.

  v-cdg_oferta = v-ch-sinoferta.

  DISPLAY
         T-Ped_header.fecha   
         T-Ped_header.cambio  
         T-Ped_header.cdg_comprobante  
         v-cdg_imputacion
         v-dsc_imputacion
         v-cdg_moneda
         v-dsc_moneda      
         v-cdg_deposito
         v-dsc_deposito 
         v-cdg_oferta
         WITH FRAME {&FRAME-NAME}.

  codigo_salir = ?.

  IF    modo = MD_MULTIPLE
     OR modo = MD_ANULACION
     OR modo = MD_EMISION
     OR modo = MD_CAMBIO
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
  DISPLAY v-pto_venta v-anulado v-cdg_cliente v-dsc_cliente v-ultimo_pedido 
          v-ultimo_estado v-cdg_domicilio v-dsc_domicilio v-cdg_oferta 
          v-cdg_condicion_venta v-dsc_condicion_venta v-cdg_condicion_impos 
          v-dsc_condicion_impos v-cdg_imputacion v-dsc_imputacion v-cdg_moneda 
          v-dsc_moneda v-cdg_vendedor v-dsc_vendedor v-cdg_deposito 
          v-dsc_deposito v-cdg_lista_precios v-dsc_lista_precios v-cdg_articulo 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE T-Ped_header THEN 
    DISPLAY T-Ped_header.tip_comprob T-Ped_header.prf_comprob 
          T-Ped_header.nro_comprob T-Ped_header.fecha 
          T-Ped_header.cdg_comprobante T-Ped_header.nro_ocm T-Ped_header.version 
          T-Ped_header.cambio T-Ped_header.transportista T-Ped_header.imp_neto 
          T-Ped_header.imp_total 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE RECT-2 RECT-3 RECT-4 RECT-5 RECT-6 Btn_salir T-Ped_header.tip_comprob 
         T-Ped_header.prf_comprob v-pto_venta btn_verificar v-cdg_oferta 
         T-Ped_header.version v-cdg_articulo BRW-ARTICULOS BRW-COLORES 
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
                btn_transferir:SENSITIVE                  = NO
                btn_cancel:SENSITIVE                      = NO
                btn_leyenda:SENSITIVE                      = NO
                /*
                btn_anular:SENSITIVE                      = NO
                btn_imprim:SENSITIVE                      = NO
                */
                T-Ped_header.tip_comprob:SENSITIVE        = NO
                T-Ped_header.prf_comprob:SENSITIVE        = NO
                T-Ped_header.nro_comprob:SENSITIVE        = NO
                T-Ped_header.fecha:SENSITIVE              = NO
                T-Ped_header.transportista:SENSITIVE      = NO
                T-Ped_header.cdg_comprobante:SENSITIVE    = NO
                T-Ped_header.nro_ocm:SENSITIVE            = NO
                T-Ped_header.cambio:SENSITIVE             = NO
                v-cdg_articulo:SENSITIVE                  = NO
                v-cdg_condicion_impos:SENSITIVE           = NO
                v-cdg_domicilio:SENSITIVE                 = NO
                v-cdg_imputacion:SENSITIVE                = NO
                v-cdg_moneda:SENSITIVE                    = NO
                v-cdg_cliente:SENSITIVE                   = NO
                v-cdg_oferta:SENSITIVE                    = NO
                v-cdg_vendedor:SENSITIVE                  = NO
                v-cdg_deposito:SENSITIVE                  = NO
                v-cdg_lista_precios:SENSITIVE             = NO
                btn_porclasificacion:SENSITIVE            = NO
                btn_verbonificaciones:SENSITIVE           = NO.
     END.
     ELSE DO:

            RUN frame_sensitiva ( NO ).

            CASE modo:
       
                WHEN MD_ALTA          
                THEN DO:
                     ASSIGN
                        btn_transferir:SENSITIVE                = YES
                        v-cdg_cliente:SENSITIVE                 = YES
                        v-cdg_oferta:SENSITIVE                  = YES.

                END.
                WHEN MD_MULTIPLE      
                THEN DO:
                     ASSIGN
                        T-Ped_header.tip_comprob:SENSITIVE        = YES
                        T-Ped_header.prf_comprob:SENSITIVE        = YES
                        T-Ped_header.nro_comprob:SENSITIVE        = YES.

                END.
                WHEN MD_DEFINIDA      
                THEN DO:
                     ASSIGN
                        btn_verbonificaciones:SENSITIVE           = YES.
         
                END.
                WHEN MD_RELACION      
                THEN DO:
                     ASSIGN
                        btn_verbonificaciones:SENSITIVE           = YES.
         
                END.
                WHEN MD_READONLY      
                THEN DO:
                     ASSIGN
                        btn_verbonificaciones:SENSITIVE           = YES.
         
                END.
                WHEN MD_CAMBIO        
                THEN DO:
                     ASSIGN
                        T-Ped_header.tip_comprob:SENSITIVE        = YES
                        T-Ped_header.prf_comprob:SENSITIVE        = YES
                        T-Ped_header.nro_comprob:SENSITIVE        = YES
                        btn_verbonificaciones:SENSITIVE           = YES.

                END.
                WHEN MD_ANULACION        
                THEN DO:
                     ASSIGN
                        T-Ped_header.tip_comprob:SENSITIVE        = YES
                        T-Ped_header.prf_comprob:SENSITIVE        = YES
                        T-Ped_header.nro_comprob:SENSITIVE        = YES
                        btn_verbonificaciones:SENSITIVE           = YES.
                END.
                WHEN MD_EMISION        
                THEN DO:
                     ASSIGN
                        T-Ped_header.tip_comprob:SENSITIVE        = YES
                        T-Ped_header.prf_comprob:SENSITIVE        = YES
                        T-Ped_header.nro_comprob:SENSITIVE        = YES
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

  IF modo = MD_ALTA OR modo = MD_GENERADO
      THEN RUN alta_datos.
      ELSE RUN regrabar_datos.

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
          btn_transferir:SENSITIVE                  = NO
          btn_copiar:SENSITIVE                      = NO
          btn_cancel:SENSITIVE                      = NO
          btn_leyenda:SENSITIVE                     = NO
          btn_observ:SENSITIVE                      = NO
          /*
          btn_imprim:SENSITIVE                      = NO
          */
          T-Ped_header.tip_comprob:SENSITIVE        = NO
          T-Ped_header.prf_comprob:SENSITIVE        = NO
          T-Ped_header.nro_comprob:SENSITIVE        = NO
          T-Ped_header.fecha:SENSITIVE              = NO
          T-Ped_header.cambio:SENSITIVE             = NO
          T-Ped_header.transportista:SENSITIVE      = NO
          T-Ped_header.cdg_comprobante:SENSITIVE    = NO
          T-Ped_header.nro_ocm:SENSITIVE            = NO
          v-cdg_articulo:SENSITIVE                  = NO
          v-cdg_condicion_impos:SENSITIVE           = NO
          v-cdg_domicilio:SENSITIVE                 = NO
          v-cdg_imputacion:SENSITIVE                = NO
          v-cdg_moneda:SENSITIVE                    = NO
          v-cdg_cliente:SENSITIVE                   = NO
          v-cdg_vendedor:SENSITIVE                  = NO
          v-cdg_deposito:SENSITIVE                  = NO
          v-cdg_lista_precios:SENSITIVE             = NO
          btn_verbonificaciones:SENSITIVE           = NO
          btn_porclasificacion:SENSITIVE            = NO.

     CASE modo:

       WHEN MD_ALTA          
       THEN DO:
            /*
            ASSIGN
                btn_cancel:SENSITIVE                      = YES
                btn_leyenda:SENSITIVE                      = YES
                v-cdg_cliente:SENSITIVE                   = NO
                btn_transferir:SENSITIVE                  = NO
            /*  btn_imprim:SENSITIVE                      = YES */
                T-Ped_header.tip_comprob:SENSITIVE        = NO
                T-Ped_header.prf_comprob:SENSITIVE        = NO
                T-Ped_header.nro_comprob:SENSITIVE        = NO
                btn_verbonificaciones:SENSITIVE           = YES.
            */
            ASSIGN
               btn_grabar:SENSITIVE                      = YES
               btn_copiar:SENSITIVE                      = NO
               btn_transferir:SENSITIVE                  = NO
               btn_cancel:SENSITIVE                      = YES
               btn_leyenda:SENSITIVE                     = YES
               btn_observ:SENSITIVE                      = YES
               /*
               btn_imprim:SENSITIVE                      = NO
               */
               T-Ped_header.fecha:SENSITIVE              = YES
               T-Ped_header.cambio:SENSITIVE             = YES
               T-Ped_header.transportista:SENSITIVE      = YES
               T-Ped_header.cdg_comprobante:SENSITIVE    = YES
               T-Ped_header.nro_ocm:SENSITIVE            = YES
               v-cdg_articulo:SENSITIVE                  = YES
               v-cdg_condicion_impos:SENSITIVE           = YES
               v-cdg_condicion_venta:SENSITIVE           = YES
               v-cdg_domicilio:SENSITIVE                 = YES
               v-cdg_imputacion:SENSITIVE                = YES
               v-cdg_moneda:SENSITIVE                    = YES
               v-cdg_cliente:SENSITIVE                   = NO
               v-cdg_vendedor:SENSITIVE                  = YES
               v-cdg_lista_precios:SENSITIVE             = YES
               v-cdg_deposito:SENSITIVE                  = YES
               btn_porclasificacion:SENSITIVE            = YES
               btn_verbonificaciones:SENSITIVE           = YES.
                
       END.
       WHEN MD_MULTIPLE      
       THEN DO:
            ASSIGN
                btn_cancel:SENSITIVE                      = YES
                btn_leyenda:SENSITIVE                     = YES
                btn_observ:SENSITIVE                      = YES
            /*  btn_imprim:SENSITIVE                      = YES */
                T-Ped_header.tip_comprob:SENSITIVE        = NO
                T-Ped_header.prf_comprob:SENSITIVE        = NO
                T-Ped_header.nro_comprob:SENSITIVE        = NO
                btn_verbonificaciones:SENSITIVE           = YES.
       END.
       WHEN MD_DEFINIDA      
       THEN DO:
            ASSIGN
/*                 btn_leyenda:SENSITIVE                      = YES     */
/*             /*  btn_imprim:SENSITIVE                      = YES */  */
/*                 btn_verbonificaciones:SENSITIVE           = YES.    */
          
                        btn_grabar:SENSITIVE                      = YES
                        btn_copiar:SENSITIVE                      = NO
                        btn_transferir:SENSITIVE                  = NO
                        btn_cancel:SENSITIVE                      = YES
                        btn_leyenda:SENSITIVE                     = YES
                        btn_observ:SENSITIVE                      = YES
                        /*
                        btn_imprim:SENSITIVE                      = NO
                        */
                        T-Ped_header.fecha:SENSITIVE              = YES
                        T-Ped_header.cambio:SENSITIVE             = YES
                        T-Ped_header.transportista:SENSITIVE      = YES
                        T-Ped_header.cdg_comprobante:SENSITIVE    = YES
                        T-Ped_header.nro_ocm:SENSITIVE            = YES
                        v-cdg_articulo:SENSITIVE                  = YES
                        v-cdg_condicion_impos:SENSITIVE           = YES
                        v-cdg_condicion_venta:SENSITIVE           = YES
                        v-cdg_domicilio:SENSITIVE                 = YES
                        v-cdg_imputacion:SENSITIVE                = YES
                        v-cdg_moneda:SENSITIVE                    = YES
                        v-cdg_cliente:SENSITIVE                   = NO
                        v-cdg_vendedor:SENSITIVE                  = YES
                        v-cdg_lista_precios:SENSITIVE             = YES
                        v-cdg_deposito:SENSITIVE                  = YES
                        btn_porclasificacion:SENSITIVE            = YES
                        btn_verbonificaciones:SENSITIVE           = YES.

                
       END.
       WHEN MD_RELACION      
       THEN DO:
            ASSIGN
                btn_leyenda:SENSITIVE                     = YES
                btn_observ:SENSITIVE                      = YES
            /*  btn_imprim:SENSITIVE                      = YES */
                btn_verbonificaciones:SENSITIVE           = YES.
       END.
       WHEN MD_READONLY      
       THEN DO:
            ASSIGN
                btn_leyenda:SENSITIVE                     = YES
                btn_observ:SENSITIVE                      = YES
            /*  btn_imprim:SENSITIVE                      = YES */
                btn_verbonificaciones:SENSITIVE           = YES.
       END.
       WHEN MD_CAMBIO        
       THEN DO:
            ASSIGN
               btn_grabar:SENSITIVE                      = YES
               btn_copiar:SENSITIVE                      = NO
               btn_transferir:SENSITIVE                  = NO
               btn_cancel:SENSITIVE                      = YES
               btn_leyenda:SENSITIVE                     = YES
               btn_observ:SENSITIVE                      = YES
               T-Ped_header.fecha:SENSITIVE              = YES
               T-Ped_header.cambio:SENSITIVE             = YES
               T-Ped_header.transportista:SENSITIVE      = YES
               T-Ped_header.cdg_comprobante:SENSITIVE    = YES
               T-Ped_header.nro_ocm:SENSITIVE            = YES
               v-cdg_articulo:SENSITIVE                  = YES
               v-cdg_condicion_impos:SENSITIVE           = YES
               v-cdg_condicion_venta:SENSITIVE           = YES
               v-cdg_domicilio:SENSITIVE                 = YES
               v-cdg_imputacion:SENSITIVE                = YES
               v-cdg_moneda:SENSITIVE                    = YES
               v-cdg_cliente:SENSITIVE                   = NO
               v-cdg_vendedor:SENSITIVE                  = YES
               v-cdg_lista_precios:SENSITIVE             = YES
               v-cdg_deposito:SENSITIVE                  = YES
               btn_porclasificacion:SENSITIVE            = YES
               btn_verbonificaciones:SENSITIVE           = YES.
       END.
       WHEN MD_ANULACION        
       THEN DO:
            ASSIGN
                btn_observ:SENSITIVE                      = YES 
                btn_leyenda:SENSITIVE                     = YES
            /*  btn_imprim:SENSITIVE                      = YES */
                btn_verbonificaciones:SENSITIVE           = YES.
       END.
       WHEN MD_EMISION        
       THEN DO:
            ASSIGN
                btn_grabar:SENSITIVE                      = YES
                btn_observ:SENSITIVE                      = YES 
                btn_leyenda:SENSITIVE                      = YES
            /*  btn_imprim:SENSITIVE                      = YES */
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


   RUN getptovta.p ( INPUT "FAC",
                     OUTPUT v-pto_venta).

   RUN getparametro.p (  INPUT  "CNTDEUDA",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).
   cntrl_deuda = v-valor_l.

   RUN getparametro.p (  INPUT  "CDGDOLAR",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).
   codigo_dolar = v-valor_c.
   FIND Moneda WHERE Moneda.cdg_moneda = codigo_dolar NO-LOCK.
   cotiza_dolar = Moneda.cambio.

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

   RUN getparametro.p (  INPUT  "DFCNVENT",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).

   FIND Imputacion WHERE Imputacion.cdg_imputacion = v-valor_n 
                         NO-LOCK.
/*    FIND Cuenta OF Imputacion NO-LOCK.  */
   act_imputacion = ROWID(Imputacion).
/*    act_cuenta = ROWID(Cuenta).  */

   RUN getparametro.p (  INPUT  "PEDMXLIN",
                      OUTPUT v-valor_c,
                      OUTPUT v-valor_d,
                      OUTPUT v-valor_l,
                      OUTPUT v-valor_n,
                      OUTPUT v-observacion ).
   IF v-valor_n <> ? 
       THEN max_lidet = v-valor_n.
       ELSE max_lidet = 0.
   
   v-cdg_comprobante = "PEDIDCLI".

   DEFINE VARIABLE ok AS LOGICAL.
 
   DO WITH FRAME {&FRAME-NAME}:

      ASSIGN v-cdg_oferta:DELIMITER     = "!"
             v-cdg_oferta:LIST-ITEMS    = v-ch-sinoferta.
             
      FOR EACH Oferta NO-LOCK WHERE CAN-DO(Oferta.lista_empresas,Empresa.cdg_empresa) BY Oferta.dsc_oferta:
          ok = v-cdg_oferta:ADD-LAST(Oferta.dsc_oferta).
      END.

      ASSIGN v-cdg_oferta:SCREEN-VALUE  = v-ch-sinoferta.

   END.          
   
   RUN titulo_window ( INPUT "Pedidos de Clientes" ).           
   
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE levantar_bonificaciones C-Win 
PROCEDURE levantar_bonificaciones :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

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


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_articulos C-Win 
PROCEDURE poner_articulos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    OPEN QUERY BRW-ARTICULOS 
         FOR EACH T-Ped_detalle, 
             FIRST Articulo OF T-Ped_detalle.

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
      T-Ped_header.tip_comprob          = v-tip_comprob.

  RUN traer_cliente.
  RUN traer_condicion_venta.
/*   RUN traer_imputacion.  */
  RUN traer_condicion_impos.
  RUN traer_lista.
  RUN traer_vendedor.

  IF T-Ped_header.cdg_oferta <> ""
  THEN DO:
        FIND Oferta OF T-Ped_header NO-LOCK.
        IF Oferta.valen_bonificaciones
        THEN DO:
             RUN levantar_bonificaciones.
        END.
  END.
  ELSE DO:
       RUN levantar_bonificaciones.
  END.
  
  DISPLAY  v-cdg_cliente 
           v-dsc_cliente

           v-cdg_condicion_venta
           v-dsc_condicion_venta

           v-cdg_imputacion
           v-dsc_imputacion

           v-cdg_condicion_impos
           v-dsc_condicion_impos

           v-cdg_lista_precios
           v-dsc_lista_precios

           v-cdg_vendedor
           v-dsc_vendedor

           v-cdg_deposito
           v-dsc_deposito

           T-Ped_header.tip_comprob
           WITH FRAME {&FRAME-NAME}.
           
   DO WITH FRAME {&FRAME-NAME}:
      ASSIGN
         btn_grabar:SENSITIVE                      = YES
         btn_copiar:SENSITIVE                      = NO
         btn_transferir:SENSITIVE                  = NO
         btn_cancel:SENSITIVE                      = YES
         btn_leyenda:SENSITIVE                     = YES
         btn_observ:SENSITIVE                      = YES
         /*
         btn_anular:SENSITIVE                      = NO
         btn_imprim:SENSITIVE                      = NO
         */
         T-Ped_header.fecha:SENSITIVE              = YES
         T-Ped_header.cambio:SENSITIVE             = YES
         T-Ped_header.transportista:SENSITIVE      = YES
         T-Ped_header.cdg_comprobante:SENSITIVE    = YES
         T-Ped_header.nro_ocm:SENSITIVE            = YES
         v-cdg_articulo:SENSITIVE                  = YES
         v-cdg_condicion_impos:SENSITIVE           = YES
         v-cdg_condicion_venta:SENSITIVE           = YES
         v-cdg_domicilio:SENSITIVE                 = YES
         v-cdg_imputacion:SENSITIVE                = YES
         v-cdg_moneda:SENSITIVE                    = YES
         v-cdg_cliente:SENSITIVE                   = NO
         v-cdg_oferta:SENSITIVE                    = NO
         v-cdg_vendedor:SENSITIVE                  = YES
         v-cdg_lista_precios:SENSITIVE             = YES
         v-cdg_deposito:SENSITIVE                  = YES
         btn_porclasificacion:SENSITIVE            = YES
         btn_verbonificaciones:SENSITIVE           = YES.
   END. 

   FIND Domicilio OF Cliente NO-LOCK NO-ERROR.
   IF AVAILABLE Domicilio 
   THEN DO:
      FIND Provincia OF Domicilio NO-LOCK.
      ASSIGN  T-Ped_header.nro_domicilio = Domicilio.nro_domicilio
              T-Ped_header.cdg_recorrido = Domicilio.cdg_recorrido
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

   /*
   RUN calculos.   
   */
   MESSAGE "por sumar estado crediticio"
       VIEW-AS ALERT-BOX INFO BUTTONS OK TITLE "poner_cliente".
   
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

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_colores C-Win 
PROCEDURE poner_colores :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    OPEN QUERY BRW-COLORES
         FOR EACH T-Color 
             WHERE T-Color.nro_linea = T-Ped_detalle.nro_linea,
                   FIRST Partida OF T-Color
                   BY Partida.cdg_partida.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_imputacion C-Win 
PROCEDURE poner_imputacion :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  FIND FIRST Tipocomprobante 
      WHERE Tipocomprobante.cdg_comprobante = T-Ped_header.cdg_comprobante:INPUT-VALUE IN FRAME {&FRAME-NAME}
        AND Tipocomprobante.cdg_empresa     = T-Ped_header.cdg_empresa
            NO-LOCK.
  FIND FIRST Comprobante_concepto OF Tipocomprobante NO-LOCK.
  FIND Imputacion OF Comprobante_concepto NO-LOCK.    
  ASSIGN v-cdg_imputacion = Imputacion.cdg_imputacion
         v-dsc_imputacion = Imputacion.dsc_imputacion.
  DISPLAY v-cdg_imputacion
          v-dsc_imputacion
      WITH FRAME {&FRAME-NAME}. 

  RUN asignar_imputacion.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE refrescar_browses C-Win 
PROCEDURE refrescar_browses :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   OPEN QUERY BRW-ARTICULOS
       FOR EACH T-Ped_detalle  OF T-Ped_header
           WHERE T-Ped_detalle.nro_partida = 0 NO-LOCK, 
                 EACH Articulo OF T-Ped_detalle NO-LOCK.

   RUN poner_colores.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE regrabar_datos C-Win 
PROCEDURE regrabar_datos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE v-prox_docum AS CHARACTER.
/*     DEFINE VARIABLE cont AS INTEGER.         */
/*     DEFINE VARIABLE max_detalle AS INTEGER.  */
    DO TRANSACTION:
    
       /*RUN validar_pedido ( OUTPUT T-Ped_header.cdg_estado ).*/

       FIND CURRENT Ped_header EXCLUSIVE-LOCK.

       BUFFER-COPY T-Ped_header TO Ped_header
           ASSIGN  Ped_header.version = Ped_header.version + 1
                   Ped_header.ultima_linea = 0.

        /* Borramos el detalle anterior */

       RUN borrar_detalle_actual.

       /* Bajamos el nuevo detalle  */

       RUN bajar_detalle.

       /* Emitimos nuevamente el pedido  */
       
/*        RUN emitir_pedido.p ( ROWID(Ped_header)). */
     
       /* Borramos las tablas temporales */

       RUN borrar_tablas_temporales.

       RELEASE Ped_header.
       RELEASE Ped_detalle.

    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE regrabar_linea C-Win 
PROCEDURE regrabar_linea :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   /*
   
   FOR EACH T-Color WHERE T-Color.nro_linea = T-Ped_detalle.nro_linea: 

        IF T-Color.upd_status <> "D"
        THEN DO:
            IF T-Color.cantidad_sol <> 0 
            THEN DO:
                Ped_header.ultima_linea  = Ped_header.ultima_linea + 1.

                CREATE Ped_detalle.
                BUFFER-COPY T-Ped_detalle TO Ped_detalle
                            ASSIGN Ped_detalle.nro_pedido   = Ped_header.nro_pedido
                                   Ped_detalle.nro_linea    = Ped_header.ultima_linea
                                   Ped_detalle.cantidad     = T-Color.cantidad_sol
                                   Ped_detalle.cantidad_sol = T-Color.cantidad_sol
                                   Ped_detalle.cantidad_ult = T-Color.cantidad_sol
                                   Ped_detalle.granel       = T-Color.granel_sol
                                   Ped_detalle.granel_sol   = T-Color.granel_sol
                                   Ped_detalle.granel_ult   = T-Color.granel_sol
                                   Ped_detalle.nro_partida  = T-Color.nro_partida
                                   Ped_detalle.cdg_estado   = Ped_header.cdg_estado.

                CREATE Ped_detalle_entr.
                ASSIGN Ped_detalle_entr.cantidad            = Ped_detalle.cantidad_sol
                       Ped_detalle_entr.cdg_estado          = Ped_detalle.cdg_estado
                       Ped_detalle_entr.fecha_tardia        = Ped_header.fecha
                       Ped_detalle_entr.fecha_temprana      = Ped_header.fecha
                       Ped_detalle_entr.flete_estimado      = 0
                       Ped_detalle_entr.granel              = Ped_detalle.granel
                       Ped_detalle_entr.nro_entrega         = 1
                       Ped_detalle_entr.nro_linea           = Ped_detalle.nro_linea
                       Ped_detalle_entr.nro_linea_remito    = 0
                       Ped_detalle_entr.nro_pedido          = Ped_header.nro_pedido
                       Ped_detalle_entr.nro_remito          = 0
                       Ped_detalle_entr.precio              = Ped_detalle.precio
                       Ped_detalle_entr.ultima_cantidad     = Ped_detalle.cantidad
                       Ped_detalle_entr.ultimo_granel       = Ped_detalle.granel.      
                        
             END.
             DELETE T-Color.                            
        END.


   END.
   DELETE T-Ped_detalle.

   */

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
     WHEN MD_DEFINIDA  THEN v-txtitulo = " Modificación Individual de " + txtitulo.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_deposito C-Win 
PROCEDURE traer_deposito :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND Deposito    OF T-Ped_header   NO-LOCK.
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

   FIND Ped_header WHERE ROWID(Ped_header) = rid_pedido NO-LOCK.

   BUFFER-COPY Ped_header TO T-Ped_header
       ASSIGN T-Ped_header.ultima_linea = 0.

   FOR EACH Ped_detalle OF Ped_header, Articulo OF Ped_detalle 
       BREAK BY Articulo.cdg_articulo BY Ped_detalle.precio:

       IF FIRST-OF(Ped_detalle.precio) 
       THEN DO:
           CREATE T-Ped_detalle.
           BUFFER-COPY Ped_detalle TO T-Ped_detalle
               ASSIGN T-Ped_header.ultima_linea = T-Ped_header.ultima_linea + 1
                      T-Ped_detalle.nro_linea = T-Ped_header.ultima_linea
                      T-Ped_detalle.nro_partida = 0
                      T-Ped_detalle.cantidad_sol = 0
                      T-Ped_detalle.granel_sol = 0.
           RUN crear_colores.
       END.
             
       FIND T-Ped_detalle WHERE T-Ped_detalle.nro_linea = T-Ped_header.ultima_linea.
       FIND T-Color WHERE T-Color.nro_linea = T-Ped_detalle.nro_linea 
                      AND T-Color.nro_partida = Ped_detalle.nro_partida
                      AND T-Color.precio = Ped_detalle.precio.

       ASSIGN T-Color.cantidad           = Ped_detalle.cantidad
              T-Color.granel             = Ped_detalle.granel
              T-Ped_detalle.cantidad_sol = T-Ped_detalle.cantidad_sol + T-Color.cantidad
              T-Ped_detalle.granel_sol   = T-Ped_detalle.granel_sol + T-Color.granel
              T-Ped_detalle.cantidad     = T-Ped_detalle.cantidad_sol
              T-Ped_detalle.granel       = T-Ped_detalle.granel_sol.

   END.    

   FOR EACH Ped_header-bon  OF Ped_header:
       CREATE T-Ped_header-bon.
       BUFFER-COPY Ped_header-bon TO T-Ped_header-bon.
   END.
    
   FOR EACH Ped_detalle-bon  OF Ped_header:
       CREATE T-Ped_detalle-bon.
       BUFFER-COPY Ped_detalle-bon TO T-Ped_detalle-bon.
   END.

   IF Ped_header.anulado 
   THEN DO:
       v-anulado = "ANULADO".
   END.
   ELSE DO:
       FIND Estado_pedido OF Ped_header NO-LOCK NO-ERROR.
       IF AVAILABLE Estado_pedido
           THEN v-anulado = Estado_pedido.descripcion.
           ELSE v-anulado = Ped_header.cdg_estado + " " + "??????".
   END.

   RUN traer_tablas.
   DISPLAY
        T-Ped_header.cambio 
        T-Ped_header.fecha 
        T-Ped_header.imp_neto 
        T-Ped_header.imp_total 
        T-Ped_header.transportista 
        T-Ped_header.nro_comprob 
        T-Ped_header.prf_comprob 
        T-Ped_header.tip_comprob 
        T-Ped_header.version
        T-Ped_header.cdg_comprobante
        v-cdg_condicion_impos 
        v-cdg_condicion_venta 
        v-cdg_domicilio 
        v-cdg_imputacion 
        v-cdg_moneda 
        v-cdg_cliente 
        v-cdg_lista_precios 
        v-cdg_deposito 
        v-cdg_vendedor 
        v-dsc_condicion_impos 
        v-dsc_condicion_venta
        v-dsc_domicilio 
        v-dsc_imputacion 
        v-dsc_moneda 
        v-dsc_cliente 
        v-dsc_lista_precios 
        v-dsc_deposito 
        v-dsc_vendedor 
        v-anulado
        v-cdg_oferta
        WITH FRAME {&FRAME-NAME}.

   RUN refrescar_browses.
       
   RUN habilitar_campos ( INPUT YES ).

   RUN calculos.
   
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

    FIND Imputacion       OF T-Ped_header NO-LOCK.
    ASSIGN
        v-cdg_imputacion      = Imputacion.cdg_imputacion
        v-dsc_imputacion      = Imputacion.dsc_imputacion.
    
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_oferta C-Win 
PROCEDURE traer_oferta :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  FIND Oferta OF T-Ped_header NO-LOCK NO-ERROR.
  IF NOT AVAILABLE Oferta 
     THEN v-cdg_oferta = v-ch-sinoferta.
     ELSE v-cdg_oferta = Oferta.dsc_oferta.

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
  RUN traer_oferta.
  RUN traer_deposito.


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

    DEFINE VARIABLE v-cant_lineas AS INTEGER.
    
    hubo_error = YES.
  
    {validartabla.i "Cliente"           "cdg_cliente"     "nom_cliente"    "FACT001"}
    {validartabla.i "Vendedor"          "cdg_vendedor"    "nombre"         "FACT003"}
    {validartabla.i "Deposito"          "cdg_deposito"    "nombre"         "FACT023"}
    {validartabla.i "Lista_precios"     "cdg_lista"       "descripcion"    "FACT009"}
    {validartabla.i "Condicion_impos"   "cdg_condiva"     "descripcion"    "FACT008"}
    {validartabla.i "Moneda"            "cdg_moneda"      "descripcion"    "FACT019"}
    {validartabla.i "Condicion_venta"   "cdg_cndventa"    "descripcion"    "FACT002"}
    {validartabla.i "Imputacion"        "cdg_imputacion"  "dsc_imputacion" "FAPR024"}

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
    
        v-cant_lineas = 0.
    
        IF Cliente.condensado_sino /* El cliente agrupa articulos en la factura */
        THEN DO:
            FOR EACH T-Ped_detalle OF T-Ped_header, Articulo OF T-Ped_detalle BREAK BY Articulo.cdg_articulo:
                IF LAST-OF(Articulo.cdg_articulo)
                    THEN v-cant_lineas = v-cant_lineas + 1.
            END.
        END.
        ELSE DO:
            FOR EACH T-Color WHERE T-Color.cantidad_sol <> 0:
                v-cant_lineas = v-cant_lineas + 1.
            END.
    
        END.
    
        IF v-cant_lineas > max_lidet
        THEN DO:
           RUN PONMENSJ.P (INPUT "FACT034").
           RETURN ERROR.
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

    RUN calculos.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE validar_oferta C-Win 
PROCEDURE validar_oferta :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE OUTPUT PARAMETER p-cdg_estado LIKE Ped_header.cdg_estado.

  DEFINE VARIABLE hay_articulo_afuera          AS LOGICAL.
         
  /*--------------------------------------------------------------------------*/  
  /*          PROCESAMIENTO EN SI DE LA VALIDADCION DE LA OFERTA              */
  /*--------------------------------------------------------------------------*/

  p-cdg_estado = "IN". /* Todo OK, salvo que se demustre lo contrario */

  FIND Oferta OF T-Ped_header NO-LOCK.
 
  IF T-Ped_header.fecha > Oferta.rige_hasta
  OR T-Ped_header.fecha < Oferta.rige_desde
  THEN DO:
       p-cdg_estado = "OF".
       RETURN.
  END.     
  
  FOR EACH T-Sumador_oferta:
      DELETE T-Sumador_oferta.
  END.    
  
  FOR EACH Oferta-rubro OF Oferta:
      CREATE T-Sumador_oferta.
      BUFFER-COPY Oferta-rubro TO T-Sumador_oferta.
  END.

  hay_articulo_afuera = NO.
  FOR EACH T-B-Ped_detalle, Articulo OF T-B-Ped_detalle:

      FIND FIRST Articulo-oferta OF Articulo WHERE Articulo-oferta.cdg_oferta = Oferta.cdg_oferta NO-ERROR.
      IF AVAILABLE Articulo-oferta
      THEN DO:
            FIND T-Sumador_oferta WHERE T-Sumador_oferta.numero_total = Articulo-oferta.numero_total.
            T-Sumador_oferta.total_pesos = T-Sumador_oferta.total_pesos + T-B-Ped_detalle.subtotal_neto.
      END.
      ELSE DO:
           hay_articulo_afuera = YES.      
      END.

  END.
  
  IF hay_articulo_afuera 
  THEN DO:
       p-cdg_estado = "OA".
       RETURN.
  END.     
  ELSE DO:
       IF CAN-FIND(FIRST T-Sumador_oferta WHERE T-Sumador_oferta.total_pesos < T-Sumador_oferta.importe_minimo - T-Sumador_oferta.tolerancia_importe)
       THEN DO:
            p-cdg_estado = "O1".
            RETURN.
       END.     
       ELSE DO:
            IF CAN-FIND(FIRST T-Sumador_oferta WHERE T-Sumador_oferta.total_pesos > T-Sumador_oferta.importe_maximo + T-Sumador_oferta.tolerancia_importe)
            THEN DO:
                 p-cdg_estado = "O2".
                 RETURN.
            END.
       END.
       
  END.
    
  DEFINE VARIABLE ant_total_pesos LIKE T-Sumador_oferta.total_pesos.
  ant_total_pesos = 0.
  FOR EACH T-Sumador_oferta BY T-Sumador_oferta.numero_total:
      IF T-Sumador_oferta.total_pesos < ant_total_pesos + Oferta.diferencia_ofertas
         THEN p-cdg_estado = "OD".
      ant_total_pesos = T-Sumador_oferta.total_pesos.
  END.    
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE validar_pedido C-Win 
PROCEDURE validar_pedido :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE OUTPUT PARAMETER p-cdg_estado LIKE Ped_header.cdg_estado.

  IF T-Ped_header.cdg_oferta <> ""
     THEN RUN validar_oferta ( OUTPUT p-cdg_estado ).
     ELSE p-cdg_estado = "IN".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

