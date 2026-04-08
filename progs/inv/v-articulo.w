&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW


/* Temp-Table and Buffer definitions                                    */
DEFINE BUFFER Ucompra FOR Unidad.
DEFINE BUFFER Ugranel FOR Unidad.



&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS V-table-Win 
/*------------------------------------------------------------------------

  File:

  Description: from VIEWER.W - Template for SmartViewer Objects

  Input Parameters:
      <none>

  Output Parameters:
      <none>

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

DEFINE VARIABLE rid_tabla AS ROWID.
DEFINE VARIABLE v-lista_empresas LIKE Articulo.lista_empresas.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartViewer
&Scoped-define DB-AWARE no

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME F-Main

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES Articulo
&Scoped-define FIRST-EXTERNAL-TABLE Articulo


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Articulo.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Articulo.cdg_articulo Articulo.stock_sino ~
Articulo.descripcion Articulo.cdg_estado Articulo.fecha_alta ~
Articulo.ventas_sino Articulo.compras_sino Articulo.inventario_sino ~
Articulo.produccion_sino Articulo.cdg_subclase Articulo.unidades_sino ~
Articulo.a_granel Articulo.lista_empresas Articulo.hay_partida ~
Articulo.hay_marca 
&Scoped-define ENABLED-TABLES Articulo
&Scoped-define FIRST-ENABLED-TABLE Articulo
&Scoped-Define ENABLED-OBJECTS RECT-1 RECT-5 RECT-6 RECT-7 RECT-8 
&Scoped-Define DISPLAYED-FIELDS Articulo.cdg_articulo Articulo.stock_sino ~
Articulo.descripcion Articulo.cdg_estado Articulo.fecha_alta ~
Articulo.fecha_baja Articulo.ventas_sino Articulo.compras_sino ~
Articulo.inventario_sino Articulo.produccion_sino Articulo.cdg_subclase ~
Articulo.unidades_sino Articulo.a_granel Articulo.lista_empresas ~
Articulo.hay_partida Articulo.hay_marca 
&Scoped-define DISPLAYED-TABLES Articulo
&Scoped-define FIRST-DISPLAYED-TABLE Articulo
&Scoped-Define DISPLAYED-OBJECTS c_nro_tipo_evento v-cdg_tipo_articulo ~
v-dsc_tipo_articulo v-cdg_familia_articulo v-dsc_familia_articulo ~
v-dsc_tipofamilia v-cdg_familia_impositiva v-dsc_familia_impositiva ~
v-cdg_familia_ganancias v-dsc_familia_ganancias v-cdg_familia_retiva ~
v-dsc_familia_retiva v-cdg_familia_retibr v-dsc_familia_retibr ~
v-cdg_familia_retsuss v-dsc_familia_retsuss v-cdg_marca_comercial ~
v-dsc_marca_comercial v-lista_sectores v-cdg_envases v-dsc_envases ~
v-cdg_ugranel v-dsc_ugranel v-cdg_ucompra v-dsc_ucompra v-cdg_unidad ~
v-dsc_unidad 

/* Custom List Definitions                                              */
/* ADM-CREATE-FIELDS,ADM-ASSIGN-FIELDS,List-3,List-4,List-5,List-6      */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _XFTR "Foreign Keys" V-table-Win _INLINE
/* Actions: ? adm/support/keyedit.w ? ? ? */
/* STRUCTURED-DATA
<KEY-OBJECT>
THIS-PROCEDURE
</KEY-OBJECT>
<FOREIGN-KEYS>
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = "",
     Keys-Supplied = ""':U).
/**************************
</EXECUTING-CODE> */   

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE BUTTON btn_clasificar 
     LABEL "&Clasificar" 
     SIZE 15 BY 1.

DEFINE BUTTON btn_elegir 
     LABEL "E&legir" 
     SIZE 15 BY 1.

DEFINE BUTTON btn_elegir-sector 
     LABEL "El&egir" 
     SIZE 15 BY 1.

DEFINE VARIABLE c_nro_tipo_evento AS INTEGER FORMAT ">>>>>>>>9" INITIAL 0 
     LABEL "Evento" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "0",1
     DROP-DOWN-LIST
     SIZE 17 BY 1 TOOLTIP "Tipo de Restriccion o Tipo de Evento"
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_envases AS CHARACTER FORMAT "X(8)" 
     LABEL "Envase" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 8 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_familia_articulo AS CHARACTER FORMAT "X(8)" 
     LABEL "F.Contable" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_familia_ganancias AS CHARACTER FORMAT "X(8)" 
     LABEL "Ganancias" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_familia_impositiva AS CHARACTER FORMAT "X(8)" 
     LABEL "F.Impositiva" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_familia_retibr AS CHARACTER FORMAT "X(8)" 
     LABEL "I.Br." 
     VIEW-AS FILL-IN NATIVE 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_familia_retiva AS CHARACTER FORMAT "X(8)" 
     LABEL "I.V.A." 
     VIEW-AS FILL-IN NATIVE 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_familia_retsuss AS CHARACTER FORMAT "X(8)" 
     LABEL "SUSS" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_marca_comercial AS CHARACTER FORMAT "X(8)" 
     LABEL "Marca" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_tipo_articulo AS CHARACTER FORMAT "X(8)" 
     LABEL "Tipo" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_ucompra AS CHARACTER FORMAT "X(12)" 
     LABEL "Un.Compra" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 8 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_ugranel AS CHARACTER FORMAT "X(12)" 
     LABEL "Un.Granel" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 8 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_unidad AS CHARACTER FORMAT "X(12)" 
     LABEL "Un.Cant." 
     VIEW-AS FILL-IN NATIVE 
     SIZE 8 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-dsc_envases AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 38 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_familia_articulo AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 47 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_familia_ganancias AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 67 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_familia_impositiva AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 67 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_familia_retibr AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 67 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_familia_retiva AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 67 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_familia_retsuss AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 67 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_marca_comercial AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 67 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_tipofamilia AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 19 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_tipo_articulo AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 67 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_ucompra AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 38 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_ugranel AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 38 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_unidad AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 38 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-lista_sectores LIKE Articulo.lista_sectores
     VIEW-AS FILL-IN NATIVE 
     SIZE 67 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 6 GRAPHIC-EDGE  NO-FILL   
     SIZE 126 BY 20.24.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 21 BY 3.57.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 21 BY 3.57.

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 21 BY 1.43.

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 21 BY 2.62.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Articulo.cdg_articulo AT ROW 1.71 COL 16 COLON-ALIGNED
          LABEL "Código"
          VIEW-AS FILL-IN NATIVE 
          SIZE 32 BY 1
          BGCOLOR 15 FGCOLOR 9 
     c_nro_tipo_evento AT ROW 1.71 COL 58 COLON-ALIGNED WIDGET-ID 40
     Articulo.stock_sino AT ROW 1.71 COL 80
          VIEW-AS TOGGLE-BOX
          SIZE 20 BY 1
     Articulo.descripcion AT ROW 2.91 COL 16 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 83 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Articulo.cdg_estado AT ROW 2.91 COL 102 COLON-ALIGNED NO-LABEL
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Habilitado","",
                     "Baja","B"
          DROP-DOWN-LIST
          SIZE 19 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_tipo_articulo AT ROW 4.1 COL 16 COLON-ALIGNED HELP
          "Código del tipo de artículo"
     v-dsc_tipo_articulo AT ROW 4.1 COL 32 COLON-ALIGNED NO-LABEL
     v-cdg_familia_articulo AT ROW 5.29 COL 16 COLON-ALIGNED
     v-dsc_familia_articulo AT ROW 5.29 COL 32 COLON-ALIGNED NO-LABEL
     v-dsc_tipofamilia AT ROW 5.29 COL 80 COLON-ALIGNED NO-LABEL
     Articulo.fecha_alta AT ROW 5.76 COL 109 COLON-ALIGNED
          LABEL "Alta"
          VIEW-AS FILL-IN NATIVE 
          SIZE 12 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_familia_impositiva AT ROW 6.48 COL 16 COLON-ALIGNED
     v-dsc_familia_impositiva AT ROW 6.48 COL 32 COLON-ALIGNED NO-LABEL
     Articulo.fecha_baja AT ROW 6.95 COL 109 COLON-ALIGNED
          LABEL "Baja"
          VIEW-AS FILL-IN NATIVE 
          SIZE 12 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_familia_ganancias AT ROW 7.67 COL 16 COLON-ALIGNED
     v-dsc_familia_ganancias AT ROW 7.67 COL 32 COLON-ALIGNED NO-LABEL
     v-cdg_familia_retiva AT ROW 8.86 COL 16 COLON-ALIGNED
     v-dsc_familia_retiva AT ROW 8.86 COL 32 COLON-ALIGNED NO-LABEL
     Articulo.ventas_sino AT ROW 9.86 COL 104
          LABEL "Ventas"
          VIEW-AS TOGGLE-BOX
          SIZE 17 BY .76
     v-cdg_familia_retibr AT ROW 10.05 COL 16 COLON-ALIGNED
     v-dsc_familia_retibr AT ROW 10.05 COL 32 COLON-ALIGNED NO-LABEL
     Articulo.compras_sino AT ROW 10.67 COL 104
          LABEL "Compras"
          VIEW-AS TOGGLE-BOX
          SIZE 17 BY .76
     v-cdg_familia_retsuss AT ROW 11.24 COL 16 COLON-ALIGNED
     v-dsc_familia_retsuss AT ROW 11.24 COL 32 COLON-ALIGNED NO-LABEL
     Articulo.inventario_sino AT ROW 11.48 COL 104
          LABEL "Inventario"
          VIEW-AS TOGGLE-BOX
          SIZE 17 BY .76
     Articulo.produccion_sino AT ROW 12.29 COL 104
          LABEL "Producción"
          VIEW-AS TOGGLE-BOX
          SIZE 17 BY .76
     v-cdg_marca_comercial AT ROW 12.43 COL 16 COLON-ALIGNED
     v-dsc_marca_comercial AT ROW 12.43 COL 32 COLON-ALIGNED NO-LABEL
     Articulo.cdg_subclase AT ROW 14.81 COL 16 COLON-ALIGNED
          LABEL "Clasificación" FORMAT "X(40)"
          VIEW-AS FILL-IN NATIVE 
          SIZE 67 BY 1
          BGCOLOR 15 FGCOLOR 9 
     btn_clasificar AT ROW 14.81 COL 86
     Articulo.unidades_sino AT ROW 14.86 COL 104
          LABEL "En Unidades"
          VIEW-AS TOGGLE-BOX
          SIZE 17 BY .76
     Articulo.a_granel AT ROW 15.67 COL 104
          VIEW-AS TOGGLE-BOX
          SIZE 16 BY .62
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME F-Main
     Articulo.lista_empresas AT ROW 16 COL 16 COLON-ALIGNED
          LABEL "Empresas"
          VIEW-AS FILL-IN NATIVE 
          SIZE 67 BY 1
          BGCOLOR 15 FGCOLOR 9 
     btn_elegir AT ROW 16 COL 86
     Articulo.hay_partida AT ROW 16.48 COL 104
          VIEW-AS TOGGLE-BOX
          SIZE 16 BY .62
     v-lista_sectores AT ROW 17.19 COL 16 COLON-ALIGNED HELP
          "" FORMAT "X(150)"
          BGCOLOR 15 FGCOLOR 9 
     btn_elegir-sector AT ROW 17.19 COL 86
     Articulo.hay_marca AT ROW 17.29 COL 104
          VIEW-AS TOGGLE-BOX
          SIZE 17 BY .62
     v-cdg_envases AT ROW 18.38 COL 16 COLON-ALIGNED
     v-dsc_envases AT ROW 18.38 COL 25 COLON-ALIGNED NO-LABEL
     v-cdg_ugranel AT ROW 18.38 COL 75 COLON-ALIGNED
     v-dsc_ugranel AT ROW 18.38 COL 84 COLON-ALIGNED NO-LABEL
     v-cdg_ucompra AT ROW 19.57 COL 16 COLON-ALIGNED
     v-dsc_ucompra AT ROW 19.57 COL 25 COLON-ALIGNED NO-LABEL
     v-cdg_unidad AT ROW 19.57 COL 75 COLON-ALIGNED
     v-dsc_unidad AT ROW 19.57 COL 84 COLON-ALIGNED NO-LABEL
     "   Registro de Stock" VIEW-AS TEXT
          SIZE 21 BY 1 AT ROW 13.38 COL 103
          BGCOLOR 5 FGCOLOR 15 
     "   Estado del Artículo" VIEW-AS TEXT
          SIZE 21 BY 1 AT ROW 1.48 COL 103
          BGCOLOR 5 FGCOLOR 15 
     " Fecha de Alta y Baja" VIEW-AS TEXT
          SIZE 21 BY 1 AT ROW 4.33 COL 103
          BGCOLOR 5 FGCOLOR 15 
     "   Habilitado para" VIEW-AS TEXT
          SIZE 21 BY 1 AT ROW 8.38 COL 103
          BGCOLOR 5 FGCOLOR 15 
     RECT-1 AT ROW 1 COL 1
     RECT-5 AT ROW 9.57 COL 103
     RECT-6 AT ROW 14.57 COL 103
     RECT-7 AT ROW 2.67 COL 103
     RECT-8 AT ROW 5.52 COL 103
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Articulo
   Allow: Basic,DB-Fields
   Frames: 1
   Add Fields to: EXTERNAL-TABLES
   Other Settings: PERSISTENT-ONLY COMPILE
   Temp-Tables and Buffers:
      TABLE: Ucompra B "?" ? sic Unidad
      TABLE: Ugranel B "?" ? sic Unidad
   END-TABLES.
 */

/* This procedure should always be RUN PERSISTENT.  Report the error,  */
/* then cleanup and return.                                            */
IF NOT THIS-PROCEDURE:PERSISTENT THEN DO:
  MESSAGE "{&FILE-NAME} should only be RUN PERSISTENT.":U
          VIEW-AS ALERT-BOX ERROR BUTTONS OK.
  RETURN.
END.

&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
/* DESIGN Window definition (used by the UIB) 
  CREATE WINDOW V-table-Win ASSIGN
         HEIGHT             = 20.76
         WIDTH              = 127.2.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB V-table-Win 
/* ************************* Included-Libraries *********************** */

{src/adm/method/viewer.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW V-table-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME F-Main
   NOT-VISIBLE Size-to-Fit                                              */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR BUTTON btn_clasificar IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_elegir IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_elegir-sector IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Articulo.cdg_articulo IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Articulo.cdg_subclase IN FRAME F-Main
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR TOGGLE-BOX Articulo.compras_sino IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR COMBO-BOX c_nro_tipo_evento IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Articulo.fecha_alta IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Articulo.fecha_baja IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR TOGGLE-BOX Articulo.inventario_sino IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Articulo.lista_empresas IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR TOGGLE-BOX Articulo.produccion_sino IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR TOGGLE-BOX Articulo.unidades_sino IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN v-cdg_envases IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_familia_articulo IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_familia_ganancias IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_familia_impositiva IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_familia_retibr IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_familia_retiva IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_familia_retsuss IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_marca_comercial IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_tipo_articulo IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_ucompra IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_ugranel IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_unidad IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_envases IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_familia_articulo IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_familia_ganancias IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_familia_impositiva IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_familia_retibr IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_familia_retiva IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_familia_retsuss IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_marca_comercial IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_tipofamilia IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_tipo_articulo IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_ucompra IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_ugranel IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_unidad IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-lista_sectores IN FRAME F-Main
   NO-ENABLE LIKE = sic.Articulo.lista_sectores EXP-FORMAT EXP-SIZE     */
/* SETTINGS FOR TOGGLE-BOX Articulo.ventas_sino IN FRAME F-Main
   EXP-LABEL                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME F-Main
/* Query rebuild information for FRAME F-Main
     _Options          = "NO-LOCK"
     _Query            is NOT OPENED
*/  /* FRAME F-Main */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME btn_clasificar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_clasificar V-table-Win
ON CHOOSE OF btn_clasificar IN FRAME F-Main /* Clasificar */
DO:
   DEFINE VARIABLE codigo_salida AS INTEGER.
   DEFINE VARIABLE sel_clase    AS CHARACTER.
   DEFINE VARIABLE rid_articulo AS ROWID.

   sel_clase = Articulo.cdg_subclase:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
   RUN d-selclase_articulos.w ( INPUT-OUTPUT sel_clase, OUTPUT codigo_salida  ).
   IF codigo_salida = 1
   THEN DO:
      Articulo.cdg_subclase:SCREEN-VALUE IN FRAME {&FRAME-NAME} = sel_clase.
   END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_elegir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_elegir V-table-Win
ON CHOOSE OF btn_elegir IN FRAME F-Main /* Elegir */
DO:
  v-lista_empresas = Articulo.lista_empresas:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
  RUN selcodempresa.p ( INPUT-OUTPUT v-lista_empresas ).
  Articulo.lista_empresas:SCREEN-VALUE IN FRAME {&FRAME-NAME} = v-lista_empresas.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_elegir-sector
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_elegir-sector V-table-Win
ON CHOOSE OF btn_elegir-sector IN FRAME F-Main /* Elegir */
DO:
  DEFINE VARIABLE x-lista_sectores LIKE Articulo.lista_sectores.
  x-lista_sectores = v-lista_sectores:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
  RUN selcodsector.p ( INPUT-OUTPUT x-lista_sectores ).
  v-lista_sectores:SCREEN-VALUE IN FRAME {&FRAME-NAME} = x-lista_sectores.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME c_nro_tipo_evento
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c_nro_tipo_evento V-table-Win
ON VALUE-CHANGED OF c_nro_tipo_evento IN FRAME F-Main /* Evento */
DO:
/*  FIND FIRST tipo_evento WHERE tipo_evento.nro_tipo_evento = c_nro_tipo_evento:INPUT-VALUE NO-ERROR.
  IF AVAILABLE tipo_evento THEN 
       dsc_tipo_evento:SCREEN-VALUE IN FRAME {&FRAME-NAME} = tipo_evento.descripcion.
*/
    ASSIGN c_nro_tipo_evento.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_envases
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_envases V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_envases IN FRAME F-Main /* Envase */
OR "." OF v-cdg_envases IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_envases IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Envases" "cdg_envases" "SELENVASES.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_envases V-table-Win
ON RETURN OF v-cdg_envases IN FRAME F-Main /* Envase */
DO:
    {traducetabla.i "envases" "cdg_envases" "dsc_envases"} 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_familia_articulo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_familia_articulo V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_familia_articulo IN FRAME F-Main /* F.Contable */
OR "." OF v-cdg_familia_articulo IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_familia_articulo IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Familia_articulo" "cdg_familia" "SELFAMAR.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_familia_articulo V-table-Win
ON RETURN OF v-cdg_familia_articulo IN FRAME F-Main /* F.Contable */
DO:
    &SCOPED-DEFINE PONER-TABLA RUN poner_familiarticulo.
    {traducetabla.i "Familia_articulo" "cdg_familia" "dsc_familia"} 
    &UNDEFINE PONER-TABLA
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_familia_ganancias
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_familia_ganancias V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_familia_ganancias IN FRAME F-Main /* Ganancias */
OR "." OF v-cdg_familia_ganancias IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_familia_ganancias IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "familia_ganancias" "cdg_famganancias" "selfganan.p"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_familia_ganancias V-table-Win
ON RETURN OF v-cdg_familia_ganancias IN FRAME F-Main /* Ganancias */
DO:
    {traducetabla.i "familia_ganancias" "cdg_famganancias" "dsc_famganancias"} 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_familia_impositiva
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_familia_impositiva V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_familia_impositiva IN FRAME F-Main /* F.Impositiva */
OR "." OF v-cdg_familia_impositiva IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_familia_impositiva IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Familia_impositiva" "cdg_familimpos" "SELFIMPOS.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_familia_impositiva V-table-Win
ON RETURN OF v-cdg_familia_impositiva IN FRAME F-Main /* F.Impositiva */
DO:
    {traducetabla.i "Familia_impositiva" "cdg_familimpos" "dsc_familimpos"} 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_familia_retibr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_familia_retibr V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_familia_retibr IN FRAME F-Main /* I.Br. */
OR "." OF v-cdg_familia_retibr IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_familia_retibr IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "familia_retibr" "cdg_famretibr" "selfrtibr.p"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_familia_retibr V-table-Win
ON RETURN OF v-cdg_familia_retibr IN FRAME F-Main /* I.Br. */
DO:
    {traducetabla.i "familia_retibr" "cdg_famretibr" "dsc_famretibr"} 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_familia_retiva
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_familia_retiva V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_familia_retiva IN FRAME F-Main /* I.V.A. */
OR "." OF v-cdg_familia_retiva IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_familia_retiva IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "familia_retiva" "cdg_famretiva" "selfrtiva.p"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_familia_retiva V-table-Win
ON RETURN OF v-cdg_familia_retiva IN FRAME F-Main /* I.V.A. */
DO:
    {traducetabla.i "familia_retiva" "cdg_famretiva" "dsc_famretiva"} 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_familia_retsuss
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_familia_retsuss V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_familia_retsuss IN FRAME F-Main /* SUSS */
OR "." OF v-cdg_familia_retsuss IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_familia_retsuss IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "familia_retsuss" "cdg_famretsuss" "selfrtsus.p"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_familia_retsuss V-table-Win
ON RETURN OF v-cdg_familia_retsuss IN FRAME F-Main /* SUSS */
DO:
    {traducetabla.i "familia_retsuss" "cdg_famretsuss" "dsc_famretsuss"} 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_marca_comercial
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_marca_comercial V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_marca_comercial IN FRAME F-Main /* Marca */
OR "." OF v-cdg_marca_comercial IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_marca_comercial IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "marca_comercial" "cdg_marcacom" "SELMARCACOM.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_marca_comercial V-table-Win
ON RETURN OF v-cdg_marca_comercial IN FRAME F-Main /* Marca */
DO:
    {traducetabla.i "Marca_comercial" "cdg_marcacom" "dsc_marcacom"} 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_tipo_articulo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_tipo_articulo V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_tipo_articulo IN FRAME F-Main /* Tipo */
OR "." OF v-cdg_tipo_articulo IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_tipo_articulo IN FRAME {&FRAME-NAME}

DO:

   {helptabla.i "Tipo_articulo" "cdg_tipoart" "SELTIPAR.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_tipo_articulo V-table-Win
ON RETURN OF v-cdg_tipo_articulo IN FRAME F-Main /* Tipo */
DO:
   {traducetabla.i "Tipo_articulo" "cdg_tipoart" "dsc_tipoart"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_ucompra
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_ucompra V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_ucompra IN FRAME F-Main /* Un.Compra */
OR "." OF v-cdg_ucompra IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_ucompra IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "Ucompra" "cdg_umed" "SELUNIDA.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_ucompra V-table-Win
ON RETURN OF v-cdg_ucompra IN FRAME F-Main /* Un.Compra */
DO:
   {traducetabla.i "Ucompra" "cdg_umed" "descripcion_unidad"} 
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_ugranel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_ugranel V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_ugranel IN FRAME F-Main /* Un.Granel */
OR "." OF v-cdg_ugranel IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_ugranel IN FRAME {&FRAME-NAME}

DO:

   {helptabla.i "Ugranel" "cdg_umed" "SELUNIDA.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_ugranel V-table-Win
ON RETURN OF v-cdg_ugranel IN FRAME F-Main /* Un.Granel */
DO:
   {traducetabla.i "Ugranel" "cdg_umed" "descripcion_unidad"} 
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_unidad
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_unidad V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_unidad IN FRAME F-Main /* Un.Cant. */
OR "." OF v-cdg_unidad IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_unidad IN FRAME {&FRAME-NAME}

DO:

   {helptabla.i "Unidad" "cdg_umed" "SELUNIDA.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_unidad V-table-Win
ON RETURN OF v-cdg_unidad IN FRAME F-Main /* Un.Cant. */
DO:
   {traducetabla.i "Unidad" "cdg_umed" "descripcion_unidad"} 
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK V-table-Win 


/* ***************************  Main Block  *************************** */

  &IF DEFINED(UIB_IS_RUNNING) <> 0 &THEN          
    RUN dispatch IN THIS-PROCEDURE ('initialize':U).        
  &ENDIF         
  
  /************************ INTERNAL PROCEDURES ********************/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available V-table-Win  _ADM-ROW-AVAILABLE
PROCEDURE adm-row-available :
/*------------------------------------------------------------------------------
  Purpose:     Dispatched to this procedure when the Record-
               Source has a new row available.  This procedure
               tries to get the new row (or foriegn keys) from
               the Record-Source and process it.
  Parameters:  <none>
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.             */
  {src/adm/template/row-head.i}

  /* Create a list of all the tables that we need to get.            */
  {src/adm/template/row-list.i "Articulo"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Articulo"}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE agregar_atributos V-table-Win 
PROCEDURE agregar_atributos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 
 DEFINE INPUT PARAMETER p-nro_articulo    LIKE Articulo.nro_articulo.
 DEFINE INPUT PARAMETER p-lista_atributos AS CHARACTER.
 
 DEFINE VARIABLE j AS INTEGER.
 DEFINE VARIABLE v-entrada AS CHARACTER.

 FOR EACH Articulo_atributo OF Articulo WHERE NOT Articulo_atributo.es_manual:
     DELETE Articulo_atributo.
 END.

 DO j = 1 TO NUM-ENTRIES(p-lista_atributos,","):
     
     v-entrada = ENTRY(j,p-lista_atributos,",").

     CREATE Articulo_atributo.
     ASSIGN Articulo_atributo.cdg_tipoatributo   = ENTRY(1,v-entrada,":")
            Articulo_atributo.cdg_atributo       = ENTRY(2,v-entrada,":")
            Articulo_atributo.es_manual          = NO
            Articulo_atributo.nro_articulo       = p-nro_articulo.
 END.
              
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI V-table-Win  _DEFAULT-DISABLE
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
  HIDE FRAME F-Main.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-add-record V-table-Win 
PROCEDURE local-add-record :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'add-record':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   {blanqueacodigo.i "Tipo_articulo"} 
   {blanqueacodigo.i "Familia_articulo"} 
   {blanqueacodigo.i "Familia_impositiva"}
   {blanqueacodigo.i "Familia_ganancias"}
   {blanqueacodigo.i "Familia_retiva"}
   {blanqueacodigo.i "Familia_retibr"}
   {blanqueacodigo.i "Familia_retsuss"}
   {blanqueacodigo.i "Unidad"}
   {blanqueacodigo.i "Ucompra"}
   {blanqueacodigo.i "Ugranel"}
   {blanqueacodigo.i "Marca_comercial"}
   {blanqueacodigo.i "Envases"}
   
   {findsector.i}
   v-lista_sectores:SCREEN-VALUE IN FRAME {&FRAME-NAME} = Area.cdg_area.

   {findempresa.i}
   Articulo.lista_empresas:SCREEN-VALUE IN FRAME {&FRAME-NAME} = Empresa.cdg_empresa.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-assign-statement V-table-Win 
PROCEDURE local-assign-statement :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

    DEFINE VARIABLE hubo_error      AS LOGICAL.
    DEFINE VARIABLE lista_atributos AS CHARACTER.
    DEFINE VARIABLE pcname          AS CHARACTER.

    &SCOPED-DEFINE TABLA-MAESTRA  Articulo
    
 
    {validartabla.i "Tipo_articulo" "cdg_tipoart" "dsc_tipoart" "ARTI008"}

    RUN validar_codigo_articulo.p ( INPUT  Articulo.cdg_articulo:SCREEN-VALUE IN FRAME {&FRAME-NAME}, 
                                    INPUT  v-cdg_tipo_articulo:SCREEN-VALUE IN FRAME {&FRAME-NAME},
                                    OUTPUT lista_atributos,
                                    OUTPUT hubo_error ).

    RUN validar_lista_empresas.p ( INPUT  Articulo.lista_empresas:SCREEN-VALUE IN FRAME {&FRAME-NAME},
                                   INPUT  hubo_error,
                                   OUTPUT hubo_error).

    RUN validar_lista_sectores.p ( INPUT  v-lista_sectores:SCREEN-VALUE IN FRAME {&FRAME-NAME},
                                   INPUT  hubo_error,
                                   OUTPUT hubo_error).

    IF hubo_error 
       THEN RETURN ERROR.

    DEFINE BUFFER B-Articulo FOR Articulo.

    IF INPUT FRAME {&FRAME-NAME} Articulo.descripcion = "" OR 
        INPUT FRAME {&FRAME-NAME} Articulo.descripcion = ?  
    THEN DO:
         RUN PONMENSJ.P (INPUT "ARTI001").
         RETURN ERROR.
    END.            

    IF CAN-FIND(FIRST B-Articulo 
                       WHERE B-Articulo.cdg_articulo = 
                           INPUT FRAME {&FRAME-NAME} Articulo.cdg_articulo  
                        AND ROWID(B-Articulo) <> ROWID(Articulo) )
    THEN DO:
         RUN PONMENSJ.P (INPUT "ARTI002").
         RETURN ERROR.
    END.            

/*    &SCOPED-DEFINE TABLA-MAESTRA  Articulo */

/*    {validartabla.i "Tipo_articulo" "cdg_tipoart" "dsc_tipoart" "ARTI008"} */
   {validartabla.i "Familia_articulo" "cdg_familia" "dsc_familia" "ARTI003"} 
   {validartabla.i "Unidad" "cdg_umed" "descripcion_unidad" "ARTI004"}
   {validartabla.i "Ucompra" "cdg_umed" "descripcion_unidad" "ARTI015"}
   {validartabla.i "Ugranel" "cdg_umed" "descripcion_unidad" "ARTI016"}
   {validartabla.i "Familia_impositiva" "cdg_familimpos" "dsc_familimpos" "ARTI003"} 
   {validartabla.i "Marca_comercial" "cdg_marcacom" "dsc_marcacom" "ARTI017"} 
   {validartabla.i "Envases" "cdg_envases" "dsc_envases" "ARTI018"} 
   {validartabla.i "Familia_ganancias" "cdg_famganancias" "dsc_famganancias" "ARTI019"} 
   {validartabla.i "Familia_retiva" "cdg_famretiva" "dsc_famretiva" "ARTI019"} 
   {validartabla.i "Familia_retibr" "cdg_famretibr" "dsc_famretibr" "ARTI019"} 
   {validartabla.i "Familia_retsuss" "cdg_famretsuss" "dsc_famretsuss" "ARTI019"} 
   
   &UNDEFINE TABLA-MAESTRA

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   &SCOPED-DEFINE TABLA-MAESTRA  Articulo

   {asignartabla.i "Tipo_articulo" "cdg_tipoart" "cdg_tipoart"} 
   {asignartabla.i "Familia_articulo" "nro_familia" "nro_familia"} 
   {asignartabla.i "Familia_impositiva" "nro_familimpos" "nro_familimpos"} 
   {asignartabla.i "Unidad" "cdg_umed" "cdg_umed"}
   {asignartabla.i "Ucompra" "cdg_umed" "cdg_ucompra"}
   {asignartabla.i "Ugranel" "cdg_umed" "cdg_ugranel"}
   {asignartabla.i "Marca_comercial" "cdg_marcacom" "cdg_marcacom"}
   {asignartabla.i "Envases" "cdg_envases" "cdg_envases"}
   {asignartabla.i "Familia_ganancias" "cdg_famganancias" "cdg_famganancias"} 
   {asignartabla.i "Familia_retiva" "cdg_famretiva" "cdg_famretiva"} 
   {asignartabla.i "Familia_retibr" "cdg_famretibr" "cdg_famretibr"} 
   {asignartabla.i "Familia_retsuss" "cdg_famretsuss" "cdg_famretsuss"} 
   
   &UNDEFINE TABLA-MAESTRA

   ASSIGN FRAME {&FRAME-NAME} Articulo.descripcion.
   RUN pcname1.p ( OUTPUT pcname ).

   IF NEW Articulo
   THEN DO:
       ASSIGN Articulo.nro_articulo = NEXT-VALUE(proximo_articulo)
              Articulo.sumaneto     = 1
              Articulo.fecha_grab   = TODAY
              Articulo.hora_grab    = TIME
/*               Articulo.nro_usuario  = Usuario.nro_usuario  */
              Articulo.pc_name      = pcname.
       IF NOT Articulo.hay_partida 
       THEN DO:
           {findempresa.i}
           CREATE Partida.
           ASSIGN Partida.cdg_empresa  = Empresa.cdg_empresa
                  Partida.cdg_partida  = ""
                  Partida.descripcion  = "Partida Unica"
                  Partida.fecha_alta   = TODAY
                  Partida.nro_articulo = Articulo.nro_articulo
                  Partida.nro_partida  = 0.
       END.
   END.

   IF lista_atributos <> ""
   THEN DO:
        RUN agregar_atributos ( INPUT Articulo.nro_articulo, INPUT lista_atributos ).
   END.

   IF Articulo.cdg_estado = "B"
   THEN DO:
        Articulo.fecha_baja = TODAY.
   END.
   ELSE DO:
        Articulo.fecha_baja = ?.
   END.

   ASSIGN FRAME {&FRAME-NAME} v-lista_sectores.
   RUN tratar_lista_permisos.p ( INPUT v-lista_sectores, OUTPUT Articulo.lista_sectores, INPUT "UNIR" ).
   articulo.nro_tipo_evento = c_nro_tipo_evento.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-delete-record V-table-Win 
PROCEDURE local-delete-record :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

   DEFINE VARIABLE baja_no AS LOGICAL.
   baja_no = FALSE.
   FOR EACH partida OF articulo:
    RUN vlb-partidas.p(INPUT ROWID(partida) , OUTPUT baja_no ).
    IF baja_no = TRUE THEN LEAVE.
   END.
   IF baja_no 
   THEN DO:
        RUN PONMENSJ.P ( "IREF001" ).
        RETURN ERROR.
   END.        
   RUN vlb-articulos.p ( INPUT ROWID(Articulo), OUTPUT baja_no ).
   IF baja_no 
   THEN DO:
        RUN PONMENSJ.P ( "IREF001" ).
        RETURN ERROR.
   END.        

  /* Dispatch standard ADM method.                             */
  FOR EACH partida OF articulo:
        DELETE partida.
  END.
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'delete-record':U ) .
  

  /* Code placed here will execute AFTER standard behavior.    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-disable-fields V-table-Win 
PROCEDURE local-disable-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'disable-fields':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  {deshabcodigo.i "Tipo_articulo"} 
  {deshabcodigo.i "Familia_articulo"} 
  {deshabcodigo.i "Familia_impositiva"} 
  {deshabcodigo.i "Familia_ganancias"}
  {deshabcodigo.i "Familia_retiva"}
  {deshabcodigo.i "Familia_retibr"}
  {deshabcodigo.i "Familia_retsuss"}

  {deshabcodigo.i "Unidad"}
  {deshabcodigo.i "Ucompra"}
  {deshabcodigo.i "Ugranel"}
  {deshabcodigo.i "Marca_comercial"}
  {deshabcodigo.i "Envases"}
  
  btn_clasificar:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
  btn_elegir:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
  v-lista_sectores:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
  btn_elegir-sector:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
  c_nro_tipo_evento:SENSITIVE IN FRAME {&FRAME-NAME} = NO.

  /*  v-lista_empresas:SENSITIVE IN FRAME {&FRAME-NAME} = NO.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-display-fields V-table-Win 
PROCEDURE local-display-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'display-fields':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  IF AVAILABLE Articulo
  THEN DO:

        &SCOPED-DEFINE TABLA-MAESTRA  Articulo

        {displaytabla.i "Tipo_articulo" "cdg_tipoart" "dsc_tipoart" "cdg_tipoart" "cdg_tipoart"} 
        {displaytabla.i "Familia_articulo" "cdg_familia" "dsc_familia" "nro_familia" "nro_familia"} 
        {displaytabla.i "Familia_impositiva" "cdg_familimpos" "dsc_familimpos" "nro_familimpos" "nro_familimpos"} 
        {displaytabla.i "Familia_ganancias" "cdg_famganancias" "dsc_famganancias" "cdg_famganancias" "cdg_famganancias"} 
        {displaytabla.i "Familia_retiva" "cdg_famretiva" "dsc_famretiva" "cdg_famretiva" "cdg_famretiva"} 
        {displaytabla.i "Familia_retibr" "cdg_famretibr" "dsc_famretibr" "cdg_famretibr" "cdg_famretibr"} 
        {displaytabla.i "Familia_retsuss" "cdg_famretsuss" "dsc_famretsuss" "cdg_famretsuss" "cdg_famretsuss"} 
        {displaytabla.i "Unidad" "cdg_umed" "descripcion_unidad" "cdg_umed" "cdg_umed"}
        {displaytabla.i "Ucompra" "cdg_umed" "descripcion_unidad" "cdg_umed" "cdg_ucompra"}
        {displaytabla.i "Ugranel" "cdg_umed" "descripcion_unidad" "cdg_umed" "cdg_ugranel"}
        {displaytabla.i "Marca_comercial" "cdg_marcacom" "dsc_marcacom" "cdg_marcacom" "cdg_marcacom"}
        {displaytabla.i "Envases" "cdg_envases" "dsc_envases" "cdg_envases" "cdg_envases"}
        
        RUN poner_familiarticulo.

        RUN tratar_lista_permisos.p ( INPUT Articulo.lista_sectores, OUTPUT v-lista_sectores, INPUT "SEPARAR" ).

        DISPLAY v-lista_sectores
                WITH FRAME {&FRAME-NAME}.
        c_nro_tipo_evento:SCREEN-VALUE  = string(articulo.nro_tipo_evento).
        DISPLAY articulo.cdg_estado WITH FRAME {&FRAME-NAME}.


  END.
  ELSE DO:

      {blanqueacodigo.i "Tipo_articulo"} 
      {blanqueacodigo.i "Familia_articulo"} 
      {blanqueacodigo.i "Familia_impositiva"}
      {blanqueacodigo.i "Familia_ganancias"}
      {blanqueacodigo.i "Familia_retiva"}
      {blanqueacodigo.i "Familia_retibr"}
      {blanqueacodigo.i "Familia_retsuss"}
      {blanqueacodigo.i "Unidad"}
      {blanqueacodigo.i "Ucompra"}
      {blanqueacodigo.i "Ugranel"}
      {blanqueacodigo.i "Marca_comercial"}
      {blanqueacodigo.i "Envases"}

      
  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-enable-fields V-table-Win 
PROCEDURE local-enable-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'enable-fields':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  {habilcodigo.i "Tipo_articulo"} 
  {habilcodigo.i "Familia_articulo"} 
  {habilcodigo.i "Familia_impositiva"} 
  {habilcodigo.i "Familia_ganancias"}
  {habilcodigo.i "Familia_retiva"}
  {habilcodigo.i "Familia_retibr"}
  {habilcodigo.i "Familia_retsuss"}
  {habilcodigo.i "Unidad"}
  {habilcodigo.i "Ucompra"}
  {habilcodigo.i "Ugranel"}
  {habilcodigo.i "Marca_comercial"}
  {habilcodigo.i "Envases"}
  
   btn_clasificar:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
   btn_elegir:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
   v-lista_sectores:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
   btn_elegir-sector:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
   c_nro_tipo_evento:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
/*   v-lista_empresas:SENSITIVE IN FRAME {&FRAME-NAME} = YES.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize V-table-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR lista AS CHAR NO-UNDO.
  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .
  DO WITH FRAME {&FRAME-NAME}:
     {levantacombo.i &TABLA=Tipo_evento &NOMBRE=cdg_tipo_evento &CODIGO=nro_tipo_evento &OBJETO=c_nro_tipo_evento}
  END.
  /* Code placed here will execute AFTER standard behavior.    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_familiarticulo V-table-Win 
PROCEDURE poner_familiarticulo :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  FIND Tipo_familiarticulo OF Familia_articulo.
  v-dsc_tipofamilia =  Tipo_familiarticulo.dsc_tipofamilia.
  DISPLAY v-dsc_tipofamilia
          WITH FRAME {&FRAME-NAME}.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records V-table-Win  _ADM-SEND-RECORDS
PROCEDURE send-records :
/*------------------------------------------------------------------------------
  Purpose:     Send record ROWID's for all tables used by
               this file.
  Parameters:  see template/snd-head.i
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.               */
  {src/adm/template/snd-head.i}

  /* For each requested table, put it's ROWID in the output list.      */
  {src/adm/template/snd-list.i "Articulo"}

  /* Deal with any unexpected table requests before closing.           */
  {src/adm/template/snd-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE state-changed V-table-Win 
PROCEDURE state-changed :
/* -----------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-------------------------------------------------------------*/
  DEFINE INPUT PARAMETER p-issuer-hdl AS HANDLE    NO-UNDO.
  DEFINE INPUT PARAMETER p-state      AS CHARACTER NO-UNDO.

  CASE p-state:
      /* Object instance CASEs can go here to replace standard behavior
         or add new cases. */
      {src/adm/template/vstates.i}
  END CASE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

