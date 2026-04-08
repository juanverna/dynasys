&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame

/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Ocm_detalle NO-UNDO LIKE Ocm_detalle.
DEFINE TEMP-TABLE T-Ocm_detalle-bon NO-UNDO LIKE Ocm_detalle-bon.
DEFINE TEMP-TABLE T-Ocm_header NO-UNDO LIKE Ocm_header.


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
DEFINE VARIABLE           p-nro_articulo   LIKE Articulo.nro_articulo.
DEFINE VARIABLE           p-nro_linea-i    LIKE Asn_detalle.nro_linea.
DEFINE VARIABLE           p-modo-cabecera  AS INTEGER.
DEFINE VARIABLE           p-modo-detalle   AS INTEGER.
DEFINE VARIABLE           p-nro_linea-o    LIKE Asn_detalle.nro_linea.
&ELSE
DEFINE INPUT   PARAMETER  p-nro_articulo   LIKE Articulo.nro_articulo.
DEFINE INPUT   PARAMETER  p-nro_linea-i    LIKE Asn_detalle.nro_linea.
DEFINE INPUT   PARAMETER  p-modo-cabecera  AS INTEGER.
DEFINE INPUT   PARAMETER  p-modo-detalle   AS INTEGER.
DEFINE OUTPUT  PARAMETER  p-nro_linea-o    LIKE Asn_detalle.nro_linea.
DEFINE INPUT   PARAMETER TABLE FOR T-Ocm_header.
DEFINE INPUT   PARAMETER TABLE FOR T-Ocm_detalle.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Ocm_detalle-bon.

&ENDIF

/* Local Variable Definitions ---                                       */

{valoresmodo.i}
{valoressalida.i}

DEFINE VARIABLE           rid_tabla       AS ROWID.
DEFINE VARIABLE           hubo_error      AS LOGICAL.
DEFINE VARIABLE           hay_obras       AS LOGICAL.
DEFINE VARIABLE           v-ref_fecha     AS DATE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame
&Scoped-define BROWSE-NAME BROWSE-7

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Ocm_detalle-bon Bonificacion

/* Definitions for BROWSE BROWSE-7                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-7 T-Ocm_detalle-bon.cdg_bonificacion ~
Bonificacion.descripcion T-Ocm_detalle-bon.porcentaje ~
T-Ocm_detalle-bon.importe 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-7 
&Scoped-define QUERY-STRING-BROWSE-7 FOR EACH T-Ocm_detalle-bon ~
      WHERE T-Ocm_detalle-bon.nro_linea = T-Ocm_detalle.nro_linea NO-LOCK, ~
      EACH Bonificacion OF T-Ocm_detalle-bon NO-LOCK
&Scoped-define OPEN-QUERY-BROWSE-7 OPEN QUERY BROWSE-7 FOR EACH T-Ocm_detalle-bon ~
      WHERE T-Ocm_detalle-bon.nro_linea = T-Ocm_detalle.nro_linea NO-LOCK, ~
      EACH Bonificacion OF T-Ocm_detalle-bon NO-LOCK.
&Scoped-define TABLES-IN-QUERY-BROWSE-7 T-Ocm_detalle-bon Bonificacion
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-7 T-Ocm_detalle-bon
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-7 Bonificacion


/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define OPEN-BROWSERS-IN-QUERY-Dialog-Frame ~
    ~{&OPEN-QUERY-BROWSE-7}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS v-cdg_bonificacion v-porcentaje BROWSE-7 ~
btn_crear btn_eliminar Btn_OK RECT-15 
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
     SIZE 25 BY 1.14.

DEFINE BUTTON btn_eliminar 
     LABEL "Eliminar &Bonificacion" 
     SIZE 25 BY 1.14.

DEFINE BUTTON Btn_OK 
     LABEL "&Salir" 
     SIZE 23 BY 1.14
     BGCOLOR 8 .

DEFINE VARIABLE v-cdg_bonificacion AS INTEGER FORMAT ">>>>9" INITIAL 0 
     VIEW-AS FILL-IN NATIVE 
     SIZE 11 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-dsc_bonificacion AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 56 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-porcentaje AS DECIMAL FORMAT ">>9.99":U INITIAL 0 
     LABEL "%" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 11 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE RECTANGLE RECT-15
     EDGE-PIXELS 4 GRAPHIC-EDGE  NO-FILL 
     SIZE 88 BY 9.76.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-7 FOR 
      T-Ocm_detalle-bon, 
      Bonificacion SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-7
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-7 Dialog-Frame _STRUCTURED
  QUERY BROWSE-7 NO-LOCK DISPLAY
      T-Ocm_detalle-bon.cdg_bonificacion COLUMN-LABEL "Có-!digo" FORMAT "ZZ9":U
            WIDTH 8.2
      Bonificacion.descripcion COLUMN-LABEL "Descripción!Bonificación" FORMAT "X(35)":U
            WIDTH 43.2
      T-Ocm_detalle-bon.porcentaje COLUMN-LABEL "%.!Bon." FORMAT "->>9.99":U
            WIDTH 11.2
      T-Ocm_detalle-bon.importe COLUMN-LABEL "Importe!Bonificado" FORMAT "->,>>>,>>9.99":U
            WIDTH 14.4
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 84 BY 6.48
         TITLE "Bonificaciones del Item de O/Compra" EXPANDABLE.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     v-cdg_bonificacion AT ROW 1.48 COL 2 COLON-ALIGNED NO-LABEL
     v-dsc_bonificacion AT ROW 1.48 COL 15 COLON-ALIGNED NO-LABEL
     v-porcentaje AT ROW 1.48 COL 75 COLON-ALIGNED
     BROWSE-7 AT ROW 2.91 COL 87 RIGHT-ALIGNED
     btn_crear AT ROW 9.57 COL 4
     btn_eliminar AT ROW 9.57 COL 30
     Btn_OK AT ROW 9.57 COL 65
     RECT-15 AT ROW 1.24 COL 2
     SPACE(1.19) SKIP(0.42)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Bonificaciones del detalle de ocompras".


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: DIALOG-BOX
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Ocm_detalle T "?" NO-UNDO sic Ocm_detalle
      TABLE: T-Ocm_detalle-bon T "?" NO-UNDO sic Ocm_detalle-bon
      TABLE: T-Ocm_header T "?" NO-UNDO sic Ocm_header
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
                                                                        */
/* BROWSE-TAB BROWSE-7 v-porcentaje Dialog-Frame */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR BROWSE BROWSE-7 IN FRAME Dialog-Frame
   ALIGN-R                                                              */
/* SETTINGS FOR FILL-IN v-dsc_bonificacion IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-7
/* Query rebuild information for BROWSE BROWSE-7
     _TblList          = "Temp-Tables.T-Ocm_detalle-bon,sic.Bonificacion OF Temp-Tables.T-Ocm_detalle-bon"
     _Options          = "NO-LOCK"
     _Where[1]         = "Temp-Tables.T-Ocm_detalle-bon.nro_linea = T-Ocm_detalle.nro_linea"
     _FldNameList[1]   > Temp-Tables.T-Ocm_detalle-bon.cdg_bonificacion
"T-Ocm_detalle-bon.cdg_bonificacion" "Có-!digo" ? "integer" ? ? ? ? ? ? no ? no no "8.2" yes no no "U" "" ""
     _FldNameList[2]   > sic.Bonificacion.descripcion
"Bonificacion.descripcion" "Descripción!Bonificación" "X(35)" "character" ? ? ? ? ? ? no ? no no "43.2" yes no no "U" "" ""
     _FldNameList[3]   > Temp-Tables.T-Ocm_detalle-bon.porcentaje
"T-Ocm_detalle-bon.porcentaje" "%.!Bon." ? "decimal" ? ? ? ? ? ? no ? no no "11.2" yes no no "U" "" ""
     _FldNameList[4]   > Temp-Tables.T-Ocm_detalle-bon.importe
"T-Ocm_detalle-bon.importe" "Importe!Bonificado" ? "decimal" ? ? ? ? ? ? no ? no no "14.4" yes no no "U" "" ""
     _Query            is OPENED
*/  /* BROWSE BROWSE-7 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Bonificaciones del detalle de ocompras */
DO:
  APPLY "END-ERROR":U TO SELF.
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
       FIND T-Ocm_detalle-bon 
            WHERE T-Ocm_detalle-bon.cdg_bonificacion = v-cdg_bonificacion NO-LOCK NO-ERROR.
       IF AVAILABLE T-Ocm_detalle-bon 
       THEN DO:
            RUN ponmensj.p ( INPUT "BONI002").
            RETURN NO-APPLY.
       END.
       ELSE DO:
            DO TRANSACTION:
               CREATE T-Ocm_detalle-bon.
               ASSIGN T-Ocm_detalle-bon.cdg_bonificacion = v-cdg_bonificacion
                      T-Ocm_detalle-bon.porcentaje       = v-porcentaje
                      T-Ocm_detalle-bon.nro_ocompra       = T-Ocm_detalle.nro_ocompra
                      T-Ocm_detalle-bon.nro_linea        = T-Ocm_detalle.nro_linea. 
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
    IF NOT AVAILABLE T-Ocm_detalle-bon
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
                 DELETE T-Ocm_detalle-bon.
                 {&OPEN-QUERY-{&BROWSE-NAME}}                 
              END. 
         END.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* Salir */
DO:

    FOR EACH T-Ocm_detalle-bon WHERE T-Ocm_detalle-bon.nro_linea = 0:
        ASSIGN T-Ocm_detalle-bon.nro_linea   = T-Ocm_detalle.nro_linea.
    END.        

    p-nro_linea-o = T-Ocm_detalle.nro_linea.
    codigo_salir = CD_GRABAR.
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


&Scoped-define BROWSE-NAME BROWSE-7
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

  FIND FIRST T-Ocm_header.
  
  FIND FIRST T-Ocm_detalle WHERE T-Ocm_detalle.nro_linea = p-nro_linea-i EXCLUSIVE-LOCK.

  {&OPEN-QUERY-{&BROWSE-NAME}}
  RUN habilitar_campos.

  APPLY "ENTRY" TO v-cdg_bonificacion IN FRAME {&FRAME-NAME}.      
 
/*WAIT-FOR GO OF FRAME {&FRAME-NAME}.*/

  WAIT-FOR U1 OF THIS-PROCEDURE FOCUS v-cdg_bonificacion.
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
  ENABLE v-cdg_bonificacion v-porcentaje BROWSE-7 btn_crear btn_eliminar Btn_OK 
         RECT-15 
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

  btn_ok:SENSITIVE IN FRAME {&FRAME-NAME}    = YES.

  IF p-modo-cabecera = MD_ALTA OR 
     p-modo-cabecera = MD_CAMBIO OR 
     p-modo-cabecera = MD_DEFINIDA OR
     p-modo-cabecera = MD_RELACION
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

