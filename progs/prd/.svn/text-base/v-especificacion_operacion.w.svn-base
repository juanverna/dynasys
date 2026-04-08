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
&Scoped-define EXTERNAL-TABLES Especif_operacion Operacionfabrica
&Scoped-define FIRST-EXTERNAL-TABLE Especif_operacion


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Especif_operacion, Operacionfabrica.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Especif_operacion.valor_deseado ~
Especif_operacion.valor_especificacion Especif_operacion.valor_minimo ~
Especif_operacion.valor_maximo Especif_operacion.momento_revision ~
Especif_operacion.observacion 
&Scoped-define ENABLED-TABLES Especif_operacion
&Scoped-define FIRST-ENABLED-TABLE Especif_operacion
&Scoped-Define ENABLED-OBJECTS RECT-6 RECT-7 
&Scoped-Define DISPLAYED-FIELDS Especif_operacion.valor_deseado ~
Especif_operacion.valor_especificacion Especif_operacion.valor_minimo ~
Especif_operacion.valor_maximo Especif_operacion.momento_revision ~
Especif_operacion.observacion 
&Scoped-define DISPLAYED-TABLES Especif_operacion
&Scoped-define FIRST-DISPLAYED-TABLE Especif_operacion
&Scoped-Define DISPLAYED-OBJECTS v-cdg_especificacion v-dsc_especificacion 

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
DEFINE VARIABLE v-cdg_especificacion AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-dsc_especificacion AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 43.2 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 64 BY 11.91.

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 64 BY 5.95.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     v-cdg_especificacion AT ROW 2.67 COL 3 COLON-ALIGNED NO-LABEL
     v-dsc_especificacion AT ROW 2.67 COL 17.8 COLON-ALIGNED NO-LABEL
     Especif_operacion.valor_deseado AT ROW 5.29 COL 11 COLON-ALIGNED
          LABEL "Deseado"
          VIEW-AS FILL-IN NATIVE 
          SIZE 13.6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Especif_operacion.valor_especificacion AT ROW 5.29 COL 46 COLON-ALIGNED
          LABEL "Normal"
          VIEW-AS FILL-IN NATIVE 
          SIZE 13.6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Especif_operacion.valor_minimo AT ROW 6.71 COL 11 COLON-ALIGNED
          LABEL "Mínimo"
          VIEW-AS FILL-IN NATIVE 
          SIZE 13.6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Especif_operacion.valor_maximo AT ROW 6.71 COL 46 COLON-ALIGNED
          LABEL "Máximo"
          VIEW-AS FILL-IN NATIVE 
          SIZE 13.6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Especif_operacion.momento_revision AT ROW 9.33 COL 19 NO-LABEL
          VIEW-AS RADIO-SET VERTICAL
          RADIO-BUTTONS 
                    "Antes de la operaciòn", "A":U,
"Durante la Operación", "D":U,
"Al Finalizar la Operación", "F":U
          SIZE 30 BY 3.1
     Especif_operacion.observacion AT ROW 14.57 COL 3 NO-LABEL
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 60 BY 4
          BGCOLOR 15 FGCOLOR 7 
     RECT-6 AT ROW 1 COL 1
     RECT-7 AT ROW 13.14 COL 1
     "   Valores de especificación asociados a la operación" VIEW-AS TEXT
          SIZE 60 BY 1 AT ROW 4.1 COL 3
          BGCOLOR 5 FGCOLOR 15 
     "   La revisión de esta especificación debe realizarse" VIEW-AS TEXT
          SIZE 60 BY 1 AT ROW 8.14 COL 3
          BGCOLOR 5 FGCOLOR 15 
     "         Especificación asociada a la operación de fábrica" VIEW-AS TEXT
          SIZE 60 BY 1 AT ROW 1.24 COL 3
          BGCOLOR 5 FGCOLOR 15 
     "   Observaciones asociadas" VIEW-AS TEXT
          SIZE 60 BY 1 AT ROW 13.38 COL 3
          BGCOLOR 5 FGCOLOR 15 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Especif_operacion,sic.Operacionfabrica
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
         HEIGHT             = 19.62
         WIDTH              = 95.6.
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

/* SETTINGS FOR FILL-IN v-cdg_especificacion IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_especificacion IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Especif_operacion.valor_deseado IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Especif_operacion.valor_especificacion IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Especif_operacion.valor_maximo IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Especif_operacion.valor_minimo IN FRAME F-Main
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

&Scoped-define SELF-NAME v-cdg_especificacion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_especificacion V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_especificacion IN FRAME F-Main
OR "." OF v-cdg_especificacion IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_especificacion IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "especificacion" "cdg_especificacion" "selespecific.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_especificacion V-table-Win
ON RETURN OF v-cdg_especificacion IN FRAME F-Main
DO:
   {traducetabla.i "especificacion" "cdg_especificacion" "cdg_especificacion"}   
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
  {src/adm/template/row-list.i "Especif_operacion"}
  {src/adm/template/row-list.i "Operacionfabrica"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Especif_operacion"}
  {src/adm/template/row-find.i "Operacionfabrica"}

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

  {blanqueacodigo.i "Especificacion" }

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

   &SCOPED-DEFINE TABLA-MAESTRA  Especif_operacion

   {validartabla.i "Especificacion" "cdg_especificacion" "dsc_especificacion" "CLIE008"} 

   &UNDEFINE TABLA-MAESTRA

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   &SCOPED-DEFINE TABLA-MAESTRA  Especif_operacion

   {asignartabla.i "Especificacion" "nro_especificacion" "nro_especificacion"} 

   &UNDEFINE TABLA-MAESTRA
  

  Especif_operacion.nro_operacion = Operacionfabrica.nro_operacion.


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

  {deshabcodigo.i "Especificacion" }

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

  IF AVAILABLE Especif_operacion
  THEN DO:

        &SCOPED-DEFINE TABLA-MAESTRA  Especif_operacion
     
        {displaytabla.i "Especificacion" "cdg_especificacion" "cdg_Especificacion" "nro_especificacion" "nro_Especificacion"} 

        &UNDEFINE TABLA-MAESTRA

  END.
  ELSE DO:

      {blanqueacodigo.i "Especificacion" }

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

  {habilcodigo.i "Especificacion" }

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
  {src/adm/template/snd-list.i "Especif_operacion"}
  {src/adm/template/snd-list.i "Operacionfabrica"}

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

