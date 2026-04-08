&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win

/* Temp-Table and Buffer definitions                                    */
DEFINE NEW SHARED TEMP-TABLE T-Ocm_detalle NO-UNDO LIKE Ocm_detalle.
DEFINE TEMP-TABLE T-Ocm_detalle-bon NO-UNDO LIKE Ocm_detalle-bon.
DEFINE TEMP-TABLE T-Ocm_detalle_entr NO-UNDO LIKE Ocm_detalle_entr.
DEFINE NEW SHARED TEMP-TABLE T-Ocm_header NO-UNDO LIKE Ocm_header.
DEFINE TEMP-TABLE T-Ocm_header-bon NO-UNDO LIKE Ocm_header-bon.


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
DEFINE VARIABLE                rid_ocompra    AS ROWID.
DEFINE VARIABLE                modo           AS INTEGER.
&ELSE
DEFINE INPUT-OUTPUT PARAMETER  rid_ocompra    AS ROWID.
DEFINE INPUT        PARAMETER  modo           AS INTEGER.
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
DEFINE VARIABLE v-pto_venta-org           AS INTEGER.

DEFINE VARIABLE v-nro_linea               AS INTEGER.
DEFINE VARIABLE v-nro_cuenta              AS INTEGER.
DEFINE VARIABLE aux_importe               AS DECIMAL.
DEFINE VARIABLE codigo_iva                AS INTEGER INITIAL 1.
DEFINE VARIABLE hay_canje                 AS LOGICAL.
DEFINE VARIABLE rid_req                   AS ROWID.

DEFINE BUFFER B-Ocm_detalle FOR T-Ocm_detalle.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME BROWSE-9

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Ocm_detalle Articulo T-Ocm_header

/* Definitions for BROWSE BROWSE-9                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-9 T-Ocm_detalle.nro_linea ~
Articulo.cdg_articulo Articulo.descripcion Articulo.cdg_umed ~
T-Ocm_detalle.cantidad T-Ocm_detalle.granel T-Ocm_detalle.precio 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-9 
&Scoped-define QUERY-STRING-BROWSE-9 FOR EACH T-Ocm_detalle OF T-Ocm_header NO-LOCK, ~
      EACH Articulo OF T-Ocm_detalle NO-LOCK
&Scoped-define OPEN-QUERY-BROWSE-9 OPEN QUERY BROWSE-9 FOR EACH T-Ocm_detalle OF T-Ocm_header NO-LOCK, ~
      EACH Articulo OF T-Ocm_detalle NO-LOCK.
&Scoped-define TABLES-IN-QUERY-BROWSE-9 T-Ocm_detalle Articulo
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-9 T-Ocm_detalle
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-9 Articulo


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define FIELDS-IN-QUERY-DEFAULT-FRAME T-Ocm_header.tip_comprob ~
T-Ocm_header.prf_comprob T-Ocm_header.nro_comprob T-Ocm_header.fecha ~
T-Ocm_header.fecha_embarque T-Ocm_header.cambio T-Ocm_header.transportista ~
T-Ocm_header.imp_neto T-Ocm_header.imp_total 
&Scoped-define ENABLED-FIELDS-IN-QUERY-DEFAULT-FRAME ~
T-Ocm_header.tip_comprob T-Ocm_header.prf_comprob T-Ocm_header.nro_comprob ~
T-Ocm_header.fecha T-Ocm_header.fecha_embarque T-Ocm_header.cambio ~
T-Ocm_header.transportista 
&Scoped-define ENABLED-TABLES-IN-QUERY-DEFAULT-FRAME T-Ocm_header
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-DEFAULT-FRAME T-Ocm_header
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-BROWSE-9}
&Scoped-define QUERY-STRING-DEFAULT-FRAME FOR EACH T-Ocm_header SHARE-LOCK
&Scoped-define OPEN-QUERY-DEFAULT-FRAME OPEN QUERY DEFAULT-FRAME FOR EACH T-Ocm_header SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-DEFAULT-FRAME T-Ocm_header
&Scoped-define FIRST-TABLE-IN-QUERY-DEFAULT-FRAME T-Ocm_header


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS T-Ocm_header.tip_comprob ~
T-Ocm_header.prf_comprob T-Ocm_header.nro_comprob T-Ocm_header.fecha ~
T-Ocm_header.fecha_embarque T-Ocm_header.cambio T-Ocm_header.transportista 
&Scoped-define ENABLED-TABLES T-Ocm_header
&Scoped-define FIRST-ENABLED-TABLE T-Ocm_header
&Scoped-Define ENABLED-OBJECTS Btn_salir BROWSE-9 RECT-2 RECT-3 RECT-4 ~
RECT-5 
&Scoped-Define DISPLAYED-FIELDS T-Ocm_header.tip_comprob ~
T-Ocm_header.prf_comprob T-Ocm_header.nro_comprob T-Ocm_header.fecha ~
T-Ocm_header.fecha_embarque T-Ocm_header.cambio T-Ocm_header.transportista ~
T-Ocm_header.imp_neto T-Ocm_header.imp_total 
&Scoped-define DISPLAYED-TABLES T-Ocm_header
&Scoped-define FIRST-DISPLAYED-TABLE T-Ocm_header
&Scoped-Define DISPLAYED-OBJECTS v-pto_venta v-estado v-cdg_proveedor ~
v-dsc_proveedor v-cdg_condicion_venta v-dsc_condicion_venta v-cdg_domicilio ~
v-dsc_domicilio v-cdg_moneda v-dsc_moneda v-cdg_imputacion v-dsc_imputacion ~
v-cdg_deposito v-dsc_deposito v-cdg_comprador v-dsc_comprador ~
v-cdg_lista_precios v-dsc_lista_precios v-cdg_articulo 

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

DEFINE BUTTON btn_copiar_requerimiento 
     LABEL "Copiar &Requerimiento" 
     SIZE 30 BY 1.14.

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
     LABEL "Buscar X &Clasificación" 
     SIZE 22 BY 1.

DEFINE BUTTON Btn_salir DEFAULT 
     LABEL "&Salir" 
     SIZE 21 BY 1.33
     BGCOLOR 8 .

DEFINE BUTTON btn_verbonifdet 
     LABEL "&Bonifics. Detalle" 
     SIZE 21 BY 1.

DEFINE BUTTON btn_verbonificaciones 
     LABEL "&Bonificaciones Grales." 
     SIZE 30 BY 1.14.

DEFINE VARIABLE v-cdg_articulo AS CHARACTER FORMAT "X(12)":U 
     LABEL "Artículo" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 16 BY 1
     BGCOLOR 14 FGCOLOR 12 FONT 6 NO-UNDO.

DEFINE VARIABLE v-cdg_comprador AS CHARACTER FORMAT "X(8)" 
     LABEL "Comprador" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_condicion_venta AS CHARACTER FORMAT "X(8)" 
     LABEL "C.Venta" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_deposito AS CHARACTER FORMAT "X(8)" 
     LABEL "Depósito" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_domicilio AS INTEGER FORMAT ">>>>>>9" INITIAL 0 
     LABEL "Domicilio" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_imputacion AS INTEGER FORMAT "->,>>>,>>9" INITIAL 0 
     LABEL "Imputación" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_lista_precios AS INTEGER FORMAT "->,>>>,>>9" INITIAL 0 
     LABEL "Lista" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_moneda AS CHARACTER FORMAT "X(3)" 
     LABEL "Moneda" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_proveedor AS CHARACTER FORMAT "X(8)" 
     LABEL "Proveedor" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-dsc_comprador AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 45 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_condicion_venta AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 45 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_deposito AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 45 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_domicilio AS CHARACTER FORMAT "X(40)" 
     VIEW-AS FILL-IN 
     SIZE 45 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_imputacion AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 45 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_lista_precios AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 45 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_moneda AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_proveedor AS CHARACTER FORMAT "X(40)" 
     VIEW-AS FILL-IN 
     SIZE 45 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-estado AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 26 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 6 NO-UNDO.

DEFINE VARIABLE v-pto_venta AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN NATIVE 
     SIZE 7 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 0 NO-UNDO.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 133 BY 1.86.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 23 BY 1.86.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 156 BY 7.86.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 156 BY 1.43.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-9 FOR 
      T-Ocm_detalle, 
      Articulo SCROLLING.

DEFINE QUERY DEFAULT-FRAME FOR 
      T-Ocm_header SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-9
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-9 C-Win _STRUCTURED
  QUERY BROWSE-9 NO-LOCK DISPLAY
      T-Ocm_detalle.nro_linea COLUMN-LABEL "Número!Item" FORMAT ">>9":U
      Articulo.cdg_articulo FORMAT "X(12)":U WIDTH 26
      Articulo.descripcion FORMAT "X(50)":U WIDTH 58.2
      Articulo.cdg_umed FORMAT "X(12)":U
      T-Ocm_detalle.cantidad COLUMN-LABEL "Cantidad!A Entregar" FORMAT "->,>>>,>>9.99":U
      T-Ocm_detalle.granel COLUMN-LABEL "Granel!A Entregar" FORMAT "->>>,>>9.99":U
      T-Ocm_detalle.precio COLUMN-LABEL "Precio!Pactado" FORMAT "->,>>>,>>9.999999":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 156 BY 14
         BGCOLOR 15 FGCOLOR 9 
         TITLE BGCOLOR 15 FGCOLOR 9 "Artículos a comprar en esta O/Compra".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btn_grabar AT ROW 1.48 COL 4
     btn_copiar AT ROW 1.48 COL 26
     btn_cancel AT ROW 1.48 COL 48
     btn_anular AT ROW 1.48 COL 70
     btn_observ AT ROW 1.48 COL 92
     btn_imprim AT ROW 1.48 COL 114
     Btn_salir AT ROW 1.48 COL 137
     T-Ocm_header.tip_comprob AT ROW 3.86 COL 17 COLON-ALIGNED
          LABEL "O/Compra"
          VIEW-AS FILL-IN NATIVE 
          SIZE 7 BY 1
          BGCOLOR 7 FGCOLOR 15 
     T-Ocm_header.prf_comprob AT ROW 3.86 COL 25 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 8 BY 1
          BGCOLOR 7 FGCOLOR 15 
     T-Ocm_header.nro_comprob AT ROW 3.86 COL 34 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 10.8 BY 1
          BGCOLOR 7 FGCOLOR 15 
     v-pto_venta AT ROW 3.86 COL 46 COLON-ALIGNED NO-LABEL
     v-estado AT ROW 3.86 COL 53 COLON-ALIGNED NO-LABEL
     T-Ocm_header.fecha AT ROW 3.86 COL 93 COLON-ALIGNED FORMAT "99/99/9999"
          VIEW-AS FILL-IN NATIVE 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Ocm_header.fecha_embarque AT ROW 3.86 COL 139 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_proveedor AT ROW 5.05 COL 17 COLON-ALIGNED
     v-dsc_proveedor AT ROW 5.05 COL 34 COLON-ALIGNED NO-LABEL
     v-cdg_condicion_venta AT ROW 5.05 COL 93 COLON-ALIGNED
     v-dsc_condicion_venta AT ROW 5.05 COL 110 COLON-ALIGNED NO-LABEL
     v-cdg_domicilio AT ROW 6.24 COL 17 COLON-ALIGNED
     v-dsc_domicilio AT ROW 6.24 COL 34 COLON-ALIGNED NO-LABEL
     v-cdg_moneda AT ROW 6.24 COL 93 COLON-ALIGNED
     v-dsc_moneda AT ROW 6.24 COL 110 COLON-ALIGNED NO-LABEL
     T-Ocm_header.cambio AT ROW 6.24 COL 139 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_imputacion AT ROW 7.43 COL 17 COLON-ALIGNED
     v-dsc_imputacion AT ROW 7.43 COL 34 COLON-ALIGNED NO-LABEL
     v-cdg_deposito AT ROW 7.43 COL 93 COLON-ALIGNED
     v-dsc_deposito AT ROW 7.43 COL 110 COLON-ALIGNED NO-LABEL
     v-cdg_comprador AT ROW 8.62 COL 17 COLON-ALIGNED
     v-dsc_comprador AT ROW 8.62 COL 34 COLON-ALIGNED NO-LABEL
     v-cdg_lista_precios AT ROW 8.62 COL 93 COLON-ALIGNED
     v-dsc_lista_precios AT ROW 8.62 COL 110 COLON-ALIGNED NO-LABEL
     T-Ocm_header.transportista AT ROW 9.81 COL 17 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 62 BY 1
          BGCOLOR 15 FGCOLOR 9 
     btn_copiar_requerimiento AT ROW 9.81 COL 95
     btn_verbonificaciones AT ROW 9.81 COL 127
     v-cdg_articulo AT ROW 11.71 COL 17 COLON-ALIGNED
     btn_porclasificacion AT ROW 11.71 COL 37
     btn_verbonifdet AT ROW 11.71 COL 60
     T-Ocm_header.imp_neto AT ROW 11.71 COL 93 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 20.2 BY 1
          BGCOLOR 7 FGCOLOR 14 
     T-Ocm_header.imp_total AT ROW 11.71 COL 135 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 20.2 BY 1
          BGCOLOR 7 FGCOLOR 14 
     BROWSE-9 AT ROW 13.14 COL 3
     RECT-2 AT ROW 1.24 COL 3
     RECT-3 AT ROW 1.24 COL 136
     RECT-4 AT ROW 3.38 COL 3
     RECT-5 AT ROW 11.48 COL 3
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 158.4 BY 26.14.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Ocm_detalle T "NEW SHARED" NO-UNDO sic Ocm_detalle
      TABLE: T-Ocm_detalle-bon T "?" NO-UNDO sic Ocm_detalle-bon
      TABLE: T-Ocm_detalle_entr T "?" NO-UNDO sic Ocm_detalle_entr
      TABLE: T-Ocm_header T "NEW SHARED" NO-UNDO sic Ocm_header
      TABLE: T-Ocm_header-bon T "?" NO-UNDO sic Ocm_header-bon
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Ordenes de Compra"
         HEIGHT             = 26.14
         WIDTH              = 158.4
         MAX-HEIGHT         = 27.33
         MAX-WIDTH          = 160
         VIRTUAL-HEIGHT     = 27.33
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
                                                                        */
/* BROWSE-TAB BROWSE-9 imp_total DEFAULT-FRAME */
/* SETTINGS FOR BUTTON btn_anular IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_cancel IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_copiar IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_copiar_requerimiento IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_grabar IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_imprim IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_observ IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_porclasificacion IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_verbonifdet IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_verbonificaciones IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Ocm_header.fecha IN FRAME DEFAULT-FRAME
   EXP-FORMAT                                                           */
/* SETTINGS FOR FILL-IN T-Ocm_header.imp_neto IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Ocm_header.imp_total IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Ocm_header.tip_comprob IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN v-cdg_articulo IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_comprador IN FRAME DEFAULT-FRAME
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
/* SETTINGS FOR FILL-IN v-cdg_proveedor IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_comprador IN FRAME DEFAULT-FRAME
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
/* SETTINGS FOR FILL-IN v-dsc_proveedor IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-estado IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-pto_venta IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-9
/* Query rebuild information for BROWSE BROWSE-9
     _TblList          = "Temp-Tables.T-Ocm_detalle OF Temp-Tables.T-Ocm_header,sic.Articulo OF Temp-Tables.T-Ocm_detalle"
     _Options          = "NO-LOCK"
     _FldNameList[1]   > Temp-Tables.T-Ocm_detalle.nro_linea
"T-Ocm_detalle.nro_linea" "Número!Item" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[2]   > sic.Articulo.cdg_articulo
"Articulo.cdg_articulo" ? ? "character" ? ? ? ? ? ? no ? no no "26" yes no no "U" "" ""
     _FldNameList[3]   > sic.Articulo.descripcion
"Articulo.descripcion" ? ? "character" ? ? ? ? ? ? no ? no no "58.2" yes no no "U" "" ""
     _FldNameList[4]   = sic.Articulo.cdg_umed
     _FldNameList[5]   > Temp-Tables.T-Ocm_detalle.cantidad
"T-Ocm_detalle.cantidad" "Cantidad!A Entregar" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[6]   > Temp-Tables.T-Ocm_detalle.granel
"T-Ocm_detalle.granel" "Granel!A Entregar" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[7]   > Temp-Tables.T-Ocm_detalle.precio
"T-Ocm_detalle.precio" "Precio!Pactado" "->,>>>,>>9.999999" "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _Query            is OPENED
*/  /* BROWSE BROWSE-9 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME DEFAULT-FRAME
/* Query rebuild information for FRAME DEFAULT-FRAME
     _TblList          = "Temp-Tables.T-Ocm_header"
     _Query            is OPENED
*/  /* FRAME DEFAULT-FRAME */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Ordenes de Compra */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Ordenes de Compra */
DO:
  /* This event will close the window and terminate the procedure.  */
  /* APPLY "CLOSE":U TO THIS-PROCEDURE. */
  APPLY "CHOOSE":U TO Btn_salir IN FRAME {&FRAME-NAME}.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-9
&Scoped-define SELF-NAME BROWSE-9
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-9 C-Win
ON DELETE-CHARACTER OF BROWSE-9 IN FRAME DEFAULT-FRAME /* Artículos a comprar en esta O/Compra */
DO:
    IF modo = MD_ALTA
    THEN DO:
        sino-msg = NO.
        MESSAGE "Desea eliminar este renglón de detalle?" 
                VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
        IF sino-msg
        THEN DO:
             DELETE T-Ocm_detalle.
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-9 C-Win
ON MOUSE-SELECT-DBLCLICK OF BROWSE-9 IN FRAME DEFAULT-FRAME /* Artículos a comprar en esta O/Compra */
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
    MESSAGE "Desea ANULAR esta O/Compra" 
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
    IF sino-msg
    THEN DO:
         RUN anular_ocompra.p (INPUT ROWID(Ocm_header), OUTPUT pudo_anular).
         IF pudo_anular = 0
         THEN DO:
              DO TRANSACTION:
                  RUN borrar_tablas_temporales.
              END.
              MESSAGE "La O/Compra ha sido anulada" 
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

  RUN d-seleccionar_ocompra.w (INPUT-OUTPUT rid_ocompra).
  IF rid_ocompra <> ?
  THEN DO:
     FIND Ocm_header WHERE ROWID(Ocm_header) = rid_ocompra NO-LOCK.
     DISPLAY Ocm_header.nro_comprob @ T-Ocm_header.nro_comprob
             WITH FRAME {&FRAME-NAME}.
     RUN traer_documento.
  END.  
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_copiar_requerimiento
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_copiar_requerimiento C-Win
ON CHOOSE OF btn_copiar_requerimiento IN FRAME DEFAULT-FRAME /* Copiar Requerimiento */
DO:
    rid_req = ?.
    RUN d-seleccionar_requerimiento.w ( INPUT-OUTPUT rid_req ).
    IF rid_req <> ?
    THEN DO:
        RUN copiar_requerimiento.
        btn_copiar_requerimiento:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_grabar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_grabar C-Win
ON CHOOSE OF btn_grabar IN FRAME DEFAULT-FRAME /* Grabar */
DO:

  ASSIGN FRAME {&FRAME-NAME}
         T-Ocm_header.cambio 
         T-Ocm_header.fecha 
         T-Ocm_header.fecha_embarque 
         T-Ocm_header.transportista. 
         
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
    MESSAGE "Desea REIMPRIMIR esta O/Compra?" 
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
    IF sino-msg
    THEN DO:
         RUN imprimir_ocompra.p (ROWID(Ocm_header)).
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_observ
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_observ C-Win
ON CHOOSE OF btn_observ IN FRAME DEFAULT-FRAME /* Leyenda */
DO:

   DEFINE VARIABLE puso_ok AS LOGICAL.
   RUN c-edttexto.w ( INPUT-OUTPUT T-Ocm_header.leyenda,
                      INPUT "Leyenda de la O/Compra",
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


&Scoped-define SELF-NAME btn_verbonifdet
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_verbonifdet C-Win
ON CHOOSE OF btn_verbonifdet IN FRAME DEFAULT-FRAME /* Bonifics. Detalle */
DO:
  
     RUN d-bonificaciones_detocompra.w ( INPUT T-Ocm_detalle.nro_articulo,
                                         INPUT T-Ocm_detalle.nro_linea,
                                         INPUT modo,
                                         INPUT 1,
                                         OUTPUT v-nro_linea,
                                         INPUT TABLE T-Ocm_header,
                                         INPUT TABLE T-Ocm_detalle,
                                         INPUT-OUTPUT TABLE T-Ocm_detalle-bon).

    IF v-nro_linea <> 0
    THEN DO:
          FIND FIRST T-Ocm_header.
          RUN calculos.
          /*RUN refrescar_browse.*/
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_verbonificaciones
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_verbonificaciones C-Win
ON CHOOSE OF btn_verbonificaciones IN FRAME DEFAULT-FRAME /* Bonificaciones Grales. */
DO:
  
  RUN d-bonificaciones_ocompra.w ( INPUT TABLE T-Ocm_header,
                                   INPUT-OUTPUT TABLE T-Ocm_header-bon, 
                                   INPUT modo ).
  RUN calculos.
  /*
  RUN poner_articulos.
  RUN poner_colores.
  */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Ocm_header.nro_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Ocm_header.nro_comprob C-Win
ON MOUSE-SELECT-DBLCLICK OF T-Ocm_header.nro_comprob IN FRAME DEFAULT-FRAME /* nro_comprob */
OR MOUSE-MENU-DOWN,"." OF T-Ocm_header.nro_comprob IN FRAME {&FRAME-NAME}
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
          titulo_window = "Selección de Ordenes de Compra en General".
          lista_estados = " ,E".
     END.
     WHEN MD_DEFINIDA             /* Esta opcion la contemlamos por unicidad pero no debería producirse nunca */
     THEN DO:
          titulo_window = "".
          lista_estados = "Consulta Individual de Ordenes de Compra".
     END.
     WHEN MD_RELACION             /* Esta opcion la contemlamos por unicidad pero no debería producirse nunca */
     THEN DO:
          titulo_window = "".
          lista_estados = "".
     END.
     WHEN MD_READONLY      
     THEN DO:
          titulo_window = "Selección de Ordenes de Compra en General".
          lista_estados = " ,E".
     END.
     WHEN MD_CAMBIO        
     THEN DO:
          titulo_window = "".
          lista_estados = "".
     END.
     WHEN MD_ANULACION        
     THEN DO:
          titulo_window = "Selección de Ordenes de Compra Emitidas".
          lista_estados = "E".
     END.
     WHEN MD_EMISION        
     THEN DO:
          titulo_window = "Selección de Ordenes de Compra Pendientes".
          lista_estados = " ".
     END.
  END CASE.     

  RUN d-seleccionar_ocompra.w (INPUT titulo_window, INPUT lista_estados, INPUT-OUTPUT rid_ocompra).
  IF rid_ocompra <> ?
  THEN DO:
     FIND Ocm_header WHERE ROWID(Ocm_header) = rid_ocompra NO-LOCK.
     DISPLAY Ocm_header.tip_comprob @ T-Ocm_header.tip_comprob 
             Ocm_header.prf_comprob @ T-Ocm_header.prf_comprob
             Ocm_header.nro_comprob @ T-Ocm_header.nro_comprob
             WITH FRAME {&FRAME-NAME}.
     RUN traer_documento.
  END.  
  RETURN NO-APPLY.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Ocm_header.nro_comprob C-Win
ON RETURN OF T-Ocm_header.nro_comprob IN FRAME DEFAULT-FRAME /* nro_comprob */
DO:

   IF LOOKUP( INPUT FRAME {&FRAME-NAME} T-Ocm_header.tip_comprob,"OC") = 0 
   THEN DO:
      RUN PONMENSJ.P (INPUT "DOCS010").
      RETURN NO-APPLY.
   END.

   FIND Ocm_header 
        WHERE Ocm_header.cdg_empresa = Empresa.cdg_empresa
          AND Ocm_header.tip_comprob = INPUT T-Ocm_header.tip_comprob 
          AND Ocm_header.prf_comprob = INPUT T-Ocm_header.prf_comprob
          AND Ocm_header.nro_comprob = INPUT T-Ocm_header.nro_comprob
              NO-ERROR.

   IF NOT AVAILABLE Ocm_header 
   THEN DO:
        IF LOCKED Ocm_header
           THEN RUN PONMENSJ.P (INPUT "DOCS000").
           ELSE RUN PONMENSJ.P (INPUT "DOCS001").
        RETURN NO-APPLY.
   END.
   ELSE DO:
        rid_ocompra = ROWID(Ocm_header).
        RUN traer_documento.
   END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Ocm_header.prf_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Ocm_header.prf_comprob C-Win
ON MOUSE-SELECT-DBLCLICK OF T-Ocm_header.prf_comprob IN FRAME DEFAULT-FRAME /* prf_comprob */
OR MOUSE-MENU-DOWN,"." OF T-Ocm_header.prf_comprob IN FRAME {&FRAME-NAME}
DO:
  APPLY "MOUSE-SELECT-DBLCLICK" TO T-Ocm_header.tip_comprob IN FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Ocm_header.tip_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Ocm_header.tip_comprob C-Win
ON LEAVE OF T-Ocm_header.tip_comprob IN FRAME DEFAULT-FRAME /* O/Compra */
DO:
   T-Ocm_header.tip_comprob:SCREEN-VALUE IN FRAME {&FRAME-NAME} = 
           CAPS(T-Ocm_header.tip_comprob:SCREEN-VALUE IN FRAME {&FRAME-NAME}).

   IF LOOKUP( INPUT FRAME {&FRAME-NAME} T-Ocm_header.tip_comprob,"OC") = 0 
   THEN DO:
      RUN PONMENSJ.P (INPUT "DOCS010").
      RETURN NO-APPLY.
   END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Ocm_header.tip_comprob C-Win
ON MOUSE-SELECT-DBLCLICK OF T-Ocm_header.tip_comprob IN FRAME DEFAULT-FRAME /* O/Compra */
OR MOUSE-MENU-DOWN,"." OF T-Ocm_header.tip_comprob IN FRAME {&FRAME-NAME}
DO:
  APPLY "MOUSE-SELECT-DBLCLICK" TO T-Ocm_header.tip_comprob IN FRAME {&FRAME-NAME}.
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
      RUN PONMENSJ.P (INPUT "FAPR001").
      RETURN NO-APPLY.
   END.

   RUN crear_detalle.
   btn_verbonifdet:SENSITIVE = YES.
   
   DISPLAY " " @ v-cdg_articulo
           WITH FRAME {&FRAME-NAME}.
   APPLY "ENTRY" TO v-cdg_articulo  IN FRAME {&FRAME-NAME}.
   RETURN NO-APPLY.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_comprador
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_comprador C-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_comprador IN FRAME DEFAULT-FRAME /* Comprador */
OR "." OF v-cdg_comprador IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_comprador IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Comprador" "cdg_comprador" "SELCOMPR.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_comprador C-Win
ON RETURN OF v-cdg_comprador IN FRAME DEFAULT-FRAME /* Comprador */
DO:
   {traducetabla.i "Comprador" "cdg_comprador" "nom_comprador"} 
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
      ASSIGN  T-Ocm_header.nro_domicilio = Domicilio_prv.nro_domicilio
              T-Ocm_header.direccion     = Domicilio_prv.direccion
              T-Ocm_header.cdg_provincia = Domicilio_prv.cdg_provincia
              T-Ocm_header.localidad     = Domicilio_prv.localidad
              T-Ocm_header.cdg_postal    = Domicilio_prv.cdg_postal
              T-Ocm_header.cdg_zonag     = Domicilio_prv.cdg_zonag
              v-cdg_domicilio            = Domicilio_prv.nro_domicilio
              v-dsc_domicilio            = Domicilio_prv.nombre.
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
  IF modo = MD_ALTA THEN APPLY "ENTRY" TO v-cdg_proveedor.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE asignar_condicion_venta C-Win 
PROCEDURE asignar_condicion_venta :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   T-Ocm_header.nro_cndventa = Condicion_venta.nro_cndventa.
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

  T-Ocm_header.cdg_imputacion = Imputacion.cdg_imputacion.
  FIND Cuenta OF Imputacion NO-LOCK.

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
   T-Ocm_header.cdg_lista =  v-cdg_lista_precios.
   FIND Lista_precios WHERE Lista_precios.cdg_lista = T-Ocm_header.cdg_lista NO-LOCK.
   FOR EACH T-Ocm_detalle OF T-Ocm_header EXCLUSIVE-LOCK, EACH Articulo OF T-Ocm_detalle:

        CASE Articulo.modo_volumen:
             WHEN ""  /* No hay descuentos por volumen */
             THEN DO: 
                  FIND FIRST Articulo_precio OF Articulo 
                       WHERE Articulo_precio.cdg_lista = Lista_precio.cdg_lista 
                         AND Articulo_precio.cdg_empresa = Empresa.cdg_empresa
                             NO-LOCK NO-ERROR. 
                  IF AVAILABLE Articulo_precio 
                  THEN DO:
                       T-Ocm_detalle.precio    = Articulo_precio.precio.
                  END.
                  ELSE DO:
                       T-Ocm_detalle.precio    = ?.
                  END.
             END.                                  
    
             WHEN "D"  /* Descuentos directos en base a cantidad */
             THEN DO: 
                  FIND FIRST Articulo_precio OF Articulo 
                       WHERE Articulo_precio.cdg_lista = Lista_precio.cdg_lista 
                         AND Articulo_precio.cdg_empresa = Empresa.cdg_empresa
                         AND Articulo_precio.desde_cantidad <= T-Ocm_detalle.cantidad
                         AND Articulo_precio.hasta_cantidad >= T-Ocm_detalle.cantidad
                             NO-LOCK NO-ERROR. 
                  IF AVAILABLE Articulo_precio 
                  THEN DO:
                       T-Ocm_detalle.precio    = Articulo_precio.precio.
                  END.
                  ELSE DO:
                       T-Ocm_detalle.precio    = ?.
                  END.
             END.                                  
    
             WHEN "E"  /* Descuentos escalados en base a cantidad */
             THEN DO: 
                    /*
                  subtotal_item = 0.
                  remanente_cantidad = T-Ocm_detalle.cantidad.
    
                  FOR EACH Articulo_precio OF Articulo 
                       WHERE Articulo_precio.cdg_lista = Lista_precio.cdg_lista 
                         AND Articulo_precio.cdg_empresa = Empresa.cdg_empresa
                         BY Articulo-precio.desde_cantidad
                             NO-LOCK NO-ERROR: 
    
                      T-Ocm_detalle.cantidad
    
    
                  IF AVAILABLE Articulo_precio 
                  THEN DO:
                       T-Ocm_detalle.precio    = Articulo_precio.precio.
                  END.
                  ELSE DO:
                       T-Ocm_detalle.precio    = ?.
                  END.
                  */
                            T-Ocm_detalle.precio = ?. /* Sacar */
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

  T-Ocm_header.nro_moneda = Moneda.nro_moneda.
  T-Ocm_header.cambio = ROUND(Moneda.cambio / Moneda.unidades , 4 ) .
  DISPLAY T-Ocm_header.cambio WITH FRAME {&FRAME-NAME}.
  /*
  IF Moneda.cdg_moneda = codigo_dolar
  THEN DO:
     T-Ocm_header.cambio_dolar = Moneda.cambio.
     DISPLAY T-Ocm_header.cambio_dolar WITH FRAME {&FRAME-NAME}.
     DISABLE T-Ocm_header.cambio_dolar WITH FRAME {&FRAME-NAME}.
  END.
  ELSE DO:
     ENABLE T-Ocm_header.cambio_dolar WITH FRAME {&FRAME-NAME}.
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

    EMPTY TEMP-TABLE T-Ocm_header.
    EMPTY TEMP-TABLE T-Ocm_detalle.
    EMPTY TEMP-TABLE T-Ocm_detalle_entr.

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

    
  { calcocom.i "T-"}

  DISPLAY T-Ocm_header.imp_neto 
          T-Ocm_header.imp_total
          WITH FRAME {&FRAME-NAME}.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE copiar_requerimiento C-Win 
PROCEDURE copiar_requerimiento :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  FIND Rqs_header WHERE ROWID(Rqs_header) = rid_req NO-LOCK.
  FOR EACH Rqs_detalle OF Rqs_header NO-LOCK:
      CREATE T-Ocm_detalle.
      BUFFER-COPY Rqs_detalle TO T-Ocm_detalle.
  END.
  FIND LAST T-Ocm_detalle.
  T-Ocm_header.ultima_linea = T-Ocm_detalle.nro_linea.
  RUN calculos.
  {&OPEN-QUERY-{&BROWSE-NAME}}


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

     RUN detalle_ocompra.p ( INPUT T-Ocm_detalle.nro_articulo,
                             INPUT T-Ocm_detalle.nro_linea,
                             INPUT modo,
                             INPUT 1,
                             OUTPUT v-nro_linea).

    IF v-nro_linea <> 0
    THEN DO:
         RUN calculos.
         {&OPEN-QUERY-{&BROWSE-NAME}}
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

    RUN detalle_ocompra.p ( INPUT  Articulo.nro_articulo,
                            INPUT  0, /* No sabemos el nro de linea */
                            INPUT  modo,
                            INPUT  0, /* modo detalle = CREAR */
                            OUTPUT v-nro_linea).

    IF v-nro_linea <> 0
    THEN DO:
         RUN calculos.
         {&OPEN-QUERY-{&BROWSE-NAME}}
         btn_copiar:SENSITIVE IN FRAME {&FRAME-NAME}        = NO.
         btn_copiar_requerimiento:SENSITIVE        = NO.

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
    
      CREATE T-Ocm_header.
      ASSIGN T-Ocm_header.nro_usuario    = Usuario.nro_usuario 
             T-Ocm_header.cdg_empresa    = Empresa.cdg_empresa
             T-Ocm_header.fecha          = TODAY 
             T-Ocm_header.fecha_ocm      = T-Ocm_header.fecha 
             T-Ocm_header.cdg_empresa    = Empresa.cdg_empresa 
             T-Ocm_header.nro_deposito   = Deposito.nro_deposito 
             T-Ocm_header.tip_comprob    = "" 
             T-Ocm_header.nro_ocompra    = 0  
             T-Ocm_header.estado         = "E" 
             T-Ocm_header.cdg_estado     = "AA"              
             T-Ocm_header.nro_comprob    = T-Ocm_header.nro_ocompra
             T-Ocm_header.prf_comprob    = 0 /* v-pto_venta */
             T-Ocm_header.nro_moneda     = Moneda.nro_moneda 
             T-Ocm_header.cambio         = Moneda.cambio  
             T-Ocm_header.num_sucursal   = sucursal-id    
             T-Ocm_header.origen         = "M"
             v-cdg_moneda                = Moneda.cdg_moneda
             v-dsc_moneda                = Moneda.descripcion
             v-cdg_imputacion            = Imputacion.cdg_imputacion
             v-dsc_imputacion            = Imputacion.dsc_imputacion 
             v-cdg_deposito              = Deposito.cdg_deposito
             v-dsc_deposito              = Deposito.nombre. 

  END.

  DISPLAY
         T-Ocm_header.fecha   
         T-Ocm_header.cambio  
         v-cdg_imputacion
         v-dsc_imputacion
         v-cdg_moneda
         v-dsc_moneda      
         v-cdg_deposito
         v-dsc_deposito 
         v-pto_venta
         WITH FRAME {&FRAME-NAME}.

  codigo_salir = ?.

  rid_req = ?.

  IF    modo = MD_MULTIPLE
     OR modo = MD_ANULACION
     OR modo = MD_EMISION
  THEN DO:
       DO WITH FRAME {&FRAME-NAME}:
          
          T-Ocm_header.tip_comprob:FGCOLOR = 9.
          T-Ocm_header.tip_comprob:BGCOLOR = 15.

          T-Ocm_header.prf_comprob:FGCOLOR = 9.
          T-Ocm_header.prf_comprob:BGCOLOR = 15.
                    
          T-Ocm_header.nro_comprob:FGCOLOR = 9.
          T-Ocm_header.nro_comprob:BGCOLOR = 15.

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
  DISPLAY v-pto_venta v-estado v-cdg_proveedor v-dsc_proveedor 
          v-cdg_condicion_venta v-dsc_condicion_venta v-cdg_domicilio 
          v-dsc_domicilio v-cdg_moneda v-dsc_moneda v-cdg_imputacion 
          v-dsc_imputacion v-cdg_deposito v-dsc_deposito v-cdg_comprador 
          v-dsc_comprador v-cdg_lista_precios v-dsc_lista_precios v-cdg_articulo 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE T-Ocm_header THEN 
    DISPLAY T-Ocm_header.tip_comprob T-Ocm_header.prf_comprob 
          T-Ocm_header.nro_comprob T-Ocm_header.fecha 
          T-Ocm_header.fecha_embarque T-Ocm_header.cambio 
          T-Ocm_header.transportista T-Ocm_header.imp_neto 
          T-Ocm_header.imp_total 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE Btn_salir T-Ocm_header.tip_comprob T-Ocm_header.prf_comprob 
         T-Ocm_header.nro_comprob T-Ocm_header.fecha 
         T-Ocm_header.fecha_embarque T-Ocm_header.cambio 
         T-Ocm_header.transportista BROWSE-9 RECT-2 RECT-3 RECT-4 RECT-5 
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
                btn_verbonificaciones:SENSITIVE           = NO
                btn_verbonifdet:SENSITIVE                 = NO
                T-Ocm_header.tip_comprob:SENSITIVE        = NO
                T-Ocm_header.prf_comprob:SENSITIVE        = NO
                T-Ocm_header.nro_comprob:SENSITIVE        = NO
                T-Ocm_header.fecha:SENSITIVE              = NO
                T-Ocm_header.fecha_embarque:SENSITIVE     = NO 
                T-Ocm_header.transportista:SENSITIVE      = NO
                T-Ocm_header.cambio:SENSITIVE             = NO
                v-cdg_articulo:SENSITIVE                  = NO
                v-cdg_domicilio:SENSITIVE                 = NO
                v-cdg_imputacion:SENSITIVE                = NO
                v-cdg_moneda:SENSITIVE                    = NO
                v-cdg_proveedor:SENSITIVE                 = NO
                v-cdg_comprador:SENSITIVE                 = NO
                v-cdg_deposito:SENSITIVE                  = NO
                v-cdg_lista_precios:SENSITIVE             = NO
                btn_porclasificacion:SENSITIVE            = NO
                btn_copiar_requerimiento:SENSITIVE        = NO.
     END.
     ELSE DO:
            CASE modo:
       
                WHEN MD_ALTA          
                THEN DO:
                     ASSIGN
                        v-cdg_proveedor:SENSITIVE               = YES
                        v-pto_venta:SENSITIVE                   = YES.
         
                END.
                WHEN MD_MULTIPLE      
                THEN DO:
                     ASSIGN
                        T-Ocm_header.tip_comprob:SENSITIVE        = YES
                        T-Ocm_header.prf_comprob:SENSITIVE        = YES
                        T-Ocm_header.nro_comprob:SENSITIVE        = YES
                        v-pto_venta:SENSITIVE                     = NO.

                END.
                WHEN MD_DEFINIDA      
                THEN DO:
                     ASSIGN
                        v-pto_venta:SENSITIVE                     = NO.
         
                END.
                WHEN MD_RELACION      
                THEN DO:
                     ASSIGN
                        v-pto_venta:SENSITIVE                     = NO.
         
                END.
                WHEN MD_READONLY      
                THEN DO:
                     ASSIGN
                        v-pto_venta:SENSITIVE                     = NO.
         
                END.
                WHEN MD_CAMBIO        
                THEN DO:
                     ASSIGN
                        v-pto_venta:SENSITIVE                     = NO.

                END.
                WHEN MD_ANULACION        
                THEN DO:
                     ASSIGN
                        T-Ocm_header.tip_comprob:SENSITIVE        = YES
                        T-Ocm_header.prf_comprob:SENSITIVE        = YES
                        T-Ocm_header.nro_comprob:SENSITIVE        = YES
                        v-pto_venta:SENSITIVE                     = NO.
                END.
                WHEN MD_EMISION        
                THEN DO:
                     ASSIGN
                        T-Ocm_header.tip_comprob:SENSITIVE        = YES
                        T-Ocm_header.prf_comprob:SENSITIVE        = YES
                        T-Ocm_header.nro_comprob:SENSITIVE        = YES
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

    DO TRANSACTION:

       ASSIGN FRAME {&FRAME-NAME} v-pto_venta.
       ASSIGN  T-Ocm_header.tip_comprob = "OC"
               T-Ocm_header.prf_comprob = v-pto_venta.
       
       RUN emitir_ocompra.p ( INPUT-OUTPUT TABLE T-Ocm_header,
                              INPUT-OUTPUT TABLE T-Ocm_detalle,
                              INPUT-OUTPUT TABLE T-Ocm_detalle_entr,
                              INPUT-OUTPUT TABLE T-Ocm_header-bon,
                              INPUT-OUTPUT TABLE T-Ocm_detalle-bon ).

       FIND FIRST T-Ocm_header.

       IF rid_req <> ? 
       THEN DO:
           FIND Rqs_header WHERE ROWID(Rqs_header) = rid_req EXCLUSIVE-LOCK.
           ASSIGN Rqs_header.cdg_estado = "CC"
                  Rqs_header.nro_ocompra = T-Ocm_header.nro_ocompra.
           FOR EACH Rqs_detalle OF Rqs_header EXCLUSIVE-LOCK:
               Rqs_detalle.cdg_estado = "CC".
           END.
           RELEASE Rqs_header.
       END.

       RUN borrar_tablas_temporales.

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
          btn_imprim:SENSITIVE                      = NO
          T-Ocm_header.tip_comprob:SENSITIVE        = NO
          T-Ocm_header.prf_comprob:SENSITIVE        = NO
          T-Ocm_header.nro_comprob:SENSITIVE        = NO
          T-Ocm_header.fecha:SENSITIVE              = NO
          T-Ocm_header.fecha_embarque:SENSITIVE     = NO
          T-Ocm_header.cambio:SENSITIVE             = NO
          T-Ocm_header.transportista:SENSITIVE      = NO
          v-cdg_articulo:SENSITIVE                  = NO
          v-cdg_domicilio:SENSITIVE                 = NO
          v-cdg_imputacion:SENSITIVE                = NO
          v-cdg_moneda:SENSITIVE                    = NO
          v-cdg_proveedor:SENSITIVE                 = NO
          v-cdg_comprador:SENSITIVE                 = NO
          v-cdg_deposito:SENSITIVE                  = NO
          v-cdg_lista_precios:SENSITIVE             = NO
          btn_porclasificacion:SENSITIVE            = NO
          btn_copiar_requerimiento:SENSITIVE        = NO.

     CASE modo:

       WHEN MD_ALTA          
       THEN DO:
            ASSIGN
                btn_copiar_requerimiento:SENSITIVE        = YES
                T-Ocm_header.tip_comprob:SENSITIVE        = NO
                T-Ocm_header.prf_comprob:SENSITIVE        = NO
                T-Ocm_header.nro_comprob:SENSITIVE        = NO
                btn_grabar:SENSITIVE                      = YES
                btn_copiar:SENSITIVE                      = YES
                btn_cancel:SENSITIVE                      = YES
                btn_anular:SENSITIVE                      = NO
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = NO
                btn_verbonificaciones:SENSITIVE           = YES
                T-Ocm_header.fecha:SENSITIVE              = YES
                T-Ocm_header.fecha_embarque:SENSITIVE     = YES
                T-Ocm_header.cambio:SENSITIVE             = YES
                T-Ocm_header.transportista:SENSITIVE      = YES
                v-cdg_articulo:SENSITIVE                  = YES
                v-cdg_condicion_venta:SENSITIVE           = YES
                v-cdg_domicilio:SENSITIVE                 = YES
                v-cdg_imputacion:SENSITIVE                = YES
                v-cdg_moneda:SENSITIVE                    = YES
                v-cdg_proveedor:SENSITIVE                 = NO
                v-cdg_comprador:SENSITIVE                 = YES
                v-cdg_lista_precios:SENSITIVE             = YES
                v-cdg_deposito:SENSITIVE                  = YES
                btn_porclasificacion:SENSITIVE            = YES.                
       END.
       WHEN MD_MULTIPLE      
       THEN DO:
            ASSIGN
                btn_cancel:SENSITIVE                      = YES
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES
                btn_verbonificaciones:SENSITIVE           = YES
                btn_verbonifdet:SENSITIVE                 = YES
                T-Ocm_header.tip_comprob:SENSITIVE        = NO
                T-Ocm_header.prf_comprob:SENSITIVE        = NO
                T-Ocm_header.nro_comprob:SENSITIVE        = NO.
       END.
       WHEN MD_DEFINIDA      
       THEN DO:
            ASSIGN
                btn_verbonificaciones:SENSITIVE           = YES
                btn_verbonifdet:SENSITIVE                 = YES
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES.
       END.
       WHEN MD_RELACION      
       THEN DO:
            ASSIGN
                btn_verbonificaciones:SENSITIVE           = YES
                btn_verbonifdet:SENSITIVE                 = YES
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES.
       END.
       WHEN MD_READONLY      
       THEN DO:
            ASSIGN
                btn_verbonificaciones:SENSITIVE           = YES
                btn_verbonifdet:SENSITIVE                 = YES
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES.
       END.
       WHEN MD_CAMBIO        
       THEN DO:
            ASSIGN
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES.
       END.
       WHEN MD_ANULACION        
       THEN DO:
            ASSIGN
                btn_verbonificaciones:SENSITIVE           = YES
                btn_verbonifdet:SENSITIVE                 = YES
                btn_anular:SENSITIVE                      = YES
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES.
       END.
       WHEN MD_EMISION        
       THEN DO:
            ASSIGN
                btn_verbonificaciones:SENSITIVE           = YES
                btn_verbonifdet:SENSITIVE                 = YES
                btn_grabar:SENSITIVE                      = YES
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES.

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


   RUN getptovta.p ( INPUT "OCM", OUTPUT v-pto_venta).

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
   
   RUN getparametro.p (  INPUT  "DFDEPOSI",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).
   FIND Deposito WHERE Deposito.cdg_deposito = v-valor_c 
                       NO-LOCK.

   RUN getparametro.p (  INPUT  "DFCNCOMP",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).

   FIND Imputacion WHERE Imputacion.cdg_imputacion = v-valor_n 
                         NO-LOCK.
   /*FIND Cuenta OF Imputacion NO-LOCK.*/

   RUN titulo_window ( INPUT "Ordenes de Compra" ).           
   

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
  v-tip_comprob = "OC".
  v-prox_docum = "POCM" + STRING(pto_venta,"9999").

  
  ASSIGN
      T-Ocm_header.cdg_condiva          = Condicion_impos.cdg_condiva
      T-Ocm_header.nro_cndventa         = Condicion_venta.nro_cndventa
      T-Ocm_header.nombre               = Proveedor.nombre
      T-Ocm_header.cuit                 = Proveedor.cuit
      T-Ocm_header.nro_proveedor        = Proveedor.nro_proveedor.

  RUN traer_proveedor.
  RUN traer_condicion_venta.
  /*RUN traer_imputacion.*/
  RUN traer_lista.
  RUN traer_comprador.

  DISPLAY  v-cdg_proveedor 
           v-dsc_proveedor

           v-cdg_condicion_venta
           v-dsc_condicion_venta

           v-cdg_imputacion
           v-dsc_imputacion

           v-cdg_lista_precios
           v-dsc_lista_precios

           v-cdg_comprador
           v-dsc_comprador

           v-cdg_deposito
           v-dsc_deposito

           T-Ocm_header.tip_comprob
           WITH FRAME {&FRAME-NAME}.
           
   FIND Domicilio_prv OF Proveedor NO-LOCK NO-ERROR.
   IF AVAILABLE Domicilio_prv 
   THEN DO:
      FIND Provincia OF Domicilio_prv NO-LOCK.
      ASSIGN  T-Ocm_header.nro_domicilio = Domicilio_prv.nro_domicilio
              T-Ocm_header.direccion     = Domicilio_prv.direccion
              T-Ocm_header.cdg_provincia = Domicilio_prv.cdg_provincia
              T-Ocm_header.localidad     = Domicilio_prv.localidad
              T-Ocm_header.cdg_postal    = Domicilio_prv.cdg_postal
              T-Ocm_header.cdg_zonag     = Domicilio_prv.cdg_zonag
              v-cdg_domicilio            = Domicilio_prv.nro_domicilio
              v-dsc_domicilio            = Domicilio_prv.nombre.
      DISABLE v-cdg_domicilio WITH FRAME {&FRAME-NAME}.      
   END.
   ELSE DO:  /* No hay ninguno o hay mas de uno */
      ASSIGN  T-Ocm_header.nro_domicilio = 0
              T-Ocm_header.direccion     = ""
              T-Ocm_header.cdg_provincia = ""
              T-Ocm_header.localidad     = ""
              T-Ocm_header.cdg_postal    = ""
              T-Ocm_header.cdg_zonag     = ""
              v-cdg_domicilio            = 0
              v-dsc_domicilio            = "".
      v-cdg_domicilio:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
   END.   

   RUN habilitar_campos ( YES ).

   DISPLAY v-cdg_domicilio
           v-dsc_domicilio
           WITH FRAME {&FRAME-NAME}.

   /*
   RUN calculos.   
   
   IF cntrl_deuda 
      THEN RUN sumstcre.p ( INPUT ROWID(Proveedor),
                            OUTPUT saldo_cc,
                            OUTPUT saldo_ccv,
                            OUTPUT tot_valores,
                            OUTPUT tot_remitos,
                            OUTPUT tot_pedidos,
                            OUTPUT cant_rech,
                            OUTPUT tot_credito ).

   IF saldo_ccv <> 0 THEN RUN PONMENSJ.P ( INPUT "FACT021" ).

   IF Proveedor.credito_maximo < tot_credito 
   THEN DO:
      RUN PONMENSJ.P ( INPUT "FACT020" ).
      RUN d-verstcre.w ( INPUT ROWID(Proveedor),
                         INPUT saldo_cc,
                         INPUT saldo_ccv,
                         INPUT tot_valores,
                         INPUT tot_remitos,
                         INPUT tot_pedidos,
                         INPUT cant_rech,
                         INPUT tot_credito ).
   END.

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
     WHEN MD_DEFINIDA  THEN v-txtitulo = " Consulta Individual de " + txtitulo.
     WHEN MD_RELACION  THEN v-txtitulo = " Consulta Relacionada de " + txtitulo.
     WHEN MD_READONLY  THEN v-txtitulo = " Consulta Sólo Lectura de " + txtitulo.
     WHEN MD_CAMBIO    THEN v-txtitulo = " Modificación y Reemisión de " + txtitulo.
     WHEN MD_ANULACION THEN v-txtitulo = " Anulación de " + txtitulo.
     WHEN MD_EMISION   THEN v-txtitulo = " Emisión de " + txtitulo + "Pendientes".

 END CASE.     

 {&WINDOW-NAME}:TITLE = "DYNASYS/COM " + NRO_RELEASE + " - " + Usuario.cdg_empresa + " - " + v-txtitulo + " User:" + USERID("sic").

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_comprador C-Win 
PROCEDURE traer_comprador :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND Comprador  OF Proveedor NO-LOCK.
    ASSIGN
        v-cdg_comprador         = Comprador.cdg_comprador
        v-dsc_comprador         = Comprador.nom_comprador.

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

    FIND Condicion_venta  OF T-Ocm_header NO-LOCK.
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

   FIND Ocm_header WHERE ROWID(Ocm_header) = rid_ocompra NO-LOCK.
   BUFFER-COPY Ocm_header TO T-Ocm_header.

   FOR EACH Ocm_detalle OF Ocm_header:
       CREATE T-Ocm_detalle.
       BUFFER-COPY Ocm_detalle TO T-Ocm_detalle.
   END.    

   FOR EACH Ocm_header-bon OF Ocm_header:
       CREATE T-Ocm_header-bon.
       BUFFER-COPY Ocm_header-bon TO T-Ocm_header-bon.
   END.
    
   FOR EACH Ocm_detalle-bon OF Ocm_header:
       CREATE T-Ocm_detalle-bon.
       BUFFER-COPY Ocm_detalle-bon TO T-Ocm_detalle-bon.
   END.
  
   FIND Estado_ocompra OF Ocm_header NO-LOCK.
   v-estado = Estado_ocompra.descripcion.
   RUN traer_tablas.
   DISPLAY
        T-Ocm_header.cambio 
        T-Ocm_header.fecha 
        T-Ocm_header.fecha_embarque 
        /*
        T-Ocm_header.imp_neto 
        T-Ocm_header.imp_total
        */ 
        T-Ocm_header.transportista 
        T-Ocm_header.nro_comprob 
        T-Ocm_header.prf_comprob 
        T-Ocm_header.tip_comprob 
        v-cdg_condicion_venta 
        v-cdg_domicilio 
        v-cdg_imputacion 
        v-cdg_moneda 
        v-cdg_proveedor 
        v-cdg_lista_precios 
        v-cdg_deposito 
        v-cdg_comprador 
        v-dsc_condicion_venta
        v-dsc_domicilio 
        v-dsc_imputacion 
        v-dsc_moneda 
        v-dsc_proveedor 
        v-dsc_lista_precios 
        v-dsc_deposito 
        v-dsc_comprador 
        v-estado
        WITH FRAME {&FRAME-NAME}.

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

    FIND Domicilio_prv OF T-Ocm_header NO-LOCK.
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

    FIND Imputacion       OF T-Ocm_header NO-LOCK.
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

    FIND Lista_precios  OF T-Ocm_header NO-LOCK.
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

    FIND Moneda    OF T-Ocm_header   NO-LOCK.
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

    FIND Proveedor OF T-Ocm_header NO-LOCK.
    ASSIGN
        v-cdg_proveedor = Proveedor.cdg_proveedor
        v-dsc_proveedor = Proveedor.nombre.
    
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

  RUN traer_condicion_venta.
  RUN traer_imputacion.
  RUN traer_moneda.
  RUN traer_proveedor.
  RUN traer_domicilio.
  RUN traer_lista.
  RUN traer_comprador.

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

    {validartabla.i "Proveedor"         "cdg_proveedor"   "nombre"         "OCOM001"}
    {validartabla.i "Comprador"         "cdg_comprador"   "nom_comprador"  "OCOM003"}
    {validartabla.i "Deposito"          "cdg_deposito"    "nombre"         "OCOM023"}
    {validartabla.i "Lista_precios"     "cdg_lista"       "descripcion"    "OCOM009"}

    {validartabla.i "Moneda"            "cdg_moneda"      "descripcion"    "OCOM019"}
    {validartabla.i "Condicion_venta"   "cdg_cndventa"    "descripcion"    "OCOM002"}
    {validartabla.i "Imputacion"        "cdg_imputacion"  "dsc_imputacion" "OCOM024"}

    IF T-Ocm_header.nombre = ""
    THEN DO:
       RUN PONMENSJ.P (INPUT "OCOM027").
       RETURN.
    END.  
  
    IF T-Ocm_header.cuit = ""
    THEN DO:
       RUN PONMENSJ.P (INPUT "OCOM028").
       RETURN.
    END.  
  
    IF T-Ocm_header.cambio = 0
    THEN DO:
       RUN PONMENSJ.P (INPUT "OCOM029").
       RETURN.
    END.  
   
    IF ROWID(T-Ocm_header) = ?
    THEN DO:
       RUN PONMENSJ.P (INPUT "OCOM007").
       RETURN.
    END.
  
    IF NOT CAN-FIND(FIRST T-Ocm_detalle OF T-Ocm_header)
    THEN DO:
       RUN PONMENSJ.P (INPUT "OCOM005").
       RETURN.
    END.
  
    /*
    IF T-Ocm_header.cambio_dolar = 0
    THEN DO:
       RUN PONMENSJ.P (INPUT "OCOM030").
       RETURN.
    END.  

    IF NOT ( cliente_sinesp OR AVAILABLE Proveedor )
    THEN DO:
       RUN PONMENSJ.P (INPUT "OCOM001").
       RETURN.
    END.

    IF AVAILABLE Proveedor AND NOT AVAILABLE Domicilio
    THEN DO:
       RUN PONMENSJ.P (INPUT "OCOM010").
       RETURN.
    END.
    */

    FIND FIRST Domicilio_prv OF Proveedor WHERE Domicilio_prv.nro_domicilio = INPUT FRAME {&FRAME-NAME} v-cdg_domicilio NO-LOCK NO-ERROR.
    IF NOT AVAILABLE Domicilio_prv
    THEN DO:
       RUN PONMENSJ.P (INPUT "OCOM006").
       RETURN.
    END.
    ELSE DO:
       ASSIGN
           T-Ocm_header.nro_domicilio = Domicilio_prv.nro_domicilio
           T-Ocm_header.direccion     = Domicilio_prv.direccion
           T-Ocm_header.cdg_provincia = Domicilio_prv.cdg_provincia
           T-Ocm_header.localidad     = Domicilio_prv.localidad
           T-Ocm_header.cdg_postal    = Domicilio_prv.cdg_postal
           T-Ocm_header.cdg_zonag     = Domicilio_prv.cdg_zonag.
    END.
  
    /* Error 26 reservado para fecha invalida */

 
    IF NOT CAN-FIND(FIRST T-Ocm_detalle OF  T-Ocm_header)
    THEN DO:
       RUN PONMENSJ.P (INPUT "FAPR005").
       RETURN.
    END.

    hubo_error = NO.

    &SCOPED-DEFINE TABLA-MAESTRA  T-Ocm_header

    {asignartabla.i "Proveedor"         "nro_proveedor"   "nro_proveedor"    }
    {asignartabla.i "Comprador"         "nro_comprador"   "nro_comprador"    }
    {asignartabla.i "Deposito"          "nro_deposito"    "nro_deposito"     }
    {asignartabla.i "Lista_precios"     "cdg_lista"       "cdg_lista"        }
    {asignartabla.i "Moneda"            "nro_moneda"      "nro_moneda"       }
    {asignartabla.i "Condicion_venta"   "nro_cndventa"    "nro_cndventa"     }
    {asignartabla.i "Imputacion"        "cdg_imputacion"  "cdg_imputacion"   }
 
    &UNDEFINE TABLA-MAESTRA

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

