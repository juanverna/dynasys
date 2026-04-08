&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
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
&Scoped-define DB-AWARE no

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

DEFINE MENU MENU-BAR-W-Win MENUBAR
       SUB-MENU  m_Archivo      LABEL "&Archivo"      .


/* Definitions of handles for SmartObjects                              */
DEFINE VARIABLE h_b-cons_comprobantes AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-cons_ctacte_rend AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-cons_historico AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-cons_op_pend_rend AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-cons_rendgastos_dt AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-cons_rendgastos_hd AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-cons_usovehiculo AS HANDLE NO-UNDO.
DEFINE VARIABLE h_folder AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-consulta AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-consulta-2 AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-consulta-3 AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-consulta-4 AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-consulta-5 AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-consulta-6 AS HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 159 BY 26.43.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartWindow
   Allow: Basic,Browse,DB-Fields,Query,Smart,Window
   Design Page: 6
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW W-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Consulta de Rendiciones"
         HEIGHT             = 25.29
         WIDTH              = 160
         MAX-HEIGHT         = 28.62
         MAX-WIDTH          = 160
         VIRTUAL-HEIGHT     = 28.62
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
ON END-ERROR OF W-Win /* Consulta de Rendiciones */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-CLOSE OF W-Win /* Consulta de Rendiciones */
DO:
  /* This ADM code must be left here in order for the SmartWindow
     and its descendents to terminate properly on exit. */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Salir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Salir W-Win
ON CHOOSE OF MENU-ITEM m_Salir /* Salir */
DO:
  APPLY "CLOSE":U TO THIS-PROCEDURE.
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
             INPUT  'FOLDER-LABELS = ':U + 'Rendicion|Detalles|Comprobantes|Historico|Viaticos|Cta.Cte.Prov.|O.P.Pendiente' + ',
                     FOLDER-TAB-TYPE = 1':U ,
             OUTPUT h_folder ).
       RUN set-position IN h_folder ( 1.00 , 1.00 ) NO-ERROR.
       RUN set-size IN h_folder ( 25.95 , 159.00 ) NO-ERROR.

       /* Links to SmartFolder h_folder. */
       RUN add-link IN adm-broker-hdl ( h_folder , 'Page':U , THIS-PROCEDURE ).

    END. /* Page 0 */

    WHEN 1 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-cons_rendgastos_hd.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-cons_rendgastos_hd ).
       RUN set-position IN h_b-cons_rendgastos_hd ( 2.67 , 3.00 ) NO-ERROR.
       RUN set-size IN h_b-cons_rendgastos_hd ( 23.81 , 153.00 ) NO-ERROR.

    END. /* Page 1 */

    WHEN 2 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-consulta.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-consulta ).
       RUN set-position IN h_v-consulta ( 2.67 , 3.00 ) NO-ERROR.
       /* Size in UIB:  ( 3.62 , 154.60 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-cons_rendgastos_dt.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-cons_rendgastos_dt ).
       RUN set-position IN h_b-cons_rendgastos_dt ( 6.71 , 3.00 ) NO-ERROR.
       RUN set-size IN h_b-cons_rendgastos_dt ( 19.29 , 155.00 ) NO-ERROR.

       /* Initialize other pages that this page requires. */
       RUN init-pages IN THIS-PROCEDURE ('1') NO-ERROR.

       /* Links to SmartViewer h_v-consulta. */
       RUN add-link IN adm-broker-hdl ( h_b-cons_rendgastos_hd , 'Record':U , h_v-consulta ).

       /* Links to SmartBrowser h_b-cons_rendgastos_dt. */
       RUN add-link IN adm-broker-hdl ( h_b-cons_rendgastos_hd , 'Record':U , h_b-cons_rendgastos_dt ).

    END. /* Page 2 */

    WHEN 3 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-consulta.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-consulta-2 ).
       RUN set-position IN h_v-consulta-2 ( 2.67 , 3.00 ) NO-ERROR.
       /* Size in UIB:  ( 3.62 , 154.60 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-cons_comprobantes.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-cons_comprobantes ).
       RUN set-position IN h_b-cons_comprobantes ( 6.71 , 3.00 ) NO-ERROR.
       RUN set-size IN h_b-cons_comprobantes ( 19.52 , 153.00 ) NO-ERROR.

       /* Initialize other pages that this page requires. */
       RUN init-pages IN THIS-PROCEDURE ('1') NO-ERROR.

       /* Links to SmartViewer h_v-consulta-2. */
       RUN add-link IN adm-broker-hdl ( h_b-cons_rendgastos_hd , 'Record':U , h_v-consulta-2 ).

       /* Links to SmartBrowser h_b-cons_comprobantes. */
       RUN add-link IN adm-broker-hdl ( h_b-cons_rendgastos_hd , 'Record':U , h_b-cons_comprobantes ).

    END. /* Page 3 */

    WHEN 4 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-consulta.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-consulta-3 ).
       RUN set-position IN h_v-consulta-3 ( 2.67 , 3.00 ) NO-ERROR.
       /* Size in UIB:  ( 3.62 , 154.60 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-cons_historico.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-cons_historico ).
       RUN set-position IN h_b-cons_historico ( 6.71 , 3.00 ) NO-ERROR.
       RUN set-size IN h_b-cons_historico ( 19.52 , 153.00 ) NO-ERROR.

       /* Initialize other pages that this page requires. */
       RUN init-pages IN THIS-PROCEDURE ('1') NO-ERROR.

       /* Links to SmartViewer h_v-consulta-3. */
       RUN add-link IN adm-broker-hdl ( h_b-cons_rendgastos_hd , 'Record':U , h_v-consulta-3 ).

       /* Links to SmartBrowser h_b-cons_historico. */
       RUN add-link IN adm-broker-hdl ( h_b-cons_rendgastos_hd , 'Record':U , h_b-cons_historico ).

    END. /* Page 4 */

    WHEN 5 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-consulta.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-consulta-4 ).
       RUN set-position IN h_v-consulta-4 ( 2.67 , 3.00 ) NO-ERROR.
       /* Size in UIB:  ( 3.62 , 154.60 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-cons_usovehiculo.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-cons_usovehiculo ).
       RUN set-position IN h_b-cons_usovehiculo ( 6.48 , 3.00 ) NO-ERROR.
       RUN set-size IN h_b-cons_usovehiculo ( 19.29 , 152.00 ) NO-ERROR.

       /* Initialize other pages that this page requires. */
       RUN init-pages IN THIS-PROCEDURE ('1') NO-ERROR.

       /* Links to SmartViewer h_v-consulta-4. */
       RUN add-link IN adm-broker-hdl ( h_b-cons_rendgastos_hd , 'Record':U , h_v-consulta-4 ).

       /* Links to SmartBrowser h_b-cons_usovehiculo. */
       RUN add-link IN adm-broker-hdl ( h_b-cons_rendgastos_hd , 'Record':U , h_b-cons_usovehiculo ).

    END. /* Page 5 */

    WHEN 6 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-consulta.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-consulta-6 ).
       RUN set-position IN h_v-consulta-6 ( 2.67 , 3.00 ) NO-ERROR.
       /* Size in UIB:  ( 3.62 , 154.60 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-cons_ctacte_rend.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-cons_ctacte_rend ).
       RUN set-position IN h_b-cons_ctacte_rend ( 6.48 , 3.00 ) NO-ERROR.
       RUN set-size IN h_b-cons_ctacte_rend ( 19.29 , 153.00 ) NO-ERROR.

       /* Initialize other pages that this page requires. */
       RUN init-pages IN THIS-PROCEDURE ('1') NO-ERROR.

       /* Links to SmartViewer h_v-consulta-6. */
       RUN add-link IN adm-broker-hdl ( h_b-cons_rendgastos_hd , 'Record':U , h_v-consulta-6 ).

       /* Links to SmartBrowser h_b-cons_ctacte_rend. */
       RUN add-link IN adm-broker-hdl ( h_b-cons_rendgastos_hd , 'Record':U , h_b-cons_ctacte_rend ).

    END. /* Page 6 */

    WHEN 7 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-consulta.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-consulta-5 ).
       RUN set-position IN h_v-consulta-5 ( 2.67 , 3.00 ) NO-ERROR.
       /* Size in UIB:  ( 3.62 , 154.60 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-cons_op_pend_rend.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-cons_op_pend_rend ).
       RUN set-position IN h_b-cons_op_pend_rend ( 6.71 , 3.00 ) NO-ERROR.
       RUN set-size IN h_b-cons_op_pend_rend ( 19.29 , 152.00 ) NO-ERROR.

       /* Initialize other pages that this page requires. */
       RUN init-pages IN THIS-PROCEDURE ('1') NO-ERROR.

       /* Links to SmartViewer h_v-consulta-5. */
       RUN add-link IN adm-broker-hdl ( h_b-cons_rendgastos_hd , 'Record':U , h_v-consulta-5 ).

       /* Links to SmartBrowser h_b-cons_op_pend_rend. */
       RUN add-link IN adm-broker-hdl ( h_b-cons_rendgastos_hd , 'Record':U , h_b-cons_op_pend_rend ).

       /* Adjust the tab order of the smart objects. */
    END. /* Page 7 */

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

   {setwintit.i "SIC/RGV" "Consulta de Rendiciones de Gastos"}


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE refrescar-detalle W-Win 
PROCEDURE refrescar-detalle :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAMETER todo_ok     AS LOGICAL.

DEFINE VARIABLE p-operacion AS CHARACTER.
/*
IF VALID-HANDLE(h_b-historia_rendicion) THEN 
DO:
   RUN refresco-detalle IN h_b-historia_rendicion.
END. */
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

