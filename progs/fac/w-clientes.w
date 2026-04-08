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
DEFINE VARIABLE h_b-bon_cliente AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-bon_xarticulo AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-clientes AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-cliente_condicion AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-cliente_contacto AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-cliente_jurisdiccion AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-domicilios AS HANDLE NO-UNDO.
DEFINE VARIABLE h_folder AS HANDLE NO-UNDO.
DEFINE VARIABLE h_p-soloedita AS HANDLE NO-UNDO.
DEFINE VARIABLE h_p-updsav AS HANDLE NO-UNDO.
DEFINE VARIABLE h_p-updspa AS HANDLE NO-UNDO.
DEFINE VARIABLE h_p-updspa-2 AS HANDLE NO-UNDO.
DEFINE VARIABLE h_p-updspa-3 AS HANDLE NO-UNDO.
DEFINE VARIABLE h_p-updspa-4 AS HANDLE NO-UNDO.
DEFINE VARIABLE h_p-updspa-5 AS HANDLE NO-UNDO.
DEFINE VARIABLE h_p-updspa-6 AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-bon_cliente AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-bon_xarticulo AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-cliente AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-cliente_contacto AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-cliente_jurisdiccion AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-cnd_cliente AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-domicli AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-dsc_cliente AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-dsc_cliente-2 AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-dsc_cliente-3 AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-dsc_cliente-4 AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-dsc_domicilio AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-jurisdiccion_del_cliente AS HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 160 BY 26.76.


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
         TITLE              = "Mantenimiento de Clientes"
         HEIGHT             = 26.76
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
ON END-ERROR OF W-Win /* Mantenimiento de Clientes */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-CLOSE OF W-Win /* Mantenimiento de Clientes */
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
ON WINDOW-MINIMIZED OF W-Win /* Mantenimiento de Clientes */
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
             INPUT  'b-clientes.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-clientes ).
       RUN set-position IN h_b-clientes ( 1.00 , 3.00 ) NO-ERROR.
       RUN set-size IN h_b-clientes ( 25.95 , 21.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'adm/objects/folder.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'FOLDER-LABELS = ':U + 'Datos|Domicilios|Contactos|Bonificacione|Bon.x Artic.|Ing.Brutos' + ',
                     FOLDER-TAB-TYPE = 1':U ,
             OUTPUT h_folder ).
       RUN set-position IN h_folder ( 1.00 , 26.00 ) NO-ERROR.
       RUN set-size IN h_folder ( 25.95 , 133.00 ) NO-ERROR.

       /* Links to SmartFolder h_folder. */
       RUN add-link IN adm-broker-hdl ( h_folder , 'Page':U , THIS-PROCEDURE ).

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_folder ,
             h_b-clientes , 'AFTER':U ).
    END. /* Page 0 */
    WHEN 1 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-cliente.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-cliente ).
       RUN set-position IN h_v-cliente ( 2.67 , 29.00 ) NO-ERROR.
       /* Size in UIB:  ( 21.43 , 126.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'p-updspa.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Edge-Pixels = 2,
                     SmartPanelType = Update-Trans,
                     AddFunction = One-Record':U ,
             OUTPUT h_p-updspa ).
       RUN set-position IN h_p-updspa ( 24.33 , 29.00 ) NO-ERROR.
       RUN set-size IN h_p-updspa ( 2.38 , 126.00 ) NO-ERROR.

       /* Links to SmartViewer h_v-cliente. */
       RUN add-link IN adm-broker-hdl ( h_b-clientes , 'Record':U , h_v-cliente ).
       RUN add-link IN adm-broker-hdl ( h_p-updspa , 'TableIO':U , h_v-cliente ).

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-cliente ,
             h_folder , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_p-updspa ,
             h_v-cliente , 'AFTER':U ).
    END. /* Page 1 */
    WHEN 2 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-domicilis.w':U ,
             INPUT  {&WINDOW-NAME} ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-domicilios ).
       RUN set-position IN h_b-domicilios ( 5.24 , 39.40 ) NO-ERROR.
       RUN set-size IN h_b-domicilios ( 18.81 , 14.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-dsc_cliente.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-dsc_cliente ).
       RUN set-position IN h_v-dsc_cliente ( 3.14 , 39.00 ) NO-ERROR.
       /* Size in UIB:  ( 1.67 , 98.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-domicli.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-domicli ).
       RUN set-position IN h_v-domicli ( 5.29 , 54.00 ) NO-ERROR.
       /* Size in UIB:  ( 18.81 , 84.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'p-updspa.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Edge-Pixels = 2,
                     SmartPanelType = Update-Trans,
                     AddFunction = One-Record':U ,
             OUTPUT h_p-updspa-2 ).
       RUN set-position IN h_p-updspa-2 ( 5.29 , 140.00 ) NO-ERROR.
       RUN set-size IN h_p-updspa-2 ( 18.81 , 13.00 ) NO-ERROR.

       /* Links to SmartBrowser h_b-domicilios. */
       RUN add-link IN adm-broker-hdl ( h_b-clientes , 'Record':U , h_b-domicilios ).

       /* Links to SmartViewer h_v-dsc_cliente. */
       RUN add-link IN adm-broker-hdl ( h_b-clientes , 'Record':U , h_v-dsc_cliente ).

       /* Links to SmartViewer h_v-domicli. */
       RUN add-link IN adm-broker-hdl ( h_b-domicilios , 'Record':U , h_v-domicli ).
       RUN add-link IN adm-broker-hdl ( h_p-updspa-2 , 'TableIO':U , h_v-domicli ).

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-dsc_cliente ,
             h_folder , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-domicli ,
             h_v-dsc_cliente , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_p-updspa-2 ,
             h_v-domicli , 'AFTER':U ).
    END. /* Page 2 */
    WHEN 3 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-dsc_cliente.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-dsc_cliente-4 ).
       RUN set-position IN h_v-dsc_cliente-4 ( 2.91 , 28.00 ) NO-ERROR.
       /* Size in UIB:  ( 1.67 , 98.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-dsc_domicilio.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-dsc_domicilio ).
       RUN set-position IN h_v-dsc_domicilio ( 4.81 , 28.00 ) NO-ERROR.
       /* Size in UIB:  ( 1.67 , 98.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-cliente_contacto.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-cliente_contacto ).
       RUN set-position IN h_b-cliente_contacto ( 6.71 , 28.00 ) NO-ERROR.
       RUN set-size IN h_b-cliente_contacto ( 10.48 , 129.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-cliente_contacto.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-cliente_contacto ).
       RUN set-position IN h_v-cliente_contacto ( 17.43 , 28.00 ) NO-ERROR.
       /* Size in UIB:  ( 6.43 , 129.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'p-updspa.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Edge-Pixels = 2,
                     SmartPanelType = Update-Trans,
                     AddFunction = One-Record':U ,
             OUTPUT h_p-updspa-5 ).
       RUN set-position IN h_p-updspa-5 ( 24.10 , 28.00 ) NO-ERROR.
       RUN set-size IN h_p-updspa-5 ( 2.00 , 129.00 ) NO-ERROR.

       /* Initialize other pages that this page requires. */
       RUN init-pages IN THIS-PROCEDURE ('2':U) NO-ERROR.

       /* Links to SmartViewer h_v-dsc_cliente-4. */
       RUN add-link IN adm-broker-hdl ( h_b-clientes , 'Record':U , h_v-dsc_cliente-4 ).

       /* Links to SmartViewer h_v-dsc_domicilio. */
       RUN add-link IN adm-broker-hdl ( h_b-domicilios , 'Record':U , h_v-dsc_domicilio ).

       /* Links to SmartBrowser h_b-cliente_contacto. */
       RUN add-link IN adm-broker-hdl ( h_b-domicilios , 'Record':U , h_b-cliente_contacto ).

       /* Links to SmartViewer h_v-cliente_contacto. */
       RUN add-link IN adm-broker-hdl ( h_b-cliente_contacto , 'Record':U , h_v-cliente_contacto ).
       RUN add-link IN adm-broker-hdl ( h_p-updspa-5 , 'TableIO':U , h_v-cliente_contacto ).

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-dsc_cliente-4 ,
             h_folder , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-dsc_domicilio ,
             h_v-dsc_cliente-4 , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_b-cliente_contacto ,
             h_v-dsc_domicilio , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-cliente_contacto ,
             h_b-cliente_contacto , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_p-updspa-5 ,
             h_v-cliente_contacto , 'AFTER':U ).
    END. /* Page 3 */
    WHEN 4 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-dsc_cliente.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-dsc_cliente-2 ).
       RUN set-position IN h_v-dsc_cliente-2 ( 2.91 , 31.00 ) NO-ERROR.
       /* Size in UIB:  ( 1.67 , 98.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-bon_cliente.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-bon_cliente ).
       RUN set-position IN h_b-bon_cliente ( 5.05 , 31.00 ) NO-ERROR.
       RUN set-size IN h_b-bon_cliente ( 6.19 , 81.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'p-updspa.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Edge-Pixels = 2,
                     SmartPanelType = Update,
                     AddFunction = One-Record':U ,
             OUTPUT h_p-updsav ).
       RUN set-position IN h_p-updsav ( 5.05 , 113.00 ) NO-ERROR.
       RUN set-size IN h_p-updsav ( 9.76 , 16.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-bon_cliente.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-bon_cliente ).
       RUN set-position IN h_v-bon_cliente ( 11.71 , 31.00 ) NO-ERROR.
       /* Size in UIB:  ( 3.10 , 81.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-cliente_condicion.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-cliente_condicion ).
       RUN set-position IN h_b-cliente_condicion ( 15.29 , 31.00 ) NO-ERROR.
       RUN set-size IN h_b-cliente_condicion ( 5.91 , 81.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'p-updspa.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Edge-Pixels = 2,
                     SmartPanelType = Update-Trans,
                     AddFunction = One-Record':U ,
             OUTPUT h_p-updspa-4 ).
       RUN set-position IN h_p-updspa-4 ( 15.29 , 113.00 ) NO-ERROR.
       RUN set-size IN h_p-updspa-4 ( 9.05 , 16.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-cnd_cliente.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-cnd_cliente ).
       RUN set-position IN h_v-cnd_cliente ( 21.48 , 31.00 ) NO-ERROR.
       /* Size in UIB:  ( 2.86 , 80.00 ) */

       /* Links to SmartViewer h_v-dsc_cliente-2. */
       RUN add-link IN adm-broker-hdl ( h_b-clientes , 'Record':U , h_v-dsc_cliente-2 ).

       /* Links to SmartBrowser h_b-bon_cliente. */
       RUN add-link IN adm-broker-hdl ( h_b-clientes , 'Record':U , h_b-bon_cliente ).

       /* Links to SmartViewer h_v-bon_cliente. */
       RUN add-link IN adm-broker-hdl ( h_b-bon_cliente , 'Record':U , h_v-bon_cliente ).
       RUN add-link IN adm-broker-hdl ( h_p-updsav , 'TableIO':U , h_v-bon_cliente ).

       /* Links to SmartBrowser h_b-cliente_condicion. */
       RUN add-link IN adm-broker-hdl ( h_b-clientes , 'Record':U , h_b-cliente_condicion ).

       /* Links to SmartViewer h_v-cnd_cliente. */
       RUN add-link IN adm-broker-hdl ( h_b-cliente_condicion , 'Record':U , h_v-cnd_cliente ).
       RUN add-link IN adm-broker-hdl ( h_p-updspa-4 , 'TableIO':U , h_v-cnd_cliente ).

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-dsc_cliente-2 ,
             h_folder , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_b-bon_cliente ,
             h_v-dsc_cliente-2 , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_p-updsav ,
             h_b-bon_cliente , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-bon_cliente ,
             h_p-updsav , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_b-cliente_condicion ,
             h_v-bon_cliente , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_p-updspa-4 ,
             h_b-cliente_condicion , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-cnd_cliente ,
             h_p-updspa-4 , 'AFTER':U ).
    END. /* Page 4 */
    WHEN 5 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-dsc_cliente.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-dsc_cliente-3 ).
       RUN set-position IN h_v-dsc_cliente-3 ( 3.38 , 33.00 ) NO-ERROR.
       /* Size in UIB:  ( 1.67 , 98.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-bon_xarticulo.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-bon_xarticulo ).
       RUN set-position IN h_b-bon_xarticulo ( 5.52 , 33.00 ) NO-ERROR.
       RUN set-size IN h_b-bon_xarticulo ( 10.52 , 110.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-bon_xarticulo.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-bon_xarticulo ).
       RUN set-position IN h_v-bon_xarticulo ( 16.48 , 33.00 ) NO-ERROR.
       /* Size in UIB:  ( 4.29 , 98.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'p-updspa.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Edge-Pixels = 2,
                     SmartPanelType = Update-Trans,
                     AddFunction = One-Record':U ,
             OUTPUT h_p-updspa-3 ).
       RUN set-position IN h_p-updspa-3 ( 21.24 , 33.00 ) NO-ERROR.
       RUN set-size IN h_p-updspa-3 ( 2.38 , 110.00 ) NO-ERROR.

       /* Initialize other pages that this page requires. */
       RUN init-pages IN THIS-PROCEDURE ('4':U) NO-ERROR.

       /* Links to SmartViewer h_v-dsc_cliente-3. */
       RUN add-link IN adm-broker-hdl ( h_b-bon_cliente , 'Record':U , h_v-dsc_cliente-3 ).

       /* Links to SmartBrowser h_b-bon_xarticulo. */
       RUN add-link IN adm-broker-hdl ( h_b-clientes , 'Record':U , h_b-bon_xarticulo ).

       /* Links to SmartViewer h_v-bon_xarticulo. */
       RUN add-link IN adm-broker-hdl ( h_b-bon_xarticulo , 'Record':U , h_v-bon_xarticulo ).
       RUN add-link IN adm-broker-hdl ( h_p-updspa-3 , 'TableIO':U , h_v-bon_xarticulo ).

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-dsc_cliente-3 ,
             h_folder , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_b-bon_xarticulo ,
             h_v-dsc_cliente-3 , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-bon_xarticulo ,
             h_b-bon_xarticulo , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_p-updspa-3 ,
             h_v-bon_xarticulo , 'AFTER':U ).
    END. /* Page 5 */
    WHEN 6 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-cliente_jurisdiccion.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-cliente_jurisdiccion ).
       RUN set-position IN h_v-cliente_jurisdiccion ( 2.91 , 31.00 ) NO-ERROR.
       /* Size in UIB:  ( 3.10 , 122.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'p-soloedita.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Edge-Pixels = 2,
                     SmartPanelType = Update-Trans,
                     AddFunction = One-Record':U ,
             OUTPUT h_p-soloedita ).
       RUN set-position IN h_p-soloedita ( 6.48 , 31.00 ) NO-ERROR.
       RUN set-size IN h_p-soloedita ( 2.38 , 122.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-cliente_jurisdiccion.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-cliente_jurisdiccion ).
       RUN set-position IN h_b-cliente_jurisdiccion ( 9.10 , 31.00 ) NO-ERROR.
       RUN set-size IN h_b-cliente_jurisdiccion ( 6.71 , 63.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-jurisdiccion_del_cliente.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-jurisdiccion_del_cliente ).
       RUN set-position IN h_v-jurisdiccion_del_cliente ( 9.10 , 96.00 ) NO-ERROR.
       /* Size in UIB:  ( 3.10 , 57.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'p-updspa.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Edge-Pixels = 2,
                     SmartPanelType = Update-Trans,
                     AddFunction = One-Record':U ,
             OUTPUT h_p-updspa-6 ).
       RUN set-position IN h_p-updspa-6 ( 12.43 , 96.00 ) NO-ERROR.
       RUN set-size IN h_p-updspa-6 ( 3.33 , 57.00 ) NO-ERROR.

       /* Links to SmartViewer h_v-cliente_jurisdiccion. */
       RUN add-link IN adm-broker-hdl ( h_b-clientes , 'Record':U , h_v-cliente_jurisdiccion ).
       RUN add-link IN adm-broker-hdl ( h_p-soloedita , 'TableIO':U , h_v-cliente_jurisdiccion ).

       /* Links to SmartBrowser h_b-cliente_jurisdiccion. */
       RUN add-link IN adm-broker-hdl ( h_b-clientes , 'Record':U , h_b-cliente_jurisdiccion ).

       /* Links to SmartViewer h_v-jurisdiccion_del_cliente. */
       RUN add-link IN adm-broker-hdl ( h_b-cliente_jurisdiccion , 'Record':U , h_v-jurisdiccion_del_cliente ).
       RUN add-link IN adm-broker-hdl ( h_p-updspa-6 , 'TableIO':U , h_v-jurisdiccion_del_cliente ).

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-cliente_jurisdiccion ,
             h_folder , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_p-soloedita ,
             h_v-cliente_jurisdiccion , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_b-cliente_jurisdiccion ,
             h_p-soloedita , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-jurisdiccion_del_cliente ,
             h_b-cliente_jurisdiccion , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_p-updspa-6 ,
             h_v-jurisdiccion_del_cliente , 'AFTER':U ).
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

  {setwintit.i "SIC/FAC" "Mantenimiento de Clientes"}


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

