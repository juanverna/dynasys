&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW

/* Temp-Table and Buffer definitions                                    */
DEFINE BUFFER B-Entidad FOR Entidad.
DEFINE TEMP-TABLE T-Entidad_distribucion NO-UNDO LIKE Entidad_distribucion.


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

DEFINE VARIABLE rid_tabla    AS ROWID.
DEFINE VARIABLE sino-msg     AS LOGICAL.
DEFINE VARIABLE que_empresa  LIKE Empresa.cdg_empresa.

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

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES Entidad
&Scoped-define FIRST-EXTERNAL-TABLE Entidad


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Entidad.
/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Entidad_distribucion B-Entidad

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table B-Entidad.cdg_entidad B-Entidad.dsc_entidad T-Entidad_distribucion.porcentaje   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table   
&Scoped-define SELF-NAME br_table
&Scoped-define QUERY-STRING-br_table FOR EACH T-Entidad_distribucion NO-LOCK, ~
             EACH B-Entidad WHERE B-Entidad.nro_entidad = T-Entidad_distribucion.nro_entidad-dis NO-LOCK
&Scoped-define OPEN-QUERY-br_table OPEN QUERY {&SELF-NAME} FOR EACH T-Entidad_distribucion NO-LOCK, ~
             EACH B-Entidad WHERE B-Entidad.nro_entidad = T-Entidad_distribucion.nro_entidad-dis NO-LOCK.
&Scoped-define TABLES-IN-QUERY-br_table T-Entidad_distribucion B-Entidad
&Scoped-define FIRST-TABLE-IN-QUERY-br_table T-Entidad_distribucion
&Scoped-define SECOND-TABLE-IN-QUERY-br_table B-Entidad


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-12 RECT-13 v-cdg_b-entidad v-porcentaje ~
br_table btn_crear btn_eliminar v-total-porcentajes 
&Scoped-Define DISPLAYED-OBJECTS v-cdg_b-entidad v-dsc_b-entidad ~
v-porcentaje v-total-porcentajes 

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


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE BUTTON btn_crear 
     LABEL "&Crear" 
     SIZE 16 BY 1.52.

DEFINE BUTTON btn_eliminar 
     LABEL "&Eliminar" 
     SIZE 16 BY 1.52.

DEFINE BUTTON btn_grabar 
     LABEL "&Grabar" 
     SIZE 16 BY 1.52.

DEFINE VARIABLE v-cdg_b-entidad AS CHARACTER FORMAT "X(8)":U 
     LABEL "Entidad" 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-dsc_b-entidad AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 40 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-porcentaje AS DECIMAL FORMAT ">>9.9999":U INITIAL 0 
     LABEL "%" 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-total-porcentajes AS DECIMAL FORMAT ">>9.9999":U INITIAL 0 
     LABEL "Total %" 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 11 FGCOLOR 9 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-12
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 23 BY 1.52.

DEFINE RECTANGLE RECT-13
     EDGE-PIXELS 4 GRAPHIC-EDGE  NO-FILL 
     SIZE 80 BY 17.62.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      T-Entidad_distribucion, 
      B-Entidad SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _FREEFORM
  QUERY br_table NO-LOCK DISPLAY
      B-Entidad.cdg_entidad             COLUMN-LABEL "Código!Entidad"
B-Entidad.dsc_entidad             COLUMN-LABEL "Nombre!Entidad" FORMAT "X(50)"
T-Entidad_distribucion.porcentaje COLUMN-LABEL "Porcentaje!Distribución"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 75 BY 13.48
         BGCOLOR 15 FGCOLOR 9 
         TITLE BGCOLOR 15 FGCOLOR 9 "Porcentajes de redistribución de la entidad".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     v-cdg_b-entidad AT ROW 1.52 COL 9 COLON-ALIGNED
     v-dsc_b-entidad AT ROW 1.52 COL 21 COLON-ALIGNED NO-LABEL
     v-porcentaje AT ROW 1.52 COL 65 COLON-ALIGNED
     br_table AT ROW 2.86 COL 3
     btn_grabar AT ROW 16.62 COL 3
     btn_crear AT ROW 16.62 COL 20
     btn_eliminar AT ROW 16.62 COL 37
     v-total-porcentajes AT ROW 16.95 COL 63 COLON-ALIGNED
     RECT-12 AT ROW 16.62 COL 54
     RECT-13 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         BGCOLOR 8 FGCOLOR 0 .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartBrowser
   External Tables: sic.Entidad
   Allow: Basic,Browse
   Frames: 1
   Add Fields to: EXTERNAL-TABLES
   Other Settings: PERSISTENT-ONLY COMPILE
   Temp-Tables and Buffers:
      TABLE: B-Entidad B "?" ? sic Entidad
      TABLE: T-Entidad_distribucion T "?" NO-UNDO sic Entidad_distribucion
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
  CREATE WINDOW B-table-Win ASSIGN
         HEIGHT             = 26.33
         WIDTH              = 160.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB B-table-Win 
/* ************************* Included-Libraries *********************** */

{setsensitivo.i}
{src/adm/method/browser.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW B-table-Win
  NOT-VISIBLE,,RUN-PERSISTENT                                           */
/* SETTINGS FOR FRAME F-Main
   NOT-VISIBLE Size-to-Fit                                              */
/* BROWSE-TAB br_table v-porcentaje F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR BUTTON btn_grabar IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_b-entidad IN FRAME F-Main
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH T-Entidad_distribucion NO-LOCK,
      EACH B-Entidad WHERE B-Entidad.nro_entidad = T-Entidad_distribucion.nro_entidad-dis NO-LOCK.
     _END_FREEFORM
     _Options          = "NO-LOCK KEY-PHRASE SORTBY-PHRASE"
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
ON ROW-ENTRY OF br_table IN FRAME F-Main /* Porcentajes de redistribución de la entidad */
DO:
  /* This code displays initial values for newly added or copied rows. */
  {src/adm/template/brsentry.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-LEAVE OF br_table IN FRAME F-Main /* Porcentajes de redistribución de la entidad */
DO:
    /* Do not disable this code or no updates will take place except
     by pressing the Save button on an Update SmartPanel. */
   {src/adm/template/brsleave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON VALUE-CHANGED OF br_table IN FRAME F-Main /* Porcentajes de redistribución de la entidad */
DO:
  /* This ADM trigger code must be preserved in order to notify other
     objects when the browser's current row changes. */
  {src/adm/template/brschnge.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_crear
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_crear B-table-Win
ON CHOOSE OF btn_crear IN FRAME F-Main /* Crear */
DO:

  ASSIGN FRAME {&FRAME-NAME} v-cdg_b-entidad v-porcentaje.
  FIND B-Entidad WHERE B-Entidad.cdg_entidad = v-cdg_b-entidad NO-LOCK NO-ERROR.
  IF AVAILABLE B-Entidad 
  THEN DO:
       FIND T-Entidad_distribucion 
            WHERE T-Entidad_distribucion.nro_entidad-dis = B-Entidad.nro_entidad NO-LOCK NO-ERROR.
       IF AVAILABLE T-Entidad_distribucion 
       THEN DO:
            RUN ponmensj.p ( INPUT "PDIS002").
            RETURN NO-APPLY.
       END.
       ELSE DO:
            DO TRANSACTION:
               CREATE T-Entidad_distribucion.
               ASSIGN T-Entidad_distribucion.nro_entidad-dis = B-Entidad.nro_entidad
                      T-Entidad_distribucion.porcentaje      = v-porcentaje. 
            END.
            {&OPEN-QUERY-{&BROWSE-NAME}}
            RUN poner_total.
            btn_grabar:SENSITIVE IN FRAME {&FRAME-NAME} = YES.

            ASSIGN  v-cdg_b-entidad = ""
                    v-dsc_b-entidad = ""
                    v-porcentaje       = 0.
            DISPLAY v-cdg_b-entidad
                    v-dsc_b-entidad
                    v-porcentaje
                    WITH FRAME {&FRAME-NAME}.
       END.
  END.
  ELSE DO:
       RUN ponmensj.p ( INPUT "PDIS002").
       RETURN NO-APPLY.
  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_eliminar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_eliminar B-table-Win
ON CHOOSE OF btn_eliminar IN FRAME F-Main /* Eliminar */
DO:
    IF NOT AVAILABLE T-Entidad_distribucion
    THEN DO:
         RUN ponmensj.p ( INPUT "PDIS003").
         RETURN NO-APPLY.
    END.
    ELSE DO:
         sino-msg = NO.
         MESSAGE "Realmente desea eliminar este Porcentaje?" 
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
         IF sino-msg
         THEN DO:
              DO TRANSACTION:              
                 DELETE T-Entidad_distribucion.
                 {&OPEN-QUERY-{&BROWSE-NAME}}
                 RUN poner_total.
                 btn_grabar:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
              END. 
         END.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_grabar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_grabar B-table-Win
ON CHOOSE OF btn_grabar IN FRAME F-Main /* Grabar */
DO:
    IF NOT CAN-FIND(FIRST T-Entidad_distribucion)
    THEN DO:
         RUN ponmensj.p ( INPUT "PDIS003").
         RETURN NO-APPLY.
    END.
    ELSE DO:

         IF v-total-porcentajes <> 100
         THEN DO:
              RUN ponmensj.p ( INPUT "PDIS005").
              RETURN NO-APPLY.
         END.
         ELSE DO:
    
              sino-msg = NO.
              MESSAGE "Realmente desea grabar las modificaciones?" 
                 VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
              IF sino-msg
              THEN DO:
                   DO TRANSACTION:              
                      RUN bajar_porcentajes.
                      btn_grabar:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
                   END. 
              END.
         END.

    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_b-entidad
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_b-entidad B-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_b-entidad IN FRAME F-Main /* Entidad */
OR "." OF v-cdg_b-entidad IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_b-entidad IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "B-Entidad" "cdg_entidad" "SELENTID.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_b-entidad B-table-Win
ON RETURN OF v-cdg_b-entidad IN FRAME F-Main /* Entidad */
DO:
    {traducetabla.i "B-Entidad" "cdg_entidad" "dsc_entidad"} 
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

  /* Create a list of all the tables that we need to get.            */
  {src/adm/template/row-list.i "Entidad"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Entidad"}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE bajar_porcentajes B-table-Win 
PROCEDURE bajar_porcentajes :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   {findempresa.i}

   FOR EACH Entidad_distribucion OF Entidad
       WHERE Entidad_distribucion.cdg_empresa = Empresa.cdg_empresa:
       DELETE Entidad_distribucion.
   END.    

   FOR EACH T-Entidad_distribucion:
       CREATE Entidad_distribucion.
       BUFFER-COPY T-Entidad_distribucion TO Entidad_distribucion 
                   ASSIGN Entidad_distribucion.nro_entidad = Entidad.nro_entidad
                          Entidad_distribucion.cdg_empresa = Empresa.cdg_empresa.
   END.    

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE levantar_porcentajes B-table-Win 
PROCEDURE levantar_porcentajes :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   {findempresa.i}

   FOR EACH Entidad_distribucion OF Entidad
       WHERE Entidad_distribucion.cdg_empresa = Empresa.cdg_empresa:
       CREATE T-Entidad_distribucion.
       BUFFER-COPY Entidad_distribucion TO T-Entidad_distribucion.
   END.    

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

   {findempresa.i}
   que_empresa = Empresa.cdg_empresa.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

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
/*
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'open-query':U ) .
*/
  /* Code placed here will execute AFTER standard behavior.    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-row-available B-table-Win 
PROCEDURE local-row-available :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

   FOR EACH T-Entidad_distribucion:
       DELETE T-Entidad_distribucion.
   END.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'row-available':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

    RUN levantar_porcentajes.
    {&OPEN-QUERY-{&BROWSE-NAME}}
    RUN poner_total.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_total B-table-Win 
PROCEDURE poner_total :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  v-total-porcentajes = 0.

  FOR EACH T-Entidad_distribucion NO-LOCK:
      v-total-porcentajes = v-total-porcentajes + T-Entidad_distribucion.porcentaje.
  END.
  
  DISPLAY 
      v-total-porcentajes
      WITH FRAME {&FRAME-NAME}.

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
  {src/adm/template/snd-list.i "Entidad"}
  {src/adm/template/snd-list.i "T-Entidad_distribucion"}
  {src/adm/template/snd-list.i "B-Entidad"}

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

