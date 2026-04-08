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
&Scoped-define BROWSE-NAME br_afiliados

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Afiliado

/* Definitions for BROWSE br_afiliados                                  */
&Scoped-define FIELDS-IN-QUERY-br_afiliados hay_observaciones Afiliado.nom_afiliado Afiliado.calle_emr Afiliado.nropta_emr Afiliado.piso_emr Afiliado.prefijotel_emr Afiliado.telefono_emr Afiliado.cdg_plan Afiliado.cdg_afiliado Afiliado.fecha_baja   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_afiliados   
&Scoped-define FIELD-PAIRS-IN-QUERY-br_afiliados
&Scoped-define SELF-NAME br_afiliados
&Scoped-define OPEN-QUERY-br_afiliados  CASE buscar_por:      WHEN "NUMERO"      THEN DO:            que_numero = clave_buscar.           OPEN QUERY br_afiliados                FOR EACH Afiliado WHERE Afiliado.cdg_afiliado BEGINS que_numero                                    AND Afiliado.cdg_empresa = que_empresa                                        NO-LOCK.           br_afiliados:TITLE = "Afiliados que satisfacen la condición de búsqueda: POR NRO.AFILIADO=" + que_numero.           que_numero = "".       END.        WHEN "TELEFONO"      THEN DO:            que_prefijo  = ENTRY(1, ~
      clave_buscar, ~
      "-").           que_telefono = ENTRY(2, ~
      clave_buscar, ~
      "-").           OPEN QUERY br_afiliados                FOR EACH Afiliado WHERE Afiliado.telefono_emr CONTAINS que_telefono                                    AND Afiliado.prefijotel_emr BEGINS que_prefijo                                    AND Afiliado.cdg_empresa = que_empresa                                        NO-LOCK.           br_afiliados:TITLE = "Afiliados que satisfacen la condición de búsqueda: POR TELEFONO=" + que_telefono.           que_telefono = "".       END.       WHEN "PREFIJO"      THEN DO:      END.       WHEN "NOMBRE"      THEN DO:            que_nombre = clave_buscar.           IF SUBSTRING(que_nombre, ~
      LENGTH(que_nombre), ~
      1) <> "*"              THEN que_nombre = que_nombre + "*".           OPEN QUERY br_afiliados                FOR EACH Afiliado WHERE Afiliado.nom_afiliado CONTAINS que_nombre                                    AND Afiliado.cdg_empresa = que_empresa                                        NO-LOCK.           br_afiliados:TITLE = "Afiliados que satisfacen la condición de búsqueda: POR NOMBRE=" + que_nombre.           que_nombre = "".        END.       WHEN "CALLE"      THEN DO:            que_calle = clave_buscar.           IF SUBSTRING(que_calle, ~
      LENGTH(que_calle), ~
      1) <> "*"              THEN que_calle = que_calle + "*".           OPEN QUERY br_afiliados                FOR EACH Afiliado WHERE Afiliado.calle_emr CONTAINS que_calle                                    AND Afiliado.cdg_empresa = que_empresa                                        NO-LOCK.           br_afiliados:TITLE = "Afiliados que satisfacen la condición de búsqueda: POR CALLE=" + que_calle.           que_calle = "".        END.       OTHERWISE      DO:            OPEN QUERY {&SELF-NAME}                FOR EACH Afiliado WHERE Afiliado.cdg_empresa = que_empresa                    NO-LOCK INDEXED-REPOSITION.       END.   END CASE.
&Scoped-define TABLES-IN-QUERY-br_afiliados Afiliado
&Scoped-define FIRST-TABLE-IN-QUERY-br_afiliados Afiliado


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-br_afiliados}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS que_calle que_nropta btn_calle Btn_Done ~
que_nombre btn_nombre Btn_Done-2 que_prefijo que_telefono que_numero ~
btn_telefono btn_nsocio Btn_Salir br_afiliados 
&Scoped-Define DISPLAYED-OBJECTS que_calle que_nropta que_nombre ~
que_prefijo que_telefono que_numero 

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
     SIZE 35 BY 1.

DEFINE BUTTON Btn_Done DEFAULT 
     LABEL "&Elegir CON Domicilio" 
     SIZE 22 BY 1
     BGCOLOR 8 .

DEFINE BUTTON Btn_Done-2 DEFAULT 
     LABEL "&Elegir SIN Domicilio" 
     SIZE 22 BY 1
     BGCOLOR 8 .

DEFINE BUTTON btn_nombre 
     LABEL "Buscar por &Nombre" 
     SIZE 35 BY 1.

DEFINE BUTTON btn_nsocio 
     LABEL "Carne&t" 
     SIZE 17 BY 1.

DEFINE BUTTON Btn_Salir DEFAULT 
     LABEL "&Salir SIN ELEGIR" 
     SIZE 22 BY 1.12
     BGCOLOR 8 .

DEFINE BUTTON btn_telefono 
     LABEL "&Teléfono" 
     SIZE 17 BY 1.

DEFINE VARIABLE que_calle AS CHARACTER FORMAT "X(256)":U 
     LABEL "Calle" 
     VIEW-AS FILL-IN 
     SIZE 29 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE que_nombre AS CHARACTER FORMAT "X(256)":U 
     LABEL "Nombre" 
     VIEW-AS FILL-IN 
     SIZE 44 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE que_nropta AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE que_numero AS CHARACTER FORMAT "X(256)":U 
     LABEL "Nro. Socio" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE que_prefijo AS CHARACTER FORMAT "X(256)":U 
     LABEL "Teléfono" 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE que_telefono AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 9 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_afiliados FOR 
      Afiliado SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_afiliados
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_afiliados C-Win _FREEFORM
  QUERY br_afiliados NO-LOCK DISPLAY
      hay_observaciones   COLUMN-LABEL "Hay!Obs." FORMAT "****/"
      Afiliado.nom_afiliado
      Afiliado.calle_emr
      Afiliado.nropta_emr COLUMN-LABEL "Nro.!Puerta"
      Afiliado.piso_emr COLUMN-LABEL "Piso!Dom."
      Afiliado.prefijotel_emr COLUMN-LABEL "Carac!Telef"
      Afiliado.telefono_emr COLUMN-LABEL "Número!Teléfono"
      Afiliado.cdg_plan COLUMN-LABEL "Código!Plan"
      Afiliado.cdg_afiliado COLUMN-LABEL "Número!Afiliado"
      Afiliado.fecha_baja COLUMN-LABEL "Fecha!Baja"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 113 BY 16.96
         FONT 4
         TITLE "Afiliados que satisfacen la condición de búsqueda".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     que_calle AT ROW 1.27 COL 8 COLON-ALIGNED
     que_nropta AT ROW 1.27 COL 38 COLON-ALIGNED NO-LABEL
     btn_calle AT ROW 1.27 COL 56
     Btn_Done AT ROW 1.27 COL 92
     que_nombre AT ROW 2.62 COL 8 COLON-ALIGNED
     btn_nombre AT ROW 2.62 COL 56
     Btn_Done-2 AT ROW 2.62 COL 92
     que_prefijo AT ROW 3.96 COL 8 COLON-ALIGNED
     que_telefono AT ROW 3.96 COL 16 COLON-ALIGNED NO-LABEL
     que_numero AT ROW 3.96 COL 38 COLON-ALIGNED
     btn_telefono AT ROW 3.96 COL 56
     btn_nsocio AT ROW 3.96 COL 74
     Btn_Salir AT ROW 3.96 COL 92
     br_afiliados AT ROW 5.31 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 114.29 BY 21.27
         FONT 4
         DEFAULT-BUTTON Btn_Done.


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
         TITLE              = "Búsqueda de Afiliados"
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
/* BROWSE-TAB br_afiliados Btn_Salir DEFAULT-FRAME */
ASSIGN 
       br_afiliados:POPUP-MENU IN FRAME DEFAULT-FRAME         = MENU POPUP-MENU-br_afiliados:HANDLE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_afiliados
/* Query rebuild information for BROWSE br_afiliados
     _START_FREEFORM

CASE buscar_por:
     WHEN "NUMERO"
     THEN DO:

          que_numero = clave_buscar.
          OPEN QUERY br_afiliados
               FOR EACH Afiliado WHERE Afiliado.cdg_afiliado BEGINS que_numero
                                   AND Afiliado.cdg_empresa = que_empresa
                                       NO-LOCK.
          br_afiliados:TITLE = "Afiliados que satisfacen la condición de búsqueda: POR NRO.AFILIADO=" + que_numero.
          que_numero = "".

     END.


     WHEN "TELEFONO"
     THEN DO:

          que_prefijo  = ENTRY(1,clave_buscar,"-").
          que_telefono = ENTRY(2,clave_buscar,"-").
          OPEN QUERY br_afiliados
               FOR EACH Afiliado WHERE Afiliado.telefono_emr CONTAINS que_telefono
                                   AND Afiliado.prefijotel_emr BEGINS que_prefijo
                                   AND Afiliado.cdg_empresa = que_empresa
                                       NO-LOCK.
          br_afiliados:TITLE = "Afiliados que satisfacen la condición de búsqueda: POR TELEFONO=" + que_telefono.
          que_telefono = "".

     END.

     WHEN "PREFIJO"
     THEN DO:
     END.

     WHEN "NOMBRE"
     THEN DO:

          que_nombre = clave_buscar.
          IF SUBSTRING(que_nombre,LENGTH(que_nombre),1) <> "*"
             THEN que_nombre = que_nombre + "*".
          OPEN QUERY br_afiliados
               FOR EACH Afiliado WHERE Afiliado.nom_afiliado CONTAINS que_nombre
                                   AND Afiliado.cdg_empresa = que_empresa
                                       NO-LOCK.
          br_afiliados:TITLE = "Afiliados que satisfacen la condición de búsqueda: POR NOMBRE=" + que_nombre.
          que_nombre = "".


     END.

     WHEN "CALLE"
     THEN DO:

          que_calle = clave_buscar.
          IF SUBSTRING(que_calle,LENGTH(que_calle),1) <> "*"
             THEN que_calle = que_calle + "*".
          OPEN QUERY br_afiliados
               FOR EACH Afiliado WHERE Afiliado.calle_emr CONTAINS que_calle
                                   AND Afiliado.cdg_empresa = que_empresa
                                       NO-LOCK.
          br_afiliados:TITLE = "Afiliados que satisfacen la condición de búsqueda: POR CALLE=" + que_calle.
          que_calle = "".


     END.

     OTHERWISE
     DO:

          OPEN QUERY {&SELF-NAME}
               FOR EACH Afiliado WHERE Afiliado.cdg_empresa = que_empresa
                   NO-LOCK INDEXED-REPOSITION.

     END.


END CASE.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Query            is OPENED
*/  /* BROWSE br_afiliados */
&ANALYZE-RESUME

 




/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Búsqueda de Afiliados */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Búsqueda de Afiliados */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_afiliados
&Scoped-define SELF-NAME br_afiliados
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_afiliados C-Win
ON MOUSE-SELECT-DBLCLICK OF br_afiliados IN FRAME DEFAULT-FRAME /* Afiliados que satisfacen la condición de búsqueda */
DO:
  RUN d-obs_afiliado ( INPUT ROWID(Afiliado)). 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_afiliados C-Win
ON ROW-DISPLAY OF br_afiliados IN FRAME DEFAULT-FRAME /* Afiliados que satisfacen la condición de búsqueda */
DO:
 
   hay_observaciones = Afiliado.observacion <> "".
   IF Afiliado.cdg_estado = "A"  
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
        OPEN QUERY br_afiliados 
             FOR EACH Afiliado 
                 WHERE Afiliado.calle_emr CONTAINS que_calle 
                   AND Afiliado.cdg_empresa = que_empresa
                       NO-LOCK.
        br_afiliados:TITLE = "Afiliados que satisfacen la condición de búsqueda: POR CALLE=" + que_calle.
        que_calle = "".
        DISPLAY que_calle.
     END.
     ELSE DO:
        OPEN QUERY br_afiliados 
             FOR EACH Afiliado 
                 WHERE Afiliado.calle_emr CONTAINS que_calle 
                   AND Afiliado.nropta CONTAINS que_nropta 
                   AND Afiliado.cdg_empresa = que_empresa
                       NO-LOCK.
        br_afiliados:TITLE = "Afiliados que satisfacen la condición de búsqueda: POR CALLE y NUMERO =" + que_calle + " " + que_nropta.
        que_calle = "".
        que_nropta = "".  
        DISPLAY que_calle
                que_nropta.
     END.

  END.   

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Done
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Done C-Win
ON CHOOSE OF Btn_Done IN FRAME DEFAULT-FRAME /* Elegir CON Domicilio */
DO:
  
  rid_afiliado = ROWID(Afiliado).
  puso_ok = YES.
  
  &IF DEFINED (adm-panel) <> 0 &THEN
      RUN dispatch IN THIS-PROCEDURE ('exit').
  &ELSE
      APPLY "CLOSE":U TO THIS-PROCEDURE.
  &ENDIF
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Done-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Done-2 C-Win
ON CHOOSE OF Btn_Done-2 IN FRAME DEFAULT-FRAME /* Elegir SIN Domicilio */
DO:
  
  rid_afiliado = ROWID(Afiliado).
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
     OPEN QUERY br_afiliados 
          FOR EACH Afiliado WHERE Afiliado.nom_afiliado CONTAINS que_nombre
                              AND Afiliado.cdg_empresa = que_empresa
                                  NO-LOCK.
     br_afiliados:TITLE = "Afiliados que satisfacen la condición de búsqueda: POR NOMBRE=" + que_nombre.
     que_nombre = "".
     DISPLAY que_nombre.

  END.   

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_nsocio
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_nsocio C-Win
ON CHOOSE OF btn_nsocio IN FRAME DEFAULT-FRAME /* Carnet */
DO:

  DO WITH FRAME DEFAULT-FRAME:

     ASSIGN que_numero.
          OPEN QUERY br_afiliados 
               FOR EACH Afiliado WHERE Afiliado.cdg_afiliado BEGINS que_numero 
                                   AND Afiliado.cdg_empresa = que_empresa
                                       NO-LOCK.
          br_afiliados:TITLE = "Afiliados que satisfacen la condición de búsqueda: POR N.AFILIADO=" + que_numero.
          que_numero = "".

  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Salir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Salir C-Win
ON CHOOSE OF Btn_Salir IN FRAME DEFAULT-FRAME /* Salir SIN ELEGIR */
DO:
  &IF DEFINED (adm-panel) <> 0 &THEN
      RUN dispatch IN THIS-PROCEDURE ('exit').
  &ELSE
      APPLY "CLOSE":U TO THIS-PROCEDURE.
  &ENDIF
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_telefono
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_telefono C-Win
ON CHOOSE OF btn_telefono IN FRAME DEFAULT-FRAME /* Teléfono */
DO:

  DO WITH FRAME DEFAULT-FRAME:

     ASSIGN que_prefijo que_telefono.
          OPEN QUERY br_afiliados 
               FOR EACH Afiliado WHERE Afiliado.telefono_emr CONTAINS que_telefono 
                                   AND Afiliado.prefijotel_emr BEGINS que_prefijo 
                                   AND Afiliado.cdg_empresa = que_empresa
                                       NO-LOCK.
          br_afiliados:TITLE = "Afiliados que satisfacen la condición de búsqueda: POR TELEFONO=" + que_telefono.
          que_telefono = "".

  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Con_Domicilio
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Con_Domicilio C-Win
ON CHOOSE OF MENU-ITEM m_Con_Domicilio /* Con Domicilio */
DO:
  APPLY "CHOOSE" TO btn_done IN FRAME {&FRAME-NAME}.
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
  DISPLAY que_calle que_nropta que_nombre que_prefijo que_telefono que_numero 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE que_calle que_nropta btn_calle Btn_Done que_nombre btn_nombre 
         Btn_Done-2 que_prefijo que_telefono que_numero btn_telefono btn_nsocio 
         Btn_Salir br_afiliados 
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
            Afiliado.nom_afiliado:FGCOLOR IN BROWSE {&BROWSE-NAME}   = p-fgcolor
            Afiliado.calle_emr:FGCOLOR IN BROWSE {&BROWSE-NAME}      = p-fgcolor
            Afiliado.nropta_emr:FGCOLOR IN BROWSE {&BROWSE-NAME}     = p-fgcolor
            Afiliado.piso_emr:FGCOLOR IN BROWSE {&BROWSE-NAME}       = p-fgcolor
            Afiliado.prefijotel_emr:FGCOLOR IN BROWSE {&BROWSE-NAME} = p-fgcolor
            Afiliado.telefono_emr:FGCOLOR IN BROWSE {&BROWSE-NAME}   = p-fgcolor
            Afiliado.cdg_plan:FGCOLOR IN BROWSE {&BROWSE-NAME}       = p-fgcolor
            Afiliado.cdg_afiliado:FGCOLOR IN BROWSE {&BROWSE-NAME}   = p-fgcolor
            Afiliado.fecha_baja:FGCOLOR IN BROWSE {&BROWSE-NAME}     = p-fgcolor.

      ASSIGN
            Afiliado.nom_afiliado:BGCOLOR IN BROWSE {&BROWSE-NAME}   = p-bgcolor
            Afiliado.calle_emr:BGCOLOR IN BROWSE {&BROWSE-NAME}      = p-bgcolor
            Afiliado.nropta_emr:BGCOLOR IN BROWSE {&BROWSE-NAME}     = p-bgcolor
            Afiliado.piso_emr:BGCOLOR IN BROWSE {&BROWSE-NAME}       = p-bgcolor
            Afiliado.prefijotel_emr:BGCOLOR IN BROWSE {&BROWSE-NAME} = p-bgcolor
            Afiliado.telefono_emr:BGCOLOR IN BROWSE {&BROWSE-NAME}   = p-bgcolor
            Afiliado.cdg_plan:BGCOLOR IN BROWSE {&BROWSE-NAME}       = p-bgcolor
            Afiliado.cdg_afiliado:BGCOLOR IN BROWSE {&BROWSE-NAME}   = p-bgcolor.

      IF Afiliado.observacion = ""
         THEN hay_observaciones:BGCOLOR IN BROWSE {&BROWSE-NAME}     = p-bgcolor.
         ELSE hay_observaciones:BGCOLOR IN BROWSE {&BROWSE-NAME}     = 14.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


