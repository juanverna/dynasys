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
&Scoped-define EXTERNAL-TABLES Proveedor_excen_ibr Proveedor
&Scoped-define FIRST-EXTERNAL-TABLE Proveedor_excen_ibr


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Proveedor_excen_ibr, Proveedor.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Proveedor_excen_ibr.fch_desde ~
Proveedor_excen_ibr.fch_hasta Proveedor_excen_ibr.prc_excencion ~
Proveedor_excen_ibr.fch_boletin 
&Scoped-define ENABLED-TABLES Proveedor_excen_ibr
&Scoped-define FIRST-ENABLED-TABLE Proveedor_excen_ibr
&Scoped-Define ENABLED-OBJECTS RECT-6 
&Scoped-Define DISPLAYED-FIELDS Proveedor_excen_ibr.fch_desde ~
Proveedor_excen_ibr.fch_hasta Proveedor_excen_ibr.prc_excencion ~
Proveedor_excen_ibr.fch_boletin 
&Scoped-define DISPLAYED-TABLES Proveedor_excen_ibr
&Scoped-define FIRST-DISPLAYED-TABLE Proveedor_excen_ibr
&Scoped-Define DISPLAYED-OBJECTS v-cdg_tipo_retibr v-dsc_tipo_retibr 

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
     SIZE 13.6 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-dsc_tipo_retibr AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 39 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 60 BY 9.52.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     v-cdg_tipo_retibr AT ROW 2.91 COL 2 COLON-ALIGNED HELP
          "Codigo del tipo de actividad" NO-LABEL
     v-dsc_tipo_retibr AT ROW 2.91 COL 17 COLON-ALIGNED NO-LABEL
     Proveedor_excen_ibr.fch_desde AT ROW 5.76 COL 2 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Proveedor_excen_ibr.fch_hasta AT ROW 5.76 COL 40 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Proveedor_excen_ibr.prc_excencion AT ROW 8.62 COL 2 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 10.4 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Proveedor_excen_ibr.fch_boletin AT ROW 8.62 COL 40 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     RECT-6 AT ROW 1 COL 1
     "  Régimen para el cual se registra la excención" VIEW-AS TEXT
          SIZE 54 BY 1 AT ROW 1.48 COL 4
          BGCOLOR 5 FGCOLOR 15 
     "  Período de vigencia de la excención" VIEW-AS TEXT
          SIZE 54 BY 1 AT ROW 4.33 COL 4
          BGCOLOR 5 FGCOLOR 15 
     "  Porcentaje de excención y fecha de de publicación" VIEW-AS TEXT
          SIZE 54 BY 1 AT ROW 7.19 COL 4
          BGCOLOR 5 FGCOLOR 15 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Proveedor_excen_ibr,sic.Proveedor
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
         HEIGHT             = 10.14
         WIDTH              = 98.6.
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

/* SETTINGS FOR FILL-IN Proveedor_excen_ibr.prc_excencion IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN v-cdg_tipo_retibr IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_tipo_retibr IN FRAME F-Main
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

&Scoped-define SELF-NAME v-cdg_tipo_retibr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_tipo_retibr V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_tipo_retibr IN FRAME F-Main
OR "." OF v-cdg_tipo_retibr IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_tipo_retibr IN FRAME {&FRAME-NAME}

DO:

   {helptabla.i "tipo_retibr" "cdg_tiporetibr" "SELTPIBR.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_tipo_retibr V-table-Win
ON RETURN OF v-cdg_tipo_retibr IN FRAME F-Main
DO:
    {traducetabla.i "tipo_retibr" "cdg_tiporetibr" "nom_retibr"}   
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
  {src/adm/template/row-list.i "Proveedor_excen_ibr"}
  {src/adm/template/row-list.i "Proveedor"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Proveedor_excen_ibr"}
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

  {blanqueacodigo.i "tipo_retibr" }

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

  DO WITH FRAME {&FRAME-NAME}:

       &SCOPED-DEFINE TABLA-MAESTRA  Proveedor_excen_ibr
    
       {validartabla.i "tipo_retibr" "cdg_tiporetibr" "nom_retibr" "EXIM001"} 
    
       &UNDEFINE TABLA-MAESTRA
          
       {validaciontotalvigencia.i
               &TABLAMAESTRA=Proveedor
               &CDG_MAESTRA=cdg_proveedor
               &TABLAVIGENCIA=Proveedor_excen_ibr
               &FECHA_DESDE=fch_desde 
               &FECHA_HASTA=fch_hasta 
               &ERRORES_RANGO=EXIM002,EXIM003,EXIM004
               &ERRORES_VIGENCIA=EXIM005
               &CONDICION="B-Proveedor_excen_ibr.cdg_empresa = Empresa.cdg_empresa AND B-Proveedor_excen_ibr.cdg_tiporetibr = v-cdg_tipo_retibr:INPUT-VALUE"
               &RUTINAVALIDACION=validar_excencion_retenciones.p }
               
       RUN validar_fecha.p ( INPUT Proveedor_excen_ibr.fch_boletin:SCREEN-VALUE,
                             INPUT "EXIM006",
                             OUTPUT rc ).

       IF rc <> 0 THEN RETURN ERROR.

       IF DECIMAL(Proveedor_excen_ibr.prc_excencion:SCREEN-VALUE) = 0
       THEN DO:
            RUN ponmensj.p ( "EXIM007").
            RETURN ERROR.
       END.

  END.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   &SCOPED-DEFINE TABLA-MAESTRA  Proveedor_excen_ibr

   {asignartabla.i "tipo_retibr" "cdg_tiporetibr" "cdg_tiporetibr"}

   &UNDEFINE TABLA-MAESTRA

   {findempresa.i}

   IF NEW Proveedor_excen_ibr
      THEN ASSIGN Proveedor_excen_ibr.nro_proveedor  = Proveedor.nro_proveedor
                  Proveedor_excen_ibr.cdg_tiporetibr = tipo_retibr.cdg_tiporetibr
                  Proveedor_excen_ibr.cdg_empresa    = Empresa.cdg_empresa.


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

  {deshabcodigo.i "tipo_retibr" }

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

  IF AVAILABLE Proveedor_excen_ibr
  THEN DO:

        &SCOPED-DEFINE TABLA-MAESTRA  Proveedor_excen_ibr
     
        {displaytabla.i "tipo_retibr" "cdg_tiporetibr" "nom_retibr" "cdg_tiporetibr" "cdg_tiporetibr"} 

        &UNDEFINE TABLA-MAESTRA

  END.
  ELSE DO:

        {blanqueacodigo.i "tipo_retibr" } 

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

  {habilcodigo.i "tipo_retibr" }

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
  {src/adm/template/snd-list.i "Proveedor_excen_ibr"}
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

