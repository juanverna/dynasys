&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
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

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartWindow

&Scoped-define ADM-CONTAINER WINDOW

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME F-Main

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

DEFINE SUB-MENU m_Reportes 
       MENU-ITEM m_OC_Pendientes LABEL "O/C &Pendientes".

DEFINE MENU MENU-BAR-W-Win MENUBAR
       SUB-MENU  m_Archivo      LABEL "&Archivo"      
       SUB-MENU  m_Reportes     LABEL "Reportes"      .


/* Definitions of handles for SmartObjects                              */
DEFINE VARIABLE h_b-ocm_detalle AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-ocm_detalle-2 AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-ocm_entrega AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-ocm_header AS HANDLE NO-UNDO.
DEFINE VARIABLE h_folder AS HANDLE NO-UNDO.
DEFINE VARIABLE h_p-btn-documento AS HANDLE NO-UNDO.
DEFINE VARIABLE h_p-updsav AS HANDLE NO-UNDO.
DEFINE VARIABLE h_p-updsav-3 AS HANDLE NO-UNDO.
DEFINE VARIABLE h_p-updtxn AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-ocm_detalle AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-ocm_entrega AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-ocm_header AS HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 114.29 BY 21.23.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartWindow
   Allow: Basic,Browse,DB-Fields,Query,Smart,Window
   Design Page: 1
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW W-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "SIC/COM - Ordenes de Compra"
         HEIGHT             = 21.23
         WIDTH              = 114.29
         MAX-HEIGHT         = 21.23
         MAX-WIDTH          = 114.29
         VIRTUAL-HEIGHT     = 21.23
         VIRTUAL-WIDTH      = 114.29
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

IF NOT W-Win:LOAD-ICON("adeicon\admin%":U) THEN
    MESSAGE "Unable to load icon: adeicon\admin%"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME


/* ***************  Runtime Attributes and UIB Settings  ************** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW W-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME F-Main
                                                                        */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(W-Win)
THEN W-Win:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB W-Win 
/* ************************* Included-Libraries *********************** */

{src/adm/method/containr.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON END-ERROR OF W-Win /* SIC/COM - Ordenes de Compra */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-CLOSE OF W-Win /* SIC/COM - Ordenes de Compra */
DO:
  /* This ADM code must be left here in order for the SmartWindow
     and its descendents to terminate properly on exit. */
   RUN get-attribute ('ADM-TRANSACTION').
   IF RETURN-VALUE = 'YES'     
   THEN DO:
        MESSAGE "No puede salir habiendo actualizaciones en curso"
                VIEW-AS ALERT-BOX ERROR TITLE "Mensaje del sistema".
   END.
   ELSE DO:
        APPLY "CLOSE":U TO THIS-PROCEDURE.
   END.                       

  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Salir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Salir W-Win
ON CHOOSE OF MENU-ITEM m_Salir /* Salir */
DO:
   RUN get-attribute ('ADM-TRANSACTION').
   IF RETURN-VALUE = 'YES'     
   THEN DO:
        MESSAGE "No puede salir habiendo actualizaciones en curso"
                VIEW-AS ALERT-BOX ERROR TITLE "Mensaje del sistema".
   END.
   ELSE DO:
        APPLY "CLOSE":U TO THIS-PROCEDURE.
   END.                       

  RETURN NO-APPLY.
  
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-create-objects W-Win _ADM-CREATE-OBJECTS
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
             INPUT  'b-ocm_header.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-ocm_header ).
       RUN set-position IN h_b-ocm_header ( 1.00 , 2.00 ) NO-ERROR.
       /* Size in UIB:  ( 21.00 , 15.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'adm/objects/folder.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'FOLDER-LABELS = ':U + 'Datos|Detalle|Recepciones|Novedades|Observaciones' + ',
                     FOLDER-TAB-TYPE = 1':U ,
             OUTPUT h_folder ).
       RUN set-position IN h_folder ( 1.00 , 19.00 ) NO-ERROR.
       RUN set-size IN h_folder ( 21.00 , 96.00 ) NO-ERROR.

       /* Links to SmartFolder h_folder. */
       RUN add-link IN adm-broker-hdl ( h_folder , 'Page':U , THIS-PROCEDURE ).

    END. /* Page 0 */

    WHEN 1 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'p-btn-documento.w':U ,
             INPUT  {&WINDOW-NAME} ,
             INPUT  'Edge-Pixels = 2,
                     SmartPanelType = Update-Trans,
                     AddFunction = One-Record':U ,
             OUTPUT h_p-btn-documento ).
       RUN set-position IN h_p-btn-documento ( 2.69 , 23.29 ) NO-ERROR.
       RUN set-size IN h_p-btn-documento ( 2.08 , 87.86 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-ocm_header.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-ocm_header ).
       RUN set-position IN h_v-ocm_header ( 5.04 , 23.00 ) NO-ERROR.
       /* Size in UIB:  ( 12.65 , 88.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'p-updsav.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Edge-Pixels = 2,
                     SmartPanelType = Update,
                     AddFunction = One-Record':U ,
             OUTPUT h_p-updsav-3 ).
       RUN set-position IN h_p-updsav-3 ( 18.23 , 23.00 ) NO-ERROR.
       RUN set-size IN h_p-updsav-3 ( 2.42 , 88.00 ) NO-ERROR.

       /* Links to SmartViewer h_v-ocm_header. */
       RUN add-link IN adm-broker-hdl ( h_b-ocm_header , 'Record':U , h_v-ocm_header ).
       RUN add-link IN adm-broker-hdl ( h_p-btn-documento , 'Documento':U , h_v-ocm_header ).
       RUN add-link IN adm-broker-hdl ( h_p-updsav-3 , 'TableIO':U , h_v-ocm_header ).

    END. /* Page 1 */

    WHEN 2 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-ocm_detalle.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-ocm_detalle ).
       RUN set-position IN h_b-ocm_detalle ( 2.35 , 21.00 ) NO-ERROR.
       /* Size in UIB:  ( 4.85 , 87.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-ocm_detalle.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-ocm_detalle ).
       RUN set-position IN h_v-ocm_detalle ( 7.73 , 21.00 ) NO-ERROR.
       /* Size in UIB:  ( 5.12 , 86.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'p-updsav.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Edge-Pixels = 2,
                     SmartPanelType = Update,
                     AddFunction = One-Record':U ,
             OUTPUT h_p-updsav ).
       RUN set-position IN h_p-updsav ( 13.12 , 21.00 ) NO-ERROR.
       RUN set-size IN h_p-updsav ( 1.77 , 86.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-ocm_entrega.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-ocm_entrega ).
       RUN set-position IN h_b-ocm_entrega ( 15.00 , 21.00 ) NO-ERROR.
       /* Size in UIB:  ( 4.58 , 11.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-ocm_entrega.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-ocm_entrega ).
       RUN set-position IN h_v-ocm_entrega ( 15.00 , 33.00 ) NO-ERROR.
       /* Size in UIB:  ( 4.58 , 74.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'p-updtxn.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Edge-Pixels = 2,
                     SmartPanelType = Update-Trans,
                     AddFunction = One-Record':U ,
             OUTPUT h_p-updtxn ).
       RUN set-position IN h_p-updtxn ( 19.85 , 21.00 ) NO-ERROR.
       RUN set-size IN h_p-updtxn ( 1.81 , 87.00 ) NO-ERROR.

       /* Links to SmartBrowser h_b-ocm_detalle. */
       RUN add-link IN adm-broker-hdl ( h_b-ocm_header , 'Record':U , h_b-ocm_detalle ).

       /* Links to SmartViewer h_v-ocm_detalle. */
       RUN add-link IN adm-broker-hdl ( h_b-ocm_detalle , 'Record':U , h_v-ocm_detalle ).
       RUN add-link IN adm-broker-hdl ( h_p-updsav , 'TableIO':U , h_v-ocm_detalle ).

       /* Links to SmartPanel h_p-updsav. */
       RUN add-link IN adm-broker-hdl ( h_p-updsav , 'Txn':U , THIS-PROCEDURE ).

       /* Links to SmartBrowser h_b-ocm_entrega. */
       RUN add-link IN adm-broker-hdl ( h_b-ocm_detalle , 'Record':U , h_b-ocm_entrega ).

       /* Links to SmartViewer h_v-ocm_entrega. */
       RUN add-link IN adm-broker-hdl ( h_b-ocm_entrega , 'Record':U , h_v-ocm_entrega ).
       RUN add-link IN adm-broker-hdl ( h_p-updtxn , 'TableIO':U , h_v-ocm_entrega ).

    END. /* Page 2 */

    WHEN 3 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-ocm_detalle.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-ocm_detalle-2 ).
       RUN set-position IN h_b-ocm_detalle-2 ( 2.62 , 22.00 ) NO-ERROR.
       /* Size in UIB:  ( 4.85 , 87.00 ) */

       /* Links to SmartBrowser h_b-ocm_detalle-2. */
       RUN add-link IN adm-broker-hdl ( h_b-ocm_header , 'Record':U , h_b-ocm_detalle-2 ).

       /* Adjust the tab order of the smart objects. */
    END. /* Page 3 */

  END CASE.
  /* Select a Startup page. */
  IF adm-current-page eq 0 
  THEN RUN select-page IN THIS-PROCEDURE ( 1 ).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available W-Win _ADM-ROW-AVAILABLE
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE arrancar_txn W-Win 
PROCEDURE arrancar_txn :
/*------------------------------------------------------------------------
  Purpose:     Override standard ADM method.  This method can go in a
               SmartWindow which wants to get a record in a RECORD-Source
               and use it to change the title of the window.     
------------------------------------------------------------------------*/
/*
  DEFINE VARIABLE h AS HANDLE NO-UNDO.
  DEFINE VARIABLE c AS CHAR   NO-UNDO.
  
  /* Ask the Record-Source for the current customer record.  Make sure
     there is only one.*/
  RUN get-link-handle IN adm-broker-hdl
       (THIS-PROCEDURE, 'Record-Source':U, OUTPUT c).
  IF NUM-ENTRIES (c) eq 1 THEN DO:
    h = WIDGET-HANDLE (c).
    RUN send-records IN h ('Customer':U, OUTPUT c).
    FIND Customer WHERE ROWID(Customer) eq TO-ROWID (c) NO-ERROR.
    
  END.



/* Is ”Salary” a tab in this folder? */
RUN get-attribute IN h_folder ('FOLDER-LABELS':U).
i_tab-number = LOOKUP ('Salary':U, RETURN-VALUE, '|':U).
 
/* If so, disable it. */
IF i_tab-number > 0 THEN RUN disable-folder-page IN h_folder
        (i_tab-number).
*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI W-Win _DEFAULT-DISABLE
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI W-Win _DEFAULT-ENABLE
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
   APPLY "CLOSE":U TO THIS-PROCEDURE.
   
   RETURN.
       
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

  {setwintit.i "SIC/COM" "Ordenes de Compra"}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records W-Win _ADM-SEND-RECORDS
PROCEDURE send-records :
/*------------------------------------------------------------------------------
  Purpose:     Send record ROWID's for all tables used by
               this file.
  Parameters:  see template/snd-head.i
------------------------------------------------------------------------------*/

  /* SEND-RECORDS does nothing because there are no External
     Tables specified for this SmartWindow, and there are no
     tables specified in any contained Browse, Query, or Frame. */

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


