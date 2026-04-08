&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame

/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Asn_detalle NO-UNDO LIKE Asn_detalle.
DEFINE TEMP-TABLE T-Asn_header NO-UNDO LIKE Asn_header.
DEFINE TEMP-TABLE T-Asn_totales NO-UNDO LIKE Asn_totales.
DEFINE BUFFER Total-Moneda FOR Moneda.


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS Dialog-Frame 
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
/*          This .W file was created with the Progress AppBuilder.       */
/*----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

DEFINE INPUT PARAMETER TABLE FOR T-Asn_header.
DEFINE INPUT PARAMETER TABLE FOR T-Asn_detalle.
DEFINE INPUT PARAMETER TABLE FOR T-Asn_totales.
    
/* Local Variable Definitions ---                                       */


{nrorelea.i}

DEFINE VARIABLE sino-msg                  AS LOGICAL NO-UNDO.
DEFINE VARIABLE st_seleccionado           AS CHARACTER.

DEFINE VARIABLE v-debito                  AS CHARACTER FORMAT "X(14)".
DEFINE VARIABLE v-credito                 AS CHARACTER FORMAT "X(14)".

DEFINE VARIABLE v-nro_linea               AS INTEGER.
DEFINE VARIABLE v-total_debitos           AS DECIMAL.

{valoresmodo.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Dialog-Box
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame
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


/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define FIELDS-IN-QUERY-Dialog-Frame T-Asn_header.tip_comprob ~
T-Asn_header.prf_comprob T-Asn_header.nro_comprob ~
T-Asn_header.nro_secuencia T-Asn_header.cambio_dolar ~
T-Asn_header.reexpresa_saldos T-Asn_header.fecha T-Asn_header.cambio ~
T-Asn_header.leyenda T-Asn_header.cdg_sigla-sic T-Asn_header.origen 
&Scoped-define ENABLED-FIELDS-IN-QUERY-Dialog-Frame ~
T-Asn_header.reexpresa_saldos T-Asn_header.fecha T-Asn_header.cambio ~
T-Asn_header.leyenda T-Asn_header.cdg_sigla-sic 
&Scoped-define ENABLED-TABLES-IN-QUERY-Dialog-Frame T-Asn_header
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-Dialog-Frame T-Asn_header
&Scoped-define OPEN-BROWSERS-IN-QUERY-Dialog-Frame ~
    ~{&OPEN-QUERY-BRW-ACUMULADOS}~
    ~{&OPEN-QUERY-BRW-DETALLE}
&Scoped-define QUERY-STRING-Dialog-Frame FOR EACH T-Asn_header SHARE-LOCK
&Scoped-define OPEN-QUERY-Dialog-Frame OPEN QUERY Dialog-Frame FOR EACH T-Asn_header SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-Dialog-Frame T-Asn_header
&Scoped-define FIRST-TABLE-IN-QUERY-Dialog-Frame T-Asn_header


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS T-Asn_header.reexpresa_saldos ~
T-Asn_header.fecha T-Asn_header.cambio T-Asn_header.leyenda ~
T-Asn_header.cdg_sigla-sic 
&Scoped-define ENABLED-TABLES T-Asn_header
&Scoped-define FIRST-ENABLED-TABLE T-Asn_header
&Scoped-Define ENABLED-OBJECTS RECT-14 RECT-15 Btn_OK BRW-ACUMULADOS ~
BRW-DETALLE 
&Scoped-Define DISPLAYED-FIELDS T-Asn_header.tip_comprob ~
T-Asn_header.prf_comprob T-Asn_header.nro_comprob ~
T-Asn_header.nro_secuencia T-Asn_header.cambio_dolar ~
T-Asn_header.reexpresa_saldos T-Asn_header.fecha T-Asn_header.cambio ~
T-Asn_header.leyenda T-Asn_header.cdg_sigla-sic T-Asn_header.origen ~
T-Asn_detalle.leyen_detalle 
&Scoped-define DISPLAYED-TABLES T-Asn_header T-Asn_detalle
&Scoped-define FIRST-DISPLAYED-TABLE T-Asn_header
&Scoped-define SECOND-DISPLAYED-TABLE T-Asn_detalle
&Scoped-Define DISPLAYED-OBJECTS v-reexpresado 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "&Salir" 
     SIZE 20 BY 1
     BGCOLOR 8 .

DEFINE VARIABLE v-reexpresado AS LOGICAL FORMAT "yes/no":U INITIAL NO 
     LABEL "Expresión" 
     VIEW-AS COMBO-BOX INNER-LINES 2
     LIST-ITEM-PAIRS "MONEDA DE ORIGEN",no,
                     "SALDOS REEXPRESADOS",yes
     DROP-DOWN-LIST
     SIZE 33 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE RECTANGLE RECT-14
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 123 BY 4.05.

DEFINE RECTANGLE RECT-15
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 22 BY 4.05.

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

DEFINE QUERY Dialog-Frame FOR 
      T-Asn_header SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BRW-ACUMULADOS
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BRW-ACUMULADOS Dialog-Frame _STRUCTURED
  QUERY BRW-ACUMULADOS NO-LOCK DISPLAY
      Total-moneda.abrevia COLUMN-LABEL "Identific!Moneda" FORMAT "X(5)":U
      T-Asn_totales.tot_debitos FORMAT "->,>>>,>>>,>>9.99":U
      T-Asn_totales.tot_creditos FORMAT "->,>>>,>>>,>>9.99":U
      T-Asn_totales.diferencia COLUMN-LABEL "Diferencia!Totales" FORMAT "->>>,>>>,>>9.99":U
      Total-moneda.descripcion COLUMN-LABEL "Denominación!Moneda" FORMAT "X(20)":U
            WIDTH 80
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 146 BY 5.71
         BGCOLOR 15 FGCOLOR 9 
         TITLE BGCOLOR 15 FGCOLOR 9 "Totales por Moneda" EXPANDABLE.

DEFINE BROWSE BRW-DETALLE
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BRW-DETALLE Dialog-Frame _STRUCTURED
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
    WITH NO-ROW-MARKERS SEPARATORS SIZE 146 BY 10.76
         BGCOLOR 15 FGCOLOR 9 
         TITLE BGCOLOR 15 FGCOLOR 9 "Pases del Asiento Actual".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     T-Asn_header.tip_comprob AT ROW 1.48 COL 13 COLON-ALIGNED
          LABEL "Asiento"
          VIEW-AS FILL-IN 
          SIZE 7 BY 1
          BGCOLOR 7 FGCOLOR 15 
     T-Asn_header.prf_comprob AT ROW 1.48 COL 21 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 7 BY 1
          BGCOLOR 7 FGCOLOR 15 
     T-Asn_header.nro_comprob AT ROW 1.48 COL 29 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 17 BY 1
          BGCOLOR 7 FGCOLOR 15 
     T-Asn_header.nro_secuencia AT ROW 1.48 COL 47 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Asn_header.cambio_dolar AT ROW 1.48 COL 107 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Btn_OK AT ROW 1.48 COL 128
     v-reexpresado AT ROW 2.67 COL 13 COLON-ALIGNED
     T-Asn_header.reexpresa_saldos AT ROW 2.67 COL 49
          LABEL "Asiento Multimoneda"
          VIEW-AS TOGGLE-BOX
          SIZE 24 BY 1.19
     T-Asn_header.fecha AT ROW 2.67 COL 81 COLON-ALIGNED FORMAT "99/99/9999"
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Asn_header.cambio AT ROW 2.67 COL 107 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Asn_header.leyenda AT ROW 3.86 COL 13 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 109 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Asn_header.cdg_sigla-sic AT ROW 3.86 COL 126 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Asn_header.origen AT ROW 3.86 COL 140 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     BRW-ACUMULADOS AT ROW 5.52 COL 3
     BRW-DETALLE AT ROW 11.48 COL 3
     T-Asn_detalle.leyen_detalle AT ROW 23.62 COL 1 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 146 BY 1
          BGCOLOR 15 FGCOLOR 9 
     "   Leyenda asociada al renglón de detalle" VIEW-AS TEXT
          SIZE 146 BY 1 AT ROW 22.43 COL 3
          BGCOLOR 5 FGCOLOR 15 
     "   Módulo Origen" VIEW-AS TEXT
          SIZE 20 BY 1 AT ROW 2.67 COL 128
          BGCOLOR 5 FGCOLOR 15 
     RECT-14 AT ROW 1.24 COL 3
     RECT-15 AT ROW 1.24 COL 127
     SPACE(1.19) SKIP(19.65)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Consulta de Imputaciones Contables"
         DEFAULT-BUTTON Btn_OK.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Dialog-Box
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Asn_detalle T "?" NO-UNDO sic Asn_detalle
      TABLE: T-Asn_header T "?" NO-UNDO sic Asn_header
      TABLE: T-Asn_totales T "?" NO-UNDO sic Asn_totales
      TABLE: Total-Moneda B "?" ? sic Moneda
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
                                                                        */
/* BROWSE-TAB BRW-ACUMULADOS origen Dialog-Frame */
/* BROWSE-TAB BRW-DETALLE BRW-ACUMULADOS Dialog-Frame */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

ASSIGN 
       Total-moneda.descripcion:AUTO-RESIZE IN BROWSE BRW-ACUMULADOS = TRUE.

/* SETTINGS FOR FILL-IN T-Asn_header.cambio_dolar IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Asn_header.fecha IN FRAME Dialog-Frame
   EXP-FORMAT                                                           */
/* SETTINGS FOR FILL-IN T-Asn_detalle.leyen_detalle IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Asn_header.nro_comprob IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Asn_header.nro_secuencia IN FRAME Dialog-Frame
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN T-Asn_header.origen IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Asn_header.prf_comprob IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR TOGGLE-BOX T-Asn_header.reexpresa_saldos IN FRAME Dialog-Frame
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN T-Asn_header.tip_comprob IN FRAME Dialog-Frame
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR COMBO-BOX v-reexpresado IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
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
     _FldNameList[4]   > Temp-Tables.T-Asn_totales.diferencia
"T-Asn_totales.diferencia" "Diferencia!Totales" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[5]   > Temp-Tables.Total-moneda.descripcion
"Total-moneda.descripcion" "Denominación!Moneda" ? "character" ? ? ? ? ? ? no ? no no "80" yes yes no "U" "" ""
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

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX Dialog-Frame
/* Query rebuild information for DIALOG-BOX Dialog-Frame
     _TblList          = "Temp-Tables.T-Asn_header"
     _Options          = "SHARE-LOCK"
     _Query            is NOT OPENED
*/  /* DIALOG-BOX Dialog-Frame */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Consulta de Imputaciones Contables */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BRW-ACUMULADOS
&Scoped-define SELF-NAME BRW-ACUMULADOS
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BRW-ACUMULADOS Dialog-Frame
ON VALUE-CHANGED OF BRW-ACUMULADOS IN FRAME Dialog-Frame /* Totales por Moneda */
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BRW-DETALLE Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF BRW-DETALLE IN FRAME Dialog-Frame /* Pases del Asiento Actual */
OR RETURN OF {&BROWSE-NAME} IN FRAME {&FRAME-NAME}
DO:
    RUN mostrar_detalle.
    RUN abre_query_detalle.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BRW-DETALLE Dialog-Frame
ON VALUE-CHANGED OF BRW-DETALLE IN FRAME Dialog-Frame /* Pases del Asiento Actual */
DO:
  DISPLAY T-Asn_detalle.leyen_detalle WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-reexpresado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-reexpresado Dialog-Frame
ON VALUE-CHANGED OF v-reexpresado IN FRAME Dialog-Frame /* Expresión */
DO:
    ASSIGN v-reexpresado.
    RUN poner_moneda.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BRW-ACUMULADOS
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Dialog-Frame 


/* ***************************  Main Block  *************************** */

/* Parent the dialog-box to the ACTIVE-WINDOW, if there is no parent.   */
IF VALID-HANDLE(ACTIVE-WINDOW) AND FRAME {&FRAME-NAME}:PARENT eq ?
THEN FRAME {&FRAME-NAME}:PARENT = ACTIVE-WINDOW.

{findempresa.i}

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  FRAME {&FRAME-NAME}:TITLE = "DYNASYS/GLA " + NRO_RELEASE + " - " + Usuario.cdg_empresa + " - Consulta de Imputación Contable User:" + Usuario.cdg_usuario.

  FIND FIRST T-Asn_header NO-LOCK NO-ERROR.
  IF AVAILABLE T-Asn_header
  THEN DO:
      DISPLAY
            T-Asn_header.tip_comprob 
            T-Asn_header.prf_comprob 
            T-Asn_header.nro_comprob 
            T-Asn_header.fecha 
            T-Asn_header.cdg_sigla-sic 
            T-Asn_header.nro_secuencia 
            T-Asn_header.origen 
            T-Asn_header.leyenda
            WITH FRAME {&FRAME-NAME}.
    
      RUN abre_query_acumulados.
      RUN abre_query_detalle.
    
      RUN habilitar_campos.
      APPLY "VALUE-CHANGED" TO BRW-DETALLE.
  END.

  WAIT-FOR GO OF FRAME {&FRAME-NAME}.
END.
RUN disable_UI.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE abre_query_acumulados Dialog-Frame 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE abre_query_detalle Dialog-Frame 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI Dialog-Frame  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Hide all frames. */
  HIDE FRAME Dialog-Frame.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI Dialog-Frame  _DEFAULT-ENABLE
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
  DISPLAY v-reexpresado 
      WITH FRAME Dialog-Frame.
  IF AVAILABLE T-Asn_detalle THEN 
    DISPLAY T-Asn_detalle.leyen_detalle 
      WITH FRAME Dialog-Frame.
  IF AVAILABLE T-Asn_header THEN 
    DISPLAY T-Asn_header.tip_comprob T-Asn_header.prf_comprob 
          T-Asn_header.nro_comprob T-Asn_header.nro_secuencia 
          T-Asn_header.cambio_dolar T-Asn_header.reexpresa_saldos 
          T-Asn_header.fecha T-Asn_header.cambio T-Asn_header.leyenda 
          T-Asn_header.cdg_sigla-sic T-Asn_header.origen 
      WITH FRAME Dialog-Frame.
  ENABLE RECT-14 RECT-15 Btn_OK T-Asn_header.reexpresa_saldos 
         T-Asn_header.fecha T-Asn_header.cambio T-Asn_header.leyenda 
         T-Asn_header.cdg_sigla-sic BRW-ACUMULADOS BRW-DETALLE 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE habilitar_campos Dialog-Frame 
PROCEDURE habilitar_campos :
/*------------------------------------------------------------------------------
  Purpose: habilita o deshabilita los campos de la frame para el estado final
           de la misma que se da cuando se ejecuta el ciclo de transaccion. El es-
           tado inicial de los campos lo ajusta la rutina frame_sensitiva.   
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  
  DO WITH FRAME {&FRAME-NAME}:

      ASSIGN   T-Asn_header.fecha:SENSITIVE             = NO
               T-Asn_header.cambio:SENSITIVE            = NO
               T-Asn_header.cambio_dolar:SENSITIVE      = NO
               T-Asn_header.leyenda:SENSITIVE           = NO
               T-Asn_header.nro_comprob:SENSITIVE       = NO
               T-Asn_header.prf_comprob:SENSITIVE       = NO
               T-Asn_header.tip_comprob:SENSITIVE       = NO
               T-Asn_header.cdg_sigla-sic:SENSITIVE     = NO
               T-Asn_header.reexpresa_saldos:SENSITIVE  = NO
               v-reexpresado:SENSITIVE                  = YES.

  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE mostrar_detalle Dialog-Frame 
PROCEDURE mostrar_detalle :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    RUN d-detalle_asiento.w ( INPUT T-Asn_header.nro_moneda,
                              INPUT T-Asn_detalle.nro_cuenta,
                              INPUT T-Asn_detalle.nro_linea,
                              INPUT T-Asn_detalle.nro_moneda,
                              INPUT T-Asn_detalle.reexpresion,
                              INPUT MD_MULTIPLE,
                              INPUT 1,
                              OUTPUT v-nro_linea,
                              INPUT-OUTPUT TABLE T-Asn_header,
                              INPUT-OUTPUT TABLE T-Asn_detalle
                              ).

    FIND FIRST T-Asn_header.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_moneda Dialog-Frame 
PROCEDURE poner_moneda :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    RUN abre_query_acumulados.
    IF v-reexpresado
        THEN APPLY "VALUE-CHANGED" TO BRW-ACUMULADOS IN FRAME {&FRAME-NAME}.
        ELSE RUN abre_query_detalle. 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

