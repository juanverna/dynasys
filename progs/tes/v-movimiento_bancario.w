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
&Scoped-define EXTERNAL-TABLES Cuenta_bancaria Cta_cte_bco
&Scoped-define FIRST-EXTERNAL-TABLE Cuenta_bancaria


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Cuenta_bancaria, Cta_cte_bco.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Cta_cte_bco.nro_comprob ~
Cta_cte_bco.tip_comprob Cta_cte_bco.prf_comprob Cta_cte_bco.fecha_efectiva ~
Cta_cte_bco.credito Cta_cte_bco.fecha_movimto Cta_cte_bco.debito ~
Cta_cte_bco.leyenda 
&Scoped-define ENABLED-TABLES Cta_cte_bco
&Scoped-define FIRST-ENABLED-TABLE Cta_cte_bco
&Scoped-Define ENABLED-OBJECTS RECT-11 
&Scoped-Define DISPLAYED-FIELDS Cta_cte_bco.nro_comprob ~
Cta_cte_bco.tip_comprob Cta_cte_bco.prf_comprob Cta_cte_bco.fecha_efectiva ~
Cta_cte_bco.credito Cta_cte_bco.fecha_movimto Cta_cte_bco.debito ~
Cta_cte_bco.leyenda 
&Scoped-define DISPLAYED-TABLES Cta_cte_bco
&Scoped-define FIRST-DISPLAYED-TABLE Cta_cte_bco
&Scoped-Define DISPLAYED-OBJECTS v-cdg_cuenta v-dsc_cuenta 

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
DEFINE VARIABLE v-cdg_cuenta AS CHARACTER FORMAT "X(8)" 
     LABEL "Imputación" 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-dsc_cuenta AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 44 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-11
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 81 BY 8.81.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Cta_cte_bco.nro_comprob AT ROW 2.91 COL 63 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_bco.tip_comprob AT ROW 2.95 COL 15 COLON-ALIGNED
          LABEL "Tipo y Prefijo"
          VIEW-AS FILL-IN 
          SIZE 8 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_bco.prf_comprob AT ROW 2.95 COL 24 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 9 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_cuenta AT ROW 4.1 COL 15 COLON-ALIGNED HELP
          "Numero interno de la cuenta de acreditación de valores"
     v-dsc_cuenta AT ROW 4.14 COL 34 COLON-ALIGNED NO-LABEL
     Cta_cte_bco.fecha_efectiva AT ROW 5.29 COL 63 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_bco.credito AT ROW 5.33 COL 15 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_bco.fecha_movimto AT ROW 6.48 COL 63 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_bco.debito AT ROW 6.57 COL 15 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_bco.leyenda AT ROW 7.67 COL 15 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 63 BY 1
          BGCOLOR 15 FGCOLOR 9 
     "                                                 Movimiento Bancario" VIEW-AS TEXT
          SIZE 78 BY 1 AT ROW 1.24 COL 2
          BGCOLOR 5 FGCOLOR 15 
     RECT-11 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Cuenta_bancaria,sic.Cta_cte_bco
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
         HEIGHT             = 9.05
         WIDTH              = 83.
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

/* SETTINGS FOR FILL-IN Cta_cte_bco.tip_comprob IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN v-cdg_cuenta IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_cuenta IN FRAME F-Main
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

&Scoped-define SELF-NAME v-cdg_cuenta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_cuenta V-table-Win
ON MOUSE-MENU-DOWN OF v-cdg_cuenta IN FRAME F-Main /* Imputación */
OR "+" OF v-cdg_cuenta IN FRAME {&FRAME-NAME}
DO:
  &SCOPED-DEFINE ROWID_TABLA        rid_cuenta
  &SCOPED-DEFINE SELECCION          SELCUENT.P
  &SCOPED-DEFINE TABLA              Cuenta
  &SCOPED-DEFINE CDG_TABLA          cdg_cuenta
  &SCOPED-DEFINE DSC_TABLA          nombre_cta
  &SCOPED-DEFINE V-DSC_TABLA        v-dsc_cuenta    
  &SCOPED-DEFINE V-CDG_TABLA        v-cdg_cuenta    
  &SCOPED-DEFINE MOSTRAR_DSC        YES

  {hlptabla-var.i}      

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_cuenta V-table-Win
ON RETURN OF v-cdg_cuenta IN FRAME F-Main /* Imputación */
DO:

  &SCOPED-DEFINE ROWID_TABLA        rid_cuenta
  &SCOPED-DEFINE TABLA              Cuenta
  &SCOPED-DEFINE CDG_TABLA          cdg_cuenta
  &SCOPED-DEFINE DSC_TABLA          nombre_cta
  &SCOPED-DEFINE V-DSC_TABLA        v-dsc_cuenta    
  &SCOPED-DEFINE CAMPO-FRAME        v-cdg_cuenta    
  &SCOPED-DEFINE MOSTRAR_DSC        YES

  {trdtabla.i}  
  
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
  {src/adm/template/row-list.i "Cuenta_bancaria"}
  {src/adm/template/row-list.i "Cta_cte_bco"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Cuenta_bancaria"}
  {src/adm/template/row-find.i "Cta_cte_bco"}

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

   {blanqueacodigo.i "Cuenta"}

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

  IF NEW Cta_cte_bco
  THEN DO:
      ASSIGN Cta_cte_bco.cdg_cuenta_ban = Cuenta_bancaria.cdg_cuenta_ban
             Cta_cte_bco.origen         = "M".
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

  IF Cta_cte_bco.origen <> "M"
  THEN DO:
      RUN ponmensj.p ( INPUT "CBCO012" ).
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

  {deshabcodigo.i "Cuenta"}
  es_alta = NO.

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

  DEFINE VARIABLE h AS HANDLE.
  DEFINE VARIABLE c AS CHARACTER.

  RUN get-link-handle IN adm-broker-hdl
       (THIS-PROCEDURE, 'TableIO-Source':U, OUTPUT c).

  IF AVAILABLE Cta_cte_bco
  THEN DO:
      IF NUM-ENTRIES (c) eq 1 
      THEN DO:
          h = WIDGET-HANDLE (c).
          RUN habilitar_modificaciones IN h ( INPUT Cta_cte_bco.origen = "M" ) .
      END.
  END.
  ELSE DO:
      IF NUM-ENTRIES (c) eq 1 
      THEN DO:
          h = WIDGET-HANDLE (c).
          RUN habilitar_modificaciones IN h ( INPUT NO ) .
      END.
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

  {habilcodigo.i "Cuenta"}


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
  {src/adm/template/snd-list.i "Cuenta_bancaria"}
  {src/adm/template/snd-list.i "Cta_cte_bco"}

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

