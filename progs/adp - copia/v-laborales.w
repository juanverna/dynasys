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
&Scoped-define EXTERNAL-TABLES Empleado
&Scoped-define FIRST-EXTERNAL-TABLE Empleado


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Empleado.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Empleado.fecha_desde-afjp Empleado.id_plan-os ~
Empleado.noretener 
&Scoped-define ENABLED-TABLES Empleado
&Scoped-define FIRST-ENABLED-TABLE Empleado
&Scoped-define DISPLAYED-TABLES Empleado
&Scoped-define FIRST-DISPLAYED-TABLE Empleado
&Scoped-Define ENABLED-OBJECTS RECT-4 
&Scoped-Define DISPLAYED-FIELDS Empleado.fecha_desde-afjp ~
Empleado.id_plan-os Empleado.carac_servicios Empleado.noretener ~
Empleado.rebaja 
&Scoped-Define DISPLAYED-OBJECTS v-cdg_seccion v-dsc_seccion ~
v-cdg_categoria v-dsc_categoria v-cdg_especializacion v-dsc_especializacion ~
v-cdg_convenio v-dsc_convenio v-cdg_grupo_francos v-dsc_grupo_francos ~
v-cdg_aseguradora v-dsc_aseguradora v-actividad_dgi v-dsc_categoria-9 ~
v-cdg_afjp v-dsc_afjp v-cdg_prepaga v-dsc_prepaga 

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
DEFINE VARIABLE v-actividad_dgi AS CHARACTER FORMAT "X(4)" 
     LABEL "Actividad DGI" 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_afjp AS CHARACTER FORMAT "X(8)" 
     LABEL "AFJP" 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_aseguradora AS CHARACTER FORMAT "X(8)" 
     LABEL "ART" 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_categoria AS INTEGER FORMAT "->,>>>,>>9" INITIAL 0 
     LABEL "Categoría" 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_convenio AS INTEGER FORMAT "->,>>>,>>9" INITIAL 0 
     LABEL "Convenio" 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_especializacion AS CHARACTER FORMAT "X(3)" 
     LABEL "Especialidad" 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_grupo_francos AS CHARACTER FORMAT "X(4)" 
     LABEL "Francos" 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_prepaga AS INTEGER FORMAT "->,>>>,>>9" INITIAL 0 
     LABEL "Prepaga" 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_seccion AS CHARACTER FORMAT "X(10)" 
     LABEL "Sección" 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-dsc_afjp AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 33 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_aseguradora AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60.8 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_categoria AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60.8 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_categoria-9 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60.8 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_convenio AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60.8 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_especializacion AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60.8 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_grupo_francos AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60.8 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_prepaga AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 33 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_seccion AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60.8 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 4 GRAPHIC-EDGE  NO-FILL 
     SIZE 102 BY 12.86.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     v-cdg_seccion AT ROW 1.52 COL 17 COLON-ALIGNED
     v-dsc_seccion AT ROW 1.52 COL 30 COLON-ALIGNED NO-LABEL
     v-cdg_categoria AT ROW 2.67 COL 17 COLON-ALIGNED
     v-dsc_categoria AT ROW 2.67 COL 30 COLON-ALIGNED NO-LABEL
     v-cdg_especializacion AT ROW 3.86 COL 17 COLON-ALIGNED
     v-dsc_especializacion AT ROW 3.86 COL 30 COLON-ALIGNED NO-LABEL
     v-cdg_convenio AT ROW 5.05 COL 17 COLON-ALIGNED
     v-dsc_convenio AT ROW 5.05 COL 30 COLON-ALIGNED NO-LABEL
     v-cdg_grupo_francos AT ROW 6.24 COL 17 COLON-ALIGNED
     v-dsc_grupo_francos AT ROW 6.24 COL 30 COLON-ALIGNED NO-LABEL
     v-cdg_aseguradora AT ROW 7.43 COL 17 COLON-ALIGNED
     v-dsc_aseguradora AT ROW 7.43 COL 30 COLON-ALIGNED NO-LABEL
     v-actividad_dgi AT ROW 8.62 COL 17 COLON-ALIGNED
     v-dsc_categoria-9 AT ROW 8.62 COL 30 COLON-ALIGNED NO-LABEL
     v-cdg_afjp AT ROW 9.81 COL 17 COLON-ALIGNED
     v-dsc_afjp AT ROW 9.81 COL 30 COLON-ALIGNED NO-LABEL
     Empleado.fecha_desde-afjp AT ROW 9.81 COL 78.6 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 12 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_prepaga AT ROW 11 COL 17 COLON-ALIGNED
     v-dsc_prepaga AT ROW 11 COL 30 COLON-ALIGNED NO-LABEL
     Empleado.id_plan-os AT ROW 11 COL 78.6 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 12 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empleado.carac_servicios AT ROW 12.19 COL 17 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 12 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empleado.noretener AT ROW 12.19 COL 32
          LABEL "No Retener Ganancias"
          VIEW-AS TOGGLE-BOX
          SIZE 31 BY .76
     Empleado.rebaja AT ROW 12.19 COL 78.4 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 12 BY 1
          BGCOLOR 15 FGCOLOR 9 
     RECT-4 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Empleado
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
         HEIGHT             = 13
         WIDTH              = 102.4.
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

/* SETTINGS FOR FILL-IN Empleado.carac_servicios IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR TOGGLE-BOX Empleado.noretener IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Empleado.rebaja IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-actividad_dgi IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_afjp IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_aseguradora IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_categoria IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_convenio IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_especializacion IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_grupo_francos IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_prepaga IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_seccion IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_afjp IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_aseguradora IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_categoria IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_categoria-9 IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_convenio IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_especializacion IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_grupo_francos IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_prepaga IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_seccion IN FRAME F-Main
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

&Scoped-define SELF-NAME v-cdg_afjp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_afjp V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_afjp IN FRAME F-Main /* AFJP */
OR "." OF v-cdg_afjp IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_afjp IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "afjp" "cdg_afjp" "SELCATEG.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_afjp V-table-Win
ON RETURN OF v-cdg_afjp IN FRAME F-Main /* AFJP */
DO:
    {traducetabla.i "Afjp" "cdg_afjp" "nom_afjp"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_aseguradora
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_aseguradora V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_aseguradora IN FRAME F-Main /* ART */
OR "." OF v-cdg_aseguradora IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_aseguradora IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "aseguradora" "cdg_aseguradora" "SELASEGU.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_aseguradora V-table-Win
ON RETURN OF v-cdg_aseguradora IN FRAME F-Main /* ART */
DO:
    {traducetabla.i "Aseguradora" "cdg_aseguradora" "nom_aseguradora"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_categoria
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_categoria V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_categoria IN FRAME F-Main /* Categoría */
OR "." OF v-cdg_categoria IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_categoria IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "categoria" "cdg_categoria" "SELCATEG.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_categoria V-table-Win
ON RETURN OF v-cdg_categoria IN FRAME F-Main /* Categoría */
DO:
    {traducetabla.i "Categoria" "cdg_categoria" "descripcion"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_convenio
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_convenio V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_convenio IN FRAME F-Main /* Convenio */
OR "." OF v-cdg_convenio IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_convenio IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "convenio" "cdg_convenio" "SELCNVNI.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_convenio V-table-Win
ON RETURN OF v-cdg_convenio IN FRAME F-Main /* Convenio */
DO:
    {traducetabla.i "Convenio" "cdg_convenio" "descripcion"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_especializacion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_especializacion V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_especializacion IN FRAME F-Main /* Especialidad */
OR "." OF v-cdg_especializacion IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_especializacion IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "especializacion" "cdg_especializacion" "SELESPEC.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_especializacion V-table-Win
ON RETURN OF v-cdg_especializacion IN FRAME F-Main /* Especialidad */
DO:
    {traducetabla.i "Especializacion" "cdg_especializacion" "descripcion"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_grupo_francos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_grupo_francos V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_grupo_francos IN FRAME F-Main /* Francos */
OR "." OF v-cdg_grupo_francos IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_grupo_francos IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "Grupo_francos" "cdg_franco" "SELCNVNI.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_grupo_francos V-table-Win
ON RETURN OF v-cdg_grupo_francos IN FRAME F-Main /* Francos */
DO:
    {traducetabla.i "Grupo_francos" "cdg_franco" "dsc_franco"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_prepaga
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_prepaga V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_prepaga IN FRAME F-Main /* Prepaga */
OR "." OF v-cdg_prepaga IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_prepaga IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "prepaga" "cdg_prepaga" "SELPREPG.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_prepaga V-table-Win
ON RETURN OF v-cdg_prepaga IN FRAME F-Main /* Prepaga */
DO:
    {traducetabla.i "Prepaga" "cdg_prepaga" "nombre"} 
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_seccion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_seccion V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_seccion IN FRAME F-Main /* Sección */
OR "." OF v-cdg_seccion IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_seccion IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "seccion" "cdg_seccion" "SELSECCN.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_seccion V-table-Win
ON RETURN OF v-cdg_seccion IN FRAME F-Main /* Sección */
DO:
    {traducetabla.i "Seccion" "cdg_seccion" "denominacion"} 
  
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
  {src/adm/template/row-list.i "Empleado"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Empleado"}

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

    {blanqueacodigo.i "Afjp"} 
    {blanqueacodigo.i "Aseguradora"} 
    {blanqueacodigo.i "Categoria"} 
    {blanqueacodigo.i "Convenio"}
    {blanqueacodigo.i "Especializacion"} 
    {blanqueacodigo.i "Grupo_francos"} 
    {blanqueacodigo.i "Prepaga"} 
    {blanqueacodigo.i "Seccion"} 


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

    {deshabcodigo.i "Afjp"} 
    {deshabcodigo.i "Aseguradora"} 
    {deshabcodigo.i "Categoria"} 
    {deshabcodigo.i "Convenio"}
    {deshabcodigo.i "Especializacion"} 
    {deshabcodigo.i "Grupo_francos"} 
    {deshabcodigo.i "Prepaga"} 
    {deshabcodigo.i "Seccion"} 


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

  IF AVAILABLE Empleado
  THEN DO:

        &SCOPED-DEFINE TABLA-MAESTRA  Empleado

        {displaytabla.i "Afjp" "cdg_afjp" "nom_afjp" "cdg_afjp" "cdg_afjp"} 
        {displaytabla.i "Aseguradora" "cdg_aseguradora" "nom_aseguradora" "cdg_aseguradora" "cdg_aseguradora"} 
        {displaytabla.i "Categoria" "cdg_categoria" "descripcion" "cdg_categoria" "cdg_categoria"} 
        {displaytabla.i "Convenio" "cdg_convenio" "descripcion" "cdg_convenio" "cdg_convenio"}
        {displaytabla.i "Especializacion" "cdg_especializacion" "descripcion" "cdg_especializacion" "cdg_especializacion"} 
        {displaytabla.i "Grupo_francos" "cdg_franco" "dsc_franco" "cdg_franco" "cdg_franco"} 
        {displaytabla.i "Prepaga" "cdg_prepaga" "nombre" "cdg_prepaga" "cdg_prepaga"} 
        {displaytabla.i "Seccion" "cdg_seccion" "denominacion" "cdg_seccion" "cdg_seccion"} 

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

    {habilcodigo.i "Afjp"} 
    {habilcodigo.i "Aseguradora"} 
    {habilcodigo.i "Categoria"} 
    {habilcodigo.i "Convenio"}
    {habilcodigo.i "Especializacion"} 
    {habilcodigo.i "Grupo_francos"} 
    {habilcodigo.i "Prepaga"} 
    {habilcodigo.i "Seccion"} 

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
  {src/adm/template/snd-list.i "Empleado"}

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

