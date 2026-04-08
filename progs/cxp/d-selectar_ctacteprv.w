&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame

/* Temp-Table and Buffer definitions                                    */
DEFINE SHARED TEMP-TABLE T-Cta_cte_prv NO-UNDO LIKE Cta_cte_prv.


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
&ELSE
DEFINE VARIABLE rid_proveedor AS ROWID.
FIND Proveedor WHERE Proveedor.cdg_proveedor = "00039" NO-LOCK.
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
&Scoped-define INTERNAL-TABLES T-Cta_cte_prv Proveedor Moneda

/* Definitions for BROWSE BROWSE-1                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-1 T-Cta_cte_prv.tip_comprob T-Cta_cte_prv.prf_comprob T-Cta_cte_prv.nro_comprob T-Cta_cte_prv.nro_vencimiento T-Cta_cte_prv.fecha_emision T-Cta_cte_prv.fecha_vencimiento T-Cta_cte_prv.fecha_programada T-Cta_cte_prv.debito T-Cta_cte_prv.credito T-Cta_cte_prv.imp_programado T-Cta_cte_prv.liberada T-Cta_cte_prv.leyenda   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-1   
&Scoped-define SELF-NAME BROWSE-1
&Scoped-define QUERY-STRING-BROWSE-1 FOR EACH T-Cta_cte_prv         WHERE T-Cta_cte_prv.cdg_empresa = que_empresa           AND T-Cta_cte_prv.nro_moneda = que_moneda           AND T-Cta_cte_prv.debito <> T-Cta_cte_prv.credito           AND NOT T-Cta_cte_prv.imputado            BY T-Cta_cte_prv.fecha_vencimiento
&Scoped-define OPEN-QUERY-BROWSE-1 OPEN QUERY {&SELF-NAME} FOR EACH T-Cta_cte_prv         WHERE T-Cta_cte_prv.cdg_empresa = que_empresa           AND T-Cta_cte_prv.nro_moneda = que_moneda           AND T-Cta_cte_prv.debito <> T-Cta_cte_prv.credito           AND NOT T-Cta_cte_prv.imputado            BY T-Cta_cte_prv.fecha_vencimiento.
&Scoped-define TABLES-IN-QUERY-BROWSE-1 T-Cta_cte_prv
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-1 T-Cta_cte_prv


/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define FIELDS-IN-QUERY-Dialog-Frame Proveedor.nombre ~
Proveedor.cdg_proveedor Moneda.descripcion Moneda.cdg_moneda 
&Scoped-define ENABLED-FIELDS-IN-QUERY-Dialog-Frame Proveedor.cdg_proveedor ~
Moneda.cdg_moneda 
&Scoped-define ENABLED-TABLES-IN-QUERY-Dialog-Frame Proveedor Moneda
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-Dialog-Frame Proveedor
&Scoped-define SECOND-ENABLED-TABLE-IN-QUERY-Dialog-Frame Moneda
&Scoped-define OPEN-BROWSERS-IN-QUERY-Dialog-Frame ~
    ~{&OPEN-QUERY-BROWSE-1}
&Scoped-define QUERY-STRING-Dialog-Frame FOR EACH Proveedor SHARE-LOCK, ~
      EACH Moneda WHERE TRUE /* Join to Proveedor incomplete */ SHARE-LOCK
&Scoped-define OPEN-QUERY-Dialog-Frame OPEN QUERY Dialog-Frame FOR EACH Proveedor SHARE-LOCK, ~
      EACH Moneda WHERE TRUE /* Join to Proveedor incomplete */ SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-Dialog-Frame Proveedor Moneda
&Scoped-define FIRST-TABLE-IN-QUERY-Dialog-Frame Proveedor
&Scoped-define SECOND-TABLE-IN-QUERY-Dialog-Frame Moneda


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Proveedor.cdg_proveedor Moneda.cdg_moneda 
&Scoped-define ENABLED-TABLES Proveedor Moneda
&Scoped-define FIRST-ENABLED-TABLE Proveedor
&Scoped-define SECOND-ENABLED-TABLE Moneda
&Scoped-Define ENABLED-OBJECTS Btn_elegir v-totcomprobantes v-totpesos ~
Btn_Cancel BROWSE-1 RECT-6 
&Scoped-Define DISPLAYED-FIELDS Proveedor.nombre Proveedor.cdg_proveedor ~
Moneda.descripcion Moneda.cdg_moneda 
&Scoped-define DISPLAYED-TABLES Proveedor Moneda
&Scoped-define FIRST-DISPLAYED-TABLE Proveedor
&Scoped-define SECOND-DISPLAYED-TABLE Moneda
&Scoped-Define DISPLAYED-OBJECTS v-totcomprobantes v-totpesos 

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

DEFINE VARIABLE v-totcomprobantes AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "#" 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 14 FGCOLOR 9 FONT 6 NO-UNDO.

DEFINE VARIABLE v-totpesos AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     LABEL "$" 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 14 FGCOLOR 9 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 107 BY 2.43.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-1 FOR 
      T-Cta_cte_prv SCROLLING.

DEFINE QUERY Dialog-Frame FOR 
      Proveedor, 
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
      T-Cta_cte_prv.fecha_programada COLUMN-LABEL "Progra-!mación"
      T-Cta_cte_prv.debito COLUMN-LABEL "Importe!Débito"
      T-Cta_cte_prv.credito COLUMN-LABEL "Importe!Crédito"
      T-Cta_cte_prv.imp_programado COLUMN-LABEL "Progra-!mado"
      T-Cta_cte_prv.liberada COLUMN-LABEL "Libe-!rada"
      T-Cta_cte_prv.leyenda COLUMN-LABEL "Leyenda!Movimiento"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 124 BY 10.76
         BGCOLOR 15 FGCOLOR 9 FONT 4
         TITLE BGCOLOR 15 FGCOLOR 9 "Documentos Pendientes".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     Btn_elegir AT ROW 1.24 COL 111
     Proveedor.nombre AT ROW 1.48 COL 30 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 52 BY 1
          BGCOLOR 7 FGCOLOR 15 
     v-totcomprobantes AT ROW 1.48 COL 86 COLON-ALIGNED
     Proveedor.cdg_proveedor AT ROW 1.52 COL 12 COLON-ALIGNED
          LABEL "Proveedor"
          VIEW-AS FILL-IN 
          SIZE 17 BY 1
     Moneda.descripcion AT ROW 2.57 COL 30 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 52 BY 1
          BGCOLOR 7 FGCOLOR 15 
     v-totpesos AT ROW 2.57 COL 86 COLON-ALIGNED
     Btn_Cancel AT ROW 2.57 COL 111
     Moneda.cdg_moneda AT ROW 2.62 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 17 BY 1
     BROWSE-1 AT ROW 3.95 COL 2
     RECT-6 AT ROW 1.29 COL 2
     SPACE(18.79) SKIP(11.37)
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
      TABLE: T-Cta_cte_prv T "SHARED" NO-UNDO sic Cta_cte_prv
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
                                                                        */
/* BROWSE-TAB BROWSE-1 cdg_moneda Dialog-Frame */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

ASSIGN 
       BROWSE-1:NUM-LOCKED-COLUMNS IN FRAME Dialog-Frame     = 4.

/* SETTINGS FOR FILL-IN Proveedor.cdg_proveedor IN FRAME Dialog-Frame
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Moneda.descripcion IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Proveedor.nombre IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-1
/* Query rebuild information for BROWSE BROWSE-1
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH T-Cta_cte_prv
        WHERE T-Cta_cte_prv.cdg_empresa = que_empresa
          AND T-Cta_cte_prv.nro_moneda = que_moneda
          AND T-Cta_cte_prv.debito <> T-Cta_cte_prv.credito
          AND NOT T-Cta_cte_prv.imputado
           BY T-Cta_cte_prv.fecha_vencimiento.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "Cta_cte_prv.nro_moneda = Moneda.nro_moneda
 AND Cta_cte_prv.cdg_empresa = Empresa.cdg_empresa"
     _Query            is OPENED
*/  /* BROWSE BROWSE-1 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX Dialog-Frame
/* Query rebuild information for DIALOG-BOX Dialog-Frame
     _TblList          = "sic.Proveedor,sic.Moneda WHERE sic.Proveedor ..."
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
       v-totpesos = v-totpesos + T-Cta_cte_prv.credito - T-Cta_cte_prv.debito.

       T-Cta_cte_prv.user-id-sel = st_seleccionado.
       T-Cta_cte_prv.selectado   = YES.
       RUN poner_color ( INPUT 0, INPUT 8).
  END.
  ELSE DO:
       v-totcomprobantes = v-totcomprobantes - 1.
       v-totpesos = v-totpesos - ( T-Cta_cte_prv.credito - T-Cta_cte_prv.debito ).

       T-Cta_cte_prv.user-id-sel = "".
       T-Cta_cte_prv.selectado   = NO.       
       RUN poner_color ( INPUT 9, INPUT 15).
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
  IF NOT T-Cta_cte_prv.selectado 
     THEN RUN poner_color ( INPUT 9, INPUT 15).
     ELSE RUN poner_color ( INPUT 0, INPUT 8).
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel Dialog-Frame
ON CHOOSE OF Btn_Cancel IN FRAME Dialog-Frame /* Cancelar */
DO:
/*
   lista_seleccion = "".
   FOR EACH T-Cta_cte_prv WHERE T-Cta_cte_prv.selectado:
      T-Cta_cte_prv.selectado = NO.
   END.
*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_elegir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_elegir Dialog-Frame
ON CHOOSE OF Btn_elegir IN FRAME Dialog-Frame /* Elegir */
DO:
/*
   lista_seleccion = "".
   FOR EACH T-Cta_cte_prv 
       WHERE T-Cta_cte_prv.selectado 
         AND T-Cta_cte_prv.user-id-sel = st_seleccionado:

      T-Cta_cte_prv.selectado = NO.
      lista_seleccion = lista_seleccion + "," + 
                        T-Cta_cte_prv.tip_comprob + ":" +
                        STRING(T-Cta_cte_prv.prf_comprob,">>>9") + ":" + 
                        STRING(T-Cta_cte_prv.nro_comprob,">>>9") + ":" + 
                        STRING(T-Cta_cte_prv.nro_vencimiento,">>>9").


   END.

   lista_seleccion = SUBSTRING(lista_seleccion,2).
   message lista_seleccion view-as alert-box message title "d-selectar_ctacteprv".
*/  
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
FIND Moneda  WHERE ROWID(Moneda) = rid_moneda NO-LOCK.
{findempresa.i}

ASSIGN
  que_empresa = Empresa.cdg_empresa.
  que_moneda = Moneda.nro_moneda.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  /*RUN abre_query.*/
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
  DISPLAY v-totcomprobantes v-totpesos 
      WITH FRAME Dialog-Frame.
  IF AVAILABLE Moneda THEN 
    DISPLAY Moneda.descripcion Moneda.cdg_moneda 
      WITH FRAME Dialog-Frame.
  IF AVAILABLE Proveedor THEN 
    DISPLAY Proveedor.nombre Proveedor.cdg_proveedor 
      WITH FRAME Dialog-Frame.
  ENABLE Btn_elegir v-totcomprobantes Proveedor.cdg_proveedor v-totpesos 
         Btn_Cancel Moneda.cdg_moneda BROWSE-1 RECT-6 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
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
    T-Cta_cte_prv.debito:FGCOLOR IN BROWSE {&BROWSE-NAME} = fg_color.
    T-Cta_cte_prv.credito:FGCOLOR IN BROWSE {&BROWSE-NAME} = fg_color.
    T-Cta_cte_prv.liberada:FGCOLOR IN BROWSE {&BROWSE-NAME} = fg_color.
    T-Cta_cte_prv.fecha_programada:FGCOLOR IN BROWSE {&BROWSE-NAME} = fg_color.
    T-Cta_cte_prv.imp_programado:FGCOLOR IN BROWSE {&BROWSE-NAME} = fg_color.

    T-Cta_cte_prv.tip_comprob:BGCOLOR IN BROWSE {&BROWSE-NAME} = bg_color.
    T-Cta_cte_prv.prf_comprob:BGCOLOR IN BROWSE {&BROWSE-NAME} = bg_color.
    T-Cta_cte_prv.nro_comprob:BGCOLOR IN BROWSE {&BROWSE-NAME} = bg_color.
    T-Cta_cte_prv.nro_vencimiento:BGCOLOR IN BROWSE {&BROWSE-NAME} = bg_color.
    T-Cta_cte_prv.fecha_emision:BGCOLOR IN BROWSE {&BROWSE-NAME} = bg_color.
    T-Cta_cte_prv.fecha_vencimiento:BGCOLOR IN BROWSE {&BROWSE-NAME} = bg_color.
    T-Cta_cte_prv.debito:BGCOLOR IN BROWSE {&BROWSE-NAME} = bg_color.
    T-Cta_cte_prv.credito:BGCOLOR IN BROWSE {&BROWSE-NAME} = bg_color.
    T-Cta_cte_prv.liberada:BGCOLOR IN BROWSE {&BROWSE-NAME} = bg_color.
    T-Cta_cte_prv.fecha_programada:BGCOLOR IN BROWSE {&BROWSE-NAME} = bg_color.
    T-Cta_cte_prv.imp_programado:BGCOLOR IN BROWSE {&BROWSE-NAME} = bg_color.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

