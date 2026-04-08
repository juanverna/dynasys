&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
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

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Fac_header_prv

/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define QUERY-STRING-DEFAULT-FRAME FOR EACH Fac_header_prv SHARE-LOCK
&Scoped-define OPEN-QUERY-DEFAULT-FRAME OPEN QUERY DEFAULT-FRAME FOR EACH Fac_header_prv SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-DEFAULT-FRAME Fac_header_prv
&Scoped-define FIRST-TABLE-IN-QUERY-DEFAULT-FRAME Fac_header_prv


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-1 v-tip_comprob v-prf_comprob ~
v-nro_comprob v-fecha_iva v-fecha_iva_nueva btn_Grabar 
&Scoped-Define DISPLAYED-OBJECTS v-tip_comprob v-prf_comprob v-nro_comprob ~
v-fecha_iva v-fecha_iva_nueva 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btn_Grabar 
     LABEL "Grabar" 
     SIZE 19 BY 1.14.

DEFINE VARIABLE v-fecha_iva LIKE Fac_header_prv.fecha_iva
     VIEW-AS FILL-IN 
     SIZE 20.6 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-fecha_iva_nueva AS DATE FORMAT "99/99/99":U 
     VIEW-AS FILL-IN 
     SIZE 20.8 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-nro_comprob LIKE Fac_header_prv.nro_comprob
     VIEW-AS FILL-IN 
     SIZE 16.6 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-prf_comprob LIKE Fac_header_prv.prf_comprob
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-tip_comprob LIKE Fac_header_prv.tip_comprob
     LABEL "Factura" 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 64 BY 8.62.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY DEFAULT-FRAME FOR 
      Fac_header_prv SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     v-tip_comprob AT ROW 2.95 COL 17 COLON-ALIGNED HELP
          ""
          LABEL "Factura"
          BGCOLOR 15 FGCOLOR 9 
     v-prf_comprob AT ROW 2.95 COL 24.2 COLON-ALIGNED HELP
          "" NO-LABEL
          BGCOLOR 15 FGCOLOR 9 
     v-nro_comprob AT ROW 2.95 COL 41.4 COLON-ALIGNED HELP
          "" NO-LABEL
          BGCOLOR 15 FGCOLOR 9 
     v-fecha_iva AT ROW 5.52 COL 9.4 COLON-ALIGNED HELP
          "" NO-LABEL
          BGCOLOR 15 FGCOLOR 9 
     v-fecha_iva_nueva AT ROW 5.52 COL 37.2 COLON-ALIGNED NO-LABEL
     btn_Grabar AT ROW 7.95 COL 40
     " Fecha Contable" VIEW-AS TEXT
          SIZE 20.6 BY 1 AT ROW 4.57 COL 11.4
          BGCOLOR 5 FGCOLOR 15 
     "Nueva Fecha Cont." VIEW-AS TEXT
          SIZE 20.8 BY 1 AT ROW 4.57 COL 39.2
          BGCOLOR 5 FGCOLOR 15 
     "                          Ingrese la factura a buscar" VIEW-AS TEXT
          SIZE 62 BY 1 AT ROW 1.52 COL 5
          BGCOLOR 5 FGCOLOR 15 
     RECT-1 AT ROW 1.24 COL 4
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 73 BY 9.91.


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
         HEIGHT             = 9.91
         WIDTH              = 73
         MAX-HEIGHT         = 27.33
         MAX-WIDTH          = 160
         VIRTUAL-HEIGHT     = 27.33
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
   FRAME-NAME                                                           */
/* SETTINGS FOR FILL-IN v-fecha_iva IN FRAME DEFAULT-FRAME
   LIKE = sic.Fac_header_prv.fecha_iva EXP-SIZE                         */
/* SETTINGS FOR FILL-IN v-nro_comprob IN FRAME DEFAULT-FRAME
   LIKE = sic.Fac_header_prv.nro_comprob EXP-SIZE                       */
/* SETTINGS FOR FILL-IN v-prf_comprob IN FRAME DEFAULT-FRAME
   LIKE = sic.Fac_header_prv.prf_comprob EXP-SIZE                       */
/* SETTINGS FOR FILL-IN v-tip_comprob IN FRAME DEFAULT-FRAME
   LIKE = sic.Fac_header_prv.tip_comprob EXP-LABEL EXP-SIZE             */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME DEFAULT-FRAME
/* Query rebuild information for FRAME DEFAULT-FRAME
     _TblList          = "sic.Fac_header_prv"
     _Query            is OPENED
*/  /* FRAME DEFAULT-FRAME */
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
/*   APPLY "CLOSE":U TO THIS-PROCEDURE. */
/*   RETURN NO-APPLY.                   */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_Grabar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_Grabar C-Win
ON CHOOSE OF btn_Grabar IN FRAME DEFAULT-FRAME /* Grabar */
DO:
ASSIGN v-fecha_iva_nueva.

UPDATE Fac_header_prv.fecha_iva = DATE (v-fecha_iva_nueva:SCREEN-VALUE IN FRAME {&FRAME-NAME}).

FIND sub_header_prv WHERE Sub_header_prv.cdg_empresa   = Fac_header_prv.cdg_empresa
                      AND Sub_header_prv.tip_comprob   = Fac_header_prv.tip_comprob
                      AND Sub_header_prv.prf_comprob   = Fac_header_prv.prf_comprob
                      AND Sub_header_prv.nro_comprob   = Fac_header_prv.nro_comprob
                      AND Sub_header_prv.nro_proveedor = Fac_header_prv.nro_proveedor NO-ERROR.

    IF AVAILABLE Sub_header_prv THEN DO:
       UPDATE Sub_header_prv.fecha = Fac_header_prv.fecha_iva.
       MESSAGE "Los cambios se efectuaron correctamente" VIEW-AS ALERT-BOX.
     
       RUN blanquear.
       END.
        ELSE DO:
            MESSAGE "No encontro sub_header_prv" VIEW-AS ALERT-BOX.
        END.



END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-fecha_iva
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-fecha_iva C-Win
ON LEAVE OF v-fecha_iva IN FRAME DEFAULT-FRAME
DO:
/*   ASSIGN v-fecha_proceso.                               */
/*   DISPLAY v-arch_entrada v-arch_entrada-2 v-arch_salida */
/*       WITH FRAME {&FRAME-NAME}.                         */
/*                                                         */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-fecha_iva_nueva
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-fecha_iva_nueva C-Win
ON LEAVE OF v-fecha_iva_nueva IN FRAME DEFAULT-FRAME
DO:
/*   ASSIGN v-fecha_proceso.                               */
/*   RUN armar_nombres_archivos.                           */
/*   DISPLAY v-arch_entrada v-arch_entrada-2 v-arch_salida */
/*       WITH FRAME {&FRAME-NAME}.                         */

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-nro_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-nro_comprob C-Win
ON RETURN OF v-nro_comprob IN FRAME DEFAULT-FRAME
DO:
{findempresa.i}
ASSIGN v-tip_comprob v-prf_comprob v-nro_comprob.
   
    FIND fac_header_prv 
       WHERE Fac_header_prv.cdg_empresa = "f" /*Empresa.cdg_empresa*/ 
         AND tip_comprob = v-tip_comprob:SCREEN-VALUE IN FRAME {&FRAME-NAME}
         AND prf_comprob = INTEGER(v-prf_comprob:SCREEN-VALUE IN FRAME {&FRAME-NAME})
         AND nro_comprob = INTEGER(v-nro_comprob:SCREEN-VALUE IN FRAME {&FRAME-NAME}) NO-ERROR.

  IF AVAILABLE Fac_header_prv 
   THEN DO:
   v-fecha_iva = fac_header_prv.fecha_iva.
   DISPLAY v-fecha_iva  WITH FRAME {&FRAME-NAME}. 

   END.

       ELSE DO:
               MESSAGE "No existe el comprobante indicado"  VIEW-AS ALERT-BOX ERROR.
               RETURN NO-APPLY.
       END.

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

/* v-fecha_proceso = TODAY.  */
/* RUN armar_nombres_archivos.  */

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE blanquear C-Win 
PROCEDURE blanquear :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
v-fecha_iva_nueva = ?
v-fecha_iva = ?
v-tip_comprob = ""
v-prf_comprob = 0
v-nro_comprob = 0.

DISPLAY
    v-fecha_iva_nueva
    v-fecha_iva 
    v-tip_comprob 
    v-prf_comprob 
    v-nro_comprob WITH FRAME {&FRAME-NAME}.

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
  DISPLAY v-tip_comprob v-prf_comprob v-nro_comprob v-fecha_iva 
          v-fecha_iva_nueva 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE RECT-1 v-tip_comprob v-prf_comprob v-nro_comprob v-fecha_iva 
         v-fecha_iva_nueva btn_Grabar 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

