&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win

/* Temp-Table and Buffer definitions                                    */
DEFINE BUFFER CC_acreditan FOR Cta_cte_prv.
DEFINE BUFFER CC_debitan FOR Cta_cte_prv.
DEFINE TEMP-TABLE T-Opg_detalle_acreditan LIKE Opg_detalle.
DEFINE TEMP-TABLE T-Opg_detalle_debitan LIKE Opg_detalle.


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
     will execute in this procedure's storage,4 and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

{NRORELEA.I}
{VRSHARED.I}
{valoresvalor.i}

DEFINE VARIABLE rid_proveedor     AS   ROWID.
DEFINE VARIABLE mensaje           AS   CHARACTER FORMAT "X(40)".
DEFINE VARIABLE saldo-deb         LIKE Cta_cte_prv.debito.
DEFINE VARIABLE saldo-cre         LIKE Cta_cte_prv.credito.
DEFINE VARIABLE que_importe       AS   DECIMAL    NO-UNDO.
DEFINE VARIABLE que_facprov       LIKE Fac_header_prv.nro_facprov.
DEFINE VARIABLE que_nro_moneda    AS INTEGER    NO-UNDO.


DEFINE VARIABLE que_proveedor     AS INTEGER    NO-UNDO.
DEFINE VARIABLE mensaje_mail      AS CHARACTER  NO-UNDO.
DEFINE VARIABLE que_moneda        LIKE Moneda.nro_moneda.
DEFINE VARIABLE que_empresa       LIKE Empresa.cdg_empresa.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME BROWSE-CRE

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES CC_acreditan CC_debitan Proveedor

/* Definitions for BROWSE BROWSE-CRE                                    */
&Scoped-define FIELDS-IN-QUERY-BROWSE-CRE CC_acreditan.selectado ~
CC_acreditan.tip_comprob CC_acreditan.prf_comprob CC_acreditan.nro_comprob ~
CC_acreditan.nro_vencimiento CC_acreditan.fecha_emision ~
CC_acreditan.credito - CC_acreditan.debito CC_acreditan.nro_moneda ~
CC_acreditan.leyenda 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-CRE 
&Scoped-define QUERY-STRING-BROWSE-CRE FOR EACH CC_acreditan OF Proveedor ~
      WHERE CC_acreditan.credito > CC_acreditan.debito ~
 ~
 ~
 NO-LOCK
&Scoped-define OPEN-QUERY-BROWSE-CRE OPEN QUERY BROWSE-CRE FOR EACH CC_acreditan OF Proveedor ~
      WHERE CC_acreditan.credito > CC_acreditan.debito ~
 ~
 ~
 NO-LOCK.
&Scoped-define TABLES-IN-QUERY-BROWSE-CRE CC_acreditan
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-CRE CC_acreditan


/* Definitions for BROWSE BROWSE-DEB                                    */
&Scoped-define FIELDS-IN-QUERY-BROWSE-DEB CC_debitan.selectado ~
CC_debitan.tip_comprob CC_debitan.prf_comprob CC_debitan.nro_comprob ~
CC_debitan.nro_vencimiento CC_debitan.fecha_emision ~
CC_debitan.debito - CC_debitan.credito CC_debitan.nro_moneda ~
CC_debitan.leyenda 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-DEB 
&Scoped-define QUERY-STRING-BROWSE-DEB FOR EACH CC_debitan OF Proveedor ~
      WHERE CC_debitan.debito > CC_debitan.credito ~
 ~
 NO-LOCK
&Scoped-define OPEN-QUERY-BROWSE-DEB OPEN QUERY BROWSE-DEB FOR EACH CC_debitan OF Proveedor ~
      WHERE CC_debitan.debito > CC_debitan.credito ~
 ~
 NO-LOCK.
&Scoped-define TABLES-IN-QUERY-BROWSE-DEB CC_debitan
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-DEB CC_debitan


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define FIELDS-IN-QUERY-DEFAULT-FRAME Proveedor.nombre ~
Proveedor.cdg_proveedor 
&Scoped-define ENABLED-FIELDS-IN-QUERY-DEFAULT-FRAME ~
Proveedor.cdg_proveedor 
&Scoped-define ENABLED-TABLES-IN-QUERY-DEFAULT-FRAME Proveedor
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-DEFAULT-FRAME Proveedor
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-BROWSE-CRE}~
    ~{&OPEN-QUERY-BROWSE-DEB}
&Scoped-define QUERY-STRING-DEFAULT-FRAME FOR EACH Proveedor SHARE-LOCK
&Scoped-define OPEN-QUERY-DEFAULT-FRAME OPEN QUERY DEFAULT-FRAME FOR EACH Proveedor SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-DEFAULT-FRAME Proveedor
&Scoped-define FIRST-TABLE-IN-QUERY-DEFAULT-FRAME Proveedor


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Proveedor.cdg_proveedor 
&Scoped-define ENABLED-TABLES Proveedor
&Scoped-define FIRST-ENABLED-TABLE Proveedor
&Scoped-Define ENABLED-OBJECTS RECT-1 RECT-2 RECT-3 RECT-4 RECT-5 RECT-6 ~
btn_credito btn_debito btn_credito-in btn_debito-in btn_compensar Btn_Done ~
v-saldo-a-imputar id_moneda des_fecha-deb has_fecha-deb t_regdeb ~
des_fecha-cre has_fecha-cre t_regcre BROWSE-DEB BROWSE-CRE 
&Scoped-Define DISPLAYED-FIELDS Proveedor.nombre Proveedor.cdg_proveedor 
&Scoped-define DISPLAYED-TABLES Proveedor
&Scoped-define FIRST-DISPLAYED-TABLE Proveedor
&Scoped-Define DISPLAYED-OBJECTS saldo v-saldo-a-imputar id_moneda ~
des_fecha-deb has_fecha-deb v_abrevia_deb t_movdeb t_regdeb des_fecha-cre ~
has_fecha-cre v_abrevia_cre t_movcre t_regcre 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btn_compensar 
     LABEL "C&ompensar" 
     SIZE 23 BY 1.24.

DEFINE BUTTON btn_credito 
     LABEL "&Créditos" 
     SIZE 23 BY 1.24.

DEFINE BUTTON btn_credito-in 
     LABEL "&Créditos" 
     SIZE 23 BY 1.24.

DEFINE BUTTON btn_debito 
     LABEL "&Débitos" 
     SIZE 23 BY 1.24.

DEFINE BUTTON btn_debito-in 
     LABEL "&Débitos" 
     SIZE 23 BY 1.24.

DEFINE BUTTON Btn_Done DEFAULT 
     LABEL "&Salir" 
     SIZE 23 BY 1.24
     BGCOLOR 8 .

DEFINE VARIABLE id_moneda AS CHARACTER FORMAT "X(256)":U INITIAL "0" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Item 1","0"
     DROP-DOWN-LIST
     SIZE 27 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE des_fecha-cre AS DATE FORMAT "99/99/9999":U 
     LABEL "Del" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE des_fecha-deb AS DATE FORMAT "99/99/9999":U 
     LABEL "Del" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE has_fecha-cre AS DATE FORMAT "99/99/9999":U 
     LABEL "Al" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE has_fecha-deb AS DATE FORMAT "99/99/9999":U 
     LABEL "Al" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE saldo AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     LABEL "Diferencia" 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 13 FONT 4 NO-UNDO.

DEFINE VARIABLE t_movcre AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     LABEL "" 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15 FGCOLOR 12 FONT 4 NO-UNDO.

DEFINE VARIABLE t_movdeb AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     LABEL "" 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15 FGCOLOR 12 FONT 4 NO-UNDO.

DEFINE VARIABLE t_regcre AS INTEGER FORMAT ">>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1 NO-UNDO.

DEFINE VARIABLE t_regdeb AS INTEGER FORMAT ">>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1 NO-UNDO.

DEFINE VARIABLE v-saldo-a-imputar AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     LABEL "Imputar" 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE v_abrevia_cre AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 7 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 6 NO-UNDO.

DEFINE VARIABLE v_abrevia_deb AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 7 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 74 BY 2.05.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 74 BY 2.29.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 151 BY 1.76.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 49 BY 1.57.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 49 BY 1.76.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 49 BY 1.76.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-CRE FOR 
      CC_acreditan SCROLLING.

DEFINE QUERY BROWSE-DEB FOR 
      CC_debitan SCROLLING.

DEFINE QUERY DEFAULT-FRAME FOR 
      Proveedor SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-CRE
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-CRE C-Win _STRUCTURED
  QUERY BROWSE-CRE NO-LOCK DISPLAY
      CC_acreditan.selectado FORMAT "*/":U
      CC_acreditan.tip_comprob FORMAT "X(3)":U
      CC_acreditan.prf_comprob FORMAT "9999":U
      CC_acreditan.nro_comprob FORMAT "ZZZZZZZ9":U
      CC_acreditan.nro_vencimiento FORMAT ">>9":U
      CC_acreditan.fecha_emision FORMAT "99/99/99":U
      CC_acreditan.credito - CC_acreditan.debito COLUMN-LABEL "Saldo" FORMAT "->,>>>,>>9.99":U
      CC_acreditan.nro_moneda FORMAT ">>9":U
      CC_acreditan.leyenda FORMAT "X(35)":U WIDTH 10.6
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 75 BY 16.19
         BGCOLOR 15 FONT 4
         TITLE BGCOLOR 15 "Movimientos que acreditan en la cuenta" ROW-HEIGHT-CHARS .71 EXPANDABLE.

DEFINE BROWSE BROWSE-DEB
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-DEB C-Win _STRUCTURED
  QUERY BROWSE-DEB NO-LOCK DISPLAY
      CC_debitan.selectado FORMAT "*/":U
      CC_debitan.tip_comprob FORMAT "X(3)":U
      CC_debitan.prf_comprob FORMAT "9999":U
      CC_debitan.nro_comprob FORMAT "ZZZZZZZ9":U
      CC_debitan.nro_vencimiento FORMAT ">>9":U
      CC_debitan.fecha_emision FORMAT "99/99/99":U
      CC_debitan.debito - CC_debitan.credito COLUMN-LABEL "Saldo" FORMAT "->,>>>,>>9.99":U
      CC_debitan.nro_moneda FORMAT ">>9":U
      CC_debitan.leyenda FORMAT "X(35)":U WIDTH 9.6
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 74 BY 16.19
         BGCOLOR 15 FONT 4
         TITLE BGCOLOR 15 "Movimientos que debitan en la cuenta" ROW-HEIGHT-CHARS .67 EXPANDABLE.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btn_credito AT ROW 3.38 COL 7
     btn_debito AT ROW 3.38 COL 31
     btn_credito-in AT ROW 3.38 COL 58
     btn_debito-in AT ROW 3.38 COL 82
     btn_compensar AT ROW 3.38 COL 109
     Btn_Done AT ROW 3.38 COL 133
     saldo AT ROW 5.76 COL 83 COLON-ALIGNED
     v-saldo-a-imputar AT ROW 5.76 COL 110 COLON-ALIGNED
     id_moneda AT ROW 5.76 COL 126 COLON-ALIGNED NO-LABEL
     Proveedor.nombre AT ROW 5.86 COL 28 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 43 BY 1
          BGCOLOR 7 FGCOLOR 15 
     Proveedor.cdg_proveedor AT ROW 5.91 COL 17 COLON-ALIGNED
          LABEL "Proveedor"
          VIEW-AS FILL-IN 
          SIZE 10 BY 1
     des_fecha-deb AT ROW 9.57 COL 10 COLON-ALIGNED
     has_fecha-deb AT ROW 9.57 COL 30 COLON-ALIGNED
     v_abrevia_deb AT ROW 9.57 COL 47 COLON-ALIGNED NO-LABEL
     t_movdeb AT ROW 9.57 COL 55 COLON-ALIGNED
     t_regdeb AT ROW 9.57 COL 68 COLON-ALIGNED NO-LABEL
     des_fecha-cre AT ROW 9.57 COL 86 COLON-ALIGNED
     has_fecha-cre AT ROW 9.57 COL 106 COLON-ALIGNED
     v_abrevia_cre AT ROW 9.57 COL 123 COLON-ALIGNED NO-LABEL
     t_movcre AT ROW 9.57 COL 131 COLON-ALIGNED
     t_regcre AT ROW 9.57 COL 144 COLON-ALIGNED NO-LABEL
     BROWSE-DEB AT ROW 11.24 COL 6
     BROWSE-CRE AT ROW 11.24 COL 82
     "                       Acciones" VIEW-AS TEXT
          SIZE 48.8 BY 1 AT ROW 1.95 COL 108
          BGCOLOR 5 FGCOLOR 15 FONT 6
     "               Documentos Internos" VIEW-AS TEXT
          SIZE 49 BY 1 AT ROW 1.95 COL 57
          BGCOLOR 5 FGCOLOR 15 FONT 6
     "                     Mostrar créditos entre fechas" VIEW-AS TEXT
          SIZE 73.8 BY 1 AT ROW 7.67 COL 82.2
          BGCOLOR 5 FGCOLOR 15 FONT 6
     "                         Mostrar débitos entre fechas" VIEW-AS TEXT
          SIZE 74.4 BY 1 AT ROW 7.67 COL 6
          BGCOLOR 5 FGCOLOR 15 FONT 6
     "               Documentos Externos" VIEW-AS TEXT
          SIZE 49 BY 1 AT ROW 1.95 COL 6
          BGCOLOR 5 FGCOLOR 15 FONT 6
     RECT-1 AT ROW 8.86 COL 6
     RECT-2 AT ROW 8.86 COL 82
     RECT-3 AT ROW 5.52 COL 6
     RECT-4 AT ROW 3.14 COL 6
     RECT-5 AT ROW 3.14 COL 57
     RECT-6 AT ROW 3.14 COL 108
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 160 BY 27.33
         FONT 4.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: CC_acreditan B "?" ? sic Cta_cte_prv
      TABLE: CC_debitan B "?" ? sic Cta_cte_prv
      TABLE: T-Opg_detalle_acreditan T "?" ? sic Opg_detalle
      TABLE: T-Opg_detalle_debitan T "?" ? sic Opg_detalle
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Calce de Documentos en Cta.Cte. de Proveedores"
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
                                                                        */
/* BROWSE-TAB BROWSE-DEB t_regcre DEFAULT-FRAME */
/* BROWSE-TAB BROWSE-CRE BROWSE-DEB DEFAULT-FRAME */
/* SETTINGS FOR FILL-IN Proveedor.cdg_proveedor IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Proveedor.nombre IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN saldo IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN t_movcre IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN t_movdeb IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v_abrevia_cre IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v_abrevia_deb IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-CRE
/* Query rebuild information for BROWSE BROWSE-CRE
     _TblList          = "CC_acreditan OF sic.Proveedor"
     _Options          = "NO-LOCK"
     _Where[1]         = "CC_acreditan.credito > CC_acreditan.debito


"
     _FldNameList[1]   = Temp-Tables.CC_acreditan.selectado
     _FldNameList[2]   = Temp-Tables.CC_acreditan.tip_comprob
     _FldNameList[3]   = Temp-Tables.CC_acreditan.prf_comprob
     _FldNameList[4]   = Temp-Tables.CC_acreditan.nro_comprob
     _FldNameList[5]   = Temp-Tables.CC_acreditan.nro_vencimiento
     _FldNameList[6]   = Temp-Tables.CC_acreditan.fecha_emision
     _FldNameList[7]   > "_<CALC>"
"CC_acreditan.credito - CC_acreditan.debito" "Saldo" "->,>>>,>>9.99" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[8]   = Temp-Tables.CC_acreditan.nro_moneda
     _FldNameList[9]   > Temp-Tables.CC_acreditan.leyenda
"CC_acreditan.leyenda" ? ? "character" ? ? ? ? ? ? no ? no no "10.6" yes no no "U" "" ""
     _Query            is OPENED
*/  /* BROWSE BROWSE-CRE */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-DEB
/* Query rebuild information for BROWSE BROWSE-DEB
     _TblList          = "CC_debitan OF sic.Proveedor"
     _Options          = "NO-LOCK"
     _Where[1]         = "CC_debitan.debito > CC_debitan.credito

"
     _FldNameList[1]   = Temp-Tables.CC_debitan.selectado
     _FldNameList[2]   = Temp-Tables.CC_debitan.tip_comprob
     _FldNameList[3]   = Temp-Tables.CC_debitan.prf_comprob
     _FldNameList[4]   = Temp-Tables.CC_debitan.nro_comprob
     _FldNameList[5]   = Temp-Tables.CC_debitan.nro_vencimiento
     _FldNameList[6]   = Temp-Tables.CC_debitan.fecha_emision
     _FldNameList[7]   > "_<CALC>"
"CC_debitan.debito - CC_debitan.credito" "Saldo" "->,>>>,>>9.99" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[8]   = Temp-Tables.CC_debitan.nro_moneda
     _FldNameList[9]   > Temp-Tables.CC_debitan.leyenda
"CC_debitan.leyenda" ? ? "character" ? ? ? ? ? ? no ? no no "9.6" yes no no "U" "" ""
     _Query            is OPENED
*/  /* BROWSE BROWSE-DEB */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME DEFAULT-FRAME
/* Query rebuild information for FRAME DEFAULT-FRAME
     _TblList          = "sic.Proveedor"
     _Query            is OPENED
*/  /* FRAME DEFAULT-FRAME */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Calce de Documentos en Cta.Cte. de Proveedores */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Calce de Documentos en Cta.Cte. de Proveedores */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-CRE
&Scoped-define SELF-NAME BROWSE-CRE
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-CRE C-Win
ON MOUSE-SELECT-DBLCLICK OF BROWSE-CRE IN FRAME DEFAULT-FRAME /* Movimientos que acreditan en la cuenta */
DO:

  IF NOT AVAILABLE CC_acreditan
  THEN DO:
     BELL.
     MESSAGE "No hay créditos que puedan compensarse"
       VIEW-AS ALERT-BOX ERROR BUTTONS OK.
     RETURN NO-APPLY.
  END.

  FIND CURRENT CC_acreditan EXCLUSIVE-LOCK.
  CC_acreditan.selectado = NOT CC_acreditan.selectado.

  IF CC_acreditan.selectado 
  THEN DO:
       t_movcre = t_movcre + ( CC_acreditan.credito - CC_acreditan.debito ).
       t_regcre = t_regcre + 1.
  END.     
  ELSE DO:
       t_movcre = t_movcre - ( CC_acreditan.credito - CC_acreditan.debito ).  
       t_regcre = t_regcre - 1.
  END.     

  DISPLAY CC_acreditan.selectado
          WITH BROWSE BROWSE-CRE. 
  FIND CURRENT CC_acreditan NO-LOCK.
  
  RUN PONER_TOTALES.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-DEB
&Scoped-define SELF-NAME BROWSE-DEB
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-DEB C-Win
ON MOUSE-SELECT-DBLCLICK OF BROWSE-DEB IN FRAME DEFAULT-FRAME /* Movimientos que debitan en la cuenta */
DO:

  IF NOT AVAILABLE CC_debitan 
  THEN DO:
     BELL.
     MESSAGE "No hay débitos que puedan compensarse"
       VIEW-AS ALERT-BOX ERROR BUTTONS OK.
     RETURN NO-APPLY.
  END.

  FIND CURRENT CC_debitan EXCLUSIVE-LOCK.
  CC_debitan.selectado = NOT CC_debitan.selectado.
  IF CC_debitan.selectado 
  THEN DO:
       t_movdeb = t_movdeb + ( CC_debitan.debito - CC_debitan.credito ).
       t_regdeb = t_regdeb + 1.
  END.
  ELSE DO:
       t_movdeb = t_movdeb - ( CC_debitan.debito - CC_debitan.credito ).  
       t_regdeb = t_regdeb - 1.
  END.     

  DISPLAY CC_debitan.selectado
          WITH BROWSE BROWSE-DEB. 
  FIND CURRENT CC_debitan NO-LOCK.

  RUN PONER_TOTALES.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_compensar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_compensar C-Win
ON CHOOSE OF btn_compensar IN FRAME DEFAULT-FRAME /* Compensar */
DO:

DEFINE VARIABLE directorio AS CHARACTER  NO-UNDO.
DEFINE VARIABLE diferencia AS DECIMAL    NO-UNDO.
DEFINE VARIABLE v-total_debitan     AS DECIMAL    NO-UNDO.
DEFINE VARIABLE v-total_acreditan   AS DECIMAL    NO-UNDO.
DEFINE VARIABLE v-total_diferencia  AS DECIMAL    NO-UNDO.
DEFINE VARIABLE v-total_restan      AS DECIMAL    NO-UNDO.
DEFINE VARIABLE ultima            AS ROWID      NO-UNDO.


DEFINE VARIABLE tiene_op AS LOGICAL    NO-UNDO.
DEFINE VARIABLE todo_ok  AS LOGICAL    NO-UNDO.

   ASSIGN v-saldo-a-imputar.

   TODO_OK = YES.

  IF t_regdeb = 0
  THEN DO:
       RUN PONMENSJ.P ( INPUT "CLCE001" ).
       RETURN NO-APPLY.
  END.     

  IF t_regcre = 0
  THEN DO:
       RUN PONMENSJ.P ( INPUT "CLCE002" ).
       RETURN NO-APPLY.
  END.     

  IF t_regdeb > 1 AND t_regcre > 1 
  THEN DO:
       RUN PONMENSJ.P ( INPUT "CLCE004" ).
       RETURN NO-APPLY.
  END.     

  IF t_regdeb <> 1 OR t_regcre <> 1
  THEN DO:

    IF t_regdeb = 1 AND saldo < 0 
    THEN DO:
         RUN PONMENSJ.P ( INPUT "CLCE005" ).
         RETURN NO-APPLY.
    END.     
  
    IF t_regcre = 1 AND saldo > 0 
    THEN DO:
         RUN PONMENSJ.P ( INPUT "CLCE006" ).
         RETURN NO-APPLY.
    END.     

  END.

  /*
  IF saldo <> 0 
  THEN DO:
       RUN PONMENSJ.P ( INPUT "CLCE003" ).
       RETURN NO-APPLY.
  END.     
  */

  RUN genero_compensacion.

  RUN ABRE_QUERY.

END. /* Del trigger */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_credito
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_credito C-Win
ON CHOOSE OF btn_credito IN FRAME DEFAULT-FRAME /* Créditos */
DO:
  RUN ABMAECRP.P ( INPUT 0 ).
  RUN ABRE_QUERY-CRE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_credito-in
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_credito-in C-Win
ON CHOOSE OF btn_credito-in IN FRAME DEFAULT-FRAME /* Créditos */
DO:
  RUN ABMAECRPI.P ( INPUT 0 ).
  RUN ABRE_QUERY-CRE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_debito
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_debito C-Win
ON CHOOSE OF btn_debito IN FRAME DEFAULT-FRAME /* Débitos */
DO:
  RUN ABMAEDBP.P ( INPUT 0 ).
  RUN ABRE_QUERY-DEB.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_debito-in
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_debito-in C-Win
ON CHOOSE OF btn_debito-in IN FRAME DEFAULT-FRAME /* Débitos */
DO:
  RUN ABMAEDBPI.P ( INPUT 0 ).
  RUN ABRE_QUERY-DEB.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Done
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Done C-Win
ON CHOOSE OF Btn_Done IN FRAME DEFAULT-FRAME /* Salir */
DO:
  IF ROWID(Proveedor) <> ? THEN RUN DESELECTAR ( INPUT ROWID(Proveedor) ).
  &IF DEFINED (adm-panel) <> 0 &THEN
      RUN dispatch IN THIS-PROCEDURE ('exit').
  &ELSE
      APPLY "CLOSE":U TO THIS-PROCEDURE.
  &ENDIF
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Proveedor.cdg_proveedor
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Proveedor.cdg_proveedor C-Win
ON LEAVE OF Proveedor.cdg_proveedor IN FRAME DEFAULT-FRAME /* Proveedor */
DO:
END.

        /* -------------------- Proveedor ------------*/

&SCOPED-DEFINE TABLA            Proveedor
&SCOPED-DEFINE CODIGO           cdg_proveedor
&SCOPED-DEFINE NOMBRE           nombre
&SCOPED-DEFINE RUTINA           SELPROVE
&SCOPED-DEFINE FRAME-INGRESO    {&FRAME-NAME}
&SCOPED-DEFINE ROWID-TABLA      act_proveedor
&SCOPED-DEFINE TRADUCIR         YES
&SCOPED-DEFINE MOSTRAR          YES
&SCOPED-DEFINE ALTA-MODIF       ACTPROVE
&SCOPED-DEFINE ULT_REGISTRO     ult_proveedor
&SCOPED-DEFINE ALT-MOD          YES
&SCOPED-DEFINE PROCESO          PONER_PROVEEDOR


{TRIGSELC.I}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME des_fecha-cre
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL des_fecha-cre C-Win
ON LEAVE OF des_fecha-cre IN FRAME DEFAULT-FRAME /* Del */
DO:
  ASSIGN des_fecha-CRE.
  RUN ABRE_QUERY-CRE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME des_fecha-deb
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL des_fecha-deb C-Win
ON LEAVE OF des_fecha-deb IN FRAME DEFAULT-FRAME /* Del */
DO:
  ASSIGN des_fecha-DEB.
  RUN ABRE_QUERY-DEB.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME has_fecha-cre
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL has_fecha-cre C-Win
ON LEAVE OF has_fecha-cre IN FRAME DEFAULT-FRAME /* Al */
DO:
  ASSIGN has_fecha-CRE.
  RUN ABRE_QUERY-CRE.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME has_fecha-deb
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL has_fecha-deb C-Win
ON LEAVE OF has_fecha-deb IN FRAME DEFAULT-FRAME /* Al */
DO:
  ASSIGN des_fecha-DEB.
  RUN ABRE_QUERY-CRE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME id_moneda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL id_moneda C-Win
ON VALUE-CHANGED OF id_moneda IN FRAME DEFAULT-FRAME
DO:
    ASSIGN id_moneda.
    FIND Moneda WHERE Moneda.cdg_moneda = id_moneda NO-LOCK.
    que_moneda = Moneda.nro_moneda.
    RUN poner_proveedor.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-CRE
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

  {setwintit.i "SIC/CXP" "Compensación de documentos en Cta.Cte."}
  {findempresa.i}
  que_empresa = Empresa.cdg_empresa.

  RUN levantar_monedas.


/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:

DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
 /*  SESSION:DATA-ENTRY-RETURN = YES. */
  ASSIGN 
         has_fecha-DEB = TODAY
         has_fecha-CRE = TODAY
         des_fecha-DEB = has_fecha-DEB - 365
         des_fecha-CRE = has_fecha-CRE - 365.

  RUN enable_UI.
 /*  RUN inicio_rendicion. */
RUN poner_proveedor.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ABRE_QUERY C-Win 
PROCEDURE ABRE_QUERY :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  RUN ABRE_QUERY-CRE.
  RUN ABRE_QUERY-DEB.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ABRE_QUERY-CRE C-Win 
PROCEDURE ABRE_QUERY-CRE :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 /*RUN genero_T_opg_detalle_acreditan. */
 OPEN QUERY BROWSE-CRE       
       FOR EACH CC_acreditan OF Proveedor 
                WHERE CC_acreditan.cdg_empresa = que_empresa
                  AND CC_acreditan.fecha_emision >= des_fecha-CRE 
                  AND CC_acreditan.fecha_emision <= has_fecha-CRE
                  AND CC_acreditan.credito > CC_acreditan.debito
                  AND CC_acreditan.nro_moneda = que_moneda
                      BY CC_acreditan.fecha_emision.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ABRE_QUERY-DEB C-Win 
PROCEDURE ABRE_QUERY-DEB :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 /* RUN genero_T_opg_detalle_debitan. */
  OPEN QUERY BROWSE-DEB
       FOR EACH CC_debitan OF Proveedor
                WHERE CC_debitan.cdg_empresa = que_empresa
                  AND CC_debitan.fecha_emision >= des_fecha-DEB 
                  AND CC_debitan.fecha_emision <= has_fecha-DEB
                  AND CC_debitan.debito > CC_debitan.credito
                  AND CC_debitan.nro_moneda = que_moneda
                   BY CC_debitan.fecha_emision. 


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE borro_orden_pago C-Win 
PROCEDURE borro_orden_pago :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT  PARAMETER rid_cta_cte AS ROWID      NO-UNDO.
DEFINE OUTPUT PARAMETER tiene_op    AS LOGICAL    NO-UNDO.
DEFINE OUTPUT PARAMETER todo_ok     AS LOGICAL    NO-UNDO.

tiene_op = NO.
todo_ok = YES.
FIND FIRST Cta_cte_prv 
     WHERE ROWID(Cta_cte_prv) = rid_cta_cte
     NO-LOCK NO-ERROR.
IF AVAILABLE Cta_cte_prv THEN
DO:

   FOR EACH  Opg_detalle
       WHERE Opg_detalle.tip_cancela = Cta_cte_prv.tip_comprob
       AND   Opg_detalle.nro_cancela = Cta_cte_prv.nro_comprob 
       AND   Opg_detalle.prf_cancela = Cta_cte_prv.prf_comprob 
       NO-LOCK :
       FIND FIRST Opg_header OF Opg_detalle 
            WHERE Opg_header.anulado = NO 
            EXCLUSIVE-LOCK NO-ERROR. 
       IF AVAILABLE  Opg_header THEN
       DO:
           IF  NOT LOCKED Opg_header THEN
           DO:     
               FIND Tipocomprobante
                    OF opg_header NO-LOCK NO-ERROR.
               ASSIGN 
               tiene_op           = YES
               Opg_header.anulado = YES.
              
                              
               FIND FIRST Caj_header 
                    WHERE Caj_header.nro_transaccion = Opg_header.nro_transaccion 
                    EXCLUSIVE-LOCK NO-ERROR.
               IF AVAILABLE Caj_header then
               DO: 
                   IF NOT LOCKED Caj_header THEN
                      Caj_header.anulado = YES.
                   ELSE
                      todo_ok = NO.

                   
                   IF todo_ok = YES THEN
                   DO:
                          FIND FIRST Cheque 
                               WHERE Cheque.nro_transaccion  = Caj_header.nro_transaccion
                               EXCLUSIVE-LOCK NO-ERROR.
                          IF AVAILABLE Cheque THEN
                          DO:
                            ASSIGN Cheque.estado           = cheque_anulado.
                          END.
                   END.
               END.                
           END.
           ELSE
               todo_ok = NO.
       END.
          
          
       
       
    END.
    RELEASE Caj_header.
    RELEASE Opg_header.                                     
END.
    
   
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE DESELECTAR C-Win 
PROCEDURE DESELECTAR :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER que_cuenta AS ROWID.
  DEFINE BUFFER B-Proveedor FOR Proveedor.
  
      
  FIND B-Proveedor WHERE ROWID(B-Proveedor) = que_cuenta NO-LOCK.
  
  
  FOR EACH CC_debitan OF B-Proveedor WHERE CC_debitan.selectado EXCLUSIVE-LOCK:
      CC_debitan.selectado = NO.
  END.    
  t_regdeb = 0.
  
  FOR EACH CC_acreditan OF B-Proveedor WHERE CC_acreditan.selectado EXCLUSIVE-LOCK:
      CC_acreditan.selectado = NO.
  END.    
  t_regcre = 0.





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
  DISPLAY saldo v-saldo-a-imputar id_moneda des_fecha-deb has_fecha-deb 
          v_abrevia_deb t_movdeb t_regdeb des_fecha-cre has_fecha-cre 
          v_abrevia_cre t_movcre t_regcre 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE Proveedor THEN 
    DISPLAY Proveedor.nombre Proveedor.cdg_proveedor 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE RECT-1 RECT-2 RECT-3 RECT-4 RECT-5 RECT-6 btn_credito btn_debito 
         btn_credito-in btn_debito-in btn_compensar Btn_Done v-saldo-a-imputar 
         id_moneda Proveedor.cdg_proveedor des_fecha-deb has_fecha-deb t_regdeb 
         des_fecha-cre has_fecha-cre t_regcre BROWSE-DEB BROWSE-CRE 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE genero_1deb_varioscred C-Win 
PROCEDURE genero_1deb_varioscred :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE OUTPUT PARAMETER todo_ok AS LOGICAL INITIAL YES NO-UNDO.

DEFINE VARIABLE directorio AS CHARACTER  NO-UNDO.
DEFINE VARIABLE diferencia AS DECIMAL    NO-UNDO.
DEFINE VARIABLE v-total_debitan     AS DECIMAL    NO-UNDO.
DEFINE VARIABLE v-total_acreditan   AS DECIMAL    NO-UNDO.
DEFINE VARIABLE v-total_diferencia  AS DECIMAL    NO-UNDO.
DEFINE VARIABLE v-total_restan      AS DECIMAL    NO-UNDO.
DEFINE VARIABLE ultima            AS ROWID      NO-UNDO.


DEFINE VARIABLE tiene_op AS LOGICAL    NO-UNDO.

v-total_debitan   = 0.
v-total_acreditan = 0.

    DO:                               
             /* Compensa UN DEBITO contra MULTIPLES CREDITOS */
             FIND CC_debitan OF Proveedor 
                  WHERE CC_debitan.debito > CC_debitan.credito
                    AND CC_debitan.selectado 
                        EXCLUSIVE-LOCK.
             IF AVAILABLE CC_debitan THEN
                v-total_debitan = CC_debitan.debito - CC_debitan.credito.

             FOR EACH CC_acreditan OF Proveedor 
                 WHERE CC_acreditan.credito > CC_acreditan.debito
                   AND CC_acreditan.selectado 
                       NO-LOCK:
                 v-total_acreditan = v-total_acreditan + ( CC_acreditan.credito - CC_acreditan.debito ).
             END.
             
             
             FOR EACH CC_acreditan OF Proveedor 
                 WHERE CC_acreditan.credito > CC_acreditan.debito
                   AND CC_acreditan.selectado 
                   AND todo_ok = YES
                       EXCLUSIVE-LOCK:
                    
                    CREATE Aplicacion_pagos_prv.                    
                    ASSIGN Aplicacion_pagos_prv.descuento        = 0
                           Aplicacion_pagos_prv.compenso         = YES
                           Aplicacion_pagos_prv.cdg_empresa      = Empresa.cdg_empresa
                           Aplicacion_pagos_prv.importe          = CC_acreditan.credito - CC_acreditan.debito  .

   
                                          /* documento cancelado ( o aplicado ) */
                    FIND FIRST Fac_header_prv
                         WHERE Fac_header_prv.tip_comprob      = CC_acreditan.tip_comprob
                         AND   Fac_header_prv.prf_comprob      = CC_acreditan.prf_comprob
                         AND   Fac_header_prv.nro_comprob      = CC_acreditan.nro_comprob
                         AND   Fac_header_prv.cdg_empresa      = CC_acreditan.cdg_empresa
                         AND   Fac_header_prv.nro_proveedor    = CC_acreditan.Nro_proveedor
                         NO-LOCK NO-ERROR.

                    ASSIGN
                           Aplicacion_pagos_prv.tip_comprob      = CC_acreditan.tip_comprob
                           Aplicacion_pagos_prv.prf_comprob      = CC_acreditan.prf_comprob
                           Aplicacion_pagos_prv.nro_comprob      = CC_acreditan.nro_comprob
                           Aplicacion_pagos_prv.cdg_comprobante  = Fac_header_prv.cdg_comprobante
                           Aplicacion_pagos_prv.nro_vencimiento  = CC_acreditan.nro_vencimiento.

                           
                
                                          /* documento que cancela ( o aplicador ) */
                    FIND FIRST Fac_header_prv
                         WHERE Fac_header_prv.tip_comprob      = CC_debitan.tip_comprob
                         AND   Fac_header_prv.prf_comprob      = CC_debitan.prf_comprob
                         AND   Fac_header_prv.nro_comprob      = CC_debitan.nro_comprob
                         AND   Fac_header_prv.cdg_empresa      = CC_debitan.cdg_empresa
                         AND   Fac_header_prv.nro_proveedor    = CC_debitan.Nro_proveedor
                         NO-LOCK NO-ERROR.
                    ASSIGN 
                           Aplicacion_pagos_prv.nro_proveedor    = CC_debitan.nro_proveedor
                           Aplicacion_pagos_prv.tip_cancela      = CC_debitan.tip_comprob
                           Aplicacion_pagos_prv.prf_cancela      = CC_debitan.prf_comprob
                           Aplicacion_pagos_prv.nro_cancela      = CC_debitan.nro_comprob
                           Aplicacion_pagos_prv.cdg_comprob_cancela = Fac_header_prv.cdg_comprobante
                           Aplicacion_pagos_prv.nro_ven_cancela  = CC_debitan.nro_vencimiento.
   
   
                                        /* actualizacion de saldos de comprobantes */
   
                    
                    ASSIGN
                           CC_debitan.credito  = CC_debitan.credito + Aplicacion_pagos_prv.importe
                           CC_acreditan.debito = CC_acreditan.credito
                           CC_acreditan.selectado = NO.
                    
                        
                    
                      RUN borro_orden_pago(INPUT  ROWID(CC_acreditan),
                                           OUTPUT tiene_op,
                                           OUTPUT todo_ok).
                      ultima = ROWID(cc_acreditan).
             END.
             
             FIND FIRST cc_acreditan
                  WHERE ROWID(cc_acreditan) = ultima
                  NO-LOCK NO-ERROR.

             FIND CC_debitan OF Proveedor 
                  WHERE CC_debitan.debito > CC_debitan.credito
                    AND CC_debitan.selectado 
                        EXCLUSIVE-LOCK.

             IF todo_ok = YES THEN
             DO:
                 RUN borro_orden_pago(INPUT  ROWID(CC_debitan),
                                      OUTPUT tiene_op,
                                      OUTPUT todo_ok).

                 IF v-total_debitan > v-total_acreditan AND 
                    todo_ok       = YES             and
                    tiene_op      = YES             THEN
                 DO:     
                     v-total_diferencia = v-total_debitan - v-total_acreditan.
                     RUN genero_orden_pago(INPUT  ROWID(CC_debitan),
                                           INPUT  v-total_diferencia,
                                           OUTPUT todo_ok).
                 END.
                 IF v-total_acreditan > v-total_debitan AND 
                    todo_ok       = YES             and
                    tiene_op      = YES             THEN
                 DO:         
                     
                     v-total_diferencia = v-total_acreditan - v-total_debitan.
                     RUN genero_orden_pago(INPUT  ROWID(CC_acreditan),
                                           INPUT  v-total_diferencia,
                                           OUTPUT todo_ok).
                 END.
                 
             
             END.

            /* UNDO, LEAVE. */
             CC_debitan.selectado  = NO.
   
      END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE genero_1_1 C-Win 
PROCEDURE genero_1_1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE OUTPUT PARAMETER todo_ok AS LOGICAL INITIAL YES NO-UNDO.

DEFINE VARIABLE directorio AS CHARACTER  NO-UNDO.
DEFINE VARIABLE diferencia AS DECIMAL    NO-UNDO.
DEFINE VARIABLE v-total_debitan     AS DECIMAL    NO-UNDO.
DEFINE VARIABLE v-total_acreditan   AS DECIMAL    NO-UNDO.
DEFINE VARIABLE v-total_diferencia  AS DECIMAL    NO-UNDO.
DEFINE VARIABLE v-total_restan      AS DECIMAL    NO-UNDO.
DEFINE VARIABLE ultima            AS ROWID      NO-UNDO.
DEFINE VARIABLE tiene_op AS LOGICAL    NO-UNDO.
v-total_debitan   = 0.
v-total_acreditan = 0.
DO:

             /* Compensa UN CREDITO contra UN DEBITO */
             
             FIND FIRST CC_acreditan OF Proveedor 
                  WHERE CC_acreditan.credito > CC_acreditan.debito
                    AND CC_acreditan.selectado 
                        EXCLUSIVE-LOCK.
             IF AVAILABLE CC_acreditan THEN
                    v-total_acreditan = CC_acreditan.credito  - CC_acreditan.debito.
             

             FIND FIRST CC_debitan OF Proveedor 
                  WHERE CC_debitan.debito > CC_debitan.credito
                    AND CC_debitan.selectado 
                        EXCLUSIVE-LOCK.
             IF AVAILABLE CC_debitan THEN
                v-total_debitan = CC_debitan.debito  - CC_debitan.credito.
             
   
             CREATE Aplicacion_pagos_prv.                    
             ASSIGN Aplicacion_pagos_prv.descuento        = 0
                    Aplicacion_pagos_prv.compenso         = YES
                    Aplicacion_pagos_prv.cdg_empresa      = Empresa.cdg_empresa
                    Aplicacion_pagos_prv.importe          = IF v-saldo-a-imputar = 0 
                                                               THEN MINIMUM(CC_acreditan.credito - CC_acreditan.debito,
                                                                    CC_debitan.debito - CC_debitan.credito)
                                                               ELSE v-saldo-a-imputar.

                                  /* documento cancelado ( o aplicado ) */
        
             FIND FIRST Fac_header_prv
                         WHERE Fac_header_prv.tip_comprob      = CC_acreditan.tip_comprob
                         AND   Fac_header_prv.prf_comprob      = CC_acreditan.prf_comprob
                         AND   Fac_header_prv.nro_comprob      = CC_acreditan.nro_comprob
                         AND   Fac_header_prv.cdg_empresa      = CC_acreditan.cdg_empresa
                         AND   Fac_header_prv.nro_proveedor    = CC_acreditan.Nro_proveedor
                         NO-LOCK NO-ERROR.
             ASSIGN 
                    Aplicacion_pagos_prv.tip_cancela      = CC_acreditan.tip_comprob
                    Aplicacion_pagos_prv.prf_cancela      = CC_acreditan.prf_comprob
                    Aplicacion_pagos_prv.nro_cancela      = CC_acreditan.nro_comprob
                    Aplicacion_pagos_prv.cdg_comprob_cancela = Fac_header_prv.cdg_comprobante
                    Aplicacion_pagos_prv.nro_ven_cancela  = CC_acreditan.nro_vencimiento.
        
                                  /* documento que cancela ( o aplicador ) */
        
             FIND FIRST Fac_header_prv
                         WHERE Fac_header_prv.tip_comprob      = CC_debitan.tip_comprob
                         AND   Fac_header_prv.prf_comprob      = CC_debitan.prf_comprob
                         AND   Fac_header_prv.nro_comprob      = CC_debitan.nro_comprob
                         AND   Fac_header_prv.cdg_empresa      = CC_debitan.cdg_empresa
                         AND   Fac_header_prv.nro_proveedor    = CC_debitan.Nro_proveedor
                         NO-LOCK NO-ERROR.
             ASSIGN
                    Aplicacion_pagos_prv.nro_proveedor    = CC_debitan.nro_proveedor
                    Aplicacion_pagos_prv.tip_comprob      = CC_debitan.tip_comprob
                    Aplicacion_pagos_prv.prf_comprob      = CC_debitan.prf_comprob
                    Aplicacion_pagos_prv.nro_comprob      = CC_debitan.nro_comprob
                    Aplicacion_pagos_prv.cdg_comprobante  = Fac_header_prv.cdg_comprobante
                    Aplicacion_pagos_prv.nro_vencimiento  = CC_debitan.nro_vencimiento
   
   
                                /* actualizacion de saldos de comprobantes */
   
                    CC_acreditan.debito    = CC_acreditan.debito + Aplicacion_pagos_prv.importe
                    CC_debitan.credito     = CC_debitan.credito  + Aplicacion_pagos_prv.importe
                    CC_debitan.selectado   = NO
                    CC_acreditan.selectado = NO.

                    todo_ok = YES.
                    RUN borro_orden_pago(INPUT  ROWID(CC_debitan),
                                         OUTPUT tiene_op,
                                         OUTPUT todo_ok).
                    
                    IF todo_ok = YES THEN
                    DO:
                        
                        IF v-total_debitan > v-total_acreditan AND 
                           tiene_op      = YES             THEN
                        DO:
                            
                           v-total_diferencia = v-total_debitan - v-total_acreditan.
                           RUN genero_orden_pago(INPUT  ROWID(CC_debitan),
                                                 INPUT  v-total_diferencia,
                                                 OUTPUT todo_ok).
                        END.
                        
                        IF todo_ok = YES THEN
                            RUN borro_orden_pago(INPUT  ROWID(CC_acreditan),
                                                 OUTPUT tiene_op,
                                                 OUTPUT todo_ok).


                        

                        IF v-total_acreditan >  v-total_debitan AND 
                           tiene_op      = YES              AND 
                           todo_ok       = YES              THEN
                        DO:
                                
                           v-total_diferencia = v-total_acreditan - v-total_debitan.
                           RUN genero_orden_pago(INPUT  ROWID(CC_acreditan),
                                                 INPUT  v-total_diferencia,
                                                 OUTPUT todo_ok).
                        END.
                    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE genero_compensacion C-Win 
PROCEDURE genero_compensacion :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VARIABLE directorio AS CHARACTER  NO-UNDO.
DEFINE VARIABLE diferencia AS DECIMAL    NO-UNDO.
DEFINE VARIABLE v-total_debitan     AS DECIMAL    NO-UNDO.
DEFINE VARIABLE v-total_acreditan   AS DECIMAL    NO-UNDO.
DEFINE VARIABLE v-total_diferencia  AS DECIMAL    NO-UNDO.
DEFINE VARIABLE v-total_restan      AS DECIMAL    NO-UNDO.
DEFINE VARIABLE ultima            AS ROWID      NO-UNDO.
DEFINE VARIABLE tiene_op AS LOGICAL    NO-UNDO. 
DEFINE VARIABLE todo_ok AS LOGICAL    NO-UNDO.

todo_ok = YES.

{findempresa.i}

  DO TRANSACTION:
     CASE TRUE:
        WHEN t_regdeb = 1 AND t_regcre > 1 THEN 
            RUN genero_1deb_varioscred (OUTPUT todo_ok).

        WHEN t_regcre = 1 AND t_regdeb > 1 THEN
            RUN genero_variosdeb_1cred (OUTPUT todo_ok).
        WHEN t_regcre = 1 AND t_regdeb = 1 THEN
            RUN genero_1_1 (OUTPUT todo_ok).

      END CASE.

     FOR EACH CC_debitan :
         CC_debitan.selectado = NO.
     END.
     FOR EACH CC_acreditan :
         CC_acreditan.selectado = NO.
     END.

     IF todo_ok = NO 
     THEN DO:
         MESSAGE "No se pudo compensar porque algun Movimiento del Proveedor " SKIP
                        "estaba siendo utilizado por otro Usuario...                " SKIP
                        "Espere un momento y vuelva a intentarlo!!!...              "
                    VIEW-AS ALERT-BOX INFO BUTTONS OK.
         UNDO, LEAVE.
     END.

     RUN PONER_PROVEEDOR.

  END. /* DE LA TRANSACCION */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE genero_orden_pago C-Win 
PROCEDURE genero_orden_pago :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT  PARAMETER rid_cta_cte      AS ROWID      NO-UNDO.
DEFINE INPUT  PARAMETER v-total_diferencia AS DECIMAL    NO-UNDO.
DEFINE OUTPUT PARAMETER todo_ok          AS LOGICAL    NO-UNDO.


DEFINE VARIABLE v-total_pesos AS DECIMAL    NO-UNDO.


DEFINE BUFFER B_opg_header  FOR Opg_header.
DEFINE BUFFER B_opg_detalle FOR Opg_detalle.
DEFINE BUFFER B_Caj_header  FOR Caj_header.
DEFINE BUFFER B_Caj_detalle FOR Caj_detalle.
DEFINE BUFFER B_Caja-imputacion FOR Caja-imputacion.

todo_ok = YES.


FIND FIRST Cta_cte_prv
     WHERE ROWID(Cta_cte_prv) = rid_cta_cte
     NO-LOCK NO-ERROR.
IF AVAILABLE Cta_cte_prv THEN
DO:
   FIND FIRST Fac_header_prv
        WHERE Fac_header_prv.cdg_empresa   = Cta_cte_prv.cdg_empresa
        AND   Fac_header_prv.tip_comprob   = Cta_cte_prv.tip_comprob
        AND   Fac_header_prv.prf_comprob   = Cta_cte_prv.prf_comprob
        AND   Fac_header_prv.nro_comprob   = Cta_cte_prv.nro_comprob
        AND   Fac_header_prv.nro_proveedor = Cta_cte_prv.nro_proveedor
        NO-LOCK NO-ERROR.
   IF AVAILABLE Fac_header_prv THEN
   DO:
      FIND FIRST Opg_detalle 
           WHERE Opg_detalle.tip_cancela = Cta_cte_prv.tip_comprob
           AND   Opg_detalle.nro_cancela = Cta_cte_prv.nro_comprob 
           AND   Opg_detalle.prf_cancela = Cta_cte_prv.prf_comprob
           NO-LOCK NO-ERROR.
      IF AVAILABLE Opg_detalle THEN
      DO:        
       FIND FIRST Opg_header OF Opg_detalle 
            NO-LOCK NO-ERROR. 
       IF AVAILABLE  Opg_header THEN
       DO: 
           
          FIND FIRST Tipocomprobante OF Opg_header NO-LOCK NO-ERROR.  
          FIND FIRST Parametro 
               WHERE Parametro.cdg_parametro = Tipocomprobante.prefijo_contador 
               AND   Parametro.cdg_empresa   = Opg_header.cdg_empresa 
               EXCLUSIVE-LOCK NO-ERROR.
          IF NOT AVAILABLE Parametro THEN 
          DO:
             CREATE Parametro.
             ASSIGN Parametro.cdg_empresa   = Opg_header.cdg_empresa
                    Parametro.cdg_parametro = Tipocomprobante.prefijo_contador
                    Parametro.descripcion   = "Contador autoagregado por " + PROGRAM-NAME(1)
                    Parametro.observacion   = ""
                    Parametro.tipo          = "N"
                    Parametro.valor_n       = 1.
          END.         
          RUN reexpresar_cotizacion.p(INPUT  Cta_cte_prv.nro_moneda,
                                INPUT  Cta_cte_prv.cambio,
                                INPUT  Cta_cte_prv.fecha_alta,
                                INPUT  v-total_diferencia,
                                OUTPUT v-total_pesos).
          
          IF AVAILABLE Parametro THEN
             IF NOT LOCKED Parametro THEN
             DO:
                  CREATE B_opg_header.
                  BUFFER-COPY Opg_header EXCEPT Opg_header.nro_ordpago Opg_header.nro_comprob TO B_opg_header .
                  ASSIGN B_Opg_header.nro_ordpago       = NEXT-VALUE(proxima_transaccion)
                         B_Opg_header.nro_comprob       = Parametro.valor_n
                         B_Opg_header.hora              = STRING(TIME,"HH:MM:SS")                           
                         B_Opg_header.imp_total         = v-total_diferencia
                         B_Opg_header.imp_pesos         = v-total_pesos
                         B_Opg_header.nro_transaccion   = NEXT-VALUE(proxima_transaccion)
                         B_Opg_header.anulado           = NO
                         B_Opg_header.ultima_linea      = 1.
                  

                  RUN completar_auditoria.p 
                              ( OUTPUT B_Opg_header.nro_usuario,
                                OUTPUT B_Opg_header.fch_cambio, 
                                OUTPUT B_Opg_header.hora_grab, 
                                OUTPUT B_Opg_header.pc_name ).

                  ASSIGN Parametro.valor_n      = Parametro.valor_n + 1.
                  RELEASE Parametro.                                    

                  CREATE b_opg_detalle.
                  BUFFER-COPY Opg_detalle EXCEPT Opg_detalle.nro_ordpago TO B_opg_detalle.
                  ASSIGN B_Opg_detalle.importe             = v-total_diferencia 
                         B_Opg_detalle.imp_este-pago       = v-total_diferencia

                         B_Opg_detalle.imp_pesos           = v-total_pesos
                         B_Opg_detalle.nro_linea           = B_Opg_header.ultima_linea
                         b_Opg_detalle.nro_ordpago         = B_Opg_header.nro_ordpago.

                  

                  FIND FIRST Caj_header 
                       WHERE Caj_header.nro_transaccion = Opg_header.nro_transaccion 
                       NO-LOCK NO-ERROR.
                       IF AVAILABLE Caj_header THEN
                       DO: 
                          CREATE b_caj_header.
                          BUFFER-COPY Caj_header EXCEPT Caj_header.nro_transaccion TO B_caj_header.

                          ASSIGN B_Caj_header.importe          = B_Opg_header.imp_total
                                 B_Caj_header.ingreso          = B_Opg_header.imp_total
                                 B_Caj_header.nro_transaccion  = B_Opg_header.nro_transaccion
                                 B_Caj_header.anulado          = NO
                                 B_Caj_header.observacion      = "Se crea por Compensacion"

/*MMO*/                          B_Caj_header.nro_comprob      = B_Opg_header.nro_comprob
                                 B_Caj_header.prf_comprob      = B_Opg_header.prf_comprob
                                 B_Caj_header.tip_comprob      = B_Opg_header.tip_comprob.
                          
                          FIND FIRST Caj_detalle OF Caj_header NO-LOCK NO-ERROR.
                          IF AVAILABLE Caj_detalle THEN
                          DO:
                              CREATE b_caj_detalle.
                              BUFFER-COPY Caj_detalle EXCEPT Caj_detalle.nro_transaccion TO B_caj_detalle.
                              ASSIGN B_Caj_detalle.importe         = B_Caj_header.importe
                                     B_Caj_detalle.nro_transaccion = B_Caj_header.nro_transaccion
                                     B_Caj_detalle.divisas         = v-total_diferencia / b_opg_header.cambio
                                     B_Caj_detalle.observacion     = "Se crea por Compensacion".
                              
                              FIND FIRST Caja-imputacion
                                   WHERE Caja-imputacion.nro_transaccion = Caj_header.nro_transaccion
                                   NO-LOCK NO-ERROR.
                              IF AVAILABLE Caja-imputacion THEN
                              DO:
                                  CREATE B_Caja-imputacion.
                                  BUFFER-COPY Caja-imputacion EXCEPT Caja-imputacion.nro_transaccion TO B_caja-imputacion.
                                  ASSIGN B_Caja-imputacion.nro_transaccion = B_Caj_header.nro_transaccion
                                         B_Caja-imputacion.observacion     = "Se crea por Compensacion"
                                         B_Caja-imputacion.valor           = B_Caj_header.importe.       
                                  
                              END.
                              FIND FIRST Cheque 
                                   WHERE Cheque.nro_transaccion  = Caj_header.nro_transaccion
                                   EXCLUSIVE-LOCK NO-ERROR.
                              IF AVAILABLE Cheque THEN
                              DO:
                                ASSIGN Cheque.nro_transaccion  = B_Caj_header.nro_transaccion
                                       Cheque.importe          = B_Caj_detalle.importe
/*MMO*/                                Cheque.estado           = cheque_por_imprimir.
                                
                              END.
    
                          END.
        
        
                       END.
             END.
             ELSE
               todo_ok = NO.                         
       END.
      END.
   END.
END.                     
RELEASE Cheque.
RELEASE B_Caj_detalle.                                             
RELEASE B_Caj_header.    
RELEASE B_Opg_header.
RELEASE B_Opg_detalle.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE genero_variosdeb_1cred C-Win 
PROCEDURE genero_variosdeb_1cred :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE OUTPUT PARAMETER todo_ok AS LOGICAL INITIAL YES NO-UNDO.

DEFINE VARIABLE directorio AS CHARACTER  NO-UNDO.
DEFINE VARIABLE diferencia AS DECIMAL    NO-UNDO.
DEFINE VARIABLE v-total_debitan     AS DECIMAL    NO-UNDO.
DEFINE VARIABLE v-total_acreditan   AS DECIMAL    NO-UNDO.
DEFINE VARIABLE v-total_diferencia  AS DECIMAL    NO-UNDO.
DEFINE VARIABLE v-total_restan      AS DECIMAL    NO-UNDO.
DEFINE VARIABLE ultima            AS ROWID      NO-UNDO.


DEFINE VARIABLE tiene_op AS LOGICAL    NO-UNDO.

 v-total_debitan   = 0.
 v-total_acreditan = 0.                    
                       /* Compensa UN CREDITO contra MULTIPLES DEBITOS */
   
             FIND CC_acreditan OF Proveedor 
                  WHERE CC_acreditan.credito > CC_acreditan.debito
                    AND CC_acreditan.selectado 
                        EXCLUSIVE-LOCK.
             IF AVAILABLE CC_acreditan THEN
                v-total_acreditan = CC_acreditan.credito - CC_acreditan.debito  .
                                           

             
             
             


             FOR EACH CC_debitan OF Proveedor 
                 WHERE CC_debitan.debito > CC_debitan.credito
                   AND CC_debitan.selectado 
                       NO-LOCK:
                 IF AVAILABLE CC_debitan THEN
                    v-total_debitan = v-total_debitan + ( CC_debitan.debito - CC_debitan.credito ).
             END.
   
             FOR EACH CC_debitan OF Proveedor 
                 WHERE CC_debitan.debito > CC_debitan.credito
                   AND CC_debitan.selectado 
                       EXCLUSIVE-LOCK:
   
                    CREATE Aplicacion_pagos_prv.                    
                    ASSIGN Aplicacion_pagos_prv.descuento        = 0
                           Aplicacion_pagos_prv.compenso         = YES
                           Aplicacion_pagos_prv.cdg_empresa      = Empresa.cdg_empresa
                           Aplicacion_pagos_prv.importe          =   CC_debitan.debito - CC_debitan.credito.
   
                                          /* documento cancelado ( o aplicado ) */
                
                    FIND FIRST Fac_header_prv
                         WHERE Fac_header_prv.tip_comprob      = CC_acreditan.tip_comprob
                         AND   Fac_header_prv.prf_comprob      = CC_acreditan.prf_comprob
                         AND   Fac_header_prv.nro_comprob      = CC_acreditan.nro_comprob
                         AND   Fac_header_prv.cdg_empresa      = CC_acreditan.cdg_empresa
                         AND   Fac_header_prv.nro_proveedor    = CC_acreditan.Nro_proveedor
                         NO-LOCK NO-ERROR.
                    ASSIGN
                           Aplicacion_pagos_prv.tip_cancela      = CC_acreditan.tip_comprob
                           Aplicacion_pagos_prv.prf_cancela      = CC_acreditan.prf_comprob
                           Aplicacion_pagos_prv.nro_cancela      = CC_acreditan.nro_comprob
                           Aplicacion_pagos_prv.cdg_comprob_cancela =  Fac_header_prv.cdg_comprobante
                           Aplicacion_pagos_prv.nro_ven_cancela  = CC_acreditan.nro_vencimiento.
                
                                          /* documento que cancela ( o aplicador ) */
                
                    FIND FIRST Fac_header_prv
                         WHERE Fac_header_prv.tip_comprob      = CC_debitan.tip_comprob
                         AND   Fac_header_prv.prf_comprob      = CC_debitan.prf_comprob
                         AND   Fac_header_prv.nro_comprob      = CC_debitan.nro_comprob
                         AND   Fac_header_prv.cdg_empresa      = CC_debitan.cdg_empresa
                         AND   Fac_header_prv.nro_proveedor    = CC_debitan.Nro_proveedor
                         NO-LOCK NO-ERROR.
                    ASSIGN
                           Aplicacion_pagos_prv.nro_proveedor    = CC_debitan.nro_proveedor
                           Aplicacion_pagos_prv.tip_comprob      = CC_debitan.tip_comprob
                           Aplicacion_pagos_prv.prf_comprob      = CC_debitan.prf_comprob
                           Aplicacion_pagos_prv.nro_comprob      = CC_debitan.nro_comprob
                           Aplicacion_pagos_prv.cdg_comprobante  = fac_header_prv.cdg_comprobante
                           Aplicacion_pagos_prv.nro_vencimiento  = CC_debitan.nro_vencimiento
   
                                        /* actualizacion de saldos de comprobantes */
                            CC_acreditan.debito = CC_acreditan.debito + Aplicacion_pagos_prv.importe
                            CC_debitan.credito = CC_debitan.debito

                           CC_debitan.selectado = NO.

                     
                      RUN borro_orden_pago(INPUT  ROWID(CC_debitan),
                                           OUTPUT tiene_op,
                                           OUTPUT todo_ok).
                      ultima = ROWID(cc_debitan).
             END.
             
             FIND FIRST cc_debitan
                  WHERE ROWID(cc_debitan) = ultima
                  NO-LOCK NO-ERROR.

             FIND FIRST CC_acreditan OF Proveedor 
                  WHERE CC_acreditan.credito > CC_acreditan.debito
                   AND  CC_acreditan.selectado 
                  EXCLUSIVE-LOCK.
             IF todo_ok = YES THEN
             DO:
                 RUN borro_orden_pago(INPUT  ROWID(CC_acreditan),
                                      OUTPUT tiene_op,
                                      OUTPUT todo_ok).
                 IF v-total_acreditan > v-total_debitan AND 
                    todo_ok       = YES             and
                    tiene_op      = YES             THEN
                 DO:       
                     v-total_diferencia = v-total_acreditan - v-total_debitan.
                     

                     RUN genero_orden_pago(INPUT  ROWID(CC_acreditan),
                                           INPUT  v-total_diferencia,
                                           OUTPUT todo_ok).
                  
                 END.
                 IF v-total_debitan > v-total_acreditan AND 
                    todo_ok       = YES             and
                    tiene_op      = YES             THEN
                 DO:         
                     
                     v-total_diferencia = v-total_debitan - v-total_acreditan.
                     
                     
                     RUN genero_orden_pago(INPUT  ROWID(CC_debitan),
                                           INPUT  v-total_diferencia,
                                           OUTPUT todo_ok).       
                 END.                                             
             
             END.
             
             CC_acreditan.selectado  = NO.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE inicio_rendicion C-Win 
PROCEDURE inicio_rendicion :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VARIABLE directorio AS CHARACTER  NO-UNDO.
    directorio = "c:\sic-temp\compensar.txt".
    INPUT FROM VALUE(SEARCH(directorio)) NO-ECHO.
        REPEAT:
            IMPORT DELIMITER ";"
            que_proveedor
            que_facprov
            que_importe
            que_nro_moneda.
        END.            
    OUTPUT CLOSE.       
    FIND FIRST Moneda 
         WHERE Moneda.nro_moneda = que_nro_moneda
         NO-LOCK NO-ERROR.
    IF AVAILABLE Moneda THEN
       ASSIGN v_abrevia_deb = Moneda.abrevia
              v_abrevia_cre = Moneda.abrevia.
    FIND FIRST Proveedor 
         WHERE Proveedor.nro_proveedor = que_proveedor
         NO-LOCK NO-ERROR.

    
    
    DISPLAY v_abrevia_deb v_abrevia_cre WITH FRAME {&FRAME-NAME}.
    APPLY "leave" TO Proveedor.cdg_proveedor IN FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE levantar_monedas C-Win 
PROCEDURE levantar_monedas :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE ok AS LOGICAL.
  DEFINE VARIABLE lista AS CHARACTER.

  DO WITH FRAME {&FRAME-NAME}:
     {levantacombo.i &TABLA=Moneda &NOMBRE=descripcion &CODIGO=cdg_moneda &OBJETO=id_moneda}
  END.          

  FIND Moneda WHERE Moneda.es_local NO-LOCK.
  ASSIGN que_moneda = Moneda.nro_moneda
         id_moneda = Moneda.cdg_moneda.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PONER_PROVEEDOR C-Win 
PROCEDURE PONER_PROVEEDOR :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   
      IF rid_proveedor <> ? THEN RUN DESELECTAR ( INPUT rid_proveedor ). 


     t_regdeb = 0.
     t_regcre = 0.
     t_movdeb = 0.
     t_movcre = 0.
     saldo = 0.
     
     DISPLAY saldo t_movdeb t_movcre t_regcre t_regdeb
             WITH FRAME {&FRAME-NAME}.

     RUN ABRE_QUERY.


     ENABLE  BROWSE-CRE
             BROWSE-DEB
             WITH FRAME {&FRAME-NAME}.
             
   
     rid_proveedor = ROWID(Proveedor).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PONER_SESION C-Win 
PROCEDURE PONER_SESION :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PONER_TOTALES C-Win 
PROCEDURE PONER_TOTALES :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  saldo = t_movdeb - t_movcre.
  DISPLAY saldo t_movdeb t_movcre t_regdeb t_regcre
          WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

