&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
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

DEFINE VARIABLE v-arch_copia1 AS CHARACTER.
    DEFINE VARIABLE v-arch_copia2 AS CHARACTER.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS v-fecha_proceso v-arch_entrada ~
v-arch_entrada-2 v-arch_salida btn_hacer-2 btn_hacer RECT-1 
&Scoped-Define DISPLAYED-OBJECTS v-fecha_proceso v-arch_entrada ~
v-arch_entrada-2 v-arch_salida 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btn_hacer 
     LABEL "&Hacer" 
     SIZE 19 BY 1.14.

DEFINE BUTTON btn_hacer-2 
     LABEL "&Probar" 
     SIZE 19 BY 1.14.

DEFINE VARIABLE v-arch_entrada AS CHARACTER FORMAT "X(256)":U 
     LABEL "Encabezado" 
     VIEW-AS FILL-IN 
     SIZE 46 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-arch_entrada-2 AS CHARACTER FORMAT "X(256)":U 
     LABEL "Detalle" 
     VIEW-AS FILL-IN 
     SIZE 46 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-arch_salida AS CHARACTER FORMAT "X(256)":U 
     LABEL "Salida (Bajado)" 
     VIEW-AS FILL-IN 
     SIZE 46 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-fecha_proceso AS DATE FORMAT "99/99/99":U 
     VIEW-AS FILL-IN 
     SIZE 19 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 73 BY 10.71.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     v-fecha_proceso AT ROW 1.95 COL 40 COLON-ALIGNED NO-LABEL
     v-arch_entrada AT ROW 3.86 COL 19 COLON-ALIGNED
     v-arch_entrada-2 AT ROW 5.29 COL 19 COLON-ALIGNED
     v-arch_salida AT ROW 7.43 COL 19 COLON-ALIGNED
     btn_hacer-2 AT ROW 10.29 COL 21
     btn_hacer AT ROW 10.29 COL 43
     RECT-1 AT ROW 1.48 COL 4
     " Fecha de Proceso" VIEW-AS TEXT
          SIZE 19 BY 1 AT ROW 1.95 COL 21
          BGCOLOR 5 FGCOLOR 15 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80.6 BY 12.


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
         TITLE              = "Carga de Movimientos de Pedidos Por Sucursal"
         HEIGHT             = 12
         WIDTH              = 80.6
         MAX-HEIGHT         = 25.71
         MAX-WIDTH          = 160
         VIRTUAL-HEIGHT     = 25.71
         VIRTUAL-WIDTH      = 160
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
                                                                        */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Carga de Movimientos de Pedidos Por Sucursal */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Carga de Movimientos de Pedidos Por Sucursal */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_hacer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_hacer C-Win
ON CHOOSE OF btn_hacer IN FRAME DEFAULT-FRAME /* Hacer */
DO:
    

    ASSIGN v-arch_entrada v-arch_entrada-2 v-arch_salida.

                 v-arch_copia1 = "\\SERVER\work\PROGRESS\PedidosInternet\PROCESADOS\" + v-arch_entrada.
                 v-arch_copia2 = "\\SERVER\work\PROGRESS\PedidosInternet\PROCESADOS\" + v-arch_entrada-2.
                 v-arch_salida = "\\SERVER\work\PROGRESS\PedidosInternet\PROCESADOS\" + v-arch_salida.
                 v-arch_entrada = "\\SERVER\work\PROGRESS\PedidosInternet\" + v-arch_entrada.
                 v-arch_entrada-2 = "\\SERVER\work\PROGRESS\PedidosInternet\" + v-arch_entrada-2.

    IF SEARCH(v-arch_entrada) = ?
    THEN DO:
        IF SEARCH(v-arch_entrada-2) = ?
        THEN DO: 
            MESSAGE "No existen los archivos " v-arch_entrada "," v-arch_entrada-2 VIEW-AS ALERT-BOX ERROR.
            RETURN NO-APPLY.
        END.
        ELSE DO: 
            MESSAGE "No existe el archivo " v-arch_entrada VIEW-AS ALERT-BOX ERROR.
            RETURN NO-APPLY.
        END.

    END.

    ELSE DO:
        IF SEARCH(v-arch_entrada-2) = ?
        THEN DO:
            MESSAGE "No existe el archivo "  v-arch_entrada-2 VIEW-AS ALERT-BOX ERROR.
            RETURN NO-APPLY.
        END.
        ELSE DO: 
                 

                 RUN borrar_pedidos_sucursal.p ( INPUT v-arch_entrada,
                                                   INPUT v-arch_entrada-2,
                                                   INPUT v-arch_salida,
                                                   INPUT v-arch_copia1,
                                                   INPUT v-arch_copia2).

        END.  
    END.      
              
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_hacer-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_hacer-2 C-Win
ON CHOOSE OF btn_hacer-2 IN FRAME DEFAULT-FRAME /* Probar */
DO:
    ASSIGN v-arch_entrada v-arch_entrada-2 v-arch_salida.

    v-arch_copia1 = "\\SERVER\work\PROGRESS\PedidosInternet\PROCESADOS\" + v-arch_entrada.
    v-arch_copia2 = "\\SERVER\work\PROGRESS\PedidosInternet\PROCESADOS\" + v-arch_entrada-2.
    v-arch_salida = "\\SERVER\work\PROGRESS\PedidosInternet\PROCESADOS\" + v-arch_salida.
    v-arch_entrada = "\\SERVER\work\PROGRESS\PedidosInternet\" + v-arch_entrada.
    v-arch_entrada-2 = "\\SERVER\work\PROGRESS\PedidosInternet\" + v-arch_entrada-2.
    
   IF SEARCH(v-arch_entrada) = ?
    THEN DO:
        IF SEARCH(v-arch_entrada-2) = ?
        THEN DO: 
            MESSAGE "No existen los archivos " v-arch_entrada "," v-arch_entrada-2 VIEW-AS ALERT-BOX ERROR.
            RETURN NO-APPLY.
        END.
        ELSE DO: 
            MESSAGE "No existe el archivo " v-arch_entrada VIEW-AS ALERT-BOX ERROR.
            RETURN NO-APPLY.
        END.

    END.

    ELSE DO:
        IF SEARCH(v-arch_entrada-2) = ?
        THEN DO:
            MESSAGE "No existe el archivo "  v-arch_entrada-2 VIEW-AS ALERT-BOX ERROR.
            RETURN NO-APPLY.
        END.
        ELSE DO: 
                 RUN prueba_levantar_pedidos_sucursal.p ( INPUT v-arch_entrada,
                                                          INPUT v-arch_entrada-2,
                                                          INPUT v-arch_salida
                                                         ).

        END.  
    END.      
              
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-fecha_proceso
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-fecha_proceso C-Win
ON LEAVE OF v-fecha_proceso IN FRAME DEFAULT-FRAME
DO:
  ASSIGN v-fecha_proceso.
  RUN armar_nombres_archivos.
  DISPLAY v-arch_entrada v-arch_entrada-2 v-arch_salida
      WITH FRAME {&FRAME-NAME}.

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

v-fecha_proceso = TODAY.
RUN armar_nombres_archivos.

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE armar_nombres_archivos C-Win 
PROCEDURE armar_nombres_archivos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    v-arch_entrada = "hd" +
                     STRING(YEAR(v-fecha_proceso),"9999") +
                     STRING(MONTH(v-fecha_proceso),"99") + 
                     STRING(DAY(v-fecha_proceso),"99") +                       
                     ".txt".
     v-arch_entrada-2 = "dt" +
                     STRING(YEAR(v-fecha_proceso),"9999") +
                     STRING(MONTH(v-fecha_proceso),"99") + 
                     STRING(DAY(v-fecha_proceso),"99") + 
                     ".txt".
    v-arch_salida = STRING(YEAR(v-fecha_proceso),"9999") +
                    STRING(MONTH(v-fecha_proceso),"99") + 
                    STRING(DAY(v-fecha_proceso),"99") + 
                    "(bajado).txt".

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
  DISPLAY v-fecha_proceso v-arch_entrada v-arch_entrada-2 v-arch_salida 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE v-fecha_proceso v-arch_entrada v-arch_entrada-2 v-arch_salida 
         btn_hacer-2 btn_hacer RECT-1 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

