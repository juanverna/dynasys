&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win

/* Temp-Table and Buffer definitions                                    */
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
DEFINE VARIABLE                rid_movcaja    AS ROWID.
DEFINE VARIABLE                modo           AS INTEGER.
&ELSE
DEFINE INPUT-OUTPUT PARAMETER  rid_movcaja    AS ROWID.
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
DEFINE VARIABLE v-rid_detalle             AS ROWID.
DEFINE VARIABLE v-nro_cuenta              AS INTEGER.
DEFINE VARIABLE aux_importe               AS DECIMAL.
DEFINE VARIABLE v-debug                   AS LOGICAL INITIAL NO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME BROWSE-3

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Caja-imputacion Cuenta Entidad Obra ~
T-Caj_header

/* Definitions for BROWSE BROWSE-3                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-3 Cuenta.cdg_cuenta Cuenta.nombre_cta ~
Entidad.cdg_entidad Obra.cdg_obra Caja-imputacion.valor ~
Caja-imputacion.observacion 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-3 
&Scoped-define QUERY-STRING-BROWSE-3 FOR EACH Caja-imputacion ~
      WHERE Caja-imputacion.nro_transaccion = Caj_header.nro_transaccion NO-LOCK, ~
      EACH Cuenta OF Caja-imputacion NO-LOCK, ~
      EACH Entidad OF Caja-imputacion NO-LOCK, ~
      EACH Obra OF Caja-imputacion OUTER-JOIN NO-LOCK ~
    BY Cuenta.cdg_cuenta ~
       BY Entidad.cdg_entidad ~
        BY Obra.cdg_obra
&Scoped-define OPEN-QUERY-BROWSE-3 OPEN QUERY BROWSE-3 FOR EACH Caja-imputacion ~
      WHERE Caja-imputacion.nro_transaccion = Caj_header.nro_transaccion NO-LOCK, ~
      EACH Cuenta OF Caja-imputacion NO-LOCK, ~
      EACH Entidad OF Caja-imputacion NO-LOCK, ~
      EACH Obra OF Caja-imputacion OUTER-JOIN NO-LOCK ~
    BY Cuenta.cdg_cuenta ~
       BY Entidad.cdg_entidad ~
        BY Obra.cdg_obra.
&Scoped-define TABLES-IN-QUERY-BROWSE-3 Caja-imputacion Cuenta Entidad Obra
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-3 Caja-imputacion
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-3 Cuenta
&Scoped-define THIRD-TABLE-IN-QUERY-BROWSE-3 Entidad
&Scoped-define FOURTH-TABLE-IN-QUERY-BROWSE-3 Obra


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define FIELDS-IN-QUERY-DEFAULT-FRAME T-Caj_header.tip_comprob ~
T-Caj_header.prf_comprob T-Caj_header.nro_comprob T-Caj_header.fecha ~
T-Caj_header.importe T-Caj_header.ingreso T-Caj_header.tipo_mov ~
T-Caj_header.observacion 
&Scoped-define ENABLED-FIELDS-IN-QUERY-DEFAULT-FRAME ~
T-Caj_header.tip_comprob T-Caj_header.prf_comprob T-Caj_header.nro_comprob ~
T-Caj_header.fecha T-Caj_header.importe T-Caj_header.ingreso ~
T-Caj_header.tipo_mov T-Caj_header.observacion 
&Scoped-define ENABLED-TABLES-IN-QUERY-DEFAULT-FRAME T-Caj_header
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-DEFAULT-FRAME T-Caj_header
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-BROWSE-3}
&Scoped-define QUERY-STRING-DEFAULT-FRAME FOR EACH T-Caj_header SHARE-LOCK
&Scoped-define OPEN-QUERY-DEFAULT-FRAME OPEN QUERY DEFAULT-FRAME FOR EACH T-Caj_header SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-DEFAULT-FRAME T-Caj_header
&Scoped-define FIRST-TABLE-IN-QUERY-DEFAULT-FRAME T-Caj_header


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS T-Caj_header.tip_comprob ~
T-Caj_header.prf_comprob T-Caj_header.nro_comprob T-Caj_header.fecha ~
T-Caj_header.importe T-Caj_header.ingreso T-Caj_header.tipo_mov ~
T-Caj_header.observacion 
&Scoped-define ENABLED-TABLES T-Caj_header
&Scoped-define FIRST-ENABLED-TABLE T-Caj_header
&Scoped-Define ENABLED-OBJECTS Btn_salir imp_no_imp BROWSE-3 RECT-1 RECT-2 ~
RECT-3 RECT-5 
&Scoped-Define DISPLAYED-FIELDS T-Caj_header.tip_comprob ~
T-Caj_header.prf_comprob T-Caj_header.nro_comprob T-Caj_header.fecha ~
T-Caj_header.importe T-Caj_header.ingreso T-Caj_header.tipo_mov ~
T-Caj_header.observacion 
&Scoped-define DISPLAYED-TABLES T-Caj_header
&Scoped-define FIRST-DISPLAYED-TABLE T-Caj_header
&Scoped-Define DISPLAYED-OBJECTS v-pto_venta v-anulado v-cdg_caja ~
v-dsc_caja v-cdg_cuenta imp_no_imp 

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
     SIZE 26 BY 1.05.

DEFINE BUTTON Btn_salir DEFAULT 
     LABEL "&Salir" 
     SIZE 21 BY 1.33
     BGCOLOR 8 .

DEFINE BUTTON btn_valores 
     LABEL "&Ver Valores" 
     SIZE 21 BY 1.

DEFINE VARIABLE imp_no_imp AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     LABEL "No Imputado" 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 7 FGCOLOR 14  NO-UNDO.

DEFINE VARIABLE v-anulado AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 21 BY 1
     FGCOLOR 12 FONT 6 NO-UNDO.

DEFINE VARIABLE v-cdg_caja AS INTEGER FORMAT "->,>>>,>>9" INITIAL 0 
     LABEL "Caja" 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_cuenta AS CHARACTER FORMAT "X(10)":U 
     LABEL "Cuenta" 
     VIEW-AS FILL-IN 
     SIZE 30 BY 1
     BGCOLOR 14 FGCOLOR 12 FONT 6 NO-UNDO.

DEFINE VARIABLE v-dsc_caja AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 59 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-pto_venta AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 0 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 21 BY 1.86.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 134 BY 1.86.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 23 BY 1.86.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 157 BY 5.19.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-3 FOR 
      Caja-imputacion, 
      Cuenta, 
      Entidad, 
      Obra SCROLLING.

DEFINE QUERY DEFAULT-FRAME FOR 
      T-Caj_header SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-3 C-Win _STRUCTURED
  QUERY BROWSE-3 NO-LOCK DISPLAY
      Cuenta.cdg_cuenta FORMAT "X(15)":U
      Cuenta.nombre_cta FORMAT "X(35)":U
      Entidad.cdg_entidad FORMAT "X(8)":U
      Obra.cdg_obra FORMAT "X(8)":U
      Caja-imputacion.valor COLUMN-LABEL "Importe!Imputado" FORMAT "->,>>>,>>9.99":U
      Caja-imputacion.observacion COLUMN-LABEL "Observacion!Imputación" FORMAT "X(23)":U
            WIDTH 69
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 157 BY 14.52
         BGCOLOR 15 FGCOLOR 9 
         TITLE BGCOLOR 15 FGCOLOR 9 "Imputación contable del actual movimiento" EXPANDABLE.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btn_copiar AT ROW 1.48 COL 27
     btn_cancel AT ROW 1.48 COL 49
     btn_anular AT ROW 1.48 COL 71
     btn_observ AT ROW 1.48 COL 93
     btn_imprim AT ROW 1.48 COL 115
     Btn_salir AT ROW 1.48 COL 138
     btn_grabar AT ROW 1.52 COL 5
     T-Caj_header.tip_comprob AT ROW 3.62 COL 23 COLON-ALIGNED
          LABEL "Comprobante"
          VIEW-AS FILL-IN 
          SIZE 7 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Caj_header.prf_comprob AT ROW 3.62 COL 31 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 7 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Caj_header.nro_comprob AT ROW 3.62 COL 39 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 14 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Caj_header.fecha AT ROW 3.62 COL 72 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-pto_venta AT ROW 3.62 COL 90 COLON-ALIGNED NO-LABEL
     T-Caj_header.importe AT ROW 3.62 COL 114 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-anulado AT ROW 3.62 COL 136 COLON-ALIGNED NO-LABEL
     v-cdg_caja AT ROW 4.81 COL 23 COLON-ALIGNED
     v-dsc_caja AT ROW 4.81 COL 39 COLON-ALIGNED NO-LABEL
     T-Caj_header.ingreso AT ROW 4.81 COL 114 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Caj_header.tipo_mov AT ROW 5.29 COL 143 NO-LABEL
          VIEW-AS RADIO-SET VERTICAL
          RADIO-BUTTONS 
                    "Ingreso", "I":U,
"Egreso", "E":U
          SIZE 13 BY 1.33
     T-Caj_header.observacion AT ROW 6 COL 23 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 109 BY 1
     btn_valores AT ROW 7.14 COL 138
     v-cdg_cuenta AT ROW 7.19 COL 23 COLON-ALIGNED
     btn_porclasificacion AT ROW 7.19 COL 74
     imp_no_imp AT ROW 7.19 COL 114 COLON-ALIGNED
     BROWSE-3 AT ROW 8.86 COL 3
     RECT-1 AT ROW 5 COL 138
     RECT-2 AT ROW 1.24 COL 3
     RECT-3 AT ROW 1.24 COL 137
     RECT-5 AT ROW 3.43 COL 3
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 160.2 BY 27.62.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
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
         TITLE              = "Movimiento de Caja"
         HEIGHT             = 27.62
         WIDTH              = 160
         MAX-HEIGHT         = 27.62
         MAX-WIDTH          = 160.2
         VIRTUAL-HEIGHT     = 27.62
         VIRTUAL-WIDTH      = 160.2
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
/* BROWSE-TAB BROWSE-3 imp_no_imp DEFAULT-FRAME */
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
/* SETTINGS FOR FILL-IN T-Caj_header.tip_comprob IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN v-anulado IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_caja IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_cuenta IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_caja IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-pto_venta IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-3
/* Query rebuild information for BROWSE BROWSE-3
     _TblList          = "sic.Caja-imputacion,sic.Cuenta OF sic.Caja-imputacion,sic.Entidad OF sic.Caja-imputacion,sic.Obra OF sic.Caja-imputacion"
     _Options          = "NO-LOCK"
     _TblOptList       = ",,, OUTER"
     _OrdList          = "sic.Cuenta.cdg_cuenta|yes,sic.Entidad.cdg_entidad|yes,sic.Obra.cdg_obra|yes"
     _Where[1]         = "Caja-imputacion.nro_transaccion = Caj_header.nro_transaccion"
     _FldNameList[1]   > sic.Cuenta.cdg_cuenta
"Cuenta.cdg_cuenta" ? "X(15)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[2]   = sic.Cuenta.nombre_cta
     _FldNameList[3]   = sic.Entidad.cdg_entidad
     _FldNameList[4]   = sic.Obra.cdg_obra
     _FldNameList[5]   > sic.Caja-imputacion.valor
"Caja-imputacion.valor" "Importe!Imputado" "->,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[6]   > sic.Caja-imputacion.observacion
"Caja-imputacion.observacion" "Observacion!Imputación" "X(23)" "character" ? ? ? ? ? ? no ? no no "69" yes no no "U" "" ""
     _Query            is OPENED
*/  /* BROWSE BROWSE-3 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME DEFAULT-FRAME
/* Query rebuild information for FRAME DEFAULT-FRAME
     _TblList          = "Temp-Tables.T-Caj_header"
     _Query            is NOT OPENED
*/  /* FRAME DEFAULT-FRAME */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Movimiento de Caja */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Movimiento de Caja */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-3
&Scoped-define SELF-NAME BROWSE-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-3 C-Win
ON DELETE-CHARACTER OF BROWSE-3 IN FRAME DEFAULT-FRAME /* Imputación contable del actual movimiento */
DO:
    IF modo = MD_ALTA
    THEN DO:
        IF AVAILABLE Caja-imputacion
        THEN DO:
            sino-msg = NO.
            MESSAGE "Desea eliminar este renglón de detalle?" 
                    VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
            IF sino-msg
            THEN DO:
                 DELETE Caja-imputacion.
                 {&OPEN-QUERY-{&BROWSE-NAME}}
                 RUN calculos.
            END.
        END.
        ELSE DO:
            MESSAGE "No hay imputaciones que puedan eliminarse" 
                    VIEW-AS ALERT-BOX ERROR.
        END.

    END.
    ELSE DO:
        BELL.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-3 C-Win
ON MOUSE-SELECT-DBLCLICK OF BROWSE-3 IN FRAME DEFAULT-FRAME /* Imputación contable del actual movimiento */
OR RETURN OF BROWSE-3 IN FRAME {&FRAME-NAME}
DO:
  IF AVAILABLE  Caja-imputacion
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
/*
    DEFINE VARIABLE pudo_anular AS INTEGER.
    sino-msg = NO.
    MESSAGE "Desea ANULAR esta factura" 
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
    IF sino-msg
    THEN DO:
         RUN anular_movcaja.p (INPUT ROWID(Fac_header), OUTPUT pudo_anular).
         IF pudo_anular = 0
         THEN DO:
              DO TRANSACTION:
                FOR EACH T-Fac_detalle:
                    DELETE T-Fac_detalle.
                END.    
                DELETE T-Caj_header.

              END.
              MESSAGE "La factura ha sido anulada" 
                      VIEW-AS ALERT-BOX MESSAGE TITLE "Aviso".
              
         END.
         ASSIGN codigo_salir = CD_GRABAR.
         APPLY "U1":U TO THIS-PROCEDURE.
    END.
*/  
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
/*
        FOR EACH T-Fac_detalle:
            DELETE T-Fac_detalle.
        END.

        FOR EACH T-Caj_header:
            DELETE T-Caj_header.
        END.

        FOR EACH T-Fac_detalle-bon:
            DELETE T-Fac_detalle-bon.
        END.

        FOR EACH T-Caj_header-bon:
            DELETE T-Caj_header-bon.
        END.

        FOR EACH T-Sub_header_vta:
            DELETE T-Sub_header_vta.
        END.

        FOR EACH T-Sub_detalle_vta:
            DELETE T-Sub_detalle_vta.
        END.
*/
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
     FIND Fac_header WHERE ROWID(Fac_header) = rid_movcaja NO-LOCK.
     DISPLAY Fac_header.tip_comprob @ T-Caj_header.tip_comprob 
             Fac_header.prf_comprob @ T-Caj_header.prf_comprob
             Fac_header.nro_comprob @ T-Caj_header.nro_comprob
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
        T-Caj_header.importe 
        T-Caj_header.observacion 
        T-Caj_header.tipo_mov.
         
  RUN validar_datos ( OUTPUT hay_error ).
  IF NOT hay_error
  THEN DO:

       IF NOT T-Caj_header.anulado /* No es una anulación */
       THEN DO:
            act_caj_head = ROWID(T-Caj_header).
            RUN c-valores_movimiento.w (INPUT-OUTPUT act_caj_head, INPUT modo).
            FIND T-Caj_header WHERE ROWID(T-Caj_header) = act_caj_head EXCLUSIVE-LOCK.
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
         RUN imprimir_movcaja.p (ROWID(Fac_header)).
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
ON CHOOSE OF btn_porclasificacion IN FRAME DEFAULT-FRAME /* X Clasificación */
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
ON CHOOSE OF btn_valores IN FRAME DEFAULT-FRAME /* Ver Valores */
DO:
     act_caj_head = ROWID(T-Caj_header).
     RUN ALTMCAJA.P (INPUT 2).
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
   {traducetabla.i "caja" "cdg_caja" "nombre"} 
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
  IF modo = MD_ALTA THEN APPLY "ENTRY" TO v-cdg_caja.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE calculos C-Win 
PROCEDURE calculos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  imp_no_imp = INPUT FRAME {&FRAME-NAME} T-Caj_header.importe.
  FOR EACH Caja-imputacion WHERE Caja-imputacion.nro_transaccion = T-Caj_header.nro_transaccion:
      imp_no_imp = imp_no_imp - Caja-imputacion.valor.
  END. 
  
  DISPLAY imp_no_imp
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

    v-rid_detalle = ROWID(Caja-imputacion).
    
    RUN d-detalle_imputacion.w ( INPUT  ROWID(T-Caj_header),
                                 INPUT-OUTPUT  v-rid_detalle, 
                                 INPUT  Caja-imputacion.nro_cuenta,
                                 INPUT  modo,
                                 INPUT  1 
                                 ).

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

    v-rid_detalle = ?.

    RUN d-detalle_imputacion.w ( INPUT  ROWID(T-Caj_header),
                                 INPUT-OUTPUT  v-rid_detalle, 
                                 INPUT  Cuenta.nro_cuenta,
                                 INPUT  modo,
                                 INPUT  0 /* modo detalle = CREAR */
                                 ).

    IF v-rid_detalle <> ?
    THEN DO:
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

  DO TRANSACTION:
    
      CREATE T-Caj_header.
      ASSIGN T-Caj_header.nro_usuario     = Usuario.nro_usuario 
             T-Caj_header.cdg_empresa     = Empresa.cdg_empresa
             T-Caj_header.fecha           = TODAY
             T-Caj_header.hora            = TIME
             T-Caj_header.tip_comprob     = "CJ"
             T-Caj_header.prf_comprob     = v-pto_venta
             T-Caj_header.cdg_empresa     = Empresa.cdg_empresa
             T-Caj_header.ultima_linea    = 0
             T-Caj_header.nro_transaccion = NEXT-VALUE(proxima_txncaja)
             imp_no_imp                 = 0
             T-Caj_header.ingreso         = 0
             T-Caj_header.cdg_caja        = Caja.cdg_caja
             v-cdg_caja                 = Caja.cdg_caja
             v-dsc_caja                 = Caja.nombre. 

  END.

  DISPLAY
         T-Caj_header.tip_comprob
         T-Caj_header.prf_comprob
         T-Caj_header.fecha   
         v-cdg_caja
         v-dsc_caja      
         v-pto_venta
         WITH FRAME {&FRAME-NAME}.

  codigo_salir = ?.

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
  DISPLAY v-pto_venta v-anulado v-cdg_caja v-dsc_caja v-cdg_cuenta imp_no_imp 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE T-Caj_header THEN 
    DISPLAY T-Caj_header.tip_comprob T-Caj_header.prf_comprob 
          T-Caj_header.nro_comprob T-Caj_header.fecha T-Caj_header.importe 
          T-Caj_header.ingreso T-Caj_header.tipo_mov T-Caj_header.observacion 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE Btn_salir T-Caj_header.tip_comprob T-Caj_header.prf_comprob 
         T-Caj_header.nro_comprob T-Caj_header.fecha T-Caj_header.importe 
         T-Caj_header.ingreso T-Caj_header.tipo_mov T-Caj_header.observacion 
         imp_no_imp BROWSE-3 RECT-1 RECT-2 RECT-3 RECT-5 
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
                btn_grabar:SENSITIVE                    = NO
                btn_copiar:SENSITIVE                    = NO
                btn_cancel:SENSITIVE                    = NO
                btn_anular:SENSITIVE                    = NO
                btn_observ:SENSITIVE                    = NO
                btn_imprim:SENSITIVE                    = NO
                T-Caj_header.tip_comprob:SENSITIVE        = NO
                T-Caj_header.prf_comprob:SENSITIVE        = NO
                T-Caj_header.nro_comprob:SENSITIVE        = NO
                T-Caj_header.fecha:SENSITIVE              = NO
                T-Caj_header.observacion:SENSITIVE        = NO
                T-Caj_header.importe:SENSITIVE            = NO
                v-cdg_cuenta:SENSITIVE                  = NO
                v-cdg_caja:SENSITIVE                    = NO
                btn_porclasificacion:SENSITIVE          = NO
                btn_valores:SENSITIVE                   = NO.
     END.
     ELSE DO:
            CASE modo:
       
                WHEN MD_ALTA          
                THEN DO:
                     ASSIGN
                        btn_grabar:SENSITIVE                    = YES
                        btn_copiar:SENSITIVE                    = NO
                        btn_cancel:SENSITIVE                    = YES
                        btn_anular:SENSITIVE                    = NO
                        btn_observ:SENSITIVE                    = YES
                        btn_imprim:SENSITIVE                    = YES
                        /*
                        T-Caj_header.tip_comprob:SENSITIVE        = YES
                        T-Caj_header.prf_comprob:SENSITIVE        = YES
                        T-Caj_header.nro_comprob:SENSITIVE        = YES
                        */
                        T-Caj_header.fecha:SENSITIVE              = YES
                        T-Caj_header.observacion:SENSITIVE        = YES
                        T-Caj_header.importe:SENSITIVE            = YES
                        v-cdg_cuenta:SENSITIVE                  = YES
                        v-cdg_caja:SENSITIVE                    = YES
                        btn_porclasificacion:SENSITIVE          = YES
                        btn_valores:SENSITIVE                   = NO
                        v-pto_venta:SENSITIVE                   = YES.
         
                END.
                WHEN MD_MULTIPLE      
                THEN DO:
                     ASSIGN
                        T-Caj_header.tip_comprob:SENSITIVE        = YES
                        T-Caj_header.prf_comprob:SENSITIVE        = YES
                        T-Caj_header.nro_comprob:SENSITIVE        = YES
                        v-pto_venta:SENSITIVE                   = NO.

                END.
                WHEN MD_DEFINIDA      
                THEN DO:
                     ASSIGN
                        btn_valores:SENSITIVE                   = YES
                        v-pto_venta:SENSITIVE                   = NO.
         
                END.
                WHEN MD_RELACION      
                THEN DO:
                     ASSIGN
                        btn_valores:SENSITIVE                   = YES
                        v-pto_venta:SENSITIVE                   = NO.
         
                END.
                WHEN MD_READONLY      
                THEN DO:
                     ASSIGN
                        btn_valores:SENSITIVE                   = YES
                        v-pto_venta:SENSITIVE                   = NO.
         
                END.
                WHEN MD_CAMBIO        
                THEN DO:
                     ASSIGN
                        btn_valores:SENSITIVE                   = YES
                        v-pto_venta:SENSITIVE                   = NO.

                END.
                WHEN MD_ANULACION        
                THEN DO:
                     ASSIGN
                        T-Caj_header.tip_comprob:SENSITIVE        = YES
                        T-Caj_header.prf_comprob:SENSITIVE        = YES
                        T-Caj_header.nro_comprob:SENSITIVE        = YES
                        v-pto_venta:SENSITIVE                   = NO.
                END.
                WHEN MD_EMISION        
                THEN DO:
                     ASSIGN
                        T-Caj_header.tip_comprob:SENSITIVE        = YES
                        T-Caj_header.prf_comprob:SENSITIVE        = YES
                        T-Caj_header.nro_comprob:SENSITIVE        = YES
                        v-pto_venta:SENSITIVE                   = NO.
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
       v-tip_comprob = "CJ".
       v-prox_docum = "PRCJ" + STRING(v-pto_venta,"9999").

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
  
       ASSIGN  T-Caj_header.tip_comprob = v-tip_comprob
               T-Caj_header.prf_comprob = v-pto_venta
               T-Caj_header.nro_comprob = Parametro.valor_n
               Parametro.valor_n      = Parametro.valor_n + 1.
       
       RUN emitir_movcaja.p ( ROWID(T-Caj_header)).

       RELEASE Parametro.        

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

   RUN getparametro.p (  INPUT  "DFNROCAJ",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).
 
   FIND Caja WHERE Caja.cdg_caja    = v-valor_n 
                  NO-LOCK.
   act_caja = ROWID(Caja).

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

   /*
   FIND Impuesto WHERE Impuesto.cdg_impuesto = codigo_iva NO-LOCK.
   prciva = Impuesto.tasa.
   */
   
   st_seleccionado = "Opg-" + USERID("SIC").
   RUN titulo_window ( INPUT "Movimientos de Tesorería" ).



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

 {&WINDOW-NAME}:TITLE = "DYNASYS/TES " + NRO_RELEASE + " - " + Usuario.cdg_empresa + " - " + v-txtitulo + " User:" + USERID("sic").

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
  
    {validartabla.i "Caja"              "cdg_caja"        "nombre"         "CAJA021"}

    IF T-Caj_header.importe = 0
    THEN DO:
       RUN PONMENSJ.P (INPUT "CAJA025").
       RETURN.
    END.  
  
    IF NOT CAN-FIND(FIRST Caja-imputacion WHERE Caja-imputacion.nro_transaccion = T-Caj_header.nro_transaccion)
    THEN DO:
       RUN PONMENSJ.P (INPUT "CAJA024").
       RETURN.
    END.  
  
    IF imp_no_imp <> 0
    THEN DO:
       RUN PONMENSJ.P (INPUT "CAJA022").
       RETURN.
    END.  
   
    hubo_error = NO.

    &SCOPED-DEFINE TABLA-MAESTRA  T-Caj_header

    {asignartabla.i "Caja"           "cdg_caja"     "cdg_caja"      }
 
    &UNDEFINE TABLA-MAESTRA


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

