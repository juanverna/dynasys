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

DEFINE VARIABLE f-debito  AS CHARACTER FORMAT "X(12)".
DEFINE VARIABLE f-credito AS CHARACTER FORMAT "X(12)".

DEFINE VARIABLE que_moneda  LIKE Moneda.nro_moneda.
DEFINE VARIABLE que_empresa LIKE Empresa.cdg_empresa.

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
&Scoped-define INTERNAL-TABLES Asn_detalle Asn_header Entidad Moneda Obra

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Asn_detalle.fecha_mayor ~
Asn_header.tip_comprob Asn_header.prf_comprob Asn_header.nro_comprob ~
Entidad.cdg_entidad Obra.cdg_obra Moneda.abrevia Asn_detalle.cambio ~
Asn_detalle.debito Asn_detalle.credito Asn_detalle.posteo ~
Asn_detalle.leyen_detalle 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table 
&Scoped-define QUERY-STRING-br_table FOR EACH Asn_detalle OF Cuenta WHERE ~{&KEY-PHRASE} ~
      AND Asn_detalle.cdg_empresa = que_empresa ~
 AND Asn_detalle.fecha_mayor <= has_fecha ~
 AND Asn_detalle.fecha_mayor >= des_fecha  ~
 AND Asn_detalle.nro_moneda = que_moneda ~
 AND Asn_detalle.reexpresion = v-reexpresado NO-LOCK, ~
      EACH Asn_header OF Asn_detalle NO-LOCK, ~
      FIRST Entidad OF Asn_detalle NO-LOCK, ~
      FIRST Moneda OF Asn_detalle NO-LOCK, ~
      EACH Obra OF Asn_detalle OUTER-JOIN NO-LOCK
&Scoped-define OPEN-QUERY-br_table OPEN QUERY br_table FOR EACH Asn_detalle OF Cuenta WHERE ~{&KEY-PHRASE} ~
      AND Asn_detalle.cdg_empresa = que_empresa ~
 AND Asn_detalle.fecha_mayor <= has_fecha ~
 AND Asn_detalle.fecha_mayor >= des_fecha  ~
 AND Asn_detalle.nro_moneda = que_moneda ~
 AND Asn_detalle.reexpresion = v-reexpresado NO-LOCK, ~
      EACH Asn_header OF Asn_detalle NO-LOCK, ~
      FIRST Entidad OF Asn_detalle NO-LOCK, ~
      FIRST Moneda OF Asn_detalle NO-LOCK, ~
      EACH Obra OF Asn_detalle OUTER-JOIN NO-LOCK.
&Scoped-define TABLES-IN-QUERY-br_table Asn_detalle Asn_header Entidad ~
Moneda Obra
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Asn_detalle
&Scoped-define SECOND-TABLE-IN-QUERY-br_table Asn_header
&Scoped-define THIRD-TABLE-IN-QUERY-br_table Entidad
&Scoped-define FOURTH-TABLE-IN-QUERY-br_table Moneda
&Scoped-define FIFTH-TABLE-IN-QUERY-br_table Obra


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS has_fecha v-reexpresado v-moneda ~
btn_imprimir des_fecha br_table RECT-1 
&Scoped-Define DISPLAYED-OBJECTS has_fecha v-reexpresado v-moneda des_fecha 

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
nro_asiento||y|sic.Asn_detalle.nro_asiento
nro_cuenta||y|sic.Asn_detalle.nro_cuenta
cdg_empresa||y|sic.Asn_detalle.cdg_empresa
nro_entidad||y|sic.Asn_detalle.nro_entidad
nro_moneda||y|sic.Asn_detalle.nro_moneda
nro_obra||y|sic.Asn_detalle.nro_obra
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = ,
     Keys-Supplied = "nro_asiento,nro_cuenta,cdg_empresa,nro_entidad,nro_moneda,nro_obra"':U).

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
DEFINE BUTTON btn_imprimir 
     LABEL "&Imprimir" 
     SIZE 14 BY 1.1.

DEFINE VARIABLE v-moneda AS CHARACTER FORMAT "X(256)":U 
     LABEL "Moneda" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "Item 1" 
     DROP-DOWN-LIST
     SIZE 45 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE des_fecha AS DATE FORMAT "99/99/99":U 
     LABEL "Del" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE has_fecha AS DATE FORMAT "99/99/99":U 
     LABEL "al" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE v-reexpresado AS LOGICAL 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Reexpresados", yes,
"M.Origen", no
     SIZE 33 BY 1.19 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 157 BY 1.62.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Asn_detalle, 
      Asn_header, 
      Entidad, 
      Moneda, 
      Obra SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _STRUCTURED
  QUERY br_table NO-LOCK DISPLAY
      Asn_detalle.fecha_mayor FORMAT "99/99/99":U
      Asn_header.tip_comprob COLUMN-LABEL "Tipo!Asto" FORMAT "X(3)":U
      Asn_header.prf_comprob FORMAT "9999":U
      Asn_header.nro_comprob COLUMN-LABEL "Número!Asiento" FORMAT ">>>>>>9":U
      Entidad.cdg_entidad FORMAT "X(8)":U
      Obra.cdg_obra FORMAT "X(8)":U
      Moneda.abrevia FORMAT "X(5)":U
      Asn_detalle.cambio FORMAT "->>,>>9.9999":U
      Asn_detalle.debito COLUMN-LABEL "Débito!Pesos" FORMAT "->>,>>>,>>9.99":U
      Asn_detalle.credito COLUMN-LABEL "Crédito!Pesos" FORMAT "->>,>>>,>>9.99":U
      Asn_detalle.posteo FORMAT "X(1)":U
      Asn_detalle.leyen_detalle FORMAT "X(50)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 157 BY 21.95
         BGCOLOR 15 FGCOLOR 9 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     has_fecha AT ROW 1.24 COL 30 COLON-ALIGNED
     v-reexpresado AT ROW 1.24 COL 50 NO-LABEL
     v-moneda AT ROW 1.24 COL 92 COLON-ALIGNED
     btn_imprimir AT ROW 1.24 COL 143
     des_fecha AT ROW 1.29 COL 6 COLON-ALIGNED
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
         HEIGHT             = 24.1
         WIDTH              = 160.
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
/* BROWSE-TAB br_table des_fecha F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _TblList          = "sic.Asn_detalle OF sic.Cuenta,sic.Asn_header OF sic.Asn_detalle,sic.Entidad OF sic.Asn_detalle,sic.Moneda OF sic.Asn_detalle,sic.Obra OF sic.Asn_detalle"
     _Options          = "NO-LOCK KEY-PHRASE"
     _TblOptList       = ",, FIRST, FIRST, OUTER"
     _Where[1]         = "Asn_detalle.cdg_empresa = que_empresa
 AND Asn_detalle.fecha_mayor <= has_fecha
 AND Asn_detalle.fecha_mayor >= des_fecha 
 AND Asn_detalle.nro_moneda = que_moneda
 AND Asn_detalle.reexpresion = v-reexpresado"
     _FldNameList[1]   = sic.Asn_detalle.fecha_mayor
     _FldNameList[2]   > sic.Asn_header.tip_comprob
"Asn_header.tip_comprob" "Tipo!Asto" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[3]   = sic.Asn_header.prf_comprob
     _FldNameList[4]   > sic.Asn_header.nro_comprob
"Asn_header.nro_comprob" "Número!Asiento" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[5]   = sic.Entidad.cdg_entidad
     _FldNameList[6]   = sic.Obra.cdg_obra
     _FldNameList[7]   = sic.Moneda.abrevia
     _FldNameList[8]   = sic.Asn_detalle.cambio
     _FldNameList[9]   > sic.Asn_detalle.debito
"Asn_detalle.debito" "Débito!Pesos" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[10]   > sic.Asn_detalle.credito
"Asn_detalle.credito" "Crédito!Pesos" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[11]   = sic.Asn_detalle.posteo
     _FldNameList[12]   = sic.Asn_detalle.leyen_detalle
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


&Scoped-define SELF-NAME btn_imprimir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_imprimir B-table-Win
ON CHOOSE OF btn_imprimir IN FRAME F-Main /* Imprimir */
DO:
   
    RUN lslibro_mayor.p
       ( INPUT  des_fecha         ,
         INPUT  has_fecha         ,
         INPUT  Cuenta.cdg_cuenta ,
         INPUT  Cuenta.cdg_cuenta ,
         INPUT  YES,
         INPUT  66,
         INPUT  0,
         INPUT  YES,
         INPUT  Moneda.cdg_moneda,
         INPUT  v-reexpresado     
       ).

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME des_fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL des_fecha B-table-Win
ON MOUSE-MENU-DOWN OF des_fecha IN FRAME F-Main /* Del */
DO:

  fecha_inicial = DATE(des_fecha:SCREEN-VALUE IN FRAME {&FRAME-NAME}) NO-ERROR.
  IF fecha_inicial = ? THEN fecha_inicial = TODAY.
  RUN d-calendario.w ( INPUT fecha_inicial, OUTPUT fecha_elegida).
  IF fecha_elegida <> ?
  THEN DO:
       DISPLAY fecha_elegida @ des_fecha 
               WITH FRAME {&FRAME-NAME}.
       APPLY "RETURN" TO SELF.        
  END.               
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL des_fecha B-table-Win
ON RETURN OF des_fecha IN FRAME F-Main /* Del */
DO:
  ASSIGN des_fecha.
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME has_fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL has_fecha B-table-Win
ON MOUSE-MENU-DOWN OF has_fecha IN FRAME F-Main /* al */
DO:

  fecha_inicial = DATE(has_fecha:SCREEN-VALUE IN FRAME {&FRAME-NAME}) NO-ERROR.
  IF fecha_inicial = ? THEN fecha_inicial = TODAY.
  RUN d-calendario.w ( INPUT fecha_inicial, OUTPUT fecha_elegida).
  IF fecha_elegida <> ?
  THEN DO:
       DISPLAY fecha_elegida @ has_fecha 
               WITH FRAME {&FRAME-NAME}.
       APPLY "TAB" TO SELF.        
  END.               
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL has_fecha B-table-Win
ON RETURN OF has_fecha IN FRAME F-Main /* al */
DO:
  ASSIGN has_fecha.
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-moneda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-moneda B-table-Win
ON VALUE-CHANGED OF v-moneda IN FRAME F-Main /* Moneda */
DO:
    FIND Moneda WHERE Moneda.descripcion = v-moneda:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
    que_moneda = Moneda.nro_moneda.
    RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-reexpresado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-reexpresado B-table-Win
ON VALUE-CHANGED OF v-reexpresado IN FRAME F-Main
DO:
  ASSIGN v-reexpresado.
  RUN dispatch IN THIS-PROCEDURE ('open-query').
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize B-table-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  DEFINE VARIABLE v-moneda_local AS CHARACTER.

  {findempresa.i}
  que_empresa = Empresa.cdg_empresa.
  
  FIND Moneda WHERE Moneda.es_local NO-LOCK.
  que_moneda = Moneda.nro_moneda.
  v-moneda_local = Moneda.descripcion.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  has_fecha = TODAY.
  des_fecha = has_fecha - 90.

  DEFINE VARIABLE ok AS LOGICAL.
  v-moneda:LIST-ITEMS IN FRAME {&FRAME-NAME} = "".
  FOR EACH Moneda:
      ok = v-moneda:ADD-FIRST(Moneda.descripcion) IN FRAME {&FRAME-NAME} .
  END.    

  v-moneda:SCREEN-VALUE IN FRAME {&FRAME-NAME} = v-moneda_local.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-open-query B-table-Win 
PROCEDURE local-open-query :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

/*
    MESSAGE "Cuenta:" Cuenta.cdg_cuenta SKIP
            "Empresa:" que_empresa SKIP
            "Desde:" STRING(des_fecha,"99/99/99") SKIP
            "Hasta:" STRING(has_fecha,"99/99/99") SKIP
            "Moneda:" STRING(que_moneda,"99") SKIP
            VIEW-AS ALERT-BOX MESSAGE TITLE "open-query".
*/

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'open-query':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

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
  {src/adm/template/sndkycas.i "nro_asiento" "Asn_detalle" "nro_asiento"}
  {src/adm/template/sndkycas.i "nro_cuenta" "Asn_detalle" "nro_cuenta"}
  {src/adm/template/sndkycas.i "cdg_empresa" "Asn_detalle" "cdg_empresa"}
  {src/adm/template/sndkycas.i "nro_entidad" "Asn_detalle" "nro_entidad"}
  {src/adm/template/sndkycas.i "nro_moneda" "Asn_detalle" "nro_moneda"}
  {src/adm/template/sndkycas.i "nro_obra" "Asn_detalle" "nro_obra"}

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
  {src/adm/template/snd-list.i "Asn_detalle"}
  {src/adm/template/snd-list.i "Asn_header"}
  {src/adm/template/snd-list.i "Entidad"}
  {src/adm/template/snd-list.i "Moneda"}
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

