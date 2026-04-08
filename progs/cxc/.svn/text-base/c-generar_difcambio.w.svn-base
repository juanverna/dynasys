&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win

/* Temp-Table and Buffer definitions                                    */
DEFINE BUFFER Moneda_origen FOR Moneda.
DEFINE TEMP-TABLE T-Cta_cte NO-UNDO LIKE Cta_cte
       FIELD saldo_comprobante LIKE Cta_cte.credito
       FIELD saldo_original LIKE Cta_cte.credito
       FIELD diferencia_cambio LIKE Cta_cte.credito
       FIELD saldo_equivalente LIKE Cta_cte.credito.


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
DEFINE VARIABLE v-codigo_dolar            LIKE Moneda.cdg_moneda.
DEFINE VARIABLE v-cambio_origen           LIKE Moneda.cambio.
DEFINE VARIABLE v-pto_venta-org           AS INTEGER.

DEFINE VARIABLE j-columna                 AS INTEGER.
DEFINE VARIABLE nt_cols                   AS INTEGER.
DEFINE VARIABLE h-columna                 AS HANDLE.
DEFINE VARIABLE hcol                      AS HANDLE EXTENT 100.

DEFINE VARIABLE v-cdg_cndventa            LIKE Condicion_venta.cdg_cndventa.

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
DEFINE BUFFER B-Dolar                     FOR Moneda.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME BROWSE_ORIGEN

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Cta_cte Moneda_origen

/* Definitions for BROWSE BROWSE_ORIGEN                                 */
&Scoped-define FIELDS-IN-QUERY-BROWSE_ORIGEN T-Cta_cte.tip_comprob T-Cta_cte.prf_comprob T-Cta_cte.nro_comprob T-Cta_cte.nro_vencimiento T-Cta_cte.fecha_emision Moneda_origen.abrevia T-Cta_cte.clausula_dolar T-Cta_cte.cambio T-Cta_cte.debito T-Cta_cte.saldo_comprobante T-Cta_cte.saldo_original T-Cta_cte.diferencia_cambio T-Cta_cte.saldo_equivalente   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE_ORIGEN   
&Scoped-define SELF-NAME BROWSE_ORIGEN
&Scoped-define QUERY-STRING-BROWSE_ORIGEN FOR EACH T-Cta_cte NO-LOCK, ~
             EACH Moneda_origen OF T-Cta_cte NO-LOCK
&Scoped-define OPEN-QUERY-BROWSE_ORIGEN OPEN QUERY {&SELF-NAME} FOR EACH T-Cta_cte NO-LOCK, ~
             EACH Moneda_origen OF T-Cta_cte NO-LOCK.
&Scoped-define TABLES-IN-QUERY-BROWSE_ORIGEN T-Cta_cte Moneda_origen
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE_ORIGEN T-Cta_cte
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE_ORIGEN Moneda_origen


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-BROWSE_ORIGEN}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-1 RECT-2 RECT-3 RECT-4 RECT-6 ~
v-cdg_cliente v-fecha_transferencia Btn_Done v-cambio_destino BROWSE_ORIGEN 
&Scoped-Define DISPLAYED-OBJECTS v-cdg_cliente v-dsc_cliente ~
v-fecha_transferencia v-pto_venta t_movdeb t_regdeb t_movcre t_regcre ~
v-cambio_destino v-monto_equivalente v-diferencia_cambio v-importe_total 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btn_compensar 
     LABEL "&Generar" 
     SIZE 14 BY 1.19.

DEFINE BUTTON Btn_Done DEFAULT 
     LABEL "&Salir" 
     SIZE 14 BY 1.24
     BGCOLOR 8 .

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
     SIZE 5 BY 1
     BGCOLOR 15 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE t_regdeb AS INTEGER FORMAT ">>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
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

DEFINE VARIABLE v-pto_venta AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 7 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 77 BY 1.67.

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

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE_ORIGEN FOR 
      T-Cta_cte, 
      Moneda_origen SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE_ORIGEN
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE_ORIGEN C-Win _FREEFORM
  QUERY BROWSE_ORIGEN NO-LOCK DISPLAY
      T-Cta_cte.tip_comprob FORMAT "X(3)":U
      T-Cta_cte.prf_comprob FORMAT "9999":U
      T-Cta_cte.nro_comprob FORMAT "ZZZZZZZ9":U
      T-Cta_cte.nro_vencimiento FORMAT ">>9":U
      T-Cta_cte.fecha_emision FORMAT "99/99/9999":U
      Moneda_origen.abrevia FORMAT "X(5)":U
      T-Cta_cte.clausula_dolar FORMAT "Si/No":U
      T-Cta_cte.cambio FORMAT "->>,>>9.9999":U
      T-Cta_cte.debito FORMAT "-ZZZ,ZZZ,ZZ9.99":U
      T-Cta_cte.saldo_comprobante FORMAT "-ZZZ,ZZZ,ZZ9.99":U COLUMN-LABEL "Saldo!Comprobante"
      T-Cta_cte.saldo_original FORMAT "-ZZZ,ZZZ,ZZ9.99":U COLUMN-LABEL "Saldo!Original"
      T-Cta_cte.diferencia_cambio FORMAT "-ZZZ,ZZZ,ZZ9.99":U COLUMN-LABEL "Diferencia!Cambio"
      T-Cta_cte.saldo_equivalente FORMAT "-ZZZ,ZZZ,ZZ9.99":U COLUMN-LABEL "Saldo!Equivalente"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS MULTIPLE SIZE 152 BY 19.29
         BGCOLOR 15 FGCOLOR 9 FONT 4
         TITLE BGCOLOR 15 FGCOLOR 9 "Movimientos de Cuenta Corriente".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     v-cdg_cliente AT ROW 3.14 COL 12 COLON-ALIGNED
     v-dsc_cliente AT ROW 3.14 COL 30 COLON-ALIGNED NO-LABEL
     v-fecha_transferencia AT ROW 3.14 COL 98 COLON-ALIGNED NO-LABEL
     v-pto_venta AT ROW 3.14 COL 113 COLON-ALIGNED NO-LABEL
     btn_compensar AT ROW 3.14 COL 127
     Btn_Done AT ROW 3.14 COL 142
     t_movdeb AT ROW 6.24 COL 6 COLON-ALIGNED
     t_regdeb AT ROW 6.24 COL 26 COLON-ALIGNED NO-LABEL
     t_movcre AT ROW 6.24 COL 36.8 COLON-ALIGNED
     t_regcre AT ROW 6.24 COL 56.8 COLON-ALIGNED NO-LABEL
     v-cambio_destino AT ROW 6.24 COL 63 COLON-ALIGNED NO-LABEL
     v-monto_equivalente AT ROW 6.24 COL 84 COLON-ALIGNED NO-LABEL
     v-diferencia_cambio AT ROW 6.24 COL 111 COLON-ALIGNED NO-LABEL
     v-importe_total AT ROW 6.24 COL 136 COLON-ALIGNED NO-LABEL
     BROWSE_ORIGEN AT ROW 7.91 COL 5
     "     Cambio" VIEW-AS TEXT
          SIZE 17 BY 1 AT ROW 4.81 COL 65
          BGCOLOR 5 FGCOLOR 15 FONT 6
     "   Total seleccionado" VIEW-AS TEXT
          SIZE 28 BY 1 AT ROW 4.81 COL 36
          BGCOLOR 5 FGCOLOR 15 FONT 6
     "+" VIEW-AS TEXT
          SIZE 2 BY .95 AT ROW 6.24 COL 108
          FONT 6
     "  Monto Equivalente" VIEW-AS TEXT
          SIZE 24 BY 1 AT ROW 4.81 COL 83
          BGCOLOR 5 FGCOLOR 15 FONT 6
     "    ImporteTotal" VIEW-AS TEXT
          SIZE 21 BY 1 AT ROW 4.81 COL 136
          BGCOLOR 5 FGCOLOR 15 FONT 6
     "=" VIEW-AS TEXT
          SIZE 3 BY .86 AT ROW 6.24 COL 134
          FONT 6
     "         Total Disponible" VIEW-AS TEXT
          SIZE 30 BY 1 AT ROW 4.81 COL 5
          BGCOLOR 5 FGCOLOR 15 FONT 6
     "             Acciones" VIEW-AS TEXT
          SIZE 31 BY 1 AT ROW 1.71 COL 126
          BGCOLOR 5 FGCOLOR 15 FONT 6
     "   Cliente cuyos movimientos se desea transferir" VIEW-AS TEXT
          SIZE 93 BY 1 AT ROW 1.71 COL 5
          BGCOLOR 5 FGCOLOR 15 FONT 6
     "  Diferencia de Cambio" VIEW-AS TEXT
          SIZE 27 BY 1 AT ROW 4.81 COL 108
          BGCOLOR 5 FGCOLOR 15 FONT 6
     "  Fecha y Ctro. Emisor" VIEW-AS TEXT
          SIZE 26 BY 1 AT ROW 1.71 COL 99
          BGCOLOR 5 FGCOLOR 15 FONT 6
     RECT-1 AT ROW 5.91 COL 5
     RECT-2 AT ROW 5.91 COL 83.2
     RECT-3 AT ROW 2.91 COL 5
     RECT-4 AT ROW 2.91 COL 99
     RECT-6 AT ROW 2.91 COL 126
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
      TABLE: Moneda_origen B "?" ? sic Moneda
      TABLE: T-Cta_cte T "?" NO-UNDO sic Cta_cte
      ADDITIONAL-FIELDS:
          FIELD saldo_comprobante LIKE Cta_cte.credito
          FIELD saldo_original LIKE Cta_cte.credito
          FIELD diferencia_cambio LIKE Cta_cte.credito
          FIELD saldo_equivalente LIKE Cta_cte.credito
      END-FIELDS.
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
/* BROWSE-TAB BROWSE_ORIGEN v-importe_total DEFAULT-FRAME */
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
/* SETTINGS FOR FILL-IN v-diferencia_cambio IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_cliente IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-importe_total IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-monto_equivalente IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-pto_venta IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE_ORIGEN
/* Query rebuild information for BROWSE BROWSE_ORIGEN
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH T-Cta_cte NO-LOCK,
      EACH Moneda_origen OF T-Cta_cte NO-LOCK.
     _END_FREEFORM
     _Options          = "NO-LOCK"
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


&Scoped-define BROWSE-NAME BROWSE_ORIGEN
&Scoped-define SELF-NAME BROWSE_ORIGEN
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE_ORIGEN C-Win
ON MOUSE-SELECT-DBLCLICK OF BROWSE_ORIGEN IN FRAME DEFAULT-FRAME /* Movimientos de Cuenta Corriente */
OR "RETURN" OF BROWSE_ORIGEN IN FRAME {&FRAME-NAME}
DO:

  IF NOT AVAILABLE T-Cta_cte 
  THEN DO:
     BELL.
     MESSAGE "La lista de documentos DISPONIBLES está vacía"
       VIEW-AS ALERT-BOX ERROR BUTTONS OK.
     RETURN NO-APPLY.
  END.

  /* Mueve un registro de una tabla a otra */

  ASSIGN  T-Cta_cte.selectado = NOT T-Cta_cte.selectado.

  RUN abre_query.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE_ORIGEN C-Win
ON ROW-DISPLAY OF BROWSE_ORIGEN IN FRAME DEFAULT-FRAME /* Movimientos de Cuenta Corriente */
DO:
    DEFINE VARIABLE col_fgselectado AS INTEGER NO-UNDO INITIAL 15.
    DEFINE VARIABLE col_bgselectado AS INTEGER NO-UNDO INITIAL 2.

    DEFINE VARIABLE col_fgnoselect  AS INTEGER NO-UNDO INITIAL 9.
    DEFINE VARIABLE col_bgnoselect  AS INTEGER NO-UNDO INITIAL 15.

    DEFINE VARIABLE col_fg          AS INTEGER NO-UNDO INITIAL 9.
    DEFINE VARIABLE col_bg          AS INTEGER NO-UNDO INITIAL 15.

    IF T-Cta_cte.selectado
        THEN ASSIGN col_fg = col_fgselectado
                    col_bg = col_bgselectado.
        ELSE ASSIGN col_fg = col_fgnoselect
                    col_bg = col_bgnoselect.

    DO j-columna = 1 TO nt_cols:
        ASSIGN hcol [ j-columna ]:FGCOLOR = col_fg
               hcol [ j-columna ]:BGCOLOR = col_bg.
    END.
    
 /* IF T-Cta_cte.selectado
    THEN DO:
        ASSIGN Moneda_origen.abrevia:FGCOLOR IN BROWSE BROWSE_ORIGEN = 15
               T-Cta_cte.cambio:FGCOLOR IN BROWSE BROWSE_ORIGEN = 15 
               T-Cta_cte.clausula_dolar:FGCOLOR IN BROWSE BROWSE_ORIGEN = 15 
               T-Cta_cte.debito:FGCOLOR IN BROWSE BROWSE_ORIGEN = 15 
               T-Cta_cte.fecha_emision:FGCOLOR IN BROWSE BROWSE_ORIGEN = 15 
               T-Cta_cte.nro_comprob:FGCOLOR IN BROWSE BROWSE_ORIGEN = 15 
               T-Cta_cte.nro_vencimiento:FGCOLOR IN BROWSE BROWSE_ORIGEN = 15 
               T-Cta_cte.prf_comprob:FGCOLOR IN BROWSE BROWSE_ORIGEN = 15 
               T-Cta_cte.tip_comprob:FGCOLOR IN BROWSE BROWSE_ORIGEN = 15

               Moneda_origen.abrevia:BGCOLOR IN BROWSE BROWSE_ORIGEN = 2
               T-Cta_cte.cambio:BGCOLOR IN BROWSE BROWSE_ORIGEN = 2 
               T-Cta_cte.clausula_dolar:BGCOLOR IN BROWSE BROWSE_ORIGEN = 2 
               T-Cta_cte.debito:BGCOLOR IN BROWSE BROWSE_ORIGEN = 2 
               T-Cta_cte.fecha_emision:BGCOLOR IN BROWSE BROWSE_ORIGEN = 2 
               T-Cta_cte.nro_comprob:BGCOLOR IN BROWSE BROWSE_ORIGEN = 2 
               T-Cta_cte.nro_vencimiento:BGCOLOR IN BROWSE BROWSE_ORIGEN = 2 
               T-Cta_cte.prf_comprob:BGCOLOR IN BROWSE BROWSE_ORIGEN = 2 
               T-Cta_cte.tip_comprob:BGCOLOR IN BROWSE BROWSE_ORIGEN = 2.
    END.
    ELSE DO:
        ASSIGN Moneda_origen.abrevia:FGCOLOR IN BROWSE BROWSE_ORIGEN = 9
               T-Cta_cte.cambio:FGCOLOR IN BROWSE BROWSE_ORIGEN = 9 
               T-Cta_cte.clausula_dolar:FGCOLOR IN BROWSE BROWSE_ORIGEN = 9 
               T-Cta_cte.debito:FGCOLOR IN BROWSE BROWSE_ORIGEN = 9 
               T-Cta_cte.fecha_emision:FGCOLOR IN BROWSE BROWSE_ORIGEN = 9 
               T-Cta_cte.nro_comprob:FGCOLOR IN BROWSE BROWSE_ORIGEN = 9 
               T-Cta_cte.nro_vencimiento:FGCOLOR IN BROWSE BROWSE_ORIGEN = 9 
               T-Cta_cte.prf_comprob:FGCOLOR IN BROWSE BROWSE_ORIGEN = 9 
               T-Cta_cte.tip_comprob:FGCOLOR IN BROWSE BROWSE_ORIGEN = 9

               Moneda_origen.abrevia:BGCOLOR IN BROWSE BROWSE_ORIGEN = 15
               T-Cta_cte.cambio:BGCOLOR IN BROWSE BROWSE_ORIGEN = 15 
               T-Cta_cte.clausula_dolar:BGCOLOR IN BROWSE BROWSE_ORIGEN = 15 
               T-Cta_cte.debito:BGCOLOR IN BROWSE BROWSE_ORIGEN = 15 
               T-Cta_cte.fecha_emision:BGCOLOR IN BROWSE BROWSE_ORIGEN = 15 
               T-Cta_cte.nro_comprob:BGCOLOR IN BROWSE BROWSE_ORIGEN = 15 
               T-Cta_cte.nro_vencimiento:BGCOLOR IN BROWSE BROWSE_ORIGEN = 15 
               T-Cta_cte.prf_comprob:BGCOLOR IN BROWSE BROWSE_ORIGEN = 15 
               T-Cta_cte.tip_comprob:BGCOLOR IN BROWSE BROWSE_ORIGEN = 15.

    END.*/


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_compensar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_compensar C-Win
ON CHOOSE OF btn_compensar IN FRAME DEFAULT-FRAME /* Generar */
DO:
    DEFINE VARIABLE sino AS LOGICAL.
    DEFINE VARIABLE hay_error AS LOGICAL.

    /*
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
    */

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
  RUN abre_query.
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
/*RUN hallar_cambio ( INPUT v-nro_monedaorigen , INPUT v-fecha_transferencia, OUTPUT v-cambio_origen ).*/
/*RUN hallar_cambio ( INPUT v-nro_monedadestino , INPUT v-fecha_transferencia, OUTPUT v-cambio_destino ).*/
  RUN hallar_cambio ( INPUT B-Dolar.nro_moneda , INPUT v-fecha_transferencia, OUTPUT v-cambio_destino ).
  DISPLAY v-cambio_destino
      WITH FRAME {&FRAME-NAME}.
  RUN abre_query.

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
  
{setwintit.i "SIC/CXC" "Generación de Diferencias de Cambio"}
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

RUN getparametro_c.p (  INPUT  "CDGDOLAR", OUTPUT v-codigo_dolar ).
FIND B-Dolar WHERE B-Dolar.cdg_moneda = v-codigo_dolar NO-LOCK.

/*RUN CARPARAM.P.*/
  
nt_cols = BROWSE_ORIGEN:NUM-COLUMNS.
h-columna = BROWSE_ORIGEN:FIRST-COLUMN.
DO j-columna = 1 TO nt_cols:
    hcol [ j-columna ] = h-columna.
    h-columna = h-columna:NEXT-COLUMN. 
END.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  SESSION:DATA-ENTRY-RETURN = YES.
  RUN inicia_combos.
  RUN enable_UI.

  DISPLAY v-fecha_transferencia v-pto_venta
      WITH FRAME {&FRAME-NAME}.

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
            
  t_movdeb = 0.
  t_regdeb = 0.

  FOR EACH T-Cta_cte WHERE NOT T-Cta_cte.selectado:
      t_movdeb = t_movdeb + T-Cta_cte.debito - T-Cta_cte.credito.
      t_regdeb = t_regdeb + 1.
      T-Cta_cte.diferencia_cambio = 0.
  END.

  ASSIGN t_movcre = 0
         t_regcre = 0
         v-diferencia_cambio = 0
         v-monto_equivalente = 0.

  FOR EACH T-Cta_cte WHERE T-Cta_cte.selectado:

      t_movcre = t_movcre + T-Cta_cte.debito - T-Cta_cte.credito.
      t_regcre = t_regcre + 1.
          
      /*
      RUN hallar_tasa_cambio.p  ( INPUT Moneda_origen.cdg_moneda,
                                  INPUT Moneda_destino.cdg_moneda,
                                  INPUT v-fecha_transferencia,
                                  OUTPUT T-Cta_cte.cambio_destino,
                                  OUTPUT x-fecha ).
      */                            

      IF T-Cta_cte.clausula_dolar
      THEN DO:
          ASSIGN T-Cta_cte.diferencia_cambio = T-Cta_cte.saldo_comprobante / T-Cta_cte.cambio * 
                                                 ( v-cambio_destino - T-Cta_cte.cambio ).
      END.
      ELSE DO:
          ASSIGN T-Cta_cte.diferencia_cambio = T-Cta_cte.saldo_comprobante * ( v-cambio_destino - T-Cta_cte.cambio ).
      END.

      ASSIGN 
             v-diferencia_cambio = v-diferencia_cambio + T-Cta_cte.diferencia_cambio
             v-monto_equivalente = v-monto_equivalente + T-Cta_cte.saldo_equivalente.
           
  END.

  v-importe_total = v-diferencia_cambio + v-monto_equivalente.

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

  OPEN QUERY BROWSE_ORIGEN
       FOR EACH T-Cta_cte, FIRST Moneda_origen OF T-Cta_cte
           BY T-Cta_cte.fecha_emision. 

  btn_compensar:SENSITIVE IN FRAME {&FRAME-NAME} = CAN-FIND(FIRST T-Cta_cte).

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
           T-Fac_header.nro_moneda        = Moneda_local.nro_moneda
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
    
    FOR EACH T-Cta_cte WHERE T-Cta_cte.diferencia_cambio <> 0:
        T-Fac_header.imp_total = T-Fac_header.imp_total + T-Cta_cte.diferencia_cambio.    
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

    FIND Condicion_venta WHERE Condicion_venta.cdg_cndventa = v-cdg_cndventa.

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
           T-Fac_header.nro_moneda        = Moneda_local.nro_moneda
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
    
    FOR EACH T-Cta_cte:
        T-Fac_header.imp_total = T-Fac_header.imp_total + T-Cta_cte.saldo_equivalente.    
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
  DISPLAY v-cdg_cliente v-dsc_cliente v-fecha_transferencia v-pto_venta t_movdeb 
          t_regdeb t_movcre t_regcre v-cambio_destino v-monto_equivalente 
          v-diferencia_cambio v-importe_total 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE RECT-1 RECT-2 RECT-3 RECT-4 RECT-6 v-cdg_cliente v-fecha_transferencia 
         Btn_Done v-cambio_destino BROWSE_ORIGEN 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
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
    
    RUN getparametro_c.p (  INPUT  "DFTSLCNV", OUTPUT v-valor_c ).
    FIND Condicion_venta WHERE Condicion_venta.cdg_cndventa = v-valor_c NO-LOCK NO-ERROR.
    IF NOT AVAILABLE Condicion_venta 
    THEN DO:
    RUN ponmens_inst.p ( INPUT "INST113" , INPUT "Condicion_venta" ,  INPUT v-valor_c ).
    RETURN ERROR.
    END.    
    
    v-cdg_cndventa = Condicion_venta.cdg_cndventa.


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
    
    EMPTY TEMP-TABLE  T-Cta_cte.
    
    FOR EACH Cta_cte OF Cliente 
      WHERE Cta_cte.cdg_empresa = que_empresa
        AND Cta_cte.debito <> Cta_cte.credito
        AND NOT Cta_cte.es_difcambio NO-LOCK, 
            FIRST Moneda OF Cta_cte NO-LOCK:

        IF NOT Moneda.es_local OR Cta_cte.clausula_dolar 
        THEN DO:
            CREATE T-Cta_cte.
            BUFFER-COPY Cta_cte TO T-Cta_cte
                ASSIGN T-Cta_cte.saldo_comprobante = T-Cta_cte.debito - T-Cta_cte.credito
                       T-Cta_cte.saldo_original    = T-Cta_cte.saldo_comprobante
                       T-Cta_cte.cambio = IF Cta_cte.clausula_dolar THEN Cta_cte.cambio_dolar ELSE Cta_cte.cambio
                       T-Cta_cte.saldo_equivalente  = IF T-Cta_cte.clausula_dolar 
                                                         THEN T-Cta_cte.saldo_comprobante 
                                                         ELSE T-Cta_cte.saldo_comprobante * T-Cta_cte.cambio.
                 
      END.                           
                           
        
        /*
        IF v-nro_monedaorigen <> v-nro_monedadestino
        THEN DO:

            /* Halla la cotización de la moneda de destino */
            /* para la fecha de emisión del comprobante    */
            /*
            RUN hallar_cambio ( INPUT v-nro_monedadestino,
                                INPUT Cta_cte.fecha_emision,
                                OUTPUT x-cambio).
            */
            /* Asigna la tasa de cambio entre una moneda y otra */

            ASSIGN T-Cta_cte.cambio = Cta_cte.cambio / x-cambio.

        END.
        ELSE DO:

            /* Si las monedas son iguales el cambio relativo es 1 */

            ASSIGN T-Cta_cte.cambio = 1.

        END.
        */

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
      
    BROWSE_ORIGEN:SENSITIVE IN FRAME {&FRAME-NAME} = YES.

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

