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
  DEFINE VARIABLE fecha_inicial AS DATE.
  DEFINE VARIABLE fecha_elegida AS DATE.

  DEFINE VARIABLE v-total_deposito AS DECIMAL FORMAT ">>>>>>9.99".

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
&Scoped-define EXTERNAL-TABLES Cuenta_bancaria
&Scoped-define FIRST-EXTERNAL-TABLE Cuenta_bancaria


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Cuenta_bancaria.
/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Boleta_deposito_hd Caja

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Boleta_deposito_hd.nro_comprob Boleta_deposito_hd.fecha_deposito v-totales() @ v-total_deposito Boleta_deposito_hd.cdg_caja Caja.nombre Boleta_deposito_hd.referencia   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table   
&Scoped-define SELF-NAME br_table
&Scoped-define OPEN-QUERY-br_table IF que_deposito = 0 THEN OPEN QUERY {&SELF-NAME} FOR EACH Boleta_deposito_hd OF Cuenta_bancaria       WHERE Boleta_deposito_hd.anulado = FALSE  AND Boleta_deposito_hd.fecha_deposito <= v-has_fecha  AND Boleta_deposito_hd.fecha_deposito >= v-des_fecha NO-LOCK, ~
             EACH Caja OF Boleta_deposito_hd NO-LOCK     BY Boleta_deposito_hd.nro_boletadep DESCENDING. ELSE     OPEN QUERY {&SELF-NAME} FOR EACH Boleta_deposito_hd OF Cuenta_bancaria       WHERE Boleta_deposito_hd.anulado = FALSE  AND Boleta_deposito_hd.nro_boletadep = que_deposito NO-LOCK, ~
             EACH Caja OF Boleta_deposito_hd NO-LOCK     BY Boleta_deposito_hd.nro_boletadep DESCENDING.
&Scoped-define TABLES-IN-QUERY-br_table Boleta_deposito_hd Caja
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Boleta_deposito_hd
&Scoped-define SECOND-TABLE-IN-QUERY-br_table Caja


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS Btn-excel RECT-1 btn_imprimir btn_anular ~
v-des_fecha que_deposito v-has_fecha v-totalsel br_table 
&Scoped-Define DISPLAYED-OBJECTS v-des_fecha que_deposito v-has_fecha ~
v-totalsel 

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
nro_boletadep||y|sic.Boleta_deposito_hd.nro_boletadep
cdg_caja||y|sic.Boleta_deposito_hd.cdg_caja
cdg_cuenta_ban||y|sic.Boleta_deposito_hd.cdg_cuenta_ban
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = ,
     Keys-Supplied = "nro_boletadep,cdg_caja,cdg_cuenta_ban"':U).

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

/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD v-totales B-table-Win 
FUNCTION v-totales RETURNS DECIMAL
  ()  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn-excel 
     IMAGE-UP FILE "excel.gif":U NO-FOCUS
     LABEL "&Modifica" 
     SIZE 9 BY 1.14 TOOLTIP "Modifica el registro actual"
     FONT 4.

DEFINE BUTTON btn_anular 
     LABEL "&Anular Depósito" 
     SIZE 17 BY 1.14
     FONT 4.

DEFINE BUTTON btn_imprimir 
     LABEL "&Imprimir Depósito" 
     SIZE 18 BY 1.14
     FONT 4.

DEFINE VARIABLE que_deposito AS INTEGER FORMAT ">>>>>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     BGCOLOR 14 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE v-des_fecha AS DATE FORMAT "99/99/9999":U 
     LABEL "Desde" 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE v-has_fecha AS DATE FORMAT "99/99/9999":U 
     LABEL "Hasta" 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE v-totalsel AS DECIMAL FORMAT ">>>,>>>,>>9.99":U INITIAL 0 
     LABEL "Total" 
     VIEW-AS FILL-IN 
     SIZE 24.8 BY 1 TOOLTIP "Suma de lo depositados para la cuenta entre fechas"
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 155 BY 1.62.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Boleta_deposito_hd, 
      Caja SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _FREEFORM
  QUERY br_table NO-LOCK DISPLAY
      Boleta_deposito_hd.nro_comprob COLUMN-LABEL "Número!Depósito" FORMAT ">>>>>9":U
      Boleta_deposito_hd.fecha_deposito COLUMN-LABEL "Fecha!Depósito" FORMAT "99/99/99":U
      v-totales() @ v-total_deposito COLUMN-LABEL "Importe!Depositado" FORMAT ">>>>>>9.99":U
      Boleta_deposito_hd.cdg_caja COLUMN-LABEL "Cod!Caja" FORMAT ">>9":U
      Caja.nombre COLUMN-LABEL "Denominación!Caja" FORMAT "X(15)":U
      Boleta_deposito_hd.referencia COLUMN-LABEL "Referencia!Bancaria" FORMAT "X(57)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 155 BY 6.81
         BGCOLOR 11 FGCOLOR 9 FONT 4
         TITLE BGCOLOR 11 FGCOLOR 9 "Depósitos bancarios por número descendente" ROW-HEIGHT-CHARS .76 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Btn-excel AT ROW 1.24 COL 108.6 WIDGET-ID 2
     btn_imprimir AT ROW 1.24 COL 119
     btn_anular AT ROW 1.24 COL 138
     v-des_fecha AT ROW 1.29 COL 26.8 COLON-ALIGNED
     que_deposito AT ROW 1.33 COL 2.4 NO-LABEL
     v-has_fecha AT ROW 1.33 COL 53 COLON-ALIGNED
     v-totalsel AT ROW 1.33 COL 78.2 COLON-ALIGNED WIDGET-ID 4
     br_table AT ROW 2.86 COL 1
     RECT-1 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         BGCOLOR 8 FGCOLOR 0 .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartBrowser
   External Tables: sic.Cuenta_bancaria
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
         HEIGHT             = 9.14
         WIDTH              = 155.6.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB B-table-Win 
/* ************************* Included-Libraries *********************** */

{src/adm/method/browser.i}
{excel-export.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW B-table-Win
  NOT-VISIBLE,,RUN-PERSISTENT                                           */
/* SETTINGS FOR FRAME F-Main
   NOT-VISIBLE Size-to-Fit                                              */
/* BROWSE-TAB br_table v-totalsel F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN que_deposito IN FRAME F-Main
   ALIGN-L                                                              */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _START_FREEFORM
IF que_deposito = 0 THEN
OPEN QUERY {&SELF-NAME} FOR EACH Boleta_deposito_hd OF Cuenta_bancaria
      WHERE Boleta_deposito_hd.anulado = FALSE
 AND Boleta_deposito_hd.fecha_deposito <= v-has_fecha
 AND Boleta_deposito_hd.fecha_deposito >= v-des_fecha NO-LOCK,
      EACH Caja OF Boleta_deposito_hd NO-LOCK
    BY Boleta_deposito_hd.nro_boletadep DESCENDING.
ELSE
    OPEN QUERY {&SELF-NAME} FOR EACH Boleta_deposito_hd OF Cuenta_bancaria
      WHERE Boleta_deposito_hd.anulado = FALSE
 AND Boleta_deposito_hd.nro_boletadep = que_deposito NO-LOCK,
      EACH Caja OF Boleta_deposito_hd NO-LOCK
    BY Boleta_deposito_hd.nro_boletadep DESCENDING.
     _END_FREEFORM
     _Options          = "NO-LOCK KEY-PHRASE"
     _OrdList          = "sic.Boleta_deposito_hd.nro_boletadep|no"
     _Where[1]         = "Boleta_deposito_hd.anulado = FALSE
 AND Boleta_deposito_hd.fecha_deposito <= v-has_fecha
 AND Boleta_deposito_hd.fecha_deposito >= v-des_fecha"
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
ON ROW-ENTRY OF br_table IN FRAME F-Main /* Depósitos bancarios por número descendente */
DO:
  /* This code displays initial values for newly added or copied rows. */
  {src/adm/template/brsentry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-LEAVE OF br_table IN FRAME F-Main /* Depósitos bancarios por número descendente */
DO:
    /* Do not disable this code or no updates will take place except
     by pressing the Save button on an Update SmartPanel. */
   {src/adm/template/brsleave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON VALUE-CHANGED OF br_table IN FRAME F-Main /* Depósitos bancarios por número descendente */
DO:
  /* This ADM trigger code must be preserved in order to notify other
     objects when the browser's current row changes. */
  {src/adm/template/brschnge.i}
  
  

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn-excel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn-excel B-table-Win
ON CHOOSE OF Btn-excel IN FRAME F-Main /* Modifica */
DO:
    run excel-export ( br_table:HANDLE IN FRAME {&FRAME-NAME} ).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_anular
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_anular B-table-Win
ON CHOOSE OF btn_anular IN FRAME F-Main /* Anular Depósito */
DO:
  DEFINE VARIABLE hubo_anulacion AS LOGICAL.
  DEFINE VARIABLE sino           AS LOGICAL.
  RUN mensajepregunta.p ( INPUT "Depósito Bancario", INPUT "PREG006", INPUT-OUTPUT sino ).
  IF sino
  THEN DO:
      RUN anular_deposito_bancario.p ( INPUT ROWID(Boleta_deposito_hd), OUTPUT hubo_anulacion ).
      IF hubo_anulacion 
      THEN DO:
           RUN dispatch IN THIS-PROCEDURE ('open-query':U).
      END.     
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_imprimir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_imprimir B-table-Win
ON CHOOSE OF btn_imprimir IN FRAME F-Main /* Imprimir Depósito */
DO:
  RUN lsdeposito.p ( ROWID(Boleta_deposito_hd)).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME que_deposito
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_deposito B-table-Win
ON RETURN OF que_deposito IN FRAME F-Main
DO:
  ASSIGN que_deposito.
  RUN calcula_total.
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-des_fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-des_fecha B-table-Win
ON LEAVE OF v-des_fecha IN FRAME F-Main /* Desde */
DO:
  APPLY "RETURN" TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-des_fecha B-table-Win
ON MOUSE-MENU-DOWN OF v-des_fecha IN FRAME F-Main /* Desde */
DO:
  fecha_inicial = DATE(v-des_fecha:SCREEN-VALUE IN FRAME {&FRAME-NAME}) NO-ERROR.
  IF fecha_inicial = ? THEN fecha_inicial = TODAY.
  RUN d-calendario.w ( INPUT fecha_inicial, OUTPUT fecha_elegida).
  IF fecha_elegida <> ?
  THEN DO:
       DISPLAY fecha_elegida @ v-des_fecha 
               WITH FRAME {&FRAME-NAME}.
       APPLY "RETURN" TO SELF.        
  END.               
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-des_fecha B-table-Win
ON RETURN OF v-des_fecha IN FRAME F-Main /* Desde */
DO:
  ASSIGN v-des_fecha.
  run calcula_total.
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-has_fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-has_fecha B-table-Win
ON LEAVE OF v-has_fecha IN FRAME F-Main /* Hasta */
DO:
  APPLY "RETURN" TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-has_fecha B-table-Win
ON MOUSE-MENU-DOWN OF v-has_fecha IN FRAME F-Main /* Hasta */
DO:
  fecha_inicial = DATE(v-has_fecha:SCREEN-VALUE IN FRAME {&FRAME-NAME}) NO-ERROR.
  IF fecha_inicial = ? THEN fecha_inicial = TODAY.
  RUN d-calendario.w ( INPUT fecha_inicial, OUTPUT fecha_elegida).
  IF fecha_elegida <> ?
  THEN DO:
       DISPLAY fecha_elegida @ v-has_fecha 
               WITH FRAME {&FRAME-NAME}.
       APPLY "TAB" TO SELF.        
  END.               
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-has_fecha B-table-Win
ON RETURN OF v-has_fecha IN FRAME F-Main /* Hasta */
DO:
  ASSIGN v-has_fecha.
  RUN calcula_total.
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-totalsel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-totalsel B-table-Win
ON MOUSE-MENU-DOWN OF v-totalsel IN FRAME F-Main /* Total */
DO:
  fecha_inicial = DATE(v-has_fecha:SCREEN-VALUE IN FRAME {&FRAME-NAME}) NO-ERROR.
  IF fecha_inicial = ? THEN fecha_inicial = TODAY.
  RUN d-calendario.w ( INPUT fecha_inicial, OUTPUT fecha_elegida).
  IF fecha_elegida <> ?
  THEN DO:
       DISPLAY fecha_elegida @ v-has_fecha 
               WITH FRAME {&FRAME-NAME}.
       APPLY "TAB" TO SELF.        
  END.               
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-totalsel B-table-Win
ON RETURN OF v-totalsel IN FRAME F-Main /* Total */
DO:
  ASSIGN v-has_fecha.
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
  {src/adm/template/row-list.i "Cuenta_bancaria"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Cuenta_bancaria"}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE calcula_total B-table-Win 
PROCEDURE calcula_total :
/*------------------------------------------------------------------------------
  Purpose:   Suma lo depositado entre fechas  
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE BUFFER bBoleta_deposito_hd FOR Boleta_deposito_hd.
DEFINE BUFFER bBoleta_deposito_dt FOR Boleta_deposito_dt.
DEFINE BUFFER bValor FOR valor.
v-totalsel = 0.
ASSIGN FRAME {&FRAME-NAME} v-has_fecha v-des_fecha.
FOR EACH bBoleta_deposito_hd OF Cuenta_bancaria
      WHERE bBoleta_deposito_hd.anulado = FALSE
 AND bBoleta_deposito_hd.fecha_deposito <= v-has_fecha
 AND bBoleta_deposito_hd.fecha_deposito >= v-des_fecha NO-LOCK,
      EACH bboleta_deposito_dt OF bBoleta_deposito_hd NO-LOCK,
    FIRST bValor OF bBoleta_deposito_dt no-lock:
      v-totalsel = v-totalsel + bValor.importe.
END.
  DISPLAY v-totalsel WITH FRAME {&FRAME-NAME}.   /* Function return value. */

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-display-fields B-table-Win 
PROCEDURE local-display-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'display-fields':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
  RUN calcula_total.

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

   v-des_fecha = TODAY.
   v-has_fecha = TODAY.
   
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
  
   DISPLAY v-des_fecha
           v-has_fecha
           WITH FRAME {&FRAME-NAME}.
   
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
  {src/adm/template/sndkycas.i "nro_boletadep" "Boleta_deposito_hd" "nro_boletadep"}
  {src/adm/template/sndkycas.i "cdg_caja" "Boleta_deposito_hd" "cdg_caja"}
  {src/adm/template/sndkycas.i "cdg_cuenta_ban" "Boleta_deposito_hd" "cdg_cuenta_ban"}

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
  {src/adm/template/snd-list.i "Cuenta_bancaria"}
  {src/adm/template/snd-list.i "Boleta_deposito_hd"}
  {src/adm/template/snd-list.i "Caja"}

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

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION v-totales B-table-Win 
FUNCTION v-totales RETURNS DECIMAL
  () :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEFINE VAR v-total AS DECIMAL NO-UNDO.
DEFINE BUFFER BBoleta_deposito_dt FOR  Boleta_deposito_dt.
DEFINE BUFFER Bvalor FOR  Valor.
v-total = 0.
  FOR EACH bBoleta_deposito_dt OF Boleta_deposito_hd NO-LOCK,
        FIRST bValor OF bBoleta_deposito_dt NO-LOCK :
      v-total = v-total + bValor.importe.
  END.
  RETURN v-total.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

