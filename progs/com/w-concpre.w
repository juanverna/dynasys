&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
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

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartWindow

&Scoped-define ADM-CONTAINER WINDOW

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME F-Main

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES Concurso_precios
&Scoped-define FIRST-EXTERNAL-TABLE Concurso_precios


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Concurso_precios.
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
       MENU-ITEM m_Hoja_de_Concurso LABEL "&Hoja de Concurso"
       MENU-ITEM m_Concursos_Vigentes LABEL "Concursos &Vigentes".

DEFINE MENU MENU-BAR-W-Win MENUBAR
       SUB-MENU  m_Archivo      LABEL "&Archivo"      
       SUB-MENU  m_Reportes     LABEL "&Reportes"     .


/* Definitions of handles for SmartObjects                              */
DEFINE VARIABLE h_b-articulos AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-conc-reqs AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-concpre AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-dtreqpen AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-itemconcpre AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-pend-prov AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-proveedores AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-provs-artic-ocm AS HANDLE NO-UNDO.
DEFINE VARIABLE h_folder AS HANDLE NO-UNDO.
DEFINE VARIABLE h_p-editar AS HANDLE NO-UNDO.
DEFINE VARIABLE h_p-updtxn AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-cant_concurso AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-concpre AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-nom_concurso AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-nom_concurso-2 AS HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 114.29 BY 21.19.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartWindow
   External Tables: sic.Concurso_precios
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
         TITLE              = "SIC/COM Rel 2.4 - Concursos de Precios"
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
ON END-ERROR OF W-Win /* SIC/COM Rel 2.4 - Concursos de Precios */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-CLOSE OF W-Win /* SIC/COM Rel 2.4 - Concursos de Precios */
DO:
  /* This ADM code must be left here in order for the SmartWindow
     and its descendents to terminate properly on exit. */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Hoja_de_Concurso
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Hoja_de_Concurso W-Win
ON CHOOSE OF MENU-ITEM m_Hoja_de_Concurso /* Hoja de Concurso */
DO:

  DEFINE VARIABLE que_concurso LIKE Concurso_precios.cdg_concurso.
  DEFINE VARIABLE existe       AS LOGICAL.
  DEFINE VARIABLE v-filtro     AS CHARACTER.
  
  existe = NO.
  REPEAT WHILE NOT existe:
         UPDATE que_concurso LABEL "Código de concurso"
                WITH FRAME a FONT 4 THREE-D SIDE-LABEL VIEW-AS DIALOG-BOX
                     TITLE "Indique concurso a imprimir".
         IF CAN-FIND(Concurso_precios WHERE Concurso_precios.cdg_concurso = que_concurso)
            THEN existe = YES.
  END.
  
  RUN exreport.p (  INPUT  ".\prl\sic.prl",
                    INPUT  "Concurso de Precios",
                    INPUT  "Concurso_precios.cdg_concurso = '" + que_concurso + "'", 
                /*  INPUT  "Concurso_precios.cdg_concurso = '1020'", */
                    INPUT  "D",
                    INPUT  "",
                    INPUT  ""
               ).   
           
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Salir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Salir W-Win
ON CHOOSE OF MENU-ITEM m_Salir /* Salir */
DO:
  &IF DEFINED (adm-panel) <> 0 &THEN
      RUN dispatch IN THIS-PROCEDURE ('exit').
  &ELSE
      APPLY "CLOSE":U TO THIS-PROCEDURE.
  &ENDIF
 
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
             INPUT  'adm/objects/folder.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'FOLDER-LABELS = ':U + 'Concursos|Items|Art.-Prov.|Pendientes' + ',
                     FOLDER-TAB-TYPE = 1':U ,
             OUTPUT h_folder ).
       RUN set-position IN h_folder ( 1.00 , 1.00 ) NO-ERROR.
       RUN set-size IN h_folder ( 20.46 , 113.00 ) NO-ERROR.

       /* Links to SmartFolder h_folder. */
       RUN add-link IN adm-broker-hdl ( h_folder , 'Page':U , THIS-PROCEDURE ).

    END. /* Page 0 */

    WHEN 1 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-concpre.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-concpre ).
       RUN set-position IN h_b-concpre ( 2.35 , 3.00 ) NO-ERROR.
       /* Size in UIB:  ( 15.35 , 43.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-concpre.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-concpre ).
       RUN set-position IN h_v-concpre ( 2.35 , 48.00 ) NO-ERROR.
       /* Size in UIB:  ( 15.35 , 64.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'p-updspa.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Edge-Pixels = 2,
                     SmartPanelType = Update-Trans,
                     AddFunction = One-Record':U ,
             OUTPUT h_p-updtxn ).
       RUN set-position IN h_p-updtxn ( 18.23 , 3.00 ) NO-ERROR.
       RUN set-size IN h_p-updtxn ( 2.15 , 109.00 ) NO-ERROR.

       /* Links to SmartViewer h_v-concpre. */
       RUN add-link IN adm-broker-hdl ( h_b-concpre , 'Record':U , h_v-concpre ).
       RUN add-link IN adm-broker-hdl ( h_p-updtxn , 'TableIO':U , h_v-concpre ).

    END. /* Page 1 */

    WHEN 2 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-nom_concurso.w':U ,
             INPUT  {&WINDOW-NAME} ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-nom_concurso ).
       RUN set-position IN h_v-nom_concurso ( 2.58 , 3.14 ) NO-ERROR.
       /* Size in UIB:  ( 1.35 , 61.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'p-editar.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Edge-Pixels = 2,
                     SmartPanelType = Update-Trans,
                     AddFunction = One-Record':U ,
             OUTPUT h_p-editar ).
       RUN set-position IN h_p-editar ( 2.35 , 69.00 ) NO-ERROR.
       RUN set-size IN h_p-editar ( 1.62 , 39.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-cant_concurso.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-cant_concurso ).
       RUN set-position IN h_v-cant_concurso ( 3.96 , 69.00 ) NO-ERROR.
       /* Size in UIB:  ( 1.35 , 39.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-itemconcpre.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-itemconcpre ).
       RUN set-position IN h_b-itemconcpre ( 4.50 , 3.00 ) NO-ERROR.
       /* Size in UIB:  ( 9.96 , 61.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-conc-reqs.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-conc-reqs ).
       RUN set-position IN h_b-conc-reqs ( 5.58 , 69.00 ) NO-ERROR.
       /* Size in UIB:  ( 9.04 , 39.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-dtreqpen.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-dtreqpen ).
       RUN set-position IN h_b-dtreqpen ( 15.00 , 3.00 ) NO-ERROR.
       /* Size in UIB:  ( 5.77 , 105.00 ) */

       /* Initialize other pages that this page requires. */
       RUN init-pages IN THIS-PROCEDURE ('1') NO-ERROR.

       /* Links to SmartViewer h_v-nom_concurso. */
       RUN add-link IN adm-broker-hdl ( h_b-concpre , 'Record':U , h_v-nom_concurso ).

       /* Links to SmartViewer h_v-cant_concurso. */
       RUN add-link IN adm-broker-hdl ( h_b-itemconcpre , 'Record':U , h_v-cant_concurso ).
       RUN add-link IN adm-broker-hdl ( h_p-editar , 'TableIO':U , h_v-cant_concurso ).

       /* Links to SmartBrowser h_b-itemconcpre. */
       RUN add-link IN adm-broker-hdl ( h_b-conc-reqs , 'State':U , h_b-itemconcpre ).
       RUN add-link IN adm-broker-hdl ( h_b-concpre , 'Record':U , h_b-itemconcpre ).
       RUN add-link IN adm-broker-hdl ( h_b-dtreqpen , 'Refrescar':U , h_b-itemconcpre ).

       /* Links to SmartBrowser h_b-conc-reqs. */
       RUN add-link IN adm-broker-hdl ( h_b-itemconcpre , 'Record':U , h_b-conc-reqs ).

       /* Links to SmartBrowser h_b-dtreqpen. */
       RUN add-link IN adm-broker-hdl ( h_b-concpre , 'Record':U , h_b-dtreqpen ).

    END. /* Page 2 */

    WHEN 3 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-articulos-compras.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-articulos ).
       RUN set-position IN h_b-articulos ( 2.62 , 3.00 ) NO-ERROR.
       /* Size in UIB:  ( 18.31 , 54.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-provs-artic-ocm.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-provs-artic-ocm ).
       RUN set-position IN h_b-provs-artic-ocm ( 2.62 , 59.00 ) NO-ERROR.
       /* Size in UIB:  ( 18.31 , 53.00 ) */

       /* Links to SmartBrowser h_b-provs-artic-ocm. */
       RUN add-link IN adm-broker-hdl ( h_b-articulos , 'Record':U , h_b-provs-artic-ocm ).

    END. /* Page 3 */

    WHEN 4 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-nom_concurso.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-nom_concurso-2 ).
       RUN set-position IN h_v-nom_concurso-2 ( 2.27 , 2.00 ) NO-ERROR.
       /* Size in UIB:  ( 1.35 , 61.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-proveedores.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-proveedores ).
       RUN set-position IN h_b-proveedores ( 3.96 , 2.00 ) NO-ERROR.
       /* Size in UIB:  ( 16.15 , 54.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-pend-prov.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-pend-prov ).
       RUN set-position IN h_b-pend-prov ( 3.96 , 57.00 ) NO-ERROR.
       /* Size in UIB:  ( 16.08 , 55.00 ) */

       /* Initialize other pages that this page requires. */
       RUN init-pages IN THIS-PROCEDURE ('1') NO-ERROR.

       /* Links to SmartViewer h_v-nom_concurso-2. */
       RUN add-link IN adm-broker-hdl ( h_b-concpre , 'Record':U , h_v-nom_concurso-2 ).

       /* Links to SmartBrowser h_b-proveedores. */
       RUN add-link IN adm-broker-hdl ( h_v-nom_concurso-2 , 'Record':U , h_b-proveedores ).

       /* Links to SmartBrowser h_b-pend-prov. */
       RUN add-link IN adm-broker-hdl ( h_b-proveedores , 'Record':U , h_b-pend-prov ).

       /* Adjust the tab order of the smart objects. */
    END. /* Page 4 */

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

  /* Create a list of all the tables that we need to get.            */
  {src/adm/template/row-list.i "Concurso_precios"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Concurso_precios"}

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

  {setwintit.i "SIC/COM" "Concursos de Precios"}

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

  /* Define variables needed by this internal procedure.               */
  {src/adm/template/snd-head.i}

  /* For each requested table, put it's ROWID in the output list.      */
  {src/adm/template/snd-list.i "Concurso_precios"}

  /* Deal with any unexpected table requests before closing.           */
  {src/adm/template/snd-end.i}

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


