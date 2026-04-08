&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win

/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Rendgastos_dt NO-UNDO LIKE Rendgastos_dt.
DEFINE TEMP-TABLE T-Rendgastos_hd NO-UNDO LIKE Rendgastos_hd.


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
/*          This .W file was created with the Progress AppBuilder.      */
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
DEFINE VARIABLE                rid_rendgastos    AS ROWID.
DEFINE VARIABLE                modo           AS INTEGER.
&ELSE
DEFINE INPUT-OUTPUT PARAMETER  rid_rendgastos    AS ROWID.
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

DEFINE VARIABLE fecha_inicial             AS DATE.
DEFINE VARIABLE fecha_elegida             AS DATE.

DEFINE VARIABLE rc                        AS INTEGER.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME BROWSE-2

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Rendgastos_dt Articulo T-Rendgastos_hd

/* Definitions for BROWSE BROWSE-2                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-2 Articulo.cdg_articulo ~
Articulo.descripcion T-Rendgastos_dt.importe_empleado ~
T-Rendgastos_dt.importe_empresa T-Rendgastos_dt.observacion 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-2 ~
T-Rendgastos_dt.importe_empleado T-Rendgastos_dt.importe_empresa ~
T-Rendgastos_dt.observacion 
&Scoped-define ENABLED-TABLES-IN-QUERY-BROWSE-2 T-Rendgastos_dt
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-BROWSE-2 T-Rendgastos_dt
&Scoped-define QUERY-STRING-BROWSE-2 FOR EACH T-Rendgastos_dt OF T-Rendgastos_hd ~
      WHERE T-Rendgastos_dt.fch_gasto = v-fecha_gasto NO-LOCK, ~
      EACH Articulo OF T-Rendgastos_dt NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-2 OPEN QUERY BROWSE-2 FOR EACH T-Rendgastos_dt OF T-Rendgastos_hd ~
      WHERE T-Rendgastos_dt.fch_gasto = v-fecha_gasto NO-LOCK, ~
      EACH Articulo OF T-Rendgastos_dt NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-2 T-Rendgastos_dt Articulo
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-2 T-Rendgastos_dt
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-2 Articulo


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define FIELDS-IN-QUERY-DEFAULT-FRAME T-Rendgastos_hd.tip_comprob ~
T-Rendgastos_hd.prf_comprob T-Rendgastos_hd.nro_comprob ~
T-Rendgastos_hd.fch_rendicion T-Rendgastos_hd.cdg_estado ~
T-Rendgastos_hd.cdg_tiporendgastos T-Rendgastos_hd.des_fecha ~
T-Rendgastos_hd.has_fecha T-Rendgastos_hd.cambio ~
T-Rendgastos_hd.imp_anticipo T-Rendgastos_hd.imp_rendicion ~
T-Rendgastos_hd.imp_imputado T-Rendgastos_hd.abierta 
&Scoped-define ENABLED-FIELDS-IN-QUERY-DEFAULT-FRAME ~
T-Rendgastos_hd.tip_comprob T-Rendgastos_hd.prf_comprob ~
T-Rendgastos_hd.nro_comprob T-Rendgastos_hd.fch_rendicion ~
T-Rendgastos_hd.cdg_tiporendgastos T-Rendgastos_hd.cambio ~
T-Rendgastos_hd.imp_rendicion T-Rendgastos_hd.imp_imputado ~
T-Rendgastos_hd.abierta 
&Scoped-define ENABLED-TABLES-IN-QUERY-DEFAULT-FRAME T-Rendgastos_hd
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-DEFAULT-FRAME T-Rendgastos_hd
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-BROWSE-2}
&Scoped-define QUERY-STRING-DEFAULT-FRAME FOR EACH T-Rendgastos_hd SHARE-LOCK
&Scoped-define OPEN-QUERY-DEFAULT-FRAME OPEN QUERY DEFAULT-FRAME FOR EACH T-Rendgastos_hd SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-DEFAULT-FRAME T-Rendgastos_hd
&Scoped-define FIRST-TABLE-IN-QUERY-DEFAULT-FRAME T-Rendgastos_hd


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS T-Rendgastos_hd.tip_comprob ~
T-Rendgastos_hd.prf_comprob T-Rendgastos_hd.nro_comprob ~
T-Rendgastos_hd.fch_rendicion T-Rendgastos_hd.cdg_tiporendgastos ~
T-Rendgastos_hd.cambio T-Rendgastos_hd.imp_rendicion ~
T-Rendgastos_hd.imp_imputado T-Rendgastos_hd.abierta 
&Scoped-define ENABLED-TABLES T-Rendgastos_hd
&Scoped-define FIRST-ENABLED-TABLE T-Rendgastos_hd
&Scoped-Define ENABLED-OBJECTS Btn_salir BROWSE-2 RECT-2 RECT-3 RECT-5 ~
RECT-6 RECT-7 
&Scoped-Define DISPLAYED-FIELDS T-Rendgastos_hd.tip_comprob ~
T-Rendgastos_hd.prf_comprob T-Rendgastos_hd.nro_comprob ~
T-Rendgastos_hd.fch_rendicion T-Rendgastos_hd.cdg_estado ~
T-Rendgastos_hd.cdg_tiporendgastos T-Rendgastos_hd.des_fecha ~
T-Rendgastos_hd.has_fecha T-Rendgastos_hd.cambio ~
T-Rendgastos_hd.imp_anticipo T-Rendgastos_hd.imp_rendicion ~
T-Rendgastos_hd.imp_imputado T-Rendgastos_hd.abierta 
&Scoped-define DISPLAYED-TABLES T-Rendgastos_hd
&Scoped-define FIRST-DISPLAYED-TABLE T-Rendgastos_hd
&Scoped-Define DISPLAYED-OBJECTS v-pto_venta v-comprobante v-cdg_moneda ~
v-dsc_moneda v-cdg_proveedor v-dsc_proveedor v-cdg_articulo v-fecha_gasto 

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
     SIZE 23 BY 1.

DEFINE BUTTON Btn_salir DEFAULT 
     LABEL "&Salir" 
     SIZE 21 BY 1.33
     BGCOLOR 8 .

DEFINE VARIABLE v-cdg_articulo AS CHARACTER FORMAT "X(15)":U 
     LABEL "Artículo" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 29 BY 1
     BGCOLOR 14 FGCOLOR 12 FONT 6 NO-UNDO.

DEFINE VARIABLE v-cdg_moneda AS CHARACTER FORMAT "X(3)" 
     LABEL "Moneda" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_proveedor AS CHARACTER FORMAT "X(256)" 
     LABEL "Empleado" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-comprobante AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 29 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE v-dsc_moneda AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 53 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_proveedor AS CHARACTER FORMAT "X(40)" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 53 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-fecha_gasto AS DATE FORMAT "99/99/9999":U 
     LABEL "Fecha Gasto" 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     BGCOLOR 14 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-pto_venta AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN NATIVE 
     SIZE 8 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 133 BY 1.91.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 23 BY 1.91.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 120 BY 1.43.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 157 BY 5.24.

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 37 BY 1.43.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-2 FOR 
      T-Rendgastos_dt, 
      Articulo SCROLLING.

DEFINE QUERY DEFAULT-FRAME FOR 
      T-Rendgastos_hd SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-2 C-Win _STRUCTURED
  QUERY BROWSE-2 NO-LOCK DISPLAY
      Articulo.cdg_articulo COLUMN-LABEL "Código!Gasto" FORMAT "X(12)":U
            WIDTH 20.2
      Articulo.descripcion COLUMN-LABEL "Descripcion!Gasto" FORMAT "X(40)":U
            WIDTH 50.8
      T-Rendgastos_dt.importe_empleado COLUMN-LABEL "Pagado!Empleado" FORMAT "->,>>>,>>9.99":U
      T-Rendgastos_dt.importe_empresa COLUMN-LABEL "Pagado!Empresa" FORMAT "->,>>>,>>9.99":U
      T-Rendgastos_dt.observacion FORMAT "X(200)":U
  ENABLE
      T-Rendgastos_dt.importe_empleado
      T-Rendgastos_dt.importe_empresa
      T-Rendgastos_dt.observacion
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 157 BY 18.1
         TITLE "Rubros que componen esta rendición" EXPANDABLE.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btn_grabar AT ROW 1.48 COL 4
     btn_copiar AT ROW 1.48 COL 26
     btn_cancel AT ROW 1.48 COL 48
     btn_anular AT ROW 1.48 COL 70
     btn_observ AT ROW 1.48 COL 92
     btn_imprim AT ROW 1.48 COL 114
     Btn_salir AT ROW 1.48 COL 138
     T-Rendgastos_hd.tip_comprob AT ROW 3.62 COL 19 COLON-ALIGNED
          LABEL "Rendición"
          VIEW-AS FILL-IN 
          SIZE 7 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Rendgastos_hd.prf_comprob AT ROW 3.62 COL 27 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 7 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Rendgastos_hd.nro_comprob AT ROW 3.62 COL 35 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-pto_venta AT ROW 3.62 COL 49 COLON-ALIGNED NO-LABEL
     v-comprobante AT ROW 3.62 COL 59 COLON-ALIGNED NO-LABEL
     T-Rendgastos_hd.fch_rendicion AT ROW 3.62 COL 104 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Rendgastos_hd.cdg_estado AT ROW 3.62 COL 136 COLON-ALIGNED
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Ingresada","IN",
                     "Anticipo Pagado","PA",
                     "Cerrada","CE",
                     "Liquidada","LQ",
                     "Anulada","ZZ"
          DROP-DOWN-LIST
          SIZE 21 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Rendgastos_hd.cdg_tiporendgastos AT ROW 4.81 COL 19 COLON-ALIGNED
          LABEL "Tipo Rendición"
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Item 1","Item 1"
          DROP-DOWN-LIST
          SIZE 69 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Rendgastos_hd.des_fecha AT ROW 4.81 COL 104 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Rendgastos_hd.has_fecha AT ROW 4.81 COL 141 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_moneda AT ROW 6 COL 19 COLON-ALIGNED NO-TAB-STOP 
     v-dsc_moneda AT ROW 6 COL 35 COLON-ALIGNED NO-LABEL
     T-Rendgastos_hd.cambio AT ROW 6 COL 100 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 20 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Rendgastos_hd.imp_anticipo AT ROW 6 COL 137 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 20 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_proveedor AT ROW 7.19 COL 19 COLON-ALIGNED
     v-dsc_proveedor AT ROW 7.19 COL 35 COLON-ALIGNED NO-LABEL
     T-Rendgastos_hd.imp_rendicion AT ROW 7.19 COL 100 COLON-ALIGNED
          LABEL "Total"
          VIEW-AS FILL-IN 
          SIZE 20.2 BY 1
          BGCOLOR 7 FGCOLOR 15 
     T-Rendgastos_hd.imp_imputado AT ROW 7.19 COL 137 COLON-ALIGNED
          LABEL "Rendido"
          VIEW-AS FILL-IN NATIVE 
          SIZE 20 BY 1
          BGCOLOR 7 FGCOLOR 15 
     v-cdg_articulo AT ROW 9.1 COL 19 COLON-ALIGNED
     btn_porclasificacion AT ROW 9.1 COL 52
     v-fecha_gasto AT ROW 9.1 COL 104 COLON-ALIGNED
     T-Rendgastos_hd.abierta AT ROW 9.33 COL 135 NO-LABEL
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Abierta", yes,
"Cerrada", no
          SIZE 24 BY .71
     BROWSE-2 AT ROW 10.52 COL 3
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 160 BY 27.62.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME DEFAULT-FRAME
     RECT-2 AT ROW 1.24 COL 3
     RECT-3 AT ROW 1.24 COL 137
     RECT-5 AT ROW 8.86 COL 3
     RECT-6 AT ROW 3.38 COL 3
     RECT-7 AT ROW 8.86 COL 123
     "Estado:" VIEW-AS TEXT
          SIZE 8 BY .62 AT ROW 9.33 COL 127
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
      TABLE: T-Rendgastos_dt T "?" NO-UNDO sic Rendgastos_dt
      TABLE: T-Rendgastos_hd T "?" NO-UNDO sic Rendgastos_hd
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Rendiciones de gastos"
         HEIGHT             = 27.62
         WIDTH              = 160
         MAX-HEIGHT         = 34.33
         MAX-WIDTH          = 204.8
         VIRTUAL-HEIGHT     = 34.33
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
                                                                        */
/* BROWSE-TAB BROWSE-2 abierta DEFAULT-FRAME */
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
/* SETTINGS FOR BUTTON btn_observ IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_porclasificacion IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX T-Rendgastos_hd.cdg_estado IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX T-Rendgastos_hd.cdg_tiporendgastos IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN T-Rendgastos_hd.des_fecha IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Rendgastos_hd.has_fecha IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Rendgastos_hd.imp_anticipo IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Rendgastos_hd.imp_imputado IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN T-Rendgastos_hd.imp_rendicion IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN T-Rendgastos_hd.tip_comprob IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN v-cdg_articulo IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_moneda IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
ASSIGN 
       v-cdg_moneda:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR FILL-IN v-cdg_proveedor IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-comprobante IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_moneda IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_proveedor IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-fecha_gasto IN FRAME DEFAULT-FRAME
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
     _TblList          = "Temp-Tables.T-Rendgastos_dt OF Temp-Tables.T-Rendgastos_hd,sic.Articulo OF Temp-Tables.T-Rendgastos_dt"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "Temp-Tables.T-Rendgastos_dt.fch_gasto = v-fecha_gasto"
     _FldNameList[1]   > sic.Articulo.cdg_articulo
"Articulo.cdg_articulo" "Código!Gasto" ? "character" ? ? ? ? ? ? no ? no no "20.2" yes no no "U" "" ""
     _FldNameList[2]   > sic.Articulo.descripcion
"Articulo.descripcion" "Descripcion!Gasto" ? "character" ? ? ? ? ? ? no ? no no "50.8" yes no no "U" "" ""
     _FldNameList[3]   > Temp-Tables.T-Rendgastos_dt.importe_empleado
"T-Rendgastos_dt.importe_empleado" "Pagado!Empleado" ? "decimal" ? ? ? ? ? ? yes ? no no ? yes no no "U" "" ""
     _FldNameList[4]   > Temp-Tables.T-Rendgastos_dt.importe_empresa
"T-Rendgastos_dt.importe_empresa" "Pagado!Empresa" ? "decimal" ? ? ? ? ? ? yes ? no no ? yes no no "U" "" ""
     _FldNameList[5]   > Temp-Tables.T-Rendgastos_dt.observacion
"T-Rendgastos_dt.observacion" ? ? "character" ? ? ? ? ? ? yes ? no no ? yes no no "U" "" ""
     _Query            is OPENED
*/  /* BROWSE BROWSE-2 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME DEFAULT-FRAME
/* Query rebuild information for FRAME DEFAULT-FRAME
     _TblList          = "Temp-Tables.T-Rendgastos_hd"
     _Query            is OPENED
*/  /* FRAME DEFAULT-FRAME */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Rendiciones de gastos */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Rendiciones de gastos */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-2
&Scoped-define SELF-NAME BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-2 C-Win
ON ROW-LEAVE OF BROWSE-2 IN FRAME DEFAULT-FRAME /* Rubros que componen esta rendición */
DO:

  IF BROWSE-2:CURRENT-ROW-MODIFIED
  THEN DO:
        T-Rendgastos_hd.imp_rendicion = T-Rendgastos_hd.imp_rendicion + 
                                        DECIMAL(T-Rendgastos_dt.importe_empleado:SCREEN-VALUE IN BROWSE {&BROWSE-NAME}) -
                                        T-Rendgastos_dt.importe_empleado + 
                                        DECIMAL(T-Rendgastos_dt.importe_empresa:SCREEN-VALUE IN BROWSE {&BROWSE-NAME}) -
                                        T-Rendgastos_dt.importe_empresa.

        DISPLAY T-Rendgastos_hd.imp_rendicion WITH FRAME {&FRAME-NAME}.

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
    MESSAGE "Desea ANULAR este comprobante" 
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
    IF sino-msg
    THEN DO:
         RUN anular_comprobante_cliente.p (INPUT ROWID(Rendgastos_hd), OUTPUT pudo_anular).
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

  RUN d-seleccionar_rendgastos.w (OUTPUT rid_rendgastos).
  IF rid_rendgastos <> ?
  THEN DO:
     FIND Rendgastos_hd WHERE ROWID(Rendgastos_hd) = rid_rendgastos NO-LOCK.
     DISPLAY Rendgastos_hd.tip_comprob @ T-Rendgastos_hd.tip_comprob 
             Rendgastos_hd.prf_comprob @ T-Rendgastos_hd.prf_comprob
             Rendgastos_hd.nro_comprob @ T-Rendgastos_hd.nro_comprob
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
         T-Rendgastos_hd.imp_anticipo 
         T-Rendgastos_hd.cambio 
         T-Rendgastos_hd.des_fecha 
         T-Rendgastos_hd.has_fecha
         T-Rendgastos_hd.fch_rendicion 
         T-Rendgastos_hd.cdg_tiporendgastos.
         
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
    MESSAGE "Desea REIMPRIMIR este comprobante?" 
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
    IF sino-msg
    THEN DO:
         RUN imprimir_rendicion_gastos.p (ROWID(Rendgastos_hd)).
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_observ
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_observ C-Win
ON CHOOSE OF btn_observ IN FRAME DEFAULT-FRAME /* Leyenda */
DO:

   DEFINE VARIABLE puso_ok AS LOGICAL.
   RUN c-editar_leyenda_comprobante.w ( INPUT-OUTPUT T-Rendgastos_hd.leyenda,
                                        INPUT "Leyenda del Comprobante Actual",
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
                               OUTPUT rid_tabla,
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


&Scoped-define SELF-NAME T-Rendgastos_hd.cdg_tiporendgastos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Rendgastos_hd.cdg_tiporendgastos C-Win
ON VALUE-CHANGED OF T-Rendgastos_hd.cdg_tiporendgastos IN FRAME DEFAULT-FRAME /* Tipo Rendición */
DO:
    ASSIGN T-Rendgastos_hd.cdg_tiporendgastos.
       MESSAGE T-Rendgastos_hd.cdg_tiporendgastos VIEW-AS ALERT-BOX MESSAGE.
    FIND Tipo_rendgastos OF T-Rendgastos_hd NO-LOCK.
    T-Rendgastos_hd.tip_comprob = Tipo_rendgastos.sigla_prefijo.
    DISPLAY T-Rendgastos_hd.tip_comprob
            WITH FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Rendgastos_hd.des_fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Rendgastos_hd.des_fecha C-Win
ON LEAVE OF T-Rendgastos_hd.des_fecha IN FRAME DEFAULT-FRAME /* Desde Fecha */
DO:
    RUN validar_rango_fechas.p ( INPUT T-Rendgastos_hd.des_fecha:SCREEN-VALUE IN FRAME {&FRAME-NAME}, 
                                 INPUT T-Rendgastos_hd.has_fecha:SCREEN-VALUE IN FRAME {&FRAME-NAME},
                                 INPUT "REND051,REND052,REND053",
                                 OUTPUT rc ).
    IF rc <> 0 THEN RETURN NO-APPLY.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Rendgastos_hd.des_fecha C-Win
ON MOUSE-MENU-DOWN OF T-Rendgastos_hd.des_fecha IN FRAME DEFAULT-FRAME /* Desde Fecha */
DO:
 {tghelpfecha.i "T-Rendgastos_hd.des_fecha"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Rendgastos_hd.has_fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Rendgastos_hd.has_fecha C-Win
ON LEAVE OF T-Rendgastos_hd.has_fecha IN FRAME DEFAULT-FRAME /* Hasta Fecha */
DO:
    RUN validar_rango_fechas.p ( INPUT T-Rendgastos_hd.des_fecha:SCREEN-VALUE IN FRAME {&FRAME-NAME}, 
                                 INPUT T-Rendgastos_hd.has_fecha:SCREEN-VALUE IN FRAME {&FRAME-NAME},
                                 INPUT "REND051,REND052,REND053",
                                 OUTPUT rc ).
    IF rc <> 0 THEN RETURN NO-APPLY.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Rendgastos_hd.has_fecha C-Win
ON MOUSE-MENU-DOWN OF T-Rendgastos_hd.has_fecha IN FRAME DEFAULT-FRAME /* Hasta Fecha */
DO:
  {tghelpfecha.i "T-Rendgastos_hd.has_fecha"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Rendgastos_hd.imp_anticipo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Rendgastos_hd.imp_anticipo C-Win
ON LEAVE OF T-Rendgastos_hd.imp_anticipo IN FRAME DEFAULT-FRAME /* Anticipo */
DO:
  ASSIGN T-Rendgastos_hd.imp_anticipo.
  T-Rendgastos_hd.imp_rendicion = T-Rendgastos_hd.imp_anticipo.
  DISPLAY T-Rendgastos_hd.imp_rendicion
      WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Rendgastos_hd.nro_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Rendgastos_hd.nro_comprob C-Win
ON MOUSE-SELECT-DBLCLICK OF T-Rendgastos_hd.nro_comprob IN FRAME DEFAULT-FRAME /* nro_comprob */
OR MOUSE-MENU-DOWN,"." OF T-Rendgastos_hd.nro_comprob IN FRAME {&FRAME-NAME}
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
          lista_estados = "N,M,C".
     END.
     WHEN MD_EMISION        
     THEN DO:
          titulo_window = "Selección de " + Tipocomprobante.titulo_window.
          lista_estados = "".
     END.
  END CASE.     

/*RUN d-selrendgastos.w (INPUT titulo_window, INPUT lista_estados, INPUT Tipocomprobante.tip_comprob, OUTPUT rid_rendgastos).*/
  RUN d-selrendgastos.w (INPUT titulo_window, INPUT lista_estados, INPUT "*", OUTPUT rid_rendgastos).
  IF rid_rendgastos <> ?
  THEN DO:
     FIND Rendgastos_hd WHERE ROWID(Rendgastos_hd) = rid_rendgastos NO-LOCK.
     DISPLAY Rendgastos_hd.tip_comprob @ T-Rendgastos_hd.tip_comprob 
             Rendgastos_hd.prf_comprob @ T-Rendgastos_hd.prf_comprob
             Rendgastos_hd.nro_comprob @ T-Rendgastos_hd.nro_comprob
             WITH FRAME {&FRAME-NAME}.
     IF modo = MD_ANULACION AND Rendgastos_hd.anulado
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Rendgastos_hd.nro_comprob C-Win
ON RETURN OF T-Rendgastos_hd.nro_comprob IN FRAME DEFAULT-FRAME /* nro_comprob */
DO:

   IF LOOKUP(INPUT FRAME {&FRAME-NAME} T-Rendgastos_hd.tip_comprob,"RG,CG") = 0 
   THEN DO:
      RUN PONMENSJ.P (INPUT "DOCS010").
      RETURN NO-APPLY.
   END.

   FIND Rendgastos_hd 
        WHERE Rendgastos_hd.cdg_empresa = Empresa.cdg_empresa
          AND Rendgastos_hd.tip_comprob = INPUT T-Rendgastos_hd.tip_comprob 
          AND Rendgastos_hd.prf_comprob = INPUT T-Rendgastos_hd.prf_comprob
          AND Rendgastos_hd.nro_comprob = INPUT T-Rendgastos_hd.nro_comprob
              NO-ERROR.

   IF NOT AVAILABLE Rendgastos_hd 
   THEN DO:
        IF LOCKED Rendgastos_hd
           THEN RUN PONMENSJ.P (INPUT "DOCS000").
           ELSE RUN PONMENSJ.P (INPUT "DOCS001").
        RETURN NO-APPLY.
   END.
   ELSE DO:
        rid_rendgastos = ROWID(Rendgastos_hd).
        RUN traer_documento.
   END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Rendgastos_hd.prf_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Rendgastos_hd.prf_comprob C-Win
ON MOUSE-SELECT-DBLCLICK OF T-Rendgastos_hd.prf_comprob IN FRAME DEFAULT-FRAME /* prf_comprob */
OR MOUSE-MENU-DOWN,"." OF T-Rendgastos_hd.prf_comprob IN FRAME {&FRAME-NAME}
DO:
  APPLY "MOUSE-SELECT-DBLCLICK" TO T-Rendgastos_hd.nro_comprob IN FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Rendgastos_hd.tip_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Rendgastos_hd.tip_comprob C-Win
ON MOUSE-SELECT-DBLCLICK OF T-Rendgastos_hd.tip_comprob IN FRAME DEFAULT-FRAME /* Rendición */
OR MOUSE-MENU-DOWN,"." OF T-Rendgastos_hd.prf_comprob IN FRAME {&FRAME-NAME}
DO:
  APPLY "MOUSE-SELECT-DBLCLICK" TO T-Rendgastos_hd.nro_comprob IN FRAME {&FRAME-NAME}.
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

  RUN selartic.p ( OUTPUT rid_articulo, 
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
   /*
   FIND Familia_articulo OF Articulo NO-LOCK.
   FIND FIRST Familia_cuenta 
       WHERE Familia_cuenta.cdg_imputacion = T-Rendgastos_hd.cdg_imputacion
         AND Familia_cuenta.nro_familia    = Familia_articulo.nro_familia
         AND Familia_cuenta.cdg_empresa    = T-Rendgastos_hd.cdg_empresa
             NO-LOCK NO-ERROR.
   
   IF NOT AVAILABLE Familia_cuenta
   THEN DO:
      RUN PONMENSJ.P (INPUT "FAPR061").
      RETURN NO-APPLY.
   END.
   */
   RUN crear_detalle.
   
   DISPLAY " " @ v-cdg_articulo
           WITH FRAME {&FRAME-NAME}.
   APPLY "ENTRY" TO v-cdg_articulo  IN FRAME {&FRAME-NAME}.
   RETURN NO-APPLY.

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
ON MOUSE-SELECT-DBLCLICK OF v-cdg_proveedor IN FRAME DEFAULT-FRAME /* Empleado */
OR "." OF v-cdg_Proveedor IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_Proveedor IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Proveedor" "cdg_proveedor" "SELPROVEINT.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_proveedor C-Win
ON RETURN OF v-cdg_proveedor IN FRAME DEFAULT-FRAME /* Empleado */
DO:
   &SCOPED-DEFINE PONER-TABLA RUN poner_proveedor.
   {traducetabla.i "Proveedor" "cdg_proveedor" "nombre"} 
   &UNDEFINE PONER-TABLA
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-fecha_gasto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-fecha_gasto C-Win
ON LEAVE OF v-fecha_gasto IN FRAME DEFAULT-FRAME /* Fecha Gasto */
DO:
  IF INPUT FRAME {&FRAME-NAME} v-fecha_gasto >= INPUT FRAME {&FRAME-NAME} T-Rendgastos_hd.des_fecha 
     AND INPUT FRAME {&FRAME-NAME} v-fecha_gasto <= INPUT FRAME {&FRAME-NAME} T-Rendgastos_hd.has_fecha 
  THEN DO:
      ASSIGN FRAME {&FRAME-NAME} v-fecha_gasto.
      {&OPEN-QUERY-{&BROWSE-NAME}}  
  END.
  ELSE DO:
      RUN ponmensj.p ( INPUT "REND054" ).
      RETURN NO-APPLY.
  END.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-fecha_gasto C-Win
ON MOUSE-MENU-DOWN OF v-fecha_gasto IN FRAME DEFAULT-FRAME /* Fecha Gasto */
DO:
  {tghelpfecha.i "v-fecha_gasto"}
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
            RUN ponmensj.p ( INPUT "PVTA001").
            DISPLAY v-pto_venta-org @ v-pto_venta
                    WITH FRAME {&FRAME-NAME}.
       END.
       ELSE DO:
            IF NOT CAN-FIND(FIRST Tipo_puntovta WHERE Tipo_puntovta.cdg_empresa  = Empresa.cdg_empresa 
                                                  AND Tipo_puntovta.cdg_puntovta = INPUT FRAME {&FRAME-NAME} v-pto_venta
                                                  AND Tipo_puntovta.cdg_comprobante = T-Rendgastos_hd.cdg_comprobante)
            THEN DO:
                 RUN ponmensj.p ( INPUT "PVTA004").
                 DISPLAY v-pto_venta-org @ v-pto_venta
                         WITH FRAME {&FRAME-NAME}.
            END.
            ELSE DO:
                 ASSIGN FRAME {&FRAME-NAME} v-pto_venta.
                 FIND Punto-venta WHERE Punto-venta.cdg_puntovta = v-pto_venta NO-LOCK.
                 T-Rendgastos_hd.fch_rendicion = TODAY.
                 DISPLAY T-Rendgastos_hd.fch_rendicion
                     WITH FRAME {&FRAME-NAME}.
            END.
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
RUN carga_comprobante.
RUN carga_tiposrendicion.

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE asignar_cambio C-Win 
PROCEDURE asignar_cambio :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE p-xx AS DATE . /* Por Compatibilidad */

  RUN cotizar_moneda.p ( INPUT  Moneda.cdg_moneda,
                         INPUT  T-Rendgastos_hd.cdg_empresa, 
                         INPUT  T-Rendgastos_hd.fch_rendicion,       
                         OUTPUT T-Rendgastos_hd.cambio,  
                         OUTPUT p-xx ).

  DISPLAY T-Rendgastos_hd.cambio WITH FRAME {&FRAME-NAME}.

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
/*
   ASSIGN FRAME {&FRAME-NAME} v-cdg_lista_precios.
   FIND Lista_precios WHERE Lista_precios.cdg_lista = v-cdg_lista_precios NO-LOCK.
   IF NOT CAN-DO(Lista_precios.lista_empresas,T-Rendgastos_hd.cdg_empresa)
   THEN DO:
         RUN PONMENSJ.P ( INPUT "ARTI017" ).
         no_aplicar = YES.
         RETURN ERROR.
   END.

   T-Rendgastos_hd.fch_rendicion_precios = T-Rendgastos_hd.fch_rendicion.
   T-Rendgastos_hd.cdg_lista =  v-cdg_lista_precios.
   FOR EACH T-Rendgastos_dt OF T-Rendgastos_hd EXCLUSIVE-LOCK, FIRST Articulo OF T-Rendgastos_dt WHERE Articulo.stock_sino:

        CASE Articulo.modo_volumen:
             WHEN ""  /* No hay descuentos por volumen */
             THEN DO: 
                  FIND LAST Articulo_precio OF Articulo 
                       WHERE Articulo_precio.cdg_lista = Lista_precio.cdg_lista 
                         AND Articulo_precio.cdg_empresa = T-Rendgastos_hd.cdg_empresa
                         AND Articulo_precio.fch_desde <= T-Rendgastos_hd.fch_rendicion_precios
                             NO-LOCK NO-ERROR. 
                  IF AVAILABLE Articulo_precio 
                  THEN DO:
                       T-Rendgastos_dt.precio    = Articulo_precio.precio.
                       T-Rendgastos_dt.precio_cf = Articulo_precio.precio_cf.
                  END.
                  ELSE DO:
                       T-Rendgastos_dt.precio    = ?.
                       T-Rendgastos_dt.precio_cf = ?.
                  END.
             END.                                  
    
             WHEN "D"  /* Descuentos directos en base a cantidad */
             THEN DO: 
                  FIND FIRST Articulo_precio OF Articulo 
                       WHERE Articulo_precio.cdg_lista = Lista_precio.cdg_lista 
                         AND Articulo_precio.cdg_empresa = T-Rendgastos_hd.cdg_empresa
                         AND Articulo_precio.desde_cantidad <= T-Rendgastos_dt.cantidad
                         AND Articulo_precio.hasta_cantidad >= T-Rendgastos_dt.cantidad
                         AND Articulo_precio.fch_desde <= T-Rendgastos_hd.fch_rendicion_precios
                             NO-LOCK NO-ERROR. 
                  IF AVAILABLE Articulo_precio 
                  THEN DO:
                       T-Rendgastos_dt.precio    = Articulo_precio.precio.
                       T-Rendgastos_dt.precio_cf = Articulo_precio.precio_cf.
                  END.
                  ELSE DO:
                       T-Rendgastos_dt.precio    = ?.
                       T-Rendgastos_dt.precio_cf = ?.
                  END.
             END.                                  
    
             WHEN "E"  /* Descuentos escalados en base a cantidad */
             THEN DO: 
                    /*
                  subtotal_item = 0.
                  remanente_cantidad = T-Rendgastos_dt.cantidad.
    
                  FOR EACH Articulo_precio OF Articulo 
                       WHERE Articulo_precio.cdg_lista = Lista_precio.cdg_lista 
                         AND Articulo_precio.cdg_empresa = T-Rendgastos_hd.cdg_empresa
                         BY Articulo-precio.desde_cantidad
                             NO-LOCK NO-ERROR: 
    
                      T-Rendgastos_dt.cantidad
    
    
                  IF AVAILABLE Articulo_precio 
                  THEN DO:
                       T-Rendgastos_dt.precio    = Articulo_precio.precio.
                       T-Rendgastos_dt.precio_cf = Articulo_precio.precio_cf.
                  END.
                  ELSE DO:
                       T-Rendgastos_dt.precio    = ?.
                       T-Rendgastos_dt.precio_cf = ?.
                  END.
                  */
                            T-Rendgastos_dt.precio = ?. /* Sacar */
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
*/
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

  T-Rendgastos_hd.nro_moneda = Moneda.nro_moneda.
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

   EMPTY TEMP-TABLE T-Rendgastos_hd.
   EMPTY TEMP-TABLE T-Rendgastos_dt.
       
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE calculos C-Win 
PROCEDURE calculos :
/*------------------------------------------------------------------------------
  Purpose: Realiza el calculo del importe final de una rendgastos     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  /*
  RUN calcular_rendicion_gastos.p ( 
                           INPUT-OUTPUT TABLE T-Rendgastos_hd,
                           INPUT-OUTPUT TABLE T-Rendgastos_dt).
                           
                         
  FIND FIRST T-Rendgastos_hd.
  
  T-Rendgastos_hd.imp_rendicion = 0.
  FOR EACH T-Rendgastos_dt OF T-Rendgastos_hd:
      T-Rendgastos_hd.imp_rendicion = T-Rendgastos_hd.imp_rendicion + T-Rendgastos_dt.importe.
  END.

  DISPLAY T-Rendgastos_hd.imp_anticipo 
          T-Rendgastos_hd.imp_rendicion 
          WITH FRAME {&FRAME-NAME}.
  {&OPEN-QUERY-{&BROWSE-NAME}}
  */

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

  /*FIND Tipocomprobante WHERE Tipocomprobante.cdg_comprobante = SUBSTRING(ENTRY(1,PROGRAM-NAME(3),"."),5) NO-LOCK NO-ERROR.*/
    FIND Tipocomprobante WHERE Tipocomprobante.cdg_comprobante = "RENDGAST".
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
    
       FIND Tipocomprobante WHERE Tipocomprobante.cdg_comprobante = "FACTUCLI" NO-LOCK NO-ERROR.
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
              v-nombre_comprobante  = "  rendgastos "
              v-fgcolor_comprobante = 9
              v-bgcolor_comprobante = 15
              v-primera_letra       = "F*"
              v-prefijo_contador    = "PRF*".
           
    
       END.
    END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE carga_tiposrendicion C-Win 
PROCEDURE carga_tiposrendicion :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   DEFINE VARIABLE lOK      AS LOGICAL.
   DEFINE VARIABLE x-listas AS CHARACTER.

/* T-Rendgastos_hd.cdg_imputacion:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = "". */
   
   {findempresa.i}
   x-listas = "".
/* x-primero = ?.*/
   FOR EACH Tipo_rendgastos
       WHERE CAN-DO(Tipo_rendgastos.lista_empresas,Empresa.cdg_empresa):
       x-listas = x-listas + "," + Tipo_rendgastos.dsc_rendgastos + "," + Tipo_rendgastos.cdg_tiporendgastos.
   END.
   IF x-listas <> ""
   THEN DO:
       x-listas = SUBSTRING(x-listas,2).
       T-Rendgastos_hd.cdg_tiporendgastos:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = x-listas.
   END.
   ELSE DO:
       MESSAGE "No se han definido Tipos de Rendición para la empresa actual" VIEW-AS ALERT-BOX ERROR TITLE "ERROR DE IMPLEMENTACIÓN".
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

     RUN detalle_rendgastos.p ( INPUT-OUTPUT TABLE T-Rendgastos_hd,
                             INPUT-OUTPUT TABLE T-Rendgastos_dt,
                             INPUT T-Rendgastos_dt.nro_articulo,
                             INPUT T-Rendgastos_dt.nro_linea,
                             INPUT modo,
                             INPUT 1,
                             OUTPUT v-nro_linea).

    FIND FIRST T-Rendgastos_hd.
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

    RUN d-detalle_rendgastos.p ( INPUT-OUTPUT TABLE T-Rendgastos_hd,
                                 INPUT-OUTPUT TABLE T-Rendgastos_dt,
                                 INPUT  Articulo.nro_articulo,
                                 INPUT  0, /* No sabemos el nro de linea */
                                 INPUT  modo,
                                 INPUT  0, /* modo detalle = CREAR */
                                 OUTPUT v-nro_linea).

    IF v-nro_linea <> 0
    THEN DO:
        RUN calculos.
        {&OPEN-QUERY-{&BROWSE-NAME}}
        btn_copiar:SENSITIVE IN FRAME {&FRAME-NAME}        = NO.
     /* btn_verimputacion:SENSITIVE IN FRAME {&FRAME-NAME} = YES.*/
    END.
    ELSE DO:
        FIND FIRST T-Rendgastos_hd.
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

      CREATE T-Rendgastos_hd.
      ASSIGN T-Rendgastos_hd.cdg_comprobante = Tipocomprobante.cdg_comprobante 
             T-Rendgastos_hd.nro_usuario     = User-id.nro_usuario 
             T-Rendgastos_hd.cdg_empresa     = Empresa.cdg_empresa
             T-Rendgastos_hd.fch_rendicion   = TODAY
             T-Rendgastos_hd.des_fecha       = T-Rendgastos_hd.fch_rendicion
             T-Rendgastos_hd.has_fecha       = T-Rendgastos_hd.fch_rendicion
             T-Rendgastos_hd.cdg_empresa     = Empresa.cdg_empresa 
             T-Rendgastos_hd.nro_rendgastos  = 0  
             T-Rendgastos_hd.abierta         = YES  
             T-Rendgastos_hd.nro_comprob     = T-Rendgastos_hd.nro_rendgastos
             T-Rendgastos_hd.prf_comprob     = 0 /*v-pto_venta */
             T-Rendgastos_hd.nro_moneda      = Moneda.nro_moneda 
             T-Rendgastos_hd.cambio          = Moneda.cambio  
             T-Rendgastos_hd.num_sucursal    = sucursal-id    
             T-Rendgastos_hd.cdg_tiporendgastos = ENTRY(2,T-Rendgastos_hd.cdg_tiporendgastos:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME})    
             T-Rendgastos_hd.cdg_estado      = "IN"    
             T-Rendgastos_hd.estado          = "N"
           /*T-Rendgastos_hd.origen          = "M"*/
             T-Rendgastos_hd.leyenda         = v-leyenda
             v-cdg_moneda                    = Moneda.cdg_moneda
             v-dsc_moneda                    = Moneda.descripcion.

             RUN asignar_cambio.

             FIND Tipo_rendgastos OF T-Rendgastos_hd NO-LOCK.
             T-Rendgastos_hd.tip_comprob = Tipo_rendgastos.sigla_prefijo.
             

  END.

  DISPLAY
         T-Rendgastos_hd.cdg_tiporendgastos
         T-Rendgastos_hd.cdg_estado
         T-Rendgastos_hd.fch_rendicion   
         T-Rendgastos_hd.des_fecha
         T-Rendgastos_hd.has_fecha
         T-Rendgastos_hd.cambio  
         T-Rendgastos_hd.abierta
         T-Rendgastos_hd.tip_comprob
         v-cdg_moneda
         v-dsc_moneda      
         v-comprobante
         v-pto_venta
         WITH FRAME {&FRAME-NAME}.
                                       
  codigo_salir = ?.

  IF    modo = MD_MULTIPLE
     OR modo = MD_ANULACION
     OR modo = MD_EMISION
  THEN DO:
       DO WITH FRAME {&FRAME-NAME}:
          T-Rendgastos_hd.tip_comprob:FGCOLOR = 9.
          T-Rendgastos_hd.tip_comprob:BGCOLOR = 15.

          T-Rendgastos_hd.prf_comprob:FGCOLOR = 9.
          T-Rendgastos_hd.prf_comprob:BGCOLOR = 15.

          T-Rendgastos_hd.nro_comprob:FGCOLOR = 9.
          T-Rendgastos_hd.nro_comprob:BGCOLOR = 15.
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
  DISPLAY v-pto_venta v-comprobante v-cdg_moneda v-dsc_moneda v-cdg_proveedor 
          v-dsc_proveedor v-cdg_articulo v-fecha_gasto 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE T-Rendgastos_hd THEN 
    DISPLAY T-Rendgastos_hd.tip_comprob T-Rendgastos_hd.prf_comprob 
          T-Rendgastos_hd.nro_comprob T-Rendgastos_hd.fch_rendicion 
          T-Rendgastos_hd.cdg_estado T-Rendgastos_hd.cdg_tiporendgastos 
          T-Rendgastos_hd.des_fecha T-Rendgastos_hd.has_fecha 
          T-Rendgastos_hd.cambio T-Rendgastos_hd.imp_anticipo 
          T-Rendgastos_hd.imp_rendicion T-Rendgastos_hd.imp_imputado 
          T-Rendgastos_hd.abierta 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE Btn_salir T-Rendgastos_hd.tip_comprob T-Rendgastos_hd.prf_comprob 
         T-Rendgastos_hd.nro_comprob T-Rendgastos_hd.fch_rendicion 
         T-Rendgastos_hd.cdg_tiporendgastos T-Rendgastos_hd.cambio 
         T-Rendgastos_hd.imp_rendicion T-Rendgastos_hd.imp_imputado 
         T-Rendgastos_hd.abierta BROWSE-2 RECT-2 RECT-3 RECT-5 RECT-6 RECT-7 
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
                T-Rendgastos_hd.tip_comprob:SENSITIVE     = NO
                T-Rendgastos_hd.prf_comprob:SENSITIVE     = NO
                T-Rendgastos_hd.nro_comprob:SENSITIVE     = NO
                T-Rendgastos_hd.fch_rendicion:SENSITIVE   = NO
                T-Rendgastos_hd.cambio:SENSITIVE          = NO
                T-Rendgastos_hd.des_fecha:SENSITIVE       = NO
                T-Rendgastos_hd.has_fecha:SENSITIVE       = NO
                T-Rendgastos_hd.imp_anticipo:SENSITIVE    = NO
                T-Rendgastos_hd.cdg_tiporendgastos:SENSITIVE = NO
                T-Rendgastos_hd.abierta:SENSITIVE            = NO
                v-cdg_articulo:SENSITIVE                  = NO
                v-fecha_gasto:SENSITIVE                   = NO
                v-cdg_moneda:SENSITIVE                    = NO
                v-cdg_Proveedor:SENSITIVE                 = NO.
     END.
     ELSE DO:

         RUN frame_sensitiva ( NO ).

         CASE modo:
             WHEN MD_ALTA          
             THEN DO:
                 ASSIGN
                    v-cdg_Proveedor:SENSITIVE               = YES
                    v-pto_venta:SENSITIVE                   = YES
                    T-Rendgastos_hd.imp_anticipo:SENSITIVE    = YES
                    T-Rendgastos_hd.cdg_tiporendgastos:SENSITIVE = YES
                    T-Rendgastos_hd.abierta:SENSITIVE            = YES
                    T-Rendgastos_hd.fch_rendicion:SENSITIVE = YES
                    T-Rendgastos_hd.des_fecha:SENSITIVE     = YES
                    T-Rendgastos_hd.has_fecha:SENSITIVE     = YES.
         
             END.
             WHEN MD_MULTIPLE      
             THEN DO:
                 ASSIGN
                    T-Rendgastos_hd.tip_comprob:SENSITIVE   = YES
                    T-Rendgastos_hd.prf_comprob:SENSITIVE   = YES
                    T-Rendgastos_hd.nro_comprob:SENSITIVE   = YES
                    v-pto_venta:SENSITIVE                   = NO.

             END.
             WHEN MD_DEFINIDA      
             THEN DO:
                 /*
                 ASSIGN
                    btn_verimputacion:SENSITIVE             = YES
                    btn_verbonificaciones:SENSITIVE           = YES
                    v-pto_venta:SENSITIVE                     = NO.
                 */   
         
             END.
             WHEN MD_RELACION      
             THEN DO:
                 /*
                 ASSIGN
                    btn_verimputacion:SENSITIVE               = YES
                    btn_verbonificaciones:SENSITIVE           = YES
                    v-pto_venta:SENSITIVE                     = NO.
                 */   
     
             END.
             WHEN MD_READONLY      
             THEN DO:
                 /*
                 ASSIGN
                    btn_verimputacion:SENSITIVE               = YES
                    btn_verbonificaciones:SENSITIVE           = YES
                    v-pto_venta:SENSITIVE                     = NO.
                 */   
     
             END.
             WHEN MD_CAMBIO        
             THEN DO:
                 ASSIGN
                    T-Rendgastos_hd.tip_comprob:SENSITIVE   = YES
                    T-Rendgastos_hd.prf_comprob:SENSITIVE   = YES
                    T-Rendgastos_hd.nro_comprob:SENSITIVE   = YES.

             END.
             WHEN MD_ANULACION        
             THEN DO:
                 ASSIGN
                    T-Rendgastos_hd.tip_comprob:SENSITIVE        = YES
                    T-Rendgastos_hd.prf_comprob:SENSITIVE        = YES
                    T-Rendgastos_hd.nro_comprob:SENSITIVE        = YES.
             END.
             WHEN MD_EMISION        
             THEN DO:
                 ASSIGN
                    T-Rendgastos_hd.tip_comprob:SENSITIVE        = YES
                    T-Rendgastos_hd.prf_comprob:SENSITIVE        = YES
                    T-Rendgastos_hd.nro_comprob:SENSITIVE        = YES.
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
       T-Rendgastos_hd.prf_comprob = v-pto_venta.

       FIND Tipo_rendgastos OF T-Rendgastos_hd NO-LOCK.
       T-Rendgastos_hd.tip_comprob = Tipo_rendgastos.sigla_prefijo.

       RUN grabar_rendicion_gastos.p ( INPUT TABLE T-Rendgastos_hd,
                                       INPUT TABLE T-Rendgastos_dt).
       
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
          btn_grabar:SENSITIVE                         = NO
          btn_copiar:SENSITIVE                         = NO
          btn_cancel:SENSITIVE                         = NO
          btn_anular:SENSITIVE                         = NO
          btn_observ:SENSITIVE                         = NO
          btn_imprim:SENSITIVE                         = NO
          T-Rendgastos_hd.tip_comprob:SENSITIVE        = NO
          T-Rendgastos_hd.prf_comprob:SENSITIVE        = NO
          T-Rendgastos_hd.nro_comprob:SENSITIVE        = NO
          T-Rendgastos_hd.fch_rendicion:SENSITIVE      = NO
          T-Rendgastos_hd.cambio:SENSITIVE             = NO
          T-Rendgastos_hd.des_fecha:SENSITIVE          = NO
          T-Rendgastos_hd.has_fecha:SENSITIVE          = NO
          T-Rendgastos_hd.imp_anticipo:SENSITIVE       = NO
          T-Rendgastos_hd.cdg_tiporendgastos:SENSITIVE = NO
          T-Rendgastos_hd.abierta:SENSITIVE            = NO
          v-fecha_gasto:SENSITIVE                      = NO
          v-cdg_articulo:SENSITIVE                     = NO
          v-cdg_moneda:SENSITIVE                       = NO
          v-cdg_Proveedor:SENSITIVE                    = NO.

     CASE modo:

       WHEN MD_ALTA          
       THEN DO:
            ASSIGN
                btn_cancel:SENSITIVE                      = YES
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES
                T-Rendgastos_hd.tip_comprob:SENSITIVE     = NO
                T-Rendgastos_hd.prf_comprob:SENSITIVE     = NO
                T-Rendgastos_hd.nro_comprob:SENSITIVE     = NO.
       END.
       WHEN MD_MULTIPLE      
       THEN DO:
            ASSIGN
                btn_cancel:SENSITIVE                      = YES
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES
                T-Rendgastos_hd.tip_comprob:SENSITIVE     = NO
                T-Rendgastos_hd.prf_comprob:SENSITIVE     = NO
                T-Rendgastos_hd.nro_comprob:SENSITIVE     = NO
                v-fecha_gasto:SENSITIVE                   = YES.
       END.
       WHEN MD_DEFINIDA      
       THEN DO:
            ASSIGN
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES
                v-fecha_gasto:SENSITIVE                   = YES.
       END.
       WHEN MD_RELACION      
       THEN DO:
            ASSIGN
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES
                v-fecha_gasto:SENSITIVE                   = YES.
       END.
       WHEN MD_READONLY      
       THEN DO:
            ASSIGN
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES
                v-fecha_gasto:SENSITIVE                   = YES.
       END.
       WHEN MD_CAMBIO        
       THEN DO:
            ASSIGN
                btn_grabar:SENSITIVE                      = YES
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES
                T-Rendgastos_hd.abierta:SENSITIVE         = YES
                v-fecha_gasto:SENSITIVE                   = YES.
       END.
       WHEN MD_ANULACION        
       THEN DO:
            ASSIGN
                btn_anular:SENSITIVE                      = YES
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES
                v-fecha_gasto:SENSITIVE                   = YES.
       END.
       WHEN MD_EMISION        
       THEN DO:
            ASSIGN
                btn_grabar:SENSITIVE                      = YES
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES
                v-fecha_gasto:SENSITIVE                   = YES.

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
   FIND Deposito WHERE Deposito.cdg_deposito = v-valor_n 
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
   T-Rendgastos_hd.cdg_imputacion = Imputacion.cdg_imputacion.
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
           TITLE "c-rendgastos_cliente:iniciar_documento".

   MESSAGE SUBSTRING(ENTRY(1,PROGRAM-NAME(3),"."),5) VIEW-AS ALERT-BOX.

*/

   RUN titulo_window ( INPUT Tipocomprobante.titulo_window ).           

   
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
  
  DEFINE VARIABLE voy_fecha AS DATE.

  ASSIGN FRAME {&FRAME-NAME} T-Rendgastos_hd.cdg_tiporendgastos.

  FIND Tipo_rendgastos OF T-Rendgastos_hd NO-LOCK.
  IF Tipo_rendgastos.todos_articulos 
  THEN DO:
      v-cdg_articulo:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
  END.
  ELSE DO:
      T-Rendgastos_hd.ultima_linea = 0.
      v-cdg_articulo:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
      DO voy_fecha = INPUT FRAME {&FRAME-NAME} T-Rendgastos_hd.des_fecha TO 
                     INPUT FRAME {&FRAME-NAME} T-Rendgastos_hd.has_fecha:

         FOR EACH Articulo_tiporendicion OF Tipo_rendgastos
             WHERE Articulo_tiporendicion.cdg_empresa = T-Rendgastos_hd.cdg_empresa:
/*
                  MESSAGE "Fecha" voy_fecha SKIP
                           "Articulo" Articulo_tiporendicion.nro_articulo SKIP
                           "Linea" T-Rendgastos_hd.ultima_linea SKIP
                      VIEW-AS ALERT-BOX MESSAGE TITLE "poner_articulos".
*/
             CREATE T-Rendgastos_dt.
             ASSIGN T-Rendgastos_dt.fch_gasto      = voy_fecha
                    T-Rendgastos_dt.nro_articulo   = Articulo_tiporendicion.nro_articulo
                    T-Rendgastos_dt.nro_linea      = T-Rendgastos_hd.ultima_linea
                    T-Rendgastos_dt.nro_rendgastos = T-Rendgastos_hd.nro_rendgastos
                    T-Rendgastos_dt.observacion    = ""
                    T-Rendgastos_hd.ultima_linea   = T-Rendgastos_hd.ultima_linea + 1.
         END.

      END.
  END.

  v-fecha_gasto:SENSITIVE IN FRAME {&FRAME-NAME} = YES.  
  v-fecha_gasto = INPUT FRAME {&FRAME-NAME} T-Rendgastos_hd.des_fecha.
  DISPLAY v-fecha_gasto 
      WITH FRAME {&FRAME-NAME}.
  {&OPEN-QUERY-{&BROWSE-NAME}}
  

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

  IF NOT CAN-DO(Proveedor.lista_empresas,Empresa.cdg_empresa)
  THEN DO:
        RUN PONMENSJ.P ( INPUT "CLIE050" ).
        no_aplicar = YES.
        RETURN ERROR.
  END.
  ELSE DO:
       IF /*LOOKUP(Proveedor.cdg_estado,",A") = 0*/ FALSE
       THEN DO:
             RUN PONMENSJ.P ( INPUT "CLIE051" ).
             no_aplicar = YES.
             RETURN ERROR.
       END.
       ELSE DO:
            ASSIGN
                T-Rendgastos_hd.nro_proveedor = Proveedor.nro_Proveedor.
          
            RUN traer_Proveedor.

            DISPLAY  v-cdg_Proveedor 
                     v-dsc_Proveedor
                     WITH FRAME {&FRAME-NAME}.
                     
             DO WITH FRAME {&FRAME-NAME}:
                ASSIGN
                   btn_grabar:SENSITIVE                      = YES
                   btn_copiar:SENSITIVE                      = YES
                   btn_cancel:SENSITIVE                      = YES
                   btn_anular:SENSITIVE                      = NO
                   btn_observ:SENSITIVE                      = YES
                   btn_imprim:SENSITIVE                      = NO
                   T-Rendgastos_hd.cdg_tiporendgastos:SENSITIVE = NO
                   T-Rendgastos_hd.fch_rendicion:SENSITIVE      = NO
                   T-Rendgastos_hd.des_fecha:SENSITIVE       = NO
                   T-Rendgastos_hd.has_fecha:SENSITIVE       = NO
                   T-Rendgastos_hd.cambio:SENSITIVE          = mod_cambio
                   v-fecha_gasto:SENSITIVE                   = NO
                   v-cdg_moneda:SENSITIVE                    = NO
                   v-cdg_Proveedor:SENSITIVE                 = NO
                   btn_porclasificacion:SENSITIVE            = NO.

             END. 

             RUN poner_articulos.
          
             /*
             RUN calculos.   
             */
             
       END.
   END.

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

 {&WINDOW-NAME}:TITLE = "DYNASYS/RGV " + NRO_RELEASE + " - " + User-id.cdg_empresa + " - " + v-txtitulo + " User:" + USERID("sic").

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

   FIND Rendgastos_hd WHERE ROWID(Rendgastos_hd) = rid_rendgastos NO-LOCK.
   BUFFER-COPY Rendgastos_hd TO T-Rendgastos_hd
       ASSIGN T-Rendgastos_hd.estado = "M".

   FOR EACH Rendgastos_dt OF Rendgastos_hd:
       CREATE T-Rendgastos_dt.
       BUFFER-COPY Rendgastos_dt TO T-Rendgastos_dt.
   END.    
   
   /*v-anulado = IF Rendgastos_hd.anulado THEN "ANULADA" ELSE "".*/
   v-fecha_gasto = T-Rendgastos_hd.des_fecha.

   RUN traer_tablas.

   DISPLAY
        T-Rendgastos_hd.cambio 
        T-Rendgastos_hd.cdg_tiporendgastos
        T-Rendgastos_hd.cdg_estado
        T-Rendgastos_hd.fch_rendicion 
        T-Rendgastos_hd.imp_rendicion 
        T-Rendgastos_hd.imp_imputado
        T-Rendgastos_hd.nro_comprob 
        T-Rendgastos_hd.prf_comprob 
        T-Rendgastos_hd.tip_comprob 
        T-Rendgastos_hd.abierta
        T-Rendgastos_hd.imp_anticipo
        v-cdg_moneda 
        v-cdg_proveedor 
        v-fecha_gasto
        v-dsc_moneda 
        v-dsc_proveedor
        WITH FRAME {&FRAME-NAME}.

   {&OPEN-QUERY-{&BROWSE-NAME}}
       
   RUN habilitar_campos ( INPUT YES ).
   
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

    FIND Moneda    OF T-Rendgastos_hd   NO-LOCK.
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

    FIND Proveedor OF T-Rendgastos_hd NO-LOCK.
    ASSIGN
        v-cdg_Proveedor = Proveedor.cdg_proveedor
        v-dsc_Proveedor = Proveedor.nombre.
    
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

  RUN traer_moneda.
  RUN traer_Proveedor.

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
/*  
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
    {IFNOTEXS.I "Provincia" "cdg_provincia" "frm-documento" "T-Rendgastos_hd" "cdg_provincia " "FACT009"}
    */

    IF T-Rendgastos_hd.nombre = ""
    THEN DO:
       RUN PONMENSJ.P (INPUT "FACT027").
       RETURN.
    END.  
  
    IF T-Rendgastos_hd.cuit = ""
    THEN DO:
       RUN PONMENSJ.P (INPUT "FACT028").
       RETURN.
    END.  
  
    IF T-Rendgastos_hd.cambio = 0
    THEN DO:
       RUN PONMENSJ.P (INPUT "FACT029").
       RETURN.
    END.  
  
    IF NOT CAN-FIND(FIRST T-Rendgastos_dt OF T-Rendgastos_hd)
    THEN DO:
       RUN PONMENSJ.P (INPUT "FACT005").
       RETURN.
    END.
  
    /* Comentar lo siguiente si se necesita emitir un comprobante con precio en 0 */

    IF T-Rendgastos_hd.imp_total = 0
    THEN DO:
       RUN PONMENSJ.P (INPUT "FACT007").
       RETURN.
    END.

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
       IF T-Rendgastos_hd.nro_domicilio <> Domicilio.nro_domicilio
       THEN DO:
           ASSIGN
               T-Rendgastos_hd.nro_domicilio = Domicilio.nro_domicilio
               T-Rendgastos_hd.direccion     = Domicilio.direccion
               T-Rendgastos_hd.cdg_provincia = Domicilio.cdg_provincia
               T-Rendgastos_hd.localidad     = Domicilio.localidad
               T-Rendgastos_hd.cdg_postal    = Domicilio.cdg_postal
               T-Rendgastos_hd.cdg_zonag     = Domicilio.cdg_zonag.
       END.
    END.
  
    FIND Punto-venta WHERE Punto-venta.cdg_empresa  = T-Rendgastos_hd.cdg_empresa
                       AND Punto-venta.cdg_puntovta = v-pto_venta
                           NO-LOCK NO-ERROR.
    IF NOT AVAILABLE Punto-venta
    THEN DO:
      RUN ponmensj.p ( INPUT "REMI063" ).
      RETURN ERROR.
    END.
    ELSE DO:                 IF T-Rendgastos_hd.fch_rendicion > TODAY
        THEN DO:
            RUN ponmensj.p ( INPUT "REMI065" ).
            RETURN ERROR.
        END.
        ELSE DO:
            IF T-Rendgastos_hd.fch_rendicion <= Punto-venta.fch_cierre
            THEN DO:
                RUN ponmensj.p ( INPUT "REMI062" ).
                RETURN ERROR.
            END.
            ELSE DO:
                T-Rendgastos_hd.tip_comprob = Tipocomprobante.tip_comprob.
                IF Tipocomprobante.usa_letra
                THEN DO:
                     T-Rendgastos_hd.tip_comprob = REPLACE(T-Rendgastos_hd.tip_comprob,"*",Condicion_impos.tipo_rendgastos).
                END.
     
                IF CAN-FIND(FIRST Rendgastos_hd
                                  WHERE Rendgastos_hd.cdg_empresa = T-Rendgastos_hd.cdg_empresa
                                    AND Rendgastos_hd.tip_comprob = T-Rendgastos_hd.tip_comprob
                                    AND Rendgastos_hd.prf_comprob = v-pto_venta
                                    AND Rendgastos_hd.fch_rendicion > T-Rendgastos_hd.fch_rendicion)
                THEN DO:
                    RUN ponmensj.p ( INPUT "REMI061" ).
                    RETURN ERROR.
                END.
            END.
        END.
    END.
    
    /* Error 26 reservado para fecha invalida */

    hubo_error = NO.

    &SCOPED-DEFINE TABLA-MAESTRA  T-Rendgastos_hd

    {asignartabla.i "Cliente"           "nro_cliente"     "nro_cliente"      }
    {asignartabla.i "Vendedor"          "nro_vendedor"    "nro_vendedor"     }
    {asignartabla.i "Deposito"          "cdg_deposito"    "cdg_deposito"     }
    {asignartabla.i "Lista_precios"     "cdg_lista"       "cdg_lista"        }
    {asignartabla.i "Condicion_impos"   "cdg_condiva"     "cdg_condiva"      }
    {asignartabla.i "Moneda"            "nro_moneda"      "nro_moneda"       }
    {asignartabla.i "Condicion_venta"   "nro_cndventa"    "nro_cndventa"     }
    /*
    {asignartabla.i "Imputacion"        "cdg_imputacion"  "cdg_imputacion"   }
    */

    &UNDEFINE TABLA-MAESTRA

*/

    hubo_error = NO.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

