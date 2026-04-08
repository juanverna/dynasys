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
&Scoped-define EXTERNAL-TABLES Familia_cliente
&Scoped-define FIRST-EXTERNAL-TABLE Familia_cliente


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Familia_cliente.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Familia_cliente.dsc_famclie ~
Familia_cliente.lista_empresas 
&Scoped-define ENABLED-TABLES Familia_cliente
&Scoped-define FIRST-ENABLED-TABLE Familia_cliente
&Scoped-Define ENABLED-OBJECTS RECT-7 
&Scoped-Define DISPLAYED-FIELDS Familia_cliente.cdg_famclie ~
Familia_cliente.dsc_famclie Familia_cliente.lista_empresas 
&Scoped-define DISPLAYED-TABLES Familia_cliente
&Scoped-define FIRST-DISPLAYED-TABLE Familia_cliente
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
DEFINE BUTTON btn_elegir 
     LABEL "E&legir" 
     SIZE 10 BY 1.

DEFINE VARIABLE v-cdg_cuenta AS CHARACTER FORMAT "X(8)" 
     LABEL "Imputación Deudas" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 11 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-dsc_cuenta AS CHARACTER FORMAT "X(35)" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 51 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 4 GRAPHIC-EDGE  NO-FILL 
     SIZE 90 BY 5.71.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Familia_cliente.cdg_famclie AT ROW 1.48 COL 22 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 11 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Familia_cliente.dsc_famclie AT ROW 2.67 COL 22 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 63 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_cuenta AT ROW 3.86 COL 22 COLON-ALIGNED
     v-dsc_cuenta AT ROW 3.91 COL 34 COLON-ALIGNED HELP
          "Denominacion" NO-LABEL
     Familia_cliente.lista_empresas AT ROW 5.05 COL 22 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 50 BY 1
          BGCOLOR 15 FGCOLOR 9 
     btn_elegir AT ROW 5.05 COL 77
     RECT-7 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Familia_cliente
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
         WIDTH              = 96.6.
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

/* SETTINGS FOR BUTTON btn_elegir IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Familia_cliente.cdg_famclie IN FRAME F-Main
   NO-ENABLE                                                            */
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

&Scoped-define SELF-NAME btn_elegir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_elegir V-table-Win
ON CHOOSE OF btn_elegir IN FRAME F-Main /* Elegir */
DO:
  DEFINE VARIABLE v-lista_empresas LIKE Cliente.lista_empresas.
  v-lista_empresas = Familia_cliente.lista_empresas:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
  RUN selcodempresa.p ( INPUT-OUTPUT v-lista_empresas ).
  Familia_cliente.lista_empresas:SCREEN-VALUE IN FRAME {&FRAME-NAME} = v-lista_empresas.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_cuenta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_cuenta V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_cuenta IN FRAME F-Main /* Imputación Deudas */
OR "." OF v-cdg_cuenta IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_cuenta IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Cuenta" "cdg_cuenta" "SELCUENT.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_cuenta V-table-Win
ON RETURN OF v-cdg_cuenta IN FRAME F-Main /* Imputación Deudas */
DO:
   {traducetabla.i "cuenta" "cdg_cuenta" "nombre_cta"} 
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
  {src/adm/template/row-list.i "Familia_cliente"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Familia_cliente"}

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

  Familia_cliente.cdg_famclie:SENSITIVE IN FRAME {&FRAME-NAME} = YES.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'add-record':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   {blanqueacodigo.i "cuenta"}
   


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

    DEFINE BUFFER B-Familia_cliente FOR Familia_cliente.
        
    IF CAN-FIND(FIRST B-Familia_cliente 
                       WHERE B-Familia_cliente.cdg_famclie = 
                           INPUT FRAME {&FRAME-NAME} Familia_cliente.cdg_famclie  
                        AND ROWID(B-Familia_cliente) <> ROWID(Familia_cliente) )
    THEN DO:
         RUN PONMENSJ.P (INPUT "FCLI001").
         RETURN ERROR.
    END.            

    IF INPUT FRAME {&FRAME-NAME} Familia_cliente.cdg_famclie = ""   
    THEN DO:
         RUN PONMENSJ.P (INPUT "FCLI002").
         RETURN ERROR.
    END.      

    IF INPUT FRAME {&FRAME-NAME} Familia_cliente.dsc_famclie = ""   
    THEN DO:
         RUN PONMENSJ.P (INPUT "FCLI003").
         RETURN ERROR.
    END.

   &SCOPED-DEFINE TABLA-MAESTRA  Familia_cliente

   {validartabla.i "cuenta" "cdg_cuenta" "nombre_cta" "FCLI004"} 
   

   &UNDEFINE TABLA-MAESTRA

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   &SCOPED-DEFINE TABLA-MAESTRA  Familia_cliente

   {asignartabla.i "cuenta" "nro_cuenta" "nro_cuenta"}
   

   &UNDEFINE TABLA-MAESTRA

   ASSIGN FRAME {&FRAME-NAME} Familia_cliente.cdg_famclie.

   Familia_cliente.cdg_famclie:SENSITIVE IN FRAME {&FRAME-NAME} = NO.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-cancel-record V-table-Win 
PROCEDURE local-cancel-record :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  Familia_cliente.cdg_famclie:SENSITIVE IN FRAME {&FRAME-NAME} = NO.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'cancel-record':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

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

  Familia_cliente.cdg_famclie:SENSITIVE IN FRAME {&FRAME-NAME} = YES.

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
   RUN vlb-familia-clientes.p ( INPUT ROWID(Familia_cliente), OUTPUT baja_no ).
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

   {deshabcodigo.i "cuenta"}
    


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

  IF AVAILABLE Familia_cliente
  THEN DO:

        &SCOPED-DEFINE TABLA-MAESTRA  Familia_cliente
     
        {displaytabla.i "cuenta" "cdg_cuenta" "nombre_cta" "nro_cuenta" "nro_cuenta"}

        &UNDEFINE TABLA-MAESTRA

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

   {habilcodigo.i "cuenta"}
 

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
  {src/adm/template/snd-list.i "Familia_cliente"}

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

