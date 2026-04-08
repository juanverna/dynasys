&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------

  File: 

  Description: 

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: 

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

&IF DEFINED(UIB_is_Running) NE 0
&THEN
DEFINE VARIABLE que_empresa  AS CHARACTER.   
DEFINE VARIABLE buscar_por   AS CHARACTER.   
DEFINE VARIABLE clave_buscar AS CHARACTER.   
DEFINE VARIABLE rid_afiliado AS ROWID.
DEFINE VARIABLE puso_ok      AS LOGICAL.   
&ELSE
DEFINE INPUT  PARAMETER que_empresa  AS CHARACTER.   
DEFINE INPUT  PARAMETER buscar_por   AS CHARACTER.   
DEFINE INPUT  PARAMETER clave_buscar AS CHARACTER.   
DEFINE INPUT-OUTPUT PARAMETER rid_afiliado AS ROWID.
DEFINE OUTPUT PARAMETER puso_ok      AS LOGICAL.   
&ENDIF

/* Local Variable Definitions ---                                       */

DEFINE VARIABLE hay_observaciones AS LOGICAL.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME br_domicilios

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Grupo-domicilio Grupofam

/* Definitions for BROWSE br_domicilios                                 */
&Scoped-define FIELDS-IN-QUERY-br_domicilios Grupo-domicilio.calle Grupo-domicilio.nropta Grupo-domicilio.depto Grupo-domicilio.piso Grupo-domicilio.prefijotel Grupo-domicilio.telefono Grupo-domicilio.cdg_localidad Grupo-domicilio.cdg_tipodom Grupofam.cdg_grupofam Grupofam.nom_grupofam   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_domicilios   
&Scoped-define FIELD-PAIRS-IN-QUERY-br_domicilios
&Scoped-define SELF-NAME br_domicilios
&Scoped-define OPEN-QUERY-br_domicilios  CASE buscar_por:       WHEN "NOMBRE"      THEN DO:            que_calle = clave_buscar.           IF SUBSTRING(que_calle, ~
      LENGTH(que_calle), ~
      1) <> "*"              THEN que_calle = que_calle + "*".           OPEN QUERY br_domicilios                FOR EACH Grupo-domicilio                    WHERE Grupo-domicilio.calle CONTAINS que_calle                      AND Grupo-domicilio.nropta CONTAINS que_nropta                      AND Grupo-domicilio.cdg_empresa = que_empresa                          NO-LOCK, ~
       FIRST Grupofam OF Grupo-domicilio NO-LOCK.           br_domicilios:TITLE = "Grupos Familiares que satisfacen la condición de búsqueda: POR NOMBRE=" + que_calle.           que_calle = "".       END.       OTHERWISE      DO:            OPEN QUERY {&SELF-NAME}                FOR EACH Grupo-domicilio                    WHERE Grupo-domicilio.cdg_empresa = que_empresa NO-LOCK, ~
                          FIRST Grupofam OF Grupo-domicilio NO-LOCK.       END.   END CASE.
&Scoped-define TABLES-IN-QUERY-br_domicilios Grupo-domicilio Grupofam
&Scoped-define FIRST-TABLE-IN-QUERY-br_domicilios Grupo-domicilio


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-br_domicilios}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS que_calle que_nropta btn_calle Btn_Done-2 ~
Btn_Salir br_domicilios 
&Scoped-Define DISPLAYED-OBJECTS que_calle que_nropta 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Menu Definitions                                                     */
DEFINE MENU POPUP-MENU-br_afiliados 
       MENU-ITEM m_Con_Domicilio LABEL "&Con Domicilio"
       MENU-ITEM m_Sin_Domicilio LABEL "&Sin Domicilio".


/* Definitions of the field level widgets                               */
DEFINE BUTTON btn_calle 
     LABEL "Buscar por &Calle" 
     SIZE 27 BY 1.

DEFINE BUTTON Btn_Done-2 DEFAULT 
     LABEL "&Elegir" 
     SIZE 15 BY 1
     BGCOLOR 8 .

DEFINE BUTTON Btn_Salir DEFAULT 
     LABEL "&Salir" 
     SIZE 15 BY 1
     BGCOLOR 8 .

DEFINE VARIABLE que_calle AS CHARACTER FORMAT "X(256)":U 
     LABEL "Calle" 
     VIEW-AS FILL-IN 
     SIZE 29 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE que_nropta AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_domicilios FOR 
      Grupo-domicilio, 
      Grupofam SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_domicilios
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_domicilios C-Win _FREEFORM
  QUERY br_domicilios NO-LOCK DISPLAY
      Grupo-domicilio.calle 
      Grupo-domicilio.nropta 
      Grupo-domicilio.depto 
      Grupo-domicilio.piso 
      Grupo-domicilio.prefijotel 
      Grupo-domicilio.telefono
      Grupo-domicilio.cdg_localidad COLUMN-LABEL "Localidad!Domicilio" FORMAT "X(15)"
      Grupo-domicilio.cdg_tipodom COLUMN-LABEL "Tip!Dom" FORMAT "X(1)"
      Grupofam.cdg_grupofam  COLUMN-LABEL "Número!Grupo"
      Grupofam.nom_grupofam
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 113 BY 19.65
         FONT 4
         TITLE "Afiliados que satisfacen la condición de búsqueda".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     que_calle AT ROW 1.27 COL 8 COLON-ALIGNED
     que_nropta AT ROW 1.27 COL 38 COLON-ALIGNED NO-LABEL
     btn_calle AT ROW 1.27 COL 56
     Btn_Done-2 AT ROW 1.27 COL 84
     Btn_Salir AT ROW 1.27 COL 100
     br_domicilios AT ROW 2.62 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 114.29 BY 21.27
         FONT 4.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Búsqueda de Domicilios"
         HEIGHT             = 22.15
         WIDTH              = 114.29
         MAX-HEIGHT         = 23.08
         MAX-WIDTH          = 114.29
         VIRTUAL-HEIGHT     = 23.08
         VIRTUAL-WIDTH      = 114.29
         RESIZE             = yes
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         KEEP-FRAME-Z-ORDER = yes
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME


/* ***************  Runtime Attributes and UIB Settings  ************** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME DEFAULT-FRAME
                                                                        */
/* BROWSE-TAB br_domicilios Btn_Salir DEFAULT-FRAME */
ASSIGN 
       br_domicilios:POPUP-MENU IN FRAME DEFAULT-FRAME         = MENU POPUP-MENU-br_afiliados:HANDLE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_domicilios
/* Query rebuild information for BROWSE br_domicilios
     _START_FREEFORM

CASE buscar_por:

     WHEN "NOMBRE"
     THEN DO:

          que_calle = clave_buscar.
          IF SUBSTRING(que_calle,LENGTH(que_calle),1) <> "*"
             THEN que_calle = que_calle + "*".
          OPEN QUERY br_domicilios
               FOR EACH Grupo-domicilio
                   WHERE Grupo-domicilio.calle CONTAINS que_calle
                     AND Grupo-domicilio.nropta CONTAINS que_nropta
                     AND Grupo-domicilio.cdg_empresa = que_empresa
                         NO-LOCK, FIRST Grupofam OF Grupo-domicilio NO-LOCK.
          br_domicilios:TITLE = "Grupos Familiares que satisfacen la condición de búsqueda: POR NOMBRE=" + que_calle.
          que_calle = "".

     END.

     OTHERWISE
     DO:

          OPEN QUERY {&SELF-NAME}
               FOR EACH Grupo-domicilio
                   WHERE Grupo-domicilio.cdg_empresa = que_empresa NO-LOCK,
                   FIRST Grupofam OF Grupo-domicilio NO-LOCK.

     END.


END CASE.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Query            is OPENED
*/  /* BROWSE br_domicilios */
&ANALYZE-RESUME

 




/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Búsqueda de Domicilios */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Búsqueda de Domicilios */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_domicilios
&Scoped-define SELF-NAME br_domicilios
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_domicilios C-Win
ON MOUSE-SELECT-DBLCLICK OF br_domicilios IN FRAME DEFAULT-FRAME /* Afiliados que satisfacen la condición de búsqueda */
DO:
  RUN d-obs_afiliado ( INPUT ROWID(Grupo-domicilio)). 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_domicilios C-Win
ON ROW-DISPLAY OF br_domicilios IN FRAME DEFAULT-FRAME /* Afiliados que satisfacen la condición de búsqueda */
DO:
 
   IF Grupofam.cdg_estado = "A"  
   THEN RUN poner_color ( INPUT 0, INPUT 15 ).
   ELSE RUN poner_color ( INPUT 0, INPUT 8 ).
 
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_calle
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_calle C-Win
ON CHOOSE OF btn_calle IN FRAME DEFAULT-FRAME /* Buscar por Calle */
DO:
  
  DO WITH FRAME DEFAULT-FRAME:

     ASSIGN que_calle que_nropta.
     IF que_nropta = ""
     THEN DO:
        OPEN QUERY br_domicilios 
             FOR EACH Grupo-domicilio 
                 WHERE Grupo-domicilio.calle CONTAINS que_calle 
                   AND Grupo-domicilio.cdg_empresa = que_empresa
                       NO-LOCK, FIRST Grupofam OF Grupo-domicilio NO-LOCK.
        br_domicilios:TITLE = "Domicilios que satisfacen la condición de búsqueda: POR CALLE=" + que_calle.
        que_calle = "".
        DISPLAY que_calle.
     END.
     ELSE DO:
        OPEN QUERY br_domicilios 
             FOR EACH Grupo-domicilio 
                 WHERE Grupo-domicilio.calle CONTAINS que_calle 
                   AND Grupo-domicilio.nropta CONTAINS que_nropta 
                   AND Grupo-domicilio.cdg_empresa = que_empresa
                       NO-LOCK, FIRST Grupofam OF Grupo-domicilio NO-LOCK.
        br_domicilios:TITLE = "Domicilios que satisfacen la condición de búsqueda: POR CALLE y NUMERO =" + que_calle + " " + que_nropta.
        que_calle = "".
        que_nropta = "".  
        DISPLAY que_calle
                que_nropta.
     END.

  END.   

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Done-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Done-2 C-Win
ON CHOOSE OF Btn_Done-2 IN FRAME DEFAULT-FRAME /* Elegir */
DO:
  
  rid_afiliado = ROWID(Grupofam).
  puso_ok = YES.
  
  &IF DEFINED (adm-panel) <> 0 &THEN
      RUN dispatch IN THIS-PROCEDURE ('exit').
  &ELSE
      APPLY "CLOSE":U TO THIS-PROCEDURE.
  &ENDIF
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Salir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Salir C-Win
ON CHOOSE OF Btn_Salir IN FRAME DEFAULT-FRAME /* Salir */
DO:
  &IF DEFINED (adm-panel) <> 0 &THEN
      RUN dispatch IN THIS-PROCEDURE ('exit').
  &ELSE
      APPLY "CLOSE":U TO THIS-PROCEDURE.
  &ENDIF
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Con_Domicilio
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Con_Domicilio C-Win
ON CHOOSE OF MENU-ITEM m_Con_Domicilio /* Con Domicilio */
DO:
  APPLY "CHOOSE" TO btn_salir IN FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Sin_Domicilio
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Sin_Domicilio C-Win
ON CHOOSE OF MENU-ITEM m_Sin_Domicilio /* Sin Domicilio */
DO:
    APPLY "CHOOSE" TO btn_done-2 IN FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.

/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
   RUN disable_UI.

/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */

MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI C-Win _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
  THEN DELETE WIDGET C-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI C-Win _DEFAULT-ENABLE
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
  DISPLAY que_calle que_nropta 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE que_calle que_nropta btn_calle Btn_Done-2 Btn_Salir br_domicilios 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_color C-Win 
PROCEDURE poner_color :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

      DEFINE INPUT PARAMETER p-fgcolor AS INTEGER.
      DEFINE INPUT PARAMETER p-bgcolor AS INTEGER.
      
      ASSIGN
            Grupo-domicilio.calle:FGCOLOR IN BROWSE {&BROWSE-NAME}        = p-fgcolor 
            Grupo-domicilio.cdg_localidad:FGCOLOR IN BROWSE {&BROWSE-NAME}= p-fgcolor 
            Grupo-domicilio.cdg_tipodom:FGCOLOR IN BROWSE {&BROWSE-NAME}  = p-fgcolor 
            Grupo-domicilio.depto:FGCOLOR IN BROWSE {&BROWSE-NAME}        = p-fgcolor 
            Grupo-domicilio.nropta:FGCOLOR IN BROWSE {&BROWSE-NAME}       = p-fgcolor 
            Grupo-domicilio.piso:FGCOLOR IN BROWSE {&BROWSE-NAME}         = p-fgcolor 
            Grupo-domicilio.prefijotel:FGCOLOR IN BROWSE {&BROWSE-NAME}   = p-fgcolor 
            Grupo-domicilio.telefono:FGCOLOR IN BROWSE {&BROWSE-NAME}     = p-fgcolor
            Grupofam.cdg_grupofam:FGCOLOR IN BROWSE {&BROWSE-NAME}        = p-fgcolor
            Grupofam.nom_grupofam:FGCOLOR IN BROWSE {&BROWSE-NAME}        = p-fgcolor.

      ASSIGN
            Grupo-domicilio.calle:BGCOLOR IN BROWSE {&BROWSE-NAME}        = p-bgcolor 
            Grupo-domicilio.cdg_localidad:BGCOLOR IN BROWSE {&BROWSE-NAME}= p-bgcolor 
            Grupo-domicilio.cdg_tipodom:BGCOLOR IN BROWSE {&BROWSE-NAME}  = p-bgcolor 
            Grupo-domicilio.depto:BGCOLOR IN BROWSE {&BROWSE-NAME}        = p-bgcolor 
            Grupo-domicilio.nropta:BGCOLOR IN BROWSE {&BROWSE-NAME}       = p-bgcolor 
            Grupo-domicilio.piso:BGCOLOR IN BROWSE {&BROWSE-NAME}         = p-bgcolor 
            Grupo-domicilio.prefijotel:BGCOLOR IN BROWSE {&BROWSE-NAME}   = p-bgcolor 
            Grupo-domicilio.telefono:BGCOLOR IN BROWSE {&BROWSE-NAME}     = p-bgcolor
            Grupofam.cdg_grupofam:BGCOLOR IN BROWSE {&BROWSE-NAME}        = p-bgcolor
            Grupofam.nom_grupofam:BGCOLOR IN BROWSE {&BROWSE-NAME}        = p-bgcolor.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


