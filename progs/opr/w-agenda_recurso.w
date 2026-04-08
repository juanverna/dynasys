&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME W-Win


/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE t-Recurso NO-UNDO LIKE Recurso.



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



DEFINE VAR precursos AS CHAR NO-UNDO. 

DEFINE VAR h_agenda_recursos_det AS WIDGET-HANDLE.

DEFINE VAR h_geocli AS HANDLE NO-UNDO.

DEFINE VAR nrotipo AS CHAR NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartWindow
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER WINDOW

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME F-Main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-18 bAgenda BUTTON-11 blibre Bp1 Bp2 ~
BAnalisis BDia 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD cerrar W-Win 
FUNCTION cerrar RETURNS LOGICAL
  ( hh AS WIDGET-HANDLE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD nrotipo W-Win 
FUNCTION nrotipo RETURNS CHARACTER
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD setnrotipo W-Win 
FUNCTION setnrotipo RETURNS CHARACTER
  ( tipo AS CHAR )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD tope W-Win 
FUNCTION tope RETURNS LOGICAL
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR W-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of handles for SmartObjects                              */
DEFINE VARIABLE h_b-eventocli AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-eventos_analisis-2 AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-eventos_recursos AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-recurso AS HANDLE NO-UNDO.
DEFINE VARIABLE h_p-excel AS HANDLE NO-UNDO.
DEFINE VARIABLE h_p-excel-2 AS HANDLE NO-UNDO.
DEFINE VARIABLE h_p-soloedita AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-agenda_dia AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-capacidad AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-evento-2 AS HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bAgenda 
     LABEL "Detalle" 
     SIZE 7.2 BY 1.29.

DEFINE BUTTON BAnalisis 
     LABEL "ANL" 
     SIZE 5.4 BY 1.14 TOOLTIP "Analisis de los Eventos teoricos vs realidad".

DEFINE BUTTON BDia 
     LABEL "DIA" 
     SIZE 5.4 BY 1.14 TOOLTIP "Analisis de los Eventos teoricos vs realidad".

DEFINE BUTTON blibre 
     LABEL "Libre" 
     SIZE 8 BY 1.14.

DEFINE BUTTON Bp1 
     LABEL "EV" 
     SIZE 5.4 BY 1.14 TOOLTIP "Evento detalle del evento".

DEFINE BUTTON Bp2 
     LABEL "HIS" 
     SIZE 5.4 BY 1.14 TOOLTIP "Historia de los eventos del cliente".

DEFINE BUTTON BUTTON-11 
     IMAGE-UP FILE "C:/Dynasys10/progs/img/earth_location.jpg":U
     LABEL "b-geocli" 
     SIZE 5 BY 1.29.

DEFINE RECTANGLE RECT-18
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 27 BY 1.67.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     bAgenda AT ROW 9.29 COL 3.8 WIDGET-ID 2
     BUTTON-11 AT ROW 9.29 COL 21.8 WIDGET-ID 36
     blibre AT ROW 9.33 COL 12.6 WIDGET-ID 48
     Bp1 AT ROW 11.48 COL 146 WIDGET-ID 40
     Bp2 AT ROW 12.67 COL 146 WIDGET-ID 42
     BAnalisis AT ROW 13.86 COL 146 WIDGET-ID 44
     BDia AT ROW 15.05 COL 146 WIDGET-ID 46
     RECT-18 AT ROW 9.05 COL 1.8 WIDGET-ID 38
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 152.6 BY 30.38.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartWindow
   Allow: Basic,Browse,DB-Fields,Query,Smart,Window
   Design Page: 3
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: t-Recurso T "?" NO-UNDO sic Recurso
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW W-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Agenda de los Recursos"
         HEIGHT             = 29
         WIDTH              = 152.6
         MAX-HEIGHT         = 49.1
         MAX-WIDTH          = 336
         VIRTUAL-HEIGHT     = 49.1
         VIRTUAL-WIDTH      = 336
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
ASSIGN 
       BDia:HIDDEN IN FRAME F-Main           = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(W-Win)
THEN W-Win:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON END-ERROR OF W-Win /* Agenda de los Recursos */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-CLOSE OF W-Win /* Agenda de los Recursos */
DO:
    /* Modificado para que el control retorne a la window padre al cerrar una windows hija */
    DEFINE VARIABLE h_parent AS HANDLE      NO-UNDO.
    h_parent = THIS-PROCEDURE:CURRENT-WINDOW:PARENT.
    IF VALID-HANDLE(h_parent) THEN DO:
        CURRENT-WINDOW = h_parent.
        APPLY 'ENTRY' TO h_parent.
    END.
    cerrar(h_agenda_recursos_det).
    APPLY "CLOSE":U TO THIS-PROCEDURE.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bAgenda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bAgenda W-Win
ON CHOOSE OF bAgenda IN FRAME F-Main /* Detalle */
DO:
  DEFINE VAR lista AS CHAR NO-UNDO.
  RUN seleccionados IN h_b-recurso( OUTPUT lista ).
  IF NOT valid-handle(h_agenda_recursos_det) THEN DO:
      RUN w-agenda_recurso_detdia.w PERSISTENT SET h_agenda_recursos_det ( lista ,
                               date(entry(1,DYNAMIC-FUNCTION( "diassel" IN h_v-capacidad )))).
      RUN dispatch IN h_agenda_recursos_det ( INPUT 'initialize':U ) .
  END.
       ELSE DYNAMIC-FUNCTION("tope" IN h_agenda_recursos_det ). 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BAnalisis
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BAnalisis W-Win
ON CHOOSE OF BAnalisis IN FRAME F-Main /* ANL */
DO:
      RUN select-Page IN THIS-PROCEDURE (3).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BDia
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BDia W-Win
ON CHOOSE OF BDia IN FRAME F-Main /* DIA */
DO:
      RUN select-Page IN THIS-PROCEDURE (4).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME blibre
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL blibre W-Win
ON CHOOSE OF blibre IN FRAME F-Main /* Libre */
DO:
  DEFINE VAR lista AS CHAR NO-UNDO.
  RUN seleccionados IN h_b-recurso( OUTPUT lista ).
  RUN dlibre.w ( lista , DYNAMIC-FUNCTION( "diassel" IN h_v-capacidad )).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bp1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bp1 W-Win
ON CHOOSE OF Bp1 IN FRAME F-Main /* EV */
DO:
  RUN select-Page IN THIS-PROCEDURE (1).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bp2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bp2 W-Win
ON CHOOSE OF Bp2 IN FRAME F-Main /* HIS */
DO:
    RUN select-Page IN THIS-PROCEDURE (2).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-11
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-11 W-Win
ON CHOOSE OF BUTTON-11 IN FRAME F-Main /* b-geocli */
DO:
  DEFINE VAR lista AS CHAR NO-UNDO.
  RUN seleccionados IN h_b-recurso( OUTPUT lista ).
  IF NOT VALID-HANDLE( h_geocli ) THEN DO:
      RUN w-geodia.w PERSISTENT SET h_geocli ( lista   , DYNAMIC-FUNCTION("diassel" IN h_v-capacidad ) ).
      RUN dispatch IN h_geocli ( INPUT 'initialize':U ) .
  END.
    ELSE do: 
        DYNAMIC-FUNCTION( "muestradia"  IN h_geocli,  lista   , DYNAMIC-FUNCTION( "diassel" IN h_v-capacidad ) ). 
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
             INPUT  'opr/b-recurso.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-recurso ).
       RUN set-position IN h_b-recurso ( 1.00 , 2.00 ) NO-ERROR.
       RUN set-size IN h_b-recurso ( 7.86 , 40.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-agenda_recurso.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Initial-Lock = NO-LOCK,
                     Hide-on-Init = no,
                     Disable-on-Init = no,
                     Layout = ,
                     Create-On-Add = ?':U ,
             OUTPUT h_v-capacidad ).
       RUN set-position IN h_v-capacidad ( 1.24 , 44.00 ) NO-ERROR.
       /* Size in UIB:  ( 9.95 , 109.40 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'p-excel.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  '':U ,
             OUTPUT h_p-excel ).
       RUN set-position IN h_p-excel ( 8.95 , 30.20 ) NO-ERROR.
       RUN set-size IN h_p-excel ( 1.76 , 11.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'opr/b-eventos_recursos.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Initial-Lock = NO-LOCK,
                     Hide-on-Init = no,
                     Disable-on-Init = no,
                     Key-Name = ,
                     Layout = ,
                     Create-On-Add = ?,
                     SortBy-Case = FAsignado':U ,
             OUTPUT h_b-eventos_recursos ).
       RUN set-position IN h_b-eventos_recursos ( 11.38 , 1.00 ) NO-ERROR.
       RUN set-size IN h_b-eventos_recursos ( 7.48 , 143.00 ) NO-ERROR.

       /* Links to SmartViewer h_v-capacidad. */
       RUN add-link IN adm-broker-hdl ( h_b-recurso , 'Record':U , h_v-capacidad ).
       RUN add-link IN adm-broker-hdl ( h_b-recurso , 'recursos':U , h_v-capacidad ).

       /* Links to SmartBrowser h_b-eventos_recursos. */
       RUN add-link IN adm-broker-hdl ( h_p-excel , 'excel':U , h_b-eventos_recursos ).
       RUN add-link IN adm-broker-hdl ( h_v-capacidad , 'Record':U , h_b-eventos_recursos ).

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_b-recurso ,
             bAgenda:HANDLE IN FRAME F-Main , 'BEFORE':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-capacidad ,
             h_b-recurso , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_p-excel ,
             h_v-capacidad , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_b-eventos_recursos ,
             blibre:HANDLE IN FRAME F-Main , 'AFTER':U ).
    END. /* Page 0 */
    WHEN 1 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-evento.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-evento-2 ).
       RUN set-position IN h_v-evento-2 ( 19.05 , 1.00 ) NO-ERROR.
       /* Size in UIB:  ( 10.67 , 143.40 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'p-soloedita.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Edge-Pixels = 2,
                     SmartPanelType = Update-Trans,
                     AddFunction = One-Record':U ,
             OUTPUT h_p-soloedita ).
       RUN set-position IN h_p-soloedita ( 19.24 , 146.00 ) NO-ERROR.
       RUN set-size IN h_p-soloedita ( 10.71 , 7.40 ) NO-ERROR.

       /* Links to SmartViewer h_v-evento-2. */
       RUN add-link IN adm-broker-hdl ( h_b-eventos_recursos , 'Record':U , h_v-evento-2 ).
       RUN add-link IN adm-broker-hdl ( h_p-soloedita , 'TableIO':U , h_v-evento-2 ).

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-evento-2 ,
             BDia:HANDLE IN FRAME F-Main , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_p-soloedita ,
             h_v-evento-2 , 'AFTER':U ).
    END. /* Page 1 */
    WHEN 2 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-eventocli.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-eventocli ).
       RUN set-position IN h_b-eventocli ( 19.00 , 1.00 ) NO-ERROR.
       RUN set-size IN h_b-eventocli ( 9.76 , 150.00 ) NO-ERROR.

       /* Links to SmartBrowser h_b-eventocli. */
       RUN add-link IN adm-broker-hdl ( h_b-eventos_recursos , 'Record':U , h_b-eventocli ).

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_b-eventocli ,
             BDia:HANDLE IN FRAME F-Main , 'AFTER':U ).
    END. /* Page 2 */
    WHEN 3 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-eventos_analisis.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-eventos_analisis-2 ).
       RUN set-position IN h_b-eventos_analisis-2 ( 19.05 , 1.00 ) NO-ERROR.
       RUN set-size IN h_b-eventos_analisis-2 ( 10.00 , 138.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'p-excel.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  '':U ,
             OUTPUT h_p-excel-2 ).
       RUN set-position IN h_p-excel-2 ( 20.52 , 141.00 ) NO-ERROR.
       RUN set-size IN h_p-excel-2 ( 1.76 , 11.00 ) NO-ERROR.

       /* Links to SmartBrowser h_b-eventos_analisis-2. */
       RUN add-link IN adm-broker-hdl ( h_b-recurso , 'recursos':U , h_b-eventos_analisis-2 ).
       RUN add-link IN adm-broker-hdl ( h_p-excel-2 , 'excel':U , h_b-eventos_analisis-2 ).
       RUN add-link IN adm-broker-hdl ( h_v-capacidad , 'Record':U , h_b-eventos_analisis-2 ).

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_b-eventos_analisis-2 ,
             BDia:HANDLE IN FRAME F-Main , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_p-excel-2 ,
             h_b-eventos_analisis-2 , 'AFTER':U ).
    END. /* Page 3 */
    WHEN 4 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-agenda_dia.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-agenda_dia ).
       RUN set-position IN h_v-agenda_dia ( 11.19 , 1.00 ) NO-ERROR.
       /* Size in UIB:  ( 15.95 , 143.00 ) */

       /* Links to SmartViewer h_v-agenda_dia. */
       RUN add-link IN adm-broker-hdl ( h_v-capacidad , 'Record':U , h_v-agenda_dia ).

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-agenda_dia ,
             blibre:HANDLE IN FRAME F-Main , 'AFTER':U ).
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
  ENABLE RECT-18 bAgenda BUTTON-11 blibre Bp1 Bp2 BAnalisis BDia 
      WITH FRAME F-Main IN WINDOW W-Win.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize W-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .
  RUN SET_recursos IN h_b-recurso ( IF precursos <> "" THEN precursos ELSE "*" ).
  w-win:WINDOW-STATE = 3.
  w-win:MOVE-TO-TOP().

  /* Code placed here will execute AFTER standard behavior.    */


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-row-available W-Win 
PROCEDURE local-row-available :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
  DEFINE VAR lista AS CHAR NO-UNDO.
  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'row-available':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
  RUN seleccionados IN h_b-recurso( OUTPUT lista ).
  IF VALID-HANDLE( h_geocli ) THEN DO:
        DYNAMIC-FUNCTION( "tope" IN h_geocli ). 
        DYNAMIC-FUNCTION( "muestradia"  IN h_geocli,  lista   , DYNAMIC-FUNCTION( "ahora" IN h_v-capacidad ) ). 
    END.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE set-estado-folders W-Win 
PROCEDURE set-estado-folders :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    DEFINE INPUT PARAMETER p-operacion AS CHARACTER.
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

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION cerrar W-Win 
FUNCTION cerrar RETURNS LOGICAL
  ( hh AS WIDGET-HANDLE ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
IF VALID-HANDLE(hh) THEN   do:
    RUN dispatch IN hh ( INPUT 'destroy':U ) . 
    RETURN TRUE.
END.
ELSE RETURN FALSE.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION nrotipo W-Win 
FUNCTION nrotipo RETURNS CHARACTER
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

  RETURN "*".   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION setnrotipo W-Win 
FUNCTION setnrotipo RETURNS CHARACTER
  ( tipo AS CHAR ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
  nrotipo = tipo.
  RETURN nrotipo.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION tope W-Win 
FUNCTION tope RETURNS LOGICAL
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
    /*w-win:WINDOW-STATE = 3.*/
{&WINDOW-NAME}:HANDLE:WINDOW-STATE = 3.
    {&WINDOW-NAME}:HANDLE:MOVE-TO-TOP().
    RETURN TRUE.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

