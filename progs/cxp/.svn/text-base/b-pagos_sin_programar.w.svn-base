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

/*{vrshared.i "new"}*/

DEFINE VARIABLE todos          AS   INTEGER INITIAL 0.
DEFINE VARIABLE con_p          AS   INTEGER INITIAL 1.
DEFINE VARIABLE sin_p          AS   INTEGER INITIAL 2.

DEFINE VARIABLE v_saldo        AS DECIMAL.

DEFINE VARIABLE fecha_inicial  AS DATE.
DEFINE VARIABLE fecha_elegida  AS DATE.

DEFINE VARIABLE mensaje        AS CHARACTER FORMAT "X(40)".

DEFINE VARIABLE ant_anulado    LIKE Fac_header_prv.anulado.
DEFINE VARIABLE que_empresa    LIKE Empresa.cdg_empresa.
DEFINE VARIABLE que_moneda     LIKE Moneda.nro_moneda.
DEFINE VARIABLE l-str_debitan   AS CHARACTER.

FORM 
     mensaje NO-LABEL
     WITH FRAME frm-espere OVERLAY
          TITLE "Aguarde un momento por favor" FONT 8
          CENTERED ROW 7 FGCOLOR 14 BGCOLOR 1.

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
&Scoped-define INTERNAL-TABLES Cta_cte_prv Imputacion Proveedor

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Proveedor.cdg_proveedor ~
Proveedor.nombre Cta_cte_prv.tip_comprob Cta_cte_prv.prf_comprob ~
Cta_cte_prv.nro_comprob Cta_cte_prv.nro_vencimiento ~
Cta_cte_prv.fecha_vencimiento ~
Cta_cte_prv.credito - Cta_cte_prv.debito @ V_SALDO ~
Cta_cte_prv.fecha_programada Cta_cte_prv.imp_programado ~
Cta_cte_prv.programada 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table 
&Scoped-define QUERY-STRING-br_table FOR EACH Cta_cte_prv OF Moneda WHERE ~{&KEY-PHRASE} ~
      AND Cta_cte_prv.selectado = FALSE NO-LOCK, ~
      FIRST Imputacion OF Cta_cte_prv NO-LOCK, ~
      FIRST Proveedor OF Cta_cte_prv NO-LOCK ~
    ~{&SORTBY-PHRASE}
&Scoped-define OPEN-QUERY-br_table OPEN QUERY br_table FOR EACH Cta_cte_prv OF Moneda WHERE ~{&KEY-PHRASE} ~
      AND Cta_cte_prv.selectado = FALSE NO-LOCK, ~
      FIRST Imputacion OF Cta_cte_prv NO-LOCK, ~
      FIRST Proveedor OF Cta_cte_prv NO-LOCK ~
    ~{&SORTBY-PHRASE}.
&Scoped-define TABLES-IN-QUERY-br_table Cta_cte_prv Imputacion Proveedor
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Cta_cte_prv
&Scoped-define SECOND-TABLE-IN-QUERY-br_table Imputacion
&Scoped-define THIRD-TABLE-IN-QUERY-br_table Proveedor


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS v-des_fecha v-has_fecha id_moneda ~
btn_comprobte btn_listado br_table RECT-1 
&Scoped-Define DISPLAYED-OBJECTS v-des_fecha v-has_fecha id_moneda 

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
cdg_empresa||y|sic.Cta_cte_prv.cdg_empresa
cdg_imputacion||y|sic.Cta_cte_prv.cdg_imputacion
nro_moneda||y|sic.Cta_cte_prv.nro_moneda
nro_proveedor||y|sic.Cta_cte_prv.nro_proveedor
cdg_tiporetgan||y|sic.Cta_cte_prv.cdg_tiporetgan
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = ,
     Keys-Supplied = "cdg_empresa,cdg_imputacion,nro_moneda,nro_proveedor,cdg_tiporetgan"':U).

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
DEFINE BUTTON btn_comprobte 
     LABEL "&Ver Comprobante" 
     SIZE 25 BY 1.14.

DEFINE BUTTON btn_listado 
     LABEL "&Listar" 
     SIZE 25 BY 1.14.

DEFINE VARIABLE id_moneda AS CHARACTER FORMAT "X(256)":U 
     LABEL "Moneda" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "Item 1" 
     DROP-DOWN-LIST
     SIZE 31 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE v-des_fecha AS DATE FORMAT "99/99/99":U 
     LABEL "Del" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE v-has_fecha AS DATE FORMAT "99/99/99":U 
     LABEL "al" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 153 BY 1.67.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Cta_cte_prv, 
      Imputacion, 
      Proveedor SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _STRUCTURED
  QUERY br_table NO-LOCK DISPLAY
      Proveedor.cdg_proveedor FORMAT "X(10)":U WIDTH 13.2
      Proveedor.nombre FORMAT "X(35)":U WIDTH 43.2
      Cta_cte_prv.tip_comprob COLUMN-LABEL "Tipo!Com." FORMAT "X(3)":U
            WIDTH 5.2
      Cta_cte_prv.prf_comprob COLUMN-LABEL "Pre-!fijo" FORMAT "9999":U
      Cta_cte_prv.nro_comprob FORMAT "ZZZZZZZ9":U
      Cta_cte_prv.nro_vencimiento COLUMN-LABEL "Nro.!Cuota" FORMAT ">>9":U
      Cta_cte_prv.fecha_vencimiento COLUMN-LABEL "Venci-!miento" FORMAT "99/99/99":U
      Cta_cte_prv.credito - Cta_cte_prv.debito @ V_SALDO COLUMN-LABEL "Saldo!Pendiente" FORMAT "->,>>>,>>9.99":U
      Cta_cte_prv.fecha_programada COLUMN-LABEL "Fecha!Asignada" FORMAT "99/99/9999":U
      Cta_cte_prv.imp_programado FORMAT "->>,>>>,>>9.99":U
      Cta_cte_prv.programada COLUMN-LABEL "Progra-!mada" FORMAT "Si/No":U
            WIDTH 5.6
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS MULTIPLE SIZE 153 BY 11.43
         BGCOLOR 11 FGCOLOR 9 
         TITLE BGCOLOR 11 FGCOLOR 9 "Pagos por rango de vecimiento" EXPANDABLE.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     v-des_fecha AT ROW 1.24 COL 6 COLON-ALIGNED
     v-has_fecha AT ROW 1.24 COL 24 COLON-ALIGNED
     id_moneda AT ROW 1.24 COL 58 COLON-ALIGNED
     btn_comprobte AT ROW 1.24 COL 102
     btn_listado AT ROW 1.24 COL 128
     br_table AT ROW 2.91 COL 1
     RECT-1 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         BGCOLOR 8 FGCOLOR 0 .


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
         HEIGHT             = 13.33
         WIDTH              = 155.
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
/* BROWSE-TAB br_table btn_listado F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _TblList          = "sic.Cta_cte_prv OF sic.Moneda,sic.Imputacion OF sic.Cta_cte_prv,sic.Proveedor OF sic.Cta_cte_prv"
     _Options          = "NO-LOCK KEY-PHRASE SORTBY-PHRASE"
     _TblOptList       = ", FIRST, FIRST,"
     _Where[1]         = "Cta_cte_prv.selectado = FALSE"
     _FldNameList[1]   > sic.Proveedor.cdg_proveedor
"Proveedor.cdg_proveedor" ? "X(10)" "character" ? ? ? ? ? ? no ? no no "13.2" yes no no "U" "" ""
     _FldNameList[2]   > sic.Proveedor.nombre
"Proveedor.nombre" ? "X(35)" "character" ? ? ? ? ? ? no ? no no "43.2" yes no no "U" "" ""
     _FldNameList[3]   > sic.Cta_cte_prv.tip_comprob
"Cta_cte_prv.tip_comprob" "Tipo!Com." ? "character" ? ? ? ? ? ? no ? no no "5.2" yes no no "U" "" ""
     _FldNameList[4]   > sic.Cta_cte_prv.prf_comprob
"Cta_cte_prv.prf_comprob" "Pre-!fijo" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[5]   = sic.Cta_cte_prv.nro_comprob
     _FldNameList[6]   > sic.Cta_cte_prv.nro_vencimiento
"Cta_cte_prv.nro_vencimiento" "Nro.!Cuota" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[7]   > sic.Cta_cte_prv.fecha_vencimiento
"Cta_cte_prv.fecha_vencimiento" "Venci-!miento" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[8]   > "_<CALC>"
"Cta_cte_prv.credito - Cta_cte_prv.debito @ V_SALDO" "Saldo!Pendiente" "->,>>>,>>9.99" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[9]   > sic.Cta_cte_prv.fecha_programada
"Cta_cte_prv.fecha_programada" "Fecha!Asignada" "99/99/9999" "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[10]   = sic.Cta_cte_prv.imp_programado
     _FldNameList[11]   > sic.Cta_cte_prv.programada
"Cta_cte_prv.programada" "Progra-!mada" ? "logical" ? ? ? ? ? ? no ? no no "5.6" yes no no "U" "" ""
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
ON MOUSE-SELECT-DBLCLICK OF br_table IN FRAME F-Main /* Pagos por rango de vecimiento */
OR "RETURN" OF br_table
DO:
  
  DO TRANSACTION:
      FIND CURRENT Cta_cte_prv EXCLUSIVE-LOCK.
      Cta_cte_prv.user-id-sel = USERID("sic").
      FIND CURRENT Cta_cte_prv NO-LOCK.
  END.
  RUN dispatch IN THIS-PROCEDURE ("open-query").

  DEFINE VARIABLE h AS HANDLE NO-UNDO.
  DEFINE VARIABLE c AS CHAR   NO-UNDO.

  RUN get-link-handle IN adm-broker-hdl
       (THIS-PROCEDURE, 'Programacion-TARGET':U, OUTPUT c).

  IF NUM-ENTRIES (c) eq 1 THEN DO:
     h = WIDGET-HANDLE (c).
     RUN refrescar_browse IN h.
  END.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-ENTRY OF br_table IN FRAME F-Main /* Pagos por rango de vecimiento */
DO:
  /* This code displays initial values for newly added or copied rows. */
  {src/adm/template/brsentry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-LEAVE OF br_table IN FRAME F-Main /* Pagos por rango de vecimiento */
DO:
    /* Do not disable this code or no updates will take place except
     by pressing the Save button on an Update SmartPanel. */
   {src/adm/template/brsleave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON VALUE-CHANGED OF br_table IN FRAME F-Main /* Pagos por rango de vecimiento */
DO:
  /* This ADM trigger code must be preserved in order to notify other
     objects when the browser's current row changes. */
  {src/adm/template/brschnge.i}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_comprobte
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_comprobte B-table-Win
ON CHOOSE OF btn_comprobte IN FRAME F-Main /* Ver Comprobante */
DO:
  DEFINE VARIABLE act_ctacte_prv AS ROWID.
  DEFINE VARIABLE act_fpr_head   AS ROWID.
  DEFINE VARIABLE act_opg_head   AS ROWID.
  
  IF NOT AVAILABLE Cta_cte_prv 
  THEN DO:
     BELL.
     MESSAGE "No hay documentos que puedan consultarse"
       VIEW-AS ALERT-BOX ERROR BUTTONS OK.
     RETURN NO-APPLY.
  END.
  ELSE DO:
     FIND Fac_header_prv WHERE Cta_cte_prv.cdg_empresa   = Fac_header_prv.cdg_empresa
                           AND Cta_cte_prv.tip_comprob   = Fac_header_prv.tip_comprob
                           AND Cta_cte_prv.prf_comprob   = Fac_header_prv.prf_comprob 
                           AND Cta_cte_prv.nro_comprob   = Fac_header_prv.nro_comprob 
                           AND Cta_cte_prv.nro_proveedor = Fac_header_prv.nro_proveedor NO-ERROR.
     IF AVAILABLE Fac_header_prv
     THEN DO:                  
        act_fpr_head = ROWID(Fac_header_prv).
        RUN c-coprobante_proveedor.w (INPUT Fac_header_prv.cdg_comprobante, INPUT-OUTPUT act_fpr_head , INPUT 2 ).
     END.
     ELSE DO:
        FIND Opg_header WHERE Cta_cte_prv.cdg_empresa   = Opg_header.cdg_empresa
                          AND Cta_cte_prv.tip_comprob   = Opg_header.tip_comprob
                          AND Cta_cte_prv.prf_comprob   = Opg_header.prf_comprob 
                          AND Cta_cte_prv.nro_comprob   = Opg_header.nro_comprob 
                          AND Cta_cte_prv.nro_proveedor = Opg_header.nro_proveedor NO-ERROR.
        IF AVAILABLE Opg_header
        THEN DO:                  
             act_opg_head = ROWID(Opg_header).
             CASE Cta_cte_prv.tip_comprob:
                WHEN "OP" THEN RUN c-orden_de_pago.w        (INPUT-OUTPUT act_opg_head, INPUT 2).

                WHEN "CA" THEN RUN c-creditodoc_proveedor.w (INPUT-OUTPUT act_opg_head, INPUT 2).
                WHEN "CB" THEN RUN c-creditodoc_proveedor.w (INPUT-OUTPUT act_opg_head, INPUT 2).
                WHEN "CC" THEN RUN c-creditodoc_proveedor.w (INPUT-OUTPUT act_opg_head, INPUT 2).
                WHEN "CI" THEN RUN c-credintdoc_proveedor.w (INPUT-OUTPUT act_opg_head, INPUT 2).
      
                WHEN "DA" THEN RUN c-debitodoc_proveedor.w (INPUT-OUTPUT act_opg_head, INPUT 2).
                WHEN "DB" THEN RUN c-debitodoc_proveedor.w (INPUT-OUTPUT act_opg_head, INPUT 2).
                WHEN "DC" THEN RUN c-debitodoc_proveedor.w (INPUT-OUTPUT act_opg_head, INPUT 2).
                WHEN "DI" THEN RUN c-debintdoc_proveedor.w (INPUT-OUTPUT act_opg_head, INPUT 2).

                OTHERWISE MESSAGE "TIPO DE COMPROBANTE DESCONOCIDO" VIEW-AS ALERT-BOX ERROR TITLE "ERROR DE INSTALACION".

             END CASE.
        END.
        ELSE DO:
            MESSAGE "El documento no ha sido hallado en la tabla respectiva"
                    VIEW-AS ALERT-BOX MESSAGE.
        END.
     END.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_listado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_listado B-table-Win
ON CHOOSE OF btn_listado IN FRAME F-Main /* Listar */
DO:

   mensaje = "    Procesando ...".
   DISPLAY mensaje WITH FRAME frm-espere.
   RUN lsprogramacion_pagos.p (INPUT v-des_fecha,
                               INPUT v-has_fecha,
                               INPUT 2,
                               ROWID(Moneda)).
   HIDE FRAME frm-espere NO-PAUSE.

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


&Scoped-define SELF-NAME v-des_fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-des_fecha B-table-Win
ON MOUSE-MENU-DOWN OF v-des_fecha IN FRAME F-Main /* Del */
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
ON RETURN OF v-des_fecha IN FRAME F-Main /* Del */
DO:
  ASSIGN v-des_fecha.
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-has_fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-has_fecha B-table-Win
ON MOUSE-MENU-DOWN OF v-has_fecha IN FRAME F-Main /* al */
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
ON RETURN OF v-has_fecha IN FRAME F-Main /* al */
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

  FIND FIRST Moneda NO-LOCK.
  que_moneda = Moneda.nro_moneda.

  DEFINE VARIABLE ok AS LOGICAL.
  id_moneda:LIST-ITEMS IN FRAME {&FRAME-NAME} = "".
  FOR EACH Moneda:
      ok = id_moneda:ADD-FIRST(Moneda.descripcion) IN FRAME {&FRAME-NAME} .
  END.    

  v-des_fecha = TODAY .
  v-has_fecha = v-des_fecha + 90.

  FIND Moneda WHERE Moneda.nro_moneda = que_moneda NO-LOCK.
  id_moneda:SCREEN-VALUE IN FRAME {&FRAME-NAME} = Moneda.descripcion.

  {findempresa.i}
  que_empresa = Empresa.cdg_empresa.

  RUN cargar_debitan ( INPUT "Compras", OUTPUT l-str_debitan ).

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
  PAUSE 0.
  mensaje = "    Recuperando datos ...".        
  DISPLAY mensaje WITH FRAME frm-espere.

  {&BROWSE-NAME}:TITLE IN FRAME {&FRAME-NAME} = "Pagos pendientes de programar por fecha de vencimiento".
  OPEN QUERY {&BROWSE-NAME}
         FOR EACH Cta_cte_prv
            WHERE Cta_cte_prv.cdg_empresa = que_empresa
              AND Cta_cte_prv.nro_moneda = que_moneda
              AND Cta_cte_prv.debito < Cta_cte_prv.credito
              AND Cta_cte_prv.fecha_vencimiento <= v-has_fecha
              AND Cta_cte_prv.fecha_vencimiento >= v-des_fecha
              AND Cta_cte_prv.user-id-sel = "",
            FIRST Imputacion OF Cta_cte_prv, FIRST Proveedor OF Cta_cte_prv
               BY Proveedor.nombre
               BY Cta_cte_prv.fecha_vencimiento.

  RUN dispatch IN THIS-PROCEDURE ('row-changed':U).

  HIDE FRAME frm-espere NO-PAUSE.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_sesion B-table-Win 
PROCEDURE poner_sesion :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

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

    RUN dispatch IN THIS-PROCEDURE ("open-query").  

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
  {src/adm/template/sndkycas.i "cdg_empresa" "Cta_cte_prv" "cdg_empresa"}
  {src/adm/template/sndkycas.i "cdg_imputacion" "Cta_cte_prv" "cdg_imputacion"}
  {src/adm/template/sndkycas.i "nro_moneda" "Cta_cte_prv" "nro_moneda"}
  {src/adm/template/sndkycas.i "nro_proveedor" "Cta_cte_prv" "nro_proveedor"}
  {src/adm/template/sndkycas.i "cdg_tiporetgan" "Cta_cte_prv" "cdg_tiporetgan"}

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
  {src/adm/template/snd-list.i "Cta_cte_prv"}
  {src/adm/template/snd-list.i "Imputacion"}
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

