&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame


/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Fac_header NO-UNDO LIKE Fac_header.



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
/*          This .W file was created with the Progress AppBuilder.       */
/*----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

&IF DEFINED(UIB_is_Running) EQ 0
&THEN
DEFINE INPUT PARAMETER p-cdg_empresa LIKE Fac_header.cdg_empresa.
DEFINE INPUT PARAMETER p-tip_comprob LIKE Fac_header.tip_comprob.
DEFINE INPUT PARAMETER p-prf_comprob LIKE Fac_header.prf_comprob.
DEFINE INPUT PARAMETER p-nro_comprob LIKE Fac_header.nro_comprob.
&ELSE
DEFINE VARIABLE p-cdg_empresa LIKE Fac_header.cdg_empresa.
DEFINE VARIABLE p-tip_comprob LIKE Fac_header.tip_comprob.
DEFINE VARIABLE p-prf_comprob LIKE Fac_header.prf_comprob.
DEFINE VARIABLE p-nro_comprob LIKE Fac_header.nro_comprob.
&ENDIF

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Dialog-Box
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME Dialog-Frame
&Scoped-define BROWSE-NAME BROWSE-5

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES comprobante_rendicion Rendicion_hd Cobrador ~
Caj_detalle Rubro Valor T-Fac_header

/* Definitions for BROWSE BROWSE-5                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-5 comprobante_rendicion.este_pago ~
Rendicion_hd.fch_rendicion Rendicion_hd.imp_imputado Cobrador.cdg_cobrador ~
Cobrador.nom_cobrador 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-5 
&Scoped-define QUERY-STRING-BROWSE-5 FOR EACH comprobante_rendicion OF T-Fac_header NO-LOCK, ~
      EACH Rendicion_hd OF comprobante_rendicion NO-LOCK, ~
      EACH Cobrador OF Rendicion_hd NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-5 OPEN QUERY BROWSE-5 FOR EACH comprobante_rendicion OF T-Fac_header NO-LOCK, ~
      EACH Rendicion_hd OF comprobante_rendicion NO-LOCK, ~
      EACH Cobrador OF Rendicion_hd NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-5 comprobante_rendicion Rendicion_hd ~
Cobrador
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-5 comprobante_rendicion
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-5 Rendicion_hd
&Scoped-define THIRD-TABLE-IN-QUERY-BROWSE-5 Cobrador


/* Definitions for BROWSE BRW-VALORES                                   */
&Scoped-define FIELDS-IN-QUERY-BRW-VALORES Rubro.cdg_rubro Rubro.nombre Caj_detalle.importe Valor.numero_cheque Valor.fecha_emision Valor.estado   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BRW-VALORES   
&Scoped-define SELF-NAME BRW-VALORES
&Scoped-define QUERY-STRING-BRW-VALORES FOR EACH Caj_detalle          WHERE Caj_detalle.nro_transaccion = Rendicion_hd.nro_transaccion NO-LOCK, ~
                      FIRST Rubro OF Caj_detalle NO-LOCK, ~
                      FIRST Valor OUTER-JOIN OF Caj_detalle NO-LOCK.
&Scoped-define OPEN-QUERY-BRW-VALORES OPEN QUERY BRW-VALORES     FOR EACH Caj_detalle          WHERE Caj_detalle.nro_transaccion = Rendicion_hd.nro_transaccion NO-LOCK, ~
                      FIRST Rubro OF Caj_detalle NO-LOCK, ~
                      FIRST Valor OUTER-JOIN OF Caj_detalle NO-LOCK.                                                                             .
&Scoped-define TABLES-IN-QUERY-BRW-VALORES Caj_detalle Rubro Valor
&Scoped-define FIRST-TABLE-IN-QUERY-BRW-VALORES Caj_detalle
&Scoped-define SECOND-TABLE-IN-QUERY-BRW-VALORES Rubro
&Scoped-define THIRD-TABLE-IN-QUERY-BRW-VALORES Valor


/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define FIELDS-IN-QUERY-Dialog-Frame T-Fac_header.tip_comprob ~
T-Fac_header.prf_comprob T-Fac_header.nro_comprob T-Fac_header.imp_total ~
T-Fac_header.fecha T-Fac_header.nombre T-Fac_header.direccion ~
T-Fac_header.mes T-Fac_header.ano T-Fac_header.cdg_postal ~
T-Fac_header.localidad T-Fac_header.nom_Administrador ~
T-Fac_header.direccion_administrador T-Fac_header.localidad_administrador 
&Scoped-define OPEN-BROWSERS-IN-QUERY-Dialog-Frame ~
    ~{&OPEN-QUERY-BROWSE-5}~
    ~{&OPEN-QUERY-BRW-VALORES}
&Scoped-define QUERY-STRING-Dialog-Frame FOR EACH T-Fac_header SHARE-LOCK
&Scoped-define OPEN-QUERY-Dialog-Frame OPEN QUERY Dialog-Frame FOR EACH T-Fac_header SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-Dialog-Frame T-Fac_header
&Scoped-define FIRST-TABLE-IN-QUERY-Dialog-Frame T-Fac_header


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS BROWSE-5 BRW-VALORES 
&Scoped-Define DISPLAYED-FIELDS T-Fac_header.tip_comprob ~
T-Fac_header.prf_comprob T-Fac_header.nro_comprob T-Fac_header.imp_total ~
T-Fac_header.fecha T-Fac_header.nombre T-Fac_header.direccion ~
T-Fac_header.mes T-Fac_header.ano T-Fac_header.cdg_postal ~
T-Fac_header.localidad T-Fac_header.nom_Administrador ~
T-Fac_header.direccion_administrador T-Fac_header.localidad_administrador 
&Scoped-define DISPLAYED-TABLES T-Fac_header
&Scoped-define FIRST-DISPLAYED-TABLE T-Fac_header


/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-5 FOR 
      comprobante_rendicion, 
      Rendicion_hd, 
      Cobrador SCROLLING.

DEFINE QUERY BRW-VALORES FOR 
      Caj_detalle, 
      Rubro, 
      Valor SCROLLING.

DEFINE QUERY Dialog-Frame FOR 
      T-Fac_header SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-5 Dialog-Frame _STRUCTURED
  QUERY BROWSE-5 NO-LOCK DISPLAY
      comprobante_rendicion.este_pago COLUMN-LABEL "Importe!Pagado" FORMAT "->>>,>>9.99":U
      Rendicion_hd.fch_rendicion FORMAT "99/99/99":U
      Rendicion_hd.imp_imputado COLUMN-LABEL "Importe!Rendición" FORMAT "->,>>>,>>9.99":U
      Cobrador.cdg_cobrador FORMAT "X(8)":U
      Cobrador.nom_cobrador FORMAT "X(35)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 92 BY 5
         TITLE "Rendiciones que afectan el comprobante" FIT-LAST-COLUMN.

DEFINE BROWSE BRW-VALORES
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BRW-VALORES Dialog-Frame _FREEFORM
  QUERY BRW-VALORES DISPLAY
      Rubro.cdg_rubro         COLUMN-LABEL "Código!Rubro"
      Rubro.nombre            COLUMN-LABEL "Denominación!Rubro"
      Caj_detalle.importe     COLUMN-LABEL "Importe!Ingresado"
      Valor.numero_cheque     COLUMN-LABEL "Número!Cheque"
      Valor.fecha_emision     COLUMN-LABEL "Fecha!Pago"
      Valor.estado            COLUMN-LABEL "Es-!tado"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 91 BY 6.91
         TITLE "Valores correspondientes a la rendición" FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     T-Fac_header.tip_comprob AT ROW 1.24 COL 9 COLON-ALIGNED WIDGET-ID 40
          LABEL "Docto."
          VIEW-AS FILL-IN 
          SIZE 5 BY 1
          BGCOLOR 15 FGCOLOR 9 FONT 6
     T-Fac_header.prf_comprob AT ROW 1.24 COL 15 COLON-ALIGNED NO-LABEL WIDGET-ID 38
          VIEW-AS FILL-IN 
          SIZE 7.6 BY 1
          BGCOLOR 15 FGCOLOR 9 FONT 6
     T-Fac_header.nro_comprob AT ROW 1.24 COL 24 COLON-ALIGNED NO-LABEL WIDGET-ID 36
          VIEW-AS FILL-IN 
          SIZE 13.2 BY 1
          BGCOLOR 15 FGCOLOR 9 FONT 6
     T-Fac_header.imp_total AT ROW 1.24 COL 44 COLON-ALIGNED WIDGET-ID 24
          VIEW-AS FILL-IN 
          SIZE 14 BY 1
          BGCOLOR 15 FGCOLOR 9 FONT 6
     T-Fac_header.fecha AT ROW 1.24 COL 74 COLON-ALIGNED WIDGET-ID 22
          VIEW-AS FILL-IN 
          SIZE 17 BY 1
          BGCOLOR 15 FGCOLOR 9 FONT 6
     T-Fac_header.nombre AT ROW 2.43 COL 9 COLON-ALIGNED WIDGET-ID 32
          LABEL "Cliente"
          VIEW-AS FILL-IN 
          SIZE 34 BY 1
          BGCOLOR 15 FGCOLOR 9 FONT 6
     T-Fac_header.direccion AT ROW 2.43 COL 44 COLON-ALIGNED NO-LABEL WIDGET-ID 18
          VIEW-AS FILL-IN 
          SIZE 47 BY 1
          BGCOLOR 15 FGCOLOR 9 FONT 6
     T-Fac_header.mes AT ROW 3.62 COL 29 COLON-ALIGNED WIDGET-ID 30
          LABEL "Período"
          VIEW-AS FILL-IN 
          SIZE 4.8 BY 1
          BGCOLOR 15 FGCOLOR 9 FONT 6
     T-Fac_header.ano AT ROW 3.62 COL 35 COLON-ALIGNED NO-LABEL WIDGET-ID 10
          VIEW-AS FILL-IN 
          SIZE 7.6 BY 1
          BGCOLOR 15 FGCOLOR 9 FONT 6
     T-Fac_header.cdg_postal AT ROW 3.62 COL 44 COLON-ALIGNED NO-LABEL WIDGET-ID 14
          VIEW-AS FILL-IN 
          SIZE 13.6 BY 1
          BGCOLOR 15 FGCOLOR 9 FONT 6
     T-Fac_header.localidad AT ROW 3.62 COL 59 COLON-ALIGNED NO-LABEL WIDGET-ID 26
          VIEW-AS FILL-IN 
          SIZE 32 BY 1
          BGCOLOR 15 FGCOLOR 9 FONT 6
     T-Fac_header.nom_Administrador AT ROW 4.81 COL 9 COLON-ALIGNED WIDGET-ID 34
          LABEL "Admin"
          VIEW-AS FILL-IN 
          SIZE 34 BY 1
          BGCOLOR 15 FGCOLOR 2 FONT 6
     T-Fac_header.direccion_administrador AT ROW 4.81 COL 44 COLON-ALIGNED NO-LABEL WIDGET-ID 20
          VIEW-AS FILL-IN 
          SIZE 47 BY 1
          BGCOLOR 15 FGCOLOR 2 FONT 6
     T-Fac_header.localidad_administrador AT ROW 6 COL 44 COLON-ALIGNED NO-LABEL WIDGET-ID 28
          VIEW-AS FILL-IN 
          SIZE 47 BY 1
          BGCOLOR 15 FGCOLOR 2 FONT 6
     BROWSE-5 AT ROW 7.43 COL 1 WIDGET-ID 400
     BRW-VALORES AT ROW 13.14 COL 2 WIDGET-ID 500
     SPACE(0.39) SKIP(0.51)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Cancelación de la factura actual" WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Dialog-Box
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Fac_header T "?" NO-UNDO sic Fac_header
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
   FRAME-NAME                                                           */
/* BROWSE-TAB BROWSE-5 localidad_administrador Dialog-Frame */
/* BROWSE-TAB BRW-VALORES BROWSE-5 Dialog-Frame */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN T-Fac_header.ano IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Fac_header.cdg_postal IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Fac_header.direccion IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Fac_header.direccion_administrador IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Fac_header.fecha IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Fac_header.imp_total IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Fac_header.localidad IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Fac_header.localidad_administrador IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Fac_header.mes IN FRAME Dialog-Frame
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN T-Fac_header.nombre IN FRAME Dialog-Frame
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN T-Fac_header.nom_Administrador IN FRAME Dialog-Frame
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN T-Fac_header.nro_comprob IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Fac_header.prf_comprob IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Fac_header.tip_comprob IN FRAME Dialog-Frame
   NO-ENABLE EXP-LABEL                                                  */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-5
/* Query rebuild information for BROWSE BROWSE-5
     _TblList          = "sic.comprobante_rendicion OF Temp-Tables.T-Fac_header,sic.Rendicion_hd OF sic.comprobante_rendicion,sic.Cobrador OF sic.Rendicion_hd"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > sic.comprobante_rendicion.este_pago
"comprobante_rendicion.este_pago" "Importe!Pagado" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[2]   = sic.Rendicion_hd.fch_rendicion
     _FldNameList[3]   > sic.Rendicion_hd.imp_imputado
"Rendicion_hd.imp_imputado" "Importe!Rendición" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[4]   = sic.Cobrador.cdg_cobrador
     _FldNameList[5]   = sic.Cobrador.nom_cobrador
     _Query            is OPENED
*/  /* BROWSE BROWSE-5 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BRW-VALORES
/* Query rebuild information for BROWSE BRW-VALORES
     _START_FREEFORM
OPEN QUERY BRW-VALORES
    FOR EACH Caj_detalle
         WHERE Caj_detalle.nro_transaccion = Rendicion_hd.nro_transaccion NO-LOCK,
               FIRST Rubro OF Caj_detalle NO-LOCK,
               FIRST Valor OUTER-JOIN OF Caj_detalle NO-LOCK.
                                                                            .
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE BRW-VALORES */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX Dialog-Frame
/* Query rebuild information for DIALOG-BOX Dialog-Frame
     _TblList          = "Temp-Tables.T-Fac_header"
     _Options          = "SHARE-LOCK"
     _Query            is OPENED
*/  /* DIALOG-BOX Dialog-Frame */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Cancelación de la factura actual */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-5
&Scoped-define SELF-NAME BROWSE-5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-5 Dialog-Frame
ON VALUE-CHANGED OF BROWSE-5 IN FRAME Dialog-Frame /* Rendiciones que afectan el comprobante */
DO:
  OPEN QUERY BRW-VALORES
    FOR EACH Caj_detalle
         WHERE Caj_detalle.nro_transaccion = Rendicion_hd.nro_transaccion NO-LOCK,
               FIRST Rubro OF Caj_detalle NO-LOCK,
               FIRST Valor OUTER-JOIN OF Rubro NO-LOCK.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Dialog-Frame 


/* ***************************  Main Block  *************************** */

/* Parent the dialog-box to the ACTIVE-WINDOW, if there is no parent.   */
IF VALID-HANDLE(ACTIVE-WINDOW) AND FRAME {&FRAME-NAME}:PARENT eq ?
THEN FRAME {&FRAME-NAME}:PARENT = ACTIVE-WINDOW.

FIND Fac_header 
    WHERE Fac_header.cdg_empresa = p-cdg_empresa
      AND Fac_header.tip_comprob = p-tip_comprob
      AND Fac_header.prf_comprob = p-prf_comprob
      AND Fac_header.nro_comprob = p-nro_comprob
          NO-LOCK.
CREATE T-Fac_header.
BUFFER-COPY Fac_header TO T-Fac_header.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  {&OPEN-QUERY-{&BROWSE-NAME}}
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

  {&OPEN-QUERY-Dialog-Frame}
  GET FIRST Dialog-Frame.
  IF AVAILABLE T-Fac_header THEN 
    DISPLAY T-Fac_header.tip_comprob T-Fac_header.prf_comprob 
          T-Fac_header.nro_comprob T-Fac_header.imp_total T-Fac_header.fecha 
          T-Fac_header.nombre T-Fac_header.direccion T-Fac_header.mes 
          T-Fac_header.ano T-Fac_header.cdg_postal T-Fac_header.localidad 
          T-Fac_header.nom_Administrador T-Fac_header.direccion_administrador 
          T-Fac_header.localidad_administrador 
      WITH FRAME Dialog-Frame.
  ENABLE BROWSE-5 BRW-VALORES 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

