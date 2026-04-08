&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW

/* Temp-Table and Buffer definitions                                    */
DEFINE BUFFER B-Cta_cte FOR Cta_cte.


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

{VRSHARED.I "NEW"}

DEFINE VARIABLE que_moneda LIKE Moneda.nro_moneda INITIAL 10.
DEFINE VARIABLE ant_anulado AS LOGICAL.
DEFINE VARIABLE liber AS CHARACTER INITIAL "L".
DEFINE VARIABLE nolib AS CHARACTER INITIAL "S".
DEFINE VARIABLE todos AS CHARACTER INITIAL "T".

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
&Scoped-define EXTERNAL-TABLES Cliente
&Scoped-define FIRST-EXTERNAL-TABLE Cliente


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Cliente.
/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Cta_cte Imputacion

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Cta_cte.liberada ~
Cta_cte.fecha_emision Cta_cte.tip_comprob Cta_cte.prf_comprob ~
Cta_cte.nro_comprob Cta_cte.nro_vencimiento Imputacion.abrevia ~
Cta_cte.fecha_vencimiento Cta_cte.debito - Cta_cte.credito @ V-SALDO ~
Cta_cte.leyenda 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table 
&Scoped-define OPEN-QUERY-br_table OPEN QUERY br_table FOR EACH Cta_cte OF Cliente WHERE ~{&KEY-PHRASE} ~
      AND Cta_cte.cdg_empresa = Empresa.cdg_empresa ~
 AND Cta_cte.credito <> Cta_cte.debito ~
 AND Cta_cte.nro_moneda = que_moneda NO-LOCK, ~
      EACH Imputacion OF Cta_cte NO-LOCK.
&Scoped-define TABLES-IN-QUERY-br_table Cta_cte Imputacion
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Cta_cte
&Scoped-define SECOND-TABLE-IN-QUERY-br_table Imputacion


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS des_fecha que_modo id_moneda btn_imprimir ~
has_fecha br_table RECT-1 
&Scoped-Define DISPLAYED-OBJECTS des_fecha que_modo id_moneda has_fecha ~
v-saldo 

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
nro_cliente||y|sic.Cta_cte.nro_cliente
nro_cobrador||y|sic.Cta_cte.nro_cobrador
cdg_imputacion||y|sic.Cta_cte.cdg_imputacion
nro_moneda||y|sic.Cta_cte.nro_moneda
nro_proveedor||y|sic.Cta_cte.nro_proveedor
nro_vendedor||y|sic.Cta_cte.nro_vendedor
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = ,
     Keys-Supplied = "nro_cliente,nro_cobrador,cdg_imputacion,nro_moneda,nro_proveedor,nro_vendedor"':U).

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
     SIZE 16 BY 1.33.

DEFINE VARIABLE id_moneda AS CHARACTER FORMAT "X(256)":U 
     LABEL "Moneda" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "Item 1" 
     DROP-DOWN-LIST
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE des_fecha AS DATE FORMAT "99/99/99":U 
     LABEL "Desde Fecha" 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE has_fecha AS DATE FORMAT "99/99/99":U 
     LABEL "Hasta Fecha" 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-saldo AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     LABEL "Saldo" 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE que_modo AS CHARACTER INITIAL "S" 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Sin Liberar", "S",
"Liberados", "L",
"Todos", "T"
     SIZE 12 BY 1.86 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 107 BY 2.43.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Cta_cte, 
      Imputacion SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _STRUCTURED
  QUERY br_table NO-LOCK DISPLAY
      Cta_cte.liberada COLUMN-LABEL "Libe!rada" FORMAT "L/R":U
      Cta_cte.fecha_emision FORMAT "99/99/9999":U
      Cta_cte.tip_comprob COLUMN-LABEL "Tip!Com" FORMAT "X(3)":U
      Cta_cte.prf_comprob COLUMN-LABEL "Pto!Vta" FORMAT "9999":U
      Cta_cte.nro_comprob COLUMN-LABEL "Número!Comprob" FORMAT "ZZZZZZZ9":U
      Cta_cte.nro_vencimiento FORMAT ">>9":U
      Imputacion.abrevia COLUMN-LABEL "Concepto!Documto." FORMAT "X(5)":U
      Cta_cte.fecha_vencimiento COLUMN-LABEL "Fecha!Vencto." FORMAT "99/99/9999":U
      Cta_cte.debito - Cta_cte.credito @ V-SALDO COLUMN-LABEL "Saldo!Comprobante"
      Cta_cte.leyenda FORMAT "X(30)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 115 BY 15.33
         BGCOLOR 11 FGCOLOR 9 FONT 4
         TITLE BGCOLOR 11 FGCOLOR 9 "Movimientos de Cuenta Corriente del Cliente".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     des_fecha AT ROW 1.24 COL 16 COLON-ALIGNED
     que_modo AT ROW 1.24 COL 36 NO-LABEL
     id_moneda AT ROW 1.24 COL 61 COLON-ALIGNED
     btn_imprimir AT ROW 1.52 COL 89
     has_fecha AT ROW 2.14 COL 16 COLON-ALIGNED
     v-saldo AT ROW 2.24 COL 61 COLON-ALIGNED
     br_table AT ROW 3.76 COL 1
     RECT-1 AT ROW 1 COL 1
     "Saldo:" VIEW-AS TEXT
          SIZE 6 BY .52 AT ROW 1.71 COL 29
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         BGCOLOR 8 FGCOLOR 0 FONT 4.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartBrowser
   External Tables: sic.Cliente
   Allow: Basic,Browse
   Frames: 1
   Add Fields to: EXTERNAL-TABLES
   Other Settings: PERSISTENT-ONLY COMPILE
   Temp-Tables and Buffers:
      TABLE: B-Cta_cte B "?" ? sic Cta_cte
   END-TABLES.
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
/* BROWSE-TAB br_table v-saldo F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN v-saldo IN FRAME F-Main
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _TblList          = "sic.Cta_cte OF sic.Cliente,sic.Imputacion OF sic.Cta_cte"
     _Options          = "NO-LOCK KEY-PHRASE"
     _Where[1]         = "Cta_cte.cdg_empresa = Empresa.cdg_empresa
 AND Cta_cte.credito <> Cta_cte.debito
 AND Cta_cte.nro_moneda = que_moneda"
     _FldNameList[1]   > sic.Cta_cte.liberada
"Cta_cte.liberada" "Libe!rada" ? "logical" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[2]   = sic.Cta_cte.fecha_emision
     _FldNameList[3]   > sic.Cta_cte.tip_comprob
"Cta_cte.tip_comprob" "Tip!Com" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[4]   > sic.Cta_cte.prf_comprob
"Cta_cte.prf_comprob" "Pto!Vta" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[5]   > sic.Cta_cte.nro_comprob
"Cta_cte.nro_comprob" "Número!Comprob" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[6]   = sic.Cta_cte.nro_vencimiento
     _FldNameList[7]   > sic.Imputacion.abrevia
"Imputacion.abrevia" "Concepto!Documto." ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[8]   > sic.Cta_cte.fecha_vencimiento
"Cta_cte.fecha_vencimiento" "Fecha!Vencto." ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[9]   > "_<CALC>"
"Cta_cte.debito - Cta_cte.credito @ V-SALDO" "Saldo!Comprobante" ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[10]   > sic.Cta_cte.leyenda
"Cta_cte.leyenda" ? "X(30)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
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
ON MOUSE-SELECT-DBLCLICK OF br_table IN FRAME F-Main /* Movimientos de Cuenta Corriente del Cliente */
OR "INSERT-MODE" OF {&BROWSE-NAME}
DO:
  
  IF NOT AVAILABLE Cta_cte
  THEN DO:
     BELL.
     MESSAGE "No hay documentos que puedan consultarse"
       VIEW-AS ALERT-BOX ERROR BUTTONS OK.
     RETURN NO-APPLY.
  END.

  FIND CURRENT Cta_cte EXCLUSIVE-LOCK.
  Cta_cte.liberada = NOT Cta_cte.liberada.
  DISPLAY Cta_cte.liberada WITH BROWSE {&BROWSE-NAME}.
  FIND CURRENT Cta_cte NO-LOCK.
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON RETURN OF br_table IN FRAME F-Main /* Movimientos de Cuenta Corriente del Cliente */
DO:
  IF NOT AVAILABLE Cta_cte 
  THEN DO:
     BELL.
     MESSAGE "No hay documentos que puedan consultarse"
       VIEW-AS ALERT-BOX ERROR BUTTONS OK.
     RETURN NO-APPLY.
  END.

  IF CAN-DO(str_debitan,"FA,FB,FE,CA,CB,CE")
  THEN DO:
     FIND Fac_header WHERE Cta_cte.tip_comprob = Fac_header.tip_comprob
                       AND Cta_cte.nro_comprob = Fac_header.nro_comprob
                       AND Cta_cte.prf_comprob = Fac_header.prf_comprob NO-ERROR.
     IF AVAILABLE Fac_header
     THEN DO:                  
        act_fac_head = ROWID(Fac_header).
        ant_anulado = Fac_header.anulado. 
        HIDE FRAME frm-cliente NO-PAUSE.
        IF CAN-DO(str_debitan,"FA,FB,FE") 
        THEN DO: 
           RUN ABMAEFAC.P (INPUT 2).
        END.
        ELSE DO: 
           RUN ABMAECDV.P (INPUT 2).
        END.
     END.
     ELSE DO:
          FIND Rec_header WHERE Cta_cte.tip_comprob = Rec_header.tip_comprob
                            AND Cta_cte.nro_comprob = Rec_header.nro_comprob.
          IF AVAILABLE Rec_header
          THEN DO:                  
               act_rec_head = ROWID(Rec_header).
               ant_anulado = Rec_header.anulado. 
               HIDE FRAME frm-cliente NO-PAUSE.
               CASE Rec_header.tip_comprob:
                    WHEN "CA" THEN RUN ABMAECRD.P ( INPUT 2 ).
                    WHEN "CB" THEN RUN ABMAECRD.P ( INPUT 2 ).
                    WHEN "CE" THEN RUN ABMAECRD.P ( INPUT 2 ).         
               END CASE.
          END.
/*        RUN PONMENSJ.P ( INPUT "DOCS014" ).
        RETURN NO-APPLY.*/
     END.
  END.
  ELSE DO:
     FIND Rec_header WHERE Cta_cte.tip_comprob = Rec_header.tip_comprob
                       AND Cta_cte.nro_comprob = Rec_header.nro_comprob.
     IF AVAILABLE Rec_header
     THEN DO:                  
        act_rec_head = ROWID(Rec_header).
        ant_anulado = Rec_header.anulado. 
        HIDE FRAME frm-cliente NO-PAUSE.
        CASE Rec_header.tip_comprob:
          WHEN "RA" THEN RUN ABMAEREC.P  ( INPUT 2 ).
          WHEN "RB" THEN RUN ABMAEREC.P  ( INPUT 2 ).
          WHEN "CA" THEN RUN ABMAECRD.P  ( INPUT 2 ).
          WHEN "CB" THEN RUN ABMAECRD.P  ( INPUT 2 ).
          WHEN "CE" THEN RUN ABMAECRD.P  ( INPUT 2 ).         
          WHEN "DA" THEN RUN ABMAEDEB.P  ( INPUT 2 ).
          WHEN "DB" THEN RUN ABMAEDEB.P  ( INPUT 2 ).
          WHEN "CI" THEN RUN ABMAECRDI.P ( INPUT 2 ).
          WHEN "DI" THEN RUN ABMAEDEBI.P ( INPUT 2 ).
        END CASE.
     END.   
     ELSE DO:
        RUN PONMENSJ.P ( INPUT "DOCS014" ).
        RETURN NO-APPLY.
     END.
  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-ENTRY OF br_table IN FRAME F-Main /* Movimientos de Cuenta Corriente del Cliente */
DO:
  /* This code displays initial values for newly added or copied rows. */
  {src/adm/template/brsentry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-LEAVE OF br_table IN FRAME F-Main /* Movimientos de Cuenta Corriente del Cliente */
DO:
    /* Do not disable this code or no updates will take place except
     by pressing the Save button on an Update SmartPanel. */
   {src/adm/template/brsleave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON VALUE-CHANGED OF br_table IN FRAME F-Main /* Movimientos de Cuenta Corriente del Cliente */
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

   RUN LISLBCLI.P (INPUT ROWID(Cliente),
                   INPUT des_fecha,
                   INPUT has_fecha).

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME des_fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL des_fecha B-table-Win
ON LEAVE OF des_fecha IN FRAME F-Main /* Desde Fecha */
DO:

  IF DATE(des_fecha:SCREEN-VALUE) <> des_fecha
  THEN DO:
       ASSIGN des_fecha.
       RUN dispatch IN THIS-PROCEDURE ('open-query':U).
  END.     

END.

RUN CARPARAM.P.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME has_fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL has_fecha B-table-Win
ON LEAVE OF has_fecha IN FRAME F-Main /* Hasta Fecha */
DO:

  IF DATE(has_fecha:SCREEN-VALUE) <> has_fecha
  THEN DO:
       ASSIGN has_fecha.
       RUN dispatch IN THIS-PROCEDURE ('open-query':U).
  END.     
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME id_moneda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL id_moneda B-table-Win
ON VALUE-CHANGED OF id_moneda IN FRAME F-Main /* Moneda */
DO:
    FIND Moneda WHERE Moneda.descripcion = id_moneda:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
    que_moneda = Moneda.nro_moneda.
    RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME que_modo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_modo B-table-Win
ON VALUE-CHANGED OF que_modo IN FRAME F-Main
DO:
  ASSIGN que_modo.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE calcular_analitico B-table-Win 
PROCEDURE calcular_analitico :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   DEFINE OUTPUT PARAMETER saldo AS DECIMAL.

   DEFINE VARIABLE tot_debitogr AS DECIMAL.
   DEFINE VARIABLE tot_creditogr AS DECIMAL.

   tot_debitogr = 0.
   tot_creditogr = 0.

   /* Busca por Movimiento en el rango de fechas */
   FOR EACH B-Cta_cte OF Cliente
      WHERE B-Cta_cte.cdg_empresa = Empresa.cdg_empresa
        AND B-Cta_cte.nro_moneda = Moneda.nro_moneda
        AND B-Cta_cte.debito <> B-Cta_cte.credito:

        tot_debitogr  = tot_debitogr  + B-Cta_cte.debito.
        tot_creditogr = tot_creditogr + B-Cta_cte.credito.

   END.

   saldo = tot_debitogr - tot_creditogr.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE calcular_historico B-table-Win 
PROCEDURE calcular_historico :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   DEFINE OUTPUT PARAMETER saldo AS DECIMAL.

   DEFINE VARIABLE tot_debitogr AS DECIMAL.
   DEFINE VARIABLE tot_creditogr AS DECIMAL.

   tot_debitogr = 0.
   tot_creditogr = 0.

   /* Busca por Movimiento desde principio de mes a la fecha */
   FOR EACH B-Cta_cte OF Cliente 
      WHERE B-Cta_cte.cdg_empresa = Empresa.cdg_empresa
        AND B-Cta_cte.nro_moneda = Moneda.nro_moneda
        AND B-Cta_cte.fecha_emision <= has_fecha 
        AND B-Cta_cte.nro_moneda = Moneda.nro_moneda:

      IF CAN-DO(str_debitan,B-Cta_cte.tip_comprob)
         THEN tot_debitogr  = tot_debitogr + B-Cta_cte.debito.
         ELSE tot_creditogr = tot_creditogr + B-Cta_cte.credito.

   END.

   saldo = tot_debitogr - tot_creditogr.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE calcular_vencido B-table-Win 
PROCEDURE calcular_vencido :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   DEFINE OUTPUT PARAMETER saldo AS DECIMAL.

   DEFINE VARIABLE tot_debitogr AS DECIMAL.
   DEFINE VARIABLE tot_creditogr AS DECIMAL.

   tot_debitogr = 0.
   tot_creditogr = 0.

   /* Busca por Movimiento en el rango de fechas */
   FOR EACH B-Cta_cte OF Cliente 
      WHERE B-Cta_cte.cdg_empresa = Empresa.cdg_empresa
        AND B-Cta_cte.nro_moneda = Moneda.nro_moneda
        AND B-Cta_cte.fecha_vencimiento <= has_fecha
        AND B-Cta_cte.debito <> B-Cta_cte.credito:

        tot_debitogr  = tot_debitogr  + B-Cta_cte.debito.
        tot_creditogr = tot_creditogr + B-Cta_cte.credito.

   END.

   saldo = tot_debitogr - tot_creditogr.

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE fijar_moneda B-table-Win 
PROCEDURE fijar_moneda :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER numero_moneda LIKE Moneda.nro_moneda.
  
  que_moneda = numero_moneda.
  
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).

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

  FIND FIRST Moneda NO-LOCK.
  que_moneda = Moneda.nro_moneda.

  {findempresa.i}

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  DEFINE VARIABLE ok AS LOGICAL.
  id_moneda:LIST-ITEMS IN FRAME {&FRAME-NAME} = "".
  FOR EACH Moneda:
      ok = id_moneda:ADD-FIRST(Moneda.descripcion) IN FRAME {&FRAME-NAME} .
  END.    

  has_fecha = TODAY.
  des_fecha = has_fecha - 90.

  FIND Moneda WHERE Moneda.nro_moneda = que_moneda NO-LOCK.
  id_moneda:SCREEN-VALUE IN FRAME {&FRAME-NAME} = Moneda.descripcion.

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

  /* Dispatch standard ADM method.                             */
/*  RUN dispatch IN THIS-PROCEDURE ( INPUT 'open-query':U ) .*/

  /* Code placed here will execute AFTER standard behavior.    */

    DEFINE VARIABLE his            AS   INTEGER INITIAL 0.
    DEFINE VARIABLE anl            AS   INTEGER INITIAL 1.
    DEFINE VARIABLE ven            AS   INTEGER INITIAL 2.
     /*
     
     */
       /*------------------------------------------------------
        message "cliente esta:" string(available cliente) skip
                " desde fecha:" string(des_fecha) skip
                " hasta fecha:" string(has_fecha) skip
                " que moneda:" string(que_moneda) skip
                "      his:" string(que_modo = his) skip
                "      anl:" string(que_modo = anl) skip
                "      ven:" string(que_modo = ven) skip
                view-as alert-box.
        -------------------------------------------------------*/

            message "modo" que_modo view-as alert-box message.

    CASE que_modo:
  
         WHEN liber THEN  OPEN QUERY {&BROWSE-NAME}       
                             FOR EACH Cta_cte OF Cliente 
                                WHERE Cta_cte.fecha_emision >= des_fecha 
                                  AND Cta_cte.fecha_emision <= has_fecha
                                  AND Cta_cte.debito <> Cta_cte.credito
                                  AND Cta_cte.cdg_empresa = Empresa.cdg_empresa
                                  AND Cta_cte.nro_moneda = que_moneda
                                  AND Cta_cte.liberada,
                                 EACH Imputacion OF Cta_cte
                                   BY Cta_cte.fecha_emision. 
  
         WHEN nolib THEN  OPEN QUERY {&BROWSE-NAME}       
                             FOR EACH Cta_cte OF Cliente 
                                WHERE Cta_cte.fecha_emision >= des_fecha 
                                  AND Cta_cte.fecha_emision <= has_fecha
                                  AND Cta_cte.debito <> Cta_cte.credito
                                  AND Cta_cte.cdg_empresa = Empresa.cdg_empresa
                                  AND Cta_cte.nro_moneda = que_moneda
                                  AND NOT Cta_cte.liberada,
                                 EACH Imputacion OF Cta_cte
                                   BY Cta_cte.fecha_emision. 
  
         WHEN todos THEN  OPEN QUERY {&BROWSE-NAME}       
                             FOR EACH Cta_cte OF Cliente 
                                WHERE Cta_cte.fecha_emision >= des_fecha 
                                  AND Cta_cte.fecha_emision <= has_fecha
                                  AND Cta_cte.debito <> Cta_cte.credito
                                  AND Cta_cte.cdg_empresa = Empresa.cdg_empresa
                                  AND Cta_cte.nro_moneda = que_moneda,
                                 EACH Imputacion OF Cta_cte
                                   BY Cta_cte.fecha_emision. 
  
  
    END CASE.
/*
    CASE que_modo:
          WHEN his 
          THEN DO:
               des_fecha:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
               has_fecha:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
               RUN calcular_historico (OUTPUT v-saldo).
          END.     
          WHEN anl 
          THEN DO:
               des_fecha:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
               has_fecha:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
               RUN calcular_analitico (OUTPUT v-saldo).
          END.     
          WHEN ven 
          THEN DO:
               des_fecha:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
               has_fecha:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
               RUN calcular_vencido (OUTPUT v-saldo).
          END.     
    END CASE.     
    DISPLAY v-saldo WITH FRAME {&FRAME-NAME}.
*/
    RUN dispatch IN THIS-PROCEDURE ('row-changed':U).

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
  {src/adm/template/sndkycas.i "nro_cliente" "Cta_cte" "nro_cliente"}
  {src/adm/template/sndkycas.i "nro_cobrador" "Cta_cte" "nro_cobrador"}
  {src/adm/template/sndkycas.i "cdg_imputacion" "Cta_cte" "cdg_imputacion"}
  {src/adm/template/sndkycas.i "nro_moneda" "Cta_cte" "nro_moneda"}
  {src/adm/template/sndkycas.i "nro_proveedor" "Cta_cte" "nro_proveedor"}
  {src/adm/template/sndkycas.i "nro_vendedor" "Cta_cte" "nro_vendedor"}

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
  {src/adm/template/snd-list.i "Cliente"}
  {src/adm/template/snd-list.i "Cta_cte"}
  {src/adm/template/snd-list.i "Imputacion"}

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

