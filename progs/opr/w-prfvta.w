&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS W-Win 
/*------------------------------------------------------------------------

  File: 

  Description: from cntnrwin.w - ADM SmartWindow Template

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  History: 
          
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

{nrorelea.i}

DEFINE VARIABLE txn_activa AS LOGICAL.
DEFINE VARIABLE rid_tabla AS ROWID.
DEFINE VARIABLE qh AS HANDLE.
DEFINE VAR brw AS HANDLE.

DEFINE TEMP-TABLE ttprf
    FIELD cdg_puntovta LIKE Punto-venta.cdg_puntovta FORMAT "9999"
    FIELD dsc_puntovta LIKE Punto-venta.dsc_puntovta
    FIELD acumulado AS DECIMAL COLUMN-LABEL "Acumulado".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartWindow
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER WINDOW

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME F-Main
&Scoped-define BROWSE-NAME BROWSE-5

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Fac_header Cliente

/* Definitions for BROWSE BROWSE-5                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-5 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-5 
&Scoped-define SELF-NAME BROWSE-5
&Scoped-define OPEN-QUERY-BROWSE-5 ASSIGN v-cdg_punto-venta fdesde fhasta. /* OPEN QUERY {&SELF-NAME} FOR EACH Fac_header WHERE fac_header.prf_comprob = v-cdg_punto-venta     and NOT fac_header.anulado AND fac_header.fecha >= fdesde AND fac_header.fecha <= fhasta NO-LOCK, ~
             EACH Cliente OF Fac_header NO-LOCK  INDEXED-REPOSITION.*/.
&Scoped-define TABLES-IN-QUERY-BROWSE-5 Fac_header Cliente
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-5 Fac_header
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-5 Cliente


/* Definitions for FRAME F-Main                                         */
&Scoped-define OPEN-BROWSERS-IN-QUERY-F-Main ~
    ~{&OPEN-QUERY-BROWSE-5}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS v-cdg_punto-venta fdesde fhasta BUTTON-2 ~
BROWSE-6 BROWSE-5 
&Scoped-Define DISPLAYED-OBJECTS v-cdg_punto-venta fdesde fhasta 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR W-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON BUTTON-2 
     LABEL "Ver" 
     SIZE 15 BY 1.14.

DEFINE VARIABLE fdesde AS DATE FORMAT "99/99/9999":U INITIAL ? 
     LABEL "Desde" 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1 NO-UNDO.

DEFINE VARIABLE fhasta AS DATE FORMAT "99/99/9999":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1 NO-UNDO.

DEFINE VARIABLE v-cdg_punto-venta LIKE Contrato_hd.prf_contrato
     VIEW-AS FILL-IN NATIVE 
     SIZE 7.6 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-5 FOR 
      Fac_header, 
      Cliente SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-5 W-Win _STRUCTURED
  
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 124 BY 11.43 ROW-HEIGHT-CHARS .76 FIT-LAST-COLUMN.

DEFINE BROWSE BROWSE-6
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-6 W-Win _STRUCTURED
  
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 125 BY 7.86.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     v-cdg_punto-venta AT ROW 1.24 COL 11 COLON-ALIGNED HELP
          "Prefijo de 4 digitos del comprobante" WIDGET-ID 18
          BGCOLOR 15 FGCOLOR 9 
     fdesde AT ROW 1.24 COL 29 COLON-ALIGNED WIDGET-ID 20
     fhasta AT ROW 1.24 COL 48 COLON-ALIGNED NO-LABEL WIDGET-ID 22
     BUTTON-2 AT ROW 1.24 COL 71 WIDGET-ID 26
     BROWSE-6 AT ROW 2.67 COL 2 WIDGET-ID 200
     BROWSE-5 AT ROW 11 COL 3 WIDGET-ID 100
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 128.8 BY 21.86.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartWindow
   Allow: Basic,Browse,DB-Fields,Query,Smart,Window
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW W-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Modelo"
         HEIGHT             = 21.86
         WIDTH              = 128.8
         MAX-HEIGHT         = 26.62
         MAX-WIDTH          = 159.6
         VIRTUAL-HEIGHT     = 26.62
         VIRTUAL-WIDTH      = 159.6
         RESIZE             = no
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB W-Win 
/* ************************* Included-Libraries *********************** */

{src/adm/method/containr.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW W-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME F-Main
   FRAME-NAME                                                           */
/* BROWSE-TAB BROWSE-6 BUTTON-2 F-Main */
/* BROWSE-TAB BROWSE-5 BROWSE-6 F-Main */
/* SETTINGS FOR FILL-IN v-cdg_punto-venta IN FRAME F-Main
   LIKE = sic.Contrato_hd.prf_contrato EXP-SIZE                         */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(W-Win)
THEN W-Win:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-5
/* Query rebuild information for BROWSE BROWSE-5
     _START_FREEFORM
ASSIGN v-cdg_punto-venta fdesde fhasta.
/*
OPEN QUERY {&SELF-NAME} FOR EACH Fac_header WHERE fac_header.prf_comprob = v-cdg_punto-venta
    and NOT fac_header.anulado AND fac_header.fecha >= fdesde AND fac_header.fecha <= fhasta NO-LOCK,
      EACH Cliente OF Fac_header NO-LOCK  INDEXED-REPOSITION.*/
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Query            is OPENED
*/  /* BROWSE BROWSE-5 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON END-ERROR OF W-Win /* Modelo */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-CLOSE OF W-Win /* Modelo */
DO:
    /* Modificado para que el control retorne a la window padre al cerrar una windows hija */
  DEFINE VARIABLE h_parent AS HANDLE      NO-UNDO.


  RUN verificar_txn ( OUTPUT txn_activa ).
  IF NOT txn_activa
  THEN DO: 
    h_parent = THIS-PROCEDURE:CURRENT-WINDOW:PARENT.
    APPLY "CLOSE":U TO THIS-PROCEDURE.
    CURRENT-WINDOW = h_parent.
    APPLY 'ENTRY' TO h_parent.
    RETURN NO-APPLY.

  END.

  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-MINIMIZED OF W-Win /* Modelo */
DO:
  RUN get-attribute ('ADM-TRANSACTION').
  IF RETURN-VALUE = "YES"
  THEN DO:
       MESSAGE "No debe minimizar esta ventana con una actualización pendiente"
               VIEW-AS ALERT-BOX WARNING TITLE "CUIDADO!!!".
{&WINDOW-NAME}:WINDOW-STATE = 1.
RETURN NO-APPLY.
  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-2 W-Win
ON CHOOSE OF BUTTON-2 IN FRAME F-Main /* Ver */
DO:
RUN ver.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fdesde
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fdesde W-Win
ON MOUSE-SELECT-DBLCLICK OF fdesde IN FRAME F-Main /* Desde */
DO:
  {selfecha.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fhasta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fhasta W-Win
ON MOUSE-SELECT-DBLCLICK OF fhasta IN FRAME F-Main
DO:
  {selfecha.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_punto-venta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_punto-venta W-Win
ON LEAVE OF v-cdg_punto-venta IN FRAME F-Main /* Prefijo */
DO :
    ASSIGN v-cdg_punto-venta.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_punto-venta W-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_punto-venta IN FRAME F-Main /* Prefijo */
OR "." OF v-cdg_punto-venta IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_punto-venta IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "Punto-venta" "cdg_puntovta" "SELpuntoventa.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-5
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK W-Win 


/* ***************************  Main Block  *************************** */

/* Include custom  Main Block code for SmartWindows. */
{src/adm/template/windowmn.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-create-objects W-Win  _ADM-CREATE-OBJECTS
PROCEDURE adm-create-objects :
/*------------------------------------------------------------------------------
  Purpose:     Create handles for all SmartObjects used in this procedure.
               After SmartObjects are initialized, then SmartLinks are added.
  Parameters:  <none>
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available W-Win  _ADM-ROW-AVAILABLE
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI W-Win  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(W-Win)
  THEN DELETE WIDGET W-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI W-Win  _DEFAULT-ENABLE
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
  DISPLAY v-cdg_punto-venta fdesde fhasta 
      WITH FRAME F-Main IN WINDOW W-Win.
  ENABLE v-cdg_punto-venta fdesde fhasta BUTTON-2 BROWSE-5 
      WITH FRAME F-Main IN WINDOW W-Win.
  {&OPEN-BROWSERS-IN-QUERY-F-Main}
  VIEW W-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-destroy W-Win 
PROCEDURE local-destroy :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
  qh:QUERY-CLOSE().
   DELETE OBJECT qh.
  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'destroy':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-exit W-Win 
PROCEDURE local-exit :
/* -----------------------------------------------------------
  Purpose:  Starts an "exit" by APPLYing CLOSE event, which starts "destroy".
  Parameters:  <none>
  Notes:    If activated, should APPLY CLOSE, *not* dispatch adm-exit.   
-------------------------------------------------------------*/

  RUN verificar_txn ( OUTPUT txn_activa ).
  IF txn_activa
  THEN DO:
       RETURN NO-APPLY.
  END.     
  ELSE DO:
       APPLY "CLOSE":U TO THIS-PROCEDURE.
       RETURN.
  END.     

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize W-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
fdesde:SCREEN-VALUE IN FRAME {&FRAME-NAME}= STRING( TODAY - 30 ) .
fhasta:SCREEN-VALUE = STRING(TODAY).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-view W-Win 
PROCEDURE local-view :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'view':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  {setwintit.i "SIC/BAS" "Modelo de Transacción"}


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records W-Win  _ADM-SEND-RECORDS
PROCEDURE send-records :
/*------------------------------------------------------------------------------
  Purpose:     Send record ROWID's for all tables used by
               this file.
  Parameters:  see template/snd-head.i
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.               */
  {src/adm/template/snd-head.i}

  /* For each requested table, put it's ROWID in the output list.      */
  {src/adm/template/snd-list.i "Fac_header"}
  {src/adm/template/snd-list.i "Cliente"}

  /* Deal with any unexpected table requests before closing.           */
  {src/adm/template/snd-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE set-estado-folders W-Win 
PROCEDURE set-estado-folders :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    DEFINE INPUT PARAMETER p-operacion AS CHARACTER.
/*
    DEFINE VARIABLE folder-labels AS CHARACTER.
    DEFINE VARIABLE page-hdl      AS CHARACTER.
    DEFINE VARIABLE j-pagina      AS INTEGER.

    RUN get-attribute IN h_folder ('FOLDER-LABELS':U).
    ASSIGN folder-labels   = IF RETURN-VALUE = ? THEN "":U
                             ELSE RETURN-VALUE.

    RUN get-link-handle IN adm-broker-hdl
                      (THIS-PROCEDURE, 'PAGE-TARGET',OUTPUT page-hdl).

    DO j-pagina = 1 TO NUM-ENTRIES(folder-labels,'|':U):                             

/*
       IF p-operacion = "HABILITAR"
          THEN RUN enable-folder-page  IN WIDGET-HANDLE(page-hdl) (j-pagina).
          ELSE RUN disable-folder-page IN WIDGET-HANDLE(page-hdl) (j-pagina).
*/
       IF p-operacion = "HABILITAR"
          THEN RUN enable-folder-page  IN h_folder (j-pagina).
          ELSE RUN disable-folder-page IN h_folder (j-pagina).

    END.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE state-changed W-Win 
PROCEDURE state-changed :
/* -----------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-------------------------------------------------------------*/
  DEFINE INPUT PARAMETER p-issuer-hdl AS HANDLE NO-UNDO.
  DEFINE INPUT PARAMETER p-state AS CHARACTER NO-UNDO.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ver W-Win 
PROCEDURE ver :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR brw AS HANDLE NO-UNDO.
{strdebitan.i}
ASSIGN FRAME {&FRAME-NAME} v-cdg_punto-venta fdesde fhasta.
EMPTY TEMP-TABLE ttprf.

FOR EACH Fac_header WHERE NOT fac_header.anulado AND fac_header.fecha >= fdesde AND fac_header.fecha <= fhasta NO-LOCK,
      EACH Cliente OF Fac_header NO-LOCK:
    FIND ttprf WHERE ttprf.cdg_puntovta = fac_header.prf_comprob NO-ERROR.
    IF NOT AVAILABLE ttprf THEN DO:
        CREATE ttprf.
        FIND punto-venta where punto-venta.cdg_puntovta = fac_header.prf_comprob NO-LOCK.
        ASSIGN ttprf.cdg_puntovta = fac_header.prf_comprob
               ttprf.dsc_puntovta = punto-venta.dsc_puntovta
               ttprf.acumulado = 0.
    END.
    IF LOOKUP(Fac_header.tip_comprob,str_debitan) <> 0
        THEN ttprf.acumulado = ttprf.acumulado + Fac_header.imp_neto.
        ELSE ttprf.acumulado = ttprf.acumulado - Fac_header.imp_neto.
END.
CREATE QUERY qh.
qh:SET-BUFFERS( BUFFER ttprf:handle ).

qh:QUERY-PREPARE("for each ttprf" ).
brw = BROWSE BROWSE-6:HANDLE.
brw:QUERY = qh.
browse-6:ADD-LIKE-COLUMN("ttprf.cdg_puntovta"). 
browse-6:ADD-LIKE-COLUMN("ttprf.dsc_puntovta"). 
browse-6:ADD-LIKE-COLUMN("ttprf.acumulado").
browse-6:EXPANDABLE = YES.

brw:COLUMN-MOVABLE = TRUE.
brw:COLUMN-RESIZABLE = TRUE.
brw:SENSITIVE = TRUE.
qh:QUERY-OPEN.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE verificar_txn W-Win 
PROCEDURE verificar_txn :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE OUTPUT PARAMETER p-estado AS LOGICAL.

  RUN get-attribute ('ADM-TRANSACTION').
  IF RETURN-VALUE = "YES"
  THEN DO:
       MESSAGE "No puede salir de esta pantalla con una actualización pendiente"
               VIEW-AS ALERT-BOX ERROR.
       p-estado = YES.
  END.
  ELSE DO:
       p-estado = NO.   /* Function return value. */
  END.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

