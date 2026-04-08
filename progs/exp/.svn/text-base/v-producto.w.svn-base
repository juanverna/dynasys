&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
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

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartViewer

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME F-Main

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES Producto
&Scoped-define FIRST-EXTERNAL-TABLE Producto


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Producto.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Producto.cdg_producto Producto.nombre ~
Producto.cdg_empresa Producto.nro_cuenta_prod Producto.nro_cuenta_coms ~
Producto.cdg_linea Producto.nro_cuenta_reem Producto.nro_cuenta_flet ~
Producto.nro_articulo_flete 
&Scoped-define FIELD-PAIRS~
 ~{&FP1}cdg_producto ~{&FP2}cdg_producto ~{&FP3}~
 ~{&FP1}nombre ~{&FP2}nombre ~{&FP3}~
 ~{&FP1}cdg_empresa ~{&FP2}cdg_empresa ~{&FP3}~
 ~{&FP1}nro_cuenta_prod ~{&FP2}nro_cuenta_prod ~{&FP3}~
 ~{&FP1}nro_cuenta_coms ~{&FP2}nro_cuenta_coms ~{&FP3}~
 ~{&FP1}cdg_linea ~{&FP2}cdg_linea ~{&FP3}~
 ~{&FP1}nro_cuenta_reem ~{&FP2}nro_cuenta_reem ~{&FP3}~
 ~{&FP1}nro_cuenta_flet ~{&FP2}nro_cuenta_flet ~{&FP3}~
 ~{&FP1}nro_articulo_flete ~{&FP2}nro_articulo_flete ~{&FP3}
&Scoped-define ENABLED-TABLES Producto
&Scoped-define FIRST-ENABLED-TABLE Producto
&Scoped-Define ENABLED-OBJECTS RECT-9 
&Scoped-Define DISPLAYED-FIELDS Producto.cdg_producto Producto.nombre ~
Producto.cdg_empresa Producto.nro_cuenta_prod Producto.nro_cuenta_coms ~
Producto.cdg_linea Producto.nro_cuenta_reem Producto.nro_cuenta_flet ~
Producto.nro_articulo_flete 

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
DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 64 BY 5.12.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Producto.cdg_producto AT ROW 1.54 COL 10 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 7 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Producto.nombre AT ROW 1.54 COL 29 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 33 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Producto.cdg_empresa AT ROW 2.62 COL 10 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 7 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Producto.nro_cuenta_prod AT ROW 2.62 COL 29 COLON-ALIGNED
          LABEL "Producción"
          VIEW-AS FILL-IN NATIVE 
          SIZE 12 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Producto.nro_cuenta_coms AT ROW 2.62 COL 50 COLON-ALIGNED
          LABEL "Comisión"
          VIEW-AS FILL-IN NATIVE 
          SIZE 12 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Producto.cdg_linea AT ROW 3.69 COL 10 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 7 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Producto.nro_cuenta_reem AT ROW 3.69 COL 29 COLON-ALIGNED
          LABEL "Reembolso"
          VIEW-AS FILL-IN NATIVE 
          SIZE 12 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Producto.nro_cuenta_flet AT ROW 4.77 COL 10 COLON-ALIGNED
          LABEL "Flete"
          VIEW-AS FILL-IN NATIVE 
          SIZE 7 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Producto.nro_articulo_flete AT ROW 4.77 COL 29 COLON-ALIGNED
          LABEL "Art. Flete"
          VIEW-AS FILL-IN NATIVE 
          SIZE 12 BY .81
          BGCOLOR 15 FGCOLOR 9 
     RECT-9 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Producto
   Allow: Basic,DB-Fields
   Frames: 1
   Add Fields to: EXTERNAL-TABLES
   Other Settings: PERSISTENT-ONLY COMPILE
 */

/* This procedure should always be RUN PERSISTENT.  Report the error,  */
/* then cleanup and return.                                            */
IF NOT THIS-PROCEDURE:PERSISTENT THEN DO:
  MESSAGE "{&FILE-NAME} should only be RUN PERSISTENT."
          VIEW-AS ALERT-BOX ERROR BUTTONS OK.
  RETURN.
END.

&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
/* DESIGN Window definition (used by the UIB) 
  CREATE WINDOW V-table-Win ASSIGN
         HEIGHT             = 10.54
         WIDTH              = 68.14.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME


/* ***************  Runtime Attributes and UIB Settings  ************** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW V-table-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME F-Main
   NOT-VISIBLE Size-to-Fit                                              */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN Producto.nro_articulo_flete IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Producto.nro_cuenta_coms IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Producto.nro_cuenta_flet IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Producto.nro_cuenta_prod IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Producto.nro_cuenta_reem IN FRAME F-Main
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

 


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB V-table-Win 
/* ************************* Included-Libraries *********************** */

{src/adm/method/viewer.i}

/* _UIB-CODE-BLOCK-END */
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available V-table-Win _ADM-ROW-AVAILABLE
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
  {src/adm/template/row-list.i "Producto"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Producto"}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI V-table-Win _DEFAULT-DISABLE
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records V-table-Win _ADM-SEND-RECORDS
PROCEDURE send-records :
/*------------------------------------------------------------------------------
  Purpose:     Send record ROWID's for all tables used by
               this file.
  Parameters:  see template/snd-head.i
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.               */
  {src/adm/template/snd-head.i}

  /* For each requested table, put it's ROWID in the output list.      */
  {src/adm/template/snd-list.i "Producto"}

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


