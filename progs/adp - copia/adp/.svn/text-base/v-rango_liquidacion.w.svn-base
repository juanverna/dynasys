&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW

/* Temp-Table and Buffer definitions                                    */
DEFINE BUFFER D-Empleado FOR Empleado.
DEFINE BUFFER H-Empleado FOR Empleado.


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
&Scoped-define EXTERNAL-TABLES Rango_liquidacion Liquidacion
&Scoped-define FIRST-EXTERNAL-TABLE Rango_liquidacion


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Rango_liquidacion, Liquidacion.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Rango_liquidacion.sec_liquidacion 
&Scoped-define ENABLED-TABLES Rango_liquidacion
&Scoped-define FIRST-ENABLED-TABLE Rango_liquidacion
&Scoped-Define ENABLED-OBJECTS RECT-9 
&Scoped-Define DISPLAYED-FIELDS Rango_liquidacion.sec_liquidacion 
&Scoped-define DISPLAYED-TABLES Rango_liquidacion
&Scoped-define FIRST-DISPLAYED-TABLE Rango_liquidacion
&Scoped-Define DISPLAYED-OBJECTS v-cdg_d-empleado v-dsc_d-empleado ~
v-cdg_h-empleado v-dsc_h-empleado v-cdg_tipo_de_liquidac ~
v-dsc_tipo_de_liquidac 

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
sec_liquidacion||y|sic.Rango_liquidacion.sec_liquidacion
cdg_liquid||y|sic.Rango_liquidacion.cdg_liquid
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = ,
     Keys-Supplied = "sec_liquidacion,cdg_liquid"':U).
/**************************
</EXECUTING-CODE> */
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE VARIABLE v-cdg_d-empleado AS INTEGER FORMAT "ZZZZZ9" INITIAL 0 
     LABEL "Desde Legajo Nº" 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_h-empleado AS INTEGER FORMAT "ZZZZZ9" INITIAL 0 
     LABEL "Hasta Legajo Nº" 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_tipo_de_liquidac AS INTEGER FORMAT ">>9" INITIAL 0 
     LABEL "Tipo Liquidación" 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-dsc_d-empleado AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 87 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_h-empleado AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 87 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_tipo_de_liquidac AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 87 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 121 BY 4.29.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     v-cdg_d-empleado AT ROW 1.48 COL 19 COLON-ALIGNED HELP
          "Desde numero de legajo"
     v-dsc_d-empleado AT ROW 1.48 COL 31 COLON-ALIGNED NO-LABEL
     v-cdg_h-empleado AT ROW 2.67 COL 19 COLON-ALIGNED HELP
          "Hasta numero de legajo"
     v-dsc_h-empleado AT ROW 2.67 COL 31 COLON-ALIGNED NO-LABEL
     v-cdg_tipo_de_liquidac AT ROW 3.86 COL 19 COLON-ALIGNED
     v-dsc_tipo_de_liquidac AT ROW 3.86 COL 31 COLON-ALIGNED NO-LABEL
     Rango_liquidacion.sec_liquidacion AT ROW 3.86 COL 109 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 9 BY 1
     RECT-9 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Rango_liquidacion,sic.Liquidacion
   Allow: Basic,DB-Fields
   Frames: 1
   Add Fields to: EXTERNAL-TABLES
   Other Settings: PERSISTENT-ONLY COMPILE
   Temp-Tables and Buffers:
      TABLE: D-Empleado B "?" ? sic Empleado
      TABLE: H-Empleado B "?" ? sic Empleado
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
         HEIGHT             = 4.62
         WIDTH              = 126.4.
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

ASSIGN 
       Rango_liquidacion.sec_liquidacion:HIDDEN IN FRAME F-Main           = TRUE.

/* SETTINGS FOR FILL-IN v-cdg_d-empleado IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_h-empleado IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_tipo_de_liquidac IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_d-empleado IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_h-empleado IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_tipo_de_liquidac IN FRAME F-Main
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

&Scoped-define SELF-NAME v-cdg_d-empleado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_d-empleado V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_d-empleado IN FRAME F-Main /* Desde Legajo Nº */
OR "." OF v-cdg_d-empleado IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_d-empleado IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "D-Empleado" "nro_legajo" "SELEMPLE.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_d-empleado V-table-Win
ON RETURN OF v-cdg_d-empleado IN FRAME F-Main /* Desde Legajo Nº */
DO:
  {traducetabla.i "D-Empleado" "nro_legajo" "nombre"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_h-empleado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_h-empleado V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_h-empleado IN FRAME F-Main /* Hasta Legajo Nº */
OR "." OF v-cdg_h-empleado IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_h-empleado IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "H-Empleado" "nro_legajo" "SELEMPLE.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_h-empleado V-table-Win
ON RETURN OF v-cdg_h-empleado IN FRAME F-Main /* Hasta Legajo Nº */
DO:
  {traducetabla.i "H-Empleado" "nro_legajo" "nombre"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_tipo_de_liquidac
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_tipo_de_liquidac V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_tipo_de_liquidac IN FRAME F-Main /* Tipo Liquidación */
OR "." OF v-cdg_tipo_de_liquidac IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_tipo_de_liquidac IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "Tipo_de_liquidac" "cdg_liquid" "SELTIPLQ.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_tipo_de_liquidac V-table-Win
ON RETURN OF v-cdg_tipo_de_liquidac IN FRAME F-Main /* Tipo Liquidación */
DO:
  {traducetabla.i "Tipo_de_liquidac" "cdg_liquid" "descripcion"} 
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
  {src/adm/template/row-list.i "Rango_liquidacion"}
  {src/adm/template/row-list.i "Liquidacion"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Rango_liquidacion"}
  {src/adm/template/row-find.i "Liquidacion"}

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

  {blanqueacodigo.i "D-Empleado"}
  {blanqueacodigo.i "H-Empleado"}
  {blanqueacodigo.i "Tipo_de_liquidac"}

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

   &SCOPED-DEFINE TABLA-MAESTRA  Rango_liquidacion

   {validartabla.i "D-Empleado" "nro_legajo" "nombre" "CLIE008"} 
   {validartabla.i "H-Empleado" "nro_legajo" "nombre" "CLIE008"} 
   {validartabla.i "Tipo_de_liquidac" "cdg_liquid" "descripcion" "CLIE008"} 
   

   &UNDEFINE TABLA-MAESTRA

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   &SCOPED-DEFINE TABLA-MAESTRA  Rango_liquidacion

   {asignartabla.i "D-Empleado" "nro_legajo" "desde_legajo"}
   {asignartabla.i "H-Empleado" "nro_legajo" "hasta_legajo"}
   {asignartabla.i "Tipo_de_liquidac" "cdg_liquid" "cdg_liquid"}

   &UNDEFINE TABLA-MAESTRA
   
  Rango_liquidacion.sec_liquidacion = Liquidacion.sec_liquidacion.

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

  {deshabcodigo.i "D-Empleado"}
  {deshabcodigo.i "H-Empleado"}
  {deshabcodigo.i "Tipo_de_liquidac"}

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

  IF AVAILABLE Rango_liquidacion
  THEN DO:

        &SCOPED-DEFINE TABLA-MAESTRA  Rango_liquidacion
     
        {displaytabla.i "D-Empleado" "nro_legajo" "nombre" "nro_legajo" "desde_legajo"} 
        {displaytabla.i "H-Empleado" "nro_legajo" "nombre" "nro_legajo" "hasta_legajo"} 

        {displaytabla.i "Tipo_de_liquidac" "cdg_liquid" "descripcion" "cdg_liquid" "cdg_liquid"} 

        &UNDEFINE TABLA-MAESTRA

  END.
  ELSE DO:
      {blanqueacodigo.i "D-Empleado"}
      {blanqueacodigo.i "H-Empleado"}
      {blanqueacodigo.i "Tipo_de_liquidac"}
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

  {habilcodigo.i "D-Empleado"}
  {habilcodigo.i "H-Empleado"}
  {habilcodigo.i "Tipo_de_liquidac"}

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
  {src/adm/template/sndkycas.i "sec_liquidacion" "Rango_liquidacion" "sec_liquidacion"}
  {src/adm/template/sndkycas.i "cdg_liquid" "Rango_liquidacion" "cdg_liquid"}

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
  {src/adm/template/snd-list.i "Rango_liquidacion"}
  {src/adm/template/snd-list.i "Liquidacion"}

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

