&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame

/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Ped_header NO-UNDO LIKE sic.Ped_header.


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
DEFINE INPUT   PARAMETER  p-modo-cabecera  AS INTEGER.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Ped_header.
&ENDIF

/* Local Variable Definitions ---                                       */

{valoresmodo.i}
{valoressalida.i}

DEFINE VARIABLE           rid_tabla       AS ROWID.
DEFINE VARIABLE           hubo_error      AS LOGICAL.
DEFINE VARIABLE           hay_obras       AS LOGICAL.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Ped_header

/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define FIELDS-IN-QUERY-Dialog-Frame T-Ped_header.transportista ~
T-Ped_header.fecha_comex T-Ped_header.fecha_carga ~
T-Ped_header.fecha_embarque 
&Scoped-define ENABLED-FIELDS-IN-QUERY-Dialog-Frame ~
T-Ped_header.transportista T-Ped_header.fecha_comex ~
T-Ped_header.fecha_carga T-Ped_header.fecha_embarque 
&Scoped-define ENABLED-TABLES-IN-QUERY-Dialog-Frame T-Ped_header
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-Dialog-Frame T-Ped_header

&Scoped-define FIELD-PAIRS-IN-QUERY-Dialog-Frame~
 ~{&FP1}transportista ~{&FP2}transportista ~{&FP3}~
 ~{&FP1}fecha_comex ~{&FP2}fecha_comex ~{&FP3}~
 ~{&FP1}fecha_carga ~{&FP2}fecha_carga ~{&FP3}~
 ~{&FP1}fecha_embarque ~{&FP2}fecha_embarque ~{&FP3}
&Scoped-define OPEN-QUERY-Dialog-Frame OPEN QUERY Dialog-Frame FOR EACH T-Ped_header SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-Dialog-Frame T-Ped_header
&Scoped-define FIRST-TABLE-IN-QUERY-Dialog-Frame T-Ped_header


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS T-Ped_header.transportista ~
T-Ped_header.fecha_comex T-Ped_header.fecha_carga ~
T-Ped_header.fecha_embarque 
&Scoped-define FIELD-PAIRS~
 ~{&FP1}transportista ~{&FP2}transportista ~{&FP3}~
 ~{&FP1}fecha_comex ~{&FP2}fecha_comex ~{&FP3}~
 ~{&FP1}fecha_carga ~{&FP2}fecha_carga ~{&FP3}~
 ~{&FP1}fecha_embarque ~{&FP2}fecha_embarque ~{&FP3}
&Scoped-define ENABLED-TABLES T-Ped_header
&Scoped-define FIRST-ENABLED-TABLE T-Ped_header
&Scoped-Define ENABLED-OBJECTS RECT-13 v-cdg_puerto_embarque ~
v-cdg_puerto_destino v-cdg_tipo_embarque Btn_OK Btn_Cancel 
&Scoped-Define DISPLAYED-FIELDS T-Ped_header.transportista ~
T-Ped_header.fecha_comex T-Ped_header.fecha_carga ~
T-Ped_header.fecha_embarque 
&Scoped-Define DISPLAYED-OBJECTS v-cdg_puerto_embarque ~
v-dsc_puerto_embarque v-cdg_puerto_destino v-dsc_puerto_destino ~
v-cdg_tipo_embarque v-dsc_tipo_embarque 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 13 BY 1.15
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 13 BY 1.15
     BGCOLOR 8 .

DEFINE VARIABLE v-cdg_puerto_destino AS INTEGER FORMAT "->,>>>,>>9" INITIAL 0 
     LABEL "Puerto de Destino" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 7 BY .81
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_puerto_embarque AS INTEGER FORMAT "->,>>>,>>9" INITIAL 0 
     LABEL "Puerto de Origen" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 7 BY .81
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_tipo_embarque AS INTEGER FORMAT "->,>>>,>>9" INITIAL 0 
     LABEL "Forma Embarque" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 7 BY .81
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-dsc_puerto_destino AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 37 BY .81
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_puerto_embarque AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 37 BY .81
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_tipo_embarque AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 37 BY .81
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-13
     EDGE-PIXELS 6 GRAPHIC-EDGE  NO-FILL 
     SIZE 65 BY 8.35.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY Dialog-Frame FOR 
      T-Ped_header SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     v-cdg_puerto_embarque AT ROW 1.81 COL 17 COLON-ALIGNED HELP
          "Codigo de tipo de embarque"
     v-dsc_puerto_embarque AT ROW 1.81 COL 25 COLON-ALIGNED NO-LABEL
     v-cdg_puerto_destino AT ROW 2.88 COL 17 COLON-ALIGNED HELP
          "Codigo de consignatario"
     v-dsc_puerto_destino AT ROW 2.88 COL 25 COLON-ALIGNED NO-LABEL
     v-cdg_tipo_embarque AT ROW 3.96 COL 17 COLON-ALIGNED HELP
          "Codigo de tipo de embarque"
     v-dsc_tipo_embarque AT ROW 3.96 COL 25 COLON-ALIGNED NO-LABEL
     T-Ped_header.transportista AT ROW 5.04 COL 17 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 45 BY .81
          BGCOLOR 15 FGCOLOR 9 
     T-Ped_header.fecha_comex AT ROW 6.12 COL 17 COLON-ALIGNED
          LABEL "Listo Comex"
          VIEW-AS FILL-IN NATIVE 
          SIZE 14 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Btn_OK AT ROW 6.12 COL 51
     T-Ped_header.fecha_carga AT ROW 7.19 COL 17 COLON-ALIGNED
          LABEL "Carga"
          VIEW-AS FILL-IN NATIVE 
          SIZE 14 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Btn_Cancel AT ROW 7.46 COL 51
     T-Ped_header.fecha_embarque AT ROW 8.27 COL 17 COLON-ALIGNED
          LABEL "Embarque"
          VIEW-AS FILL-IN NATIVE 
          SIZE 14 BY .81
          BGCOLOR 15 FGCOLOR 9 
     RECT-13 AT ROW 1.27 COL 1
     SPACE(1.13) SKIP(0.91)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Datos de Embarque del Pedido Internacional"
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: DIALOG-BOX
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Ped_header T "?" NO-UNDO sic Ped_header
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS


/* ***************  Runtime Attributes and UIB Settings  ************** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
                                                                        */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN T-Ped_header.fecha_carga IN FRAME Dialog-Frame
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN T-Ped_header.fecha_comex IN FRAME Dialog-Frame
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN T-Ped_header.fecha_embarque IN FRAME Dialog-Frame
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN v-dsc_puerto_destino IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_puerto_embarque IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_tipo_embarque IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX Dialog-Frame
/* Query rebuild information for DIALOG-BOX Dialog-Frame
     _TblList          = "Temp-Tables.T-Ped_header"
     _Options          = "SHARE-LOCK"
     _Query            is OPENED
*/  /* DIALOG-BOX Dialog-Frame */
&ANALYZE-RESUME

 




/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Datos de Embarque del Pedido Internacional */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* OK */
DO:

  RUN  validar_datos ( OUTPUT hubo_error ).
  IF NOT hubo_error
  THEN DO:
        ASSIGN FRAME {&FRAME-NAME}
               T-Ped_header.fecha_carga 
               T-Ped_header.fecha_embarque
               T-Ped_header.fecha_comex
               T-Ped_header.transportista.
        codigo_salir = CD_GRABAR.
        APPLY "U1" TO THIS-PROCEDURE.
  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_puerto_destino
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_puerto_destino Dialog-Frame
ON MOUSE-MENU-DOWN OF v-cdg_puerto_destino IN FRAME Dialog-Frame /* Puerto de Destino */
OR "." OF v-cdg_puerto_destino IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_puerto_destino IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Puerto_destino" "cdg_puerto_des" "SELPTODS.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_puerto_destino Dialog-Frame
ON RETURN OF v-cdg_puerto_destino IN FRAME Dialog-Frame /* Puerto de Destino */
DO:
   {traducetabla.i "Puerto_destino" "cdg_puerto_des" "nombre_puerto_des"}   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_puerto_embarque
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_puerto_embarque Dialog-Frame
ON MOUSE-MENU-DOWN OF v-cdg_puerto_embarque IN FRAME Dialog-Frame /* Puerto de Origen */
OR "." OF v-cdg_puerto_embarque IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_puerto_embarque IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Puerto_embarque" "cdg_puerto_emb" "SELPTOEM.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_puerto_embarque Dialog-Frame
ON RETURN OF v-cdg_puerto_embarque IN FRAME Dialog-Frame /* Puerto de Origen */
DO:
   {traducetabla.i "Puerto_embarque" "cdg_puerto_emb" "nombre_puerto_emb"} 
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_tipo_embarque
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_tipo_embarque Dialog-Frame
ON MOUSE-MENU-DOWN OF v-cdg_tipo_embarque IN FRAME Dialog-Frame /* Forma Embarque */
OR "." OF v-cdg_tipo_embarque IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_tipo_embarque IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Tipo_embarque" "cdg_embarque" "SELTIPEM.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_tipo_embarque Dialog-Frame
ON RETURN OF v-cdg_tipo_embarque IN FRAME Dialog-Frame /* Forma Embarque */
DO:
   {traducetabla.i "Tipo_embarque" "cdg_embarque" "descripcion"}
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

  FIND FIRST T-Ped_header.
  RUN traer_tablas.
  DISPLAY 
        T-Ped_header.fecha_carga 
        T-Ped_header.fecha_embarque
        v-cdg_puerto_embarque
        v-dsc_puerto_embarque
        v-cdg_puerto_destino
        v-dsc_puerto_destino
        v-cdg_tipo_embarque
        v-dsc_tipo_embarque
        WITH FRAME {&FRAME-NAME}.      

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI Dialog-Frame _DEFAULT-DISABLE
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI Dialog-Frame _DEFAULT-ENABLE
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
  DISPLAY v-cdg_puerto_embarque v-dsc_puerto_embarque v-cdg_puerto_destino 
          v-dsc_puerto_destino v-cdg_tipo_embarque v-dsc_tipo_embarque 
      WITH FRAME Dialog-Frame.
  IF AVAILABLE T-Ped_header THEN 
    DISPLAY T-Ped_header.transportista T-Ped_header.fecha_comex 
          T-Ped_header.fecha_carga T-Ped_header.fecha_embarque 
      WITH FRAME Dialog-Frame.
  ENABLE RECT-13 v-cdg_puerto_embarque v-cdg_puerto_destino v-cdg_tipo_embarque 
         T-Ped_header.transportista T-Ped_header.fecha_comex Btn_OK 
         T-Ped_header.fecha_carga Btn_Cancel T-Ped_header.fecha_embarque 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_puerto_destino Dialog-Frame 
PROCEDURE traer_puerto_destino :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND Puerto_destino OF T-Ped_header   NO-LOCK NO-ERROR.
    IF AVAILABLE Puerto_destino 
       THEN ASSIGN
                   v-cdg_puerto_destino = Puerto_destino.cdg_puerto_des
                   v-dsc_puerto_destino = Puerto_destino.nombre_puerto_des.
       ELSE ASSIGN
                   v-cdg_puerto_destino = 0
                   v-dsc_puerto_destino = "".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_puerto_embarque Dialog-Frame 
PROCEDURE traer_puerto_embarque :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND Puerto_embarque OF T-Ped_header   NO-LOCK NO-ERROR.
    IF AVAILABLE Puerto_embarque 
       THEN ASSIGN
                   v-cdg_puerto_embarque = Puerto_embarque.cdg_puerto_emb
                   v-dsc_puerto_embarque = Puerto_embarque.nombre_puerto_emb.
       ELSE ASSIGN
                   v-cdg_puerto_embarque = 0
                   v-dsc_puerto_embarque = "".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_tablas Dialog-Frame 
PROCEDURE traer_tablas :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  RUN traer_puerto_embarque.
  RUN traer_puerto_destino.
  RUN traer_tipo_embarque.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_tipo_embarque Dialog-Frame 
PROCEDURE traer_tipo_embarque :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND Tipo_embarque OF T-Ped_header   NO-LOCK NO-ERROR.
    IF AVAILABLE Tipo_embarque 
       THEN ASSIGN
                   v-cdg_tipo_embarque = Tipo_embarque.cdg_embarque
                   v-dsc_tipo_embarque = Tipo_embarque.descripcion.
       ELSE ASSIGN
                   v-cdg_tipo_embarque = 0
                   v-dsc_tipo_embarque = "".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE validar_datos Dialog-Frame 
PROCEDURE validar_datos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE OUTPUT PARAMETER hubo_error AS LOGICAL.
    
    hubo_error = YES.
    
    {validartabla.i "Puerto_embarque"   "cdg_puerto_emb"  "nombre_puerto_emb"    "PINT012"}
    {validartabla.i "Puerto_destino"    "cdg_puerto_des"  "nombre_puerto_des"    "PINT013"}
    {validartabla.i "Tipo_embarque"     "cdg_embarque"    "descripcion"          "PINT014"}

    hubo_error = NO.

    &SCOPED-DEFINE TABLA-MAESTRA  T-Ped_header

    {asignartabla.i "Puerto_embarque"   "cdg_puerto_emb"  "cdg_puerto_emb"}
    {asignartabla.i "Puerto_destino"    "cdg_puerto_des"  "cdg_puerto_des"}
    {asignartabla.i "Tipo_embarque"     "cdg_embarque"    "cdg_embarque" }

    &UNDEFINE TABLA-MAESTRA

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


