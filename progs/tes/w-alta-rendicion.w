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

DEFINE VARIABLE txn_activa AS LOGICAL.

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
DEFINE MENU MENU-BAR-W-Win MENUBAR
       MENU-ITEM m_Archivo      LABEL "&Archivo"      .


/* Definitions of handles for SmartObjects                              */
DEFINE VARIABLE h_b-comprobante_rendicion AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-recibos-rendicion AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-rendicion AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-rendicion_dt AS HANDLE NO-UNDO.
DEFINE VARIABLE h_folder AS HANDLE NO-UNDO.
DEFINE VARIABLE h_p-navico AS HANDLE NO-UNDO.
DEFINE VARIABLE h_p-updspa-sicopia-tes AS HANDLE NO-UNDO.
DEFINE VARIABLE h_q-cobempresa AS HANDLE NO-UNDO.
DEFINE VARIABLE h_q-cobrador AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-id-cobrador AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-id-empresa-2 AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-rendicion AS HANDLE NO-UNDO.

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
   Design Page: 2
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW W-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "SIC/TES Ingreso de Rendiciones"
         HEIGHT             = 21.23
         WIDTH              = 114.29
         MAX-HEIGHT         = 21.62
         MAX-WIDTH          = 114.29
         VIRTUAL-HEIGHT     = 21.62
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

{setsensitivo.i}
{src/adm/method/containr.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON END-ERROR OF W-Win /* SIC/TES Ingreso de Rendiciones */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-CLOSE OF W-Win /* SIC/TES Ingreso de Rendiciones */
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
ON WINDOW-MINIMIZED OF W-Win /* SIC/TES Ingreso de Rendiciones */
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
             INPUT  'v-id-cobrador.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-id-cobrador ).
       RUN set-position IN h_v-id-cobrador ( 1.27 , 3.00 ) NO-ERROR.
       /* Size in UIB:  ( 1.62 , 44.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'p-updspa-sicopia-tes.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Edge-Pixels = 2,
                     SmartPanelType = Update-Trans,
                     AddFunction = One-Record':U ,
             OUTPUT h_p-updspa-sicopia-tes ).
       RUN set-position IN h_p-updspa-sicopia-tes ( 1.27 , 45.00 ) NO-ERROR.
       RUN set-size IN h_p-updspa-sicopia-tes ( 1.62 , 68.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-rendicion.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-rendicion ).
       RUN set-position IN h_b-rendicion ( 3.15 , 3.00 ) NO-ERROR.
       /* Size in UIB:  ( 15.88 , 18.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-rendicion.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  '':U ,
             OUTPUT h_v-rendicion ).
       /* Position in UIB:  ( 3.15 , 22.00 ) */
       /* Size in UIB:  ( 2.42 , 68.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-id-empresa-2.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  '':U ,
             OUTPUT h_v-id-empresa-2 ).
       /* Position in UIB:  ( 3.15 , 92.00 ) */
       /* Size in UIB:  ( 0.81 , 21.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'adm/objects/p-navico.r':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Edge-Pixels = 2,
                     SmartPanelType = NAV-ICON,
                     Right-to-Left = First-On-Left':U ,
             OUTPUT h_p-navico ).
       RUN set-position IN h_p-navico ( 4.23 , 92.00 ) NO-ERROR.
       RUN set-size IN h_p-navico ( 1.35 , 21.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'adm/objects/folder.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'FOLDER-LABELS = ':U + 'Cupones|Recibos|Valores' + ',
                     FOLDER-TAB-TYPE = 1':U ,
             OUTPUT h_folder ).
       RUN set-position IN h_folder ( 5.85 , 22.00 ) NO-ERROR.
       RUN set-size IN h_folder ( 15.88 , 91.00 ) NO-ERROR.

       /* Initialize other pages that this page requires. */
       RUN init-pages IN THIS-PROCEDURE ('5,1') NO-ERROR.

       /* Links to SmartBrowser h_b-rendicion. */
       RUN add-link IN adm-broker-hdl ( h_q-cobempresa , 'Record':U , h_b-rendicion ).

       /* Links to  h_v-rendicion. */
       RUN add-link IN adm-broker-hdl ( h_b-comprobante_rendicion , 'Totalizar':U , h_v-rendicion ).
       RUN add-link IN adm-broker-hdl ( h_b-rendicion , 'Record':U , h_v-rendicion ).
       RUN add-link IN adm-broker-hdl ( h_p-updspa-sicopia-tes , 'TableIO':U , h_v-rendicion ).

       /* Links to  h_v-id-empresa-2. */
       RUN add-link IN adm-broker-hdl ( h_q-cobempresa , 'Record':U , h_v-id-empresa-2 ).

       /* Links to SmartFolder h_folder. */
       RUN add-link IN adm-broker-hdl ( h_folder , 'Page':U , THIS-PROCEDURE ).

    END. /* Page 0 */

    WHEN 1 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-comprobante_rendicion.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  '':U ,
             OUTPUT h_b-comprobante_rendicion ).
       /* Position in UIB:  ( 7.73 , 25.00 ) */
       /* Size in UIB:  ( 12.92 , 85.00 ) */

       /* Links to  h_b-comprobante_rendicion. */
       RUN add-link IN adm-broker-hdl ( h_b-rendicion , 'Record':U , h_b-comprobante_rendicion ).

    END. /* Page 1 */

    WHEN 2 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-recibos-rendicion.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-recibos-rendicion ).
       RUN set-position IN h_b-recibos-rendicion ( 7.46 , 23.00 ) NO-ERROR.
       /* Size in UIB:  ( 13.19 , 88.00 ) */

       /* Links to SmartBrowser h_b-recibos-rendicion. */
       RUN add-link IN adm-broker-hdl ( h_b-rendicion , 'Record':U , h_b-recibos-rendicion ).

    END. /* Page 2 */

    WHEN 3 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-rendicion_dt.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-rendicion_dt ).
       RUN set-position IN h_b-rendicion_dt ( 7.46 , 24.00 ) NO-ERROR.
       /* Size in UIB:  ( 13.46 , 86.00 ) */

       /* Links to SmartBrowser h_b-rendicion_dt. */
       RUN add-link IN adm-broker-hdl ( h_b-rendicion , 'Record':U , h_b-rendicion_dt ).

    END. /* Page 3 */

    WHEN 5 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'q-cobempresa.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  '':U ,
             OUTPUT h_q-cobempresa ).
       /* Position in UIB:  ( 9.62 , 42.00 ) */
       /* Size in UIB:  ( 1.77 , 8.29 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'q-cobrador.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  '':U ,
             OUTPUT h_q-cobrador ).
       /* Position in UIB:  ( 10.15 , 63.00 ) */
       /* Size in UIB:  ( 1.77 , 8.29 ) */

       /* Links to  h_q-cobempresa. */
       RUN add-link IN adm-broker-hdl ( h_p-navico , 'Navigation':U , h_q-cobempresa ).
       RUN add-link IN adm-broker-hdl ( h_q-cobrador , 'Record':U , h_q-cobempresa ).

       /* Links to  h_q-cobrador. */
       RUN add-link IN adm-broker-hdl ( h_v-id-cobrador , 'Posicionar':U , h_q-cobrador ).

       /* Adjust the tab order of the smart objects. */
    END. /* Page 5 */

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

  {setwintit.i "SIC/TES" "Ingreso de Rendiciones"}


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

/*
       IF p-operacion = "HABILITAR"
          THEN RUN enable-folder-page  IN WIDGET-HANDLE(page-hdl) (j-pagina).
          ELSE RUN disable-folder-page IN WIDGET-HANDLE(page-hdl) (j-pagina).
*/
       IF p-operacion = "HABILITAR"
          THEN RUN enable-folder-page  IN h_folder (j-pagina).
          ELSE RUN disable-folder-page IN h_folder (j-pagina).

    END.
/*
    IF p-operacion = "HABILITAR" 
    THEN DO: 
         IF VALID-HANDLE(h_b-cuenta-bancaria) THEN RUN set-sensitivo IN h_b-cuenta-bancaria  ( INPUT YES ).
         IF VALID-HANDLE(h_b-chequeras)       THEN RUN set-sensitivo IN h_b-chequeras        ( INPUT YES ).
       /*MENU-BAR-W-Win:SENSITIVE IN FRAME {&FRAME-NAME} = YES.*/
    END.     
    ELSE DO: 
         IF VALID-HANDLE(h_b-cuenta-bancaria) THEN RUN set-sensitivo IN h_b-cuenta-bancaria  ( INPUT NO ).
         IF VALID-HANDLE(h_b-chequeras)       THEN RUN set-sensitivo IN h_b-chequeras        ( INPUT NO ).
       /*MENU MENU-BAR-W-Win:SENSITIVE IN FRAME {&FRAME-NAME} = NO.*/
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


