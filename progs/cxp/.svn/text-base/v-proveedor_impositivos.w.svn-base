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
&Scoped-Define ENABLED-FIELDS Proveedor.cdg_condiva Proveedor.cuit ~
Proveedor.fmax_ganancias Proveedor.plib_ganancias Proveedor.ret_ganancias ~
Proveedor.ret_ibrutos Proveedor.fmax_ibrutos Proveedor.plib_ibrutos ~
Proveedor.ret_iva Proveedor.fmax_iva Proveedor.plib_iva Proveedor.ret_suss ~
Proveedor.fmax_suss Proveedor.plib_suss Proveedor.credito_maximo ~
Proveedor.numero_ibr Proveedor.convenio_sino Proveedor.direccion ~
Proveedor.localidad Proveedor.cdg_provincia Proveedor.cdg_postal ~
Proveedor.telefonos Proveedor.cdg_pais 
&Scoped-define ENABLED-TABLES Proveedor
&Scoped-define FIRST-ENABLED-TABLE Proveedor
&Scoped-Define ENABLED-OBJECTS RECT-10 RECT-12 RECT-13 RECT-6 RECT-7 RECT-8 ~
RECT-9 
&Scoped-Define DISPLAYED-FIELDS Proveedor.cdg_condiva Proveedor.cuit ~
Proveedor.fmax_ganancias Proveedor.plib_ganancias Proveedor.ret_ganancias ~
Proveedor.ret_ibrutos Proveedor.fmax_ibrutos Proveedor.plib_ibrutos ~
Proveedor.ret_iva Proveedor.fmax_iva Proveedor.plib_iva Proveedor.ret_suss ~
Proveedor.fmax_suss Proveedor.plib_suss Proveedor.credito_maximo ~
Proveedor.numero_ibr Proveedor.convenio_sino Proveedor.direccion ~
Proveedor.localidad Proveedor.cdg_provincia Proveedor.cdg_postal ~
Proveedor.telefonos Proveedor.cdg_pais 
&Scoped-define DISPLAYED-TABLES Proveedor
&Scoped-define FIRST-DISPLAYED-TABLE Proveedor
&Scoped-Define DISPLAYED-OBJECTS v-cdg_tipo_retibr v-dsc_tipo_retibr ~
v-cdg_tipo_retiva v-dsc_tipo_retiva v-cdg_tipo_retsus v-dsc_tipo_retsus 

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
DEFINE VARIABLE v-cdg_tipo_retibr AS CHARACTER FORMAT "X(8)" 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_tipo_retiva AS CHARACTER FORMAT "X(8)" 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_tipo_retsus AS CHARACTER FORMAT "X(8)" 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-dsc_tipo_retibr AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 38 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_tipo_retiva AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 38 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_tipo_retsus AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 38 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 98 BY 5.24.

DEFINE RECTANGLE RECT-12
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 70 BY 2.76.

DEFINE RECTANGLE RECT-13
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 27 BY 2.86.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 100 BY 18.1.

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 17 BY 6.05.

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 80 BY 6.05.

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 98 BY 1.33.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Proveedor.cdg_condiva AT ROW 1.24 COL 6 COLON-ALIGNED
          LABEL "IVA"
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "0",0
          DROP-DOWN-LIST
          SIZE 52 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Proveedor.cuit AT ROW 1.24 COL 73 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 24 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Proveedor.fmax_ganancias AT ROW 5.52 COL 70 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Proveedor.plib_ganancias AT ROW 5.52 COL 84 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Proveedor.ret_ganancias AT ROW 5.57 COL 4
          LABEL "Ganancias"
          VIEW-AS TOGGLE-BOX
          SIZE 13 BY 1.1
     Proveedor.ret_ibrutos AT ROW 6.62 COL 4
          LABEL "Ing.Brutos"
          VIEW-AS TOGGLE-BOX
          SIZE 13 BY 1.1
     v-cdg_tipo_retibr AT ROW 6.71 COL 19 COLON-ALIGNED NO-LABEL
     v-dsc_tipo_retibr AT ROW 6.71 COL 31 COLON-ALIGNED NO-LABEL
     Proveedor.fmax_ibrutos AT ROW 6.71 COL 70 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Proveedor.plib_ibrutos AT ROW 6.71 COL 84 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Proveedor.ret_iva AT ROW 7.71 COL 4
          LABEL "I.V.A."
          VIEW-AS TOGGLE-BOX
          SIZE 12 BY 1.1
     v-cdg_tipo_retiva AT ROW 7.81 COL 19 COLON-ALIGNED NO-LABEL
     v-dsc_tipo_retiva AT ROW 7.91 COL 31 COLON-ALIGNED NO-LABEL
     Proveedor.fmax_iva AT ROW 7.91 COL 70 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Proveedor.plib_iva AT ROW 7.91 COL 84 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Proveedor.ret_suss AT ROW 8.81 COL 4
          LABEL "SUSS"
          VIEW-AS TOGGLE-BOX
          SIZE 13 BY 1.1
     v-cdg_tipo_retsus AT ROW 9.1 COL 19 COLON-ALIGNED NO-LABEL
     v-dsc_tipo_retsus AT ROW 9.1 COL 31 COLON-ALIGNED NO-LABEL
     Proveedor.fmax_suss AT ROW 9.1 COL 70 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Proveedor.plib_suss AT ROW 9.1 COL 84 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Proveedor.credito_maximo AT ROW 11.91 COL 72 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 25 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Proveedor.numero_ibr AT ROW 11.95 COL 47 COLON-ALIGNED
          LABEL "Ing.Brutos"
          VIEW-AS FILL-IN 
          SIZE 21 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Proveedor.convenio_sino AT ROW 12 COL 3 NO-LABEL
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Inscripto", "S":U,
"No Inscripto", ""
          SIZE 32 BY .76
     Proveedor.direccion AT ROW 15 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 85 BY 1
          BGCOLOR 15 FGCOLOR 9 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME F-Main
     Proveedor.localidad AT ROW 16.24 COL 36 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 26 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Proveedor.cdg_provincia AT ROW 16.24 COL 74 COLON-ALIGNED
          LABEL "Provincia"
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Item 1","Item 1"
          DROP-DOWN-LIST
          SIZE 23 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Proveedor.cdg_postal AT ROW 16.29 COL 12 COLON-ALIGNED
          LABEL "C.P."
          VIEW-AS FILL-IN 
          SIZE 11 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Proveedor.telefonos AT ROW 17.43 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 50 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Proveedor.cdg_pais AT ROW 17.43 COL 74 COLON-ALIGNED
          LABEL "Pais"
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "0",1
          DROP-DOWN-LIST
          SIZE 23 BY 1
          BGCOLOR 15 FGCOLOR 9 
     RECT-10 AT ROW 13.62 COL 2
     RECT-12 AT ROW 10.52 COL 2
     RECT-13 AT ROW 10.52 COL 73
     RECT-6 AT ROW 1 COL 1
     RECT-7 AT ROW 4.24 COL 2
     RECT-8 AT ROW 4.24 COL 20
     RECT-9 AT ROW 2.57 COL 2
     "    Regímenes de retención asociados al proveedor" VIEW-AS TEXT
          SIZE 96 BY .81 AT ROW 2.86 COL 3
          BGCOLOR 5 FGCOLOR 15 
     "      Convenio Multilateral e Inscripción en Ingresos Brutos" VIEW-AS TEXT
          SIZE 68 BY .81 AT ROW 10.76 COL 3
          BGCOLOR 7 FGCOLOR 15 
     "         Retener" VIEW-AS TEXT
          SIZE 15 BY .81 AT ROW 4.48 COL 3
          BGCOLOR 5 FGCOLOR 15 
     "  Régimen a Aplicar, Fecha Máxima de Excención y Porcentaje" VIEW-AS TEXT
          SIZE 78 BY .81 AT ROW 4.48 COL 21
          BGCOLOR 5 FGCOLOR 15 
     "    Crédito Máximo" VIEW-AS TEXT
          SIZE 25 BY .81 AT ROW 10.76 COL 74
          BGCOLOR 7 FGCOLOR 15 
     "    Domicilio legal del proveedor a efectos fiscales" VIEW-AS TEXT
          SIZE 96 BY .81 AT ROW 13.91 COL 98 RIGHT-ALIGNED
          BGCOLOR 5 FGCOLOR 15 
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
         HEIGHT             = 21.24
         WIDTH              = 118.
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

/* SETTINGS FOR COMBO-BOX Proveedor.cdg_condiva IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR COMBO-BOX Proveedor.cdg_pais IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Proveedor.cdg_postal IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR COMBO-BOX Proveedor.cdg_provincia IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Proveedor.credito_maximo IN FRAME F-Main
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
/* SETTINGS FOR FILL-IN v-cdg_tipo_retibr IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_tipo_retiva IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_tipo_retsus IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_tipo_retibr IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_tipo_retiva IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_tipo_retsus IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR TEXT-LITERAL "    Domicilio legal del proveedor a efectos fiscales"
          SIZE 96 BY .81 AT ROW 13.91 COL 98 RIGHT-ALIGNED              */

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

&Scoped-define SELF-NAME v-cdg_tipo_retibr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_tipo_retibr V-table-Win
ON MOUSE-MENU-DOWN OF v-cdg_tipo_retibr IN FRAME F-Main
OR "." OF v-cdg_tipo_retibr IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_tipo_retibr IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "Tipo_retibr" "cdg_tiporetibr" "SELTPIBR.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_tipo_retibr V-table-Win
ON RETURN OF v-cdg_tipo_retibr IN FRAME F-Main
DO:
  {traducetabla.i "Tipo_retibr" "cdg_tiporetibr" "nom_retibr"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_tipo_retiva
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_tipo_retiva V-table-Win
ON MOUSE-MENU-DOWN OF v-cdg_tipo_retiva IN FRAME F-Main
OR "." OF v-cdg_tipo_retiva IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_tipo_retiva IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "Tipo_retiva" "cdg_tiporetiva" "SELTPIVA.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_tipo_retiva V-table-Win
ON RETURN OF v-cdg_tipo_retiva IN FRAME F-Main
DO:
  {traducetabla.i "Tipo_retiva" "cdg_tiporetiva" "nom_retiva"}   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_tipo_retsus
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_tipo_retsus V-table-Win
ON MOUSE-MENU-DOWN OF v-cdg_tipo_retsus IN FRAME F-Main
OR "." OF v-cdg_tipo_retsus IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_tipo_retsus IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "Tipo_retsus" "cdg_tiporetsus" "SELTPSUS.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_tipo_retsus V-table-Win
ON RETURN OF v-cdg_tipo_retsus IN FRAME F-Main
DO:
  {traducetabla.i "Tipo_retsus" "cdg_tiporetsus" "nom_retsus"}   
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
     {levantacombo.i &TABLA=Condicion_impos &NOMBRE=descripcion &CODIGO=cdg_condiva &OBJETO=Proveedor.cdg_condiva}
     {levantacombo.i &TABLA=Provincia &NOMBRE=nombre &CODIGO=cdg_provincia &OBJETO=Proveedor.cdg_provincia}
     {levantacombo.i &TABLA=Pais &NOMBRE=nombre &CODIGO=cdg_pais &OBJETO=Proveedor.cdg_pais}
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

  {blanqueacodigo.i "Tipo_retibr"} 
  {blanqueacodigo.i "Tipo_retiva"}
  {blanqueacodigo.i "Tipo_retsus"}


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

   &SCOPED-DEFINE TABLA-MAESTRA  Proveedor

   {validartabla.i "Tipo_retibr" "cdg_tiporetibr" "nom_retibr" "PROV003"} 
   {validartabla.i "Tipo_retiva" "cdg_tiporetiva" "nom_retiva" "PROV014"}
   {validartabla.i "Tipo_retsus" "cdg_tiporetsus" "nom_retsus" "PROV017"}

   &UNDEFINE TABLA-MAESTRA

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   &SCOPED-DEFINE TABLA-MAESTRA  Proveedor

   {asignartabla.i "Tipo_retibr" "cdg_tiporetibr" "cdg_tiporetibr"} 
   {asignartabla.i "Tipo_retiva" "cdg_tiporetiva" "cdg_tiporetiva"}
   {asignartabla.i "Tipo_retsus" "cdg_tiporetsus" "cdg_tiporetsus"}

   &UNDEFINE TABLA-MAESTRA


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

  {sensitivecombo.i "Proveedor.cdg_condiva"   "NO"}
  {sensitivecombo.i "Proveedor.cdg_provincia"   "NO"}
  {sensitivecombo.i "Proveedor.cdg_pais"   "NO"}

  {deshabcodigo.i "Tipo_retibr"} 
  {deshabcodigo.i "Tipo_retiva"}
  {deshabcodigo.i "Tipo_retsus"}

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
     
        {displaytabla.i "Tipo_retibr" "cdg_tiporetibr" "nom_retibr" "cdg_tiporetibr" "cdg_tiporetibr"}         
        {displaytabla.i "Tipo_retiva" "cdg_tiporetiva" "nom_retiva" "cdg_tiporetiva" "cdg_tiporetiva"}         
        {displaytabla.i "Tipo_retsus" "cdg_tiporetsus" "nom_retsus" "cdg_tiporetsus" "cdg_tiporetsus"}         

        &UNDEFINE TABLA-MAESTRA
        
  END.
  ELSE DO:
      {blanqueacodigo.i "Tipo_retibr"} 
      {blanqueacodigo.i "Tipo_retiva"}
      {blanqueacodigo.i "Tipo_retsus"}
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

  {sensitivecombo.i "Proveedor.cdg_condiva"   "YES"}
  {sensitivecombo.i "Proveedor.cdg_provincia"   "YES"}
  {sensitivecombo.i "Proveedor.cdg_pais"   "YES"}

  {habilcodigo.i "Tipo_retibr"} 
  {habilcodigo.i "Tipo_retiva"}
  {habilcodigo.i "Tipo_retsus"}


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

