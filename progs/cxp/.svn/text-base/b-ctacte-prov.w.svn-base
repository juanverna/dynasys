&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW


/* Temp-Table and Buffer definitions                                    */
DEFINE BUFFER B-Cta_cte_prv FOR Cta_cte_prv.



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

DEFINE VARIABLE que_empresa   LIKE Empresa.cdg_empresa.
DEFINE VARIABLE fecha_inicial AS DATE.
DEFINE VARIABLE fecha_elegida AS DATE.
DEFINE VARIABLE que_moneda LIKE Moneda.nro_moneda INITIAL 10.
/*DEFINE VARIABLE l-str_debitan   AS CHARACTER INITIAL "FA,FB,FC,DA,DB,DC,SI".*/
{VRSHARED.I "NEW"}

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
&Scoped-define EXTERNAL-TABLES Proveedor
&Scoped-define FIRST-EXTERNAL-TABLE Proveedor


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Proveedor.
/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Cta_cte_prv Imputacion

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Cta_cte_prv.fecha_emision ~
Cta_cte_prv.tip_comprob Cta_cte_prv.prf_comprob Cta_cte_prv.nro_comprob ~
Cta_cte_prv.nro_vencimiento Imputacion.abrevia ~
Cta_cte_prv.fecha_vencimiento Cta_cte_prv.debito Cta_cte_prv.credito ~
Cta_cte_prv.fecha_programada Cta_cte_prv.imp_programado ~
Cta_cte_prv.programada 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table 
&Scoped-define QUERY-STRING-br_table FOR EACH Cta_cte_prv OF Proveedor WHERE ~{&KEY-PHRASE} ~
      AND Cta_cte_prv.cdg_empresa = Empresa.cdg_empresa NO-LOCK, ~
      EACH Imputacion OF Cta_cte_prv NO-LOCK ~
    ~{&SORTBY-PHRASE}
&Scoped-define OPEN-QUERY-br_table OPEN QUERY br_table FOR EACH Cta_cte_prv OF Proveedor WHERE ~{&KEY-PHRASE} ~
      AND Cta_cte_prv.cdg_empresa = Empresa.cdg_empresa NO-LOCK, ~
      EACH Imputacion OF Cta_cte_prv NO-LOCK ~
    ~{&SORTBY-PHRASE}.
&Scoped-define TABLES-IN-QUERY-br_table Cta_cte_prv Imputacion
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Cta_cte_prv
&Scoped-define SECOND-TABLE-IN-QUERY-br_table Imputacion


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-1 id_moneda btn_ficha btn_imprimir ~
v-des_fecha ficha v-has_fecha btn_programar br_table 
&Scoped-Define DISPLAYED-OBJECTS id_moneda v-des_fecha ficha v-has_fecha ~
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
     Keys-Supplied = "cdg_imputacion,nro_moneda,nro_proveedor,cdg_tiporetgan"':U).

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
DEFINE BUTTON btn_ficha 
     LABEL "&Ficha Integrada" 
     SIZE 18 BY 2.14.

DEFINE BUTTON btn_imprimir 
     LABEL "&Imprimir" 
     SIZE 12 BY .95.

DEFINE BUTTON btn_programar 
     LABEL "&Programar" 
     SIZE 12 BY .95.

DEFINE VARIABLE id_moneda AS CHARACTER FORMAT "X(256)":U 
     LABEL "Moneda" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "Item 1" 
     DROP-DOWN-LIST
     SIZE 24 BY 1
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

DEFINE VARIABLE v-saldo AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     LABEL "Saldo" 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE ficha AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Histórico", 0,
"Analítico", 1,
"Vencido", 2
     SIZE 15 BY 1.86 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 128 BY 2.62.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Cta_cte_prv, 
      Imputacion SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _STRUCTURED
  QUERY br_table NO-LOCK DISPLAY
      Cta_cte_prv.fecha_emision COLUMN-LABEL "Fecha de!Emisión" FORMAT "99/99/9999":U
      Cta_cte_prv.tip_comprob COLUMN-LABEL "Tip!Com" FORMAT "X(3)":U
      Cta_cte_prv.prf_comprob COLUMN-LABEL "Pto!Vta" FORMAT "9999":U
      Cta_cte_prv.nro_comprob COLUMN-LABEL "Número!Comprob" FORMAT "ZZZZZZZ9":U
      Cta_cte_prv.nro_vencimiento COLUMN-LABEL "N!V" FORMAT ">>9":U
      Imputacion.abrevia COLUMN-LABEL "Concepto!Documto." FORMAT "X(5)":U
      Cta_cte_prv.fecha_vencimiento COLUMN-LABEL "Fecha!Vencimiento" FORMAT "99/99/9999":U
      Cta_cte_prv.debito FORMAT "->>,>>>,>>9.99":U
      Cta_cte_prv.credito FORMAT "->>,>>>,>>9.99":U
      Cta_cte_prv.fecha_programada COLUMN-LABEL "Fecha!Programada" FORMAT "99/99/9999":U
      Cta_cte_prv.imp_programado FORMAT "->>,>>>,>>9.99":U
      Cta_cte_prv.programada FORMAT "Si/No":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 128 BY 16.91
         BGCOLOR 15 FGCOLOR 9 FONT 4
         TITLE BGCOLOR 15 FGCOLOR 9 "Movimientos de Cuenta Corriente del Proveedor".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     id_moneda AT ROW 1.24 COL 69 COLON-ALIGNED
     btn_ficha AT ROW 1.24 COL 97
     btn_imprimir AT ROW 1.24 COL 116
     v-des_fecha AT ROW 1.29 COL 9 COLON-ALIGNED
     ficha AT ROW 1.48 COL 45 NO-LABEL
     v-has_fecha AT ROW 2.33 COL 9 COLON-ALIGNED
     v-saldo AT ROW 2.43 COL 69 COLON-ALIGNED
     btn_programar AT ROW 2.43 COL 116
     br_table AT ROW 3.86 COL 1
     "Saldo:" VIEW-AS TEXT
          SIZE 7 BY .71 AT ROW 1.48 COL 37
     RECT-1 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         BGCOLOR 8 FGCOLOR 0 FONT 4.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartBrowser
   External Tables: sic.Proveedor
   Allow: Basic,Browse
   Frames: 1
   Add Fields to: EXTERNAL-TABLES
   Other Settings: PERSISTENT-ONLY COMPILE
   Temp-Tables and Buffers:
      TABLE: B-Cta_cte_prv B "?" ? sic Cta_cte_prv
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
         HEIGHT             = 20.33
         WIDTH              = 130.6.
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
/* BROWSE-TAB br_table btn_programar F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

ASSIGN 
       br_table:NUM-LOCKED-COLUMNS IN FRAME F-Main     = 5.

/* SETTINGS FOR FILL-IN v-saldo IN FRAME F-Main
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _TblList          = "sic.Cta_cte_prv OF sic.Proveedor,sic.Imputacion OF sic.Cta_cte_prv"
     _Options          = "NO-LOCK KEY-PHRASE SORTBY-PHRASE"
     _Where[1]         = "Cta_cte_prv.cdg_empresa = Empresa.cdg_empresa"
     _FldNameList[1]   > sic.Cta_cte_prv.fecha_emision
"Cta_cte_prv.fecha_emision" "Fecha de!Emisión" "99/99/9999" "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[2]   > sic.Cta_cte_prv.tip_comprob
"Cta_cte_prv.tip_comprob" "Tip!Com" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[3]   > sic.Cta_cte_prv.prf_comprob
"Cta_cte_prv.prf_comprob" "Pto!Vta" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[4]   > sic.Cta_cte_prv.nro_comprob
"Cta_cte_prv.nro_comprob" "Número!Comprob" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[5]   > sic.Cta_cte_prv.nro_vencimiento
"Cta_cte_prv.nro_vencimiento" "N!V" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[6]   > sic.Imputacion.abrevia
"Imputacion.abrevia" "Concepto!Documto." ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[7]   > sic.Cta_cte_prv.fecha_vencimiento
"Cta_cte_prv.fecha_vencimiento" "Fecha!Vencimiento" "99/99/9999" "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[8]   = sic.Cta_cte_prv.debito
     _FldNameList[9]   = sic.Cta_cte_prv.credito
     _FldNameList[10]   > sic.Cta_cte_prv.fecha_programada
"Cta_cte_prv.fecha_programada" "Fecha!Programada" "99/99/9999" "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[11]   = sic.Cta_cte_prv.imp_programado
     _FldNameList[12]   = sic.Cta_cte_prv.programada
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
ON CTRL-SHIFT-DEL OF br_table IN FRAME F-Main /* Movimientos de Cuenta Corriente del Proveedor */
DO:
  DEFINE VARIABLE que AS LOGICAL.
  que = NO.
  MESSAGE "Confirma que desea eliminar este registro?"
          VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE que .
  IF que 
  THEN DO:
       DO TRANSACTION:
          FIND CURRENT Cta_cte_prv EXCLUSIVE-LOCK.
          DELETE Cta_cte_prv.
       END.
       RUN dispatch IN THIS-PROCEDURE ('open-query':U).
  END.        
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON CTRL-SHIFT-ENTER OF br_table IN FRAME F-Main /* Movimientos de Cuenta Corriente del Proveedor */
DO:
  RUN d-editaccprov.p (INPUT ROWID(Cta_cte_prv)).
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON CTRL-SHIFT-INS OF br_table IN FRAME F-Main /* Movimientos de Cuenta Corriente del Proveedor */
DO:
    DO TRANSACTION:
       CREATE Cta_cte_prv.
       ASSIGN Cta_cte_prv.nro_proveedor = Proveedor.nro_proveedor
              Cta_cte_prv.cdg_empresa   = Empresa.cdg_empresa
              Cta_cte_prv.nro_moneda    = Moneda.nro_moneda.
       FIND FIRST Actividad_proveedor OF Proveedor NO-LOCK.
       Cta_cte_prv.cdg_tiporetgan = Actividad_proveedor.cdg_tiporetgan.       
       RUN d-editaccprov.p (INPUT ROWID(Cta_cte_prv)).
    END.
    RUN dispatch IN THIS-PROCEDURE ('open-query':U).
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON MOUSE-SELECT-DBLCLICK OF br_table IN FRAME F-Main /* Movimientos de Cuenta Corriente del Proveedor */
OR "RETURN" OF br_table
DO:
  
  DEFINE VARIABLE act_ctacte_prv AS ROWID.
  
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
        RUN ocultar_window.
        RUN c-comprobante_proveedor.w ( INPUT-OUTPUT act_fpr_head , INPUT 2, INPUT Fac_header_prv.cdg_comprobante ).
        RUN mostrar_window.
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
            RUN ocultar_window.
            RUN c-orden_de_pago.w        (INPUT-OUTPUT act_opg_head, INPUT 2).
            RUN mostrar_window.
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-ENTRY OF br_table IN FRAME F-Main /* Movimientos de Cuenta Corriente del Proveedor */
DO:
  /* This code displays initial values for newly added or copied rows. */
  {src/adm/template/brsentry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-LEAVE OF br_table IN FRAME F-Main /* Movimientos de Cuenta Corriente del Proveedor */
DO:
    /* Do not disable this code or no updates will take place except
     by pressing the Save button on an Update SmartPanel. */
   {src/adm/template/brsleave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON VALUE-CHANGED OF br_table IN FRAME F-Main /* Movimientos de Cuenta Corriente del Proveedor */
DO:
  /* This ADM trigger code must be preserved in order to notify other
     objects when the browser's current row changes. */

  {src/adm/template/brschnge.i}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_ficha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_ficha B-table-Win
ON CHOOSE OF btn_ficha IN FRAME F-Main /* Ficha Integrada */
DO:

     RUN fichaintegral_proveedor.p (INPUT ROWID(Proveedor), 
                                    INPUT ROWID(Moneda)).

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_imprimir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_imprimir B-table-Win
ON CHOOSE OF btn_imprimir IN FRAME F-Main /* Imprimir */
DO:

     RUN LISCCPRO.P (INPUT ROWID(Proveedor), 
                     INPUT v-des_fecha, 
                     INPUT v-has_fecha, 
                     INPUT ficha,
                     INPUT que_moneda ).

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_programar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_programar B-table-Win
ON CHOOSE OF btn_programar IN FRAME F-Main /* Programar */
DO:

  DEFINE VARIABLE hazlo_cono AS LOGICAL.

  IF NOT AVAILABLE Cta_cte_prv
  THEN DO:
     BELL.
     MESSAGE "No hay documentos que puedan programarse"
       VIEW-AS ALERT-BOX ERROR BUTTONS OK.
     RETURN NO-APPLY.
  END.

  RUN d-programaccprov.p (INPUT ROWID(Cta_cte_prv)).
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

  /* Create a list of all the tables that we need to get.            */
  {src/adm/template/row-list.i "Proveedor"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Proveedor"}

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
   FOR EACH B-Cta_cte_prv OF Proveedor
      WHERE B-Cta_cte_prv.cdg_empresa  = Empresa.cdg_empresa
        AND B-Cta_cte_prv.nro_moneda = Moneda.nro_moneda
        AND B-Cta_cte_prv.debito <> B-Cta_cte_prv.credito:

       /*
       MESSAGE "T" B-Cta_cte_prv.tip_comprob SKIP
               "P" STRING(B-Cta_cte_prv.prf_comprob,"9999") SKIP
               "N" STRING(B-Cta_cte_prv.nro_comprob,"99999999") SKIP
               "D" STRING(B-Cta_cte_prv.debito) SKIP
               "C" STRING(B-Cta_cte_prv.credito) SKIP
               "TD" STRING(tot_debitogr) SKIP
               "TC" STRING(tot_creditogr)SKIP
               "LOOKUP" STRING(LOOKUP(B-Cta_cte_prv.tip_comprob,l-str_debitan)) 
               VIEW-AS ALERT-BOX MESSAGE.
       */

        tot_debitogr  = tot_debitogr  + B-Cta_cte_prv.debito.
        tot_creditogr = tot_creditogr + B-Cta_cte_prv.credito.

   END.

   saldo = tot_creditogr - tot_debitogr .

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

   /* Busca por Movimiento a la fecha */

   FOR EACH B-Cta_cte_prv OF Proveedor 
       WHERE B-Cta_cte_prv.cdg_empresa  = Empresa.cdg_empresa
         AND B-Cta_cte_prv.fecha_emision <= v-has_fecha 
         AND B-Cta_cte_prv.nro_moneda = Moneda.nro_moneda:

      /*          
              MESSAGE "T" B-Cta_cte_prv.tip_comprob SKIP
                      "P" STRING(B-Cta_cte_prv.prf_comprob,"9999") SKIP
                      "N" STRING(B-Cta_cte_prv.nro_comprob,"99999999") SKIP
                      "D" STRING(B-Cta_cte_prv.debito) SKIP
                      "C" STRING(B-Cta_cte_prv.credito) SKIP
                      "TD" STRING(tot_debitogr) SKIP
                      "TC" STRING(tot_creditogr)SKIP
                      "LOOKUP" STRING(LOOKUP(B-Cta_cte_prv.tip_comprob,l-str_debitan)) 
                      VIEW-AS ALERT-BOX MESSAGE.
             */                                       
                          
            /*
            tot_debitogr  = tot_debitogr  + B-Cta_cte_prv.debito.
            tot_creditogr = tot_creditogr + B-Cta_cte_prv.credito.
            */
            IF LOOKUP(B-Cta_cte_prv.tip_comprob,str_debitan_prv) <> 0              
                THEN tot_debitogr  = tot_debitogr + B-Cta_cte_prv.debito.    
                ELSE tot_creditogr = tot_creditogr + B-Cta_cte_prv.credito.  

   END.

   saldo = tot_creditogr - tot_debitogr .

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
   FOR EACH B-Cta_cte_prv OF Proveedor 
      WHERE B-Cta_cte_prv.cdg_empresa  = Empresa.cdg_empresa
        AND B-Cta_cte_prv.fecha_vencimiento <= v-has_fecha
        AND B-Cta_cte_prv.nro_moneda = Moneda.nro_moneda
        AND B-Cta_cte_prv.debito <> B-Cta_cte_prv.credito:

        tot_debitogr  = tot_debitogr  + B-Cta_cte_prv.debito.
        tot_creditogr = tot_creditogr + B-Cta_cte_prv.credito.

   END.

   saldo = tot_creditogr - tot_debitogr.

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

  v-has_fecha = TODAY.
  v-des_fecha = v-has_fecha - 90.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  DEFINE VARIABLE ok AS LOGICAL.
  id_moneda:LIST-ITEMS IN FRAME {&FRAME-NAME} = "".
  FOR EACH Moneda:
      ok = id_moneda:ADD-FIRST(Moneda.descripcion) IN FRAME {&FRAME-NAME} .
  END.    

  FIND Moneda WHERE Moneda.nro_moneda = que_moneda NO-LOCK.
  id_moneda:SCREEN-VALUE IN FRAME {&FRAME-NAME} = Moneda.descripcion.

  DISPLAY v-has_fecha
          v-des_fecha
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

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
 /*  RUN dispatch IN THIS-PROCEDURE ( INPUT 'open-query':U ) .*/

  /* Code placed here will execute AFTER standard behavior.    */

    DEFINE VARIABLE his            AS   INTEGER INITIAL 0.
    DEFINE VARIABLE anl            AS   INTEGER INITIAL 1.
    DEFINE VARIABLE ven            AS   INTEGER INITIAL 2.

       /*------------------------------------------------------
        message "proveed esta:" string(available proveedor) skip
                " desde fecha:" string(v-des_fecha) skip
                " hasta fecha:" string(v-has_fecha) skip
                " que moneda:" string(que_moneda) skip
                "        his:" string(ficha = his) skip
                "        anl:" string(ficha = anl) skip
                "        ven:" string(ficha = ven) skip
                view-as alert-box.
         -------------------------------------------------------*/

    CASE ficha:
  
         WHEN his THEN  OPEN QUERY {&BROWSE-NAME}       
                             FOR EACH Cta_cte_prv OF Proveedor 
                                WHERE Cta_cte_prv.cdg_empresa = Empresa.cdg_empresa
                                  AND Cta_cte_prv.fecha_emision >= v-des_fecha 
                                  AND Cta_cte_prv.fecha_emision <= v-has_fecha
                                  AND Cta_cte_prv.nro_moneda = que_moneda,
                                 EACH Imputacion OF Cta_cte_prv
                                   BY Cta_cte_prv.fecha_emision. 
  
         WHEN anl THEN  OPEN QUERY {&BROWSE-NAME}       
                             FOR EACH Cta_cte_prv OF Proveedor 
                                WHERE Cta_cte_prv.cdg_empresa = Empresa.cdg_empresa
                                  AND Cta_cte_prv.nro_moneda = que_moneda
                                  AND Cta_cte_prv.debito <> Cta_cte_prv.credito,
                                 EACH Imputacion OF Cta_cte_prv
                                   BY Cta_cte_prv.fecha_vencimiento. 
  
         WHEN ven THEN  OPEN QUERY {&BROWSE-NAME}       
                             FOR EACH Cta_cte_prv OF Proveedor 
                                WHERE Cta_cte_prv.cdg_empresa = Empresa.cdg_empresa
                                  AND Cta_cte_prv.fecha_vencimiento <= v-has_fecha
                                  AND Cta_cte_prv.nro_moneda = que_moneda
                                  AND Cta_cte_prv.debito <> Cta_cte_prv.credito,
                                 EACH Imputacion OF Cta_cte_prv
                                   BY Cta_cte_prv.fecha_vencimiento. 
  
  
    END CASE.

    CASE ficha:
          WHEN his 
          THEN DO:
               v-des_fecha:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
               v-has_fecha:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
               RUN calcular_historico (OUTPUT v-saldo).
          END.     
          WHEN anl 
          THEN DO:
               v-des_fecha:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
               v-has_fecha:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
               RUN calcular_analitico (OUTPUT v-saldo).
          END.     
          WHEN ven 
          THEN DO:
               v-des_fecha:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
               v-has_fecha:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
               RUN calcular_vencido (OUTPUT v-saldo).
          END.     
    END CASE.     
    DISPLAY v-saldo WITH FRAME {&FRAME-NAME}.

    IF AVAILABLE Cta_cte_prv
       THEN btn_programar:SENSITIVE IN FRAME {&FRAME-NAME} = 
            LOOKUP(Cta_cte_prv.tip_comprob,str_debitan_prv) <> 0 AND 
            Cta_cte_prv.tip_comprob <> "SI".
       ELSE btn_programar:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
            
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
  {src/adm/template/snd-list.i "Proveedor"}
  {src/adm/template/snd-list.i "Cta_cte_prv"}
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

