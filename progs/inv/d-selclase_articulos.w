&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame


/* Temp-Table and Buffer definitions                                    */
DEFINE BUFFER B-Clase FOR Clase_de_Articulo.
DEFINE BUFFER Clase FOR Clase_de_Articulo.



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
DEFINE VARIABLE sel_clase    AS CHARACTER.
DEFINE VARIABLE codigo_salir AS INTEGER NO-UNDO.
&ELSE
DEFINE INPUT-OUTPUT PARAMETER sel_clase    AS CHARACTER.
DEFINE OUTPUT PARAMETER codigo_salir       AS INTEGER NO-UNDO.
&ENDIF

/* Local Variable Definitions ---                                       */

 {vrshared.i "NEW"}

DEFINE VARIABLE p_punto              AS INTEGER INITIAL 0.
DEFINE VARIABLE l_rotulo             AS INTEGER INITIAL 0.
DEFINE VARIABLE j                    AS INTEGER INITIAL 0.

DEFINE VARIABLE SELECCION_NADA       AS INTEGER INITIAL 0.
DEFINE VARIABLE SELECCION_CLASE      AS INTEGER INITIAL 1.
DEFINE VARIABLE SELECCION_ARTICULO   AS INTEGER INITIAL 2.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME Dialog-Frame
&Scoped-define BROWSE-NAME brw_clasificacion

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Clase

/* Definitions for BROWSE brw_clasificacion                             */
&Scoped-define FIELDS-IN-QUERY-brw_clasificacion ~
SUBSTRING(Clase.cdg_subclase,LENGTH(que_clase) + 2) Clase.nombre_subclase 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brw_clasificacion 
&Scoped-define QUERY-STRING-brw_clasificacion FOR EACH Clase NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brw_clasificacion OPEN QUERY brw_clasificacion FOR EACH Clase NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brw_clasificacion Clase
&Scoped-define FIRST-TABLE-IN-QUERY-brw_clasificacion Clase


/* Definitions for DIALOG-BOX Dialog-Frame                              */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-1 que_subclase brw_clasificacion camino ~
Btn_OK Btn_Cancel 
&Scoped-Define DISPLAYED-OBJECTS que_subclase que_nombre que_clase camino 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "&Salir" 
     SIZE 24 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "&Elegir" 
     SIZE 24 BY 1.14
     BGCOLOR 8 .

DEFINE VARIABLE que_clase AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 52 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE que_nombre AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 30 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE que_subclase AS CHARACTER FORMAT "X(256)":U 
     LABEL "Subclase" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 52 BY 1.62.

DEFINE VARIABLE camino AS CHARACTER 
     VIEW-AS SELECTION-LIST SINGLE SCROLLBAR-VERTICAL 
     SIZE 52 BY 17.24
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brw_clasificacion FOR 
      Clase SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brw_clasificacion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brw_clasificacion Dialog-Frame _STRUCTURED
  QUERY brw_clasificacion NO-LOCK DISPLAY
      SUBSTRING(Clase.cdg_subclase,LENGTH(que_clase) + 2) COLUMN-LABEL "Código!Subclase" FORMAT "X(10)":U
      Clase.nombre_subclase COLUMN-LABEL "Denominacion!Subclase" FORMAT "X(40)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 55 BY 19.14
         BGCOLOR 15 FGCOLOR 9 FONT 4
         TITLE BGCOLOR 15 FGCOLOR 9 "Subclases Definidas para la Clase Actual".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     que_subclase AT ROW 1.52 COL 12 COLON-ALIGNED
     que_nombre AT ROW 1.52 COL 27 COLON-ALIGNED NO-LABEL
     que_clase AT ROW 1.52 COL 59 COLON-ALIGNED NO-LABEL
     brw_clasificacion AT ROW 2.62 COL 4
     camino AT ROW 2.62 COL 61 NO-LABEL
     Btn_OK AT ROW 20.38 COL 62
     Btn_Cancel AT ROW 20.38 COL 88
     RECT-1 AT ROW 20.14 COL 61
     SPACE(2.28) SKIP(0.23)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         FONT 4
         TITLE "Selección de Clasificación de Artículos"
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: DIALOG-BOX
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: B-Clase B "?" ? sic Clase_de_Articulo
      TABLE: Clase B "?" ? sic Clase_de_Articulo
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
   FRAME-NAME                                                           */
/* BROWSE-TAB brw_clasificacion que_clase Dialog-Frame */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN que_clase IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN que_nombre IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brw_clasificacion
/* Query rebuild information for BROWSE brw_clasificacion
     _TblList          = "sic.Clase"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > "_<CALC>"
"SUBSTRING(Clase.cdg_subclase,LENGTH(que_clase) + 2)" "Código!Subclase" "X(10)" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[2]   > Temp-Tables.Clase.nombre_subclase
"Clase.nombre_subclase" "Denominacion!Subclase" "X(40)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _Query            is NOT OPENED
*/  /* BROWSE brw_clasificacion */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Selección de Clasificación de Artículos */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brw_clasificacion
&Scoped-define SELF-NAME brw_clasificacion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brw_clasificacion Dialog-Frame
ON RETURN OF brw_clasificacion IN FRAME Dialog-Frame /* Subclases Definidas para la Clase Actual */
OR MOUSE-SELECT-DBLCLICK OF brw_clasificacion
DO:
   que_subclase = SUBSTRING(Clase.cdg_subclase,LENGTH(que_clase) + 2).
   DISPLAY que_subclase
           WITH FRAME {&FRAME-NAME}.
   APPLY "RETURN" TO que_subclase IN FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* Elegir */
DO:
    codigo_salir = SELECCION_CLASE.
    sel_clase = que_clase.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME que_subclase
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_subclase Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF que_subclase IN FRAME Dialog-Frame /* Subclase */
DO:
  que_subclase = "".
  DISPLAY que_subclase
          WITH FRAME {&FRAME-NAME}.
  APPLY "RETURN" TO que_subclase IN FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_subclase Dialog-Frame
ON RETURN OF que_subclase IN FRAME Dialog-Frame /* Subclase */
DO:
   ASSIGN que_subclase.
   IF que_subclase = "" 
   THEN DO:
      p_punto = LENGTH(que_clase).
      DO WHILE p_punto > 0 AND SUBSTRING(que_clase,p_punto,1) <> ".":
         p_punto = p_punto - 1.
         que_clase = SUBSTRING(que_clase,1,p_punto).
      END.   
      IF p_punto = 0
      THEN DO:

         APPLY "U1" TO SELF.
         RETURN NO-APPLY.
      END.
      ELSE DO:
         
         IF p_punto > 1
         THEN DO:
            p_punto = p_punto - 1.
            que_clase = SUBSTRING(que_clase,1,p_punto).
            FIND FIRST Clase WHERE Clase.cdg_subclase = que_clase.
            que_nombre = Clase.nombre.
            RUN armar_rotulo.
         END.
         ELSE DO:
            que_clase = "".
            que_nombre = "".
            /*rotulo = ""*/.
         END.
               
         como_fue = camino:DELETE(camino:NUM-ITEMS). /* Elimina el ultimo item */
         que_subclase = "".
         DISPLAY /*rotulo*/
                 que_subclase
                 que_nombre                     
                 camino
                 WITH FRAME {&FRAME-NAME}.      
         RUN abre_query.
         RUN abre_query_articulos.
         
      END.   
   END.   
   ELSE DO:

      FIND FIRST Clase WHERE Clase.cdg_clase = que_clase 
                         AND Clase.cdg_subclase = que_clase + "." + que_subclase NO-ERROR.

      IF NOT AVAILABLE Clase
      THEN DO:
         MESSAGE "No existe la clase indicada" VIEW-AS ALERT-BOX ERROR.
         RETURN NO-APPLY.
      END.
      ELSE DO:
         que_nombre = Clase.nombre_subclase.
         ASSIGN que_clase = que_clase + "." + que_subclase
                que_subclase = "".
         como_fue = camino:ADD-LAST(que_nombre).

         RUN armar_rotulo.
         DISPLAY /*rotulo*/
                 que_subclase
                 que_nombre                     
                 camino
                 WITH FRAME {&FRAME-NAME}.
      END.

   END.   
   DISPLAY que_clase WITH FRAME {&FRAME-NAME}.
   RUN abre_query.
   RUN abre_query_articulos.
   RETURN NO-APPLY.
    
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
  que_clase = "".
  RUN ABRE_QUERY.
  camino:DELIMITER IN FRAME {&FRAME-NAME} = "@".
  DO j = 2 TO NUM-ENTRIES(sel_clase,"."):
     que_subclase = ENTRY(j,sel_clase,".").
     DISPLAY que_subclase
             WITH FRAME {&FRAME-NAME}.
     APPLY "RETURN" TO que_subclase IN FRAME {&FRAME-NAME}.
  END.
  WAIT-FOR GO OF FRAME {&FRAME-NAME}.
END.
RUN disable_UI.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE abre_query Dialog-Frame 
PROCEDURE abre_query :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

        OPEN QUERY brw_clasificacion 
             FOR EACH Clase WHERE Clase.cdg_clase = que_clase NO-LOCK. 
                              
                              
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE abre_query_articulos Dialog-Frame 
PROCEDURE abre_query_articulos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

        OPEN QUERY brw_articulos 
             FOR EACH Articulo WHERE Articulo.cdg_subclase BEGINS que_clase
                                  BY Articulo.cdg_articulo. 


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE armar_rotulo Dialog-Frame 
PROCEDURE armar_rotulo :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  IF AVAILABLE Clase
     THEN rotulo = FILL(" ",l_rotulo - LENGTH(Clase.rotulo_siguiente) - 1) + Clase.rotulo_siguiente + ":". 
     ELSE rotulo = FILL(" ",l_rotulo - 1) + ":".


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

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
  DISPLAY que_subclase que_nombre que_clase camino 
      WITH FRAME Dialog-Frame.
  ENABLE RECT-1 que_subclase brw_clasificacion camino Btn_OK Btn_Cancel 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

