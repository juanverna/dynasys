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

DEFINE VARIABLE rid_tabla     AS ROWID.
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
&Scoped-define EXTERNAL-TABLES Domicilio_prv Proveedor
&Scoped-define FIRST-EXTERNAL-TABLE Domicilio_prv


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Domicilio_prv, Proveedor.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Domicilio_prv.nro_domicilio ~
Domicilio_prv.nombre Domicilio_prv.direccion Domicilio_prv.localidad ~
Domicilio_prv.cdg_postal Domicilio_prv.cdg_provincia Domicilio_prv.cdg_pais ~
Domicilio_prv.telefono Domicilio_prv.email 
&Scoped-define ENABLED-TABLES Domicilio_prv
&Scoped-define FIRST-ENABLED-TABLE Domicilio_prv
&Scoped-Define ENABLED-OBJECTS RECT-10 
&Scoped-Define DISPLAYED-FIELDS Domicilio_prv.nro_domicilio ~
Domicilio_prv.nombre Domicilio_prv.direccion Domicilio_prv.localidad ~
Domicilio_prv.cdg_postal Domicilio_prv.cdg_provincia Domicilio_prv.cdg_pais ~
Domicilio_prv.telefono Domicilio_prv.email 
&Scoped-define DISPLAYED-TABLES Domicilio_prv
&Scoped-define FIRST-DISPLAYED-TABLE Domicilio_prv


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
DEFINE BUTTON btn_copiar 
     LABEL "Copiar" 
     SIZE 15 BY 1.14.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 80 BY 9.05.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     btn_copiar AT ROW 1.24 COL 62
     Domicilio_prv.nro_domicilio AT ROW 1.48 COL 11 COLON-ALIGNED
          LABEL "Número"
          VIEW-AS FILL-IN 
          SIZE 11 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Domicilio_prv.nombre AT ROW 2.67 COL 11 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 64 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Domicilio_prv.direccion AT ROW 3.86 COL 2.2
          VIEW-AS FILL-IN 
          SIZE 64 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Domicilio_prv.localidad AT ROW 5.05 COL 11 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 29 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Domicilio_prv.cdg_postal AT ROW 5.05 COL 56 COLON-ALIGNED
          LABEL "C.Postal"
          VIEW-AS FILL-IN 
          SIZE 19 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Domicilio_prv.cdg_provincia AT ROW 6.24 COL 11 COLON-ALIGNED
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Item 1","Item 1"
          DROP-DOWN-LIST
          SIZE 29 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Domicilio_prv.cdg_pais AT ROW 6.24 COL 50 COLON-ALIGNED
          LABEL "Pais"
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "0",1
          DROP-DOWN-LIST
          SIZE 25 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Domicilio_prv.telefono AT ROW 7.43 COL 11 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 64 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Domicilio_prv.email AT ROW 8.62 COL 11 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 64 BY 1
          BGCOLOR 15 FGCOLOR 9 
     RECT-10 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE NO-VALIDATE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Domicilio_prv,sic.Proveedor
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
         HEIGHT             = 25.91
         WIDTH              = 160.
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

/* SETTINGS FOR BUTTON btn_copiar IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX Domicilio_prv.cdg_pais IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Domicilio_prv.cdg_postal IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Domicilio_prv.direccion IN FRAME F-Main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN Domicilio_prv.nro_domicilio IN FRAME F-Main
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

&Scoped-define SELF-NAME btn_copiar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_copiar V-table-Win
ON CHOOSE OF btn_copiar IN FRAME F-Main /* Copiar */
DO:

   DISPLAY Proveedor.cdg_postal      @    Domicilio_prv.cdg_postal    
           Proveedor.direccion       @    Domicilio_prv.direccion     
           Proveedor.localidad       @    Domicilio_prv.localidad     
           Proveedor.nombre          @    Domicilio_prv.nombre        
           Proveedor.telefono        @    Domicilio_prv.telefono   
           WITH FRAME {&FRAME-NAME}.

   ASSIGN   Domicilio_prv.cdg_pais:SCREEN-VALUE = STRING(Proveedor.cdg_pais)
            Domicilio_prv.cdg_provincia:SCREEN-VALUE  = Proveedor.cdg_provincia .

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
  {src/adm/template/row-list.i "Domicilio_prv"}
  {src/adm/template/row-list.i "Proveedor"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Domicilio_prv"}
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
      {levantacombo.i &TABLA=Pais &NOMBRE=nombre &CODIGO=cdg_pais &OBJETO=Domicilio_prv.cdg_pais }
      {levantacombo.i &TABLA=Provincia &NOMBRE=nombre &CODIGO=cdg_provincia &OBJETO=Domicilio_prv.cdg_provincia }
  END.

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

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   ASSIGN
       Domicilio_prv.nro_proveedor = Proveedor.nro_proveedor. 

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

  btn_copiar:SENSITIVE IN FRAME {&FRAME-NAME} = NO.

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

  btn_copiar:SENSITIVE IN FRAME {&FRAME-NAME} = YES.

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
  {src/adm/template/snd-list.i "Domicilio_prv"}
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

