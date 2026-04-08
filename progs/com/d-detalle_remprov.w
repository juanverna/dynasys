&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame

/* Temp-Table and Buffer definitions                                    */
DEFINE SHARED TEMP-TABLE T-Rem_detalle_prv NO-UNDO LIKE Rem_detalle_prv.
DEFINE SHARED TEMP-TABLE T-Rem_header_prv NO-UNDO LIKE Rem_header_prv.


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
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Rem_detalle_prv

/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define FIELDS-IN-QUERY-Dialog-Frame T-Rem_detalle_prv.cantidad ~
T-Rem_detalle_prv.granel T-Rem_detalle_prv.precio 
&Scoped-define ENABLED-FIELDS-IN-QUERY-Dialog-Frame ~
T-Rem_detalle_prv.cantidad T-Rem_detalle_prv.granel ~
T-Rem_detalle_prv.precio 
&Scoped-define ENABLED-TABLES-IN-QUERY-Dialog-Frame T-Rem_detalle_prv
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-Dialog-Frame T-Rem_detalle_prv
&Scoped-define QUERY-STRING-Dialog-Frame FOR EACH T-Rem_detalle_prv SHARE-LOCK
&Scoped-define OPEN-QUERY-Dialog-Frame OPEN QUERY Dialog-Frame FOR EACH T-Rem_detalle_prv SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-Dialog-Frame T-Rem_detalle_prv
&Scoped-define FIRST-TABLE-IN-QUERY-Dialog-Frame T-Rem_detalle_prv


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS T-Rem_detalle_prv.cantidad ~
T-Rem_detalle_prv.granel T-Rem_detalle_prv.precio 
&Scoped-define ENABLED-TABLES T-Rem_detalle_prv
&Scoped-define FIRST-ENABLED-TABLE T-Rem_detalle_prv
&Scoped-Define ENABLED-OBJECTS v-tip_ocompra v-prf_ocompra v-nro_ocompra ~
v-nro_linea Btn_OK Btn_Cancel RECT-10 RECT-11 RECT-9 
&Scoped-Define DISPLAYED-FIELDS T-Rem_detalle_prv.cantidad ~
T-Rem_detalle_prv.granel T-Rem_detalle_prv.precio 
&Scoped-define DISPLAYED-TABLES T-Rem_detalle_prv
&Scoped-define FIRST-DISPLAYED-TABLE T-Rem_detalle_prv
&Scoped-Define DISPLAYED-OBJECTS v-cdg_articulo v-dsc_articulo ~
v-cdg_partida v-dsc_partida v-cdg_entidad v-dsc_entidad v-cdg_obra ~
v-dsc_obra v-tip_ocompra v-prf_ocompra v-nro_ocompra v-nro_linea 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 18 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 18 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON btn_sinobra 
     LABEL "&Sin Obra" 
     SIZE 15 BY 1.

DEFINE VARIABLE v-cdg_articulo AS CHARACTER FORMAT "X(256)":U 
     LABEL "Artículo" 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-cdg_entidad AS CHARACTER FORMAT "X(256)":U 
     LABEL "Entidad" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cdg_obra AS CHARACTER FORMAT "X(256)":U 
     LABEL "Obra" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cdg_partida AS CHARACTER FORMAT "X(256)":U 
     LABEL "Partida" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-dsc_articulo AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 58 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_entidad AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 58 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_obra AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 42 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_partida AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 58 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-nro_linea AS INTEGER FORMAT ">>9":U INITIAL 0 
     VIEW-AS FILL-IN NATIVE 
     SIZE 5 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-nro_ocompra AS INTEGER FORMAT "99999999":U INITIAL 0 
     VIEW-AS FILL-IN NATIVE 
     SIZE 12 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-prf_ocompra AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN NATIVE 
     SIZE 9 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-tip_ocompra AS CHARACTER FORMAT "X(2)":U 
     LABEL "O/Compra" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 5 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 91 BY 4.05.

DEFINE RECTANGLE RECT-11
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 91 BY 2.76.

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 91 BY 2.43.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY Dialog-Frame FOR 
      T-Rem_detalle_prv SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     v-cdg_articulo AT ROW 1.52 COL 12 COLON-ALIGNED
     v-dsc_articulo AT ROW 1.52 COL 31 COLON-ALIGNED NO-LABEL
     v-cdg_partida AT ROW 2.62 COL 12 COLON-ALIGNED
     v-dsc_partida AT ROW 2.62 COL 31 COLON-ALIGNED NO-LABEL
     v-cdg_entidad AT ROW 4.24 COL 12 COLON-ALIGNED
     v-dsc_entidad AT ROW 4.24 COL 31 COLON-ALIGNED NO-LABEL
     v-cdg_obra AT ROW 5.33 COL 12 COLON-ALIGNED
     v-dsc_obra AT ROW 5.33 COL 31 COLON-ALIGNED NO-LABEL
     btn_sinobra AT ROW 5.33 COL 76
     T-Rem_detalle_prv.cantidad AT ROW 7.19 COL 12.2 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-tip_ocompra AT ROW 7.19 COL 55.2 COLON-ALIGNED
     v-prf_ocompra AT ROW 7.19 COL 61.2 COLON-ALIGNED NO-LABEL
     v-nro_ocompra AT ROW 7.19 COL 71.2 COLON-ALIGNED NO-LABEL
     v-nro_linea AT ROW 7.19 COL 84.2 COLON-ALIGNED NO-LABEL
     T-Rem_detalle_prv.granel AT ROW 8.29 COL 12.2 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Rem_detalle_prv.precio AT ROW 8.29 COL 71.2 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Btn_OK AT ROW 9.62 COL 14.2
     Btn_Cancel AT ROW 9.62 COL 73.2
     RECT-10 AT ROW 6.95 COL 2
     RECT-11 AT ROW 3.95 COL 1.8
     RECT-9 AT ROW 1.29 COL 1.8
     SPACE(0.59) SKIP(7.32)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Detalle de Remito de Proveedor"
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: DIALOG-BOX
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Rem_detalle_prv T "SHARED" NO-UNDO sic Rem_detalle_prv
      TABLE: T-Rem_header_prv T "SHARED" NO-UNDO sic Rem_header_prv
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

/* SETTINGS FOR BUTTON btn_sinobra IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_articulo IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_entidad IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_obra IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_partida IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_articulo IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_entidad IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_obra IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_partida IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX Dialog-Frame
/* Query rebuild information for DIALOG-BOX Dialog-Frame
     _TblList          = "Temp-Tables.T-Rem_detalle_prv"
     _Options          = "SHARE-LOCK"
     _Query            is OPENED
*/  /* DIALOG-BOX Dialog-Frame */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Detalle de Remito de Proveedor */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* OK */
DO:
  ASSIGN FRAME {&FRAME-NAME}
        v-cdg_entidad
        v-cdg_obra
        v-cdg_partida
        T-Rem_detalle_prv.cantidad 
        T-Rem_detalle_prv.granel
        T-Rem_detalle_prv.precio
        v-nro_linea 
        v-nro_ocompra 
        v-prf_ocompra 
        v-tip_ocompra.
  
  RUN  validar_datos ( OUTPUT hubo_error ).
  IF NOT hubo_error
  THEN DO:
        IF p-modo-detalle = 0 /* Es un alta */ 
        THEN DO:
            ASSIGN
                T-Rem_header_prv.ultima_linea     = T-Rem_header_prv.ultima_linea + 1
                T-Rem_detalle_prv.nro_remprov     = T-Rem_header_prv.nro_remprov
                T-Rem_detalle_prv.nro_linea       = T-Rem_header_prv.ultima_linea.
        END.
        p-nro_linea-o = T-Rem_detalle_prv.nro_linea.
        codigo_salir = CD_GRABAR.
        APPLY "U1" TO THIS-PROCEDURE.
  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_sinobra
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_sinobra Dialog-Frame
ON CHOOSE OF btn_sinobra IN FRAME Dialog-Frame /* Sin Obra */
DO:

  ASSIGN
     T-Rem_detalle_prv.nro_obra = 0
     v-cdg_obra = ""
     v-dsc_obra = "".

  DISPLAY 
        v-cdg_obra
        v-dsc_obra
        WITH FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_entidad
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_entidad Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF v-cdg_entidad IN FRAME Dialog-Frame /* Entidad */
OR "." OF v-cdg_entidad IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_entidad IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Entidad" "cdg_entidad" "SELENTID.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_entidad Dialog-Frame
ON RETURN OF v-cdg_entidad IN FRAME Dialog-Frame /* Entidad */
DO:
    {traducetabla.i "Entidad" "cdg_entidad" "dsc_entidad"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_obra
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_obra Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF v-cdg_obra IN FRAME Dialog-Frame /* Obra */
OR "." OF v-cdg_obra IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_obra IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Obra" "cdg_obra" "SELOBRGL.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_obra Dialog-Frame
ON RETURN OF v-cdg_obra IN FRAME Dialog-Frame /* Obra */
DO:
    {traducetabla.i "Obra" "cdg_obra" "dsc_obra"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_partida
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_partida Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF v-cdg_partida IN FRAME Dialog-Frame /* Partida */
OR "." OF v-cdg_partida IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_partida IN FRAME {&FRAME-NAME}
DO:
  DEFINE VARIABLE x-cdg_partida LIKE Partida.cdg_partida.
  RUN d-seleccionar_partida-deposito.w ( INPUT  T-Rem_detalle_prv.nro_articulo,
                                         INPUT  T-Rem_header_prv.nro_deposito,
                                         OUTPUT x-cdg_partida ).
  IF x-cdg_partida <> ?
  THEN DO:
     DISPLAY x-cdg_partida @ v-cdg_partida 
             WITH FRAME {&FRAME-NAME}.
     APPLY "RETURN" TO v-cdg_partida IN FRAME {&FRAME-NAME}.        
     RETURN NO-APPLY.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_partida Dialog-Frame
ON RETURN OF v-cdg_partida IN FRAME Dialog-Frame /* Partida */
OR TAB OF v-cdg_partida  IN FRAME {&FRAME-NAME}
DO:

   FIND FIRST Partida NO-LOCK 
        WHERE Partida.cdg_empresa  = T-Rem_header_prv.cdg_empresa
          AND Partida.nro_articulo = T-Rem_detalle_prv.nro_articulo
          AND Partida.cdg_partida  = INPUT FRAME {&FRAME-NAME} v-cdg_partida NO-ERROR.

   IF NOT AVAILABLE Partida
   THEN DO:
        RUN ponmensj.p ( INPUT "ARTI008" ).
        RETURN NO-APPLY.
   END.
   ELSE DO:
         v-dsc_partida = Partida.descripcion.
         DISPLAY v-dsc_partida
                 WITH FRAME {&FRAME-NAME}.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-nro_linea
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-nro_linea Dialog-Frame
ON MOUSE-MENU-DOWN OF v-nro_linea IN FRAME Dialog-Frame
DO:
  
  DEFINE VARIABLE rid_detalle AS ROWID.

  RUN d-seleccionar_item_ocompra.w ( INPUT   Articulo.nro_articulo,
                                     INPUT   T-Rem_header_prv.nro_proveedor,
                                     INPUT   "Selección de Items de Ordenes de Compra",
                                     INPUT   "AA",
                                     OUTPUT  rid_detalle).
  IF rid_detalle <> ?
  THEN DO:
       FIND Ocm_detalle WHERE ROWID(Ocm_detalle) = rid_detalle NO-LOCK.
       FIND Ocm_header  OF Ocm_detalle.
       ASSIGN
            v-tip_ocompra = Ocm_header.tip_comprob
            v-prf_ocompra = Ocm_header.prf_comprob
            v-nro_ocompra = Ocm_header.nro_comprob
            v-nro_linea   = Ocm_detalle.nro_linea.
       DISPLAY  v-nro_linea 
                v-nro_ocompra 
                v-prf_ocompra 
                v-tip_ocompra
                Ocm_detalle.precio @ T-Rem_detalle_prv.precio
                WITH FRAME {&FRAME-NAME}.
  END.

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

  FIND FIRST T-Rem_header_prv.
  IF p-modo-detalle = 0
  THEN DO:
       FIND Articulo WHERE Articulo.nro_articulo  = p-nro_articulo NO-LOCK.
       ASSIGN v-cdg_articulo = Articulo.cdg_articulo
              v-dsc_articulo = Articulo.descripcion.
       CREATE T-Rem_detalle_prv.
       ASSIGN T-Rem_detalle_prv.nro_articulo = Articulo.nro_articulo
              T-Rem_detalle_prv.precio       = Articulo.costo.
       IF NOT Articulo.hay_partida
       THEN DO:
            FIND FIRST Partida OF Articulo 
                 WHERE Partida.cdg_empresa = T-Rem_header_prv.cdg_empresa
                       NO-LOCK.
            ASSIGN
                   T-Rem_detalle_prv.nro_partida = Partida.nro_partida.
                   v-cdg_partida = Partida.cdg_partida.
                   v-dsc_partida = Partida.descripcion.     
       END.
  END.
  ELSE DO:
       FIND FIRST T-Rem_detalle_prv WHERE T-Rem_detalle_prv.nro_linea = p-nro_linea-i EXCLUSIVE-LOCK.
       RUN traer_tablas.
  END.     

  DISPLAY 
        v-cdg_articulo
        v-dsc_articulo
        v-cdg_partida
        v-dsc_partida
        v-cdg_entidad
        v-dsc_entidad
        v-cdg_obra
        v-dsc_obra
        T-Rem_detalle_prv.cantidad 
        T-Rem_detalle_prv.granel
        v-nro_linea 
        v-nro_ocompra 
        v-prf_ocompra 
        v-tip_ocompra
        WITH FRAME {&FRAME-NAME}.      

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

  {&OPEN-QUERY-Dialog-Frame}
  GET FIRST Dialog-Frame.
  DISPLAY v-cdg_articulo v-dsc_articulo v-cdg_partida v-dsc_partida 
          v-cdg_entidad v-dsc_entidad v-cdg_obra v-dsc_obra v-tip_ocompra 
          v-prf_ocompra v-nro_ocompra v-nro_linea 
      WITH FRAME Dialog-Frame.
  IF AVAILABLE T-Rem_detalle_prv THEN 
    DISPLAY T-Rem_detalle_prv.cantidad T-Rem_detalle_prv.granel 
          T-Rem_detalle_prv.precio 
      WITH FRAME Dialog-Frame.
  ENABLE T-Rem_detalle_prv.cantidad v-tip_ocompra v-prf_ocompra v-nro_ocompra 
         v-nro_linea T-Rem_detalle_prv.granel T-Rem_detalle_prv.precio Btn_OK 
         Btn_Cancel RECT-10 RECT-11 RECT-9 
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

  DO WITH FRAME {&FRAME-NAME}:

    RUN hayobras.p ( OUTPUT hay_obras ).
    ASSIGN
        v-cdg_entidad:SENSITIVE                   = NO
        v-cdg_obra:SENSITIVE                      = NO
        T-Rem_detalle_prv.cantidad:SENSITIVE      = NO 
        T-Rem_detalle_prv.granel:SENSITIVE        = NO 
        T-Rem_detalle_prv.precio:SENSITIVE        = NO 
        v-tip_ocompra:SENSITIVE                   = NO 
        v-prf_ocompra:SENSITIVE                   = NO 
        v-nro_ocompra:SENSITIVE                   = NO 
        v-nro_linea:SENSITIVE                     = NO 
        btn_sinobra:SENSITIVE                     = NO
        Btn_OK:SENSITIVE                          = NO.


    CASE p-modo-cabecera:
        WHEN MD_ALTA                   
        THEN DO:
            v-cdg_entidad:SENSITIVE                   = YES.
            v-cdg_obra:SENSITIVE                      = hay_obras.
            v-cdg_partida:SENSITIVE                   = Articulo.hay_partida.
            T-Rem_detalle_prv.cantidad:SENSITIVE      = YES. 
            T-Rem_detalle_prv.granel:SENSITIVE        = Articulo.a_granel. 
            T-Rem_detalle_prv.precio:SENSITIVE        = YES.
            v-tip_ocompra:SENSITIVE                   = YES. 
            v-prf_ocompra:SENSITIVE                   = YES.
            v-nro_ocompra:SENSITIVE                   = YES.
            v-nro_linea:SENSITIVE                     = YES. 
            Btn_OK:SENSITIVE                          = YES.
            btn_sinobra:SENSITIVE                     = hay_obras.
        END.
        
        WHEN MD_MULTIPLE               
        THEN DO:
             /* Nada Habilitado */
        END.
        
        WHEN MD_DEFINIDA               
        THEN DO:
             /* Nada Habilitado */
        END.
        
        WHEN MD_RELACION               
        THEN DO:
             /* Nada Habilitado */
        END.
        
        WHEN MD_READONLY               
        THEN DO:
             /* Nada Habilitado */
        END.
        
        WHEN MD_CAMBIO                 
        THEN DO:
             /* Nada Habilitado */
        END.
        
        WHEN MD_GENERADO               
        THEN DO:
             /* Nada Habilitado */
        END.
         
        WHEN MD_ANULACION              
        THEN DO:
             /* Nada Habilitado */
        END.
         
        WHEN MD_EMISION                
        THEN DO:
             /* Nada Habilitado */
        END.

    END CASE.

  END.

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

  FIND Articulo OF T-Rem_detalle_prv NO-LOCK.
  v-cdg_articulo = Articulo.cdg_articulo.
  v-dsc_articulo = Articulo.descripcion.

  FIND Entidad OF T-Rem_detalle_prv NO-LOCK NO-ERROR.
  IF AVAILABLE Entidad
  THEN DO:
       v-cdg_entidad = Entidad.cdg_entidad.
       v-dsc_entidad = Entidad.dsc_entidad.
  END.
  ELSE DO:
       v-cdg_entidad = "".
       v-dsc_entidad = "".
  END.

  FIND Obra OF T-Rem_detalle_prv NO-LOCK NO-ERROR.
  IF AVAILABLE Obra
  THEN DO:
       v-cdg_obra = Obra.cdg_obra.
       v-dsc_obra = Obra.dsc_obra.
  END.
  ELSE DO:
       v-cdg_obra = "".
       v-dsc_obra = "".
  END.

  FIND Partida OF T-Rem_detalle_prv NO-LOCK NO-ERROR.
  IF AVAILABLE Partida
  THEN DO:
       v-cdg_partida = Partida.cdg_partida.
       v-dsc_partida = Partida.descripcion.
  END.
  ELSE DO:
       v-cdg_partida = "".
       v-dsc_partida = "".
  END.

  FIND Ocm_header OF T-Rem_detalle_prv NO-LOCK NO-ERROR.
  IF AVAILABLE Ocm_header
  THEN DO:
      FIND FIRST Ocm_detalle OF Ocm_header 
           WHERE Ocm_detalle.nro_linea = T-Rem_detalle_prv.nro_linea_ocm NO-LOCK.
    
      ASSIGN
             v-tip_ocompra = Ocm_header.tip_comprob
             v-prf_ocompra = Ocm_header.prf_comprob
             v-nro_ocompra = Ocm_header.nro_comprob
             v-nro_linea   = Ocm_detalle.nro_linea.
  END.
  ELSE DO:
      ASSIGN
             v-tip_ocompra = ""
             v-prf_ocompra = 0
             v-nro_ocompra = 0
             v-nro_linea   = 0.
  END.


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

   DEFINE OUTPUT PARAMETER hay_error AS LOGICAL.

   hay_error = YES.

   FIND Entidad WHERE Entidad.cdg_entidad = v-cdg_entidad NO-ERROR.
   IF NOT AVAILABLE Entidad
   THEN DO:
        RUN PONMENSJ.P ( INPUT "ASIE012" ).
        RETURN.
   END.
   ELSE DO:
        T-Rem_detalle_prv.nro_entidad = Entidad.nro_entidad.
   END.

   FIND Partida WHERE Partida.nro_articulo = Articulo.nro_articulo
                  AND Partida.cdg_partida  = v-cdg_partida
                  AND Partida.cdg_empresa  = T-Rem_header_prv.cdg_empresa
                      NO-LOCK NO-ERROR.
   IF NOT AVAILABLE Partida
   THEN DO:
        RUN PONMENSJ.P ( INPUT "FAPR033" ).
        RETURN.
   END.                             
   ELSE DO:
        T-Rem_detalle_prv.nro_partida = Partida.nro_partida.
   END.

   IF INPUT FRAME {&FRAME-NAME} v-cdg_obra <> ""
   THEN DO:
        FIND Obra WHERE Obra.cdg_obra = v-cdg_obra NO-ERROR.
        IF NOT AVAILABLE Obra
        THEN DO:
             RUN PONMENSJ.P ( INPUT "ASIE013" ).
             RETURN.
        END.
        ELSE DO:
             IF LOOKUP(Obra.entidades_validas,T-Rem_header_prv.cdg_empresa,",") = 0
             THEN DO:
                  RUN PONMENSJ.P ( INPUT "ASIE027" ).
                  RETURN.
             END.

             IF Obra.finalizada
             THEN DO:
                  RUN PONMENSJ.P ( INPUT "ASIE026" ).
                  RETURN.
             END.
             
             IF T-Rem_header_prv.fecha < Obra.fecha_apertura OR
                T-Rem_header_prv.fecha > Obra.fecha_cierre 
             THEN DO:
                  RUN PONMENSJ.P ( INPUT "ASIE026" ).
                  RETURN.
             END.

             T-Rem_detalle_prv.nro_obra = Obra.nro_obra.

        END.
   END.

   IF v-tip_ocompra <> ""
   THEN DO:
         
        FIND Ocm_header
             WHERE Ocm_header.tip_comprob = v-tip_ocompra
               AND Ocm_header.prf_comprob = v-prf_ocompra
               AND Ocm_header.nro_comprob = v-nro_ocompra
               AND Ocm_header.cdg_empresa = T-Rem_header_prv.cdg_empresa
                   NO-LOCK NO-ERROR.
        IF AVAILABLE Ocm_header
        THEN DO:
            IF Ocm_header.nro_proveedor = T-Rem_header_prv.nro_proveedor            
            THEN DO:
                IF Ocm_header.cdg_estado = "AA"
                THEN DO:
                    FIND FIRST Ocm_detalle OF Ocm_header 
                         WHERE Ocm_detalle.nro_linea = v-nro_linea NO-LOCK NO-ERROR.
                    IF AVAILABLE Ocm_detalle
                    THEN DO:
                         IF T-Rem_detalle_prv.nro_articulo = Ocm_detalle.nro_articulo
                         THEN DO:
                              IF Ocm_detalle.cantidad_rec < Ocm_detalle.cantidad OR
                                 Ocm_detalle.cdg_estado <> "AA"
                              THEN DO:
                                   IF Ocm_detalle.cantidad - Ocm_detalle.cantidad_rec >= T-Rem_detalle_prv.cantidad
                                   THEN DO:
                                        ASSIGN
                                              T-Rem_detalle_prv.nro_ocompra   = Ocm_detalle.nro_ocompra
                                              T-Rem_detalle_prv.nro_linea_ocm = Ocm_detalle.nro_linea
                                              T-Rem_detalle_prv.precio        = Ocm_detalle.precio.
                                   END.
                                   ELSE DO:
                                        RUN PONMENSJ.P ( INPUT "RPRV039" ).
                                        RETURN.
                                   END.
                              END.
                              ELSE DO:
                                   RUN PONMENSJ.P ( INPUT "RPRV038" ).
                                   RETURN.
                              END.
                         END.       
                         ELSE DO:
                              RUN PONMENSJ.P ( INPUT "RPRV034" ).
                              RETURN.
                         END.
                    END.
                    ELSE DO:
                         RUN PONMENSJ.P ( INPUT "RPRV033" ).
                         RETURN.
                    END.
                END.
                ELSE DO:
                     RUN PONMENSJ.P ( INPUT "RPRV040" ).
                     RETURN.
                END.

            END.
            ELSE DO:
                RUN PONMENSJ.P ( INPUT "RPRV031" ).
                RETURN.
            END.
        END.
        ELSE DO:
             RUN PONMENSJ.P ( INPUT "RPRV030" ).
             RETURN.
        END.

   END.

   hay_error = NO.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

