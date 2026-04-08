&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW


/* Temp-Table and Buffer definitions                                    */
DEFINE BUFFER Administrador FOR Cliente.
DEFINE BUFFER B-Cliente FOR Cliente.



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

DEFINE VARIABLE rid_tabla     AS ROWID.
DEFINE VARIABLE combos_listos AS LOGICAL INITIAL NO.
DEFINE VARIABLE es_alta       AS LOGICAL.
DEFINE VARIABLE hay_error_interface AS LOGICAL.

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
&Scoped-define EXTERNAL-TABLES Cliente
&Scoped-define FIRST-EXTERNAL-TABLE Cliente


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Cliente.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Cliente.cdg_cliente Cliente.credito_maximo ~
Cliente.cdg_estado Cliente.nom_cliente Cliente.fecha_alta ~
Cliente.fecha_baja Cliente.nom_fantasia Cliente.ref_proveedor Cliente.cuit ~
Cliente.paga_abasto Cliente.agrupa_remitos Cliente.permite_nominar ~
Cliente.tiene_ctacte Cliente.condensado_sino Cliente.clausula_dolar ~
Cliente.cdg_famclie Cliente.lista_mail Cliente.prc_mincambio ~
Cliente.prc_difcambio Cliente.cdg_tipoclie Cliente.lista_sectores ~
Cliente.lista_empresas Cliente.direccion Cliente.cdg_pais ~
Cliente.cdg_postal Cliente.localidad Cliente.cdg_provincia ~
Cliente.telefonos 
&Scoped-define ENABLED-TABLES Cliente
&Scoped-define FIRST-ENABLED-TABLE Cliente
&Scoped-Define ENABLED-OBJECTS RECT-1 RECT-2 RECT-7 v-verificar bVer 
&Scoped-Define DISPLAYED-FIELDS Cliente.cdg_cliente Cliente.credito_maximo ~
Cliente.cdg_estado Cliente.nom_cliente Cliente.fecha_alta ~
Cliente.fecha_baja Cliente.nom_fantasia Cliente.ref_proveedor ~
Cliente.nro_cliente Cliente.cuit Cliente.paga_abasto Cliente.agrupa_remitos ~
Cliente.permite_nominar Cliente.tiene_ctacte Cliente.condensado_sino ~
Cliente.clausula_dolar Cliente.cdg_famclie Cliente.lista_mail ~
Cliente.prc_mincambio Cliente.prc_difcambio Cliente.cdg_tipoclie ~
Cliente.lista_sectores Cliente.lista_empresas Cliente.direccion ~
Cliente.cdg_pais Cliente.cdg_postal Cliente.localidad Cliente.cdg_provincia ~
Cliente.telefonos 
&Scoped-define DISPLAYED-TABLES Cliente
&Scoped-define FIRST-DISPLAYED-TABLE Cliente
&Scoped-Define DISPLAYED-OBJECTS v-cdg_lista_precios v-dsc_lista_precios ~
v-verificar v-cdg_condicion_impos v-dsc_condicion_impos ~
v-cdg_condicion_venta v-dsc_condicion_venta v-cdg_vendedor v-dsc_vendedor ~
v-cdg_cobrador v-dsc_cobrador v-cdg_grupo-empresario v-dsc_grupo-empresario ~
v-cdg_entidad v-dsc_entidad v-cdg_administrador v-dsc_administrador 

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
     SIZE 10 BY 1.

DEFINE BUTTON btn_elegir-2 
     LABEL "El&egir" 
     SIZE 10 BY 1.

DEFINE BUTTON bVer 
     LABEL "Ver" 
     SIZE 10 BY 1.

DEFINE VARIABLE v-cdg_administrador AS CHARACTER FORMAT "X(8)" 
     LABEL "Administ." 
     VIEW-AS FILL-IN NATIVE 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_cobrador AS CHARACTER FORMAT "X(8)" 
     LABEL "Cobrador" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_condicion_impos AS INTEGER FORMAT ">>>9" INITIAL 0 
     LABEL "Cond.Impos." 
     VIEW-AS FILL-IN NATIVE 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_condicion_venta AS CHARACTER FORMAT "X(8)" 
     LABEL "Cond. Venta" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_entidad AS CHARACTER FORMAT "X(8)" 
     LABEL "C.Costo" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_grupo-empresario AS CHARACTER FORMAT "X(8)" 
     LABEL "Grupo" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_lista_precios AS INTEGER FORMAT ">>>>>>9" INITIAL 0 
     LABEL "Lista" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_vendedor AS CHARACTER FORMAT "X(8)" 
     LABEL "Vendedor" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-dsc_administrador AS CHARACTER FORMAT "X(35)" 
     VIEW-AS FILL-IN 
     SIZE 40 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_cobrador AS CHARACTER FORMAT "X(35)" 
     VIEW-AS FILL-IN 
     SIZE 52 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_condicion_impos AS CHARACTER FORMAT "X(35)" 
     VIEW-AS FILL-IN 
     SIZE 52 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_condicion_venta AS CHARACTER FORMAT "X(35)" 
     VIEW-AS FILL-IN 
     SIZE 52 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_entidad AS CHARACTER FORMAT "X(35)" 
     VIEW-AS FILL-IN 
     SIZE 52 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_grupo-empresario AS CHARACTER FORMAT "X(35)" 
     VIEW-AS FILL-IN 
     SIZE 52 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_lista_precios AS CHARACTER FORMAT "X(35)" 
     VIEW-AS FILL-IN 
     SIZE 52 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_vendedor AS CHARACTER FORMAT "X(35)" 
     VIEW-AS FILL-IN 
     SIZE 52 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 126 BY 4.05.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 126 BY 15.95.

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 33 BY 4.05.

DEFINE VARIABLE v-verificar AS LOGICAL INITIAL yes 
     LABEL "" 
     VIEW-AS TOGGLE-BOX
     SIZE 3 BY 1 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Cliente.cdg_cliente AT ROW 1.24 COL 13 COLON-ALIGNED
          LABEL "Código"
          VIEW-AS FILL-IN NATIVE 
          SIZE 27 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.credito_maximo AT ROW 1.24 COL 61 COLON-ALIGNED
          LABEL "Créd.Máx." FORMAT "ZZZZZZ9"
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.cdg_estado AT ROW 1.24 COL 90 COLON-ALIGNED
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Activo","A",
                     "Inactivo","I",
                     "Potencial","P"
          DROP-DOWN-LIST
          SIZE 33 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.nom_cliente AT ROW 2.43 COL 13 COLON-ALIGNED
          LABEL "R.Social"
          VIEW-AS FILL-IN NATIVE 
          SIZE 66 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.fecha_alta AT ROW 2.43 COL 90 COLON-ALIGNED
          LABEL "Alta"
          VIEW-AS FILL-IN NATIVE 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.fecha_baja AT ROW 2.43 COL 110 COLON-ALIGNED
          LABEL "Baja"
          VIEW-AS FILL-IN NATIVE 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.nom_fantasia AT ROW 3.62 COL 13 COLON-ALIGNED
          LABEL "N.Fantasía"
          VIEW-AS FILL-IN NATIVE 
          SIZE 66 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.ref_proveedor AT ROW 3.62 COL 90 COLON-ALIGNED
          LABEL "Prov."
          VIEW-AS FILL-IN NATIVE 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.nro_cliente AT ROW 3.62 COL 114 COLON-ALIGNED
          LABEL "Carpeta"
          VIEW-AS FILL-IN 
          SIZE 9 BY 1
          BGCOLOR 15 FGCOLOR 2 
     v-cdg_lista_precios AT ROW 4.81 COL 13 COLON-ALIGNED
     v-dsc_lista_precios AT ROW 4.81 COL 27 COLON-ALIGNED HELP
          "Denominacion" NO-LABEL
     Cliente.cuit AT ROW 4.81 COL 90 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 29 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-verificar AT ROW 4.81 COL 122
     v-cdg_condicion_impos AT ROW 6 COL 13 COLON-ALIGNED
     v-dsc_condicion_impos AT ROW 6 COL 27 COLON-ALIGNED HELP
          "Denominacion" NO-LABEL
     Cliente.paga_abasto AT ROW 6 COL 90 COLON-ALIGNED
          LABEL "Abasto"
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Nunca Paga","N",
                     "Según Operación","D",
                     "Siempre Paga","S"
          DROP-DOWN-LIST
          SIZE 33 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_condicion_venta AT ROW 7.19 COL 13 COLON-ALIGNED
     v-dsc_condicion_venta AT ROW 7.19 COL 27 COLON-ALIGNED HELP
          "Denominacion" NO-LABEL
     Cliente.agrupa_remitos AT ROW 7.43 COL 93
          VIEW-AS TOGGLE-BOX
          SIZE 22 BY .62
     Cliente.permite_nominar AT ROW 8.14 COL 93
          LABEL "Nomina Comprobantes"
          VIEW-AS TOGGLE-BOX
          SIZE 24 BY .62
     v-cdg_vendedor AT ROW 8.38 COL 13 COLON-ALIGNED
     v-dsc_vendedor AT ROW 8.38 COL 27 COLON-ALIGNED HELP
          "Denominacion" NO-LABEL
     Cliente.tiene_ctacte AT ROW 8.86 COL 93
          LABEL "Habilitado en Cta.Cte."
          VIEW-AS TOGGLE-BOX
          SIZE 25 BY .62
     v-cdg_cobrador AT ROW 9.57 COL 13 COLON-ALIGNED
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME F-Main
     v-dsc_cobrador AT ROW 9.57 COL 27 COLON-ALIGNED HELP
          "Denominacion" NO-LABEL
     Cliente.condensado_sino AT ROW 9.57 COL 93
          LABEL "Condensa Articulos."
          VIEW-AS TOGGLE-BOX
          SIZE 23 BY .62 TOOLTIP "Condensa Art."
     Cliente.clausula_dolar AT ROW 10.29 COL 93
          VIEW-AS TOGGLE-BOX
          SIZE 19 BY .81
     v-cdg_grupo-empresario AT ROW 10.76 COL 13 COLON-ALIGNED
     v-dsc_grupo-empresario AT ROW 10.76 COL 27 COLON-ALIGNED HELP
          "Denominacion" NO-LABEL
     Cliente.cdg_famclie AT ROW 11.95 COL 13 COLON-ALIGNED
          LABEL "Familia"
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Item1","Item1"
          DROP-DOWN-LIST
          SIZE 31 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.lista_mail AT ROW 11.95 COL 54 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 25 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.prc_mincambio AT ROW 11.95 COL 90 COLON-ALIGNED
          LABEL "% Cambio"
          VIEW-AS FILL-IN NATIVE 
          SIZE 8 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.prc_difcambio AT ROW 11.95 COL 115 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 8 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_entidad AT ROW 13.14 COL 13 COLON-ALIGNED
     v-dsc_entidad AT ROW 13.14 COL 27 COLON-ALIGNED HELP
          "Denominacion" NO-LABEL
     Cliente.cdg_tipoclie AT ROW 13.14 COL 90 COLON-ALIGNED
          LABEL "Actividad"
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Item 1","Item 1"
          DROP-DOWN-LIST
          SIZE 33 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_administrador AT ROW 14.33 COL 13 COLON-ALIGNED
     v-dsc_administrador AT ROW 14.33 COL 27 COLON-ALIGNED HELP
          "Denominacion" NO-LABEL
     bVer AT ROW 14.33 COL 71
     Cliente.lista_sectores AT ROW 15.52 COL 13 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 54 BY 1
          BGCOLOR 15 FGCOLOR 9 
     btn_elegir-2 AT ROW 15.52 COL 71
     Cliente.lista_empresas AT ROW 15.52 COL 81 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 31 BY 1
          BGCOLOR 15 FGCOLOR 9 
     btn_elegir AT ROW 15.52 COL 115
     Cliente.direccion AT ROW 18.62 COL 13 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 66 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.cdg_pais AT ROW 18.62 COL 97 COLON-ALIGNED
          LABEL "Pais"
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Item 1",0
          DROP-DOWN-LIST
          SIZE 26 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.cdg_postal AT ROW 19.81 COL 13 COLON-ALIGNED
          LABEL "C. P."
          VIEW-AS FILL-IN NATIVE 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.localidad AT ROW 19.81 COL 38 COLON-ALIGNED
          LABEL "Localidad"
          VIEW-AS FILL-IN NATIVE 
          SIZE 41 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.cdg_provincia AT ROW 19.81 COL 97 COLON-ALIGNED
          LABEL "Provincia"
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Item1","Item1"
          DROP-DOWN-LIST
          SIZE 26 BY 1
          BGCOLOR 15 FGCOLOR 9 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME F-Main
     Cliente.telefonos AT ROW 21 COL 13 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 110 BY 1
          BGCOLOR 15 FGCOLOR 9 
     "   Domicilio Fiscal" VIEW-AS TEXT
          SIZE 126 BY 1 AT ROW 17.19 COL 1
          BGCOLOR 5 FGCOLOR 15 
     "   Lista de empresas habilitadas" VIEW-AS TEXT
          SIZE 42 BY 1 AT ROW 14.33 COL 83
          BGCOLOR 5 FGCOLOR 15 
     RECT-1 AT ROW 18.38 COL 1
     RECT-2 AT ROW 1 COL 1
     RECT-7 AT ROW 7.19 COL 92
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Cliente
   Allow: Basic,DB-Fields
   Frames: 1
   Add Fields to: EXTERNAL-TABLES
   Other Settings: PERSISTENT-ONLY COMPILE
   Temp-Tables and Buffers:
      TABLE: Administrador B "?" ? sic Cliente
      TABLE: B-Cliente B "?" ? sic Cliente
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
         HEIGHT             = 23.29
         WIDTH              = 132.
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
/* SETTINGS FOR BUTTON btn_elegir-2 IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Cliente.cdg_cliente IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR COMBO-BOX Cliente.cdg_famclie IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR COMBO-BOX Cliente.cdg_pais IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cliente.cdg_postal IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR COMBO-BOX Cliente.cdg_provincia IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR COMBO-BOX Cliente.cdg_tipoclie IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR TOGGLE-BOX Cliente.condensado_sino IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cliente.credito_maximo IN FRAME F-Main
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN Cliente.fecha_alta IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cliente.fecha_baja IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cliente.lista_empresas IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cliente.localidad IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cliente.nom_cliente IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cliente.nom_fantasia IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cliente.nro_cliente IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR COMBO-BOX Cliente.paga_abasto IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR TOGGLE-BOX Cliente.permite_nominar IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cliente.prc_mincambio IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cliente.ref_proveedor IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR TOGGLE-BOX Cliente.tiene_ctacte IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN v-cdg_administrador IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_cobrador IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_condicion_impos IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_condicion_venta IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_entidad IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_grupo-empresario IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_lista_precios IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_vendedor IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_administrador IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_cobrador IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_condicion_impos IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_condicion_venta IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_entidad IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_grupo-empresario IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_lista_precios IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_vendedor IN FRAME F-Main
   NO-ENABLE                                                            */
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
  DEFINE VARIABLE v-lista_empresas LIKE Cliente.lista_empresas.
  v-lista_empresas = Cliente.lista_empresas:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
  RUN selcodempresa.p ( INPUT-OUTPUT v-lista_empresas ).
  Cliente.lista_empresas:SCREEN-VALUE IN FRAME {&FRAME-NAME} = v-lista_empresas.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_elegir-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_elegir-2 V-table-Win
ON CHOOSE OF btn_elegir-2 IN FRAME F-Main /* Elegir */
DO:
  DEFINE VARIABLE x-lista_sectores LIKE Cliente.lista_sectores.
  DEFINE VARIABLE x-lista_parcial  LIKE Cliente.lista_sectores.
  DEFINE VARIABLE x-suma_sectores LIKE Cliente.lista_sectores.
  DEFINE VARIABLE j-lista AS INTEGER.

  x-lista_sectores = Cliente.lista_sectores:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
  RUN selcodsector.p ( INPUT-OUTPUT x-lista_sectores ).
  IF Cliente.lista_sectores:SCREEN-VALUE IN FRAME {&FRAME-NAME} = ""
  THEN DO:
      x-suma_sectores = "".
      x-lista_parcial = ENTRY(1,x-lista_sectores,".").
      DO j-lista = 2 TO NUM-ENTRIES(x-lista_sectores,"."):
          x-suma_sectores = x-suma_sectores + "," + x-lista_parcial.
          x-lista_parcial = x-lista_parcial + "." + ENTRY(j-lista,x-lista_sectores,".").  
          /*
          MESSAGE "x-suma_sectores"     x-suma_sectores  SKIP
                  "x-lista_parcial"     x-lista_parcial  SKIP
                  "x-lista_sectores"    x-lista_sectores SKIP
              VIEW-AS ALERT-BOX INFO BUTTONS OK.
          */    
      END.
      x-suma_sectores = x-suma_sectores + "," + x-lista_parcial.
      /*
      MESSAGE "x-suma_sectores"     x-suma_sectores  SKIP
          VIEW-AS ALERT-BOX INFO BUTTONS OK.
      */    

  END.
  Cliente.lista_sectores:SCREEN-VALUE IN FRAME {&FRAME-NAME} = SUBSTRING(x-suma_sectores,2).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bVer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bVer V-table-Win
ON CHOOSE OF bVer IN FRAME F-Main /* Ver */
DO:
  FIND administrador WHERE administrador.nro_cliente = cliente.nro_administrador NO-LOCK NO-ERROR.
    IF AVAILABLE administrador THEN
  RUN w-zoom_cliente.w ( INPUT ROWID(administrador) ).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_administrador
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_administrador V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_administrador IN FRAME F-Main /* Administ. */
OR "." OF v-cdg_administrador IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_administrador IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "Administrador" "cdg_cliente" "SELadminis.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_administrador V-table-Win
ON RETURN OF v-cdg_administrador IN FRAME F-Main /* Administ. */
DO:
   {traducetabla.i "Administrador" "cdg_cliente" "nom_cliente"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_cobrador
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_cobrador V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_cobrador IN FRAME F-Main /* Cobrador */
OR "." OF v-cdg_cobrador IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_cobrador IN FRAME {&FRAME-NAME}

DO:

   {helptabla.i "Cobrador" "cdg_cobrador" "SELCOBRA.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_cobrador V-table-Win
ON RETURN OF v-cdg_cobrador IN FRAME F-Main /* Cobrador */
DO:
   {traducetabla.i "Cobrador" "cdg_cobrador" "nom_cobrador"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_condicion_impos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_condicion_impos V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_condicion_impos IN FRAME F-Main /* Cond.Impos. */
OR "." OF v-cdg_condicion_impos IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_condicion_impos IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Condicion_impos" "cdg_condiva" "SELCNDIV-v.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_condicion_impos V-table-Win
ON RETURN OF v-cdg_condicion_impos IN FRAME F-Main /* Cond.Impos. */
DO:
   {traducetabla.i "Vendedor" "cdg_vendedor" "nombre"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_condicion_venta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_condicion_venta V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_condicion_venta IN FRAME F-Main /* Cond. Venta */
OR "." OF v-cdg_condicion_venta IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_condicion_venta IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Condicion_venta" "cdg_cndventa" "SELCNDVN.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_condicion_venta V-table-Win
ON RETURN OF v-cdg_condicion_venta IN FRAME F-Main /* Cond. Venta */
DO:
   {traducetabla.i "Condicion_venta" "cdg_cndventa" "descripcion"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_entidad
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_entidad V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_entidad IN FRAME F-Main /* C.Costo */
OR "." OF v-cdg_entidad IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_entidad IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "Entidad" "cdg_entidad" "SELENTID.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_entidad V-table-Win
ON RETURN OF v-cdg_entidad IN FRAME F-Main /* C.Costo */
DO:
   {traducetabla.i "Entidad" "cdg_entidad" "dsc_entidad"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_grupo-empresario
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_grupo-empresario V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_grupo-empresario IN FRAME F-Main /* Grupo */
OR "." OF v-cdg_grupo-empresario IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_grupo-empresario IN FRAME {&FRAME-NAME}

DO:

   {helptabla.i "Grupo-empresario" "cdg_grupoemp" "SELGRUEM.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_grupo-empresario V-table-Win
ON RETURN OF v-cdg_grupo-empresario IN FRAME F-Main /* Grupo */
DO:
    {traducetabla.i "Grupo-empresario" "cdg_grupoemp" "dsc_grupoemp"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_lista_precios
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_lista_precios V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_lista_precios IN FRAME F-Main /* Lista */
OR "." OF v-cdg_lista_precios IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_lista_precios IN FRAME {&FRAME-NAME}

DO:

   {helptabla.i "Lista_precios" "cdg_lista" "SELLISTA.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_lista_precios V-table-Win
ON RETURN OF v-cdg_lista_precios IN FRAME F-Main /* Lista */
DO:
    {traducetabla.i "Lista_precios" "cdg_lista" "descripcion"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_vendedor
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_vendedor V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_vendedor IN FRAME F-Main /* Vendedor */
OR "." OF v-cdg_vendedor IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_vendedor IN FRAME {&FRAME-NAME}

DO:

   {helptabla.i "Vendedor" "cdg_vendedor" "SELVENDR.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_vendedor V-table-Win
ON RETURN OF v-cdg_vendedor IN FRAME F-Main /* Vendedor */
DO:
   {traducetabla.i "Vendedor" "cdg_vendedor" "nombre"} 
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
  {src/adm/template/row-list.i "Cliente"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Cliente"}

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE inicia_combos V-table-Win 
PROCEDURE inicia_combos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE ok AS LOGICAL.
  DEFINE VARIABLE lista AS CHARACTER.

  DO WITH FRAME {&FRAME-NAME}:
     {levantacombo.i &TABLA=Provincia &NOMBRE=nombre &CODIGO=cdg_provincia &OBJETO=Cliente.cdg_provincia}
/*      {levantacombo.i &TABLA=Familia_cliente &NOMBRE=dsc_famclie &CODIGO=cdg_famclie &OBJETO=Cliente.cdg_famclie}  */
     {levantacombo_empresa.i "Familia_cliente" "dsc_famclie" "cdg_famclie" "Cliente.cdg_famclie" "lista_empresas" Empresa.cdg_empresa}
     {levantacombo.i &TABLA=Tipo_cliente &NOMBRE=dsc_tipoclie &CODIGO=cdg_tipoclie &OBJETO=Cliente.cdg_tipoclie}
     {levantacombo.i &TABLA=Pais &NOMBRE=nombre &CODIGO=cdg_pais &OBJETO=Cliente.cdg_pais}
  END.          
  
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

   ES_ALTA = YES.
   v-verificar = YES.
   DISPLAY v-verificar
       WITH FRAME {&FRAME-NAME}.
 
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'add-record':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
   
   {blanqueacodigo.i "Lista_precios"}
   {blanqueacodigo.i "Vendedor"} 
   {blanqueacodigo.i "Cobrador"}
   {blanqueacodigo.i "Grupo-empresario"}
   {blanqueacodigo.i "Condicion_impos"}
   {blanqueacodigo.i "Condicion_venta"}
   {blanqueacodigo.i "Entidad"} 
   {blanqueacodigo.i "Administrador"} 

   DISPLAY 100 @  Cliente.prc_difcambio
       WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-assign-statement V-table-Win 
PROCEDURE local-assign-statement :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
    DEFINE VARIABLE hubo_error      AS LOGICAL.
    
    IF INPUT FRAME {&FRAME-NAME} Cliente.nom_cliente = "" OR 
        INPUT FRAME {&FRAME-NAME} Cliente.nom_cliente = ?  
    THEN DO:
         RUN PONMENSJ.P (INPUT "CLIE001").
         RETURN ERROR.
    END.            

    RUN validar_lista_empresas.p ( INPUT  Cliente.lista_empresas:SCREEN-VALUE IN FRAME {&FRAME-NAME},
                                   INPUT  hubo_error,
                                   OUTPUT hubo_error).

    IF hubo_error 
       THEN RETURN ERROR.

    IF es_alta
    THEN DO:

        IF CAN-FIND(FIRST B-Cliente 
                           WHERE B-Cliente.cdg_cliente = 
                               INPUT FRAME {&FRAME-NAME} Cliente.cdg_cliente )
        THEN DO:
             RUN PONMENSJ.P (INPUT "CLIE002").
             RETURN ERROR.
        END.

    END.
    ELSE DO:

        IF CAN-FIND(FIRST B-Cliente 
                           WHERE B-Cliente.cdg_cliente = 
                               INPUT FRAME {&FRAME-NAME} Cliente.cdg_cliente  
                            AND ROWID(B-Cliente) <> ROWID(Cliente) )
        THEN DO:
             RUN PONMENSJ.P (INPUT "CLIE002").
             RETURN ERROR.
        END.
        
/*         IF CAN-FIND(FIRST B-Cliente                                   */
/*                            WHERE B-Cliente.cuit =                     */
/*                                INPUT FRAME {&FRAME-NAME} Cliente.cuit */
/*                             AND ROWID(B-Cliente) <> ROWID(Cliente))   */
/*         THEN DO:                                                      */
/*              RUN PONMENSJ.P (INPUT "CLIE036").                        */
/*              RETURN ERROR.                                            */
/*         END.                                                          */

    END.


    IF CAN-FIND(FIRST B-Cliente
                       WHERE B-Cliente.cuit = INPUT FRAME {&FRAME-NAME} Cliente.cuit
                         AND ROWID(B-Cliente) <> ROWID(Cliente) 
                         AND v-verificar:INPUT-VALUE)
    THEN DO:
         RUN PONMENSJ.P (INPUT "CLIE036").
         RETURN ERROR.
    END.

   &SCOPED-DEFINE TABLA-MAESTRA  Cliente

   {validartabla.i "Lista_precios" "cdg_lista" "descripcion" "CLIE008"} 
   {validartabla.i "Vendedor" "cdg_vendedor" "nombre" "CLIE003"} 
   {validartabla.i "Cobrador" "cdg_cobrador" "nom_cobrador" "CLIE003"} 
   {validartabla.i "Grupo-empresario" "cdg_grupoemp" "dsc_grupoemp" "CLIE009"}
   {validartabla.i "Condicion_venta" "cdg_cndventa" "descripcion" "CLIE005"}
   {validartabla.i "Condicion_impos" "cdg_condiva" "descripcion" "CLIE006"}
   {validartabla.i "Entidad" "cdg_entidad" "dsc_entidad" "CLIE010"}
   IF v-cdg_administrador:INPUT-VALUE <> ""
   THEN DO:
       {validartabla.i "Administrador" "cdg_cliente" "nom_cliente" "CLIEXXX"}
   END.
   

   &UNDEFINE TABLA-MAESTRA

   RUN GET-ATTRIBUTE  IN adm-broker-hdl ( INPUT "ADM-NEW-RECORD" ). /* Averiguamos si es un alta */
   IF RETURN-VALUE <> "YES"
   THEN DO:
       CREATE Hst_Cliente.
       BUFFER-COPY Cliente TO Hst_cliente.
       RUN completar_auditoria.p ( OUTPUT Hst_Cliente.user_cambio,
                                   OUTPUT Hst_cliente.fecha_cambio,
                                   OUTPUT Hst_cliente.hor_cambio,
                                   OUTPUT Hst_cliente.pc_cambio).
       ASSIGN Hst_cliente.hms_cambio = STRING(Hst_cliente.hor_cambio,"HH:MM:SS").
   END.


  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   &SCOPED-DEFINE TABLA-MAESTRA  Cliente

   {asignartabla.i "Lista_precios" "cdg_lista" "dfl_lista"}
   {asignartabla.i "Vendedor" "nro_vendedor" "nro_vendedor"} 
   {asignartabla.i "Cobrador" "nro_cobrador" "nro_cobrador"} 
   {asignartabla.i "Grupo-empresario" "cdg_grupoemp" "cdg_grupoemp"}
   {asignartabla.i "Condicion_venta" "cdg_cndventa" "dfl_cndventa" }
   {asignartabla.i "Condicion_impos" "cdg_condiva" "cdg_condiva" }
   {asignartabla.i "Entidad" "nro_entidad" "nro_entidad"} 

   IF v-cdg_administrador:INPUT-VALUE <> ""
   THEN DO:
       {asignartabla.i "Administrador" "nro_cliente" "nro_administrador"}
   END.
   ELSE DO:
       Cliente.nro_administrador = 0.
   END.

   &UNDEFINE TABLA-MAESTRA

   IF NEW Cliente
      THEN ASSIGN Cliente.nro_cliente = NEXT-VALUE(proximo_cliente)
                  Cliente.fecha_alta  = TODAY
                  Cliente.hora_alta   = TIME.

   ASSIGN Cliente.fecha_grab = TODAY
          Cliente.hora_grab = TIME.
   ASSIGN Cliente.nro_administrador = IF Cliente.nro_administrador = 0  THEN Cliente.nro_cliente ELSE Cliente.nro_administrador.

   IF SEARCH("sincronizar_cliente.p") <> ? OR
   SEARCH("sincronizar_cliente.r") <> ?
   THEN DO:
       RUN sincronizar_cliente.p ( INPUT Cliente.cdg_cliente,
                                   OUTPUT hay_error_interface).
   END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-copy-record V-table-Win 
PROCEDURE local-copy-record :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

   ES_ALTA = YES.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'copy-record':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

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
   RUN vlb-clientes.p ( INPUT ROWID(Cliente), OUTPUT baja_no ).
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

  btn_elegir:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
  btn_elegir-2:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
  {deshabcodigo.i "Lista_precios"} 
  {deshabcodigo.i "Entidad"} 
  {deshabcodigo.i "Vendedor"} 
  {deshabcodigo.i "Cobrador"} 
  {deshabcodigo.i "Grupo-empresario"}
  {deshabcodigo.i "Condicion_impos"} 
  {deshabcodigo.i "Condicion_venta"} 
  {deshabcodigo.i "Administrador"} 

  ES_ALTA = NO.

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

  IF AVAILABLE Cliente
  THEN DO:

        &SCOPED-DEFINE TABLA-MAESTRA  Cliente
     
        {displaytabla.i "Lista_precios" "cdg_lista" "descripcion" "cdg_lista" "dfl_lista"} 
        {displaytabla.i "Vendedor" "cdg_vendedor" "nombre" "nro_vendedor" "nro_vendedor"} 
        {displaytabla.i "Cobrador" "cdg_cobrador" "nom_cobrador" "nro_cobrador" "nro_cobrador"} 
        {displaytabla.i "Grupo-empresario" "cdg_grupoemp" "dsc_grupoemp" "cdg_grupoemp" "cdg_grupoemp"}
        {displaytabla.i "Condicion_impos" "cdg_condiva" "descripcion" "cdg_condiva" "cdg_condiva"} 
        {displaytabla.i "Condicion_venta" "cdg_cndventa" "descripcion" "cdg_cndventa" "dfl_cndventa"} 
        {displaytabla.i "Entidad" "cdg_entidad" "dsc_entidad" "nro_entidad" "nro_entidad"} 
        {displaytabla.i "Administrador" "cdg_cliente" "nom_cliente" "nro_cliente" "nro_administrador" } 

        &UNDEFINE TABLA-MAESTRA
        
        v-verificar = YES.
        DISPLAY v-verificar
            WITH FRAME {&FRAME-NAME}.


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

 
   btn_elegir:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
   btn_elegir-2:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
  {habilcodigo.i "Lista_precios"} 
  {habilcodigo.i "Vendedor"} 
  {habilcodigo.i "Entidad"} 
  {habilcodigo.i "Cobrador"} 
  {habilcodigo.i "Grupo-empresario"}
  {habilcodigo.i "Condicion_impos"} 
  {habilcodigo.i "Condicion_venta"} 
  {habilcodigo.i "Administrador"} 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize V-table-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

   {findempresa.i}

   RUN inicia_combos.
   
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

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
  {src/adm/template/snd-list.i "Cliente"}

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

