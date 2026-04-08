&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS B-table-Win 
/*------------------------------------------------------------------------

  File:  

  Description: from BROWSER.W - Basic SmartBrowser Object Template

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

DEFINE VARIABLE que_empresa LIKE Empresa.cdg_empresa.
DEFINE VARIABLE que_area    LIKE Area.nro_area.

DEFINE VARIABLE sino       AS LOGICAL.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartBrowser
&Scoped-define DB-AWARE no

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME F-Main
&Scoped-define BROWSE-NAME br_table

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Ingresoaplanta Sre_header Rem_header_prv ~
Proveedor

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Ingresoaplanta.num_ingreso ~
Sre_header.prf_comprob Sre_header.nro_comprob Sre_header.nro_ocompra ~
Rem_header_prv.tip_comprob Rem_header_prv.prf_comprob ~
Rem_header_prv.nro_comprob Proveedor.cdg_proveedor Proveedor.nombre 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table 
&Scoped-define QUERY-STRING-br_table FOR EACH Ingresoaplanta WHERE ~{&KEY-PHRASE} ~
      AND Ingresoaplanta.cdg_estado = "IN" NO-LOCK, ~
      EACH Sre_header OF Ingresoaplanta ~
      WHERE Sre_header.nro_area = que_area ~
 AND Sre_header.cdg_empresa = que_empresa NO-LOCK, ~
      EACH Rem_header_prv OF Ingresoaplanta NO-LOCK, ~
      EACH Proveedor OF Rem_header_prv NO-LOCK ~
    ~{&SORTBY-PHRASE}
&Scoped-define OPEN-QUERY-br_table OPEN QUERY br_table FOR EACH Ingresoaplanta WHERE ~{&KEY-PHRASE} ~
      AND Ingresoaplanta.cdg_estado = "IN" NO-LOCK, ~
      EACH Sre_header OF Ingresoaplanta ~
      WHERE Sre_header.nro_area = que_area ~
 AND Sre_header.cdg_empresa = que_empresa NO-LOCK, ~
      EACH Rem_header_prv OF Ingresoaplanta NO-LOCK, ~
      EACH Proveedor OF Rem_header_prv NO-LOCK ~
    ~{&SORTBY-PHRASE}.
&Scoped-define TABLES-IN-QUERY-br_table Ingresoaplanta Sre_header ~
Rem_header_prv Proveedor
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Ingresoaplanta
&Scoped-define SECOND-TABLE-IN-QUERY-br_table Sre_header
&Scoped-define THIRD-TABLE-IN-QUERY-br_table Rem_header_prv
&Scoped-define FOURTH-TABLE-IN-QUERY-br_table Proveedor


/* Definitions for FRAME F-Main                                         */
&Scoped-define QUERY-STRING-F-Main FOR EACH Ingresoaplanta NO-LOCK
&Scoped-define OPEN-QUERY-F-Main OPEN QUERY F-Main FOR EACH Ingresoaplanta NO-LOCK.
&Scoped-define TABLES-IN-QUERY-F-Main Ingresoaplanta
&Scoped-define FIRST-TABLE-IN-QUERY-F-Main Ingresoaplanta


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS btn_aprobar btn_rechazar v-codigo br_table ~
RECT-3 
&Scoped-Define DISPLAYED-OBJECTS v-codigo 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _XFTR "Foreign Keys" B-table-Win _INLINE
/* Actions: ? adm/support/keyedit.w ? ? ? */
/* STRUCTURED-DATA
<KEY-OBJECT>
&BROWSE-NAME
</KEY-OBJECT>
<FOREIGN-KEYS>
cdg_motivoretiro||y|sic.Motivo_retiro.cdg_motivoretiro
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = ,
     Keys-Supplied = "cdg_motivoretiro"':U).

/* Tell the ADM to use the OPEN-QUERY-CASES. */
&Scoped-define OPEN-QUERY-CASES RUN dispatch ('open-query-cases':U).
/**************************
</EXECUTING-CODE> */
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _XFTR "Advanced Query Options" B-table-Win _INLINE
/* Actions: ? adm/support/advqedit.w ? ? ? */
/* STRUCTURED-DATA
<KEY-OBJECT>
&BROWSE-NAME
</KEY-OBJECT>
<SORTBY-OPTIONS>
</SORTBY-OPTIONS>
<SORTBY-RUN-CODE>
************************
* Set attributes related to SORTBY-OPTIONS */
RUN set-attribute-list (
    'SortBy-Options = ""':U).
/************************
</SORTBY-RUN-CODE>
<FILTER-ATTRIBUTES>
</FILTER-ATTRIBUTES> */   

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE BUTTON btn_aprobar 
     LABEL "&Conforme Descarga" 
     SIZE 24 BY 1.14.

DEFINE BUTTON btn_rechazar 
     LABEL "&Rechazar Descarga" 
     SIZE 24 BY 1.14.

DEFINE VARIABLE v-codigo AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN NATIVE 
     SIZE 15 BY 1
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 123 BY 9.52.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Ingresoaplanta, 
      Sre_header, 
      Rem_header_prv, 
      Proveedor SCROLLING.

DEFINE QUERY F-Main FOR 
      Ingresoaplanta SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _STRUCTURED
  QUERY br_table NO-LOCK DISPLAY
      Ingresoaplanta.num_ingreso FORMAT "->,>>>,>>9":U
      Sre_header.prf_comprob COLUMN-LABEL "Prefijo!Solicitud" FORMAT "9999":U
      Sre_header.nro_comprob COLUMN-LABEL "Número!Solicitud" FORMAT "ZZZZZZZ9":U
      Sre_header.nro_ocompra COLUMN-LABEL "Número!O/Compra" FORMAT "ZZZZZ9":U
      Rem_header_prv.tip_comprob COLUMN-LABEL "Tipo!Remito" FORMAT "X(3)":U
      Rem_header_prv.prf_comprob COLUMN-LABEL "Prefijo!Remito" FORMAT "9999":U
      Rem_header_prv.nro_comprob COLUMN-LABEL "Número!Remito" FORMAT "ZZZZZZZ9":U
      Proveedor.cdg_proveedor FORMAT "X(8)":U
      Proveedor.nombre FORMAT "X(40)":U WIDTH 38
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 119 BY 7.38
         BGCOLOR 11 FGCOLOR 9 
         TITLE BGCOLOR 11 FGCOLOR 9 "Ingresos a Planta Pendientes de Aprobar o Rechazar" EXPANDABLE.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     btn_aprobar AT ROW 1.24 COL 72
     btn_rechazar AT ROW 1.24 COL 98
     v-codigo AT ROW 1.29 COL 3 NO-LABEL
     br_table AT ROW 2.67 COL 3
     RECT-3 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartBrowser
   Allow: Basic,Browse
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
  CREATE WINDOW B-table-Win ASSIGN
         HEIGHT             = 9.86
         WIDTH              = 125.8.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB B-table-Win 
/* ************************* Included-Libraries *********************** */

{src/adm/method/browser.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW B-table-Win
  NOT-VISIBLE,,RUN-PERSISTENT                                           */
/* SETTINGS FOR FRAME F-Main
   NOT-VISIBLE Size-to-Fit                                              */
/* BROWSE-TAB br_table v-codigo F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN v-codigo IN FRAME F-Main
   ALIGN-L                                                              */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _TblList          = "sic.Ingresoaplanta,sic.Sre_header OF sic.Ingresoaplanta,sic.Rem_header_prv OF sic.Ingresoaplanta,sic.Proveedor OF sic.Rem_header_prv"
     _Options          = "NO-LOCK KEY-PHRASE SORTBY-PHRASE"
     _Where[1]         = "Ingresoaplanta.cdg_estado = ""IN"""
     _Where[2]         = "Sre_header.nro_area = que_area
 AND Sre_header.cdg_empresa = que_empresa"
     _FldNameList[1]   = sic.Ingresoaplanta.num_ingreso
     _FldNameList[2]   > sic.Sre_header.prf_comprob
"Sre_header.prf_comprob" "Prefijo!Solicitud" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[3]   > sic.Sre_header.nro_comprob
"Sre_header.nro_comprob" "Número!Solicitud" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[4]   > sic.Sre_header.nro_ocompra
"Sre_header.nro_ocompra" "Número!O/Compra" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[5]   > sic.Rem_header_prv.tip_comprob
"Rem_header_prv.tip_comprob" "Tipo!Remito" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[6]   > sic.Rem_header_prv.prf_comprob
"Rem_header_prv.prf_comprob" "Prefijo!Remito" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[7]   > sic.Rem_header_prv.nro_comprob
"Rem_header_prv.nro_comprob" "Número!Remito" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[8]   = sic.Proveedor.cdg_proveedor
     _FldNameList[9]   > sic.Proveedor.nombre
"Proveedor.nombre" ? ? "character" ? ? ? ? ? ? no ? no no "38" yes no no "U" "" ""
     _Query            is NOT OPENED
*/  /* BROWSE br_table */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME F-Main
/* Query rebuild information for FRAME F-Main
     _TblList          = "sic.Ingresoaplanta"
     _Options          = "NO-LOCK"
     _Query            is NOT OPENED
*/  /* FRAME F-Main */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define BROWSE-NAME br_table
&Scoped-define SELF-NAME br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-ENTRY OF br_table IN FRAME F-Main /* Ingresos a Planta Pendientes de Aprobar o Rechazar */
DO:
  /* This code displays initial values for newly added or copied rows. */
  {src/adm/template/brsentry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-LEAVE OF br_table IN FRAME F-Main /* Ingresos a Planta Pendientes de Aprobar o Rechazar */
DO:
    /* Do not disable this code or no updates will take place except
     by pressing the Save button on an Update SmartPanel. */
   {src/adm/template/brsleave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON VALUE-CHANGED OF br_table IN FRAME F-Main /* Ingresos a Planta Pendientes de Aprobar o Rechazar */
DO:
  /* This ADM trigger code must be preserved in order to notify other
     objects when the browser's current row changes. */
  {src/adm/template/brschnge.i}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_aprobar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_aprobar B-table-Win
ON CHOOSE OF btn_aprobar IN FRAME F-Main /* Conforme Descarga */
DO:
  sino = NO.
  MESSAGE "Desea APROBAR este ingreso" VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación"
      UPDATE sino .
  IF sino
  THEN DO:
      DO TRANSACTION:
          FIND CURRENT Ingresoaplanta EXCLUSIVE-LOCK.
          Ingresoaplanta.cdg_estado = "AA".
          Ingresoaplanta.nro_usuario_cumple = Usuario.nro_usuario.
          FIND CURRENT Ingresoaplanta NO-LOCK.
      END.
      RUN dispatch IN THIS-PROCEDURE ( "open-query").
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_rechazar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_rechazar B-table-Win
ON CHOOSE OF btn_rechazar IN FRAME F-Main /* Rechazar Descarga */
DO:
  sino = NO.
  MESSAGE "Desea RECHAZAR este ingreso" VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación"
      UPDATE sino .
  IF sino
  THEN DO:
      DO TRANSACTION:
          FIND CURRENT Ingresoaplanta EXCLUSIVE-LOCK.
          Ingresoaplanta.cdg_estado = "RE".
          Ingresoaplanta.nro_usuario_cumple = Usuario.nro_usuario.
          FIND CURRENT Ingresoaplanta NO-LOCK.
      END.
      RUN dispatch IN THIS-PROCEDURE ( "open-query").
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-codigo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-codigo B-table-Win
ON MOUSE-MENU-DOWN OF v-codigo IN FRAME F-Main
DO:
  
/*   &SCOPED-DEFINE ROWID_TABLA        rid_ingreso_planta */
/*   &SCOPED-DEFINE SELECCION          SELDESTINATARIO.P  */
/*   &SCOPED-DEFINE TABLA              Ingreso_planta     */
/*   &SCOPED-DEFINE CDG_TABLA          num_ingreso        */
/*   &SCOPED-DEFINE DSC_TABLA          dsc_ingreso_planta */
/*   &SCOPED-DEFINE V-CDG_TABLA        v-codigo           */
/*   &SCOPED-DEFINE MOSTRAR_DSC        NO                 */
/*                                                        */
/*   {hlptabla-var.i}                                     */
/*                                                        */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-codigo B-table-Win
ON RETURN OF v-codigo IN FRAME F-Main
OR "TAB" OF v-codigo IN FRAME {&FRAME-NAME}
DO:
  
  &SCOPED-DEFINE CODIGO num_ingreso

  IF {&BROWSE-NAME}:SENSITIVE IN FRAME {&FRAME-NAME}
  THEN DO:

    ASSIGN v-codigo.
    FIND FIRST {&FIRST-TABLE-IN-QUERY-{&BROWSE-NAME}}
         WHERE {&FIRST-TABLE-IN-QUERY-{&BROWSE-NAME}}.{&CODIGO} >= v-codigo
                NO-LOCK NO-ERROR.
    IF NOT AVAILABLE {&FIRST-TABLE-IN-QUERY-{&BROWSE-NAME}}
       THEN FIND LAST {&FIRST-TABLE-IN-QUERY-{&BROWSE-NAME}} NO-LOCK.
    REPOSITION {&BROWSE-NAME} TO ROWID ROWID({&FIRST-TABLE-IN-QUERY-{&BROWSE-NAME}}).
    RUN dispatch IN THIS-PROCEDURE ('row-changed').

  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK B-table-Win 


/* ***************************  Main Block  *************************** */

&IF DEFINED(UIB_IS_RUNNING) <> 0 &THEN          
RUN dispatch IN THIS-PROCEDURE ('initialize':U).        
&ENDIF

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-open-query-cases B-table-Win  adm/support/_adm-opn.p
PROCEDURE adm-open-query-cases :
/*------------------------------------------------------------------------------
  Purpose:     Opens different cases of the query based on attributes
               such as the 'Key-Name', or 'SortBy-Case'
  Parameters:  <none>
------------------------------------------------------------------------------*/

  /* No Foreign keys are accepted by this SmartObject. */

  {&OPEN-QUERY-{&BROWSE-NAME}}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available B-table-Win  _ADM-ROW-AVAILABLE
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

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI B-table-Win  _DEFAULT-DISABLE
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize B-table-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

   {findempresa.i}
   que_empresa = Empresa.cdg_empresa.
   {findsector.i}
   que_area    = Area.nro_area.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records B-table-Win  _ADM-SEND-RECORDS
PROCEDURE send-records :
/*------------------------------------------------------------------------------
  Purpose:     Send record ROWID's for all tables used by
               this file.
  Parameters:  see template/snd-head.i
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.               */
  {src/adm/template/snd-head.i}

  /* For each requested table, put it's ROWID in the output list.      */
  {src/adm/template/snd-list.i "Ingresoaplanta"}
  {src/adm/template/snd-list.i "Sre_header"}
  {src/adm/template/snd-list.i "Rem_header_prv"}
  {src/adm/template/snd-list.i "Proveedor"}

  /* Deal with any unexpected table requests before closing.           */
  {src/adm/template/snd-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE set-sensitivo B-table-Win 
PROCEDURE set-sensitivo :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEFINE INPUT PARAMETER p-estado AS LOGICAL.


DO WITH FRAME {&FRAME-NAME}:

      IF p-estado  /* Habilitar */
      THEN v-codigo:SENSITIVE = YES.
      ELSE v-codigo:SENSITIVE = NO.

END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE state-changed B-table-Win 
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
      {src/adm/template/bstates.i}
  END CASE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

