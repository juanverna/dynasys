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
&Scoped-define EXTERNAL-TABLES Cuenta_bancaria
&Scoped-define FIRST-EXTERNAL-TABLE Cuenta_bancaria


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Cuenta_bancaria.
/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Cheque Proveedor

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Cheque.numero_cheque ~
Proveedor.cdg_proveedor Proveedor.nombre Cheque.fecha_emision ~
Cheque.fecha_salida Cheque.fecha_deposito Cheque.importe Cheque.estado ~
Cheque.observacion 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table 
&Scoped-define QUERY-STRING-br_table FOR EACH Cheque OF Cuenta_bancaria WHERE ~{&KEY-PHRASE} ~
      AND Cheque.fecha_emision <= v-has_fecha ~
 AND Cheque.fecha_emision >= v-des_fecha NO-LOCK, ~
      EACH Proveedor OF Cheque NO-LOCK ~
    ~{&SORTBY-PHRASE}
&Scoped-define OPEN-QUERY-br_table OPEN QUERY br_table FOR EACH Cheque OF Cuenta_bancaria WHERE ~{&KEY-PHRASE} ~
      AND Cheque.fecha_emision <= v-has_fecha ~
 AND Cheque.fecha_emision >= v-des_fecha NO-LOCK, ~
      EACH Proveedor OF Cheque NO-LOCK ~
    ~{&SORTBY-PHRASE}.
&Scoped-define TABLES-IN-QUERY-br_table Cheque Proveedor
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Cheque
&Scoped-define SECOND-TABLE-IN-QUERY-br_table Proveedor


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-2 v-des_fecha v-has_fecha v-sort ~
br_table 
&Scoped-Define DISPLAYED-OBJECTS v-des_fecha v-has_fecha v-sort 

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
cdg_caja||y|sic.Cheque.cdg_caja
nro_transaccion||y|sic.Cheque.nro_transaccion
nro_cheque||y|sic.Cheque.nro_cheque
nro_cuenta||y|sic.Cheque.nro_cuenta
cdg_cuenta_ban||y|sic.Cheque.cdg_cuenta_ban
nro_proveedor||y|sic.Cheque.nro_proveedor
num_sucursal||y|sic.Cheque.num_sucursal
nro_titular-pag||y|sic.Cheque.nro_titular-pag
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = ,
     Keys-Supplied = "cdg_caja,nro_transaccion,nro_cheque,nro_cuenta,cdg_cuenta_ban,nro_proveedor,num_sucursal,nro_titular-pag"':U).

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
DEFINE BUTTON btn_listar 
     LABEL "&Listado" 
     SIZE 24 BY 1.33.

DEFINE BUTTON btn_vercheque 
     LABEL "&Ver Cheque" 
     SIZE 24 BY 1.33.

DEFINE VARIABLE v-sort AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Ordenado por" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Número",         1,
                     "Fecha Emisión",         2,
                     "Fecha Salida",         3
     DROP-DOWN-LIST
     SIZE 28 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-des_fecha AS DATE FORMAT "99/99/99":U 
     LABEL "Desde" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE v-has_fecha AS DATE FORMAT "99/99/99":U 
     LABEL "Hasta" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 155 BY 1.86.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Cheque, 
      Proveedor SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _STRUCTURED
  QUERY br_table NO-LOCK DISPLAY
      Cheque.numero_cheque FORMAT ">>>>>>>9":U
      Proveedor.cdg_proveedor FORMAT "X(8)":U
      Proveedor.nombre FORMAT "X(35)":U
      Cheque.fecha_emision FORMAT "99/99/9999":U
      Cheque.fecha_salida FORMAT "99/99/9999":U
      Cheque.fecha_deposito FORMAT "99/99/9999":U
      Cheque.importe FORMAT "->>>,>>>,>>9.99":U
      Cheque.estado FORMAT "X(2)":U WIDTH 6.2
      Cheque.observacion FORMAT "X(40)":U WIDTH 32.2
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 154 BY 16.91
         BGCOLOR 15 FGCOLOR 9  FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     btn_vercheque AT ROW 1.24 COL 105
     btn_listar AT ROW 1.24 COL 130
     v-des_fecha AT ROW 1.48 COL 11 COLON-ALIGNED
     v-has_fecha AT ROW 1.48 COL 34 COLON-ALIGNED
     v-sort AT ROW 1.48 COL 66 COLON-ALIGNED WIDGET-ID 6
     br_table AT ROW 3.14 COL 1
     RECT-2 AT ROW 1 COL 1
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
         HEIGHT             = 22.14
         WIDTH              = 158.2.
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
/* BROWSE-TAB br_table v-sort F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR BUTTON btn_listar IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_vercheque IN FRAME F-Main
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _TblList          = "sic.Cheque OF sic.Cuenta_bancaria,sic.Proveedor OF sic.Cheque"
     _Options          = "NO-LOCK KEY-PHRASE SORTBY-PHRASE"
     _Where[1]         = "Cheque.fecha_emision <= v-has_fecha
 AND Cheque.fecha_emision >= v-des_fecha"
     _FldNameList[1]   = sic.Cheque.numero_cheque
     _FldNameList[2]   = sic.Proveedor.cdg_proveedor
     _FldNameList[3]   > sic.Proveedor.nombre
"Proveedor.nombre" ? "X(35)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[4]   = sic.Cheque.fecha_emision
     _FldNameList[5]   = sic.Cheque.fecha_salida
     _FldNameList[6]   = sic.Cheque.fecha_deposito
     _FldNameList[7]   = sic.Cheque.importe
     _FldNameList[8]   > sic.Cheque.estado
"Cheque.estado" ? ? "character" ? ? ? ? ? ? no ? no no "6.2" yes no no "U" "" ""
     _FldNameList[9]   > sic.Cheque.observacion
"Cheque.observacion" ? ? "character" ? ? ? ? ? ? no ? no no "32.2" yes no no "U" "" ""
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


&Scoped-define SELF-NAME btn_listar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_listar B-table-Win
ON CHOOSE OF btn_listar IN FRAME F-Main /* Listado */
DO:
    RUN noesta.p.
   /*RUN lschequesxcuenta.p (INPUT Cuenta_bancaria.cdg_cuenta_ban, 
                             INPUT v-des_fecha, 
                             INPUT v-has_fecha,
                             INPUT "PP,00,01,02,03,04").*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_vercheque
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_vercheque B-table-Win
ON CHOOSE OF btn_vercheque IN FRAME F-Main /* Ver Cheque */
DO:
  IF AVAILABLE Cheque
     THEN RUN d-muestra_cheque.w ( INPUT ROWID(Cheque)).
     ELSE BELL.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-des_fecha
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
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-has_fecha
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
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-sort
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-sort B-table-Win
ON VALUE-CHANGED OF v-sort IN FRAME F-Main /* Ordenado por */
DO:
  ASSIGN v-sort.
  RUN refrescar_browse ( INPUT v-sort ).
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

  ASSIGN v-has_fecha = TODAY
         v-des_fecha = v-has_fecha - 90
         v-sort = 1.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   DISPLAY v-des_fecha
           v-has_fecha
           WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-open-query B-table-Win 
PROCEDURE local-open-query :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  CASE v-sort:

       WHEN 1 THEN OPEN QUERY {&BROWSE-NAME}
                        FOR EACH Cheque NO-LOCK OF Cuenta_bancaria 
                           WHERE Cheque.fecha_emision <= v-has_fecha
                             AND Cheque.fecha_emision >= v-des_fecha,
                                 FIRST Proveedor OF Cheque NO-LOCK
                                 BY Cheque.numero_cheque.
       WHEN 2 THEN OPEN QUERY {&BROWSE-NAME}
                        FOR EACH Cheque NO-LOCK OF Cuenta_bancaria 
                           WHERE Cheque.fecha_emision <= v-has_fecha
                             AND Cheque.fecha_emision >= v-des_fecha,
                                 FIRST Proveedor OF Cheque NO-LOCK
                                 BY Cheque.fecha_emision.
       WHEN 3 THEN OPEN QUERY {&BROWSE-NAME}
                        FOR EACH Cheque NO-LOCK OF Cuenta_bancaria 
                           WHERE Cheque.fecha_emision <= v-has_fecha
                             AND Cheque.fecha_emision >= v-des_fecha,
                                 FIRST Proveedor OF Cheque NO-LOCK
                                 BY Cheque.fecha_salida.

  END CASE.

  btn_vercheque:SENSITIVE IN FRAME {&FRAME-NAME} = AVAILABLE Cheque.
  btn_listar:SENSITIVE IN FRAME {&FRAME-NAME}    = AVAILABLE Cheque.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE refrescar_browse B-table-Win 
PROCEDURE refrescar_browse :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER p-sort AS INTEGER.
  
  v-sort = p-sort.
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).

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
  {src/adm/template/sndkycas.i "cdg_caja" "Cheque" "cdg_caja"}
  {src/adm/template/sndkycas.i "nro_transaccion" "Cheque" "nro_transaccion"}
  {src/adm/template/sndkycas.i "nro_cheque" "Cheque" "nro_cheque"}
  {src/adm/template/sndkycas.i "nro_cuenta" "Cheque" "nro_cuenta"}
  {src/adm/template/sndkycas.i "cdg_cuenta_ban" "Cheque" "cdg_cuenta_ban"}
  {src/adm/template/sndkycas.i "nro_proveedor" "Cheque" "nro_proveedor"}
  {src/adm/template/sndkycas.i "num_sucursal" "Cheque" "num_sucursal"}
  {src/adm/template/sndkycas.i "nro_titular-pag" "Cheque" "nro_titular-pag"}

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
  {src/adm/template/snd-list.i "Cheque"}
  {src/adm/template/snd-list.i "Proveedor"}

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

