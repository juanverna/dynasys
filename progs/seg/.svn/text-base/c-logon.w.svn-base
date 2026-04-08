&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
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

/* Local Variable Definitions ---                                       */

  &IF DEFINED(UIB_is_Running) NE 0
  &THEN
  DEFINE VARIABLE p-cdg_salida            AS INTEGER.
  DEFINE VARIABLE p-entidad_logon         LIKE Entidad.nro_entidad.
  &ELSE
  DEFINE OUTPUT PARAMETER p-cdg_salida    AS INTEGER.   
  DEFINE OUTPUT PARAMETER p-entidad_logon LIKE Entidad.nro_entidad.
  &ENDIF

  DEFINE VARIABLE intentos                AS INTEGER INITIAL 0 NO-UNDO.
  DEFINE VARIABLE intentos_usuario        AS INTEGER INITIAL 0 NO-UNDO.
  DEFINE VARIABLE pcnombre                AS CHARACTER.

  DEFINE VARIABLE v-reconectar            AS LOGICAL INITIAL YES.

  {valoressalida.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-1 IMAGE-2 v-cdg_usuario v-clave Btn_OK ~
Btn_Done 
&Scoped-Define DISPLAYED-OBJECTS v-cdg_usuario v-clave v-cdg_lenguaje ~
v-fecha_proceso 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Done DEFAULT 
     LABEL "&Cancelar" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK 
     LABEL "OK" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE VARIABLE v-cdg_lenguaje AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Castellano - Argentina","SPAARG"
     DROP-DOWN-LIST
     SIZE 47 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cdg_usuario AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 30 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-clave AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 30 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-fecha_proceso AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE IMAGE IMAGE-2 CONVERT-3D-COLORS
     STRETCH-TO-FIT RETAIN-SHAPE
     SIZE 61 BY 2.62.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 4 GRAPHIC-EDGE  NO-FILL   
     SIZE 65 BY 9.76.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     v-cdg_usuario AT ROW 5.76 COL 3 COLON-ALIGNED NO-LABEL
     v-clave AT ROW 5.76 COL 34 COLON-ALIGNED NO-LABEL BLANK 
     v-cdg_lenguaje AT ROW 8.14 COL 3 COLON-ALIGNED NO-LABEL WIDGET-ID 14
     v-fecha_proceso AT ROW 8.14 COL 51 COLON-ALIGNED NO-LABEL WIDGET-ID 12
     Btn_OK AT ROW 9.33 COL 5
     Btn_Done AT ROW 9.33 COL 51
     "    Nombre del usuario" VIEW-AS TEXT
          SIZE 30 BY 1 AT ROW 4.57 COL 5 WIDGET-ID 4
          BGCOLOR 1 FGCOLOR 15 FONT 6
     "    Clave de acceso" VIEW-AS TEXT
          SIZE 30 BY 1 AT ROW 4.57 COL 36 WIDGET-ID 6
          BGCOLOR 1 FGCOLOR 15 FONT 6
     "    Idioma" VIEW-AS TEXT
          SIZE 47 BY 1 AT ROW 6.95 COL 5 WIDGET-ID 16
          BGCOLOR 1 FGCOLOR 15 FONT 6
     "    Fecha" VIEW-AS TEXT
          SIZE 13 BY 1 AT ROW 6.95 COL 53 WIDGET-ID 10
          BGCOLOR 1 FGCOLOR 15 FONT 6
     RECT-1 AT ROW 1.24 COL 3
     IMAGE-2 AT ROW 1.71 COL 5 WIDGET-ID 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 68.4 BY 10.29
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
         TITLE              = "Identificación del Usuario"
         HEIGHT             = 10.29
         WIDTH              = 68.4
         MAX-HEIGHT         = 13.81
         MAX-WIDTH          = 129.2
         VIRTUAL-HEIGHT     = 13.81
         VIRTUAL-WIDTH      = 129.2
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



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME                                                           */
/* SETTINGS FOR COMBO-BOX v-cdg_lenguaje IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-fecha_proceso IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME DEFAULT-FRAME
/* Query rebuild information for FRAME DEFAULT-FRAME
     _Query            is NOT OPENED
*/  /* FRAME DEFAULT-FRAME */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Identificación del Usuario */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Identificación del Usuario */
DO:
  /* This event will close the window and terminate the procedure.  */
  /*APPLY "CLOSE":U TO THIS-PROCEDURE.*/
  APPLY "CHOOSE":U TO Btn_Done IN FRAME {&FRAME-NAME}.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Done
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Done C-Win
ON CHOOSE OF Btn_Done IN FRAME DEFAULT-FRAME /* Cancelar */
DO:
    &IF DEFINED (adm-panel) <> 0 &THEN
        RUN dispatch IN THIS-PROCEDURE ('exit').
    &ELSE
/*      APPLY "CLOSE":U TO THIS-PROCEDURE.*/
        ASSIGN codigo_salir = CD_SALIR.
        APPLY "U1":U TO THIS-PROCEDURE.
    &ENDIF

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK C-Win
ON CHOOSE OF Btn_OK IN FRAME DEFAULT-FRAME /* OK */
DO:
    
    RUN validar_login.
    IF RETURN-VALUE = "SALIR"
        THEN APPLY "U1" TO THIS-PROCEDURE.
        ELSE RETURN NO-APPLY.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-fecha_proceso
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-fecha_proceso C-Win
ON RETURN OF v-fecha_proceso IN FRAME DEFAULT-FRAME
DO:
  APPLY "CHOOSE" TO btn_ok.
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

ASSIGN v-cdg_lenguaje = "SPAARG"
       v-fecha_proceso = TODAY.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
ASSIGN
         {&WINDOW-NAME}:ROW     = ( SESSION:HEIGHT-PIXELS - {&WINDOW-NAME}:HEIGHT-PIXELS ) / 
                                 SESSION:PIXELS-PER-ROW / 2  
         {&WINDOW-NAME}:COLUMN  = ( SESSION:WIDTH-PIXELS  - {&WINDOW-NAME}:WIDTH-PIXELS  ) / 
                                 SESSION:PIXELS-PER-COLUMN / 2.

IF {&WINDOW-NAME}:COLUMN = 0  THEN {&WINDOW-NAME}:COLUMN = 1.                                 
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.

  image-2:LOAD-IMAGE(SEARCH("../imagenes/logo.bmp")).
  DISPLAY v-fecha_proceso v-cdg_lenguaje
      WITH FRAME {&FRAME-NAME}.
/*IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.*/
  WAIT-FOR "U1" OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI C-Win  _DEFAULT-DISABLE
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI C-Win  _DEFAULT-ENABLE
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
  DISPLAY v-cdg_usuario v-clave v-cdg_lenguaje v-fecha_proceso 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE RECT-1 IMAGE-2 v-cdg_usuario v-clave Btn_OK Btn_Done 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE mostrar_frase C-Win 
PROCEDURE mostrar_frase :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE ultimo AS INTEGER.
  
  FIND LAST Frase_bienvenida.
  ultimo = Frase_bienvenida.nro_frase.

  FIND FIRST Frase_bienvenida WHERE Frase_bienvenida.nro_frase >= RANDOM(1,ultimo) NO-LOCK.
  MESSAGE Frase_bienvenida.texto VIEW-AS ALERT-BOX MESSAGE TITLE "Bienvenido a SIC. Su frase del día".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE validar_login C-Win 
PROCEDURE validar_login :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE lOk    AS LOGICAL.
  DEFINE VARIABLE lOkset AS LOGICAL.

  ASSIGN FRAME {&FRAME-NAME} v-cdg_usuario v-clave v-fecha_proceso v-cdg_lenguaje.

  FIND Usuario WHERE Usuario.cdg_usuario = v-cdg_usuario NO-LOCK NO-ERROR.
  IF NOT AVAILABLE Usuario
  THEN DO:
      intentos_usuario = intentos_usuario + 1.
      RUN ponmensj.p ( INPUT "SEGU005" ).
      IF intentos_usuario < 2 
          THEN RETURN.
          ELSE DO:
              p-cdg_salida = CD_CANCELAR.
              RETURN "SALIR".
          END.
  END.

  IF Usuario.estado <> "A" 
  THEN DO:
      RUN ponmensj.p ( INPUT "SEGU011").
      RETURN.
  END.
  
  RUN pcname1.p ( OUTPUT pcnombre ).
  IF NOT CAN-DO(Usuario.estaciones_habilitadas,pcnombre) 
  THEN DO:
      RUN ponmensj.p ( INPUT "SEGU009" ).
      RETURN.
  END.

  IF Usuario.clave <> ENCODE(v-clave)
  THEN DO:
      intentos = intentos + 1.
      RUN ponmensj.p ( INPUT "SEGU006" ).
      IF Usuario.cant_loginerroneos <> 0 AND intentos >=  Usuario.cant_loginerroneos 
      THEN DO:
          p-cdg_salida = CD_CANCELAR.
          RETURN "SALIR".
      END.
      ELSE DO:
          RETURN.
      END.
          
  END.

  IF  /* Si esta conectado a la base Y está corriendo la aplicación (puede estar en modo desarrollo)....error  */
      CAN-FIND(FIRST _Connect WHERE _Connect._Connect-name = Usuario.cdg_usuario AND LOOKUP(_Connect._Connect-Type,"SELF,REMC") <> 0) AND 
      CAN-FIND(FIRST Modulo-sic WHERE Modulo-sic.cdg_sigla-sic = "BAS" AND LOOKUP(Usuario.cdg_usuario,Modulo-sic.usuarios_conectados) <> 0 )
  THEN DO:
      RUN ponmensj.p ( INPUT "SEGU007").
      RETURN.
  END.

  IF NOT CAN-FIND(FIRST User_empresa OF Usuario 
                  WHERE User_empresa.rige_desde <= v-fecha_proceso
                    AND User_empresa.rige_hasta >= v-fecha_proceso)
  THEN DO:
      RUN ponmensj.p ( INPUT "SEGU013" ).
      p-cdg_salida = CD_CANCELAR.
      RETURN "SALIR".
  END.

  IF Usuario.dias_inactivo > 0 AND v-fecha_proceso - Usuario.fch_ultimologin > Usuario.dias_inactivo
  THEN DO:
      RUN ponmensj.p ( INPUT "SEGU012" ).
      p-cdg_salida = CD_CANCELAR.
      RETURN "SALIR".
  END.
  
/*aca*/
  lOkset = SETUSERID(Usuario.cdg_usuario,v-clave,"sic").
IF NOT lOkset
    THEN do: 
        MESSAGE "No pudo fijarse el usuario de base de datos"
        VIEW-AS ALERT-BOX INFO BUTTONS OK TITLE "ERROR DE SEGURIDAD".
        RETURN ERROR.
END.

IF Usuario.cambiar_clave OR (Usuario.dias_clave > 0 AND v-fecha_proceso - Usuario.fch_ultimaclave > Usuario.dias_clave )
THEN DO:
  RUN d-asignar_clave.w ( OUTPUT lok ).
  IF NOT lok
  THEN DO:
      RUN ponmensj.p ( INPUT "SEGU010" ).
      p-cdg_salida = CD_CANCELAR.
      RETURN "SALIR".
  END.
END.





IF Usuario.mostrar_frase THEN RUN mostrar_frase.

  
  
  
  
  DO TRANSACTION:

      FIND CURRENT Usuario EXCLUSIVE-LOCK.  
      Usuario.lista_empresas = "".
      FOR EACH User_empresa OF Usuario 
          WHERE User_empresa.rige_desde <= v-fecha_proceso
            AND User_empresa.rige_hasta >= v-fecha_proceso
            AND CAN-FIND(FIRST Empresa OF User_empresa) NO-LOCK:

                Usuario.lista_empresas = Usuario.lista_empresas + "," + User_empresa.cdg_empresa.

      END.

      Usuario.lista_empresas = SUBSTRING(Usuario.lista_empresas,2).
      Usuario.cdg_empresa = ENTRY(1,Usuario.lista_empresas,",").
      Usuario.cambiar_clave = NO.
      Usuario.fch_ultimologin = v-fecha_proceso.

      FIND FIRST Logusuario OF Usuario WHERE Logusuario.abierta EXCLUSIVE-LOCK NO-ERROR.

      IF AVAILABLE Logusuario
      THEN DO:
          ASSIGN Logusuario.abierta    = NO
                 Logusuario.fch_hasta  = v-fecha_proceso
                 Logusuario.hor_hasta  = TIME
                 Logusuario.hms_hasta  = STRING(Logusuario.hor_hasta,"HH:MM:SS").
      END.

      CREATE Logusuario.
      ASSIGN Logusuario.abierta          = YES
             Logusuario.cdg_empresa      = Usuario.cdg_empresa
             Logusuario.fch_desde        = v-fecha_proceso
             Logusuario.hor_desde        = TIME
             Logusuario.hms_desde        = STRING(Logusuario.hor_desde,"HH:MM:SS")
             Logusuario.fch_hasta        = ?
             Logusuario.hor_hasta        = ?
             Logusuario.hms_hasta        = ?
             Logusuario.fecha_sistema    = v-fecha_proceso
             Logusuario.nro_sesion       = NEXT-VALUE(proxima_sesion)
             Logusuario.nro_usuario      = Usuario.nro_usuario
             Logusuario.parametros       = ""
             Logusuario.pc_name          = pcnombre.
      FIND CURRENT Usuario NO-LOCK.

      FIND Entidad WHERE Entidad.cdg_entidad = Usuario.cdg_empresa NO-LOCK.
      p-entidad_logon = Entidad.nro_entidad.

  END.


  RELEASE Usuario.
  RELEASE Logusuario.

  ASSIGN p-cdg_salida = CD_GRABAR.
  RETURN "SALIR".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

