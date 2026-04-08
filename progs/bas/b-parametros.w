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
DEFINE TEMP-TABLE tt NO-UNDO LIKE parametro.

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

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Parametro

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Parametro.cdg_parametro ~
Parametro.descripcion Parametro.tipo 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table 
&Scoped-define QUERY-STRING-br_table FOR EACH Parametro WHERE ~{&KEY-PHRASE} ~
      AND Parametro.cdg_empresa = que_empresa NO-LOCK ~
    ~{&SORTBY-PHRASE}
&Scoped-define OPEN-QUERY-br_table OPEN QUERY br_table FOR EACH Parametro WHERE ~{&KEY-PHRASE} ~
      AND Parametro.cdg_empresa = que_empresa NO-LOCK ~
    ~{&SORTBY-PHRASE}.
&Scoped-define TABLES-IN-QUERY-br_table Parametro
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Parametro


/* Definitions for FRAME F-Main                                         */
&Scoped-define OPEN-BROWSERS-IN-QUERY-F-Main ~
    ~{&OPEN-QUERY-br_table}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-2 btn_copiar btn_export btn_import ~
v-empresa que_codigo que_dexcrip br_table 
&Scoped-Define DISPLAYED-OBJECTS v-empresa que_codigo que_dexcrip 

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
cdg_empresa|y|y|sic.Parametro.cdg_empresa
descripcion||y|sic.Parametro.descripcion
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = "cdg_empresa",
     Keys-Supplied = "cdg_empresa,descripcion"':U).

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


/* Definitions of handles for OCX Containers                            */
DEFINE VARIABLE CtrlFrame AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE chCtrlFrame AS COMPONENT-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btn_copiar 
     LABEL "&Copiar" 
     SIZE 13 BY 1.14.

DEFINE BUTTON btn_export 
     LABEL "&Export" 
     SIZE 8 BY 1.14.

DEFINE BUTTON btn_import 
     LABEL "&Import" 
     SIZE 8 BY 1.14.

DEFINE VARIABLE v-empresa AS CHARACTER FORMAT "X(256)":U 
     LABEL "Empresa" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "item1","item1"
     DROP-DOWN-LIST
     SIZE 34 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE que_codigo AS CHARACTER FORMAT "X(8)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 22 BY 1 TOOLTIP "Busqueda por codigo"
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE que_dexcrip AS CHARACTER FORMAT "X(8)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 37.6 BY 1 TOOLTIP "Busca el patron en la descripcion"
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 156 BY 13.33.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Parametro SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _STRUCTURED
  QUERY br_table NO-LOCK DISPLAY
      Parametro.cdg_parametro COLUMN-LABEL "Código!Parámetro" FORMAT "X(11)":U
            WIDTH 15.2
      Parametro.descripcion COLUMN-LABEL "Descripción!Parámetro" FORMAT "X(110)":U
            WIDTH 125.2
      Parametro.tipo COLUMN-LABEL "Tipo!Parám" FORMAT "X(1)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN NO-ROW-MARKERS SEPARATORS MULTIPLE SIZE 153 BY 11.48
         BGCOLOR 11 FGCOLOR 9 FONT 4
         TITLE BGCOLOR 11 FGCOLOR 9 "Parámetros Generales".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     btn_copiar AT ROW 1.24 COL 78
     btn_export AT ROW 1.24 COL 92.8 WIDGET-ID 8
     btn_import AT ROW 1.24 COL 102.6 WIDGET-ID 10
     v-empresa AT ROW 1.24 COL 120 COLON-ALIGNED
     que_codigo AT ROW 1.29 COL 3 NO-LABEL
     que_dexcrip AT ROW 1.29 COL 37.4 NO-LABEL WIDGET-ID 2
     br_table AT ROW 2.62 COL 3
     RECT-2 AT ROW 1 COL 1
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
         HEIGHT             = 27.33
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
   NOT-VISIBLE FRAME-NAME Size-to-Fit                                   */
/* BROWSE-TAB br_table que_dexcrip F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN que_codigo IN FRAME F-Main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN que_dexcrip IN FRAME F-Main
   ALIGN-L                                                              */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _TblList          = "sic.Parametro"
     _Options          = "NO-LOCK KEY-PHRASE SORTBY-PHRASE"
     _Where[1]         = "sic.Parametro.cdg_empresa = que_empresa"
     _FldNameList[1]   > sic.Parametro.cdg_parametro
"Parametro.cdg_parametro" "Código!Parámetro" "X(11)" "character" ? ? ? ? ? ? no ? no no "15.2" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > sic.Parametro.descripcion
"Parametro.descripcion" "Descripción!Parámetro" "X(110)" "character" ? ? ? ? ? ? no ? no no "125.2" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > sic.Parametro.tipo
"Parametro.tipo" "Tipo!Parám" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is OPENED
*/  /* BROWSE br_table */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME F-Main
/* Query rebuild information for FRAME F-Main
     _Options          = "NO-LOCK"
     _Query            is NOT OPENED
*/  /* FRAME F-Main */
&ANALYZE-RESUME

 


/* **********************  Create OCX Containers  ********************** */

&ANALYZE-SUSPEND _CREATE-DYNAMIC

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN

CREATE CONTROL-FRAME CtrlFrame ASSIGN
       FRAME           = FRAME F-Main:HANDLE
       ROW             = 1.29
       COLUMN          = 28
       HEIGHT          = .95
       WIDTH           = 5
       WIDGET-ID       = 6
       HIDDEN          = no
       SENSITIVE       = yes.

PROCEDURE adm-create-controls:
      CtrlFrame:NAME = "CtrlFrame":U .
/* CtrlFrame OCXINFO:CREATE-CONTROL from: {EAF26C8F-9586-101B-9306-0020AF234C9D} type: CSSpin */
      CtrlFrame:MOVE-AFTER(que_codigo:HANDLE IN FRAME F-Main).

END PROCEDURE.

&ENDIF

&ANALYZE-RESUME /* End of _CREATE-DYNAMIC */


/* ************************  Control Triggers  ************************ */

&Scoped-define BROWSE-NAME br_table
&Scoped-define SELF-NAME br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-ENTRY OF br_table IN FRAME F-Main /* Parámetros Generales */
DO:
  /* This code displays initial values for newly added or copied rows. */
  {src/adm/template/brsentry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-LEAVE OF br_table IN FRAME F-Main /* Parámetros Generales */
DO:
    /* Do not disable this code or no updates will take place except
     by pressing the Save button on an Update SmartPanel. */
   {src/adm/template/brsleave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON VALUE-CHANGED OF br_table IN FRAME F-Main /* Parámetros Generales */
DO:
  /* This ADM trigger code must be preserved in order to notify other
     objects when the browser's current row changes. */
  {src/adm/template/brschnge.i}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_copiar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_copiar B-table-Win
ON CHOOSE OF btn_copiar IN FRAME F-Main /* Copiar */
DO:

  DEFINE VARIABLE sino      AS LOGICAL.
  DEFINE VARIABLE n_empresa LIKE Empresa.cdg_empresa.
  DEFINE BUFFER B-Parametro FOR Parametro.
  DEFINE BUFFER C-Parametro FOR Parametro.

  sino = NO.
  MESSAGE "Esta función copia todos los parámetros de una empresa a otra, cuyos parámetros"
          "todavía NO EXISTEN. No se copian parámetros EXISTENTES. Indique si procede." 
          VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirme la copia"  UPDATE sino .
  IF sino
  THEN DO:

       SET n_empresa LABEL "Nueva Empresa"
           WITH FRAME f_nueva VIEW-AS DIALOG-BOX THREE-D SIDE-LABELS TITLE "Indique destino".

       FOR EACH B-parametro WHERE B-Parametro.cdg_empresa = que_empresa:

           FIND C-Parametro WHERE C-Parametro.cdg_empresa = n_empresa
                              AND C-Parametro.cdg_parametro = B-Parametro.cdg_parametro
                                  NO-LOCK NO-ERROR.
           IF NOT AVAILABLE C-Parametro
           THEN DO:
                CREATE C-Parametro.
                BUFFER-COPY B-Parametro To C-Parametro 
                            ASSIGN C-Parametro.cdg_empresa = n_empresa.
           END.            
       END.
       MESSAGE "Terminada la copia de parámetros"
                VIEW-AS ALERT-BOX MESSAGE TITLE "Mensaje".

  END.        
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_export
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_export B-table-Win
ON CHOOSE OF btn_export IN FRAME F-Main /* Export */
DO:

  DEFINE VARIABLE sino      AS LOGICAL NO-UNDO.
  DEFINE VARIABLE n_empresa LIKE Empresa.cdg_empresa NO-UNDO.
  DEFINE VARIABLE n_file AS CHAR FORMAT "X(40)" NO-UNDO.
  DEFINE BUFFER B-Parametro FOR Parametro.
  DEFINE BUFFER C-Parametro FOR Parametro.
  
  DEFINE VAR i AS INT64 NO-UNDO.
  sino = NO.
  MESSAGE "Esta función exporta los parametros seleccionados seleccionados a archivo XML" SKIP
          "Puede cambiar la empresa en la exportacion si lo desea"
          VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirme la exportaciona"  UPDATE sino .
  IF sino
  THEN DO:
       n_empresa = v-empresa.
       update n_empresa LABEL "Empresa"
              n_file LABEL "Archivo"
           WITH FRAME f_nueva VIEW-AS DIALOG-BOX THREE-D SIDE-LABELS TITLE "Indique Destino".
       EMPTY TEMP-TABLE tt.
       DO i = 1 TO br_table:NUM-SELECTED-ROWS IN FRAME {&FRAME-NAME} TRANSACTION:
         br_table:FETCH-SELECTED-ROW ( i ) NO-ERROR.
         CREATE tt.
         BUFFER-COPY parametro TO tt ASSIGN tt.cdg_empresa = n_empresa.
       END.
       TEMP-TABLE tt:WRITE-XML("File",n_file,TRUE,?,?,FALSE,FALSE).
       MESSAGE "Terminada la copia de parámetros"
                VIEW-AS ALERT-BOX MESSAGE TITLE "Mensaje".

  END.        
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_import
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_import B-table-Win
ON CHOOSE OF btn_import IN FRAME F-Main /* Import */
DO:

  DEFINE VARIABLE sino      AS LOGICAL.
  DEFINE VARIABLE n_empresa LIKE Empresa.cdg_empresa.
  DEFINE VAR n_file AS CHAR NO-UNDO.
  DEFINE BUFFER B-Parametro FOR Parametro.
  DEFINE BUFFER C-Parametro FOR Parametro.

  sino = NO.
  MESSAGE "Esta función importa los parametros del archivo selecionado en la empresa seleccionada" SKIP
          "que todavía NO EXISTEN. No se copian parámetros EXISTENTES. Indique si procede." 
          VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirme la importacion"  UPDATE sino .
  IF sino
  THEN DO:

     
  
      SYSTEM-DIALOG GET-FILE n_file    TITLE   "Elija el archivo a importar"    
          FILTERS "Excel(*.xml)"   "*.xml"
                    MUST-EXIST    
          USE-FILENAME    
          UPDATE sino.
       IF NOT sino THEN  RETURN no-apply.
           
       EMPTY TEMP-TABLE tt.
       TEMP-TABLE tt:READ-XML("FILE",n_file,"empty","",?).
       FOR EACH tt:
           FIND parametro WHERE parametro.cdg_empresa = v-empresa and
                                parametro.cdg_parametro = tt.cdg_parametro  NO-ERROR.
           IF AVAILABLE parametro THEN NEXT.
           CREATE parametro.
           BUFFER-COPY tt TO parametro ASSIGN parametro.cdg_empresa = v-empresa.
       END.
       
       MESSAGE "Terminada la importacion de parámetros"
                VIEW-AS ALERT-BOX MESSAGE TITLE "Mensaje".

  END.        
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME CtrlFrame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL CtrlFrame B-table-Win OCX.Change
PROCEDURE CtrlFrame.CSSpin.Change .
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  None required for OCX.
  Notes:       
------------------------------------------------------------------------------*/
APPLY "return" TO que_dexcrip IN FRAME {&FRAME-NAME}.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME que_codigo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_codigo B-table-Win
ON RETURN OF que_codigo IN FRAME F-Main
OR "TAB" OF que_codigo IN FRAME {&FRAME-NAME}
DO:
 
  &SCOPED-DEFINE CODIGO cdg_parametro
 
  IF {&BROWSE-NAME}:SENSITIVE IN FRAME {&FRAME-NAME} 
  THEN DO:

    ASSIGN que_codigo.
    FIND FIRST {&FIRST-TABLE-IN-QUERY-{&BROWSE-NAME}} 
         WHERE {&FIRST-TABLE-IN-QUERY-{&BROWSE-NAME}}.{&CODIGO} >= que_codigo
           AND {&FIRST-TABLE-IN-QUERY-{&BROWSE-NAME}}.cdg_empresa = que_empresa
                NO-LOCK NO-ERROR.
    IF NOT AVAILABLE {&FIRST-TABLE-IN-QUERY-{&BROWSE-NAME}} 
       THEN FIND LAST {&FIRST-TABLE-IN-QUERY-{&BROWSE-NAME}} 
               WHERE {&FIRST-TABLE-IN-QUERY-{&BROWSE-NAME}}.cdg_empresa = que_empresa
                       NO-LOCK.
    IF ROWID({&FIRST-TABLE-IN-QUERY-{&BROWSE-NAME}}) <> ?
    THEN DO:
        REPOSITION {&BROWSE-NAME} TO ROWID ROWID({&FIRST-TABLE-IN-QUERY-{&BROWSE-NAME}}).
        RUN dispatch IN THIS-PROCEDURE ('row-changed').
    END.

  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME que_dexcrip
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_dexcrip B-table-Win
ON RETURN OF que_dexcrip IN FRAME F-Main
OR "TAB" OF que_dexcrip IN FRAME {&FRAME-NAME}
DO:
    DEF VAR veces AS INT.
 
  &SCOPED-DEFINE CODIGO descripcion

  IF {&BROWSE-NAME}:SENSITIVE IN FRAME {&FRAME-NAME} 
  THEN DO:
   ASSIGN que_dexcrip.
   veces = 0.
   FOR each {&FIRST-TABLE-IN-QUERY-{&BROWSE-NAME}} 
         WHERE {&FIRST-TABLE-IN-QUERY-{&BROWSE-NAME}}.{&CODIGO} CONTAINS que_dexcrip
           AND {&FIRST-TABLE-IN-QUERY-{&BROWSE-NAME}}.cdg_empresa = que_empresa
                NO-LOCK . 
       veces = veces + 1.
       IF veces >= chCtrlFrame:CSSpin:VALUE THEN LEAVE.

    END.
    IF NOT AVAILABLE {&FIRST-TABLE-IN-QUERY-{&BROWSE-NAME}} 
       THEN FIND LAST {&FIRST-TABLE-IN-QUERY-{&BROWSE-NAME}} 
               WHERE {&FIRST-TABLE-IN-QUERY-{&BROWSE-NAME}}.cdg_empresa = que_empresa
                       NO-LOCK.
    IF ROWID({&FIRST-TABLE-IN-QUERY-{&BROWSE-NAME}}) <> ?
    THEN DO:
        REPOSITION {&BROWSE-NAME} TO ROWID ROWID({&FIRST-TABLE-IN-QUERY-{&BROWSE-NAME}}).
        RUN dispatch IN THIS-PROCEDURE ('row-changed').
    END.

  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-empresa
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-empresa B-table-Win
ON VALUE-CHANGED OF v-empresa IN FRAME F-Main /* Empresa */
DO:

     IF v-empresa:SCREEN-VALUE = "" 
     THEN que_empresa = "".
     ELSE DO:
         ASSIGN v-empresa.
         FIND Empresa WHERE Empresa.cdg_empresa = v-empresa:SCREEN-VALUE NO-LOCK.
         que_empresa = Empresa.cdg_empresa.
     END.
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
    WHEN 'cdg_empresa':U THEN DO:
       &Scope KEY-PHRASE Parametro.cdg_empresa eq key-value
       {&OPEN-QUERY-{&BROWSE-NAME}}
    END. /* cdg_empresa */
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE control_load B-table-Win  _CONTROL-LOAD
PROCEDURE control_load :
/*------------------------------------------------------------------------------
  Purpose:     Load the OCXs    
  Parameters:  <none>
  Notes:       Here we load, initialize and make visible the 
               OCXs in the interface.                        
------------------------------------------------------------------------------*/

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN
DEFINE VARIABLE UIB_S    AS LOGICAL    NO-UNDO.
DEFINE VARIABLE OCXFile  AS CHARACTER  NO-UNDO.

OCXFile = SEARCH( "b-parametros.wrx":U ).
IF OCXFile = ? THEN
  OCXFile = SEARCH(SUBSTRING(THIS-PROCEDURE:FILE-NAME, 1,
                     R-INDEX(THIS-PROCEDURE:FILE-NAME, ".":U), "CHARACTER":U) + "wrx":U).

IF OCXFile <> ? THEN
DO:
  ASSIGN
    chCtrlFrame = CtrlFrame:COM-HANDLE
    UIB_S = chCtrlFrame:LoadControls( OCXFile, "CtrlFrame":U)
  .
  RUN DISPATCH IN THIS-PROCEDURE("initialize-controls":U) NO-ERROR.
END.
ELSE MESSAGE "b-parametros.wrx":U SKIP(1)
             "The binary control file could not be found. The controls cannot be loaded."
             VIEW-AS ALERT-BOX TITLE "Controls Not Loaded".

&ENDIF

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

  DEFINE VARIABLE ok AS LOGICAL.
  DEFINE VARIABLE lista AS CHARACTER.

  DO WITH FRAME {&FRAME-NAME}:
     lista = "[Todas]|".
     v-empresa:DELIMITER = "|".
     FOR EACH Empresa NO-LOCK BY Empresa.nombre:
         lista = lista + "|" + TRIM(Empresa.nombre) + "|" + Empresa.cdg_empresa.
     END.
     v-empresa:LIST-ITEM-PAIRS = SUBSTRING(lista,2).
  END.          
  {findempresa.i}
  v-empresa = Empresa.cdg_empresa.
  que_empresa = Empresa.cdg_empresa.
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  DISPLAY v-empresa
      WITH FRAME {&FRAME-NAME}.
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
  {src/adm/template/sndkycas.i "cdg_empresa" "Parametro" "cdg_empresa"}
  {src/adm/template/sndkycas.i "descripcion" "Parametro" "descripcion"}

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
  {src/adm/template/snd-list.i "Parametro"}

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

