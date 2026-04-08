&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win

/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE CC_destino NO-UNDO LIKE Cta_cte
       FIELD saldo_comprobante LIKE CC_Destino.credito
       FIELD saldo_equivalente LIKE CC_Destino.credito
       FIELD cambio_destino    LIKE CC_Destino.cambio
       FIELD diferencia_cambio LIKE CC_Destino.credito
       .
DEFINE TEMP-TABLE CC_origen NO-UNDO LIKE Cta_cte
       FIELD saldo_comprobante LIKE CC_Origen.credito
       FIELD saldo_original LIKE CC_Origen.credito.
DEFINE BUFFER Moneda_destino FOR Moneda.
DEFINE BUFFER Moneda_origen FOR Moneda.


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

/* Local Variable Definitions ---                                       */

{NRORELEA.I}

DEFINE VARIABLE rid_documento             AS   ROWID.
DEFINE VARIABLE rid_tabla                 AS   ROWID.
DEFINE VARIABLE mensaje                   AS   CHARACTER FORMAT "X(40)".
DEFINE VARIABLE saldo_origen              LIKE Cta_cte.debito.
DEFINE VARIABLE saldo_destino             LIKE Cta_cte.credito.

DEFINE VARIABLE que_empresa               LIKE Empresa.cdg_empresa.

DEFINE VARIABLE v-cambio_origen           LIKE Moneda.cambio.
DEFINE VARIABLE v-pto_venta-org           AS INTEGER.

DEFINE TEMP-TABLE T-Fac_header            NO-UNDO LIKE Fac_header.
DEFINE TEMP-TABLE T-Fac_detalle           NO-UNDO LIKE Fac_detalle.
DEFINE TEMP-TABLE T-Sub_header_vta        NO-UNDO LIKE Sub_header_vta.
DEFINE TEMP-TABLE T-Sub_detalle_vta       NO-UNDO LIKE Sub_detalle_vta.
DEFINE TEMP-TABLE T-Fac_header_impuesto   NO-UNDO LIKE Fac_header_impuesto.
DEFINE TEMP-TABLE T-Fac_detalle_impuesto  NO-UNDO LIKE Fac_detalle_impuesto.
DEFINE TEMP-TABLE T-Fac_header-bon        NO-UNDO LIKE Fac_header-bon.
DEFINE TEMP-TABLE T-Fac_detalle-bon       NO-UNDO LIKE Fac_detalle-bon.

DEFINE BUFFER B-Sub_header_vta            FOR T-Sub_header_vta.
DEFINE BUFFER B-Sub_detalle_vta           FOR T-Sub_detalle_vta.
DEFINE BUFFER Moneda_local                FOR Moneda.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME BROWSE_DESTINO

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES CC_destino CC_origen

/* Definitions for BROWSE BROWSE_DESTINO                                */
&Scoped-define FIELDS-IN-QUERY-BROWSE_DESTINO CC_destino.tip_comprob ~
CC_destino.prf_comprob CC_destino.nro_comprob CC_destino.nro_vencimiento ~
CC_Destino.saldo_comprobante CC_destino.cambio CC_Destino.saldo_equivalente 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE_DESTINO 
&Scoped-define QUERY-STRING-BROWSE_DESTINO FOR EACH CC_destino ~
      WHERE CC_destino.credito > CC_destino.debito NO-LOCK
&Scoped-define OPEN-QUERY-BROWSE_DESTINO OPEN QUERY BROWSE_DESTINO FOR EACH CC_destino ~
      WHERE CC_destino.credito > CC_destino.debito NO-LOCK.
&Scoped-define TABLES-IN-QUERY-BROWSE_DESTINO CC_destino
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE_DESTINO CC_destino


/* Definitions for BROWSE BROWSE_ORIGEN                                 */
&Scoped-define FIELDS-IN-QUERY-BROWSE_ORIGEN CC_origen.tip_comprob ~
CC_origen.prf_comprob CC_origen.nro_comprob CC_origen.nro_vencimiento ~
CC_origen.fecha_emision CC_Origen.saldo_comprobante CC_origen.cambio 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE_ORIGEN 
&Scoped-define QUERY-STRING-BROWSE_ORIGEN FOR EACH CC_origen ~
      WHERE NOT CC_origen.selectado NO-LOCK
&Scoped-define OPEN-QUERY-BROWSE_ORIGEN OPEN QUERY BROWSE_ORIGEN FOR EACH CC_origen ~
      WHERE NOT CC_origen.selectado NO-LOCK.
&Scoped-define TABLES-IN-QUERY-BROWSE_ORIGEN CC_origen
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE_ORIGEN CC_origen


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-BROWSE_DESTINO}~
    ~{&OPEN-QUERY-BROWSE_ORIGEN}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-1 RECT-2 RECT-3 RECT-4 RECT-6 RECT-7 ~
RECT-8 v-cdg_cliente v-fecha_transferencia Btn_Done v-pago_parcial ~
BROWSE_ORIGEN BROWSE_DESTINO 
&Scoped-Define DISPLAYED-OBJECTS v-cdg_cliente v-dsc_cliente ~
v-fecha_transferencia v-pto_venta v-nro_monedaorigen v-nro_monedadestino ~
v-cambio_destino t_movdeb t_regdeb t_movcre t_regcre v-monto_equivalente ~
v-diferencia_cambio v-importe_total v-pago_parcial v-cdg_cndventa v-estado 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btn_compensar 
     LABEL "&Transferir" 
     SIZE 14 BY 1.19.

DEFINE BUTTON Btn_Done DEFAULT 
     LABEL "&Salir" 
     SIZE 14 BY 1.24
     BGCOLOR 8 .

DEFINE VARIABLE v-cdg_cndventa AS CHARACTER FORMAT "X(256)":U 
     LABEL "Condición de Venta" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Item 1","Item 1"
     DROP-DOWN-LIST
     SIZE 51 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-nro_monedadestino AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Item 1",0
     DROP-DOWN-LIST
     SIZE 57 BY 1
     BGCOLOR 9 FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE v-nro_monedaorigen AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Item 1",0
     DROP-DOWN-LIST
     SIZE 74 BY 1
     BGCOLOR 9 FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE t_movcre AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     LABEL "$" 
     VIEW-AS FILL-IN 
     SIZE 18.6 BY 1
     BGCOLOR 15 FGCOLOR 12 FONT 4 NO-UNDO.

DEFINE VARIABLE t_movdeb AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     LABEL "$" 
     VIEW-AS FILL-IN 
     SIZE 18.6 BY 1
     BGCOLOR 15 FGCOLOR 12 FONT 4 NO-UNDO.

DEFINE VARIABLE t_regcre AS INTEGER FORMAT ">>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 6.2 BY 1
     BGCOLOR 15 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE t_regdeb AS INTEGER FORMAT ">>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 6.6 BY 1
     BGCOLOR 15 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE v-cambio_destino AS DECIMAL FORMAT "->>,>>9.9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cdg_cliente AS CHARACTER FORMAT "X(8)" 
     LABEL "Cliente" 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-diferencia_cambio AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18.6 BY 1
     BGCOLOR 12 FGCOLOR 15 FONT 4 NO-UNDO.

DEFINE VARIABLE v-dsc_cliente AS CHARACTER FORMAT "X(40)" 
     VIEW-AS FILL-IN 
     SIZE 65 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-estado AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 58 BY .95
     BGCOLOR 1 FGCOLOR 14 FONT 6 NO-UNDO.

DEFINE VARIABLE v-fecha_transferencia AS DATE FORMAT "99/99/99":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 6 NO-UNDO.

DEFINE VARIABLE v-importe_total AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18.6 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE v-monto_equivalente AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18.6 BY 1
     BGCOLOR 9 FGCOLOR 15 FONT 4 NO-UNDO.

DEFINE VARIABLE v-pago_parcial AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     LABEL "Ingrese Cancelación Parcial" 
     VIEW-AS FILL-IN 
     SIZE 26 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-pto_venta AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 7 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 74.2 BY 1.67.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 74.2 BY 1.67.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 93 BY 1.67.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 26 BY 1.67.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 31 BY 1.67.

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 74 BY 1.43.

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 74 BY 1.43.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE_DESTINO FOR 
      CC_destino SCROLLING.

DEFINE QUERY BROWSE_ORIGEN FOR 
      CC_origen SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE_DESTINO
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE_DESTINO C-Win _STRUCTURED
  QUERY BROWSE_DESTINO NO-LOCK DISPLAY
      CC_destino.tip_comprob FORMAT "X(3)":U WIDTH 4.2
      CC_destino.prf_comprob FORMAT "9999":U
      CC_destino.nro_comprob FORMAT "ZZZZZZZ9":U
      CC_destino.nro_vencimiento FORMAT ">>9":U WIDTH 2.2
      CC_Destino.saldo_comprobante COLUMN-LABEL "Saldo!Comprobante" FORMAT "->>>,>>>,>>9.99":U
      CC_destino.cambio COLUMN-LABEL "Cambio!Original" FORMAT "->>,>>9.9999":U
      CC_Destino.saldo_equivalente COLUMN-LABEL "Saldo!Equivalente" FORMAT "->>>,>>>,>>9.99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 74 BY 15.48
         BGCOLOR 15 FONT 4
         TITLE BGCOLOR 15 "Movimientos SELECCIONADOS".

DEFINE BROWSE BROWSE_ORIGEN
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE_ORIGEN C-Win _STRUCTURED
  QUERY BROWSE_ORIGEN NO-LOCK DISPLAY
      CC_origen.tip_comprob FORMAT "X(3)":U WIDTH 5.2
      CC_origen.prf_comprob FORMAT "9999":U
      CC_origen.nro_comprob FORMAT "ZZZZZZZ9":U
      CC_origen.nro_vencimiento FORMAT ">>9":U
      CC_origen.fecha_emision FORMAT "99/99/9999":U
      CC_Origen.saldo_comprobante COLUMN-LABEL "Saldo!Comprobante" FORMAT "->>>,>>>,>>9.99":U
      CC_origen.cambio COLUMN-LABEL "Valor de!Cambio" FORMAT "->>,>>9.9999":U
            WIDTH 13.6
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS MULTIPLE SIZE 74 BY 15.48
         BGCOLOR 15 FGCOLOR 9 FONT 4
         TITLE BGCOLOR 15 FGCOLOR 9 "Movimientos DISPONIBLES".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     v-cdg_cliente AT ROW 3.14 COL 12 COLON-ALIGNED
     v-dsc_cliente AT ROW 3.14 COL 30 COLON-ALIGNED NO-LABEL
     v-fecha_transferencia AT ROW 3.14 COL 98 COLON-ALIGNED NO-LABEL
     v-pto_venta AT ROW 3.14 COL 113 COLON-ALIGNED NO-LABEL
     btn_compensar AT ROW 3.14 COL 127
     Btn_Done AT ROW 3.14 COL 142
     v-nro_monedaorigen AT ROW 6 COL 3 COLON-ALIGNED NO-LABEL
     v-nro_monedadestino AT ROW 6 COL 81 COLON-ALIGNED NO-LABEL
     v-cambio_destino AT ROW 6 COL 139 COLON-ALIGNED NO-LABEL
     t_movdeb AT ROW 8.62 COL 6 COLON-ALIGNED
     t_regdeb AT ROW 8.62 COL 26 COLON-ALIGNED NO-LABEL
     t_movcre AT ROW 8.62 COL 49.8 COLON-ALIGNED
     t_regcre AT ROW 8.62 COL 69.8 COLON-ALIGNED NO-LABEL
     v-monto_equivalente AT ROW 8.62 COL 84 COLON-ALIGNED NO-LABEL
     v-diferencia_cambio AT ROW 8.62 COL 111 COLON-ALIGNED NO-LABEL
     v-importe_total AT ROW 8.62 COL 136 COLON-ALIGNED NO-LABEL
     v-pago_parcial AT ROW 10.29 COL 50 COLON-ALIGNED
     v-cdg_cndventa AT ROW 10.29 COL 103 COLON-ALIGNED
     BROWSE_ORIGEN AT ROW 11.71 COL 5
     BROWSE_DESTINO AT ROW 11.71 COL 83
     v-estado AT ROW 18.38 COL 52 COLON-ALIGNED NO-LABEL
     "    ImporteTotal" VIEW-AS TEXT
          SIZE 21 BY 1 AT ROW 7.19 COL 136
          BGCOLOR 5 FGCOLOR 15 FONT 6
     "       Total seleccionado" VIEW-AS TEXT
          SIZE 29.8 BY 1 AT ROW 7.19 COL 49
          BGCOLOR 5 FGCOLOR 15 FONT 6
     "=" VIEW-AS TEXT
          SIZE 3 BY .86 AT ROW 8.62 COL 134
          FONT 6
     "+" VIEW-AS TEXT
          SIZE 2 BY .95 AT ROW 8.62 COL 108
          FONT 6
     "  Fecha y Ctro. Emisor" VIEW-AS TEXT
          SIZE 26 BY 1 AT ROW 1.71 COL 99
          BGCOLOR 5 FGCOLOR 15 FONT 6
     "  Diferencia de Cambio" VIEW-AS TEXT
          SIZE 27 BY 1 AT ROW 7.19 COL 108
          BGCOLOR 5 FGCOLOR 15 FONT 6
     "  Monto Equivalente" VIEW-AS TEXT
          SIZE 24 BY 1 AT ROW 7.19 COL 83
          BGCOLOR 5 FGCOLOR 15 FONT 6
     "         Total Disponible" VIEW-AS TEXT
          SIZE 31 BY 1 AT ROW 7.19 COL 5
          BGCOLOR 5 FGCOLOR 15 FONT 6
     "   Cliente cuyos movimientos se desea transferir" VIEW-AS TEXT
          SIZE 93 BY 1 AT ROW 1.71 COL 5
          BGCOLOR 5 FGCOLOR 15 FONT 6
     "        Moneda de destino de los movimientos y cambio actual" VIEW-AS TEXT
          SIZE 74 BY 1 AT ROW 4.81 COL 83
          BGCOLOR 5 FGCOLOR 15 FONT 6
     "        Moneda de origen de los movimientos y cambio actual" VIEW-AS TEXT
          SIZE 74 BY 1 AT ROW 4.81 COL 5
          BGCOLOR 5 FGCOLOR 15 FONT 6
     "             Acciones" VIEW-AS TEXT
          SIZE 31 BY 1 AT ROW 1.71 COL 126
          BGCOLOR 5 FGCOLOR 15 FONT 6
     RECT-1 AT ROW 8.29 COL 5
     RECT-2 AT ROW 8.29 COL 83.2
     RECT-3 AT ROW 2.91 COL 5
     RECT-4 AT ROW 2.91 COL 99
     RECT-6 AT ROW 2.91 COL 126
     RECT-7 AT ROW 10.05 COL 5
     RECT-8 AT ROW 10.05 COL 83
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 158 BY 26.19
         FONT 4.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: CC_destino T "?" NO-UNDO sic Cta_cte
      ADDITIONAL-FIELDS:
          FIELD saldo_comprobante LIKE CC_Destino.credito
          FIELD saldo_equivalente LIKE CC_Destino.credito
          FIELD cambio_destino    LIKE CC_Destino.cambio
          FIELD diferencia_cambio LIKE CC_Destino.credito
          
      END-FIELDS.
      TABLE: CC_origen T "?" NO-UNDO sic Cta_cte
      ADDITIONAL-FIELDS:
          FIELD saldo_comprobante LIKE CC_Origen.credito
          FIELD saldo_original LIKE CC_Origen.credito
      END-FIELDS.
      TABLE: Moneda_destino B "?" ? sic Moneda
      TABLE: Moneda_origen B "?" ? sic Moneda
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Transferencia de saldos entre monedas"
         HEIGHT             = 26.19
         WIDTH              = 158
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
/* BROWSE-TAB BROWSE_ORIGEN v-cdg_cndventa DEFAULT-FRAME */
/* BROWSE-TAB BROWSE_DESTINO BROWSE_ORIGEN DEFAULT-FRAME */
/* SETTINGS FOR BUTTON btn_compensar IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN t_movcre IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN t_movdeb IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN t_regcre IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN t_regdeb IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cambio_destino IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX v-cdg_cndventa IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-diferencia_cambio IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_cliente IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-estado IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-importe_total IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-monto_equivalente IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX v-nro_monedadestino IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX v-nro_monedaorigen IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-pto_venta IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE_DESTINO
/* Query rebuild information for BROWSE BROWSE_DESTINO
     _TblList          = "sic.CC_destino"
     _Options          = "NO-LOCK"
     _Where[1]         = "CC_destino.credito > CC_destino.debito"
     _FldNameList[1]   > Temp-Tables.CC_destino.tip_comprob
"CC_destino.tip_comprob" ? ? "character" ? ? ? ? ? ? no ? no no "4.2" yes no no "U" "" ""
     _FldNameList[2]   = Temp-Tables.CC_destino.prf_comprob
     _FldNameList[3]   = Temp-Tables.CC_destino.nro_comprob
     _FldNameList[4]   > Temp-Tables.CC_destino.nro_vencimiento
"CC_destino.nro_vencimiento" ? ? "integer" ? ? ? ? ? ? no ? no no "2.2" yes no no "U" "" ""
     _FldNameList[5]   > "_<CALC>"
"CC_Destino.saldo_comprobante" "Saldo!Comprobante" "->>>,>>>,>>9.99" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[6]   > Temp-Tables.CC_destino.cambio
"CC_destino.cambio" "Cambio!Original" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[7]   > "_<CALC>"
"CC_Destino.saldo_equivalente" "Saldo!Equivalente" "->>>,>>>,>>9.99" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _Query            is OPENED
*/  /* BROWSE BROWSE_DESTINO */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE_ORIGEN
/* Query rebuild information for BROWSE BROWSE_ORIGEN
     _TblList          = "CC_origen"
     _Options          = "NO-LOCK"
     _Where[1]         = "NOT CC_origen.selectado"
     _FldNameList[1]   > Temp-Tables.CC_origen.tip_comprob
"CC_origen.tip_comprob" ? ? "character" ? ? ? ? ? ? no ? no no "5.2" yes no no "U" "" ""
     _FldNameList[2]   = Temp-Tables.CC_origen.prf_comprob
     _FldNameList[3]   = Temp-Tables.CC_origen.nro_comprob
     _FldNameList[4]   = Temp-Tables.CC_origen.nro_vencimiento
     _FldNameList[5]   = Temp-Tables.CC_origen.fecha_emision
     _FldNameList[6]   > "_<CALC>"
"CC_Origen.saldo_comprobante" "Saldo!Comprobante" "->>>,>>>,>>9.99" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[7]   > Temp-Tables.CC_origen.cambio
"CC_origen.cambio" "Valor de!Cambio" ? "decimal" ? ? ? ? ? ? no ? no no "13.6" yes no no "U" "" ""
     _Query            is OPENED
*/  /* BROWSE BROWSE_ORIGEN */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Transferencia de saldos entre monedas */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Transferencia de saldos entre monedas */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE_DESTINO
&Scoped-define SELF-NAME BROWSE_DESTINO
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE_DESTINO C-Win
ON MOUSE-SELECT-DBLCLICK OF BROWSE_DESTINO IN FRAME DEFAULT-FRAME /* Movimientos SELECCIONADOS */
OR "RETURN" OF BROWSE_DESTINO IN FRAME {&FRAME-NAME}
DO:
    DEFINE VARIABLE x-cambio LIKE Cta_cte.cambio.
    
    IF NOT AVAILABLE CC_destino
    THEN DO:
        BELL.
        MESSAGE "La lista de documentos SELECCIONADOS está vacía"
            VIEW-AS ALERT-BOX ERROR BUTTONS OK.
        RETURN NO-APPLY.
    END.

   /* Mueve un registro de una tabla a otra */

    FIND CC_Origen 
      WHERE CC_Origen.cdg_empresa     = CC_Destino.cdg_empresa    
        AND CC_Origen.tip_comprob     = CC_Destino.tip_comprob    
        AND CC_Origen.prf_comprob     = CC_Destino.prf_comprob    
        AND CC_Origen.nro_comprob     = CC_Destino.nro_comprob    
        AND CC_Origen.nro_vencimiento = CC_Destino.nro_vencimiento.
    
    ASSIGN CC_Origen.selectado = NO.
    
    DELETE CC_Destino.
    
    RUN abre_query_origen.
    RUN abre_query_destino.

    RUN habilitar_combos_monedas ( INPUT NOT CAN-FIND(FIRST CC_Destino) ).

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE_ORIGEN
&Scoped-define SELF-NAME BROWSE_ORIGEN
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE_ORIGEN C-Win
ON MOUSE-SELECT-DBLCLICK OF BROWSE_ORIGEN IN FRAME DEFAULT-FRAME /* Movimientos DISPONIBLES */
OR "RETURN" OF BROWSE_ORIGEN IN FRAME {&FRAME-NAME}
DO:

  IF NOT AVAILABLE CC_origen 
  THEN DO:
     BELL.
     MESSAGE "La lista de documentos DISPONIBLES está vacía"
       VIEW-AS ALERT-BOX ERROR BUTTONS OK.
     RETURN NO-APPLY.
  END.

  /* Mueve un registro de una tabla a otra */

  CREATE CC_Destino.
  BUFFER-COPY CC_Origen TO CC_Destino
      ASSIGN CC_Destino.nro_moneda = v-nro_monedadestino
             CC_Origen.selectado = YES.

  RUN abre_query_origen.
  RUN abre_query_destino.

  RUN habilitar_combos_monedas ( INPUT NO ).

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE_ORIGEN C-Win
ON VALUE-CHANGED OF BROWSE_ORIGEN IN FRAME DEFAULT-FRAME /* Movimientos DISPONIBLES */
DO:
  v-pago_parcial = CC_Origen.saldo_comprobante.
  DISPLAY v-pago_parcial
      WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_compensar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_compensar C-Win
ON CHOOSE OF btn_compensar IN FRAME DEFAULT-FRAME /* Transferir */
DO:
    DEFINE VARIABLE sino AS LOGICAL.
    DEFINE VARIABLE hay_error AS LOGICAL.

    
    sino = NO.
    MESSAGE "Desea efectuar esta transferencia" 
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino.

    
   /*  v-estado:SENSITIVE = YES. */

    IF sino
    THEN DO:
        
        RUN validar_datos ( OUTPUT hay_error ).
        IF NOT hay_error
        THEN DO:
            v-estado:HIDDEN = NO.
            V-estado:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "        P R O C E S A N D O ...".
            ASSIGN FRAME {&FRAME-NAME} v-cdg_cliente v-fecha_transferencia v-pto_venta.
            RUN transferir_movimientos.
            v-estado:HIDDEN = YES.
            APPLY "RETURN" TO v-cdg_cliente.
        END.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Done
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Done C-Win
ON CHOOSE OF Btn_Done IN FRAME DEFAULT-FRAME /* Salir */
DO:
  &IF DEFINED (adm-panel) <> 0 &THEN
      RUN dispatch IN THIS-PROCEDURE ('exit').
  &ELSE
      APPLY "CLOSE":U TO THIS-PROCEDURE.
  &ENDIF
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cambio_destino
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cambio_destino C-Win
ON LEAVE OF v-cambio_destino IN FRAME DEFAULT-FRAME
DO:
  APPLY "RETURN" TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cambio_destino C-Win
ON RETURN OF v-cambio_destino IN FRAME DEFAULT-FRAME
DO:
  ASSIGN v-cambio_destino.
  RUN abre_query_destino.
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


&Scoped-define SELF-NAME v-fecha_transferencia
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-fecha_transferencia C-Win
ON LEAVE OF v-fecha_transferencia IN FRAME DEFAULT-FRAME
DO:

  APPLY "RETURN" TO SELF.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-fecha_transferencia C-Win
ON RETURN OF v-fecha_transferencia IN FRAME DEFAULT-FRAME
DO:
  ASSIGN FRAME {&FRAME-NAME} v-fecha_transferencia.
         MESSAGE v-nro_monedaorigen
             VIEW-AS ALERT-BOX INFO BUTTONS OK.
  RUN hallar_cambio ( INPUT v-nro_monedaorigen , INPUT v-fecha_transferencia, OUTPUT v-cambio_origen ).
  RUN hallar_cambio ( INPUT v-nro_monedadestino , INPUT v-fecha_transferencia, OUTPUT v-cambio_destino ).
  DISPLAY v-cambio_destino
      WITH FRAME {&FRAME-NAME}.
  RUN abre_query_destino.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-nro_monedadestino
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-nro_monedadestino C-Win
ON VALUE-CHANGED OF v-nro_monedadestino IN FRAME DEFAULT-FRAME
DO:
  ASSIGN v-nro_monedadestino.
  FIND Moneda_destino WHERE Moneda_destino.nro_moneda = v-nro_monedadestino NO-LOCK.
  RUN hallar_cambio ( INPUT v-nro_monedadestino , INPUT v-fecha_transferencia, OUTPUT v-cambio_destino ).
  DISPLAY v-cambio_destino
      WITH FRAME {&FRAME-NAME}.
  RUN abre_query_destino.  
  RUN levantar_origen.
  RUN abre_query_origen.
  v-cambio_destino:SENSITIVE = NOT CAN-FIND(FIRST Moneda WHERE Moneda.nro_moneda = v-nro_monedadestino AND Moneda.es_referencia).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-nro_monedaorigen
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-nro_monedaorigen C-Win
ON VALUE-CHANGED OF v-nro_monedaorigen IN FRAME DEFAULT-FRAME
DO:
  ASSIGN v-nro_monedaorigen.
  FIND Moneda_origen WHERE Moneda_origen.nro_moneda = v-nro_monedaorigen NO-LOCK.
  RUN hallar_cambio ( INPUT v-nro_monedaorigen , INPUT v-fecha_transferencia, OUTPUT v-cambio_origen ).
  RUN levantar_origen.
  RUN abre_query_origen.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-pago_parcial
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-pago_parcial C-Win
ON RETURN OF v-pago_parcial IN FRAME DEFAULT-FRAME /* Ingrese Cancelación Parcial */
DO:
  ASSIGN v-pago_parcial.

RUN crear_mensaje.p ( "TRMO001", "Debe seleccionarse algun comprobante","E", YES ).
RUN crear_mensaje.p ( "TRMO002", "No puede indicarse una cancelación parcial CERO","E", YES ).
RUN crear_mensaje.p ( "TRMO003", "La cancelación parcial indicada supera el saldo del comprobante","E", YES ).
RUN crear_mensaje.p ( "TRMO004", "Debe indicarse un importe del mismo signo que el saldo del comprobante","E", YES ).

  IF BROWSE_ORIGEN:FOCUSED-ROW-SELECTED
  THEN DO:
      IF v-pago_parcial <> 0
      THEN DO:
          IF  v-pago_parcial * CC_Origen.saldo_original > 0 /* Tienen el mismo signo */
          THEN DO:
              IF ABS(v-pago_parcial) <= ABS(CC_Origen.saldo_original) /* Monto parcial no supera el total*/
              THEN DO:
                  CC_Origen.saldo_comprobante = v-pago_parcial.
                  DISPLAY CC_Origen.saldo_comprobante
                      WITH BROWSE BROWSE_ORIGEN.
              END.
              ELSE DO:
                  RUN ponmensj.p ( INPUT "TRMO003" ).
                  v-pago_parcial = CC_Origen.saldo_comprobante.
                  DISPLAY v-pago_parcial
                      WITH FRAME {&FRAME-NAME}.
                  RETURN NO-APPLY.
              END.
          END.
          ELSE DO:
              RUN ponmensj.p ( INPUT "TRMO004" ).
              v-pago_parcial = CC_Origen.saldo_comprobante.
              DISPLAY v-pago_parcial
                  WITH FRAME {&FRAME-NAME}.
              RETURN NO-APPLY.
          END.
      END.
      ELSE DO:
          RUN ponmensj.p ( INPUT "TRMO002" ).
          RETURN NO-APPLY.
      END.
  END.
  ELSE DO:
      RUN ponmensj.p ( INPUT "TRMO001" ).
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
  IF INPUT FRAME {&FRAME-NAME} v-pto_venta <> v-pto_venta-org
  THEN DO:
       IF NOT CAN-FIND(Punto-venta WHERE Punto-venta.cdg_empresa  = que_empresa
                                     AND Punto-venta.cdg_puntovta = INPUT FRAME {&FRAME-NAME} v-pto_venta)
       THEN DO:
            RUN ponmensj.p ( INPUT "PVTA001").
            DISPLAY v-pto_venta-org @ v-pto_venta
                    WITH FRAME {&FRAME-NAME}.
       END.
       ELSE DO:
           ASSIGN FRAME {&FRAME-NAME} v-pto_venta.
           FIND Punto-venta WHERE Punto-venta.cdg_puntovta = v-pto_venta NO-LOCK.
           v-fecha_transferencia = IF Punto-venta.modo_fecha = "T" THEN Punto-venta.fch_cierre + 1 ELSE TODAY.
           DISPLAY v-fecha_transferencia
               WITH FRAME {&FRAME-NAME}.
     END.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE_DESTINO
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

/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.
  v-estado:HIDDEN = YES.
{setwintit.i "SIC/CXC" "Transferencia de saldos entre monedas"}
{findempresa.i}
que_empresa = Empresa.cdg_empresa.
ASSIGN v-fecha_transferencia = TODAY.

RUN getparametro_n.p (  INPUT  "DFTSLPVT", OUTPUT v-pto_venta  ).
FIND Punto-venta 
    WHERE Punto-venta.cdg_puntovta = v-pto_venta 
      AND Punto-venta.cdg_empresa = que_empresa
          NO-LOCK NO-ERROR.
IF NOT AVAILABLE Punto-venta 
THEN DO:
    RUN ponmens_inst.p ( INPUT "INST101" , INPUT "Punto-venta" ,  INPUT v-pto_venta ).
    RUN ponmensj.p ( INPUT "REMI063" ).
END.

  /*RUN CARPARAM.P.*/
  
/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:

DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  SESSION:DATA-ENTRY-RETURN = YES.
  RUN inicia_combos.
  RUN enable_UI.
  v-estado:HIDDEN = YES.




  DISPLAY v-fecha_transferencia v-pto_venta
      WITH FRAME {&FRAME-NAME}.

  v-estado:HIDDEN = YES.
  v-estado:SENSITIVE = NO.
  FIND FIRST Cliente WHERE CAN-DO(Cliente.lista_empresas, que_empresa) NO-LOCK NO-ERROR.
  IF AVAILABLE Cliente
  THEN DO:
      ASSIGN v-cdg_cliente = Cliente.cdg_cliente 
             v-dsc_cliente = Cliente.nom_cliente.
      DISPLAY v-cdg_cliente v-dsc_cliente WITH FRAME {&FRAME-NAME}.
  END.

  APPLY "RETURN" TO v-cdg_cliente IN FRAME {&FRAME-NAME}.
  APPLY "ENTRY" TO v-cdg_cliente IN FRAME {&FRAME-NAME}.

  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE abre_query C-Win 
PROCEDURE abre_query :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  RUN abre_query_destino.
  RUN abre_query_origen.
                      
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE abre_query_destino C-Win 
PROCEDURE abre_query_destino :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE x-fecha AS DATE.

  t_movcre = 0.
  t_regcre = 0.
  v-diferencia_cambio = 0.
  v-monto_equivalente = 0.

  FOR EACH CC_destino:
      t_movcre = t_movcre + CC_Destino.debito - CC_Destino.credito.
      t_regcre = t_regcre + 1.
          
      /*
      RUN hallar_tasa_cambio.p  ( INPUT Moneda_origen.cdg_moneda,
                                  INPUT Moneda_destino.cdg_moneda,
                                  INPUT v-fecha_transferencia,
                                  OUTPUT CC_Destino.cambio_destino,
                                  OUTPUT x-fecha ).
      */                            

      CC_Destino.cambio_destino = v-cambio_destino / v-cambio_origen.
      
      CC_Destino.saldo_equivalente = CC_Destino.saldo_comprobante * CC_Destino.cambio.

      ASSIGN CC_Destino.diferencia_cambio = CC_Destino.saldo_comprobante * CC_Destino.cambio_destino - CC_Destino.saldo_equivalente
             v-diferencia_cambio = v-diferencia_cambio + CC_Destino.diferencia_cambio
             v-monto_equivalente = v-monto_equivalente + CC_Destino.saldo_equivalente.
           
  END.

  v-importe_total = v-diferencia_cambio + v-monto_equivalente.

  OPEN QUERY BROWSE_DESTINO       
       FOR EACH CC_destino BY CC_destino.fecha_emision. 

  RUN poner_totales.

  IF v-diferencia_cambio > 0
       THEN ASSIGN v-diferencia_cambio:FGCOLOR IN FRAME {&FRAME-NAME} = 15
                   v-diferencia_cambio:BGCOLOR IN FRAME {&FRAME-NAME} = 9.
       ELSE IF v-diferencia_cambio < 0
                THEN ASSIGN v-diferencia_cambio:FGCOLOR IN FRAME {&FRAME-NAME} = 15
                            v-diferencia_cambio:BGCOLOR IN FRAME {&FRAME-NAME} = 12.
                ELSE ASSIGN v-diferencia_cambio:FGCOLOR IN FRAME {&FRAME-NAME} = 0
                            v-diferencia_cambio:BGCOLOR IN FRAME {&FRAME-NAME} = 15.

  DISPLAY v-importe_total v-diferencia_cambio v-monto_equivalente
      WITH FRAME {&FRAME-NAME}.

  btn_compensar:SENSITIVE IN FRAME {&FRAME-NAME} = CAN-FIND(FIRST CC_destino).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE abre_query_origen C-Win 
PROCEDURE abre_query_origen :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
            
  t_movdeb = 0.
  t_regdeb = 0.

  FOR EACH CC_origen WHERE NOT CC_Origen.selectado:
      t_movdeb = t_movdeb + CC_Origen.debito - CC_Origen.credito.
      t_regdeb = t_regdeb + 1.

  END.

  OPEN QUERY BROWSE_ORIGEN
       FOR EACH CC_origen WHERE NOT CC_Origen.selectado
           BY CC_origen.fecha_emision. 

  RUN poner_totales.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE crear_diferencia_de_cambio C-Win 
PROCEDURE crear_diferencia_de_cambio :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE p-punto_venta  AS INTEGER.
    DEFINE VARIABLE p-cdg_concepto AS INTEGER.
    DEFINE VARIABLE x-proporcion   AS DECIMAL DECIMALS 6.
    DEFINE VARIABLE x-delta_cambio LIKE Rec_header.cambio.
    
    {parlocales.i}

    RUN getparametro_n.p (  INPUT  "DFCAMPVT", OUTPUT p-punto_venta  ).
    FIND Punto-venta 
        WHERE Punto-venta.cdg_puntovta = p-punto_venta 
          AND Punto-venta.cdg_empresa = que_empresa
              NO-LOCK NO-ERROR.
    IF NOT AVAILABLE Punto-venta 
    THEN DO:
        RUN ponmens_inst.p ( INPUT "INST121" , INPUT "Punto-venta" ,  INPUT p-punto_venta ).
        RETURN ERROR.
    END.

    RUN getparametro_n.p (  INPUT  "DFCAMCON", OUTPUT p-cdg_concepto ).
    FIND Imputacion WHERE Imputacion.cdg_imputacion = p-cdg_concepto NO-LOCK NO-ERROR.
    IF NOT AVAILABLE Imputacion 
    THEN DO:
        RUN ponmens_inst.p ( INPUT "INST122" , INPUT "Imputacion" ,  INPUT p-cdg_concepto ).
        RETURN ERROR.
    END.

    RUN getparametro_c.p (  INPUT  "DFCAMCNV", OUTPUT v-valor_c ).
    FIND Condicion_venta WHERE Condicion_venta.cdg_cndventa = v-valor_c NO-LOCK NO-ERROR.
    IF NOT AVAILABLE Condicion_venta 
    THEN DO:
        RUN ponmens_inst.p ( INPUT "INST123" , INPUT "Condicion_venta" ,  INPUT v-valor_c ).
        RETURN ERROR.
    END.    

    RUN getparametro_c.p (  INPUT  "DFCAMART", OUTPUT v-valor_c ).
    FIND Articulo WHERE Articulo.cdg_articulo = v-valor_c NO-LOCK NO-ERROR.
    IF NOT AVAILABLE Articulo
    THEN DO:
        RUN ponmens_inst.p ( INPUT "INST124" , INPUT "Articulo" ,  INPUT v-valor_c ).
        RETURN ERROR.
    END.    
    
    FIND Tipocomprobante 
        WHERE Tipocomprobante.cdg_comprobante = "DBCAMBIO" 
          AND Tipocomprobante.cdg_empresa = que_empresa
              NO-LOCK NO-ERROR.
    IF NOT AVAILABLE Tipocomprobante
    THEN DO:
        RUN ponmens_inst.p ( INPUT "INST125" , INPUT "Tipocomprobante" ,  INPUT v-valor_c ).
        RETURN ERROR.
    END.    

    FIND Tipocomprobante 
        WHERE Tipocomprobante.cdg_comprobante = "CRCAMBIO" 
          AND Tipocomprobante.cdg_empresa = que_empresa
              NO-LOCK NO-ERROR.
    IF NOT AVAILABLE Tipocomprobante
    THEN DO:
        RUN ponmens_inst.p ( INPUT "INST126" , INPUT "Tipocomprobante" ,  INPUT v-valor_c ).
        RETURN ERROR.
    END.    

    RUN getparametro_c.p (  INPUT  "DFDEPOSI", OUTPUT v-valor_c ).
    FIND Deposito WHERE Deposito.cdg_deposito = v-valor_c NO-LOCK.

    FIND FIRST Moneda_local WHERE Moneda_local.es_local NO-LOCK.
    
    EMPTY TEMP-TABLE T-Fac_header.               
    EMPTY TEMP-TABLE T-Fac_detalle.              
    EMPTY TEMP-TABLE T-Sub_header_vta.           
    EMPTY TEMP-TABLE T-Sub_detalle_vta.          
    EMPTY TEMP-TABLE T-Fac_header_impuesto.      
    EMPTY TEMP-TABLE T-Fac_detalle_impuesto.     

    FIND Cliente WHERE Cliente.cdg_cliente = v-cdg_cliente NO-LOCK.
    FIND FIRST Domicilio OF Cliente NO-LOCK.
    FIND Condicion_impos OF Cliente NO-LOCK.
    FIND Vendedor OF Cliente NO-LOCK.
    FIND Obra WHERE Obra.cdg_obra = Vendedor.cdg_vendedor NO-LOCK.
    
    CREATE T-Fac_header.
    ASSIGN T-Fac_header.origen            = "R"
           T-Fac_header.cdg_empresa       = que_empresa
           T-Fac_header.cdg_comprobante   = "DBCAMBIO"
           T-Fac_header.estado            = "P"
           T-Fac_header.cta_cte           = YES /* OJO !!!!!! */
           T-Fac_header.nro_factura       = 1
           T-Fac_header.fecha             = v-fecha_transferencia
           T-Fac_header.fecha_iva         = T-Fac_header.fecha
           T-Fac_header.fecha_precios     = T-Fac_header.fecha
           T-Fac_header.cdg_imputacion    = p-cdg_concepto
           T-Fac_header.impreso           = ""
           T-Fac_header.cambio            = v-cambio_destino
           T-Fac_header.prf_comprob       = p-punto_venta
           T-Fac_header.nro_cndventa      = Condicion_venta.nro_cndventa
           T-Fac_header.nro_moneda        = v-nro_monedadestino
           T-Fac_header.nro_deposito      = Deposito.nro_deposito
           T-Fac_header.nro_obra          = Obra.nro_obra
           T-Fac_header.nro_cliente       = Cliente.nro_cliente
           T-Fac_header.nombre            = Cliente.nom_cliente
           T-Fac_header.direccion_leg     = Cliente.direccion
           T-Fac_header.localidad_leg     = Cliente.localidad
           T-Fac_header.cdg_postal_leg    = Cliente.cdg_postal
           T-Fac_header.cdg_provincia_leg = Cliente.cdg_provincia
           T-Fac_header.cdg_condiva       = Cliente.cdg_condiva
           T-Fac_header.cdg_lista         = Cliente.dfl_lista
           T-Fac_header.nro_vendedor      = Cliente.nro_vendedor
           T-Fac_header.nombre_domicilio  = Domicilio.nombre
           T-Fac_header.nro_domicilio     = Domicilio.nro_domicilio
           T-Fac_header.direccion         = Domicilio.direccion
           T-Fac_header.cdg_provincia     = Domicilio.cdg_provincia
           T-Fac_header.localidad         = Domicilio.localidad
           T-Fac_header.cdg_postal        = Domicilio.cdg_postal
           T-Fac_header.cdg_zonag         = Domicilio.cdg_zonag
           T-Fac_header.imp_total         = 0.
    
    FOR EACH CC_Destino WHERE CC_Destino.diferencia_cambio <> 0:
        T-Fac_header.imp_total = T-Fac_header.imp_total + CC_Destino.diferencia_cambio.    
    END.
    
    IF T-Fac_header.imp_total < 0
    THEN DO:
       ASSIGN
           T-Fac_header.cdg_comprobante = "CRCAMBIO"
           T-Fac_header.imp_total =  T-Fac_header.imp_total * ( - 1 ).
    END.
    
    CREATE T-Fac_detalle.
    ASSIGN T-Fac_detalle.nro_factura  = T-Fac_header.nro_factura
           T-Fac_detalle.nro_linea    = 1
           T-Fac_detalle.cantidad     = 1
           T-Fac_detalle.granel       = 1
           T-Fac_detalle.precio       = T-Fac_header.imp_total
           T-Fac_detalle.nro_articulo = Articulo.nro_articulo
           T-Fac_detalle.detallada    = Articulo.detallada.

    RUN calcular_diferencia_cambio.p (
                         INPUT-OUTPUT TABLE T-Fac_header,
                         INPUT-OUTPUT TABLE T-Fac_detalle,
                         INPUT-OUTPUT TABLE T-Sub_header_vta,
                         INPUT-OUTPUT TABLE T-Sub_detalle_vta,
                         INPUT-OUTPUT TABLE T-Fac_header-bon,
                         INPUT-OUTPUT TABLE T-Fac_detalle-bon,
                         INPUT-OUTPUT TABLE T-Fac_header_impuesto,
                         INPUT-OUTPUT TABLE T-Fac_detalle_impuesto).

    RUN emitir_comprobante_cliente.p (
                     INPUT TABLE T-Fac_header,
                     INPUT TABLE T-Fac_detalle,
                     INPUT TABLE T-Sub_header_vta,
                     INPUT TABLE T-Sub_detalle_vta,
                     INPUT TABLE T-Fac_header-bon,
                     INPUT TABLE T-Fac_detalle-bon,
                     INPUT TABLE T-Fac_header_impuesto,
                     INPUT TABLE T-Fac_detalle_impuesto).


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE credito_origen C-Win 
PROCEDURE credito_origen :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE p-cdg_concepto AS INTEGER.
    DEFINE VARIABLE x-proporcion   AS DECIMAL DECIMALS 6.
    DEFINE VARIABLE x-delta_cambio LIKE Rec_header.cambio.
    DEFINE VARIABLE v-prox_docum   AS CHARACTER.
    DEFINE VARIABLE str_debitan    AS CHARACTER.
    
    {parlocales.i}

    RUN getparametro_n.p (  INPUT  "DFTSLCON", OUTPUT p-cdg_concepto ).

    RUN getparametro_c.p (  INPUT  "DFTSLCNV", OUTPUT v-valor_c ).
    FIND Condicion_venta WHERE Condicion_venta.cdg_cndventa = v-valor_c NO-LOCK.

    RUN getparametro_c.p (  INPUT  "DFTSLART", OUTPUT v-valor_c ).
    FIND Articulo WHERE Articulo.cdg_articulo = v-valor_c NO-LOCK.

    RUN getparametro_c.p (  INPUT  "DFDEPOSI", OUTPUT v-valor_c ).
    FIND Deposito WHERE Deposito.cdg_deposito = v-valor_c NO-LOCK.

    EMPTY TEMP-TABLE T-Fac_header.               
    EMPTY TEMP-TABLE T-Fac_detalle.              
    EMPTY TEMP-TABLE T-Sub_header_vta.           
    EMPTY TEMP-TABLE T-Sub_detalle_vta.          
    EMPTY TEMP-TABLE T-Fac_header_impuesto.      
    EMPTY TEMP-TABLE T-Fac_detalle_impuesto.     

    FIND Cliente WHERE Cliente.cdg_cliente = v-cdg_cliente NO-LOCK.
    FIND FIRST Domicilio OF Cliente NO-LOCK.
    FIND Condicion_impos OF Cliente NO-LOCK.
    FIND Vendedor OF Cliente NO-LOCK.
    FIND Obra WHERE Obra.cdg_obra = Vendedor.cdg_vendedor NO-LOCK.
    
    CREATE T-Fac_header.
    ASSIGN T-Fac_header.origen            = "R"
           T-Fac_header.cdg_empresa       = que_empresa
           T-Fac_header.cdg_comprobante   = "CRTRAMON"
           T-Fac_header.estado            = "P"
           T-Fac_header.cta_cte           = YES /* OJO !!!!!! */
           T-Fac_header.nro_factura       = 1
           T-Fac_header.fecha             = v-fecha_transferencia
           T-Fac_header.fecha_iva         = T-Fac_header.fecha
           T-Fac_header.fecha_precios     = T-Fac_header.fecha
           T-Fac_header.cdg_imputacion    = p-cdg_concepto
           T-Fac_header.impreso           = ""
           T-Fac_header.cambio            = v-cambio_origen
           T-Fac_header.prf_comprob       = v-pto_venta
           T-Fac_header.nro_cndventa      = Condicion_venta.nro_cndventa
           T-Fac_header.nro_moneda        = v-nro_monedaorigen
           T-Fac_header.nro_deposito      = Deposito.nro_deposito
           T-Fac_header.nro_obra          = Obra.nro_obra
           T-Fac_header.nro_cliente       = Cliente.nro_cliente
           T-Fac_header.nombre            = Cliente.nom_cliente
           T-Fac_header.direccion_leg     = Cliente.direccion
           T-Fac_header.localidad_leg     = Cliente.localidad
           T-Fac_header.cdg_postal_leg    = Cliente.cdg_postal
           T-Fac_header.cdg_provincia_leg = Cliente.cdg_provincia
           T-Fac_header.cdg_condiva       = Cliente.cdg_condiva
           T-Fac_header.cdg_lista         = Cliente.dfl_lista
           T-Fac_header.nro_vendedor      = Cliente.nro_vendedor
           T-Fac_header.nombre_domicilio  = Domicilio.nombre
           T-Fac_header.nro_domicilio     = Domicilio.nro_domicilio
           T-Fac_header.direccion         = Domicilio.direccion
           T-Fac_header.cdg_provincia     = Domicilio.cdg_provincia
           T-Fac_header.localidad         = Domicilio.localidad
           T-Fac_header.cdg_postal        = Domicilio.cdg_postal
           T-Fac_header.cdg_zonag         = Domicilio.cdg_zonag
           T-Fac_header.imp_total         = 0.
    
    FOR EACH CC_Destino:
        T-Fac_header.imp_total = T-Fac_header.imp_total + CC_Destino.saldo_comprobante.    
    END.
    
    IF T-Fac_header.imp_total < 0
    THEN DO:
       ASSIGN
           T-Fac_header.cdg_comprobante = "DBTRAMON"
           T-Fac_header.imp_total =  T-Fac_header.imp_total * ( - 1 ).
    END.
    
    CREATE T-Fac_detalle.
    ASSIGN T-Fac_detalle.nro_factura  = T-Fac_header.nro_factura
           T-Fac_detalle.nro_linea    = 1
           T-Fac_detalle.cantidad     = 1
           T-Fac_detalle.granel       = 1
           T-Fac_detalle.precio       = T-Fac_header.imp_total
           T-Fac_detalle.nro_articulo = Articulo.nro_articulo
           T-Fac_detalle.detallada    = Articulo.detallada.

    FIND Tipocomprobante OF T-Fac_header NO-LOCK.

    IF NOT Tipocomprobante.autonumerado
    THEN DO:

        v-prox_docum = Tipocomprobante.prefijo_contador + STRING(T-Fac_header.prf_comprob,"9999").
        T-Fac_header.tip_comprob =  Tipocomprobante.tip_comprob.    
        IF Tipocomprobante.usa_letra
        THEN DO:
            v-prox_docum = REPLACE(v-prox_docum,"*",Condicion_impos.tipo_factura).
            T-Fac_header.tip_comprob = REPLACE(T-Fac_header.tip_comprob,"*",Condicion_impos.tipo_factura).
        END.
    
        FIND Parametro WHERE Parametro.cdg_parametro = v-prox_docum 
                         AND Parametro.cdg_empresa   = T-Fac_header.cdg_empresa 
                             EXCLUSIVE-LOCK NO-ERROR.
    
        IF NOT AVAILABLE Parametro
        THEN DO:
             CREATE Parametro.
             ASSIGN Parametro.cdg_empresa   = T-Fac_header.cdg_empresa
                    Parametro.cdg_parametro = v-prox_docum
                    Parametro.descripcion   = "Contador autoagregado por " + PROGRAM-NAME(1)
                    Parametro.observacion   = ""
                    Parametro.tipo          = "N"
                    Parametro.valor_n       = 1.
        END.         
        
        ASSIGN
           T-Fac_header.nro_comprob = Parametro.valor_n
           Parametro.valor_n        = Parametro.valor_n + 1.

    END.
          
    RUN emitir_comprobante_cliente.p (
                         INPUT TABLE T-Fac_header,
                         INPUT TABLE T-Fac_detalle,
                         INPUT TABLE T-Sub_header_vta,
                         INPUT TABLE T-Sub_detalle_vta,
                         INPUT TABLE T-Fac_header-bon,
                         INPUT TABLE T-Fac_detalle-bon,
                         INPUT TABLE T-Fac_header_impuesto,
                         INPUT TABLE T-Fac_detalle_impuesto).

    /* ---------------------------------------------------------------------------------- */
    /* Produce la cancelacion de los comprobantes seleccionados contra el crédito emitido */
    /* ---------------------------------------------------------------------------------- */

    RUN cargar_debitan.p ( INPUT "Ventas", OUTPUT str_debitan ).

    FOR EACH Cta_cte WHERE Cta_cte.cdg_empresa     = T-Fac_header.cdg_empresa    
                       AND Cta_cte.tip_comprob     = T-Fac_header.tip_comprob    
                       AND Cta_cte.prf_comprob     = T-Fac_header.prf_comprob    
                       AND Cta_cte.nro_comprob     = T-Fac_header.nro_comprob
                           EXCLUSIVE-LOCK:

        IF CAN-DO(str_debitan,Cta_cte.tip_comprob)
            THEN Cta_cte.credito = Cta_cte.debito.
            ELSE Cta_cte.debito  = Cta_cte.credito.

    END.

    FOR EACH CC_Destino:

        FIND Cta_cte WHERE Cta_cte.cdg_empresa     = CC_Destino.cdg_empresa    
                       AND Cta_cte.tip_comprob     = CC_Destino.tip_comprob    
                       AND Cta_cte.prf_comprob     = CC_Destino.prf_comprob    
                       AND Cta_cte.nro_comprob     = CC_Destino.nro_comprob    
                       AND Cta_cte.nro_vencimiento = CC_Destino.nro_vencimiento
                           EXCLUSIVE-LOCK.

        IF CAN-DO(str_debitan,Cta_cte.tip_comprob)
            THEN Cta_cte.credito = Cta_cte.credito + CC_Destino.saldo_comprobante.
            ELSE Cta_cte.debito = Cta_cte.debito - CC_Destino.saldo_comprobante. /* CC_Destino.saldo_comprobante. es < 0 */


        /*----------------------------------------------------------------------------------*/
        /*     GENERA EL REGISTRO DE APLICACION DE PAGOS PARA CADA DOCUMENTO CANCELADO      */
        /*----------------------------------------------------------------------------------*/
    
        CREATE Aplicacion_pagos.
        ASSIGN Aplicacion_pagos.cdg_empresa      = T-Fac_header.cdg_empresa
               Aplicacion_pagos.importe          = CC_Destino.saldo_comprobante
               Aplicacion_pagos.descuento        = 0
               Aplicacion_pagos.tip_cancela      = CC_Destino.tip_comprob
               Aplicacion_pagos.prf_cancela      = CC_Destino.prf_comprob
               Aplicacion_pagos.nro_cancela      = CC_Destino.nro_comprob
               Aplicacion_pagos.nro_ven_cancela  = CC_Destino.nro_vencimiento
               Aplicacion_pagos.tip_comprob      = T-Fac_header.tip_comprob
               Aplicacion_pagos.prf_comprob      = T-Fac_header.prf_comprob
               Aplicacion_pagos.nro_comprob      = T-Fac_header.nro_comprob           
               Aplicacion_pagos.nro_vencimiento  = 1.

    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE debito_destino C-Win 
PROCEDURE debito_destino :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/


    DEFINE VARIABLE p-cdg_concepto AS INTEGER.
    DEFINE VARIABLE x-proporcion   AS DECIMAL DECIMALS 6.
    DEFINE VARIABLE x-delta_cambio LIKE Rec_header.cambio.
    DEFINE VARIABLE v-prox_docum   AS CHARACTER.

    {parlocales.i}

    /* No haría falta la validación de la instalación pero se repite por cambios futuros en la parametrización */

    RUN getparametro_n.p (  INPUT  "DFTSLCON", OUTPUT p-cdg_concepto ).

    FIND Condicion_venta WHERE Condicion_venta.cdg_cndventa = v-cdg_cndventa:INPUT-VALUE IN FRAME {&FRAME-NAME}.

    RUN getparametro_c.p (  INPUT  "DFTSLART", OUTPUT v-valor_c ).
    FIND Articulo WHERE Articulo.cdg_articulo = v-valor_c NO-LOCK.

    RUN getparametro_c.p (  INPUT  "DFDEPOSI", OUTPUT v-valor_c ).
    FIND Deposito WHERE Deposito.cdg_deposito = v-valor_c NO-LOCK.

    EMPTY TEMP-TABLE T-Fac_header.               
    EMPTY TEMP-TABLE T-Fac_detalle.              
    EMPTY TEMP-TABLE T-Sub_header_vta.           
    EMPTY TEMP-TABLE T-Sub_detalle_vta.          
    EMPTY TEMP-TABLE T-Fac_header_impuesto.      
    EMPTY TEMP-TABLE T-Fac_detalle_impuesto.     

    FIND Cliente WHERE Cliente.cdg_cliente = v-cdg_cliente NO-LOCK.
    FIND FIRST Domicilio OF Cliente NO-LOCK.
    FIND Condicion_impos OF Cliente NO-LOCK.
    FIND Vendedor OF Cliente NO-LOCK.
    FIND Obra WHERE Obra.cdg_obra = Vendedor.cdg_vendedor NO-LOCK.
    
    CREATE T-Fac_header.
    ASSIGN T-Fac_header.origen            = "R"
           T-Fac_header.cdg_empresa       = que_empresa
           T-Fac_header.cdg_comprobante   = "DBTRAMON"
           T-Fac_header.estado            = "P"
           T-Fac_header.cta_cte           = YES /* OJO !!!!!! */
           T-Fac_header.nro_factura       = 1
           T-Fac_header.fecha             = v-fecha_transferencia
           T-Fac_header.fecha_iva         = T-Fac_header.fecha
           T-Fac_header.fecha_precios     = T-Fac_header.fecha
           T-Fac_header.cdg_imputacion    = p-cdg_concepto
           T-Fac_header.impreso           = ""
           T-Fac_header.cambio            = v-cambio_destino
           T-Fac_header.prf_comprob       = v-pto_venta
           T-Fac_header.nro_cndventa      = Condicion_venta.nro_cndventa
           T-Fac_header.nro_moneda        = v-nro_monedadestino
           T-Fac_header.nro_deposito      = Deposito.nro_deposito
           T-Fac_header.nro_obra          = Obra.nro_obra
           T-Fac_header.nro_cliente       = Cliente.nro_cliente
           T-Fac_header.nombre            = Cliente.nom_cliente
           T-Fac_header.direccion_leg     = Cliente.direccion
           T-Fac_header.localidad_leg     = Cliente.localidad
           T-Fac_header.cdg_postal_leg    = Cliente.cdg_postal
           T-Fac_header.cdg_provincia_leg = Cliente.cdg_provincia
           T-Fac_header.cdg_condiva       = Cliente.cdg_condiva
           T-Fac_header.cdg_lista         = Cliente.dfl_lista
           T-Fac_header.nro_vendedor      = Cliente.nro_vendedor
           T-Fac_header.nombre_domicilio  = Domicilio.nombre
           T-Fac_header.nro_domicilio     = Domicilio.nro_domicilio
           T-Fac_header.direccion         = Domicilio.direccion
           T-Fac_header.cdg_provincia     = Domicilio.cdg_provincia
           T-Fac_header.localidad         = Domicilio.localidad
           T-Fac_header.cdg_postal        = Domicilio.cdg_postal
           T-Fac_header.cdg_zonag         = Domicilio.cdg_zonag
           T-Fac_header.imp_total         = 0.
    
    FOR EACH CC_destino:
        T-Fac_header.imp_total = T-Fac_header.imp_total + CC_destino.saldo_equivalente.    
    END.
    
    IF T-Fac_header.imp_total < 0
    THEN DO:
       ASSIGN
           T-Fac_header.cdg_comprobante = "CRTRAMON"
           T-Fac_header.imp_total =  T-Fac_header.imp_total * ( - 1 ).
    END.
    
    CREATE T-Fac_detalle.
    ASSIGN T-Fac_detalle.nro_factura  = T-Fac_header.nro_factura
           T-Fac_detalle.nro_linea    = 1
           T-Fac_detalle.cantidad     = 1
           T-Fac_detalle.granel       = 1
           T-Fac_detalle.precio       = T-Fac_header.imp_total
           T-Fac_detalle.nro_articulo = Articulo.nro_articulo
           T-Fac_detalle.detallada    = Articulo.detallada.
    
    FIND Tipocomprobante OF T-Fac_header NO-LOCK.

    IF NOT Tipocomprobante.autonumerado
    THEN DO:

        v-prox_docum = Tipocomprobante.prefijo_contador + STRING(T-Fac_header.prf_comprob,"9999").
        T-Fac_header.tip_comprob =  Tipocomprobante.tip_comprob.    
        IF Tipocomprobante.usa_letra
        THEN DO:
            v-prox_docum = REPLACE(v-prox_docum,"*",Condicion_impos.tipo_factura).
            T-Fac_header.tip_comprob = REPLACE(T-Fac_header.tip_comprob,"*",Condicion_impos.tipo_factura).
        END.
    
        FIND Parametro WHERE Parametro.cdg_parametro = v-prox_docum 
                         AND Parametro.cdg_empresa   = T-Fac_header.cdg_empresa 
                             EXCLUSIVE-LOCK NO-ERROR.
    
        IF NOT AVAILABLE Parametro
        THEN DO:
             CREATE Parametro.
             ASSIGN Parametro.cdg_empresa   = T-Fac_header.cdg_empresa
                    Parametro.cdg_parametro = v-prox_docum
                    Parametro.descripcion   = "Contador autoagregado por " + PROGRAM-NAME(1)
                    Parametro.observacion   = ""
                    Parametro.tipo          = "N"
                    Parametro.valor_n       = 1.
        END.         
        
        ASSIGN
           T-Fac_header.nro_comprob = Parametro.valor_n
           Parametro.valor_n        = Parametro.valor_n + 1.

    END.

    RUN emitir_comprobante_cliente.p (
                         INPUT TABLE T-Fac_header,
                         INPUT TABLE T-Fac_detalle,
                         INPUT TABLE T-Sub_header_vta,
                         INPUT TABLE T-Sub_detalle_vta,
                         INPUT TABLE T-Fac_header-bon,
                         INPUT TABLE T-Fac_detalle-bon,
                         INPUT TABLE T-Fac_header_impuesto,
                         INPUT TABLE T-Fac_detalle_impuesto).


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
  DISPLAY v-cdg_cliente v-dsc_cliente v-fecha_transferencia v-pto_venta 
          v-nro_monedaorigen v-nro_monedadestino v-cambio_destino t_movdeb 
          t_regdeb t_movcre t_regcre v-monto_equivalente v-diferencia_cambio 
          v-importe_total v-pago_parcial v-cdg_cndventa v-estado 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE RECT-1 RECT-2 RECT-3 RECT-4 RECT-6 RECT-7 RECT-8 v-cdg_cliente 
         v-fecha_transferencia Btn_Done v-pago_parcial BROWSE_ORIGEN 
         BROWSE_DESTINO 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE habilitar_combos_monedas C-Win 
PROCEDURE habilitar_combos_monedas :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE INPUT PARAMETER p-habilitar AS LOGICAL.

    RUN habilitar_widget (  INPUT v-nro_monedaorigen:HANDLE IN FRAME {&FRAME-NAME} , INPUT p-habilitar ).
    RUN habilitar_widget (  INPUT v-nro_monedadestino:HANDLE IN FRAME {&FRAME-NAME}, INPUT p-habilitar ).    

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE habilitar_widget C-Win 
PROCEDURE habilitar_widget :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    
    DEFINE INPUT PARAMETER p-handle AS WIDGET-HANDLE.
    DEFINE INPUT PARAMETER p-habilitar AS LOGICAL.

    IF p-habilitar
    THEN DO:
        p-handle:SENSITIVE = YES.
        p-handle:FGCOLOR   = 15.
        p-handle:BGCOLOR   = 9.
    END.    
    ELSE DO:
        p-handle:SENSITIVE = NO.
        p-handle:FGCOLOR   = 0.
        p-handle:BGCOLOR   = 15.
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE hallar_cambio C-Win 
PROCEDURE hallar_cambio :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE INPUT  PARAMETER p-nro_moneda  LIKE Moneda.nro_moneda.
    DEFINE INPUT  PARAMETER p-fecha       AS DATE.
    DEFINE OUTPUT PARAMETER p-cambio      LIKE Cotizacion.cambio.
    
    DEFINE VARIABLE x-fecha AS DATE.
    
    FIND Moneda WHERE Moneda.nro_moneda = p-nro_moneda NO-LOCK.
    RUN cotizar_moneda.p ( INPUT Moneda.cdg_moneda,
                           INPUT que_empresa,
                           INPUT p-fecha,
                           OUTPUT p-cambio,
                           OUTPUT x-fecha ).

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

  {parlocales.i}

  DEFINE VARIABLE ok AS LOGICAL.
  DEFINE VARIABLE lista AS CHARACTER.

  DO WITH FRAME {&FRAME-NAME}:
     {levantacombo.i &TABLA=Moneda &NOMBRE=descripcion &CODIGO=nro_moneda &OBJETO=v-nro_monedaorigen}
     {levantacombo.i &TABLA=Moneda &NOMBRE=descripcion &CODIGO=nro_moneda &OBJETO=v-nro_monedadestino}
     {levantacombo.i &TABLA=Condicion_venta &NOMBRE=descripcion &CODIGO=cdg_cndventa &OBJETO=v-cdg_cndventa}

     FIND Moneda WHERE Moneda.es_referencia NO-LOCK.
     v-nro_monedaorigen = Moneda.nro_moneda.

     FIND Moneda WHERE Moneda.es_local NO-LOCK.
     v-nro_monedadestino = Moneda.nro_moneda.

     RUN getparametro_c.p (  INPUT  "DFTSLCNV", OUTPUT v-valor_c ).
     FIND Condicion_venta WHERE Condicion_venta.cdg_cndventa = v-valor_c NO-LOCK NO-ERROR.
     IF NOT AVAILABLE Condicion_venta 
     THEN DO:
        RUN ponmens_inst.p ( INPUT "INST113" , INPUT "Condicion_venta" ,  INPUT v-valor_c ).
        RETURN ERROR.
     END.    

     v-cdg_cndventa = Condicion_venta.cdg_cndventa.

     DISPLAY v-nro_monedaorigen v-nro_monedadestino v-cdg_cndventa.

     APPLY "VALUE-CHANGED" TO v-nro_monedaorigen.
     APPLY "VALUE-CHANGED" TO v-nro_monedadestino.

  END.          

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE levantar_origen C-Win 
PROCEDURE levantar_origen :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE x-cambio LIKE Cta_cte.cambio.
    
    EMPTY TEMP-TABLE  CC_origen.
    EMPTY TEMP-TABLE  CC_destino.
    
    FOR EACH Cta_cte OF Cliente 
      WHERE Cta_cte.nro_moneda = v-nro_monedaorigen 
        AND Cta_cte.cdg_empresa = que_empresa
        AND Cta_cte.debito <> Cta_cte.credito NO-LOCK:

        CREATE CC_Origen.
        BUFFER-COPY Cta_cte TO CC_origen
            ASSIGN CC_Origen.saldo_comprobante = CC_Origen.debito - CC_Origen.credito
                   CC_Origen.saldo_original    = CC_Origen.saldo_comprobante.

        IF v-nro_monedaorigen <> v-nro_monedadestino
        THEN DO:

            /* Halla la cotización de la moneda de destino */
            /* para la fecha de emisión del comprobante    */

            RUN hallar_cambio ( INPUT v-nro_monedadestino,
                                INPUT Cta_cte.fecha_emision,
                                OUTPUT x-cambio).

            /* Asigna la tasa de cambio entre una moneda y otra */

            ASSIGN CC_Origen.cambio = Cta_cte.cambio / x-cambio.

        END.
        ELSE DO:

            /* Si las monedas son iguales el cambio relativo es 1 */

            ASSIGN CC_Origen.cambio = 1.

        END.

    END.
    
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

    ASSIGN FRAME {&FRAME-NAME} v-fecha_transferencia.

    RUN levantar_origen.
    
    t_regdeb = 0.
    t_regcre = 0.
    t_movdeb = 0.
    t_movcre = 0.
     
    DISPLAY t_movdeb t_movcre t_regcre t_regdeb
             WITH FRAME {&FRAME-NAME}.
    
    RUN abre_query.
      
    BROWSE_DESTINO:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
    BROWSE_ORIGEN:SENSITIVE IN FRAME {&FRAME-NAME} = YES.

    v-nro_monedadestino:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
    v-nro_monedaorigen:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
            

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_totales C-Win 
PROCEDURE poner_totales :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DISPLAY t_movdeb t_movcre t_regdeb t_regcre
          WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE transferir_movimientos C-Win 
PROCEDURE transferir_movimientos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

 RUN credito_origen.
 RUN debito_destino.
 IF v-diferencia_cambio <> 0
     THEN RUN crear_diferencia_de_cambio.

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

    DEFINE OUTPUT PARAMETER p-hay_error AS LOGICAL.

    {parlocales.i}

    DEFINE VARIABLE v-tip_comprob  LIKE Fac_header.tip_comprob.
    DEFINE VARIABLE p-cdg_concepto AS INTEGER.

    p-hay_error = YES. /* Si falla la validación, devolverá YES */

    FIND Punto-venta 
        WHERE Punto-venta.cdg_puntovta = v-pto_venta 
          AND Punto-venta.cdg_empresa = que_empresa
              NO-LOCK NO-ERROR.
    IF NOT AVAILABLE Punto-venta 
    THEN DO:
        RUN ponmens_inst.p ( INPUT "INST101" , INPUT "Punto-venta" ,  INPUT v-pto_venta ).
        RUN ponmensj.p ( INPUT "REMI063" ).
        RETURN ERROR.
    END.
    ELSE DO:
        IF v-fecha_transferencia > TODAY
        THEN DO:
            RUN ponmensj.p ( INPUT "REMI065" ).
            RETURN ERROR.
        END.
        ELSE DO:
            IF v-fecha_transferencia <= Punto-venta.fch_cierre
            THEN DO:
                RUN ponmensj.p ( INPUT "REMI062" ).
                RETURN ERROR.
            END.
            ELSE DO:

                RUN getparametro_n.p (  INPUT  "DFTSLCON", OUTPUT p-cdg_concepto ).
                FIND Imputacion WHERE Imputacion.cdg_imputacion = p-cdg_concepto NO-LOCK NO-ERROR.
                IF NOT AVAILABLE Imputacion 
                THEN DO:
                    RUN ponmens_inst.p ( INPUT "INST102" , INPUT "Imputacion" ,  INPUT p-cdg_concepto ).
                    RETURN ERROR.
                END.

                RUN getparametro_c.p (  INPUT  "DFTSLCNV", OUTPUT v-valor_c ).
                FIND Condicion_venta WHERE Condicion_venta.cdg_cndventa = v-valor_c NO-LOCK NO-ERROR.
                IF NOT AVAILABLE Condicion_venta 
                THEN DO:
                    RUN ponmens_inst.p ( INPUT "INST103" , INPUT "Condicion_venta" ,  INPUT v-valor_c ).
                    RETURN ERROR.
                END.    

                RUN getparametro_c.p (  INPUT  "DFTSLART", OUTPUT v-valor_c ).
                FIND Articulo WHERE Articulo.cdg_articulo = v-valor_c NO-LOCK NO-ERROR.
                IF NOT AVAILABLE Articulo
                THEN DO:
                    RUN ponmens_inst.p ( INPUT "INST104" , INPUT "Articulo" ,  INPUT v-valor_c ).
                    RETURN ERROR.
                END.    

                FIND Tipocomprobante 
                    WHERE Tipocomprobante.cdg_comprobante = "DBTRAMON" 
                      AND Tipocomprobante.cdg_empresa = que_empresa
                          NO-LOCK NO-ERROR.
                IF NOT AVAILABLE Tipocomprobante
                THEN DO:
                    RUN ponmens_inst.p ( INPUT "INST115" , INPUT "Tipocomprobante" ,  INPUT v-valor_c ).
                    RETURN ERROR.
                END.    

                v-tip_comprob = Tipocomprobante.tip_comprob.
                IF Tipocomprobante.usa_letra
                    THEN v-tip_comprob = REPLACE(v-tip_comprob,"*",Condicion_impos.tipo_factura).
     
                IF CAN-FIND(FIRST Fac_header
                                  WHERE Fac_header.cdg_empresa = que_empresa
                                    AND Fac_header.tip_comprob = v-tip_comprob
                                    AND Fac_header.prf_comprob = v-pto_venta
                                    AND Fac_header.fecha > v-fecha_transferencia)
                THEN DO:
                    RUN ponmensj.p ( INPUT "REMI061" ).
                    RETURN ERROR.
                END.

                FIND Tipocomprobante 
                    WHERE Tipocomprobante.cdg_comprobante = "CRTRAMON" 
                      AND Tipocomprobante.cdg_empresa = que_empresa
                          NO-LOCK NO-ERROR.
                IF NOT AVAILABLE Tipocomprobante
                THEN DO:
                    RUN ponmens_inst.p ( INPUT "INST116" , INPUT "Tipocomprobante" ,  INPUT v-valor_c ).
                    RETURN ERROR.
                END.    

                v-tip_comprob = Tipocomprobante.tip_comprob.
                IF Tipocomprobante.usa_letra
                    THEN v-tip_comprob = REPLACE(v-tip_comprob,"*",Condicion_impos.tipo_factura).
     
                IF CAN-FIND(FIRST Fac_header
                                  WHERE Fac_header.cdg_empresa = que_empresa
                                    AND Fac_header.tip_comprob = v-tip_comprob
                                    AND Fac_header.prf_comprob = v-pto_venta
                                    AND Fac_header.fecha > v-fecha_transferencia)
                THEN DO:
                    RUN ponmensj.p ( INPUT "REMI061" ).
                    RETURN ERROR.
                END.
            END.
        END.
    END.

    p-hay_error = NO.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

