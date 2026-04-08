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
&Scoped-define EXTERNAL-TABLES Caj_detalle Caj_header
&Scoped-define FIRST-EXTERNAL-TABLE Caj_detalle


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Caj_detalle, Caj_header.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Caj_detalle.importe Caj_detalle.divisas ~
Caj_detalle.cambio Caj_detalle.nro_cheque Caj_detalle.nro_valor ~
Caj_detalle.cdg_cuenta_ban Caj_detalle.nro_linea Caj_detalle.observacion 
&Scoped-define ENABLED-TABLES Caj_detalle
&Scoped-define FIRST-ENABLED-TABLE Caj_detalle
&Scoped-Define ENABLED-OBJECTS RECT-13 
&Scoped-Define DISPLAYED-FIELDS Caj_detalle.importe Caj_detalle.divisas ~
Caj_detalle.cambio Caj_detalle.nro_cheque Caj_detalle.nro_valor ~
Caj_detalle.cdg_cuenta_ban Caj_detalle.nro_linea Caj_detalle.observacion 
&Scoped-define DISPLAYED-TABLES Caj_detalle
&Scoped-define FIRST-DISPLAYED-TABLE Caj_detalle
&Scoped-Define DISPLAYED-OBJECTS v-cdg_rubro v-dsc_rubro v-cdg_entidad ~
v-dsc_entidad 

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
cdg_rubro|y|y|sic.Caj_detalle.cdg_rubro
nro_transaccion||y|sic.Caj_detalle.nro_transaccion
nro_cheque||y|sic.Caj_detalle.nro_cheque
cdg_cuenta_ban||y|sic.Caj_detalle.cdg_cuenta_ban
nro_entidad||y|sic.Caj_detalle.nro_entidad
nro_valor||y|sic.Caj_detalle.nro_valor
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = "cdg_rubro",
     Keys-Supplied = "cdg_rubro,nro_transaccion,nro_cheque,cdg_cuenta_ban,nro_entidad,nro_valor"':U).
/**************************
</EXECUTING-CODE> */
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE VARIABLE v-cdg_entidad AS CHARACTER FORMAT "X(256)":U 
     LABEL "Entidad" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 20 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cdg_rubro AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Rubro" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 20 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-dsc_entidad AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 62 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_rubro AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 62 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-13
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 101 BY 8.1.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     v-cdg_rubro AT ROW 1.48 COL 15 COLON-ALIGNED
     v-dsc_rubro AT ROW 1.48 COL 36 COLON-ALIGNED NO-LABEL
     v-cdg_entidad AT ROW 2.67 COL 15 COLON-ALIGNED
     v-dsc_entidad AT ROW 2.67 COL 36 COLON-ALIGNED NO-LABEL
     Caj_detalle.importe AT ROW 3.86 COL 15 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 20 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Caj_detalle.divisas AT ROW 3.86 COL 46 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 20 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Caj_detalle.cambio AT ROW 3.86 COL 78 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 20 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Caj_detalle.nro_cheque AT ROW 5.05 COL 15 COLON-ALIGNED
          LABEL "Nro. Cheque"
          VIEW-AS FILL-IN NATIVE 
          SIZE 20 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Caj_detalle.nro_valor AT ROW 5.05 COL 78 COLON-ALIGNED
          LABEL "Nro.Valor"
          VIEW-AS FILL-IN NATIVE 
          SIZE 20 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Caj_detalle.cdg_cuenta_ban AT ROW 6.24 COL 15 COLON-ALIGNED
          LABEL "Cta.Bria."
          VIEW-AS FILL-IN NATIVE 
          SIZE 20 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Caj_detalle.nro_linea AT ROW 6.24 COL 78 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 20 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Caj_detalle.observacion AT ROW 7.43 COL 15 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 83 BY 1
          BGCOLOR 15 FGCOLOR 9 
     RECT-13 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Caj_detalle,sic.Caj_header
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
         HEIGHT             = 8.48
         WIDTH              = 104.
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

/* SETTINGS FOR FILL-IN Caj_detalle.cdg_cuenta_ban IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Caj_detalle.nro_cheque IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Caj_detalle.nro_valor IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN v-cdg_entidad IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_rubro IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_entidad IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_rubro IN FRAME F-Main
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


&Scoped-define SELF-NAME v-cdg_rubro
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_rubro V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_rubro IN FRAME F-Main /* Rubro */
OR "." OF v-cdg_rubro IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_rubro IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "rubro" "cdg_rubro" "SELRUBRO.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_rubro V-table-Win
ON RETURN OF v-cdg_rubro IN FRAME F-Main /* Rubro */
DO:
    {traducetabla.i "rubro" "cdg_rubro" "nombre"} 
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
    WHEN 'cdg_rubro':U THEN
       {src/adm/template/find-tbl.i
           &TABLE = Caj_detalle
           &WHERE = "WHERE Caj_detalle.cdg_rubro eq INTEGER(key-value)"
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
  {src/adm/template/row-list.i "Caj_detalle"}
  {src/adm/template/row-list.i "Caj_header"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Caj_detalle"}
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

  {blanqueacodigo.i "Rubro"}
  {blanqueacodigo.i "Entidad"}

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

   &SCOPED-DEFINE TABLA-MAESTRA  Caj_detalle

   {validartabla.i "Rubro" "cdg_rubro" "nombre" "CLIE008"} 
   {validartabla.i "Entidad" "cdg_entidad" "dsc_entidad" "CLIE010"}

   &UNDEFINE TABLA-MAESTRA

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   &SCOPED-DEFINE TABLA-MAESTRA  Caj_detalle

   {asignartabla.i "Rubro" "cdg_rubro" "cdg_rubro"}
   {asignartabla.i "Entidad" "nro_entidad" "nro_entidad"} 

   &UNDEFINE TABLA-MAESTRA
   
  /* Code placed here will execute AFTER standard behavior.    */

  Caj_detalle.nro_transaccion = Caj_header.nro_transaccion.

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

  {deshabcodigo.i "Rubro"}
  {deshabcodigo.i "Entidad"}

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

  IF AVAILABLE Caj_detalle
  THEN DO:

        &SCOPED-DEFINE TABLA-MAESTRA  Caj_detalle
     
        {displaytabla.i "Rubro" "cdg_rubro" "nombre" "cdg_rubro" "cdg_rubro"} 
        {displaytabla.i "Entidad" "cdg_entidad" "dsc_entidad" "nro_entidad" "nro_entidad"} 

        &UNDEFINE TABLA-MAESTRA
        

  END.
  ELSE DO:

      {blanqueacodigo.i "Rubro"}
      {blanqueacodigo.i "Entidad"}

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

  {habilcodigo.i "Rubro"}
  {habilcodigo.i "Entidad"}

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
  {src/adm/template/sndkycas.i "cdg_rubro" "Caj_detalle" "cdg_rubro"}
  {src/adm/template/sndkycas.i "nro_transaccion" "Caj_detalle" "nro_transaccion"}
  {src/adm/template/sndkycas.i "nro_cheque" "Caj_detalle" "nro_cheque"}
  {src/adm/template/sndkycas.i "cdg_cuenta_ban" "Caj_detalle" "cdg_cuenta_ban"}
  {src/adm/template/sndkycas.i "nro_entidad" "Caj_detalle" "nro_entidad"}
  {src/adm/template/sndkycas.i "nro_valor" "Caj_detalle" "nro_valor"}

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
  {src/adm/template/snd-list.i "Caj_detalle"}
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

