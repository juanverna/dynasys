&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
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

DEFINE VARIABLE rid_afiliado AS ROWID.
DEFINE VARIABLE rid_grupo    AS ROWID.

DEFINE VARIABLE puso_ok AS LOGICAL.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartWindow

&Scoped-define ADM-CONTAINER WINDOW

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME F-Main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS v-cdg_empresa v-cdg_empresa-dst que_grupo ~
v-nom_grupofam btn_cambiar 
&Scoped-Define DISPLAYED-OBJECTS v-cdg_empresa v-cdg_empresa-dst que_grupo ~
v-nom_grupofam 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR W-Win AS WIDGET-HANDLE NO-UNDO.

/* Menu Definitions                                                     */
DEFINE MENU POPUP-MENU-que_grupo 
       MENU-ITEM m_Afiliados    LABEL "A&filiados"    
       MENU-ITEM m_Domicilios   LABEL "&Domicilios"   
       MENU-ITEM m_Grupos       LABEL "&Grupos"       .


/* Definitions of the field level widgets                               */
DEFINE BUTTON btn_cambiar 
     LABEL "E&jecutar cambio de empresa" 
     SIZE 84 BY 1.12.

DEFINE VARIABLE que_grupo AS CHARACTER FORMAT "X(256)":U 
     LABEL "Código de Grupo" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 14 BY 1
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE v-cdg_empresa AS CHARACTER FORMAT "X(256)":U 
     LABEL "De Empresa" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE v-cdg_empresa-dst AS CHARACTER FORMAT "X(256)":U 
     LABEL "A  Empresa" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE v-nom_grupofam AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 69 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     v-cdg_empresa AT ROW 5.31 COL 19 COLON-ALIGNED
     v-cdg_empresa-dst AT ROW 5.31 COL 89 COLON-ALIGNED
     que_grupo AT ROW 6.92 COL 19 COLON-ALIGNED
     v-nom_grupofam AT ROW 6.92 COL 34 COLON-ALIGNED NO-LABEL
     btn_cambiar AT ROW 9.08 COL 21
     "  Indique las empresas de origen y destino y el còdigo de grupo familiar" VIEW-AS TEXT
          SIZE 105 BY 1.08 AT ROW 2.62 COL 5
          BGCOLOR 5 FGCOLOR 14 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 114.29 BY 22.31.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartWindow
   Allow: Basic,Browse,DB-Fields,Query,Smart,Window
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW W-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Cambio de Empresa"
         HEIGHT             = 22.31
         WIDTH              = 114.29
         MAX-HEIGHT         = 22.31
         MAX-WIDTH          = 114.29
         VIRTUAL-HEIGHT     = 22.31
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
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME


/* ***************  Runtime Attributes and UIB Settings  ************** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW W-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME F-Main
                                                                        */
ASSIGN 
       que_grupo:POPUP-MENU IN FRAME F-Main       = MENU POPUP-MENU-que_grupo:HANDLE.

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
ON END-ERROR OF W-Win /* Cambio de Empresa */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-CLOSE OF W-Win /* Cambio de Empresa */
DO:
  /* This ADM code must be left here in order for the SmartWindow
     and its descendents to terminate properly on exit. */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_cambiar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_cambiar W-Win
ON CHOOSE OF btn_cambiar IN FRAME F-Main /* Ejecutar cambio de empresa */
DO:
  ASSIGN FRAME {&FRAME-NAME} v-cdg_empresa v-cdg_empresa-dst que_grupo.
   
  IF NOT CAN-FIND(Empresa WHERE Empresa.cdg_empresa = v-cdg_empresa)
  THEN DO:
       MESSAGE "No existe la empresa DESDE" VIEW-AS ALERT-BOX ERROR.
       RETURN NO-APPLY.
  END.

  IF NOT CAN-FIND(Empresa WHERE Empresa.cdg_empresa = v-cdg_empresa-dst)
  THEN DO:
       MESSAGE "No existe la empresa HASTA" VIEW-AS ALERT-BOX ERROR.
       RETURN NO-APPLY.
  END.
  
  IF NOT CAN-FIND(FIRST Grupofam WHERE Grupofam.cdg_grupofam = que_grupo
                                   AND Grupofam.cdg_empresa = v-cdg_empresa)
  THEN DO:
       MESSAGE "No existe el grupo familiar indicado" VIEW-AS ALERT-BOX ERROR.
       RETURN NO-APPLY.
  END.

  IF CAN-FIND(FIRST Grupofam WHERE Grupofam.cdg_grupofam = que_grupo
                               AND Grupofam.cdg_empresa = v-cdg_empresa-dst)
  THEN DO:
       MESSAGE "YA existe el grupo familiar en la empresa de destino" VIEW-AS ALERT-BOX ERROR.
       RETURN NO-APPLY.
  END.

  IF CAN-FIND(FIRST Cta_cte WHERE Cta_cte.nro_cliente = Grupofam.nro_cliente)
  THEN DO:
       MESSAGE "NO PUEDE TRANSFERIRSE un grupofamiliar con movimientos de cuenta corriente" VIEW-AS ALERT-BOX ERROR.
       RETURN NO-APPLY.
  END.

  DO TRANSACTION:
  
     FIND Grupofam WHERE Grupofam.cdg_grupofam = que_grupo
                     AND Grupofam.cdg_empresa = v-cdg_empresa
                         EXCLUSIVE-LOCK.

     FIND Cliente WHERE Cliente.nro_cliente = Grupofam.nro_cliente EXCLUSIVE-LOCK NO-ERROR.
     IF AVAILABLE Cliente THEN OVERLAY(Cliente.cdg_cliente,1,1) = v-cdg_empresa-dst.

     Grupofam.cdg_empresa = v-cdg_empresa-dst.

  END.
  
  
  v-nom_grupofam = "".
  que_grupo = "".
  DISPLAY v-nom_grupofam que_grupo
          WITH FRAME {&FRAME-NAME}.

  MESSAGE "El grupo ha sido transferido" VIEW-AS ALERT-BOX MESSAGE TITLE "Operacion finalizada".

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Afiliados
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Afiliados W-Win
ON CHOOSE OF MENU-ITEM m_Afiliados /* Afiliados */
DO:
  
  RUN c-busafiliado.w ( INPUT v-cdg_empresa,
                        INPUT "",
                        INPUT "",
                        INPUT-OUTPUT rid_afiliado,
                        OUTPUT puso_ok).   
  IF puso_ok
  THEN DO:
       FIND Afiliado WHERE ROWID(Afiliado) = rid_afiliado NO-LOCK.
       FIND Grupofam OF Afiliado NO-LOCK.
       DISPLAY Grupofam.cdg_grupofam @ que_grupo
               WITH FRAME {&FRAME-NAME}.
       APPLY "RETURN" TO que_grupo IN FRAME {&FRAME-NAME}.
       RETURN NO-APPLY.
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Domicilios
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Domicilios W-Win
ON CHOOSE OF MENU-ITEM m_Domicilios /* Domicilios */
DO:
  RUN c-busdomic.w ( INPUT v-cdg_empresa,
                     INPUT "",
                     INPUT "",
                     INPUT-OUTPUT rid_grupo,
                     OUTPUT puso_ok).   
  IF puso_ok
  THEN DO:
       FIND Grupofam WHERE ROWID(Grupofam) = rid_grupo NO-LOCK.
       DISPLAY Grupofam.cdg_grupofam @ que_grupo
               WITH FRAME {&FRAME-NAME}.
       APPLY "RETURN" TO que_grupo IN FRAME {&FRAME-NAME}.
       RETURN NO-APPLY.
  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Grupos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Grupos W-Win
ON CHOOSE OF MENU-ITEM m_Grupos /* Grupos */
DO:

  RUN c-busgrupo.w ( INPUT v-cdg_empresa,
                     INPUT "",
                     INPUT "",
                     INPUT-OUTPUT rid_grupo,
                     OUTPUT puso_ok).   
  IF puso_ok
  THEN DO:
       FIND Grupofam WHERE ROWID(Grupofam) = rid_grupo NO-LOCK.
       DISPLAY Grupofam.cdg_grupofam @ que_grupo
               WITH FRAME {&FRAME-NAME}.
       APPLY "RETURN" TO que_grupo IN FRAME {&FRAME-NAME}.
       RETURN NO-APPLY.
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME que_grupo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_grupo W-Win
ON RETURN OF que_grupo IN FRAME F-Main /* Código de Grupo */
DO:
  FIND FIRST Grupofam 
       WHERE Grupofam.cdg_grupofam >= que_grupo:SCREEN-VALUE IN FRAME {&FRAME-NAME}
         AND Grupofam.cdg_empresa = v-cdg_empresa NO-LOCK NO-ERROR.
  IF NOT AVAILABLE Grupofam 
     THEN FIND LAST Grupofam WHERE Grupofam.cdg_empresa = v-cdg_empresa.
  
  v-nom_grupofam = Grupofam.nom_grupofam.
  DISPLAY v-nom_grupofam
          WITH FRAME {&FRAME-NAME}.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_empresa
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_empresa W-Win
ON LEAVE OF v-cdg_empresa IN FRAME F-Main /* De Empresa */
DO:
  ASSIGN FRAME {&FRAME-NAME} v-cdg_empresa.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_empresa-dst
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_empresa-dst W-Win
ON LEAVE OF v-cdg_empresa-dst IN FRAME F-Main /* A  Empresa */
DO:
  ASSIGN FRAME {&FRAME-NAME} v-cdg_empresa-dst.
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
  DISPLAY v-cdg_empresa v-cdg_empresa-dst que_grupo v-nom_grupofam 
      WITH FRAME F-Main IN WINDOW W-Win.
  ENABLE v-cdg_empresa v-cdg_empresa-dst que_grupo v-nom_grupofam btn_cambiar 
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

  {setwintit.i "SIC/AFI" "Transferencia de grupos entre empresas"}


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


