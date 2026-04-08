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
DEFINE VARIABLE combos_listos AS LOGICAL INITIAL NO.

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
&Scoped-define EXTERNAL-TABLES Proveedor
&Scoped-define FIRST-EXTERNAL-TABLE Proveedor


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Proveedor.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Proveedor.cdg_proveedor Proveedor.fecha_baja ~
Proveedor.prc_canje Proveedor.nombre Proveedor.titular_oxp_sino ~
Proveedor.orden_cheque Proveedor.contacto Proveedor.fecha_alta ~
Proveedor.ret_ganancias Proveedor.fmax_ganancias Proveedor.plib_ganancias ~
Proveedor.cuit Proveedor.ret_ibrutos Proveedor.fmax_ibrutos ~
Proveedor.plib_ibrutos Proveedor.cdg_tiporetibr Proveedor.cdg_tiporetiva ~
Proveedor.ret_iva Proveedor.fmax_iva Proveedor.plib_iva Proveedor.ret_suss ~
Proveedor.fmax_suss Proveedor.plib_suss Proveedor.cdg_tiporetsus ~
Proveedor.dfl_cndventa Proveedor.credito_maximo Proveedor.cdg_condiva ~
Proveedor.convenio_sino Proveedor.numero_ibr Proveedor.cyorden_sino ~
Proveedor.cdg_famprove Proveedor.lista_empresas 
&Scoped-define ENABLED-TABLES Proveedor
&Scoped-define FIRST-ENABLED-TABLE Proveedor
&Scoped-Define ENABLED-OBJECTS RECT-11 RECT-12 RECT-13 RECT-6 
&Scoped-Define DISPLAYED-FIELDS Proveedor.cdg_proveedor ~
Proveedor.fecha_baja Proveedor.prc_canje Proveedor.nombre ~
Proveedor.titular_oxp_sino Proveedor.orden_cheque Proveedor.contacto ~
Proveedor.fecha_alta Proveedor.ret_ganancias Proveedor.fmax_ganancias ~
Proveedor.plib_ganancias Proveedor.cuit Proveedor.ret_ibrutos ~
Proveedor.fmax_ibrutos Proveedor.plib_ibrutos Proveedor.cdg_tiporetibr ~
Proveedor.cdg_tiporetiva Proveedor.ret_iva Proveedor.fmax_iva ~
Proveedor.plib_iva Proveedor.ret_suss Proveedor.fmax_suss ~
Proveedor.plib_suss Proveedor.cdg_tiporetsus Proveedor.dfl_cndventa ~
Proveedor.credito_maximo Proveedor.cdg_condiva Proveedor.convenio_sino ~
Proveedor.numero_ibr Proveedor.cyorden_sino Proveedor.cdg_famprove ~
Proveedor.lista_empresas 
&Scoped-define DISPLAYED-TABLES Proveedor
&Scoped-define FIRST-DISPLAYED-TABLE Proveedor
&Scoped-Define DISPLAYED-OBJECTS v-cdg_comprador v-dsc_comprador ~
v-cdg_lista_precios v-dsc_lista_precios v-cdg_grupo-empresario ~
v-dsc_grupo-empresario 

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
DEFINE VARIABLE v-cdg_comprador AS CHARACTER FORMAT "X(8)" INITIAL "0" 
     LABEL "Comprador" 
     VIEW-AS FILL-IN 
     SIZE 12 BY .81
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_grupo-empresario AS CHARACTER FORMAT "X(8)" 
     LABEL "Grupo" 
     VIEW-AS FILL-IN 
     SIZE 12 BY .81
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_lista_precios AS INTEGER FORMAT ">>>>>>9" INITIAL 0 
     LABEL "Lista" 
     VIEW-AS FILL-IN 
     SIZE 12 BY .81
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-dsc_comprador AS CHARACTER FORMAT "X(35)" 
     VIEW-AS FILL-IN 
     SIZE 36 BY .81
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_grupo-empresario AS CHARACTER FORMAT "X(35)" 
     VIEW-AS FILL-IN 
     SIZE 36 BY .81
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_lista_precios AS CHARACTER FORMAT "X(35)" 
     VIEW-AS FILL-IN 
     SIZE 36 BY .81
     BGCOLOR 7 FGCOLOR 15 .

DEFINE RECTANGLE RECT-11
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 26 BY 2.96.

DEFINE RECTANGLE RECT-12
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 26 BY 1.88.

DEFINE RECTANGLE RECT-13
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 26 BY 1.35.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 91 BY 15.88.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Proveedor.cdg_proveedor AT ROW 1.54 COL 13 COLON-ALIGNED
          LABEL "Código"
          VIEW-AS FILL-IN 
          SIZE 12 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Proveedor.fecha_baja AT ROW 1.54 COL 32 COLON-ALIGNED
          LABEL "Baja"
          VIEW-AS FILL-IN 
          SIZE 11.72 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Proveedor.prc_canje AT ROW 1.54 COL 54 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 8 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Proveedor.nombre AT ROW 2.62 COL 13 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 49 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Proveedor.titular_oxp_sino AT ROW 2.88 COL 66 NO-LABEL
          VIEW-AS RADIO-SET VERTICAL
          RADIO-BUTTONS 
                    "Proveedor", no,
"Titular de Obligaciones", yes
          SIZE 23 BY 1.35
     Proveedor.orden_cheque AT ROW 3.69 COL 13 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 49 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Proveedor.contacto AT ROW 4.77 COL 13 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 49 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Proveedor.fecha_alta AT ROW 4.77 COL 73 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Proveedor.ret_ganancias AT ROW 5.85 COL 15
          LABEL "Ganancias"
          VIEW-AS TOGGLE-BOX
          SIZE 12 BY .77
     Proveedor.fmax_ganancias AT ROW 5.85 COL 32 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 11.72 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Proveedor.plib_ganancias AT ROW 5.85 COL 51 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 11 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Proveedor.cuit AT ROW 5.85 COL 73 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Proveedor.ret_ibrutos AT ROW 6.92 COL 15
          LABEL "Ing.Brutos"
          VIEW-AS TOGGLE-BOX
          SIZE 11 BY .77
     Proveedor.fmax_ibrutos AT ROW 6.92 COL 32 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 11.72 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Proveedor.plib_ibrutos AT ROW 6.92 COL 51 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 11 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Proveedor.cdg_tiporetibr AT ROW 6.92 COL 80 COLON-ALIGNED
          LABEL "Régimen I.Brutos"
          VIEW-AS FILL-IN 
          SIZE 8 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Proveedor.cdg_tiporetiva AT ROW 7.92 COL 80 COLON-ALIGNED
          LABEL "Régimen I.V.A."
          VIEW-AS FILL-IN 
          SIZE 8 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Proveedor.ret_iva AT ROW 8 COL 15
          LABEL "I.V.A."
          VIEW-AS TOGGLE-BOX
          SIZE 12 BY .77
     Proveedor.fmax_iva AT ROW 8 COL 32 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 11.72 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Proveedor.plib_iva AT ROW 8 COL 51 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 11 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Proveedor.ret_suss AT ROW 9.08 COL 15
          LABEL "SUSS"
          VIEW-AS TOGGLE-BOX
          SIZE 13 BY .77
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME F-Main
     Proveedor.fmax_suss AT ROW 9.08 COL 32 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 12 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Proveedor.plib_suss AT ROW 9.08 COL 51 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 11 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Proveedor.cdg_tiporetsus AT ROW 9.08 COL 80 COLON-ALIGNED
          LABEL "Régimen SUSS"
          VIEW-AS FILL-IN 
          SIZE 8 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Proveedor.dfl_cndventa AT ROW 10.15 COL 13 COLON-ALIGNED
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Item","Item"
          DROP-DOWN-LIST
          SIZE 49 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Proveedor.credito_maximo AT ROW 10.15 COL 73 COLON-ALIGNED
          LABEL "C.Máx."
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Proveedor.cdg_condiva AT ROW 11.23 COL 13 COLON-ALIGNED
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "0",0
          DROP-DOWN-LIST
          SIZE 49 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_comprador AT ROW 12.31 COL 13 COLON-ALIGNED
     v-dsc_comprador AT ROW 12.31 COL 26 COLON-ALIGNED HELP
          "Denominacion" NO-LABEL
     Proveedor.convenio_sino AT ROW 12.31 COL 66 NO-LABEL
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Inscripto", "S":U,
"No Inscripto", ""
          SIZE 24 BY .77
     v-cdg_lista_precios AT ROW 13.38 COL 13 COLON-ALIGNED
     v-dsc_lista_precios AT ROW 13.38 COL 26 COLON-ALIGNED HELP
          "Denominacion" NO-LABEL
     Proveedor.numero_ibr AT ROW 13.38 COL 73 COLON-ALIGNED
          LABEL "Ing.Brutos"
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_grupo-empresario AT ROW 14.46 COL 13 COLON-ALIGNED
     v-dsc_grupo-empresario AT ROW 14.46 COL 26 COLON-ALIGNED HELP
          "Denominacion" NO-LABEL
     Proveedor.cyorden_sino AT ROW 14.73 COL 66
          LABEL "Habil. para Cta y Orden"
          VIEW-AS TOGGLE-BOX
          SIZE 24 BY .54
     Proveedor.cdg_famprove AT ROW 15.54 COL 13 COLON-ALIGNED
          LABEL "Familia"
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Item","Item"
          DROP-DOWN-LIST
          SIZE 40 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Proveedor.lista_empresas AT ROW 15.54 COL 64 COLON-ALIGNED
          LABEL "Empresas"
          VIEW-AS FILL-IN 
          SIZE 24 BY .81
          BGCOLOR 15 FGCOLOR 9 
     RECT-11 AT ROW 1.54 COL 65
     RECT-12 AT ROW 11.23 COL 65
     RECT-13 AT ROW 13.12 COL 65
     RECT-6 AT ROW 1 COL 1
     "Retener:" VIEW-AS TEXT
          SIZE 8 BY .62 AT ROW 5.85 COL 14 RIGHT-ALIGNED
     "      Convenio Multilateral" VIEW-AS TEXT
          SIZE 24 BY .81 AT ROW 11.5 COL 89 RIGHT-ALIGNED
          BGCOLOR 7 FGCOLOR 15 
     "           Tipo de Cuenta" VIEW-AS TEXT
          SIZE 24 BY .81 AT ROW 1.81 COL 89 RIGHT-ALIGNED
          BGCOLOR 7 FGCOLOR 15 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Proveedor
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
         HEIGHT             = 16.96
         WIDTH              = 95.72.
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

/* SETTINGS FOR COMBO-BOX Proveedor.cdg_famprove IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Proveedor.cdg_proveedor IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Proveedor.cdg_tiporetibr IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Proveedor.cdg_tiporetiva IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Proveedor.cdg_tiporetsus IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Proveedor.credito_maximo IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR TOGGLE-BOX Proveedor.cyorden_sino IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Proveedor.fecha_baja IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Proveedor.lista_empresas IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Proveedor.numero_ibr IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR TOGGLE-BOX Proveedor.ret_ganancias IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR TOGGLE-BOX Proveedor.ret_ibrutos IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR TOGGLE-BOX Proveedor.ret_iva IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR TOGGLE-BOX Proveedor.ret_suss IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN v-cdg_comprador IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_grupo-empresario IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_lista_precios IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_comprador IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_grupo-empresario IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_lista_precios IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR TEXT-LITERAL "           Tipo de Cuenta"
          SIZE 24 BY .81 AT ROW 1.81 COL 89 RIGHT-ALIGNED               */

/* SETTINGS FOR TEXT-LITERAL "Retener:"
          SIZE 8 BY .62 AT ROW 5.85 COL 14 RIGHT-ALIGNED                */

/* SETTINGS FOR TEXT-LITERAL "      Convenio Multilateral"
          SIZE 24 BY .81 AT ROW 11.5 COL 89 RIGHT-ALIGNED               */

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

&Scoped-define SELF-NAME v-cdg_comprador
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_comprador V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_comprador IN FRAME F-Main /* Comprador */
OR "." OF v-cdg_comprador IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_comprador IN FRAME {&FRAME-NAME}

DO:

   {helptabla.i "comprador" "cdg_comprador" "SELCOMPR.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_comprador V-table-Win
ON RETURN OF v-cdg_comprador IN FRAME F-Main /* Comprador */
DO:
   {traducetabla.i "comprador" "cdg_comprador" "nom_comprador"} 
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
   {helptabla.i "Lista_precios" "cdg_lista" "SELLISTACOMPRAS.P"}
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
  {src/adm/template/row-list.i "Proveedor"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Proveedor"}

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


  DEFINE VARIABLE lista AS CHARACTER.
            
  DO WITH FRAME {&FRAME-NAME}:
     {levantacombo.i &TABLA=Condicion_venta &NOMBRE=descripcion &CODIGO=cdg_cndventa &OBJETO=Proveedor.dfl_cndventa}
     {levantacombo.i &TABLA=Familia_proveedor &NOMBRE=dsc_famprove &CODIGO=cdg_famprove &OBJETO=Proveedor.cdg_famprove}
     {levantacombo.i &TABLA=Condicion_impos &NOMBRE=descripcion &CODIGO=cdg_condiva &OBJETO=Proveedor.cdg_condiva}
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

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'add-record':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   {blanqueacodigo.i "Comprador"} 
   {blanqueacodigo.i "Grupo-empresario"}
   {blanqueacodigo.i "Lista_precios"}


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-assign-statement V-table-Win 
PROCEDURE local-assign-statement :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute BEFORE standard behavior.    */

    DEFINE BUFFER B-Proveedor FOR Proveedor.

    IF INPUT FRAME {&FRAME-NAME} Proveedor.nombre = "" OR 
        INPUT FRAME {&FRAME-NAME} Proveedor.nombre = ?  
    THEN DO:
         RUN PONMENSJ.P (INPUT "PROV001").
         RETURN ERROR.
    END.            

    IF CAN-FIND(FIRST B-Proveedor 
                       WHERE B-Proveedor.cdg_proveedor = 
                           INPUT FRAME {&FRAME-NAME} Proveedor.cdg_proveedor  
                        AND ROWID(B-Proveedor) <> ROWID(Proveedor) )
    THEN DO:
         RUN PONMENSJ.P (INPUT "PROV002").
         RETURN ERROR.
    END.            

   &SCOPED-DEFINE TABLA-MAESTRA  Proveedor

   {validartabla.i "Comprador" "cdg_comprador" "nom_comprador" "PROV003"} 
   {validartabla.i "Grupo-empresario" "cdg_grupoemp" "dsc_grupoemp" "PROV014"}
   {validartabla.i "Lista_precios" "cdg_lista" "descripcion" "PROV017"}

   &UNDEFINE TABLA-MAESTRA

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   &SCOPED-DEFINE TABLA-MAESTRA  Proveedor

   {asignartabla.i "Lista_precios" "cdg_lista" "dfl_lista"}
   {asignartabla.i "Comprador" "nro_comprador" "nro_comprador"} 
   {asignartabla.i "Grupo-empresario" "cdg_grupoemp" "cdg_grupoemp"}

   &UNDEFINE TABLA-MAESTRA

   IF NEW Proveedor
      THEN ASSIGN Proveedor.nro_proveedor = NEXT-VALUE(proximo_proveedor).

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
   RUN vlb-proveedores.p ( INPUT ROWID(Proveedor), OUTPUT baja_no ).
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

  {sensitivecombo.i "Proveedor.dfl_cndventa"   "NO"}
  {sensitivecombo.i "Proveedor.cdg_condiva"    "NO"}
  {sensitivecombo.i "Proveedor.cdg_famprove"    "NO"}

  {deshabcodigo.i "Comprador"} 
  {deshabcodigo.i "Grupo-empresario"}
  {deshabcodigo.i "Lista_precios"}

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

  IF AVAILABLE Proveedor
  THEN DO:

        &SCOPED-DEFINE TABLA-MAESTRA  Proveedor
     
        {displaytabla.i "Lista_precios" "cdg_lista" "descripcion" "cdg_lista" "dfl_lista"} 
        {displaytabla.i "Comprador" "cdg_comprador" "nom_comprador" "nro_comprador" "nro_comprador"} 
        {displaytabla.i "Grupo-empresario" "cdg_grupoemp" "dsc_grupoemp" "cdg_grupoemp" "cdg_grupoemp"}

        &UNDEFINE TABLA-MAESTRA
        
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

  {habilcodigo.i "Comprador"} 
  {habilcodigo.i "Grupo-empresario"}
  {habilcodigo.i "Lista_precios"}

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
  {src/adm/template/snd-list.i "Proveedor"}

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

