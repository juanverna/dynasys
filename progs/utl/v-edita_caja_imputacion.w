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
&Scoped-define EXTERNAL-TABLES Caja-imputacion Caj_header
&Scoped-define FIRST-EXTERNAL-TABLE Caja-imputacion


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Caja-imputacion, Caj_header.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Caja-imputacion.valor ~
Caja-imputacion.observacion 
&Scoped-define ENABLED-TABLES Caja-imputacion
&Scoped-define FIRST-ENABLED-TABLE Caja-imputacion
&Scoped-Define ENABLED-OBJECTS RECT-14 
&Scoped-Define DISPLAYED-FIELDS Caja-imputacion.valor ~
Caja-imputacion.observacion 
&Scoped-define DISPLAYED-TABLES Caja-imputacion
&Scoped-define FIRST-DISPLAYED-TABLE Caja-imputacion
&Scoped-Define DISPLAYED-OBJECTS v-cdg_cuenta v-dsc_cuenta v-cdg_entidad ~
v-dsc_entidad v-cdg_obra v-dsc_obra 

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
nro_transaccion|y|y|sic.Caja-imputacion.nro_transaccion
nro_cuenta||y|sic.Caja-imputacion.nro_cuenta
nro_entidad||y|sic.Caja-imputacion.nro_entidad
nro_obra||y|sic.Caja-imputacion.nro_obra
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = "nro_transaccion",
     Keys-Supplied = "nro_transaccion,nro_cuenta,nro_entidad,nro_obra"':U).
/**************************
</EXECUTING-CODE> */
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE VARIABLE v-cdg_cuenta AS CHARACTER FORMAT "X(256)":U 
     LABEL "Cuenta" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 20 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cdg_entidad AS CHARACTER FORMAT "X(256)":U 
     LABEL "Entidad" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 20 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cdg_obra AS CHARACTER FORMAT "X(256)":U 
     LABEL "Obra" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 20 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-dsc_cuenta AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 83 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_entidad AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 83 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_obra AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 83 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-14
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 118 BY 5.24.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     v-cdg_cuenta AT ROW 1.24 COL 11 COLON-ALIGNED
     v-dsc_cuenta AT ROW 1.24 COL 32 COLON-ALIGNED NO-LABEL
     v-cdg_entidad AT ROW 2.43 COL 11 COLON-ALIGNED
     v-dsc_entidad AT ROW 2.43 COL 32 COLON-ALIGNED NO-LABEL
     v-cdg_obra AT ROW 3.62 COL 11 COLON-ALIGNED
     v-dsc_obra AT ROW 3.62 COL 32 COLON-ALIGNED NO-LABEL
     Caja-imputacion.valor AT ROW 4.81 COL 11 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 20 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Caja-imputacion.observacion AT ROW 4.81 COL 47 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 68 BY 1
          BGCOLOR 15 FGCOLOR 9 
     RECT-14 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Caja-imputacion,sic.Caj_header
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
         HEIGHT             = 8.24
         WIDTH              = 121.4.
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

/* SETTINGS FOR FILL-IN v-cdg_cuenta IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_entidad IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_obra IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_cuenta IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_entidad IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_obra IN FRAME F-Main
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
ON MOUSE-SELECT-DBLCLICK OF v-cdg_cuenta IN FRAME F-Main /* Cuenta */
OR "." OF v-cdg_cuenta IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_cuenta IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Cuenta" "cdg_cuenta" "SELCUENT.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_cuenta V-table-Win
ON RETURN OF v-cdg_cuenta IN FRAME F-Main /* Cuenta */
DO:
    {traducetabla.i "cuenta" "cdg_cuenta" "nombre"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_entidad
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_entidad V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_entidad IN FRAME F-Main /* Entidad */
OR "." OF v-cdg_entidad IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_entidad IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Entidad" "cdg_entidad" "SELENTID.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_entidad V-table-Win
ON RETURN OF v-cdg_entidad IN FRAME F-Main /* Entidad */
DO:
    {traducetabla.i "Entidad" "cdg_entidad" "dsc_entidad"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_obra
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_obra V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_obra IN FRAME F-Main /* Obra */
OR "." OF v-cdg_obra IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_obra IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Obra" "cdg_obra" "SELOBRGL.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_obra V-table-Win
ON RETURN OF v-cdg_obra IN FRAME F-Main /* Obra */
DO:
    {traducetabla.i "Obra" "cdg_obra" "dsc_obra"} 
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
  DEF VAR key-value AS CHAR NO-UNDO.
  DEF VAR row-avail-enabled AS LOGICAL NO-UNDO.

  /* LOCK status on the find depends on FIELDS-ENABLED. */
  RUN get-attribute ('FIELDS-ENABLED':U).
  row-avail-enabled = (RETURN-VALUE eq 'yes':U).
  /* Look up the current key-value. */
  RUN get-attribute ('Key-Value':U).
  key-value = RETURN-VALUE.

  /* Find the current record using the current Key-Name. */
  RUN get-attribute ('Key-Name':U).
  CASE RETURN-VALUE:
    WHEN 'nro_transaccion':U THEN
       {src/adm/template/find-tbl.i
           &TABLE = Caja-imputacion
           &WHERE = "WHERE Caja-imputacion.nro_transaccion eq INTEGER(key-value)"
       }
  END CASE.

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
  {src/adm/template/row-list.i "Caja-imputacion"}
  {src/adm/template/row-list.i "Caj_header"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Caja-imputacion"}
  {src/adm/template/row-find.i "Caj_header"}

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

  {blanqueacodigo.i "Cuenta"}
  {blanqueacodigo.i "Entidad"}
  {blanqueacodigo.i "Obra"}


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

   &SCOPED-DEFINE TABLA-MAESTRA  Caja-imputacion

   {validartabla_if.i "Cuenta" "cdg_Cuenta" "nombre_cta" "CLIE010"}
   {validartabla_if.i "Entidad" "cdg_entidad" "dsc_entidad" "CLIE010"}
   {validartabla_if.i "Obra" "cdg_obra" "dsc_obra" "CLIE010"}         

   &UNDEFINE TABLA-MAESTRA

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   &SCOPED-DEFINE TABLA-MAESTRA  Caja-imputacion

   {asignartabla_if.i "Cuenta" "nro_cuenta" "nro_cuenta"} 
   {asignartabla_if.i "Entidad" "nro_entidad" "nro_entidad"} 
   {asignartabla_if.i "Obra" "nro_obra" "nro_obra"} 

   &UNDEFINE TABLA-MAESTRA

   Caja-imputacion.nro_transaccion = Caj_header.nro_transaccion.

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
  {deshabcodigo.i "Entidad"}
  {deshabcodigo.i "Obra"}



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

  IF AVAILABLE Caja-imputacion
  THEN DO:

        &SCOPED-DEFINE TABLA-MAESTRA  Caja-imputacion
     
        {displaytabla.i "Cuenta" "cdg_cuenta" "nombre_cta" "nro_cuenta" "nro_cuenta"} 
        {displaytabla.i "Entidad" "cdg_entidad" "dsc_entidad" "nro_entidad" "nro_entidad"} 
        {displaytabla.i "Obra" "cdg_obra" "dsc_obra" "nro_obra" "nro_obra"} 

        &UNDEFINE TABLA-MAESTRA
        

  END.
  ELSE DO:

      {blanqueacodigo.i "Cuenta"}
      {blanqueacodigo.i "Entidad"}
      {blanqueacodigo.i "Obra"}

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
  {habilcodigo.i "Entidad"}
  {habilcodigo.i "Obra"}


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
  {src/adm/template/sndkycas.i "nro_transaccion" "Caja-imputacion" "nro_transaccion"}
  {src/adm/template/sndkycas.i "nro_cuenta" "Caja-imputacion" "nro_cuenta"}
  {src/adm/template/sndkycas.i "nro_entidad" "Caja-imputacion" "nro_entidad"}
  {src/adm/template/sndkycas.i "nro_obra" "Caja-imputacion" "nro_obra"}

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
  {src/adm/template/snd-list.i "Caja-imputacion"}
  {src/adm/template/snd-list.i "Caj_header"}

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

