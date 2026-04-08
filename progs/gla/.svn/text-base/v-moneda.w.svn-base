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

DEFINE BUFFER B-Moneda FOR Moneda.

DEFINE VARIABLE es_alta AS LOGICAL.

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
&Scoped-define EXTERNAL-TABLES Moneda
&Scoped-define FIRST-EXTERNAL-TABLE Moneda


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Moneda.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Moneda.cdg_moneda Moneda.es_local ~
Moneda.abrevia Moneda.descripcion Moneda.descripcion_i Moneda.descripcion_o ~
Moneda.es_referencia Moneda.reexpresa_saldos 
&Scoped-define ENABLED-TABLES Moneda
&Scoped-define FIRST-ENABLED-TABLE Moneda
&Scoped-Define ENABLED-OBJECTS RECT-6 
&Scoped-Define DISPLAYED-FIELDS Moneda.cdg_moneda Moneda.es_local ~
Moneda.abrevia Moneda.descripcion Moneda.descripcion_i Moneda.descripcion_o ~
Moneda.es_referencia Moneda.reexpresa_saldos 
&Scoped-define DISPLAYED-TABLES Moneda
&Scoped-define FIRST-DISPLAYED-TABLE Moneda


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
DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 85 BY 7.62.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Moneda.cdg_moneda AT ROW 1.48 COL 18 COLON-ALIGNED
          LABEL "Código"
          VIEW-AS FILL-IN 
          SIZE 10 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Moneda.es_local AT ROW 1.48 COL 34
          LABEL "Es Moneda Local"
          VIEW-AS TOGGLE-BOX
          SIZE 22 BY .95
     Moneda.abrevia AT ROW 1.48 COL 71 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 10 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Moneda.descripcion AT ROW 3.86 COL 18 COLON-ALIGNED
          LABEL "Local"
          VIEW-AS FILL-IN 
          SIZE 63 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Moneda.descripcion_i AT ROW 5.05 COL 18 COLON-ALIGNED
          LABEL "Inglés"
          VIEW-AS FILL-IN 
          SIZE 63 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Moneda.descripcion_o AT ROW 6.24 COL 18 COLON-ALIGNED
          LABEL "Idioma Origen"
          VIEW-AS FILL-IN 
          SIZE 63 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Moneda.es_referencia AT ROW 7.43 COL 20
          VIEW-AS TOGGLE-BOX
          SIZE 19 BY .76
     Moneda.reexpresa_saldos AT ROW 7.43 COL 60
          VIEW-AS TOGGLE-BOX
          SIZE 22 BY .81
     RECT-6 AT ROW 1 COL 1
     "   Descripciones asociadas a la moneda actual" VIEW-AS TEXT
          SIZE 63 BY 1 AT ROW 2.67 COL 20
          BGCOLOR 5 FGCOLOR 15 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Moneda
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
         HEIGHT             = 10.43
         WIDTH              = 90.
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

/* SETTINGS FOR FILL-IN Moneda.cdg_moneda IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Moneda.descripcion IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Moneda.descripcion_i IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Moneda.descripcion_o IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR TOGGLE-BOX Moneda.es_local IN FRAME F-Main
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
  {src/adm/template/row-list.i "Moneda"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Moneda"}

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

   es_alta = YES.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'add-record':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

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

    DEFINE VARIABLE hubo_error      AS LOGICAL.


    IF INPUT FRAME {&FRAME-NAME} Moneda.descripcion = "" OR 
        INPUT FRAME {&FRAME-NAME} Moneda.descripcion = ?  
    THEN DO:
         RUN PONMENSJ.P (INPUT "MONE001").
         RETURN ERROR.
    END.            

    IF INPUT FRAME {&FRAME-NAME} Moneda.cdg_moneda = "" OR 
        INPUT FRAME {&FRAME-NAME} Moneda.cdg_moneda = ?  
    THEN DO:
         RUN PONMENSJ.P (INPUT "MONE007").
         RETURN ERROR.
    END.            

    IF es_alta
    THEN DO:

        IF CAN-FIND(FIRST B-Moneda 
                           WHERE B-Moneda.cdg_Moneda = 
                               INPUT FRAME {&FRAME-NAME} Moneda.cdg_Moneda )
        THEN DO:
             RUN PONMENSJ.P (INPUT "MONE002").
             RETURN ERROR.
        END.

        IF CAN-FIND(FIRST B-Moneda 
                           WHERE B-Moneda.descripcion = 
                               INPUT FRAME {&FRAME-NAME} Moneda.descripcion )
        THEN DO:
             RUN PONMENSJ.P (INPUT "MONE006").
             RETURN ERROR.
        END.

    END.
    ELSE DO:
        IF CAN-FIND(FIRST B-Moneda 
                           WHERE B-Moneda.cdg_Moneda = 
                               INPUT FRAME {&FRAME-NAME} Moneda.cdg_Moneda  
                            AND ROWID(B-Moneda) <> ROWID(Moneda) )
        THEN DO:
             RUN PONMENSJ.P (INPUT "MONE002").
             RETURN ERROR.
        END.

        IF CAN-FIND(FIRST B-Moneda 
                           WHERE B-Moneda.descripcion = 
                               INPUT FRAME {&FRAME-NAME} Moneda.descripcion 
                            AND ROWID(B-Moneda) <> ROWID(Moneda) )
        THEN DO:
             RUN PONMENSJ.P (INPUT "MONE006").
             RETURN ERROR.
        END.

    END.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  IF NEW Moneda
     THEN Moneda.nro_moneda = NEXT-VALUE(proxima_moneda).

  IF Moneda.es_local 
  THEN DO:
      /* Borramos todas las marcadas */
      FOR EACH B-Moneda:
          B-Moneda.es_local = NO.
      END.
      /* vovlemos a marcar la actual */
      Moneda.es_local =  YES.
  END.

  IF Moneda.es_referencia 
  THEN DO:
      /* Borramos todas las marcadas */
      FOR EACH B-Moneda:
          B-Moneda.es_referencia = NO.
      END.
      /* vovlemos a marcar la actual */
      Moneda.es_referencia =  YES.
  END.
  
  es_alta = FALSE.

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

   es_alta = YES.

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

   DEFINE VARIABLE baja_no AS LOGICAL.
   RUN vlb-monedas.p ( INPUT ROWID(Moneda), OUTPUT baja_no ).
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-disable V-table-Win 
PROCEDURE local-disable :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'disable':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  es_alta = NO.

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
  {src/adm/template/snd-list.i "Moneda"}

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

