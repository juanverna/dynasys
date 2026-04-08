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
&Scoped-define EXTERNAL-TABLES Cliente
&Scoped-define FIRST-EXTERNAL-TABLE Cliente


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Cliente.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Cliente.cdg_cliente Cliente.nom_cliente 
&Scoped-define ENABLED-TABLES Cliente
&Scoped-define FIRST-ENABLED-TABLE Cliente
&Scoped-Define ENABLED-OBJECTS RECT-9 
&Scoped-Define DISPLAYED-FIELDS Cliente.cdg_cliente Cliente.nom_cliente 
&Scoped-define DISPLAYED-TABLES Cliente
&Scoped-define FIRST-DISPLAYED-TABLE Cliente


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
cdg_cliente|y|y|sic.Cliente.cdg_cliente
nro_cliente|y|y|sic.Cliente.nro_cliente
nro_cobrador||y|sic.Cliente.nro_cobrador
cdg_condiva||y|sic.Cliente.cdg_condiva
cdg_condibr||y|sic.Cliente.cdg_condibr
cdg_postal||y|sic.Cliente.cdg_postal
nro_entidad||y|sic.Cliente.nro_entidad
cdg_estado||y|sic.Cliente.cdg_estado
cdg_famclie||y|sic.Cliente.cdg_famclie
cdg_grupoemp||y|sic.Cliente.cdg_grupoemp
cdg_pais||y|sic.Cliente.cdg_pais
nro_proveedor||y|sic.Cliente.nro_proveedor
cdg_provincia||y|sic.Cliente.cdg_provincia
num_sucursal||y|sic.Cliente.num_sucursal
cdg_tipoclie||y|sic.Cliente.cdg_tipoclie
nro_usuario||y|sic.Cliente.nro_usuario
nro_vendedor||y|sic.Cliente.nro_vendedor
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = "cdg_cliente,nro_cliente",
     Keys-Supplied = "cdg_cliente,nro_cliente,nro_cobrador,cdg_condiva,cdg_condibr,cdg_postal,nro_entidad,cdg_estado,cdg_famclie,cdg_grupoemp,cdg_pais,nro_proveedor,cdg_provincia,num_sucursal,cdg_tipoclie,nro_usuario,nro_vendedor"':U).
/**************************
</EXECUTING-CODE> */
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Menu Definitions                                                     */
DEFINE MENU POPUP-MENU-cdg_cliente 
       MENU-ITEM m_Consorcio    LABEL "Consorcio"     .


/* Definitions of the field level widgets                               */
DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 123 BY 1.67.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Cliente.cdg_cliente AT ROW 1.24 COL 16 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 13.6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.nom_cliente AT ROW 1.24 COL 56 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 42 BY 1
          BGCOLOR 15 FGCOLOR 9 
     RECT-9 AT ROW 1 COL 1
     "Administ.:" VIEW-AS TEXT
          SIZE 11 BY .62 AT ROW 1.48 COL 6
     "Nombre:" VIEW-AS TEXT
          SIZE 9 BY .62 AT ROW 1.48 COL 48
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Cliente
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
         HEIGHT             = 4.81
         WIDTH              = 129.2.
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
       Cliente.cdg_cliente:POPUP-MENU IN FRAME F-Main       = MENU POPUP-MENU-cdg_cliente:HANDLE.

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
    WHEN 'cdg_cliente':U THEN
       {src/adm/template/find-tbl.i
           &TABLE = Cliente
           &WHERE = "WHERE Cliente.cdg_cliente eq key-value"
       }
    WHEN 'nro_cliente':U THEN
       {src/adm/template/find-tbl.i
           &TABLE = Cliente
           &WHERE = "WHERE Cliente.nro_cliente eq INTEGER(key-value)"
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
  {src/adm/template/row-list.i "Cliente"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Cliente"}

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
  {src/adm/template/sndkycas.i "cdg_cliente" "Cliente" "cdg_cliente"}
  {src/adm/template/sndkycas.i "nro_cliente" "Cliente" "nro_cliente"}
  {src/adm/template/sndkycas.i "nro_cobrador" "Cliente" "nro_cobrador"}
  {src/adm/template/sndkycas.i "cdg_condiva" "Cliente" "cdg_condiva"}
  {src/adm/template/sndkycas.i "cdg_condibr" "Cliente" "cdg_condibr"}
  {src/adm/template/sndkycas.i "cdg_postal" "Cliente" "cdg_postal"}
  {src/adm/template/sndkycas.i "nro_entidad" "Cliente" "nro_entidad"}
  {src/adm/template/sndkycas.i "cdg_estado" "Cliente" "cdg_estado"}
  {src/adm/template/sndkycas.i "cdg_famclie" "Cliente" "cdg_famclie"}
  {src/adm/template/sndkycas.i "cdg_grupoemp" "Cliente" "cdg_grupoemp"}
  {src/adm/template/sndkycas.i "cdg_pais" "Cliente" "cdg_pais"}
  {src/adm/template/sndkycas.i "nro_proveedor" "Cliente" "nro_proveedor"}
  {src/adm/template/sndkycas.i "cdg_provincia" "Cliente" "cdg_provincia"}
  {src/adm/template/sndkycas.i "num_sucursal" "Cliente" "num_sucursal"}
  {src/adm/template/sndkycas.i "cdg_tipoclie" "Cliente" "cdg_tipoclie"}
  {src/adm/template/sndkycas.i "nro_usuario" "Cliente" "nro_usuario"}
  {src/adm/template/sndkycas.i "nro_vendedor" "Cliente" "nro_vendedor"}

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
  {src/adm/template/snd-list.i "Cliente"}

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

