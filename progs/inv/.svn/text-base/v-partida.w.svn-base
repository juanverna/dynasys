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

DEFINE VARIABLE que_empresa LIKE Empresa.cdg_empresa.

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
&Scoped-define EXTERNAL-TABLES Partida Articulo
&Scoped-define FIRST-EXTERNAL-TABLE Partida


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Partida, Articulo.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Partida.cdg_partida Partida.ubicacion ~
Partida.descripcion Partida.fecha_alta Partida.fecha_vencimiento ~
Partida.ultima_merma Partida.estado 
&Scoped-define ENABLED-TABLES Partida
&Scoped-define FIRST-ENABLED-TABLE Partida
&Scoped-Define ENABLED-OBJECTS RECT-2 RECT-3 RECT-4 
&Scoped-Define DISPLAYED-FIELDS Partida.cdg_partida Partida.ubicacion ~
Partida.descripcion Partida.fecha_alta Partida.fecha_vencimiento ~
Partida.reservado_cantidad Partida.remanente_cantidad ~
Partida.remanente_granel Partida.reservado_granel Partida.ultima_merma ~
Partida.estado 
&Scoped-define DISPLAYED-TABLES Partida
&Scoped-define FIRST-DISPLAYED-TABLE Partida


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
DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 29 BY 3.1.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 27 BY 3.1.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 4 GRAPHIC-EDGE  NO-FILL 
     SIZE 70 BY 9.05.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Partida.cdg_partida AT ROW 1.52 COL 18 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 12 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Partida.ubicacion AT ROW 1.52 COL 46 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Partida.descripcion AT ROW 2.62 COL 18 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 45 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Partida.fecha_alta AT ROW 3.67 COL 18 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 12 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Partida.fecha_vencimiento AT ROW 3.67 COL 46 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Partida.reservado_cantidad AT ROW 5.52 COL 48 COLON-ALIGNED
          LABEL "Unidades"
          VIEW-AS FILL-IN NATIVE 
          SIZE 12 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Partida.remanente_cantidad AT ROW 5.57 COL 18 COLON-ALIGNED
          LABEL "Unidades"
          VIEW-AS FILL-IN NATIVE 
          SIZE 12 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Partida.remanente_granel AT ROW 6.71 COL 18 COLON-ALIGNED
          LABEL "Granel"
          VIEW-AS FILL-IN NATIVE 
          SIZE 12 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Partida.reservado_granel AT ROW 6.71 COL 48 COLON-ALIGNED
          LABEL "Granel"
          VIEW-AS FILL-IN NATIVE 
          SIZE 12 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Partida.ultima_merma AT ROW 8.38 COL 18 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 12 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Partida.estado AT ROW 8.62 COL 38 NO-LABEL
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Abierta", "",
"Cerrada", "C":U
          SIZE 24 BY .81
     RECT-2 AT ROW 5.05 COL 7
     RECT-3 AT ROW 5.05 COL 38
     RECT-4 AT ROW 1 COL 1
     "   Remanente" VIEW-AS TEXT
          SIZE 13 BY .62 AT ROW 4.76 COL 12.8
     "   Disponible" VIEW-AS TEXT
          SIZE 12 BY .62 AT ROW 4.76 COL 43.2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Partida,sic.Articulo
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
         HEIGHT             = 15.24
         WIDTH              = 73.6.
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

/* SETTINGS FOR FILL-IN Partida.remanente_granel IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN Partida.remanente_cantidad IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN Partida.reservado_granel IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN Partida.reservado_cantidad IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME F-Main
/* Query rebuild information for FRAME F-Main
     _Options          = "NO-LOCK"
     _Query            is NOT OPENED
*/  /* FRAME F-Main */
&ANALYZE-RESUME

 


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
  {src/adm/template/row-list.i "Partida"}
  {src/adm/template/row-list.i "Articulo"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Partida"}
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

  IF NEW Partida
  THEN DO:
       {findempresa.i}
       FIND CURRENT Articulo EXCLUSIVE-LOCK.
       ASSIGN Partida.nro_articulo   = Articulo.nro_articulo
              Articulo.ult_partida   = Articulo.ult_partida + 1
              Partida.nro_partida    = Articulo.ult_partida
              Partida.cdg_empresa    = Empresa.cdg_empresa.
       FIND CURRENT Articulo NO-LOCK.
  END.
  

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
   RUN vlb-partidas.p ( INPUT ROWID(Partida), OUTPUT baja_no ).
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
  {src/adm/template/snd-list.i "Partida"}
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

