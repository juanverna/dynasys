&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame
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
DEFINE VARIABLE p-que_clase  AS CHARACTER.   
DEFINE VARIABLE puso_ok      AS LOGICAL.   
&ELSE
DEFINE OUTPUT PARAMETER   p-que_clase  AS CHARACTER.   
DEFINE OUTPUT PARAMETER   puso_ok      AS LOGICAL.   
&ENDIF

/* Local Variable Definitions ---                                       */

{nrorelea.i}

DEFINE BUFFER B-Clase_de_Zonas FOR Clase_de_Zonas.

DEFINE VARIABLE f-que_clase LIKE Clase_de_Zonas.cdg_subclasezng.

DEFINE VARIABLE p_punto              AS INTEGER INITIAL 0.
DEFINE VARIABLE l_rotulo             AS INTEGER INITIAL 0.
DEFINE VARIABLE como_fue             AS LOGICAL.

FORM           
   SKIP(0.2)   
   Clase_de_Zonas.nombre_subclasezng  COLON 16 FGCOLOR 9 BGCOLOR 15
   SKIP(0.2)   
   Clase_de_Zonas.rotulo_siguiente COLON 16 FGCOLOR 9 BGCOLOR 15
   SKIP(0.2)   
   Clase_de_Zonas.longitud_siguiente COLON 16 FGCOLOR 9 BGCOLOR 15
   Clase_de_Zonas.tipo_siguiente COLON 16 FGCOLOR 9
   SKIP(0.2)   
   WITH TITLE "Modificación de Clasificación.F2=Finalizar" THREE-D KEEP-TAB-ORDER
        FONT 4 FGCOLOR 9 BGCOLOR 8 VIEW-AS DIALOG-BOX SIDE-LABELS
        FRAME frm-registro.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Dialog-Box
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame
&Scoped-define BROWSE-NAME brw_clasificacion

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Clase_de_Zonas

/* Definitions for BROWSE brw_clasificacion                             */
&Scoped-define FIELDS-IN-QUERY-brw_clasificacion ~
SUBSTRING(Clase_de_Zonas.cdg_subclasezng,LENGTH(que_clase) + 2) ~
Clase_de_Zonas.nombre_subclasezng 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brw_clasificacion 
&Scoped-define QUERY-STRING-brw_clasificacion FOR EACH Clase_de_Zonas ~
      WHERE Clase_de_Zonas.cdg_clasezng = que_clase NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brw_clasificacion OPEN QUERY brw_clasificacion FOR EACH Clase_de_Zonas ~
      WHERE Clase_de_Zonas.cdg_clasezng = que_clase NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brw_clasificacion Clase_de_Zonas
&Scoped-define FIRST-TABLE-IN-QUERY-brw_clasificacion Clase_de_Zonas


/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define OPEN-BROWSERS-IN-QUERY-Dialog-Frame ~
    ~{&OPEN-QUERY-brw_clasificacion}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS que_subclase que_nombre que_clase ~
brw_clasificacion camino btn_modificar btn_eliminar Btn_OK Btn_Cancel 
&Scoped-Define DISPLAYED-OBJECTS que_subclase que_nombre que_clase camino 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD relleno Dialog-Frame 
FUNCTION relleno RETURNS CHARACTER
  ( INPUT nivel AS INTEGER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "&Salir" 
     SIZE 27 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON btn_eliminar 
     LABEL "&Eliminar" 
     SIZE 26 BY 1.14.

DEFINE BUTTON btn_modificar 
     LABEL "&Modificar" 
     SIZE 26 BY 1.14.

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "&Elegir y Salir" 
     SIZE 27 BY 1.14
     BGCOLOR 8 .

DEFINE VARIABLE que_clase AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 56 BY .81 NO-UNDO.

DEFINE VARIABLE que_nombre AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 43 BY .81
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE que_subclase AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 9 BY .81 NO-UNDO.

DEFINE VARIABLE camino AS CHARACTER 
     VIEW-AS SELECTION-LIST SINGLE 
     SIZE 56 BY 19.14
     FONT 2 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brw_clasificacion FOR 
      Clase_de_Zonas SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brw_clasificacion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brw_clasificacion Dialog-Frame _STRUCTURED
  QUERY brw_clasificacion NO-LOCK DISPLAY
      SUBSTRING(Clase_de_Zonas.cdg_subclasezng,LENGTH(que_clase) + 2) COLUMN-LABEL "Código!Clase" FORMAT "X(8)":U
      Clase_de_Zonas.nombre_subclasezng COLUMN-LABEL "Denominacion!Subclase" FORMAT "X(40)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 53 BY 19.14
         FONT 4
         TITLE "Clasificación".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     que_subclase AT ROW 1.29 COL 3 NO-LABEL
     que_nombre AT ROW 1.29 COL 11 COLON-ALIGNED NO-LABEL
     que_clase AT ROW 1.29 COL 56 COLON-ALIGNED NO-LABEL
     brw_clasificacion AT ROW 2.33 COL 3
     camino AT ROW 2.33 COL 58 NO-LABEL
     btn_modificar AT ROW 21.71 COL 3
     btn_eliminar AT ROW 21.71 COL 30
     Btn_OK AT ROW 21.71 COL 58
     Btn_Cancel AT ROW 21.71 COL 87
     SPACE(0.99) SKIP(0.38)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Selección de Zonas Geográficas".


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Dialog-Box
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
                                                                        */
/* BROWSE-TAB brw_clasificacion que_clase Dialog-Frame */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN que_subclase IN FRAME Dialog-Frame
   ALIGN-L                                                              */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brw_clasificacion
/* Query rebuild information for BROWSE brw_clasificacion
     _TblList          = "sic.Clase_de_Zonas"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "Clase_de_Zonas.cdg_clasezng = que_clase"
     _FldNameList[1]   > "_<CALC>"
"SUBSTRING(Clase_de_Zonas.cdg_subclasezng,LENGTH(que_clase) + 2)" "Código!Clase" "X(8)" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[2]   > sic.Clase_de_Zonas.nombre_subclasezng
"Clase_de_Zonas.nombre_subclasezng" "Denominacion!Subclase" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _Query            is OPENED
*/  /* BROWSE brw_clasificacion */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Selección de Zonas Geográficas */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brw_clasificacion
&Scoped-define SELF-NAME brw_clasificacion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brw_clasificacion Dialog-Frame
ON RETURN OF brw_clasificacion IN FRAME Dialog-Frame /* Clasificación */
OR MOUSE-SELECT-DBLCLICK OF brw_clasificacion IN FRAME {&FRAME-NAME}
DO:

   que_subclase = SUBSTRING(Clase_de_Zonas.cdg_subclasezng,LENGTH(que_clase) + 2).
   DISPLAY que_subclase
           WITH FRAME {&FRAME-NAME}.
   APPLY "RETURN" TO que_subclase IN FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel Dialog-Frame
ON CHOOSE OF Btn_Cancel IN FRAME Dialog-Frame /* Salir */
DO:

  p-que_clase = ?.
  puso_ok = NO.
  
  &IF DEFINED (adm-panel) <> 0 &THEN
      RUN dispatch IN THIS-PROCEDURE ('exit').
  &ELSE
      APPLY "CLOSE":U TO THIS-PROCEDURE.
  &ENDIF
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_eliminar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_eliminar Dialog-Frame
ON CHOOSE OF btn_eliminar IN FRAME Dialog-Frame /* Eliminar */
DO:

   IF CAN-FIND(FIRST B-Clase_de_Zonas WHERE B-Clase_de_Zonas.cdg_clasezng = Clase_de_Zonas.cdg_subclasezng)
   THEN DO:
       RUN PONMENSJ.P (INPUT "CLAS001" ).
   END.    
   ELSE DO:                                                 
       DO TRANSACTION:
          FIND CURRENT Clase_de_Zonas EXCLUSIVE-LOCK.   
          DELETE Clase_de_Zonas.
       END.
       RUN ABRE_QUERY.
   END.    
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_modificar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_modificar Dialog-Frame
ON CHOOSE OF btn_modificar IN FRAME Dialog-Frame /* Modificar */
DO:
   DO TRANSACTION:
        FIND CURRENT Clase_de_Zonas EXCLUSIVE-LOCK.   
        RUN modificar_clasificacion.
        DISPLAY Clase_de_Zonas.nombre_subclasezng
                WITH BROWSE brw_clasificacion.
   END.        
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* Elegir y Salir */
DO:
  
  p-que_clase = que_clase.
  puso_ok = YES.
  
  &IF DEFINED (adm-panel) <> 0 &THEN
      RUN dispatch IN THIS-PROCEDURE ('exit').
  &ELSE
      APPLY "CLOSE":U TO THIS-PROCEDURE.
  &ENDIF
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME que_subclase
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_subclase Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF que_subclase IN FRAME Dialog-Frame
DO:
  que_subclase = "".
  DISPLAY que_subclase
          WITH FRAME {&FRAME-NAME}.
  APPLY "RETURN" TO que_subclase IN FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_subclase Dialog-Frame
ON RETURN OF que_subclase IN FRAME Dialog-Frame
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
            FIND FIRST Clase_de_Zonas WHERE Clase_de_Zonas.cdg_subclasezng = que_clase.
            que_nombre = Clase_de_Zonas.nombre.
            RUN armar_rotulo.
         END.
         ELSE DO:
            que_clase = "".
            que_nombre = "".
         END.
               
         como_fue = camino:DELETE(camino:NUM-ITEMS).
         que_subclase = "".
         DISPLAY que_subclase
                 que_nombre                     
                 camino
                 WITH FRAME {&FRAME-NAME}.      
         RUN abre_query.
         RUN abre_query_cuentas.
         
      END.   
   END.   
   ELSE DO:

      FIND FIRST Clase_de_Zonas WHERE Clase_de_Zonas.cdg_clasezng = que_clase 
                         AND Clase_de_Zonas.cdg_subclasezng = que_clase + "." + que_subclase NO-ERROR.

      IF NOT AVAILABLE Clase_de_Zonas
      THEN DO:
         que_nombre = "".
         RUN crear_clasificacion.         
      END.
      ELSE DO:
         que_nombre = Clase_de_Zonas.nombre_subclasezng.
         ASSIGN que_clase = que_clase + "." + que_subclase
                que_subclase = "".
         como_fue = camino:ADD-LAST(relleno( camino:NUM-ITEMS ) + que_nombre).

         RUN armar_rotulo.
         DISPLAY que_subclase
                 que_nombre                     
                 camino
                 WITH FRAME {&FRAME-NAME}.
      END.

   END.   
   DISPLAY que_clase WITH FRAME {&FRAME-NAME}.
   RUN abre_query.
   RUN abre_query_cuentas.
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
   
   {&OPEN-QUERY-{&BROWSE-NAME}}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE abre_query_cuentas Dialog-Frame 
PROCEDURE abre_query_cuentas :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

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

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE crear_clasificacion Dialog-Frame 
PROCEDURE crear_clasificacion :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DO ON ERROR UNDO, LEAVE:

         CREATE Clase_de_Zonas.
         ASSIGN 
                Clase_de_Zonas.cdg_clasezng = que_clase                                 
                Clase_de_Zonas.cdg_subclasezng = que_clase + "." + que_subclase.
         RUN MODIFICAR_CLASIFICACION.       

  END.

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
  ENABLE que_subclase que_nombre que_clase brw_clasificacion camino 
         btn_modificar btn_eliminar Btn_OK Btn_Cancel 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE iniciar_clase Dialog-Frame 
PROCEDURE iniciar_clase :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  FIND FIRST Clase_de_Zonas NO-LOCK NO-ERROR.
  IF NOT AVAILABLE Clase_de_Zonas
  THEN DO:
       DO TRANSACTION:
          CREATE Clase_de_Zonas.
          ASSIGN Clase_de_Zonas.cdg_clasezng    = ?
                 Clase_de_Zonas.cdg_subclasezng = "".
       END.
       RELEASE Clase_de_Zonas.
  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE modificar_clasificacion Dialog-Frame 
PROCEDURE modificar_clasificacion :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   UPDATE Clase_de_Zonas.nombre_subclasezng
          Clase_de_Zonas.rotulo_siguiente
          Clase_de_Zonas.longitud_siguiente
          Clase_de_Zonas.tipo_siguiente
          WITH FRAME frm-registro.
   HIDE FRAME frm-registro NO-PAUSE.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION relleno Dialog-Frame 
FUNCTION relleno RETURNS CHARACTER
  ( INPUT nivel AS INTEGER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

  DEFINE VARIABLE v-relleno AS CHARACTER.

  IF nivel = 0 
     THEN v-relleno = "".
     ELSE v-relleno = FILL(" ",nivel) + "-".

  RETURN v-relleno.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

