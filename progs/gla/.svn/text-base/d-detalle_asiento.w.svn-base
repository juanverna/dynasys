&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame

/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Asn_detalle NO-UNDO LIKE Asn_detalle.
DEFINE TEMP-TABLE T-Asn_header NO-UNDO LIKE Asn_header.


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
DEFINE VARIABLE           p-nro_moneda-h   LIKE Asn_header.nro_moneda.
DEFINE VARIABLE           p-nro_cuenta     LIKE Cuenta.nro_cuenta.
DEFINE VARIABLE           p-nro_linea-i    LIKE Asn_detalle.nro_linea.
DEFINE VARIABLE           p-nro_moneda-i   LIKE Asn_detalle.nro_moneda.
DEFINE VARIABLE           p-reexpresion    LIKE Asn_detalle.reexpresion.
DEFINE VARIABLE           p-modo-cabecera  AS INTEGER.
DEFINE VARIABLE           p-modo-detalle   AS INTEGER.
DEFINE VARIABLE           p-nro_linea-o    LIKE Asn_detalle.nro_linea.
&ELSE
DEFINE INPUT   PARAMETER  p-nro_moneda-h   LIKE Asn_header.nro_moneda.
DEFINE INPUT   PARAMETER  p-nro_cuenta     LIKE Cuenta.nro_cuenta.
DEFINE INPUT   PARAMETER  p-nro_linea-i    LIKE Asn_detalle.nro_linea.
DEFINE INPUT   PARAMETER  p-nro_moneda-i   LIKE Asn_detalle.nro_moneda.
DEFINE INPUT   PARAMETER  p-reexpresion    LIKE Asn_detalle.reexpresion.
DEFINE INPUT   PARAMETER  p-modo-cabecera  AS INTEGER.
DEFINE INPUT   PARAMETER  p-modo-detalle   AS INTEGER.
DEFINE OUTPUT  PARAMETER  p-nro_linea-o    LIKE Asn_detalle.nro_linea.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Asn_header.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Asn_detalle.
&ENDIF

/* Local Variable Definitions ---                                       */

{valoresmodo.i}
{valoressalida.i}

DEFINE VARIABLE               rid_tabla   AS ROWID.
DEFINE VARIABLE               hubo_error  AS LOGICAL.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Asn_detalle

/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define FIELDS-IN-QUERY-Dialog-Frame ~
T-Asn_detalle.lista_imputaciones T-Asn_detalle.debito T-Asn_detalle.credito ~
T-Asn_detalle.cambio T-Asn_detalle.debito_can T-Asn_detalle.credito_can ~
T-Asn_detalle.valor_unitario T-Asn_detalle.unidades ~
T-Asn_detalle.leyen_detalle 
&Scoped-define QUERY-STRING-Dialog-Frame FOR EACH T-Asn_detalle SHARE-LOCK
&Scoped-define OPEN-QUERY-Dialog-Frame OPEN QUERY Dialog-Frame FOR EACH T-Asn_detalle SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-Dialog-Frame T-Asn_detalle
&Scoped-define FIRST-TABLE-IN-QUERY-Dialog-Frame T-Asn_detalle


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-10 RECT-11 RECT-9 v-moneda Btn_Cancel 
&Scoped-Define DISPLAYED-FIELDS T-Asn_detalle.lista_imputaciones ~
T-Asn_detalle.debito T-Asn_detalle.credito T-Asn_detalle.cambio ~
T-Asn_detalle.debito_can T-Asn_detalle.credito_can ~
T-Asn_detalle.valor_unitario T-Asn_detalle.unidades ~
T-Asn_detalle.leyen_detalle 
&Scoped-define DISPLAYED-TABLES T-Asn_detalle
&Scoped-define FIRST-DISPLAYED-TABLE T-Asn_detalle
&Scoped-Define DISPLAYED-OBJECTS v-cdg_cuenta v-nom_cuenta v-cdg_entidad ~
v-dsc_entidad v-cdg_obra v-dsc_obra v-moneda 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON btn_elegir 
     LABEL "&Elegir" 
     SIZE 15 BY 1.

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON btn_sinobra 
     LABEL "&Sin Obra" 
     SIZE 15 BY 1.

DEFINE VARIABLE v-moneda AS CHARACTER FORMAT "X(256)":U 
     LABEL "Moneda" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Item 1","Item 1"
     DROP-DOWN-LIST
     SIZE 37 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cdg_cuenta AS CHARACTER FORMAT "X(256)":U 
     LABEL "Cuenta" 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-cdg_entidad AS CHARACTER FORMAT "X(256)":U 
     LABEL "Entidad" 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cdg_obra AS CHARACTER FORMAT "X(256)":U 
     LABEL "Obra" 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-dsc_entidad AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 63 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_obra AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 46 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-nom_cuenta AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 63 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 100 BY 6.24.

DEFINE RECTANGLE RECT-11
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 100 BY 1.43.

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 100 BY 4.24.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY Dialog-Frame FOR 
      T-Asn_detalle SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     v-cdg_cuenta AT ROW 1.71 COL 16 COLON-ALIGNED
     v-nom_cuenta AT ROW 1.71 COL 35 COLON-ALIGNED NO-LABEL
     v-cdg_entidad AT ROW 2.91 COL 16 COLON-ALIGNED
     v-dsc_entidad AT ROW 2.91 COL 35 COLON-ALIGNED NO-LABEL
     v-cdg_obra AT ROW 4.1 COL 16 COLON-ALIGNED
     v-dsc_obra AT ROW 4.1 COL 35 COLON-ALIGNED NO-LABEL
     btn_sinobra AT ROW 4.1 COL 85
     T-Asn_detalle.lista_imputaciones AT ROW 5.76 COL 16 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 65 BY 1
          BGCOLOR 15 FGCOLOR 9 
     btn_elegir AT ROW 5.76 COL 85
     v-moneda AT ROW 7.43 COL 16 COLON-ALIGNED
     Btn_OK AT ROW 7.43 COL 85
     Btn_Cancel AT ROW 8.86 COL 85
     T-Asn_detalle.debito AT ROW 9.57 COL 16 COLON-ALIGNED
          LABEL "Importes"
          VIEW-AS FILL-IN 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Asn_detalle.credito AT ROW 9.57 COL 35 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Asn_detalle.cambio AT ROW 9.57 COL 65 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Asn_detalle.debito_can AT ROW 10.76 COL 16 COLON-ALIGNED
          LABEL "Unidades"
          VIEW-AS FILL-IN 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Asn_detalle.credito_can AT ROW 10.76 COL 35 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Asn_detalle.valor_unitario AT ROW 10.76 COL 65 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Asn_detalle.unidades AT ROW 10.76 COL 86
          VIEW-AS TOGGLE-BOX
          SIZE 14 BY .76
     T-Asn_detalle.leyen_detalle AT ROW 11.95 COL 16 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 82 BY 1
          BGCOLOR 15 FGCOLOR 9 
     "         Créditos" VIEW-AS TEXT
          SIZE 18 BY .81 AT ROW 8.62 COL 37
          BGCOLOR 5 FGCOLOR 15 FONT 6
     "          Débitos" VIEW-AS TEXT
          SIZE 18 BY .81 AT ROW 8.62 COL 18
          BGCOLOR 5 FGCOLOR 15 FONT 6
     RECT-10 AT ROW 6.95 COL 2
     RECT-11 AT ROW 5.52 COL 2
     RECT-9 AT ROW 1.29 COL 2
     SPACE(3.79) SKIP(8.03)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Detalle de Asiento"
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: DIALOG-BOX
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Asn_detalle T "?" NO-UNDO sic Asn_detalle
      TABLE: T-Asn_header T "?" NO-UNDO sic Asn_header
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

/* SETTINGS FOR BUTTON btn_elegir IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON Btn_OK IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_sinobra IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Asn_detalle.cambio IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Asn_detalle.credito IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Asn_detalle.credito_can IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Asn_detalle.debito IN FRAME Dialog-Frame
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN T-Asn_detalle.debito_can IN FRAME Dialog-Frame
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN T-Asn_detalle.leyen_detalle IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Asn_detalle.lista_imputaciones IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR TOGGLE-BOX T-Asn_detalle.unidades IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_cuenta IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_entidad IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_obra IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_entidad IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_obra IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-nom_cuenta IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Asn_detalle.valor_unitario IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX Dialog-Frame
/* Query rebuild information for DIALOG-BOX Dialog-Frame
     _TblList          = "Temp-Tables.T-Asn_detalle"
     _Options          = "SHARE-LOCK"
     _Query            is OPENED
*/  /* DIALOG-BOX Dialog-Frame */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Detalle de Asiento */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel Dialog-Frame
ON CHOOSE OF Btn_Cancel IN FRAME Dialog-Frame /* Cancel */
DO:
    IF p-modo-detalle = 0
       THEN DELETE T-Asn_detalle.
    p-nro_linea-o = 0.
    codigo_salir = CD_SALIR.
    APPLY "U1" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_elegir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_elegir Dialog-Frame
ON CHOOSE OF btn_elegir IN FRAME Dialog-Frame /* Elegir */
DO:
  {ELEGIR.I "T-Asn_detalle" "lista_imputaciones" "Imputacioncontable" "cdg_imputacontable" "dsc_imputacontable" "selecimputacontable.p"}

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
        T-Asn_detalle.cambio 
        T-Asn_detalle.credito 
        T-Asn_detalle.credito_can 
        T-Asn_detalle.debito 
        T-Asn_detalle.debito_can 
        T-Asn_detalle.leyen_detalle 
        T-Asn_detalle.unidades 
        T-Asn_detalle.valor_unitario
        T-Asn_detalle.lista_imputaciones.
  
  
  RUN  validar_datos ( OUTPUT hubo_error ).
  IF NOT hubo_error
  THEN DO:
        IF p-modo-detalle = 0 /* Es un alta */ 
        THEN DO:
            ASSIGN
                T-Asn_header.ultima_linea     = T-Asn_header.ultima_linea + 1
                T-Asn_detalle.nro_asiento     = T-Asn_header.nro_asiento
                T-Asn_detalle.nro_linea       = T-Asn_header.ultima_linea
                T-Asn_detalle.cdg_empresa     = T-Asn_header.cdg_empresa.
        END.
        p-nro_linea-o = T-Asn_detalle.nro_linea.
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
     T-Asn_detalle.nro_obra = 0
     v-cdg_obra = ""
     v-dsc_obra = "".

  DISPLAY 
        v-cdg_obra
        v-dsc_obra
        WITH FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Asn_detalle.cambio
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Asn_detalle.cambio Dialog-Frame
ON LEAVE OF T-Asn_detalle.cambio IN FRAME Dialog-Frame /* Cambio */
DO:
/*
  T-Asn_detalle.debito  = ROUND(INPUT FRAME {&FRAME-NAME} T-Asn_detalle.debito_div *
                                INPUT FRAME {&FRAME-NAME} T-Asn_detalle.cambio,2).

  T-Asn_detalle.credito = ROUND(INPUT FRAME {&FRAME-NAME} T-Asn_detalle.credito_div *
                                INPUT FRAME {&FRAME-NAME} T-Asn_detalle.cambio,2).
  DISPLAY T-Asn_detalle.credito
          T-Asn_detalle.debito
          WITH FRAME {&FRAME-NAME}.
*/  
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


&Scoped-define SELF-NAME v-moneda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-moneda Dialog-Frame
ON VALUE-CHANGED OF v-moneda IN FRAME Dialog-Frame /* Moneda */
DO:
   RUN poner_moneda.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Dialog-Frame 


/* ***************************  Main Block  *************************** */

/* Parent the dialog-box to the ACTIVE-WINDOW, if there is no parent.   */
IF VALID-HANDLE(ACTIVE-WINDOW) AND FRAME {&FRAME-NAME}:PARENT eq ?
THEN FRAME {&FRAME-NAME}:PARENT = ACTIVE-WINDOW.

RUN inicia_combos.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */

MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.

  FIND FIRST T-Asn_header.
  IF p-modo-detalle = 0
  THEN DO:
       FIND Cuenta WHERE Cuenta.nro_cuenta  = p-nro_cuenta NO-LOCK.
       ASSIGN v-cdg_cuenta = Cuenta.cdg_cuenta
              v-nom_cuenta = Cuenta.nombre_cta.

       CREATE T-Asn_detalle.
       ASSIGN T-Asn_detalle.cdg_empresa     = T-Asn_header.cdg_empresa
              T-Asn_detalle.nro_cuenta      = Cuenta.nro_cuenta
              T-Asn_detalle.unidades        = Cuenta.unidades
              T-Asn_detalle.fecha_mayor     = T-Asn_header.fecha
              T-Asn_detalle.cambio          = T-Asn_header.cambio
              T-Asn_detalle.cambio_dolar    = T-Asn_header.cambio_dolar.
              
       RUN poner_moneda.       

  END.
  ELSE DO:
       FIND FIRST T-Asn_detalle 
                  WHERE T-Asn_detalle.nro_linea   = p-nro_linea-i
                    AND T-Asn_detalle.nro_moneda  = p-nro_moneda-i
                    AND T-Asn_detalle.reexpresion = p-reexpresion
                        EXCLUSIVE-LOCK.
       RUN traer_tablas.
  END.     

  DISPLAY 
        v-cdg_cuenta
        v-nom_cuenta
        v-cdg_entidad
        v-dsc_entidad
        v-cdg_obra
        v-dsc_obra
        v-moneda
        T-Asn_detalle.cambio 
        T-Asn_detalle.valor_unitario
        T-Asn_detalle.credito 
        T-Asn_detalle.credito_can 
        T-Asn_detalle.debito 
        T-Asn_detalle.debito_can 
        T-Asn_detalle.unidades
        T-Asn_detalle.leyen_detalle 
        T-Asn_detalle.lista_imputaciones
        WITH FRAME {&FRAME-NAME}.      

  IF T-Asn_detalle.reexpresion
     THEN FRAME {&FRAME-NAME}:TITLE = "Detalle de asiento - REEXPRESION EN " + v-moneda:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
     ELSE FRAME {&FRAME-NAME}:TITLE = "Detalle de asiento - MONEDA DE ORIGEN".

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
  DISPLAY v-cdg_cuenta v-nom_cuenta v-cdg_entidad v-dsc_entidad v-cdg_obra 
          v-dsc_obra v-moneda 
      WITH FRAME Dialog-Frame.
  IF AVAILABLE T-Asn_detalle THEN 
    DISPLAY T-Asn_detalle.lista_imputaciones T-Asn_detalle.debito 
          T-Asn_detalle.credito T-Asn_detalle.cambio T-Asn_detalle.debito_can 
          T-Asn_detalle.credito_can T-Asn_detalle.valor_unitario 
          T-Asn_detalle.unidades T-Asn_detalle.leyen_detalle 
      WITH FRAME Dialog-Frame.
  ENABLE RECT-10 RECT-11 RECT-9 v-moneda Btn_Cancel 
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

    ASSIGN
        v-cdg_entidad:SENSITIVE                     = NO
        v-cdg_obra:SENSITIVE                        = NO
        v-moneda:SENSITIVE                          = NO
        T-Asn_detalle.cambio:SENSITIVE              = NO 
        T-Asn_detalle.valor_unitario:SENSITIVE      = NO 
        T-Asn_detalle.credito:SENSITIVE             = NO 
        T-Asn_detalle.credito_can:SENSITIVE         = NO 
        T-Asn_detalle.debito:SENSITIVE              = NO 
        T-Asn_detalle.debito_can:SENSITIVE          = NO 
        T-Asn_detalle.leyen_detalle:SENSITIVE       = NO 
        T-Asn_detalle.lista_imputaciones:SENSITIVE  = NO 
        btn_sinobra:SENSITIVE                       = NO
        btn_elegir:SENSITIVE                        = NO
        Btn_OK:SENSITIVE                            = NO.
    

    CASE p-modo-cabecera:
        WHEN MD_ALTA                   
        THEN DO:
            v-cdg_entidad:SENSITIVE                     = NOT T-Asn_detalle.reexpresion.
            v-cdg_obra:SENSITIVE                        = NOT T-Asn_detalle.reexpresion.
            T-Asn_detalle.cambio:SENSITIVE              = NOT T-Asn_detalle.reexpresion. 
            T-Asn_detalle.debito:SENSITIVE              = YES. 
            T-Asn_detalle.credito:SENSITIVE             = YES. 
            T-Asn_detalle.credito_can:SENSITIVE         = Cuenta.unidades AND NOT T-Asn_detalle.reexpresion. 
            T-Asn_detalle.debito_can:SENSITIVE          = Cuenta.unidades AND NOT T-Asn_detalle.reexpresion. 
            T-Asn_detalle.valor_unitario:SENSITIVE      = Cuenta.unidades AND NOT T-Asn_detalle.reexpresion. 
            T-Asn_detalle.leyen_detalle:SENSITIVE       = NOT T-Asn_detalle.reexpresion. 
            T-Asn_detalle.lista_imputaciones:SENSITIVE  = YES.
            v-moneda:SENSITIVE                          = NOT T-Asn_detalle.reexpresion AND p-nro_moneda-h = ?.
            btn_sinobra:SENSITIVE                       = NOT T-Asn_detalle.reexpresion.
            btn_elegir:SENSITIVE                        = YES.
            Btn_OK:SENSITIVE                            = YES.
        END.
        
        WHEN MD_MULTIPLE               
        THEN DO:
            /* Habilitado solo salir */
            Btn_cancel:SENSITIVE                    = YES.
        END.
        
        WHEN MD_DEFINIDA               
        THEN DO:
            /* Habilitado solo salir */
            Btn_cancel:SENSITIVE                    = YES.
        END.
        
        WHEN MD_RELACION               
        THEN DO:
            /* Habilitado solo salir */
            Btn_cancel:SENSITIVE                    = YES.
        END.
        
        WHEN MD_READONLY               
        THEN DO:
            /* Habilitado solo salir */
            Btn_cancel:SENSITIVE                    = YES.
        END.
        
        WHEN MD_CAMBIO                 
        THEN DO:
            /* Habilitado solo salir */
            Btn_cancel:SENSITIVE                    = YES.
        END.
        
        WHEN MD_GENERADO               
        THEN DO:
            /* Habilitado solo salir */
            Btn_cancel:SENSITIVE                    = YES.
        END.
         
        WHEN MD_ANULACION              
        THEN DO:
            /* Habilitado solo salir */
            Btn_cancel:SENSITIVE                    = YES.
        END.
         
        WHEN MD_EMISION                
        THEN DO:
            /* Habilitado solo salir */
            Btn_cancel:SENSITIVE                    = YES.
        END.

    END CASE.

  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE inicia_combos Dialog-Frame 
PROCEDURE inicia_combos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE lista AS CHARACTER.
 
  DO WITH FRAME {&FRAME-NAME}:

     ASSIGN v-moneda:DELIMITER     = ",".
     lista = "".       
     FOR EACH Moneda NO-LOCK BY Moneda.descripcion:
         lista = lista + "," + Moneda.descripcion + "," + Moneda.cdg_moneda.
     END.
     v-moneda:LIST-ITEM-PAIRS = SUBSTRING(lista,2).

     FIND FIRST Moneda WHERE Moneda.es_local NO-LOCK.
     ASSIGN v-moneda:SCREEN-VALUE  = Moneda.cdg_moneda.

  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_moneda Dialog-Frame 
PROCEDURE poner_moneda :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND Moneda WHERE Moneda.cdg_moneda = v-moneda:SCREEN-VALUE IN FRAME {&FRAME-NAME} NO-LOCK.
    FIND LAST Cotizacion OF Moneda
         WHERE Cotizacion.cdg_empresa     = T-Asn_detalle.cdg_empresa
           AND Cotizacion.fch_cotizacion <= T-Asn_detalle.fecha_mayor
               NO-LOCK.
    ASSIGN
       T-Asn_detalle.cambio:SENSITIVE IN FRAME {&FRAME-NAME} = NOT Moneda.es_referencia
       T-Asn_detalle.nro_moneda = Moneda.nro_moneda
       T-Asn_detalle.cambio     = Cotizacion.cambio.

    DISPLAY 
         T-Asn_detalle.cambio
         WITH FRAME {&FRAME-NAME}. 

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

  FIND Cuenta OF T-Asn_detalle NO-LOCK.
  v-cdg_cuenta = Cuenta.cdg_cuenta.
  v-nom_cuenta = Cuenta.nombre_cta.

  FIND Entidad OF T-Asn_detalle NO-LOCK NO-ERROR.
  IF AVAILABLE Entidad
  THEN DO:
       v-cdg_entidad = Entidad.cdg_entidad.
       v-dsc_entidad = Entidad.dsc_entidad.
  END.
  ELSE DO:
       v-cdg_entidad = "".
       v-dsc_entidad = "".
  END.

  FIND Obra OF T-Asn_detalle NO-LOCK NO-ERROR.
  IF AVAILABLE obra
  THEN DO:
       v-cdg_obra = Obra.cdg_obra.
       v-dsc_obra = Obra.dsc_obra.
  END.
  ELSE DO:
       v-cdg_obra = "".
       v-dsc_obra = "".
  END.

  FIND Moneda OF T-Asn_detalle NO-LOCK.
  v-moneda = Moneda.cdg_moneda.

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

   DEFINE VARIABLE aux_debito  LIKE Asn_detalle.debito.
   DEFINE VARIABLE aux_credito LIKE Asn_detalle.credito.

   hay_error = YES.

   IF NOT CAN-FIND(Cuenta-moneda WHERE Cuenta-moneda.nro_cuenta = T-Asn_detalle.nro_cuenta
                                   AND Cuenta-moneda.nro_moneda = T-Asn_detalle.nro_moneda
                                   AND Cuenta-moneda.admite_movimientos)
   THEN DO:
        RUN PONMENSJ.P ( INPUT "ASIE016" ).
        RETURN.
   END.   

   FIND Entidad WHERE Entidad.cdg_entidad = v-cdg_entidad NO-ERROR.
   IF NOT AVAILABLE Entidad
   THEN DO:
        RUN PONMENSJ.P ( INPUT "ASIE012" ).
        RETURN.
   END.
   ELSE DO:
        T-Asn_detalle.nro_entidad = Entidad.nro_entidad.
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
             IF NOT CAN-DO(Obra.lista_empresas,T-Asn_header.cdg_empresa)
             THEN DO:
                  RUN PONMENSJ.P ( INPUT "ASIE027" ).
                  RETURN.
             END.

             IF Obra.finalizada
             THEN DO:
                  RUN PONMENSJ.P ( INPUT "ASIE026" ).
                  RETURN.
             END.
             
             IF T-Asn_header.fecha < Obra.fecha_apertura OR
                T-Asn_header.fecha > Obra.fecha_cierre 
             THEN DO:
                  RUN PONMENSJ.P ( INPUT "ASIE026" ).
                  RETURN.
             END.

             T-Asn_detalle.nro_obra = Obra.nro_obra.

        END.
   END.

   IF T-Asn_detalle.valor_unitario = 0 AND T-Asn_detalle.unidades
   THEN DO:
      RUN PONMENSJ.P ( INPUT "ASIE018" ).
      RETURN.
   END.

/*
   IF T-Asn_detalle.cambio = 0 AND T-Asn_detalle.bimonetario
   THEN DO:
      RUN PONMENSJ.P ( INPUT "ASIE019" ).
      RETURN.
   END.
*/

   IF T-Asn_detalle.unidades
   THEN DO:
      ASSIGN
            aux_debito  = ROUND(T-Asn_detalle.debito_can  * T-Asn_detalle.valor_unitario, 2)
            aux_credito = ROUND(T-Asn_detalle.credito_can  * T-Asn_detalle.valor_unitario, 2).
      IF aux_debito  <> T-Asn_detalle.debito OR
         aux_credito <> T-Asn_detalle.credito
      THEN DO:   
         RUN PONMENSJ.P ( INPUT "ASIE015" ).
         RETURN.
      END.
   END.      
 
 
   IF Cuenta.entidades_validas <> "*"
   THEN DO:
        FIND Entidad OF T-Asn_detalle NO-LOCK.
        IF LOOKUP(Entidad.cdg_entidad,Cuenta.entidades_validas) = 0
        THEN DO:
             RUN PONMENSJ.P ( INPUT "ASIE024").
             RETURN.
        END.
   END.
   
   FIND Obra OF T-Asn_detalle NO-LOCK NO-ERROR.
   IF AVAILABLE Obra
   THEN DO:
        IF Obra.finalizada
        THEN DO:
             RUN PONMENSJ.P ( INPUT "ASIE025").
             RETURN.
        END.
        IF Obra.fecha_cierre < T-Asn_header.fecha OR
           Obra.fecha_apertura > T-Asn_header.fecha
        THEN DO:
             RUN PONMENSJ.P ( INPUT "ASIE026").
             RETURN.
        END.
   END.
   
   hay_error = NO.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

