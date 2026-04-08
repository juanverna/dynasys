&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win

/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Cta_cte_prv NO-UNDO LIKE Cta_cte_prv.


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------

  File: 

  Description: 

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: 

------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
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

DEFINE VARIABLE todos          AS   INTEGER INITIAL 0.
DEFINE VARIABLE con_p          AS   INTEGER INITIAL 1.
DEFINE VARIABLE sin_p          AS   INTEGER INITIAL 2.

DEFINE VARIABLE v_saldo        AS DECIMAL.
DEFINE VARIABLE x-saldo        AS DECIMAL.

DEFINE VARIABLE fecha_inicial  AS DATE.
DEFINE VARIABLE fecha_elegida  AS DATE.

DEFINE VARIABLE mensaje        AS CHARACTER FORMAT "X(40)".

DEFINE VARIABLE ant_anulado    LIKE Fac_header_prv.anulado.
DEFINE VARIABLE que_empresa    LIKE Empresa.cdg_empresa.
DEFINE VARIABLE que_moneda     LIKE Moneda.nro_moneda.
DEFINE VARIABLE l-str_debitan  AS CHARACTER.

{nrorelea.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME BROWSE-6

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Cta_cte_prv Proveedor

/* Definitions for BROWSE BROWSE-6                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-6 Proveedor.cdg_proveedor ~
Proveedor.nombre T-Cta_cte_prv.tip_comprob T-Cta_cte_prv.prf_comprob ~
T-Cta_cte_prv.nro_comprob T-Cta_cte_prv.fecha_emision ~
T-Cta_cte_prv.fecha_vencimiento T-Cta_cte_prv.imp_programado ~
T-Cta_cte_prv.credito - T-Cta_cte_prv.debito @ x-saldo 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-6 ~
T-Cta_cte_prv.imp_programado 
&Scoped-define ENABLED-TABLES-IN-QUERY-BROWSE-6 T-Cta_cte_prv
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-BROWSE-6 T-Cta_cte_prv
&Scoped-define QUERY-STRING-BROWSE-6 FOR EACH T-Cta_cte_prv NO-LOCK, ~
      EACH Proveedor OF T-Cta_cte_prv NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-6 OPEN QUERY BROWSE-6 FOR EACH T-Cta_cte_prv NO-LOCK, ~
      EACH Proveedor OF T-Cta_cte_prv NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-6 T-Cta_cte_prv Proveedor
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-6 T-Cta_cte_prv
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-6 Proveedor


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-BROWSE-6}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS id_moneda v-des_fecha v-has_fecha ~
btn_comprobte btn_listado v-medio_pago btn_generalote v-ultimo_lote ~
v-fecha_pago v-total_pago BROWSE-6 RECT-1 
&Scoped-Define DISPLAYED-OBJECTS id_moneda v-des_fecha v-has_fecha ~
v-medio_pago v-ultimo_lote v-cuenta_bancaria v-fecha_pago v-total_pago 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btn_comprobte 
     LABEL "&Ver Comprobante" 
     SIZE 25 BY 1.14.

DEFINE BUTTON btn_generalote 
     LABEL "&Generar Lote de Pagos" 
     SIZE 25 BY 1.14.

DEFINE BUTTON btn_listado 
     LABEL "&Listar" 
     SIZE 25 BY 1.14.

DEFINE VARIABLE id_moneda AS CHARACTER FORMAT "X(256)":U 
     LABEL "Moneda" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "Item 1" 
     DROP-DOWN-LIST
     SIZE 32 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE v-cuenta_bancaria AS CHARACTER FORMAT "X(256)":U 
     LABEL "Cuenta" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Item 1","Item 1"
     DROP-DOWN-LIST
     SIZE 70 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-medio_pago AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Medio" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Item 1",0
     DROP-DOWN-LIST
     SIZE 70 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-des_fecha AS DATE FORMAT "99/99/99":U 
     LABEL "Del" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE v-fecha_pago AS DATE FORMAT "99/99/99":U 
     LABEL "Fecha de Pago" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 14 FGCOLOR 9 FONT 6 NO-UNDO.

DEFINE VARIABLE v-has_fecha AS DATE FORMAT "99/99/99":U 
     LABEL "al" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE v-total_pago AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     LABEL "Total a Pagar" 
     VIEW-AS FILL-IN 
     SIZE 19 BY 1
     BGCOLOR 14 FGCOLOR 9 FONT 6 NO-UNDO.

DEFINE VARIABLE v-ultimo_lote AS INTEGER FORMAT ">>>>>>9":U INITIAL 0 
     LABEL "Ultimo Lote" 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 154 BY 4.29.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-6 FOR 
      T-Cta_cte_prv, 
      Proveedor SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-6
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-6 C-Win _STRUCTURED
  QUERY BROWSE-6 NO-LOCK DISPLAY
      Proveedor.cdg_proveedor FORMAT "X(8)":U
      Proveedor.nombre FORMAT "X(40)":U WIDTH 65.6
      T-Cta_cte_prv.tip_comprob FORMAT "X(3)":U
      T-Cta_cte_prv.prf_comprob FORMAT "9999":U
      T-Cta_cte_prv.nro_comprob FORMAT "ZZZZZZZ9":U
      T-Cta_cte_prv.fecha_emision FORMAT "99/99/99":U
      T-Cta_cte_prv.fecha_vencimiento FORMAT "99/99/99":U
      T-Cta_cte_prv.imp_programado FORMAT "->>,>>>,>>9.99":U
      T-Cta_cte_prv.credito - T-Cta_cte_prv.debito @ x-saldo COLUMN-LABEL "Saldo!Comprobante" FORMAT "->>,>>>,>>9.99":U
            WIDTH 15.6
  ENABLE
      T-Cta_cte_prv.imp_programado
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 154 BY 21.19
         TITLE "Pagos pendientes por fecha de pago" EXPANDABLE.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     id_moneda AT ROW 1.48 COL 10 COLON-ALIGNED
     v-des_fecha AT ROW 1.48 COL 48 COLON-ALIGNED
     v-has_fecha AT ROW 1.48 COL 66 COLON-ALIGNED
     btn_comprobte AT ROW 1.48 COL 100
     btn_listado AT ROW 1.48 COL 128
     v-medio_pago AT ROW 2.67 COL 10 COLON-ALIGNED
     btn_generalote AT ROW 2.67 COL 100
     v-ultimo_lote AT ROW 2.67 COL 139 COLON-ALIGNED
     v-cuenta_bancaria AT ROW 3.86 COL 10 COLON-ALIGNED
     v-fecha_pago AT ROW 3.86 COL 98 COLON-ALIGNED
     v-total_pago AT ROW 3.86 COL 132 COLON-ALIGNED
     BROWSE-6 AT ROW 5.52 COL 1
     RECT-1 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 159.6 BY 26.24.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Cta_cte_prv T "?" NO-UNDO sic Cta_cte_prv
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Generación de Lotes de Pagos"
         HEIGHT             = 26.24
         WIDTH              = 159.6
         MAX-HEIGHT         = 26.24
         MAX-WIDTH          = 159.6
         VIRTUAL-HEIGHT     = 26.24
         VIRTUAL-WIDTH      = 159.6
         RESIZE             = yes
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         KEEP-FRAME-Z-ORDER = yes
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME DEFAULT-FRAME
                                                                        */
/* BROWSE-TAB BROWSE-6 v-total_pago DEFAULT-FRAME */
/* SETTINGS FOR COMBO-BOX v-cuenta_bancaria IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-6
/* Query rebuild information for BROWSE BROWSE-6
     _TblList          = "Temp-Tables.T-Cta_cte_prv,sic.Proveedor OF Temp-Tables.T-Cta_cte_prv"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   = sic.Proveedor.cdg_proveedor
     _FldNameList[2]   > sic.Proveedor.nombre
"sic.Proveedor.nombre" ? ? "character" ? ? ? ? ? ? no ? no no "65.6" yes no no "U" "" ""
     _FldNameList[3]   = Temp-Tables.T-Cta_cte_prv.tip_comprob
     _FldNameList[4]   = Temp-Tables.T-Cta_cte_prv.prf_comprob
     _FldNameList[5]   = Temp-Tables.T-Cta_cte_prv.nro_comprob
     _FldNameList[6]   = Temp-Tables.T-Cta_cte_prv.fecha_emision
     _FldNameList[7]   = Temp-Tables.T-Cta_cte_prv.fecha_vencimiento
     _FldNameList[8]   > Temp-Tables.T-Cta_cte_prv.imp_programado
"Temp-Tables.T-Cta_cte_prv.imp_programado" ? ? "decimal" ? ? ? ? ? ? yes ? no no ? yes no no "U" "" ""
     _FldNameList[9]   > "_<CALC>"
"T-Cta_cte_prv.credito - T-Cta_cte_prv.debito @ x-saldo" "Saldo!Comprobante" "->>,>>>,>>9.99" ? ? ? ? ? ? ? no ? no no "15.6" yes no no "U" "" ""
     _Query            is OPENED
*/  /* BROWSE BROWSE-6 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Generación de Lotes de Pagos */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Generación de Lotes de Pagos */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-6
&Scoped-define SELF-NAME BROWSE-6
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-6 C-Win
ON MOUSE-SELECT-DBLCLICK OF BROWSE-6 IN FRAME DEFAULT-FRAME /* Pagos pendientes por fecha de pago */
OR "RETURN" OF {&BROWSE-NAME}
DO:

  FIND CURRENT T-Cta_cte_prv EXCLUSIVE-LOCK.
  IF T-Cta_cte_prv.user-id-sel = ""
  THEN DO:
      v-total_pago = v-total_pago + T-Cta_cte_prv.imp_programado.
      T-Cta_cte_prv.user-id-sel = "*".
      RUN poner_color ( YES ).
  END.
  ELSE DO:
      v-total_pago = v-total_pago - T-Cta_cte_prv.imp_programado.
      T-Cta_cte_prv.user-id-sel = "".
      RUN poner_color ( NO ).
  END.

  FIND CURRENT T-Cta_cte_prv NO-LOCK.
  DISPLAY v-total_pago
      WITH FRAME {&FRAME-NAME}.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_comprobte
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_comprobte C-Win
ON CHOOSE OF btn_comprobte IN FRAME DEFAULT-FRAME /* Ver Comprobante */
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
        RUN c-comprobante_proveedor.w ( INPUT Fac_header_prv.cdg_comprobante, INPUT-OUTPUT act_fpr_head , INPUT 2 ).
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


&Scoped-define SELF-NAME btn_generalote
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_generalote C-Win
ON CHOOSE OF btn_generalote IN FRAME DEFAULT-FRAME /* Generar Lote de Pagos */
DO:
  DEFINE VARIABLE sino AS LOGICAL.
  sino = NO.
  MESSAGE "Desea generar el lote de pago" 
      VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO  TITLE "Confirmación" SET sino.
  IF sino
  THEN DO:
      RUN generar_lote_pagos.
  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_listado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_listado C-Win
ON CHOOSE OF btn_listado IN FRAME DEFAULT-FRAME /* Listar */
DO:
   RUN lsprogramacion_pagos.p (INPUT v-des_fecha,
                               INPUT v-has_fecha,
                               INPUT 1,
                               ROWID(Moneda)).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME id_moneda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL id_moneda C-Win
ON VALUE-CHANGED OF id_moneda IN FRAME DEFAULT-FRAME /* Moneda */
DO:
    FIND Moneda WHERE Moneda.descripcion = id_moneda:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
    que_moneda = Moneda.nro_moneda.
    RUN abrir_query.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-des_fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-des_fecha C-Win
ON MOUSE-MENU-DOWN OF v-des_fecha IN FRAME DEFAULT-FRAME /* Del */
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-des_fecha C-Win
ON RETURN OF v-des_fecha IN FRAME DEFAULT-FRAME /* Del */
DO:
  ASSIGN v-des_fecha.
  RUN abrir_query.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-has_fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-has_fecha C-Win
ON MOUSE-MENU-DOWN OF v-has_fecha IN FRAME DEFAULT-FRAME /* al */
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-has_fecha C-Win
ON RETURN OF v-has_fecha IN FRAME DEFAULT-FRAME /* al */
DO:
  ASSIGN v-has_fecha.
  RUN abrir_query.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-medio_pago
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-medio_pago C-Win
ON VALUE-CHANGED OF v-medio_pago IN FRAME DEFAULT-FRAME /* Medio */
DO:
  ASSIGN FRAME {&FRAME-NAME} v-medio_pago.
  RUN tratar_cuentas ( INPUT v-medio_pago ).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.

/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
   RUN disable_UI.

/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN inicializar.
  {setwintit.i "SIC/TES" "Generación de Lotes de Pagos"}
  RUN enable_UI.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE abrir_query C-Win 
PROCEDURE abrir_query :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE titulo AS CHARACTER.

    titulo = {&BROWSE-NAME}:TITLE IN FRAME {&FRAME-NAME}.
    {&BROWSE-NAME}:TITLE IN FRAME {&FRAME-NAME} = "Recuperando datos ...".

    RUN levantar_ctacteprv.p ( INPUT que_empresa,
                               INPUT que_moneda,
                               INPUT v-des_fecha,
                               INPUT v-has_fecha,
                               OUTPUT TABLE T-Cta_cte_prv ).

    {&OPEN-QUERY-{&BROWSE-NAME}}

    {&BROWSE-NAME}:TITLE IN FRAME {&FRAME-NAME} = titulo.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE cargar_cuentas_bancarias C-Win 
PROCEDURE cargar_cuentas_bancarias :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

 DEFINE INPUT PARAMETER p-que_banco AS INTEGER.
 
 DEFINE VARIABLE x-lista AS CHARACTER.

 DO WITH FRAME {&FRAME-NAME}:
     x-lista = "".
     v-cuenta_bancaria:DELIMITER  = "|".
     FOR EACH Cuenta_bancaria NO-LOCK
         WHERE Cuenta_bancaria.cdg_empresa = Empresa.cdg_empresa 
           AND Cuenta_bancaria.cdg_banco = p-que_banco
               BY Cuenta_bancaria.denominacion:
         x-lista = x-lista + "|" + TRIM(Cuenta_bancaria.denominacion) + "|" + STRING(Cuenta_bancaria.cdg_cuenta_ban).
     END.
     IF x-lista = ""
     THEN DO:
         v-cuenta_bancaria:DELIMITER IN FRAME {&FRAME-NAME} = "|".
         v-cuenta_bancaria:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = "NO HAY DEFINICION DE CUENTAS BANCARIAS|ZZZ".
         v-cuenta_bancaria = "ZZZ".
         DISPLAY v-cuenta_bancaria WITH FRAME {&FRAME-NAME}.
         MESSAGE "No se definieron las cuentas bancarias para el medio de pago referido" VIEW-AS ALERT-BOX MESSAGE 
             TITLE "ERROR DE IMPLEMENTACION".
     END.
     ELSE DO:
         v-cuenta_bancaria:LIST-ITEM-PAIRS = SUBSTRING(x-lista,2).
         v-cuenta_bancaria = ENTRY(2,v-cuenta_bancaria:LIST-ITEM-PAIRS,"|").
         DISPLAY v-cuenta_bancaria.
     END.
 END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI C-Win  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Delete the WINDOW we created */
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
  THEN DELETE WIDGET C-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI C-Win  _DEFAULT-ENABLE
PROCEDURE enable_UI :
/*------------------------------------------------------------------------------
  Purpose:     ENABLE the User Interface
  Parameters:  <none>
  Notes:       Here we display/view/enable the widgets in the
               user-interface.  In addition, OPEN all queries
               associated with each FRAME and BROWSE.
               These statements here are based on the "Other 
               Settings" section of the widget Property Sheets.
------------------------------------------------------------------------------*/
  DISPLAY id_moneda v-des_fecha v-has_fecha v-medio_pago v-ultimo_lote 
          v-cuenta_bancaria v-fecha_pago v-total_pago 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE id_moneda v-des_fecha v-has_fecha btn_comprobte btn_listado 
         v-medio_pago btn_generalote v-ultimo_lote v-fecha_pago v-total_pago 
         BROWSE-6 RECT-1 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE generar_lote_pagos C-Win 
PROCEDURE generar_lote_pagos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE lista_errores AS CHARACTER.
  DEFINE VARIABLE j             AS INTEGER.
  
  {findempresa.i}

  DO TRANSACTION:
      CREATE Lote_pago.
      ASSIGN Lote_pago.cdg_empresa      = Empresa.cdg_empresa
             Lote_pago.confirmado       = NO
             Lote_pago.fecha_pago       = TODAY
             Lote_pago.nro_usuario_aut  = 0
             Lote_pago.nro_usuario_prp  = Usuario.nro_usuario
             Lote_pago.numero_lote      = 1
             Lote_pago.observacion      = "".
    
      DO WITH FRAME {&FRAME-NAME}:
         DO j = 1 TO {&BROWSE-NAME}:NUM-SELECTED-ROWS:
            {&BROWSE-NAME}:SCROLL-TO-SELECTED-ROW(j).
            {&BROWSE-NAME}:FETCH-SELECTED-ROW(j).
            CREATE Lote-factura.
            BUFFER-COPY Cta_cte_prv TO Lote-factura
                ASSIGN Lote-factura.importe = Cta_cte_prv.imp_programado
                       Lote-factura.numero_lote = Lote_pago.numero_lote.
         END.
      END.
  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE inicializar C-Win 
PROCEDURE inicializar :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

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

  v-fecha_pago = TODAY.

  RUN inicia_combos.


  DISPLAY v-des_fecha 
          v-has_fecha
          v-fecha_pago
          WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE inicia_combos C-Win 
PROCEDURE inicia_combos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  
  DEFINE VARIABLE lista AS CHARACTER.

  DO WITH FRAME {&FRAME-NAME}:
     {levantacombo.i &TABLA=Rubro &NOMBRE=nombre &CODIGO=cdg_rubro &OBJETO=v-medio_pago &CONDICION="Rubro.tipo = 'P' OR Rubro.tipo = 'B'"}
/*     {levantacombo.i &TABLA=Cuenta_bancaria &NOMBRE=denominacion_cta &CODIGO=cdg_cuenta_ban &OBJETO=v-cuenta_bancaria}*/
  END.          
  v-medio_pago = INTEGER(ENTRY(2,v-medio_pago:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME},"|")).
  RUN tratar_cuentas ( INPUT v-medio_pago ).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_color C-Win 
PROCEDURE poner_color :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER p-seleccion AS LOGICAL.

  IF p-selecCion
  THEN DO:
      T-Cta_cte_prv.imp_programa:FGCOLOR IN BROWSE {&BROWSE-NAME} = 15.
      T-Cta_cte_prv.imp_programa:BGCOLOR IN BROWSE {&BROWSE-NAME} = 9.
  END.
  ELSE DO:
      T-Cta_cte_prv.imp_programa:FGCOLOR IN BROWSE {&BROWSE-NAME} = 9.
      T-Cta_cte_prv.imp_programa:BGCOLOR IN BROWSE {&BROWSE-NAME} = 15.
  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE tratar_cuentas C-Win 
PROCEDURE tratar_cuentas :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER p-medio_pago LIKE v-medio_pago.

  FIND Rubro WHERE Rubro.cdg_rubro = p-medio_pago NO-LOCK.
  IF Rubro.tipo = "P" /* Cheque Propio */
    OR Rubro.tipo = "B" /* Debito Bancario, transferencia */
  THEN DO:
      v-cuenta_bancaria:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
      RUN cargar_cuentas_bancarias ( INPUT Rubro.cdg_banco ).
  END.
  ELSE DO:
      v-cuenta_bancaria:DELIMITER IN FRAME {&FRAME-NAME} = "|".
      v-cuenta_bancaria:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = "NO APLICABLE|ZZZ".
      v-cuenta_bancaria = "ZZZ".
      DISPLAY v-cuenta_bancaria WITH FRAME {&FRAME-NAME}.
      v-cuenta_bancaria:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

