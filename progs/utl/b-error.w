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

  DEFINE STREAM Listado.

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
&Scoped-define INTERNAL-TABLES Mensaje

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Mensaje.cdg_mensaje Mensaje.texto ~
Mensaje.tipo 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table 
&Scoped-define QUERY-STRING-br_table FOR EACH Mensaje WHERE ~{&KEY-PHRASE} NO-LOCK ~
    ~{&SORTBY-PHRASE} INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_table OPEN QUERY br_table FOR EACH Mensaje WHERE ~{&KEY-PHRASE} NO-LOCK ~
    ~{&SORTBY-PHRASE} INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_table Mensaje
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Mensaje


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-4 que_mensaje btn_listar que_dexcrip ~
btn_copiar_grupo v-comienzo_viejo v-comienzo_nuevo br_table 
&Scoped-Define DISPLAYED-OBJECTS que_mensaje que_dexcrip v-comienzo_viejo ~
v-comienzo_nuevo 

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
cdg_mensaje||y|sic.Mensaje.cdg_mensaje
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = ,
     Keys-Supplied = "cdg_mensaje"':U).

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
DEFINE BUTTON btn_copiar_grupo 
     LABEL "Copiar grupo de mensajes" 
     SIZE 28 BY 1.

DEFINE BUTTON btn_listar 
     LABEL "Listar" 
     SIZE 13 BY 1.

DEFINE VARIABLE que_dexcrip AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 30 BY 1 TOOLTIP "Patron de busqueda en la descripcion"
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE que_mensaje AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 15 BY 1 TOOLTIP "Prefijo de busqueda"
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE v-comienzo_nuevo AS CHARACTER FORMAT "X(4)":U 
     LABEL "Nuevo Grupo" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 8 BY 1
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE v-comienzo_viejo AS CHARACTER FORMAT "X(4)":U 
     LABEL "Grupo Original" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 8 BY 1
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 154 BY 15.71.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Mensaje SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _STRUCTURED
  QUERY br_table NO-LOCK DISPLAY
      Mensaje.cdg_mensaje COLUMN-LABEL "Codigo!Mensaje" FORMAT "X(9)":U
            WIDTH 12.2
      Mensaje.texto COLUMN-LABEL "Texto!Mensaje" FORMAT "X(90)":U
            WIDTH 123.2
      Mensaje.tipo COLUMN-LABEL "Ti-!po" FORMAT "X(1)":U WIDTH 6.2
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 150 BY 13.1
         BGCOLOR 11 FGCOLOR 9 FONT 4
         TITLE BGCOLOR 11 FGCOLOR 9 "Mensajes del sistema".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     que_mensaje AT ROW 1.67 COL 3 NO-LABEL
     btn_listar AT ROW 1.67 COL 19
     que_dexcrip AT ROW 1.67 COL 43 NO-LABEL WIDGET-ID 2
     btn_copiar_grupo AT ROW 1.67 COL 74
     v-comienzo_viejo AT ROW 1.67 COL 104.4
     v-comienzo_nuevo AT ROW 1.67 COL 130
     br_table AT ROW 3.14 COL 3
     RECT-4 AT ROW 1 COL 1
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
         HEIGHT             = 16.48
         WIDTH              = 155.6.
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
/* BROWSE-TAB br_table v-comienzo_nuevo F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN que_dexcrip IN FRAME F-Main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN que_mensaje IN FRAME F-Main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN v-comienzo_nuevo IN FRAME F-Main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN v-comienzo_viejo IN FRAME F-Main
   ALIGN-L                                                              */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _TblList          = "sic.Mensaje"
     _Options          = "NO-LOCK INDEXED-REPOSITION KEY-PHRASE SORTBY-PHRASE"
     _FldNameList[1]   > sic.Mensaje.cdg_mensaje
"Mensaje.cdg_mensaje" "Codigo!Mensaje" "X(9)" "character" ? ? ? ? ? ? no ? no no "12.2" yes no no "U" "" ""
     _FldNameList[2]   > sic.Mensaje.texto
"Mensaje.texto" "Texto!Mensaje" "X(90)" "character" ? ? ? ? ? ? no ? no no "123.2" yes no no "U" "" ""
     _FldNameList[3]   > sic.Mensaje.tipo
"Mensaje.tipo" "Ti-!po" ? "character" ? ? ? ? ? ? no ? no no "6.2" yes no no "U" "" ""
     _Query            is NOT OPENED
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
       ROW             = 1.71
       COLUMN          = 34
       HEIGHT          = .95
       WIDTH           = 8
       WIDGET-ID       = 6
       HIDDEN          = no
       SENSITIVE       = yes.

PROCEDURE adm-create-controls:
      CtrlFrame:NAME = "CtrlFrame":U .
/* CtrlFrame OCXINFO:CREATE-CONTROL from: {EAF26C8F-9586-101B-9306-0020AF234C9D} type: CSSpin */
      CtrlFrame:MOVE-AFTER(v-comienzo_nuevo:HANDLE IN FRAME F-Main).

END PROCEDURE.

&ENDIF

&ANALYZE-RESUME /* End of _CREATE-DYNAMIC */


/* ************************  Control Triggers  ************************ */

&Scoped-define BROWSE-NAME br_table
&Scoped-define SELF-NAME br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-ENTRY OF br_table IN FRAME F-Main /* Mensajes del sistema */
DO:
  /* This code displays initial values for newly added or copied rows. */
  {src/adm/template/brsentry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-LEAVE OF br_table IN FRAME F-Main /* Mensajes del sistema */
DO:
    /* Do not disable this code or no updates will take place except
     by pressing the Save button on an Update SmartPanel. */
   {src/adm/template/brsleave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON VALUE-CHANGED OF br_table IN FRAME F-Main /* Mensajes del sistema */
DO:
  /* This ADM trigger code must be preserved in order to notify other
     objects when the browser's current row changes. */
  {src/adm/template/brschnge.i}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_copiar_grupo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_copiar_grupo B-table-Win
ON CHOOSE OF btn_copiar_grupo IN FRAME F-Main /* Copiar grupo de mensajes */
DO:
    ASSIGN v-comienzo_viejo v-comienzo_nuevo.
    IF LENGTH(v-comienzo_viejo) = 4 AND LENGTH(v-comienzo_nuevo) = 4 
    THEN DO:
        DEFINE BUFFER bb FOR Mensaje.
        DO TRANSACTION:
            FOR EACH Mensaje WHERE Mensaje.cdg_mensaje BEGINS v-comienzo_viejo:
                CREATE bb.
                BUFFER-COPY Mensaje TO bb
                    ASSIGN bb.cdg_mensaje = REPLACE(Mensaje.cdg_mensaje,v-comienzo_viejo,v-comienzo_nuevo).
            END.
        END.
        RUN ponmensj.p ( INPUT "GRAL002" ).
        RUN dispatch IN THIS-PROCEDURE ('open-query').
        DISPLAY "" @ v-comienzo_viejo 
                "" @ v-comienzo_nuevo
                WITH FRAME {&FRAME-NAME}.
    END.
    ELSE DO:
        RUN ponmensj.p ( INPUT "GRAL001" ).
        RETURN NO-APPLY.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_listar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_listar B-table-Win
ON CHOOSE OF btn_listar IN FRAME F-Main /* Listar */
DO:

  OUTPUT STREAM Listado TO PRINTER.
  FOR EACH mensaje WHERE cdg_mensaje BEGINS que_mensaje:SCREEN-VALUE IN FRAME {&FRAME-NAME}:
      DISPLAY STREAM Listado Mensaje.cdg_mensaje Mensaje.texto WITH STREAM-IO.
  END.
  OUTPUT STREAM Listado CLOSE.
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


&Scoped-define SELF-NAME que_dexcrip
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_dexcrip B-table-Win
ON RETURN OF que_dexcrip IN FRAME F-Main
DO:
    ASSIGN que_dexcrip.
  DEF VAR veces AS INT.
 veces = 0.
  FOR EACH Mensaje WHERE sic.Mensaje.texto CONTAINS  que_dexcrip:SCREEN-VALUE IN FRAME {&FRAME-NAME} NO-LOCK: 
      veces = veces + 1.
      IF veces >= chCtrlFrame:CSSpin:VALUE THEN LEAVE.
  END.
  IF NOT AVAILABLE Mensaje THEN FIND LAST Mensaje NO-LOCK.
  REPOSITION br_table TO ROWID ROWID(Mensaje) NO-ERROR.
  RUN dispatch IN THIS-PROCEDURE ('row-changed':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME que_mensaje
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_mensaje B-table-Win
ON RETURN OF que_mensaje IN FRAME F-Main
DO:
  FIND FIRST Mensaje WHERE Mensaje.cdg_mensaje >= que_mensaje:SCREEN-VALUE IN FRAME {&FRAME-NAME} NO-LOCK NO-ERROR.
  IF NOT AVAILABLE Mensaje THEN FIND LAST Mensaje NO-LOCK.
  REPOSITION br_table TO ROWID ROWID(Mensaje) NO-ERROR.
  RUN dispatch IN THIS-PROCEDURE ('row-changed':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-comienzo_nuevo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-comienzo_nuevo B-table-Win
ON RETURN OF v-comienzo_nuevo IN FRAME F-Main /* Nuevo Grupo */
DO:
  FIND FIRST Mensaje WHERE Mensaje.cdg_mensaje >= que_mensaje:SCREEN-VALUE IN FRAME {&FRAME-NAME} NO-LOCK NO-ERROR.
  IF NOT AVAILABLE Mensaje THEN FIND LAST Mensaje NO-LOCK.
  REPOSITION br_table TO ROWID ROWID(Mensaje) NO-ERROR.
  RUN dispatch IN THIS-PROCEDURE ('row-changed':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-comienzo_viejo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-comienzo_viejo B-table-Win
ON RETURN OF v-comienzo_viejo IN FRAME F-Main /* Grupo Original */
DO:
  FIND FIRST Mensaje WHERE Mensaje.cdg_mensaje >= que_mensaje:SCREEN-VALUE IN FRAME {&FRAME-NAME} NO-LOCK NO-ERROR.
  IF NOT AVAILABLE Mensaje THEN FIND LAST Mensaje NO-LOCK.
  REPOSITION br_table TO ROWID ROWID(Mensaje) NO-ERROR.
  RUN dispatch IN THIS-PROCEDURE ('row-changed':U).
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

OCXFile = SEARCH( "b-error.wrx":U ).
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
ELSE MESSAGE "b-error.wrx":U SKIP(1)
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
  {src/adm/template/sndkycas.i "cdg_mensaje" "Mensaje" "cdg_mensaje"}

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
  {src/adm/template/snd-list.i "Mensaje"}

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

