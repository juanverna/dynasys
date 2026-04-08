&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
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

DEFINE BUFFER Imp-ajuste      FOR Cuenta.
DEFINE BUFFER Imp-variac      FOR Cuenta.
DEFINE BUFFER Imp-ventas      FOR Cuenta.
DEFINE BUFFER Imp-costo       FOR Cuenta.
DEFINE BUFFER Imp-consumo     FOR Cuenta.
DEFINE BUFFER Imp-pendte      FOR Cuenta.
DEFINE BUFFER Imp-existencia  FOR Cuenta.

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
&Scoped-define EXTERNAL-TABLES Familia_articulo
&Scoped-define FIRST-EXTERNAL-TABLE Familia_articulo


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Familia_articulo.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Familia_articulo.cdg_familia ~
Familia_articulo.dsc_familia Familia_articulo.lista_empresas ~
Familia_articulo.inventario_sino Familia_articulo.ventas_sino ~
Familia_articulo.compras_sino Familia_articulo.produccion_sino ~
Familia_articulo.observacion 
&Scoped-define ENABLED-TABLES Familia_articulo
&Scoped-define FIRST-ENABLED-TABLE Familia_articulo
&Scoped-Define ENABLED-OBJECTS RECT-7 
&Scoped-Define DISPLAYED-FIELDS Familia_articulo.cdg_familia ~
Familia_articulo.dsc_familia Familia_articulo.lista_empresas ~
Familia_articulo.inventario_sino Familia_articulo.ventas_sino ~
Familia_articulo.compras_sino Familia_articulo.produccion_sino ~
Familia_articulo.observacion 
&Scoped-define DISPLAYED-TABLES Familia_articulo
&Scoped-define FIRST-DISPLAYED-TABLE Familia_articulo
&Scoped-Define DISPLAYED-OBJECTS v-cdg_Imp-ajuste v-dsc_Imp-ajuste ~
v-cdg_Imp-consumo v-dsc_Imp-consumo v-cdg_Imp-costo v-dsc_Imp-costo ~
v-cdg_Imp-variac v-dsc_Imp-variac v-cdg_Imp-pendte v-dsc_Imp-pendte ~
v-cdg_Imp-existencia v-dsc_Imp-existencia v-cdg_tipo_familiarticulo ~
v-dsc_tipo_familiarticulo 

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
DEFINE BUTTON btn_elegir 
     LABEL "E&legir" 
     SIZE 15 BY 1.

DEFINE VARIABLE v-cdg_Imp-ajuste AS CHARACTER FORMAT "X(12)":U 
     LABEL "Ajuste Inv." 
     VIEW-AS FILL-IN NATIVE 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cdg_Imp-consumo AS CHARACTER FORMAT "X(12)":U 
     LABEL "Consumo" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cdg_Imp-costo AS CHARACTER FORMAT "X(12)":U 
     LABEL "Costo Ventas" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cdg_Imp-existencia AS CHARACTER FORMAT "X(12)":U 
     LABEL "Existencias" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cdg_Imp-pendte AS CHARACTER FORMAT "X(12)":U 
     LABEL "Recepción" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cdg_Imp-variac AS CHARACTER FORMAT "X(12)":U 
     LABEL "Dif. Costo" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cdg_tipo_familiarticulo AS CHARACTER FORMAT "X(12)":U 
     LABEL "Tipo Familia" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-dsc_Imp-ajuste AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 47 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_Imp-consumo AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 47 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_Imp-costo AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 47 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_Imp-existencia AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 47 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_Imp-pendte AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 47 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_Imp-variac AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 47 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_tipo_familiarticulo AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 47 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 81 BY 18.81.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Familia_articulo.cdg_familia AT ROW 1.29 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 12.8 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Familia_articulo.dsc_familia AT ROW 2.43 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 62 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Familia_articulo.lista_empresas AT ROW 3.62 COL 14 COLON-ALIGNED
          LABEL "Empresas"
          VIEW-AS FILL-IN NATIVE 
          SIZE 46 BY 1
          BGCOLOR 15 FGCOLOR 9 
     btn_elegir AT ROW 3.62 COL 63
     Familia_articulo.inventario_sino AT ROW 4.81 COL 61
          LABEL "Inventario"
          VIEW-AS TOGGLE-BOX
          SIZE 14 BY .76
     Familia_articulo.ventas_sino AT ROW 4.86 COL 16
          LABEL "Ventas"
          VIEW-AS TOGGLE-BOX
          SIZE 11 BY .76
     Familia_articulo.compras_sino AT ROW 5.76 COL 16
          LABEL "Compras"
          VIEW-AS TOGGLE-BOX
          SIZE 11 BY .76
     Familia_articulo.produccion_sino AT ROW 5.86 COL 61
          LABEL "Producción"
          VIEW-AS TOGGLE-BOX
          SIZE 15 BY .76
     v-cdg_Imp-ajuste AT ROW 6.95 COL 14 COLON-ALIGNED
     v-dsc_Imp-ajuste AT ROW 6.95 COL 29 COLON-ALIGNED NO-LABEL
     v-cdg_Imp-consumo AT ROW 8.14 COL 14 COLON-ALIGNED
     v-dsc_Imp-consumo AT ROW 8.14 COL 29 COLON-ALIGNED NO-LABEL
     v-cdg_Imp-costo AT ROW 9.33 COL 14 COLON-ALIGNED
     v-dsc_Imp-costo AT ROW 9.33 COL 29 COLON-ALIGNED NO-LABEL
     v-cdg_Imp-variac AT ROW 10.52 COL 14 COLON-ALIGNED
     v-dsc_Imp-variac AT ROW 10.52 COL 29 COLON-ALIGNED NO-LABEL
     v-cdg_Imp-pendte AT ROW 11.71 COL 14 COLON-ALIGNED
     v-dsc_Imp-pendte AT ROW 11.71 COL 29 COLON-ALIGNED NO-LABEL
     v-cdg_Imp-existencia AT ROW 12.91 COL 14 COLON-ALIGNED
     v-dsc_Imp-existencia AT ROW 12.91 COL 29 COLON-ALIGNED NO-LABEL
     v-cdg_tipo_familiarticulo AT ROW 14.1 COL 14 COLON-ALIGNED
     v-dsc_tipo_familiarticulo AT ROW 14.1 COL 29 COLON-ALIGNED NO-LABEL
     Familia_articulo.observacion AT ROW 15.29 COL 4 NO-LABEL
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 74 BY 3.19
          BGCOLOR 15 FGCOLOR 7 
     RECT-7 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Familia_articulo
   Allow: Basic,DB-Fields
   Frames: 1
   Add Fields to: EXTERNAL-TABLES
   Other Settings: PERSISTENT-ONLY COMPILE
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
         HEIGHT             = 19.67
         WIDTH              = 109.4.
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

/* SETTINGS FOR BUTTON btn_elegir IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR TOGGLE-BOX Familia_articulo.compras_sino IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR TOGGLE-BOX Familia_articulo.inventario_sino IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Familia_articulo.lista_empresas IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR TOGGLE-BOX Familia_articulo.produccion_sino IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN v-cdg_Imp-ajuste IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_Imp-consumo IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_Imp-costo IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_Imp-existencia IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_Imp-pendte IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_Imp-variac IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_tipo_familiarticulo IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_Imp-ajuste IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_Imp-consumo IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_Imp-costo IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_Imp-existencia IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_Imp-pendte IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_Imp-variac IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_tipo_familiarticulo IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR TOGGLE-BOX Familia_articulo.ventas_sino IN FRAME F-Main
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

&Scoped-define SELF-NAME btn_elegir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_elegir V-table-Win
ON CHOOSE OF btn_elegir IN FRAME F-Main /* Elegir */
DO:
  DEFINE VARIABLE v-lista_empresas AS CHARACTER.
  v-lista_empresas = Familia_articulo.lista_empresas:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
  RUN selcodempresa.p ( INPUT-OUTPUT v-lista_empresas ).
  Familia_articulo.lista_empresas:SCREEN-VALUE IN FRAME {&FRAME-NAME} = v-lista_empresas.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_Imp-ajuste
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_Imp-ajuste V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_Imp-ajuste IN FRAME F-Main /* Ajuste Inv. */
OR "." OF v-cdg_Imp-ajuste IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_Imp-ajuste IN FRAME {&FRAME-NAME}
DO:

  &SCOPED-DEFINE ROWID_TABLA    rid_ajuste
  &SCOPED-DEFINE SELECCION      SELCUENT.p
  &SCOPED-DEFINE TABLA          Imp-ajuste
  &SCOPED-DEFINE V-CDG_TABLA    v-cdg_Imp-ajuste
  &SCOPED-DEFINE CDG_TABLA      cdg_cuenta
  &SCOPED-DEFINE MOSTRAR_DSC    YES 
  &SCOPED-DEFINE V-DSC_TABLA    v-dsc_Imp-ajuste
  &SCOPED-DEFINE DSC_TABLA      nombre_cta

  {hlptabla-var.i}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_Imp-ajuste V-table-Win
ON RETURN OF v-cdg_Imp-ajuste IN FRAME F-Main /* Ajuste Inv. */
DO:
   {traducetabla.i "Imp-ajuste" "cdg_cuenta" "nombre_cta"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_Imp-consumo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_Imp-consumo V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_Imp-consumo IN FRAME F-Main /* Consumo */
OR "." OF v-cdg_Imp-consumo IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_Imp-consumo IN FRAME {&FRAME-NAME}
DO:

  &SCOPED-DEFINE ROWID_TABLA    rid_consumo
  &SCOPED-DEFINE SELECCION      SELCUENT.p
  &SCOPED-DEFINE TABLA          Imp-consumo
  &SCOPED-DEFINE V-CDG_TABLA    v-cdg_Imp-consumo
  &SCOPED-DEFINE CDG_TABLA      cdg_cuenta
  &SCOPED-DEFINE MOSTRAR_DSC    YES 
  &SCOPED-DEFINE V-DSC_TABLA    v-dsc_Imp-consumo
  &SCOPED-DEFINE DSC_TABLA      nombre_cta

  {hlptabla-var.i}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_Imp-consumo V-table-Win
ON RETURN OF v-cdg_Imp-consumo IN FRAME F-Main /* Consumo */
DO:
   {traducetabla.i "Imp-consumo" "cdg_cuenta" "nombre_cta"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_Imp-costo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_Imp-costo V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_Imp-costo IN FRAME F-Main /* Costo Ventas */
OR "." OF v-cdg_Imp-costo IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_Imp-costo IN FRAME {&FRAME-NAME}
DO:

  &SCOPED-DEFINE ROWID_TABLA    rid_costo
  &SCOPED-DEFINE SELECCION      SELCUENT.p
  &SCOPED-DEFINE TABLA          Imp-costo
  &SCOPED-DEFINE V-CDG_TABLA    v-cdg_Imp-costo
  &SCOPED-DEFINE CDG_TABLA      cdg_cuenta
  &SCOPED-DEFINE MOSTRAR_DSC    YES 
  &SCOPED-DEFINE V-DSC_TABLA    v-dsc_Imp-costo
  &SCOPED-DEFINE DSC_TABLA      nombre_cta

  {hlptabla-var.i}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_Imp-costo V-table-Win
ON RETURN OF v-cdg_Imp-costo IN FRAME F-Main /* Costo Ventas */
DO:
   {traducetabla.i "Imp-costo" "cdg_cuenta" "nombre_cta"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_Imp-existencia
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_Imp-existencia V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_Imp-existencia IN FRAME F-Main /* Existencias */
OR "." OF v-cdg_Imp-existencia IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_Imp-existencia IN FRAME {&FRAME-NAME}
DO:

  &SCOPED-DEFINE ROWID_TABLA    rid_existencia
  &SCOPED-DEFINE SELECCION      SELCUENT.p
  &SCOPED-DEFINE TABLA          Imp-existencia
  &SCOPED-DEFINE V-CDG_TABLA    v-cdg_Imp-existencia
  &SCOPED-DEFINE CDG_TABLA      cdg_cuenta
  &SCOPED-DEFINE MOSTRAR_DSC    YES 
  &SCOPED-DEFINE V-DSC_TABLA    v-dsc_Imp-existencia
  &SCOPED-DEFINE DSC_TABLA      nombre_cta

  {hlptabla-var.i}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_Imp-existencia V-table-Win
ON RETURN OF v-cdg_Imp-existencia IN FRAME F-Main /* Existencias */
DO:
   {traducetabla.i "Imp-existencia" "cdg_cuenta" "nombre_cta"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_Imp-pendte
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_Imp-pendte V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_Imp-pendte IN FRAME F-Main /* Recepción */
OR "." OF v-cdg_Imp-pendte IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_Imp-pendte IN FRAME {&FRAME-NAME}
DO:

  &SCOPED-DEFINE ROWID_TABLA    rid_pendte
  &SCOPED-DEFINE SELECCION      SELCUENT.p
  &SCOPED-DEFINE TABLA          Imp-pendte
  &SCOPED-DEFINE V-CDG_TABLA    v-cdg_Imp-pendte
  &SCOPED-DEFINE CDG_TABLA      cdg_cuenta
  &SCOPED-DEFINE MOSTRAR_DSC    YES 
  &SCOPED-DEFINE V-DSC_TABLA    v-dsc_Imp-pendte
  &SCOPED-DEFINE DSC_TABLA      nombre_cta

  {hlptabla-var.i}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_Imp-pendte V-table-Win
ON RETURN OF v-cdg_Imp-pendte IN FRAME F-Main /* Recepción */
DO:
   {traducetabla.i "Imp-pendte" "cdg_cuenta" "nombre_cta"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_Imp-variac
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_Imp-variac V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_Imp-variac IN FRAME F-Main /* Dif. Costo */
OR "." OF v-cdg_Imp-variac IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_Imp-variac IN FRAME {&FRAME-NAME}
DO:

  &SCOPED-DEFINE ROWID_TABLA    rid_variac
  &SCOPED-DEFINE SELECCION      SELCUENT.p
  &SCOPED-DEFINE TABLA          Imp-variac
  &SCOPED-DEFINE V-CDG_TABLA    v-cdg_Imp-variac
  &SCOPED-DEFINE CDG_TABLA      cdg_cuenta
  &SCOPED-DEFINE MOSTRAR_DSC    YES 
  &SCOPED-DEFINE V-DSC_TABLA    v-dsc_Imp-variac
  &SCOPED-DEFINE DSC_TABLA      nombre_cta

  {hlptabla-var.i}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_Imp-variac V-table-Win
ON RETURN OF v-cdg_Imp-variac IN FRAME F-Main /* Dif. Costo */
DO:
   {traducetabla.i "Imp-variac" "cdg_cuenta" "nombre_cta"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_tipo_familiarticulo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_tipo_familiarticulo V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_tipo_familiarticulo IN FRAME F-Main /* Tipo Familia */
OR "." OF v-cdg_tipo_familiarticulo IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_tipo_familiarticulo IN FRAME {&FRAME-NAME}
DO:

  &SCOPED-DEFINE ROWID_TABLA    rid_ajuste
                                
  &SCOPED-DEFINE SELECCION      SELTIPOFAMILIA.P
  &SCOPED-DEFINE TABLA          Tipo_familiarticulo
  &SCOPED-DEFINE V-CDG_TABLA    v-cdg_tipo_familiarticulo
  &SCOPED-DEFINE CDG_TABLA      cdg_tipofamilia
  &SCOPED-DEFINE MOSTRAR_DSC    YES 
  &SCOPED-DEFINE V-DSC_TABLA    v-dsc_tipo_familiarticulo
  &SCOPED-DEFINE DSC_TABLA      dsc_tipofamilia

  {hlptabla-var.i}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_tipo_familiarticulo V-table-Win
ON RETURN OF v-cdg_tipo_familiarticulo IN FRAME F-Main /* Tipo Familia */
DO:
   {traducetabla.i "Tipo_familiarticulo" "cdg_tipofamilia" "dsc_tipofamilia"} 
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
  {src/adm/template/row-list.i "Familia_articulo"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Familia_articulo"}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

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

   {blanqueacodigo.i "Imp-ajuste"}
   {blanqueacodigo.i "Imp-consumo"}
   {blanqueacodigo.i "Imp-costo"}
   {blanqueacodigo.i "Imp-pendte"}
   {blanqueacodigo.i "Imp-existencia"}
   {blanqueacodigo.i "Imp-variac"} 
   {blanqueacodigo.i "Tipo_familiarticulo"}

   {findempresa.i}

   Familia_articulo.lista_empresas:SCREEN-VALUE IN FRAME {&FRAME-NAME} = Empresa.cdg_empresa.

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

   &SCOPED-DEFINE TABLA-MAESTRA  Familia_articulo

    {validartabla.i "Imp-ajuste"  "cdg_cuenta" "nombre_cta" "FAMR005"}
    {validartabla.i "Imp-consumo" "cdg_cuenta" "nombre_cta" "FAMR006"}
    {validartabla.i "Imp-costo"   "cdg_cuenta" "nombre_cta" "FAMR007"}
    {validartabla.i "Imp-pendte"  "cdg_cuenta" "nombre_cta" "FAMR008"}
    {validartabla.i "Imp-existencia"  "cdg_cuenta" "nombre_cta" "FAMR011"}
    {validartabla.i "Imp-variac"  "cdg_cuenta" "nombre_cta" "FAMR009"} 
    {validartabla.i "Tipo_familiarticulo"  "cdg_tipofamilia" "dsc_tipofamilia" "FAMR012"} 

   &UNDEFINE TABLA-MAESTRA

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   &SCOPED-DEFINE TABLA-MAESTRA  Familia_articulo

    {asignartabla.i "Imp-ajuste"  "nro_cuenta" "nro_cuenta_ajuste"}
    {asignartabla.i "Imp-consumo" "nro_cuenta" "nro_cuenta_consumo"}
    {asignartabla.i "Imp-costo"   "nro_cuenta" "nro_cuenta_costo"}
    {asignartabla.i "Imp-pendte"  "nro_cuenta" "nro_cuenta_pendte"}
    {asignartabla.i "Imp-existencia"  "nro_cuenta" "nro_cuenta_existencia"}
    {asignartabla.i "Imp-variac"  "nro_cuenta" "nro_cuenta_variacion"} 
    {asignartabla.i "Tipo_familiarticulo"  "cdg_tipofamilia" "cdg_tipofamilia"}

   &UNDEFINE TABLA-MAESTRA

   IF NEW Familia_articulo
      THEN ASSIGN Familia_articulo.nro_familia = NEXT-VALUE(proxima_familia).

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
   RUN vlb-famarticulos.p ( INPUT ROWID(Familia_articulo), OUTPUT baja_no ).
   IF baja_no 
   THEN DO:
        RUN PONMENSJ.P ( "IREF001" ).
        RETURN ERROR.
   END.        

  /* Dispatch standard ADM method.                             */
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
   
   {deshabcodigo.i "Imp-ajuste"}
   {deshabcodigo.i "Imp-consumo"}
   {deshabcodigo.i "Imp-costo"}
   {deshabcodigo.i "Imp-pendte"}
   {deshabcodigo.i "Imp-existencia"}
   {deshabcodigo.i "Imp-variac"} 
   {deshabcodigo.i "Tipo_familiarticulo"}
   
   Familia_articulo.observacion:FGCOLOR IN FRAME {&FRAME-NAME} = 7.

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

  IF AVAILABLE Familia_articulo
  THEN DO:

        &SCOPED-DEFINE TABLA-MAESTRA  Familia_articulo
     
        {displaytabla.i "Imp-ajuste"  "cdg_cuenta" "nombre_cta" "nro_cuenta" "nro_cuenta_ajuste"}
        {displaytabla.i "Imp-consumo" "cdg_cuenta" "nombre_cta" "nro_cuenta" "nro_cuenta_consumo"}
        {displaytabla.i "Imp-costo"   "cdg_cuenta" "nombre_cta" "nro_cuenta" "nro_cuenta_costo"}
        {displaytabla.i "Imp-pendte"  "cdg_cuenta" "nombre_cta" "nro_cuenta" "nro_cuenta_pendte"}
        {displaytabla.i "Imp-existencia"  "cdg_cuenta" "nombre_cta" "nro_cuenta" "nro_cuenta_existencia"}
        {displaytabla.i "Imp-variac"  "cdg_cuenta" "nombre_cta" "nro_cuenta" "nro_cuenta_variacion"} 
        {displaytabla.i "Tipo_familiarticulo"  "cdg_tipofamilia" "dsc_tipofamilia" "cdg_tipofamilia" "cdg_tipofamilia"} 
        

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

   {habilcodigo.i "Imp-ajuste"}
   {habilcodigo.i "Imp-consumo"}
   {habilcodigo.i "Imp-costo"}
   {habilcodigo.i "Imp-pendte"}
   {habilcodigo.i "Imp-existencia"}
   {habilcodigo.i "Imp-variac"} 
   {habilcodigo.i "Tipo_familiarticulo"}
  

   Familia_articulo.observacion:FGCOLOR IN FRAME {&FRAME-NAME} = 9.


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
  {src/adm/template/snd-list.i "Familia_articulo"}

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

