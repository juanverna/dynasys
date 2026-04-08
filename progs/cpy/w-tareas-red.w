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

DEFINE VARIABLE txn_activa AS LOGICAL.
DEFINE VAR h_consor AS HANDLE.
DEFINE VAR h_admin AS HANDLE.
DEFINE VAR h_agenda_recurso AS HANDLE.
DEFINE VAR h_naseventos AS HANDLE.
DEFINE VAR temp_tarea AS CHAR INITIAL "v-temp_tarea1.w".
DEFINE VAR temp_tareaprinc AS CHAR INITIAL "v-temp_tarea1.w".

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
&Scoped-Define ENABLED-OBJECTS BUTTON-3 BUTTON-4 Bagenda_recurso bnasig 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR W-Win AS WIDGET-HANDLE NO-UNDO.

/* Menu Definitions                                                     */
DEFINE SUB-MENU m_Proyectos 
       MENU-ITEM m_Mantenimiento_de_Proyectos LABEL "&Mantenimiento de Proyectos"
       MENU-ITEM m_Clasificacion_de_Proyectos LABEL "&Clasificacion de Proyectos".

DEFINE SUB-MENU m_Recursos 
       MENU-ITEM m_Mantenimiento_de_Recursos LABEL "&Mantenimiento de Recursos".

DEFINE SUB-MENU m_Tipos 
       MENU-ITEM m_Mantenimiento_de_Tipos_de_T LABEL "&Mantenimiento de Tipos de Tareas".

DEFINE SUB-MENU m_Listados 
       MENU-ITEM m_Reporte_de_Tareas LABEL "&Reporte de Tareas"
              DISABLED
       MENU-ITEM m_Horas_por_Tarea LABEL "&Horas por Tarea"
       MENU-ITEM m_Ficha_de_Tarea LABEL "&Ficha de Tarea"
       RULE
       MENU-ITEM m_Actividades_por_Tarea LABEL "Actividades por Tarea"
       MENU-ITEM m_Parte_por_Recurso LABEL "Parte por Recurso".

DEFINE SUB-MENU m_Precios 
       MENU-ITEM m_Tipo-Precio  LABEL "Tipo-Precio"   
       MENU-ITEM m_Conformados  LABEL "Conformados"   .

DEFINE MENU MENU-BAR-W-Win MENUBAR
       SUB-MENU  m_Proyectos    LABEL "&Proyectos"    
       SUB-MENU  m_Recursos     LABEL "&Recursos"     
       SUB-MENU  m_Tipos        LABEL "&Tipos"        
       SUB-MENU  m_Listados     LABEL "&Listados"     
       SUB-MENU  m_Precios      LABEL "&Precios"      .


/* Definitions of handles for SmartObjects                              */
DEFINE VARIABLE h_b-tareas AS HANDLE NO-UNDO.
DEFINE VARIABLE h_folder AS HANDLE NO-UNDO.
DEFINE VARIABLE h_p-soloedita AS HANDLE NO-UNDO.
DEFINE VARIABLE h_p-updspa AS HANDLE NO-UNDO.
DEFINE VARIABLE h_q-cliente AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-tarea AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-tarea-red1 AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-tarea-redsolotel AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-temp_tarea1 AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-temp_tareaprinc AS HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON Bagenda_recurso 
     LABEL "Agenda" 
     SIZE 15 BY 1.14.

DEFINE BUTTON bnasig 
     LABEL "No realizados" 
     SIZE 15 BY 1.14.

DEFINE BUTTON BUTTON-3 
     LABEL "Consorcios" 
     SIZE 15 BY 1.14.

DEFINE BUTTON BUTTON-4 
     LABEL "Administracion" 
     SIZE 15 BY 1.14.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     BUTTON-3 AT ROW 1 COL 71 WIDGET-ID 2
     BUTTON-4 AT ROW 1 COL 87 WIDGET-ID 4
     Bagenda_recurso AT ROW 1 COL 103 WIDGET-ID 38
     bnasig AT ROW 1 COL 119 WIDGET-ID 40
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 202.2 BY 27.19.


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
         TITLE              = "Mantenimiento de Tareas"
         HEIGHT             = 26.91
         WIDTH              = 202.4
         MAX-HEIGHT         = 46.1
         MAX-WIDTH          = 336
         VIRTUAL-HEIGHT     = 46.1
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
   FRAME-NAME                                                           */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(W-Win)
THEN W-Win:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME F-Main
/* Query rebuild information for FRAME F-Main
     _Query            is NOT OPENED
*/  /* FRAME F-Main */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON END-ERROR OF W-Win /* Mantenimiento de Tareas */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-CLOSE OF W-Win /* Mantenimiento de Tareas */
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
ON WINDOW-MINIMIZED OF W-Win /* Mantenimiento de Tareas */
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


&Scoped-define SELF-NAME Bagenda_recurso
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bagenda_recurso W-Win
ON CHOOSE OF Bagenda_recurso IN FRAME F-Main /* Agenda */
DO:
  IF NOT VALID-HANDLE(h_agenda_recurso) THEN DO:
      RUN w-agenda_recurso.w PERSISTENT SET h_agenda_recurso.
      IF VALID-HANDLE(h_agenda_recurso) THEN
         RUN dispatch IN h_agenda_recurso ( INPUT 'initialize':U ) .
  END.
  ELSE DYNAMIC-FUNCTION("tope" IN h_agenda_recurso ). 
  
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bnasig
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bnasig W-Win
ON CHOOSE OF bnasig IN FRAME F-Main /* No realizados */
DO:
  IF NOT valid-handle(h_naseventos) THEN DO:
      RUN w-evento.w PERSISTENT SET h_naseventos ( TRUE,FALSE, "" , "" , 0 , 0 ,?, TODAY - 1).
      RUN dispatch IN h_naseventos ( INPUT 'initialize':U ) .
  END.
      ELSE DYNAMIC-FUNCTION("tope" IN h_naseventos ). 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-3 W-Win
ON CHOOSE OF BUTTON-3 IN FRAME F-Main /* Consorcios */
DO:

  IF NOT VALID-HANDLE(h_consor) THEN DO:
      RUN w-consorcios-cli.w PERSISTENT SET h_consor.
      IF VALID-HANDLE(h_consor) THEN DO:
        /* RUN add-link IN adm-broker-hdl ( h_q-cliente, "Record":U , h_consor ).*/
         RUN dispatch IN h_consor ( INPUT 'initialize':U ) .
      END.
  END.
  /*ELSE DYNAMIC-FUNCTION("tope" IN h_consor ). */
  
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-4 W-Win
ON CHOOSE OF BUTTON-4 IN FRAME F-Main /* Administracion */
DO:
  IF NOT VALID-HANDLE(h_admin) THEN DO:
      RUN w-administraciones.w PERSISTENT SET h_admin.
      IF VALID-HANDLE(h_admin) THEN
         RUN dispatch IN h_admin ( INPUT 'initialize':U ) .
  END.
  /*ELSE DYNAMIC-FUNCTION("tope" IN h_admin ). */
  
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Actividades_por_Tarea
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Actividades_por_Tarea W-Win
ON CHOOSE OF MENU-ITEM m_Actividades_por_Tarea /* Actividades por Tarea */
DO:
  RUN actividades_por_tarea  IN h_b-tareas.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Clasificacion_de_Proyectos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Clasificacion_de_Proyectos W-Win
ON CHOOSE OF MENU-ITEM m_Clasificacion_de_Proyectos /* Clasificacion de Proyectos */
DO:
    DEFINE VARIABLE v-que_clase  AS CHARACTER.
    DEFINE VARIABLE puso_ok      AS CHARACTER.

    RUN c-abmclaseproyecto.w ( OUTPUT v-que_clase, OUTPUT puso_ok).
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Conformados
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Conformados W-Win
ON CHOOSE OF MENU-ITEM m_Conformados /* Conformados */
DO:
  RUN w-dato-precio.w.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Ficha_de_Tarea
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Ficha_de_Tarea W-Win
ON CHOOSE OF MENU-ITEM m_Ficha_de_Tarea /* Ficha de Tarea */
DO:
  RUN ficha_tarea IN h_b-tareas.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Horas_por_Tarea
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Horas_por_Tarea W-Win
ON CHOOSE OF MENU-ITEM m_Horas_por_Tarea /* Horas por Tarea */
DO:
    RUN horas_x_tarea IN h_b-tareas.    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Mantenimiento_de_Proyectos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Mantenimiento_de_Proyectos W-Win
ON CHOOSE OF MENU-ITEM m_Mantenimiento_de_Proyectos /* Mantenimiento de Proyectos */
DO:
  DEFINE VARIABLE x-lista_proyectos AS CHARACTER.

  RUN w-proyectos.w.
  RUN refrescar_proyectos IN h_b-tareas ( OUTPUT x-lista_proyectos ).
  IF VALID-HANDLE(h_v-tarea) 
      THEN RUN inicia_proyectos IN h_v-tarea  ( INPUT  x-lista_proyectos ).
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Mantenimiento_de_Recursos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Mantenimiento_de_Recursos W-Win
ON CHOOSE OF MENU-ITEM m_Mantenimiento_de_Recursos /* Mantenimiento de Recursos */
DO:
    RUN w-recursos.w.
    IF VALID-HANDLE(h_b-tareas) THEN RUN refrescar_recursos IN h_b-tareas.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Mantenimiento_de_Tipos_de_T
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Mantenimiento_de_Tipos_de_T W-Win
ON CHOOSE OF MENU-ITEM m_Mantenimiento_de_Tipos_de_T /* Mantenimiento de Tipos de Tareas */
DO:
  RUN w-tipotareas.w.
  IF VALID-HANDLE(h_v-tarea)  THEN RUN inicia_tipotareas IN h_v-tarea.
  IF VALID-HANDLE(h_b-tareas) THEN RUN refrescar_tipotareas IN h_b-tareas.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Parte_por_Recurso
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Parte_por_Recurso W-Win
ON CHOOSE OF MENU-ITEM m_Parte_por_Recurso /* Parte por Recurso */
DO:
  RUN w-parte_recurso.w.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Reporte_de_Tareas
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Reporte_de_Tareas W-Win
ON CHOOSE OF MENU-ITEM m_Reporte_de_Tareas /* Reporte de Tareas */
DO:
    RUN imprimir_tareas IN h_b-tareas.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Tipo-Precio
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Tipo-Precio W-Win
ON CHOOSE OF MENU-ITEM m_Tipo-Precio /* Tipo-Precio */
DO:
  RUN w-tipo-precio.w.
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
             INPUT  'FOLDER-LABELS = ':U + 'Tareas|Detalle' + ',
                     FOLDER-TAB-TYPE = 2':U ,
             OUTPUT h_folder ).
       RUN set-position IN h_folder ( 1.00 , 1.00 ) NO-ERROR.
       RUN set-size IN h_folder ( 27.14 , 201.00 ) NO-ERROR.

       /* Links to SmartFolder h_folder. */
       RUN add-link IN adm-broker-hdl ( h_folder , 'Page':U , THIS-PROCEDURE ).

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_folder ,
             BUTTON-3:HANDLE IN FRAME F-Main , 'BEFORE':U ).
    END. /* Page 0 */
    WHEN 1 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-tareas-red.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ,
                     SortBy-Case = cdg_postal':U ,
             OUTPUT h_b-tareas ).
       RUN set-position IN h_b-tareas ( 2.57 , 2.20 ) NO-ERROR.
       RUN set-size IN h_b-tareas ( 14.71 , 199.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-temp_tarea1.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Key-Name = cdg_proyecto,
                     Layout = ':U ,
             OUTPUT h_v-temp_tareaprinc ).
       RUN set-position IN h_v-temp_tareaprinc ( 17.67 , 2.20 ) NO-ERROR.
       /* Size in UIB:  ( 10.00 , 150.60 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-tarea-redsolotel.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-tarea-redsolotel ).
       RUN set-position IN h_v-tarea-redsolotel ( 17.67 , 153.00 ) NO-ERROR.
       /* Size in UIB:  ( 8.57 , 47.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'p-soloedita.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Edge-Pixels = 2,
                     SmartPanelType = Update-Trans,
                     AddFunction = One-Record':U ,
             OUTPUT h_p-soloedita ).
       RUN set-position IN h_p-soloedita ( 26.43 , 152.60 ) NO-ERROR.
       RUN set-size IN h_p-soloedita ( 1.48 , 48.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'q-cliente.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Key-Name = nro_cliente':U ,
             OUTPUT h_q-cliente ).
       RUN set-position IN h_q-cliente ( 4.81 , 146.00 ) NO-ERROR.
       /* Size in UIB:  ( 1.86 , 10.80 ) */

       /* Initialize other pages that this page requires. */
       RUN init-pages IN THIS-PROCEDURE ('2':U) NO-ERROR.

       /* Links to SmartViewer h_v-temp_tareaprinc. */
       RUN add-link IN adm-broker-hdl ( h_b-tareas , 'Record':U , h_v-temp_tareaprinc ).
       RUN add-link IN adm-broker-hdl ( h_p-soloedita , 'TableIO':U , h_v-temp_tareaprinc ).

       /* Links to SmartViewer h_v-tarea-redsolotel. */
       RUN add-link IN adm-broker-hdl ( h_v-tarea , 'Record':U , h_v-tarea-redsolotel ).
       RUN add-link IN adm-broker-hdl ( h_v-temp_tareaprinc , 'group-assign':U , h_v-tarea-redsolotel ).

       /* Links to SmartQuery h_q-cliente. */
       RUN add-link IN adm-broker-hdl ( h_b-tareas , 'Record':U , h_q-cliente ).

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_b-tareas ,
             bnasig:HANDLE IN FRAME F-Main , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-temp_tareaprinc ,
             h_b-tareas , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-tarea-redsolotel ,
             h_v-temp_tareaprinc , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_p-soloedita ,
             h_v-tarea-redsolotel , 'AFTER':U ).
    END. /* Page 1 */
    WHEN 2 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-tarea-red2.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Initial-Lock = NO-LOCK,
                     Hide-on-Init = no,
                     Disable-on-Init = no,
                     Layout = ,
                     Create-On-Add = ?':U ,
             OUTPUT h_v-tarea ).
       RUN set-position IN h_v-tarea ( 2.86 , 7.20 ) NO-ERROR.
       /* Size in UIB:  ( 1.24 , 148.00 ) */

       RUN init-object IN THIS-PROCEDURE (
           &IF DEFINED(UIB_is_Running) ne 0 &THEN
             INPUT  'v-temp_tarea1.w':U ,
           &ELSE
             INPUT temp_tarea ,
           &ENDIF
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Initial-Lock = NO-LOCK,
                     Hide-on-Init = no,
                     Disable-on-Init = no,
                     Layout = ,
                     Create-On-Add = ?':U ,
             OUTPUT h_v-temp_tarea1 ).
       RUN set-position IN h_v-temp_tarea1 ( 4.81 , 7.00 ) NO-ERROR.
       /* Size in UIB:  ( 10.00 , 150.60 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-tarea-red11.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Initial-Lock = NO-LOCK,
                     Hide-on-Init = no,
                     Disable-on-Init = no,
                     Layout = ,
                     Create-On-Add = ?':U ,
             OUTPUT h_v-tarea-red1 ).
       RUN set-position IN h_v-tarea-red1 ( 16.00 , 8.00 ) NO-ERROR.
       /* Size in UIB:  ( 7.71 , 147.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'p-soloedita.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Edge-Pixels = 2,
                     SmartPanelType = Update-Trans,
                     AddFunction = One-Record':U ,
             OUTPUT h_p-updspa ).
       RUN set-position IN h_p-updspa ( 24.81 , 7.00 ) NO-ERROR.
       RUN set-size IN h_p-updspa ( 2.14 , 149.00 ) NO-ERROR.

       /* Initialize other pages that this page requires. */
       RUN init-pages IN THIS-PROCEDURE ('1':U) NO-ERROR.

       /* Links to SmartViewer h_v-tarea. */
       RUN add-link IN adm-broker-hdl ( h_b-tareas , 'Record':U , h_v-tarea ).
       RUN add-link IN adm-broker-hdl ( h_p-updspa , 'TableIO':U , h_v-tarea ).

       /* Links to SmartViewer h_v-temp_tarea1. */
       RUN add-link IN adm-broker-hdl ( h_v-tarea , 'group-assign':U , h_v-temp_tarea1 ).
       RUN add-link IN adm-broker-hdl ( h_v-tarea , 'Record':U , h_v-temp_tarea1 ).

       /* Links to SmartViewer h_v-tarea-red1. */
       RUN add-link IN adm-broker-hdl ( h_v-tarea , 'group-assign':U , h_v-tarea-red1 ).
       RUN add-link IN adm-broker-hdl ( h_v-tarea , 'Record':U , h_v-tarea-red1 ).

       /* Links to SmartPanel h_p-updspa. */
       RUN add-link IN adm-broker-hdl ( h_b-tareas , 'State':U , h_p-updspa ).

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-tarea ,
             bnasig:HANDLE IN FRAME F-Main , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-temp_tarea1 ,
             h_v-tarea , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-tarea-red1 ,
             h_v-temp_tarea1 , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_p-updspa ,
             h_v-tarea-red1 , 'AFTER':U ).
    END. /* Page 2 */

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
  ENABLE BUTTON-3 BUTTON-4 Bagenda_recurso bnasig 
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

  {setwintit.i "SIC/CPY" "Mantenimiento de Tareas"}


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
    ASSIGN
         MENU m_Proyectos:SENSITIVE = p-operacion = "HABILITAR" 
         MENU m_Recursos:SENSITIVE = p-operacion = "HABILITAR"
         MENU m_Tipos:SENSITIVE = p-operacion = "HABILITAR"
         MENU m_Listados:SENSITIVE = p-operacion = "HABILITAR".

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE template W-Win 
PROCEDURE template :
/*------------------------------------------------------------------------------
  Purpose: Cambia los templates de pedidos de datos segun el tipo de tarea en forma dinamica.    
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  DEFINE INPUT PARAMETER ptipo AS CHAR NO-UNDO.
  DEFINE VAR atemp_tarea AS CHAR NO-UNDO.
  DEFINE VARIABLE adm-current-page  AS INTEGER NO-UNDO.
  DEFINE VAR posrow AS decimal NO-UNDO.
  DEFINE VAR poscol AS DECIMAL NO-UNDO.
  DEFINE VAR hideoninit AS LOGICAL NO-UNDO.
  RUN get-attribute IN THIS-PROCEDURE ('Current-Page':U).
  
  IF INTEGER(RETURN-VALUE) <> 2 THEN RETURN.
  
  FIND tipo_tarea WHERE tipo_tarea.cdg_tipotarea = ptipo NO-LOCK NO-ERROR.

  IF AVAILABLE tipo_tarea THEN DO:
      IF tipo_tarea.pgm_abm <> "" AND tipo_tarea.pgm_abm <> ?  THEN
           atemp_tarea = tipo_tarea.pgm_abm.
      ELSE
           atemp_tarea = "v-temp_tarea1.w".
  END.
  ELSE atemp_tarea = "v-temp_tarea1.w".

  /*IF atemp_tarea = temp_tarea THEN RETURN.*/

  temp_tarea = atemp_tarea.

  posrow = 4.81.
  poscol = 2.00.
  RUN remove-link IN adm-broker-hdl ( h_v-tarea , 'group-assign':U , h_v-temp_tarea1 ).
  RUN remove-link IN adm-broker-hdl ( h_v-tarea , 'Record':U , h_v-temp_tarea1 ).
  RUN adm-destroy IN h_v-temp_tarea1.
  RUN init-object IN THIS-PROCEDURE (
             INPUT temp_tarea ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Initial-Lock = NO-LOCK,
                     Hide-on-Init = NO,
                     Disable-on-Init = no,
                     Layout = ,
                     Create-On-Add = ?':U ,
             OUTPUT h_v-temp_tarea1 ).

  RUN set-position IN h_v-temp_tarea1 ( posrow , poscol ) NO-ERROR.
  RUN add-link IN adm-broker-hdl ( h_v-tarea , 'group-assign':U , h_v-temp_tarea1 ).
  RUN add-link IN adm-broker-hdl ( h_v-tarea , 'Record':U , h_v-temp_tarea1 ).
  RUN adjust-tab-order IN adm-broker-hdl ( h_v-temp_tarea1 ,
         h_v-tarea , 'AFTER':U ).
  RUN adjust-tab-order IN adm-broker-hdl ( h_p-updspa ,
         h_v-temp_tarea1 , 'AFTER':U ).
  RUN dispatch IN h_v-temp_tarea1 ("initialize").
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE templateprinc W-Win 
PROCEDURE templateprinc :
/*------------------------------------------------------------------------------
  Purpose: Cambia los templates de pedidos de datos segun el tipo de tarea en forma dinamica.    
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  DEFINE INPUT PARAMETER ptipo AS CHAR NO-UNDO.
  DEFINE VAR atemp_tareaprinc AS CHAR NO-UNDO.
  DEFINE VARIABLE adm-current-page  AS INTEGER NO-UNDO.
  DEFINE VAR posrow AS decimal NO-UNDO.
  DEFINE VAR poscol AS DECIMAL NO-UNDO.
  
  RUN get-attribute IN THIS-PROCEDURE ('Current-Page':U).
  IF INTEGER(RETURN-VALUE) <> 1 THEN RETURN.

  FIND tipo_tarea WHERE tipo_tarea.cdg_tipotarea = ptipo NO-LOCK NO-ERROR.

  IF AVAILABLE tipo_tarea THEN DO:
      IF tipo_tarea.pgm_abm <> "" AND tipo_tarea.pgm_abm <> ?  THEN
           atemp_tareaprinc = tipo_tarea.pgm_abm.
      ELSE
           atemp_tareaprinc = "v-temp_tarea1.w".
  END.
  ELSE atemp_tareaprinc = "v-temp_tarea1.w".

  IF atemp_tareaprinc = temp_tareaprinc THEN RETURN.

  temp_tareaprinc = atemp_tareaprinc.

  posrow = 17.67.
  poscol = 2.2.
  RUN remove-link IN adm-broker-hdl (h_v-temp_tareaprinc , 'group-assign':U , h_v-tarea-redsolotel ).
  RUN remove-link IN adm-broker-hdl ( h_b-tareas , 'Record':U , h_v-temp_tareaprinc ).
  RUN remove-link IN adm-broker-hdl ( h_p-soloedita , 'TableIO':U , h_v-temp_tareaprinc ).
  RUN adm-destroy IN h_v-temp_tareaprinc.
  RUN init-object IN THIS-PROCEDURE (
             INPUT temp_tareaprinc ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Initial-Lock = NO-LOCK,
                     Hide-on-Init = no,
                     Disable-on-Init = no,
                     Layout = ,
                     Create-On-Add = ?':U ,
             OUTPUT h_v-temp_tareaprinc ).

  RUN set-position IN h_v-temp_tareaprinc ( posrow , poscol ) NO-ERROR.
  RUN add-link IN adm-broker-hdl ( h_b-tareas , 'Record':U , h_v-temp_tareaprinc ).
  RUN add-link IN adm-broker-hdl ( h_p-soloedita , 'TableIO':U , h_v-temp_tareaprinc ).
  RUN add-link IN adm-broker-hdl (h_v-temp_tareaprinc , 'group-assign':U , h_v-tarea-redsolotel ).
  RUN adjust-tab-order IN adm-broker-hdl ( h_v-temp_tareaprinc ,
         h_b-tareas , 'AFTER':U ).
  RUN dispatch IN h_v-temp_tareaprinc ("initialize").
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

