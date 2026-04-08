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

DEFINE VARIABLE que_empresa LIKE Empresa.cdg_empresa.
DEFINE VARIABLE fecha_inicial AS DATE.
DEFINE VARIABLE fecha_elegida AS DATE.

DEF VAR hcproc AS CHAR NO-UNDO.
DEF VAR hproc AS HANDLE NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartBrowser
&Scoped-define DB-AWARE no

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME F-Main
&Scoped-define BROWSE-NAME br_table

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES Contrato_hd
&Scoped-define FIRST-EXTERNAL-TABLE Contrato_hd


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Contrato_hd.
/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Cta_cte Imputacion

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Cta_cte.fecha_emision ~
Cta_cte.tip_comprob Cta_cte.prf_comprob Cta_cte.nro_comprob ~
Cta_cte.nro_vencimiento Imputacion.abrevia Cta_cte.fecha_vencimiento ~
Cta_cte.debito Cta_cte.credito Cta_cte.cambio Cta_cte.cambio_dolar ~
Cta_cte.clausula_dolar Cta_cte.es_difcambio Cta_cte.leyenda 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table 
&Scoped-define QUERY-STRING-br_table FOR EACH Cta_cte WHERE Cta_cte.nro_contrato = Contrato_hd.nro_contrato and ~
cta_cte.nro_cliente = contrato_hd.nro_cliente NO-LOCK, ~
      EACH Imputacion OF Cta_cte NO-LOCK
&Scoped-define OPEN-QUERY-br_table OPEN QUERY br_table FOR EACH Cta_cte WHERE Cta_cte.nro_contrato = Contrato_hd.nro_contrato and ~
cta_cte.nro_cliente = contrato_hd.nro_cliente NO-LOCK, ~
      EACH Imputacion OF Cta_cte NO-LOCK.
&Scoped-define TABLES-IN-QUERY-br_table Cta_cte Imputacion
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Cta_cte
&Scoped-define SECOND-TABLE-IN-QUERY-br_table Imputacion


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-1 des_fecha ficha id_moneda ~
btn_imprimir btn_integral has_fecha btn_consolidado btn_verificar br_table 
&Scoped-Define DISPLAYED-OBJECTS des_fecha ficha id_moneda has_fecha ~
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
DEFINE BUTTON btn_consolidado 
     LABEL "&Consolidado" 
     SIZE 19 BY 1.14.

DEFINE BUTTON btn_imprimir 
     LABEL "&Imprimir" 
     SIZE 19 BY 1.14.

DEFINE BUTTON btn_integral 
     LABEL "&Integral" 
     SIZE 17 BY 1.19.

DEFINE BUTTON btn_verificar 
     LABEL "&Verificar" 
     SIZE 17 BY 1.19.

DEFINE VARIABLE id_moneda AS CHARACTER FORMAT "X(256)":U 
     LABEL "Moneda" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "Item 1" 
     DROP-DOWN-LIST
     SIZE 27 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE des_fecha AS DATE FORMAT "99/99/99":U 
     LABEL "Del" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 14 BY 1
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE has_fecha AS DATE FORMAT "99/99/99":U 
     LABEL "al" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 14 BY 1
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE v-saldo AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     LABEL "Saldo" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 27 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE ficha AS INTEGER INITIAL 2 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Histórico", 0,
"Analítico", 1,
"Vencido", 2
     SIZE 12 BY 2.38 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 144 BY 2.86.

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
      Cta_cte.fecha_emision FORMAT "99/99/9999":U
      Cta_cte.tip_comprob COLUMN-LABEL "Tip!Com" FORMAT "X(3)":U
      Cta_cte.prf_comprob COLUMN-LABEL "Pto!Vta" FORMAT "9999":U
      Cta_cte.nro_comprob COLUMN-LABEL "Número!Comprob" FORMAT "ZZZZZZZ9":U
      Cta_cte.nro_vencimiento FORMAT ">>9":U
      Imputacion.abrevia COLUMN-LABEL "Concepto!Documto." FORMAT "X(5)":U
      Cta_cte.fecha_vencimiento COLUMN-LABEL "Fecha!Vencto." FORMAT "99/99/9999":U
      Cta_cte.debito FORMAT "-ZZZ,ZZZ,ZZ9.99":U
      Cta_cte.credito FORMAT "-ZZZ,ZZZ,ZZ9.99":U
      Cta_cte.cambio FORMAT "->>,>>9.9999":U
      Cta_cte.cambio_dolar COLUMN-LABEL "Valor!Dólar" FORMAT "->>,>>9.9999":U
      Cta_cte.clausula_dolar FORMAT "Si/No":U
      Cta_cte.es_difcambio FORMAT "Si/No":U
      Cta_cte.leyenda FORMAT "X(24)":U WIDTH 4.2
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 145 BY 14.05
         BGCOLOR 15 FGCOLOR 9 FONT 4
         TITLE BGCOLOR 15 FGCOLOR 9 "Movimientos de Cuenta Corriente del Cliente" ROW-HEIGHT-CHARS .71 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     des_fecha AT ROW 1.24 COL 6 COLON-ALIGNED
     ficha AT ROW 1.24 COL 31 NO-LABEL
     id_moneda AT ROW 1.24 COL 57 COLON-ALIGNED
     btn_imprimir AT ROW 1.24 COL 107 WIDGET-ID 4
     btn_integral AT ROW 1.24 COL 127 WIDGET-ID 6
     has_fecha AT ROW 2.43 COL 6 COLON-ALIGNED
     v-saldo AT ROW 2.43 COL 57 COLON-ALIGNED
     btn_consolidado AT ROW 2.43 COL 107 WIDGET-ID 2
     btn_verificar AT ROW 2.43 COL 127 WIDGET-ID 8
     br_table AT ROW 4.1 COL 1
     "Saldo:" VIEW-AS TEXT
          SIZE 6 BY .52 AT ROW 1.95 COL 24
     RECT-1 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         BGCOLOR 8 FGCOLOR 0 FONT 4.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartBrowser
   External Tables: sic.Contrato_hd
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
         HEIGHT             = 17.14
         WIDTH              = 145.
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
   NOT-VISIBLE FRAME-NAME Size-to-Fit                                   */
/* BROWSE-TAB br_table btn_verificar F-Main */
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
     _TblList          = "sic.Cta_cte WHERE sic.Contrato_hd  ...,sic.Imputacion OF sic.Cta_cte"
     _Options          = "NO-LOCK KEY-PHRASE"
     _JoinCode[1]      = "Cta_cte.nro_contrato = Contrato_hd.nro_contrato and
cta_cte.nro_cliente = contrato_hd.nro_cliente"
     _FldNameList[1]   = sic.Cta_cte.fecha_emision
     _FldNameList[2]   > sic.Cta_cte.tip_comprob
"Cta_cte.tip_comprob" "Tip!Com" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > sic.Cta_cte.prf_comprob
"Cta_cte.prf_comprob" "Pto!Vta" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > sic.Cta_cte.nro_comprob
"Cta_cte.nro_comprob" "Número!Comprob" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   = sic.Cta_cte.nro_vencimiento
     _FldNameList[6]   > sic.Imputacion.abrevia
"Imputacion.abrevia" "Concepto!Documto." ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > sic.Cta_cte.fecha_vencimiento
"Cta_cte.fecha_vencimiento" "Fecha!Vencto." ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   = sic.Cta_cte.debito
     _FldNameList[9]   = sic.Cta_cte.credito
     _FldNameList[10]   = sic.Cta_cte.cambio
     _FldNameList[11]   > sic.Cta_cte.cambio_dolar
"Cta_cte.cambio_dolar" "Valor!Dólar" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > sic.Cta_cte.clausula_dolar
"Cta_cte.clausula_dolar" ? "Si/No" "logical" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > sic.Cta_cte.es_difcambio
"Cta_cte.es_difcambio" ? "Si/No" "logical" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > sic.Cta_cte.leyenda
"Cta_cte.leyenda" ? "X(24)" "character" ? ? ? ? ? ? no ? no no "4.2" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
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
ON CTRL-SHIFT-DEL OF br_table IN FRAME F-Main /* Movimientos de Cuenta Corriente del Cliente */
DO:
  DEFINE VARIABLE que AS LOGICAL.
  que = NO.
  MESSAGE "Confirma que desea eliminar este registro?"
          VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE que .
  IF que 
  THEN DO:
       DO TRANSACTION:
          CREATE Logmenu.
          ASSIGN Logmenu.accion = "baja-cc"
                 Logmenu.cdg_empresa = Cta_cte.cdg_empresa 
                 Logmenu.cdg_item  = "" 
                 Logmenu.fch_desde = TODAY
                 Logmenu.hms_desde = STRING(TIME,"HH:MM:SS")
                 Logmenu.hor_desde = TIME
                 Logmenu.fch_hasta = Logmenu.fch_desde
                 Logmenu.hms_hasta = Logmenu.hms_desde 
                 Logmenu.hor_hasta = Logmenu.hor_desde
                 Logmenu.nro_usuario = Usuario.nro_usuario.
          RELEASE Logmenu.
          FIND CURRENT Cta_cte EXCLUSIVE-LOCK.
          DELETE Cta_cte.

       END.
       RUN dispatch IN THIS-PROCEDURE ('open-query':U).
  END.        
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON CTRL-SHIFT-ENTER OF br_table IN FRAME F-Main /* Movimientos de Cuenta Corriente del Cliente */
DO:

   DO TRANSACTION:
       FIND CURRENT Cta_cte EXCLUSIVE-LOCK.
       DISPLAY Cta_cte WITH 2 COLUMNS SIDE-LABELS THREE-D VIEW-AS DIALOG-BOX
               FRAME f-actualiza.
       UPDATE  Cta_cte EXCEPT Cta_cte.nro_cliente Cta_cte.nro_contrato Cta_cte.cdg_empresa
               WITH 2 COLUMNS SIDE-LABELS THREE-D VIEW-AS DIALOG-BOX
               FRAME f-actualiza.

       CREATE Logmenu.
       ASSIGN Logmenu.accion = "corrige-cc"
              Logmenu.cdg_empresa = Cta_cte.cdg_empresa 
              Logmenu.cdg_item  = "" 
              Logmenu.fch_desde = TODAY
              Logmenu.hms_desde = STRING(TIME,"HH:MM:SS")
              Logmenu.hor_desde = TIME
              Logmenu.fch_hasta = Logmenu.fch_desde
              Logmenu.hms_hasta = Logmenu.hms_desde 
              Logmenu.hor_hasta = Logmenu.hor_desde
              Logmenu.nro_usuario = Usuario.nro_usuario.
       RELEASE Logmenu.

    END.
    RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON CTRL-SHIFT-INS OF br_table IN FRAME F-Main /* Movimientos de Cuenta Corriente del Cliente */
DO:
  
    DO TRANSACTION:
       CREATE Cta_cte.
       ASSIGN Cta_cte.nro_contrato = contrato_hd.nro_contrato
              Cta_cte.cdg_empresa = Empresa.cdg_empresa.
       DISPLAY Cta_cte WITH 2 COLUMNS SIDE-LABELS THREE-D VIEW-AS DIALOG-BOX
               FRAME f-actualiza.
       UPDATE  Cta_cte EXCEPT Cta_cte.nro_contrato Cta_cte.cdg_empresa
               WITH 2 COLUMNS SIDE-LABELS THREE-D VIEW-AS DIALOG-BOX
               FRAME f-actualiza.
       CREATE Logmenu.
       ASSIGN Logmenu.accion = "alta-cc"
              Logmenu.cdg_empresa = Cta_cte.cdg_empresa 
              Logmenu.cdg_item  = "" 
              Logmenu.fch_desde = TODAY
              Logmenu.hms_desde = STRING(TIME,"HH:MM:SS")
              Logmenu.hor_desde = TIME
              Logmenu.fch_hasta = Logmenu.fch_desde
              Logmenu.hms_hasta = Logmenu.hms_desde 
              Logmenu.hor_hasta = Logmenu.hor_desde
              Logmenu.nro_usuario = Usuario.nro_usuario.
       RELEASE Logmenu.
    END.
    RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON MOUSE-SELECT-DBLCLICK OF br_table IN FRAME F-Main /* Movimientos de Cuenta Corriente del Cliente */
OR "RETURN" OF br_table IN FRAME {&FRAME-NAME}
DO:
    DEF VAR que_programa AS CHAR NO-UNDO.
  RUN getparametro_c.p("CONCOMCL", OUTPUT que_programa).
  IF que_programa = "" THEN que_programa = "c-comprobante_cliente.w".

  IF NOT AVAILABLE Cta_cte 
  THEN DO:
     BELL.
     MESSAGE "No hay documentos que puedan consultarse"
       VIEW-AS ALERT-BOX ERROR BUTTONS OK.
     RETURN NO-APPLY.
  END.
  ELSE DO:
     FIND Fac_header WHERE Cta_cte.cdg_empresa = Fac_header.cdg_empresa
                       AND Cta_cte.tip_comprob = Fac_header.tip_comprob
                       AND Cta_cte.nro_comprob = Fac_header.nro_comprob
                       AND Cta_cte.prf_comprob = Fac_header.prf_comprob NO-ERROR.
     IF AVAILABLE Fac_header
     THEN DO:                  
          act_fac_head = ROWID(Fac_header).
          ant_anulado = Fac_header.anulado. 
          RUN ocultar_window.
          RUN value(que_programa) ( INPUT-OUTPUT act_fac_head , INPUT 2, INPUT Fac_header.cdg_comprobante ).
          RUN mostrar_window.
     END.
     ELSE DO:
          FIND Rec_header WHERE Cta_cte.cdg_empresa = Rec_header.cdg_empresa
                            AND Cta_cte.tip_comprob = Rec_header.tip_comprob
                            AND Cta_cte.nro_comprob = Rec_header.nro_comprob
                            AND Cta_cte.prf_comprob = Rec_header.prf_comprob 
                                NO-ERROR.
          IF AVAILABLE Rec_header
          THEN DO:                  
               act_rec_head = ROWID(Rec_header).
               ant_anulado = Rec_header.anulado. 
               RUN ocultar_window.
               RUN c-recibo_de_pago.w ( INPUT-OUTPUT act_rec_head , INPUT 2 ).
               RUN mostrar_window.
          END.
          ELSE DO:
               RUN PONMENSJ.P ( INPUT "DOCS014" ).
               RETURN NO-APPLY.
          END.
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


&Scoped-define SELF-NAME btn_consolidado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_consolidado B-table-Win
ON CHOOSE OF btn_consolidado IN FRAME F-Main /* Consolidado */
DO:

     RUN LISCCCLICONS_ctacte.P (INPUT ROWID(contrato_hd), 
                         INPUT des_fecha, 
                         INPUT has_fecha, 
                         INPUT ficha,
                         INPUT que_moneda ).

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_imprimir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_imprimir B-table-Win
ON CHOOSE OF btn_imprimir IN FRAME F-Main /* Imprimir */
DO:
    RUN listar_ctacte_contrato.p ( INPUT ROWID(contrato_hd), 
                                    INPUT des_fecha, 
                                    INPUT has_fecha, 
                                    INPUT ficha,
                                    INPUT que_moneda ).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_integral
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_integral B-table-Win
ON CHOOSE OF btn_integral IN FRAME F-Main /* Integral */
DO:
     RUN fintegral_contrato.p (INPUT ROWID(contrato_hd), 
                              INPUT que_moneda ).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_verificar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_verificar B-table-Win
ON CHOOSE OF btn_verificar IN FRAME F-Main /* Verificar */
DO:
     RUN verificar_aplicacion_cc_contrato.p (INPUT ROWID(Contrato_hd), 
                                    INPUT que_moneda ).
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


&Scoped-define SELF-NAME ficha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ficha B-table-Win
ON VALUE-CHANGED OF ficha IN FRAME F-Main
DO:
  ASSIGN ficha.
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
  {src/adm/template/row-list.i "Contrato_hd"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Contrato_hd"}

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
   FOR EACH B-Cta_cte OF contrato_hd
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
   FOR EACH B-Cta_cte OF contrato_hd 
      WHERE B-Cta_cte.cdg_empresa = Empresa.cdg_empresa
        AND B-Cta_cte.nro_moneda = Moneda.nro_moneda
        /* AND B-Cta_cte.fecha_emision <= has_fecha    */:

      IF CAN-DO(str_debitan,B-Cta_cte.tip_comprob)
         THEN DO: tot_debitogr  = tot_debitogr + B-Cta_cte.debito.
         END.
         ELSE DO: tot_creditogr = tot_creditogr + B-Cta_cte.credito.
         END.


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
   FOR EACH B-Cta_cte OF contrato_hd 
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
  {findempresa.i}
  que_empresa = Empresa.cdg_empresa.
  
  DEFINE VARIABLE ok AS LOGICAL.
  id_moneda:LIST-ITEMS IN FRAME {&FRAME-NAME} = "".
  FOR EACH Moneda:
      ok = id_moneda:ADD-FIRST(Moneda.descripcion) IN FRAME {&FRAME-NAME} .
  END.    

  FIND Moneda WHERE Moneda.es_local NO-LOCK.
  que_moneda = Moneda.nro_moneda.
  
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  id_moneda:SCREEN-VALUE IN FRAME {&FRAME-NAME} = Moneda.descripcion.
  RUN get-link-handle IN adm-broker-hdl
    ( INPUT THIS-PROCEDURE,
      INPUT "fecha-source",
      OUTPUT hcproc).
  hproc = WIDGET-HANDLE(hcproc).
  IF VALID-HANDLE( hproc )THEN DO:
      has_fecha = DYNAMIC-FUNCTION("get-has_fecha" IN hproc ).
      des_fecha = DYNAMIC-FUNCTION("get-des_fecha" IN hproc ).
      has_fecha:HIDDEN IN FRAME {&FRAME-NAME} = TRUE.
      des_fecha:HIDDEN IN FRAME {&FRAME-NAME} = has_fecha:HIDDEN IN FRAME {&FRAME-NAME}.

  END.
  ELSE do: 
      has_fecha = TODAY.
      des_fecha = has_fecha - 90.
      DISPLAY 
      has_fecha
      des_fecha
      WITH FRAME {&FRAME-NAME}.

  END.
    RUN dispatch IN THIS-PROCEDURE ('open-query':U).

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
        message "contrato_hd esta:" string(available contrato_hd) skip
                " desde fecha:" string(des_fecha) skip
                " hasta fecha:" string(has_fecha) skip
                " que moneda:" string(que_moneda) skip
                "      his:" string(ficha = his) skip
                "      anl:" string(ficha = anl) skip
                "      ven:" string(ficha = ven) skip
                view-as alert-box.
        -------------------------------------------------------*/

    CASE ficha:
  
         WHEN his THEN DO: 
             OPEN QUERY {&BROWSE-NAME}       
                             FOR EACH Cta_cte OF contrato_hd 
                                WHERE Cta_cte.fecha_emision >= des_fecha 
                                  AND Cta_cte.fecha_emision <= has_fecha
                                  AND Cta_cte.cdg_empresa = Empresa.cdg_empresa
                                  AND Cta_cte.nro_moneda = que_moneda,
                                 EACH Imputacion OF Cta_cte
                                   BY Cta_cte.fecha_emision. 
                             END.

         WHEN anl THEN DO: 
             OPEN QUERY {&BROWSE-NAME}       
                             FOR EACH Cta_cte OF contrato_hd 
                                WHERE Cta_cte.cdg_empresa = Empresa.cdg_empresa
                                  AND Cta_cte.fecha_emision >= des_fecha 
                                  AND Cta_cte.fecha_emision <= has_fecha
                                  AND Cta_cte.nro_moneda = que_moneda
                                  AND Cta_cte.debito <> Cta_cte.credito,
                                 EACH Imputacion OF Cta_cte
                                   BY Cta_cte.fecha_vencimiento. 
                             END.
  
         WHEN ven THEN DO: 
             OPEN QUERY {&BROWSE-NAME}       
                             FOR EACH Cta_cte OF contrato_hd 
                                WHERE Cta_cte.cdg_empresa = Empresa.cdg_empresa
                                  AND Cta_cte.fecha_vencimiento <= has_fecha
                                  AND Cta_cte.nro_moneda = que_moneda
                                  AND Cta_cte.debito <> Cta_cte.credito,
                                 EACH Imputacion OF Cta_cte
                                   BY Cta_cte.fecha_vencimiento.   
                             END.
  
    END CASE.

    CASE ficha:
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

    RUN dispatch IN THIS-PROCEDURE ('row-changed':U).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE mostrar_window B-table-Win 
PROCEDURE mostrar_window :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE p-link-hdls AS CHARACTER.
  DEFINE VARIABLE h-handle    AS HANDLE.

  RUN get-link-handle IN adm-broker-hdl
    ( INPUT THIS-PROCEDURE /* HANDLE */,
      INPUT "Container-Source" /* CHARACTER */,
      OUTPUT p-link-hdls /* CHARACTER */).

  h-handle = WIDGET-HANDLE(p-link-hdls).
  IF VALID-HANDLE(h-handle)
      THEN RUN mostrar_window IN h-handle.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ocultar_window B-table-Win 
PROCEDURE ocultar_window :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  
  DEFINE VARIABLE p-link-hdls AS CHARACTER.
  DEFINE VARIABLE h-handle    AS HANDLE.

  RUN get-link-handle IN adm-broker-hdl
    ( INPUT THIS-PROCEDURE /* HANDLE */,
      INPUT "Container-Source" /* CHARACTER */,
      OUTPUT p-link-hdls /* CHARACTER */).

  h-handle = WIDGET-HANDLE(p-link-hdls).
  IF VALID-HANDLE(h-handle)
      THEN RUN ocultar_window IN h-handle.

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
  {src/adm/template/snd-list.i "Contrato_hd"}
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

