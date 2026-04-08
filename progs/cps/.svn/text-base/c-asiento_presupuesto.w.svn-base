&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win

/* Temp-Table and Buffer definitions                                    */
DEFINE NEW SHARED TEMP-TABLE T-Aps_detalle NO-UNDO LIKE Aps_detalle.
DEFINE NEW SHARED TEMP-TABLE T-Aps_header NO-UNDO LIKE Aps_header.
DEFINE TEMP-TABLE T-Aps_totales NO-UNDO LIKE Aps_totales.
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

DEFINE BUFFER T-Reexpresion FOR T-Aps_detalle.

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
&Scoped-define INTERNAL-TABLES T-Aps_totales Total-moneda T-Aps_detalle ~
Ctapsp Moneda Entidad T-Aps_header

/* Definitions for BROWSE BRW-ACUMULADOS                                */
&Scoped-define FIELDS-IN-QUERY-BRW-ACUMULADOS Total-moneda.cdg_moneda ~
T-Aps_totales.tot_debitos T-Aps_totales.tot_creditos ~
T-Aps_totales.diferencia Total-moneda.descripcion 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BRW-ACUMULADOS 
&Scoped-define QUERY-STRING-BRW-ACUMULADOS FOR EACH T-Aps_totales OF T-Aps_header NO-LOCK, ~
      EACH Total-moneda WHERE TRUE /* Join to T-Aps_totales incomplete */ NO-LOCK
&Scoped-define OPEN-QUERY-BRW-ACUMULADOS OPEN QUERY BRW-ACUMULADOS FOR EACH T-Aps_totales OF T-Aps_header NO-LOCK, ~
      EACH Total-moneda WHERE TRUE /* Join to T-Aps_totales incomplete */ NO-LOCK.
&Scoped-define TABLES-IN-QUERY-BRW-ACUMULADOS T-Aps_totales Total-moneda
&Scoped-define FIRST-TABLE-IN-QUERY-BRW-ACUMULADOS T-Aps_totales
&Scoped-define SECOND-TABLE-IN-QUERY-BRW-ACUMULADOS Total-moneda


/* Definitions for BROWSE BRW-DETALLE                                   */
&Scoped-define FIELDS-IN-QUERY-BRW-DETALLE T-Aps_detalle.nro_linea ~
Ctapsp.cdg_ctapsp Ctapsp.nombre_cps Entidad.cdg_entidad Entidad.dsc_entidad ~
Moneda.abrevia T-Aps_detalle.cambio ~
IF (T-Aps_detalle.debito<>0) THEN (STRING(T-Aps_detalle.debito,"-ZZ,ZZZ,ZZ9.99")) ELSE ("")  @ v-debito ~
IF (T-Aps_detalle.credito<>0) THEN (STRING(T-Aps_detalle.credito,"-ZZ,ZZZ,ZZ9.99")) ELSE ("")  @ v-credito 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BRW-DETALLE 
&Scoped-define QUERY-STRING-BRW-DETALLE FOR EACH T-Aps_detalle OF T-Aps_header NO-LOCK, ~
      EACH Ctapsp OF T-Aps_detalle NO-LOCK, ~
      EACH Moneda OF T-Aps_detalle NO-LOCK, ~
      EACH Entidad OF T-Aps_detalle NO-LOCK ~
    BY T-Aps_detalle.nro_linea
&Scoped-define OPEN-QUERY-BRW-DETALLE OPEN QUERY BRW-DETALLE FOR EACH T-Aps_detalle OF T-Aps_header NO-LOCK, ~
      EACH Ctapsp OF T-Aps_detalle NO-LOCK, ~
      EACH Moneda OF T-Aps_detalle NO-LOCK, ~
      EACH Entidad OF T-Aps_detalle NO-LOCK ~
    BY T-Aps_detalle.nro_linea.
&Scoped-define TABLES-IN-QUERY-BRW-DETALLE T-Aps_detalle Ctapsp Moneda ~
Entidad
&Scoped-define FIRST-TABLE-IN-QUERY-BRW-DETALLE T-Aps_detalle
&Scoped-define SECOND-TABLE-IN-QUERY-BRW-DETALLE Ctapsp
&Scoped-define THIRD-TABLE-IN-QUERY-BRW-DETALLE Moneda
&Scoped-define FOURTH-TABLE-IN-QUERY-BRW-DETALLE Entidad


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define FIELDS-IN-QUERY-DEFAULT-FRAME T-Aps_header.tip_comprob ~
T-Aps_header.prf_comprob T-Aps_header.nro_comprob T-Aps_header.fecha ~
T-Aps_header.cambio_dolar T-Aps_header.cambio T-Aps_header.leyenda ~
T-Aps_header.origen T-Aps_header.nro_secuencia T-Aps_header.cdg_sigla-sic 
&Scoped-define ENABLED-FIELDS-IN-QUERY-DEFAULT-FRAME T-Aps_header.fecha ~
T-Aps_header.cambio T-Aps_header.leyenda 
&Scoped-define ENABLED-TABLES-IN-QUERY-DEFAULT-FRAME T-Aps_header
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-DEFAULT-FRAME T-Aps_header
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-BRW-ACUMULADOS}~
    ~{&OPEN-QUERY-BRW-DETALLE}
&Scoped-define QUERY-STRING-DEFAULT-FRAME FOR EACH T-Aps_header SHARE-LOCK
&Scoped-define OPEN-QUERY-DEFAULT-FRAME OPEN QUERY DEFAULT-FRAME FOR EACH T-Aps_header SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-DEFAULT-FRAME T-Aps_header
&Scoped-define FIRST-TABLE-IN-QUERY-DEFAULT-FRAME T-Aps_header


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS T-Aps_header.fecha T-Aps_header.cambio ~
T-Aps_header.leyenda 
&Scoped-define ENABLED-TABLES T-Aps_header
&Scoped-define FIRST-ENABLED-TABLE T-Aps_header
&Scoped-Define ENABLED-OBJECTS Btn_salir BRW-ACUMULADOS BRW-DETALLE RECT-2 ~
RECT-3 RECT-4 RECT-5 RECT-6 RECT-7 RECT-8 RECT-9 
&Scoped-Define DISPLAYED-FIELDS T-Aps_header.tip_comprob ~
T-Aps_header.prf_comprob T-Aps_header.nro_comprob T-Aps_header.fecha ~
T-Aps_header.cambio_dolar T-Aps_header.cambio T-Aps_header.leyenda ~
T-Aps_header.origen T-Aps_header.nro_secuencia T-Aps_header.cdg_sigla-sic ~
T-Aps_detalle.leyen_detalle 
&Scoped-define DISPLAYED-TABLES T-Aps_header T-Aps_detalle
&Scoped-define FIRST-DISPLAYED-TABLE T-Aps_header
&Scoped-define SECOND-DISPLAYED-TABLE T-Aps_detalle
&Scoped-Define DISPLAYED-OBJECTS v-anulado v-estado v-reexpresado v-libro ~
v-cdg_ctapsp 

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

DEFINE BUTTON btn_copiar 
     LABEL "&Copiar" 
     SIZE 20 BY 1.33 TOOLTIP "Selecciona y copia un asiento existente".

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
     SIZE 37 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-reexpresado AS LOGICAL FORMAT "yes/no":U INITIAL NO 
     LABEL "Expresión" 
     VIEW-AS COMBO-BOX INNER-LINES 2
     LIST-ITEM-PAIRS "MONEDA DE ORIGEN",no,
                     "SALDOS REEXPRESADOS",yes
     DROP-DOWN-LIST
     SIZE 39 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-anulado AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     FGCOLOR 12 FONT 6 NO-UNDO.

DEFINE VARIABLE v-cdg_ctapsp AS CHARACTER FORMAT "X(256)":U 
     LABEL "Ctapsp" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 15 BY 1
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE v-estado AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 12 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 127 BY 1.86.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 22 BY 1.86.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 127 BY 10.43.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 22 BY 2.38.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 150 BY 12.67.

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 22 BY 3.33.

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 22 BY 1.43.

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 22 BY 2.86.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BRW-ACUMULADOS FOR 
      T-Aps_totales, 
      Total-moneda SCROLLING.

DEFINE QUERY BRW-DETALLE FOR 
      T-Aps_detalle, 
      Ctapsp, 
      Moneda, 
      Entidad SCROLLING.

DEFINE QUERY DEFAULT-FRAME FOR 
      T-Aps_header SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BRW-ACUMULADOS
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BRW-ACUMULADOS C-Win _STRUCTURED
  QUERY BRW-ACUMULADOS NO-LOCK DISPLAY
      Total-moneda.cdg_moneda FORMAT "X(3)":U
      T-Aps_totales.tot_debitos FORMAT "->>,>>>,>>9.99":U
      T-Aps_totales.tot_creditos FORMAT "->>,>>>,>>9.99":U
      T-Aps_totales.diferencia FORMAT "->>,>>>,>>9.99":U
      Total-moneda.descripcion FORMAT "X(40)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 123 BY 5.71
         BGCOLOR 15 FGCOLOR 9 
         TITLE BGCOLOR 15 FGCOLOR 9 "Totales por Moneda" EXPANDABLE.

DEFINE BROWSE BRW-DETALLE
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BRW-DETALLE C-Win _STRUCTURED
  QUERY BRW-DETALLE NO-LOCK DISPLAY
      T-Aps_detalle.nro_linea COLUMN-LABEL "N.Li!nea" FORMAT ">>>9":U
      Ctapsp.cdg_ctapsp FORMAT "X(8)":U
      Ctapsp.nombre_cps COLUMN-LABEL "Nombre!Ctapsp" FORMAT "X(35)":U
      Entidad.cdg_entidad FORMAT "X(8)":U
      Entidad.dsc_entidad COLUMN-LABEL "Descripción!Entidad" FORMAT "X(20)":U
      Moneda.abrevia COLUMN-LABEL "Identific!Moneda" FORMAT "X(5)":U
      T-Aps_detalle.cambio COLUMN-LABEL "Valor!Cotización" FORMAT ">>>>9.9999":U
      IF (T-Aps_detalle.debito<>0) THEN (STRING(T-Aps_detalle.debito,"-ZZ,ZZZ,ZZ9.99")) ELSE ("")  @ v-debito COLUMN-LABEL "Importe!Débito" FORMAT "X(14)":U
            COLUMN-FONT 2
      IF (T-Aps_detalle.credito<>0) THEN (STRING(T-Aps_detalle.credito,"-ZZ,ZZZ,ZZ9.99")) ELSE ("")  @ v-credito COLUMN-LABEL "Importe!Crédito" FORMAT "X(14)":U
            COLUMN-FONT 2
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 146 BY 10.76
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
     T-Aps_header.tip_comprob AT ROW 3.86 COL 15 COLON-ALIGNED
          LABEL "Asiento"
          VIEW-AS FILL-IN NATIVE 
          SIZE 7 BY 1
          BGCOLOR 7 FGCOLOR 15 
     T-Aps_header.prf_comprob AT ROW 3.86 COL 23 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 7 BY 1
          BGCOLOR 7 FGCOLOR 15 
     T-Aps_header.nro_comprob AT ROW 3.86 COL 31 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 23 BY 1
          BGCOLOR 7 FGCOLOR 15 
     v-anulado AT ROW 3.86 COL 56 COLON-ALIGNED NO-LABEL
     T-Aps_header.fecha AT ROW 3.86 COL 82 COLON-ALIGNED FORMAT "99/99/9999"
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Aps_header.cambio_dolar AT ROW 3.86 COL 111 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 15 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-estado AT ROW 4.48 COL 131 COLON-ALIGNED NO-LABEL
     v-reexpresado AT ROW 5.05 COL 15 COLON-ALIGNED
     v-libro AT ROW 5.05 COL 62 COLON-ALIGNED
     T-Aps_header.cambio AT ROW 5.05 COL 111 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 15 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Aps_header.leyenda AT ROW 6.24 COL 15 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 84 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_ctapsp AT ROW 6.24 COL 111 COLON-ALIGNED
     T-Aps_header.origen AT ROW 7.1 COL 131 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 4 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Aps_header.nro_secuencia AT ROW 7.1 COL 136 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     BRW-ACUMULADOS AT ROW 7.67 COL 5
     T-Aps_header.cdg_sigla-sic AT ROW 9.1 COL 142 COLON-ALIGNED
          LABEL "Módulo"
          VIEW-AS FILL-IN NATIVE 
          SIZE 7 BY 1
          BGCOLOR 15 FGCOLOR 9 
     btn_revertir AT ROW 10.76 COL 132
     btn_modelo AT ROW 12.19 COL 132
     BRW-DETALLE AT ROW 14.38 COL 5
     T-Aps_detalle.leyen_detalle AT ROW 25.43 COL 2 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 147 BY 1
          BGCOLOR 15 FGCOLOR 9 
     RECT-2 AT ROW 1.29 COL 3
     RECT-3 AT ROW 1.24 COL 131
     RECT-4 AT ROW 3.43 COL 3
     RECT-5 AT ROW 3.38 COL 131
     RECT-6 AT ROW 14.1 COL 3
     RECT-7 AT ROW 10.52 COL 131
     RECT-8 AT ROW 8.86 COL 131
     RECT-9 AT ROW 6 COL 131
     "         Estado" VIEW-AS TEXT
          SIZE 17 BY .62 AT ROW 3.62 COL 133
          BGCOLOR 5 FGCOLOR 15 
     "   Origen y Sec" VIEW-AS TEXT
          SIZE 18 BY .62 AT ROW 6.29 COL 133
          BGCOLOR 5 FGCOLOR 15 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 160 BY 27.19.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Aps_detalle T "NEW SHARED" NO-UNDO sic Aps_detalle
      TABLE: T-Aps_header T "NEW SHARED" NO-UNDO sic Aps_header
      TABLE: T-Aps_totales T "?" NO-UNDO sic Aps_totales
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
         HEIGHT             = 27.19
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
                                                                        */
/* BROWSE-TAB BRW-ACUMULADOS nro_secuencia DEFAULT-FRAME */
/* BROWSE-TAB BRW-DETALLE btn_modelo DEFAULT-FRAME */
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
/* SETTINGS FOR BUTTON btn_modelo IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_observ IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_revertir IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Aps_header.cambio_dolar IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Aps_header.cdg_sigla-sic IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN T-Aps_header.fecha IN FRAME DEFAULT-FRAME
   EXP-FORMAT                                                           */
/* SETTINGS FOR FILL-IN T-Aps_detalle.leyen_detalle IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Aps_header.nro_comprob IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Aps_header.nro_secuencia IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN T-Aps_header.origen IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Aps_header.prf_comprob IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Aps_header.tip_comprob IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN v-anulado IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_ctapsp IN FRAME DEFAULT-FRAME
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
     _TblList          = "Temp-Tables.T-Aps_totales OF Temp-Tables.T-Aps_header,sic.Total-moneda WHERE Temp-Tables.T-Aps_totales ..."
     _Options          = "NO-LOCK"
     _FldNameList[1]   = Temp-Tables.Total-moneda.cdg_moneda
     _FldNameList[2]   = Temp-Tables.T-Aps_totales.tot_debitos
     _FldNameList[3]   = Temp-Tables.T-Aps_totales.tot_creditos
     _FldNameList[4]   = Temp-Tables.T-Aps_totales.diferencia
     _FldNameList[5]   > Temp-Tables.Total-moneda.descripcion
"Total-moneda.descripcion" ? "X(40)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _Query            is OPENED
*/  /* BROWSE BRW-ACUMULADOS */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BRW-DETALLE
/* Query rebuild information for BROWSE BRW-DETALLE
     _TblList          = "Temp-Tables.T-Aps_detalle OF Temp-Tables.T-Aps_header,sic.Ctapsp OF Temp-Tables.T-Aps_detalle,sic.Moneda OF Temp-Tables.T-Aps_detalle,sic.Entidad OF Temp-Tables.T-Aps_detalle"
     _Options          = "NO-LOCK"
     _OrdList          = "Temp-Tables.T-Aps_detalle.nro_linea|yes"
     _FldNameList[1]   > Temp-Tables.T-Aps_detalle.nro_linea
"T-Aps_detalle.nro_linea" "N.Li!nea" ">>>9" "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[2]   = sic.Ctapsp.cdg_ctapsp
     _FldNameList[3]   > sic.Ctapsp.nombre_cps
"Ctapsp.nombre_cps" "Nombre!Ctapsp" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[4]   = sic.Entidad.cdg_entidad
     _FldNameList[5]   > sic.Entidad.dsc_entidad
"Entidad.dsc_entidad" "Descripción!Entidad" "X(20)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[6]   > sic.Moneda.abrevia
"Moneda.abrevia" "Identific!Moneda" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[7]   > Temp-Tables.T-Aps_detalle.cambio
"T-Aps_detalle.cambio" "Valor!Cotización" ">>>>9.9999" "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[8]   > "_<CALC>"
"IF (T-Aps_detalle.debito<>0) THEN (STRING(T-Aps_detalle.debito,""-ZZ,ZZZ,ZZ9.99"")) ELSE ("""")  @ v-debito" "Importe!Débito" "X(14)" ? ? ? 2 ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[9]   > "_<CALC>"
"IF (T-Aps_detalle.credito<>0) THEN (STRING(T-Aps_detalle.credito,""-ZZ,ZZZ,ZZ9.99"")) ELSE ("""")  @ v-credito" "Importe!Crédito" "X(14)" ? ? ? 2 ? ? ? no ? no no ? yes no no "U" "" ""
     _Query            is OPENED
*/  /* BROWSE BRW-DETALLE */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME DEFAULT-FRAME
/* Query rebuild information for FRAME DEFAULT-FRAME
     _TblList          = "Temp-Tables.T-Aps_header"
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
  IF AVAILABLE T-Aps_totales AND v-reexpresado
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
             DELETE T-Aps_detalle.
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
  DISPLAY T-Aps_detalle.leyen_detalle WITH FRAME {&FRAME-NAME}.
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
         RUN anular_asiento.p (INPUT ROWID(Aps_header), OUTPUT pudo_anular).
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
    
        FOR EACH T-Aps_totales:
            DELETE T-Aps_totales.
        END.

        FOR EACH T-Aps_detalle:
            DELETE T-Aps_detalle.
        END.

        FIND FIRST T-Aps_header.
        DELETE T-Aps_header.

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

  RUN d-seleccionar_aspresupuesto.w (INPUT-OUTPUT rid_asiento).
  IF rid_asiento <> ?
  THEN DO:
     FIND Aps_header WHERE ROWID(Aps_header) = rid_asiento NO-LOCK.
     DISPLAY Aps_header.tip_comprob @ T-Aps_header.tip_comprob 
             Aps_header.nro_comprob @ T-Aps_header.nro_comprob
             WITH FRAME {&FRAME-NAME}.
     RUN traer_documento.
     btn_copiar:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
     btn_modelo:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
  END.  
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_grabar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_grabar C-Win
ON CHOOSE OF btn_grabar IN FRAME DEFAULT-FRAME /* Grabar */
DO:

  ASSIGN FRAME {&FRAME-NAME}
         T-Aps_header.fecha 
         T-Aps_header.leyenda.
         
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
         RUN imprimir_asiento.p (ROWID(Aps_header),
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
  
  RUN d-elegir_modelo.w ( INPUT-OUTPUT rid_modelo).

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
   RUN c-edttexto.w ( INPUT-OUTPUT T-Aps_header.observacion,
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


&Scoped-define SELF-NAME T-Aps_header.cambio
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Aps_header.cambio C-Win
ON LEAVE OF T-Aps_header.cambio IN FRAME DEFAULT-FRAME /* Cambio */
DO:
    ASSIGN FRAME {&FRAME-NAME} T-Aps_header.cambio.
    RUN modificar_cambio.
    RUN abre_query_detalle.
    APPLY "VALUE-CHANGED" TO {&BROWSE-NAME} IN FRAME {&FRAME-NAME}.
    RUN calculos.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Aps_header.cambio_dolar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Aps_header.cambio_dolar C-Win
ON LEAVE OF T-Aps_header.cambio_dolar IN FRAME DEFAULT-FRAME /* Dólar */
DO:
    ASSIGN FRAME {&FRAME-NAME} T-Aps_header.cambio_dolar.
    RUN modificar_cambio.
    RUN abre_query_detalle.
    APPLY "VALUE-CHANGED" TO {&BROWSE-NAME} IN FRAME {&FRAME-NAME}.
    RUN calculos.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Aps_header.fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Aps_header.fecha C-Win
ON LEAVE OF T-Aps_header.fecha IN FRAME DEFAULT-FRAME /* Fecha */
DO:
   ASSIGN FRAME {&FRAME-NAME} T-Aps_header.fecha.
/*
   IF INPUT FRAME {&FRAME-NAME} T-Aps_header.fecha <> T-Aps_header.fecha
   THEN DO:
        ASSIGN FRAME {&FRAME-NAME} T-Aps_header.fecha.
        RUN poner_cambio.
        RUN poner_dolar.
        RUN refrescar_cotizaciones.
   END.
*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Aps_header.leyenda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Aps_header.leyenda C-Win
ON LEAVE OF T-Aps_header.leyenda IN FRAME DEFAULT-FRAME /* Leyenda */
DO:
   ASSIGN FRAME {&FRAME-NAME} T-Aps_header.leyenda.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Aps_header.nro_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Aps_header.nro_comprob C-Win
ON MOUSE-SELECT-DBLCLICK OF T-Aps_header.nro_comprob IN FRAME DEFAULT-FRAME /* nro_comprob */
OR MOUSE-MENU-DOWN,"." OF T-Aps_header.nro_comprob IN FRAME {&FRAME-NAME}
DO:

  RUN d-seleccionar_aspresupuesto.w (INPUT-OUTPUT rid_asiento).
  IF rid_asiento <> ?
  THEN DO:
     FIND Aps_header WHERE ROWID(Aps_header) = rid_asiento NO-LOCK.
     DISPLAY Aps_header.tip_comprob @ T-Aps_header.tip_comprob 
             Aps_header.prf_comprob @ T-Aps_header.prf_comprob
             Aps_header.nro_comprob @ T-Aps_header.nro_comprob
             WITH FRAME {&FRAME-NAME}.
     
     RUN traer_documento.
  END.  
  RETURN NO-APPLY.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Aps_header.nro_comprob C-Win
ON RETURN OF T-Aps_header.nro_comprob IN FRAME DEFAULT-FRAME /* nro_comprob */
DO:
   IF INPUT FRAME {&FRAME-NAME} T-Aps_header.tip_comprob <> "AS" 
   THEN DO:
      RUN PONMENSJ.P (INPUT "DOCS010").
      RETURN NO-APPLY.
   END.

   FIND Aps_header 
        WHERE Aps_header.cdg_empresa = Empresa.cdg_empresa
          AND Aps_header.tip_comprob = INPUT T-Aps_header.tip_comprob 
          AND Aps_header.prf_comprob = INPUT T-Aps_header.prf_comprob
          AND Aps_header.nro_comprob = INPUT T-Aps_header.nro_comprob
              NO-ERROR.

   IF NOT AVAILABLE Aps_header 
   THEN DO:
        IF LOCKED Aps_header
           THEN RUN PONMENSJ.P (INPUT "DOCS000").
           ELSE RUN PONMENSJ.P (INPUT "DOCS001").
        RETURN NO-APPLY.
   END.
   ELSE DO:
        rid_asiento = ROWID(Aps_header).
        RUN traer_documento.
   END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Aps_header.tip_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Aps_header.tip_comprob C-Win
ON LEAVE OF T-Aps_header.tip_comprob IN FRAME DEFAULT-FRAME /* Asiento */
OR MOUSE-MENU-DOWN,"." OF T-Aps_header.tip_comprob IN FRAME {&FRAME-NAME}
DO:
  APPLY "MOUSE-SELECT-DBLCLICK" TO T-Aps_header.tip_comprob IN FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_ctapsp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_ctapsp C-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_ctapsp IN FRAME DEFAULT-FRAME /* Ctapsp */
OR MOUSE-MENU-DOWN,"." OF v-cdg_ctapsp IN FRAME {&FRAME-NAME}
DO:

  DEFINE VARIABLE rid_cuenta AS ROWID.

  RUN selcuent.p ( INPUT-OUTPUT rid_cuenta, 
                   INPUT YES ).

  IF rid_cuenta <> ?
  THEN DO:
       FIND Ctapsp WHERE ROWID(Ctapsp) = rid_cuenta NO-LOCK.
       DISPLAY Ctapsp.cdg_ctapsp  @ v-cdg_ctapsp
               WITH FRAME {&FRAME-NAME}.
       APPLY "RETURN" TO v-cdg_ctapsp IN FRAME {&FRAME-NAME}.
  END.
  RETURN NO-APPLY.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_ctapsp C-Win
ON RETURN OF v-cdg_ctapsp IN FRAME DEFAULT-FRAME /* Ctapsp */
DO:

   ASSIGN FRAME {&FRAME-NAME}
         v-cdg_ctapsp.

   FIND Ctapsp WHERE Ctapsp.cdg_ctapsp = v-cdg_ctapsp NO-LOCK NO-ERROR.

   IF NOT AVAILABLE Ctapsp
   THEN DO:
      RUN PONMENSJ.P (INPUT "ASIE028").
      RETURN NO-APPLY.
   END.
   /*
   IF NOT CAN-FIND(FIRST Libro-cuenta OF Ctapsp WHERE Libro-cuenta.cdg_librocontable = T-Aps_header.cdg_librocontable)
   THEN DO:
      RUN PONMENSJ.P (INPUT "ASIE029").
      RETURN NO-APPLY.
   END.
   
   IF Ctapsp.esta_restringida
   THEN DO:
      FIND Usuario WHERE Usuario.cdg_usuario = USERID("sic") NO-LOCK.
      IF NOT CAN-FIND(FIRST Ctapsp-usuarios OF Ctapsp WHERE Ctapsp-usuarios.cdg_grupousr = Usuario.cdg_grupousr)
      THEN DO:
           RUN PONMENSJ.P (INPUT "ASIE030").
           RETURN NO-APPLY.
      END.
   END.
   */

   RUN crear_detalle.
   
   DISPLAY " " @ v-cdg_ctapsp
           WITH FRAME {&FRAME-NAME}.
   APPLY "ENTRY" TO v-cdg_ctapsp  IN FRAME {&FRAME-NAME}.
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
        FOR EACH T-Aps_totales WHERE T-Aps_totales.reexpresion = v-reexpresado, 
            FIRST Total-moneda OF T-Aps_totales
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
          FOR EACH T-Aps_detalle OF T-Aps_header NO-LOCK 
             WHERE T-Aps_detalle.reexpresion
               AND T-Aps_detalle.nro_moneda =  Total-moneda.nro_moneda,
                  FIRST Ctapsp OF T-Aps_detalle NO-LOCK,
                  FIRST Moneda OF T-Aps_detalle NO-LOCK,
                  FIRST Entidad OF T-Aps_detalle NO-LOCK
                        BY T-Aps_detalle.nro_linea.

      BRW-DETALLE:TITLE IN FRAME {&FRAME-NAME} = "Pases del asiento reexpresados en " + Total-moneda.descripcion.        

  END.
  ELSE DO:
      OPEN QUERY BRW-DETALLE
          FOR EACH T-Aps_detalle OF T-Aps_header NO-LOCK 
             WHERE NOT T-Aps_detalle.reexpresion,
                FIRST Ctapsp OF T-Aps_detalle NO-LOCK,
                FIRST Moneda OF T-Aps_detalle NO-LOCK,
                FIRST Entidad OF T-Aps_detalle NO-LOCK
                      BY T-Aps_detalle.nro_linea.

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

    EMPTY TEMP-TABLE T-Aps_totales.

    FOR EACH T-Aps_detalle OF T-Aps_header:
        
        FIND T-Aps_totales 
             WHERE T-Aps_totales.nro_moneda  = T-Aps_detalle.nro_moneda 
               AND T-Aps_totales.reexpresion = T-Aps_detalle.reexpresion
                   NO-ERROR.

        IF NOT AVAILABLE T-Aps_totales
        THEN DO:
             CREATE T-Aps_totales.
             ASSIGN T-Aps_totales.nro_moneda  = T-Aps_detalle.nro_moneda
                    T-Aps_totales.reexpresion = T-Aps_detalle.reexpresion.
        END.
    
        T-Aps_totales.tot_debitos  = T-Aps_totales.tot_debitos  + T-Aps_detalle.debito.
        T-Aps_totales.tot_creditos = T-Aps_totales.tot_creditos + T-Aps_detalle.credito.
    
    END.       
    
    FOR EACH T-Aps_totales:
        T-Aps_totales.diferencia = T-Aps_totales.tot_debitos - T-Aps_totales.tot_creditos.
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

    EMPTY TEMP-TABLE T-Aps_header  NO-ERROR.
    EMPTY TEMP-TABLE T-Aps_detalle NO-ERROR.
    EMPTY TEMP-TABLE T-Aps_totales NO-ERROR.

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE copiar_modelo C-Win 
PROCEDURE copiar_modelo :
/*------------------------------------------------------------------------------
  Purpose: COPIA UN ASIENTO EN BASE A UN MODELO DADO    
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
    DEFINE VARIABLE mensaje        AS CHARACTER FORMAT "X(40)".
    
    DEFINE VARIABLE total          LIKE Aps_header.tot_creditos LABEL "Total Pesos".
    DEFINE VARIABLE total_can      LIKE Aps_header.tot_creditos LABEL "Total Cantidades".
    DEFINE VARIABLE total_div      LIKE Aps_header.tot_creditos LABEL "Total Divisas".
    
    DEFINE BUTTON btn_grabar
         LABEL "&Grabar":L 
         SIZE 10 BY 0.9 FONT 4.
    
    FORM 
         mensaje NO-LABEL
         WITH FRAME frm-espere OVERLAY
              TITLE "Aguarde un momento por favor" FONT 8
              CENTERED ROW 7 FGCOLOR 14 BGCOLOR 1.
    
    FORM
        SKIP(1)
        total     COLON 20 FGCOLOR fe_c BGCOLOR be_c
        SKIP(0.2)
        total_can COLON 20 FGCOLOR fe_c BGCOLOR be_c
        SKIP(0.2)    
        total_div COLON 20 FGCOLOR fe_c BGCOLOR be_c 
        SKIP(1)
        btn_grabar
        WITH FRAME frm-totales THREE-D KEEP-TAB-ORDER FONT 8 VIEW-AS DIALOG-BOX
              SIDE-LABELS FGCOLOR f-fg_c BGCOLOR f-bg_c 
              TITLE "Valores totales de Asientos Proporcionales".
    
    FIND Amd_header WHERE ROWID(Amd_header) = rid_modelo NO-LOCK.
    IF Amd_header.modo_importes = "P"
    THEN DO:
       DISPLAY 
           total
           total_can    
           total_div
           WITH FRAME frm-totales.
       ENABLE ALL    
           WITH FRAME frm-totales.
       WAIT-FOR CHOOSE OF btn_grabar IN FRAME frm-totales.
       ASSIGN         
           total
           total_can    
           total_div.
    END.       
    
    PAUSE 0.
    mensaje = "Procediendo a copiar Asiento...".
    DISPLAY mensaje WITH FRAME frm-espere.
    
    RUN duplicar_asiento ( INPUT total,
                           INPUT total_div,
                           INPUT total_can ).

    HIDE FRAME frm-espere NO-PAUSE.
    
    RUN abre_query_detalle.
*/
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

    RUN d-detalle_asiento.w ( INPUT T-Aps_detalle.nro_ctapsp,
                              INPUT T-Aps_detalle.nro_linea,
                              INPUT T-Aps_detalle.nro_moneda,
                              INPUT T-Aps_detalle.reexpresion,
                              INPUT modo,
                              INPUT 1,
                              OUTPUT v-nro_linea).

    IF modo = MD_ALTA
    THEN DO:
  
        IF v-nro_linea <> 0
        THEN DO:
             IF NOT T-Aps_detalle.reexpresion 
                THEN RUN reexpresar_movimiento ( INPUT T-Aps_detalle.nro_linea ).
             RUN abre_query_detalle.
             APPLY "VALUE-CHANGED" TO BRW-DETALLE IN FRAME {&FRAME-NAME}.
             RUN calculos.
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

    RUN d-detalle_asiento.w ( INPUT  Ctapsp.nro_ctapsp,
                              INPUT  0, /* No sabemos el nro de linea */
                              INPUT  0, /* No sabemos la moneda       */
                              INPUT  NO, /* No es una reexpresion */
                              INPUT  modo,
                              INPUT  0, /* modo detalle = CREAR */
                              OUTPUT v-nro_linea).

    IF v-nro_linea <> 0
    THEN DO:
         RUN reexpresar_movimiento ( INPUT v-nro_linea ).
         RUN abre_query_detalle.
         APPLY "VALUE-CHANGED" TO BRW-DETALLE IN FRAME {&FRAME-NAME}.
         RUN calculos.
         btn_copiar:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
         btn_modelo:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
         v-libro:SENSITIVE    IN FRAME {&FRAME-NAME} = NO.
         T-Aps_header.fecha:SENSITIVE IN FRAME {&FRAME-NAME} = NO.

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

      CREATE T-Aps_header.
      ASSIGN T-Aps_header.nro_usuario       = Usuario.nro_usuario 
             T-Aps_header.fecha             = TODAY 
             T-Aps_header.cdg_empresa       = Empresa.cdg_empresa 
             T-Aps_header.tip_comprob       = "TAS" 
             T-Aps_header.nro_asiepsp       = 0  
             T-Aps_header.nro_comprob       = T-Aps_header.nro_asiepsp
             T-Aps_header.cdg_sigla-sic     = "GLA" 
             T-Aps_header.origen            = "M"
             T-Aps_header.cdg_estadoasiento = "I".
    
  END.

  v-reexpresado = NO.

  DISPLAY
         T-Aps_header.fecha   
         T-Aps_header.origen 
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
          T-Aps_header.tip_comprob:FGCOLOR = 9.
          T-Aps_header.tip_comprob:BGCOLOR = 15.

          T-Aps_header.nro_comprob:FGCOLOR = 9.
          T-Aps_header.nro_comprob:BGCOLOR = 15.

          T-Aps_header.prf_comprob:FGCOLOR = 9.
          T-Aps_header.prf_comprob:BGCOLOR = 15.
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
/*----------------
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

DEFINE VARIABLE sal_debito            LIKE Aps_header.tot_creditos.
DEFINE VARIABLE sal_debito_can        LIKE Aps_header.tot_creditos.
DEFINE VARIABLE sal_debito_div        LIKE Aps_header.tot_creditos.

DEFINE VARIABLE sal_credito           LIKE Aps_header.tot_creditos.
DEFINE VARIABLE sal_credito_can       LIKE Aps_header.tot_creditos.
DEFINE VARIABLE sal_credito_div       LIKE Aps_header.tot_creditos.

/*=================================================================================*/
/*                                      PROCESO                                    */
/*=================================================================================*/

DO TRANSACTION:

     ASSIGN 
          T-Aps_header.estado              = ""
          T-Aps_header.leyenda             = Amd_header.leyenda 
          T-Aps_header.origen              = "M"
          T-Aps_header.ultima_linea        = 0.
     
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
     
         CREATE T-Aps_detalle.
         ASSIGN T-Aps_header.ultima_linea     = T-Aps_header.ultima_linea + 1.
         ASSIGN T-Aps_detalle.nro_asiepsp     = T-Aps_header.nro_asiepsp
                T-Aps_detalle.fecha_mayor     = T-Aps_header.fecha                
                T-Aps_detalle.nro_linea       = T-Aps_header.ultima_linea.

         ASSIGN T-Aps_detalle.bimonetario     = Amd_detalle.bimonetario
                T-Aps_detalle.cambio          = Amd_detalle.cambio
                T-Aps_detalle.leyen_detalle   = Amd_detalle.leyen_detalle
                T-Aps_detalle.nro_ctapsp      = Amd_detalle.nro_ctapsp
                T-Aps_detalle.nro_entidad     = Amd_detalle.nro_entidad
                T-Aps_detalle.nro_obra        = Amd_detalle.nro_obra
                T-Aps_detalle.valor_unitario  = Amd_detalle.valor_unitario.

         CASE Amd_header.modo_importes:

            WHEN "L" 
            THEN DO:
                 /*
                RUN d-detalle_asiento.w (INPUT T-Aps_detalle.nro_linea, INPUT 1).
                 */
            END.
      
            WHEN "P" 
            THEN DO:
                IF NOT LAST-OF(Amd_detalle.nro_modelo)
                THEN DO:
 
                   ASSIGN 
                      T-Aps_detalle.credito      = ROUND(Amd_detalle.credito * factor,2)
                      T-Aps_detalle.credito_div  = ROUND(Amd_detalle.credito_div * factor_div,2)
                      T-Aps_detalle.debito       = ROUND(Amd_detalle.debito * factor,2)
                      T-Aps_detalle.debito_div   = ROUND(Amd_detalle.debito_div * factor_div,2).
 
                   ASSIGN 
                      sal_credito     = sal_credito     - T-Aps_detalle.credito
                      sal_credito_div = sal_credito_div - T-Aps_detalle.credito_div
                      sal_debito      = sal_debito      - T-Aps_detalle.debito
                      sal_debito_div  = sal_debito_div  - T-Aps_detalle.debito_div.
                      
                END.              
                ELSE DO:
                   ASSIGN 
                      T-Aps_detalle.credito          = sal_credito
                      T-Aps_detalle.credito_div      = sal_credito_div
                      T-Aps_detalle.debito           = sal_debito
                      T-Aps_detalle.debito_div       = sal_debito_div.
                   ASSIGN
                      T-Aps_header.tot_debitos       = total   
                      T-Aps_header.tot_creditos      = total
                      T-Aps_header.tot_debitos_div   = total_div   
                      T-Aps_header.tot_creditos_div  = total_div.
                END.
            END.
      
            WHEN "F" 
            THEN DO:
                ASSIGN T-Aps_detalle.credito      = Amd_detalle.credito
                       T-Aps_detalle.credito_can  = Amd_detalle.credito_can
                       T-Aps_detalle.credito_div  = Amd_detalle.credito_div
                       T-Aps_detalle.debito       = Amd_detalle.debito
                       T-Aps_detalle.debito_can   = Amd_detalle.debito_can
                       T-Aps_detalle.debito_div   = Amd_detalle.debito_div.
            END.

         END CASE.


     END. /* De los detalles de ASIENTO MODELO */

END.
------------------------------*/
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
  DISPLAY v-anulado v-estado v-reexpresado v-libro v-cdg_ctapsp 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE T-Aps_detalle THEN 
    DISPLAY T-Aps_detalle.leyen_detalle 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE T-Aps_header THEN 
    DISPLAY T-Aps_header.tip_comprob T-Aps_header.prf_comprob 
          T-Aps_header.nro_comprob T-Aps_header.fecha T-Aps_header.cambio_dolar 
          T-Aps_header.cambio T-Aps_header.leyenda T-Aps_header.origen 
          T-Aps_header.nro_secuencia T-Aps_header.cdg_sigla-sic 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE Btn_salir T-Aps_header.fecha T-Aps_header.cambio T-Aps_header.leyenda 
         BRW-ACUMULADOS BRW-DETALLE RECT-2 RECT-3 RECT-4 RECT-5 RECT-6 RECT-7 
         RECT-8 RECT-9 
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
                T-Aps_header.tip_comprob:SENSITIVE    = NO
                T-Aps_header.prf_comprob:SENSITIVE    = NO
                T-Aps_header.nro_comprob:SENSITIVE    = NO
                T-Aps_header.fecha:SENSITIVE          = NO
                T-Aps_header.leyenda:SENSITIVE        = NO
                T-Aps_header.cambio:SENSITIVE         = NO
                T-Aps_header.cambio_dolar:SENSITIVE   = NO
                v-cdg_ctapsp:SENSITIVE                = NO
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
                T-Aps_header.tip_comprob:SENSITIVE    = NO
                T-Aps_header.nro_comprob:SENSITIVE    = NO
                T-Aps_header.fecha:SENSITIVE          = NO
                T-Aps_header.leyenda:SENSITIVE        = NO
                v-cdg_ctapsp:SENSITIVE                = NO
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
                         v-cdg_ctapsp:SENSITIVE                = YES
                         T-Aps_header.fecha:SENSITIVE          = YES
                         T-Aps_header.leyenda:SENSITIVE        = YES
                         btn_modelo:SENSITIVE                  = YES
                         btn_revertir:SENSITIVE                = YES
                         v-libro:SENSITIVE                     = NUM-ENTRIES(v-libro:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME}) > 2
                         v-reexpresado:SENSITIVE               = YES.
         
                END.
                WHEN MD_MULTIPLE      
                THEN DO:
                     ASSIGN
                         T-Aps_header.nro_comprob:SENSITIVE    = YES
                         T-Aps_header.prf_comprob:SENSITIVE    = YES
                         T-Aps_header.tip_comprob:SENSITIVE    = YES.
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
                         v-cdg_ctapsp:SENSITIVE                = NO
                         T-Aps_header.fecha:SENSITIVE          = NO
                         T-Aps_header.leyenda:SENSITIVE        = NO.
                END.
                WHEN MD_ANULACION        
                THEN DO:
                     ASSIGN
                         T-Aps_header.nro_comprob:SENSITIVE    = YES
                         T-Aps_header.prf_comprob:SENSITIVE    = YES
                         T-Aps_header.tip_comprob:SENSITIVE    = YES.
         
                END.
                WHEN MD_EMISION        
                THEN DO:
                     ASSIGN
                         T-Aps_header.nro_comprob:SENSITIVE    = YES
                         T-Aps_header.prf_comprob:SENSITIVE    = YES
                         T-Aps_header.tip_comprob:SENSITIVE    = YES.
         
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
  
       CREATE Aps_header.
       BUFFER-COPY T-Aps_header TO Aps_header
           ASSIGN  Aps_header.nro_asiepsp = NEXT-VALUE(proximo_asiento) 
                   Aps_header.tip_comprob = "AS"
                   Aps_header.nro_comprob = Parametro.valor_n.
  
       FOR EACH T-Aps_detalle:
           CREATE Aps_detalle.
           BUFFER-COPY T-Aps_detalle TO Aps_detalle
               ASSIGN  Aps_detalle.nro_asiepsp = Aps_header.nro_asiepsp.
           DELETE T-Aps_detalle.
       END.

       FOR EACH T-Aps_totales:
           CREATE Aps_totales.
           BUFFER-COPY T-Aps_totales TO Aps_totales
               ASSIGN  Aps_totales.nro_asiepsp = Aps_header.nro_asiepsp.
           DELETE T-Aps_totales.
       END.
      
       Parametro.valor_n = Parametro.valor_n + 1.

       {crearauditoria.i}

       RELEASE Parametro.
*/
       RUN emitir_asiento.p ( INPUT TABLE T-Aps_header,
                              INPUT TABLE T-Aps_detalle,
                              INPUT TABLE T-Aps_totales).
       
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
           v-cdg_ctapsp:SENSITIVE                = NO
           v-reexpresado:SENSITIVE               = NO
           v-libro:SENSITIVE                     = NO
           T-Aps_header.fecha:SENSITIVE          = NO
           T-Aps_header.cambio:SENSITIVE         = NO
           T-Aps_header.cambio_dolar:SENSITIVE   = NO
           T-Aps_header.leyenda:SENSITIVE        = NO
           T-Aps_header.nro_comprob:SENSITIVE    = NO
           T-Aps_header.prf_comprob:SENSITIVE    = NO
           T-Aps_header.tip_comprob:SENSITIVE    = NO
           v-reexpresado:SENSITIVE               = NO.

     CASE modo:

       WHEN MD_ALTA          
       THEN DO:
            ASSIGN
                btn_grabar:SENSITIVE                  = YES
                btn_cancel:SENSITIVE                  = YES
                btn_observ:SENSITIVE                  = YES
                v-cdg_ctapsp:SENSITIVE                = YES
                v-reexpresado:SENSITIVE               = YES
                v-libro:SENSITIVE                     = YES
                T-Aps_header.fecha:SENSITIVE          = YES
                T-Aps_header.leyenda:SENSITIVE        = YES.

       END.
       WHEN MD_MULTIPLE      
       THEN DO:
            ASSIGN
                btn_cancel:SENSITIVE                  = YES
                btn_observ:SENSITIVE                  = YES
                btn_imprim:SENSITIVE                  = YES
                v-reexpresado:SENSITIVE               = YES.

       END.
       WHEN MD_DEFINIDA      
       THEN DO:
            ASSIGN
                btn_observ:SENSITIVE                  = YES
                btn_imprim:SENSITIVE                  = YES
                v-reexpresado:SENSITIVE                    = YES.

       END.
       WHEN MD_RELACION      
       THEN DO:
            ASSIGN
                btn_observ:SENSITIVE                  = YES
                btn_imprim:SENSITIVE                  = YES
                v-reexpresado:SENSITIVE                    = YES.

       END.
       WHEN MD_READONLY      
       THEN DO:
            ASSIGN
                btn_observ:SENSITIVE                  = YES
                btn_imprim:SENSITIVE                  = YES
                v-reexpresado:SENSITIVE                    = YES.
       END.
       WHEN MD_CAMBIO        
       THEN DO:
            ASSIGN
                btn_observ:SENSITIVE                  = YES
                btn_imprim:SENSITIVE                  = YES
                v-reexpresado:SENSITIVE                    = YES.
       END.
       WHEN MD_ANULACION        
       THEN DO:
            ASSIGN
                btn_observ:SENSITIVE                  = YES
                btn_imprim:SENSITIVE                  = YES
                btn_anular:SENSITIVE                  = YES
                v-reexpresado:SENSITIVE                    = YES.
       END.
       WHEN MD_EMISION        
       THEN DO:
            ASSIGN
                btn_grabar:SENSITIVE                  = YES
                btn_cancel:SENSITIVE                  = YES
                btn_observ:SENSITIVE                  = YES
                btn_imprim:SENSITIVE                  = YES
                v-reexpresado:SENSITIVE                    = YES.
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


    RUN titulo_window ( INPUT "Asientos de Presupuesto" ).           

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
    FOR EACH T-Aps_detalle:
        T-Aps_detalle.cambio_dolar  = T-Aps_header.cambio_dolar.
        T-Aps_detalle.cambio        = T-Aps_header.cambio.
        T-Aps_detalle.debito        = ROUND(T-Aps_detalle.debito_div * T-Aps_detalle.cambio,2). 
        T-Aps_detalle.credito       = ROUND(T-Aps_detalle.credito_div * T-Aps_detalle.cambio,2). 
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
         T-Aps_header.cambio_dolar = 1.
         T-Aps_header.cambio_dolar:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
    END.
    ELSE DO:
         FIND LAST Cotizacion OF Dolar
              WHERE Cotizacion.cdg_empresa    = T-Aps_header.cdg_empresa
                AND Cotizacion.fch_cotizacion <= T-Aps_header.fecha.
         T-Aps_header.cambio_dolar = Cotizacion.cambio.
    END.

    DISPLAY 
         T-Aps_header.cambio_dolar
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

  FIND Estado_asiento OF T-Aps_header NO-LOCK.
  v-estado = Estado_asiento.dsc_estadoasiento.
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

      ASSIGN T-Aps_header.cdg_librocontable = Librocontable.cdg_librocontable.

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
        ASSIGN T-Aps_header.nro_moneda = Moneda.nro_moneda.
        FIND LAST Cotizacion OF Moneda
            WHERE Cotizacion.cdg_empresa    = T-Aps_header.cdg_empresa
              AND Cotizacion.fch_cotizacion <= T-Aps_header.fecha.
        T-Aps_header.cambio = Cotizacion.cambio.
    
        DISPLAY 
             T-Aps_header.cambio
             WITH FRAME {&FRAME-NAME}. 
    END.     
    ELSE DO:
        T-Aps_header.cambio:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
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

  DEFINE INPUT PARAMETER p-que_linea LIKE Aps_detalle.nro_linea.

  FIND FIRST T-Aps_detalle 
       WHERE T-Aps_detalle.nro_asiepsp = 0 
         AND T-Aps_detalle.nro_linea   = p-que_linea
         AND T-Aps_detalle.reexpresion = NO.

  FOR EACH Ctapsp-moneda 
      WHERE Ctapsp-moneda.nro_ctapsp = T-Aps_detalle.nro_ctapsp 
        AND Ctapsp-moneda.reexpresa_saldos: 

      FIND T-Reexpresion 
           WHERE T-Reexpresion.nro_asiepsp = T-Aps_detalle.nro_asiepsp
             AND T-Reexpresion.nro_linea   = T-Aps_detalle.nro_linea
             AND T-Reexpresion.nro_moneda  = Ctapsp-moneda.nro_moneda
             AND T-Reexpresion.reexpresion
                 EXCLUSIVE-LOCK NO-ERROR.

      IF NOT AVAILABLE T-Reexpresion
      THEN DO:
           CREATE T-Reexpresion.
           BUFFER-COPY T-Aps_detalle TO T-Reexpresion
                ASSIGN T-Reexpresion.nro_moneda  = Ctapsp-moneda.nro_moneda
                       T-Reexpresion.reexpresion = YES.

           IF Ctapsp-moneda.nro_moneda <> T-Aps_detalle.nro_moneda
           THEN DO:       
                FIND LAST Cotizacion
                     WHERE Cotizacion.cdg_empresa    = T-Aps_header.cdg_empresa
                       AND Cotizacion.nro_moneda = Ctapsp-moneda.nro_moneda
                       AND Cotizacion.fch_cotizacion <= T-Aps_header.fecha.
                T-Reexpresion.cambio = Cotizacion.cambio.
           END.

           /*---------------------------------------------------------------------------
           FIND LAST Cotizacion OF Moneda
               WHERE Cotizacion.cdg_empresa    = T-Aps_header.cdg_empresa
                 AND Cotizacion.fch_cotizacion <= T-Aps_header.fecha.
           T-Reexpresion.cambio = Cotizacion.cambio.
           ----------------------------------------------------------------------------*/

      END.           

      T-Reexpresion.debito  = T-Aps_detalle.debito  * ( T-Aps_detalle.cambio / T-Reexpresion.cambio) .
      T-Reexpresion.credito = T-Aps_detalle.credito * ( T-Aps_detalle.cambio / T-Reexpresion.cambio) .


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
    FOR EACH T-Aps_detalle, Moneda OF T-Aps_detalle:

        IF Moneda.es_local
        THEN DO:
             T-Aps_header.cambio = 1.
             T-Aps_header.cambio:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
        END.
        ELSE DO:
             T-Aps_header.cambio:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
             FIND LAST Cotizacion OF Moneda
                  WHERE Cotizacion.cdg_empresa    = T-Aps_header.cdg_empresa
                    AND Cotizacion.fch_cotizacion <= T-Aps_header.fecha.
             T-Aps_header.cambio = Cotizacion.cambio.
        END.

        T-Aps_detalle.debito     = ROUND(T-Aps_detalle.debito_div * T-Aps_header.cambio,2). 
        T-Aps_detalle.credito    = ROUND(T-Aps_detalle.credito_div * T-Aps_header.cambio,2). 

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
     FOR EACH T-Aps_detalle:
         a-credito = T-Aps_detalle.credito.
         T-Aps_detalle.credito = T-Aps_detalle.debito.
         T-Aps_detalle.debito = a-credito.
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

   FIND Aps_header WHERE ROWID(Aps_header) = rid_asiento NO-LOCK.
   BUFFER-COPY Aps_header TO T-Aps_header.

   FOR EACH Aps_detalle OF Aps_header:
       CREATE T-Aps_detalle.
       BUFFER-COPY Aps_detalle TO T-Aps_detalle.
   END.    

   FOR EACH Aps_totales OF Aps_header:
       CREATE T-Aps_totales.
       BUFFER-COPY Aps_totales TO T-Aps_totales.
   END.    

   v-anulado = IF T-Aps_header.anulado
                  THEN "A"
                  ELSE "".

   DISPLAY
        T-Aps_header.tip_comprob 
        T-Aps_header.prf_comprob 
        T-Aps_header.nro_comprob 
        T-Aps_header.fecha 
        v-anulado
        T-Aps_header.cdg_sigla-sic 
        T-Aps_header.nro_secuencia 
        T-Aps_header.origen 
        T-Aps_header.leyenda
        WITH FRAME {&FRAME-NAME}.

   RUN poner_estado.
   /*
   ASSIGN T-Aps_header.tip_comprob:SENSITIVE IN FRAME {&FRAME-NAME} = NO 
          T-Aps_header.prf_comprob:SENSITIVE IN FRAME {&FRAME-NAME} = NO 
          T-Aps_header.nro_comprob:SENSITIVE IN FRAME {&FRAME-NAME} = NO
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
    
    IF NOT CAN-FIND(FIRST T-Aps_detalle OF  T-Aps_header)
    THEN DO:
       RUN PONMENSJ.P (INPUT "ASIE005").
       RETURN.
    END.

    IF CAN-FIND(FIRST T-Aps_totales WHERE T-Aps_totales.diferencia <> 0 AND T-Aps_totales.reexpresion)
    THEN DO:
       RUN PONMENSJ.P ( INPUT "ASIE011" ).
       RETURN.
    END.

    FIND FIRST Periodo_fiscal WHERE Periodo_fiscal.cdg_empresa = T-Aps_header.cdg_empresa
                                AND Periodo_fiscal.ano         = YEAR(T-Aps_header.fecha)
                                AND Periodo_fiscal.mes         = MONTH(T-Aps_header.fecha) 
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

