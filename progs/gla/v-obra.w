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
&Scoped-define EXTERNAL-TABLES Obra
&Scoped-define FIRST-EXTERNAL-TABLE Obra


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Obra.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Obra.cdg_obra Obra.dsc_obra ~
Obra.entidades_validas Obra.lista_empresas Obra.cdg_subclaseobra ~
Obra.fecha_apertura Obra.fecha_cierre Obra.permanente Obra.finalizada 
&Scoped-define ENABLED-TABLES Obra
&Scoped-define FIRST-ENABLED-TABLE Obra
&Scoped-Define ENABLED-OBJECTS RECT-6 
&Scoped-Define DISPLAYED-FIELDS Obra.cdg_obra Obra.dsc_obra ~
Obra.entidades_validas Obra.lista_empresas Obra.cdg_subclaseobra ~
Obra.fecha_apertura Obra.fecha_cierre Obra.permanente Obra.finalizada ~
Obra.obs_obra 
&Scoped-define DISPLAYED-TABLES Obra
&Scoped-define FIRST-DISPLAYED-TABLE Obra


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
     LABEL "Elegir" 
     SIZE 15 BY 1.

DEFINE BUTTON btn_elegir-2 
     LABEL "Elegir" 
     SIZE 15 BY 1.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 84 BY 16.67.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Obra.cdg_obra AT ROW 1.48 COL 15 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Obra.dsc_obra AT ROW 2.67 COL 15 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 66 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Obra.entidades_validas AT ROW 3.86 COL 15 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 50 BY 1
          BGCOLOR 15 FGCOLOR 9 
     btn_elegir AT ROW 3.86 COL 68
     btn_elegir-2 AT ROW 5 COL 68
     Obra.lista_empresas AT ROW 5.05 COL 15 COLON-ALIGNED
          LABEL "Empresas"
          VIEW-AS FILL-IN 
          SIZE 50 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Obra.cdg_subclaseobra AT ROW 6.24 COL 15 COLON-ALIGNED
          LABEL "Clasifica" FORMAT "X(50)"
          VIEW-AS FILL-IN 
          SIZE 50 BY 1
          BGCOLOR 15 FGCOLOR 9 
     btn_clasificar AT ROW 6.24 COL 68
     Obra.fecha_apertura AT ROW 7.43 COL 15 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Obra.fecha_cierre AT ROW 7.43 COL 68 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Obra.permanente AT ROW 8.62 COL 17
          VIEW-AS TOGGLE-BOX
          SIZE 15 BY .76
     Obra.finalizada AT ROW 8.62 COL 70
          VIEW-AS TOGGLE-BOX
          SIZE 14 BY .76
     Obra.obs_obra AT ROW 11 COL 4 NO-LABEL
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 79 BY 6.29
          BGCOLOR 15 FGCOLOR 7 
     "                        Observaciones Asociadas a la Obra" VIEW-AS TEXT
          SIZE 79 BY 1 AT ROW 9.81 COL 4
          BGCOLOR 7 FGCOLOR 15 
     RECT-6 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Obra
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
         HEIGHT             = 16.91
         WIDTH              = 85.
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
/* SETTINGS FOR BUTTON btn_elegir-2 IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Obra.cdg_subclaseobra IN FRAME F-Main
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN Obra.lista_empresas IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR EDITOR Obra.obs_obra IN FRAME F-Main
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

&Scoped-define SELF-NAME btn_clasificar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_clasificar V-table-Win
ON CHOOSE OF btn_clasificar IN FRAME F-Main /* Clasificar */
DO:
   DEFINE VARIABLE codigo_salida AS INTEGER.
   DEFINE VARIABLE sel_clase    AS CHARACTER.
   DEFINE VARIABLE rid_Entidad AS ROWID.

   sel_clase = Obra.cdg_subclaseobr:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
   RUN d-selclase_obras.w ( INPUT-OUTPUT sel_clase, OUTPUT codigo_salida  ).
   IF codigo_salida = 1
   THEN DO:
      Obra.cdg_subclaseobr:SCREEN-VALUE IN FRAME {&FRAME-NAME} = sel_clase.
   END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_elegir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_elegir V-table-Win
ON CHOOSE OF btn_elegir IN FRAME F-Main /* Elegir */
DO:
{ELEGIR.I "Obra" "entidades_validas" "Entidad" "cdg_entidad" "dsc_entidad" "SELECENT.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_elegir-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_elegir-2 V-table-Win
ON CHOOSE OF btn_elegir-2 IN FRAME F-Main /* Elegir */
DO:
{ELEGIR.I "Obra" "lista_empresas" "Empresa" "cdg_empresa" "nombre" "SELECEMP.P"}
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
  {src/adm/template/row-list.i "Obra"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Obra"}

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

  ASSIGN FRAME {&FRAME-NAME} Obra.obs_obra.

  IF NEW Obra
     THEN Obra.nro_obra = NEXT-VALUE(proxima_obra).

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
   RUN vlb-obras.p ( INPUT ROWID(Obra), OUTPUT baja_no ).
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

   Obra.obs_obra:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
   Obra.obs_obra:FGCOLOR   IN FRAME {&FRAME-NAME} = 8.
   btn_elegir:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
   btn_elegir-2:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
   btn_clasificar:SENSITIVE IN FRAME {&FRAME-NAME} = NO.

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

   Obra.obs_obra:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
   Obra.obs_obra:FGCOLOR   IN FRAME {&FRAME-NAME} = 9.
   btn_elegir:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
   btn_elegir-2:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
   btn_clasificar:SENSITIVE IN FRAME {&FRAME-NAME} = YES.

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
  {src/adm/template/snd-list.i "Obra"}

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

