&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI ADM2
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME wWin
{adecomm/appserv.i}
DEFINE VARIABLE h_dwserver                 AS HANDLE          NO-UNDO.
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wWin 
/*------------------------------------------------------------------------

  File: 

  Description: from cntnrwin.w - ADM SmartWindow Template

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  History: New V9 Version - January 15, 1998
          
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AB.              */
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

{src/adm2/widgetprto.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartWindow
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER WINDOW

&Scoped-define ADM-SUPPORTED-LINKS Data-Target,Data-Source,Page-Target,Update-Source,Update-Target,Filter-target,Filter-Source

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fMain

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS btParaPredef 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wWin AS WIDGET-HANDLE NO-UNDO.

/* Definitions of handles for SmartObjects                              */
DEFINE VARIABLE h_brepschcampo AS HANDLE NO-UNDO.
DEFINE VARIABLE h_brepschtabla AS HANDLE NO-UNDO.
DEFINE VARIABLE h_drepschcampo AS HANDLE NO-UNDO.
DEFINE VARIABLE h_drepschtabla AS HANDLE NO-UNDO.
DEFINE VARIABLE h_dyntoolbar AS HANDLE NO-UNDO.
DEFINE VARIABLE h_dyntoolbar-2 AS HANDLE NO-UNDO.
DEFINE VARIABLE h_vrepschcampo AS HANDLE NO-UNDO.
DEFINE VARIABLE h_vrepschtabla AS HANDLE NO-UNDO.
DEFINE VARIABLE h_wreppardef AS HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btParaPredef 
     LABEL "Parametros Predefinidos" 
     SIZE 25 BY 1.14.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fMain
     btParaPredef AT ROW 1.24 COL 37 WIDGET-ID 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 136.6 BY 25.14 WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartWindow
   Allow: Basic,Browse,DB-Fields,Query,Smart,Window
   Container Links: Data-Target,Data-Source,Page-Target,Update-Source,Update-Target,Filter-target,Filter-Source
   Design Page: 1
   Other Settings: APPSERVER
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW wWin ASSIGN
         HIDDEN             = YES
         TITLE              = "Configuracion de Reportes"
         HEIGHT             = 25.14
         WIDTH              = 136.6
         MAX-HEIGHT         = 28.81
         MAX-WIDTH          = 149.6
         VIRTUAL-HEIGHT     = 28.81
         VIRTUAL-WIDTH      = 149.6
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB wWin 
/* ************************* Included-Libraries *********************** */

{src/adm2/containr.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW wWin
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fMain
   FRAME-NAME                                                           */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wWin)
THEN wWin:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wWin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON END-ERROR OF wWin /* Configuracion de Reportes */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON WINDOW-CLOSE OF wWin /* Configuracion de Reportes */
DO:
  /* This ADM code must be left here in order for the SmartWindow
     and its descendents to terminate properly on exit. */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btParaPredef
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btParaPredef wWin
ON CHOOSE OF btParaPredef IN FRAME fMain /* Parametros Predefinidos */
DO:
  RUN selectpage(1).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wWin 


/* ***************************  Main Block  *************************** */

/* Include custom  Main Block code for SmartWindows. */
{src/adm2/windowmn.i}
{smodef.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-create-objects wWin  _ADM-CREATE-OBJECTS
PROCEDURE adm-create-objects :
/*------------------------------------------------------------------------------
  Purpose:     Create handles for all SmartObjects used in this procedure.
               After SmartObjects are initialized, then SmartLinks are added.
  Parameters:  <none>
------------------------------------------------------------------------------*/
  DEFINE VARIABLE currentPage  AS INTEGER NO-UNDO.

  ASSIGN currentPage = getCurrentPage().

  CASE currentPage: 

    WHEN 0 THEN DO:
       RUN constructObject (
             INPUT  'drepschtabla.wDB-AWARE':U ,
             INPUT  FRAME fMain:HANDLE ,
             INPUT  'AppServicedwserverASInfoASUsePrompt?CacheDuration0CheckCurrentChangedyesDestroyStatelessyesDisconnectAppServernoServerOperatingModeNONEShareDatanoUpdateFromSourcenoForeignFieldsObjectNamedrepschtablaOpenOnInityesPromptColumns(NONE)PromptOnDeleteyesRowsToBatch200RebuildOnReposnoToggleDataTargetsyes':U ,
             OUTPUT h_drepschtabla ).
       RUN repositionObject IN h_drepschtabla ( 1.24 , 86.00 ) NO-ERROR.
       /* Size in AB:  ( 2.38 , 14.80 ) */

       RUN constructObject (
             INPUT  'mfvsys/reporte/admin/brepschtabla.w':U ,
             INPUT  FRAME fMain:HANDLE ,
             INPUT  'ScrollRemotenoNumDown0CalcWidthnoMaxWidth80FetchOnReposToEndyesUseSortIndicatoryesSearchFieldDataSourceNames?UpdateTargetNames?LogicalObjectNameHideOnInitnoDisableOnInitnoObjectLayout':U ,
             OUTPUT h_brepschtabla ).
       RUN repositionObject IN h_brepschtabla ( 1.24 , 2.00 ) NO-ERROR.
       RUN resizeObject IN h_brepschtabla ( 10.48 , 34.00 ) NO-ERROR.

       RUN constructObject (
             INPUT  'mfvsys/reporte/admin/vrepschtabla.w':U ,
             INPUT  FRAME fMain:HANDLE ,
             INPUT  'EnabledObjFldsToDisable?ModifyFields(All)DataSourceNamesUpdateTargetNamesLogicalObjectNameLogicalObjectNamePhysicalObjectNameDynamicObjectnoRunAttributeHideOnInitnoDisableOnInitnoObjectLayout':U ,
             OUTPUT h_vrepschtabla ).
       RUN repositionObject IN h_vrepschtabla ( 4.10 , 37.00 ) NO-ERROR.
       /* Size in AB:  ( 5.71 , 89.00 ) */

       RUN constructObject (
             INPUT  'drepschcampo.wDB-AWARE':U ,
             INPUT  FRAME fMain:HANDLE ,
             INPUT  'AppServicedwserverASInfoASUsePrompt?CacheDuration0CheckCurrentChangedyesDestroyStatelessyesDisconnectAppServernoServerOperatingModeNONEShareDatanoUpdateFromSourcenoForeignFieldsReporteSchCampo.Tabla,TablaObjectNamedrepschcampoOpenOnInityesPromptColumns(NONE)PromptOnDeleteyesRowsToBatch200RebuildOnReposnoToggleDataTargetsyes':U ,
             OUTPUT h_drepschcampo ).
       RUN repositionObject IN h_drepschcampo ( 9.57 , 87.00 ) NO-ERROR.
       /* Size in AB:  ( 2.86 , 17.00 ) */

       RUN constructObject (
             INPUT  'mfvsys/reporte/admin/brepschcampo.w':U ,
             INPUT  FRAME fMain:HANDLE ,
             INPUT  'ScrollRemotenoNumDown0CalcWidthnoMaxWidth80FetchOnReposToEndyesUseSortIndicatoryesSearchFieldDataSourceNames?UpdateTargetNames?LogicalObjectNameHideOnInitnoDisableOnInitnoObjectLayout':U ,
             OUTPUT h_brepschcampo ).
       RUN repositionObject IN h_brepschcampo ( 11.95 , 2.00 ) NO-ERROR.
       RUN resizeObject IN h_brepschcampo ( 13.81 , 51.00 ) NO-ERROR.

       RUN constructObject (
             INPUT  'mfvsys/reporte/admin/vrepschcampo.w':U ,
             INPUT  FRAME fMain:HANDLE ,
             INPUT  'EnabledObjFldsToDisable?ModifyFields(All)DataSourceNamesUpdateTargetNamesLogicalObjectNameLogicalObjectNamePhysicalObjectNameDynamicObjectnoRunAttributeHideOnInitnoDisableOnInitnoObjectLayout':U ,
             OUTPUT h_vrepschcampo ).
       RUN repositionObject IN h_vrepschcampo ( 13.38 , 55.00 ) NO-ERROR.
       /* Size in AB:  ( 12.62 , 82.00 ) */

       RUN constructObject (
             INPUT  'adm2/dyntoolbar.w':U ,
             INPUT  FRAME fMain:HANDLE ,
             INPUT  'EdgePixels2DeactivateTargetOnHidenoDisabledActionsFlatButtonsyesMenunoShowBorderyesToolbaryesActionGroupsTableio,NavigationTableIOTypeUpdateSupportedLinksNavigation-source,Tableio-sourceToolbarBandsToolbarAutoSizenoToolbarDrawDirectionHorizontalLogicalObjectNameDisabledActionsHiddenActionsResetHiddenToolbarBandsHiddenMenuBandsMenuMergeOrder0RemoveMenuOnHidenoCreateSubMenuOnConflictyesNavigationTargetNameHideOnInitnoDisableOnInitnoObjectLayout':U ,
             OUTPUT h_dyntoolbar ).
       RUN repositionObject IN h_dyntoolbar ( 2.57 , 36.80 ) NO-ERROR.
       RUN resizeObject IN h_dyntoolbar ( 1.24 , 89.00 ) NO-ERROR.

       RUN constructObject (
             INPUT  'adm2/dyntoolbar.w':U ,
             INPUT  FRAME fMain:HANDLE ,
             INPUT  'EdgePixels2DeactivateTargetOnHidenoDisabledActionsFlatButtonsyesMenunoShowBorderyesToolbaryesActionGroupsTableio,NavigationTableIOTypeUpdateSupportedLinksNavigation-source,Tableio-sourceToolbarBandsToolbarAutoSizenoToolbarDrawDirectionHorizontalLogicalObjectNameDisabledActionsHiddenActionsResetHiddenToolbarBandsHiddenMenuBandsMenuMergeOrder0RemoveMenuOnHidenoCreateSubMenuOnConflictyesNavigationTargetNameHideOnInitnoDisableOnInitnoObjectLayout':U ,
             OUTPUT h_dyntoolbar-2 ).
       RUN repositionObject IN h_dyntoolbar-2 ( 11.95 , 55.00 ) NO-ERROR.
       RUN resizeObject IN h_dyntoolbar-2 ( 1.24 , 82.00 ) NO-ERROR.

       /* Links to SmartDataObject h_drepschtabla. */
       RUN addLink ( h_dyntoolbar , 'Navigation':U , h_drepschtabla ).

       /* Links to SmartDataBrowser h_brepschtabla. */
       RUN addLink ( h_drepschtabla , 'Data':U , h_brepschtabla ).

       /* Links to SmartDataViewer h_vrepschtabla. */
       RUN addLink ( h_drepschtabla , 'Data':U , h_vrepschtabla ).
       RUN addLink ( h_vrepschtabla , 'Update':U , h_drepschtabla ).
       RUN addLink ( h_dyntoolbar , 'TableIo':U , h_vrepschtabla ).

       /* Links to SmartDataObject h_drepschcampo. */
       RUN addLink ( h_drepschtabla , 'Data':U , h_drepschcampo ).
       RUN addLink ( h_dyntoolbar-2 , 'Navigation':U , h_drepschcampo ).

       /* Links to SmartDataBrowser h_brepschcampo. */
       RUN addLink ( h_drepschcampo , 'Data':U , h_brepschcampo ).

       /* Links to SmartDataViewer h_vrepschcampo. */
       RUN addLink ( h_drepschcampo , 'Data':U , h_vrepschcampo ).
       RUN addLink ( h_vrepschcampo , 'Update':U , h_drepschcampo ).
       RUN addLink ( h_dyntoolbar-2 , 'TableIo':U , h_vrepschcampo ).

       /* Adjust the tab order of the smart objects. */
       RUN adjustTabOrder ( h_brepschtabla ,
             btParaPredef:HANDLE IN FRAME fMain , 'BEFORE':U ).
       RUN adjustTabOrder ( h_dyntoolbar ,
             btParaPredef:HANDLE IN FRAME fMain , 'AFTER':U ).
       RUN adjustTabOrder ( h_vrepschtabla ,
             h_dyntoolbar , 'AFTER':U ).
       RUN adjustTabOrder ( h_brepschcampo ,
             h_vrepschtabla , 'AFTER':U ).
       RUN adjustTabOrder ( h_dyntoolbar-2 ,
             h_brepschcampo , 'AFTER':U ).
       RUN adjustTabOrder ( h_vrepschcampo ,
             h_dyntoolbar-2 , 'AFTER':U ).
    END. /* Page 0 */
    WHEN 1 THEN DO:
       RUN constructObject (
             INPUT  'mfvsys/reporte/admin/wreppardef.w':U ,
             INPUT  {&WINDOW-NAME} ,
             INPUT  'LogicalObjectNamePhysicalObjectNameDynamicObjectnoRunAttributeHideOnInitnoDisableOnInitnoObjectLayout':U ,
             OUTPUT h_wreppardef ).
       /* Position in AB:  ( 1.24 , 105.00 ) */
       /* Size in AB:  ( 1.86 , 10.80 ) */

       /* Adjust the tab order of the smart objects. */
    END. /* Page 1 */

  END CASE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI wWin  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wWin)
  THEN DELETE WIDGET wWin.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI wWin  _DEFAULT-ENABLE
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
  ENABLE btParaPredef 
      WITH FRAME fMain IN WINDOW wWin.
  {&OPEN-BROWSERS-IN-QUERY-fMain}
  VIEW wWin.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE exitObject wWin 
PROCEDURE exitObject :
/*------------------------------------------------------------------------------
  Purpose:  Window-specific override of this procedure which destroys 
            its contents and itself.
    Notes:  
------------------------------------------------------------------------------*/

  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

