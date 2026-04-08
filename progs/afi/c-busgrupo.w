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
&Scoped-define BROWSE-NAME br_grupos

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Grupofam

/* Definitions for BROWSE br_grupos                                     */
&Scoped-define FIELDS-IN-QUERY-br_grupos hay_observaciones Grupofam.cdg_grupofam Grupofam.nom_grupofam Grupofam.cdg_plan Grupofam.fecha_baja Grupofam.cdg_motbaja Grupofam.importe_cuota Grupofam.cant_capitas Grupofam.fecha_alta Grupofam.tipo_compbte   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_grupos   
&Scoped-define FIELD-PAIRS-IN-QUERY-br_grupos
&Scoped-define SELF-NAME br_grupos
&Scoped-define OPEN-QUERY-br_grupos  CASE buscar_por:      WHEN "NUMERO"      THEN DO:            que_numero = clave_buscar.           OPEN QUERY br_grupos                FOR EACH Grupofam WHERE Grupofam.cdg_grupofam BEGINS que_numero                                    AND Grupofam.cdg_empresa = que_empresa                                        NO-LOCK.           br_grupos:TITLE = "Grupos Familiares que satisfacen la condición de búsqueda: POR NRO.AFILIADO=" + que_numero.           que_numero = "".       END.        WHEN "NOMBRE"      THEN DO:            que_nombre = clave_buscar.           IF SUBSTRING(que_nombre, ~
      LENGTH(que_nombre), ~
      1) <> "*"              THEN que_nombre = que_nombre + "*".           OPEN QUERY br_grupos                FOR EACH Grupofam WHERE Grupofam.nom_fantasia CONTAINS que_nombre                                    AND Grupofam.cdg_empresa = que_empresa                                        NO-LOCK.           br_grupos:TITLE = "Grupos Familiares que satisfacen la condición de búsqueda: POR NOMBRE=" + que_nombre.           que_nombre = "".       END.       WHEN "RAZON"      THEN DO:            que_nombre = clave_buscar.           IF SUBSTRING(que_nombre, ~
      LENGTH(que_nombre), ~
      1) <> "*"              THEN que_nombre = que_nombre + "*".           OPEN QUERY br_grupos                FOR EACH Grupofam WHERE Grupofam.nom_grupofam CONTAINS que_nombre                                    AND Grupofam.cdg_empresa = que_empresa                                        NO-LOCK.           br_grupos:TITLE = "Grupos Familiares que satisfacen la condición de búsqueda: POR NOMBRE=" + que_nombre.           que_nombre = "".       END.       OTHERWISE      DO:            OPEN QUERY {&SELF-NAME}                FOR EACH Grupofam WHERE Grupofam.cdg_empresa = que_empresa                         NO-LOCK INDEXED-REPOSITION.       END.   END CASE.
&Scoped-define TABLES-IN-QUERY-br_grupos Grupofam
&Scoped-define FIRST-TABLE-IN-QUERY-br_grupos Grupofam


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-br_grupos}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS que_razon btn_razon Btn_Done-2 que_nombre ~
btn_nombre que_numero btn_nsocio Btn_Salir br_grupos 
&Scoped-Define DISPLAYED-OBJECTS que_razon que_nombre que_numero 

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
DEFINE BUTTON Btn_Done-2 DEFAULT 
     LABEL "&Elegir" 
     SIZE 22 BY 1
     BGCOLOR 8 .

DEFINE BUTTON btn_nombre 
     LABEL "Buscar por &Nombre" 
     SIZE 35 BY 1.

DEFINE BUTTON btn_nsocio 
     LABEL "&Número de Socio" 
     SIZE 35 BY 1.

DEFINE BUTTON btn_razon 
     LABEL "Buscar por &Razón Social" 
     SIZE 35 BY 1.

DEFINE BUTTON Btn_Salir DEFAULT 
     LABEL "&Salir" 
     SIZE 22 BY 1
     BGCOLOR 8 .

DEFINE VARIABLE que_nombre AS CHARACTER FORMAT "X(256)":U 
     LABEL "Nombre" 
     VIEW-AS FILL-IN 
     SIZE 42 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE que_numero AS CHARACTER FORMAT "X(256)":U 
     LABEL "Nro. Socio" 
     VIEW-AS FILL-IN 
     SIZE 42 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE que_razon AS CHARACTER FORMAT "X(256)":U 
     LABEL "R.Social" 
     VIEW-AS FILL-IN 
     SIZE 42 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_grupos FOR 
      Grupofam SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_grupos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_grupos C-Win _FREEFORM
  QUERY br_grupos NO-LOCK DISPLAY
      hay_observaciones      COLUMN-LABEL "Hay!Obs." FORMAT "****/"
      Grupofam.cdg_grupofam  COLUMN-LABEL "Número!Grupofam"
      Grupofam.nom_grupofam
      Grupofam.cdg_plan      COLUMN-LABEL "Código!Plan"
      Grupofam.fecha_baja    COLUMN-LABEL "Fecha!Baja"
      Grupofam.cdg_motbaja   COLUMN-LABEL "Mot!Baja"
      Grupofam.importe_cuota COLUMN-LABEL "Importe!Cuota"
      Grupofam.cant_capitas  COLUMN-LABEL "Cant.!Cápitas" FORMAT ">>>>9"
      Grupofam.fecha_alta    COLUMN-LABEL "Fecha!Alta"
      Grupofam.tipo_compbte  COLUMN-LABEL "Tip!Com" FORMAT "X(1)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 113 BY 16.96
         FONT 4
         TITLE "Grupos Familiares/Areas que satisfacen la condición de búsqueda".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     que_razon AT ROW 1.27 COL 10 COLON-ALIGNED
     btn_razon AT ROW 1.27 COL 56
     Btn_Done-2 AT ROW 1.27 COL 92
     que_nombre AT ROW 2.62 COL 10 COLON-ALIGNED
     btn_nombre AT ROW 2.62 COL 56
     que_numero AT ROW 3.96 COL 10 COLON-ALIGNED
     btn_nsocio AT ROW 3.96 COL 56
     Btn_Salir AT ROW 3.96 COL 92
     br_grupos AT ROW 5.31 COL 2
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
         TITLE              = "Búsqueda de Grupos Familiares"
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
/* BROWSE-TAB br_grupos Btn_Salir DEFAULT-FRAME */
ASSIGN 
       br_grupos:POPUP-MENU IN FRAME DEFAULT-FRAME         = MENU POPUP-MENU-br_afiliados:HANDLE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_grupos
/* Query rebuild information for BROWSE br_grupos
     _START_FREEFORM

CASE buscar_por:
     WHEN "NUMERO"
     THEN DO:

          que_numero = clave_buscar.
          OPEN QUERY br_grupos
               FOR EACH Grupofam WHERE Grupofam.cdg_grupofam BEGINS que_numero
                                   AND Grupofam.cdg_empresa = que_empresa
                                       NO-LOCK.
          br_grupos:TITLE = "Grupos Familiares que satisfacen la condición de búsqueda: POR NRO.AFILIADO=" + que_numero.
          que_numero = "".

     END.


     WHEN "NOMBRE"
     THEN DO:

          que_nombre = clave_buscar.
          IF SUBSTRING(que_nombre,LENGTH(que_nombre),1) <> "*"
             THEN que_nombre = que_nombre + "*".
          OPEN QUERY br_grupos
               FOR EACH Grupofam WHERE Grupofam.nom_fantasia CONTAINS que_nombre
                                   AND Grupofam.cdg_empresa = que_empresa
                                       NO-LOCK.
          br_grupos:TITLE = "Grupos Familiares que satisfacen la condición de búsqueda: POR NOMBRE=" + que_nombre.
          que_nombre = "".

     END.

     WHEN "RAZON"
     THEN DO:

          que_nombre = clave_buscar.
          IF SUBSTRING(que_nombre,LENGTH(que_nombre),1) <> "*"
             THEN que_nombre = que_nombre + "*".
          OPEN QUERY br_grupos
               FOR EACH Grupofam WHERE Grupofam.nom_grupofam CONTAINS que_nombre
                                   AND Grupofam.cdg_empresa = que_empresa
                                       NO-LOCK.
          br_grupos:TITLE = "Grupos Familiares que satisfacen la condición de búsqueda: POR NOMBRE=" + que_nombre.
          que_nombre = "".

     END.

     OTHERWISE
     DO:

          OPEN QUERY {&SELF-NAME}
               FOR EACH Grupofam WHERE Grupofam.cdg_empresa = que_empresa
                        NO-LOCK INDEXED-REPOSITION.

     END.


END CASE.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Query            is OPENED
*/  /* BROWSE br_grupos */
&ANALYZE-RESUME

 




/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Búsqueda de Grupos Familiares */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Búsqueda de Grupos Familiares */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_grupos
&Scoped-define SELF-NAME br_grupos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_grupos C-Win
ON MOUSE-SELECT-DBLCLICK OF br_grupos IN FRAME DEFAULT-FRAME /* Grupos Familiares/Areas que satisfacen la condición de búsqueda */
DO:
  RUN d-obs_afiliado ( INPUT ROWID(Grupofam)). 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_grupos C-Win
ON ROW-DISPLAY OF br_grupos IN FRAME DEFAULT-FRAME /* Grupos Familiares/Areas que satisfacen la condición de búsqueda */
DO:
 
   hay_observaciones = Grupofam.observacion <> "".
   IF Grupofam.cdg_estado = "A"  
   THEN RUN poner_color ( INPUT 0, INPUT 15 ).
   ELSE RUN poner_color ( INPUT 0, INPUT 8 ).
 
  
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


&Scoped-define SELF-NAME btn_nombre
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_nombre C-Win
ON CHOOSE OF btn_nombre IN FRAME DEFAULT-FRAME /* Buscar por Nombre */
DO:

  DO WITH FRAME DEFAULT-FRAME:

     ASSIGN que_nombre.
     OPEN QUERY br_grupos 
          FOR EACH Grupofam WHERE Grupofam.nom_fantasia CONTAINS que_nombre 
                              AND Grupofam.cdg_empresa = que_empresa
                                  NO-LOCK.

     br_grupos:TITLE = "Grupos Familiares que satisfacen la condición de búsqueda: POR NOMBRE=" + que_nombre.
     que_nombre = "".
     DISPLAY que_nombre.

  END.   

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_nsocio
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_nsocio C-Win
ON CHOOSE OF btn_nsocio IN FRAME DEFAULT-FRAME /* Número de Socio */
DO:

  DO WITH FRAME DEFAULT-FRAME:

     ASSIGN que_numero.
          OPEN QUERY br_grupos 
               FOR EACH Grupofam WHERE Grupofam.cdg_grupofam BEGINS que_numero 
                                   AND Grupofam.cdg_empresa = que_empresa
                                       NO-LOCK.
          br_grupos:TITLE = "Grupofams que satisfacen la condición de búsqueda: POR N.AFILIADO=" + que_numero.
          que_numero = "".

  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_razon
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_razon C-Win
ON CHOOSE OF btn_razon IN FRAME DEFAULT-FRAME /* Buscar por Razón Social */
DO:

  DO WITH FRAME DEFAULT-FRAME:

     ASSIGN que_razon.
     OPEN QUERY br_grupos 
          FOR EACH Grupofam WHERE Grupofam.nom_grupofam CONTAINS que_razon 
                              AND Grupofam.cdg_empresa = que_empresa
                                  NO-LOCK.

     br_grupos:TITLE = "Grupos Familiares que satisfacen la condición de búsqueda: POR RAZON SOCIAL=" + que_nombre.
     que_razon = "".
     DISPLAY que_razon.

  END.   

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
  DISPLAY que_razon que_nombre que_numero 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE que_razon btn_razon Btn_Done-2 que_nombre btn_nombre que_numero 
         btn_nsocio Btn_Salir br_grupos 
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
            Grupofam.cdg_grupofam:FGCOLOR IN BROWSE {&BROWSE-NAME}   = p-fgcolor
            Grupofam.nom_grupofam:FGCOLOR IN BROWSE {&BROWSE-NAME}   = p-fgcolor
            Grupofam.cdg_plan:FGCOLOR IN BROWSE {&BROWSE-NAME}       = p-fgcolor
            Grupofam.fecha_baja:FGCOLOR IN BROWSE {&BROWSE-NAME}     = p-fgcolor
            Grupofam.cdg_motbaja:FGCOLOR IN BROWSE {&BROWSE-NAME}    = p-fgcolor
            Grupofam.cant_capitas:FGCOLOR IN BROWSE {&BROWSE-NAME}   = p-fgcolor 
            Grupofam.importe_cuota:FGCOLOR IN BROWSE {&BROWSE-NAME}  = p-fgcolor 
            Grupofam.fecha_alta:FGCOLOR IN BROWSE {&BROWSE-NAME}     = p-fgcolor 
            Grupofam.tipo_compbte:FGCOLOR IN BROWSE {&BROWSE-NAME}   = p-fgcolor.

      ASSIGN
            Grupofam.cdg_grupofam:BGCOLOR IN BROWSE {&BROWSE-NAME}   = p-bgcolor
            Grupofam.nom_grupofam:BGCOLOR IN BROWSE {&BROWSE-NAME}   = p-bgcolor
            Grupofam.cdg_plan:BGCOLOR IN BROWSE {&BROWSE-NAME}       = p-bgcolor
            Grupofam.fecha_baja:BGCOLOR IN BROWSE {&BROWSE-NAME}     = p-bgcolor
            Grupofam.cdg_motbaja:BGCOLOR IN BROWSE {&BROWSE-NAME}    = p-bgcolor
            Grupofam.cant_capitas:BGCOLOR IN BROWSE {&BROWSE-NAME}   = p-bgcolor 
            Grupofam.importe_cuota:BGCOLOR IN BROWSE {&BROWSE-NAME}  = p-bgcolor 
            Grupofam.fecha_alta:BGCOLOR IN BROWSE {&BROWSE-NAME}     = p-bgcolor 
            Grupofam.tipo_compbte:BGCOLOR IN BROWSE {&BROWSE-NAME}   = p-bgcolor.
            

      IF Grupofam.observacion = ""
         THEN hay_observaciones:BGCOLOR IN BROWSE {&BROWSE-NAME}     = p-bgcolor.
         ELSE hay_observaciones:BGCOLOR IN BROWSE {&BROWSE-NAME}     = 14.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


