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
&Scoped-define EXTERNAL-TABLES Tipo_tarea
&Scoped-define FIRST-EXTERNAL-TABLE Tipo_tarea


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Tipo_tarea.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Tipo_tarea.cdg_tipotarea ~
Tipo_tarea.color_letra Tipo_tarea.informa Tipo_tarea.color_fondo ~
Tipo_tarea.dsc_tipotarea Tipo_tarea.cambio Tipo_tarea.Pgm_abm 
&Scoped-define ENABLED-TABLES Tipo_tarea
&Scoped-define FIRST-ENABLED-TABLE Tipo_tarea
&Scoped-Define ENABLED-OBJECTS RECT-2 
&Scoped-Define DISPLAYED-FIELDS Tipo_tarea.cdg_tipotarea ~
Tipo_tarea.color_letra Tipo_tarea.informa Tipo_tarea.color_fondo ~
Tipo_tarea.dsc_tipotarea Tipo_tarea.cambio Tipo_tarea.Pgm_abm 
&Scoped-define DISPLAYED-TABLES Tipo_tarea
&Scoped-define FIRST-DISPLAYED-TABLE Tipo_tarea


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
DEFINE BUTTON btn_archivos 
     LABEL "&Archivos" 
     SIZE 12 BY 1.

DEFINE BUTTON btn_nextcolorfondo 
     IMAGE-UP FILE "adeicon\next-au":U
     LABEL "btn_nextmes" 
     SIZE 4 BY 1.

DEFINE BUTTON btn_nextcolorletra 
     IMAGE-UP FILE "adeicon\next-au":U
     LABEL "btn_nextmes" 
     SIZE 4 BY 1.

DEFINE BUTTON btn_prevcolorfondo 
     IMAGE-UP FILE "adeicon\prev-au":U
     LABEL "btn_prevcolorletra 2" 
     SIZE 4 BY 1.

DEFINE BUTTON btn_prevcolorletra 
     IMAGE-UP FILE "adeicon\prev-au":U
     LABEL "Button 44" 
     SIZE 4 BY 1.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 80 BY 7.14.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Tipo_tarea.cdg_tipotarea AT ROW 2.43 COL 13 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Tipo_tarea.color_letra AT ROW 2.43 COL 34 COLON-ALIGNED WIDGET-ID 16
          VIEW-AS FILL-IN NATIVE 
          SIZE 6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     btn_prevcolorletra AT ROW 2.43 COL 43 WIDGET-ID 12
     btn_nextcolorletra AT ROW 2.43 COL 47 WIDGET-ID 8
     Tipo_tarea.informa AT ROW 2.43 COL 57 WIDGET-ID 22
          VIEW-AS TOGGLE-BOX
          SIZE 13.4 BY .81
     Tipo_tarea.color_fondo AT ROW 3.62 COL 34 COLON-ALIGNED WIDGET-ID 14
          VIEW-AS FILL-IN NATIVE 
          SIZE 6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     btn_prevcolorfondo AT ROW 3.62 COL 43 WIDGET-ID 10
     btn_nextcolorfondo AT ROW 3.62 COL 47 WIDGET-ID 6
     Tipo_tarea.dsc_tipotarea AT ROW 4.86 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 44 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Tipo_tarea.cambio AT ROW 5.95 COL 14 COLON-ALIGNED WIDGET-ID 24
          VIEW-AS FILL-IN 
          SIZE 64 BY 1 TOOLTIP "CANDO de tareas posibles de cambio"
     Tipo_tarea.Pgm_abm AT ROW 7.05 COL 14 COLON-ALIGNED WIDGET-ID 20
          VIEW-AS FILL-IN NATIVE 
          SIZE 52 BY 1 TOOLTIP "Programa especializado para solicitar datos TAREA"
          BGCOLOR 15 FGCOLOR 9 
     btn_archivos AT ROW 7.05 COL 69 WIDGET-ID 18
     RECT-2 AT ROW 1.24 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Tipo_tarea
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
         HEIGHT             = 7.48
         WIDTH              = 82.6.
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

/* SETTINGS FOR BUTTON btn_archivos IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_nextcolorfondo IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_nextcolorletra IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_prevcolorfondo IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_prevcolorletra IN FRAME F-Main
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

&Scoped-define SELF-NAME btn_archivos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_archivos V-table-Win
ON CHOOSE OF btn_archivos IN FRAME F-Main /* Archivos */
DO:
  DEFINE VARIABLE ok AS LOGICAL NO-UNDO.
  DEFINE VARIABLE v-archivo AS CHARACTER NO-UNDO.
 
  def var v-directorio as char no-undo.
  def var i as int no-undo.

  ASSIGN v-archivo = tipo_tarea.Pgm_abm:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
  
  v-archivo = search(v-archivo).
  v-directorio = "".
  do i = 1 to NUM-ENTRIES(v-archivo,"\") - 1 :
     v-directorio =   v-directorio  + entry( i , v-archivo, "\" )  + "\"  .
  end.
  
  RUN selprograma.p ( INPUT-OUTPUT v-archivo, INPUT v-directorio,INPUT NO, OUTPUT ok ).
  IF ok 
     THEN DISPLAY v-archivo @ tipo_tarea.Pgm_abm
                  WITH FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_nextcolorfondo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_nextcolorfondo V-table-Win
ON CHOOSE OF btn_nextcolorfondo IN FRAME F-Main /* btn_nextmes */
DO:
    DEFINE VAR n-color AS INT NO-UNDO.
  n-color = tipo_tarea.color_fondo:INPUT-VALUE + 1.
  IF n-color = 16 THEN n-color = 0.
  DISPLAY n-color @ tipo_tarea.color_fondo
      WITH FRAME {&FRAME-NAME}.
  cdg_tipotarea:BGCOLOR = n-color.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_nextcolorletra
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_nextcolorletra V-table-Win
ON CHOOSE OF btn_nextcolorletra IN FRAME F-Main /* btn_nextmes */
DO:
    DEFINE VAR n-color AS INT NO-UNDO.
  n-color = tipo_tarea.color_letra:INPUT-VALUE + 1.
  IF n-color = 16 THEN n-color = 0.
  DISPLAY n-color @ tipo_tarea.color_letra
      WITH FRAME {&FRAME-NAME}.
  cdg_tipotarea:FGCOLOR = n-color.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_prevcolorfondo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_prevcolorfondo V-table-Win
ON CHOOSE OF btn_prevcolorfondo IN FRAME F-Main /* btn_prevcolorletra 2 */
DO:
    DEFINE VAR n-color AS INT NO-UNDO.
  n-color = tipo_tarea.color_fondo:INPUT-VALUE - 1.
  IF n-color = -1 THEN n-color = 15.
  DISPLAY n-color @ tipo_tarea.color_fondo
      WITH FRAME {&FRAME-NAME}.
  cdg_tipotarea:BGCOLOR = n-color.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_prevcolorletra
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_prevcolorletra V-table-Win
ON CHOOSE OF btn_prevcolorletra IN FRAME F-Main /* Button 44 */
DO:
    DEFINE VAR n-color AS INT NO-UNDO.
  n-color = tipo_tarea.color_letra:INPUT-VALUE - 1.
  IF n-color = -1 THEN n-color = 15.
  DISPLAY n-color @ tipo_tarea.color_letra
      WITH FRAME {&FRAME-NAME}.
  cdg_tipotarea:FGCOLOR = n-color.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Tipo_tarea.color_fondo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Tipo_tarea.color_fondo V-table-Win
ON LEAVE OF Tipo_tarea.color_fondo IN FRAME F-Main /* Color Fondo */
DO:
  tipo_tarea.cdg_tipotarea:BGCOLOR = SELF:INPUT-VALUE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Tipo_tarea.color_letra
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Tipo_tarea.color_letra V-table-Win
ON LEAVE OF Tipo_tarea.color_letra IN FRAME F-Main /* Color Letra */
DO:
  tipo_tarea.cdg_tipotarea:FGCOLOR = SELF:INPUT-VALUE.
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
  {src/adm/template/row-list.i "Tipo_tarea"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Tipo_tarea"}

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
    btn_nextcolorfondo:sensitive IN FRAME {&FRAME-NAME}= false.
    btn_nextcolorletra:sensitive = false.
    btn_prevcolorfondo:sensitive = false.
    btn_prevcolorletra:sensitive = false.
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
IF AVAILABLE tipo_tarea THEN do:
  cdg_tipotarea:FGCOLOR IN FRAME {&FRAME-NAME}=tipo_tarea.color_letra.
  cdg_tipotarea:BGCOLOR =tipo_tarea.color_fondo.
END.
IF SEARCH(tipo_tarea.Pgm_abm:SCREEN-VALUE IN FRAME {&FRAME-NAME}) = ? THEN DO:
   tipo_tarea.Pgm_abm:BGCOLOR = 12.
   tipo_tarea.Pgm_abm:FGCOLOR = 15.
END.
ELSE DO:
   tipo_tarea.Pgm_abm:BGCOLOR = ?.
   tipo_tarea.Pgm_abm:FGCOLOR = ?.
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
    btn_nextcolorfondo:sensitive IN FRAME {&FRAME-NAME}= true.
    btn_nextcolorletra:sensitive = true.
    btn_prevcolorfondo:sensitive = true.
    btn_prevcolorletra:sensitive = true.
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
  {src/adm/template/snd-list.i "Tipo_tarea"}

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

