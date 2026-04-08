&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win

/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Ciclo_novedades NO-UNDO LIKE Ciclo_novedades.
DEFINE TEMP-TABLE T-Parte_novedades NO-UNDO LIKE Parte_novedades.


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
/*          This .W file was created with the Progress AppBuilder.      */
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

DEFINE VARIABLE hay_error                 AS LOGICAL NO-UNDO.
DEFINE VARIABLE sino-msg                  AS LOGICAL NO-UNDO.
DEFINE VARIABLE rid_tabla                 AS ROWID   NO-UNDO.

{valoressalida.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Ciclo_novedades

/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define FIELDS-IN-QUERY-DEFAULT-FRAME T-Ciclo_novedades.nro_ciclo ~
T-Ciclo_novedades.descripcion T-Ciclo_novedades.fecha_desde T-Ciclo_novedades.fecha_hasta T-Ciclo_novedades.activo 
&Scoped-define QUERY-STRING-DEFAULT-FRAME FOR EACH T-Ciclo_novedades SHARE-LOCK
&Scoped-define OPEN-QUERY-DEFAULT-FRAME OPEN QUERY DEFAULT-FRAME FOR EACH T-Ciclo_novedades SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-DEFAULT-FRAME T-Ciclo_novedades
&Scoped-define FIRST-TABLE-IN-QUERY-DEFAULT-FRAME T-Ciclo_novedades


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS T-Parte_novedades.fecha ~
T-Parte_novedades.valor T-Parte_novedades.observacion 
&Scoped-define ENABLED-TABLES T-Parte_novedades
&Scoped-define FIRST-ENABLED-TABLE T-Parte_novedades
&Scoped-Define ENABLED-OBJECTS v-cdg_empleado v-cdg_destino v-cdg_novedad ~
btn_grabar btn_salir v-fijar_empleado v-fijar_destino v-fijar_novedad ~
RECT-6 
&Scoped-Define DISPLAYED-FIELDS T-Parte_novedades.fecha ~
T-Parte_novedades.valor T-Parte_novedades.observacion T-Ciclo_novedades.nro_ciclo ~
T-Ciclo_novedades.descripcion T-Ciclo_novedades.fecha_desde T-Ciclo_novedades.fecha_hasta T-Ciclo_novedades.activo 
&Scoped-define DISPLAYED-TABLES T-Parte_novedades T-Ciclo_novedades
&Scoped-define FIRST-DISPLAYED-TABLE T-Parte_novedades
&Scoped-define SECOND-DISPLAYED-TABLE T-Ciclo_novedades
&Scoped-Define DISPLAYED-OBJECTS v-cdg_empleado v-cdg_destino v-cdg_novedad ~
v-fijar_empleado v-fijar_destino v-fijar_novedad v-dsc_empleado ~
v-dsc_destino v-dsc_novedad 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btn_grabar 
     LABEL "&Grabar" 
     SIZE 15 BY 1.14.

DEFINE BUTTON btn_salir 
     LABEL "&Salir" 
     SIZE 15 BY 1.14.

DEFINE VARIABLE v-cdg_destino AS INTEGER FORMAT "->,>>>,>>9" INITIAL 0 
     LABEL "Destino" 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_empleado AS INTEGER FORMAT "->,>>>,>>9" INITIAL 0 
     LABEL "Empleado" 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_novedad AS INTEGER FORMAT "->,>>>,>>9" INITIAL 0 
     LABEL "Novedad" 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-dsc_destino AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 52 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_empleado AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 52 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_novedad AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 52 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 6 GRAPHIC-EDGE  NO-FILL 
     SIZE 107 BY 14.52.

DEFINE VARIABLE v-fijar_destino AS LOGICAL INITIAL no 
     LABEL "Fijar Destino" 
     VIEW-AS TOGGLE-BOX
     SIZE 19 BY 1.05 NO-UNDO.

DEFINE VARIABLE v-fijar_empleado AS LOGICAL INITIAL no 
     LABEL "Fijar Empleado" 
     VIEW-AS TOGGLE-BOX
     SIZE 19 BY 1.05 NO-UNDO.

DEFINE VARIABLE v-fijar_novedad AS LOGICAL INITIAL no 
     LABEL "Fijar Novedad" 
     VIEW-AS TOGGLE-BOX
     SIZE 19 BY 1.05 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY DEFAULT-FRAME FOR 
      T-Ciclo_novedades SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     v-cdg_empleado AT ROW 4.33 COL 15 COLON-ALIGNED
     v-cdg_destino AT ROW 5.52 COL 15 COLON-ALIGNED
     v-cdg_novedad AT ROW 6.71 COL 15 COLON-ALIGNED
     T-Parte_novedades.fecha AT ROW 7.91 COL 15 COLON-ALIGNED FORMAT "99/99/99"
          VIEW-AS FILL-IN 
          SIZE 15 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Parte_novedades.valor AT ROW 7.91 COL 64 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 18.8 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Parte_novedades.observacion AT ROW 10.29 COL 6 NO-LABEL
          VIEW-AS EDITOR
          SIZE 101 BY 3.33
          BGCOLOR 15 FGCOLOR 9 
     btn_grabar AT ROW 13.86 COL 6
     btn_salir AT ROW 13.86 COL 92
     v-fijar_empleado AT ROW 4.33 COL 87
     v-fijar_destino AT ROW 5.52 COL 87
     v-fijar_novedad AT ROW 6.71 COL 87
     T-Ciclo_novedades.nro_ciclo AT ROW 2.91 COL 4 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 13 BY 1
          BGCOLOR 9 FGCOLOR 15 
     T-Ciclo_novedades.descripcion AT ROW 2.91 COL 18 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 36 BY 1
          BGCOLOR 9 FGCOLOR 15 
     T-Ciclo_novedades.fecha_desde AT ROW 2.91 COL 56 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 13 BY 1
          BGCOLOR 9 FGCOLOR 15 
     T-Ciclo_novedades.fecha_hasta AT ROW 2.91 COL 70 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 13 BY 1
          BGCOLOR 9 FGCOLOR 15 
     T-Ciclo_novedades.activo AT ROW 2.91 COL 101 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 4 BY 1
          BGCOLOR 9 FGCOLOR 15 
     v-dsc_empleado AT ROW 4.33 COL 31 COLON-ALIGNED NO-LABEL
     v-dsc_destino AT ROW 5.52 COL 31 COLON-ALIGNED NO-LABEL
     v-dsc_novedad AT ROW 6.71 COL 31 COLON-ALIGNED NO-LABEL
     RECT-6 AT ROW 1.24 COL 3
     "     Observaciones asociadas a la novedad" VIEW-AS TEXT
          SIZE 101 BY 1 AT ROW 9.1 COL 6
          BGCOLOR 5 FGCOLOR 15 
     "     Ciclo_novedades al que corresponde la novedad" VIEW-AS TEXT
          SIZE 50 BY 1 AT ROW 1.71 COL 6
          BGCOLOR 5 FGCOLOR 15 
     "     Periodo que abarca el Ciclo_novedades" VIEW-AS TEXT
          SIZE 49 BY 1 AT ROW 1.71 COL 58
          BGCOLOR 5 FGCOLOR 15 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 111.2 BY 16.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Ciclo_novedades T "?" NO-UNDO sic Ciclo_novedades
      TABLE: T-Parte_novedades T "?" NO-UNDO sic Parte_novedades
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Ingreso de novedades de parte diario"
         HEIGHT             = 16
         WIDTH              = 111.2
         MAX-HEIGHT         = 16
         MAX-WIDTH          = 111.2
         VIRTUAL-HEIGHT     = 16
         VIRTUAL-WIDTH      = 111.2
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
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME DEFAULT-FRAME
   Custom                                                               */
/* SETTINGS FOR FILL-IN T-Ciclo_novedades.activo IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Ciclo_novedades.descripcion IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Parte_novedades.fecha IN FRAME DEFAULT-FRAME
   EXP-FORMAT                                                           */
/* SETTINGS FOR FILL-IN T-Ciclo_novedades.fecha_desde IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN T-Ciclo_novedades.fecha_hasta IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN T-Ciclo_novedades.nro_ciclo IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN v-dsc_destino IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_empleado IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_novedad IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME DEFAULT-FRAME
/* Query rebuild information for FRAME DEFAULT-FRAME
     _TblList          = "Temp-Tables.T-Ciclo_novedades"
     _Query            is OPENED
*/  /* FRAME DEFAULT-FRAME */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Ingreso de novedades de parte diario */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Ingreso de novedades de parte diario */
DO:
  /* This event will close the window and terminate the procedure.  */
  /* APPLY "CLOSE":U TO THIS-PROCEDURE. */
  APPLY "CHOOSE":U TO Btn_salir IN FRAME {&FRAME-NAME}.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_grabar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_grabar C-Win
ON CHOOSE OF btn_grabar IN FRAME DEFAULT-FRAME /* Grabar */
DO:

  ASSIGN FRAME {&FRAME-NAME}
      v-cdg_destino 
      v-cdg_empleado 
      v-cdg_novedad 
      v-fijar_destino 
      v-fijar_empleado 
      v-fijar_novedad 
      T-Parte_novedades.fecha
      T-Parte_novedades.observacion
      T-Parte_novedades.valor.
         
  RUN validar_datos ( OUTPUT hay_error ).
  IF NOT hay_error
  THEN DO:

       RUN grabar_datos.

       ASSIGN codigo_salir = CD_GRABAR.
       APPLY "U1" TO THIS-PROCEDURE.
  
  END.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_salir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_salir C-Win
ON CHOOSE OF btn_salir IN FRAME DEFAULT-FRAME /* Salir */
DO:
    sino-msg = NO.
    MESSAGE "Desea abandonar esta función?" 
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
    IF sino-msg
    THEN DO:
        &IF DEFINED (adm-panel) <> 0 &THEN
            RUN dispatch IN THIS-PROCEDURE ('exit').
        &ELSE
/*          APPLY "CLOSE":U TO THIS-PROCEDURE.*/
            ASSIGN codigo_salir = CD_SALIR.
            APPLY "U1":U TO THIS-PROCEDURE.

        &ENDIF

    END.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_destino
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_destino C-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_destino IN FRAME DEFAULT-FRAME /* Destino */
OR "." OF v-cdg_destino IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_destino IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "destino" "cdg_destino" "SELDESTI.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_destino C-Win
ON RETURN OF v-cdg_destino IN FRAME DEFAULT-FRAME /* Destino */
DO:

    &SCOPED-DEFINE PONER-TABLA RUN poner_destino.          
   {traducetabla.i "destino" "cdg_destino" "nombre"}
    &UNDEFINE PONER-TABLA                                  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_empleado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_empleado C-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_empleado IN FRAME DEFAULT-FRAME /* Empleado */
OR "." OF v-cdg_empleado IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_empleado IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "empleado" "nro_legajo" "SELEMPLE.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_empleado C-Win
ON RETURN OF v-cdg_empleado IN FRAME DEFAULT-FRAME /* Empleado */
DO:

    &SCOPED-DEFINE PONER-TABLA RUN poner_empleado.          
   {traducetabla.i "empleado" "nro_legajo" "nombre"}
   &UNDEFINE PONER-TABLA                                  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_novedad
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_novedad C-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_novedad IN FRAME DEFAULT-FRAME /* Novedad */
OR "." OF v-cdg_novedad IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_novedad IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "novedad" "cdg_novedad" "SELNOVED.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_novedad C-Win
ON RETURN OF v-cdg_novedad IN FRAME DEFAULT-FRAME /* Novedad */
DO:

    &SCOPED-DEFINE PONER-TABLA RUN poner_novedad.          
   {traducetabla.i "novedad" "cdg_novedad" "descripcion"}
    &UNDEFINE PONER-TABLA                                  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-fijar_destino
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-fijar_destino C-Win
ON VALUE-CHANGED OF v-fijar_destino IN FRAME DEFAULT-FRAME /* Fijar Destino */
DO:
  IF NOT v-fijar_destino:INPUT-VALUE IN FRAME {&FRAME-NAME}
      THEN v-cdg_destino:SENSITIVE IN FRAME  {&FRAME-NAME} = YES.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-fijar_empleado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-fijar_empleado C-Win
ON VALUE-CHANGED OF v-fijar_empleado IN FRAME DEFAULT-FRAME /* Fijar Empleado */
DO:
  IF NOT v-fijar_empleado:INPUT-VALUE IN FRAME {&FRAME-NAME}
      THEN v-cdg_empleado:SENSITIVE IN FRAME  {&FRAME-NAME} = YES.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-fijar_novedad
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-fijar_novedad C-Win
ON VALUE-CHANGED OF v-fijar_novedad IN FRAME DEFAULT-FRAME /* Fijar Novedad */
DO:
  IF NOT v-fijar_novedad:INPUT-VALUE IN FRAME {&FRAME-NAME}
      THEN v-cdg_novedad:SENSITIVE IN FRAME  {&FRAME-NAME} = YES.  
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

FIND FIRST Ciclo_novedades WHERE Ciclo_novedades.actual NO-LOCK NO-ERROR.
IF NOT AVAILABLE Ciclo_novedades
THEN DO:
    DO TRANSACTION:
        FIND FIRST Ciclo_novedades EXCLUSIVE-LOCK.
        Ciclo_novedades.actual = YES.
        FIND CURRENT Ciclo_novedades NO-LOCK.
    END.
END.   
DO TRANSACTION:
    CREATE T-Ciclo_novedades.
    BUFFER-COPY Ciclo_novedades TO T-Ciclo_novedades.
END.

ASSIGN v-fijar_empleado = NO
       v-fijar_destino  = NO
       v-fijar_novedad  = NO.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
REPEAT ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  /*
  RUN iniciar_documento.
  RUN frame_sensitiva ( INPUT NO ).  
  */
  RUN crear_registro.
  /*
  IF modo = MD_DEFINIDA
     THEN RUN traer_documento.
     ELSE RUN 
  */
  RUN frame_sensitiva ( INPUT YES ).
  IF NOT v-fijar_empleado 
     THEN APPLY "ENTRY" TO v-cdg_empleado.
     ELSE IF NOT v-fijar_destino 
             THEN APPLY "ENTRY" TO v-cdg_destino.
             ELSE IF NOT v-fijar_novedad 
                     THEN APPLY "ENTRY" TO v-cdg_empleado.
                     ELSE APPLY "ENTRY" TO T-Parte_novedades.fecha.
  WAIT-FOR U1 OF THIS-PROCEDURE.
  CASE codigo_salir:
       WHEN CD_SALIR THEN UNDO,LEAVE.
       WHEN CD_CANCELAR THEN UNDO,RETRY.
       WHEN CD_GRABAR THEN NEXT.
  END CASE.
END.
APPLY "CLOSE" TO THIS-PROCEDURE. /* hay que ver si realmente hace falta */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE borrar_tablas_temporales C-Win 
PROCEDURE borrar_tablas_temporales :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  EMPTY TEMP-TABLE T-Parte_novedades.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE crear_registro C-Win 
PROCEDURE crear_registro :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  CREATE T-Parte_novedades.  
  
  IF NOT v-fijar_empleado
  THEN DO:
      ASSIGN v-cdg_empleado = 0
             v-dsc_empleado = "".
  END.

  IF NOT v-fijar_destino
  THEN DO:
      ASSIGN v-cdg_destino = 0
             v-dsc_destino = "".
  END.


  IF NOT v-fijar_novedad
  THEN DO:
      ASSIGN v-cdg_novedad = 0
             v-dsc_novedad = "".
  END.

  ASSIGN T-Parte_novedades.fecha = ?
         T-Parte_novedades.valor = 0
         T-Parte_novedades.observacion = "".

  DISPLAY v-cdg_empleado
          v-dsc_empleado
          v-cdg_destino 
          v-dsc_destino 
          v-cdg_novedad 
          v-dsc_novedad 
          T-Parte_novedades.fecha
          T-Parte_novedades.valor
          T-Parte_novedades.observacion
          WITH FRAME {&FRAME-NAME}.

  

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

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

  {&OPEN-QUERY-DEFAULT-FRAME}
  GET FIRST DEFAULT-FRAME.
  DISPLAY v-cdg_empleado v-cdg_destino v-cdg_novedad v-fijar_empleado 
          v-fijar_destino v-fijar_novedad v-dsc_empleado v-dsc_destino 
          v-dsc_novedad 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE T-Ciclo_novedades THEN 
    DISPLAY T-Ciclo_novedades.nro_ciclo T-Ciclo_novedades.descripcion T-Ciclo_novedades.fecha_desde 
          T-Ciclo_novedades.fecha_hasta T-Ciclo_novedades.activo 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE T-Parte_novedades THEN 
    DISPLAY T-Parte_novedades.fecha T-Parte_novedades.valor 
          T-Parte_novedades.observacion 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE v-cdg_empleado v-cdg_destino v-cdg_novedad T-Parte_novedades.fecha 
         T-Parte_novedades.valor T-Parte_novedades.observacion btn_grabar 
         btn_salir v-fijar_empleado v-fijar_destino v-fijar_novedad RECT-6 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE frame_sensitiva C-Win 
PROCEDURE frame_sensitiva :
/*------------------------------------------------------------------------------
  Purpose: habilita o deshabilita los campos de la frame para el estado inicial
           de la misma que se da cuando comienza el Ciclo_novedades de transaccion. El es-
           tado definitivo de los campos lo ajusta la rutina habilitar_campos ( INPUT YES ).   
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER habilitado AS LOGICAL.

  DO WITH FRAME {&FRAME-NAME}:

     IF NOT habilitado
     THEN DO:
          ASSIGN
                btn_grabar:SENSITIVE                      = NO
                T-Parte_novedades.fecha:SENSITIVE         = NO
                T-Parte_novedades.valor:SENSITIVE         = NO
                T-Parte_novedades.observacion:SENSITIVE   = NO
                v-cdg_empleado:SENSITIVE                  = NO
                v-cdg_destino:SENSITIVE                   = NO
                v-cdg_novedad:SENSITIVE                   = NO.

     END.
     ELSE DO:
          ASSIGN
                btn_grabar:SENSITIVE                      = YES
                T-Parte_novedades.fecha:SENSITIVE         = YES
                T-Parte_novedades.valor:SENSITIVE         = YES
                T-Parte_novedades.observacion:SENSITIVE   = YES
                v-cdg_empleado:SENSITIVE                  = NOT v-fijar_empleado
                v-cdg_destino:SENSITIVE                   = NOT v-fijar_destino
                v-cdg_novedad:SENSITIVE                   = NOT v-fijar_novedad.

     END.
  END.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE grabar_datos C-Win 
PROCEDURE grabar_datos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  
  CREATE Parte_novedades.
  BUFFER-COPY T-Parte_novedades TO Parte_novedades.

  RUN borrar_tablas_temporales.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_destino C-Win 
PROCEDURE poner_destino :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_empleado C-Win 
PROCEDURE poner_empleado :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_novedad C-Win 
PROCEDURE poner_novedad :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE validar_datos C-Win 
PROCEDURE validar_datos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

        DEFINE OUTPUT PARAMETER hubo_error AS LOGICAL.
        
        hubo_error = YES.
        
        IF NOT T-Ciclo_novedades.activo
        THEN DO:
           RUN PONMENSJ.P ( INPUT "PART001").
           RETURN.
        END.     
        
        {validartabla.i "Empleado"         "nro_legajo"     "nombre"         "PART004"}
        {validartabla.i "Destino"          "cdg_destino"    "nombre"         "PART005"}
        {validartabla.i "Novedad"          "cdg_novedad"    "descripcion"    "PART006"}

        IF INPUT FRAME {&FRAME-NAME} T-Parte_novedades.fecha = DATE("")
        THEN DO:
            RUN PONMENSJ.P ( INPUT "PART010").   
            RETURN.
        END.     


        IF INPUT FRAME {&FRAME-NAME} T-Parte_novedades.fecha < T-Ciclo_novedades.fecha_desde OR
           INPUT FRAME {&FRAME-NAME} T-Parte_novedades.fecha > T-Ciclo_novedades.fecha_hasta
        THEN DO:
            RUN PONMENSJ.P ( INPUT "PART002").   
            RETURN.
        END.     
        
        IF Empleado.cdg_estado <> Novedad.cdg_estado_nov AND
           Empleado.estado_pendiente
        THEN DO:
            RUN PONMENSJ.P ( INPUT "PART008").   
            RETURN.
        END.     
        
        IF NOT CAN-FIND(FIRST Novedad_estado OF Novedad
                            WHERE Novedad_estado.cdg_estado = Empleado.cdg_estado)
        THEN DO:
            RUN PONMENSJ.P ( INPUT "PART007").   
            RETURN.
        END.     


    /* Procede a contar los articulos para que no se pase del máximo permitido */

    hubo_error = NO.

    &SCOPED-DEFINE TABLA-MAESTRA  T-Parte_novedades

    {asignartabla.i "Empleado"          "nro_empleado"     "nro_empleado"      }
    {asignartabla.i "Novedad"           "nro_novedad"     "nro_novedad"      }
    {asignartabla.i "Destino"          "cdg_Destino"    "cdg_Destino"     }


    &UNDEFINE TABLA-MAESTRA


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

