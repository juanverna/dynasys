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
&Scoped-define EXTERNAL-TABLES Vendedor
&Scoped-define FIRST-EXTERNAL-TABLE Vendedor


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Vendedor.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Vendedor.cdg_vendedor Vendedor.nombre ~
Vendedor.cdg_subclasevnd Vendedor.entidades_validas Vendedor.calle ~
Vendedor.piso Vendedor.depto Vendedor.cdg_postal Vendedor.localidad ~
Vendedor.tipo_doc Vendedor.numero_doc Vendedor.telefono Vendedor.nacionalid ~
Vendedor.fecha_nac Vendedor.lugar_nac Vendedor.nro_cuil Vendedor.prc_ventas ~
Vendedor.prc_cobranzas Vendedor.imp_minimo 
&Scoped-define ENABLED-TABLES Vendedor
&Scoped-define FIRST-ENABLED-TABLE Vendedor
&Scoped-Define ENABLED-OBJECTS RECT-7 
&Scoped-Define DISPLAYED-FIELDS Vendedor.cdg_vendedor Vendedor.nombre ~
Vendedor.cdg_subclasevnd Vendedor.entidades_validas Vendedor.calle ~
Vendedor.piso Vendedor.depto Vendedor.cdg_postal Vendedor.localidad ~
Vendedor.tipo_doc Vendedor.numero_doc Vendedor.telefono Vendedor.nacionalid ~
Vendedor.fecha_nac Vendedor.lugar_nac Vendedor.nro_cuil Vendedor.prc_ventas ~
Vendedor.prc_cobranzas Vendedor.imp_minimo 
&Scoped-define DISPLAYED-TABLES Vendedor
&Scoped-define FIRST-DISPLAYED-TABLE Vendedor
&Scoped-Define DISPLAYED-OBJECTS v-cdg_empleado v-dsc_empleado 

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
DEFINE BUTTON btn_clasificar 
     LABEL "&Clasificar" 
     SIZE 21 BY 1.

DEFINE VARIABLE v-cdg_empleado AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Empleado" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-dsc_empleado AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 87 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 125 BY 13.81.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Vendedor.cdg_vendedor AT ROW 1.48 COL 18 COLON-ALIGNED
          LABEL "Código"
          VIEW-AS FILL-IN NATIVE 
          SIZE 15 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Vendedor.nombre AT ROW 2.67 COL 18 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 103 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Vendedor.cdg_subclasevnd AT ROW 3.86 COL 18 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 81 BY 1
          BGCOLOR 15 FGCOLOR 9 
     btn_clasificar AT ROW 3.86 COL 102
     v-cdg_empleado AT ROW 5.05 COL 18 COLON-ALIGNED
     v-dsc_empleado AT ROW 5.05 COL 34 COLON-ALIGNED NO-LABEL
     Vendedor.entidades_validas AT ROW 6.24 COL 18 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 103 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Vendedor.calle AT ROW 7.43 COL 18 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 64 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Vendedor.piso AT ROW 7.43 COL 90 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 9 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Vendedor.depto AT ROW 7.43 COL 109 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 12 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Vendedor.cdg_postal AT ROW 8.62 COL 18 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 12 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Vendedor.localidad AT ROW 8.62 COL 39 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 43 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Vendedor.tipo_doc AT ROW 8.62 COL 90 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 9 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Vendedor.numero_doc AT ROW 8.62 COL 109 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 12 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Vendedor.telefono AT ROW 9.81 COL 18 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 64 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Vendedor.nacionalid AT ROW 9.81 COL 109 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 12 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Vendedor.fecha_nac AT ROW 11 COL 18 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Vendedor.lugar_nac AT ROW 11 COL 50 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 32 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Vendedor.nro_cuil AT ROW 11 COL 90 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 31 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Vendedor.prc_ventas AT ROW 13.38 COL 18 COLON-ALIGNED
          LABEL "% Ventas"
          VIEW-AS FILL-IN NATIVE 
          SIZE 12 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Vendedor.prc_cobranzas AT ROW 13.38 COL 70 COLON-ALIGNED
          LABEL "% Cobranzas"
          VIEW-AS FILL-IN NATIVE 
          SIZE 12 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Vendedor.imp_minimo AT ROW 13.38 COL 101 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 20 BY 1
          BGCOLOR 15 FGCOLOR 9 
     RECT-7 AT ROW 1 COL 1
     "                   Porcentajes básicos de comisión y mìnimo asegurado" VIEW-AS TEXT
          SIZE 103 BY 1 AT ROW 12.19 COL 20
          BGCOLOR 5 FGCOLOR 15 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Vendedor
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
         HEIGHT             = 20.67
         WIDTH              = 128.6.
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

/* SETTINGS FOR BUTTON btn_clasificar IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Vendedor.cdg_vendedor IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Vendedor.prc_cobranzas IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Vendedor.prc_ventas IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN v-cdg_empleado IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_empleado IN FRAME F-Main
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

&Scoped-define SELF-NAME btn_clasificar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_clasificar V-table-Win
ON CHOOSE OF btn_clasificar IN FRAME F-Main /* Clasificar */
DO:

   DEFINE VARIABLE v-cdg_subclase LIKE Vendedor.cdg_subclase.
   DEFINE VARIABLE puso_ok AS LOGICAL.
   
   RUN c-abmclasevendedor.w ( OUTPUT v-cdg_subclase , OUTPUT puso_ok ).
   IF puso_ok
   THEN DO:
      DISPLAY v-cdg_subclase @ Vendedor.cdg_subclase
              WITH FRAME {&FRAME-NAME}.
   END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_empleado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_empleado V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_empleado IN FRAME F-Main /* Empleado */
OR "." OF v-cdg_empleado IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_empleado IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "empleado" "nro_legajo" "selemple.p"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_empleado V-table-Win
ON RETURN OF v-cdg_empleado IN FRAME F-Main /* Empleado */
DO:
   {traducetabla.i "Empleado" "nro_legajo" "nombre"}   
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
  {src/adm/template/row-list.i "Vendedor"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Vendedor"}

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

  {blanqueacodigo.i "Empleado"}

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

    DEFINE BUFFER B-Vendedor FOR Vendedor.

    IF INPUT FRAME {&FRAME-NAME} Vendedor.nombre = "" OR 
        INPUT FRAME {&FRAME-NAME} Vendedor.nombre = ?  
    THEN DO:
         RUN PONMENSJ.P (INPUT "VEND001").
         RETURN ERROR.
    END.            

    IF CAN-FIND(FIRST B-Vendedor 
                       WHERE B-Vendedor.cdg_vendedor = 
                           INPUT FRAME {&FRAME-NAME} Vendedor.cdg_vendedor  
                        AND ROWID(B-Vendedor) <> ROWID(Vendedor) )
    THEN DO:
         RUN PONMENSJ.P (INPUT "VEND002").
         RETURN ERROR.
    END.            


   &SCOPED-DEFINE TABLA-MAESTRA  Vendedor

   {validartabla.i "Empleado" "nro_legajo" "nombre" "DOMI002"}

   &UNDEFINE TABLA-MAESTRA

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   &SCOPED-DEFINE TABLA-MAESTRA  Vendedor

   {asignartabla.i "Empleado" "nro_empleado" "nro_empleado" } 

   &UNDEFINE TABLA-MAESTRA


 IF NEW Vendedor 
    THEN Vendedor.nro_vendedor = NEXT-VALUE(proximo_vendedor).

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
   RUN vlb-vendedor.p ( INPUT ROWID(Vendedor), OUTPUT baja_no ).
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

   btn_clasificar:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
   {deshabcodigo.i "Empleado"}

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

  IF AVAILABLE Vendedor
  THEN DO:

        &SCOPED-DEFINE TABLA-MAESTRA Vendedor
  
        {displaytabla.i "Empleado" "nro_legajo" "nombre" "nro_empleado" "nro_empleado"} 

        &UNDEFINE TABLA-MAESTRA

  END.
  ELSE DO:
       {blanqueacodigo.i "Empleado" }
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

   btn_clasificar:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
  {habilcodigo.i "Empleado"}

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
  {src/adm/template/snd-list.i "Vendedor"}

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

