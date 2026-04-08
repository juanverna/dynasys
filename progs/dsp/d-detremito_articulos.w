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

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame
&Scoped-define BROWSE-NAME BROWSE-7

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Rem_detalle-bon Bonificacion ~
T-Remito-pedido Ped_header T-Registrable-remito Registrable T-Rem_detalle

/* Definitions for BROWSE BROWSE-7                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-7 T-Rem_detalle-bon.cdg_bonificacion ~
Bonificacion.descripcion T-Rem_detalle-bon.porcentaje ~
T-Rem_detalle-bon.importe 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-7 
&Scoped-define QUERY-STRING-BROWSE-7 FOR EACH T-Rem_detalle-bon OF T-Rem_detalle NO-LOCK, ~
      EACH Bonificacion OF T-Rem_detalle-bon NO-LOCK
&Scoped-define OPEN-QUERY-BROWSE-7 OPEN QUERY BROWSE-7 FOR EACH T-Rem_detalle-bon OF T-Rem_detalle NO-LOCK, ~
      EACH Bonificacion OF T-Rem_detalle-bon NO-LOCK.
&Scoped-define TABLES-IN-QUERY-BROWSE-7 T-Rem_detalle-bon Bonificacion
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-7 T-Rem_detalle-bon
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-7 Bonificacion


/* Definitions for BROWSE BRW-PEDIDOS                                   */
&Scoped-define FIELDS-IN-QUERY-BRW-PEDIDOS Ped_header.nro_comprob ~
T-Remito-pedido.nro_linea-ped T-Remito-pedido.cantidad ~
T-Remito-pedido.granel 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BRW-PEDIDOS 
&Scoped-define QUERY-STRING-BRW-PEDIDOS FOR EACH T-Remito-pedido WHERE TRUE /* Join to T-Rem_detalle incomplete */ ~
      AND T-Remito-pedido.nro_remito = T-Rem_detalle.nro_remito ~
 AND T-Remito-pedido.nro_linea-rem = T-Rem_detalle.nro_linea NO-LOCK, ~
      EACH Ped_header OF T-Remito-pedido NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BRW-PEDIDOS OPEN QUERY BRW-PEDIDOS FOR EACH T-Remito-pedido WHERE TRUE /* Join to T-Rem_detalle incomplete */ ~
      AND T-Remito-pedido.nro_remito = T-Rem_detalle.nro_remito ~
 AND T-Remito-pedido.nro_linea-rem = T-Rem_detalle.nro_linea NO-LOCK, ~
      EACH Ped_header OF T-Remito-pedido NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BRW-PEDIDOS T-Remito-pedido Ped_header
&Scoped-define FIRST-TABLE-IN-QUERY-BRW-PEDIDOS T-Remito-pedido
&Scoped-define SECOND-TABLE-IN-QUERY-BRW-PEDIDOS Ped_header


/* Definitions for BROWSE BRW-REGISTRABLES                              */
&Scoped-define FIELDS-IN-QUERY-BRW-REGISTRABLES Registrable.cdg_registrable 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BRW-REGISTRABLES 
&Scoped-define QUERY-STRING-BRW-REGISTRABLES FOR EACH T-Registrable-remito OF T-Rem_detalle NO-LOCK, ~
      EACH Registrable OF T-Registrable-remito NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BRW-REGISTRABLES OPEN QUERY BRW-REGISTRABLES FOR EACH T-Registrable-remito OF T-Rem_detalle NO-LOCK, ~
      EACH Registrable OF T-Registrable-remito NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BRW-REGISTRABLES T-Registrable-remito ~
Registrable
&Scoped-define FIRST-TABLE-IN-QUERY-BRW-REGISTRABLES T-Registrable-remito
&Scoped-define SECOND-TABLE-IN-QUERY-BRW-REGISTRABLES Registrable


/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define FIELDS-IN-QUERY-Dialog-Frame T-Rem_detalle.cantidad ~
T-Rem_detalle.granel T-Rem_detalle.precio T-Rem_detalle.subtotal_neto 
&Scoped-define ENABLED-FIELDS-IN-QUERY-Dialog-Frame T-Rem_detalle.cantidad ~
T-Rem_detalle.granel 
&Scoped-define ENABLED-TABLES-IN-QUERY-Dialog-Frame T-Rem_detalle
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-Dialog-Frame T-Rem_detalle
&Scoped-define OPEN-BROWSERS-IN-QUERY-Dialog-Frame ~
    ~{&OPEN-QUERY-BROWSE-7}~
    ~{&OPEN-QUERY-BRW-REGISTRABLES}
&Scoped-define QUERY-STRING-Dialog-Frame FOR EACH T-Rem_detalle SHARE-LOCK
&Scoped-define OPEN-QUERY-Dialog-Frame OPEN QUERY Dialog-Frame FOR EACH T-Rem_detalle SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-Dialog-Frame T-Rem_detalle
&Scoped-define FIRST-TABLE-IN-QUERY-Dialog-Frame T-Rem_detalle


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS T-Rem_detalle.cantidad T-Rem_detalle.granel 
&Scoped-define ENABLED-TABLES T-Rem_detalle
&Scoped-define FIRST-ENABLED-TABLE T-Rem_detalle
&Scoped-Define ENABLED-OBJECTS BRW-REGISTRABLES v-cdg_bonificacion ~
v-porcentaje BRW-PEDIDOS BROWSE-7 v-tip_pedido v-prf_pedido v-nro_pedido ~
v-nro_linea v-cantidad v-granel Btn_OK Btn_Cancel RECT-10 RECT-11 RECT-12 ~
RECT-13 RECT-14 RECT-15 RECT-9 
&Scoped-Define DISPLAYED-FIELDS T-Rem_detalle.cantidad T-Rem_detalle.granel ~
T-Rem_detalle.precio T-Rem_detalle.subtotal_neto 
&Scoped-define DISPLAYED-TABLES T-Rem_detalle
&Scoped-define FIRST-DISPLAYED-TABLE T-Rem_detalle
&Scoped-Define DISPLAYED-OBJECTS v-registrable v-cdg_articulo ~
v-dsc_articulo v-cdg_partida v-dsc_partida v-cdg_umed v-cdg_entidad ~
v-dsc_entidad v-cdg_obra v-dsc_obra v-cantidad_pend v-granel_pend ~
v-cdg_bonificacion v-dsc_bonificacion v-porcentaje v-tip_pedido ~
v-prf_pedido v-nro_pedido v-nro_linea v-cantidad v-granel 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Ca&ncel" 
     SIZE 13 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON btn_creapedido 
     LABEL "C&rear" 
     SIZE 18 BY 1.14.

DEFINE BUTTON btn_crear 
     LABEL "Crear &Bonificacion" 
     SIZE 31 BY 1.14.

DEFINE BUTTON btn_desasignar 
     LABEL "&Desasignar" 
     SIZE 19 BY 1.14.

DEFINE BUTTON btn_eliminar 
     LABEL "Eliminar &Bonificacion" 
     SIZE 31 BY 1.14.

DEFINE BUTTON btn_elimpedido 
     LABEL "&Eliminar" 
     SIZE 18 BY 1.14.

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "&OK" 
     SIZE 14 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON btn_sinobra 
     LABEL "&Sin Obra" 
     SIZE 12 BY 1.

DEFINE VARIABLE v-cantidad AS DECIMAL FORMAT "->>>>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cantidad_pend AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Un" 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-cdg_articulo AS CHARACTER FORMAT "X(256)":U 
     LABEL "Artículo" 
     VIEW-AS FILL-IN 
     SIZE 22 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-cdg_bonificacion AS INTEGER FORMAT ">>>>9" INITIAL 0 
     VIEW-AS FILL-IN NATIVE 
     SIZE 8 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_entidad AS CHARACTER FORMAT "X(256)":U 
     LABEL "Entidad" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 22 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cdg_obra AS CHARACTER FORMAT "X(256)":U 
     LABEL "Obra" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 22 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cdg_partida AS CHARACTER FORMAT "X(256)":U 
     LABEL "Partida" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 22 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cdg_umed AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_articulo AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 65 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_bonificacion AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 43 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_entidad AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 65 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_obra AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 52 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_partida AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 47 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-granel AS DECIMAL FORMAT "->>>>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-granel_pend AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Kg" 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-nro_linea AS INTEGER FORMAT ">>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-nro_pedido AS INTEGER FORMAT ">>>>>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 9 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-porcentaje AS DECIMAL FORMAT ">>9.99":U INITIAL 0 
     LABEL "%" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 8 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-prf_pedido AS INTEGER FORMAT ">>>>>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-registrable AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 19 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-tip_pedido AS CHARACTER FORMAT "X(2)":U 
     LABEL "Pedido" 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 105 BY 1.71.

DEFINE RECTANGLE RECT-11
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 105 BY 2.76.

DEFINE RECTANGLE RECT-12
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 65 BY 10.24.

DEFINE RECTANGLE RECT-13
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 40 BY 12.14.

DEFINE RECTANGLE RECT-14
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 21 BY 19.29.

DEFINE RECTANGLE RECT-15
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 65 BY 1.62.

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 105 BY 2.57.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-7 FOR 
      T-Rem_detalle-bon, 
      Bonificacion SCROLLING.

DEFINE QUERY BRW-PEDIDOS FOR 
      T-Remito-pedido, 
      Ped_header SCROLLING.

DEFINE QUERY BRW-REGISTRABLES FOR 
      T-Registrable-remito, 
      Registrable SCROLLING.

DEFINE QUERY Dialog-Frame FOR 
      T-Rem_detalle SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-7
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-7 Dialog-Frame _STRUCTURED
  QUERY BROWSE-7 NO-LOCK DISPLAY
      T-Rem_detalle-bon.cdg_bonificacion COLUMN-LABEL "Có-!digo" FORMAT "ZZ9":U
      Bonificacion.descripcion COLUMN-LABEL "Descripción!Bonificación" FORMAT "X(28)":U
            WIDTH 31
      T-Rem_detalle-bon.porcentaje COLUMN-LABEL "%.!Bon." FORMAT "->>9.99":U
      T-Rem_detalle-bon.importe COLUMN-LABEL "Importe!Bonificado" FORMAT "->,>>>,>>9.99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 63 BY 7.05
         TITLE "Bonificaciones del Item de Comprobante".

DEFINE BROWSE BRW-PEDIDOS
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BRW-PEDIDOS Dialog-Frame _STRUCTURED
  QUERY BRW-PEDIDOS NO-LOCK DISPLAY
      Ped_header.nro_comprob COLUMN-LABEL "Número!Pedido" FORMAT "ZZZZZZZ9":U
            WIDTH 7.4
      T-Remito-pedido.nro_linea-ped COLUMN-LABEL "Lí-!nea" FORMAT ">>9":U
            WIDTH 4.4
      T-Remito-pedido.cantidad COLUMN-LABEL "Cantidad!Enviada" FORMAT "->>>,>>>,>>9.99":U
            WIDTH 8.2
      T-Remito-pedido.granel COLUMN-LABEL "Granel!Enviado" FORMAT "->>,>>9.99":U
            WIDTH 10
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 37 BY 5.14
         TITLE "Pedidos Imputados" EXPANDABLE.

DEFINE BROWSE BRW-REGISTRABLES
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BRW-REGISTRABLES Dialog-Frame _STRUCTURED
  QUERY BRW-REGISTRABLES NO-LOCK DISPLAY
      Registrable.cdg_registrable FORMAT "X(8)":U WIDTH 14.4
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 19 BY 15 EXPANDABLE.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     BRW-REGISTRABLES AT ROW 3.86 COL 109
     v-registrable AT ROW 2.67 COL 107 COLON-ALIGNED NO-LABEL
     v-cdg_articulo AT ROW 1.48 COL 16 COLON-ALIGNED
     v-dsc_articulo AT ROW 1.48 COL 39 COLON-ALIGNED NO-LABEL
     v-cdg_partida AT ROW 2.67 COL 16 COLON-ALIGNED
     v-dsc_partida AT ROW 2.67 COL 39 COLON-ALIGNED NO-LABEL
     v-cdg_umed AT ROW 2.67 COL 87 COLON-ALIGNED NO-LABEL
     v-cdg_entidad AT ROW 4.33 COL 16 COLON-ALIGNED
     v-dsc_entidad AT ROW 4.33 COL 39 COLON-ALIGNED NO-LABEL
     v-cdg_obra AT ROW 5.52 COL 16 COLON-ALIGNED
     v-dsc_obra AT ROW 5.52 COL 39 COLON-ALIGNED NO-LABEL
     btn_sinobra AT ROW 5.52 COL 94
     T-Rem_detalle.cantidad AT ROW 6.95 COL 16 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 22 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Rem_detalle.granel AT ROW 6.95 COL 50 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Rem_detalle.precio AT ROW 6.95 COL 86 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cantidad_pend AT ROW 8.62 COL 6 COLON-ALIGNED
     v-granel_pend AT ROW 8.62 COL 25 COLON-ALIGNED
     v-cdg_bonificacion AT ROW 8.62 COL 41 COLON-ALIGNED NO-LABEL
     v-dsc_bonificacion AT ROW 8.62 COL 50 COLON-ALIGNED NO-LABEL
     v-porcentaje AT ROW 8.62 COL 96 COLON-ALIGNED
     BRW-PEDIDOS AT ROW 9.71 COL 3
     BROWSE-7 AT ROW 9.91 COL 43
     btn_creapedido AT ROW 15.1 COL 3
     btn_elimpedido AT ROW 15.05 COL 22
     v-tip_pedido AT ROW 16.48 COL 12 COLON-ALIGNED
     v-prf_pedido AT ROW 16.48 COL 17 COLON-ALIGNED NO-LABEL
     v-nro_pedido AT ROW 16.48 COL 23 COLON-ALIGNED NO-LABEL
     v-nro_linea AT ROW 16.48 COL 32 COLON-ALIGNED NO-LABEL
     v-cantidad AT ROW 19 COL 1 COLON-ALIGNED NO-LABEL
     v-granel AT ROW 19.1 COL 21 COLON-ALIGNED NO-LABEL
     btn_crear AT ROW 17.19 COL 43
     btn_eliminar AT ROW 17.19 COL 75
     Btn_OK AT ROW 19.14 COL 43
     Btn_Cancel AT ROW 19.14 COL 58
     T-Rem_detalle.subtotal_neto AT ROW 19.29 COL 85 COLON-ALIGNED
          LABEL "Subtotal Neto"
          VIEW-AS FILL-IN 
          SIZE 19 BY 1
          BGCOLOR 7 FGCOLOR 15 
     btn_desasignar AT ROW 19.1 COL 109
     RECT-10 AT ROW 6.67 COL 2
     RECT-11 AT ROW 3.86 COL 2
     RECT-12 AT ROW 8.38 COL 42
     RECT-13 AT ROW 8.38 COL 2
     RECT-14 AT ROW 1.24 COL 108
     RECT-15 AT ROW 18.86 COL 42
     RECT-9 AT ROW 1.29 COL 2
     "  Cantidad y Granel Imputados" VIEW-AS TEXT
          SIZE 37 BY 1 AT ROW 17.76 COL 3
          BGCOLOR 5 FGCOLOR 15 
     "       Registrables" VIEW-AS TEXT
          SIZE 19 BY 1 AT ROW 1.48 COL 109
          BGCOLOR 5 FGCOLOR 15 
     SPACE(1.79) SKIP(18.13)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Detalle de Comprobantes de Despacho"
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel.


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
   Custom                                                               */
/* BROWSE-TAB BRW-REGISTRABLES 1 Dialog-Frame */
/* BROWSE-TAB BRW-PEDIDOS v-porcentaje Dialog-Frame */
/* BROWSE-TAB BROWSE-7 BRW-PEDIDOS Dialog-Frame */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR BUTTON btn_creapedido IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_crear IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_desasignar IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_eliminar IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_elimpedido IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_sinobra IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Rem_detalle.precio IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Rem_detalle.subtotal_neto IN FRAME Dialog-Frame
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN v-cantidad_pend IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_articulo IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_entidad IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_obra IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_partida IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_umed IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_articulo IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_bonificacion IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_entidad IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_obra IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_partida IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-granel_pend IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-registrable IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-7
/* Query rebuild information for BROWSE BROWSE-7
     _TblList          = "Temp-Tables.T-Rem_detalle-bon OF Temp-Tables.T-Rem_detalle,sic.Bonificacion OF Temp-Tables.T-Rem_detalle-bon"
     _Options          = "NO-LOCK"
     _FldNameList[1]   > Temp-Tables.T-Rem_detalle-bon.cdg_bonificacion
"T-Rem_detalle-bon.cdg_bonificacion" "Có-!digo" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[2]   > sic.Bonificacion.descripcion
"Bonificacion.descripcion" "Descripción!Bonificación" "X(28)" "character" ? ? ? ? ? ? no ? no no "31" yes no no "U" "" ""
     _FldNameList[3]   > Temp-Tables.T-Rem_detalle-bon.porcentaje
"T-Rem_detalle-bon.porcentaje" "%.!Bon." ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[4]   > Temp-Tables.T-Rem_detalle-bon.importe
"T-Rem_detalle-bon.importe" "Importe!Bonificado" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _Query            is OPENED
*/  /* BROWSE BROWSE-7 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BRW-PEDIDOS
/* Query rebuild information for BROWSE BRW-PEDIDOS
     _TblList          = "Temp-Tables.T-Remito-pedido WHERE Temp-Tables.T-Rem_detalle <external> ...,sic.Ped_header OF Temp-Tables.T-Remito-pedido"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "Temp-Tables.T-Remito-pedido.nro_remito = T-Rem_detalle.nro_remito
 AND Temp-Tables.T-Remito-pedido.nro_linea-rem = T-Rem_detalle.nro_linea"
     _FldNameList[1]   > sic.Ped_header.nro_comprob
"Ped_header.nro_comprob" "Número!Pedido" ? "integer" ? ? ? ? ? ? no ? no no "7.4" yes no no "U" "" ""
     _FldNameList[2]   > Temp-Tables.T-Remito-pedido.nro_linea-ped
"T-Remito-pedido.nro_linea-ped" "Lí-!nea" ? "integer" ? ? ? ? ? ? no ? no no "4.4" yes no no "U" "" ""
     _FldNameList[3]   > Temp-Tables.T-Remito-pedido.cantidad
"T-Remito-pedido.cantidad" "Cantidad!Enviada" ? "decimal" ? ? ? ? ? ? no ? no no "8.2" yes no no "U" "" ""
     _FldNameList[4]   > Temp-Tables.T-Remito-pedido.granel
"T-Remito-pedido.granel" "Granel!Enviado" ? "decimal" ? ? ? ? ? ? no ? no no "10" yes no no "U" "" ""
     _Query            is NOT OPENED
*/  /* BROWSE BRW-PEDIDOS */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BRW-REGISTRABLES
/* Query rebuild information for BROWSE BRW-REGISTRABLES
     _TblList          = "Temp-Tables.T-Registrable-remito OF Temp-Tables.T-Rem_detalle,sic.Registrable OF Temp-Tables.T-Registrable-remito"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > sic.Registrable.cdg_registrable
"Registrable.cdg_registrable" ? ? "character" ? ? ? ? ? ? no ? no no "14.4" yes no no "U" "" ""
     _Query            is OPENED
*/  /* BROWSE BRW-REGISTRABLES */
&ANALYZE-RESUME

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
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Detalle de Comprobantes de Despacho */
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
      FOR EACH T-Rem_detalle-bon OF T-Rem_detalle:
          DELETE T-Rem_detalle-bon.
      END.
      DELETE T-Rem_detalle.  
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_creapedido
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_creapedido Dialog-Frame
ON CHOOSE OF btn_creapedido IN FRAME Dialog-Frame /* Crear */
DO:
   RUN crear_relacion.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_crear
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_crear Dialog-Frame
ON CHOOSE OF btn_crear IN FRAME Dialog-Frame /* Crear Bonificacion */
DO:

  ASSIGN FRAME {&FRAME-NAME} v-cdg_bonificacion v-porcentaje.
  FIND Bonificacion WHERE Bonificacion.cdg_bonificacion = v-cdg_bonificacion NO-LOCK NO-ERROR.
  IF AVAILABLE Bonificacion 
  THEN DO:
       FIND T-Rem_detalle-bon 
            WHERE T-Rem_detalle-bon.cdg_bonificacion = v-cdg_bonificacion NO-LOCK NO-ERROR.
       IF AVAILABLE T-Rem_detalle-bon 
       THEN DO:
            RUN ponmensj.p ( INPUT "BONI002").
            RETURN NO-APPLY.
       END.
       ELSE DO:
            DO TRANSACTION:
               CREATE T-Rem_detalle-bon.
               ASSIGN T-Rem_detalle-bon.cdg_bonificacion = v-cdg_bonificacion
                      T-Rem_detalle-bon.porcentaje       = v-porcentaje
                      T-Rem_detalle-bon.nro_remito       = T-Rem_detalle.nro_remito
                      T-Rem_detalle-bon.nro_linea        = T-Rem_detalle.nro_linea. 
            END.
            {&OPEN-QUERY-{&BROWSE-NAME}}
            ASSIGN  v-cdg_bonificacion = 0
                    v-dsc_bonificacion = ""
                    v-porcentaje       = 0.
            DISPLAY v-cdg_bonificacion
                    v-dsc_bonificacion
                    v-porcentaje
                    WITH FRAME {&FRAME-NAME}.
       END.
  END.
  ELSE DO:
       RUN ponmensj.p ( INPUT "BONI002").
       RETURN NO-APPLY.
  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_desasignar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_desasignar Dialog-Frame
ON CHOOSE OF btn_desasignar IN FRAME Dialog-Frame /* Desasignar */
DO:
    DEFINE VARIABLE sino-msg AS LOGICAL.
    IF NOT AVAILABLE T-Registrable-remito
    THEN DO:
         RUN ponmensj.p ( INPUT "BONI003").
         RETURN NO-APPLY.
    END.
    ELSE DO:
         sino-msg = NO.
         MESSAGE "Realmente desea desasignar este Registrable?" 
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
         IF sino-msg
         THEN DO:
              DO TRANSACTION:              
                 DELETE T-Registrable-remito.
                 RUN refrescar_browse_registrables.
              END. 
         END.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_eliminar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_eliminar Dialog-Frame
ON CHOOSE OF btn_eliminar IN FRAME Dialog-Frame /* Eliminar Bonificacion */
DO:
    DEFINE VARIABLE sino-msg AS LOGICAL.
    IF NOT AVAILABLE T-Rem_detalle-bon
    THEN DO:
         RUN ponmensj.p ( INPUT "BONI003").
         RETURN NO-APPLY.
    END.
    ELSE DO:
         sino-msg = NO.
         MESSAGE "Realmente desea eliminar esta Bonificación?" 
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
         IF sino-msg
         THEN DO:
              DO TRANSACTION:              
                 DELETE T-Rem_detalle-bon.
                 {&OPEN-QUERY-{&BROWSE-NAME}}                 
              END. 
         END.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_elimpedido
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_elimpedido Dialog-Frame
ON CHOOSE OF btn_elimpedido IN FRAME Dialog-Frame /* Eliminar */
DO:
    DEFINE VARIABLE sino-msg AS LOGICAL.
    IF NOT AVAILABLE T-Remito-pedido
    THEN DO:
         RUN ponmensj.p ( INPUT "BONI003").
         RETURN NO-APPLY.
    END.
    ELSE DO:
         sino-msg = NO.
         MESSAGE "Realmente desea desasignar este pedido?" 
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
         IF sino-msg
         THEN DO:
              DO TRANSACTION:              
                 DELETE T-Remito-pedido.
                 RUN calcular_pendiente.
                 RUN refrescar_browse_pedidos.                 
              END. 
         END.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* OK */
DO:

  ASSIGN FRAME {&FRAME-NAME}
        v-cdg_partida
        v-cdg_entidad
        v-cdg_obra
        T-Rem_detalle.cantidad 
        T-Rem_detalle.granel 
        T-Rem_detalle.precio.
  
  RUN  validar_datos ( OUTPUT hubo_error ).
  IF NOT hubo_error
  THEN DO:
        IF p-modo-detalle = 0 /* Es un alta */ 
        THEN DO:
            ASSIGN
                T-Rem_header.ultima_linea     = T-Rem_header.ultima_linea + 1.
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


&Scoped-define SELF-NAME T-Rem_detalle.cantidad
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Rem_detalle.cantidad Dialog-Frame
ON LEAVE OF T-Rem_detalle.cantidad IN FRAME Dialog-Frame /* Cantidad */
DO:
  RUN calcular_pendiente.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Rem_detalle.granel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Rem_detalle.granel Dialog-Frame
ON LEAVE OF T-Rem_detalle.granel IN FRAME Dialog-Frame /* Granel */
DO:
  RUN calcular_pendiente.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_bonificacion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_bonificacion Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF v-cdg_bonificacion IN FRAME Dialog-Frame
OR "." OF v-cdg_bonificacion IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_bonificacion IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Bonificacion" "cdg_bonificacion" "SELBONIF.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_bonificacion Dialog-Frame
ON RETURN OF v-cdg_bonificacion IN FRAME Dialog-Frame
OR TAB OF v-cdg_bonificacion IN FRAME {&FRAME-NAME}
DO:
   &SCOPED-DEFINE PONER-TABLA RUN poner_porcentaje.
   {traducetabla.i "Bonificacion" "cdg_bonificacion" "descripcion"} 
   &UNDEFINE PONER-TABLA
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
ON F7 OF v-cdg_partida IN FRAME Dialog-Frame /* Partida */
DO:
/*
  HIDE FRAME {&FRAME-NAME}.
  ult_partida = ?.
  RUN ACTPARTI.P (INPUT 1).
  RUN PONER_SESION.
  IF ult_partida <> ?
  THEN DO:
     ant_ROWID = ?.
     FIND Partida WHERE ROWID(Partida) = ult_partida NO-LOCK.
     DISPLAY Partida.cdg_partida WITH FRAME {&FRAME-NAME}.
     APPLY "RETURN" TO Partida.cdg_partida IN FRAME {&FRAME-NAME}.
  END.
  ELSE DO:
     VIEW FRAME {&FRAME-NAME}.
     APPLY "ENTRY" TO Partida.cdg_partida IN FRAME {&FRAME-NAME}.
  END.
  RETURN NO-APPLY.
*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_partida Dialog-Frame
ON F8 OF v-cdg_partida IN FRAME Dialog-Frame /* Partida */
DO:
/*
  IF NOT AVAILABLE Partida
  THEN DO:
     RUN ponmensj.p (INPUT "HELP001").
  END.
  ELSE DO:
     HIDE FRAME {&FRAME-NAME}.
     ult_partida = ROWID(Partida).
     RUN ACTPARTI.P (INPUT 2).
     RUN PONER_SESION.
     IF ult_partida <> ?
     THEN DO:
        ant_ROWID = ?.
        FIND Partida WHERE ROWID(Partida) = ult_partida NO-LOCK.
        DISPLAY Partida.cdg_partida WITH FRAME {&FRAME-NAME}.
        APPLY "RETURN" TO Partida.cdg_partida IN FRAME {&FRAME-NAME}.
     END.
     ELSE DO:
        VIEW FRAME {&FRAME-NAME}.
        APPLY "ENTRY" TO Partida.cdg_partida IN FRAME {&FRAME-NAME}.
     END.
  END.
  RETURN NO-APPLY.
*/  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_partida Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF v-cdg_partida IN FRAME Dialog-Frame /* Partida */
OR "." OF v-cdg_partida IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_partida IN FRAME {&FRAME-NAME}
DO:
  DEFINE VARIABLE x-cdg_partida LIKE Partida.cdg_partida.
  RUN d-seleccionar_partida-deposito.w ( INPUT  T-Rem_detalle.nro_articulo,
                                         INPUT  T-Rem_header.nro_deposito,
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
        WHERE Partida.cdg_empresa  = T-Rem_header.cdg_empresa
          AND Partida.nro_articulo = T-Rem_detalle.nro_articulo
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


&Scoped-define SELF-NAME v-cdg_umed
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_umed Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF v-cdg_umed IN FRAME Dialog-Frame
OR "." OF v-cdg_entidad IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_entidad IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Entidad" "cdg_entidad" "SELENTID.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_umed Dialog-Frame
ON RETURN OF v-cdg_umed IN FRAME Dialog-Frame
DO:
    {traducetabla.i "Entidad" "cdg_entidad" "dsc_entidad"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-nro_linea
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-nro_linea Dialog-Frame
ON MOUSE-MENU-DOWN OF v-nro_linea IN FRAME Dialog-Frame
OR MOUSE-SELECT-DBLCLICK OF v-nro_linea IN FRAME {&FRAME-NAME}
DO:
  DEFINE VARIABLE lOK AS LOGICAL.
  RUN d-seleccionar_itempedido.w ( INPUT T-Rem_header.nro_cliente,
                                   INPUT T-Rem_detalle.nro_articulo,
                                   OUTPUT v-tip_pedido, 
                                   OUTPUT v-prf_pedido,
                                   OUTPUT v-nro_pedido,
                                   OUTPUT v-nro_linea,
                                   OUTPUT v-cantidad,
                                   OUTPUT v-granel,
                                   OUTPUT lOK).
  IF lOK
  THEN DO:
     DISPLAY v-tip_pedido 
             v-prf_pedido
             v-nro_pedido
             v-nro_linea
             v-cantidad
             v-granel
             WITH FRAME {&FRAME-NAME}.
     APPLY "RETURN" TO  v-nro_linea IN FRAME {&FRAME-NAME}.
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-nro_pedido
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-nro_pedido Dialog-Frame
ON MOUSE-MENU-DOWN OF v-nro_pedido IN FRAME Dialog-Frame
OR MOUSE-SELECT-DBLCLICK OF v-nro_pedido IN FRAME {&FRAME-NAME}
DO:
  APPLY "MOUSE-MENU-DOWN" TO v-nro_linea IN FRAME {&FRAME-NAME}.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-prf_pedido
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-prf_pedido Dialog-Frame
ON MOUSE-MENU-DOWN OF v-prf_pedido IN FRAME Dialog-Frame
OR MOUSE-SELECT-DBLCLICK OF v-prf_pedido IN FRAME {&FRAME-NAME}
DO:
  APPLY "MOUSE-MENU-DOWN" TO v-nro_linea IN FRAME {&FRAME-NAME}.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-registrable
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-registrable Dialog-Frame
ON RETURN OF v-registrable IN FRAME Dialog-Frame
DO:
  FIND FIRST Registrable 
      WHERE Registrable.cdg_registrable = INPUT v-registrable NO-LOCK NO-ERROR.
  IF AVAILABLE Registrable
  THEN DO:
      DO TRANSACTION:
          CREATE T-Registrable-remito.
          BUFFER-COPY T-Rem_detalle TO T-Registrable-remito
              ASSIGN T-Registrable-remito.nro_registrable = Registrable.nro_registrable.
      END.
      RUN refrescar_browse_registrables.
  END.
  ELSE DO:
      MESSAGE "No existe el registrable" VIEW-AS ALERT-BOX MESSAGE.
  END.

  DISPLAY " " @ v-registrable
          WITH FRAME {&FRAME-NAME}.
  APPLY "ENTRY" TO v-registrable  IN FRAME {&FRAME-NAME}.
  RETURN NO-APPLY.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-tip_pedido
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-tip_pedido Dialog-Frame
ON MOUSE-MENU-DOWN OF v-tip_pedido IN FRAME Dialog-Frame /* Pedido */
OR MOUSE-SELECT-DBLCLICK OF v-tip_pedido IN FRAME {&FRAME-NAME}
DO:
  APPLY "MOUSE-MENU-DOWN" TO v-nro_linea IN FRAME {&FRAME-NAME}.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-7
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
/*  
         FOR EACH T-remito-pedido:
             MESSAGE T-remito-pedido.nro_remito T-remito-pedido.nro_linea-rem T-remito-pedido.nro_pedido T-remito-pedido.nro_linea-ped
                      VIEW-AS ALERT-BOX MESSAGE TITLE "linea " + STRING(t-rem_detalle.nro_linea).
         END.
*/

  IF p-modo-detalle = 0
  THEN DO:
     FIND Articulo WHERE Articulo.nro_articulo = p-nro_articulo NO-LOCK.
     ASSIGN v-cdg_articulo = Articulo.cdg_articulo
            v-dsc_articulo = Articulo.descripcion
            v-cdg_umed     = Articulo.cdg_umed.

     CREATE T-Rem_detalle.
     ASSIGN T-Rem_detalle.nro_remito   = T-Rem_header.nro_remito
            T-Rem_detalle.nro_linea    = T-Rem_header.ultima_linea + 1
            T-Rem_detalle.nro_articulo = Articulo.nro_articulo
            T-Rem_detalle.costo        = Articulo.costo
            T-Rem_detalle.a_granel     = Articulo.a_granel.

     FIND Lista_precios OF T-Rem_header NO-LOCK.
     FIND LAST Articulo_precio OF Articulo 
               WHERE Articulo_precio.cdg_lista   = Lista_precios.cdg_lista 
                 AND Articulo_precio.cdg_empresa = T-Rem_header.cdg_empresa
                 AND Articulo_precio.fch_desde <= T-Rem_header.fecha   
                     NO-LOCK NO-ERROR.
     IF NOT AVAILABLE Articulo_precio 
     THEN DO:
          RUN ponmensj.p ( INPUT "PEDI012").
          T-Rem_detalle.precio     = ?.
     END.     
     ELSE DO:
          T-Rem_detalle.precio     = Articulo_precio.precio.
     END.

     FOR EACH Cliente-bonxarticulo OF Articulo 
         WHERE Cliente-bonxarticulo.nro_cliente = T-Rem_header.nro_cliente 
           AND Cliente-bonxarticulo.desde_fecha <= T-Rem_header.fecha 
           AND Cliente-bonxarticulo.hasta_fecha >= T-Rem_header.fecha 
           AND Cliente-bonxarticulo.cdg_empresa  = T-Rem_header.cdg_empresa 
               NO-LOCK:
         
         CREATE T-Rem_detalle-bon.
         ASSIGN T-Rem_detalle-bon.cdg_bonificacion = Cliente-bonxarticulo.cdg_bonificacion
                T-Rem_detalle-bon.importe          = 0
                T-Rem_detalle-bon.nro_linea        = T-Rem_detalle.nro_linea
                T-Rem_detalle-bon.nro_remito       = T-Rem_detalle.nro_remito
                T-Rem_detalle-bon.porcentaje       = Cliente-bonxarticulo.porcentaje.
         
     END.

     IF NOT Articulo.hay_partida
     THEN DO:
        FIND FIRST Partida OF Articulo NO-LOCK.
        T-Rem_detalle.nro_partida = Partida.nro_partida.
     END.
     
     FIND Entidad WHERE Entidad.cdg_entidad = T-Rem_header.cdg_empresa NO-LOCK.
     IF AVAILABLE Entidad
     THEN DO:
          v-cdg_entidad = Entidad.cdg_entidad.
          v-dsc_entidad = Entidad.dsc_entidad.
     END.
     ELSE DO:
          v-cdg_entidad = "".
          v-dsc_entidad = "".
     END.
     
  END.
  ELSE DO:
     FIND FIRST T-Rem_detalle WHERE T-Rem_detalle.nro_linea = p-nro_linea-i EXCLUSIVE-LOCK.
     RUN traer_tablas.
  END.

  IF Articulo.a_granel
     THEN ASSIGN T-Rem_detalle.cantidad:BGCOLOR IN FRAME {&FRAME-NAME} = 14
                 T-Rem_detalle.granel:BGCOLOR IN FRAME {&FRAME-NAME} = 14.
     ELSE ASSIGN T-Rem_detalle.cantidad:BGCOLOR IN FRAME {&FRAME-NAME} = 15
                 T-Rem_detalle.granel:BGCOLOR IN FRAME {&FRAME-NAME} = 15.

  DISPLAY 
        v-cdg_articulo
        v-dsc_articulo
        v-cdg_umed
        v-cdg_entidad
        v-dsc_entidad
        v-cdg_obra
        v-dsc_obra
        v-cdg_partida
        v-dsc_partida
        T-Rem_detalle.cantidad 
        T-Rem_detalle.granel 
        T-Rem_detalle.precio
        T-Rem_detalle.subtotal_neto 
        WITH FRAME {&FRAME-NAME}.      

  RUN habilitar_campos.
  {&OPEN-QUERY-{&BROWSE-NAME}}
  RUN refrescar_browse_pedidos.
  RUN refrescar_browse_registrables.
  RUN calcular_pendiente.

  APPLY "ENTRY" TO T-Rem_detalle.cantidad IN FRAME {&FRAME-NAME}.      
 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE calcular_pendiente Dialog-Frame 
PROCEDURE calcular_pendiente :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  v-cantidad_pend = T-Rem_detalle.cantidad:INPUT-VALUE IN FRAME {&FRAME-NAME}.
  v-granel_pend   = T-Rem_detalle.granel:INPUT-VALUE IN FRAME {&FRAME-NAME}.

  FOR EACH T-Remito-pedido WHERE T-Remito-pedido.nro_remito = T-Rem_detalle.nro_remito
                             AND T-Remito-pedido.nro_linea-rem = T-Rem_detalle.nro_linea:

       v-cantidad_pend = v-cantidad_pend - T-Remito-pedido.cantidad.
       v-granel_pend = v-granel_pend - T-Remito-pedido.granel.

  END.

  DISPLAY v-cantidad_pend v-granel_pend 
          WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE crear_relacion Dialog-Frame 
PROCEDURE crear_relacion :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  ASSIGN FRAME {&FRAME-NAME} v-cantidad v-granel v-nro_linea v-nro_pedido v-tip_pedido v-prf_pedido.
  FIND Ped_header WHERE Ped_header.cdg_empresa = T-Rem_header.cdg_empresa
                    AND Ped_header.tip_comprob = v-tip_pedido 
                    AND Ped_header.prf_comprob = v-prf_pedido 
                    AND Ped_header.nro_comprob = v-nro_pedido 
                    NO-LOCK NO-ERROR.
  IF AVAILABLE Ped_header 
  THEN DO:
       FIND FIRST Ped_detalle OF Ped_header 
            WHERE Ped_detalle.nro_linea = v-nro_linea NO-LOCK NO-ERROR.
       IF AVAILABLE Ped_detalle 
       THEN DO:
            IF T-Rem_detalle.nro_articulo = Ped_detalle.nro_articulo
            THEN DO:
                 RUN hacer_relacion.           
            END.
            ELSE DO:
                 
                 RUN ponmensj.p ( INPUT "REMI053").
                 RETURN NO-APPLY.
            END.
       END.
       ELSE DO:
            RUN ponmensj.p ( INPUT "REMI052").
            RETURN NO-APPLY.
       END.
  END.
  ELSE DO:
       RUN ponmensj.p ( INPUT "REMI050").
       RETURN NO-APPLY.
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

  {&OPEN-QUERY-Dialog-Frame}
  GET FIRST Dialog-Frame.
  DISPLAY v-registrable v-cdg_articulo v-dsc_articulo v-cdg_partida 
          v-dsc_partida v-cdg_umed v-cdg_entidad v-dsc_entidad v-cdg_obra 
          v-dsc_obra v-cantidad_pend v-granel_pend v-cdg_bonificacion 
          v-dsc_bonificacion v-porcentaje v-tip_pedido v-prf_pedido v-nro_pedido 
          v-nro_linea v-cantidad v-granel 
      WITH FRAME Dialog-Frame.
  IF AVAILABLE T-Rem_detalle THEN 
    DISPLAY T-Rem_detalle.cantidad T-Rem_detalle.granel T-Rem_detalle.precio 
          T-Rem_detalle.subtotal_neto 
      WITH FRAME Dialog-Frame.
  ENABLE BRW-REGISTRABLES T-Rem_detalle.cantidad T-Rem_detalle.granel 
         v-cdg_bonificacion v-porcentaje BRW-PEDIDOS BROWSE-7 v-tip_pedido 
         v-prf_pedido v-nro_pedido v-nro_linea v-cantidad v-granel Btn_OK 
         Btn_Cancel RECT-10 RECT-11 RECT-12 RECT-13 RECT-14 RECT-15 RECT-9 
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
        v-cdg_partida:SENSITIVE                   = NO
        v-cdg_entidad:SENSITIVE                   = NO
        v-cdg_obra:SENSITIVE                      = NO
        v-registrable:SENSITIVE                   = NO
        T-Rem_detalle.cantidad:SENSITIVE          = NO 
        T-Rem_detalle.granel:SENSITIVE            = NO 
        T-Rem_detalle.precio:SENSITIVE            = NO 
        btn_creapedido:SENSITIVE                  = NO  
        btn_crear:SENSITIVE                       = NO  
        btn_eliminar:SENSITIVE                    = NO  
        btn_elimpedido:SENSITIVE                  = NO 
        btn_sinobra:SENSITIVE                     = NO
        btn_desasignar:SENSITIVE                  = NO
        Btn_OK:SENSITIVE                          = NO.

    CASE p-modo-cabecera:
        WHEN MD_ALTA                   
        THEN DO:
            v-cdg_partida:SENSITIVE                   = Articulo.hay_partida.
            v-cdg_entidad:SENSITIVE                   = YES.
            v-cdg_obra:SENSITIVE                      = hay_obras.
            v-registrable:SENSITIVE                   = Articulo.es_registrable.
            T-Rem_detalle.cantidad:SENSITIVE          = YES. 
            T-Rem_detalle.granel:SENSITIVE            = Articulo.a_granel. 
            T-Rem_detalle.precio:SENSITIVE            = NO. 
            btn_creapedido:SENSITIVE                  = YES.  
            btn_crear:SENSITIVE                       = YES.  
            btn_eliminar:SENSITIVE                    = YES.  
            btn_elimpedido:SENSITIVE                  = YES. 
            btn_sinobra:SENSITIVE                     = hay_obras.
            btn_desasignar:SENSITIVE                  = Articulo.es_registrable.
            Btn_OK:SENSITIVE                          = YES.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE hacer_relacion Dialog-Frame 
PROCEDURE hacer_relacion :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   CREATE T-Remito-pedido.
   ASSIGN T-Remito-pedido.nro_remito     = T-Rem_detalle.nro_remito
          T-Remito-pedido.nro_linea-rem  = T-Rem_detalle.nro_linea
          T-Remito-pedido.nro_pedido     = Ped_detalle.nro_pedido
          T-Remito-pedido.nro_linea-ped  = Ped_detalle.nro_linea
          T-Remito-pedido.cantidad       = v-cantidad
          T-Remito-pedido.granel         = v-granel.

   /*{&OPEN-QUERY-{&BROWSE-NAME}}*/
   
   RUN refrescar_browse_pedidos.
   ASSIGN  v-tip_pedido = ""
           v-prf_pedido = 0
           v-nro_pedido = 0
           v-cantidad   = 0
           v-granel     = 0.
   DISPLAY v-tip_pedido 
           v-prf_pedido 
           v-nro_pedido
           v-cantidad  
           v-granel
           WITH FRAME {&FRAME-NAME}.
    
   RUN calcular_pendiente.
   
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_porcentaje Dialog-Frame 
PROCEDURE poner_porcentaje :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  v-porcentaje = Bonificacion.porcentaje.
  DISPLAY v-porcentaje
          WITH FRAME {&FRAME-NAME}.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE refrescar_browse_pedidos Dialog-Frame 
PROCEDURE refrescar_browse_pedidos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   OPEN QUERY BRW-PEDIDOS 
        FOR EACH T-Remito-pedido OF T-Rem_detalle, 
           FIRST Ped_header OF T-Remito-pedido.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE refrescar_browse_registrables Dialog-Frame 
PROCEDURE refrescar_browse_registrables :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   OPEN QUERY BRW-REGISTRABLES 
        FOR EACH T-Registrable-remito OF T-Rem_detalle, 
           FIRST Registrable OF T-Registrable-remito.

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
        v-dsc_articulo = Articulo.descripcion
        v-cdg_umed     = Articulo.cdg_umed.
        
  FIND Partida OF T-Rem_detalle NO-LOCK.
  IF AVAILABLE Partida
  THEN DO:
       v-cdg_partida = Partida.cdg_partida.
       v-dsc_partida = Partida.descripcion.
  END.
  ELSE DO:
       v-cdg_Partida = "".
       v-dsc_Partida = "".
  END.
  
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

  FIND Partida OF T-Rem_detalle NO-LOCK NO-ERROR.
  IF AVAILABLE Partida
  THEN DO:
       v-cdg_partida = Partida.cdg_partida.
       v-dsc_partida = Partida.descripcion.
  END.
  ELSE DO:
       v-cdg_partida = "".
       v-dsc_partida = "".
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

   IF T-Rem_detalle.cantidad = 0 OR (Articulo.a_granel AND T-Rem_detalle.granel = 0 )   
   THEN DO:
        RUN ponmensj.p ( INPUT "REMI012" ).
        RETURN.
   END.

   IF v-cantidad_pend < 0 OR v-granel_pend < 0 
   THEN DO:
        RUN ponmensj.p ( INPUT "PEDI028" ).
        RETURN.
   END.

   FIND Entidad WHERE Entidad.cdg_entidad = v-cdg_entidad NO-ERROR.
   IF NOT AVAILABLE Entidad
   THEN DO:
        RUN ponmensj.p ( INPUT "ASIE012" ).
        RETURN.
   END.
   ELSE DO:
        T-Rem_detalle.nro_entidad = Entidad.nro_entidad.
   END.

   IF Articulo.hay_partida
   THEN DO:
        FIND FIRST Partida NO-LOCK 
             WHERE Partida.cdg_empresa  = T-Rem_header.cdg_empresa
               AND Partida.nro_articulo = T-Rem_detalle.nro_articulo
               AND Partida.cdg_partida  = INPUT FRAME {&FRAME-NAME} v-cdg_partida NO-ERROR.
     
        IF NOT AVAILABLE Partida
        THEN DO:
             RUN ponmensj.p ( INPUT "ARTI008" ).
             RETURN NO-APPLY.
        END.
        ELSE DO:
             T-Rem_detalle.nro_partida = Partida.nro_partida.
        END.
   END.
   
   IF INPUT FRAME {&FRAME-NAME} v-cdg_obra <> ""
   THEN DO:
        FIND Obra WHERE Obra.cdg_obra = v-cdg_obra NO-ERROR.
        IF NOT AVAILABLE Obra
        THEN DO:
             RUN ponmensj.p ( INPUT "ASIE013" ).
             RETURN.
        END.
        ELSE DO:
             IF LOOKUP(Obra.entidades_validas,T-Rem_header.cdg_empresa,",") = 0
             THEN DO:
                  RUN ponmensj.p ( INPUT "ASIE027" ).
                  RETURN.
             END.

             IF Obra.finalizada
             THEN DO:
                  RUN ponmensj.p ( INPUT "ASIE026" ).
                  RETURN.
             END.
             
             IF T-Rem_header.fecha < Obra.fecha_apertura OR
                T-Rem_header.fecha > Obra.fecha_cierre 
             THEN DO:
                  RUN ponmensj.p ( INPUT "ASIE026" ).
                  RETURN.
             END.

             T-Rem_detalle.nro_obra = Obra.nro_obra.

        END.
   END.


   hay_error = NO.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

