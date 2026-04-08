&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame

/* Temp-Table and Buffer definitions                                    */
DEFINE SHARED TEMP-TABLE T-Ocm_detalle NO-UNDO LIKE Ocm_detalle.
DEFINE SHARED TEMP-TABLE T-Ocm_header NO-UNDO LIKE Ocm_header.


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
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

&IF DEFINED(UIB_is_Running) NE 0
&THEN
DEFINE VARIABLE           p-nro_articulo   LIKE Articulo.nro_articulo.
DEFINE VARIABLE           p-nro_linea-i    LIKE Asn_detalle.nro_linea.
DEFINE VARIABLE           p-modo-cabecera  AS INTEGER.
DEFINE VARIABLE           p-modo-detalle   AS INTEGER.
DEFINE VARIABLE           p-nro_linea-o    LIKE Asn_detalle.nro_linea.
&ELSE
DEFINE INPUT   PARAMETER  p-nro_articulo   LIKE Articulo.nro_articulo.
DEFINE INPUT   PARAMETER  p-nro_linea-i    LIKE Asn_detalle.nro_linea.
DEFINE INPUT   PARAMETER  p-modo-cabecera  AS INTEGER.
DEFINE INPUT   PARAMETER  p-modo-detalle   AS INTEGER.
DEFINE OUTPUT  PARAMETER  p-nro_linea-o    LIKE Asn_detalle.nro_linea.
&ENDIF

/* Local Variable Definitions ---                                       */

{valoresmodo.i}
{valoressalida.i}

DEFINE VARIABLE           rid_tabla       AS ROWID.
DEFINE VARIABLE           hubo_error      AS LOGICAL.
DEFINE VARIABLE           hay_obras       AS LOGICAL.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame
&Scoped-define BROWSE-NAME BROWSE-10

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Rem_detalle_prv Rem_header_prv T-Ocm_detalle

/* Definitions for BROWSE BROWSE-10                                     */
&Scoped-define FIELDS-IN-QUERY-BROWSE-10 Rem_header_prv.tip_comprob ~
Rem_header_prv.prf_comprob Rem_header_prv.nro_comprob Rem_header_prv.fecha ~
Rem_detalle_prv.cantidad Rem_detalle_prv.granel 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-10 
&Scoped-define QUERY-STRING-BROWSE-10 FOR EACH Rem_detalle_prv ~
      WHERE Rem_detalle_prv.nro_ocompra = T-Ocm_detalle.nro_ocompra ~
 AND Rem_detalle_prv.nro_linea_ocm = T-Ocm_detalle.nro_linea ~
 AND Rem_detalle_prv.nro_ocompra <> 0 NO-LOCK, ~
      EACH Rem_header_prv OF Rem_detalle_prv NO-LOCK
&Scoped-define OPEN-QUERY-BROWSE-10 OPEN QUERY BROWSE-10 FOR EACH Rem_detalle_prv ~
      WHERE Rem_detalle_prv.nro_ocompra = T-Ocm_detalle.nro_ocompra ~
 AND Rem_detalle_prv.nro_linea_ocm = T-Ocm_detalle.nro_linea ~
 AND Rem_detalle_prv.nro_ocompra <> 0 NO-LOCK, ~
      EACH Rem_header_prv OF Rem_detalle_prv NO-LOCK.
&Scoped-define TABLES-IN-QUERY-BROWSE-10 Rem_detalle_prv Rem_header_prv
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-10 Rem_detalle_prv
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-10 Rem_header_prv


/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define FIELDS-IN-QUERY-Dialog-Frame T-Ocm_detalle.cantidad ~
T-Ocm_detalle.granel T-Ocm_detalle.precio T-Ocm_detalle.fecha_temprana ~
T-Ocm_detalle.subtotal_bruto T-Ocm_detalle.cdg_estadoocm 
&Scoped-define ENABLED-FIELDS-IN-QUERY-Dialog-Frame T-Ocm_detalle.cantidad ~
T-Ocm_detalle.granel T-Ocm_detalle.precio T-Ocm_detalle.fecha_temprana 
&Scoped-define ENABLED-TABLES-IN-QUERY-Dialog-Frame T-Ocm_detalle
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-Dialog-Frame T-Ocm_detalle
&Scoped-define OPEN-BROWSERS-IN-QUERY-Dialog-Frame ~
    ~{&OPEN-QUERY-BROWSE-10}
&Scoped-define QUERY-STRING-Dialog-Frame FOR EACH T-Ocm_detalle SHARE-LOCK
&Scoped-define OPEN-QUERY-Dialog-Frame OPEN QUERY Dialog-Frame FOR EACH T-Ocm_detalle SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-Dialog-Frame T-Ocm_detalle
&Scoped-define FIRST-TABLE-IN-QUERY-Dialog-Frame T-Ocm_detalle


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS T-Ocm_detalle.cantidad T-Ocm_detalle.granel ~
T-Ocm_detalle.precio T-Ocm_detalle.fecha_temprana 
&Scoped-define ENABLED-TABLES T-Ocm_detalle
&Scoped-define FIRST-ENABLED-TABLE T-Ocm_detalle
&Scoped-Define ENABLED-OBJECTS BROWSE-10 Btn_OK Btn_Cancel RECT-10 RECT-11 ~
RECT-9 
&Scoped-Define DISPLAYED-FIELDS T-Ocm_detalle.cantidad T-Ocm_detalle.granel ~
T-Ocm_detalle.precio T-Ocm_detalle.fecha_temprana ~
T-Ocm_detalle.subtotal_bruto T-Ocm_detalle.cdg_estadoocm 
&Scoped-define DISPLAYED-TABLES T-Ocm_detalle
&Scoped-define FIRST-DISPLAYED-TABLE T-Ocm_detalle
&Scoped-Define DISPLAYED-OBJECTS v-cdg_articulo v-dsc_articulo ~
v-cdg_partida v-dsc_partida v-unidad v-cdg_entidad v-dsc_entidad v-cdg_obra ~
v-dsc_obra 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 18 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 18 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON btn_sinobra 
     LABEL "&Sin Obra" 
     SIZE 15 BY 1.

DEFINE VARIABLE v-cdg_articulo AS CHARACTER FORMAT "X(256)":U 
     LABEL "Artículo" 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-cdg_entidad AS CHARACTER FORMAT "X(256)":U 
     LABEL "Entidad" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cdg_obra AS CHARACTER FORMAT "X(256)":U 
     LABEL "Obra" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cdg_partida AS CHARACTER FORMAT "X(256)":U 
     LABEL "Partida" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-dsc_articulo AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 61 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_entidad AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 61.2 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_obra AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 45.2 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_partida AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 44 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-unidad AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 97 BY 10.24.

DEFINE RECTANGLE RECT-11
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 97 BY 3.1.

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 97.2 BY 2.81.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-10 FOR 
      Rem_detalle_prv, 
      Rem_header_prv SCROLLING.

DEFINE QUERY Dialog-Frame FOR 
      T-Ocm_detalle SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-10
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-10 Dialog-Frame _STRUCTURED
  QUERY BROWSE-10 NO-LOCK DISPLAY
      Rem_header_prv.tip_comprob COLUMN-LABEL "Ti-!po" FORMAT "X(3)":U
      Rem_header_prv.prf_comprob COLUMN-LABEL "Pre-!fijo" FORMAT "9999":U
      Rem_header_prv.nro_comprob COLUMN-LABEL "Número de!Remito" FORMAT "ZZZZZZZ9":U
      Rem_header_prv.fecha COLUMN-LABEL "Fecha!Entrega" FORMAT "99/99/99":U
      Rem_detalle_prv.cantidad FORMAT "->,>>>,>>9.99":U
      Rem_detalle_prv.granel FORMAT "->>,>>9.99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 61 BY 9.76
         TITLE "Recepciones que afectan a este ítem de O/Compra".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     v-cdg_articulo AT ROW 1.48 COL 14 COLON-ALIGNED
     v-dsc_articulo AT ROW 1.48 COL 33 COLON-ALIGNED NO-LABEL
     v-cdg_partida AT ROW 2.67 COL 14 COLON-ALIGNED
     v-dsc_partida AT ROW 2.67 COL 33 COLON-ALIGNED NO-LABEL
     v-unidad AT ROW 2.67 COL 78 COLON-ALIGNED NO-LABEL
     v-cdg_entidad AT ROW 4.48 COL 14.2 COLON-ALIGNED
     v-dsc_entidad AT ROW 4.48 COL 33 COLON-ALIGNED NO-LABEL
     v-cdg_obra AT ROW 5.67 COL 14.2 COLON-ALIGNED
     v-dsc_obra AT ROW 5.67 COL 33 COLON-ALIGNED NO-LABEL
     btn_sinobra AT ROW 5.67 COL 81.2
     T-Ocm_detalle.cantidad AT ROW 7.43 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     BROWSE-10 AT ROW 7.43 COL 35
     T-Ocm_detalle.granel AT ROW 8.62 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Ocm_detalle.precio AT ROW 9.81 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Ocm_detalle.fecha_temprana AT ROW 11 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Ocm_detalle.subtotal_bruto AT ROW 12.19 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Ocm_detalle.cdg_estadoocm AT ROW 13.38 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 5.8 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Btn_OK AT ROW 14.57 COL 16
     Btn_Cancel AT ROW 16 COL 16
     RECT-10 AT ROW 7.19 COL 2
     RECT-11 AT ROW 4.1 COL 2
     RECT-9 AT ROW 1.29 COL 1.8
     SPACE(1.39) SKIP(13.51)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Detalle de O/Compra a Proveedores"
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: DIALOG-BOX
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Ocm_detalle T "SHARED" NO-UNDO sic Ocm_detalle
      TABLE: T-Ocm_header T "SHARED" NO-UNDO sic Ocm_header
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
                                                                        */
/* BROWSE-TAB BROWSE-10 cantidad Dialog-Frame */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR BUTTON btn_sinobra IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Ocm_detalle.cdg_estadoocm IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Ocm_detalle.subtotal_bruto IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_articulo IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_entidad IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_obra IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_partida IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_articulo IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_entidad IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_obra IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_partida IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-unidad IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-10
/* Query rebuild information for BROWSE BROWSE-10
     _TblList          = "sic.Rem_detalle_prv,sic.Rem_header_prv OF sic.Rem_detalle_prv"
     _Options          = "NO-LOCK"
     _Where[1]         = "sic.Rem_detalle_prv.nro_ocompra = T-Ocm_detalle.nro_ocompra
 AND sic.Rem_detalle_prv.nro_linea_ocm = T-Ocm_detalle.nro_linea
 AND sic.Rem_detalle_prv.nro_ocompra <> 0"
     _FldNameList[1]   > sic.Rem_header_prv.tip_comprob
"Rem_header_prv.tip_comprob" "Ti-!po" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[2]   > sic.Rem_header_prv.prf_comprob
"Rem_header_prv.prf_comprob" "Pre-!fijo" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[3]   > sic.Rem_header_prv.nro_comprob
"Rem_header_prv.nro_comprob" "Número de!Remito" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[4]   > sic.Rem_header_prv.fecha
"Rem_header_prv.fecha" "Fecha!Entrega" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[5]   = sic.Rem_detalle_prv.cantidad
     _FldNameList[6]   = sic.Rem_detalle_prv.granel
     _Query            is OPENED
*/  /* BROWSE BROWSE-10 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX Dialog-Frame
/* Query rebuild information for DIALOG-BOX Dialog-Frame
     _TblList          = "Temp-Tables.T-Ocm_detalle"
     _Options          = "SHARE-LOCK"
     _Query            is NOT OPENED
*/  /* DIALOG-BOX Dialog-Frame */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Detalle de O/Compra a Proveedores */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* OK */
DO:
  ASSIGN FRAME {&FRAME-NAME}
        v-cdg_entidad
        v-cdg_obra
        v-cdg_partida
        T-Ocm_detalle.cantidad 
        T-Ocm_detalle.granel
        T-Ocm_detalle.precio
        T-Ocm_detalle.fecha_temprana.
  
  
  RUN  validar_datos ( OUTPUT hubo_error ).
  IF NOT hubo_error
  THEN DO:
        IF p-modo-detalle = 0 /* Es un alta */ 
        THEN DO:
            ASSIGN
                T-Ocm_header.ultima_linea     = T-Ocm_header.ultima_linea + 1
                T-Ocm_detalle.nro_ocompra     = T-Ocm_header.nro_ocompra
                T-Ocm_detalle.nro_linea       = T-Ocm_header.ultima_linea.
        END.
        p-nro_linea-o = T-Ocm_detalle.nro_linea.
        codigo_salir = CD_GRABAR.
        APPLY "U1" TO THIS-PROCEDURE.
  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_sinobra
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_sinobra Dialog-Frame
ON CHOOSE OF btn_sinobra IN FRAME Dialog-Frame /* Sin Obra */
DO:

  ASSIGN
     T-Ocm_detalle.nro_obra = 0
     v-cdg_obra = ""
     v-dsc_obra = "".

  DISPLAY 
        v-cdg_obra
        v-dsc_obra
        WITH FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_entidad
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_entidad Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF v-cdg_entidad IN FRAME Dialog-Frame /* Entidad */
OR "." OF v-cdg_entidad IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_entidad IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Entidad" "cdg_entidad" "SELENTID.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_entidad Dialog-Frame
ON RETURN OF v-cdg_entidad IN FRAME Dialog-Frame /* Entidad */
DO:
    {traducetabla.i "Entidad" "cdg_entidad" "dsc_entidad"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_obra
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_obra Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF v-cdg_obra IN FRAME Dialog-Frame /* Obra */
OR "." OF v-cdg_obra IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_obra IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Obra" "cdg_obra" "SELOBRGL.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_obra Dialog-Frame
ON RETURN OF v-cdg_obra IN FRAME Dialog-Frame /* Obra */
DO:
    {traducetabla.i "Obra" "cdg_obra" "dsc_obra"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_partida
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_partida Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF v-cdg_partida IN FRAME Dialog-Frame /* Partida */
OR "." OF v-cdg_partida IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_partida IN FRAME {&FRAME-NAME}
DO:
  DEFINE VARIABLE x-cdg_partida LIKE Partida.cdg_partida.
  RUN d-seleccionar_partida-deposito.w ( INPUT  T-Ocm_detalle.nro_articulo,
                                         INPUT  T-Ocm_header.nro_deposito,
                                         OUTPUT x-cdg_partida ).
  IF x-cdg_partida <> ?
  THEN DO:
     DISPLAY x-cdg_partida @ v-cdg_partida 
             WITH FRAME {&FRAME-NAME}.
     APPLY "RETURN" TO v-cdg_partida IN FRAME {&FRAME-NAME}.        
     RETURN NO-APPLY.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_partida Dialog-Frame
ON RETURN OF v-cdg_partida IN FRAME Dialog-Frame /* Partida */
OR TAB OF v-cdg_partida  IN FRAME {&FRAME-NAME}
DO:

   FIND FIRST Partida NO-LOCK 
        WHERE Partida.cdg_empresa  = T-Ocm_header.cdg_empresa
          AND Partida.nro_articulo = T-Ocm_detalle.nro_articulo
          AND Partida.cdg_partida  = INPUT FRAME {&FRAME-NAME} v-cdg_partida NO-ERROR.

   IF NOT AVAILABLE Partida
   THEN DO:
        RUN ponmensj.p ( INPUT "ARTI008" ).
        RETURN NO-APPLY.
   END.
   ELSE DO:
         v-dsc_partida = Partida.descripcion.
         DISPLAY v-dsc_partida
                 WITH FRAME {&FRAME-NAME}.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-10
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Dialog-Frame 


/* ***************************  Main Block  *************************** */

/* Parent the dialog-box to the ACTIVE-WINDOW, if there is no parent.   */
IF VALID-HANDLE(ACTIVE-WINDOW) AND FRAME {&FRAME-NAME}:PARENT eq ?
THEN FRAME {&FRAME-NAME}:PARENT = ACTIVE-WINDOW.


/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.

  FIND FIRST T-Ocm_header.
  IF p-modo-detalle = 0
  THEN DO:
       FIND Articulo WHERE Articulo.nro_articulo  = p-nro_articulo NO-LOCK.
       FIND Unidad OF Articulo NO-LOCK.
       ASSIGN v-cdg_articulo = Articulo.cdg_articulo
              v-dsc_articulo = Articulo.descripcion
              v-unidad       = Unidad.abrevia.
       CREATE T-Ocm_detalle.
       ASSIGN T-Ocm_detalle.nro_articulo = Articulo.nro_articulo
              T-Ocm_detalle.precio       = Articulo.costo.
       IF NOT Articulo.hay_partida
       THEN DO:
            FIND FIRST Partida OF Articulo 
                 WHERE Partida.cdg_empresa = T-Ocm_header.cdg_empresa
                       NO-LOCK.
            ASSIGN
                   T-Ocm_detalle.nro_partida = Partida.nro_partida.
                   v-cdg_partida = Partida.cdg_partida.
                   v-dsc_partida = Partida.descripcion.     
       END.
       ASSIGN 
            T-Ocm_detalle.fecha_tempra = T-Ocm_header.fecha_ocm
            T-Ocm_detalle.fecha_tardia = T-Ocm_header.fecha_ocm.
       
  END.
  ELSE DO:
       FIND FIRST T-Ocm_detalle WHERE T-Ocm_detalle.nro_linea = p-nro_linea-i EXCLUSIVE-LOCK.
       RUN traer_tablas.
  END.     

  DISPLAY 
        v-cdg_articulo
        v-dsc_articulo
        v-cdg_partida
        v-dsc_partida
        v-cdg_entidad
        v-dsc_entidad
        v-cdg_obra
        v-dsc_obra
        v-unidad
        T-Ocm_detalle.cantidad 
        T-Ocm_detalle.granel 
        T-Ocm_detalle.precio
        T-Ocm_detalle.fecha_temprana
        T-Ocm_detalle.subtotal_bruto
        T-Ocm_detalle.cdg_estadoocm
        WITH FRAME {&FRAME-NAME}.      

  {&OPEN-QUERY-{&BROWSE-NAME}}

  RUN habilitar_campos.

/*WAIT-FOR GO OF FRAME {&FRAME-NAME}.*/

  WAIT-FOR U1 OF THIS-PROCEDURE.
  CASE codigo_salir:
       WHEN CD_SALIR    THEN UNDO,LEAVE.
       WHEN CD_CANCELAR THEN UNDO,RETRY.
       WHEN CD_GRABAR   THEN LEAVE.
  END CASE.

END.
RUN disable_UI.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

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
  DISPLAY v-cdg_articulo v-dsc_articulo v-cdg_partida v-dsc_partida v-unidad 
          v-cdg_entidad v-dsc_entidad v-cdg_obra v-dsc_obra 
      WITH FRAME Dialog-Frame.
  IF AVAILABLE T-Ocm_detalle THEN 
    DISPLAY T-Ocm_detalle.cantidad T-Ocm_detalle.granel T-Ocm_detalle.precio 
          T-Ocm_detalle.fecha_temprana T-Ocm_detalle.subtotal_bruto 
          T-Ocm_detalle.cdg_estadoocm 
      WITH FRAME Dialog-Frame.
  ENABLE T-Ocm_detalle.cantidad BROWSE-10 T-Ocm_detalle.granel 
         T-Ocm_detalle.precio T-Ocm_detalle.fecha_temprana Btn_OK Btn_Cancel 
         RECT-10 RECT-11 RECT-9 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE habilitar_campos Dialog-Frame 
PROCEDURE habilitar_campos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DO WITH FRAME {&FRAME-NAME}:

    RUN hayobras.p ( OUTPUT hay_obras ).
    ASSIGN
        v-cdg_entidad:SENSITIVE                   = NO
        v-cdg_obra:SENSITIVE                      = NO
        T-Ocm_detalle.cantidad:SENSITIVE          = NO 
        T-Ocm_detalle.granel:SENSITIVE            = NO 
        T-Ocm_detalle.precio:SENSITIVE            = NO 
        T-Ocm_detalle.fecha_temprana:SENSITIVE    = NO 
        btn_sinobra:SENSITIVE                     = NO
        Btn_OK:SENSITIVE                          = NO.


    CASE p-modo-cabecera:
        WHEN MD_ALTA                   
        THEN DO:
            v-cdg_entidad:SENSITIVE                   = YES.
            v-cdg_obra:SENSITIVE                      = hay_obras.
            v-cdg_partida:SENSITIVE                   = Articulo.hay_partida.
            T-Ocm_detalle.cantidad:SENSITIVE          = YES. 
            T-Ocm_detalle.granel:SENSITIVE            = Articulo.a_granel. 
            T-Ocm_detalle.precio:SENSITIVE            = YES.
            T-Ocm_detalle.fecha_temprana:SENSITIVE    = YES. 
            Btn_OK:SENSITIVE                          = YES.
            btn_sinobra:SENSITIVE                     = hay_obras.
        END.
        
        WHEN MD_MULTIPLE               
        THEN DO:
             /* Nada Habilitado */
        END.
        
        WHEN MD_DEFINIDA               
        THEN DO:
             /* Nada Habilitado */
        END.
        
        WHEN MD_RELACION               
        THEN DO:
             /* Nada Habilitado */
        END.
        
        WHEN MD_READONLY               
        THEN DO:
             /* Nada Habilitado */
        END.
        
        WHEN MD_CAMBIO                 
        THEN DO:
             /* Nada Habilitado */
        END.
        
        WHEN MD_GENERADO               
        THEN DO:
             /* Nada Habilitado */
        END.
         
        WHEN MD_ANULACION              
        THEN DO:
             /* Nada Habilitado */
        END.
         
        WHEN MD_EMISION                
        THEN DO:
             /* Nada Habilitado */
        END.

    END CASE.

  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_tablas Dialog-Frame 
PROCEDURE traer_tablas :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  FIND Articulo OF T-Ocm_detalle NO-LOCK.
  FIND Unidad OF Articulo NO-LOCK.
  ASSIGN v-cdg_articulo = Articulo.cdg_articulo
         v-dsc_articulo = Articulo.descripcion
         v-unidad       = Unidad.abrevia.

  FIND Entidad OF T-Ocm_detalle NO-LOCK NO-ERROR.
  IF AVAILABLE Entidad
  THEN DO:
       v-cdg_entidad = Entidad.cdg_entidad.
       v-dsc_entidad = Entidad.dsc_entidad.
  END.
  ELSE DO:
       v-cdg_entidad = "".
       v-dsc_entidad = "".
  END.

  FIND Obra OF T-Ocm_detalle NO-LOCK NO-ERROR.
  IF AVAILABLE Obra
  THEN DO:
       v-cdg_obra = Obra.cdg_obra.
       v-dsc_obra = Obra.dsc_obra.
  END.
  ELSE DO:
       v-cdg_obra = "".
       v-dsc_obra = "".
  END.

  FIND Partida OF T-Ocm_detalle NO-LOCK NO-ERROR.
  IF AVAILABLE Partida
  THEN DO:
       v-cdg_partida = Partida.cdg_partida.
       v-dsc_partida = Partida.descripcion.
  END.
  ELSE DO:
       v-cdg_partida = "".
       v-dsc_partida = "".
  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE validar_datos Dialog-Frame 
PROCEDURE validar_datos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   DEFINE OUTPUT PARAMETER hay_error AS LOGICAL.

   hay_error = YES.

   FIND Entidad WHERE Entidad.cdg_entidad = v-cdg_entidad NO-ERROR.
   IF NOT AVAILABLE Entidad
   THEN DO:
        RUN PONMENSJ.P ( INPUT "ASIE012" ).
        RETURN.
   END.
   ELSE DO:
        T-Ocm_detalle.nro_entidad = Entidad.nro_entidad.
   END.

   FIND Partida WHERE Partida.nro_articulo = Articulo.nro_articulo
                  AND Partida.cdg_partida  = v-cdg_partida
                  AND Partida.cdg_empresa  = T-Ocm_header.cdg_empresa
                      NO-LOCK NO-ERROR.
   IF NOT AVAILABLE Partida
   THEN DO:
        RUN PONMENSJ.P ( INPUT "FAPR033" ).
        RETURN.
   END.                             
   ELSE DO:
        T-Ocm_detalle.nro_partida = Partida.nro_partida.
   END.

   IF INPUT FRAME {&FRAME-NAME} v-cdg_obra <> ""
   THEN DO:
        FIND Obra WHERE Obra.cdg_obra = v-cdg_obra NO-ERROR.
        IF NOT AVAILABLE Obra
        THEN DO:
             RUN PONMENSJ.P ( INPUT "ASIE013" ).
             RETURN.
        END.
        ELSE DO:
             IF LOOKUP(Obra.entidades_validas,T-Ocm_header.cdg_empresa,",") = 0
             THEN DO:
                  RUN PONMENSJ.P ( INPUT "ASIE027" ).
                  RETURN.
             END.

             IF Obra.finalizada
             THEN DO:
                  RUN PONMENSJ.P ( INPUT "ASIE026" ).
                  RETURN.
             END.
             
             IF T-Ocm_header.fecha < Obra.fecha_apertura OR
                T-Ocm_header.fecha > Obra.fecha_cierre 
             THEN DO:
                  RUN PONMENSJ.P ( INPUT "ASIE026" ).
                  RETURN.
             END.

             T-Ocm_detalle.nro_obra = Obra.nro_obra.

        END.
   END.

   hay_error = NO.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

