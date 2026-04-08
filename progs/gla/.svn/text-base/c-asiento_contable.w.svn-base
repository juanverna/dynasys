&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win

/* Temp-Table and Buffer definitions                                    */
DEFINE NEW SHARED TEMP-TABLE T-Asn_detalle NO-UNDO LIKE Asn_detalle.
DEFINE NEW SHARED TEMP-TABLE T-Asn_header NO-UNDO LIKE Asn_header.
DEFINE TEMP-TABLE T-Asn_totales NO-UNDO LIKE Asn_totales.
DEFINE BUFFER Total-moneda FOR Moneda.


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

DEFINE BUFFER T-Reexpresion FOR T-Asn_detalle.

/* Parameters Definitions ---                                           */
&IF DEFINED(UIB_is_Running) NE 0
&THEN
DEFINE VARIABLE                rid_asiento    AS ROWID.
DEFINE VARIABLE                modo           AS INTEGER.
&ELSE
DEFINE INPUT-OUTPUT PARAMETER  rid_asiento    AS ROWID.
DEFINE INPUT        PARAMETER  modo           AS INTEGER.
&ENDIF

/* Local Variable Definitions ---                                       */

{VRSHARED.I "NEW"}

{nrorelea.i}
{valoresmodo.i}
{valoressalida.i}
{dfmodocotiza.i}

DEFINE VARIABLE cotiza_dolar              AS DECIMAL.
DEFINE VARIABLE codigo_dolar              LIKE Moneda.cdg_moneda.

DEFINE VARIABLE dfl_leyenda               AS CHARACTER.

DEFINE VARIABLE sino-msg                  AS LOGICAL NO-UNDO.
DEFINE VARIABLE st_seleccionado           AS CHARACTER.

DEFINE VARIABLE v-prox_docum              LIKE Parametro.cdg_parametro INITIAL "PROXNASN".
DEFINE VARIABLE v-debito                  AS CHARACTER FORMAT "X(14)".
DEFINE VARIABLE v-credito                 AS CHARACTER FORMAT "X(14)".

DEFINE VARIABLE rid_modelo                AS ROWID.

DEFINE VARIABLE v-nro_linea               AS INTEGER.
DEFINE VARIABLE v-total_debitos           AS DECIMAL.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME BRW-ACUMULADOS

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Asn_totales Total-moneda T-Asn_detalle ~
Cuenta Moneda Entidad T-Asn_header

/* Definitions for BROWSE BRW-ACUMULADOS                                */
&Scoped-define FIELDS-IN-QUERY-BRW-ACUMULADOS Total-moneda.abrevia ~
T-Asn_totales.tot_debitos T-Asn_totales.tot_creditos ~
T-Asn_totales.diferencia Total-moneda.descripcion 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BRW-ACUMULADOS 
&Scoped-define QUERY-STRING-BRW-ACUMULADOS FOR EACH T-Asn_totales OF T-Asn_header NO-LOCK, ~
      EACH Total-moneda OF T-Asn_header NO-LOCK
&Scoped-define OPEN-QUERY-BRW-ACUMULADOS OPEN QUERY BRW-ACUMULADOS FOR EACH T-Asn_totales OF T-Asn_header NO-LOCK, ~
      EACH Total-moneda OF T-Asn_header NO-LOCK.
&Scoped-define TABLES-IN-QUERY-BRW-ACUMULADOS T-Asn_totales Total-moneda
&Scoped-define FIRST-TABLE-IN-QUERY-BRW-ACUMULADOS T-Asn_totales
&Scoped-define SECOND-TABLE-IN-QUERY-BRW-ACUMULADOS Total-moneda


/* Definitions for BROWSE BRW-DETALLE                                   */
&Scoped-define FIELDS-IN-QUERY-BRW-DETALLE T-Asn_detalle.nro_linea ~
Cuenta.cdg_cuenta Cuenta.nombre_cta Entidad.cdg_entidad Entidad.dsc_entidad ~
Moneda.abrevia T-Asn_detalle.cambio ~
IF (T-Asn_detalle.debito<>0) THEN (STRING(T-Asn_detalle.debito,"-ZZ,ZZZ,ZZ9.99")) ELSE ("")  @ v-debito ~
IF (T-Asn_detalle.credito<>0) THEN (STRING(T-Asn_detalle.credito,"-ZZ,ZZZ,ZZ9.99")) ELSE ("")  @ v-credito 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BRW-DETALLE 
&Scoped-define QUERY-STRING-BRW-DETALLE FOR EACH T-Asn_detalle OF T-Asn_header NO-LOCK, ~
      EACH Cuenta OF T-Asn_detalle NO-LOCK, ~
      EACH Moneda OF T-Asn_detalle NO-LOCK, ~
      EACH Entidad OF T-Asn_detalle NO-LOCK ~
    BY T-Asn_detalle.nro_linea
&Scoped-define OPEN-QUERY-BRW-DETALLE OPEN QUERY BRW-DETALLE FOR EACH T-Asn_detalle OF T-Asn_header NO-LOCK, ~
      EACH Cuenta OF T-Asn_detalle NO-LOCK, ~
      EACH Moneda OF T-Asn_detalle NO-LOCK, ~
      EACH Entidad OF T-Asn_detalle NO-LOCK ~
    BY T-Asn_detalle.nro_linea.
&Scoped-define TABLES-IN-QUERY-BRW-DETALLE T-Asn_detalle Cuenta Moneda ~
Entidad
&Scoped-define FIRST-TABLE-IN-QUERY-BRW-DETALLE T-Asn_detalle
&Scoped-define SECOND-TABLE-IN-QUERY-BRW-DETALLE Cuenta
&Scoped-define THIRD-TABLE-IN-QUERY-BRW-DETALLE Moneda
&Scoped-define FOURTH-TABLE-IN-QUERY-BRW-DETALLE Entidad


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define FIELDS-IN-QUERY-DEFAULT-FRAME T-Asn_header.tip_comprob ~
T-Asn_header.prf_comprob T-Asn_header.nro_comprob ~
T-Asn_header.nro_secuencia T-Asn_header.cambio_dolar ~
T-Asn_header.reexpresa_saldos T-Asn_header.fecha T-Asn_header.cambio ~
T-Asn_header.leyenda T-Asn_header.cdg_sigla-sic T-Asn_header.origen 
&Scoped-define ENABLED-FIELDS-IN-QUERY-DEFAULT-FRAME T-Asn_header.fecha ~
T-Asn_header.cambio T-Asn_header.leyenda 
&Scoped-define ENABLED-TABLES-IN-QUERY-DEFAULT-FRAME T-Asn_header
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-DEFAULT-FRAME T-Asn_header
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-BRW-ACUMULADOS}~
    ~{&OPEN-QUERY-BRW-DETALLE}
&Scoped-define QUERY-STRING-DEFAULT-FRAME FOR EACH T-Asn_header SHARE-LOCK
&Scoped-define OPEN-QUERY-DEFAULT-FRAME OPEN QUERY DEFAULT-FRAME FOR EACH T-Asn_header SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-DEFAULT-FRAME T-Asn_header
&Scoped-define FIRST-TABLE-IN-QUERY-DEFAULT-FRAME T-Asn_header


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS T-Asn_header.fecha T-Asn_header.cambio ~
T-Asn_header.leyenda 
&Scoped-define ENABLED-TABLES T-Asn_header
&Scoped-define FIRST-ENABLED-TABLE T-Asn_header
&Scoped-Define ENABLED-OBJECTS RECT-2 RECT-3 RECT-4 RECT-5 RECT-6 RECT-7 ~
RECT-8 RECT-9 RECT-10 Btn_salir BRW-ACUMULADOS BRW-DETALLE 
&Scoped-Define DISPLAYED-FIELDS T-Asn_header.tip_comprob ~
T-Asn_header.prf_comprob T-Asn_header.nro_comprob ~
T-Asn_header.nro_secuencia T-Asn_header.cambio_dolar ~
T-Asn_header.reexpresa_saldos T-Asn_header.fecha T-Asn_header.cambio ~
T-Asn_header.leyenda T-Asn_header.cdg_sigla-sic T-Asn_header.origen ~
T-Asn_detalle.leyen_detalle 
&Scoped-define DISPLAYED-TABLES T-Asn_header T-Asn_detalle
&Scoped-define FIRST-DISPLAYED-TABLE T-Asn_header
&Scoped-define SECOND-DISPLAYED-TABLE T-Asn_detalle
&Scoped-Define DISPLAYED-OBJECTS v-libro v-estado v-reexpresado ~
v-cdg_cuenta 

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
     SIZE 20 BY 1.33 TOOLTIP "Anula el asiento actual".

DEFINE BUTTON btn_cancel 
     LABEL "&Cancelar" 
     SIZE 20 BY 1.33 TOOLTIP "Cancela el ingreso actual y comienza nuevamente".

DEFINE BUTTON btn_comprobante 
     LABEL "&Ver Comprobante" 
     SIZE 20 BY 1.33 TOOLTIP "Genera un asiento en base  a un modelo almacenado".

DEFINE BUTTON btn_copiar 
     LABEL "&Copiar" 
     SIZE 20 BY 1.33 TOOLTIP "Selecciona y copia un asiento existente".

DEFINE BUTTON btn_difcambio 
     LABEL "Diferencia Cambio" 
     SIZE 20 BY 1.33.

DEFINE BUTTON btn_grabar 
     LABEL "&Grabar" 
     SIZE 20 BY 1.33 TOOLTIP "Finaliza el ingreso y procede a grabar si no hay errores".

DEFINE BUTTON btn_imprim 
     LABEL "&Reimprimir" 
     SIZE 20 BY 1.33 TOOLTIP "Imprime una minuta con el vuelco del asiento".

DEFINE BUTTON btn_modelo 
     LABEL "&Modelo" 
     SIZE 20 BY 1.33 TOOLTIP "Genera un asiento en base  a un modelo almacenado".

DEFINE BUTTON btn_observ 
     LABEL "&Observación" 
     SIZE 20 BY 1.33 TOOLTIP "Edita las observaciones del asiento actual".

DEFINE BUTTON btn_revertir 
     LABEL "&Revertir" 
     SIZE 20 BY 1.33 TOOLTIP "Revierte el asiento ingresado".

DEFINE BUTTON Btn_salir DEFAULT 
     LABEL "&Salir" 
     SIZE 20 BY 1.33 TOOLTIP "Sale de la transacción"
     BGCOLOR 8 .

DEFINE VARIABLE v-libro AS CHARACTER FORMAT "X(256)":U 
     LABEL "Libro" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     DROP-DOWN-LIST
     SIZE 29 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-reexpresado AS LOGICAL FORMAT "yes/no":U INITIAL NO 
     LABEL "Expresión" 
     VIEW-AS COMBO-BOX INNER-LINES 2
     LIST-ITEM-PAIRS "MONEDA DE ORIGEN",no,
                     "SALDOS REEXPRESADOS",yes
     DROP-DOWN-LIST
     SIZE 33 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cdg_cuenta AS CHARACTER FORMAT "X(256)":U 
     LABEL "Cuenta" 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE v-estado AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15 FGCOLOR 12 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 22 BY 1.91.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 127 BY 1.86.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 22 BY 1.86.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 127 BY 12.38.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 22 BY 2.62.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 150 BY 10.76.

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 22 BY 3.33.

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 22 BY 1.91.

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 22 BY 2.62.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BRW-ACUMULADOS FOR 
      T-Asn_totales, 
      Total-moneda SCROLLING.

DEFINE QUERY BRW-DETALLE FOR 
      T-Asn_detalle, 
      Cuenta, 
      Moneda, 
      Entidad SCROLLING.

DEFINE QUERY DEFAULT-FRAME FOR 
      T-Asn_header SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BRW-ACUMULADOS
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BRW-ACUMULADOS C-Win _STRUCTURED
  QUERY BRW-ACUMULADOS NO-LOCK DISPLAY
      Total-moneda.abrevia COLUMN-LABEL "Identific!Moneda" FORMAT "X(5)":U
      T-Asn_totales.tot_debitos FORMAT "->,>>>,>>>,>>9.99":U
      T-Asn_totales.tot_creditos FORMAT "->,>>>,>>>,>>9.99":U
      T-Asn_totales.diferencia FORMAT "->>>,>>>,>>9.99":U
      Total-moneda.descripcion FORMAT "X(35)":U WIDTH 57.2
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 123 BY 7.86
         BGCOLOR 15 FGCOLOR 9 
         TITLE BGCOLOR 15 FGCOLOR 9 "Totales por Moneda" EXPANDABLE.

DEFINE BROWSE BRW-DETALLE
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BRW-DETALLE C-Win _STRUCTURED
  QUERY BRW-DETALLE NO-LOCK DISPLAY
      T-Asn_detalle.nro_linea COLUMN-LABEL "N.Li!nea" FORMAT ">>>9":U
      Cuenta.cdg_cuenta FORMAT "X(8)":U
      Cuenta.nombre_cta COLUMN-LABEL "Nombre!Cuenta" FORMAT "X(35)":U
      Entidad.cdg_entidad FORMAT "X(8)":U
      Entidad.dsc_entidad FORMAT "X(20)":U
      Moneda.abrevia COLUMN-LABEL "Identific!Moneda" FORMAT "X(5)":U
      T-Asn_detalle.cambio COLUMN-LABEL "Valor!Cotización" FORMAT ">>>>9.9999":U
      IF (T-Asn_detalle.debito<>0) THEN (STRING(T-Asn_detalle.debito,"-ZZ,ZZZ,ZZ9.99")) ELSE ("")  @ v-debito COLUMN-LABEL "Importe!Débito" FORMAT "X(14)":U
            COLUMN-FONT 2
      IF (T-Asn_detalle.credito<>0) THEN (STRING(T-Asn_detalle.credito,"-ZZ,ZZZ,ZZ9.99")) ELSE ("")  @ v-credito COLUMN-LABEL "Importe!Crédito" FORMAT "X(14)":U
            COLUMN-FONT 2
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 146 BY 8.91
         BGCOLOR 15 FGCOLOR 9 
         TITLE BGCOLOR 15 FGCOLOR 9 "Pases del Asiento Actual".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btn_copiar AT ROW 1.48 COL 25
     btn_cancel AT ROW 1.48 COL 45
     btn_anular AT ROW 1.48 COL 66
     btn_observ AT ROW 1.48 COL 87
     btn_imprim AT ROW 1.48 COL 108
     Btn_salir AT ROW 1.48 COL 132
     btn_grabar AT ROW 1.52 COL 4
     T-Asn_header.tip_comprob AT ROW 3.86 COL 15 COLON-ALIGNED
          LABEL "Asiento"
          VIEW-AS FILL-IN 
          SIZE 7 BY 1
          BGCOLOR 7 FGCOLOR 15 
     T-Asn_header.prf_comprob AT ROW 3.86 COL 23 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 7 BY 1
          BGCOLOR 7 FGCOLOR 15 
     T-Asn_header.nro_comprob AT ROW 3.86 COL 31 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 17 BY 1
          BGCOLOR 7 FGCOLOR 15 
     T-Asn_header.nro_secuencia AT ROW 3.86 COL 49 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-libro AT ROW 3.86 COL 73 COLON-ALIGNED
     T-Asn_header.cambio_dolar AT ROW 3.86 COL 111 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-estado AT ROW 4.81 COL 130 COLON-ALIGNED NO-LABEL
     v-reexpresado AT ROW 5.05 COL 15 COLON-ALIGNED
     T-Asn_header.reexpresa_saldos AT ROW 5.05 COL 51
          LABEL "Asiento Multimoneda"
          VIEW-AS TOGGLE-BOX
          SIZE 24 BY .81
     T-Asn_header.fecha AT ROW 5.05 COL 86 COLON-ALIGNED FORMAT "99/99/9999"
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Asn_header.cambio AT ROW 5.05 COL 111 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Asn_header.leyenda AT ROW 6.24 COL 15 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 87 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_cuenta AT ROW 6.24 COL 111 COLON-ALIGNED
     T-Asn_header.cdg_sigla-sic AT ROW 7.43 COL 130 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Asn_header.origen AT ROW 7.43 COL 144 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     BRW-ACUMULADOS AT ROW 7.67 COL 5
     btn_difcambio AT ROW 8.86 COL 132
     btn_revertir AT ROW 10.76 COL 132
     btn_modelo AT ROW 12.19 COL 132
     btn_comprobante AT ROW 14.1 COL 132
     BRW-DETALLE AT ROW 16.24 COL 5
     T-Asn_detalle.leyen_detalle AT ROW 25.43 COL 3 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 146 BY 1
          BGCOLOR 15 FGCOLOR 9 
     "   Módulo Origen" VIEW-AS TEXT
          SIZE 20 BY 1 AT ROW 6.24 COL 132
          BGCOLOR 5 FGCOLOR 15 
     "         Estado" VIEW-AS TEXT
          SIZE 20 BY 1 AT ROW 3.62 COL 132
          BGCOLOR 5 FGCOLOR 15 
     RECT-2 AT ROW 1.29 COL 3
     RECT-3 AT ROW 1.24 COL 131
     RECT-4 AT ROW 3.38 COL 3
     RECT-5 AT ROW 3.38 COL 131
     RECT-6 AT ROW 16 COL 3
     RECT-7 AT ROW 10.52 COL 131
     RECT-8 AT ROW 8.62 COL 131
     RECT-9 AT ROW 6 COL 131
     RECT-10 AT ROW 13.86 COL 131
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 155.2 BY 27.67.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Asn_detalle T "NEW SHARED" NO-UNDO sic Asn_detalle
      TABLE: T-Asn_header T "NEW SHARED" NO-UNDO sic Asn_header
      TABLE: T-Asn_totales T "?" NO-UNDO sic Asn_totales
      TABLE: Total-moneda B "?" ? sic Moneda
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Asientos Contables"
         HEIGHT             = 27.67
         WIDTH              = 155.2
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
                                                                        */
/* BROWSE-TAB BRW-ACUMULADOS origen DEFAULT-FRAME */
/* BROWSE-TAB BRW-DETALLE btn_comprobante DEFAULT-FRAME */
ASSIGN 
       Total-moneda.descripcion:AUTO-RESIZE IN BROWSE BRW-ACUMULADOS = TRUE.

/* SETTINGS FOR BUTTON btn_anular IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_cancel IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_comprobante IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_copiar IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_difcambio IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_grabar IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_imprim IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_modelo IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_observ IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_revertir IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Asn_header.cambio_dolar IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Asn_header.cdg_sigla-sic IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN T-Asn_header.fecha IN FRAME DEFAULT-FRAME
   EXP-FORMAT                                                           */
/* SETTINGS FOR FILL-IN T-Asn_detalle.leyen_detalle IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Asn_header.nro_comprob IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Asn_header.nro_secuencia IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN T-Asn_header.origen IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Asn_header.prf_comprob IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR TOGGLE-BOX T-Asn_header.reexpresa_saldos IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN T-Asn_header.tip_comprob IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN v-cdg_cuenta IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-estado IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX v-libro IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX v-reexpresado IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BRW-ACUMULADOS
/* Query rebuild information for BROWSE BRW-ACUMULADOS
     _TblList          = "Temp-Tables.T-Asn_totales OF Temp-Tables.T-Asn_header,sic.Total-moneda OF Temp-Tables.T-Asn_header"
     _Options          = "NO-LOCK"
     _FldNameList[1]   > Temp-Tables.Total-moneda.abrevia
"Total-moneda.abrevia" "Identific!Moneda" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[2]   = Temp-Tables.T-Asn_totales.tot_debitos
     _FldNameList[3]   = Temp-Tables.T-Asn_totales.tot_creditos
     _FldNameList[4]   = Temp-Tables.T-Asn_totales.diferencia
     _FldNameList[5]   > Temp-Tables.Total-moneda.descripcion
"Total-moneda.descripcion" ? "X(35)" "character" ? ? ? ? ? ? no ? no no "57.2" yes yes no "U" "" ""
     _Query            is OPENED
*/  /* BROWSE BRW-ACUMULADOS */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BRW-DETALLE
/* Query rebuild information for BROWSE BRW-DETALLE
     _TblList          = "Temp-Tables.T-Asn_detalle OF Temp-Tables.T-Asn_header,sic.Cuenta OF Temp-Tables.T-Asn_detalle,sic.Moneda OF Temp-Tables.T-Asn_detalle,sic.Entidad OF Temp-Tables.T-Asn_detalle"
     _Options          = "NO-LOCK"
     _OrdList          = "Temp-Tables.T-Asn_detalle.nro_linea|yes"
     _FldNameList[1]   > Temp-Tables.T-Asn_detalle.nro_linea
"T-Asn_detalle.nro_linea" "N.Li!nea" ">>>9" "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[2]   = sic.Cuenta.cdg_cuenta
     _FldNameList[3]   > sic.Cuenta.nombre_cta
"Cuenta.nombre_cta" "Nombre!Cuenta" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[4]   = sic.Entidad.cdg_entidad
     _FldNameList[5]   > sic.Entidad.dsc_entidad
"Entidad.dsc_entidad" ? "X(20)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[6]   > sic.Moneda.abrevia
"Moneda.abrevia" "Identific!Moneda" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[7]   > Temp-Tables.T-Asn_detalle.cambio
"T-Asn_detalle.cambio" "Valor!Cotización" ">>>>9.9999" "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[8]   > "_<CALC>"
"IF (T-Asn_detalle.debito<>0) THEN (STRING(T-Asn_detalle.debito,""-ZZ,ZZZ,ZZ9.99"")) ELSE ("""")  @ v-debito" "Importe!Débito" "X(14)" ? ? ? 2 ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[9]   > "_<CALC>"
"IF (T-Asn_detalle.credito<>0) THEN (STRING(T-Asn_detalle.credito,""-ZZ,ZZZ,ZZ9.99"")) ELSE ("""")  @ v-credito" "Importe!Crédito" "X(14)" ? ? ? 2 ? ? ? no ? no no ? yes no no "U" "" ""
     _Query            is OPENED
*/  /* BROWSE BRW-DETALLE */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME DEFAULT-FRAME
/* Query rebuild information for FRAME DEFAULT-FRAME
     _TblList          = "Temp-Tables.T-Asn_header"
     _Query            is OPENED
*/  /* FRAME DEFAULT-FRAME */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Asientos Contables */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Asientos Contables */
DO:
  /* This event will close the window and terminate the procedure.*/
  APPLY "CHOOSE":U TO btn_salir IN FRAME {&FRAME-NAME}.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BRW-ACUMULADOS
&Scoped-define SELF-NAME BRW-ACUMULADOS
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BRW-ACUMULADOS C-Win
ON VALUE-CHANGED OF BRW-ACUMULADOS IN FRAME DEFAULT-FRAME /* Totales por Moneda */
DO:
  IF AVAILABLE T-Asn_totales AND v-reexpresado
  THEN DO:
      RUN abre_query_detalle.
    /*APPLY "VALUE-CHANGED" TO v-reexpresado IN FRAME {&FRAME-NAME}.*/
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BRW-DETALLE
&Scoped-define SELF-NAME BRW-DETALLE
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BRW-DETALLE C-Win
ON DELETE-CHARACTER OF BRW-DETALLE IN FRAME DEFAULT-FRAME /* Pases del Asiento Actual */
DO:
    IF modo = MD_ALTA
    THEN DO:
        sino-msg = NO.
        MESSAGE "Desea eliminar este renglón de detalle?" 
                VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
        IF sino-msg
        THEN DO:
             DELETE T-Asn_detalle.
             RUN abre_query_detalle.
             RUN calculos.
        END.
    END.
    ELSE DO:
        BELL.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BRW-DETALLE C-Win
ON MOUSE-SELECT-DBLCLICK OF BRW-DETALLE IN FRAME DEFAULT-FRAME /* Pases del Asiento Actual */
OR RETURN OF {&BROWSE-NAME} IN FRAME {&FRAME-NAME}
DO:
    RUN corregir_detalle.
    RUN abre_query_detalle.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BRW-DETALLE C-Win
ON VALUE-CHANGED OF BRW-DETALLE IN FRAME DEFAULT-FRAME /* Pases del Asiento Actual */
DO:
  DISPLAY T-Asn_detalle.leyen_detalle WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_anular
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_anular C-Win
ON CHOOSE OF btn_anular IN FRAME DEFAULT-FRAME /* Anular */
DO:

    DEFINE VARIABLE pudo_anular AS INTEGER.
    sino-msg = NO.
    MESSAGE "Desea ANULAR este asiento contable" 
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
    IF sino-msg
    THEN DO:
         RUN anular_asiento.p (INPUT ROWID(Asn_header), OUTPUT pudo_anular).
         IF pudo_anular = 0
         THEN DO:
              RUN borrar_tablas_temporales.
              MESSAGE "El Asiento Actual ha sido anulado" 
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
    
        FOR EACH T-Asn_totales:
            DELETE T-Asn_totales.
        END.

        FOR EACH T-Asn_detalle:
            DELETE T-Asn_detalle.
        END.

        FIND FIRST T-Asn_header.
        DELETE T-Asn_header.

        ASSIGN codigo_salir = CD_CANCELAR.
        APPLY "U1" TO THIS-PROCEDURE.

    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_comprobante
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_comprobante C-Win
ON CHOOSE OF btn_comprobante IN FRAME DEFAULT-FRAME /* Ver Comprobante */
DO:
    DEFINE VARIABLE rid_registro AS ROWID.

    CASE T-Asn_header.tabla_comprobante:
        WHEN "Fac_header" 
        THEN DO:
            FIND Fac_header WHERE Fac_header.nro_factura = T-Asn_header.nro_idcabecera NO-LOCK.
            rid_registro = ROWID(Fac_header).
            RUN c-comprobante_cliente.w ( INPUT-OUTPUT rid_registro , INPUT 2, INPUT Fac_header.cdg_comprobante ).
        END.
        WHEN "Fac_header_prv" 
        THEN DO:
            FIND Fac_header_prv WHERE Fac_header_prv.nro_facprov = T-Asn_header.nro_idcabecera NO-LOCK.
            rid_registro = ROWID(Fac_header_prv).
            RUN c-comprobante_proveedor.w ( INPUT-OUTPUT rid_registro , INPUT 2, INPUT Fac_header_prv.cdg_comprobante ).
        END.
        WHEN "Rem_header" 
        THEN DO:
            FIND Rem_header WHERE Rem_header.nro_remito = T-Asn_header.nro_idcabecera NO-LOCK.
            rid_registro = ROWID(Rem_header).
            RUN c-comprobante_despacho.w ( INPUT-OUTPUT rid_registro , INPUT 2, INPUT Rem_header.cdg_comprobante ).
        END.

        WHEN "Caj_header" 
        THEN DO:
            FIND Rec_header WHERE Rec_header.nro_transaccion = T-Asn_header.nro_idcabecera NO-LOCK NO-ERROR.
            IF AVAILABLE Rec_header
            THEN DO:
                rid_registro = ROWID(Rec_header).
                RUN c-recibo_de_pago.w ( INPUT-OUTPUT rid_registro , INPUT 2 ).
            END.
            ELSE DO:
                FIND Opg_header WHERE Opg_header.nro_ordpago = T-Asn_header.nro_idcabecera NO-LOCK NO-ERROR.
                IF AVAILABLE Opg_header
                THEN DO:
                    rid_registro = ROWID(Opg_header).
                    RUN c-orden_de_pago.w ( INPUT-OUTPUT rid_registro , INPUT 2 ).
                END.
                ELSE DO:
                    rid_registro = ROWID(Caj_header).
                    RUN c-movimiento_tesoreria.w ( INPUT-OUTPUT rid_registro , INPUT 2).
                END.
            END.
        END.
    END CASE.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_copiar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_copiar C-Win
ON CHOOSE OF btn_copiar IN FRAME DEFAULT-FRAME /* Copiar */
DO:

  RUN d-seleccionar_asiento.w (INPUT-OUTPUT rid_asiento).
  IF rid_asiento <> ?
  THEN DO:
     FIND Asn_header WHERE ROWID(Asn_header) = rid_asiento NO-LOCK.
     DISPLAY Asn_header.tip_comprob @ T-Asn_header.tip_comprob 
             Asn_header.nro_comprob @ T-Asn_header.nro_comprob
             WITH FRAME {&FRAME-NAME}.
     RUN traer_documento.
     btn_copiar:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
     btn_modelo:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
  END.  
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_difcambio
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_difcambio C-Win
ON CHOOSE OF btn_difcambio IN FRAME DEFAULT-FRAME /* Diferencia Cambio */
DO:
  RUN compensar_diferencias.
  btn_difcambio:SENSITIVE IN FRAME {&FRAME-NAME} = NO.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_grabar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_grabar C-Win
ON CHOOSE OF btn_grabar IN FRAME DEFAULT-FRAME /* Grabar */
DO:

  ASSIGN FRAME {&FRAME-NAME}
         T-Asn_header.fecha 
         T-Asn_header.leyenda.
         
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
    MESSAGE "Desea REIMPRIMIR este asiento?" 
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
    IF sino-msg
    THEN DO:
         RUN imprimir_asiento.p (ROWID(Asn_header),
                                 INPUT v-reexpresado,
                                 INPUT Total-moneda.nro_moneda ).
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_modelo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_modelo C-Win
ON CHOOSE OF btn_modelo IN FRAME DEFAULT-FRAME /* Modelo */
DO:

  RUN d-elegir_modelo.w ( INPUT-OUTPUT rid_modelo, OUTPUT v-total_debitos).

  IF rid_modelo <> ?
  THEN DO:
       RUN copiar_modelo.
       RUN calculos.
       btn_copiar:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
       btn_modelo:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
       
  END.  

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_observ
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_observ C-Win
ON CHOOSE OF btn_observ IN FRAME DEFAULT-FRAME /* Observación */
DO:

   DEFINE VARIABLE puso_ok AS LOGICAL.
   RUN c-edttexto.w ( INPUT-OUTPUT T-Asn_header.observacion,
                      INPUT "Observaciones del Asiento Actual",
                      INPUT modo,
                      OUTPUT puso_ok).
   RETURN NO-APPLY.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_revertir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_revertir C-Win
ON CHOOSE OF btn_revertir IN FRAME DEFAULT-FRAME /* Revertir */
DO:
  RUN revertir_asiento.
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


&Scoped-define SELF-NAME T-Asn_header.cambio
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Asn_header.cambio C-Win
ON LEAVE OF T-Asn_header.cambio IN FRAME DEFAULT-FRAME /* Cambio */
DO:
    ASSIGN FRAME {&FRAME-NAME} T-Asn_header.cambio.
    RUN modificar_cambio.
    RUN abre_query_detalle.
    APPLY "VALUE-CHANGED" TO {&BROWSE-NAME} IN FRAME {&FRAME-NAME}.
    RUN calculos.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Asn_header.cambio_dolar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Asn_header.cambio_dolar C-Win
ON LEAVE OF T-Asn_header.cambio_dolar IN FRAME DEFAULT-FRAME /* Dólar */
DO:
    ASSIGN FRAME {&FRAME-NAME} T-Asn_header.cambio_dolar.
    RUN modificar_cambio.
    RUN abre_query_detalle.
    APPLY "VALUE-CHANGED" TO {&BROWSE-NAME} IN FRAME {&FRAME-NAME}.
    RUN calculos.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Asn_header.fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Asn_header.fecha C-Win
ON LEAVE OF T-Asn_header.fecha IN FRAME DEFAULT-FRAME /* Fecha */
DO:
   ASSIGN FRAME {&FRAME-NAME} T-Asn_header.fecha.
/*
   IF INPUT FRAME {&FRAME-NAME} T-Asn_header.fecha <> T-Asn_header.fecha
   THEN DO:
        ASSIGN FRAME {&FRAME-NAME} T-Asn_header.fecha.
        RUN poner_cambio.
        RUN poner_dolar.
        RUN refrescar_cotizaciones.
   END.
*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Asn_header.leyenda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Asn_header.leyenda C-Win
ON LEAVE OF T-Asn_header.leyenda IN FRAME DEFAULT-FRAME /* Leyenda */
DO:
   ASSIGN FRAME {&FRAME-NAME} T-Asn_header.leyenda.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Asn_header.nro_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Asn_header.nro_comprob C-Win
ON MOUSE-SELECT-DBLCLICK OF T-Asn_header.nro_comprob IN FRAME DEFAULT-FRAME /* nro_comprob */
OR MOUSE-MENU-DOWN,"." OF T-Asn_header.nro_comprob IN FRAME {&FRAME-NAME}
DO:

  RUN d-seleccionar_asiento.w (INPUT-OUTPUT rid_asiento).
  IF rid_asiento <> ?
  THEN DO:
     FIND Asn_header WHERE ROWID(Asn_header) = rid_asiento NO-LOCK.
     DISPLAY Asn_header.tip_comprob @ T-Asn_header.tip_comprob 
             Asn_header.prf_comprob @ T-Asn_header.prf_comprob
             Asn_header.nro_comprob @ T-Asn_header.nro_comprob
             WITH FRAME {&FRAME-NAME}.
     
     RUN traer_documento.
  END.  
  RETURN NO-APPLY.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Asn_header.nro_comprob C-Win
ON RETURN OF T-Asn_header.nro_comprob IN FRAME DEFAULT-FRAME /* nro_comprob */
DO:
   IF INPUT FRAME {&FRAME-NAME} T-Asn_header.tip_comprob <> "AS" 
   THEN DO:
      RUN PONMENSJ.P (INPUT "DOCS010").
      RETURN NO-APPLY.
   END.

   FIND Asn_header 
        WHERE Asn_header.cdg_empresa = Empresa.cdg_empresa
          AND Asn_header.tip_comprob = INPUT T-Asn_header.tip_comprob 
          AND Asn_header.prf_comprob = INPUT T-Asn_header.prf_comprob
          AND Asn_header.nro_comprob = INPUT T-Asn_header.nro_comprob
              NO-ERROR.

   IF NOT AVAILABLE Asn_header 
   THEN DO:
        IF LOCKED Asn_header
           THEN RUN PONMENSJ.P (INPUT "DOCS000").
           ELSE RUN PONMENSJ.P (INPUT "DOCS001").
        RETURN NO-APPLY.
   END.
   ELSE DO:
        rid_asiento = ROWID(Asn_header).
        RUN traer_documento.
   END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Asn_header.reexpresa_saldos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Asn_header.reexpresa_saldos C-Win
ON VALUE-CHANGED OF T-Asn_header.reexpresa_saldos IN FRAME DEFAULT-FRAME /* Asiento Multimoneda */
DO:
  v-reexpresado = INPUT T-Asn_header.reexpresa_saldos.
  v-reexpresado:SENSITIVE IN FRAME {&FRAME-NAME} = v-reexpresado.
  DISPLAY v-reexpresado
      WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Asn_header.tip_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Asn_header.tip_comprob C-Win
ON LEAVE OF T-Asn_header.tip_comprob IN FRAME DEFAULT-FRAME /* Asiento */
OR MOUSE-MENU-DOWN,"." OF T-Asn_header.tip_comprob IN FRAME {&FRAME-NAME}
DO:
  APPLY "MOUSE-SELECT-DBLCLICK" TO T-Asn_header.tip_comprob IN FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_cuenta
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
      RUN PONMENSJ.P (INPUT "ASIE028").
      RETURN NO-APPLY.
   END.

   IF NOT CAN-FIND(FIRST Libro-cuenta OF Cuenta WHERE Libro-cuenta.cdg_librocontable = T-Asn_header.cdg_librocontable)
   THEN DO:
      RUN PONMENSJ.P (INPUT "ASIE029").
      RETURN NO-APPLY.
   END.

   IF Cuenta.esta_restringida
   THEN DO:
      FIND Usuario WHERE Usuario.cdg_usuario = USERID("sic") NO-LOCK.
      IF NOT CAN-FIND(FIRST Cuenta-usuarios OF Cuenta WHERE Cuenta-usuarios.cdg_grupousr = Usuario.cdg_grupousr)
      THEN DO:
           RUN PONMENSJ.P (INPUT "ASIE030").
           RETURN NO-APPLY.
      END.
   END.

   RUN crear_detalle.
   
   DISPLAY " " @ v-cdg_cuenta
           WITH FRAME {&FRAME-NAME}.
   APPLY "ENTRY" TO v-cdg_cuenta  IN FRAME {&FRAME-NAME}.
   RETURN NO-APPLY.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-libro
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-libro C-Win
ON VALUE-CHANGED OF v-libro IN FRAME DEFAULT-FRAME /* Libro */
DO:
    ASSIGN v-libro.
    RUN poner_libro.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-reexpresado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-reexpresado C-Win
ON VALUE-CHANGED OF v-reexpresado IN FRAME DEFAULT-FRAME /* Expresión */
DO:
    ASSIGN v-reexpresado.
    RUN poner_moneda.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BRW-ACUMULADOS
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
  RUN frame_sensitiva ( INPUT YES ).
  WAIT-FOR U1,U2 OF THIS-PROCEDURE.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE abre_query_acumulados C-Win 
PROCEDURE abre_query_acumulados :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    OPEN QUERY BRW-ACUMULADOS
        FOR EACH T-Asn_totales WHERE T-Asn_totales.reexpresion = v-reexpresado, 
            FIRST Total-moneda OF T-Asn_totales
                  BY Total-moneda.cdg_moneda.

    IF v-reexpresado
    THEN DO:
      BRW-ACUMULADOS:TITLE IN FRAME {&FRAME-NAME} = "Totales REEXPRESADOS del asiento".                        
        
    END.
    ELSE DO:
      BRW-ACUMULADOS:TITLE IN FRAME {&FRAME-NAME} = "Totales del asiento en MONEDA DE ORIGEN".                        
    END.     

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE abre_query_detalle C-Win 
PROCEDURE abre_query_detalle :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  IF v-reexpresado
  THEN DO:
      OPEN QUERY BRW-DETALLE
          FOR EACH T-Asn_detalle OF T-Asn_header NO-LOCK 
             WHERE T-Asn_detalle.reexpresion
               AND T-Asn_detalle.nro_moneda =  Total-moneda.nro_moneda,
                  FIRST Cuenta OF T-Asn_detalle NO-LOCK,
                  FIRST Moneda OF T-Asn_detalle NO-LOCK,
                  FIRST Entidad OF T-Asn_detalle NO-LOCK
                        BY T-Asn_detalle.nro_linea.

      BRW-DETALLE:TITLE IN FRAME {&FRAME-NAME} = "Pases del asiento reexpresados en " + Total-moneda.descripcion.        

  END.
  ELSE DO:
      OPEN QUERY BRW-DETALLE
          FOR EACH T-Asn_detalle OF T-Asn_header NO-LOCK 
             WHERE NOT T-Asn_detalle.reexpresion,
                FIRST Cuenta OF T-Asn_detalle NO-LOCK,
                FIRST Moneda OF T-Asn_detalle NO-LOCK,
                FIRST Entidad OF T-Asn_detalle NO-LOCK
                      BY T-Asn_detalle.nro_linea.

      BRW-DETALLE:TITLE IN FRAME {&FRAME-NAME} = "Pases del asiento en MONEDA DE ORIGEN".

  END.     

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE acumular_monedas C-Win 
PROCEDURE acumular_monedas :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    EMPTY TEMP-TABLE T-Asn_totales.

    FOR EACH T-Asn_detalle OF T-Asn_header:
        
        FIND T-Asn_totales 
             WHERE T-Asn_totales.nro_moneda  = T-Asn_detalle.nro_moneda 
               AND T-Asn_totales.reexpresion = T-Asn_detalle.reexpresion
                   NO-ERROR.

        IF NOT AVAILABLE T-Asn_totales
        THEN DO:
             CREATE T-Asn_totales.
             ASSIGN T-Asn_totales.nro_moneda  = T-Asn_detalle.nro_moneda
                    T-Asn_totales.reexpresion = T-Asn_detalle.reexpresion.
        END.
    
        T-Asn_totales.tot_debitos  = T-Asn_totales.tot_debitos  + T-Asn_detalle.debito.
        T-Asn_totales.tot_creditos = T-Asn_totales.tot_creditos + T-Asn_detalle.credito.
    
    END.       
    
    FOR EACH T-Asn_totales:
        T-Asn_totales.diferencia = T-Asn_totales.tot_debitos - T-Asn_totales.tot_creditos.
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

    EMPTY TEMP-TABLE T-Asn_header  NO-ERROR.
    EMPTY TEMP-TABLE T-Asn_detalle NO-ERROR.
    EMPTY TEMP-TABLE T-Asn_totales NO-ERROR.

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

  /*
  {calcularasiento.i "T-"}
  */

  RUN acumular_monedas.
  RUN abre_query_acumulados.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE compensar_diferencias C-Win 
PROCEDURE compensar_diferencias :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND FIRST Entidad WHERE Entidad.cdg_entidad = T-Asn_header.cdg_empresa NO-LOCK.

    FOR EACH T-Asn_totales WHERE T-Asn_totales.reexpresion AND T-Asn_totales.diferencia <> 0:
               
        FIND FIRST Imputacion_difcambio 
            WHERE Imputacion_difcambio.nro_moneda = T-Asn_totales.nro_moneda
              AND Imputacion_difcambio.cdg_empresa =  T-Asn_header.cdg_empresa 
                  NO-LOCK.

        CREATE T-Asn_detalle.
        ASSIGN T-Asn_header.ultima_linea     = T-Asn_header.ultima_linea + 1
               T-Asn_detalle.nro_asiento     = T-Asn_header.nro_asiento
               T-Asn_detalle.nro_linea       = T-Asn_header.ultima_linea
               T-Asn_detalle.cdg_empresa     = T-Asn_header.cdg_empresa
               T-Asn_detalle.fecha_mayor     = T-Asn_header.fecha
               T-Asn_detalle.reexpresion     = YES
               T-Asn_detalle.nro_cuenta      = Imputacion_difcambio.nro_cuenta
               T-Asn_detalle.nro_moneda      = T-Asn_totales.nro_moneda.
               T-Asn_detalle.nro_entidad     = Entidad.nro_entidad.

        IF T-Asn_totales.diferencia > 0
            THEN ASSIGN T-Asn_detalle.debito  = 0
                        T-Asn_detalle.credito = T-Asn_totales.diferencia.
            ELSE ASSIGN T-Asn_detalle.debito  = T-Asn_totales.diferencia * ( - 1 )
                        T-Asn_detalle.credito = 0.

    END.

    RUN calculos.
    APPLY "VALUE-CHANGED" TO BRW-ACUMULADOS IN FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE copiar_modelo C-Win 
PROCEDURE copiar_modelo :
/*------------------------------------------------------------------------------
  Purpose: COPIA UN ASIENTO EN BASE A UN MODELO DADO    
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    /*=================================================================================*/
    /*                                    VARIABLES                                    */
    /*=================================================================================*/
    
    DEFINE VARIABLE factor                AS DECIMAL.
    DEFINE VARIABLE factor_can            AS DECIMAL.
    DEFINE VARIABLE act_detalle           AS ROWID.
    
    DEFINE VARIABLE sal_debito            LIKE Asn_totales.tot_creditos.
    DEFINE VARIABLE sal_debito_can        LIKE Asn_totales.tot_creditos.
    
    DEFINE VARIABLE sal_credito           LIKE Asn_totales.tot_creditos.
    DEFINE VARIABLE sal_credito_can       LIKE Asn_totales.tot_creditos.

    DEFINE VARIABLE x-fecha_cotizacion    AS DATE.
    
    /*=================================================================================*/
    /*                                      PROCESO                                    */
    /*=================================================================================*/
    
    FIND Amd_header WHERE ROWID(Amd_header) = rid_modelo NO-LOCK.
    
    ASSIGN T-Asn_header.estado              = ""
           T-Asn_header.leyenda             = Amd_header.leyenda 
           T-Asn_header.origen              = "M"
           T-Asn_header.ultima_linea        = 0.
    
    IF Amd_header.modo_importes = "P" 
    THEN DO:
    
        ASSIGN factor            = IF Amd_header.tot_debitos <> 0 
                                    THEN v-total_debitos / Amd_header.tot_debitos
                                    ELSE 0
               sal_debito        = v-total_debitos
               sal_credito       = v-total_debitos.
         
    END.
    
    FOR EACH Amd_detalle OF Amd_header NO-LOCK, Moneda OF Amd_detalle BREAK BY Amd_detalle.nro_modelo:
            
        CREATE T-Asn_detalle.
        ASSIGN T-Asn_header.ultima_linea     = T-Asn_header.ultima_linea + 1.
        ASSIGN T-Asn_detalle.nro_asiento     = T-Asn_header.nro_asiento
               T-Asn_detalle.fecha_mayor     = T-Asn_header.fecha                
               T-Asn_detalle.nro_linea       = T-Asn_header.ultima_linea.
        
        ASSIGN T-Asn_detalle.leyen_detalle   = Amd_detalle.leyen_detalle
               T-Asn_detalle.nro_cuenta      = Amd_detalle.nro_cuenta
               T-Asn_detalle.nro_entidad     = Amd_detalle.nro_entidad
               T-Asn_detalle.nro_obra        = Amd_detalle.nro_obra
               T-Asn_detalle.nro_moneda      = Amd_detalle.nro_moneda
               T-Asn_detalle.valor_unitario  = 0 /*Amd_detalle.valor_unitario*/
               T-Asn_detalle.unidades        = NO.

        RUN cotizar_moneda.p ( INPUT Moneda.cdg_moneda,  
                               INPUT T-Asn_header.cdg_empresa,
                               INPUT T-Asn_header.fecha,
                               OUTPUT T-Asn_detalle.cambio,
                               OUTPUT x-fecha_cotizacion ).
        
        CASE Amd_header.modo_importes:
        
            WHEN "L" 
            THEN DO:
                 /*
                RUN d-detalle_asiento.w (INPUT T-Asn_detalle.nro_linea, INPUT 1).
                 */
            END.
            
            WHEN "P" 
            THEN DO:
                IF NOT LAST-OF(Amd_detalle.nro_modelo)
                THEN DO:
            
                   ASSIGN 
                      T-Asn_detalle.credito      = ROUND(Amd_detalle.credito * factor,2)
                      T-Asn_detalle.debito       = ROUND(Amd_detalle.debito * factor,2)
                      sal_credito                = sal_credito - T-Asn_detalle.credito
                      sal_debito                 = sal_debito  - T-Asn_detalle.debito.
                      
                END.              
                ELSE DO:
                   ASSIGN 
                      T-Asn_detalle.credito = sal_credito
                      T-Asn_detalle.debito  = sal_debito.
                END.
            END.
            
            WHEN "F" 
            THEN DO:
                ASSIGN T-Asn_detalle.credito      = Amd_detalle.credito
                       T-Asn_detalle.credito_can  = Amd_detalle.credito_can
                       T-Asn_detalle.debito       = Amd_detalle.debito
                       T-Asn_detalle.debito_can   = Amd_detalle.debito_can.
            END.
        
        END CASE.
        
        RUN reexpresar_movimiento ( INPUT T-Asn_detalle.nro_linea ).
        
    END. /* De los detalles de ASIENTO MODELO */

    RUN calculos.

    RUN abre_query_detalle.

    APPLY "VALUE-CHANGED" TO BRW-DETALLE IN FRAME {&FRAME-NAME}.
    T-Asn_header.reexpresa_saldos:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
    btn_copiar:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
    btn_modelo:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
    btn_difcambio:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
    v-libro:SENSITIVE    IN FRAME {&FRAME-NAME} = NO.
    T-Asn_header.fecha:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
    DISPLAY T-Asn_header.leyenda
        WITH FRAME {&FRAME-NAME}.

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

    DEFINE VARIABLE x-nro_linea    LIKE   T-Asn_detalle.nro_linea.  
    DEFINE VARIABLE x-nro_moneda   LIKE   T-Asn_detalle.nro_moneda. 
    DEFINE VARIABLE x-reexpresion  LIKE   T-Asn_detalle.reexpresion.


    ASSIGN x-nro_linea    =   T-Asn_detalle.nro_linea  
           x-nro_moneda   =   T-Asn_detalle.nro_moneda 
           x-reexpresion  =   T-Asn_detalle.reexpresion.
    
    RUN d-detalle_asiento.w ( INPUT T-Asn_header.nro_moneda,
                              INPUT T-Asn_detalle.nro_cuenta,
                              INPUT T-Asn_detalle.nro_linea,
                              INPUT T-Asn_detalle.nro_moneda,
                              INPUT T-Asn_detalle.reexpresion,
                              INPUT modo,
                              INPUT 1,
                              OUTPUT v-nro_linea,
                              INPUT-OUTPUT TABLE T-Asn_header,
                              INPUT-OUTPUT TABLE T-Asn_detalle
                              ).

    FIND FIRST T-Asn_header.
    FIND T-Asn_detalle 
        WHERE x-nro_linea    =   T-Asn_detalle.nro_linea  
          AND x-nro_moneda   =   T-Asn_detalle.nro_moneda 
          AND x-reexpresion  =   T-Asn_detalle.reexpresion.
    
    IF modo = MD_ALTA
    THEN DO:
  
        IF v-nro_linea <> 0
        THEN DO:
             IF NOT T-Asn_detalle.reexpresion 
                THEN RUN reexpresar_movimiento ( INPUT v-nro_linea ).
             RUN calculos.
             RUN abre_query_detalle.
             APPLY "VALUE-CHANGED" TO BRW-DETALLE IN FRAME {&FRAME-NAME}.
        END.

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

    RUN d-detalle_asiento.w ( INPUT T-Asn_header.nro_moneda,
                              INPUT  Cuenta.nro_cuenta,
                              INPUT  0, /* No sabemos el nro de linea */
                              INPUT  0, /* No sabemos la moneda       */
                              INPUT  NO, /* No es una reexpresion */
                              INPUT  modo,
                              INPUT  0, /* modo detalle = CREAR */
                              OUTPUT v-nro_linea,
                              INPUT-OUTPUT TABLE T-Asn_header,
                              INPUT-OUTPUT TABLE T-Asn_detalle                              
                              ).

    FIND FIRST T-Asn_header.

    IF v-nro_linea <> 0
    THEN DO:

         RUN reexpresar_movimiento ( INPUT v-nro_linea ).
         RUN calculos.
         RUN abre_query_acumulados.
         RUN abre_query_detalle.
         APPLY "VALUE-CHANGED" TO BRW-DETALLE IN FRAME {&FRAME-NAME}.
         T-Asn_header.reexpresa_saldos:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
         btn_copiar:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
         btn_modelo:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
         btn_difcambio:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
         v-libro:SENSITIVE    IN FRAME {&FRAME-NAME} = NO.
         T-Asn_header.fecha:SENSITIVE IN FRAME {&FRAME-NAME} = NO.

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

  RUN getparametro_c.p ( INPUT "MDCOTIZA", OUTPUT v-modo_cotiza ).

  DO TRANSACTION:

      CREATE T-Asn_header.
      ASSIGN T-Asn_header.nro_usuario       = Usuario.nro_usuario 
             T-Asn_header.fecha             = TODAY 
             T-Asn_header.cdg_empresa       = Empresa.cdg_empresa 
             T-Asn_header.tip_comprob       = "TAS" 
             T-Asn_header.nro_asiento       = 0  
             T-Asn_header.nro_comprob       = T-Asn_header.nro_asiento
             T-Asn_header.cdg_sigla-sic     = "GLA" 
             T-Asn_header.origen            = "M"
             T-Asn_header.reexpresa_saldos  = YES
             T-Asn_header.tabla_comprobante = "Asn_header"
             T-Asn_header.nro_idcabecera    = T-Asn_header.nro_asiento
             T-Asn_header.cdg_estadoasiento = "I"
             T-Asn_header.nro_moneda        = ?.
    
  END.

  v-reexpresado = YES.

  DISPLAY
         T-Asn_header.fecha   
         T-Asn_header.origen 
         T-Asn_header.cdg_sigla-sic
         T-Asn_header.reexpresa_saldos
         v-reexpresado   
         v-libro 
         WITH FRAME {&FRAME-NAME}.

  RUN poner_moneda.
  RUN poner_libro.
  RUN poner_dolar.
  RUN poner_estado.

  codigo_salir = ?.

  IF    modo = MD_MULTIPLE
     OR modo = MD_ANULACION
     OR modo = MD_EMISION
  THEN DO:
       DO WITH FRAME {&FRAME-NAME}:
          T-Asn_header.tip_comprob:FGCOLOR = 9.
          T-Asn_header.tip_comprob:BGCOLOR = 15.

          T-Asn_header.nro_comprob:FGCOLOR = 9.
          T-Asn_header.nro_comprob:BGCOLOR = 15.

          T-Asn_header.prf_comprob:FGCOLOR = 9.
          T-Asn_header.prf_comprob:BGCOLOR = 15.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE duplicar_asiento C-Win 
PROCEDURE duplicar_asiento :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
/*=================================================================================*/
/*           GENERA UN NUEVO ASIENTO EN BASE A UN ASIENTO MODELO DADO              */
/*=================================================================================*/

DEFINE INPUT PARAMETER total          AS DECIMAL.
DEFINE INPUT PARAMETER total_div      AS DECIMAL.
DEFINE INPUT PARAMETER total_can      AS DECIMAL.

/*=================================================================================*/
/*                                    VARIABLES                                    */
/*=================================================================================*/

DEFINE VARIABLE factor                AS DECIMAL.
DEFINE VARIABLE factor_can            AS DECIMAL.
DEFINE VARIABLE factor_div            AS DECIMAL.
DEFINE VARIABLE act_detalle           AS ROWID.

DEFINE VARIABLE sal_debito            LIKE Asn_header.tot_creditos.
DEFINE VARIABLE sal_debito_can        LIKE Asn_header.tot_creditos.
DEFINE VARIABLE sal_debito_div        LIKE Asn_header.tot_creditos.

DEFINE VARIABLE sal_credito           LIKE Asn_header.tot_creditos.
DEFINE VARIABLE sal_credito_can       LIKE Asn_header.tot_creditos.
DEFINE VARIABLE sal_credito_div       LIKE Asn_header.tot_creditos.

/*=================================================================================*/
/*                                      PROCESO                                    */
/*=================================================================================*/

DO TRANSACTION:

     ASSIGN 
          T-Asn_header.estado              = ""
          T-Asn_header.leyenda             = Amd_header.leyenda 
          T-Asn_header.origen              = "M"
          T-Asn_header.ultima_linea        = 0.
     
     IF Amd_header.modo_importes = "P" 
     THEN DO:
     
          ASSIGN factor            = IF Amd_header.tot_debitos <> 0 
                                        THEN total / Amd_header.tot_debitos
                                        ELSE 0
                 factor_div        = IF Amd_header.tot_debitos_div <> 0 
                                        THEN total_div / Amd_header.tot_debitos_div
                                        ELSE 0
                 sal_debito        = total
                 sal_credito       = total
                 sal_debito_div    = total_div
                 sal_credito_div   = total_div.
                 
     END.

     FOR EACH Amd_detalle OF Amd_header NO-LOCK BREAK BY Amd_detalle.nro_modelo :
     
         CREATE T-Asn_detalle.
         ASSIGN T-Asn_header.ultima_linea     = T-Asn_header.ultima_linea + 1.
         ASSIGN T-Asn_detalle.nro_asiento     = T-Asn_header.nro_asiento
                T-Asn_detalle.fecha_mayor     = T-Asn_header.fecha                
                T-Asn_detalle.nro_linea       = T-Asn_header.ultima_linea.

         ASSIGN T-Asn_detalle.bimonetario     = Amd_detalle.bimonetario
                T-Asn_detalle.cambio          = Amd_detalle.cambio
                T-Asn_detalle.leyen_detalle   = Amd_detalle.leyen_detalle
                T-Asn_detalle.nro_cuenta      = Amd_detalle.nro_cuenta
                T-Asn_detalle.nro_entidad     = Amd_detalle.nro_entidad
                T-Asn_detalle.nro_obra        = Amd_detalle.nro_obra
                T-Asn_detalle.valor_unitario  = Amd_detalle.valor_unitario.

         CASE Amd_header.modo_importes:

            WHEN "L" 
            THEN DO:
                 /*
                RUN d-detalle_asiento.w (INPUT T-Asn_detalle.nro_linea, INPUT 1).
                 */
            END.
      
            WHEN "P" 
            THEN DO:
                IF NOT LAST-OF(Amd_detalle.nro_modelo)
                THEN DO:
 
                   ASSIGN 
                      T-Asn_detalle.credito      = ROUND(Amd_detalle.credito * factor,2)
                      T-Asn_detalle.credito_div  = ROUND(Amd_detalle.credito_div * factor_div,2)
                      T-Asn_detalle.debito       = ROUND(Amd_detalle.debito * factor,2)
                      T-Asn_detalle.debito_div   = ROUND(Amd_detalle.debito_div * factor_div,2).
 
                   ASSIGN 
                      sal_credito     = sal_credito     - T-Asn_detalle.credito
                      sal_credito_div = sal_credito_div - T-Asn_detalle.credito_div
                      sal_debito      = sal_debito      - T-Asn_detalle.debito
                      sal_debito_div  = sal_debito_div  - T-Asn_detalle.debito_div.
                      
                END.              
                ELSE DO:
                   ASSIGN 
                      T-Asn_detalle.credito          = sal_credito
                      T-Asn_detalle.credito_div      = sal_credito_div
                      T-Asn_detalle.debito           = sal_debito
                      T-Asn_detalle.debito_div       = sal_debito_div.
                   ASSIGN
                      T-Asn_header.tot_debitos       = total   
                      T-Asn_header.tot_creditos      = total
                      T-Asn_header.tot_debitos_div   = total_div   
                      T-Asn_header.tot_creditos_div  = total_div.
                END.
            END.
      
            WHEN "F" 
            THEN DO:
                ASSIGN T-Asn_detalle.credito      = Amd_detalle.credito
                       T-Asn_detalle.credito_can  = Amd_detalle.credito_can
                       T-Asn_detalle.credito_div  = Amd_detalle.credito_div
                       T-Asn_detalle.debito       = Amd_detalle.debito
                       T-Asn_detalle.debito_can   = Amd_detalle.debito_can
                       T-Asn_detalle.debito_div   = Amd_detalle.debito_div.
            END.

         END CASE.


     END. /* De los detalles de ASIENTO MODELO */

END.
*/
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
  DISPLAY v-libro v-estado v-reexpresado v-cdg_cuenta 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE T-Asn_detalle THEN 
    DISPLAY T-Asn_detalle.leyen_detalle 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE T-Asn_header THEN 
    DISPLAY T-Asn_header.tip_comprob T-Asn_header.prf_comprob 
          T-Asn_header.nro_comprob T-Asn_header.nro_secuencia 
          T-Asn_header.cambio_dolar T-Asn_header.reexpresa_saldos 
          T-Asn_header.fecha T-Asn_header.cambio T-Asn_header.leyenda 
          T-Asn_header.cdg_sigla-sic T-Asn_header.origen 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE RECT-2 RECT-3 RECT-4 RECT-5 RECT-6 RECT-7 RECT-8 RECT-9 RECT-10 
         Btn_salir T-Asn_header.fecha T-Asn_header.cambio T-Asn_header.leyenda 
         BRW-ACUMULADOS BRW-DETALLE 
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
                btn_grabar:SENSITIVE                  = NO
                btn_copiar:SENSITIVE                  = NO
                btn_cancel:SENSITIVE                  = NO
                btn_anular:SENSITIVE                  = NO
                btn_observ:SENSITIVE                  = NO
                btn_imprim:SENSITIVE                  = NO
                T-Asn_header.tip_comprob:SENSITIVE    = NO
                T-Asn_header.prf_comprob:SENSITIVE    = NO
                T-Asn_header.nro_comprob:SENSITIVE    = NO
                T-Asn_header.fecha:SENSITIVE          = NO
                T-Asn_header.leyenda:SENSITIVE        = NO
                T-Asn_header.cambio:SENSITIVE         = NO
                T-Asn_header.cambio_dolar:SENSITIVE   = NO
                v-cdg_cuenta:SENSITIVE                = NO
                v-reexpresado:SENSITIVE                    = NO
                v-libro:SENSITIVE                     = NO
                btn_modelo:SENSITIVE                  = NO
                btn_revertir:SENSITIVE                = NO.
     END.
     ELSE DO:

            ASSIGN
                btn_grabar:SENSITIVE                  = NO
                btn_copiar:SENSITIVE                  = NO
                btn_cancel:SENSITIVE                  = NO
                btn_anular:SENSITIVE                  = NO
                btn_observ:SENSITIVE                  = NO
                btn_imprim:SENSITIVE                  = NO
                T-Asn_header.tip_comprob:SENSITIVE    = NO
                T-Asn_header.nro_comprob:SENSITIVE    = NO
                T-Asn_header.fecha:SENSITIVE          = NO
                T-Asn_header.leyenda:SENSITIVE        = NO
                v-cdg_cuenta:SENSITIVE                = NO
                v-reexpresado:SENSITIVE                    = NO
                v-libro:SENSITIVE                     = NO
                btn_modelo:SENSITIVE                  = NO
                btn_revertir:SENSITIVE                = NO.

            CASE modo:
       
                WHEN MD_ALTA          
                THEN DO:
                     ASSIGN
                         btn_grabar:SENSITIVE                  = YES
                         btn_copiar:SENSITIVE                  = YES
                         btn_cancel:SENSITIVE                  = YES
                         btn_imprim:SENSITIVE                  = YES
                         btn_observ:SENSITIVE                  = YES
                         v-cdg_cuenta:SENSITIVE                = YES
                         T-Asn_header.fecha:SENSITIVE          = YES
                         T-Asn_header.leyenda:SENSITIVE        = YES
                         btn_modelo:SENSITIVE                  = YES
                         btn_revertir:SENSITIVE                = YES
                         v-libro:SENSITIVE                     = NUM-ENTRIES(v-libro:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME}) > 2
                         v-reexpresado:SENSITIVE               = YES.
         
                END.
                WHEN MD_MULTIPLE      
                THEN DO:
                     ASSIGN
                         T-Asn_header.nro_comprob:SENSITIVE    = YES
                         T-Asn_header.prf_comprob:SENSITIVE    = YES
                         T-Asn_header.tip_comprob:SENSITIVE    = YES.
                END.
                WHEN MD_DEFINIDA      
                THEN DO:
                     ASSIGN
                         btn_observ:SENSITIVE                  = YES
                         v-reexpresado:SENSITIVE               = YES
                         btn_imprim:SENSITIVE                  = YES.
                END.
                WHEN MD_RELACION      
                THEN DO:
                     ASSIGN
                         btn_observ:SENSITIVE                  = YES.
         
                END.
                WHEN MD_READONLY      
                THEN DO:
                     ASSIGN
                         btn_observ:SENSITIVE                  = YES.
         
                END.
                WHEN MD_CAMBIO        
                THEN DO:
                     ASSIGN
                         btn_grabar:SENSITIVE                  = NO
                         btn_anular:SENSITIVE                  = YES
                         btn_imprim:SENSITIVE                  = NO
                         btn_observ:SENSITIVE                  = YES
                         v-cdg_cuenta:SENSITIVE                = NO
                         T-Asn_header.fecha:SENSITIVE          = NO
                         T-Asn_header.leyenda:SENSITIVE        = NO.
                END.
                WHEN MD_ANULACION        
                THEN DO:
                     ASSIGN
                         T-Asn_header.nro_comprob:SENSITIVE    = YES
                         T-Asn_header.prf_comprob:SENSITIVE    = YES
                         T-Asn_header.tip_comprob:SENSITIVE    = YES.
         
                END.
                WHEN MD_EMISION        
                THEN DO:
                     ASSIGN
                         T-Asn_header.nro_comprob:SENSITIVE    = YES
                         T-Asn_header.prf_comprob:SENSITIVE    = YES
                         T-Asn_header.tip_comprob:SENSITIVE    = YES.
         
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
/*       
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
  
       CREATE Asn_header.
       BUFFER-COPY T-Asn_header TO Asn_header
           ASSIGN  Asn_header.nro_asiento = NEXT-VALUE(proximo_asiento) 
                   Asn_header.tip_comprob = "AS"
                   Asn_header.nro_comprob = Parametro.valor_n.
  
       FOR EACH T-Asn_detalle:
           CREATE Asn_detalle.
           BUFFER-COPY T-Asn_detalle TO Asn_detalle
               ASSIGN  Asn_detalle.nro_asiento = Asn_header.nro_asiento.
           DELETE T-Asn_detalle.
       END.

       FOR EACH T-Asn_totales:
           CREATE Asn_totales.
           BUFFER-COPY T-Asn_totales TO Asn_totales
               ASSIGN  Asn_totales.nro_asiento = Asn_header.nro_asiento.
           DELETE T-Asn_totales.
       END.
      
       Parametro.valor_n = Parametro.valor_n + 1.

       {crearauditoria.i}

       RELEASE Parametro.
*/
       RUN emitir_asiento.p ( INPUT TABLE T-Asn_header,
                              INPUT TABLE T-Asn_detalle,
                              INPUT TABLE T-Asn_totales).
       
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
           btn_grabar:SENSITIVE                  = NO
           btn_copiar:SENSITIVE                  = NO
           btn_cancel:SENSITIVE                  = NO
           btn_anular:SENSITIVE                  = NO
           btn_observ:SENSITIVE                  = NO
           btn_imprim:SENSITIVE                  = NO
           btn_comprobante:SENSITIVE             = NO
           v-cdg_cuenta:SENSITIVE                = NO
           v-reexpresado:SENSITIVE               = NO
           v-libro:SENSITIVE                     = NO
           T-Asn_header.fecha:SENSITIVE          = NO
           T-Asn_header.cambio:SENSITIVE         = NO
           T-Asn_header.cambio_dolar:SENSITIVE   = NO
           T-Asn_header.leyenda:SENSITIVE        = NO
           T-Asn_header.nro_comprob:SENSITIVE    = NO
           T-Asn_header.prf_comprob:SENSITIVE    = NO
           T-Asn_header.tip_comprob:SENSITIVE    = NO
           T-Asn_header.reexpresa_saldos:SENSITIVE    = NO.

     CASE modo:

       WHEN MD_ALTA          
       THEN DO:
            ASSIGN
                btn_grabar:SENSITIVE                  = YES
                btn_cancel:SENSITIVE                  = YES
                btn_observ:SENSITIVE                  = YES
                v-cdg_cuenta:SENSITIVE                = YES
                v-reexpresado:SENSITIVE               = YES
                v-libro:SENSITIVE                     = YES
                T-Asn_header.fecha:SENSITIVE          = YES
                T-Asn_header.leyenda:SENSITIVE        = YES.

       END.
       WHEN MD_MULTIPLE      
       THEN DO:
            ASSIGN
                btn_cancel:SENSITIVE                  = YES
                btn_observ:SENSITIVE                  = YES
                btn_imprim:SENSITIVE                  = YES
                btn_comprobante:SENSITIVE             = YES
                v-reexpresado:SENSITIVE               = YES.

       END.
       WHEN MD_DEFINIDA      
       THEN DO:
            ASSIGN
                btn_observ:SENSITIVE                  = YES
                btn_imprim:SENSITIVE                  = YES
                btn_comprobante:SENSITIVE             = YES
                v-reexpresado:SENSITIVE               = YES.

       END.
       WHEN MD_RELACION      
       THEN DO:
            ASSIGN
                btn_observ:SENSITIVE                  = YES
                btn_imprim:SENSITIVE                  = YES
                btn_comprobante:SENSITIVE             = YES
                v-reexpresado:SENSITIVE               = YES.

       END.
       WHEN MD_READONLY      
       THEN DO:
            ASSIGN
                btn_observ:SENSITIVE                  = YES
                btn_imprim:SENSITIVE                  = YES
                btn_comprobante:SENSITIVE             = YES
                v-reexpresado:SENSITIVE               = YES.
       END.
       WHEN MD_CAMBIO        
       THEN DO:
            ASSIGN
                btn_observ:SENSITIVE                  = YES
                btn_imprim:SENSITIVE                  = YES
                btn_comprobante:SENSITIVE             = YES
                v-reexpresado:SENSITIVE               = YES.
       END.
       WHEN MD_ANULACION        
       THEN DO:
            ASSIGN
                btn_observ:SENSITIVE                  = YES
                btn_imprim:SENSITIVE                  = YES
                btn_anular:SENSITIVE                  = YES
                btn_comprobante:SENSITIVE             = YES
                v-reexpresado:SENSITIVE               = YES.
       END.
       WHEN MD_EMISION        
       THEN DO:
            ASSIGN
                btn_grabar:SENSITIVE                  = YES
                btn_cancel:SENSITIVE                  = YES
                btn_observ:SENSITIVE                  = YES
                btn_imprim:SENSITIVE                  = YES
                btn_comprobante:SENSITIVE             = YES
                v-reexpresado:SENSITIVE               = YES.
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

    DEFINE VARIABLE v-cambio AS DECIMAL.
    DEFINE VARIABLE v-dolar  AS DECIMAL.

    v-prox_docum = "PROXNASN".
    
    /*{titulowindow_asiento.i "SIC/GLA"}*/
    
    RUN inicia_combos.


    RUN titulo_window ( INPUT "Asientos Contables" ).           

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE inicia_combos C-Win 
PROCEDURE inicia_combos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE x-lista AS CHARACTER.
 
  DO WITH FRAME {&FRAME-NAME}:

     /*
     x-lista = "[MONEDA DE ORIGEN],".
     FOR EACH Moneda WHERE Moneda.reexpresa_saldos NO-LOCK BY Moneda.descripcion:
         x-lista = x-lista + "," + Moneda.descripcion + "," + Moneda.cdg_moneda.
     END.
     v-reexpresado:LIST-ITEM-PAIRS = x-lista . /*SUBSTRING(x-lista,2).*/
     FIND FIRST Moneda WHERE Moneda.es_local NO-LOCK.
     v-reexpresado = Moneda.cdg_moneda.
     */

     x-lista = "".
     FOR EACH Librocontable NO-LOCK BY Librocontable.dsc_librocontable:
         x-lista = x-lista + "," + Librocontable.dsc_librocontable + "," + Librocontable.cdg_librocontable.
     END.
     v-libro:LIST-ITEM-PAIRS = SUBSTRING(x-lista,2).
    
     FIND FIRST Librocontable NO-LOCK.
     v-libro = Librocontable.cdg_librocontable.
      
  END.          

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE modificar_cambio C-Win 
PROCEDURE modificar_cambio :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
    FOR EACH T-Asn_detalle:
        T-Asn_detalle.cambio_dolar  = T-Asn_header.cambio_dolar.
        T-Asn_detalle.cambio        = T-Asn_header.cambio.
        T-Asn_detalle.debito        = ROUND(T-Asn_detalle.debito_div * T-Asn_detalle.cambio,2). 
        T-Asn_detalle.credito       = ROUND(T-Asn_detalle.credito_div * T-Asn_detalle.cambio,2). 
    END.    
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_dolar C-Win 
PROCEDURE poner_dolar :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE BUFFER Dolar FOR Moneda.

    FIND Dolar WHERE Dolar.es_referencia NO-LOCK NO-ERROR.
    IF NOT AVAILABLE Dolar
    THEN DO:
         T-Asn_header.cambio_dolar = 1.
         T-Asn_header.cambio_dolar:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
    END.
    ELSE DO:
         FIND LAST Cotizacion OF Dolar
              WHERE Cotizacion.cdg_empresa    = T-Asn_header.cdg_empresa
                AND Cotizacion.fch_cotizacion <= T-Asn_header.fecha.
         T-Asn_header.cambio_dolar = Cotizacion.cambio.
    END.

    DISPLAY 
         T-Asn_header.cambio_dolar
         WITH FRAME {&FRAME-NAME}. 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_estado C-Win 
PROCEDURE poner_estado :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  
  IF T-Asn_header.anulado
  THEN DO:
      v-estado = "ANULADO".
  END.
  ELSE DO:
      FIND Estado_asiento OF T-Asn_header NO-LOCK.
      v-estado = Estado_asiento.dsc_estadoasiento.
  END.

  DISPLAY v-estado
          WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_libro C-Win 
PROCEDURE poner_libro :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

      FIND Librocontable WHERE Librocontable.cdg_librocontable = v-libro NO-LOCK NO-ERROR.

      ASSIGN T-Asn_header.cdg_librocontable = Librocontable.cdg_librocontable.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_moneda C-Win 
PROCEDURE poner_moneda :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
    IF v-reexpresado <> v-reexpresado-origen
    THEN DO:
        FIND Moneda WHERE Moneda.cdg_moneda = v-reexpresado NO-LOCK.
        ASSIGN T-Asn_header.nro_moneda = Moneda.nro_moneda.
        FIND LAST Cotizacion OF Moneda
            WHERE Cotizacion.cdg_empresa    = T-Asn_header.cdg_empresa
              AND Cotizacion.fch_cotizacion <= T-Asn_header.fecha.
        T-Asn_header.cambio = Cotizacion.cambio.
    
        DISPLAY 
             T-Asn_header.cambio
             WITH FRAME {&FRAME-NAME}. 
    END.     
    ELSE DO:
        T-Asn_header.cambio:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
    END.
*/
    RUN abre_query_acumulados.
    IF v-reexpresado
        THEN APPLY "VALUE-CHANGED" TO BRW-ACUMULADOS IN FRAME {&FRAME-NAME}.
        ELSE RUN abre_query_detalle. 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE reexpresar_movimiento C-Win 
PROCEDURE reexpresar_movimiento :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER p-que_linea LIKE Asn_detalle.nro_linea.

  DEFINE VARIABLE x-cotiza_origen AS DATE.

  /* ----------------------------------------------------------------------------- */
  /*   Recupera el detalle de asiento que se desea reexpresar en otras monedas     */
  /* ----------------------------------------------------------------------------- */

  FIND FIRST T-Asn_detalle 
       WHERE T-Asn_detalle.nro_asiento = 0 
         AND T-Asn_detalle.nro_linea   = p-que_linea
         AND T-Asn_detalle.reexpresion = NO.

  IF INPUT FRAME {&FRAME-NAME} T-Asn_header.reexpresa_saldos 
  THEN DO:

      /* ----------------------------------------------------------------------------- */
      /* Recorre las monedas para las cuales la cuenta del movimiento reexpresa saldos */
      /* ----------------------------------------------------------------------------- */
    
      FOR EACH Cuenta-moneda 
          WHERE Cuenta-moneda.nro_cuenta = T-Asn_detalle.nro_cuenta 
            AND Cuenta-moneda.reexpresa_saldos: 
    
          /* ---------------------------------------- */
          /* Busca la reexpresion en esta moneda.     */
          /* ---------------------------------------- */
    
          FIND T-Reexpresion 
               WHERE T-Reexpresion.nro_asiento = T-Asn_detalle.nro_asiento
                 AND T-Reexpresion.nro_linea   = T-Asn_detalle.nro_linea
                 AND T-Reexpresion.nro_moneda  = Cuenta-moneda.nro_moneda
                 AND T-Reexpresion.reexpresion
                     EXCLUSIVE-LOCK NO-ERROR.
    
          /* ---------------------------------------- */
          /* Si no esta, la crea, asignando el cambio */
          /* ---------------------------------------- */
    
          IF NOT AVAILABLE T-Reexpresion
          THEN DO:
              CREATE T-Reexpresion.
              BUFFER-COPY T-Asn_detalle TO T-Reexpresion
                    ASSIGN T-Reexpresion.nro_moneda  = Cuenta-moneda.nro_moneda
                           T-Reexpresion.reexpresion = YES.
    
              IF Cuenta-moneda.nro_moneda <> T-Asn_detalle.nro_moneda
              THEN DO:     
                  FIND Moneda OF T-Reexpresion NO-LOCK.
                  RUN cotizar_moneda.p  ( INPUT   Moneda.cdg_moneda, 
                                          INPUT   T-Asn_header.cdg_empresa,  
                                          INPUT   T-Asn_header.fecha, 
                                          OUTPUT  T-Reexpresion.cambio, 
                                          OUTPUT  x-cotiza_origen).
              END.
    
          END.           
    
          IF Cuenta-moneda.nro_moneda <> T-Asn_detalle.nro_moneda
          THEN DO:       
              IF v-modo_cotiza = v-dividir 
                  THEN ASSIGN T-Reexpresion.debito  = T-Asn_detalle.debito  * ( T-Asn_detalle.cambio / T-Reexpresion.cambio)
                              T-Reexpresion.credito = T-Asn_detalle.credito * ( T-Asn_detalle.cambio / T-Reexpresion.cambio).
                  ELSE ASSIGN T-Reexpresion.debito  = T-Asn_detalle.debito  * ( T-Reexpresion.cambio / T-Asn_detalle.cambio)
                              T-Reexpresion.credito = T-Asn_detalle.credito * ( T-Reexpresion.cambio / T-Asn_detalle.cambio).

          END.
          ELSE DO:
              ASSIGN T-Reexpresion.debito  = T-Asn_detalle.debito  
                     T-Reexpresion.credito = T-Asn_detalle.credito
                     T-Reexpresion.cambio  = T-Asn_detalle.cambio.
          END.           
      END.

      T-Asn_header.nro_moneda = ?.

  END.
  ELSE DO:

      /* ----------------------------------------------------------------------------- */
      /* Rexpresa el asiento como una imagen de si mismo en la misma moneda            */
      /* Busca la reexpresion en esta moneda. Si no esta, la crea y copia el renglon   */
      /* ----------------------------------------------------------------------------- */
    
      FIND T-Reexpresion 
           WHERE T-Reexpresion.nro_asiento = T-Asn_detalle.nro_asiento
             AND T-Reexpresion.nro_linea   = T-Asn_detalle.nro_linea
             AND T-Reexpresion.nro_moneda  = T-Asn_detalle.nro_moneda
             AND T-Reexpresion.reexpresion
                 EXCLUSIVE-LOCK NO-ERROR.

      IF NOT AVAILABLE T-Reexpresion
          THEN CREATE T-Reexpresion.

      BUFFER-COPY T-Asn_detalle TO T-Reexpresion
            ASSIGN T-Reexpresion.reexpresion = YES.

      T-Asn_header.nro_moneda = T-Asn_detalle.nro_moneda.
    
  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE refrescar_cotizaciones C-Win 
PROCEDURE refrescar_cotizaciones :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
    FOR EACH T-Asn_detalle, Moneda OF T-Asn_detalle:

        IF Moneda.es_local
        THEN DO:
             T-Asn_header.cambio = 1.
             T-Asn_header.cambio:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
        END.
        ELSE DO:
             T-Asn_header.cambio:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
             FIND LAST Cotizacion OF Moneda
                  WHERE Cotizacion.cdg_empresa    = T-Asn_header.cdg_empresa
                    AND Cotizacion.fch_cotizacion <= T-Asn_header.fecha.
             T-Asn_header.cambio = Cotizacion.cambio.
        END.

        T-Asn_detalle.debito     = ROUND(T-Asn_detalle.debito_div * T-Asn_header.cambio,2). 
        T-Asn_detalle.credito    = ROUND(T-Asn_detalle.credito_div * T-Asn_header.cambio,2). 

    END.    

    RUN calculos.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE revertir_asiento C-Win 
PROCEDURE revertir_asiento :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE a-credito AS DECIMAL.

  DO TRANSACTION:
     FOR EACH T-Asn_detalle:
         a-credito = T-Asn_detalle.credito.
         T-Asn_detalle.credito = T-Asn_detalle.debito.
         T-Asn_detalle.debito = a-credito.
     END.
  END.

  RUN abre_query_detalle.
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

 {&WINDOW-NAME}:TITLE = "DYNASYS/GLA " + NRO_RELEASE + " - " + Usuario.cdg_empresa + " - " + v-txtitulo + " User:" + USERID("sic").

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

   FIND Asn_header WHERE ROWID(Asn_header) = rid_asiento NO-LOCK.
   BUFFER-COPY Asn_header TO T-Asn_header.

   FOR EACH Asn_detalle OF Asn_header:
       CREATE T-Asn_detalle.
       BUFFER-COPY Asn_detalle TO T-Asn_detalle.
   END.    

   FOR EACH Asn_totales OF Asn_header:
       CREATE T-Asn_totales.
       BUFFER-COPY Asn_totales TO T-Asn_totales.
   END.    

   DISPLAY
        T-Asn_header.tip_comprob 
        T-Asn_header.prf_comprob 
        T-Asn_header.nro_comprob 
        T-Asn_header.fecha 
        T-Asn_header.cdg_sigla-sic 
        T-Asn_header.nro_secuencia 
        T-Asn_header.origen 
        T-Asn_header.leyenda
        T-Asn_header.cambio
        T-Asn_header.cambio_dolar
        T-Asn_header.reexpresa_saldos
        WITH FRAME {&FRAME-NAME}.

   RUN poner_estado.
   /*
   ASSIGN T-Asn_header.tip_comprob:SENSITIVE IN FRAME {&FRAME-NAME} = NO 
          T-Asn_header.prf_comprob:SENSITIVE IN FRAME {&FRAME-NAME} = NO 
          T-Asn_header.nro_comprob:SENSITIVE IN FRAME {&FRAME-NAME} = NO
          v-reexpresado:SENSITIVE IN FRAME {&FRAME-NAME} = YES. 
   */
   RUN abre_query_acumulados.
   RUN abre_query_detalle.
       
   RUN habilitar_campos ( INPUT YES ).
   
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
    
    IF NOT CAN-FIND(FIRST T-Asn_detalle OF  T-Asn_header)
    THEN DO:
       RUN PONMENSJ.P (INPUT "ASIE005").
       RETURN.
    END.

    IF CAN-FIND(FIRST T-Asn_totales WHERE T-Asn_totales.diferencia <> 0 AND T-Asn_totales.reexpresion)
    THEN DO:
       RUN PONMENSJ.P ( INPUT "ASIE011" ).
       RETURN.
    END.

    FIND FIRST Periodo_fiscal WHERE Periodo_fiscal.cdg_empresa = T-Asn_header.cdg_empresa
                                AND Periodo_fiscal.ano         = YEAR(T-Asn_header.fecha)
                                AND Periodo_fiscal.mes         = MONTH(T-Asn_header.fecha) 
                                    NO-LOCK NO-ERROR.
    IF NOT AVAILABLE Periodo_fiscal
    THEN DO:
         RUN PONMENSJ.P ( INPUT "ASIE014" ).
         RETURN.
    END.
    ELSE DO:
         IF Periodo_fiscal.cerrado
         THEN DO:
              RUN PONMENSJ.P ( INPUT "ASIE001" ).
              RETURN.
         END.
    END.
    
    hubo_error = NO.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

