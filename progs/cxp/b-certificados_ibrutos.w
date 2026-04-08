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

DEFINE VARIABLE que_empresa   LIKE Empresa.cdg_empresa.
DEFINE VARIABLE fecha_inicial AS DATE.
DEFINE VARIABLE fecha_elegida AS DATE.

DEFINE VARIABLE todos          AS   INTEGER INITIAL 0.
DEFINE VARIABLE ya_emi         AS   INTEGER INITIAL 1.
DEFINE VARIABLE no_emi         AS   INTEGER INITIAL 2.
DEFINE VARIABLE nulos          AS   INTEGER INITIAL 3.

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
&Scoped-define INTERNAL-TABLES Certificado_ibr Tipo_retibr Proveedor

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Certificado_ibr.nro_certifibr ~
Proveedor.cdg_proveedor Proveedor.nombre Tipo_retibr.cdg_tiporetibr ~
Certificado_ibr.fecha_emision Certificado_ibr.imp_retenido ~
Certificado_ibr.imp_pagado Certificado_ibr.fecha_deposito 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table 
&Scoped-define QUERY-STRING-br_table FOR EACH Certificado_ibr WHERE ~{&KEY-PHRASE} NO-LOCK, ~
      EACH Tipo_retibr OF Certificado_ibr NO-LOCK, ~
      EACH Proveedor OF Certificado_ibr NO-LOCK ~
    ~{&SORTBY-PHRASE}
&Scoped-define OPEN-QUERY-br_table OPEN QUERY br_table FOR EACH Certificado_ibr WHERE ~{&KEY-PHRASE} NO-LOCK, ~
      EACH Tipo_retibr OF Certificado_ibr NO-LOCK, ~
      EACH Proveedor OF Certificado_ibr NO-LOCK ~
    ~{&SORTBY-PHRASE}.
&Scoped-define TABLES-IN-QUERY-br_table Certificado_ibr Tipo_retibr ~
Proveedor
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Certificado_ibr
&Scoped-define SECOND-TABLE-IN-QUERY-br_table Tipo_retibr
&Scoped-define THIRD-TABLE-IN-QUERY-br_table Proveedor


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-1 RECT-2 v-has_fecha v-des_fecha ~
ver_pagos btn_comprobte btn_emitir btn_listado br_table 
&Scoped-Define DISPLAYED-OBJECTS v-has_fecha v-des_fecha ver_pagos 

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
nro_proveedor|y|y|sic.Certificado_gan.nro_proveedor
nro_transaccion||y|sic.Certificado_gan.nro_transaccion
nro_certifgan||y|sic.Certificado_gan.nro_certifgan
cdg_empresa||y|sic.Certificado_gan.cdg_empresa
cdg_tiporetgan||y|sic.Certificado_gan.cdg_tiporetgan
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = "nro_proveedor",
     Keys-Supplied = "nro_proveedor,nro_transaccion,nro_certifgan,cdg_empresa,cdg_tiporetgan"':U).

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
     LABEL "Ver &Certificado" 
     SIZE 20 BY 1.1.

DEFINE BUTTON btn_emitir 
     LABEL "&Imprimir Certificado" 
     SIZE 20 BY 1.1.

DEFINE BUTTON btn_listado 
     LABEL "Emitir &Listado" 
     SIZE 20 BY 1.1.

DEFINE VARIABLE v-des_fecha AS DATE FORMAT "99/99/99":U 
     LABEL "Emitidos del" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE v-has_fecha AS DATE FORMAT "99/99/99":U 
     LABEL "al" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE ver_pagos AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Todos", 0,
"Ya Emitidos", 1,
"Pendientes", 2,
"Anulados", 3
     SIZE 61 BY .81 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 126 BY 1.67.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 126 BY 1.62.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Certificado_ibr, 
      Tipo_retibr, 
      Proveedor SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _STRUCTURED
  QUERY br_table NO-LOCK DISPLAY
      Certificado_ibr.nro_certifibr FORMAT ">>>>9":U
      Proveedor.cdg_proveedor FORMAT "X(8)":U WIDTH 13.4
      Proveedor.nombre FORMAT "X(34)":U WIDTH 36.8
      Tipo_retibr.cdg_tiporetibr FORMAT "X(8)":U
      Certificado_ibr.fecha_emision FORMAT "99/99/99":U
      Certificado_ibr.imp_retenido FORMAT "->,>>>,>>9.99":U
      Certificado_ibr.imp_pagado FORMAT "->,>>>,>>9.99":U
      Certificado_ibr.fecha_deposito FORMAT "99/99/99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 126 BY 21.43
         BGCOLOR 15 FGCOLOR 9 
         TITLE BGCOLOR 15 FGCOLOR 9 "Certificados emitidos o no por fecha de emision".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     v-has_fecha AT ROW 1.24 COL 30 COLON-ALIGNED
     v-des_fecha AT ROW 1.29 COL 12 COLON-ALIGNED
     ver_pagos AT ROW 1.48 COL 64 NO-LABEL
     btn_comprobte AT ROW 3.14 COL 4
     btn_emitir AT ROW 3.14 COL 26
     btn_listado AT ROW 3.14 COL 105
     br_table AT ROW 4.81 COL 1
     "Mostrar:" VIEW-AS TEXT
          SIZE 7 BY .81 AT ROW 1.48 COL 55
     RECT-1 AT ROW 1 COL 1
     RECT-2 AT ROW 2.91 COL 1
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
         HEIGHT             = 25.57
         WIDTH              = 138.2.
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
     _TblList          = "sic.Certificado_ibr,sic.Tipo_retibr OF sic.Certificado_ibr,sic.Proveedor OF sic.Certificado_ibr"
     _Options          = "NO-LOCK KEY-PHRASE SORTBY-PHRASE"
     _FldNameList[1]   = sic.Certificado_ibr.nro_certifibr
     _FldNameList[2]   > sic.Proveedor.cdg_proveedor
"Proveedor.cdg_proveedor" ? ? "character" ? ? ? ? ? ? no ? no no "13.4" yes no no "U" "" ""
     _FldNameList[3]   > sic.Proveedor.nombre
"Proveedor.nombre" ? "X(34)" "character" ? ? ? ? ? ? no ? no no "36.8" yes no no "U" "" ""
     _FldNameList[4]   = sic.Tipo_retibr.cdg_tiporetibr
     _FldNameList[5]   = sic.Certificado_ibr.fecha_emision
     _FldNameList[6]   = sic.Certificado_ibr.imp_retenido
     _FldNameList[7]   = sic.Certificado_ibr.imp_pagado
     _FldNameList[8]   = sic.Certificado_ibr.fecha_deposito
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
ON MOUSE-SELECT-DBLCLICK OF br_table IN FRAME F-Main /* Certificados emitidos o no por fecha de emision */
DO:
  APPLY "CHOOSE" TO btn_comprobte.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON RETURN OF br_table IN FRAME F-Main /* Certificados emitidos o no por fecha de emision */
DO:
  APPLY "CHOOSE" TO btn_comprobte.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-ENTRY OF br_table IN FRAME F-Main /* Certificados emitidos o no por fecha de emision */
DO:
  /* This code displays initial values for newly added or copied rows. */
  {src/adm/template/brsentry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-LEAVE OF br_table IN FRAME F-Main /* Certificados emitidos o no por fecha de emision */
DO:
    /* Do not disable this code or no updates will take place except
     by pressing the Save button on an Update SmartPanel. */
   {src/adm/template/brsleave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON VALUE-CHANGED OF br_table IN FRAME F-Main /* Certificados emitidos o no por fecha de emision */
DO:
  /* This ADM trigger code must be preserved in order to notify other
     objects when the browser's current row changes. */
  {src/adm/template/brschnge.i}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_comprobte
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_comprobte B-table-Win
ON CHOOSE OF btn_comprobte IN FRAME F-Main /* Ver Certificado */
DO:
  IF AVAILABLE Certificado_ibr
  THEN DO:
       RUN d-ver_certificado_ibrutos.w ( INPUT ROWID(Certificado_ibr)).
  END.
  ELSE DO:       
       BELL.
  END.
     
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_emitir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_emitir B-table-Win
ON CHOOSE OF btn_emitir IN FRAME F-Main /* Imprimir Certificado */
DO:
  IF AVAILABLE Certificado_ibr
  THEN DO:
       RUN imprimir_certificado_ibr.p ( INPUT ROWID(Certificado_ibr)).
       RUN dispatch IN THIS-PROCEDURE ('open-query':U).
  END.
  ELSE DO:
       BELL.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_listado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_listado B-table-Win
ON CHOOSE OF btn_listado IN FRAME F-Main /* Emitir Listado */
DO:
   RUN  listar_certificados_ibrutos.p (INPUT v-des_fecha,
                                       INPUT v-has_fecha,
                                       INPUT ver_pagos).
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-des_fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-des_fecha B-table-Win
ON MOUSE-MENU-DOWN OF v-des_fecha IN FRAME F-Main /* Emitidos del */
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
ON RETURN OF v-des_fecha IN FRAME F-Main /* Emitidos del */
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


&Scoped-define SELF-NAME ver_pagos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ver_pagos B-table-Win
ON VALUE-CHANGED OF ver_pagos IN FRAME F-Main
DO:

  ASSIGN FRAME {&FRAME-NAME} ver_pagos.
  CASE ver_pagos:
    WHEN todos
    THEN DO:
         {&BROWSE-NAME}:TITLE = "Certificados emitidos o no".
    END.
    WHEN ya_emi
    THEN DO:
         {&BROWSE-NAME}:TITLE = "Certificados ya emitidos".
    END.
    WHEN no_emi
    THEN DO:
         {&BROWSE-NAME}:TITLE = "Certificados pendientes de emision".
    END.
  END CASE.
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
  DEF VAR key-value AS CHAR NO-UNDO.

  /* Look up the current key-value. */
  RUN get-attribute ('Key-Value':U).
  key-value = RETURN-VALUE.

  /* Find the current record using the current Key-Name. */
  RUN get-attribute ('Key-Name':U).
  CASE RETURN-VALUE:
    WHEN 'nro_proveedor':U THEN DO:
       &Scope KEY-PHRASE Certificado_gan.nro_proveedor eq INTEGER(key-value)
       {&OPEN-QUERY-{&BROWSE-NAME}}
    END. /* nro_proveedor */
    OTHERWISE DO:
       &Scope KEY-PHRASE TRUE
       {&OPEN-QUERY-{&BROWSE-NAME}}
    END. /* OTHERWISE...*/
  END CASE.

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
  
  v-has_fecha = TODAY.
  v-des_fecha = v-has_fecha - 90.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

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

  CASE ver_pagos:

    WHEN todos
    THEN DO:
        OPEN QUERY {&BROWSE-NAME}
             FOR EACH Certificado_ibr
                WHERE NOT Certificado_ibr.anulado
                  AND Certificado_ibr.cdg_empresa = que_empresa
                  AND Certificado_ibr.fecha_emision <= v-has_fecha
                  AND Certificado_ibr.fecha_emision >= v-des_fecha,
                FIRST Tipo_retibr OF Certificado_ibr, FIRST Proveedor OF Certificado_ibr
                   BY Certificado_ibr.fecha_emision.
    END.
    WHEN ya_emi
    THEN DO:
        OPEN QUERY {&BROWSE-NAME}
             FOR EACH Certificado_ibr
                WHERE NOT Certificado_ibr.anulado
                  AND Certificado_ibr.cdg_empresa = que_empresa
                  AND Certificado_ibr.fecha_emision <= v-has_fecha
                  AND Certificado_ibr.fecha_emision >= v-des_fecha
                  AND Certificado_ibr.emitido,
                FIRST Tipo_retibr OF Certificado_ibr, FIRST Proveedor OF Certificado_ibr
                   BY Certificado_ibr.fecha_emision.

    END.
    WHEN no_emi
    THEN DO:
        OPEN QUERY {&BROWSE-NAME}
             FOR EACH Certificado_ibr
                WHERE NOT Certificado_ibr.anulado
                  AND Certificado_ibr.cdg_empresa = que_empresa
                  AND Certificado_ibr.fecha_emision <= v-has_fecha
                  AND Certificado_ibr.fecha_emision >= v-des_fecha
                  AND NOT Certificado_ibr.emitido,
                FIRST Tipo_retibr OF Certificado_ibr, FIRST Proveedor OF Certificado_ibr
                   BY Certificado_ibr.fecha_emision.

    END.
    WHEN nulos
    THEN DO:
        OPEN QUERY {&BROWSE-NAME}
             FOR EACH Certificado_ibr
                WHERE Certificado_ibr.anulado
                  AND Certificado_ibr.cdg_empresa = que_empresa
                  AND Certificado_ibr.fecha_emision <= v-has_fecha
                  AND Certificado_ibr.fecha_emision >= v-des_fecha,
                FIRST Tipo_retibr OF Certificado_ibr, FIRST Proveedor OF Certificado_ibr
                   BY Certificado_ibr.fecha_emision.
    END.

  END CASE.

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
  {src/adm/template/sndkycas.i "nro_proveedor" "Certificado_gan" "nro_proveedor"}
  {src/adm/template/sndkycas.i "nro_transaccion" "Certificado_gan" "nro_transaccion"}
  {src/adm/template/sndkycas.i "nro_certifgan" "Certificado_gan" "nro_certifgan"}
  {src/adm/template/sndkycas.i "cdg_empresa" "Certificado_gan" "cdg_empresa"}
  {src/adm/template/sndkycas.i "cdg_tiporetgan" "Certificado_gan" "cdg_tiporetgan"}

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
  {src/adm/template/snd-list.i "Certificado_ibr"}
  {src/adm/template/snd-list.i "Tipo_retibr"}
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

