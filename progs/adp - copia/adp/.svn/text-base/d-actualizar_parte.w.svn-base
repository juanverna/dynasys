&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame

/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Ciclo_novedades NO-UNDO LIKE Ciclo_novedades.


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
/*          This .W file was created with the Progress AppBuilder.       */
/*----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

DEFINE VARIABLE rid_tabla AS ROWID.

{valoressalida.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Dialog-Box
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Ciclo_novedades

/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define FIELDS-IN-QUERY-Dialog-Frame T-Ciclo_novedades.nro_ciclo ~
T-Ciclo_novedades.descripcion T-Ciclo_novedades.fecha_desde T-Ciclo_novedades.fecha_hasta T-Ciclo_novedades.activo 
&Scoped-define QUERY-STRING-Dialog-Frame FOR EACH T-Ciclo_novedades SHARE-LOCK
&Scoped-define OPEN-QUERY-Dialog-Frame OPEN QUERY Dialog-Frame FOR EACH T-Ciclo_novedades SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-Dialog-Frame T-Ciclo_novedades
&Scoped-define FIRST-TABLE-IN-QUERY-Dialog-Frame T-Ciclo_novedades


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS v-cdg_empleado v-fijar_empleado ~
v-cdg_destino v-fijar_destino v-cdg_novedad v-fijar_novedad v-fecha_novedad ~
v-valor v-observacion btn_grabar Btn_OK RECT-6 
&Scoped-Define DISPLAYED-FIELDS T-Ciclo_novedades.nro_ciclo T-Ciclo_novedades.descripcion ~
T-Ciclo_novedades.fecha_desde T-Ciclo_novedades.fecha_hasta T-Ciclo_novedades.activo 
&Scoped-define DISPLAYED-TABLES T-Ciclo_novedades
&Scoped-define FIRST-DISPLAYED-TABLE T-Ciclo_novedades
&Scoped-Define DISPLAYED-OBJECTS v-cdg_empleado v-dsc_empleado ~
v-fijar_empleado v-cdg_destino v-dsc_destino v-fijar_destino v-cdg_novedad ~
v-dsc_novedad v-fijar_novedad v-fecha_novedad v-valor v-observacion 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON btn_grabar 
     LABEL "&Grabar" 
     SIZE 15 BY 1.14.

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "&Salir" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE VARIABLE v-observacion AS CHARACTER 
     LABEL "Observ." 
     VIEW-AS EDITOR
     SIZE 101 BY 3.33
     BGCOLOR 15 FGCOLOR 7 .

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

DEFINE VARIABLE v-fecha_novedad AS DATE FORMAT "99/99/99":U INITIAL ? 
     LABEL "Fecha" 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-valor AS DECIMAL FORMAT "->>>>>>>9.99" INITIAL 0 
     LABEL "Valor" 
     VIEW-AS FILL-IN 
     SIZE 18.8 BY 1
     BGCOLOR 15 FGCOLOR 9 .

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
DEFINE QUERY Dialog-Frame FOR 
      T-Ciclo_novedades SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
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
     v-cdg_empleado AT ROW 4.33 COL 15 COLON-ALIGNED
     v-dsc_empleado AT ROW 4.33 COL 31 COLON-ALIGNED NO-LABEL
     v-fijar_empleado AT ROW 4.33 COL 87
     v-cdg_destino AT ROW 5.52 COL 15 COLON-ALIGNED
     v-dsc_destino AT ROW 5.52 COL 31 COLON-ALIGNED NO-LABEL
     v-fijar_destino AT ROW 5.52 COL 87
     v-cdg_novedad AT ROW 6.71 COL 15 COLON-ALIGNED
     v-dsc_novedad AT ROW 6.71 COL 31 COLON-ALIGNED NO-LABEL
     v-fijar_novedad AT ROW 6.71 COL 87
     v-fecha_novedad AT ROW 7.91 COL 15 COLON-ALIGNED
     v-valor AT ROW 7.91 COL 64 COLON-ALIGNED HELP
          "Ingrese el valor numerico"
     v-observacion AT ROW 10.29 COL 6 NO-LABEL
     btn_grabar AT ROW 13.86 COL 6
     Btn_OK AT ROW 13.86 COL 92
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
     SPACE(3.99) SKIP(13.61)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Ingreso de Novedades de Parte Diario"
         DEFAULT-BUTTON Btn_OK.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Dialog-Box
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Ciclo_novedades T "?" NO-UNDO sic Ciclo_novedades
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
                                                                        */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN T-Ciclo_novedades.activo IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Ciclo_novedades.descripcion IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Ciclo_novedades.fecha_desde IN FRAME Dialog-Frame
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN T-Ciclo_novedades.fecha_hasta IN FRAME Dialog-Frame
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN T-Ciclo_novedades.nro_ciclo IN FRAME Dialog-Frame
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN v-dsc_destino IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_empleado IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_novedad IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX Dialog-Frame
/* Query rebuild information for DIALOG-BOX Dialog-Frame
     _TblList          = "Temp-Tables.T-Ciclo_novedades"
     _Options          = "SHARE-LOCK"
     _Query            is OPENED
*/  /* DIALOG-BOX Dialog-Frame */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Ingreso de Novedades de Parte Diario */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_destino
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_destino Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF v-cdg_destino IN FRAME Dialog-Frame /* Destino */
OR "." OF v-cdg_destino IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_destino IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "destino" "cdg_destino" "SELDESTI.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_destino Dialog-Frame
ON RETURN OF v-cdg_destino IN FRAME Dialog-Frame /* Destino */
DO:

    &SCOPED-DEFINE PONER-TABLA RUN poner_destino.          
   {traducetabla.i "destino" "cdg_destino" "nombre"}
    &UNDEFINE PONER-TABLA                                  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_empleado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_empleado Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF v-cdg_empleado IN FRAME Dialog-Frame /* Empleado */
OR "." OF v-cdg_empleado IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_empleado IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "empleado" "nro_legajo" "SELEMPLE.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_empleado Dialog-Frame
ON RETURN OF v-cdg_empleado IN FRAME Dialog-Frame /* Empleado */
DO:

    &SCOPED-DEFINE PONER-TABLA RUN poner_empleado.          
   {traducetabla.i "empleado" "nro_legajo" "nombre"}
   &UNDEFINE PONER-TABLA                                  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_novedad
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_novedad Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF v-cdg_novedad IN FRAME Dialog-Frame /* Novedad */
OR "." OF v-cdg_novedad IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_novedad IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "novedad" "cdg_novedad" "SELNOVED.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_novedad Dialog-Frame
ON RETURN OF v-cdg_novedad IN FRAME Dialog-Frame /* Novedad */
DO:

    &SCOPED-DEFINE PONER-TABLA RUN poner_novedad.          
   {traducetabla.i "novedad" "cdg_novedad" "descripcion"}
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
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  ASSIGN v-cdg_empleado:SENSITIVE IN FRAME {&FRAME-NAME}  = NOT v-fijar_empleado
         v-cdg_destino:SENSITIVE IN FRAME {&FRAME-NAME}   = NOT v-fijar_destino 
         v-cdg_novedad:SENSITIVE IN FRAME {&FRAME-NAME}   = NOT v-fijar_novedad.
  CLEAR FRAME {&FRAME-NAME} ALL.
/*F modo = MD_ALTA THEN APPLY "ENTRY" TO v-cdg_cliente.*/
  WAIT-FOR U1 OF THIS-PROCEDURE.
  CASE codigo_salir:
       WHEN CD_SALIR THEN UNDO,LEAVE.
       WHEN CD_CANCELAR THEN UNDO,RETRY.
       WHEN CD_GRABAR THEN NEXT.
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

  {&OPEN-QUERY-Dialog-Frame}
  GET FIRST Dialog-Frame.
  DISPLAY v-cdg_empleado v-dsc_empleado v-fijar_empleado v-cdg_destino 
          v-dsc_destino v-fijar_destino v-cdg_novedad v-dsc_novedad 
          v-fijar_novedad v-fecha_novedad v-valor v-observacion 
      WITH FRAME Dialog-Frame.
  IF AVAILABLE T-Ciclo_novedades THEN 
    DISPLAY T-Ciclo_novedades.nro_ciclo T-Ciclo_novedades.descripcion T-Ciclo_novedades.fecha_desde 
          T-Ciclo_novedades.fecha_hasta T-Ciclo_novedades.activo 
      WITH FRAME Dialog-Frame.
  ENABLE v-cdg_empleado v-fijar_empleado v-cdg_destino v-fijar_destino 
         v-cdg_novedad v-fijar_novedad v-fecha_novedad v-valor v-observacion 
         btn_grabar Btn_OK RECT-6 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_destino Dialog-Frame 
PROCEDURE poner_destino :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_empleado Dialog-Frame 
PROCEDURE poner_empleado :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_novedad Dialog-Frame 
PROCEDURE poner_novedad :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

