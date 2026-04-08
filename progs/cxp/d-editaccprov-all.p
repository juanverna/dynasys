&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
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

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

&IF DEFINED(UIB_is_Running) EQ 0
&THEN
DEFINE INPUT PARAMETER rid_detalle AS ROWID.
&ELSE
DEFINE VARIABLE rid_detalle AS ROWID.
FIND FIRST Opg_detalle.
rid_detalle = ROWID(Opg_detalle).
&ENDIF

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Cta_cte_prv

/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define FIELDS-IN-QUERY-Dialog-Frame Cta_cte_prv.tip_comprob ~
Cta_cte_prv.prf_comprob Cta_cte_prv.nro_comprob Cta_cte_prv.nro_vencimiento ~
Cta_cte_prv.mes Cta_cte_prv.ano Cta_cte_prv.cdg_empresa ~
Cta_cte_prv.cdg_imputacion Cta_cte_prv.nro_moneda Cta_cte_prv.cambio ~
Cta_cte_prv.credito Cta_cte_prv.debito Cta_cte_prv.liberada ~
Cta_cte_prv.imp_neto Cta_cte_prv.imp_iva Cta_cte_prv.imp_total ~
Cta_cte_prv.imp_retibr Cta_cte_prv.cdg_tiporetgan ~
Cta_cte_prv.cdg_tiporetibr Cta_cte_prv.cdg_tiporetiva ~
Cta_cte_prv.imp_retiva Cta_cte_prv.cdg_tiporetsus Cta_cte_prv.fecha_alta ~
Cta_cte_prv.fecha_emision Cta_cte_prv.fecha_vencimiento ~
Cta_cte_prv.fecha_programada Cta_cte_prv.imp_programado ~
Cta_cte_prv.programada Cta_cte_prv.leyenda Cta_cte_prv.usuario-sel 
&Scoped-define ENABLED-FIELDS-IN-QUERY-Dialog-Frame Cta_cte_prv.tip_comprob ~
Cta_cte_prv.prf_comprob Cta_cte_prv.nro_comprob Cta_cte_prv.nro_vencimiento ~
Cta_cte_prv.mes Cta_cte_prv.ano Cta_cte_prv.cdg_empresa ~
Cta_cte_prv.cdg_imputacion Cta_cte_prv.nro_moneda Cta_cte_prv.cambio ~
Cta_cte_prv.credito Cta_cte_prv.debito Cta_cte_prv.liberada ~
Cta_cte_prv.imp_neto Cta_cte_prv.imp_iva Cta_cte_prv.imp_total ~
Cta_cte_prv.imp_retibr Cta_cte_prv.cdg_tiporetgan ~
Cta_cte_prv.cdg_tiporetibr Cta_cte_prv.cdg_tiporetiva ~
Cta_cte_prv.imp_retiva Cta_cte_prv.cdg_tiporetsus Cta_cte_prv.fecha_alta ~
Cta_cte_prv.fecha_emision Cta_cte_prv.fecha_vencimiento ~
Cta_cte_prv.fecha_programada Cta_cte_prv.imp_programado ~
Cta_cte_prv.programada Cta_cte_prv.leyenda Cta_cte_prv.usuario-sel 
&Scoped-define ENABLED-TABLES-IN-QUERY-Dialog-Frame Cta_cte_prv
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-Dialog-Frame Cta_cte_prv

&Scoped-define FIELD-PAIRS-IN-QUERY-Dialog-Frame~
 ~{&FP1}tip_comprob ~{&FP2}tip_comprob ~{&FP3}~
 ~{&FP1}prf_comprob ~{&FP2}prf_comprob ~{&FP3}~
 ~{&FP1}nro_comprob ~{&FP2}nro_comprob ~{&FP3}~
 ~{&FP1}nro_vencimiento ~{&FP2}nro_vencimiento ~{&FP3}~
 ~{&FP1}mes ~{&FP2}mes ~{&FP3}~
 ~{&FP1}ano ~{&FP2}ano ~{&FP3}~
 ~{&FP1}cdg_empresa ~{&FP2}cdg_empresa ~{&FP3}~
 ~{&FP1}cdg_imputacion ~{&FP2}cdg_imputacion ~{&FP3}~
 ~{&FP1}nro_moneda ~{&FP2}nro_moneda ~{&FP3}~
 ~{&FP1}cambio ~{&FP2}cambio ~{&FP3}~
 ~{&FP1}credito ~{&FP2}credito ~{&FP3}~
 ~{&FP1}debito ~{&FP2}debito ~{&FP3}~
 ~{&FP1}imp_neto ~{&FP2}imp_neto ~{&FP3}~
 ~{&FP1}imp_iva ~{&FP2}imp_iva ~{&FP3}~
 ~{&FP1}imp_total ~{&FP2}imp_total ~{&FP3}~
 ~{&FP1}imp_retibr ~{&FP2}imp_retibr ~{&FP3}~
 ~{&FP1}cdg_tiporetgan ~{&FP2}cdg_tiporetgan ~{&FP3}~
 ~{&FP1}cdg_tiporetibr ~{&FP2}cdg_tiporetibr ~{&FP3}~
 ~{&FP1}cdg_tiporetiva ~{&FP2}cdg_tiporetiva ~{&FP3}~
 ~{&FP1}imp_retiva ~{&FP2}imp_retiva ~{&FP3}~
 ~{&FP1}cdg_tiporetsus ~{&FP2}cdg_tiporetsus ~{&FP3}~
 ~{&FP1}fecha_alta ~{&FP2}fecha_alta ~{&FP3}~
 ~{&FP1}fecha_emision ~{&FP2}fecha_emision ~{&FP3}~
 ~{&FP1}fecha_vencimiento ~{&FP2}fecha_vencimiento ~{&FP3}~
 ~{&FP1}fecha_programada ~{&FP2}fecha_programada ~{&FP3}~
 ~{&FP1}imp_programado ~{&FP2}imp_programado ~{&FP3}~
 ~{&FP1}leyenda ~{&FP2}leyenda ~{&FP3}~
 ~{&FP1}usuario-sel ~{&FP2}usuario-sel ~{&FP3}
&Scoped-define OPEN-QUERY-Dialog-Frame OPEN QUERY Dialog-Frame FOR EACH Cta_cte_prv SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-Dialog-Frame Cta_cte_prv
&Scoped-define FIRST-TABLE-IN-QUERY-Dialog-Frame Cta_cte_prv


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Cta_cte_prv.tip_comprob ~
Cta_cte_prv.prf_comprob Cta_cte_prv.nro_comprob Cta_cte_prv.nro_vencimiento ~
Cta_cte_prv.mes Cta_cte_prv.ano Cta_cte_prv.cdg_empresa ~
Cta_cte_prv.cdg_imputacion Cta_cte_prv.nro_moneda Cta_cte_prv.cambio ~
Cta_cte_prv.credito Cta_cte_prv.debito Cta_cte_prv.liberada ~
Cta_cte_prv.imp_neto Cta_cte_prv.imp_iva Cta_cte_prv.imp_total ~
Cta_cte_prv.imp_retibr Cta_cte_prv.cdg_tiporetgan ~
Cta_cte_prv.cdg_tiporetibr Cta_cte_prv.cdg_tiporetiva ~
Cta_cte_prv.imp_retiva Cta_cte_prv.cdg_tiporetsus Cta_cte_prv.fecha_alta ~
Cta_cte_prv.fecha_emision Cta_cte_prv.fecha_vencimiento ~
Cta_cte_prv.fecha_programada Cta_cte_prv.imp_programado ~
Cta_cte_prv.programada Cta_cte_prv.leyenda Cta_cte_prv.usuario-sel 
&Scoped-define FIELD-PAIRS~
 ~{&FP1}tip_comprob ~{&FP2}tip_comprob ~{&FP3}~
 ~{&FP1}prf_comprob ~{&FP2}prf_comprob ~{&FP3}~
 ~{&FP1}nro_comprob ~{&FP2}nro_comprob ~{&FP3}~
 ~{&FP1}nro_vencimiento ~{&FP2}nro_vencimiento ~{&FP3}~
 ~{&FP1}mes ~{&FP2}mes ~{&FP3}~
 ~{&FP1}ano ~{&FP2}ano ~{&FP3}~
 ~{&FP1}cdg_empresa ~{&FP2}cdg_empresa ~{&FP3}~
 ~{&FP1}cdg_imputacion ~{&FP2}cdg_imputacion ~{&FP3}~
 ~{&FP1}nro_moneda ~{&FP2}nro_moneda ~{&FP3}~
 ~{&FP1}cambio ~{&FP2}cambio ~{&FP3}~
 ~{&FP1}credito ~{&FP2}credito ~{&FP3}~
 ~{&FP1}debito ~{&FP2}debito ~{&FP3}~
 ~{&FP1}imp_neto ~{&FP2}imp_neto ~{&FP3}~
 ~{&FP1}imp_iva ~{&FP2}imp_iva ~{&FP3}~
 ~{&FP1}imp_total ~{&FP2}imp_total ~{&FP3}~
 ~{&FP1}imp_retibr ~{&FP2}imp_retibr ~{&FP3}~
 ~{&FP1}cdg_tiporetgan ~{&FP2}cdg_tiporetgan ~{&FP3}~
 ~{&FP1}cdg_tiporetibr ~{&FP2}cdg_tiporetibr ~{&FP3}~
 ~{&FP1}cdg_tiporetiva ~{&FP2}cdg_tiporetiva ~{&FP3}~
 ~{&FP1}imp_retiva ~{&FP2}imp_retiva ~{&FP3}~
 ~{&FP1}cdg_tiporetsus ~{&FP2}cdg_tiporetsus ~{&FP3}~
 ~{&FP1}fecha_alta ~{&FP2}fecha_alta ~{&FP3}~
 ~{&FP1}fecha_emision ~{&FP2}fecha_emision ~{&FP3}~
 ~{&FP1}fecha_vencimiento ~{&FP2}fecha_vencimiento ~{&FP3}~
 ~{&FP1}fecha_programada ~{&FP2}fecha_programada ~{&FP3}~
 ~{&FP1}imp_programado ~{&FP2}imp_programado ~{&FP3}~
 ~{&FP1}leyenda ~{&FP2}leyenda ~{&FP3}~
 ~{&FP1}usuario-sel ~{&FP2}usuario-sel ~{&FP3}
&Scoped-define ENABLED-TABLES Cta_cte_prv
&Scoped-define FIRST-ENABLED-TABLE Cta_cte_prv
&Scoped-Define ENABLED-OBJECTS RECT-7 Btn_OK Btn_Cancel 
&Scoped-Define DISPLAYED-FIELDS Cta_cte_prv.tip_comprob ~
Cta_cte_prv.prf_comprob Cta_cte_prv.nro_comprob Cta_cte_prv.nro_vencimiento ~
Cta_cte_prv.mes Cta_cte_prv.ano Cta_cte_prv.cdg_empresa ~
Cta_cte_prv.cdg_imputacion Cta_cte_prv.nro_moneda Cta_cte_prv.cambio ~
Cta_cte_prv.credito Cta_cte_prv.debito Cta_cte_prv.liberada ~
Cta_cte_prv.imp_neto Cta_cte_prv.imp_iva Cta_cte_prv.imp_total ~
Cta_cte_prv.imp_retibr Cta_cte_prv.cdg_tiporetgan ~
Cta_cte_prv.cdg_tiporetibr Cta_cte_prv.cdg_tiporetiva ~
Cta_cte_prv.imp_retiva Cta_cte_prv.cdg_tiporetsus Cta_cte_prv.fecha_alta ~
Cta_cte_prv.fecha_emision Cta_cte_prv.fecha_vencimiento ~
Cta_cte_prv.fecha_programada Cta_cte_prv.imp_programado ~
Cta_cte_prv.programada Cta_cte_prv.leyenda Cta_cte_prv.usuario-sel 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 17 BY 1.15
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 17 BY 1.15
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 112 BY 12.12.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY Dialog-Frame FOR 
      Cta_cte_prv SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     Cta_cte_prv.tip_comprob AT ROW 1.81 COL 16 COLON-ALIGNED
          LABEL "Comprobante"
          VIEW-AS FILL-IN NATIVE 
          SIZE 7.72 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_prv.prf_comprob AT ROW 1.81 COL 25 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 6.29 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_prv.nro_comprob AT ROW 1.81 COL 32 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 10.86 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_prv.nro_vencimiento AT ROW 1.81 COL 44 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 5.14 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_prv.mes AT ROW 1.81 COL 61 COLON-ALIGNED
          LABEL "Período"
          VIEW-AS FILL-IN NATIVE 
          SIZE 5 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_prv.ano AT ROW 1.81 COL 69 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 9 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_prv.cdg_empresa AT ROW 1.81 COL 93 COLON-ALIGNED
          LABEL "Empresa"
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_prv.cdg_imputacion AT ROW 2.88 COL 16 COLON-ALIGNED
          LABEL "Imputación"
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_prv.nro_moneda AT ROW 2.88 COL 61 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_prv.cambio AT ROW 2.88 COL 93 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_prv.credito AT ROW 3.96 COL 16 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_prv.debito AT ROW 3.96 COL 61 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_prv.liberada AT ROW 3.96 COL 95
          LABEL "Liberada"
          VIEW-AS TOGGLE-BOX
          SIZE 11 BY .77
     Cta_cte_prv.imp_neto AT ROW 5.04 COL 16 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_prv.imp_iva AT ROW 5.04 COL 61 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_prv.imp_total AT ROW 5.04 COL 93 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_prv.imp_retibr AT ROW 6.12 COL 61 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_prv.cdg_tiporetgan AT ROW 6.12 COL 93 COLON-ALIGNED
          LABEL "Ganancias"
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_prv.cdg_tiporetibr AT ROW 6.19 COL 16 COLON-ALIGNED
          LABEL "Ing.Brutos"
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_prv.cdg_tiporetiva AT ROW 7.19 COL 16 COLON-ALIGNED
          LABEL "I.V.A."
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY .81
          BGCOLOR 15 FGCOLOR 9 
.
/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME Dialog-Frame
     Cta_cte_prv.imp_retiva AT ROW 7.19 COL 61 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_prv.cdg_tiporetsus AT ROW 7.19 COL 93 COLON-ALIGNED
          LABEL "SUSS"
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_prv.fecha_alta AT ROW 8.27 COL 16 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_prv.fecha_emision AT ROW 8.27 COL 61 COLON-ALIGNED
          LABEL "Emisión"
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_prv.fecha_vencimiento AT ROW 8.27 COL 93 COLON-ALIGNED
          LABEL "Vencimiento"
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_prv.fecha_programada AT ROW 9.35 COL 16 COLON-ALIGNED
          LABEL "Programación"
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_prv.imp_programado AT ROW 9.35 COL 61 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte_prv.programada AT ROW 9.35 COL 95
          VIEW-AS TOGGLE-BOX
          SIZE 17 BY .77
     Cta_cte_prv.leyenda AT ROW 10.42 COL 16 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 62 BY .81
          BGCOLOR 15 FGCOLOR 9 
     /*Cta_cte_prv.usuario-sel AT ROW 10.42 COL 93 COLON-ALIGNED
          LABEL "Seleccionó"
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY .81
          BGCOLOR 15 FGCOLOR 9 */
     Btn_OK AT ROW 11.77 COL 18
     Btn_Cancel AT ROW 11.77 COL 95
     RECT-7 AT ROW 1.27 COL 3
     SPACE(2.85) SKIP(0.52)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Edita un registro de cuenta corriente de proveedores"
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: DIALOG-BOX
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS


/* ***************  Runtime Attributes and UIB Settings  ************** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
                                                                        */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN Cta_cte_prv.cdg_empresa IN FRAME Dialog-Frame
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cta_cte_prv.cdg_imputacion IN FRAME Dialog-Frame
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cta_cte_prv.cdg_tiporetgan IN FRAME Dialog-Frame
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cta_cte_prv.cdg_tiporetibr IN FRAME Dialog-Frame
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cta_cte_prv.cdg_tiporetiva IN FRAME Dialog-Frame
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cta_cte_prv.cdg_tiporetsus IN FRAME Dialog-Frame
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cta_cte_prv.fecha_emision IN FRAME Dialog-Frame
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cta_cte_prv.fecha_programada IN FRAME Dialog-Frame
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cta_cte_prv.fecha_vencimiento IN FRAME Dialog-Frame
   EXP-LABEL                                                            */
/* SETTINGS FOR TOGGLE-BOX Cta_cte_prv.liberada IN FRAME Dialog-Frame
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cta_cte_prv.mes IN FRAME Dialog-Frame
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cta_cte_prv.tip_comprob IN FRAME Dialog-Frame
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cta_cte_prv.usuario-sel IN FRAME Dialog-Frame
   EXP-LABEL                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX Dialog-Frame
/* Query rebuild information for DIALOG-BOX Dialog-Frame
     _TblList          = "sic.Cta_cte_prv"
     _Options          = "SHARE-LOCK"
     _Query            is NOT OPENED
*/  /* DIALOG-BOX Dialog-Frame */
&ANALYZE-RESUME

 




/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Edita un registro de cuenta corriente de proveedores */
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
        Cta_cte_prv.ano 
        Cta_cte_prv.cambio 
        Cta_cte_prv.cdg_empresa 
        Cta_cte_prv.cdg_imputacion 
        Cta_cte_prv.cdg_tiporetgan 
        Cta_cte_prv.cdg_tiporetibr 
        Cta_cte_prv.cdg_tiporetiva 
        Cta_cte_prv.cdg_tiporetsus 
        Cta_cte_prv.credito 
        Cta_cte_prv.debito 
        Cta_cte_prv.fecha_alta 
        Cta_cte_prv.fecha_emision 
        Cta_cte_prv.fecha_programada 
        Cta_cte_prv.fecha_vencimiento 
        Cta_cte_prv.imp_iva 
        Cta_cte_prv.imp_neto 
        Cta_cte_prv.imp_programado 
        Cta_cte_prv.imp_retibr 
        Cta_cte_prv.imp_retiva 
        Cta_cte_prv.imp_total 
        Cta_cte_prv.leyenda 
        Cta_cte_prv.liberada 
        Cta_cte_prv.mes 
        Cta_cte_prv.nro_comprob 
        Cta_cte_prv.nro_moneda 
        Cta_cte_prv.nro_vencimiento 
        Cta_cte_prv.prf_comprob 
        Cta_cte_prv.programada 
        Cta_cte_prv.tip_comprob 
        /*Cta_cte_prv.usuario-sel*/ .
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
  FIND Opg_detalle WHERE ROWID(Opg_detalle) = rid_detalle EXCLUSIVE-LOCK.
  RUN enable_UI.
  WAIT-FOR GO OF FRAME {&FRAME-NAME}.
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
  IF AVAILABLE Cta_cte_prv THEN 
    DISPLAY Cta_cte_prv.tip_comprob Cta_cte_prv.prf_comprob 
          Cta_cte_prv.nro_comprob Cta_cte_prv.nro_vencimiento Cta_cte_prv.mes 
          Cta_cte_prv.ano Cta_cte_prv.cdg_empresa Cta_cte_prv.cdg_imputacion 
          Cta_cte_prv.nro_moneda Cta_cte_prv.cambio Cta_cte_prv.credito 
          Cta_cte_prv.debito Cta_cte_prv.liberada Cta_cte_prv.imp_neto 
          Cta_cte_prv.imp_iva Cta_cte_prv.imp_total Cta_cte_prv.imp_retibr 
          Cta_cte_prv.cdg_tiporetgan Cta_cte_prv.cdg_tiporetibr 
          Cta_cte_prv.cdg_tiporetiva Cta_cte_prv.imp_retiva 
          Cta_cte_prv.cdg_tiporetsus Cta_cte_prv.fecha_alta 
          Cta_cte_prv.fecha_emision Cta_cte_prv.fecha_vencimiento 
          Cta_cte_prv.fecha_programada Cta_cte_prv.imp_programado 
          Cta_cte_prv.programada Cta_cte_prv.leyenda /*Cta_cte_prv.usuario-sel*/ 
      WITH FRAME Dialog-Frame.
  ENABLE RECT-7 Cta_cte_prv.tip_comprob Cta_cte_prv.prf_comprob 
         Cta_cte_prv.nro_comprob Cta_cte_prv.nro_vencimiento Cta_cte_prv.mes 
         Cta_cte_prv.ano Cta_cte_prv.cdg_empresa Cta_cte_prv.cdg_imputacion 
         Cta_cte_prv.nro_moneda Cta_cte_prv.cambio Cta_cte_prv.credito 
         Cta_cte_prv.debito Cta_cte_prv.liberada Cta_cte_prv.imp_neto 
         Cta_cte_prv.imp_iva Cta_cte_prv.imp_total Cta_cte_prv.imp_retibr 
         Cta_cte_prv.cdg_tiporetgan Cta_cte_prv.cdg_tiporetibr 
         Cta_cte_prv.cdg_tiporetiva Cta_cte_prv.imp_retiva 
         Cta_cte_prv.cdg_tiporetsus Cta_cte_prv.fecha_alta 
         Cta_cte_prv.fecha_emision Cta_cte_prv.fecha_vencimiento 
         Cta_cte_prv.fecha_programada Cta_cte_prv.imp_programado 
         Cta_cte_prv.programada Cta_cte_prv.leyenda /*Cta_cte_prv.usuario-sel */
         Btn_OK Btn_Cancel 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


