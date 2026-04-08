&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME D-Dialog
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS D-Dialog 
/*------------------------------------------------------------------------

  File: 

  Description: from cntnrdlg.w - ADM SmartDialog Template

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
DEFINE VARIABLE p-nro_cliente  LIKE Cliente.nro_cliente.
DEFINE VARIABLE p-nro_articulo LIKE Articulo.nro_articulo.
DEFINE VARIABLE p-tip_pedido   LIKE Ped_header.tip_comprob. 
DEFINE VARIABLE p-prf_pedido   LIKE Ped_header.prf_comprob.
DEFINE VARIABLE p-nro_pedido   LIKE Ped_header.nro_comprob.
DEFINE VARIABLE p-nro_linea    LIKE Ped_detalle.nro_linea.
DEFINE VARIABLE p-cantidad     LIKE Ped_detalle.cantidad.
DEFINE VARIABLE p-granel       LIKE Ped_detalle.granel.
DEFINE VARIABLE lOK            AS LOGICAL.
&ELSE
DEFINE INPUT  PARAMETER p-nro_cliente  LIKE Cliente.nro_cliente.
DEFINE INPUT  PARAMETER p-nro_articulo LIKE Articulo.nro_articulo.
DEFINE OUTPUT PARAMETER p-tip_pedido   LIKE Ped_header.tip_comprob. 
DEFINE OUTPUT PARAMETER p-prf_pedido   LIKE Ped_header.prf_comprob.
DEFINE OUTPUT PARAMETER p-nro_pedido   LIKE Ped_header.nro_comprob.
DEFINE OUTPUT PARAMETER p-nro_linea    LIKE Ped_detalle.nro_linea.
DEFINE OUTPUT PARAMETER p-cantidad     LIKE Ped_detalle.cantidad.
DEFINE OUTPUT PARAMETER p-granel       LIKE Ped_detalle.granel.
DEFINE OUTPUT PARAMETER lOK            AS LOGICAL.
&ENDIF

/* Local Variable Definitions ---                                       */

DEFINE VARIABLE que_empresa      LIKE Empresa.cdg_empresa.
DEFINE VARIABLE fecha_inicial    AS DATE.
DEFINE VARIABLE fecha_elegida    AS DATE.
DEFINE VARIABLE que_moneda       LIKE Moneda.nro_moneda.
DEFINE VARIABLE que_cliente      LIKE Cliente.nro_cliente.

DEFINE VARIABLE v-cantidad_pen LIKE Ped_detalle.cantidad.
DEFINE VARIABLE v-granel_pen   LIKE Ped_detalle.granel.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartDialog
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER DIALOG-BOX

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME D-Dialog
&Scoped-define BROWSE-NAME BROWSE-8

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Ped_header Ped_detalle

/* Definitions for BROWSE BROWSE-8                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-8 Ped_header.tip_comprob ~
Ped_header.prf_comprob Ped_header.nro_comprob Ped_header.fecha_alta ~
Ped_header.fecha_carga Ped_detalle.fecha_temprana Ped_detalle.fecha_tardia ~
Ped_detalle.cantidad - Ped_detalle.cantidad_cum @ v-cantidad_pen ~
Ped_detalle.granel - Ped_detalle.granel_cum @ v-granel_pen 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-8 
&Scoped-define QUERY-STRING-BROWSE-8 FOR EACH Ped_header ~
      WHERE Ped_header.nro_cliente = p-nro_cliente ~
 AND Ped_header.cdg_empresa = que_empresa ~
 AND (Ped_header.cdg_estado = "AA" ~
  OR Ped_header.cdg_estado = "AM") NO-LOCK, ~
      EACH Ped_detalle OF Ped_header ~
      WHERE Ped_detalle.nro_articulo = p-nro_articulo NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-8 OPEN QUERY BROWSE-8 FOR EACH Ped_header ~
      WHERE Ped_header.nro_cliente = p-nro_cliente ~
 AND Ped_header.cdg_empresa = que_empresa ~
 AND (Ped_header.cdg_estado = "AA" ~
  OR Ped_header.cdg_estado = "AM") NO-LOCK, ~
      EACH Ped_detalle OF Ped_header ~
      WHERE Ped_detalle.nro_articulo = p-nro_articulo NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-8 Ped_header Ped_detalle
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-8 Ped_header
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-8 Ped_detalle


/* Definitions for DIALOG-BOX D-Dialog                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-D-Dialog ~
    ~{&OPEN-QUERY-BROWSE-8}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS v-des_fecha v-has_fecha Btn_OK Btn_Cancel ~
v-cdg_cliente v-cdg_articulo BROWSE-8 RECT-1 RECT-2 RECT-9 
&Scoped-Define DISPLAYED-OBJECTS v-des_fecha v-has_fecha v-cdg_cliente ~
v-dsc_cliente v-cdg_articulo v-dsc_articulo 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancelar" 
     SIZE 15 BY .81
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "Elegir" 
     SIZE 15 BY .81
     BGCOLOR 8 .

DEFINE VARIABLE v-cdg_articulo AS CHARACTER FORMAT "X(14)" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 18 BY .81
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-cdg_cliente AS CHARACTER FORMAT "X(12)" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 18 BY .81
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-des_fecha AS DATE FORMAT "99/99/99":U 
     LABEL "Del" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 11 BY .81
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE v-dsc_articulo AS CHARACTER FORMAT "X(25)" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 55 BY .81
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_cliente AS CHARACTER FORMAT "X(25)" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 55 BY .81
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-has_fecha AS DATE FORMAT "99/99/99":U 
     LABEL "al" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 11 BY .81
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 76 BY 1.35.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 76 BY 1.35.

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 76 BY 1.35.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-8 FOR 
      Ped_header, 
      Ped_detalle SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-8
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-8 D-Dialog _STRUCTURED
  QUERY BROWSE-8 NO-LOCK DISPLAY
      Ped_header.tip_comprob COLUMN-LABEL "Ti-!po" FORMAT "X(3)":U
      Ped_header.prf_comprob COLUMN-LABEL "Pre-!fijo" FORMAT "9999":U
      Ped_header.nro_comprob COLUMN-LABEL "Número!Pedido" FORMAT "ZZZZZZZ9":U
      Ped_header.fecha_alta FORMAT "99/99/99":U
      Ped_header.fecha_carga COLUMN-LABEL "Fecha!Carga" FORMAT "99/99/9999":U
      Ped_detalle.fecha_temprana COLUMN-LABEL "Fecha!Entrega" FORMAT "99/99/99":U
      Ped_detalle.fecha_tardia COLUMN-LABEL "Fecha!Tope" FORMAT "99/99/99":U
      Ped_detalle.cantidad - Ped_detalle.cantidad_cum @ v-cantidad_pen COLUMN-LABEL "Cantidad!Pendiente" FORMAT "->,>>>,>>9.99":U
      Ped_detalle.granel - Ped_detalle.granel_cum @ v-granel_pen COLUMN-LABEL "Kilaje!Pendiente" FORMAT "->>>,>>9.99":U
            WIDTH 9.72
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 76 BY 9.96 EXPANDABLE.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME D-Dialog
     v-des_fecha AT ROW 1.54 COL 8 COLON-ALIGNED
     v-has_fecha AT ROW 1.54 COL 24.14 COLON-ALIGNED
     Btn_OK AT ROW 1.54 COL 45
     Btn_Cancel AT ROW 1.54 COL 62
     v-cdg_cliente AT ROW 3.15 COL 1 COLON-ALIGNED NO-LABEL
     v-dsc_cliente AT ROW 3.15 COL 20 COLON-ALIGNED NO-LABEL
     v-cdg_articulo AT ROW 4.77 COL 1 COLON-ALIGNED NO-LABEL
     v-dsc_articulo AT ROW 4.77 COL 20 COLON-ALIGNED NO-LABEL
     BROWSE-8 AT ROW 6.12 COL 2
     RECT-1 AT ROW 2.88 COL 2
     RECT-2 AT ROW 4.5 COL 2
     RECT-9 AT ROW 1.27 COL 2
     SPACE(1.85) SKIP(14.06)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Seleccion de Items de Pedidos por Cliente"
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartDialog
   Allow: Basic,Browse,DB-Fields,Query,Smart
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB D-Dialog 
/* ************************* Included-Libraries *********************** */

{src/adm/method/containr.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX D-Dialog
   NOT-VISIBLE                                                          */
/* BROWSE-TAB BROWSE-8 v-dsc_articulo D-Dialog */
ASSIGN 
       FRAME D-Dialog:SCROLLABLE       = FALSE
       FRAME D-Dialog:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN v-dsc_articulo IN FRAME D-Dialog
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_cliente IN FRAME D-Dialog
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-8
/* Query rebuild information for BROWSE BROWSE-8
     _TblList          = "sic.Ped_header,sic.Ped_detalle OF sic.Ped_header"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "Ped_header.nro_cliente = p-nro_cliente
 AND Ped_header.cdg_empresa = que_empresa
 AND (Ped_header.cdg_estado = ""AA""
  OR Ped_header.cdg_estado = ""AM"")"
     _Where[2]         = "Ped_detalle.nro_articulo = p-nro_articulo"
     _FldNameList[1]   > sic.Ped_header.tip_comprob
"Ped_header.tip_comprob" "Ti-!po" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[2]   > sic.Ped_header.prf_comprob
"Ped_header.prf_comprob" "Pre-!fijo" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[3]   > sic.Ped_header.nro_comprob
"Ped_header.nro_comprob" "Número!Pedido" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[4]   = sic.Ped_header.fecha_alta
     _FldNameList[5]   > sic.Ped_header.fecha_carga
"Ped_header.fecha_carga" "Fecha!Carga" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[6]   > sic.Ped_detalle.fecha_temprana
"Ped_detalle.fecha_temprana" "Fecha!Entrega" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[7]   > sic.Ped_detalle.fecha_tardia
"Ped_detalle.fecha_tardia" "Fecha!Tope" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[8]   > "_<CALC>"
"Ped_detalle.cantidad - Ped_detalle.cantidad_cum @ v-cantidad_pen" "Cantidad!Pendiente" "->,>>>,>>9.99" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[9]   > "_<CALC>"
"Ped_detalle.granel - Ped_detalle.granel_cum @ v-granel_pen" "Kilaje!Pendiente" "->>>,>>9.99" ? ? ? ? ? ? ? no ? no no "9.72" yes no no "U" "" ""
     _Query            is OPENED
*/  /* BROWSE BROWSE-8 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX D-Dialog
/* Query rebuild information for DIALOG-BOX D-Dialog
     _Options          = "SHARE-LOCK"
     _Query            is NOT OPENED
*/  /* DIALOG-BOX D-Dialog */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME D-Dialog
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL D-Dialog D-Dialog
ON WINDOW-CLOSE OF FRAME D-Dialog /* Seleccion de Items de Pedidos por Cliente */
DO:  
  /* Add Trigger to equate WINDOW-CLOSE to END-ERROR. */
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel D-Dialog
ON CHOOSE OF Btn_Cancel IN FRAME D-Dialog /* Cancelar */
DO:
    ASSIGN
         p-tip_pedido = ""  
         p-prf_pedido = 0
         p-nro_pedido = 0
         p-nro_linea  = 0
         lOK = NO.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK D-Dialog
ON CHOOSE OF Btn_OK IN FRAME D-Dialog /* Elegir */
DO:
  IF AVAILABLE Ped_detalle
     THEN ASSIGN
             p-tip_pedido = Ped_header.tip_comprob  
             p-prf_pedido = Ped_header.prf_comprob
             p-nro_pedido = Ped_header.nro_comprob
             p-nro_linea  = Ped_detalle.nro_linea
             p-cantidad   = Ped_detalle.cantidad - Ped_detalle.cantidad_cum
             p-granel     = Ped_detalle.granel - Ped_detalle.granel_cum             
             lOK = YES.
     ELSE BELL.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-des_fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-des_fecha D-Dialog
ON MOUSE-MENU-DOWN OF v-des_fecha IN FRAME D-Dialog /* Del */
DO:

  fecha_inicial = DATE(v-des_fecha:SCREEN-VALUE IN FRAME {&FRAME-NAME}) NO-ERROR.
  IF fecha_inicial = ? THEN fecha_inicial = TODAY.
  RUN d-calendario.w ( INPUT fecha_inicial, OUTPUT fecha_elegida).
  IF fecha_elegida <> ?
  THEN DO:
       DISPLAY fecha_elegida @ v-des_fecha 
               WITH FRAME {&FRAME-NAME}.
       APPLY "RETURN" TO SELF.        
  END.               
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-des_fecha D-Dialog
ON RETURN OF v-des_fecha IN FRAME D-Dialog /* Del */
DO:
  ASSIGN v-des_fecha.
  {&OPEN-QUERY-{&BROWSE-NAME}}
  /*
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
  */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-has_fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-has_fecha D-Dialog
ON MOUSE-MENU-DOWN OF v-has_fecha IN FRAME D-Dialog /* al */
DO:

  fecha_inicial = DATE(v-has_fecha:SCREEN-VALUE IN FRAME {&FRAME-NAME}) NO-ERROR.
  IF fecha_inicial = ? THEN fecha_inicial = TODAY.
  RUN d-calendario.w ( INPUT fecha_inicial, OUTPUT fecha_elegida).
  IF fecha_elegida <> ?
  THEN DO:
       DISPLAY fecha_elegida @ v-has_fecha 
               WITH FRAME {&FRAME-NAME}.
       APPLY "TAB" TO SELF.        
  END.               
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-has_fecha D-Dialog
ON RETURN OF v-has_fecha IN FRAME D-Dialog /* al */
DO:
  ASSIGN v-has_fecha.
  {&OPEN-QUERY-{&BROWSE-NAME}}
  /*
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
  */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-8
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK D-Dialog 


/* ***************************  Main Block  *************************** */

{src/adm/template/dialogmn.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-create-objects D-Dialog  _ADM-CREATE-OBJECTS
PROCEDURE adm-create-objects :
/*------------------------------------------------------------------------------
  Purpose:     Create handles for all SmartObjects used in this procedure.
               After SmartObjects are initialized, then SmartLinks are added.
  Parameters:  <none>
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available D-Dialog  _ADM-ROW-AVAILABLE
PROCEDURE adm-row-available :
/*------------------------------------------------------------------------------
  Purpose:     Dispatched to this procedure when the Record-
               Source has a new row available.  This procedure
               tries to get the new row (or foriegn keys) from
               the Record-Source and process it.
  Parameters:  <none>
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.             */
  {src/adm/template/row-head.i}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI D-Dialog  _DEFAULT-DISABLE
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
  HIDE FRAME D-Dialog.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI D-Dialog  _DEFAULT-ENABLE
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
  DISPLAY v-des_fecha v-has_fecha v-cdg_cliente v-dsc_cliente v-cdg_articulo 
          v-dsc_articulo 
      WITH FRAME D-Dialog.
  ENABLE v-des_fecha v-has_fecha Btn_OK Btn_Cancel v-cdg_cliente v-cdg_articulo 
         BROWSE-8 RECT-1 RECT-2 RECT-9 
      WITH FRAME D-Dialog.
  {&OPEN-BROWSERS-IN-QUERY-D-Dialog}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize D-Dialog 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

   v-has_fecha = TODAY.
   v-des_fecha = TODAY - 30.
   
   {findempresa.i}
   que_empresa = Empresa.cdg_empresa.
   
   FIND Cliente WHERE Cliente.nro_cliente = p-nro_cliente NO-LOCK.
   v-cdg_cliente = CLiente.cdg_cliente.
   v-dsc_cliente = Cliente.nom_cliente.

   FIND Articulo WHERE Articulo.nro_articulo = p-nro_articulo NO-LOCK.
   v-cdg_articulo = Articulo.cdg_articulo.
   v-dsc_articulo = Articulo.descripcion.


  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   DISPLAY
        v-des_fecha
        v-has_fecha
        v-cdg_cliente
        v-dsc_cliente
        v-cdg_articulo
        v-dsc_articulo
        WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records D-Dialog  _ADM-SEND-RECORDS
PROCEDURE send-records :
/*------------------------------------------------------------------------------
  Purpose:     Send record ROWID's for all tables used by
               this file.
  Parameters:  see template/snd-head.i
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.               */
  {src/adm/template/snd-head.i}

  /* For each requested table, put it's ROWID in the output list.      */
  {src/adm/template/snd-list.i "Ped_header"}
  {src/adm/template/snd-list.i "Ped_detalle"}

  /* Deal with any unexpected table requests before closing.           */
  {src/adm/template/snd-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE state-changed D-Dialog 
PROCEDURE state-changed :
/* -----------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-------------------------------------------------------------*/
  DEFINE INPUT PARAMETER p-issuer-hdl AS HANDLE NO-UNDO.
  DEFINE INPUT PARAMETER p-state AS CHARACTER NO-UNDO.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

