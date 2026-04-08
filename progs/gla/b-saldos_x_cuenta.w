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
DEFINE VARIABLE que_moneda  LIKE Moneda.nro_moneda.

DEFINE VARIABLE fecha_inicial AS DATE.
DEFINE VARIABLE fecha_elegida AS DATE.

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

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES Cuenta
&Scoped-define FIRST-EXTERNAL-TABLE Cuenta


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Cuenta.
/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Saldos_x_cuenta Entidad Obra

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Entidad.cdg_entidad ~
Entidad.dsc_entidad Obra.cdg_obra Saldos_x_cuenta.tot_creditos ~
Saldos_x_cuenta.tot_debitos Saldos_x_cuenta.saldo_total 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table 
&Scoped-define QUERY-STRING-br_table FOR EACH Saldos_x_cuenta OF Cuenta WHERE ~{&KEY-PHRASE} ~
      AND Saldos_x_cuenta.cdg_empresa = que_empresa ~
 AND Saldos_x_cuenta.fch_saldo = que_fecha  ~
 AND Saldos_x_cuenta.reexpresion = que_reexpresion ~
 AND Saldos_x_cuenta.nro_moneda = que_moneda NO-LOCK, ~
      EACH Entidad OF Saldos_x_cuenta NO-LOCK, ~
      EACH Obra OF Saldos_x_cuenta OUTER-JOIN NO-LOCK ~
    ~{&SORTBY-PHRASE}
&Scoped-define OPEN-QUERY-br_table OPEN QUERY br_table FOR EACH Saldos_x_cuenta OF Cuenta WHERE ~{&KEY-PHRASE} ~
      AND Saldos_x_cuenta.cdg_empresa = que_empresa ~
 AND Saldos_x_cuenta.fch_saldo = que_fecha  ~
 AND Saldos_x_cuenta.reexpresion = que_reexpresion ~
 AND Saldos_x_cuenta.nro_moneda = que_moneda NO-LOCK, ~
      EACH Entidad OF Saldos_x_cuenta NO-LOCK, ~
      EACH Obra OF Saldos_x_cuenta OUTER-JOIN NO-LOCK ~
    ~{&SORTBY-PHRASE}.
&Scoped-define TABLES-IN-QUERY-br_table Saldos_x_cuenta Entidad Obra
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Saldos_x_cuenta
&Scoped-define SECOND-TABLE-IN-QUERY-br_table Entidad
&Scoped-define THIRD-TABLE-IN-QUERY-br_table Obra


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS que_reexpresion v-moneda que_fecha br_table ~
RECT-1 
&Scoped-Define DISPLAYED-OBJECTS que_reexpresion v-moneda que_fecha 

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
nro_cuenta||y|sic.Saldos_x_cuenta.nro_cuenta
cdg_empresa||y|sic.Saldos_x_cuenta.cdg_empresa
nro_entidad||y|sic.Saldos_x_cuenta.nro_entidad
nro_moneda||y|sic.Saldos_x_cuenta.nro_moneda
nro_obra||y|sic.Saldos_x_cuenta.nro_obra
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = ,
     Keys-Supplied = "nro_cuenta,cdg_empresa,nro_entidad,nro_moneda,nro_obra"':U).

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
DEFINE VARIABLE v-moneda AS CHARACTER FORMAT "X(256)":U 
     LABEL "Moneda" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     DROP-DOWN-LIST
     SIZE 26 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE que_fecha AS DATE FORMAT "99/99/99":U 
     LABEL "Fecha" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE que_reexpresion AS LOGICAL 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Saldos Reexpresados", yes,
"Moneda de Origen", no
     SIZE 25 BY 1.33 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 94 BY 1.86.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Saldos_x_cuenta, 
      Entidad, 
      Obra SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _STRUCTURED
  QUERY br_table NO-LOCK DISPLAY
      Entidad.cdg_entidad FORMAT "X(8)":U
      Entidad.dsc_entidad COLUMN-LABEL "Denominación!Entidad" FORMAT "X(21)":U
      Obra.cdg_obra FORMAT "X(8)":U
      Saldos_x_cuenta.tot_creditos FORMAT "->>>,>>>,>>9.99":U
      Saldos_x_cuenta.tot_debitos FORMAT "->>>,>>>,>>9.99":U
      Saldos_x_cuenta.saldo_total FORMAT "->>>,>>>,>>9.99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 94 BY 12.81
         BGCOLOR 15 FGCOLOR 9 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     que_reexpresion AT ROW 1.29 COL 4 NO-LABEL
     v-moneda AT ROW 1.48 COL 40 COLON-ALIGNED
     que_fecha AT ROW 1.48 COL 75 COLON-ALIGNED
     br_table AT ROW 3.43 COL 1
     RECT-1 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         BGCOLOR 8 FGCOLOR 0 .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartBrowser
   External Tables: sic.Cuenta
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
         HEIGHT             = 26.33
         WIDTH              = 95.2.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB B-table-Win 
/* ************************* Included-Libraries *********************** */

{setsensitivo.i}
{src/adm/method/browser.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW B-table-Win
  NOT-VISIBLE,,RUN-PERSISTENT                                           */
/* SETTINGS FOR FRAME F-Main
   NOT-VISIBLE Size-to-Fit                                              */
/* BROWSE-TAB br_table que_fecha F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _TblList          = "sic.Saldos_x_cuenta OF sic.Cuenta,sic.Entidad OF sic.Saldos_x_cuenta,sic.Obra OF sic.Saldos_x_cuenta"
     _Options          = "NO-LOCK KEY-PHRASE SORTBY-PHRASE"
     _TblOptList       = ",, OUTER"
     _Where[1]         = "Saldos_x_cuenta.cdg_empresa = que_empresa
 AND Saldos_x_cuenta.fch_saldo = que_fecha 
 AND Saldos_x_cuenta.reexpresion = que_reexpresion
 AND Saldos_x_cuenta.nro_moneda = que_moneda"
     _FldNameList[1]   = sic.Entidad.cdg_entidad
     _FldNameList[2]   > sic.Entidad.dsc_entidad
"Entidad.dsc_entidad" "Denominación!Entidad" "X(21)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[3]   = sic.Obra.cdg_obra
     _FldNameList[4]   = sic.Saldos_x_cuenta.tot_creditos
     _FldNameList[5]   = sic.Saldos_x_cuenta.tot_debitos
     _FldNameList[6]   = sic.Saldos_x_cuenta.saldo_total
     _Query            is NOT OPENED
*/  /* BROWSE br_table */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME F-Main
/* Query rebuild information for FRAME F-Main
     _Options          = "NO-LOCK"
     _Query            is NOT OPENED
*/  /* FRAME F-Main */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define BROWSE-NAME br_table
&Scoped-define SELF-NAME br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-ENTRY OF br_table IN FRAME F-Main
DO:
  /* This code displays initial values for newly added or copied rows. */
  {src/adm/template/brsentry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-LEAVE OF br_table IN FRAME F-Main
DO:
    /* Do not disable this code or no updates will take place except
     by pressing the Save button on an Update SmartPanel. */
   {src/adm/template/brsleave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON VALUE-CHANGED OF br_table IN FRAME F-Main
DO:
  /* This ADM trigger code must be preserved in order to notify other
     objects when the browser's current row changes. */
  {src/adm/template/brschnge.i}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME que_fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_fecha B-table-Win
ON + OF que_fecha IN FRAME F-Main /* Fecha */
DO:
  fecha_inicial = DATE(que_fecha:SCREEN-VALUE IN FRAME {&FRAME-NAME}) NO-ERROR.
  IF fecha_inicial = ? THEN fecha_inicial = TODAY.
  fecha_elegida = fecha_inicial + 1.
  DISPLAY fecha_elegida @ que_fecha 
          WITH FRAME {&FRAME-NAME}.
  APPLY "RETURN" TO SELF.        
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_fecha B-table-Win
ON - OF que_fecha IN FRAME F-Main /* Fecha */
DO:
  fecha_inicial = DATE(que_fecha:SCREEN-VALUE IN FRAME {&FRAME-NAME}) NO-ERROR.
  IF fecha_inicial = ? THEN fecha_inicial = TODAY.
  fecha_elegida = fecha_inicial - 1.
  DISPLAY fecha_elegida @ que_fecha 
          WITH FRAME {&FRAME-NAME}.
  APPLY "RETURN" TO SELF.        
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_fecha B-table-Win
ON MOUSE-MENU-DOWN OF que_fecha IN FRAME F-Main /* Fecha */
DO:

  fecha_inicial = DATE(que_fecha:SCREEN-VALUE IN FRAME {&FRAME-NAME}) NO-ERROR.
  IF fecha_inicial = ? THEN fecha_inicial = TODAY.
  RUN d-calendario.w ( INPUT fecha_inicial, OUTPUT fecha_elegida).
  IF fecha_elegida <> ?
  THEN DO:
       DISPLAY fecha_elegida @ que_fecha 
               WITH FRAME {&FRAME-NAME}.
       APPLY "RETURN" TO SELF.        
  END.               
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_fecha B-table-Win
ON RETURN OF que_fecha IN FRAME F-Main /* Fecha */
DO:
  ASSIGN que_fecha.
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME que_reexpresion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_reexpresion B-table-Win
ON VALUE-CHANGED OF que_reexpresion IN FRAME F-Main
DO:
  ASSIGN que_reexpresion.
  RUN inicia_combos.
  RUN fijar_local.
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-moneda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-moneda B-table-Win
ON VALUE-CHANGED OF v-moneda IN FRAME F-Main /* Moneda */
DO:
   ASSIGN v-moneda. 
   RUN poner_moneda.  
   RUN dispatch IN THIS-PROCEDURE ('open-query':U).
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

  /* Create a list of all the tables that we need to get.            */
  {src/adm/template/row-list.i "Cuenta"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Cuenta"}

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE fijar_local B-table-Win 
PROCEDURE fijar_local :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  FIND FIRST Moneda WHERE Moneda.es_local NO-LOCK.
  v-moneda = Moneda.cdg_moneda.
  DISPLAY v-moneda
      WITH FRAME {&FRAME-NAME}.
  que_moneda = Moneda.nro_moneda.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE inicia_combos B-table-Win 
PROCEDURE inicia_combos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE x-lista AS CHARACTER.

  DO WITH FRAME {&FRAME-NAME}:

     x-lista = "".
     FOR EACH Moneda 
         WHERE Moneda.reexpresa_saldos OR NOT que_reexpresion
         NO-LOCK BY Moneda.descripcion:
         x-lista = x-lista + "," + Moneda.descripcion + "," + Moneda.cdg_moneda.
     END.

     v-moneda:LIST-ITEM-PAIRS = SUBSTRING(x-lista,2).
  END.
  
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

   que_reexpresion = YES.
   que_fecha = TODAY.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  RUN inicia_combos.
  RUN fijar_local.

  DISPLAY que_reexpresion
          que_fecha
          WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_moneda B-table-Win 
PROCEDURE poner_moneda :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND Moneda WHERE Moneda.cdg_moneda = v-moneda NO-LOCK.
    que_moneda = Moneda.nro_moneda.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-key B-table-Win  adm/support/_key-snd.p
PROCEDURE send-key :
/*------------------------------------------------------------------------------
  Purpose:     Sends a requested KEY value back to the calling
               SmartObject.
  Parameters:  <see adm/template/sndkytop.i>
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.             */
  {src/adm/template/sndkytop.i}

  /* Return the key value associated with each key case.             */
  {src/adm/template/sndkycas.i "nro_cuenta" "Saldos_x_cuenta" "nro_cuenta"}
  {src/adm/template/sndkycas.i "cdg_empresa" "Saldos_x_cuenta" "cdg_empresa"}
  {src/adm/template/sndkycas.i "nro_entidad" "Saldos_x_cuenta" "nro_entidad"}
  {src/adm/template/sndkycas.i "nro_moneda" "Saldos_x_cuenta" "nro_moneda"}
  {src/adm/template/sndkycas.i "nro_obra" "Saldos_x_cuenta" "nro_obra"}

  /* Close the CASE statement and end the procedure.                 */
  {src/adm/template/sndkyend.i}

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
  {src/adm/template/snd-list.i "Cuenta"}
  {src/adm/template/snd-list.i "Saldos_x_cuenta"}
  {src/adm/template/snd-list.i "Entidad"}
  {src/adm/template/snd-list.i "Obra"}

  /* Deal with any unexpected table requests before closing.           */
  {src/adm/template/snd-end.i}

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

