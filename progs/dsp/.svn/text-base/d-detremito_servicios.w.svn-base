&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame


/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Registrable-remito NO-UNDO LIKE Registrable-remito.
DEFINE TEMP-TABLE T-Remito-pedido NO-UNDO LIKE Remito-pedido.
DEFINE TEMP-TABLE T-Rem_detalle NO-UNDO LIKE Rem_detalle.
DEFINE TEMP-TABLE T-Rem_detalle-bon NO-UNDO LIKE Rem_detalle-bon.
DEFINE TEMP-TABLE T-Rem_header NO-UNDO LIKE Rem_header.



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
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Rem_header.                         
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Rem_detalle.                        
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Registrable-remito.    
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Rem_detalle-bon.                    
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Remito-pedido.                      
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

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME Dialog-Frame

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Rem_detalle

/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define FIELDS-IN-QUERY-Dialog-Frame T-Rem_detalle.cantidad ~
T-Rem_detalle.precio T-Rem_detalle.precio_cf T-Rem_detalle.subtotal_neto_cf ~
T-Rem_detalle.subtotal_neto T-Rem_detalle.detallada 
&Scoped-define ENABLED-FIELDS-IN-QUERY-Dialog-Frame T-Rem_detalle.cantidad ~
T-Rem_detalle.precio T-Rem_detalle.precio_cf T-Rem_detalle.detallada 
&Scoped-define ENABLED-TABLES-IN-QUERY-Dialog-Frame T-Rem_detalle
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-Dialog-Frame T-Rem_detalle
&Scoped-define QUERY-STRING-Dialog-Frame FOR EACH T-Rem_detalle SHARE-LOCK
&Scoped-define OPEN-QUERY-Dialog-Frame OPEN QUERY Dialog-Frame FOR EACH T-Rem_detalle SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-Dialog-Frame T-Rem_detalle
&Scoped-define FIRST-TABLE-IN-QUERY-Dialog-Frame T-Rem_detalle


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS T-Rem_detalle.cantidad T-Rem_detalle.precio ~
T-Rem_detalle.precio_cf T-Rem_detalle.detallada 
&Scoped-define ENABLED-TABLES T-Rem_detalle
&Scoped-define FIRST-ENABLED-TABLE T-Rem_detalle
&Scoped-Define ENABLED-OBJECTS RECT-10 RECT-9 incl_iva Btn_OK Btn_Cancel 
&Scoped-Define DISPLAYED-FIELDS T-Rem_detalle.cantidad T-Rem_detalle.precio ~
T-Rem_detalle.precio_cf T-Rem_detalle.subtotal_neto_cf ~
T-Rem_detalle.subtotal_neto T-Rem_detalle.detallada 
&Scoped-define DISPLAYED-TABLES T-Rem_detalle
&Scoped-define FIRST-DISPLAYED-TABLE T-Rem_detalle
&Scoped-Define DISPLAYED-OBJECTS v-cdg_articulo v-dsc_articulo ~
v-cdg_entidad v-dsc_entidad v-cdg_obra v-dsc_obra incl_iva 

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
     SIZE 12 BY .95.

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
     SIZE 45 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 91 BY 10.

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 91 BY 4.

DEFINE VARIABLE incl_iva AS LOGICAL INITIAL yes 
     LABEL "Iva Incluido" 
     VIEW-AS TOGGLE-BOX
     SIZE 16 BY .81 TOOLTIP "Si es verdadero permite ingresar los precios con el iva incluido" NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY Dialog-Frame FOR 
      T-Rem_detalle SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     v-cdg_articulo AT ROW 1.48 COL 13 COLON-ALIGNED
     v-dsc_articulo AT ROW 1.48 COL 32 COLON-ALIGNED NO-LABEL
     v-cdg_entidad AT ROW 2.67 COL 13 COLON-ALIGNED
     v-dsc_entidad AT ROW 2.67 COL 32 COLON-ALIGNED NO-LABEL
     v-cdg_obra AT ROW 3.86 COL 13 COLON-ALIGNED
     v-dsc_obra AT ROW 3.86 COL 32 COLON-ALIGNED NO-LABEL
     btn_sinobra AT ROW 3.86 COL 79
     T-Rem_detalle.cantidad AT ROW 5.76 COL 13 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Rem_detalle.precio AT ROW 5.76 COL 41 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Rem_detalle.precio_cf AT ROW 5.76 COL 71 COLON-ALIGNED WIDGET-ID 4
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     incl_iva AT ROW 6.91 COL 14 WIDGET-ID 2
     T-Rem_detalle.subtotal_neto_cf AT ROW 6.91 COL 71 COLON-ALIGNED WIDGET-ID 6
          LABEL "Neto CF"
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Rem_detalle.subtotal_neto AT ROW 6.95 COL 41 COLON-ALIGNED
          LABEL "Neto"
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Rem_detalle.detallada AT ROW 8.05 COL 4 NO-LABEL
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 87 BY 5.91
          BGCOLOR 15 FGCOLOR 9 
     Btn_OK AT ROW 14 COL 4.2
     Btn_Cancel AT ROW 14.1 COL 73.2
     RECT-10 AT ROW 5.52 COL 2
     RECT-9 AT ROW 1.29 COL 2
     SPACE(0.79) SKIP(13.03)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Detalle de Remitos de Clientes"
         CANCEL-BUTTON Btn_Cancel.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: DIALOG-BOX
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Registrable-remito T "?" NO-UNDO sic Registrable-remito
      TABLE: T-Remito-pedido T "?" NO-UNDO sic Remito-pedido
      TABLE: T-Rem_detalle T "?" NO-UNDO sic Rem_detalle
      TABLE: T-Rem_detalle-bon T "?" NO-UNDO sic Rem_detalle-bon
      TABLE: T-Rem_header T "?" NO-UNDO sic Rem_header
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
   FRAME-NAME                                                           */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR BUTTON btn_sinobra IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Rem_detalle.subtotal_neto IN FRAME Dialog-Frame
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN T-Rem_detalle.subtotal_neto_cf IN FRAME Dialog-Frame
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN v-cdg_articulo IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_entidad IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_obra IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_articulo IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_entidad IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_obra IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX Dialog-Frame
/* Query rebuild information for DIALOG-BOX Dialog-Frame
     _TblList          = "Temp-Tables.T-Rem_detalle"
     _Options          = "SHARE-LOCK"
     _Query            is OPENED
*/  /* DIALOG-BOX Dialog-Frame */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Detalle de Remitos de Clientes */
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
  THEN DO:  
      DELETE T-Rem_detalle.  
  END.

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
        T-Rem_detalle.detallada 
        T-Rem_detalle.cantidad 
        T-Rem_detalle.precio
        T-Rem_detalle.precio_cf.
  
  RUN  validar_datos ( OUTPUT hubo_error ).
  IF NOT hubo_error
  THEN DO:
        IF p-modo-detalle = 0 /* Es un alta */ 
        THEN DO:
            ASSIGN
                T-Rem_header.ultima_linea     = T-Rem_header.ultima_linea + 1
                T-Rem_detalle.nro_remito      = T-Rem_header.nro_remito
                T-Rem_detalle.nro_linea       = T-Rem_header.ultima_linea.
        END.
        p-nro_linea-o = T-Rem_detalle.nro_linea.
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
     T-Rem_detalle.nro_obra = 0
     v-cdg_obra = ""
     v-dsc_obra = "".

  DISPLAY 
        v-cdg_obra
        v-dsc_obra
        WITH FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Rem_detalle.detallada
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Rem_detalle.detallada Dialog-Frame
ON TAB OF T-Rem_detalle.detallada IN FRAME Dialog-Frame
DO:
      RUN ponmensj.p ( INPUT "DOCS018" ).
      RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME incl_iva
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL incl_iva Dialog-Frame
ON VALUE-CHANGED OF incl_iva IN FRAME Dialog-Frame /* Iva Incluido */
DO:
  ASSIGN incl_iva.
  T-rem_detalle.precio:SENSITIVE            = NOT incl_iva.
  T-rem_detalle.precio_cf:SENSITIVE         = incl_iva.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Rem_detalle.precio
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Rem_detalle.precio Dialog-Frame
ON LEAVE OF T-Rem_detalle.precio IN FRAME Dialog-Frame /* Precio */
DO:
    RUN calcular_valores(self:name).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Rem_detalle.precio_cf
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Rem_detalle.precio_cf Dialog-Frame
ON LEAVE OF T-Rem_detalle.precio_cf IN FRAME Dialog-Frame /* Precio C.F. */
DO:

    RUN calcular_valores(self:name).

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

  FIND FIRST T-Rem_header.
  IF p-modo-detalle = 0
  THEN DO:
     
       FIND Articulo WHERE Articulo.nro_articulo  = p-nro_articulo NO-LOCK.
       ASSIGN v-cdg_articulo = Articulo.cdg_articulo
              v-dsc_articulo = Articulo.descripcion.
       FIND Entidad WHERE Entidad.cdg_entidad = T-Rem_header.cdg_empresa NO-LOCK.
       CREATE T-Rem_detalle.
       ASSIGN T-Rem_detalle.nro_remito   = T-Rem_header.nro_remito
              T-Rem_detalle.nro_entidad  = T-Rem_header.nro_entidad
              /*T-Rem_detalle.nro_obra     = T-Rem_header.nro_obra*/
              T-Rem_detalle.nro_articulo = Articulo.nro_articulo
              T-Rem_detalle.a_granel     = Articulo.a_granel
              T-Rem_detalle.detallada    = Articulo.detallada
              T-Rem_detalle.costo        = Articulo.costo.
  END.
  ELSE DO:
       FIND FIRST T-Rem_detalle WHERE T-Rem_detalle.nro_linea = p-nro_linea-i EXCLUSIVE-LOCK.
  END.     

  RUN traer_tablas.

    RUN getparametro_l.p ( INPUT  "FACSCIVA", OUTPUT incl_iva).

  DISPLAY 
        v-cdg_articulo
        v-dsc_articulo
        v-cdg_entidad
        v-dsc_entidad
        v-cdg_obra
        v-dsc_obra
        T-Rem_detalle.cantidad 
        T-Rem_detalle.detallada 
        T-Rem_detalle.precio 
        T-Rem_detalle.subtotal_neto 
        T-Rem_detalle.precio_cf 
        T-Rem_detalle.subtotal_neto_cf 
        incl_iva
        WITH FRAME {&FRAME-NAME}.      

  RUN habilitar_campos.
 {&OPEN-QUERY-{&BROWSE-NAME}}
 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE calcular_valores Dialog-Frame 
PROCEDURE calcular_valores :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAMETER campo AS char NO-UNDO.
DEFINE VARIABLE que_tasa LIKE Impuesto_condicion.tasa.

          /* --------------------------------------------------- */
          /*  El precio a CF es el precio + impuestos. SI no hay */
          /*  impuestos, el precio_cf quedará igual al precio    */
          /* --------------------------------------------------- */

RUN hallar_iva_detalle ( OUTPUT que_tasa ).

ASSIGN FRAME {&FRAME-NAME} T-rem_detalle.precio_cf
       T-rem_detalle.precio 
       T-rem_detalle.cantidad.

IF T-rem_detalle.cantidad = 0.0 THEN T-rem_detalle.cantidad = 1.0.
IF campo = "precio" THEN
        T-rem_detalle.precio_cf = T-rem_detalle.precio * ( 1 + que_tasa / 100).
IF campo = "precio_cf" Then     
        T-rem_detalle.precio = T-rem_detalle.precio_cf / ( 1 + que_tasa / 100).

T-rem_detalle.subtotal_neto = T-rem_detalle.precio * T-rem_detalle.cantidad.
T-rem_detalle.subtotal_neto_cf = T-rem_detalle.precio_cf * T-rem_detalle.cantidad.
DISPLAY T-rem_detalle.subtotal_neto  T-rem_detalle.precio 
        T-rem_detalle.subtotal_neto_cf T-rem_detalle.precio_cf
        T-rem_detalle.cantidad WITH FRAME {&FRAME-NAME}.
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

  {&OPEN-QUERY-Dialog-Frame}
  GET FIRST Dialog-Frame.
  DISPLAY v-cdg_articulo v-dsc_articulo v-cdg_entidad v-dsc_entidad v-cdg_obra 
          v-dsc_obra incl_iva 
      WITH FRAME Dialog-Frame.
  IF AVAILABLE T-Rem_detalle THEN 
    DISPLAY T-Rem_detalle.cantidad T-Rem_detalle.precio T-Rem_detalle.precio_cf 
          T-Rem_detalle.subtotal_neto_cf T-Rem_detalle.subtotal_neto 
          T-Rem_detalle.detallada 
      WITH FRAME Dialog-Frame.
  ENABLE RECT-10 RECT-9 T-Rem_detalle.cantidad T-Rem_detalle.precio 
         T-Rem_detalle.precio_cf incl_iva T-Rem_detalle.detallada Btn_OK 
         Btn_Cancel 
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
        T-Rem_detalle.detallada:SENSITIVE         = NO 
        T-Rem_detalle.cantidad:SENSITIVE          = NO 
        T-Rem_detalle.precio:SENSITIVE            = NO
        T-Rem_detalle.precio_cf:SENSITIVE            = NO 
        btn_sinobra:SENSITIVE                     = NO
        Btn_OK:SENSITIVE                          = NO.

    CASE p-modo-cabecera:
        WHEN MD_ALTA                   
        THEN DO:
            ASSIGN
                v-cdg_entidad:SENSITIVE                   = YES
                v-cdg_obra:SENSITIVE                      = hay_obras
                T-Rem_detalle.cantidad:SENSITIVE          = YES 
                T-Rem_detalle.detallada:SENSITIVE         = YES 
                T-Rem_detalle.precio:SENSITIVE            = NOT incl_iva
                T-Rem_detalle.precio_cf:SENSITIVE         = incl_iva 
                btn_sinobra:SENSITIVE                     = hay_obras
                Btn_OK:SENSITIVE                          = YES
                T-Rem_detalle.cantidad:FGCOLOR            = 9. 

        END.
        
        WHEN MD_MULTIPLE               
        THEN DO:
             /* nada habilitado */
        END.
        
        WHEN MD_DEFINIDA               
        THEN DO:
             /* nada habilitado */
        END.
        
        WHEN MD_RELACION               
        THEN DO:
             /* nada habilitado */
        END.
        
        WHEN MD_READONLY               
        THEN DO:
             /* nada habilitado */
        END.
        
        WHEN MD_CAMBIO                 
        THEN DO:
             /* nada habilitado */
        END.
        
        WHEN MD_GENERADO               
        THEN DO:
             /* nada habilitado */
        END.
         
        WHEN MD_ANULACION              
        THEN DO:
             /* nada habilitado */
        END.
         
        WHEN MD_EMISION                
        THEN DO:
             /* nada habilitado */
        END.

    END CASE.

  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE hallar_iva_detalle Dialog-Frame 
PROCEDURE hallar_iva_detalle :
DEFINE OUTPUT PARAMETER p-tasa LIKE Impuesto_condicion.tasa.
 
 p-tasa = 0.
 /*ver si el comprobante aplica impuestos o no*/
 FIND tipocomprobante OF t-rem_header NO-LOCK.

 IF Tipocomprobante.aplica_impuestos THEN DO:
      
     FIND Familia_impositiva OF Articulo NO-LOCK.
        
     FIND first Impuesto_condicion OF  Familia_impositiva 
           WHERE Impuesto_condicion.cdg_condiva = T-rem_header.cdg_condiva
             AND Impuesto_condicion.cdg_empresa = T-rem_header.cdg_empresa 
             AND Impuesto_condicion.fch_desde <= T-rem_header.fecha_iva
             AND Impuesto_condicion.fch_hasta >= T-rem_header.fecha_iva
             AND CAN-DO(Impuesto_condicion.lista_provincias,T-rem_header.cdg_provincia) 
             AND CAN-FIND(FIRST Impuesto OF Impuesto_condicion WHERE Impuesto.es_iva) NO-LOCK NO-ERROR.
     IF AVAILABLE Impuesto_condicion THEN DO:
         FIND FIRST  Cliente_excencion OF Cliente 
                      WHERE Cliente_excencion.cdg_empresa  = T-rem_header.cdg_empresa
                        AND Cliente_excencion.cdg_impuesto = Impuesto_condicion.cdg_impuesto
                        AND Cliente_excencion.fch_desde <= T-rem_header.fecha_iva
                        AND Cliente_excencion.fch_hasta >= T-rem_header.fecha_iva NO-LOCK NO-ERROR.
        
         IF NOT AVAILABLE Cliente_excencion
             THEN p-tasa = Impuesto_condicion.tasa.
             ELSE p-tasa = Impuesto_condicion.tasa * ( 1 - Cliente_excencion.prc_excencion  / 100.0 ).
              
     END.
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

  FIND Articulo OF T-Rem_detalle NO-LOCK.
  ASSIGN
        v-cdg_articulo = Articulo.cdg_articulo
        v-dsc_articulo = Articulo.descripcion.

  FIND Entidad OF T-Rem_detalle NO-LOCK NO-ERROR.
  IF AVAILABLE Entidad
  THEN DO:
       v-cdg_entidad = Entidad.cdg_entidad.
       v-dsc_entidad = Entidad.dsc_entidad.
  END.
  ELSE DO:
       v-cdg_entidad = "".
       v-dsc_entidad = "".
  END.

  FIND Obra OF T-Rem_detalle NO-LOCK NO-ERROR.
  IF AVAILABLE obra
  THEN DO:
       v-cdg_obra = Obra.cdg_obra.
       v-dsc_obra = Obra.dsc_obra.
  END.
  ELSE DO:
       v-cdg_obra = "".
       v-dsc_obra = "".
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

   IF T-Rem_detalle.detallada:INPUT-VALUE IN FRAME {&FRAME-NAME} = ""
   THEN DO:
       RUN PONMENSJ.P ( INPUT "FACT033" ).
       RETURN.
   END.

   FIND Entidad WHERE Entidad.cdg_entidad = v-cdg_entidad NO-ERROR.
   IF NOT AVAILABLE Entidad
   THEN DO:
        RUN PONMENSJ.P ( INPUT "ASIE012" ).
        RETURN.
   END.
   ELSE DO:
        T-Rem_detalle.nro_entidad = Entidad.nro_entidad.
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
             IF LOOKUP(Obra.entidades_validas,T-Rem_header.cdg_empresa,",") = 0
             THEN DO:
                  RUN PONMENSJ.P ( INPUT "ASIE027" ).
                  RETURN.
             END.

             IF Obra.finalizada
             THEN DO:
                  RUN PONMENSJ.P ( INPUT "ASIE026" ).
                  RETURN.
             END.
             
             IF T-Rem_header.fecha < Obra.fecha_apertura OR
                T-Rem_header.fecha > Obra.fecha_cierre 
             THEN DO:
                  RUN PONMENSJ.P ( INPUT "ASIE026" ).
                  RETURN.
             END.

             T-Rem_detalle.nro_obra = Obra.nro_obra.

        END.
   END.
/*
   IF T-Rem_detalle.valor_unitario = 0 AND T-Rem_detalle.unidades
   THEN DO:
      RUN PONMENSJ.P ( INPUT "ASIE018" ).
      RETURN.
   END.

   IF T-Rem_detalle.cambio = 0 AND T-Rem_detalle.bimonetario
   THEN DO:
      RUN PONMENSJ.P ( INPUT "ASIE019" ).
      RETURN.
   END.

   IF T-Rem_detalle.bimonetario
   THEN DO:
      ASSIGN
            aux_debito  = ROUND(T-Rem_detalle.debito  * T-Rem_detalle.cambio, 2)
            aux_credito = ROUND(T-Rem_detalle.credito * T-Rem_detalle.cambio, 2). 
      IF aux_debito  <> T-Rem_detalle.debito_div OR
         aux_credito <> T-Rem_detalle.credito_div
      THEN DO:   
         RUN PONMENSJ.P ( INPUT "ASIE016" ).
         RETURN.
      END.
   END.      

   IF T-Rem_detalle.unidades
   THEN DO:
      ASSIGN
            aux_debito  = ROUND(T-Rem_detalle.debito_can  * T-Rem_detalle.valor_unitario, 2)
            aux_credito = ROUND(T-Rem_detalle.credito_can  * T-Rem_detalle.valor_unitario, 2).
      IF aux_debito  <> T-Rem_detalle.debito OR
         aux_credito <> T-Rem_detalle.credito
      THEN DO:   
         RUN PONMENSJ.P ( INPUT "ASIE015" ).
         RETURN.
      END.
   END.      
 
 
   IF Cuenta.entidades_validas <> "*"
   THEN DO:
        FIND Entidad OF T-Rem_detalle NO-LOCK.
        IF LOOKUP(Entidad.cdg_entidad,Cuenta.entidades_validas) = 0
        THEN DO:
             RUN PONMENSJ.P ( INPUT "ASIE024").
             RETURN.
        END.
   END.
   
   FIND Obra OF T-Rem_detalle NO-LOCK NO-ERROR.
   IF AVAILABLE Obra
   THEN DO:
        IF Obra.finalizada
        THEN DO:
             RUN PONMENSJ.P ( INPUT "ASIE025").
             RETURN.
        END.
        IF Obra.fecha_cierre < T-Rem_header.fecha OR
           Obra.fecha_apertura > T-Rem_header.fecha
        THEN DO:
             RUN PONMENSJ.P ( INPUT "ASIE026").
             RETURN.
        END.
   END.
*/   
   hay_error = NO.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

