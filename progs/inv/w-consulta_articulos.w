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

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartWindow
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER WINDOW

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME F-Main

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES Cliente
&Scoped-define FIRST-EXTERNAL-TABLE Cliente


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Cliente.
/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR W-Win AS WIDGET-HANDLE NO-UNDO.

/* Menu Definitions                                                     */
DEFINE SUB-MENU m_Archivo 
       MENU-ITEM m_Salir        LABEL "&Salir"        .

DEFINE MENU MENU-BAR-W-Win MENUBAR
       SUB-MENU  m_Archivo      LABEL "&Archivo"      .


/* Definitions of handles for SmartObjects                              */
DEFINE VARIABLE h_b-articulo AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-articulo_atributo AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-articulo_deposito AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-articulo_precio AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-fcomerciales AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-partidas AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-partida_deposito AS HANDLE NO-UNDO.
DEFINE VARIABLE h_folder AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-articulo AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-articulo_atributo AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-articulo_deposito AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-articulo_precio AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-fcomercial AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-otros_datosarticulo AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-partida AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-que_articulo AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-que_articulo-2 AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-que_articulo-3 AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-que_articulo-4 AS HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 159 BY 26.1.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartWindow
   External Tables: sic.Cliente
   Allow: Basic,Browse,DB-Fields,Query,Smart,Window
   Design Page: 3
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW W-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Consulta de Articulos"
         HEIGHT             = 26.1
         WIDTH              = 159
         MAX-HEIGHT         = 26.76
         MAX-WIDTH          = 160
         VIRTUAL-HEIGHT     = 26.76
         VIRTUAL-WIDTH      = 160
         RESIZE             = no
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.

ASSIGN {&WINDOW-NAME}:MENUBAR    = MENU MENU-BAR-W-Win:HANDLE.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB W-Win 
/* ************************* Included-Libraries *********************** */

{setsensitivo.i}
{src/adm/method/containr.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW W-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME F-Main
                                                                        */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(W-Win)
THEN W-Win:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON END-ERROR OF W-Win /* Consulta de Articulos */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-CLOSE OF W-Win /* Consulta de Articulos */
DO:
  /* This ADM code must be left here in order for the SmartWindow
     and its descendents to terminate properly on exit. */


  RUN verificar_txn ( OUTPUT txn_activa ).
  IF NOT txn_activa
  THEN DO: 
        APPLY "CLOSE":U TO THIS-PROCEDURE.
  END.

  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-MINIMIZED OF W-Win /* Consulta de Articulos */
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


&Scoped-define SELF-NAME m_Salir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Salir W-Win
ON CHOOSE OF MENU-ITEM m_Salir /* Salir */
DO:
  APPLY "WINDOW-CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


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
  DEFINE VARIABLE adm-current-page  AS INTEGER NO-UNDO.

  RUN get-attribute IN THIS-PROCEDURE ('Current-Page':U).
  ASSIGN adm-current-page = INTEGER(RETURN-VALUE).

  CASE adm-current-page: 

    WHEN 0 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-articulos.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-articulo ).
       RUN set-position IN h_b-articulo ( 1.00 , 2.00 ) NO-ERROR.
       RUN set-size IN h_b-articulo ( 25.10 , 22.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'adm/objects/folder.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'FOLDER-LABELS = ':U + 'Artículos|Partidas|Depósitos|Marcas|Precios|Otros Datos' + ',
                     FOLDER-TAB-TYPE = 1':U ,
             OUTPUT h_folder ).
       RUN set-position IN h_folder ( 1.00 , 25.00 ) NO-ERROR.
       RUN set-size IN h_folder ( 25.24 , 134.00 ) NO-ERROR.

       /* Links to SmartFolder h_folder. */
       RUN add-link IN adm-broker-hdl ( h_folder , 'Page':U , THIS-PROCEDURE ).

    END. /* Page 0 */

    WHEN 1 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-articulo.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-articulo ).
       RUN set-position IN h_v-articulo ( 3.14 , 30.00 ) NO-ERROR.
       /* Size in UIB:  ( 19.29 , 118.00 ) */

       /* Links to SmartViewer h_v-articulo. */
       RUN add-link IN adm-broker-hdl ( h_b-articulo , 'Record':U , h_v-articulo ).

    END. /* Page 1 */

    WHEN 2 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-que_articulo.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-que_articulo ).
       RUN set-position IN h_v-que_articulo ( 2.91 , 39.00 ) NO-ERROR.
       /* Size in UIB:  ( 1.67 , 94.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-partidas.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-partidas ).
       RUN set-position IN h_b-partidas ( 4.81 , 39.00 ) NO-ERROR.
       RUN set-size IN h_b-partidas ( 19.52 , 15.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-partida.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-partida ).
       RUN set-position IN h_v-partida ( 4.81 , 72.00 ) NO-ERROR.
       /* Size in UIB:  ( 9.05 , 70.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-partida_deposito.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-partida_deposito ).
       RUN set-position IN h_b-partida_deposito ( 14.10 , 72.00 ) NO-ERROR.
       RUN set-size IN h_b-partida_deposito ( 10.24 , 70.00 ) NO-ERROR.

       /* Links to SmartViewer h_v-que_articulo. */
       RUN add-link IN adm-broker-hdl ( h_b-articulo , 'Record':U , h_v-que_articulo ).

       /* Links to SmartBrowser h_b-partidas. */
       RUN add-link IN adm-broker-hdl ( h_b-articulo , 'Record':U , h_b-partidas ).

       /* Links to SmartViewer h_v-partida. */
       RUN add-link IN adm-broker-hdl ( h_b-partidas , 'Record':U , h_v-partida ).

       /* Links to SmartBrowser h_b-partida_deposito. */
       RUN add-link IN adm-broker-hdl ( h_b-partidas , 'Record':U , h_b-partida_deposito ).

    END. /* Page 2 */

    WHEN 3 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-que_articulo.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-que_articulo-4 ).
       RUN set-position IN h_v-que_articulo-4 ( 2.91 , 29.00 ) NO-ERROR.
       /* Size in UIB:  ( 1.67 , 94.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-articulo_deposito.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-articulo_deposito ).
       RUN set-position IN h_b-articulo_deposito ( 4.81 , 29.00 ) NO-ERROR.
       RUN set-size IN h_b-articulo_deposito ( 6.24 , 126.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-articulo_deposito.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-articulo_deposito ).
       RUN set-position IN h_v-articulo_deposito ( 11.24 , 29.00 ) NO-ERROR.
       /* Size in UIB:  ( 13.57 , 126.00 ) */

       /* Links to SmartViewer h_v-que_articulo-4. */
       RUN add-link IN adm-broker-hdl ( h_b-articulo , 'Record':U , h_v-que_articulo-4 ).

       /* Links to SmartBrowser h_b-articulo_deposito. */
       RUN add-link IN adm-broker-hdl ( h_b-articulo , 'Record':U , h_b-articulo_deposito ).

       /* Links to SmartViewer h_v-articulo_deposito. */
       RUN add-link IN adm-broker-hdl ( h_b-articulo_deposito , 'Record':U , h_v-articulo_deposito ).

    END. /* Page 3 */

    WHEN 4 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-que_articulo.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-que_articulo-2 ).
       RUN set-position IN h_v-que_articulo-2 ( 5.05 , 47.00 ) NO-ERROR.
       /* Size in UIB:  ( 1.67 , 94.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-fcomerciales.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-fcomerciales ).
       RUN set-position IN h_b-fcomerciales ( 7.19 , 47.00 ) NO-ERROR.
       RUN set-size IN h_b-fcomerciales ( 10.76 , 18.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-fcomercial.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-fcomercial ).
       RUN set-position IN h_v-fcomercial ( 7.19 , 71.00 ) NO-ERROR.
       /* Size in UIB:  ( 7.38 , 79.00 ) */

       /* Links to SmartViewer h_v-que_articulo-2. */
       RUN add-link IN adm-broker-hdl ( h_b-articulo , 'Record':U , h_v-que_articulo-2 ).

       /* Links to SmartBrowser h_b-fcomerciales. */
       RUN add-link IN adm-broker-hdl ( h_b-articulo , 'Record':U , h_b-fcomerciales ).

       /* Links to SmartViewer h_v-fcomercial. */
       RUN add-link IN adm-broker-hdl ( h_b-fcomerciales , 'Record':U , h_v-fcomercial ).

    END. /* Page 4 */

    WHEN 5 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-articulo_precio.w':U ,
             INPUT  {&WINDOW-NAME} ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-articulo_precio ).
       RUN set-position IN h_b-articulo_precio ( 5.19 , 38.20 ) NO-ERROR.
       RUN set-size IN h_b-articulo_precio ( 10.81 , 103.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-articulo_precio.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-articulo_precio ).
       RUN set-position IN h_v-articulo_precio ( 16.48 , 38.00 ) NO-ERROR.
       /* Size in UIB:  ( 3.33 , 103.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-que_articulo.w':U ,
             INPUT  {&WINDOW-NAME} ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-que_articulo-3 ).
       RUN set-position IN h_v-que_articulo-3 ( 3.10 , 38.20 ) NO-ERROR.
       /* Size in UIB:  ( 1.67 , 94.00 ) */

       /* Links to SmartBrowser h_b-articulo_precio. */
       RUN add-link IN adm-broker-hdl ( h_b-articulo , 'Record':U , h_b-articulo_precio ).

       /* Links to SmartViewer h_v-articulo_precio. */
       RUN add-link IN adm-broker-hdl ( h_b-articulo_precio , 'Record':U , h_v-articulo_precio ).

       /* Links to SmartViewer h_v-que_articulo-3. */
       RUN add-link IN adm-broker-hdl ( h_b-articulo , 'Record':U , h_v-que_articulo-3 ).

    END. /* Page 5 */

    WHEN 6 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-otros_datosarticulo.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-otros_datosarticulo ).
       RUN set-position IN h_v-otros_datosarticulo ( 2.67 , 31.00 ) NO-ERROR.
       /* Size in UIB:  ( 20.71 , 126.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-articulo_atributo.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-articulo_atributo ).
       RUN set-position IN h_b-articulo_atributo ( 16.95 , 31.00 ) NO-ERROR.
       RUN set-size IN h_b-articulo_atributo ( 4.57 , 126.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-articulo_atributo.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-articulo_atributo ).
       RUN set-position IN h_v-articulo_atributo ( 21.95 , 31.00 ) NO-ERROR.
       /* Size in UIB:  ( 3.10 , 126.00 ) */

       /* Links to SmartViewer h_v-otros_datosarticulo. */
       RUN add-link IN adm-broker-hdl ( h_b-articulo , 'Record':U , h_v-otros_datosarticulo ).

       /* Links to SmartBrowser h_b-articulo_atributo. */
       RUN add-link IN adm-broker-hdl ( h_b-articulo , 'Record':U , h_b-articulo_atributo ).

       /* Links to SmartViewer h_v-articulo_atributo. */
       RUN add-link IN adm-broker-hdl ( h_b-articulo_atributo , 'Record':U , h_v-articulo_atributo ).

       /* Adjust the tab order of the smart objects. */
    END. /* Page 6 */

  END CASE.
  /* Select a Startup page. */
  IF adm-current-page eq 0 
  THEN RUN select-page IN THIS-PROCEDURE ( 1 ).

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
  VIEW FRAME F-Main IN WINDOW W-Win.
  {&OPEN-BROWSERS-IN-QUERY-F-Main}
  VIEW W-Win.
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

  {setwintit.i "SIC/INV" "Consulta de Maestro de Articulos"}


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

    DEFINE VARIABLE folder-labels AS CHARACTER.
    DEFINE VARIABLE page-hdl      AS CHARACTER.
    DEFINE VARIABLE j-pagina      AS INTEGER.

    RUN get-attribute IN h_folder ('FOLDER-LABELS':U).
    ASSIGN folder-labels   = IF RETURN-VALUE = ? THEN "":U
                             ELSE RETURN-VALUE.

    RUN get-link-handle IN adm-broker-hdl
                      (THIS-PROCEDURE, 'PAGE-TARGET',OUTPUT page-hdl).


    DO j-pagina = 1 TO NUM-ENTRIES(folder-labels,'|':U):                             

       IF p-operacion = "HABILITAR"
          THEN RUN enable-folder-page  IN h_folder (j-pagina).
          ELSE RUN disable-folder-page IN h_folder (j-pagina).

    END.

    IF VALID-HANDLE(h_b-articulo)          THEN RUN set-sensitivo IN h_b-articulo          ( INPUT p-operacion = "HABILITAR" ).
    

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

