&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame

/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Cta_cte_prv NO-UNDO LIKE Cta_cte_prv.


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

&IF DEFINED(UIB_is_Running) EQ 0
&THEN
DEFINE INPUT PARAMETER rid_proveedor   AS ROWID.
DEFINE INPUT PARAMETER rid_moneda      AS ROWID.
DEFINE INPUT PARAMETER st_seleccionado AS CHARACTER.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Cta_cte_prv.
&ELSE
DEFINE VARIABLE rid_proveedor AS ROWID.
FIND Proveedor WHERE Proveedor.cdg_proveedor = "C0022" NO-LOCK.
rid_proveedor = ROWID(Proveedor).
DEFINE VARIABLE rid_moneda  AS ROWID.
FIND FIRST Moneda.
rid_moneda = ROWID(Moneda).
DEFINE VARIABLE st_seleccionado AS CHARACTER.
st_seleccionado = "OPG-" + USERID("SIC").
&ENDIF

/* Local Variable Definitions ---                                       */

DEFINE VARIABLE que_empresa LIKE Empresa.cdg_empresa.
DEFINE VARIABLE que_moneda  LIKE Moneda.nro_moneda.

DEFINE VARIABLE rid_tabla   AS ROWID.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame
&Scoped-define BROWSE-NAME BROWSE-1

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Cta_cte_prv Moneda

/* Definitions for BROWSE BROWSE-1                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-1 T-Cta_cte_prv.tip_comprob T-Cta_cte_prv.prf_comprob T-Cta_cte_prv.nro_comprob T-Cta_cte_prv.nro_vencimiento T-Cta_cte_prv.fecha_emision T-Cta_cte_prv.fecha_vencimiento T-Cta_cte_prv.cambio T-Cta_cte_prv.cambio_dolar Moneda.abrevia T-Cta_cte_prv.debito T-Cta_cte_prv.credito T-Cta_cte_prv.fecha_programada T-Cta_cte_prv.imp_programado   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-1   
&Scoped-define SELF-NAME BROWSE-1
&Scoped-define OPEN-QUERY-BROWSE-1 IF que_moneda = ?     THEN OPEN QUERY {&SELF-NAME} FOR EACH T-Cta_cte_prv NO-LOCK             WHERE T-Cta_cte_prv.cdg_empresa = que_empresa               AND T-Cta_cte_prv.debito <> T-Cta_cte_prv.credito               AND NOT T-Cta_cte_prv.imputado, ~
                       FIRST Moneda OF T-Cta_cte_prv                BY T-Cta_cte_prv.fecha_vencimiento.     ELSE OPEN QUERY {&SELF-NAME} FOR EACH T-Cta_cte_prv NO-LOCK             WHERE T-Cta_cte_prv.cdg_empresa = que_empresa               AND (T-Cta_cte_prv.nro_moneda = que_moneda )               AND T-Cta_cte_prv.debito <> T-Cta_cte_prv.credito               AND NOT T-Cta_cte_prv.imputado, ~
                       FIRST Moneda OF T-Cta_cte_prv                BY T-Cta_cte_prv.fecha_vencimiento.
&Scoped-define TABLES-IN-QUERY-BROWSE-1 T-Cta_cte_prv Moneda
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-1 T-Cta_cte_prv
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-1 Moneda


/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define OPEN-BROWSERS-IN-QUERY-Dialog-Frame ~
    ~{&OPEN-QUERY-BROWSE-1}
&Scoped-define QUERY-STRING-Dialog-Frame FOR EACH Moneda SHARE-LOCK
&Scoped-define OPEN-QUERY-Dialog-Frame OPEN QUERY Dialog-Frame FOR EACH Moneda SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-Dialog-Frame Moneda
&Scoped-define FIRST-TABLE-IN-QUERY-Dialog-Frame Moneda


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS Btn_elegir v-totcomprobantes v-totpesos ~
Btn_Cancel BROWSE-1 RECT-6 
&Scoped-Define DISPLAYED-OBJECTS v-totcomprobantes v-cdg_proveedor ~
v-dsc_proveedor v-totpesos v-cdg_moneda v-dsc_moneda 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "&Cancelar" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON Btn_elegir AUTO-GO 
     LABEL "&Elegir" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE VARIABLE v-cdg_proveedor AS CHARACTER FORMAT "x(8)" 
     LABEL "Proveedor" 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_moneda AS CHARACTER FORMAT "X(3)" 
     LABEL "Moneda" 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-dsc_proveedor AS CHARACTER FORMAT "X(40)" 
     VIEW-AS FILL-IN 
     SIZE 56 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_moneda AS CHARACTER FORMAT "X(20)" 
     VIEW-AS FILL-IN 
     SIZE 56 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-totcomprobantes AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "#" 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 14 FGCOLOR 9 FONT 6 NO-UNDO.

DEFINE VARIABLE v-totpesos AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     LABEL "$" 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 14 FGCOLOR 9 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 108 BY 2.62.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-1 FOR 
      T-Cta_cte_prv, 
      Moneda SCROLLING.

DEFINE QUERY Dialog-Frame FOR 
      Moneda SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-1 Dialog-Frame _FREEFORM
  QUERY BROWSE-1 NO-LOCK DISPLAY
      T-Cta_cte_prv.tip_comprob COLUMN-LABEL "Tipo!Comp"
      T-Cta_cte_prv.prf_comprob COLUMN-LABEL "Pto.!Vta."
      T-Cta_cte_prv.nro_comprob COLUMN-LABEL "Número!Comprobte."
      T-Cta_cte_prv.nro_vencimiento COLUMN-LABEL "Nro!Ven"
      T-Cta_cte_prv.fecha_emision COLUMN-LABEL "Fecha!Emisión"
      T-Cta_cte_prv.fecha_vencimiento COLUMN-LABEL "Venci-!miento"
      T-Cta_cte_prv.cambio COLUMN-LABEL "Tasa!Cambio"
      T-Cta_cte_prv.cambio_dolar COLUMN-LABEL "Tasa!Cambio"
      Moneda.abrevia COLUMN-LABEL "Mo-!neda"
      T-Cta_cte_prv.debito COLUMN-LABEL "Importe!Débito" FORMAT "->>>,>>>,>>9.99"
      T-Cta_cte_prv.credito COLUMN-LABEL "Importe!Crédito" FORMAT "->>>,>>>,>>9.99"
      T-Cta_cte_prv.fecha_programada COLUMN-LABEL "Progra-!mación"
      T-Cta_cte_prv.imp_programado COLUMN-LABEL "Progra-!mado" FORMAT "->>>,>>>,>>9.99"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 125 BY 10.76
         BGCOLOR 15 FGCOLOR 9 FONT 4
         TITLE BGCOLOR 15 FGCOLOR 9 "Documentos Pendientes" EXPANDABLE.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     Btn_elegir AT ROW 1.24 COL 112
     v-totcomprobantes AT ROW 1.48 COL 87 COLON-ALIGNED
     v-cdg_proveedor AT ROW 1.52 COL 12 COLON-ALIGNED
     v-dsc_proveedor AT ROW 1.52 COL 26 COLON-ALIGNED NO-LABEL
     v-totpesos AT ROW 2.57 COL 87 COLON-ALIGNED
     v-cdg_moneda AT ROW 2.62 COL 12 COLON-ALIGNED
     v-dsc_moneda AT ROW 2.62 COL 26 COLON-ALIGNED NO-LABEL
     Btn_Cancel AT ROW 2.67 COL 112
     BROWSE-1 AT ROW 4.24 COL 2
     RECT-6 AT ROW 1.24 COL 2
     SPACE(17.79) SKIP(11.23)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         FONT 4
         TITLE "Selección de Documentos de Cuenta Corriente"
         DEFAULT-BUTTON Btn_elegir CANCEL-BUTTON Btn_Cancel.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: DIALOG-BOX
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Cta_cte_prv T "?" NO-UNDO sic Cta_cte_prv
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
                                                                        */
/* BROWSE-TAB BROWSE-1 Btn_Cancel Dialog-Frame */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN v-cdg_proveedor IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_moneda IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_proveedor IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_moneda IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-1
/* Query rebuild information for BROWSE BROWSE-1
     _START_FREEFORM
IF que_moneda = ?
    THEN OPEN QUERY {&SELF-NAME} FOR EACH T-Cta_cte_prv NO-LOCK
            WHERE T-Cta_cte_prv.cdg_empresa = que_empresa
              AND T-Cta_cte_prv.debito <> T-Cta_cte_prv.credito
              AND NOT T-Cta_cte_prv.imputado,
                FIRST Moneda OF T-Cta_cte_prv
               BY T-Cta_cte_prv.fecha_vencimiento.
    ELSE OPEN QUERY {&SELF-NAME} FOR EACH T-Cta_cte_prv NO-LOCK
            WHERE T-Cta_cte_prv.cdg_empresa = que_empresa
              AND (T-Cta_cte_prv.nro_moneda = que_moneda )
              AND T-Cta_cte_prv.debito <> T-Cta_cte_prv.credito
              AND NOT T-Cta_cte_prv.imputado,
                FIRST Moneda OF T-Cta_cte_prv
               BY T-Cta_cte_prv.fecha_vencimiento.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "Cta_cte_prv_prv.nro_moneda = Moneda.nro_moneda
 AND Cta_cte_prv_prv.cdg_empresa = Empresa.cdg_empresa"
     _Query            is OPENED
*/  /* BROWSE BROWSE-1 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX Dialog-Frame
/* Query rebuild information for DIALOG-BOX Dialog-Frame
     _TblList          = "sic.Moneda"
     _Options          = "SHARE-LOCK"
     _Query            is NOT OPENED
*/  /* DIALOG-BOX Dialog-Frame */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Selección de Documentos de Cuenta Corriente */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-1
&Scoped-define SELF-NAME BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-1 Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF BROWSE-1 IN FRAME Dialog-Frame /* Documentos Pendientes */
DO:
  FIND CURRENT T-Cta_cte_prv EXCLUSIVE-LOCK.
  IF T-Cta_cte_prv.user-id-sel = "" 
  THEN DO:
       v-totcomprobantes = v-totcomprobantes + 1.
       v-totpesos = v-totpesos + T-Cta_cte_prv.debito - T-Cta_cte_prv.credito.
       T-Cta_cte_prv.user-id-sel = st_seleccionado.
       RUN poner_color ( INPUT 0, INPUT 8).
  END.
  ELSE DO:
       T-Cta_cte_prv.user-id-sel = "".
       RUN poner_color ( INPUT 9, INPUT 15).
       v-totcomprobantes = v-totcomprobantes - 1.
       v-totpesos = v-totpesos - ( T-Cta_cte_prv.debito - T-Cta_cte_prv.credito ).
  END.

  DISPLAY 
       v-totcomprobantes
       v-totpesos
       WITH FRAME {&FRAME-NAME}.
  FIND CURRENT T-Cta_cte_prv NO-LOCK.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-1 Dialog-Frame
ON RETURN OF BROWSE-1 IN FRAME Dialog-Frame /* Documentos Pendientes */
DO:
  APPLY "MOUSE-SELECT-DBLCLICK" TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-1 Dialog-Frame
ON ROW-DISPLAY OF BROWSE-1 IN FRAME Dialog-Frame /* Documentos Pendientes */
DO:
  IF T-Cta_cte_prv.user-id-sel = "" 
     THEN RUN poner_color ( INPUT 9, INPUT 15).
     ELSE RUN poner_color ( INPUT 0, INPUT 8).
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel Dialog-Frame
ON CHOOSE OF Btn_Cancel IN FRAME Dialog-Frame /* Cancelar */
DO:
   FOR EACH T-Cta_cte_prv WHERE T-Cta_cte_prv.user-id-sel = st_seleccionado:
      T-Cta_cte_prv.selectado = NO.
      T-Cta_cte_prv.user-id-sel = "".
   END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_proveedor
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_proveedor Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF v-cdg_proveedor IN FRAME Dialog-Frame /* Proveedor */
OR "." OF v-cdg_proveedor IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_proveedor IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "proveedor" "cdg_proveedor" "SELCLIEN.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_proveedor Dialog-Frame
ON RETURN OF v-cdg_proveedor IN FRAME Dialog-Frame /* Proveedor */
DO:
   &SCOPED-DEFINE PONER-TABLA RUN poner_proveedor.
   {traducetabla.i "proveedor" "cdg_proveedor" "nombre"} 
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

FIND Proveedor WHERE ROWID(Proveedor) = rid_proveedor NO-LOCK.
v-cdg_proveedor = Proveedor.cdg_proveedor.
v-dsc_proveedor = Proveedor.nombre.
IF rid_moneda <> ?
THEN DO:
    FIND Moneda  WHERE ROWID(Moneda) = rid_moneda NO-LOCK.
    ASSIGN v-cdg_moneda = Moneda.cdg_moneda
           v-dsc_moneda = Moneda.descripcion
           que_moneda = Moneda.nro_moneda.
END.
ELSE DO:
    ASSIGN v-cdg_moneda = ""
           v-dsc_moneda = "TODAS LAS MONEDAS"
           que_moneda = ?.
END.

{findempresa.i}
ASSIGN
  que_empresa = Empresa.cdg_empresa.
  

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
  DISPLAY v-totcomprobantes v-cdg_proveedor v-dsc_proveedor v-totpesos v-cdg_moneda 
          v-dsc_moneda 
      WITH FRAME Dialog-Frame.
  ENABLE Btn_elegir v-totcomprobantes v-totpesos Btn_Cancel BROWSE-1 RECT-6 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_proveedor Dialog-Frame 
PROCEDURE poner_proveedor :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  {&OPEN-QUERY-{&BROWSE-NAME}}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_color Dialog-Frame 
PROCEDURE poner_color :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE INPUT PARAMETER fg_color AS INTEGER.
    DEFINE INPUT PARAMETER bg_color AS INTEGER.
  
    T-Cta_cte_prv.tip_comprob:FGCOLOR IN BROWSE {&BROWSE-NAME} = fg_color.
    T-Cta_cte_prv.prf_comprob:FGCOLOR IN BROWSE {&BROWSE-NAME} = fg_color.
    T-Cta_cte_prv.nro_comprob:FGCOLOR IN BROWSE {&BROWSE-NAME} = fg_color.
    T-Cta_cte_prv.nro_vencimiento:FGCOLOR IN BROWSE {&BROWSE-NAME} = fg_color.
    T-Cta_cte_prv.fecha_emision:FGCOLOR IN BROWSE {&BROWSE-NAME} = fg_color.
    T-Cta_cte_prv.fecha_vencimiento:FGCOLOR IN BROWSE {&BROWSE-NAME} = fg_color.
    T-Cta_cte_prv.cambio:FGCOLOR IN BROWSE {&BROWSE-NAME} = fg_color.
    T-Cta_cte_prv.cambio_dolar:FGCOLOR IN BROWSE {&BROWSE-NAME} = fg_color.
    Moneda.abrevia:FGCOLOR IN BROWSE {&BROWSE-NAME} = fg_color.
    T-Cta_cte_prv.debito:FGCOLOR IN BROWSE {&BROWSE-NAME} = fg_color.
    T-Cta_cte_prv.credito:FGCOLOR IN BROWSE {&BROWSE-NAME} = fg_color.
    T-Cta_cte_prv.fecha_programada:FGCOLOR IN BROWSE {&BROWSE-NAME} = fg_color.
    T-Cta_cte_prv.imp_programado:FGCOLOR IN BROWSE {&BROWSE-NAME} = fg_color.

    T-Cta_cte_prv.tip_comprob:BGCOLOR IN BROWSE {&BROWSE-NAME} = bg_color.
    T-Cta_cte_prv.prf_comprob:BGCOLOR IN BROWSE {&BROWSE-NAME} = bg_color.
    T-Cta_cte_prv.nro_comprob:BGCOLOR IN BROWSE {&BROWSE-NAME} = bg_color.
    T-Cta_cte_prv.nro_vencimiento:BGCOLOR IN BROWSE {&BROWSE-NAME} = bg_color.
    T-Cta_cte_prv.fecha_emision:BGCOLOR IN BROWSE {&BROWSE-NAME} = bg_color.
    T-Cta_cte_prv.fecha_vencimiento:BGCOLOR IN BROWSE {&BROWSE-NAME} = bg_color.
    T-Cta_cte_prv.cambio:BGCOLOR IN BROWSE {&BROWSE-NAME} = bg_color.
    T-Cta_cte_prv.cambio_dolar:BGCOLOR IN BROWSE {&BROWSE-NAME} = bg_color.
    Moneda.abrevia:BGCOLOR IN BROWSE {&BROWSE-NAME} = bg_color.
    T-Cta_cte_prv.debito:BGCOLOR IN BROWSE {&BROWSE-NAME} = bg_color.
    T-Cta_cte_prv.credito:BGCOLOR IN BROWSE {&BROWSE-NAME} = bg_color.
    T-Cta_cte_prv.fecha_programada:BGCOLOR IN BROWSE {&BROWSE-NAME} = bg_color.
    T-Cta_cte_prv.imp_programado:BGCOLOR IN BROWSE {&BROWSE-NAME} = bg_color.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

