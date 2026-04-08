&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win


/* Temp-Table and Buffer definitions                                    */
DEFINE BUFFER Receptora FOR Caja.
DEFINE TEMP-TABLE T-Asn_detalle NO-UNDO LIKE Asn_detalle.
DEFINE TEMP-TABLE T-Asn_header NO-UNDO LIKE Asn_header.
DEFINE TEMP-TABLE T-Asn_totales NO-UNDO LIKE Asn_totales.
DEFINE TEMP-TABLE T-Caja-imputacion NO-UNDO LIKE Caja-imputacion.
DEFINE TEMP-TABLE T-Caj_detalle NO-UNDO LIKE Caj_detalle.
DEFINE TEMP-TABLE T-Caj_header NO-UNDO LIKE Caj_header.
DEFINE TEMP-TABLE T-Cheque NO-UNDO LIKE Cheque.
DEFINE TEMP-TABLE T-Valor NO-UNDO LIKE Valor.



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
DEFINE VARIABLE                rid_movcaja        AS ROWID.
DEFINE VARIABLE                modo               AS INTEGER.
/*
DEFINE VARIABLE                p-cdg_comprobante  AS CHARACTER.
*/
&ELSE
DEFINE INPUT-OUTPUT PARAMETER  rid_movcaja        AS ROWID.
DEFINE INPUT        PARAMETER  modo               AS INTEGER.
/*
DEFINE INPUT        PARAMETER  p-cdg_comprobante  AS CHARACTER.
*/
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
DEFINE VARIABLE v-prox_docum              LIKE Parametro.cdg_parametro INITIAL "PROXNASN".
DEFINE VARIABLE v-debito                  AS CHARACTER FORMAT "X(14)".
DEFINE VARIABLE v-credito                 AS CHARACTER FORMAT "X(14)".

DEFINE VARIABLE rid_tabla                 AS ROWID.
DEFINE VARIABLE v-rid_detalle             AS ROWID.
DEFINE VARIABLE v-nro_linea               AS INTEGER.
DEFINE VARIABLE v-nro_cuenta              AS INTEGER.
DEFINE VARIABLE aux_importe               AS DECIMAL.
DEFINE VARIABLE mod_cambio                AS LOGICAL.

DEFINE VARIABLE v-nombre_comprobante      AS CHARACTER.
DEFINE VARIABLE v-fgcolor_comprobante     AS INTEGER.
DEFINE VARIABLE v-bgcolor_comprobante     AS INTEGER.
DEFINE VARIABLE v-pto_venta-org           AS INTEGER.
DEFINE VARIABLE v-primera_letra           AS CHARACTER.
DEFINE VARIABLE v-prefijo_contador        AS CHARACTER.

DEFINE VARIABLE que_empresa               LIKE Empresa.cdg_empresa.

DEFINE VARIABLE v-modo-cabecera           AS INTEGER.
DEFINE VARIABLE v-modo-detalle            AS INTEGER.

DEFINE VARIABLE v-nro_entidad             LIKE Entidad.nro_entidad.
DEFINE VARIABLE v-nro_obra                LIKE Obra.nro_obra.
DEFINE VARIABLE v-valor                   LIKE Caja-imputacion.valor.

DEFINE VARIABLE v-ok                      AS LOGICAL.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME BROWSE-4

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Caja-imputacion Cuenta Entidad Obra ~
T-Caj_header

/* Definitions for BROWSE BROWSE-4                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-4 Cuenta.cdg_cuenta Cuenta.nombre_cta ~
Entidad.cdg_entidad Entidad.dsc_entidad Obra.cdg_obra Obra.dsc_obra ~
T-Caja-imputacion.valor T-Caja-imputacion.observacion 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-4 
&Scoped-define QUERY-STRING-BROWSE-4 FOR EACH T-Caja-imputacion ~
      WHERE T-Caja-imputacion.nro_transaccion = T-Caj_header.nro_transaccion NO-LOCK, ~
      EACH Cuenta OF T-Caja-imputacion NO-LOCK, ~
      EACH Entidad OF T-Caja-imputacion NO-LOCK, ~
      EACH Obra OF T-Caja-imputacion OUTER-JOIN NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-4 OPEN QUERY BROWSE-4 FOR EACH T-Caja-imputacion ~
      WHERE T-Caja-imputacion.nro_transaccion = T-Caj_header.nro_transaccion NO-LOCK, ~
      EACH Cuenta OF T-Caja-imputacion NO-LOCK, ~
      EACH Entidad OF T-Caja-imputacion NO-LOCK, ~
      EACH Obra OF T-Caja-imputacion OUTER-JOIN NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-4 T-Caja-imputacion Cuenta Entidad ~
Obra
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-4 T-Caja-imputacion
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-4 Cuenta
&Scoped-define THIRD-TABLE-IN-QUERY-BROWSE-4 Entidad
&Scoped-define FOURTH-TABLE-IN-QUERY-BROWSE-4 Obra


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define FIELDS-IN-QUERY-DEFAULT-FRAME T-Caj_header.tip_comprob ~
T-Caj_header.prf_comprob T-Caj_header.nro_comprob T-Caj_header.fecha ~
T-Caj_header.importe T-Caj_header.cambio T-Caj_header.tipo_mov ~
T-Caj_header.observacion T-Caj_header.fch_cambio 
&Scoped-define ENABLED-FIELDS-IN-QUERY-DEFAULT-FRAME ~
T-Caj_header.tip_comprob T-Caj_header.prf_comprob T-Caj_header.nro_comprob ~
T-Caj_header.fecha T-Caj_header.importe T-Caj_header.cambio ~
T-Caj_header.tipo_mov T-Caj_header.observacion 
&Scoped-define ENABLED-TABLES-IN-QUERY-DEFAULT-FRAME T-Caj_header
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-DEFAULT-FRAME T-Caj_header
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-BROWSE-4}
&Scoped-define QUERY-STRING-DEFAULT-FRAME FOR EACH T-Caj_header SHARE-LOCK
&Scoped-define OPEN-QUERY-DEFAULT-FRAME OPEN QUERY DEFAULT-FRAME FOR EACH T-Caj_header SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-DEFAULT-FRAME T-Caj_header
&Scoped-define FIRST-TABLE-IN-QUERY-DEFAULT-FRAME T-Caj_header


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS T-Caj_header.tip_comprob ~
T-Caj_header.prf_comprob T-Caj_header.nro_comprob T-Caj_header.fecha ~
T-Caj_header.importe T-Caj_header.cambio T-Caj_header.tipo_mov ~
T-Caj_header.observacion 
&Scoped-define ENABLED-TABLES T-Caj_header
&Scoped-define FIRST-ENABLED-TABLE T-Caj_header
&Scoped-Define ENABLED-OBJECTS RECT-1 RECT-2 RECT-3 RECT-5 Btn_salir ~
imp_no_imp BROWSE-4 v-usuario 
&Scoped-Define DISPLAYED-FIELDS T-Caj_header.tip_comprob ~
T-Caj_header.prf_comprob T-Caj_header.nro_comprob T-Caj_header.fecha ~
T-Caj_header.importe T-Caj_header.cambio T-Caj_header.tipo_mov ~
T-Caj_header.observacion T-Caj_header.fch_cambio 
&Scoped-define DISPLAYED-TABLES T-Caj_header
&Scoped-define FIRST-DISPLAYED-TABLE T-Caj_header
&Scoped-Define DISPLAYED-OBJECTS v-pto_venta imp_no_imp v-anulado ~
v-cdg_caja v-dsc_caja v-cdg_moneda v-dsc_moneda v-cdg_receptora ~
v-dsc_receptora v-cdg_cuenta v-usuario 

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
     LABEL "Buscar X &Clasificación" 
     SIZE 23 BY 1.05.

DEFINE BUTTON Btn_salir DEFAULT 
     LABEL "&Salir" 
     SIZE 21 BY 1.33
     BGCOLOR 8 .

DEFINE BUTTON btn_valores 
     LABEL "&Ver Medios de Pago" 
     SIZE 21 BY 1.

DEFINE BUTTON btn_verimputacion 
     LABEL "&Imputación Contable" 
     SIZE 21 BY 1.

DEFINE VARIABLE imp_no_imp AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     LABEL "No Imputado" 
     VIEW-AS FILL-IN 
     SIZE 21 BY 1
     BGCOLOR 7 FGCOLOR 14  NO-UNDO.

DEFINE VARIABLE v-anulado AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 21 BY 1
     FGCOLOR 12 FONT 6 NO-UNDO.

DEFINE VARIABLE v-cdg_caja AS INTEGER FORMAT "->,>>>,>>9" INITIAL 0 
     LABEL "Caja" 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_cuenta AS CHARACTER FORMAT "X(10)":U 
     LABEL "Cuenta" 
     VIEW-AS FILL-IN 
     SIZE 33 BY 1
     BGCOLOR 14 FGCOLOR 12 FONT 6 NO-UNDO.

DEFINE VARIABLE v-cdg_moneda AS CHARACTER FORMAT "X(3)" 
     LABEL "Moneda" 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_receptora AS INTEGER FORMAT "->,>>>,>>9" INITIAL 0 
     LABEL "Caja Receptora" 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-dsc_caja AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 53 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_moneda AS CHARACTER FORMAT "X(20)" 
     VIEW-AS FILL-IN 
     SIZE 53 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_receptora AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 53 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-pto_venta AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1 TOOLTIP "Punto de venta ( en caso de discriminar)"
     BGCOLOR 15 FGCOLOR 9 FONT 6 NO-UNDO.

DEFINE VARIABLE v-usuario AS CHARACTER FORMAT "X(256)":U 
     LABEL "Usuario" 
      VIEW-AS TEXT 
     SIZE 20.8 BY .62 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 21 BY 4.52.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 133 BY 1.86.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 23 BY 1.86.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 156 BY 7.62.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-4 FOR 
      T-Caja-imputacion, 
      Cuenta, 
      Entidad, 
      Obra SCROLLING.

DEFINE QUERY DEFAULT-FRAME FOR 
      T-Caj_header SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-4 C-Win _STRUCTURED
  QUERY BROWSE-4 NO-LOCK DISPLAY
      Cuenta.cdg_cuenta FORMAT "X(8)":U WIDTH 13.2
      Cuenta.nombre_cta FORMAT "X(35)":U
      Entidad.cdg_entidad FORMAT "X(8)":U
      Entidad.dsc_entidad FORMAT "X(20)":U
      Obra.cdg_obra FORMAT "X(8)":U
      Obra.dsc_obra COLUMN-LABEL "Titulo!Obra" FORMAT "X(20)":U
      T-Caja-imputacion.valor COLUMN-LABEL "Importe!Imputación" FORMAT "->>>>>>9.99":U
      T-Caja-imputacion.observacion COLUMN-LABEL "Observación!Asociada" FORMAT "X(50)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 156 BY 15.95
         TITLE "Imputación contable del movimiento actual" FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btn_grabar AT ROW 1.48 COL 4
     btn_copiar AT ROW 1.48 COL 26
     btn_cancel AT ROW 1.48 COL 48
     btn_anular AT ROW 1.48 COL 70
     btn_observ AT ROW 1.48 COL 92
     btn_imprim AT ROW 1.48 COL 114
     Btn_salir AT ROW 1.52 COL 137
     T-Caj_header.tip_comprob AT ROW 3.38 COL 24 COLON-ALIGNED
          LABEL "Comprobante"
          VIEW-AS FILL-IN 
          SIZE 9 BY 1
          BGCOLOR 7 FGCOLOR 15 
     T-Caj_header.prf_comprob AT ROW 3.38 COL 34 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 8 BY 1
          BGCOLOR 7 FGCOLOR 15 
     T-Caj_header.nro_comprob AT ROW 3.38 COL 43 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 14 BY 1
          BGCOLOR 7 FGCOLOR 15 
     T-Caj_header.fecha AT ROW 3.38 COL 73 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 14 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-pto_venta AT ROW 3.38 COL 88 COLON-ALIGNED NO-LABEL
     imp_no_imp AT ROW 3.38 COL 112 COLON-ALIGNED
     v-anulado AT ROW 3.38 COL 135 COLON-ALIGNED NO-LABEL
     v-cdg_caja AT ROW 4.57 COL 24 COLON-ALIGNED
     v-dsc_caja AT ROW 4.57 COL 43 COLON-ALIGNED NO-LABEL
     T-Caj_header.importe AT ROW 4.57 COL 112 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 21 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_moneda AT ROW 5.76 COL 24 COLON-ALIGNED
     v-dsc_moneda AT ROW 5.76 COL 43 COLON-ALIGNED NO-LABEL
     T-Caj_header.cambio AT ROW 5.76 COL 112 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 21 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Caj_header.tipo_mov AT ROW 6 COL 139 NO-LABEL
          VIEW-AS RADIO-SET VERTICAL
          RADIO-BUTTONS 
                    "Egreso", "E":U,
"Ingreso", "I":U,
"Transferencia", "T":U
          SIZE 17 BY 2.62
     v-cdg_receptora AT ROW 6.95 COL 24 COLON-ALIGNED
     v-dsc_receptora AT ROW 6.95 COL 43 COLON-ALIGNED NO-LABEL
     T-Caj_header.observacion AT ROW 8.14 COL 24 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 72 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Caj_header.fch_cambio AT ROW 8.14 COL 112 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 21 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_cuenta AT ROW 9.33 COL 24 COLON-ALIGNED
     btn_porclasificacion AT ROW 9.33 COL 85
     btn_verimputacion AT ROW 9.33 COL 114
     btn_valores AT ROW 9.33 COL 137
     BROWSE-4 AT ROW 11 COL 3
     v-usuario AT ROW 7.05 COL 112.2 COLON-ALIGNED WIDGET-ID 4
     "       Modalidad" VIEW-AS TEXT
          SIZE 19 BY .95 AT ROW 4.81 COL 138
          BGCOLOR 5 FGCOLOR 15 
     RECT-1 AT ROW 4.57 COL 137
     RECT-2 AT ROW 1.24 COL 3
     RECT-3 AT ROW 1.24 COL 136
     RECT-5 AT ROW 3.14 COL 3
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 161.4 BY 27.57.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: Receptora B "?" ? sic Caja
      TABLE: T-Asn_detalle T "?" NO-UNDO sic Asn_detalle
      TABLE: T-Asn_header T "?" NO-UNDO sic Asn_header
      TABLE: T-Asn_totales T "?" NO-UNDO sic Asn_totales
      TABLE: T-Caja-imputacion T "?" NO-UNDO sic Caja-imputacion
      TABLE: T-Caj_detalle T "?" NO-UNDO sic Caj_detalle
      TABLE: T-Caj_header T "?" NO-UNDO sic Caj_header
      TABLE: T-Cheque T "?" NO-UNDO sic Cheque
      TABLE: T-Valor T "?" NO-UNDO sic Valor
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Movimiento de Tesorería"
         HEIGHT             = 25.86
         WIDTH              = 158.4
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
   FRAME-NAME                                                           */
/* BROWSE-TAB BROWSE-4 btn_valores DEFAULT-FRAME */
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
/* SETTINGS FOR BUTTON btn_valores IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_verimputacion IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Caj_header.fch_cambio IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Caj_header.tip_comprob IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN v-anulado IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_caja IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_cuenta IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_moneda IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_receptora IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_caja IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_moneda IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_receptora IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-pto_venta IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
ASSIGN 
       v-usuario:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-4
/* Query rebuild information for BROWSE BROWSE-4
     _TblList          = "Temp-Tables.T-Caja-imputacion,sic.Cuenta OF Temp-Tables.T-Caja-imputacion,sic.Entidad OF Temp-Tables.T-Caja-imputacion,sic.Obra OF Temp-Tables.T-Caja-imputacion"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _TblOptList       = ",,, OUTER"
     _Where[1]         = "Temp-Tables.T-Caja-imputacion.nro_transaccion = T-Caj_header.nro_transaccion"
     _FldNameList[1]   > sic.Cuenta.cdg_cuenta
"Cuenta.cdg_cuenta" ? ? "character" ? ? ? ? ? ? no ? no no "13.2" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   = sic.Cuenta.nombre_cta
     _FldNameList[3]   = sic.Entidad.cdg_entidad
     _FldNameList[4]   > sic.Entidad.dsc_entidad
"Entidad.dsc_entidad" ? "X(20)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   = sic.Obra.cdg_obra
     _FldNameList[6]   > sic.Obra.dsc_obra
"Obra.dsc_obra" "Titulo!Obra" "X(20)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > Temp-Tables.T-Caja-imputacion.valor
"T-Caja-imputacion.valor" "Importe!Imputación" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > Temp-Tables.T-Caja-imputacion.observacion
"T-Caja-imputacion.observacion" "Observación!Asociada" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is OPENED
*/  /* BROWSE BROWSE-4 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME DEFAULT-FRAME
/* Query rebuild information for FRAME DEFAULT-FRAME
     _TblList          = "Temp-Tables.T-Caj_header"
     _Query            is OPENED
*/  /* FRAME DEFAULT-FRAME */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Movimiento de Tesorería */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Movimiento de Tesorería */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-4
&Scoped-define SELF-NAME BROWSE-4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-4 C-Win
ON MOUSE-SELECT-DBLCLICK OF BROWSE-4 IN FRAME DEFAULT-FRAME /* Imputación contable del movimiento actual */
OR RETURN OF BROWSE-4 IN FRAME {&FRAME-NAME}
DO:
  IF AVAILABLE  T-Caja-imputacion
  THEN DO:
       RUN corregir_detalle.
       {&OPEN-QUERY-{&BROWSE-NAME}}
  END.
  ELSE DO:
       BELL.
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
    MESSAGE "Desea ANULAR este Movimiento de Caja?" 
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
    IF sino-msg
    THEN DO:
         RUN anular_movcaja.p (INPUT ROWID(Caj_header), OUTPUT pudo_anular).
         IF pudo_anular = 0
         THEN DO:
             RUN borrar_tablas_temporales.
             MESSAGE "El movimiento ha sido anulado" 
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

  RUN d-seleccionar_movcaja.w (INPUT-OUTPUT rid_movcaja).
  IF rid_movcaja <> ?
  THEN DO:
     FIND Caj_header WHERE ROWID(Caj_header) = rid_movcaja NO-LOCK.
     DISPLAY Caj_header.tip_comprob @ T-Caj_header.tip_comprob 
             Caj_header.prf_comprob @ T-Caj_header.prf_comprob
             Caj_header.nro_comprob @ T-Caj_header.nro_comprob
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
        T-Caj_header.fecha 
        T-Caj_header.fch_cambio 
        T-Caj_header.cambio
        T-Caj_header.importe 
        T-Caj_header.observacion 
        T-Caj_header.tipo_mov
        v-cdg_receptora.
         

  RUN validar_datos ( OUTPUT hay_error).
  IF NOT hay_error
  THEN DO:

       IF NOT T-Caj_header.anulado /* No es una anulación */
       THEN DO:
            RUN d-valores_movimiento.w ( INPUT-OUTPUT TABLE T-Caj_header,
                                         INPUT-OUTPUT TABLE T-Caj_detalle,
                                         INPUT-OUTPUT TABLE T-Caja-imputacion,
                                         INPUT-OUTPUT TABLE T-Cheque,
                                         INPUT-OUTPUT TABLE T-Valor,
                                         INPUT 0).
            FIND FIRST T-Caj_header EXCLUSIVE-LOCK.
            IF T-Caj_header.importe <> T-Caj_header.ingreso THEN RETURN NO-APPLY.
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
    MESSAGE "Desea REIMPRIMIR esta factura?" 
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
    IF sino-msg
    THEN DO:
         RUN imprimir_movcaja.p (ROWID(Caj_header)).
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_observ
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_observ C-Win
ON CHOOSE OF btn_observ IN FRAME DEFAULT-FRAME /* Leyenda */
DO:

   DEFINE VARIABLE puso_ok AS LOGICAL.
   RUN c-edttexto.w ( INPUT-OUTPUT T-Caj_header.observacion,
                      INPUT "Leyenda del Movimiento de Caja",
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
  RUN d-selclase_cuenta.w ( INPUT-OUTPUT que_clase,
                                  INPUT-OUTPUT rid_tabla,
                                  OUTPUT modo_salida).
  IF modo_salida = 1
  THEN DO:
       FIND Cuenta WHERE ROWID(Cuenta) = rid_tabla NO-LOCK.
       DISPLAY Cuenta.cdg_Cuenta @ v-cdg_cuenta
               WITH FRAME {&FRAME-NAME}.
       APPLY "RETURN" TO v-cdg_cuenta.
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


&Scoped-define SELF-NAME btn_valores
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_valores C-Win
ON CHOOSE OF btn_valores IN FRAME DEFAULT-FRAME /* Ver Medios de Pago */
DO:

    RUN d-valores_movimiento.w ( INPUT-OUTPUT TABLE T-Caj_header,
                                 INPUT-OUTPUT TABLE T-Caj_detalle,
                                 INPUT-OUTPUT TABLE T-Caja-imputacion,
                                 INPUT-OUTPUT TABLE T-Cheque,
                                 INPUT-OUTPUT TABLE T-Valor,
                                 INPUT 2).
    FIND FIRST T-Caj_header.
    {&OPEN-QUERY-{&BROWSE-NAME}}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_verimputacion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_verimputacion C-Win
ON CHOOSE OF btn_verimputacion IN FRAME DEFAULT-FRAME /* Imputación Contable */
DO:
  
  RUN d-ver_asiento_contable.w ( INPUT TABLE T-Asn_header,
                                 INPUT TABLE T-Asn_detalle,
                                 INPUT TABLE T-Asn_totales).

  /*
    RUN d-valores_movimiento.w ( INPUT-OUTPUT TABLE T-Caj_header,
                                 INPUT-OUTPUT TABLE T-Caj_detalle,
                                 INPUT-OUTPUT TABLE T-Caja-imputacion,
                                 INPUT-OUTPUT TABLE T-Cheque,
                                 INPUT-OUTPUT TABLE T-Valor,
                                 INPUT 2).
  */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Caj_header.importe
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Caj_header.importe C-Win
ON LEAVE OF T-Caj_header.importe IN FRAME DEFAULT-FRAME /* Importe */
DO:
  RUN calculos.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Caj_header.nro_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Caj_header.nro_comprob C-Win
ON MOUSE-SELECT-DBLCLICK OF T-Caj_header.nro_comprob IN FRAME DEFAULT-FRAME /* nro_comprob */
OR MOUSE-MENU-DOWN,"." OF T-Caj_header.nro_comprob IN FRAME {&FRAME-NAME}
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
          titulo_window = "Selección de " + "Comprobantes de caja".
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
          titulo_window = "Selección " + "Comprobantes de caja".
          lista_estados = "*".
     END.
     WHEN MD_CAMBIO        
     THEN DO:
          titulo_window = "".
          lista_estados = "".
     END.
     WHEN MD_ANULACION        
     THEN DO:
          titulo_window = "Selección de " + "Comprobantes de caja".
          lista_estados = "P,E".
     END.
     WHEN MD_EMISION        
     THEN DO:
          titulo_window = "Selección de " + "Comprobantes de caja".
          lista_estados = "".
     END.
  END CASE.     

  RUN d-selcomprobante_caja.w (INPUT titulo_window, INPUT lista_estados, INPUT "CJ", INPUT-OUTPUT rid_movcaja).
  IF rid_movcaja <> ?
  THEN DO:
     FIND Caj_header WHERE ROWID(Caj_header) = rid_movcaja NO-LOCK.
     DISPLAY Caj_header.tip_comprob @ T-Caj_header.tip_comprob 
             Caj_header.prf_comprob @ T-Caj_header.prf_comprob
             Caj_header.nro_comprob @ T-Caj_header.nro_comprob
             WITH FRAME {&FRAME-NAME}.
     IF modo = MD_ANULACION AND Caj_header.anulado
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Caj_header.nro_comprob C-Win
ON RETURN OF T-Caj_header.nro_comprob IN FRAME DEFAULT-FRAME /* nro_comprob */
DO:

   IF LOOKUP(INPUT FRAME {&FRAME-NAME} T-Caj_header.tip_comprob,"CJ,TI,TS") = 0 
   THEN DO:
      RUN PONMENSJ.P (INPUT "DOCS010").
      RETURN NO-APPLY.
   END.

   FIND Caj_header 
        WHERE Caj_header.cdg_empresa = Empresa.cdg_empresa
          AND Caj_header.tip_comprob = INPUT T-Caj_header.tip_comprob 
          AND Caj_header.prf_comprob = INPUT T-Caj_header.prf_comprob
          AND Caj_header.nro_comprob = INPUT T-Caj_header.nro_comprob
              NO-ERROR.

   IF NOT AVAILABLE Caj_header 
   THEN DO:
        IF LOCKED Caj_header
           THEN RUN PONMENSJ.P (INPUT "DOCS000").
           ELSE RUN PONMENSJ.P (INPUT "DOCS001").
        RETURN NO-APPLY.
   END.
   ELSE DO:
        rid_movcaja = ROWID(Caj_header).
        RUN traer_documento.
   END.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Caj_header.prf_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Caj_header.prf_comprob C-Win
ON MOUSE-SELECT-DBLCLICK OF T-Caj_header.prf_comprob IN FRAME DEFAULT-FRAME /* prf_comprob */
OR MOUSE-MENU-DOWN,"." OF T-Caj_header.prf_comprob IN FRAME {&FRAME-NAME}
DO:
  APPLY "MOUSE-SELECT-DBLCLICK" TO T-Caj_header.nro_comprob IN FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Caj_header.tipo_mov
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Caj_header.tipo_mov C-Win
ON VALUE-CHANGED OF T-Caj_header.tipo_mov IN FRAME DEFAULT-FRAME
DO:
  IF INPUT FRAME {&FRAME-NAME} T-Caj_header.tipo_mov = "T"
  THEN DO:
      ASSIGN
         v-cdg_receptora:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
  END.
  ELSE DO:
      ASSIGN
         v-cdg_receptora = 0
         v-dsc_receptora = ""
         v-cdg_receptora:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
      DISPLAY 
         v-cdg_receptora
         v-dsc_receptora
          WITH FRAME {&FRAME-NAME}.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Caj_header.tip_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Caj_header.tip_comprob C-Win
ON MOUSE-SELECT-DBLCLICK OF T-Caj_header.tip_comprob IN FRAME DEFAULT-FRAME /* Comprobante */
OR MOUSE-MENU-DOWN,"." OF T-Caj_header.tip_comprob IN FRAME {&FRAME-NAME}
DO:
  APPLY "MOUSE-SELECT-DBLCLICK" TO T-Caj_header.nro_comprob IN FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_caja
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_caja C-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_caja IN FRAME DEFAULT-FRAME /* Caja */
OR "." OF v-cdg_caja IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_caja IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "caja" "cdg_caja" "SELNCAJA.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_caja C-Win
ON RETURN OF v-cdg_caja IN FRAME DEFAULT-FRAME /* Caja */
DO:
   &SCOPED-DEFINE PONER-TABLA RUN poner_caja.
   {traducetabla.i "caja" "cdg_caja" "nombre"} 
   &UNDEFINE PONER-TABLA
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_cuenta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_cuenta C-Win
ON * OF v-cdg_cuenta IN FRAME DEFAULT-FRAME /* Cuenta */
DO:
  APPLY "CHOOSE" TO btn_porclasificacion.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_cuenta C-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_cuenta IN FRAME DEFAULT-FRAME /* Cuenta */
OR MOUSE-MENU-DOWN,"." OF v-cdg_cuenta IN FRAME {&FRAME-NAME}
DO:

  DEFINE VARIABLE rid_cuenta AS ROWID.

  RUN selcuent.p ( INPUT-OUTPUT rid_cuenta, 
                   INPUT YES ).

  IF rid_cuenta <> ?
  THEN DO:
       FIND Cuenta WHERE ROWID(Cuenta) = rid_cuenta NO-LOCK.
       DISPLAY Cuenta.cdg_cuenta  @ v-cdg_cuenta
               WITH FRAME {&FRAME-NAME}.
       APPLY "RETURN" TO v-cdg_cuenta IN FRAME {&FRAME-NAME}.
  END.
  RETURN NO-APPLY.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_cuenta C-Win
ON RETURN OF v-cdg_cuenta IN FRAME DEFAULT-FRAME /* Cuenta */
DO:

   ASSIGN FRAME {&FRAME-NAME}
         v-cdg_cuenta.

   FIND Cuenta WHERE Cuenta.cdg_cuenta = v-cdg_cuenta NO-LOCK NO-ERROR.

   IF NOT AVAILABLE Cuenta
   THEN DO:
      RUN PONMENSJ.P (INPUT "FAPR001").
      RETURN NO-APPLY.
   END.

   RUN crear_detalle.
   
   DISPLAY " " @ v-cdg_cuenta
           WITH FRAME {&FRAME-NAME}.
   APPLY "ENTRY" TO v-cdg_cuenta  IN FRAME {&FRAME-NAME}.
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


&Scoped-define SELF-NAME v-cdg_receptora
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_receptora C-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_receptora IN FRAME DEFAULT-FRAME /* Caja Receptora */
OR "." OF v-cdg_receptora IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_receptora IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Receptora" "cdg_caja" "SELNCAJA.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_receptora C-Win
ON RETURN OF v-cdg_receptora IN FRAME DEFAULT-FRAME /* Caja Receptora */
DO:
   &SCOPED-DEFINE PONER-TABLA RUN poner_receptora.
   {traducetabla.i "receptora" "cdg_caja" "nombre"} 
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
            DISPLAY v-pto_venta @ T-Caj_header.prf_comprob
                    WITH FRAME {&FRAME-NAME}.
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

/*
RUN carga_comprobante.
RUN carga_conceptos.
*/
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
                         INPUT  T-Caj_header.cdg_empresa, 
                         INPUT  T-Caj_header.fch_cambio,       
                         OUTPUT T-Caj_header.cambio,  
                         OUTPUT T-Caj_header.fch_cambio ).

  DISPLAY T-Caj_header.cambio 
          T-Caj_header.fch_cambio 
          WITH FRAME {&FRAME-NAME}.

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
  
  T-Caj_header.nro_moneda = Moneda.nro_moneda.
  T-Caj_header.fch_cambio = T-Caj_header.fecha - 1.
  RUN asignar_cambio.
  RUN calculos.

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

 EMPTY TEMP-TABLE T-Caja-imputacion       NO-ERROR.
 EMPTY TEMP-TABLE T-Caj_header            NO-ERROR.
 EMPTY TEMP-TABLE T-Caj_detalle           NO-ERROR.
 EMPTY TEMP-TABLE T-Valor                 NO-ERROR. 
 EMPTY TEMP-TABLE T-Cheque                NO-ERROR.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE calculos C-Win 
PROCEDURE calculos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    RUN calcular_comprobante_caja.p (
                             INPUT-OUTPUT TABLE T-Caj_header,
                             INPUT-OUTPUT TABLE T-Caj_detalle,
                             INPUT-OUTPUT TABLE T-Caja-imputacion,
                             INPUT-OUTPUT TABLE T-Asn_header,
                             INPUT-OUTPUT TABLE T-Asn_detalle,
                             INPUT-OUTPUT TABLE T-Asn_totales).

    FIND FIRST T-Asn_header NO-ERROR.
    FIND FIRST T-Caj_header.

    imp_no_imp = INPUT FRAME {&FRAME-NAME} T-Caj_header.importe.
    FOR EACH T-Caja-imputacion WHERE T-Caja-imputacion.nro_transaccion = T-Caj_header.nro_transaccion:
             imp_no_imp = imp_no_imp - T-Caja-imputacion.valor.
    END. 

    DISPLAY imp_no_imp
            WITH FRAME {&FRAME-NAME}.
    btn_verimputacion:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
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

    RUN d-detalle_imputacion.w ( INPUT         T-Caja-imputacion.nro_cuenta,
                                 INPUT  modo,
                                 INPUT  1, /* modo detalle = CREAR */
                                 INPUT-OUTPUT  T-Caja-imputacion.nro_entidad,
                                 INPUT-OUTPUT  T-Caja-imputacion.nro_obra,
                                 INPUT-OUTPUT  T-Caja-imputacion.valor,
                                 INPUT-OUTPUT  T-Caja-imputacion.observacion,
                                 OUTPUT        v-ok).

    
    IF v-rid_detalle <> ?
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

    v-valor = imp_no_imp.
    v-observacion = INPUT FRAME {&FRAME-NAME} T-Caj_header.observacion.


       RUN d-detalle_imputacion.w ( INPUT Cuenta.nro_cuenta,
                                 INPUT  modo,
                                 INPUT  0, /* modo detalle = CREAR */
                                 INPUT-OUTPUT  v-nro_entidad,
                                 INPUT-OUTPUT  v-nro_obra,
                                 INPUT-OUTPUT  v-valor,
                                 INPUT-OUTPUT  v-observacion,
                                 OUTPUT        v-ok).
   
    
    IF v-ok
    THEN DO:
        CREATE T-Caja-imputacion.
        ASSIGN T-Caja-imputacion.nro_transaccion = T-Caj_header.nro_transaccion
               T-Caja-imputacion.nro_cuenta      = Cuenta.nro_cuenta
               T-Caja-imputacion.nro_entidad     = v-nro_entidad
               T-Caja-imputacion.nro_obra        = v-nro_obra
               T-Caja-imputacion.valor           = v-valor
               T-Caja-imputacion.observacion     = v-observacion.

         RUN calculos.
         {&OPEN-QUERY-{&BROWSE-NAME}}
         btn_copiar:SENSITIVE IN FRAME {&FRAME-NAME}        = NO.

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
  /*
  DO WITH FRAME {&FRAME-NAME}:
     v-comprobante = v-nombre_comprobante.
     v-comprobante:FGCOLOR = v-fgcolor_comprobante.
     v-comprobante:BGCOLOR = v-bgcolor_comprobante.
  END.
  */

  DO TRANSACTION:
    
      CREATE T-Caj_header.
      ASSIGN T-Caj_header.cdg_comprobante  = "MOVGCAJA"
             T-Caj_header.nro_usuario      = Usuario.nro_usuario 
             T-Caj_header.cdg_empresa      = Empresa.cdg_empresa
             T-Caj_header.fecha            = TODAY 
             T-Caj_header.cdg_empresa      = Empresa.cdg_empresa 
             T-Caj_header.tip_comprob      = "" 
             T-Caj_header.nro_transaccion  = 0  
             T-Caj_header.estado           = "E"  
             T-Caj_header.nro_comprob      = T-Caj_header.nro_transaccion
             T-Caj_header.prf_comprob      = 0
             T-Caj_header.nro_moneda       = Moneda.nro_moneda 
             T-Caj_header.cambio           = Moneda.cambio
             T-Caj_header.num_sucursal     = sucursal-id    
             T-Caj_header.origen           = "M"
             v-cdg_moneda                  = Moneda.cdg_moneda
             v-dsc_moneda                  = Moneda.descripcion. 
  END.

  RUN asignar_cambio.

  IF    modo = MD_MULTIPLE
     OR modo = MD_ANULACION
     OR modo = MD_EMISION
  THEN DO:
       DO WITH FRAME {&FRAME-NAME}:
          T-Caj_header.tip_comprob:FGCOLOR = 9.
          T-Caj_header.tip_comprob:BGCOLOR = 15.

          T-Caj_header.prf_comprob:FGCOLOR = 9.
          T-Caj_header.prf_comprob:BGCOLOR = 15.

          T-Caj_header.nro_comprob:FGCOLOR = 9.
          T-Caj_header.nro_comprob:BGCOLOR = 15.
       END.
  END.

  DISPLAY
         T-Caj_header.fecha   
         v-cdg_moneda
         v-dsc_moneda      
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
  DISPLAY v-pto_venta imp_no_imp v-anulado v-cdg_caja v-dsc_caja v-cdg_moneda 
          v-dsc_moneda v-cdg_receptora v-dsc_receptora v-cdg_cuenta v-usuario 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE T-Caj_header THEN 
    DISPLAY T-Caj_header.tip_comprob T-Caj_header.prf_comprob 
          T-Caj_header.nro_comprob T-Caj_header.fecha T-Caj_header.importe 
          T-Caj_header.cambio T-Caj_header.tipo_mov T-Caj_header.observacion 
          T-Caj_header.fch_cambio 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE RECT-1 RECT-2 RECT-3 RECT-5 Btn_salir T-Caj_header.tip_comprob 
         T-Caj_header.prf_comprob T-Caj_header.nro_comprob T-Caj_header.fecha 
         imp_no_imp T-Caj_header.importe T-Caj_header.cambio 
         T-Caj_header.tipo_mov T-Caj_header.observacion BROWSE-4 v-usuario 
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
                T-Caj_header.tip_comprob:SENSITIVE        = NO
                T-Caj_header.prf_comprob:SENSITIVE        = NO
                T-Caj_header.nro_comprob:SENSITIVE        = NO
                T-Caj_header.fecha:SENSITIVE              = NO
                T-Caj_header.cambio:SENSITIVE             = NO
                T-Caj_header.observacion:SENSITIVE        = NO
                T-Caj_header.tipo_mov:SENSITIVE           = NO
                T-Caj_header.importe:SENSITIVE            = NO
                v-cdg_cuenta:SENSITIVE                    = NO
                v-cdg_moneda:SENSITIVE                    = NO
                btn_verimputacion:SENSITIVE               = NO
                btn_porclasificacion:SENSITIVE            = NO.
     END.
     ELSE DO:

        RUN FRAME_sensitiva ( NO ).
        CASE modo:
   
            WHEN MD_ALTA          
            THEN DO:
                 ASSIGN
                    v-cdg_caja:SENSITIVE                 = YES
                    v-pto_venta:SENSITIVE                = YES.
     
            END.
            WHEN MD_MULTIPLE      
            THEN DO:
                 ASSIGN
                    T-Caj_header.tip_comprob:SENSITIVE        = YES
                    T-Caj_header.prf_comprob:SENSITIVE        = YES
                    T-Caj_header.nro_comprob:SENSITIVE        = YES
                    v-pto_venta:SENSITIVE                     = NO.

            END.
            WHEN MD_DEFINIDA      
            THEN DO:
                 ASSIGN
                    btn_verimputacion:SENSITIVE               = CAN-FIND(FIRST T-Asn_header )
                    v-pto_venta:SENSITIVE                     = NO.
     
            END.
            WHEN MD_RELACION      
            THEN DO:
                 ASSIGN
                    btn_verimputacion:SENSITIVE               = CAN-FIND(FIRST T-Asn_header )
                    v-pto_venta:SENSITIVE                     = NO.
     
            END.
            WHEN MD_READONLY      
            THEN DO:
                 ASSIGN
                    btn_verimputacion:SENSITIVE               = CAN-FIND(FIRST T-Asn_header )
                    v-pto_venta:SENSITIVE                     = NO.
     
            END.
            WHEN MD_CAMBIO        
            THEN DO:
                 ASSIGN
                    btn_verimputacion:SENSITIVE               = CAN-FIND(FIRST T-Asn_header )
                    v-pto_venta:SENSITIVE                     = NO.

            END.
            WHEN MD_ANULACION        
            THEN DO:
                 ASSIGN
                    T-Caj_header.tip_comprob:SENSITIVE        = YES
                    T-Caj_header.prf_comprob:SENSITIVE        = YES
                    T-Caj_header.nro_comprob:SENSITIVE        = YES
                    v-pto_venta:SENSITIVE                     = NO.
            END.
            WHEN MD_EMISION        
            THEN DO:
                 ASSIGN
                    T-Caj_header.tip_comprob:SENSITIVE        = YES
                    T-Caj_header.prf_comprob:SENSITIVE        = YES
                    T-Caj_header.nro_comprob:SENSITIVE        = YES
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

        RUN emitir_movimiento_tesoreria.p
            (INPUT v-cdg_receptora,
             INPUT TABLE T-Caj_header,
             INPUT TABLE T-Caj_detalle,
             INPUT TABLE T-Caja-imputacion,
             INPUT TABLE T-Cheque,
             INPUT TABLE T-Valor).

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

                  /* Deshabilitamos todo y después habilitamos según cada caso */

     ASSIGN
            btn_grabar:SENSITIVE                      = NO
            btn_copiar:SENSITIVE                      = NO
            btn_cancel:SENSITIVE                      = NO
            btn_anular:SENSITIVE                      = NO
            btn_observ:SENSITIVE                      = NO
            btn_imprim:SENSITIVE                      = NO
            T-Caj_header.tip_comprob:SENSITIVE        = NO
            T-Caj_header.prf_comprob:SENSITIVE        = NO
            T-Caj_header.nro_comprob:SENSITIVE        = NO
            T-Caj_header.fecha:SENSITIVE              = NO
            T-Caj_header.cambio:SENSITIVE             = NO
            T-Caj_header.observacion:SENSITIVE        = NO
            T-Caj_header.tipo_mov:SENSITIVE           = NO
            T-Caj_header.importe:SENSITIVE            = NO
            v-cdg_cuenta:SENSITIVE                    = NO
            v-cdg_moneda:SENSITIVE                    = NO
            btn_verimputacion:SENSITIVE               = NO
            btn_porclasificacion:SENSITIVE            = NO.


     CASE modo:

       WHEN MD_ALTA          
       THEN DO:
            /* No se invoca esta rutina cuando el modo es MD_ALTA */
       END.
       WHEN MD_MULTIPLE      
       THEN DO:
            ASSIGN
                btn_cancel:SENSITIVE                      = YES
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES
                btn_verimputacion:SENSITIVE               = CAN-FIND(FIRST T-Asn_header )
                btn_valores:SENSITIVE                     = YES
                btn_valores:SENSITIVE                     = YES.

       END.
       WHEN MD_DEFINIDA      
       THEN DO:
            ASSIGN
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES
                btn_verimputacion:SENSITIVE               = CAN-FIND(FIRST T-Asn_header )
                btn_valores:SENSITIVE                     = YES.
       END.
       WHEN MD_RELACION      
       THEN DO:
            ASSIGN
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES
                btn_verimputacion:SENSITIVE               = CAN-FIND(FIRST T-Asn_header )
                btn_valores:SENSITIVE                     = YES.
       END.
       WHEN MD_READONLY      
       THEN DO:
            ASSIGN
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES
                btn_verimputacion:SENSITIVE               = CAN-FIND(FIRST T-Asn_header )
                btn_valores:SENSITIVE                     = YES.
       END.
       WHEN MD_CAMBIO        
       THEN DO:
            ASSIGN
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES
                btn_verimputacion:SENSITIVE               = CAN-FIND(FIRST T-Asn_header )
                btn_valores:SENSITIVE                     = YES.
       END.
       WHEN MD_ANULACION        
       THEN DO:
            ASSIGN
                btn_cancel:SENSITIVE                      = YES
                btn_anular:SENSITIVE                      = YES
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES
                btn_verimputacion:SENSITIVE               = CAN-FIND(FIRST T-Asn_header )
                btn_valores:SENSITIVE                     = YES.
       END.
       WHEN MD_EMISION        
       THEN DO:
            ASSIGN
                btn_grabar:SENSITIVE                      = YES
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES
                btn_verimputacion:SENSITIVE               = CAN-FIND(FIRST T-Asn_header )
                btn_valores:SENSITIVE                     = YES.
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

    RUN getparametro.p (  INPUT  "MDCAMBIO",
                          OUTPUT v-valor_c,
                          OUTPUT v-valor_d,
                          OUTPUT v-valor_l,
                          OUTPUT v-valor_n,
                          OUTPUT v-observacion ).
    IF v-valor_l = ? 
      THEN mod_cambio = NO.
      ELSE mod_cambio = v-valor_l.


    RUN getparametro.p (  INPUT  "DFMONEDA",
                          OUTPUT v-valor_c,
                          OUTPUT v-valor_d,
                          OUTPUT v-valor_l,
                          OUTPUT v-valor_n,
                          OUTPUT v-observacion ).
    FIND Moneda WHERE Moneda.cdg_moneda = v-valor_c NO-LOCK.
    act_moneda = ROWID(Moneda).
    
    RUN getparametro.p (  INPUT  "DFNROCAJ",
                          OUTPUT v-valor_c,
                          OUTPUT v-valor_d,
                          OUTPUT v-valor_l,
                          OUTPUT v-valor_n,
                          OUTPUT v-observacion ).
    
    FIND Caja WHERE Caja.cdg_caja = v-valor_n NO-LOCK.
    act_caja = ROWID(Caja).

/*

    RUN getparametro.p (  INPUT  "HABCANJE",
                          OUTPUT v-valor_c,
                          OUTPUT v-valor_d,
                          OUTPUT v-valor_l,
                          OUTPUT v-valor_n,
                          OUTPUT v-observacion ).
    IF v-valor_l = ? 
       THEN hay_canje = NO.
       ELSE hay_canje = v-valor_l.
       
    
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
*/
   RUN titulo_window ( INPUT "Movimiento de Tesorería" ).           

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_caja C-Win 
PROCEDURE poner_caja :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  
  IF NOT CAN-DO(Caja.lista_usuarios,Usuario.cdg_usuario)
  THEN DO:
      no_aplicar = YES.
      RUN ponmensj.p ( INPUT "CAJA028" ).
      RETURN ERROR.

  END.
  
  DISPLAY "CJ" @ T-Caj_header.tip_comprob
          WITH FRAME {&FRAME-NAME}.
  ASSIGN
      T-Caj_header.cdg_caja          = Caja.cdg_caja
      v-cdg_caja                     = Caja.cdg_caja.

  DISPLAY  v-cdg_caja 
           v-dsc_caja

           WITH FRAME {&FRAME-NAME}.
           
  DO WITH FRAME {&FRAME-NAME}:
      ASSIGN
            btn_grabar:SENSITIVE                      = YES
            btn_copiar:SENSITIVE                      = YES
            btn_cancel:SENSITIVE                      = YES
            btn_anular:SENSITIVE                      = NO
            btn_observ:SENSITIVE                      = YES
            btn_imprim:SENSITIVE                      = NO
            T-Caj_header.tip_comprob:SENSITIVE        = NO
            T-Caj_header.prf_comprob:SENSITIVE        = NO
            T-Caj_header.nro_comprob:SENSITIVE        = NO
            T-Caj_header.fecha:SENSITIVE              = YES
            T-Caj_header.cambio:SENSITIVE             = YES /*mod_cambio*/
            T-Caj_header.observacion:SENSITIVE        = YES
            T-Caj_header.tipo_mov:SENSITIVE           = YES
            T-Caj_header.importe:SENSITIVE            = YES
            v-cdg_moneda:SENSITIVE                    = YES
            v-cdg_cuenta:SENSITIVE                    = YES
            v-cdg_caja:SENSITIVE                      = NO.
            
   END. 

   /*RUN calculos.   */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_receptora C-Win 
PROCEDURE poner_receptora :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  
  IF NOT CAN-DO(Receptora.lista_usuarios,Usuario.cdg_usuario)
  THEN DO:
      no_aplicar = YES.
      RUN ponmensj.p ( INPUT "CAJA028" ).
      RETURN ERROR.

  END.
  
  ASSIGN
      v-cdg_receptora = Receptora.cdg_caja
      v-dsc_receptora = Receptora.nombre.

  DISPLAY  v-cdg_receptora 
           v-dsc_receptora
           WITH FRAME {&FRAME-NAME}.

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_caja C-Win 
PROCEDURE traer_caja :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND Caja OF T-Caj_header NO-LOCK.
    ASSIGN
        v-cdg_caja   = Caja.cdg_caja
        v-dsc_caja   = Caja.nombre.
    
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

   FIND Caj_header WHERE ROWID(Caj_header) = rid_movcaja NO-LOCK.
   FIND Caja OF Caj_header NO-LOCK.
   IF NOT CAN-DO(Caja.lista_usuarios,Usuario.cdg_usuario)
   THEN DO:
       RUN ponmensj.p ( INPUT "CAJA029" ).
       RETURN ERROR.
   END.


   RUN traer_movimiento_caja.p ( INPUT Caj_header.nro_transaccion,
                                 OUTPUT TABLE T-Caj_header,
                                 OUTPUT TABLE T-Caj_detalle,
                                 OUTPUT TABLE T-Caja-imputacion,
                                 OUTPUT TABLE T-Cheque,
                                 OUTPUT TABLE T-Valor).
   FIND FIRST T-Caj_header.
   RUN traer_tablas.

   RUN leer_asiento_comprobante.p ( INPUT "Caj_header",
                                    INPUT Caj_header.nro_transaccion,
                                    OUTPUT TABLE T-Asn_header,
                                    OUTPUT TABLE T-Asn_detalle,
                                    OUTPUT TABLE T-Asn_totales ).
   FIND FIRST T-Asn_header NO-LOCK NO-ERROR.

   v-anulado = IF T-Caj_header.anulado THEN "ANULADA" ELSE "".
   v-usuario = "".
   find usuario NO-LOCK OF t-Caj_header NO-ERROR.
   IF AVAILABLE usuario THEN v-usuario = usuario.nombre.
   DISPLAY
        T-Caj_header.cambio 
        T-Caj_header.fecha 
        T-Caj_header.importe 
        T-Caj_header.observacion 
        T-Caj_header.nro_comprob 
        T-Caj_header.prf_comprob 
        T-Caj_header.tip_comprob 
        v-usuario
        v-cdg_moneda 
        v-cdg_caja 
        v-dsc_moneda 
        v-dsc_caja 
        v-anulado
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

    FIND Moneda    OF T-Caj_header   NO-LOCK.
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

  RUN traer_moneda.
  RUN traer_caja.


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

    IF NOT CAN-FIND(FIRST T-Caja-imputacion WHERE T-Caja-imputacion.nro_transaccion = T-Caj_header.nro_transaccion)
    THEN DO:
       RUN PONMENSJ.P (INPUT "RECB008").
       RETURN.
    END.

    IF imp_no_imp <> 0
    THEN DO:
       RUN PONMENSJ.P (INPUT "CAJA022").
       RETURN.
    END.

    IF T-Caj_header.importe = 0
    THEN DO:
       RUN PONMENSJ.P (INPUT "RECB019").
       RETURN.
    END.
    
    IF CAN-FIND(Caj_header WHERE Caj_header.cdg_empresa = T-Caj_header.cdg_empresa
                             AND Caj_header.tip_comprob = T-Caj_header.tip_comprob
                             AND Caj_header.prf_comprob = T-Caj_header.prf_comprob
                             AND Caj_header.nro_comprob = T-Caj_header.nro_comprob)
    THEN DO:
       RUN PONMENSJ.P (INPUT "RECB014").
       RETURN.
    END.
    
    {validartabla.i "Moneda"            "cdg_moneda"      "descripcion"    "DBCR012"}
    {validartabla.i "Caja"              "cdg_caja"        "nombre"         "CAJA021"}
    IF T-Caj_header.tipo_mov = "T"
    THEN DO:
        {validartabla.i "Receptora"              "cdg_caja"        "nombre"         "CAJA021"}
    END.

    hubo_error = NO.

    &SCOPED-DEFINE TABLA-MAESTRA  T-Caj_header
    
    {asignartabla.i "Moneda"            "nro_moneda"      "nro_moneda"       }
    {asignartabla.i "Caja"              "cdg_caja"        "cdg_caja"         }

    &UNDEFINE TABLA-MAESTRA


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

