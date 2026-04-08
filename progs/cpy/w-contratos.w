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

/* Name of designated FRAME-NAME and/or first browse and/or first query */
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
DEFINE MENU MENU-BAR-W-Win MENUBAR
       MENU-ITEM m_Archivo      LABEL "&Archivo"      .


/* Definitions of handles for SmartObjects                              */
DEFINE VARIABLE h_b-clientes_con_contratos AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-contratos AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-detalle_contrato AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-especif_header AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-restcont AS HANDLE NO-UNDO.
DEFINE VARIABLE h_f-restric AS HANDLE NO-UNDO.
DEFINE VARIABLE h_folder AS HANDLE NO-UNDO.
DEFINE VARIABLE h_p-updsav AS HANDLE NO-UNDO.
DEFINE VARIABLE h_p-updspa AS HANDLE NO-UNDO.
DEFINE VARIABLE h_p-updspa-2 AS HANDLE NO-UNDO.
DEFINE VARIABLE h_q-empresa AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-contrato AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-detalle_contrato AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-id-contrato AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-id-contrato-2 AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-restcli1 AS HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 160 BY 25.86.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartWindow
   External Tables: sic.Cliente
   Allow: Basic,Browse,DB-Fields,Query,Smart,Window
   Design Page: 4
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW W-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Mantenimiento de Contratos"
         HEIGHT             = 25.86
         WIDTH              = 160
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
   FRAME-NAME                                                           */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(W-Win)
THEN W-Win:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON END-ERROR OF W-Win /* Mantenimiento de Contratos */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-CLOSE OF W-Win /* Mantenimiento de Contratos */
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
ON WINDOW-MINIMIZED OF W-Win /* Mantenimiento de Contratos */
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
             INPUT  'adm/objects/folder.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'FOLDER-LABELS = ':U + 'Clientes|Contratos|Especificacin|Restricciones' + ',
                     FOLDER-TAB-TYPE = 1':U ,
             OUTPUT h_folder ).
       RUN set-position IN h_folder ( 1.00 , 4.00 ) NO-ERROR.
       RUN set-size IN h_folder ( 25.24 , 157.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'q-empresa.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  '':U ,
             OUTPUT h_q-empresa ).
       RUN set-position IN h_q-empresa ( 1.00 , 121.00 ) NO-ERROR.
       /* Size in UIB:  ( 1.76 , 8.20 ) */

       /* Links to SmartFolder h_folder. */
       RUN add-link IN adm-broker-hdl ( h_folder , 'Page':U , THIS-PROCEDURE ).

    END. /* Page 0 */
    WHEN 1 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-clientes_con_contratos.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-clientes_con_contratos ).
       RUN set-position IN h_b-clientes_con_contratos ( 3.38 , 6.00 ) NO-ERROR.
       RUN set-size IN h_b-clientes_con_contratos ( 22.38 , 148.00 ) NO-ERROR.

       /* Links to SmartBrowser h_b-clientes_con_contratos. */
       RUN add-link IN adm-broker-hdl ( h_q-empresa , 'Record':U , h_b-clientes_con_contratos ).

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_b-clientes_con_contratos ,
             h_folder , 'AFTER':U ).
    END. /* Page 1 */
    WHEN 2 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'cpy/b-contratos.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-contratos ).
       RUN set-position IN h_b-contratos ( 2.91 , 4.00 ) NO-ERROR.
       RUN set-size IN h_b-contratos ( 15.71 , 27.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-contrato.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-contrato ).
       RUN set-position IN h_v-contrato ( 2.91 , 33.00 ) NO-ERROR.
       /* Size in UIB:  ( 13.81 , 123.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'p-updspa.w':U ,
             INPUT  {&WINDOW-NAME} ,
             INPUT  'Edge-Pixels = 2,
                     SmartPanelType = Update-Trans,
                     AddFunction = One-Record':U ,
             OUTPUT h_p-updspa ).
       RUN set-position IN h_p-updspa ( 16.91 , 33.00 ) NO-ERROR.
       RUN set-size IN h_p-updspa ( 1.29 , 123.40 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'cpy/v-detalle_contrato.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-detalle_contrato ).
       RUN set-position IN h_v-detalle_contrato ( 18.38 , 33.00 ) NO-ERROR.
       /* Size in UIB:  ( 7.38 , 105.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'cpy/b-detalle_contrato.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-detalle_contrato ).
       RUN set-position IN h_b-detalle_contrato ( 18.62 , 4.00 ) NO-ERROR.
       RUN set-size IN h_b-detalle_contrato ( 6.71 , 13.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'p-updspa.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Edge-Pixels = 2,
                     SmartPanelType = Update-Trans,
                     AddFunction = One-Record':U ,
             OUTPUT h_p-updspa-2 ).
       RUN set-position IN h_p-updspa-2 ( 18.62 , 19.00 ) NO-ERROR.
       RUN set-size IN h_p-updspa-2 ( 6.91 , 12.00 ) NO-ERROR.

       /* Initialize other pages that this page requires. */
       RUN init-pages IN THIS-PROCEDURE ('1':U) NO-ERROR.

       /* Links to SmartBrowser h_b-contratos. */
       RUN add-link IN adm-broker-hdl ( h_b-clientes_con_contratos , 'Record':U , h_b-contratos ).

       /* Links to SmartViewer h_v-contrato. */
       RUN add-link IN adm-broker-hdl ( h_b-contratos , 'Record':U , h_v-contrato ).
       RUN add-link IN adm-broker-hdl ( h_p-updspa , 'TableIO':U , h_v-contrato ).

       /* Links to SmartViewer h_v-detalle_contrato. */
       RUN add-link IN adm-broker-hdl ( h_b-detalle_contrato , 'Record':U , h_v-detalle_contrato ).
       RUN add-link IN adm-broker-hdl ( h_p-updspa-2 , 'TableIO':U , h_v-detalle_contrato ).

       /* Links to SmartBrowser h_b-detalle_contrato. */
       RUN add-link IN adm-broker-hdl ( h_b-contratos , 'Record':U , h_b-detalle_contrato ).

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_b-contratos ,
             h_folder , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-contrato ,
             h_b-contratos , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-detalle_contrato ,
             h_v-contrato , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_b-detalle_contrato ,
             h_v-detalle_contrato , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_p-updspa-2 ,
             h_b-detalle_contrato , 'AFTER':U ).
    END. /* Page 2 */
    WHEN 3 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-id-contrato.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-id-contrato-2 ).
       RUN set-position IN h_v-id-contrato-2 ( 3.38 , 23.00 ) NO-ERROR.
       /* Size in UIB:  ( 2.14 , 96.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-especif_header.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-especif_header ).
       RUN set-position IN h_b-especif_header ( 6.71 , 23.00 ) NO-ERROR.
       RUN set-size IN h_b-especif_header ( 15.95 , 96.00 ) NO-ERROR.

       /* Initialize other pages that this page requires. */
       RUN init-pages IN THIS-PROCEDURE ('2':U) NO-ERROR.

       /* Links to SmartViewer h_v-id-contrato-2. */
       RUN add-link IN adm-broker-hdl ( h_b-contratos , 'Record':U , h_v-id-contrato-2 ).

       /* Links to SmartBrowser h_b-especif_header. */
       RUN add-link IN adm-broker-hdl ( h_b-contratos , 'Record':U , h_b-especif_header ).

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-id-contrato-2 ,
             h_folder , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_b-especif_header ,
             h_v-id-contrato-2 , 'AFTER':U ).
    END. /* Page 3 */
    WHEN 4 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-id-contrato.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-id-contrato ).
       RUN set-position IN h_v-id-contrato ( 3.38 , 26.00 ) NO-ERROR.
       /* Size in UIB:  ( 2.14 , 96.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'opr/b-restcont.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-restcont ).
       RUN set-position IN h_b-restcont ( 6.71 , 8.00 ) NO-ERROR.
       RUN set-size IN h_b-restcont ( 15.24 , 16.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-restcli1.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-restcli1 ).
       RUN set-position IN h_v-restcli1 ( 6.71 , 26.00 ) NO-ERROR.
       /* Size in UIB:  ( 3.57 , 80.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'bas/p-updsav.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Edge-Pixels = 2,
                     SmartPanelType = Save,
                     AddFunction = One-Record':U ,
             OUTPUT h_p-updsav ).
       RUN set-position IN h_p-updsav ( 6.71 , 108.00 ) NO-ERROR.
       RUN set-size IN h_p-updsav ( 15.24 , 15.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'f-restric.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_f-restric ).
       RUN set-position IN h_f-restric ( 10.52 , 26.00 ) NO-ERROR.
       /* Size in UIB:  ( 11.24 , 79.60 ) */

       /* Initialize other pages that this page requires. */
       RUN init-pages IN THIS-PROCEDURE ('2':U) NO-ERROR.

       /* Links to SmartViewer h_v-id-contrato. */
       RUN add-link IN adm-broker-hdl ( h_b-contratos , 'Record':U , h_v-id-contrato ).

       /* Links to SmartBrowser h_b-restcont. */
       RUN add-link IN adm-broker-hdl ( h_b-contratos , 'Record':U , h_b-restcont ).

       /* Links to SmartViewer h_v-restcli1. */
       RUN add-link IN adm-broker-hdl ( h_b-restcont , 'Record':U , h_v-restcli1 ).
       RUN add-link IN adm-broker-hdl ( h_p-updsav , 'TableIO':U , h_v-restcli1 ).

       /* Links to SmartFrame h_f-restric. */
       RUN add-link IN adm-broker-hdl ( h_v-restcli1 , 'group-assign':U , h_f-restric ).
       RUN add-link IN adm-broker-hdl ( h_v-restcli1 , 'Record':U , h_f-restric ).

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-id-contrato ,
             h_folder , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_b-restcont ,
             h_v-id-contrato , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-restcli1 ,
             h_b-restcont , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_p-updsav ,
             h_v-restcli1 , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_f-restric ,
             h_p-updsav , 'AFTER':U ).
    END. /* Page 4 */

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

   {findempresa.i}
   RUN posicionar_query IN h_q-empresa ( INPUT ROWID(Empresa)).

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

  {setwintit.i "SIC/FAC" "Mantenimiento de Contratos"}


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

       IF p-operacion = "HABILITAR"
          THEN RUN enable-folder-page  IN h_folder (j-pagina).
          ELSE RUN disable-folder-page IN h_folder (j-pagina).

    END.

    IF VALID-HANDLE(h_b-clientes)          THEN RUN set-sensitivo IN h_b-clientes          ( INPUT p-operacion = "HABILITAR" ).
    IF VALID-HANDLE(h_b-bon_cliente)       THEN RUN set-sensitivo IN h_b-bon_cliente       ( INPUT p-operacion = "HABILITAR" ). 
    IF VALID-HANDLE(h_b-bon_xarticulo)     THEN RUN set-sensitivo IN h_b-bon_xarticulo     ( INPUT p-operacion = "HABILITAR" ). 
    IF VALID-HANDLE(h_b-cliente_condicion) THEN RUN set-sensitivo IN h_b-cliente_condicion ( INPUT p-operacion = "HABILITAR" ). 
    IF VALID-HANDLE(h_b-clientes)          THEN RUN set-sensitivo IN h_b-clientes          ( INPUT p-operacion = "HABILITAR" ). 
    IF VALID-HANDLE(h_b-domicilios)        THEN RUN set-sensitivo IN h_b-domicilios        ( INPUT p-operacion = "HABILITAR" ). 
    IF VALID-HANDLE(h_p-updsav)            THEN RUN set-sensitivo IN h_p-updsav            ( INPUT p-operacion = "HABILITAR" ).
    IF VALID-HANDLE(h_p-updspa)            THEN RUN set-sensitivo IN h_p-updspa            ( INPUT p-operacion = "HABILITAR" ). 
    IF VALID-HANDLE(h_p-updspa-2)          THEN RUN set-sensitivo IN h_p-updspa-2          ( INPUT p-operacion = "HABILITAR" ). 
    IF VALID-HANDLE(h_p-updspa-3)          THEN RUN set-sensitivo IN h_p-updspa-3          ( INPUT p-operacion = "HABILITAR" ).
    IF VALID-HANDLE(h_p-updspa-4)          THEN RUN set-sensitivo IN h_p-updspa-4          ( INPUT p-operacion = "HABILITAR" ).
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

