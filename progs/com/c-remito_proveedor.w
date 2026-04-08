&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win

/* Temp-Table and Buffer definitions                                    */
DEFINE NEW SHARED TEMP-TABLE T-Rem_detalle_prv NO-UNDO LIKE Rem_detalle_prv.
DEFINE NEW SHARED TEMP-TABLE T-Rem_header_prv NO-UNDO LIKE Rem_header_prv.
DEFINE NEW SHARED TEMP-TABLE T-Sub_detalle_inv NO-UNDO LIKE Sub_detalle_inv.
DEFINE NEW SHARED TEMP-TABLE T-Sub_header_inv NO-UNDO LIKE Sub_header_inv.


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
DEFINE VARIABLE                rid_remprov    AS ROWID.
DEFINE VARIABLE                modo           AS INTEGER.
DEFINE VARIABLE                p-cdg_comprobante  AS CHARACTER.
&ELSE
DEFINE INPUT-OUTPUT PARAMETER  rid_remprov    AS ROWID.
DEFINE INPUT        PARAMETER  modo           AS INTEGER.
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
DEFINE VARIABLE st_seleccionado           AS CHARACTER.

DEFINE VARIABLE v-prox_docum              LIKE Parametro.cdg_parametro INITIAL "PROXNASN".
DEFINE VARIABLE v-debito                  AS CHARACTER FORMAT "X(14)".
DEFINE VARIABLE v-credito                 AS CHARACTER FORMAT "X(14)".

DEFINE VARIABLE rid_tabla                 AS ROWID.

DEFINE VARIABLE v-nro_linea               AS INTEGER.
DEFINE VARIABLE v-nro_cuenta              AS INTEGER.
DEFINE VARIABLE aux_importe               AS DECIMAL.
DEFINE VARIABLE codigo_iva                AS INTEGER INITIAL 1.
DEFINE VARIABLE hay_canje                 AS LOGICAL.
DEFINE VARIABLE que_empresa               LIKE Empresa.cdg_empresa.
DEFINE VARIABLE v-nombre_comprobante      AS CHARACTER.
DEFINE VARIABLE v-fgcolor_comprobante     AS INTEGER.
DEFINE VARIABLE v-bgcolor_comprobante     AS INTEGER.
DEFINE VARIABLE v-primera_letra           AS CHARACTER.
DEFINE VARIABLE v-prefijo_contador        AS CHARACTER.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME BROWSE-6

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Rem_detalle_prv Articulo Partida ~
T-Rem_header_prv

/* Definitions for BROWSE BROWSE-6                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-6 T-Rem_detalle_prv.nro_linea ~
Articulo.cdg_articulo Articulo.descripcion Partida.cdg_partida ~
Articulo.cdg_umed T-Rem_detalle_prv.cantidad T-Rem_detalle_prv.granel 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-6 
&Scoped-define QUERY-STRING-BROWSE-6 FOR EACH T-Rem_detalle_prv OF T-Rem_header_prv NO-LOCK, ~
      EACH Articulo OF T-Rem_detalle_prv NO-LOCK, ~
      EACH Partida OF T-Rem_detalle_prv NO-LOCK
&Scoped-define OPEN-QUERY-BROWSE-6 OPEN QUERY BROWSE-6 FOR EACH T-Rem_detalle_prv OF T-Rem_header_prv NO-LOCK, ~
      EACH Articulo OF T-Rem_detalle_prv NO-LOCK, ~
      EACH Partida OF T-Rem_detalle_prv NO-LOCK.
&Scoped-define TABLES-IN-QUERY-BROWSE-6 T-Rem_detalle_prv Articulo Partida
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-6 T-Rem_detalle_prv
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-6 Articulo
&Scoped-define THIRD-TABLE-IN-QUERY-BROWSE-6 Partida


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define FIELDS-IN-QUERY-DEFAULT-FRAME T-Rem_header_prv.tip_comprob ~
T-Rem_header_prv.prf_comprob T-Rem_header_prv.nro_comprob ~
T-Rem_header_prv.fecha 
&Scoped-define ENABLED-FIELDS-IN-QUERY-DEFAULT-FRAME ~
T-Rem_header_prv.prf_comprob T-Rem_header_prv.nro_comprob ~
T-Rem_header_prv.fecha 
&Scoped-define ENABLED-TABLES-IN-QUERY-DEFAULT-FRAME T-Rem_header_prv
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-DEFAULT-FRAME T-Rem_header_prv
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-BROWSE-6}
&Scoped-define QUERY-STRING-DEFAULT-FRAME FOR EACH T-Rem_header_prv SHARE-LOCK
&Scoped-define OPEN-QUERY-DEFAULT-FRAME OPEN QUERY DEFAULT-FRAME FOR EACH T-Rem_header_prv SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-DEFAULT-FRAME T-Rem_header_prv
&Scoped-define FIRST-TABLE-IN-QUERY-DEFAULT-FRAME T-Rem_header_prv


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS T-Rem_header_prv.prf_comprob ~
T-Rem_header_prv.nro_comprob T-Rem_header_prv.fecha 
&Scoped-define ENABLED-TABLES T-Rem_header_prv
&Scoped-define FIRST-ENABLED-TABLE T-Rem_header_prv
&Scoped-Define ENABLED-OBJECTS Btn_salir BROWSE-6 RECT-2 RECT-3 RECT-4 ~
RECT-5 
&Scoped-Define DISPLAYED-FIELDS T-Rem_header_prv.tip_comprob ~
T-Rem_header_prv.prf_comprob T-Rem_header_prv.nro_comprob ~
T-Rem_header_prv.fecha 
&Scoped-define DISPLAYED-TABLES T-Rem_header_prv
&Scoped-define FIRST-DISPLAYED-TABLE T-Rem_header_prv
&Scoped-Define DISPLAYED-OBJECTS v-anulado v-comprobante v-cdg_deposito ~
v-dsc_deposito v-cdg_proveedor v-dsc_proveedor v-cdg_imputacion ~
v-dsc_imputacion v-cdg_domicilio v-dsc_domicilio v-cdg_articulo 

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
     SIZE 46 BY 1.

DEFINE BUTTON Btn_salir DEFAULT 
     LABEL "&Salir" 
     SIZE 21 BY 1.33
     BGCOLOR 8 .

DEFINE BUTTON btn_verimputacion 
     LABEL "Ver &Imputación Contable" 
     SIZE 54.2 BY 1.

DEFINE VARIABLE v-anulado AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     FGCOLOR 12 FONT 6 NO-UNDO.

DEFINE VARIABLE v-cdg_articulo AS CHARACTER FORMAT "X(10)":U 
     LABEL "Artículo" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 18 BY 1
     BGCOLOR 14 FGCOLOR 12 FONT 6 NO-UNDO.

DEFINE VARIABLE v-cdg_deposito AS CHARACTER FORMAT "X(8)" INITIAL "0" 
     LABEL "Depósito" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 11.6 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_domicilio AS INTEGER FORMAT ">>>>>>9" INITIAL 0 
     LABEL "Domicilio" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 17 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_imputacion AS INTEGER FORMAT ">>9" INITIAL 90 
     LABEL "Imputación" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 11.6 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_proveedor AS CHARACTER FORMAT "X(8)" 
     LABEL "Proveedor" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 17 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-comprobante AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 31 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE v-dsc_deposito AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 41.8 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_domicilio AS CHARACTER FORMAT "X(40)" 
     VIEW-AS FILL-IN 
     SIZE 47 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_imputacion AS CHARACTER FORMAT "X(30)" 
     VIEW-AS FILL-IN 
     SIZE 41.8 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_proveedor AS CHARACTER FORMAT "X(40)" 
     VIEW-AS FILL-IN 
     SIZE 47 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 133 BY 1.86.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 23 BY 1.86.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 156 BY 4.52.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 156 BY 2.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-6 FOR 
      T-Rem_detalle_prv, 
      Articulo, 
      Partida SCROLLING.

DEFINE QUERY DEFAULT-FRAME FOR 
      T-Rem_header_prv SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-6
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-6 C-Win _STRUCTURED
  QUERY BROWSE-6 NO-LOCK DISPLAY
      T-Rem_detalle_prv.nro_linea FORMAT ">>9":U WIDTH 8.2
      Articulo.cdg_articulo FORMAT "X(12)":U WIDTH 25.2
      Articulo.descripcion FORMAT "X(53)":U WIDTH 56.2
      Partida.cdg_partida FORMAT "X(8)":U WIDTH 13.4
      Articulo.cdg_umed FORMAT "X(12)":U
      T-Rem_detalle_prv.cantidad FORMAT "->,>>>,>>9.99":U WIDTH 16.4
      T-Rem_detalle_prv.granel FORMAT "->>,>>9.99":U WIDTH 14.2
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 156 BY 15.1
         BGCOLOR 15 FGCOLOR 9 
         TITLE BGCOLOR 15 FGCOLOR 9 "Artículos".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btn_grabar AT ROW 1.48 COL 4
     btn_copiar AT ROW 1.48 COL 26
     btn_cancel AT ROW 1.48 COL 48
     btn_anular AT ROW 1.48 COL 70
     btn_observ AT ROW 1.48 COL 92
     btn_imprim AT ROW 1.48 COL 114
     Btn_salir AT ROW 1.48 COL 137
     T-Rem_header_prv.tip_comprob AT ROW 3.62 COL 17 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 6.8 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Rem_header_prv.prf_comprob AT ROW 3.62 COL 24 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 9.8 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Rem_header_prv.nro_comprob AT ROW 3.62 COL 35 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 14.8 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Rem_header_prv.fecha AT ROW 3.62 COL 65 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 16.8 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-anulado AT ROW 3.62 COL 100 COLON-ALIGNED NO-LABEL
     v-comprobante AT ROW 3.62 COL 124 COLON-ALIGNED NO-LABEL
     v-cdg_deposito AT ROW 4.81 COL 100 COLON-ALIGNED
     v-dsc_deposito AT ROW 4.81 COL 113 COLON-ALIGNED NO-LABEL
     v-cdg_proveedor AT ROW 4.86 COL 17 COLON-ALIGNED
     v-dsc_proveedor AT ROW 4.86 COL 35 COLON-ALIGNED NO-LABEL
     v-cdg_imputacion AT ROW 6.24 COL 100 COLON-ALIGNED
     v-dsc_imputacion AT ROW 6.24 COL 113 COLON-ALIGNED NO-LABEL
     v-cdg_domicilio AT ROW 6.29 COL 17 COLON-ALIGNED
     v-dsc_domicilio AT ROW 6.29 COL 35 COLON-ALIGNED NO-LABEL
     v-cdg_articulo AT ROW 8.62 COL 17 COLON-ALIGNED
     btn_porclasificacion AT ROW 8.62 COL 38
     btn_verimputacion AT ROW 8.62 COL 102
     BROWSE-6 AT ROW 10.29 COL 3
     RECT-2 AT ROW 1.29 COL 3
     RECT-3 AT ROW 1.24 COL 136
     RECT-4 AT ROW 3.38 COL 3
     RECT-5 AT ROW 8.14 COL 3
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.2 ROW 1
         SIZE 159 BY 27.14.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Rem_detalle_prv T "NEW SHARED" NO-UNDO sic Rem_detalle_prv
      TABLE: T-Rem_header_prv T "NEW SHARED" NO-UNDO sic Rem_header_prv
      TABLE: T-Sub_detalle_inv T "NEW SHARED" NO-UNDO sic Sub_detalle_inv
      TABLE: T-Sub_header_inv T "NEW SHARED" NO-UNDO sic Sub_header_inv
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Remitos de Proveedores"
         HEIGHT             = 25.91
         WIDTH              = 160
         MAX-HEIGHT         = 28.62
         MAX-WIDTH          = 160
         VIRTUAL-HEIGHT     = 28.62
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
/* BROWSE-TAB BROWSE-6 btn_verimputacion DEFAULT-FRAME */
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
/* SETTINGS FOR FILL-IN T-Rem_header_prv.tip_comprob IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-anulado IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_articulo IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_deposito IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_domicilio IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_imputacion IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_proveedor IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-comprobante IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_deposito IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_domicilio IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_imputacion IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_proveedor IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-6
/* Query rebuild information for BROWSE BROWSE-6
     _TblList          = "Temp-Tables.T-Rem_detalle_prv OF Temp-Tables.T-Rem_header_prv,sic.Articulo OF Temp-Tables.T-Rem_detalle_prv,sic.Partida OF Temp-Tables.T-Rem_detalle_prv"
     _Options          = "NO-LOCK"
     _FldNameList[1]   > Temp-Tables.T-Rem_detalle_prv.nro_linea
"T-Rem_detalle_prv.nro_linea" ? ? "integer" ? ? ? ? ? ? no ? no no "8.2" yes no no "U" "" ""
     _FldNameList[2]   > sic.Articulo.cdg_articulo
"Articulo.cdg_articulo" ? ? "character" ? ? ? ? ? ? no ? no no "25.2" yes no no "U" "" ""
     _FldNameList[3]   > sic.Articulo.descripcion
"Articulo.descripcion" ? "X(53)" "character" ? ? ? ? ? ? no ? no no "56.2" yes no no "U" "" ""
     _FldNameList[4]   > sic.Partida.cdg_partida
"Partida.cdg_partida" ? ? "character" ? ? ? ? ? ? no ? no no "13.4" yes no no "U" "" ""
     _FldNameList[5]   = sic.Articulo.cdg_umed
     _FldNameList[6]   > Temp-Tables.T-Rem_detalle_prv.cantidad
"T-Rem_detalle_prv.cantidad" ? ? "decimal" ? ? ? ? ? ? no ? no no "16.4" yes no no "U" "" ""
     _FldNameList[7]   > Temp-Tables.T-Rem_detalle_prv.granel
"T-Rem_detalle_prv.granel" ? ? "decimal" ? ? ? ? ? ? no ? no no "14.2" yes no no "U" "" ""
     _Query            is OPENED
*/  /* BROWSE BROWSE-6 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME DEFAULT-FRAME
/* Query rebuild information for FRAME DEFAULT-FRAME
     _TblList          = "Temp-Tables.T-Rem_header_prv"
     _Query            is OPENED
*/  /* FRAME DEFAULT-FRAME */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Remitos de Proveedores */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Remitos de Proveedores */
DO:
  /* This event will close the window and terminate the procedure.  */
  /* APPLY "CLOSE":U TO THIS-PROCEDURE. */
  APPLY "CHOOSE":U TO Btn_salir IN FRAME {&FRAME-NAME}.
  RETURN NO-APPLY.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-6
&Scoped-define SELF-NAME BROWSE-6
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-6 C-Win
ON DELETE-CHARACTER OF BROWSE-6 IN FRAME DEFAULT-FRAME /* Artículos */
DO:
    IF modo = MD_ALTA
    THEN DO:
        sino-msg = NO.
        MESSAGE "Desea eliminar este renglón de detalle?" 
                VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
        IF sino-msg
        THEN DO:
             DELETE T-Rem_detalle_prv.
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-6 C-Win
ON MOUSE-SELECT-DBLCLICK OF BROWSE-6 IN FRAME DEFAULT-FRAME /* Artículos */
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
    MESSAGE "Desea ANULAR este remito" 
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
    IF sino-msg
    THEN DO:
         RUN anular_remprov.p (INPUT ROWID(Rem_header_prv), OUTPUT pudo_anular).
         IF pudo_anular = 0
         THEN DO:
              DO TRANSACTION:
                    FOR EACH T-Rem_detalle_prv:
                        DELETE T-Rem_detalle_prv.
                    END.
            
                    FOR EACH T-Rem_header_prv:
                        DELETE T-Rem_header_prv.
                    END.
            
                    FOR EACH T-Sub_detalle_inv:
                        DELETE T-Sub_detalle_inv.
                    END.
            
                    FOR EACH T-Sub_header_inv:
                        DELETE T-Sub_header_inv.
                    END.
              END.
              MESSAGE "El remito ha sido anulado" 
                      VIEW-AS ALERT-BOX MESSAGE TITLE "Aviso".

              ASSIGN codigo_salir = CD_GRABAR.
              APPLY "U1":U TO THIS-PROCEDURE.   
         END.
            ELSE MESSAGE "No se puede anular, el remito ya ha salido" 
            VIEW-AS ALERT-BOX MESSAGE TITLE "Aviso".

         
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

  RUN d-seleccionar_remprov.w (INPUT-OUTPUT rid_remprov).
  IF rid_remprov <> ?
  THEN DO:
     FIND Rem_header_prv WHERE ROWID(Rem_header_prv) = rid_remprov NO-LOCK.
     DISPLAY Rem_header_prv.tip_comprob @ T-Rem_header_prv.tip_comprob 
             Rem_header_prv.prf_comprob @ T-Rem_header_prv.prf_comprob
             Rem_header_prv.nro_comprob @ T-Rem_header_prv.nro_comprob
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
         T-Rem_header_prv.nro_comprob 
         T-Rem_header_prv.prf_comprob 
         T-Rem_header_prv.tip_comprob
         T-Rem_header_prv.fecha.
                  
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
    MESSAGE "Desea REIMPRIMIR este remito de proveedor" 
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
    IF sino-msg
    THEN DO:
         RUN imprimir_remprov.p (ROWID(Rem_header_prv)).
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_observ
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_observ C-Win
ON CHOOSE OF btn_observ IN FRAME DEFAULT-FRAME /* Leyenda */
DO:

   DEFINE VARIABLE puso_ok AS LOGICAL.
   RUN c-edttexto.w ( INPUT-OUTPUT T-Rem_header_prv.leyenda,
                      INPUT "Observaciones del Remito de Proveedor",
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
  RUN d-selclase_articulos.w ( INPUT-OUTPUT que_clase,
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
ON CHOOSE OF btn_verimputacion IN FRAME DEFAULT-FRAME /* Ver Imputación Contable */
DO:
  RUN d-ver_imputacion_remprov.w.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Rem_header_prv.nro_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Rem_header_prv.nro_comprob C-Win
ON MOUSE-SELECT-DBLCLICK OF T-Rem_header_prv.nro_comprob IN FRAME DEFAULT-FRAME /* nro_comprob */
OR MOUSE-MENU-DOWN,"." OF T-Rem_header_prv.nro_comprob IN FRAME {&FRAME-NAME}
DO:
  DEFINE VARIABLE lista_estados AS CHARACTER.
  DEFINE VARIABLE titulo_window AS CHARACTER.

  CASE modo:
     WHEN MD_ALTA          
     THEN DO:
          titulo_window = "".     /* Esta opcion la contemlamos por unicidad pero no debería producirse nunca */
          lista_estados = "".
     END.
     WHEN MD_MULTIPLE      
     THEN DO:
          titulo_window = "Selección de Remitos de Proveedores en General".
          lista_estados = " ,E".
     END.
     WHEN MD_DEFINIDA             /* Esta opcion la contemlamos por unicidad pero no debería producirse nunca */
     THEN DO:
          titulo_window = "".
          lista_estados = "Consulta Individual de Remitos de Proveedores".
     END.
     WHEN MD_RELACION             /* Esta opcion la contemlamos por unicidad pero no debería producirse nunca */
     THEN DO:
          titulo_window = "".
          lista_estados = "".
     END.
     WHEN MD_READONLY      
     THEN DO:
          titulo_window = "Selección de Remitos de Proveedores en General".
          lista_estados = " ,E".
     END.
     WHEN MD_CAMBIO        
     THEN DO:
          titulo_window = "".
          lista_estados = "".
     END.
     WHEN MD_ANULACION        
     THEN DO:
          titulo_window = "Selección de Remitos de Proveedores Emitidas".
          lista_estados = "E".
     END.
     WHEN MD_EMISION        
     THEN DO:
          titulo_window = "Selección de Remitos de Proveedores Pendientes".
          lista_estados = " ".
     END.
  END CASE.     

  RUN d-seleccionar_remprov.w (INPUT titulo_window, INPUT lista_estados, INPUT-OUTPUT rid_remprov).
  IF rid_remprov <> ?
  THEN DO:
      FIND Rem_header_prv WHERE ROWID(Rem_header_prv) = rid_remprov NO-LOCK NO-ERROR.
     DISPLAY Rem_header_prv.tip_comprob @ T-Rem_header_prv.tip_comprob 
             Rem_header_prv.prf_comprob @ T-Rem_header_prv.prf_comprob
             Rem_header_prv.nro_comprob @ T-Rem_header_prv.nro_comprob
             WITH FRAME {&FRAME-NAME}.
     RUN traer_documento.
  END.  
  RETURN NO-APPLY.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Rem_header_prv.nro_comprob C-Win
ON RETURN OF T-Rem_header_prv.nro_comprob IN FRAME DEFAULT-FRAME /* nro_comprob */
DO:

   IF LOOKUP( INPUT FRAME {&FRAME-NAME} T-Rem_header_prv.tip_comprob,"RP") = 0 AND 
   LOOKUP( INPUT FRAME {&FRAME-NAME} T-Rem_header_prv.tip_comprob,"RM") = 0
       THEN DO:
      RUN PONMENSJ.P (INPUT "DOCS010").
      RETURN NO-APPLY.
   END.

   FIND Rem_header_prv 
        WHERE Rem_header_prv.cdg_empresa = Empresa.cdg_empresa
          AND Rem_header_prv.tip_comprob = INPUT T-Rem_header_prv.tip_comprob 
          AND Rem_header_prv.prf_comprob = INPUT T-Rem_header_prv.prf_comprob
          AND Rem_header_prv.nro_comprob = INPUT T-Rem_header_prv.nro_comprob NO-LOCK NO-ERROR.
/*           AND Rem_header_prv.anulado = NO NO-LOCK NO-ERROR.  */

   IF NOT AVAILABLE Rem_header_prv 
   THEN DO:
        IF LOCKED Rem_header_prv
           THEN RUN PONMENSJ.P (INPUT "DOCS000").
           ELSE RUN PONMENSJ.P (INPUT "DOCS001").
        RETURN NO-APPLY.
   END.
   ELSE DO:
        rid_remprov = ROWID(Rem_header_prv).
        RUN traer_documento.
   END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Rem_header_prv.prf_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Rem_header_prv.prf_comprob C-Win
ON MOUSE-SELECT-DBLCLICK OF T-Rem_header_prv.prf_comprob IN FRAME DEFAULT-FRAME /* prf_comprob */
OR MOUSE-MENU-DOWN,"." OF T-Rem_header_prv.prf_comprob IN FRAME {&FRAME-NAME}
DO:
  APPLY "MOUSE-SELECT-DBLCLICK" TO T-Rem_header_prv.tip_comprob IN FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Rem_header_prv.tip_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Rem_header_prv.tip_comprob C-Win
ON LEAVE OF T-Rem_header_prv.tip_comprob IN FRAME DEFAULT-FRAME /* Tipo */
DO:
   T-Rem_header_prv.tip_comprob:SCREEN-VALUE IN FRAME {&FRAME-NAME} = 
           CAPS(T-Rem_header_prv.tip_comprob:SCREEN-VALUE IN FRAME {&FRAME-NAME}).

   IF LOOKUP( INPUT FRAME {&FRAME-NAME} T-Rem_header_prv.tip_comprob,"RP") = 0 AND
   LOOKUP( INPUT FRAME {&FRAME-NAME} T-Rem_header_prv.tip_comprob,"RM") = 0
       THEN DO:
      RUN PONMENSJ.P (INPUT "DOCS010").
      RETURN NO-APPLY.
   END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Rem_header_prv.tip_comprob C-Win
ON MOUSE-SELECT-DBLCLICK OF T-Rem_header_prv.tip_comprob IN FRAME DEFAULT-FRAME /* Tipo */
OR MOUSE-MENU-DOWN,"." OF T-Rem_header_prv.tip_comprob IN FRAME {&FRAME-NAME}
DO:
  APPLY "MOUSE-SELECT-DBLCLICK" TO T-Rem_header_prv.tip_comprob IN FRAME {&FRAME-NAME}.
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
                   "C",
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


&Scoped-define SELF-NAME v-cdg_deposito
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_deposito C-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_deposito IN FRAME DEFAULT-FRAME /* Depósito */
OR "." OF v-cdg_deposito IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_deposito IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Deposito" "cdg_deposito" "SELDEPOS.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_deposito C-Win
ON RETURN OF v-cdg_deposito IN FRAME DEFAULT-FRAME /* Depósito */
DO:
   {traducetabla.i "Deposito" "cdg_deposito" "nombre"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_imputacion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_imputacion C-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_imputacion IN FRAME DEFAULT-FRAME /* Imputación */
OR "." OF v-cdg_imputacion IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_imputacion IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "imputacion" "cdg_imputacion" "SELCNDOC.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_imputacion C-Win
ON RETURN OF v-cdg_imputacion IN FRAME DEFAULT-FRAME /* Imputación */
DO:
   &SCOPED-DEFINE PONER-TABLA RUN asignar_imputacion.

   {traducetabla.i "imputacion" "cdg_imputacion" "dsc_imputacion"} 

   &UNDEFINE PONER-TABLA
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_proveedor
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_proveedor C-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_proveedor IN FRAME DEFAULT-FRAME /* Proveedor */
OR "." OF v-cdg_proveedor IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_proveedor IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "proveedor" "cdg_proveedor" "SELPROVE.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_proveedor C-Win
ON RETURN OF v-cdg_proveedor IN FRAME DEFAULT-FRAME /* Proveedor */
DO:
   &SCOPED-DEFINE PONER-TABLA RUN poner_proveedor.
   {traducetabla.i "proveedor" "cdg_proveedor" "nombre"} 
   &UNDEFINE PONER-TABLA
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

RUN carga_comprobante.

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE asignar_imputacion C-Win 
PROCEDURE asignar_imputacion :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  T-Rem_header_prv.cdg_imputacion = Imputacion.cdg_imputacion.
  T-Rem_header_prv.cta_cte        = Imputacion.cta_cte.

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

    EMPTY TEMP-TABLE T-Rem_header_prv.
    EMPTY TEMP-TABLE T-Rem_detalle_prv.
    EMPTY TEMP-TABLE T-Sub_detalle_inv.
    EMPTY TEMP-TABLE T-Sub_header_inv.

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

  IF AVAILABLE T-Sub_header_inv
  THEN DO:
     FOR EACH T-Sub_detalle_inv:
         DELETE T-Sub_detalle_inv.
     END.    
     DELETE T-Sub_header_inv.
  END.

  { calcularemprov.i "T-"}

  btn_verimputacion:SENSITIVE IN FRAME {&FRAME-NAME} = YES.

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

     RUN d-detalle_remprov.w ( INPUT T-Rem_detalle_prv.nro_articulo,
                               INPUT T-Rem_detalle_prv.nro_linea,
                               INPUT modo,
                               INPUT 1,
                               OUTPUT v-nro_linea).

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

    RUN d-detalle_remprov.w ( INPUT  Articulo.nro_articulo,
                              INPUT  0, /* No sabemos el nro de linea */
                              INPUT  modo,
                              INPUT  0, /* modo detalle = CREAR */
                              OUTPUT v-nro_linea).
    IF v-nro_linea <> 0
    THEN DO:
         {&OPEN-QUERY-{&BROWSE-NAME}}
         RUN calculos.
         btn_copiar:SENSITIVE IN FRAME {&FRAME-NAME}        = NO.
         btn_verimputacion:SENSITIVE IN FRAME {&FRAME-NAME} = YES.

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
    
      CREATE T-Rem_header_prv.
      ASSIGN T-Rem_header_prv.cdg_comprobante = Tipocomprobante.cdg_comprobante 
             T-Rem_header_prv.nro_usuario     = Usuario.nro_usuario 
             T-Rem_header_prv.cdg_empresa     = Empresa.cdg_empresa
             T-Rem_header_prv.fecha           = TODAY 
             T-Rem_header_prv.cdg_empresa     = Empresa.cdg_empresa 
             T-Rem_header_prv.tip_comprob     = "RP" 
             T-Rem_header_prv.nro_remprov     = 0  
             T-Rem_header_prv.estado          = "E"  
             T-Rem_header_prv.nro_comprob     = T-Rem_header_prv.nro_remprov
             T-Rem_header_prv.prf_comprob     = 0
             T-Rem_header_prv.nro_moneda      = Moneda.nro_moneda 
             T-Rem_header_prv.cambio          = Moneda.cambio  
             T-Rem_header_prv.cdg_imputacion  = Imputacion.cdg_imputacion
             T-Rem_header_prv.cta_cte         = Imputacion.cta_cte
             T-Rem_header_prv.num_sucursal    = sucursal-id    
             T-Rem_header_prv.origen          = "M"
             T-Rem_header_prv.nro_deposito    = Deposito.nro_deposito 
             v-cdg_deposito                   = Deposito.cdg_deposito
             v-dsc_deposito                   = Deposito.nombre 
             v-cdg_imputacion                 = Imputacion.cdg_imputacion
             v-dsc_imputacion                 = Imputacion.dsc_imputacion. 
  END.

  DISPLAY
         T-Rem_header_prv.fecha   
         v-cdg_imputacion
         v-dsc_imputacion
         v-cdg_deposito
         v-dsc_deposito
         v-comprobante
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
  DISPLAY v-anulado v-comprobante v-cdg_deposito v-dsc_deposito v-cdg_proveedor 
          v-dsc_proveedor v-cdg_imputacion v-dsc_imputacion v-cdg_domicilio 
          v-dsc_domicilio v-cdg_articulo 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE T-Rem_header_prv THEN 
    DISPLAY T-Rem_header_prv.tip_comprob T-Rem_header_prv.prf_comprob 
          T-Rem_header_prv.nro_comprob T-Rem_header_prv.fecha 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE Btn_salir T-Rem_header_prv.prf_comprob T-Rem_header_prv.nro_comprob 
         T-Rem_header_prv.fecha BROWSE-6 RECT-2 RECT-3 RECT-4 RECT-5 
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

    ASSIGN
          btn_grabar:SENSITIVE                      = NO
          btn_copiar:SENSITIVE                      = NO
          btn_cancel:SENSITIVE                      = NO
          btn_anular:SENSITIVE                      = NO
          btn_observ:SENSITIVE                      = NO
          btn_imprim:SENSITIVE                      = NO
          T-Rem_header_prv.tip_comprob:SENSITIVE    = NO
          T-Rem_header_prv.prf_comprob:SENSITIVE    = NO
          T-Rem_header_prv.nro_comprob:SENSITIVE    = NO
          T-Rem_header_prv.fecha:SENSITIVE          = NO
          v-cdg_articulo:SENSITIVE                  = NO
          v-cdg_domicilio:SENSITIVE                 = NO
          v-cdg_deposito:SENSITIVE                  = NO
          v-cdg_imputacion:SENSITIVE                = NO
          v-cdg_proveedor:SENSITIVE                 = NO
          btn_porclasificacion:SENSITIVE            = NO
          btn_verimputacion:SENSITIVE               = NO.

     CASE modo:
 
          WHEN MD_ALTA          
          THEN DO:
               ASSIGN
                  v-cdg_proveedor:SENSITIVE                 = YES.
   
          END.
          WHEN MD_MULTIPLE      
          THEN DO:
               ASSIGN
                  T-Rem_header_prv.tip_comprob:SENSITIVE    = YES
                  T-Rem_header_prv.prf_comprob:SENSITIVE    = YES
                  T-Rem_header_prv.nro_comprob:SENSITIVE    = YES.
          END.
          WHEN MD_DEFINIDA      
          THEN DO:
                  /* Nada Habiltado */         
          END.
          WHEN MD_RELACION      
          THEN DO:
                  /* Nada Habiltado */         
   
          END.
          WHEN MD_READONLY      
          THEN DO:
                  /* Nada Habiltado */         
   
          END.
          WHEN MD_CAMBIO        
          THEN DO:
                  /* Nada Habiltado */         
          END.
          WHEN MD_ANULACION        
          THEN DO:
               ASSIGN
                  T-Rem_header_prv.tip_comprob:SENSITIVE    = YES
                  T-Rem_header_prv.prf_comprob:SENSITIVE    = YES
                  T-Rem_header_prv.nro_comprob:SENSITIVE    = YES.         
          END.
          WHEN MD_EMISION        
          THEN DO:
               ASSIGN
                  T-Rem_header_prv.tip_comprob:SENSITIVE    = YES
                  T-Rem_header_prv.prf_comprob:SENSITIVE    = YES
                  T-Rem_header_prv.nro_comprob:SENSITIVE    = YES.
          END.
 
     END CASE.     
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
    
       CREATE Rem_header_prv.
       BUFFER-COPY T-Rem_header_prv TO Rem_header_prv
           ASSIGN  Rem_header_prv.nro_remprov = NEXT-VALUE(proxima_transaccion).
  
       FOR EACH T-Rem_detalle_prv:
           CREATE Rem_detalle_prv.
           BUFFER-COPY T-Rem_detalle_prv TO Rem_detalle_prv
               ASSIGN  Rem_detalle_prv.nro_remprov = Rem_header_prv.nro_remprov.
           DELETE T-Rem_detalle_prv.
       END.

       RUN emitir_remprov.p ( ROWID(Rem_header_prv)).

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
        btn_grabar:SENSITIVE                      = NO
        btn_copiar:SENSITIVE                      = NO
        btn_cancel:SENSITIVE                      = NO
        btn_anular:SENSITIVE                      = NO
        btn_observ:SENSITIVE                      = NO
        btn_imprim:SENSITIVE                      = NO
        T-Rem_header_prv.tip_comprob:SENSITIVE    = NO
        T-Rem_header_prv.prf_comprob:SENSITIVE    = NO
        T-Rem_header_prv.nro_comprob:SENSITIVE    = NO
        T-Rem_header_prv.fecha:SENSITIVE          = NO
        v-cdg_articulo:SENSITIVE                  = NO
        v-cdg_domicilio:SENSITIVE                 = NO
        v-cdg_imputacion:SENSITIVE                = NO
        v-cdg_proveedor:SENSITIVE                 = NO
        btn_porclasificacion:SENSITIVE            = NO
        btn_verimputacion:SENSITIVE               = NO.

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
                btn_cancel:SENSITIVE                      = YES
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
    
    
    RUN getparametro.p (  INPUT  "DFMONEDA",
                          OUTPUT v-valor_c,
                          OUTPUT v-valor_d,
                          OUTPUT v-valor_l,
                          OUTPUT v-valor_n,
                          OUTPUT v-observacion ).
    FIND Moneda WHERE Moneda.cdg_moneda = v-valor_c NO-LOCK NO-ERROR.
    IF AVAILABLE Moneda THEN
      act_moneda = ROWID(Moneda).
    
    RUN getparametro.p (  INPUT  "DFDEPOSI",
                          OUTPUT v-valor_c,
                          OUTPUT v-valor_d,
                          OUTPUT v-valor_l,
                          OUTPUT v-valor_n,
                          OUTPUT v-observacion ).
    FIND Deposito WHERE Deposito.cdg_deposito = v-valor_c NO-LOCK NO-ERROR.
    IF AVAILABLE Deposito THEN
        act_deposito = ROWID(Deposito).
    
   
    /*---------------- Depende del Proveedor-------------------------------------------*/
    
    RUN getparametro.p (  INPUT "DFCNRPRV",
                          OUTPUT v-valor_c,
                          OUTPUT v-valor_d,
                          OUTPUT v-valor_l,
                          OUTPUT v-valor_n,
                          OUTPUT v-observacion ).
    
    FIND Imputacion WHERE Imputacion.cdg_imputacion = v-valor_n NO-LOCK NO-ERROR.
    IF AVAILABLE Imputacion THEN DO:
        act_imputacion = ROWID(Imputacion).
            FIND Cuenta OF Imputacion NO-LOCK NO-ERROR.
            IF AVAILABLE Cuenta THEN act_cuenta = ROWID(Cuenta).
    END.
    /*---------------------------------------------------------------------------------*/

    RUN titulo_window ( INPUT Tipocomprobante.titulo_window ).           

/*     RUN titulo_window ( INPUT "Remitos de Proveedores" ).  */
/*  {setwintit.i "SIC/BDU" "Anulación de Remitos de Proveedores"}  */
  /*  {titulowindow.i "SIC/COM" "Remitos de Proveedores"}  */

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

  FIND Condicion_venta WHERE Condicion_venta.cdg_cndventa = Proveedor.dfl_cndventa NO-LOCK.

  FIND Familia_proveedor OF Proveedor NO-LOCK.
 /* FIND Imputacion WHERE Imputacion.cdg_imputacion = Familia_proveedor.cdg_imputacompr NO-LOCK. */
  
  FIND Condicion_impos   OF Proveedor NO-LOCK.
  v-tip_comprob = "F" + Condicion_impos.tipo_factura.
  
  ASSIGN
      T-Rem_header_prv.cdg_condiva          = Condicion_impos.cdg_condiva
      T-Rem_header_prv.nro_cndventa         = Condicion_venta.nro_cndventa
      T-Rem_header_prv.nombre               = Proveedor.nombre
      T-Rem_header_prv.cuit                 = Proveedor.cuit
      T-Rem_header_prv.nro_proveedor        = Proveedor.nro_proveedor.

  RUN traer_proveedor.
  RUN traer_imputacion.
  
  DISPLAY  v-cdg_proveedor 
           v-dsc_proveedor

           v-cdg_imputacion
           v-dsc_imputacion

           WITH FRAME {&FRAME-NAME}.
           
   DO WITH FRAME {&FRAME-NAME}:
      ASSIGN
         btn_grabar:SENSITIVE                      = YES
         btn_copiar:SENSITIVE                      = YES
         btn_cancel:SENSITIVE                      = YES
         btn_anular:SENSITIVE                      = NO
         btn_observ:SENSITIVE                      = YES
         btn_imprim:SENSITIVE                      = NO
         T-Rem_header_prv.tip_comprob:SENSITIVE    = YES
         T-Rem_header_prv.prf_comprob:SENSITIVE    = YES
         T-Rem_header_prv.nro_comprob:SENSITIVE    = YES
         T-Rem_header_prv.fecha:SENSITIVE          = YES
         v-cdg_articulo:SENSITIVE                  = YES
         v-cdg_domicilio:SENSITIVE                 = YES
         v-cdg_deposito:SENSITIVE                  = YES
         v-cdg_imputacion:SENSITIVE                = YES
         v-cdg_proveedor:SENSITIVE                 = NO
         btn_porclasificacion:SENSITIVE            = YES
         btn_verimputacion:SENSITIVE               = YES.
   END. 

   FIND Domicilio_prv OF Proveedor NO-LOCK NO-ERROR.
   IF AVAILABLE Domicilio_prv 
   THEN DO:
      FIND Provincia OF Domicilio_prv NO-LOCK.
      ASSIGN  T-Rem_header_prv.nro_domicilio = Domicilio_prv.nro_domicilio
              T-Rem_header_prv.direccion     = Domicilio_prv.direccion
              T-Rem_header_prv.cdg_provincia = Domicilio_prv.cdg_provincia
              T-Rem_header_prv.localidad     = Domicilio_prv.localidad
              T-Rem_header_prv.cdg_postal    = Domicilio_prv.cdg_postal
              T-Rem_header_prv.cdg_zonag     = Domicilio_prv.cdg_zonag
              v-cdg_domicilio                = Domicilio_prv.nro_domicilio
              v-dsc_domicilio                = Domicilio_prv.nombre.
      DISPLAY v-cdg_domicilio
              v-dsc_domicilio
              WITH FRAME {&FRAME-NAME}.
      DISABLE v-cdg_domicilio WITH FRAME {&FRAME-NAME}.      
   END.
   ELSE DO:  /* No hay ninguno o hay mas de uno */
      ASSIGN  T-Rem_header_prv.nro_domicilio = 0
              T-Rem_header_prv.direccion     = ""
              T-Rem_header_prv.cdg_provincia = ""
              T-Rem_header_prv.localidad     = ""
              T-Rem_header_prv.cdg_postal    = ""
              T-Rem_header_prv.cdg_zonag     = ""
              v-cdg_domicilio                = 0
              v-dsc_domicilio                = "".
      DISPLAY v-cdg_domicilio
              v-dsc_domicilio
              WITH FRAME {&FRAME-NAME}.
      ENABLE v-cdg_domicilio WITH FRAME {&FRAME-NAME}.
   END.   

   RUN CALCULOS.   

   APPLY "ENTRY" TO T-Rem_header_prv.tip_comprob IN FRAME {&FRAME-NAME}.

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

 {findsector.i}

 {&WINDOW-NAME}:TITLE = "DYNASYS/DSP " + NRO_RELEASE + " - " + Usuario.cdg_empresa + " - " + v-txtitulo + " User:" + USERID("sic") + " - " + Area.cdg_area.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_deposito C-Win 
PROCEDURE traer_deposito :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
   FIND Deposito OF T-Rem_header_prv NO-LOCK.
    ASSIGN
        v-cdg_deposito = Deposito.cdg_deposito
        v-dsc_deposito = Deposito.nombre.
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

   FIND Rem_header_prv WHERE ROWID(Rem_header_prv) = rid_remprov NO-LOCK.
   BUFFER-COPY Rem_header_prv TO T-Rem_header_prv.
   FOR EACH Rem_detalle_prv OF Rem_header_prv:
       CREATE T-Rem_detalle_prv.
       BUFFER-COPY Rem_detalle_prv TO T-Rem_detalle_prv.
   END.    

   v-anulado = IF Rem_header_prv.anulado THEN "ANULADO" ELSE "".

   FIND Sub_header_inv 
        WHERE Sub_header_inv.nro_proveedor = Rem_header_prv.nro_proveedor
          AND Sub_header_inv.cdg_empresa   = Rem_header_prv.cdg_empresa
          AND Sub_header_inv.tip_comprob   = Rem_header_prv.tip_comprob
          AND Sub_header_inv.prf_comprob   = Rem_header_prv.prf_comprob
          AND Sub_header_inv.nro_comprob   = Rem_header_prv.nro_comprob
              NO-LOCK NO-ERROR.
   IF AVAILABLE Sub_header_inv
   THEN DO:
        CREATE T-Sub_header_inv.
        BUFFER-COPY Sub_header_inv TO T-Sub_header_inv.           
     
        FOR EACH Sub_detalle_inv 
             WHERE Sub_detalle_inv.nro_proveedor = Sub_header_inv.nro_proveedor
               AND Sub_detalle_inv.cdg_empresa   = Sub_header_inv.cdg_empresa
               AND Sub_detalle_inv.tip_comprob   = Sub_header_inv.tip_comprob
               AND Sub_detalle_inv.prf_comprob   = Sub_header_inv.prf_comprob
               AND Sub_detalle_inv.nro_comprob   = Sub_header_inv.nro_comprob
                   NO-LOCK.
     
            CREATE T-Sub_detalle_inv.
            BUFFER-COPY Sub_detalle_inv TO T-Sub_detalle_inv.           
     
        END.
   END.

   RUN traer_tablas.
   
   DISPLAY

        T-Rem_header_prv.fecha 
        T-Rem_header_prv.nro_comprob 
        T-Rem_header_prv.prf_comprob 
        T-Rem_header_prv.tip_comprob 
        v-cdg_domicilio 
        v-cdg_deposito
        v-cdg_imputacion 
        v-cdg_proveedor 
        v-dsc_domicilio
        v-dsc_deposito
        v-dsc_imputacion 
        v-dsc_proveedor 
        v-anulado
        WITH FRAME {&FRAME-NAME}.

   {&OPEN-QUERY-{&BROWSE-NAME}}
   IF v-anulado = "" THEN
   RUN habilitar_campos ( INPUT YES ).
   
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_domicilio C-Win 
PROCEDURE traer_domicilio :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND Domicilio_prv OF T-Rem_header_prv NO-LOCK.
    ASSIGN
        v-cdg_domicilio = Domicilio_prv.nro_domicilio
        v-dsc_domicilio = Domicilio_prv.nombre.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_imputacion C-Win 
PROCEDURE traer_imputacion :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND Imputacion       OF T-Rem_header_prv NO-LOCK NO-ERROR.
    IF AVAILABLE Imputacion THEN DO:
    ASSIGN
        v-cdg_imputacion      = Imputacion.cdg_imputacion
        v-dsc_imputacion      = Imputacion.dsc_imputacion.
    END.
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

    FIND Proveedor OF T-Rem_header_prv NO-LOCK.
    ASSIGN
        v-cdg_proveedor = Proveedor.cdg_proveedor
        v-dsc_proveedor = Proveedor.nombre.
    
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

  RUN traer_imputacion.
  RUN traer_proveedor.
  RUN traer_domicilio.
  RUN traer_deposito.

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
  
    IF NOT CAN-FIND(FIRST T-Rem_detalle_prv OF  T-Rem_header_prv)
    THEN DO:
       RUN PONMENSJ.P (INPUT "FAPR005").
       RETURN.
    END.
  
    IF LOOKUP(INPUT FRAME {&FRAME-NAME} T-Rem_header_prv.tip_comprob,"RP") = 0
    THEN DO:
       RUN PONMENSJ.P (INPUT "FAPR022").
       RETURN.
    END.
  
    IF T-Rem_header_prv.prf_comprob:SCREEN-VALUE = ""
    THEN DO:
       RUN PONMENSJ.P (INPUT "FAPR023").
       RETURN.
    END.
  
    IF INPUT FRAME {&FRAME-NAME} T-Rem_header_prv.nro_comprob = 0
    THEN DO:
       RUN PONMENSJ.P (INPUT "FAPR024").
       RETURN.
    END.
  
   {validartabla.i "Imputacion"        "cdg_imputacion"  "dsc_imputacion" "FAPR031"}
   {validartabla.i "Deposito"          "cdg_deposito"    "nombre"         "FAPR031"}

   hubo_error = NO.

   &SCOPED-DEFINE TABLA-MAESTRA  T-Rem_header_prv
   {asignartabla.i "Imputacion"        "cdg_imputacion"  "cdg_imputacion"   }
   {asignartabla.i "Deposito"          "nro_deposito"    "nro_deposito"     }

   &UNDEFINE TABLA-MAESTRA


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

