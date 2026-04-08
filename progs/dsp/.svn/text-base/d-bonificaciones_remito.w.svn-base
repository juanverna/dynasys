&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame

/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Rem_header-bon NO-UNDO LIKE Rem_header-bon.


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS Dialog-Frame 
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

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

&IF DEFINED(UIB_is_Running) NE 0
&THEN
DEFINE VARIABLE           p-modo-cabecera  AS INTEGER.
&ELSE
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR t-Rem_header-bon.
DEFINE INPUT   PARAMETER  p-modo-cabecera  AS INTEGER.
&ENDIF

/* Local Variable Definitions ---                                       */

{valoresmodo.i}
{valoressalida.i}

DEFINE VARIABLE           rid_tabla       AS ROWID.
DEFINE VARIABLE           hubo_error      AS LOGICAL.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame
&Scoped-define BROWSE-NAME BROWSE-8

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Rem_header-bon Bonificacion

/* Definitions for BROWSE BROWSE-8                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-8 T-Rem_header-bon.cdg_bonificacion ~
Bonificacion.descripcion T-Rem_header-bon.porcentaje ~
T-Rem_header-bon.importe 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-8 
&Scoped-define OPEN-QUERY-BROWSE-8 OPEN QUERY BROWSE-8 FOR EACH T-Rem_header-bon NO-LOCK, ~
      EACH Bonificacion OF T-Rem_header-bon NO-LOCK.
&Scoped-define TABLES-IN-QUERY-BROWSE-8 T-Rem_header-bon Bonificacion
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-8 T-Rem_header-bon
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-8 Bonificacion


/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define OPEN-BROWSERS-IN-QUERY-Dialog-Frame ~
    ~{&OPEN-QUERY-BROWSE-8}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS v-cdg_bonificacion v-porcentaje BROWSE-8 ~
btn_crear btn_eliminar RECT-10 
&Scoped-Define DISPLAYED-OBJECTS v-cdg_bonificacion v-dsc_bonificacion ~
v-porcentaje 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON btn_crear 
     LABEL "Crear &Bonificacion" 
     SIZE 22 BY 1.15.

DEFINE BUTTON btn_eliminar 
     LABEL "Eliminar &Bonificacion" 
     SIZE 22 BY 1.15.

DEFINE BUTTON btn_salir 
     LABEL "&Salir" 
     SIZE 12 BY 1.12.

DEFINE VARIABLE v-cdg_bonificacion AS INTEGER FORMAT ">>>>9" INITIAL 0 
     VIEW-AS FILL-IN NATIVE 
     SIZE 8 BY .81
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-dsc_bonificacion AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 42 BY .81
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-porcentaje AS DECIMAL FORMAT ">>9.99":U INITIAL 0 
     LABEL "%" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 8 BY .81
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 6 GRAPHIC-EDGE  NO-FILL 
     SIZE 66 BY 11.04.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-8 FOR 
      T-Rem_header-bon, 
      Bonificacion SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-8
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-8 Dialog-Frame _STRUCTURED
  QUERY BROWSE-8 NO-LOCK DISPLAY
      T-Rem_header-bon.cdg_bonificacion COLUMN-LABEL "Có-!digo" FORMAT "ZZ9":U
      Bonificacion.descripcion COLUMN-LABEL "Descripción!Bonificación" FORMAT "X(30)":U
      T-Rem_header-bon.porcentaje COLUMN-LABEL "%.!Bonificado" FORMAT "->>9.99":U
      T-Rem_header-bon.importe COLUMN-LABEL "Importe!Bonificado" FORMAT "->,>>>,>>9.99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 62 BY 7.54.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     v-cdg_bonificacion AT ROW 1.81 COL 2 COLON-ALIGNED NO-LABEL
     v-dsc_bonificacion AT ROW 1.81 COL 11 COLON-ALIGNED NO-LABEL
     v-porcentaje AT ROW 1.81 COL 56 COLON-ALIGNED
     BROWSE-8 AT ROW 2.88 COL 4
     btn_crear AT ROW 10.69 COL 4
     btn_eliminar AT ROW 10.69 COL 27
     btn_salir AT ROW 10.69 COL 54
     RECT-10 AT ROW 1.27 COL 2
     SPACE(0.85) SKIP(0.22)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Bonificaciones del presente remito".


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: DIALOG-BOX
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Rem_header-bon T "?" NO-UNDO sic Rem_header-bon
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
                                                                        */
/* BROWSE-TAB BROWSE-8 v-porcentaje Dialog-Frame */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR BUTTON btn_salir IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_bonificacion IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-8
/* Query rebuild information for BROWSE BROWSE-8
     _TblList          = "Temp-Tables.T-Rem_header-bon,sic.Bonificacion OF Temp-Tables.T-Rem_header-bon"
     _Options          = "NO-LOCK"
     _FldNameList[1]   > Temp-Tables.T-Rem_header-bon.cdg_bonificacion
"T-Rem_header-bon.cdg_bonificacion" "Có-!digo" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[2]   > sic.Bonificacion.descripcion
"Bonificacion.descripcion" "Descripción!Bonificación" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[3]   > Temp-Tables.T-Rem_header-bon.porcentaje
"T-Rem_header-bon.porcentaje" "%.!Bonificado" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[4]   > Temp-Tables.T-Rem_header-bon.importe
"T-Rem_header-bon.importe" "Importe!Bonificado" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _Query            is OPENED
*/  /* BROWSE BROWSE-8 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Bonificaciones del presente remito */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-8
&Scoped-define SELF-NAME BROWSE-8
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-8 Dialog-Frame
ON DELETE-CHARACTER OF BROWSE-8 IN FRAME Dialog-Frame
DO:
    IF btn_eliminar:SENSITIVE IN FRAME {&FRAME-NAME} 
       THEN APPLY "CHOOSE" TO btn_eliminar IN FRAME {&FRAME-NAME}.
       ELSE BELL.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-8 Dialog-Frame
ON INSERT-MODE OF BROWSE-8 IN FRAME Dialog-Frame
DO:
    IF btn_crear:SENSITIVE IN FRAME {&FRAME-NAME} 
       THEN APPLY "CHOOSE" TO btn_crear IN FRAME {&FRAME-NAME}.
       ELSE BELL.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_crear
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_crear Dialog-Frame
ON CHOOSE OF btn_crear IN FRAME Dialog-Frame /* Crear Bonificacion */
DO:

  ASSIGN FRAME {&FRAME-NAME} v-cdg_bonificacion v-porcentaje.
  FIND Bonificacion WHERE Bonificacion.cdg_bonificacion = v-cdg_bonificacion NO-LOCK NO-ERROR.
  IF AVAILABLE Bonificacion 
  THEN DO:
       FIND T-Rem_header-bon 
            WHERE T-Rem_header-bon.cdg_bonificacion = v-cdg_bonificacion NO-LOCK NO-ERROR.
       IF AVAILABLE T-Rem_header-bon 
       THEN DO:
            RUN ponmensj.p ( INPUT "BONI002").
            RETURN NO-APPLY.
       END.
       ELSE DO:
            DO TRANSACTION:
               CREATE T-Rem_header-bon.
               ASSIGN T-Rem_header-bon.cdg_bonificacion = v-cdg_bonificacion
                      T-Rem_header-bon.porcentaje       = v-porcentaje. 
            END.
            {&OPEN-QUERY-{&BROWSE-NAME}}
            ASSIGN  v-cdg_bonificacion = 0
                    v-dsc_bonificacion = ""
                    v-porcentaje       = 0.
            DISPLAY v-cdg_bonificacion
                    v-dsc_bonificacion
                    v-porcentaje
                    WITH FRAME {&FRAME-NAME}.
       END.
  END.
  ELSE DO:
       RUN ponmensj.p ( INPUT "BONI002").
       RETURN NO-APPLY.
  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_eliminar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_eliminar Dialog-Frame
ON CHOOSE OF btn_eliminar IN FRAME Dialog-Frame /* Eliminar Bonificacion */
DO:
    DEFINE VARIABLE sino-msg AS LOGICAL.
    IF NOT AVAILABLE T-Rem_header-bon
    THEN DO:
         RUN ponmensj.p ( INPUT "BONI003").
         RETURN NO-APPLY.
    END.
    ELSE DO:
         sino-msg = NO.
         MESSAGE "Realmente desea eliminar esta Bonificación?" 
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
         IF sino-msg
         THEN DO:
              DO TRANSACTION:              
                 DELETE T-Rem_header-bon.
                 {&OPEN-QUERY-{&BROWSE-NAME}}                 
              END. 
         END.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_salir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_salir Dialog-Frame
ON CHOOSE OF btn_salir IN FRAME Dialog-Frame /* Salir */
DO:
  codigo_salir = CD_SALIR.
  APPLY "U1" TO THIS-PROCEDURE.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_bonificacion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_bonificacion Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF v-cdg_bonificacion IN FRAME Dialog-Frame
OR "." OF v-cdg_bonificacion IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_bonificacion IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Bonificacion" "cdg_bonificacion" "SELBONIF.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_bonificacion Dialog-Frame
ON RETURN OF v-cdg_bonificacion IN FRAME Dialog-Frame
OR TAB OF v-cdg_bonificacion IN FRAME {&FRAME-NAME}
DO:
   &SCOPED-DEFINE PONER-TABLA RUN poner_porcentaje.
   {traducetabla.i "Bonificacion" "cdg_bonificacion" "descripcion"} 
   &UNDEFINE PONER-TABLA
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Dialog-Frame 


/* ***************************  Main Block  *************************** */

/* Parent the dialog-box to the ACTIVE-WINDOW, if there is no parent.   */
IF VALID-HANDLE(ACTIVE-WINDOW) AND FRAME {&FRAME-NAME}:PARENT eq ?
THEN FRAME {&FRAME-NAME}:PARENT = ACTIVE-WINDOW.


/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.

 
 {&OPEN-QUERY-{&BROWSE-NAME}}
 RUN habilitar_campos.
 
/*WAIT-FOR GO OF FRAME {&FRAME-NAME}.*/

  WAIT-FOR U1 OF THIS-PROCEDURE.
  CASE codigo_salir:
       WHEN CD_SALIR    THEN UNDO,LEAVE.
       WHEN CD_CANCELAR THEN UNDO,RETRY.
       WHEN CD_GRABAR   THEN LEAVE.
  END CASE.

END.
RUN disable_UI.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI Dialog-Frame  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Hide all frames. */
  HIDE FRAME Dialog-Frame.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI Dialog-Frame  _DEFAULT-ENABLE
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
  DISPLAY v-cdg_bonificacion v-dsc_bonificacion v-porcentaje 
      WITH FRAME Dialog-Frame.
  ENABLE v-cdg_bonificacion v-porcentaje BROWSE-8 btn_crear btn_eliminar 
         RECT-10 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE habilitar_campos Dialog-Frame 
PROCEDURE habilitar_campos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  btn_salir:SENSITIVE IN FRAME {&FRAME-NAME}    = YES.

  IF p-modo-cabecera = MD_ALTA
  THEN DO:
       btn_eliminar:SENSITIVE IN FRAME {&FRAME-NAME}   = YES.
       btn_crear:SENSITIVE IN FRAME {&FRAME-NAME}      = YES.
  END.
  ELSE DO:
       btn_eliminar:SENSITIVE IN FRAME {&FRAME-NAME}   = NO.
       btn_crear:SENSITIVE IN FRAME {&FRAME-NAME}      = NO.
  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_porcentaje Dialog-Frame 
PROCEDURE poner_porcentaje :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  v-porcentaje = Bonificacion.porcentaje.
  DISPLAY v-porcentaje
          WITH FRAME {&FRAME-NAME}.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

