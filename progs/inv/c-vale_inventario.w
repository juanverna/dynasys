&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win

/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Partida NO-UNDO LIKE Partida
       FIELD es_nueva AS LOGICAL.
DEFINE TEMP-TABLE T-Registrable NO-UNDO LIKE Registrable
       FIELD es_nuevo AS LOGICAL.
DEFINE TEMP-TABLE T-Registrable_vale NO-UNDO LIKE Registrable_vale.
DEFINE TEMP-TABLE T-Sub_detalle_inv NO-UNDO LIKE Sub_detalle_inv.
DEFINE TEMP-TABLE T-Sub_header_inv NO-UNDO LIKE Sub_header_inv.
DEFINE TEMP-TABLE T-Valeinv_dt NO-UNDO LIKE Valeinv_dt.
DEFINE TEMP-TABLE T-Valeinv_hd NO-UNDO LIKE Valeinv_hd.


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
DEFINE VARIABLE                rid_factura        AS ROWID.
DEFINE VARIABLE                modo               AS INTEGER.
DEFINE VARIABLE                p-cdg_comprobante  AS CHARACTER.
&ELSE
DEFINE INPUT-OUTPUT PARAMETER  rid_factura        AS ROWID.
DEFINE INPUT        PARAMETER  modo               AS INTEGER.
DEFINE INPUT        PARAMETER  p-cdg_comprobante  AS CHARACTER.
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

DEFINE VARIABLE v-nombre_comprobante      AS CHARACTER.
DEFINE VARIABLE v-fgcolor_comprobante     AS INTEGER.
DEFINE VARIABLE v-bgcolor_comprobante     AS INTEGER.
DEFINE VARIABLE v-primera_letra           AS CHARACTER.
DEFINE VARIABLE v-prefijo_contador        AS CHARACTER.
DEFINE VARIABLE v-leyenda                 AS CHARACTER.

DEFINE VARIABLE v-pto_venta-org           AS INTEGER.
DEFINE VARIABLE v-nro_linea               AS INTEGER.
DEFINE VARIABLE v-nro_Cuenta              AS INTEGER.

DEFINE VARIABLE x-primero                 LIKE T-Valeinv_hd.cdg_imputacion.

DEFINE VARIABLE fecha_inicial             AS DATE.
DEFINE VARIABLE fecha_elegida             AS DATE.

DEFINE VARIABLE v-prox_docum              LIKE Parametro.cdg_parametro.

DEFINE VARIABLE rid_tabla                 AS ROWID.

DEFINE VARIABLE que_empresa               LIKE Empresa.cdg_empresa.
DEFINE VARIABLE que_sector                LIKE Area.cdg_area.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME BROWSE-11

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Valeinv_dt Articulo Partida T-Valeinv_hd

/* Definitions for BROWSE BROWSE-11                                     */
&Scoped-define FIELDS-IN-QUERY-BROWSE-11 T-Valeinv_dt.nro_linea ~
Articulo.cdg_articulo Articulo.descripcion T-Valeinv_dt.cantidad ~
T-Valeinv_dt.granel Articulo.cdg_umed Partida.cdg_partida ~
T-Valeinv_dt.observacion 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-11 
&Scoped-define QUERY-STRING-BROWSE-11 FOR EACH T-Valeinv_dt OF T-Valeinv_hd NO-LOCK, ~
      EACH Articulo OF T-Valeinv_dt NO-LOCK, ~
      EACH Partida OF T-Valeinv_dt NO-LOCK
&Scoped-define OPEN-QUERY-BROWSE-11 OPEN QUERY BROWSE-11 FOR EACH T-Valeinv_dt OF T-Valeinv_hd NO-LOCK, ~
      EACH Articulo OF T-Valeinv_dt NO-LOCK, ~
      EACH Partida OF T-Valeinv_dt NO-LOCK.
&Scoped-define TABLES-IN-QUERY-BROWSE-11 T-Valeinv_dt Articulo Partida
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-11 T-Valeinv_dt
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-11 Articulo
&Scoped-define THIRD-TABLE-IN-QUERY-BROWSE-11 Partida


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define FIELDS-IN-QUERY-DEFAULT-FRAME T-Valeinv_hd.tip_comprob ~
T-Valeinv_hd.prf_comprob T-Valeinv_hd.nro_comprob ~
T-Valeinv_hd.cdg_imputacion T-Valeinv_hd.fecha 
&Scoped-define ENABLED-FIELDS-IN-QUERY-DEFAULT-FRAME ~
T-Valeinv_hd.tip_comprob T-Valeinv_hd.prf_comprob T-Valeinv_hd.nro_comprob ~
T-Valeinv_hd.fecha 
&Scoped-define ENABLED-TABLES-IN-QUERY-DEFAULT-FRAME T-Valeinv_hd
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-DEFAULT-FRAME T-Valeinv_hd
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-BROWSE-11}
&Scoped-define QUERY-STRING-DEFAULT-FRAME FOR EACH T-Valeinv_hd SHARE-LOCK
&Scoped-define OPEN-QUERY-DEFAULT-FRAME OPEN QUERY DEFAULT-FRAME FOR EACH T-Valeinv_hd SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-DEFAULT-FRAME T-Valeinv_hd
&Scoped-define FIRST-TABLE-IN-QUERY-DEFAULT-FRAME T-Valeinv_hd


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS T-Valeinv_hd.tip_comprob ~
T-Valeinv_hd.prf_comprob T-Valeinv_hd.nro_comprob T-Valeinv_hd.fecha 
&Scoped-define ENABLED-TABLES T-Valeinv_hd
&Scoped-define FIRST-ENABLED-TABLE T-Valeinv_hd
&Scoped-Define ENABLED-OBJECTS Btn_salir BROWSE-11 RECT-2 RECT-3 RECT-4 ~
RECT-5 RECT-6 
&Scoped-Define DISPLAYED-FIELDS T-Valeinv_hd.tip_comprob ~
T-Valeinv_hd.prf_comprob T-Valeinv_hd.nro_comprob ~
T-Valeinv_hd.cdg_imputacion T-Valeinv_hd.fecha 
&Scoped-define DISPLAYED-TABLES T-Valeinv_hd
&Scoped-define FIRST-DISPLAYED-TABLE T-Valeinv_hd
&Scoped-Define DISPLAYED-OBJECTS v-cdg_articulo v-anulado v-comprobante 

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
     LABEL "&Observaciones" 
     SIZE 21 BY 1.33.

DEFINE BUTTON btn_porclasificacion 
     LABEL "Buscar X &Clasificación" 
     SIZE 28 BY 1.

DEFINE BUTTON Btn_salir DEFAULT 
     LABEL "&Salir" 
     SIZE 21 BY 1.33
     BGCOLOR 8 .

DEFINE BUTTON btn_verimputacion 
     LABEL "Ver &Asiento" 
     SIZE 21 BY 1.19.

DEFINE VARIABLE v-anulado AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 21 BY 1
     FGCOLOR 12 FONT 6 NO-UNDO.

DEFINE VARIABLE v-cdg_articulo AS CHARACTER FORMAT "X(18)":U 
     LABEL "Artículo" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 29 BY 1
     BGCOLOR 14 FGCOLOR 12 FONT 6 NO-UNDO.

DEFINE VARIABLE v-comprobante AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 32 BY 1
     FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 134 BY 1.86.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 23 BY 1.86.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 133 BY 1.67.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 156 BY 1.43.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 23 BY 1.67.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-11 FOR 
      T-Valeinv_dt, 
      Articulo, 
      Partida SCROLLING.

DEFINE QUERY DEFAULT-FRAME FOR 
      T-Valeinv_hd SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-11
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-11 C-Win _STRUCTURED
  QUERY BROWSE-11 NO-LOCK DISPLAY
      T-Valeinv_dt.nro_linea COLUMN-LABEL "Li-!nea" FORMAT ">>9":U
      Articulo.cdg_articulo FORMAT "X(12)":U WIDTH 18.8
      Articulo.descripcion FORMAT "X(27)":U WIDTH 40.2
      T-Valeinv_dt.cantidad COLUMN-LABEL "Cantidad!Variación" FORMAT "->,>>>,>>9.99":U
      T-Valeinv_dt.granel COLUMN-LABEL "Granel!Variación" FORMAT "->>,>>9.99":U
      Articulo.cdg_umed FORMAT "X(12)":U
      Partida.cdg_partida FORMAT "X(8)":U
      T-Valeinv_dt.observacion COLUMN-LABEL "Observacion!del movimiento" FORMAT "X(25)":U
            WIDTH 39.8
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 156 BY 20.48
         BGCOLOR 15 FGCOLOR 9 
         TITLE BGCOLOR 15 FGCOLOR 9 "Detalle de Articulos involucrados en el movimiento" EXPANDABLE.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btn_copiar AT ROW 1.48 COL 26
     btn_cancel AT ROW 1.48 COL 48
     btn_anular AT ROW 1.48 COL 70
     btn_observ AT ROW 1.48 COL 92
     btn_imprim AT ROW 1.48 COL 114
     Btn_salir AT ROW 1.48 COL 137
     btn_grabar AT ROW 1.52 COL 4
     T-Valeinv_hd.tip_comprob AT ROW 3.38 COL 13 COLON-ALIGNED
          LABEL "Vale"
          VIEW-AS FILL-IN 
          SIZE 6 BY 1
          BGCOLOR 7 FGCOLOR 15 
     T-Valeinv_hd.prf_comprob AT ROW 3.38 COL 20 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 7 BY 1
          BGCOLOR 7 FGCOLOR 15 
     T-Valeinv_hd.nro_comprob AT ROW 3.38 COL 28 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 14 BY 1
          BGCOLOR 7 FGCOLOR 15 
     T-Valeinv_hd.cdg_imputacion AT ROW 3.38 COL 57 COLON-ALIGNED
          LABEL "Imputación"
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "0",1
          DROP-DOWN-LIST
          SIZE 53 BY 1
          BGCOLOR 15 FGCOLOR 9 FONT 4
     T-Valeinv_hd.fecha AT ROW 3.38 COL 119 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 13.8 BY 1
          BGCOLOR 15 FGCOLOR 9 
     btn_verimputacion AT ROW 3.38 COL 137
     v-cdg_articulo AT ROW 5.29 COL 13 COLON-ALIGNED
     btn_porclasificacion AT ROW 5.29 COL 50
     v-anulado AT ROW 5.29 COL 89 COLON-ALIGNED NO-LABEL
     v-comprobante AT ROW 5.29 COL 123 COLON-ALIGNED NO-LABEL
     BROWSE-11 AT ROW 6.71 COL 3
     RECT-2 AT ROW 1.24 COL 3
     RECT-3 AT ROW 1.24 COL 136
     RECT-4 AT ROW 3.14 COL 3
     RECT-5 AT ROW 5.05 COL 3
     RECT-6 AT ROW 3.14 COL 136
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 159 BY 27.24.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Partida T "?" NO-UNDO sic Partida
      ADDITIONAL-FIELDS:
          FIELD es_nueva AS LOGICAL
      END-FIELDS.
      TABLE: T-Registrable T "?" NO-UNDO sic Registrable
      ADDITIONAL-FIELDS:
          FIELD es_nuevo AS LOGICAL
      END-FIELDS.
      TABLE: T-Registrable_vale T "?" NO-UNDO sic Registrable_vale
      TABLE: T-Sub_detalle_inv T "?" NO-UNDO sic Sub_detalle_inv
      TABLE: T-Sub_header_inv T "?" NO-UNDO sic Sub_header_inv
      TABLE: T-Valeinv_dt T "?" NO-UNDO sic Valeinv_dt
      TABLE: T-Valeinv_hd T "?" NO-UNDO sic Valeinv_hd
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Vale de Inventario"
         HEIGHT             = 27.24
         WIDTH              = 159.2
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
/* BROWSE-TAB BROWSE-11 v-comprobante DEFAULT-FRAME */
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
/* SETTINGS FOR BUTTON btn_verimputacion IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX T-Valeinv_hd.cdg_imputacion IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN T-Valeinv_hd.tip_comprob IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN v-anulado IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_articulo IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-comprobante IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-11
/* Query rebuild information for BROWSE BROWSE-11
     _TblList          = "Temp-Tables.T-Valeinv_dt OF Temp-Tables.T-Valeinv_hd,sic.Articulo OF Temp-Tables.T-Valeinv_dt,sic.Partida OF Temp-Tables.T-Valeinv_dt"
     _Options          = "NO-LOCK"
     _FldNameList[1]   > Temp-Tables.T-Valeinv_dt.nro_linea
"T-Valeinv_dt.nro_linea" "Li-!nea" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[2]   > sic.Articulo.cdg_articulo
"Articulo.cdg_articulo" ? ? "character" ? ? ? ? ? ? no ? no no "18.8" yes no no "U" "" ""
     _FldNameList[3]   > sic.Articulo.descripcion
"Articulo.descripcion" ? "X(27)" "character" ? ? ? ? ? ? no ? no no "40.2" yes no no "U" "" ""
     _FldNameList[4]   > Temp-Tables.T-Valeinv_dt.cantidad
"T-Valeinv_dt.cantidad" "Cantidad!Variación" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[5]   > Temp-Tables.T-Valeinv_dt.granel
"T-Valeinv_dt.granel" "Granel!Variación" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[6]   = sic.Articulo.cdg_umed
     _FldNameList[7]   = sic.Partida.cdg_partida
     _FldNameList[8]   > Temp-Tables.T-Valeinv_dt.observacion
"T-Valeinv_dt.observacion" "Observacion!del movimiento" "X(25)" "character" ? ? ? ? ? ? no ? no no "39.8" yes no no "U" "" ""
     _Query            is OPENED
*/  /* BROWSE BROWSE-11 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME DEFAULT-FRAME
/* Query rebuild information for FRAME DEFAULT-FRAME
     _TblList          = "Temp-Tables.T-Valeinv_hd"
     _Query            is OPENED
*/  /* FRAME DEFAULT-FRAME */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Vale de Inventario */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Vale de Inventario */
DO:
  /* This event will close the window and terminate the procedure.  */
  /* APPLY "CLOSE":U TO THIS-PROCEDURE. */
  APPLY "CHOOSE":U TO Btn_salir IN FRAME {&FRAME-NAME}.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-11
&Scoped-define SELF-NAME BROWSE-11
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-11 C-Win
ON DELETE-CHARACTER OF BROWSE-11 IN FRAME DEFAULT-FRAME /* Detalle de Articulos involucrados en el movimiento */
DO:
    IF modo = MD_ALTA
    THEN DO:
        sino-msg = NO.
        MESSAGE "Desea eliminar este renglón de detalle?" 
                VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
        IF sino-msg
        THEN DO:
             DELETE T-Valeinv_dt.
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-11 C-Win
ON MOUSE-SELECT-DBLCLICK OF BROWSE-11 IN FRAME DEFAULT-FRAME /* Detalle de Articulos involucrados en el movimiento */
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
    MESSAGE "Desea ANULAR este Vale de Ingreso" 
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
    IF sino-msg
    THEN DO:
         RUN anular_vale_inventario.p (INPUT ROWID(Valeinv_hd), OUTPUT pudo_anular).
         IF pudo_anular = 0
         THEN DO:
             DO TRANSACTION:
                 RUN borrar_tablas_temporales.
             END.
             MESSAGE "El Vale de Ingreso ha sido anulado" 
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

  RUN d-seleccionar_valeinventario.w (INPUT-OUTPUT rid_factura).
  IF rid_factura <> ?
  THEN DO:
     FIND Valeinv_hd WHERE ROWID(Valeinv_hd) = rid_factura NO-LOCK.
     DISPLAY Valeinv_hd.tip_comprob @ T-Valeinv_hd.tip_comprob 
             Valeinv_hd.prf_comprob @ T-Valeinv_hd.prf_comprob
             Valeinv_hd.nro_comprob @ T-Valeinv_hd.nro_comprob
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
         T-Valeinv_hd.fecha
         T-Valeinv_hd.cdg_imputacion .
         
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
    MESSAGE "Desea REIMPRIMIR este vale?" 
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
    IF sino-msg
    THEN DO:
         RUN imprimir_vale_inventario.p (ROWID(Valeinv_hd)).
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_observ
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_observ C-Win
ON CHOOSE OF btn_observ IN FRAME DEFAULT-FRAME /* Observaciones */
DO:

   DEFINE VARIABLE puso_ok AS LOGICAL.
   RUN c-edttexto.w ( INPUT-OUTPUT T-Valeinv_hd.leyenda,
                      INPUT "Leyenda del Vale de Inventario",
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

  RUN d-selarticulosxclase.w ( INPUT-OUTPUT que_clase,
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


&Scoped-define SELF-NAME btn_verimputacion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_verimputacion C-Win
ON CHOOSE OF btn_verimputacion IN FRAME DEFAULT-FRAME /* Ver Asiento */
DO:
  RUN d-ver_imputacion_valeinv.w ( INPUT TABLE  T-Sub_header_inv, 
                                   INPUT TABLE  T-Sub_detalle_inv).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Valeinv_hd.nro_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Valeinv_hd.nro_comprob C-Win
ON MOUSE-SELECT-DBLCLICK OF T-Valeinv_hd.nro_comprob IN FRAME DEFAULT-FRAME /* nro_comprob */
OR MOUSE-MENU-DOWN,"." OF T-Valeinv_hd.nro_comprob IN FRAME {&FRAME-NAME}
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
          lista_estados = "P,E".
     END.
     WHEN MD_EMISION        
     THEN DO:
          titulo_window = "Selección de " + Tipocomprobante.titulo_window.
          lista_estados = "".
     END.
  END CASE.     

  RUN d-selvale_inventario.w (INPUT titulo_window, INPUT lista_estados, INPUT Tipocomprobante.tip_comprob, INPUT-OUTPUT rid_factura).
  IF rid_factura <> ?
  THEN DO:
     FIND Valeinv_hd WHERE ROWID(Valeinv_hd) = rid_factura NO-LOCK.
     DISPLAY Valeinv_hd.tip_comprob @ T-Valeinv_hd.tip_comprob 
             Valeinv_hd.prf_comprob @ T-Valeinv_hd.prf_comprob
             Valeinv_hd.nro_comprob @ T-Valeinv_hd.nro_comprob
             WITH FRAME {&FRAME-NAME}.
     IF modo = MD_ANULACION AND Valeinv_hd.anulado
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Valeinv_hd.nro_comprob C-Win
ON RETURN OF T-Valeinv_hd.nro_comprob IN FRAME DEFAULT-FRAME /* nro_comprob */
DO:

   IF LOOKUP(INPUT FRAME {&FRAME-NAME} T-Valeinv_hd.tip_comprob,"VI,VS") = 0 
   THEN DO:
      RUN PONMENSJ.P (INPUT "DOCS010").
      RETURN NO-APPLY.
   END.

   FIND Valeinv_hd 
        WHERE Valeinv_hd.cdg_empresa = Empresa.cdg_empresa
          AND Valeinv_hd.tip_comprob = INPUT T-Valeinv_hd.tip_comprob 
          AND Valeinv_hd.prf_comprob = INPUT T-Valeinv_hd.prf_comprob
          AND Valeinv_hd.nro_comprob = INPUT T-Valeinv_hd.nro_comprob
              NO-ERROR.

   IF NOT AVAILABLE Valeinv_hd 
   THEN DO:
        IF LOCKED Valeinv_hd
           THEN RUN PONMENSJ.P (INPUT "DOCS000").
           ELSE RUN PONMENSJ.P (INPUT "DOCS001").
        RETURN NO-APPLY.
   END.
   ELSE DO:
        rid_factura = ROWID(Valeinv_hd).
        RUN traer_documento.
   END.
  
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
                   "I",
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
   
   DISPLAY " " @ v-cdg_articulo
           WITH FRAME {&FRAME-NAME}.
   APPLY "ENTRY" TO v-cdg_articulo  IN FRAME {&FRAME-NAME}.
   RETURN NO-APPLY.

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

{findsector.i}
que_sector = Area.cdg_area.

RUN carga_comprobante.
RUN carga_conceptos.

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
  IF modo = MD_ALTA THEN APPLY "ENTRY" TO v-cdg_articulo.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE borrar_tablas_temporales C-Win 
PROCEDURE borrar_tablas_temporales :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    EMPTY TEMP-TABLE T-Valeinv_hd.
    EMPTY TEMP-TABLE T-Valeinv_dt.
    EMPTY TEMP-TABLE T-Registrable_vale.
    EMPTY TEMP-TABLE T-Sub_header_inv.
    EMPTY TEMP-TABLE T-Sub_detalle_inv.

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

  EMPTY TEMP-TABLE T-Sub_header_inv.
  EMPTY TEMP-TABLE T-Sub_detalle_inv.

  RUN calcular_vale_inventario.p ( INPUT-OUTPUT TABLE T-Valeinv_hd,
                                   INPUT-OUTPUT TABLE T-Valeinv_dt,
                                   INPUT-OUTPUT TABLE T-Sub_header_inv,
                                   INPUT-OUTPUT TABLE T-Sub_detalle_inv).
                         
  FIND FIRST T-Valeinv_hd.
/*
  DISPLAY T-Fac_header.imp_neto 
          T-Fac_header.imp_total
          WITH FRAME {&FRAME-NAME}.
*/          
  btn_verimputacion:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
  {&OPEN-QUERY-{&BROWSE-NAME}}

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

    FIND Tipocomprobante 
        WHERE Tipocomprobante.cdg_empresa     = que_empresa
          AND Tipocomprobante.cdg_comprobante = p-cdg_comprobante
               NO-LOCK NO-ERROR.

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

        FIND Tipocomprobante 
            WHERE Tipocomprobante.cdg_empresa     = que_empresa
              AND Tipocomprobante.cdg_comprobante = "VALEININ" 
                  NO-LOCK NO-ERROR.

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
    
           ASSIGN
              v-nombre_comprobante  = "VALE DE INVENTARIO "
              v-fgcolor_comprobante = 9
              v-bgcolor_comprobante = 15
              v-primera_letra       = "F*"
              v-prefijo_contador    = "PRF*".
           
    
       END.
    END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE carga_conceptos C-Win 
PROCEDURE carga_conceptos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   DEFINE VARIABLE lOK      AS LOGICAL.
   DEFINE VARIABLE x-listas AS CHARACTER.

   {findempresa.i}
   x-listas = "".
   x-primero = ?.
   FOR EACH Comprobante_concepto OF Tipocomprobante
       WHERE Comprobante_concepto.cdg_empresa = Empresa.cdg_empresa, Imputacion OF Comprobante_concepto:
       x-listas = x-listas + "," + Imputacion.dsc_imputacion + "," + STRING(Imputacion.cdg_imputacion).
       IF x-primero = ? THEN x-primero = Imputacion.cdg_imputacion.
   END.
   IF x-listas <> ""
   THEN DO:
       x-listas = SUBSTRING(x-listas,2).
       T-Valeinv_hd.cdg_imputacion:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = x-listas.
   END.
   ELSE DO:
       MESSAGE "No se han definido conceptos para el comprobante actual" VIEW-AS ALERT-BOX ERROR TITLE "ERROR DE IMPLEMENTACIÓN".
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

    RUN d-detalle_valeinv.w ( INPUT-OUTPUT TABLE T-Valeinv_hd,
                              INPUT-OUTPUT TABLE T-Valeinv_dt,
                              INPUT-OUTPUT TABLE T-Partida,
                              INPUT-OUTPUT TABLE T-Registrable,
                              INPUT-OUTPUT TABLE T-Registrable_vale,
                              INPUT T-Valeinv_dt.nro_articulo,
                              INPUT T-Valeinv_dt.nro_linea,
                              INPUT modo,
                              INPUT 1,
                              OUTPUT v-nro_linea).

    FIND FIRST T-Valeinv_hd.
    IF v-nro_linea <> 0
    THEN DO:
         {&OPEN-QUERY-{&BROWSE-NAME}}
         RUN calculos.
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

    RUN d-detalle_valeinv.w ( INPUT-OUTPUT TABLE T-Valeinv_hd,
                              INPUT-OUTPUT TABLE T-Valeinv_dt,
                              INPUT-OUTPUT TABLE T-Partida,
                              INPUT-OUTPUT TABLE T-Registrable,
                              INPUT-OUTPUT TABLE T-Registrable_vale,
                              INPUT  Articulo.nro_articulo,
                              INPUT  0, /* No sabemos el nro de linea */
                              INPUT  modo,
                              INPUT  0, /* modo detalle = CREAR */
                              OUTPUT v-nro_linea).

    IF v-nro_linea <> 0
    THEN DO:
        RUN calculos.
        {&OPEN-QUERY-{&BROWSE-NAME}}
        T-Valeinv_hd.cdg_imputacion:SENSITIVE IN FRAME {&FRAME-NAME}  = NO.         
        btn_copiar:SENSITIVE IN FRAME {&FRAME-NAME}        = NO.
        btn_verimputacion:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
    END.
    ELSE DO:
        FIND FIRST T-Valeinv_hd.
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
    
      CREATE T-Valeinv_hd.
      ASSIGN T-Valeinv_hd.cdg_comprobante = Tipocomprobante.cdg_comprobante 
             T-Valeinv_hd.nro_usuario     = Usuario.nro_usuario 
             T-Valeinv_hd.cdg_empresa     = Empresa.cdg_empresa
             T-Valeinv_hd.fecha           = TODAY 
             T-Valeinv_hd.tip_comprob     = Tipocomprobante.tip_comprob 
             T-Valeinv_hd.nro_valeinv     = 0  
             T-Valeinv_hd.estado          = "E"  
             T-Valeinv_hd.nro_comprob     = T-Valeinv_hd.nro_valeinv
             T-Valeinv_hd.prf_comprob     = 0
             T-Valeinv_hd.cdg_imputacion  = x-primero
             /*                           
             T-Valeinv_hd.nro_moneda      = Moneda.nro_moneda 
             T-Valeinv_hd.cambio          = Moneda.cambio  
             v-cdg_moneda                 = Moneda.cdg_moneda
             v-dsc_moneda                 = Moneda.descripcion
             
             v-cdg_imputacion             = Imputacion.cdg_imputacion
             v-dsc_imputacion             = Imputacion.dsc_imputacion 
             */                           
             T-Valeinv_hd.num_sucursal    = sucursal-id    
             T-Valeinv_hd.origen          = "M".

  END.

  DISPLAY
         T-Valeinv_hd.fecha   
         v-comprobante
         T-Valeinv_hd.cdg_imputacion
         /*
         v-cdg_imputacion
         v-dsc_imputacion
         v-cdg_moneda
         v-dsc_moneda      
         v-cdg_deposito
         v-dsc_deposito 
         */
         
         WITH FRAME {&FRAME-NAME}.

  codigo_salir = ?.

  IF    modo = MD_MULTIPLE
     OR modo = MD_ANULACION
     OR modo = MD_EMISION
  THEN DO:
       DO WITH FRAME {&FRAME-NAME}:
          T-Valeinv_hd.tip_comprob:FGCOLOR = 9.
          T-Valeinv_hd.tip_comprob:BGCOLOR = 15.

          T-Valeinv_hd.prf_comprob:FGCOLOR = 9.
          T-Valeinv_hd.prf_comprob:BGCOLOR = 15.

          T-Valeinv_hd.nro_comprob:FGCOLOR = 9.
          T-Valeinv_hd.nro_comprob:BGCOLOR = 15.
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
  DISPLAY v-cdg_articulo v-anulado v-comprobante 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE T-Valeinv_hd THEN 
    DISPLAY T-Valeinv_hd.tip_comprob T-Valeinv_hd.prf_comprob 
          T-Valeinv_hd.nro_comprob T-Valeinv_hd.cdg_imputacion 
          T-Valeinv_hd.fecha 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE Btn_salir T-Valeinv_hd.tip_comprob T-Valeinv_hd.prf_comprob 
         T-Valeinv_hd.nro_comprob T-Valeinv_hd.fecha BROWSE-11 RECT-2 RECT-3 
         RECT-4 RECT-5 RECT-6 
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
                  T-Valeinv_hd.tip_comprob:SENSITIVE        = NO
                  T-Valeinv_hd.prf_comprob:SENSITIVE        = NO
                  T-Valeinv_hd.nro_comprob:SENSITIVE        = NO
                  T-Valeinv_hd.fecha:SENSITIVE              = NO
                  T-Valeinv_hd.cdg_imputacion:SENSITIVE     = NO
                  v-cdg_articulo:SENSITIVE                  = NO
                  btn_porclasificacion:SENSITIVE            = NO
                  btn_verimputacion:SENSITIVE               = NO.
     END.
     ELSE DO:

            RUN frame_sensitiva ( INPUT NO ).

            CASE modo:
       
                WHEN MD_ALTA          
                THEN DO:

                     ASSIGN
                        btn_grabar:SENSITIVE                      = YES
                        btn_cancel:SENSITIVE                      = YES
                        btn_observ:SENSITIVE                      = YES
                        btn_imprim:SENSITIVE                      = YES
                        v-cdg_articulo:SENSITIVE                  = YES
                        T-Valeinv_hd.fecha:SENSITIVE              = YES
                        T-Valeinv_hd.cdg_imputacion:SENSITIVE     = YES
                        btn_porclasificacion:SENSITIVE            = YES.
         
                END.
                WHEN MD_MULTIPLE      
                THEN DO:
                     ASSIGN
                        T-Valeinv_hd.tip_comprob:SENSITIVE        = YES
                        T-Valeinv_hd.prf_comprob:SENSITIVE        = YES
                        T-Valeinv_hd.nro_comprob:SENSITIVE        = YES.

                END.
                WHEN MD_DEFINIDA      
                THEN DO:
                     ASSIGN
                        btn_verimputacion:SENSITIVE               = YES.
         
                END.
                WHEN MD_RELACION      
                THEN DO:
                     ASSIGN
                        btn_verimputacion:SENSITIVE               = YES.
         
                END.
                WHEN MD_READONLY      
                THEN DO:
                     ASSIGN
                        btn_verimputacion:SENSITIVE               = YES.
         
                END.
                WHEN MD_CAMBIO        
                THEN DO:
                     ASSIGN
                        btn_verimputacion:SENSITIVE               = YES.

                END.
                WHEN MD_ANULACION        
                THEN DO:
                     ASSIGN
                        btn_verimputacion:SENSITIVE               = YES
                        T-Valeinv_hd.tip_comprob:SENSITIVE        = YES
                        T-Valeinv_hd.prf_comprob:SENSITIVE        = YES
                        T-Valeinv_hd.nro_comprob:SENSITIVE        = YES.
                END.
                WHEN MD_EMISION        
                THEN DO:
                     ASSIGN
                        btn_verimputacion:SENSITIVE               = YES
                        T-Valeinv_hd.tip_comprob:SENSITIVE        = YES
                        T-Valeinv_hd.prf_comprob:SENSITIVE        = YES
                        T-Valeinv_hd.nro_comprob:SENSITIVE        = YES.
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
    
       RUN emitir_vale_inventario.p ( 
                              INPUT TABLE T-Valeinv_hd,
                              INPUT TABLE T-Valeinv_dt,
                              INPUT TABLE T-Registrable_vale,
                              INPUT TABLE T-Sub_header_inv,
                              INPUT TABLE T-Sub_detalle_inv ).
       
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
          btn_grabar:SENSITIVE                      = NO
          btn_copiar:SENSITIVE                      = NO
          btn_cancel:SENSITIVE                      = NO
          btn_anular:SENSITIVE                      = NO
          btn_observ:SENSITIVE                      = NO
          btn_imprim:SENSITIVE                      = NO
          T-Valeinv_hd.tip_comprob:SENSITIVE        = NO
          T-Valeinv_hd.prf_comprob:SENSITIVE        = NO
          T-Valeinv_hd.nro_comprob:SENSITIVE        = NO
          T-Valeinv_hd.fecha:SENSITIVE              = NO
          T-Valeinv_hd.cdg_imputacion:SENSITIVE     = NO
          v-cdg_articulo:SENSITIVE                  = NO
          btn_porclasificacion:SENSITIVE            = NO
          btn_verimputacion:SENSITIVE               = NO.

     CASE modo:

       WHEN MD_ALTA          
       THEN DO:
            ASSIGN
                btn_cancel:SENSITIVE                      = YES
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES
                v-cdg_articulo:SENSITIVE                  = YES
                T-Valeinv_hd.fecha:SENSITIVE              = YES
                T-Valeinv_hd.cdg_imputacion:SENSITIVE     = YES
                btn_porclasificacion:SENSITIVE            = YES
                btn_verimputacion:SENSITIVE               = YES.
       END.
       WHEN MD_MULTIPLE      
       THEN DO:
            ASSIGN
                btn_cancel:SENSITIVE                      = YES
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES
                btn_verimputacion:SENSITIVE               = YES.
       END.
       WHEN MD_DEFINIDA      
       THEN DO:
            ASSIGN
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES
                btn_verimputacion:SENSITIVE               = YES.
       END.
       WHEN MD_RELACION      
       THEN DO:
            ASSIGN
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES
                btn_verimputacion:SENSITIVE               = YES.
       END.
       WHEN MD_READONLY      
       THEN DO:
            ASSIGN
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES
                btn_verimputacion:SENSITIVE               = YES.
       END.
       WHEN MD_CAMBIO        
       THEN DO:
            ASSIGN
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES
                btn_verimputacion:SENSITIVE               = YES.
       END.
       WHEN MD_ANULACION        
       THEN DO:
            ASSIGN
                btn_anular:SENSITIVE                      = YES
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES
                btn_verimputacion:SENSITIVE               = YES.
       END.
       WHEN MD_EMISION        
       THEN DO:
            ASSIGN
                btn_grabar:SENSITIVE                      = YES
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES
                btn_verimputacion:SENSITIVE               = YES.

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

   /*
   RUN getparametro.p (  INPUT  "DFDEPOSI",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).
   FIND Deposito WHERE Deposito.cdg_deposito = v-valor_c 
                       NO-LOCK.
   act_deposito = ROWID(Deposito).
   */
   
   RUN titulo_window ( INPUT Tipocomprobante.titulo_window ).           

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

 {&WINDOW-NAME}:TITLE = "DYNASYS/INV " + NRO_RELEASE + " - " + Usuario.cdg_empresa + " - " + v-txtitulo + " User:" + USERID("sic").

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

   FIND Valeinv_hd WHERE ROWID(Valeinv_hd) = rid_factura NO-LOCK.
   BUFFER-COPY Valeinv_hd TO T-Valeinv_hd.

   FOR EACH Valeinv_dt OF Valeinv_hd:
       CREATE T-Valeinv_dt.
       BUFFER-COPY Valeinv_dt TO T-Valeinv_dt.
   END.    

   FIND Sub_header_inv 
        WHERE Sub_header_inv.cdg_empresa = Valeinv_hd.cdg_empresa
          AND Sub_header_inv.tip_comprob = Valeinv_hd.tip_comprob
          AND Sub_header_inv.prf_comprob = Valeinv_hd.prf_comprob
          AND Sub_header_inv.nro_comprob = Valeinv_hd.nro_comprob
              NO-LOCK NO-ERROR.
   IF AVAILABLE Sub_header_inv
   THEN DO:
        CREATE T-Sub_header_inv.
        BUFFER-COPY Sub_header_inv TO T-Sub_header_inv.           
     
        FOR EACH Sub_detalle_inv 
             WHERE Sub_detalle_inv.cdg_empresa = Sub_header_inv.cdg_empresa
               AND Sub_detalle_inv.tip_comprob = Sub_header_inv.tip_comprob
               AND Sub_detalle_inv.prf_comprob = Sub_header_inv.prf_comprob
               AND Sub_detalle_inv.nro_comprob = Sub_header_inv.nro_comprob
                   NO-LOCK.
     
            CREATE T-Sub_detalle_inv.
            BUFFER-COPY Sub_detalle_inv TO T-Sub_detalle_inv.           
     
        END.
   END.
   
   v-anulado = IF Valeinv_hd.anulado THEN "ANULADA" ELSE "".

   DISPLAY
        T-Valeinv_hd.fecha 
        T-Valeinv_hd.nro_comprob 
        T-Valeinv_hd.prf_comprob 
        T-Valeinv_hd.tip_comprob 
        T-Valeinv_hd.cdg_imputacion 
        v-anulado
        WITH FRAME {&FRAME-NAME}.

   {&OPEN-QUERY-{&BROWSE-NAME}}
       
   RUN habilitar_campos ( INPUT YES ).
   RUN calculos.

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

  DEFINE OUTPUT PARAMETER p-error AS LOGICAL.

  p-error = NO.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

