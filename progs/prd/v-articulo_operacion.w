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
&Scoped-define EXTERNAL-TABLES Articulo_operacion Articulo
&Scoped-define FIRST-EXTERNAL-TABLE Articulo_operacion


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Articulo_operacion, Articulo.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Articulo_operacion.num_orden ~
Articulo_operacion.opcional Articulo_operacion.observacion 
&Scoped-define ENABLED-TABLES Articulo_operacion
&Scoped-define FIRST-ENABLED-TABLE Articulo_operacion
&Scoped-Define ENABLED-OBJECTS RECT-10 
&Scoped-Define DISPLAYED-FIELDS Articulo_operacion.num_orden ~
Articulo_operacion.opcional Articulo_operacion.observacion 
&Scoped-define DISPLAYED-TABLES Articulo_operacion
&Scoped-define FIRST-DISPLAYED-TABLE Articulo_operacion
&Scoped-Define DISPLAYED-OBJECTS v-cdg_operacionfabrica ~
v-dsc_operacionfabrica v-cdg_centrotrabajo v-dsc_centrotrabajo 

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
DEFINE VARIABLE v-cdg_centrotrabajo AS CHARACTER FORMAT "X(12)" 
     LABEL "Centro" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_operacionfabrica AS CHARACTER FORMAT "X(256)":U 
     LABEL "Operación" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-dsc_centrotrabajo AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 51 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_operacionfabrica AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 51 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 103 BY 9.52.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     v-cdg_operacionfabrica AT ROW 1.48 COL 14 COLON-ALIGNED
     v-dsc_operacionfabrica AT ROW 1.48 COL 31 COLON-ALIGNED NO-LABEL
     Articulo_operacion.num_orden AT ROW 1.48 COL 90 COLON-ALIGNED
          LABEL "Orden" FORMAT "999999"
          VIEW-AS FILL-IN NATIVE 
          SIZE 10 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_centrotrabajo AT ROW 2.91 COL 14 COLON-ALIGNED
     v-dsc_centrotrabajo AT ROW 2.91 COL 31 COLON-ALIGNED NO-LABEL
     Articulo_operacion.opcional AT ROW 2.91 COL 88
          VIEW-AS TOGGLE-BOX
          SIZE 13.4 BY .81
     Articulo_operacion.observacion AT ROW 5.76 COL 3 NO-LABEL
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 99 BY 4.52
          BGCOLOR 15 FGCOLOR 7 
     RECT-10 AT ROW 1 COL 1
     "   Observaciones pertinentes a la presente operación" VIEW-AS TEXT
          SIZE 99 BY 1 AT ROW 4.33 COL 3
          BGCOLOR 5 FGCOLOR 15 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Articulo_operacion,sic.Articulo
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
         HEIGHT             = 9.86
         WIDTH              = 105.2.
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

/* SETTINGS FOR FILL-IN Articulo_operacion.num_orden IN FRAME F-Main
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN v-cdg_centrotrabajo IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_operacionfabrica IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_centrotrabajo IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_operacionfabrica IN FRAME F-Main
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

&Scoped-define SELF-NAME v-cdg_centrotrabajo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_centrotrabajo V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_centrotrabajo IN FRAME F-Main /* Centro */
OR "." OF v-cdg_Centrotrabajo IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_Centrotrabajo IN FRAME {&FRAME-NAME}

DO:

   {helptabla.i "Centrotrabajo" "cdg_centrotrabajo" "selcentrotrabajo.p"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_centrotrabajo V-table-Win
ON RETURN OF v-cdg_centrotrabajo IN FRAME F-Main /* Centro */
DO:
   {traducetabla.i "Centrotrabajo" "cdg_centrotrabajo" "dsc_centrotrabajo"} 
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_operacionfabrica
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_operacionfabrica V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_operacionfabrica IN FRAME F-Main /* Operación */
OR "." OF v-cdg_operacionfabrica IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_operacionfabrica IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "operacionfabrica" "cdg_operacion" "seloperacion.p"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_operacionfabrica V-table-Win
ON RETURN OF v-cdg_operacionfabrica IN FRAME F-Main /* Operación */
DO:
  {traducetabla.i "Operacionfabrica" "cdg_operacion" "cdg_operacion"}   
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
  {src/adm/template/row-list.i "Articulo_operacion"}
  {src/adm/template/row-list.i "Articulo"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Articulo_operacion"}
  {src/adm/template/row-find.i "Articulo"}

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

  {blanqueacodigo.i "Operacionfabrica" }
  {blanqueacodigo.i "Centrotrabajo" }

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

   &SCOPED-DEFINE TABLA-MAESTRA  Articulo_operacion

   {validartabla.i "Operacionfabrica" "cdg_operacion" "dsc_operacion" "ARTI003"} 
   {validartabla.i "Centrotrabajo" "cdg_centrotrabajo" "dsc_centrotrabajo" "ARTI003"} 
      
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   {asignartabla.i "Operacionfabrica" "nro_operacion" "nro_operacion"} 
   {asignartabla.i "Centrotrabajo" "nro_centrotrabajo" "nro_centrotrabajo"} 
   
   &UNDEFINE TABLA-MAESTRA

  Articulo_operacion.nro_articulo = Articulo.nro_articulo.

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

   DEFINE VARIABLE hay_error AS LOGICAL.

   RUN vlb-articulo_operacion.p ( INPUT ROWID(Articulo_operacion), OUTPUT hay_error ).
   IF hay_error
   THEN DO:
       RUN ponmensj.p ( INPUT "IREF001" ).
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

  {deshabcodigo.i "Operacionfabrica" }
  {deshabcodigo.i "Centrotrabajo" }

  Articulo_operacion.observacion:FGCOLOR IN FRAME {&FRAME-NAME} = 7.

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

  IF AVAILABLE Articulo_operacion
  THEN DO:

        
        &SCOPED-DEFINE TABLA-MAESTRA Articulo_operacion
        
        {displaytabla.i  "Operacionfabrica" "cdg_operacion" "dsc_operacion" "nro_operacion" "nro_operacion" } 
        {displaytabla.i  "Centrotrabajo"    "cdg_centrotrabajo" "dsc_centrotrabajo" "nro_centrotrabajo" "nro_centrotrabajo" } 
        
        &UNDEFINE TABLA-MAESTRA


  END.
  ELSE DO:

      {blanqueacodigo.i "Operacionfabrica"} 
      {blanqueacodigo.i "Centrotrabajo"} 
      
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

  {habilcodigo.i "Operacionfabrica" }
  {habilcodigo.i "Centrotrabajo" }

  Articulo_operacion.observacion:FGCOLOR IN FRAME {&FRAME-NAME} = 9.

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
  {src/adm/template/snd-list.i "Articulo_operacion"}
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

