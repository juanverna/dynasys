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

DEFINE VARIABLE rid_tabla AS ROWID.

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
&Scoped-define EXTERNAL-TABLES Bduso
&Scoped-define FIRST-EXTERNAL-TABLE Bduso


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Bduso.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Bduso.tipo_formula Bduso.num_inventario ~
Bduso.dsc_bduso Bduso.referencia Bduso.fecha_alta Bduso.fecha_baja ~
Bduso.n_periodos Bduso.fecha_ultamor Bduso.valor_org Bduso.valor_act 
&Scoped-define ENABLED-TABLES Bduso
&Scoped-define FIRST-ENABLED-TABLE Bduso
&Scoped-Define ENABLED-OBJECTS v-cdg_grupo_bduso RECT-5 
&Scoped-Define DISPLAYED-FIELDS Bduso.tipo_formula Bduso.num_inventario ~
Bduso.dsc_bduso Bduso.referencia Bduso.fecha_alta Bduso.fecha_baja ~
Bduso.n_periodos Bduso.fecha_ultamor Bduso.valor_org Bduso.valor_act 
&Scoped-define DISPLAYED-TABLES Bduso
&Scoped-define FIRST-DISPLAYED-TABLE Bduso
&Scoped-Define DISPLAYED-OBJECTS v-cdg_grupo_bduso v-dsc_grupo_bduso 

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
DEFINE VARIABLE v-cdg_grupo_bduso AS CHARACTER FORMAT "X(8)" 
     LABEL "Grupo B.Uso." 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-dsc_grupo_bduso AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 63 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 109 BY 10.95.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Bduso.tipo_formula AT ROW 1.48 COL 80 NO-LABEL
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Mensual", "M":U,
"Anual", "A":U
          SIZE 25 BY 1.19
     Bduso.num_inventario AT ROW 1.52 COL 20 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Bduso.dsc_bduso AT ROW 2.91 COL 20 COLON-ALIGNED FORMAT "X(55)"
          VIEW-AS FILL-IN 
          SIZE 83 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Bduso.referencia AT ROW 4.33 COL 20 COLON-ALIGNED FORMAT "X(35)"
          VIEW-AS FILL-IN 
          SIZE 83 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Bduso.fecha_alta AT ROW 5.76 COL 20 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Bduso.fecha_baja AT ROW 5.76 COL 85 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Bduso.n_periodos AT ROW 7.14 COL 20 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Bduso.fecha_ultamor AT ROW 7.14 COL 85 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Bduso.valor_org AT ROW 8.62 COL 20 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Bduso.valor_act AT ROW 8.62 COL 85 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_grupo_bduso AT ROW 10 COL 20 COLON-ALIGNED
     v-dsc_grupo_bduso AT ROW 10.05 COL 40 COLON-ALIGNED NO-LABEL
     RECT-5 AT ROW 1 COL 1
     "Amortización:" VIEW-AS TEXT
          SIZE 14 BY .62 AT ROW 1.71 COL 66
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Bduso
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
         HEIGHT             = 17.33
         WIDTH              = 125.
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

/* SETTINGS FOR FILL-IN Bduso.dsc_bduso IN FRAME F-Main
   EXP-FORMAT                                                           */
/* SETTINGS FOR FILL-IN Bduso.referencia IN FRAME F-Main
   EXP-FORMAT                                                           */
/* SETTINGS FOR FILL-IN v-dsc_grupo_bduso IN FRAME F-Main
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

&Scoped-define SELF-NAME v-cdg_grupo_bduso
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_grupo_bduso V-table-Win
ON MOUSE-MENU-DOWN OF v-cdg_grupo_bduso IN FRAME F-Main /* Grupo B.Uso. */
OR "." OF v-cdg_grupo_bduso IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_grupo_bduso IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Grupo_bduso" "cdg_grpbduso" "SELGRBDU.P"}
  
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
  {src/adm/template/row-list.i "Bduso"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Bduso"}

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

  {blanqueacodigo.i "Grupo_bduso"}
  /*{blanqueacodigo.i "Entidad"}*/

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

    DEFINE VARIABLE act_bduso AS ROWID.
    DEFINE BUFFER B-Bduso FOR Bduso.

    IF INPUT FRAME {&FRAME-NAME} Bduso.num_inventario = "" OR 
        INPUT FRAME {&FRAME-NAME} Bduso.num_inventario = ?  
    THEN DO:
         RUN PONMENSJ.P (INPUT "BUSO010").
         RETURN ERROR.
    END.            

    IF INPUT FRAME {&FRAME-NAME} Bduso.dsc_bduso  = "" OR 
        INPUT FRAME {&FRAME-NAME} Bduso.dsc_bduso = ?  
    THEN DO:
         RUN PONMENSJ.P (INPUT "BUSO011").
         RETURN ERROR.
    END.            

    IF CAN-FIND(FIRST B-Bduso 
                       WHERE B-Bduso.num_inventario = 
                           INPUT FRAME {&FRAME-NAME} Bduso.num_inventario  
                        AND ROWID(B-Bduso) <> ROWID(Bduso) )
    THEN DO:
         RUN PONMENSJ.P (INPUT "BUSO012").
         RETURN ERROR.
    END.            

    IF INPUT FRAME {&FRAME-NAME} Bduso.n_periodos <= 0  
    THEN DO:
       RUN PONMENSJ.P (INPUT "BUSO014").
       RETURN.
    END.            

    IF INPUT FRAME {&FRAME-NAME} Bduso.valor_org <= 0  
    THEN DO:
       RUN PONMENSJ.P (INPUT "BUSO015").
       RETURN.
    END.            

   &SCOPED-DEFINE TABLA-MAESTRA  Bduso

   {validartabla.i "Grupo_bduso" "cdg_grpbduso" "dsc_grpbduso" "BUSO013"}
   /*{validartabla.i "Entidad" "cdg_entidad" "dsc_entidad" "ENTI017"}*/
      
   &UNDEFINE TABLA-MAESTRA
    
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   &SCOPED-DEFINE TABLA-MAESTRA  Bduso
   
   {asignartabla.i "Grupo_bduso" "cdg_grpbduso" "cdg_grpbduso"}
   /*{asignartabla.i "Entidad" "nro_entidad" "nro_entidad"} */

   &UNDEFINE TABLA-MAESTRA
   
  /* Code placed here will execute AFTER standard behavior.    */
    
   {findempresa.i}
    
   Bduso.cdg_empresa = Empresa.cdg_empresa.
   IF NEW Bduso
       THEN Bduso.nro_bduso = NEXT-VALUE(proximo_bduso).

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
   RUN vlb-bduso.p ( INPUT ROWID(Bduso), OUTPUT baja_no ).
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

  {deshabcodigo.i "Grupo_bduso"}
  /*{deshabcodigo.i "Entidad"}*/

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

  &SCOPED-DEFINE TABLA-MAESTRA  Bduso

  IF AVAILABLE Bduso
  THEN DO:
      /*{displaytabla.i "Entidad" "cdg_entidad" "nom_entidad" "nro_entidad" "nro_entidad"} */
      {displaytabla.i "Grupo_bduso" "cdg_grpbduso" "dsc_grpbduso" "cdg_grpbduso" "cdg_grpbduso"}
  END.
  ELSE DO:
      {blanqueacodigo.i "Grupo_bduso"}
      /*{blanqueacodigo.i "Entidad"}*/
      
  END.

  &UNDEFINE TABLA-MAESTRA


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

  {habilcodigo.i "Grupo_bduso"}
  /*{habilcodigo.i "Entidad"}*/


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
  {src/adm/template/snd-list.i "Bduso"}

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

