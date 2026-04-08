&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW


/* Temp-Table and Buffer definitions                                    */
DEFINE BUFFER B-Restriccion FOR Restriccion.



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

DEFINE VAR es_alta AS LOGICAL NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartViewer
&Scoped-define DB-AWARE no

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME F-Main

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES Restriccion
&Scoped-define FIRST-EXTERNAL-TABLE Restriccion


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Restriccion.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Restriccion.nro_tipo_evento ~
Restriccion.nro_restriccion Restriccion.cdg_restriccion Restriccion.evaluar ~
Restriccion.esRestriccion Restriccion.descripcion Restriccion.tipo ~
Restriccion.Pgm_abm Restriccion.Pgm_eval Restriccion.Prioridad ~
Restriccion.Etag 
&Scoped-define ENABLED-TABLES Restriccion
&Scoped-define FIRST-ENABLED-TABLE Restriccion
&Scoped-Define ENABLED-OBJECTS RECT-4 
&Scoped-Define DISPLAYED-FIELDS Restriccion.nro_tipo_evento ~
Restriccion.nro_restriccion Restriccion.cdg_restriccion Restriccion.evaluar ~
Restriccion.esRestriccion Restriccion.descripcion Restriccion.tipo ~
Restriccion.Pgm_abm Restriccion.Pgm_eval Restriccion.Prioridad ~
Restriccion.Etag 
&Scoped-define DISPLAYED-TABLES Restriccion
&Scoped-define FIRST-DISPLAYED-TABLE Restriccion


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

DEFINE BUTTON btn_archivos-2 
     LABEL "&Archivos" 
     SIZE 12 BY 1.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 4 GRAPHIC-EDGE  NO-FILL   
     SIZE 82 BY 9.52.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Restriccion.nro_tipo_evento AT ROW 1.24 COL 14 COLON-ALIGNED
          LABEL "Tipo"
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "0",1
          DROP-DOWN-LIST
          SIZE 50.4 BY 1 TOOLTIP "Tipo de Restriccion o Tipo de Evento"
     Restriccion.nro_restriccion AT ROW 2.43 COL 14 COLON-ALIGNED WIDGET-ID 2
          VIEW-AS FILL-IN 
          SIZE 4 BY 1
     Restriccion.cdg_restriccion AT ROW 2.43 COL 31.8 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 10 BY 1
     Restriccion.evaluar AT ROW 2.43 COL 48.8
          VIEW-AS TOGGLE-BOX
          SIZE 12.2 BY .81
     Restriccion.esRestriccion AT ROW 2.43 COL 62
          LABEL "Restriccion"
          VIEW-AS TOGGLE-BOX
          SIZE 19 BY .81 TOOLTIP "Si es Restriccion o caracteristica"
     Restriccion.descripcion AT ROW 3.86 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 42 BY 1
     Restriccion.tipo AT ROW 3.86 COL 63 COLON-ALIGNED WIDGET-ID 4
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Contrato","A",
                     "Cliente","B"
          DROP-DOWN-LIST
          SIZE 16 BY 1
     Restriccion.Pgm_abm AT ROW 5.05 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 52 BY 1
     btn_archivos AT ROW 5.05 COL 69
     Restriccion.Pgm_eval AT ROW 6.24 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 52 BY 1
     btn_archivos-2 AT ROW 6.24 COL 69
     Restriccion.Prioridad AT ROW 7.67 COL 16 NO-LABEL
          VIEW-AS SLIDER MIN-VALUE 1 MAX-VALUE 9 HORIZONTAL 
          TIC-MARKS BOTTOM FREQUENCY 1
          SIZE 35 BY 2.38 TOOLTIP "Prioridad por default asignada a esta restriccion frente a otra"
     Restriccion.Etag AT ROW 8 COL 58 COLON-ALIGNED WIDGET-ID 6
          VIEW-AS FILL-IN 
          SIZE 21 BY 1
     "Prioridad:" VIEW-AS TEXT
          SIZE 10 BY 1.43 AT ROW 7.19 COL 6
     RECT-4 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Restriccion
   Allow: Basic,DB-Fields
   Frames: 1
   Add Fields to: EXTERNAL-TABLES
   Other Settings: PERSISTENT-ONLY COMPILE
   Temp-Tables and Buffers:
      TABLE: B-Restriccion B "?" ? sic Restriccion
   END-TABLES.
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
         HEIGHT             = 13.29
         WIDTH              = 87.2.
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
   NOT-VISIBLE FRAME-NAME Size-to-Fit                                   */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR BUTTON btn_archivos IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_archivos-2 IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR TOGGLE-BOX Restriccion.esRestriccion IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR COMBO-BOX Restriccion.nro_tipo_evento IN FRAME F-Main
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

&Scoped-define SELF-NAME btn_archivos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_archivos V-table-Win
ON CHOOSE OF btn_archivos IN FRAME F-Main /* Archivos */
DO:
  DEFINE VARIABLE ok AS LOGICAL NO-UNDO.
  DEFINE VARIABLE v-archivo AS CHARACTER NO-UNDO.
 
  def var v-directorio as char no-undo.
  def var i as int no-undo.

  ASSIGN v-archivo = restriccion.Pgm_abm:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
  
  v-archivo = search(v-archivo).
  v-directorio = "".
  do i = 1 to NUM-ENTRIES(v-archivo,"\") - 1 :
     v-directorio =   v-directorio  + entry( i , v-archivo, "\" )  + "\"  .
  end.
  
  RUN selprograma.p ( INPUT-OUTPUT v-archivo, INPUT v-directorio,INPUT NO, OUTPUT ok ).
  IF ok 
     THEN DISPLAY v-archivo @ restriccion.Pgm_abm
                  WITH FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_archivos-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_archivos-2 V-table-Win
ON CHOOSE OF btn_archivos-2 IN FRAME F-Main /* Archivos */
DO:
   DEFINE VARIABLE ok AS LOGICAL NO-UNDO.
    DEFINE VARIABLE v-archivo AS CHARACTER NO-UNDO.

    def var v-directorio as char no-undo.
    def var i as int no-undo.

    ASSIGN v-archivo = Pgm_eval:SCREEN-VALUE IN FRAME {&FRAME-NAME}.

    v-archivo = search(v-archivo).
    v-directorio = "".
    do i = 1 to NUM-ENTRIES(v-archivo,"\") - 1 :
       v-directorio =   v-directorio  + entry( i , v-archivo, "\" )  + "\"  .
    end.

    RUN selprograma.p ( INPUT-OUTPUT v-archivo, INPUT v-directorio,INPUT NO, OUTPUT ok ).
    IF ok 
       THEN DISPLAY v-archivo @ Pgm_eval
                    WITH FRAME {&FRAME-NAME}.




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
  {src/adm/template/row-list.i "Restriccion"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Restriccion"}

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
 ES_ALTA = YES.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'add-record':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-assign-record V-table-Win 
PROCEDURE local-assign-record :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */
  DEFINE VARIABLE hubo_error      AS LOGICAL.
     IF INPUT FRAME {&FRAME-NAME} restriccion.cdg_restriccion = "" OR 
          INPUT FRAME {&FRAME-NAME} restriccion.descrip = ""  
      THEN DO:
           RUN PONMENSJ.P (INPUT "REST001").
           RETURN ERROR.
     END.            

      IF NEW Restriccion
      THEN DO:

          IF CAN-FIND(FIRST B-restriccion 
                             WHERE B-restriccion.cdg_restriccion = 
                                 INPUT FRAME {&FRAME-NAME} restriccion.cdg_restriccion )
          THEN DO:
                MESSAGE "No se encuentra el ABM para la restriccion".
               RETURN ERROR.
          END.
               
      END.
     

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-record':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
   IF NEW restriccion THEN 
        ASSIGN restriccion.nro_restriccion = NEXT-VALUE( proxima_restriccion)
               restriccion.cdg_restriccion = INPUT FRAME {&FRAME-NAME} restriccion.cdg_restriccion .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-copy-record V-table-Win 
PROCEDURE local-copy-record :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */
es_alta = TRUE.
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'copy-record':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

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
MESSAGE "No se permite el borrado de restricciones" VIEW-AS ALERT-BOX INFORMATION.
RETURN ERROR.
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

  /* Dispatch standard ADM method.    */
                        
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'disable-fields':U ) .
  btn_archivos:SENSITIVE IN FRAME {&FRAME-NAME} = FALSE.
  btn_archivos-2:SENSITIVE IN FRAME {&FRAME-NAME} = FALSE. 
  /* Code placed here will execute AFTER standard behavior.    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-display-fields V-table-Win 
PROCEDURE local-display-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR dummy AS INT NO-UNDO.
  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'display-fields':U ) .

  IF SEARCH(restriccion.Pgm_abm:SCREEN-VALUE IN FRAME {&FRAME-NAME}) = ? THEN DO:
   restriccion.Pgm_abm:BGCOLOR = 12.
   restriccion.Pgm_abm:FGCOLOR = 15.
  END.
  ELSE DO:
   restriccion.Pgm_abm:BGCOLOR = ?.
   restriccion.Pgm_abm:FGCOLOR = ?.
  END.
IF SEARCH(pgm_eval:SCREEN-VALUE IN FRAME {&FRAME-NAME}) = ? THEN DO:
   pgm_eval:BGCOLOR = 12.
   pgm_eval:FGCOLOR = 15.
  END.
  ELSE DO:
   pgm_eval:BGCOLOR = ?.
   pgm_eval:FGCOLOR = ?.
  END.

  /* Code placed here will execute AFTER standard behavior.    */

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
  btn_archivos:SENSITIVE IN FRAME {&FRAME-NAME} = TRUE.
  btn_archivos-2:SENSITIVE IN FRAME {&FRAME-NAME} = TRUE.

  /* Code placed here will execute AFTER standard behavior.    */

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

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .
  
  DEF VAR lista AS CHAR NO-UNDO.
  DO WITH FRAME {&FRAME-NAME}:
     {levantacombo.i &TABLA=Tipo_evento &NOMBRE=cdg_tipo_evento &CODIGO=nro_tipo_evento &OBJETO=restriccion.nro_tipo_evento}
  END.  
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
  {src/adm/template/snd-list.i "Restriccion"}

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

