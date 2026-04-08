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
&Scoped-define EXTERNAL-TABLES Partetareas Tarea
&Scoped-define FIRST-EXTERNAL-TABLE Partetareas


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Partetareas, Tarea.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Partetareas.cdg_recurso Partetareas.fch_parte ~
Partetareas.facturable Partetareas.hms_desde Partetareas.hms_hasta ~
Partetareas.lugar_prestacion Partetareas.observacion_parte 
&Scoped-define ENABLED-TABLES Partetareas
&Scoped-define FIRST-ENABLED-TABLE Partetareas
&Scoped-Define ENABLED-OBJECTS RECT-1 
&Scoped-Define DISPLAYED-FIELDS Partetareas.cdg_recurso ~
Partetareas.fch_parte Partetareas.facturable Partetareas.hms_desde ~
Partetareas.hms_hasta Partetareas.lugar_prestacion ~
Partetareas.observacion_parte 
&Scoped-define DISPLAYED-TABLES Partetareas
&Scoped-define FIRST-DISPLAYED-TABLE Partetareas


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
cdg_recurso||y|sic.Partetareas.cdg_recurso
nro_tarea||y|sic.Partetareas.nro_tarea
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = ,
     Keys-Supplied = "cdg_recurso,nro_tarea"':U).
/**************************
</EXECUTING-CODE> */
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD convertir_hora V-table-Win 
FUNCTION convertir_hora RETURNS INTEGER
  ( INPUT p-hms AS CHARACTER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD normalizar_hora V-table-Win 
FUNCTION normalizar_hora RETURNS CHARACTER
  ( INPUT p-hms AS CHARACTER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 116 BY 5.48.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Partetareas.cdg_recurso AT ROW 1.48 COL 6.8
          LABEL "Recurso"
          VIEW-AS COMBO-BOX INNER-LINES 25
          LIST-ITEM-PAIRS "Item 1","Item 1"
          DROP-DOWN-LIST
          SIZE 47 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Partetareas.fch_parte AT ROW 1.48 COL 78 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 14 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Partetareas.facturable AT ROW 1.48 COL 96
          LABEL "Cargo al Cliente"
          VIEW-AS TOGGLE-BOX
          SIZE 20 BY 1.05
     Partetareas.hms_desde AT ROW 2.67 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 14 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Partetareas.hms_hasta AT ROW 2.67 COL 47 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 14 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Partetareas.lugar_prestacion AT ROW 2.67 COL 78 COLON-ALIGNED
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEMS "Cliente","Estudio","Domicilio","Viaje","Otros" 
          DROP-DOWN-LIST
          SIZE 35 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Partetareas.observacion_parte AT ROW 5.05 COL 1 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 112 BY 1
          BGCOLOR 15 FGCOLOR 9 
     "   Observaciones asociadas a la actividad" VIEW-AS TEXT
          SIZE 112 BY 1 AT ROW 3.86 COL 3
          BGCOLOR 5 FGCOLOR 15 
     RECT-1 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Partetareas,sic.Tarea
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
         HEIGHT             = 9.57
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

/* SETTINGS FOR COMBO-BOX Partetareas.cdg_recurso IN FRAME F-Main
   ALIGN-L EXP-LABEL                                                    */
/* SETTINGS FOR TOGGLE-BOX Partetareas.facturable IN FRAME F-Main
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

&Scoped-define SELF-NAME Partetareas.hms_desde
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Partetareas.hms_desde V-table-Win
ON LEAVE OF Partetareas.hms_desde IN FRAME F-Main /* Desde Hora */
DO:
    DEFINE VARIABLE hh AS CHARACTER.
    hh = normalizar_hora(SELF:SCREEN-VALUE).
    IF hh <> ? THEN SELF:SCREEN-VALUE = hh.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Partetareas.hms_hasta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Partetareas.hms_hasta V-table-Win
ON LEAVE OF Partetareas.hms_hasta IN FRAME F-Main /* Hasta Hora */
DO:
    DEFINE VARIABLE hh AS CHARACTER.
    hh = normalizar_hora(SELF:SCREEN-VALUE).
    IF hh <> ? THEN SELF:SCREEN-VALUE = hh.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-find-using-key V-table-Win  adm/support/_key-fnd.p
PROCEDURE adm-find-using-key :
/*------------------------------------------------------------------------------
  Purpose:     Finds the current record using the contents of
               the 'Key-Name' and 'Key-Value' attributes.
  Parameters:  <none>
------------------------------------------------------------------------------*/

  /* No Foreign keys are accepted by this SmartObject. */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

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
  {src/adm/template/row-list.i "Partetareas"}
  {src/adm/template/row-list.i "Tarea"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Partetareas"}
  {src/adm/template/row-find.i "Tarea"}

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

  Partetarea.cdg_recurso:SCREEN-VALUE IN FRAME {&FRAME-NAME} = Tarea.cdg_recurso.
  DISPLAY TODAY @ sic.Partetareas.fch_parte
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

  /* Code placed here will execute PRIOR to standard behavior. */

  DEFINE VARIABLE h1 AS INTEGER.
  DEFINE VARIABLE h2 AS INTEGER.
  
  h1 = convertir_hora(Partetareas.hms_desde:INPUT-VALUE IN  FRAME {&FRAME-NAME}).
  IF h1 = ? OR Partetareas.hms_desde:INPUT-VALUE = "" 
  THEN DO:
      RUN ponmensj.p ( INPUT "PART001" ).
      RETURN ERROR.
  END.

  h2 = convertir_hora(Partetareas.hms_hasta:INPUT-VALUE IN  FRAME {&FRAME-NAME}).
  IF h2 = ? OR Partetareas.hms_hasta:INPUT-VALUE = ""
  THEN DO:
      RUN ponmensj.p ( INPUT "PART002" ).
      RETURN ERROR.
  END.

  IF h1 >= h2
  THEN DO:
      RUN ponmensj.p ( INPUT "PART003" ).
      RETURN ERROR.
  END.

  IF Partetareas.fch_parte:INPUT-VALUE IN  FRAME {&FRAME-NAME} = DATE("")
  THEN DO:
      RUN ponmensj.p ( INPUT "PART004" ).
      RETURN ERROR.
  END.
  
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  ASSIGN Partetareas.nro_tarea = Tarea.nro_tarea
         Partetareas.hor_desde = h1
         Partetareas.hor_hasta = h2.


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

  DEFINE VARIABLE x-lista AS CHARACTER.
  
  x-lista = "".
  FOR EACH Recurso BY Recurso.nom_recurso:
    x-lista = x-lista +  "," + Recurso.nom_recurso + "," + Recurso.cdg_recurso.
  END.
  Partetarea.cdg_recurso:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = SUBSTRING(x-lista,2).

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-key V-table-Win  adm/support/_key-snd.p
PROCEDURE send-key :
/*------------------------------------------------------------------------------
  Purpose:     Sends a requested KEY value back to the calling
               SmartObject.
  Parameters:  <see adm/template/sndkytop.i>
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.             */
  {src/adm/template/sndkytop.i}

  /* Return the key value associated with each key case.             */
  {src/adm/template/sndkycas.i "cdg_recurso" "Partetareas" "cdg_recurso"}
  {src/adm/template/sndkycas.i "nro_tarea" "Partetareas" "nro_tarea"}

  /* Close the CASE statement and end the procedure.                 */
  {src/adm/template/sndkyend.i}

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
  {src/adm/template/snd-list.i "Partetareas"}
  {src/adm/template/snd-list.i "Tarea"}

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

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION convertir_hora V-table-Win 
FUNCTION convertir_hora RETURNS INTEGER
  ( INPUT p-hms AS CHARACTER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

  DEFINE VARIABLE hh AS INTEGER.
  DEFINE VARIABLE mm AS INTEGER. 
  DEFINE VARIABLE hora AS INTEGER.

  hora = ?. /* Si no valida el formato, la función retornará este valor*/

  hh = INTEGER(SUBSTRING(p-hms,1,2)) NO-ERROR.
  IF NOT ERROR-STATUS:ERROR
  THEN DO:
      mm = INTEGER(SUBSTRING(p-hms,4,2)) NO-ERROR.
      IF NOT ERROR-STATUS:ERROR
      THEN DO:
          IF hh <= 23 AND hh >= 0
          THEN DO:
              IF mm <= 59 AND mm >= 0
              THEN DO:
                  hora = hh * 3600 + mm * 60.
              END.
          END.
      END.
  END.

  RETURN hora.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION normalizar_hora V-table-Win 
FUNCTION normalizar_hora RETURNS CHARACTER
  ( INPUT p-hms AS CHARACTER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

  DEFINE VARIABLE v-hms AS CHARACTER.

  v-hms = SUBSTRING(p-hms,1,5).

  CASE LENGTH(v-hms):
      WHEN 1 THEN v-hms = "0" + v-hms + ":00".
      WHEN 2 THEN v-hms = v-hms + ":00".
      WHEN 3 THEN v-hms = SUBSTRING(v-hms,1,2) + ":00".
      WHEN 4 THEN v-hms = SUBSTRING(v-hms,1,2) + ":" + SUBSTRING(v-hms,3,2).
      WHEN 5 THEN v-hms = SUBSTRING(v-hms,1,2) + ":" + SUBSTRING(v-hms,4,2).
  END CASE.

  RETURN v-hms.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

