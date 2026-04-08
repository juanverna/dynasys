&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame

/* Temp-Table and Buffer definitions                                    */
DEFINE SHARED TEMP-TABLE T-Fac_detalle_prv NO-UNDO LIKE Fac_detalle_prv.
DEFINE SHARED TEMP-TABLE T-Fac_header_prv NO-UNDO LIKE Fac_header_prv.


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
&Scoped-define BROWSE-NAME BROWSE-6

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Remito-factura_prv Rem_header_prv ~
T-Fac_detalle_prv

/* Definitions for BROWSE BROWSE-6                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-6 Rem_header_prv.tip_comprob ~
Rem_header_prv.prf_comprob Rem_header_prv.nro_comprob Rem_header_prv.fecha ~
Remito-factura_prv.cantidad Remito-factura_prv.granel 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-6 
&Scoped-define QUERY-STRING-BROWSE-6 FOR EACH Remito-factura_prv WHERE TRUE /* Join to T-Fac_detalle_prv incomplete */ ~
      AND Remito-factura_prv.nro_facprov = T-Fac_detalle_prv.nro_facprov ~
 AND Remito-factura_prv.nro_linea_fac = T-Fac_detalle_prv.nro_linea NO-LOCK, ~
      EACH Rem_header_prv OF Remito-factura_prv NO-LOCK
&Scoped-define OPEN-QUERY-BROWSE-6 OPEN QUERY BROWSE-6 FOR EACH Remito-factura_prv WHERE TRUE /* Join to T-Fac_detalle_prv incomplete */ ~
      AND Remito-factura_prv.nro_facprov = T-Fac_detalle_prv.nro_facprov ~
 AND Remito-factura_prv.nro_linea_fac = T-Fac_detalle_prv.nro_linea NO-LOCK, ~
      EACH Rem_header_prv OF Remito-factura_prv NO-LOCK.
&Scoped-define TABLES-IN-QUERY-BROWSE-6 Remito-factura_prv Rem_header_prv
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-6 Remito-factura_prv
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-6 Rem_header_prv


/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define FIELDS-IN-QUERY-Dialog-Frame T-Fac_detalle_prv.cantidad ~
T-Fac_detalle_prv.granel T-Fac_detalle_prv.precio ~
T-Fac_detalle_prv.subtotal_neto T-Fac_detalle_prv.num_subcolumna 
&Scoped-define ENABLED-FIELDS-IN-QUERY-Dialog-Frame ~
T-Fac_detalle_prv.cantidad T-Fac_detalle_prv.granel ~
T-Fac_detalle_prv.precio T-Fac_detalle_prv.subtotal_neto 
&Scoped-define ENABLED-TABLES-IN-QUERY-Dialog-Frame T-Fac_detalle_prv
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-Dialog-Frame T-Fac_detalle_prv
&Scoped-define OPEN-BROWSERS-IN-QUERY-Dialog-Frame ~
    ~{&OPEN-QUERY-BROWSE-6}
&Scoped-define QUERY-STRING-Dialog-Frame FOR EACH T-Fac_detalle_prv SHARE-LOCK
&Scoped-define OPEN-QUERY-Dialog-Frame OPEN QUERY Dialog-Frame FOR EACH T-Fac_detalle_prv SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-Dialog-Frame T-Fac_detalle_prv
&Scoped-define FIRST-TABLE-IN-QUERY-Dialog-Frame T-Fac_detalle_prv


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS T-Fac_detalle_prv.cantidad ~
T-Fac_detalle_prv.granel T-Fac_detalle_prv.precio ~
T-Fac_detalle_prv.subtotal_neto 
&Scoped-define ENABLED-TABLES T-Fac_detalle_prv
&Scoped-define FIRST-ENABLED-TABLE T-Fac_detalle_prv
&Scoped-Define ENABLED-OBJECTS BROWSE-6 Btn_OK Btn_Cancel RECT-10 RECT-11 ~
RECT-9 
&Scoped-Define DISPLAYED-FIELDS T-Fac_detalle_prv.cantidad ~
T-Fac_detalle_prv.granel T-Fac_detalle_prv.precio ~
T-Fac_detalle_prv.subtotal_neto T-Fac_detalle_prv.num_subcolumna 
&Scoped-define DISPLAYED-TABLES T-Fac_detalle_prv
&Scoped-define FIRST-DISPLAYED-TABLE T-Fac_detalle_prv
&Scoped-Define DISPLAYED-OBJECTS v-cdg_articulo v-dsc_articulo ~
v-cdg_partida v-dsc_partida v-cdg_entidad v-dsc_entidad v-cdg_obra ~
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
     SIZE 15 BY .81.

DEFINE VARIABLE v-cdg_articulo AS CHARACTER FORMAT "X(256)":U 
     LABEL "Artículo" 
     VIEW-AS FILL-IN 
     SIZE 18 BY .81
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-cdg_entidad AS CHARACTER FORMAT "X(256)":U 
     LABEL "Entidad" 
     VIEW-AS FILL-IN 
     SIZE 18 BY .81
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cdg_obra AS CHARACTER FORMAT "X(256)":U 
     LABEL "Obra" 
     VIEW-AS FILL-IN 
     SIZE 18 BY .81
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cdg_partida AS CHARACTER FORMAT "X(256)":U 
     LABEL "Partida" 
     VIEW-AS FILL-IN 
     SIZE 18 BY .81
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-dsc_articulo AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 58 BY .81
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_entidad AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 58 BY .81
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_obra AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 42 BY .81
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_partida AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 58 BY .81
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 91 BY 9.14.

DEFINE RECTANGLE RECT-11
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 91 BY 2.43.

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 91 BY 2.43.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-6 FOR 
      Remito-factura_prv, 
      Rem_header_prv SCROLLING.

DEFINE QUERY Dialog-Frame FOR 
      T-Fac_detalle_prv SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-6
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-6 Dialog-Frame _STRUCTURED
  QUERY BROWSE-6 NO-LOCK DISPLAY
      Rem_header_prv.tip_comprob COLUMN-LABEL "Ti-!po" FORMAT "X(3)":U
      Rem_header_prv.prf_comprob COLUMN-LABEL "Pre-!fijo" FORMAT "9999":U
      Rem_header_prv.nro_comprob COLUMN-LABEL "Número!Comprobante" FORMAT "ZZZZZZZ9":U
      Rem_header_prv.fecha COLUMN-LABEL "Fecha!Entrega" FORMAT "99/99/99":U
      Remito-factura_prv.cantidad COLUMN-LABEL "Cantidad!Entregada" FORMAT "->,>>>,>>9.99":U
      Remito-factura_prv.granel COLUMN-LABEL "Granel!Entregado" FORMAT "->>,>>9.99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 58 BY 8.33
         BGCOLOR 15 FGCOLOR 9 
         TITLE BGCOLOR 15 FGCOLOR 9 "Recepciones que originan esta factura".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     v-cdg_articulo AT ROW 1.52 COL 12 COLON-ALIGNED
     v-dsc_articulo AT ROW 1.52 COL 31 COLON-ALIGNED NO-LABEL
     v-cdg_partida AT ROW 2.62 COL 12 COLON-ALIGNED
     v-dsc_partida AT ROW 2.62 COL 31 COLON-ALIGNED NO-LABEL
     v-cdg_entidad AT ROW 4.24 COL 12 COLON-ALIGNED
     v-dsc_entidad AT ROW 4.24 COL 31 COLON-ALIGNED NO-LABEL
     v-cdg_obra AT ROW 5.33 COL 12 COLON-ALIGNED
     v-dsc_obra AT ROW 5.33 COL 31 COLON-ALIGNED NO-LABEL
     btn_sinobra AT ROW 5.33 COL 76
     T-Fac_detalle_prv.cantidad AT ROW 7.19 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 18 BY .81
          BGCOLOR 15 FGCOLOR 9 
     BROWSE-6 AT ROW 7.19 COL 33
     T-Fac_detalle_prv.granel AT ROW 8.29 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 18 BY .81
          BGCOLOR 15 FGCOLOR 9 
     T-Fac_detalle_prv.precio AT ROW 9.33 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 18 BY .81
          BGCOLOR 15 FGCOLOR 9 
     T-Fac_detalle_prv.subtotal_neto AT ROW 10.43 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 18 BY .81
          BGCOLOR 15 FGCOLOR 9 
     T-Fac_detalle_prv.num_subcolumna AT ROW 11.52 COL 14 NO-LABEL
          VIEW-AS RADIO-SET VERTICAL
          RADIO-BUTTONS 
                    "Importe Gravado", 0,
"Importe Exento", 1
          SIZE 18 BY 1.33
     Btn_OK AT ROW 13.14 COL 14
     Btn_Cancel AT ROW 14.48 COL 14
     RECT-10 AT ROW 6.67 COL 2
     RECT-11 AT ROW 3.95 COL 2
     RECT-9 AT ROW 1.29 COL 2
     SPACE(0.71) SKIP(13.00)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Detalle de Factura de Proveedor"
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: DIALOG-BOX
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Fac_detalle_prv T "SHARED" NO-UNDO sic Fac_detalle_prv
      TABLE: T-Fac_header_prv T "SHARED" NO-UNDO sic Fac_header_prv
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
                                                                        */
/* BROWSE-TAB BROWSE-6 cantidad Dialog-Frame */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR BUTTON btn_sinobra IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR RADIO-SET T-Fac_detalle_prv.num_subcolumna IN FRAME Dialog-Frame
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
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-6
/* Query rebuild information for BROWSE BROWSE-6
     _TblList          = "sic.Remito-factura_prv WHERE Temp-Tables.T-Fac_detalle_prv <external> ...,sic.Rem_header_prv OF sic.Remito-factura_prv"
     _Options          = "NO-LOCK"
     _Where[1]         = "sic.Remito-factura_prv.nro_facprov = T-Fac_detalle_prv.nro_facprov
 AND sic.Remito-factura_prv.nro_linea_fac = T-Fac_detalle_prv.nro_linea"
     _FldNameList[1]   > sic.Rem_header_prv.tip_comprob
"Rem_header_prv.tip_comprob" "Ti-!po" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[2]   > sic.Rem_header_prv.prf_comprob
"Rem_header_prv.prf_comprob" "Pre-!fijo" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[3]   > sic.Rem_header_prv.nro_comprob
"Rem_header_prv.nro_comprob" "Número!Comprobante" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[4]   > sic.Rem_header_prv.fecha
"Rem_header_prv.fecha" "Fecha!Entrega" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[5]   > sic.Remito-factura_prv.cantidad
"Remito-factura_prv.cantidad" "Cantidad!Entregada" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[6]   > sic.Remito-factura_prv.granel
"Remito-factura_prv.granel" "Granel!Entregado" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _Query            is OPENED
*/  /* BROWSE BROWSE-6 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX Dialog-Frame
/* Query rebuild information for DIALOG-BOX Dialog-Frame
     _TblList          = "Temp-Tables.T-Fac_detalle_prv"
     _Options          = "SHARE-LOCK"
     _Query            is OPENED
*/  /* DIALOG-BOX Dialog-Frame */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Detalle de Factura de Proveedor */
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
        T-Fac_detalle_prv.cantidad 
        T-Fac_detalle_prv.granel 
        T-Fac_detalle_prv.precio
        T-Fac_detalle_prv.num_subcolumna.
  
  RUN  validar_datos ( OUTPUT hubo_error ).
  IF NOT hubo_error
  THEN DO:
        IF p-modo-detalle = 0 /* Es un alta */ 
        THEN DO:
            ASSIGN
                T-Fac_header_prv.ultima_linea     = T-Fac_header_prv.ultima_linea + 1
                T-Fac_detalle_prv.nro_facprov     = T-Fac_header_prv.nro_facprov
                T-Fac_detalle_prv.nro_linea       = T-Fac_header_prv.ultima_linea.
        END.
        p-nro_linea-o = T-Fac_detalle_prv.nro_linea.
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
     T-Fac_detalle_prv.nro_obra = 0
     v-cdg_obra = ""
     v-dsc_obra = "".

  DISPLAY 
        v-cdg_obra
        v-dsc_obra
        WITH FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Fac_detalle_prv.cantidad
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Fac_detalle_prv.cantidad Dialog-Frame
ON LEAVE OF T-Fac_detalle_prv.cantidad IN FRAME Dialog-Frame /* Cantidad */
OR "LEAVE" OF T-Fac_detalle_prv.granel IN FRAME {&FRAME-NAME}
OR "LEAVE" OF T-Fac_detalle_prv.precio IN FRAME {&FRAME-NAME}
DO:
  RUN calcula_subtotal_neto.
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
OR "." OF v-cdg_entidad IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_entidad IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Entidad" "cdg_entidad" "SELENTID.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_partida Dialog-Frame
ON RETURN OF v-cdg_partida IN FRAME Dialog-Frame /* Partida */
DO:
    {traducetabla.i "Entidad" "cdg_entidad" "dsc_entidad"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-6
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

  FIND FIRST T-Fac_header_prv.
  IF p-modo-detalle = 0
  THEN DO:
       FIND Articulo WHERE Articulo.nro_articulo  = p-nro_articulo NO-LOCK.
       ASSIGN v-cdg_articulo = Articulo.cdg_articulo
              v-dsc_articulo = Articulo.descripcion.
       CREATE T-Fac_detalle_prv.
       ASSIGN T-Fac_detalle_prv.nro_articulo      = Articulo.nro_articulo.
  END.
  ELSE DO:
       FIND FIRST T-Fac_detalle_prv WHERE T-Fac_detalle_prv.nro_linea = p-nro_linea-i EXCLUSIVE-LOCK.
       RUN traer_tablas.
  END.     

  DISPLAY 
        v-cdg_articulo
        v-dsc_articulo
        v-cdg_entidad
        v-dsc_entidad
        v-cdg_obra
        v-dsc_obra
        T-Fac_detalle_prv.cantidad 
        T-Fac_detalle_prv.granel 
        T-Fac_detalle_prv.precio 
        T-Fac_detalle_prv.subtotal_neto 
        T-Fac_detalle_prv.num_subcolumna
        WITH FRAME {&FRAME-NAME}.      

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE calcula_subtotal_neto Dialog-Frame 
PROCEDURE calcula_subtotal_neto :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   ASSIGN FRAME {&FRAME-NAME} 
           T-Fac_detalle_prv.precio
           T-Fac_detalle_prv.granel
           T-Fac_detalle_prv.cantidad.

   T-Fac_detalle_prv.subtotal_neto = 
        ( IF T-Fac_detalle_prv.a_granel 
             THEN ROUND( T-Fac_detalle_prv.precio * T-Fac_detalle_prv.granel   , 2 )
             ELSE ROUND( T-Fac_detalle_prv.precio * T-Fac_detalle_prv.cantidad , 2 ) ).

   DISPLAY T-Fac_detalle_prv.subtotal_neto 
            WITH FRAME {&FRAME-NAME}. 

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

  {&OPEN-QUERY-Dialog-Frame}
  GET FIRST Dialog-Frame.
  DISPLAY v-cdg_articulo v-dsc_articulo v-cdg_partida v-dsc_partida 
          v-cdg_entidad v-dsc_entidad v-cdg_obra v-dsc_obra 
      WITH FRAME Dialog-Frame.
  IF AVAILABLE T-Fac_detalle_prv THEN 
    DISPLAY T-Fac_detalle_prv.cantidad T-Fac_detalle_prv.granel 
          T-Fac_detalle_prv.precio T-Fac_detalle_prv.subtotal_neto 
          T-Fac_detalle_prv.num_subcolumna 
      WITH FRAME Dialog-Frame.
  ENABLE T-Fac_detalle_prv.cantidad BROWSE-6 T-Fac_detalle_prv.granel 
         T-Fac_detalle_prv.precio T-Fac_detalle_prv.subtotal_neto Btn_OK 
         Btn_Cancel RECT-10 RECT-11 RECT-9 
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
        v-cdg_entidad:SENSITIVE                     = NO
        v-cdg_obra:SENSITIVE                        = NO
        T-Fac_detalle_prv.cantidad:SENSITIVE        = NO 
        T-Fac_detalle_prv.granel:SENSITIVE          = NO 
        T-Fac_detalle_prv.precio:SENSITIVE          = NO 
        T-Fac_detalle_prv.subtotal_neto:SENSITIVE        = NO 
        T-Fac_detalle_prv.num_subcolumna:SENSITIVE  = NO
        btn_sinobra:SENSITIVE                       = NO
        Btn_OK:SENSITIVE                            = NO.


    CASE p-modo-cabecera:
        WHEN MD_ALTA                   
        THEN DO:
            v-cdg_entidad:SENSITIVE                    = YES.
            v-cdg_obra:SENSITIVE                       = hay_obras.
            T-Fac_detalle_prv.cantidad:SENSITIVE       = YES. 
            T-Fac_detalle_prv.granel:SENSITIVE         = Articulo.a_granel. 
            T-Fac_detalle_prv.precio:SENSITIVE         = YES. 
            T-Fac_detalle_prv.subtotal_neto:SENSITIVE       = NO. 
            T-Fac_detalle_prv.num_subcolumna:SENSITIVE = Articulo.sumaneto <> 0.
            btn_sinobra:SENSITIVE                      = hay_obras.
            Btn_OK:SENSITIVE                           = YES.
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

  FIND Articulo OF T-Fac_detalle_prv NO-LOCK.
  v-cdg_articulo = Articulo.cdg_articulo.
  v-dsc_articulo = Articulo.descripcion.

  FIND Entidad OF T-Fac_detalle_prv NO-LOCK NO-ERROR.
  IF AVAILABLE Entidad
  THEN DO:
       v-cdg_entidad = Entidad.cdg_entidad.
       v-dsc_entidad = Entidad.dsc_entidad.
  END.
  ELSE DO:
       v-cdg_entidad = "".
       v-dsc_entidad = "".
  END.

  FIND Obra OF T-Fac_detalle_prv NO-LOCK NO-ERROR.
  IF AVAILABLE obra
  THEN DO:
       v-cdg_obra = Obra.cdg_obra.
       v-dsc_obra = Obra.dsc_obra.
  END.
  ELSE DO:
       v-cdg_obra = "".
       v-dsc_obra = "".
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
        T-Fac_detalle_prv.nro_entidad = Entidad.nro_entidad.
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
             IF LOOKUP(Obra.lista_empresas,T-Fac_header_prv.cdg_empresa,",") = 0
             THEN DO:
                  RUN PONMENSJ.P ( INPUT "ASIE027" ).
                  RETURN.
             END.

             IF Obra.finalizada
             THEN DO:
                  RUN PONMENSJ.P ( INPUT "ASIE026" ).
                  RETURN.
             END.
             
             IF T-Fac_header_prv.fecha < Obra.fecha_apertura OR
                T-Fac_header_prv.fecha > Obra.fecha_cierre 
             THEN DO:
                  RUN PONMENSJ.P ( INPUT "ASIE026" ).
                  RETURN.
             END.

             T-Fac_detalle_prv.nro_obra = Obra.nro_obra.

        END.
   END.
/*
   IF T-Fac_detalle_prv.valor_unitario = 0 AND T-Fac_detalle_prv.unidades
   THEN DO:
      RUN PONMENSJ.P ( INPUT "ASIE018" ).
      RETURN.
   END.

   IF T-Fac_detalle_prv.cambio = 0 AND T-Fac_detalle_prv.bimonetario
   THEN DO:
      RUN PONMENSJ.P ( INPUT "ASIE019" ).
      RETURN.
   END.

   IF T-Fac_detalle_prv.bimonetario
   THEN DO:
      ASSIGN
            aux_debito  = ROUND(T-Fac_detalle_prv.debito  * T-Fac_detalle_prv.cambio, 2)
            aux_credito = ROUND(T-Fac_detalle_prv.credito * T-Fac_detalle_prv.cambio, 2). 
      IF aux_debito  <> T-Fac_detalle_prv.debito_div OR
         aux_credito <> T-Fac_detalle_prv.credito_div
      THEN DO:   
         RUN PONMENSJ.P ( INPUT "ASIE016" ).
         RETURN.
      END.
   END.      

   IF T-Fac_detalle_prv.unidades
   THEN DO:
      ASSIGN
            aux_debito  = ROUND(T-Fac_detalle_prv.debito_can  * T-Fac_detalle_prv.valor_unitario, 2)
            aux_credito = ROUND(T-Fac_detalle_prv.credito_can  * T-Fac_detalle_prv.valor_unitario, 2).
      IF aux_debito  <> T-Fac_detalle_prv.debito OR
         aux_credito <> T-Fac_detalle_prv.credito
      THEN DO:   
         RUN PONMENSJ.P ( INPUT "ASIE015" ).
         RETURN.
      END.
   END.      
 
 
   IF Cuenta.entidades_validas <> "*"
   THEN DO:
        FIND Entidad OF T-Fac_detalle_prv NO-LOCK.
        IF LOOKUP(Entidad.cdg_entidad,Cuenta.entidades_validas) = 0
        THEN DO:
             RUN PONMENSJ.P ( INPUT "ASIE024").
             RETURN.
        END.
   END.
   
   FIND Obra OF T-Fac_detalle_prv NO-LOCK NO-ERROR.
   IF AVAILABLE Obra
   THEN DO:
        IF Obra.finalizada
        THEN DO:
             RUN PONMENSJ.P ( INPUT "ASIE025").
             RETURN.
        END.
        IF Obra.fecha_cierre < T-Fac_header_prv.fecha OR
           Obra.fecha_apertura > T-Fac_header_prv.fecha
        THEN DO:
             RUN PONMENSJ.P ( INPUT "ASIE026").
             RETURN.
        END.
   END.
*/   
   hay_error = NO.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

