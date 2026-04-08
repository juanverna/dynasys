&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS B-table-Win 
/*------------------------------------------------------------------------

  File:  

  Description: from BROWSER.W - Basic SmartBrowser Object Template

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

  DEFINE VARIABLE x-lista      AS CHARACTER.
  DEFINE VARIABLE x-sino       AS LOGICAL.

DEFINE VAR diasabierto AS INT LABEL "Hace".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartBrowser
&Scoped-define DB-AWARE no

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME F-Main
&Scoped-define BROWSE-NAME br_table

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Tarea

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Tarea.nro_tarea ~
durmiendo() @ diasabierto Tarea.titulo Tarea.prioridad Tarea.cdg_tipotarea 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table 
&Scoped-define QUERY-STRING-br_table FOR EACH Tarea WHERE ~{&KEY-PHRASE} ~
      AND CAN-DO(que_proyecto,Tarea.cdg_proyecto) ~
 AND Tarea.estado = que_estado ~
 AND CAN-DO(que_recurso,Tarea.cdg_recurso) NO-LOCK ~
    ~{&SORTBY-PHRASE}
&Scoped-define OPEN-QUERY-br_table OPEN QUERY br_table FOR EACH Tarea WHERE ~{&KEY-PHRASE} ~
      AND CAN-DO(que_proyecto,Tarea.cdg_proyecto) ~
 AND Tarea.estado = que_estado ~
 AND CAN-DO(que_recurso,Tarea.cdg_recurso) NO-LOCK ~
    ~{&SORTBY-PHRASE}.
&Scoped-define TABLES-IN-QUERY-br_table Tarea
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Tarea


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-2 que_estado que_proyecto x-ver_todos ~
que_recurso br_table BTN_CERRAR BTN_DESCARTAR BTN_REABRIR BTN_IMPRIMIR ~
BTN_COMUNICAR 
&Scoped-Define DISPLAYED-OBJECTS que_estado que_proyecto x-ver_todos ~
que_recurso 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _XFTR "Foreign Keys" B-table-Win _INLINE
/* Actions: ? adm/support/keyedit.w ? ? ? */
/* STRUCTURED-DATA
<KEY-OBJECT>
&BROWSE-NAME
</KEY-OBJECT>
<FOREIGN-KEYS>
cdg_proyecto|y|y|sic.Tarea.cdg_proyecto
cdg_recurso|y|y|sic.Tarea.cdg_recurso
nro_tarea||y|sic.Tarea.nro_tarea
cdg_tipotarea||y|sic.Tarea.cdg_tipotarea
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = "cdg_proyecto,cdg_recurso",
     Keys-Supplied = "cdg_proyecto,cdg_recurso,nro_tarea,cdg_tipotarea"':U).

/* Tell the ADM to use the OPEN-QUERY-CASES. */
&Scoped-define OPEN-QUERY-CASES RUN dispatch ('open-query-cases':U).
/**************************
</EXECUTING-CODE> */
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _XFTR "Advanced Query Options" B-table-Win _INLINE
/* Actions: ? adm/support/advqedit.w ? ? ? */
/* STRUCTURED-DATA
<KEY-OBJECT>
&BROWSE-NAME
</KEY-OBJECT>
<SORTBY-OPTIONS>
</SORTBY-OPTIONS>
<SORTBY-RUN-CODE>
************************
* Set attributes related to SORTBY-OPTIONS */
RUN set-attribute-list (
    'SortBy-Options = ""':U).
/************************
</SORTBY-RUN-CODE>
<FILTER-ATTRIBUTES>
</FILTER-ATTRIBUTES> */   

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD durmiendo B-table-Win 
FUNCTION durmiendo RETURNS INTEGER
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE BUTTON BTN_CERRAR 
     LABEL "&Cerrar Tarea" 
     SIZE 26 BY 1.14.

DEFINE BUTTON BTN_COMUNICAR 
     LABEL "&Comunicar Tarea" 
     SIZE 26 BY 1.14.

DEFINE BUTTON BTN_DESCARTAR 
     LABEL "&Descartar Tarea" 
     SIZE 26 BY 1.14.

DEFINE BUTTON BTN_IMPRIMIR 
     LABEL "&Imprimir Tarea" 
     SIZE 26 BY 1.14.

DEFINE BUTTON BTN_REABRIR 
     LABEL "&Reabrir Tarea" 
     SIZE 26 BY 1.14.

DEFINE VARIABLE que_estado AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX SORT INNER-LINES 5
     LIST-ITEM-PAIRS "Abierto","A",
                     "Resuelto","R",
                     "Descartado","D",
                     "Control Calidad","Q",
                     "Tratado","T"
     DROP-DOWN-LIST
     SIZE 22 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE que_proyecto AS CHARACTER FORMAT "X(8)" 
     VIEW-AS COMBO-BOX INNER-LINES 25
     LIST-ITEM-PAIRS "Item 1","Item 1"
     DROP-DOWN-LIST
     SIZE 47 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE que_recurso AS CHARACTER FORMAT "X(8)" 
     VIEW-AS COMBO-BOX INNER-LINES 25
     LIST-ITEM-PAIRS "Item 1","Item 1"
     DROP-DOWN-LIST
     SIZE 44 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE x-ver_todos AS LOGICAL FORMAT "yes/no":U INITIAL NO 
     VIEW-AS COMBO-BOX INNER-LINES 2
     LIST-ITEM-PAIRS "Todos",yes,
                     "Solo Abiertos",no
     DROP-DOWN-LIST
     SIZE 19 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 136 BY 1.62.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Tarea SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _STRUCTURED
  QUERY br_table NO-LOCK DISPLAY
      Tarea.nro_tarea FORMAT ">>>>>9":U WIDTH 13.2
      durmiendo() @ diasabierto COLUMN-LABEL "Hace"
      Tarea.titulo FORMAT "X(80)":U WIDTH 109.2
      Tarea.prioridad FORMAT ">>>9":U WIDTH 7.6
      Tarea.cdg_tipotarea FORMAT "X(1)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 136 BY 15.48
         BGCOLOR 15 FGCOLOR 9  FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     que_estado AT ROW 2.1 COL 1 NO-LABEL
     que_proyecto AT ROW 2.19 COL 22 COLON-ALIGNED NO-LABEL
     x-ver_todos AT ROW 2.19 COL 70 COLON-ALIGNED NO-LABEL
     que_recurso AT ROW 2.19 COL 91 COLON-ALIGNED NO-LABEL
     br_table AT ROW 3.38 COL 1
     BTN_CERRAR AT ROW 19.33 COL 2
     BTN_DESCARTAR AT ROW 19.33 COL 29
     BTN_REABRIR AT ROW 19.33 COL 56
     BTN_IMPRIMIR AT ROW 19.33 COL 83
     BTN_COMUNICAR AT ROW 19.33 COL 110
     "  Ver Proyectos" VIEW-AS TEXT
          SIZE 19 BY 1 AT ROW 1 COL 72
          BGCOLOR 5 FGCOLOR 15 
     "  Proyecto" VIEW-AS TEXT
          SIZE 47 BY 1 AT ROW 1 COL 24
          BGCOLOR 5 FGCOLOR 15 
     "  Recurso" VIEW-AS TEXT
          SIZE 44 BY 1 AT ROW 1 COL 93
          BGCOLOR 5 FGCOLOR 15 
     "  Estado de Tareas" VIEW-AS TEXT
          SIZE 22 BY 1 AT ROW 1 COL 1
          BGCOLOR 5 FGCOLOR 15 
     RECT-2 AT ROW 19.1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartBrowser
   Allow: Basic,Browse
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
  CREATE WINDOW B-table-Win ASSIGN
         HEIGHT             = 19.71
         WIDTH              = 139.2.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB B-table-Win 
/* ************************* Included-Libraries *********************** */

{src/adm/method/browser.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW B-table-Win
  NOT-VISIBLE,,RUN-PERSISTENT                                           */
/* SETTINGS FOR FRAME F-Main
   NOT-VISIBLE Size-to-Fit                                              */
/* BROWSE-TAB br_table que_recurso F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR COMBO-BOX que_estado IN FRAME F-Main
   ALIGN-L                                                              */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _TblList          = "sic.Tarea"
     _Options          = "NO-LOCK KEY-PHRASE SORTBY-PHRASE"
     _Where[1]         = "CAN-DO(que_proyecto,Tarea.cdg_proyecto)
 AND Tarea.estado = que_estado
 AND CAN-DO(que_recurso,Tarea.cdg_recurso)"
     _FldNameList[1]   > sic.Tarea.nro_tarea
"Tarea.nro_tarea" ? ? "integer" ? ? ? ? ? ? no ? no no "13.2" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > "_<CALC>"
"durmiendo() @ diasabierto" "Hace" ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > sic.Tarea.titulo
"Tarea.titulo" ? ? "character" ? ? ? ? ? ? no ? no no "109.2" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > sic.Tarea.prioridad
"Tarea.prioridad" ? ? "integer" ? ? ? ? ? ? no ? no no "7.6" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   = sic.Tarea.cdg_tipotarea
     _Query            is NOT OPENED
*/  /* BROWSE br_table */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME F-Main
/* Query rebuild information for FRAME F-Main
     _Options          = "NO-LOCK"
     _Query            is NOT OPENED
*/  /* FRAME F-Main */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define BROWSE-NAME br_table
&Scoped-define SELF-NAME br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-ENTRY OF br_table IN FRAME F-Main
DO:
  /* This code displays initial values for newly added or copied rows. */
  {src/adm/template/brsentry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-LEAVE OF br_table IN FRAME F-Main
DO:
    /* Do not disable this code or no updates will take place except
     by pressing the Save button on an Update SmartPanel. */
   {src/adm/template/brsleave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON VALUE-CHANGED OF br_table IN FRAME F-Main
DO:
  /* This ADM trigger code must be preserved in order to notify other
     objects when the browser's current row changes. */
  {src/adm/template/brschnge.i}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BTN_CERRAR
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BTN_CERRAR B-table-Win
ON CHOOSE OF BTN_CERRAR IN FRAME F-Main /* Cerrar Tarea */
DO:
  x-sino = NO.
  MESSAGE "Desea CERRAR esta tarea" VIEW-AS ALERT-BOX MESSAGE BUTTONS YES-NO
      TITLE "Confirmacion" UPDATE x-sino .
  IF x-sino
  THEN DO:
      DO TRANSACTION:
          FIND CURRENT  Tarea EXCLUSIVE-LOCK.
          Tarea.estado = "R".
          IF Tarea.fecha_resuelto = ? THEN Tarea.fecha_resuelto = TODAY.
          RUN dispatch IN THIS-PROCEDURE ('open-query':U).
      END.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BTN_COMUNICAR
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BTN_COMUNICAR B-table-Win
ON CHOOSE OF BTN_COMUNICAR IN FRAME F-Main /* Comunicar Tarea */
DO:
    x-sino = NO.
    MESSAGE "Desea COMUNICAR esta tarea al recurso responsable" VIEW-AS ALERT-BOX MESSAGE BUTTONS YES-NO
        TITLE "Confirmacion" UPDATE x-sino .
    IF x-sino
    THEN DO:
        DO TRANSACTION:
            /*
            FIND CURRENT  Tarea EXCLUSIVE-LOCK.
            Tarea.estado = "R".
            IF Tarea.fecha_resuelto = ? THEN Tarea.fecha_resuelto = TODAY.
            RUN dispatch IN THIS-PROCEDURE ('open-query':U).
            */
        END.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BTN_DESCARTAR
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BTN_DESCARTAR B-table-Win
ON CHOOSE OF BTN_DESCARTAR IN FRAME F-Main /* Descartar Tarea */
DO:
    x-sino = NO.
    MESSAGE "Desea DESCARTAR esta tarea" VIEW-AS ALERT-BOX MESSAGE BUTTONS YES-NO
        TITLE "Confirmacion" UPDATE x-sino .
    IF x-sino
    THEN DO:
        DO TRANSACTION:
            FIND CURRENT  Tarea EXCLUSIVE-LOCK.
            Tarea.estado = "D".
            IF Tarea.fecha_resuelto = ? THEN Tarea.fecha_resuelto = TODAY.
            RUN dispatch IN THIS-PROCEDURE ('open-query':U).
        END.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BTN_IMPRIMIR
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BTN_IMPRIMIR B-table-Win
ON CHOOSE OF BTN_IMPRIMIR IN FRAME F-Main /* Imprimir Tarea */
DO:
  RUN ficha_tarea.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BTN_REABRIR
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BTN_REABRIR B-table-Win
ON CHOOSE OF BTN_REABRIR IN FRAME F-Main /* Reabrir Tarea */
DO:
    x-sino = NO.
    MESSAGE "Desea REABRIR esta tarea" VIEW-AS ALERT-BOX MESSAGE BUTTONS YES-NO
        TITLE "Confirmacion" UPDATE x-sino .
    IF x-sino
    THEN DO:
        DO TRANSACTION:
            FIND CURRENT  Tarea EXCLUSIVE-LOCK.
            Tarea.estado = "A".
            Tarea.fecha_resuelto = ?.
            RUN dispatch IN THIS-PROCEDURE ('open-query':U).
        END.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME que_estado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_estado B-table-Win
ON VALUE-CHANGED OF que_estado IN FRAME F-Main
DO:
    ASSIGN que_estado.
    RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME que_proyecto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_proyecto B-table-Win
ON VALUE-CHANGED OF que_proyecto IN FRAME F-Main
DO:
  ASSIGN que_proyecto.
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME que_recurso
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_recurso B-table-Win
ON VALUE-CHANGED OF que_recurso IN FRAME F-Main
DO:
  ASSIGN que_recurso.
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME x-ver_todos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL x-ver_todos B-table-Win
ON VALUE-CHANGED OF x-ver_todos IN FRAME F-Main
DO:
  ASSIGN x-ver_todos.
  RUN iniciar_proyectos.
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK B-table-Win 


/* ***************************  Main Block  *************************** */

&IF DEFINED(UIB_IS_RUNNING) <> 0 &THEN          
RUN dispatch IN THIS-PROCEDURE ('initialize':U).        
&ENDIF

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE actividades_por_tarea B-table-Win 
PROCEDURE actividades_por_tarea :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  RUN actividades_por_tarea.p ( INPUT que_estado,
                                INPUT que_proyecto,
                                INPUT que_recurso ).


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-open-query-cases B-table-Win  adm/support/_adm-opn.p
PROCEDURE adm-open-query-cases :
/*------------------------------------------------------------------------------
  Purpose:     Opens different cases of the query based on attributes
               such as the 'Key-Name', or 'SortBy-Case'
  Parameters:  <none>
------------------------------------------------------------------------------*/
  DEF VAR key-value AS CHAR NO-UNDO.

  /* Look up the current key-value. */
  RUN get-attribute ('Key-Value':U).
  key-value = RETURN-VALUE.

  /* Find the current record using the current Key-Name. */
  RUN get-attribute ('Key-Name':U).
  CASE RETURN-VALUE:
    WHEN 'cdg_proyecto':U THEN DO:
       &Scope KEY-PHRASE Tarea.cdg_proyecto eq key-value
       {&OPEN-QUERY-{&BROWSE-NAME}}
    END. /* cdg_proyecto */
    WHEN 'cdg_recurso':U THEN DO:
       &Scope KEY-PHRASE Tarea.cdg_recurso eq key-value
       {&OPEN-QUERY-{&BROWSE-NAME}}
    END. /* cdg_recurso */
    OTHERWISE DO:
       &Scope KEY-PHRASE TRUE
       {&OPEN-QUERY-{&BROWSE-NAME}}
    END. /* OTHERWISE...*/
  END CASE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available B-table-Win  _ADM-ROW-AVAILABLE
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

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE asignar_release B-table-Win 
PROCEDURE asignar_release :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE que_version AS CHARACTER.
  
  IF NOT CAN-FIND(Proyecto WHERE Proyecto.cdg_proyecto = que_proyecto)
  THEN DO:
      MESSAGE "No se indicó el proyecto" VIEW-AS ALERT-BOX ERROR.
      RETURN ERROR.
  END.

  RUN d-que_version.w ( OUTPUT que_version ).

  IF que_version <> ?
       THEN RUN asignar_version.p ( INPUT que_proyecto,
                                    INPUT que_version ).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI B-table-Win  _DEFAULT-DISABLE
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ficha_tarea B-table-Win 
PROCEDURE ficha_tarea :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  IF AVAILABLE Tarea
      THEN RUN prtarea.p ( INPUT Tarea.nro_tarea).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE horas_x_tarea B-table-Win 
PROCEDURE horas_x_tarea :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  RUN horas_x_tarea.p ( INPUT que_estado,
                        INPUT que_proyecto,
                        INPUT que_recurso ).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE imprimir_tareas B-table-Win 
PROCEDURE imprimir_tareas :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  RUN imprimir_tareas.p ( INPUT que_estado,
                          INPUT que_proyecto,
                          INPUT que_recurso ).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE iniciar_proyectos B-table-Win 
PROCEDURE iniciar_proyectos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  IF x-ver_todos
      THEN x-lista = "[Todos los Proyectos],*".
      ELSE x-lista = "[Todos los Proyectos Abiertos],*".
  FOR EACH Proyecto WHERE Proyecto.abierto OR x-ver_todos BY Proyecto.dsc_proyecto:
    x-lista = x-lista +  "," + Proyecto.dsc_proyecto + "," + Proyecto.cdg_proyecto.
  END.
  que_proyecto:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = x-lista.
  que_proyecto = ENTRY(2,x-lista,",").

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE iniciar_recursos B-table-Win 
PROCEDURE iniciar_recursos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  x-lista = "[Todos],*".
  FOR EACH Recurso BY Recurso.nom_recurso:
    x-lista = x-lista +  "," + Recurso.nom_recurso + "," + Recurso.cdg_recurso.
  END.
  que_recurso:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = x-lista.
  que_recurso = ENTRY(2,x-lista,",").

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize B-table-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  RUN iniciar_proyectos.
  RUN iniciar_recursos.

  que_estado = "A".
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  DISPLAY que_proyecto
          que_estado
      WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-open-query B-table-Win 
PROCEDURE local-open-query :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'open-query':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  BTN_CERRAR:SENSITIVE IN FRAME {&FRAME-NAME} = que_estado = "A". 
  BTN_COMUNICAR:SENSITIVE IN FRAME {&FRAME-NAME} = que_estado = "A".
  BTN_DESCARTAR:SENSITIVE IN FRAME {&FRAME-NAME} = que_estado = "A". 
  BTN_REABRIR:SENSITIVE IN FRAME {&FRAME-NAME} = ( que_estado = "D" OR que_estado = "R").

                          
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE refrescar_proyectos B-table-Win 
PROCEDURE refrescar_proyectos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE OUTPUT PARAMETER p-lista AS CHARACTER.

  DEFINE VARIABLE x-proyecto LIKE Proyecto.cdg_proyecto.

  x-proyecto = que_proyecto:INPUT-VALUE IN FRAME {&FRAME-NAME}.
  RUN iniciar_proyectos.
  IF CAN-FIND(FIRST Proyecto 
              WHERE Proyecto.cdg_proyecto = x-proyecto
                AND LOOKUP(Proyecto.dsc_proyecto,que_proyecto:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME}) <> 0 )
  THEN DO:
      que_proyecto = x-proyecto.
  END.
  ELSE DO:
      que_proyecto = ENTRY(2,que_proyecto:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME},",").
  END.

  DISPLAY que_proyecto WITH FRAME {&FRAME-NAME}.

  p-lista = que_proyecto:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME}.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE refrescar_recursos B-table-Win 
PROCEDURE refrescar_recursos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE x-recurso AS CHARACTER.

  x-recurso = que_recurso:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
  RUN iniciar_recursos.
  que_recurso:SCREEN-VALUE IN FRAME {&FRAME-NAME} = x-recurso.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE refrescar_tipotareas B-table-Win 
PROCEDURE refrescar_tipotareas :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-key B-table-Win  adm/support/_key-snd.p
PROCEDURE send-key :
/*------------------------------------------------------------------------------
  Purpose:     Sends a requested KEY value back to the calling
               SmartObject.
  Parameters:  <see adm/template/sndkytop.i>
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.             */
  {src/adm/template/sndkytop.i}

  /* Return the key value associated with each key case.             */
  {src/adm/template/sndkycas.i "cdg_proyecto" "Tarea" "cdg_proyecto"}
  {src/adm/template/sndkycas.i "cdg_recurso" "Tarea" "cdg_recurso"}
  {src/adm/template/sndkycas.i "nro_tarea" "Tarea" "nro_tarea"}
  {src/adm/template/sndkycas.i "cdg_tipotarea" "Tarea" "cdg_tipotarea"}

  /* Close the CASE statement and end the procedure.                 */
  {src/adm/template/sndkyend.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records B-table-Win  _ADM-SEND-RECORDS
PROCEDURE send-records :
/*------------------------------------------------------------------------------
  Purpose:     Send record ROWID's for all tables used by
               this file.
  Parameters:  see template/snd-head.i
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.               */
  {src/adm/template/snd-head.i}

  /* For each requested table, put it's ROWID in the output list.      */
  {src/adm/template/snd-list.i "Tarea"}

  /* Deal with any unexpected table requests before closing.           */
  {src/adm/template/snd-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE state-changed B-table-Win 
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
      {src/adm/template/bstates.i}
  END CASE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE valor_proyecto B-table-Win 
PROCEDURE valor_proyecto :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE OUTPUT PARAMETER p-cdg_proyecto LIKE Proyecto.cdg_proyecto.

 p-cdg_proyecto = que_proyecto:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
     

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE valor_recurso B-table-Win 
PROCEDURE valor_recurso :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE OUTPUT PARAMETER p-cdg_recurso LIKE Recurso.cdg_recurso.

  p-cdg_recurso = que_recurso:SCREEN-VALUE IN FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION durmiendo B-table-Win 
FUNCTION durmiendo RETURNS INTEGER
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose:  Dias durmiendo sin ninguna accion
    Notes:  
------------------------------------------------------------------------------*/

  RETURN TODAY - Tarea.fecha_alta.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

