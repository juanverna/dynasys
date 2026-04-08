&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW

/* Temp-Table and Buffer definitions                                    */
DEFINE BUFFER B-Proveedor FOR Proveedor.
DEFINE TEMP-TABLE T-Participacion_societaria NO-UNDO LIKE Participacion_societaria.


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
&Scoped-define EXTERNAL-TABLES Proveedor
&Scoped-define FIRST-EXTERNAL-TABLE Proveedor


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Proveedor.
/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Participacion_societaria B-Proveedor

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table B-Proveedor.cdg_proveedor B-Proveedor.nombre T-Participacion_societaria.prc_participacion   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table   
&Scoped-define SELF-NAME br_table
&Scoped-define QUERY-STRING-br_table FOR EACH T-Participacion_societaria NO-LOCK, ~
             EACH B-Proveedor WHERE B-Proveedor.nro_proveedor = T-Participacion_societaria.nro_proveedor_integrante NO-LOCK
&Scoped-define OPEN-QUERY-br_table OPEN QUERY {&SELF-NAME} FOR EACH T-Participacion_societaria NO-LOCK, ~
             EACH B-Proveedor WHERE B-Proveedor.nro_proveedor = T-Participacion_societaria.nro_proveedor_integrante NO-LOCK.
&Scoped-define TABLES-IN-QUERY-br_table T-Participacion_societaria ~
B-Proveedor
&Scoped-define FIRST-TABLE-IN-QUERY-br_table T-Participacion_societaria
&Scoped-define SECOND-TABLE-IN-QUERY-br_table B-Proveedor


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS v-cdg_b-proveedor v-prc_participacion ~
br_table btn_crear btn_eliminar v-total-prc_participacions RECT-12 RECT-13 
&Scoped-Define DISPLAYED-OBJECTS v-cdg_b-proveedor v-dsc_b-proveedor ~
v-prc_participacion v-total-prc_participacions 

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
     SIZE 21 BY 1.67.

DEFINE BUTTON btn_eliminar 
     LABEL "&Eliminar" 
     SIZE 21 BY 1.67.

DEFINE BUTTON btn_grabar 
     LABEL "&Grabar" 
     SIZE 21 BY 1.67.

DEFINE VARIABLE v-cdg_b-proveedor AS CHARACTER FORMAT "X(8)":U 
     LABEL "Proveedor" 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-dsc_b-proveedor AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 43 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-prc_participacion AS DECIMAL FORMAT ">>9.9999":U INITIAL 0 
     LABEL "%" 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-total-prc_participacions AS DECIMAL FORMAT ">>9.9999":U INITIAL 0 
     LABEL "Total %" 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 11 FGCOLOR 9 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-12
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 24 BY 1.67.

DEFINE RECTANGLE RECT-13
     EDGE-PIXELS 4 GRAPHIC-EDGE  NO-FILL 
     SIZE 97 BY 24.29.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      T-Participacion_societaria, 
      B-Proveedor SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _FREEFORM
  QUERY br_table NO-LOCK DISPLAY
      B-Proveedor.cdg_proveedor             COLUMN-LABEL "Código!Proveedor" FORMAT "X(15)"
      B-Proveedor.nombre                    COLUMN-LABEL "Nombre!Proveedor" FORMAT "X(60)"
      T-Participacion_societaria.prc_participacion COLUMN-LABEL "Porcentaje!Distribución"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 92 BY 20.05
         BGCOLOR 15 FGCOLOR 9 
         TITLE BGCOLOR 15 FGCOLOR 9 "Porcentajes de redistribución de la proveedor".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     v-cdg_b-proveedor AT ROW 1.48 COL 14 COLON-ALIGNED
     v-dsc_b-proveedor AT ROW 1.48 COL 32 COLON-ALIGNED NO-LABEL
     v-prc_participacion AT ROW 1.48 COL 79 COLON-ALIGNED
     br_table AT ROW 2.86 COL 3
     btn_grabar AT ROW 23.14 COL 3
     btn_crear AT ROW 23.14 COL 25
     btn_eliminar AT ROW 23.14 COL 47
     v-total-prc_participacions AT ROW 23.38 COL 79 COLON-ALIGNED
     RECT-12 AT ROW 23.14 COL 71
     RECT-13 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         BGCOLOR 8 FGCOLOR 0 .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartBrowser
   External Tables: sic.Proveedor
   Allow: Basic,Browse
   Frames: 1
   Add Fields to: EXTERNAL-TABLES
   Other Settings: PERSISTENT-ONLY COMPILE
   Temp-Tables and Buffers:
      TABLE: B-Proveedor B "?" ? sic Proveedor
      TABLE: T-Participacion_societaria T "?" NO-UNDO sic Participacion_societaria
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
/* BROWSE-TAB br_table v-prc_participacion F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR BUTTON btn_grabar IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_b-proveedor IN FRAME F-Main
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH T-Participacion_societaria NO-LOCK,
      EACH B-Proveedor WHERE B-Proveedor.nro_proveedor = T-Participacion_societaria.nro_proveedor_integrante NO-LOCK.
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
ON ROW-ENTRY OF br_table IN FRAME F-Main /* Porcentajes de redistribución de la proveedor */
DO:
  /* This code displays initial values for newly added or copied rows. */
  {src/adm/template/brsentry.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-LEAVE OF br_table IN FRAME F-Main /* Porcentajes de redistribución de la proveedor */
DO:
    /* Do not disable this code or no updates will take place except
     by pressing the Save button on an Update SmartPanel. */
   {src/adm/template/brsleave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON VALUE-CHANGED OF br_table IN FRAME F-Main /* Porcentajes de redistribución de la proveedor */
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

  ASSIGN FRAME {&FRAME-NAME} v-cdg_b-proveedor v-prc_participacion.
  FIND B-Proveedor WHERE B-Proveedor.cdg_proveedor = v-cdg_b-proveedor NO-LOCK NO-ERROR.
  IF AVAILABLE B-Proveedor 
  THEN DO:
       FIND T-Participacion_societaria 
            WHERE T-Participacion_societaria.nro_proveedor_integrante = B-Proveedor.nro_proveedor NO-LOCK NO-ERROR.
       IF AVAILABLE T-Participacion_societaria 
       THEN DO:
            RUN ponmensj.p ( INPUT "PDIS002").
            RETURN NO-APPLY.
       END.
       ELSE DO:
            DO TRANSACTION:
               CREATE T-Participacion_societaria.
               ASSIGN T-Participacion_societaria.nro_proveedor_integrante = B-Proveedor.nro_proveedor
                      T-Participacion_societaria.prc_participacion      = v-prc_participacion. 
            END.
            {&OPEN-QUERY-{&BROWSE-NAME}}
            RUN poner_total.
            btn_grabar:SENSITIVE IN FRAME {&FRAME-NAME} = YES.

            ASSIGN  v-cdg_b-proveedor = ""
                    v-dsc_b-proveedor = ""
                    v-prc_participacion       = 0.
            DISPLAY v-cdg_b-proveedor
                    v-dsc_b-proveedor
                    v-prc_participacion
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
    IF NOT AVAILABLE T-Participacion_societaria
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
                 DELETE T-Participacion_societaria.
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
    IF NOT CAN-FIND(FIRST T-Participacion_societaria)
    THEN DO:
         RUN ponmensj.p ( INPUT "PDIS003").
         RETURN NO-APPLY.
    END.
    ELSE DO:

         IF v-total-prc_participacions <> 100
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
                      RUN bajar_prc_participacions.
                      btn_grabar:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
                   END. 
              END.
         END.

    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_b-proveedor
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_b-proveedor B-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_b-proveedor IN FRAME F-Main /* Proveedor */
OR "." OF v-cdg_b-proveedor IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_b-proveedor IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "B-Proveedor" "cdg_proveedor" "SELPROVE.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_b-proveedor B-table-Win
ON RETURN OF v-cdg_b-proveedor IN FRAME F-Main /* Proveedor */
DO:
    {traducetabla.i "B-Proveedor" "cdg_proveedor" "nombre"} 
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
  {src/adm/template/row-list.i "Proveedor"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Proveedor"}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE bajar_prc_participacions B-table-Win 
PROCEDURE bajar_prc_participacions :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   {findempresa.i}

   FOR EACH Participacion_societaria 
       WHERE Participacion_societaria.nro_proveedor_sociedad = Proveedor.nro_proveedor:
       DELETE Participacion_societaria.
   END.    

   FOR EACH T-Participacion_societaria:
       CREATE Participacion_societaria.
       BUFFER-COPY T-Participacion_societaria TO Participacion_societaria 
                   ASSIGN Participacion_societaria.nro_proveedor_sociedad = Proveedor.nro_proveedor.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE levantar_prc_participacions B-table-Win 
PROCEDURE levantar_prc_participacions :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   {findempresa.i}

   FOR EACH Participacion_societaria 
       WHERE Participacion_societaria.nro_proveedor_sociedad = Proveedor.nro_proveedor:
       CREATE T-Participacion_societaria.
       BUFFER-COPY Participacion_societaria TO T-Participacion_societaria.
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

   FOR EACH T-Participacion_societaria:
       DELETE T-Participacion_societaria.
   END.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'row-available':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

    RUN levantar_prc_participacions.
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

  v-total-prc_participacions = 0.

  FOR EACH T-Participacion_societaria NO-LOCK:
      v-total-prc_participacions = v-total-prc_participacions + T-Participacion_societaria.prc_participacion.
  END.
  
  DISPLAY 
      v-total-prc_participacions
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
  {src/adm/template/snd-list.i "Proveedor"}
  {src/adm/template/snd-list.i "T-Participacion_societaria"}
  {src/adm/template/snd-list.i "B-Proveedor"}

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

