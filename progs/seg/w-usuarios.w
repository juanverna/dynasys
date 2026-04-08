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
DEFINE SUB-MENU m_Listados 
       MENU-ITEM m_Funciones_por_Usuario LABEL "&Funciones por Usuario".

DEFINE MENU MENU-BAR-W-Win MENUBAR
       MENU-ITEM m_Archivo      LABEL "&Archivo"      
       SUB-MENU  m_Listados     LABEL "&Listados"     .


/* Definitions of handles for SmartObjects                              */
DEFINE VARIABLE h_b-autorizacion_usuarios AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-funciones_usuario AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-hst_claves AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-sesiones_del_usuario AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-uso_de_menues AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-usuarios AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-usuario_empresa AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-usuario_empresa-2 AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-usuario_programa AS HANDLE NO-UNDO.
DEFINE VARIABLE h_folder AS HANDLE NO-UNDO.
DEFINE VARIABLE h_p-updsav AS HANDLE NO-UNDO.
DEFINE VARIABLE h_p-updspa-2 AS HANDLE NO-UNDO.
DEFINE VARIABLE h_p-updspa-3 AS HANDLE NO-UNDO.
DEFINE VARIABLE h_p-updspa-4 AS HANDLE NO-UNDO.
DEFINE VARIABLE h_p-updspaM AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-autorizacion_usuarios AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-dsc_usuario AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-dsc_usuario-2 AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-dsc_usuario-3 AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-dsc_usuario-4 AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-funcion_usuario AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-textoempresas AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-user_empresa AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-usuario AS HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 158 BY 26.29.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartWindow
   External Tables: sic.Cliente
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
         TITLE              = "Mantenimiento de Usuarios"
         HEIGHT             = 26.29
         WIDTH              = 158
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
ON END-ERROR OF W-Win /* Mantenimiento de Usuarios */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-CLOSE OF W-Win /* Mantenimiento de Usuarios */
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
ON WINDOW-MINIMIZED OF W-Win /* Mantenimiento de Usuarios */
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


&Scoped-define SELF-NAME m_Funciones_por_Usuario
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Funciones_por_Usuario W-Win
ON CHOOSE OF MENU-ITEM m_Funciones_por_Usuario /* Funciones por Usuario */
DO:
  RUN listar_funciones_seguridad.p.
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
             INPUT  'b-usuarios.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-usuarios ).
       RUN set-position IN h_b-usuarios ( 1.00 , 3.00 ) NO-ERROR.
       RUN set-size IN h_b-usuarios ( 24.76 , 15.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'adm/objects/folder.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'FOLDER-LABELS = ':U + 'Datos|Funciones|Logs Menues|Sesiones|Transacciones|Autorizacione' + ',
                     FOLDER-TAB-TYPE = 1':U ,
             OUTPUT h_folder ).
       RUN set-position IN h_folder ( 1.24 , 20.00 ) NO-ERROR.
       RUN set-size IN h_folder ( 24.52 , 134.00 ) NO-ERROR.

       /* Links to SmartFolder h_folder. */
       RUN add-link IN adm-broker-hdl ( h_folder , 'Page':U , THIS-PROCEDURE ).

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_folder ,
             h_b-usuarios , 'AFTER':U ).
    END. /* Page 0 */
    WHEN 1 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-usuario.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-usuario ).
       RUN set-position IN h_v-usuario ( 3.38 , 27.00 ) NO-ERROR.
       /* Size in UIB:  ( 13.10 , 122.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'p-updspa.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Edge-Pixels = 2,
                     SmartPanelType = Update-Trans,
                     AddFunction = One-Record':U ,
             OUTPUT h_p-updspaM ).
       RUN set-position IN h_p-updspaM ( 16.95 , 27.00 ) NO-ERROR.
       RUN set-size IN h_p-updspaM ( 2.38 , 123.00 ) NO-ERROR.

       /* Links to SmartViewer h_v-usuario. */
       RUN add-link IN adm-broker-hdl ( h_b-usuarios , 'Record':U , h_v-usuario ).
       RUN add-link IN adm-broker-hdl ( h_p-updspaM , 'TableIO':U , h_v-usuario ).

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-usuario ,
             h_folder , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_p-updspaM ,
             h_v-usuario , 'AFTER':U ).
    END. /* Page 1 */
    WHEN 2 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-dsc_usuario.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-dsc_usuario-2 ).
       RUN set-position IN h_v-dsc_usuario-2 ( 3.14 , 29.00 ) NO-ERROR.
       /* Size in UIB:  ( 1.43 , 87.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-textoempresas.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-textoempresas ).
       RUN set-position IN h_v-textoempresas ( 5.05 , 29.00 ) NO-ERROR.
       /* Size in UIB:  ( 1.00 , 120.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-usuario_empresa.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-usuario_empresa ).
       RUN set-position IN h_b-usuario_empresa ( 6.24 , 29.00 ) NO-ERROR.
       RUN set-size IN h_b-usuario_empresa ( 6.43 , 38.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-user_empresa.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-user_empresa ).
       RUN set-position IN h_v-user_empresa ( 6.24 , 68.00 ) NO-ERROR.
       /* Size in UIB:  ( 6.43 , 81.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'p-updspa.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Edge-Pixels = 2,
                     SmartPanelType = Update-Trans,
                     AddFunction = One-Record':U ,
             OUTPUT h_p-updspa-3 ).
       RUN set-position IN h_p-updspa-3 ( 13.14 , 29.00 ) NO-ERROR.
       RUN set-size IN h_p-updspa-3 ( 1.91 , 120.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-hst_claves.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-hst_claves ).
       RUN set-position IN h_b-hst_claves ( 15.38 , 122.80 ) NO-ERROR.
       RUN set-size IN h_b-hst_claves ( 10.00 , 28.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-funciones_usuario.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-funciones_usuario ).
       RUN set-position IN h_b-funciones_usuario ( 15.52 , 29.00 ) NO-ERROR.
       RUN set-size IN h_b-funciones_usuario ( 6.43 , 73.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'p-updspa.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Edge-Pixels = 2,
                     SmartPanelType = Update-Trans,
                     AddFunction = One-Record':U ,
             OUTPUT h_p-updspa-2 ).
       RUN set-position IN h_p-updspa-2 ( 15.52 , 105.00 ) NO-ERROR.
       RUN set-size IN h_p-updspa-2 ( 10.00 , 15.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-funcion_usuario.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-funcion_usuario ).
       RUN set-position IN h_v-funcion_usuario ( 22.19 , 29.00 ) NO-ERROR.
       /* Size in UIB:  ( 3.24 , 73.00 ) */

       /* Links to SmartViewer h_v-dsc_usuario-2. */
       RUN add-link IN adm-broker-hdl ( h_b-usuarios , 'Record':U , h_v-dsc_usuario-2 ).

       /* Links to SmartBrowser h_b-usuario_empresa. */
       RUN add-link IN adm-broker-hdl ( h_b-usuarios , 'Record':U , h_b-usuario_empresa ).

       /* Links to SmartViewer h_v-user_empresa. */
       RUN add-link IN adm-broker-hdl ( h_b-usuario_empresa , 'Record':U , h_v-user_empresa ).
       RUN add-link IN adm-broker-hdl ( h_p-updspa-3 , 'TableIO':U , h_v-user_empresa ).

       /* Links to SmartBrowser h_b-hst_claves. */
       RUN add-link IN adm-broker-hdl ( h_b-usuarios , 'Record':U , h_b-hst_claves ).

       /* Links to SmartBrowser h_b-funciones_usuario. */
       RUN add-link IN adm-broker-hdl ( h_b-usuario_empresa , 'Record':U , h_b-funciones_usuario ).

       /* Links to SmartViewer h_v-funcion_usuario. */
       RUN add-link IN adm-broker-hdl ( h_b-funciones_usuario , 'Record':U , h_v-funcion_usuario ).
       RUN add-link IN adm-broker-hdl ( h_p-updspa-2 , 'TableIO':U , h_v-funcion_usuario ).

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-dsc_usuario-2 ,
             h_folder , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-textoempresas ,
             h_v-dsc_usuario-2 , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_b-usuario_empresa ,
             h_v-textoempresas , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-user_empresa ,
             h_b-usuario_empresa , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_p-updspa-3 ,
             h_v-user_empresa , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_b-hst_claves ,
             h_p-updspa-3 , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_b-funciones_usuario ,
             h_b-hst_claves , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_p-updspa-2 ,
             h_b-funciones_usuario , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-funcion_usuario ,
             h_p-updspa-2 , 'AFTER':U ).
    END. /* Page 2 */
    WHEN 3 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-dsc_usuario.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-dsc_usuario ).
       RUN set-position IN h_v-dsc_usuario ( 3.38 , 32.00 ) NO-ERROR.
       /* Size in UIB:  ( 1.43 , 87.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-uso_de_menues.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-uso_de_menues ).
       RUN set-position IN h_b-uso_de_menues ( 5.29 , 32.00 ) NO-ERROR.
       RUN set-size IN h_b-uso_de_menues ( 19.52 , 115.00 ) NO-ERROR.

       /* Links to SmartViewer h_v-dsc_usuario. */
       RUN add-link IN adm-broker-hdl ( h_b-usuarios , 'Record':U , h_v-dsc_usuario ).

       /* Links to SmartBrowser h_b-uso_de_menues. */
       RUN add-link IN adm-broker-hdl ( h_b-usuarios , 'Record':U , h_b-uso_de_menues ).

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-dsc_usuario ,
             h_folder , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_b-uso_de_menues ,
             h_v-dsc_usuario , 'AFTER':U ).
    END. /* Page 3 */
    WHEN 4 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-dsc_usuario.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-dsc_usuario-3 ).
       RUN set-position IN h_v-dsc_usuario-3 ( 3.38 , 26.00 ) NO-ERROR.
       /* Size in UIB:  ( 1.43 , 87.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-sesiones_del_usuario.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-sesiones_del_usuario ).
       RUN set-position IN h_b-sesiones_del_usuario ( 5.29 , 26.00 ) NO-ERROR.
       RUN set-size IN h_b-sesiones_del_usuario ( 19.52 , 124.00 ) NO-ERROR.

       /* Links to SmartViewer h_v-dsc_usuario-3. */
       RUN add-link IN adm-broker-hdl ( h_b-usuarios , 'Record':U , h_v-dsc_usuario-3 ).

       /* Links to SmartBrowser h_b-sesiones_del_usuario. */
       RUN add-link IN adm-broker-hdl ( h_b-usuarios , 'Record':U , h_b-sesiones_del_usuario ).

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-dsc_usuario-3 ,
             h_folder , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_b-sesiones_del_usuario ,
             h_v-dsc_usuario-3 , 'AFTER':U ).
    END. /* Page 4 */
    WHEN 5 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-dsc_usuario.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-dsc_usuario-4 ).
       RUN set-position IN h_v-dsc_usuario-4 ( 3.14 , 25.00 ) NO-ERROR.
       /* Size in UIB:  ( 1.43 , 87.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-usuario_empresa.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-usuario_empresa-2 ).
       RUN set-position IN h_b-usuario_empresa-2 ( 5.05 , 25.00 ) NO-ERROR.
       RUN set-size IN h_b-usuario_empresa-2 ( 18.57 , 38.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-autorizacion_usuarios.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-autorizacion_usuarios ).
       RUN set-position IN h_b-autorizacion_usuarios ( 5.05 , 64.00 ) NO-ERROR.
       RUN set-size IN h_b-autorizacion_usuarios ( 9.05 , 79.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-autorizacion_usuarios.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-autorizacion_usuarios ).
       RUN set-position IN h_v-autorizacion_usuarios ( 14.33 , 64.00 ) NO-ERROR.
       /* Size in UIB:  ( 6.91 , 79.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'p-updspa.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Edge-Pixels = 2,
                     SmartPanelType = Update-Trans,
                     AddFunction = One-Record':U ,
             OUTPUT h_p-updspa-4 ).
       RUN set-position IN h_p-updspa-4 ( 21.48 , 64.00 ) NO-ERROR.
       RUN set-size IN h_p-updspa-4 ( 2.14 , 79.00 ) NO-ERROR.

       /* Links to SmartViewer h_v-dsc_usuario-4. */
       RUN add-link IN adm-broker-hdl ( h_b-usuarios , 'Record':U , h_v-dsc_usuario-4 ).

       /* Links to SmartBrowser h_b-usuario_empresa-2. */
       RUN add-link IN adm-broker-hdl ( h_b-usuarios , 'Record':U , h_b-usuario_empresa-2 ).

       /* Links to SmartBrowser h_b-autorizacion_usuarios. */
       RUN add-link IN adm-broker-hdl ( h_b-usuario_empresa-2 , 'Record':U , h_b-autorizacion_usuarios ).

       /* Links to SmartViewer h_v-autorizacion_usuarios. */
       RUN add-link IN adm-broker-hdl ( h_b-autorizacion_usuarios , 'Record':U , h_v-autorizacion_usuarios ).
       RUN add-link IN adm-broker-hdl ( h_p-updspa-4 , 'TableIO':U , h_v-autorizacion_usuarios ).

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-dsc_usuario-4 ,
             h_folder , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_b-usuario_empresa-2 ,
             h_v-dsc_usuario-4 , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_b-autorizacion_usuarios ,
             h_b-usuario_empresa-2 , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-autorizacion_usuarios ,
             h_b-autorizacion_usuarios , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_p-updspa-4 ,
             h_v-autorizacion_usuarios , 'AFTER':U ).
    END. /* Page 5 */
    WHEN 6 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-usuario_programa.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-usuario_programa ).
       RUN set-position IN h_b-usuario_programa ( 4.10 , 45.00 ) NO-ERROR.
       RUN set-size IN h_b-usuario_programa ( 17.62 , 88.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'adm/objects/p-updsav.r':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Edge-Pixels = 2,
                     SmartPanelType = Update,
                     AddFunction = One-Record':U ,
             OUTPUT h_p-updsav ).
       RUN set-position IN h_p-updsav ( 22.91 , 65.00 ) NO-ERROR.
       RUN set-size IN h_p-updsav ( 1.76 , 56.00 ) NO-ERROR.

       /* Links to SmartBrowser h_b-usuario_programa. */
       RUN add-link IN adm-broker-hdl ( h_b-usuarios , 'Record':U , h_b-usuario_programa ).
       RUN add-link IN adm-broker-hdl ( h_p-updsav , 'TableIO':U , h_b-usuario_programa ).

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_b-usuario_programa ,
             h_folder , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_p-updsav ,
             h_b-usuario_programa , 'AFTER':U ).
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

  {setwintit.i "SIC/SEG" "Mantenimiento de Usuarios"}


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

/*
       IF p-operacion = "HABILITAR"
          THEN RUN enable-folder-page  IN WIDGET-HANDLE(page-hdl) (j-pagina).
          ELSE RUN disable-folder-page IN WIDGET-HANDLE(page-hdl) (j-pagina).
*/
       IF p-operacion = "HABILITAR"
          THEN RUN enable-folder-page  IN h_folder (j-pagina).
          ELSE RUN disable-folder-page IN h_folder (j-pagina).

    END.

    IF VALID-HANDLE(h_b-usuarios)          THEN RUN set-sensitivo IN h_b-usuarios          ( INPUT p-operacion = "HABILITAR" ).
    IF VALID-HANDLE(h_p-updspam)           THEN RUN set-sensitivo IN h_p-updspam           ( INPUT p-operacion = "HABILITAR" ). 
    IF VALID-HANDLE(h_p-updspa-2)          THEN RUN set-sensitivo IN h_p-updspa-2          ( INPUT p-operacion = "HABILITAR" ). 
    IF VALID-HANDLE(h_p-updspa-3)          THEN RUN set-sensitivo IN h_p-updspa-3          ( INPUT p-operacion = "HABILITAR" ). 
    IF VALID-HANDLE(h_b-funciones_usuario) THEN RUN set-sensitivo IN h_b-funciones_usuario ( INPUT p-operacion = "HABILITAR" ). 
    IF VALID-HANDLE(h_b-hst_claves)        THEN RUN set-sensitivo IN h_b-hst_claves        ( INPUT p-operacion = "HABILITAR" ). 
    IF VALID-HANDLE(h_b-usuario_empresa)   THEN RUN set-sensitivo IN h_b-usuario_empresa   ( INPUT p-operacion = "HABILITAR" ). 

       /*MENU-BAR-W-Win:SENSITIVE IN FRAME {&FRAME-NAME} = YES.*/

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

