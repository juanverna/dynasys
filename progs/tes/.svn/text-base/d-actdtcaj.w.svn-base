&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
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

/* Local Variable Definitions ---                                       */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartDialog

&Scoped-define ADM-CONTAINER DIALOG-BOX

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME D-Dialog

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Rubro Caj_detalle Valor Banco Cheque ~
Cuenta_bancaria

/* Definitions for DIALOG-BOX D-Dialog                                  */
&Scoped-define FIELDS-IN-QUERY-D-Dialog Rubro.cdg_rubro Rubro.nombre ~
Caj_detalle.observacion Caj_detalle.cambio Caj_detalle.tipo_mov ~
Caj_detalle.importe Caj_detalle.divisas Valor.cdg_banco ~
Valor.cdg_sucurbanco Banco.abrevia Cuenta_bancaria.cdg_cuenta_ban ~
Cuenta_bancaria.denominacion_cta Valor.numero_cheque Cheque.numero_cheque ~
Valor.fecha_emision Cheque.fecha_emision Valor.dias_clearing ~
Cheque.dias_clearing Valor.fecha_deposito Cheque.fecha_deposito ~
Valor.fecha_acredita Cheque.fecha_acredita Valor.estado 
&Scoped-define ENABLED-FIELDS-IN-QUERY-D-Dialog Rubro.cdg_rubro ~
Rubro.nombre Caj_detalle.observacion Caj_detalle.cambio ~
Caj_detalle.tipo_mov Caj_detalle.importe Caj_detalle.divisas ~
Valor.cdg_banco Valor.cdg_sucurbanco Banco.abrevia ~
Cuenta_bancaria.cdg_cuenta_ban Cuenta_bancaria.denominacion_cta ~
Valor.numero_cheque Cheque.numero_cheque Valor.fecha_emision ~
Cheque.fecha_emision Valor.dias_clearing Cheque.dias_clearing ~
Valor.fecha_deposito Cheque.fecha_deposito Valor.fecha_acredita ~
Cheque.fecha_acredita Valor.estado 
&Scoped-define ENABLED-TABLES-IN-QUERY-D-Dialog Rubro Caj_detalle Valor ~
Banco Cuenta_bancaria Cheque
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-D-Dialog Rubro
&Scoped-define SECOND-ENABLED-TABLE-IN-QUERY-D-Dialog Caj_detalle
&Scoped-define THIRD-ENABLED-TABLE-IN-QUERY-D-Dialog Valor

&Scoped-define FIELD-PAIRS-IN-QUERY-D-Dialog~
 ~{&FP1}cdg_rubro ~{&FP2}cdg_rubro ~{&FP3}~
 ~{&FP1}nombre ~{&FP2}nombre ~{&FP3}~
 ~{&FP1}observacion ~{&FP2}observacion ~{&FP3}~
 ~{&FP1}cambio ~{&FP2}cambio ~{&FP3}~
 ~{&FP1}importe ~{&FP2}importe ~{&FP3}~
 ~{&FP1}divisas ~{&FP2}divisas ~{&FP3}~
 ~{&FP1}cdg_banco ~{&FP2}cdg_banco ~{&FP3}~
 ~{&FP1}cdg_sucurbanco ~{&FP2}cdg_sucurbanco ~{&FP3}~
 ~{&FP1}abrevia ~{&FP2}abrevia ~{&FP3}~
 ~{&FP1}cdg_cuenta_ban ~{&FP2}cdg_cuenta_ban ~{&FP3}~
 ~{&FP1}denominacion_cta ~{&FP2}denominacion_cta ~{&FP3}~
 ~{&FP1}numero_cheque ~{&FP2}numero_cheque ~{&FP3}~
 ~{&FP1}numero_cheque ~{&FP2}numero_cheque ~{&FP3}~
 ~{&FP1}fecha_emision ~{&FP2}fecha_emision ~{&FP3}~
 ~{&FP1}fecha_emision ~{&FP2}fecha_emision ~{&FP3}~
 ~{&FP1}dias_clearing ~{&FP2}dias_clearing ~{&FP3}~
 ~{&FP1}dias_clearing ~{&FP2}dias_clearing ~{&FP3}~
 ~{&FP1}fecha_deposito ~{&FP2}fecha_deposito ~{&FP3}~
 ~{&FP1}fecha_deposito ~{&FP2}fecha_deposito ~{&FP3}~
 ~{&FP1}fecha_acredita ~{&FP2}fecha_acredita ~{&FP3}~
 ~{&FP1}fecha_acredita ~{&FP2}fecha_acredita ~{&FP3}~
 ~{&FP1}estado ~{&FP2}estado ~{&FP3}
&Scoped-define OPEN-QUERY-D-Dialog OPEN QUERY D-Dialog FOR EACH Rubro SHARE-LOCK, ~
      EACH Caj_detalle OF Rubro SHARE-LOCK, ~
      EACH Valor OF Caj_detalle SHARE-LOCK, ~
      EACH Banco OF Rubro SHARE-LOCK, ~
      EACH Cheque OF Caj_detalle SHARE-LOCK, ~
      EACH Cuenta_bancaria OF Caj_detalle SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-D-Dialog Rubro Caj_detalle Valor Banco ~
Cheque Cuenta_bancaria
&Scoped-define FIRST-TABLE-IN-QUERY-D-Dialog Rubro


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Rubro.cdg_rubro Rubro.nombre ~
Caj_detalle.observacion Caj_detalle.cambio Caj_detalle.tipo_mov ~
Caj_detalle.importe Caj_detalle.divisas Valor.cdg_banco ~
Valor.cdg_sucurbanco Banco.abrevia Cuenta_bancaria.cdg_cuenta_ban ~
Cuenta_bancaria.denominacion_cta Valor.numero_cheque Cheque.numero_cheque ~
Valor.fecha_emision Cheque.fecha_emision Valor.dias_clearing ~
Cheque.dias_clearing Valor.fecha_deposito Cheque.fecha_deposito ~
Valor.fecha_acredita Cheque.fecha_acredita Valor.estado 
&Scoped-define FIELD-PAIRS~
 ~{&FP1}cdg_rubro ~{&FP2}cdg_rubro ~{&FP3}~
 ~{&FP1}nombre ~{&FP2}nombre ~{&FP3}~
 ~{&FP1}observacion ~{&FP2}observacion ~{&FP3}~
 ~{&FP1}cambio ~{&FP2}cambio ~{&FP3}~
 ~{&FP1}importe ~{&FP2}importe ~{&FP3}~
 ~{&FP1}divisas ~{&FP2}divisas ~{&FP3}~
 ~{&FP1}cdg_banco ~{&FP2}cdg_banco ~{&FP3}~
 ~{&FP1}cdg_sucurbanco ~{&FP2}cdg_sucurbanco ~{&FP3}~
 ~{&FP1}abrevia ~{&FP2}abrevia ~{&FP3}~
 ~{&FP1}cdg_cuenta_ban ~{&FP2}cdg_cuenta_ban ~{&FP3}~
 ~{&FP1}denominacion_cta ~{&FP2}denominacion_cta ~{&FP3}~
 ~{&FP1}numero_cheque ~{&FP2}numero_cheque ~{&FP3}~
 ~{&FP1}numero_cheque ~{&FP2}numero_cheque ~{&FP3}~
 ~{&FP1}fecha_emision ~{&FP2}fecha_emision ~{&FP3}~
 ~{&FP1}fecha_emision ~{&FP2}fecha_emision ~{&FP3}~
 ~{&FP1}dias_clearing ~{&FP2}dias_clearing ~{&FP3}~
 ~{&FP1}dias_clearing ~{&FP2}dias_clearing ~{&FP3}~
 ~{&FP1}fecha_deposito ~{&FP2}fecha_deposito ~{&FP3}~
 ~{&FP1}fecha_deposito ~{&FP2}fecha_deposito ~{&FP3}~
 ~{&FP1}fecha_acredita ~{&FP2}fecha_acredita ~{&FP3}~
 ~{&FP1}fecha_acredita ~{&FP2}fecha_acredita ~{&FP3}~
 ~{&FP1}estado ~{&FP2}estado ~{&FP3}
&Scoped-define ENABLED-TABLES Rubro Caj_detalle Valor Banco Cuenta_bancaria ~
Cheque
&Scoped-define FIRST-ENABLED-TABLE Rubro
&Scoped-define SECOND-ENABLED-TABLE Caj_detalle
&Scoped-define THIRD-ENABLED-TABLE Valor
&Scoped-Define ENABLED-OBJECTS RECT-6 RECT-5 RECT-4 RECT-3 RECT-2 RECT-1 ~
btn_grabar btn_cancel btn_salir 
&Scoped-Define DISPLAYED-FIELDS Rubro.cdg_rubro Rubro.nombre ~
Caj_detalle.observacion Caj_detalle.cambio Caj_detalle.tipo_mov ~
Caj_detalle.importe Caj_detalle.divisas Valor.cdg_banco ~
Valor.cdg_sucurbanco Banco.abrevia Cuenta_bancaria.cdg_cuenta_ban ~
Cuenta_bancaria.denominacion_cta Valor.numero_cheque Cheque.numero_cheque ~
Valor.fecha_emision Cheque.fecha_emision Valor.dias_clearing ~
Cheque.dias_clearing Valor.fecha_deposito Cheque.fecha_deposito ~
Valor.fecha_acredita Cheque.fecha_acredita Valor.estado 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _XFTR "SmartDialogCues" D-Dialog _INLINE
/* Actions: adecomm/_so-cue.w ? adecomm/_so-cued.p ? adecomm/_so-cuew.p */
/* SmartDialog,uib,49267
Destroy on next read */
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON btn_cancel 
     LABEL "&Cancelar" 
     SIZE 25 BY 1.12.

DEFINE BUTTON btn_grabar 
     LABEL "&Grabar" 
     SIZE 25 BY 1.12.

DEFINE BUTTON btn_salir 
     LABEL "&Salir" 
     SIZE 25 BY 1.12.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 86 BY 2.42.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 43 BY 9.15.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 43 BY 2.96.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 43 BY 9.15.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 43 BY 2.96.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 86 BY 2.15.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY D-Dialog FOR 
      Rubro, 
      Caj_detalle, 
      Valor, 
      Banco, 
      Cheque, 
      Cuenta_bancaria SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME D-Dialog
     Rubro.cdg_rubro AT ROW 1.54 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR 7 FGCOLOR 15 
     Rubro.nombre AT ROW 1.54 COL 28 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 57 BY .81
          BGCOLOR 7 FGCOLOR 15 
     Caj_detalle.observacion AT ROW 2.62 COL 12 COLON-ALIGNED
          LABEL "Obs."
          VIEW-AS FILL-IN 
          SIZE 73 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Caj_detalle.cambio AT ROW 5.04 COL 56 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Caj_detalle.tipo_mov AT ROW 5.31 COL 36 NO-LABEL
          VIEW-AS RADIO-SET VERTICAL
          RADIO-BUTTONS 
                    "Ing.", "I",
"Egr.", "E"
          SIZE 8 BY 1.62
     Caj_detalle.importe AT ROW 5.58 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Caj_detalle.divisas AT ROW 6.12 COL 56 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Valor.cdg_banco AT ROW 8.54 COL 12 COLON-ALIGNED
          LABEL "Banco"
          VIEW-AS FILL-IN 
          SIZE 7 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Valor.cdg_sucurbanco AT ROW 8.54 COL 20 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 6.72 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Banco.abrevia AT ROW 8.54 COL 28 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR 7 FGCOLOR 15 
     Cuenta_bancaria.cdg_cuenta_ban AT ROW 8.54 COL 56 COLON-ALIGNED
          LABEL "Cuenta"
          VIEW-AS FILL-IN 
          SIZE 7 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cuenta_bancaria.denominacion_cta AT ROW 8.54 COL 64 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 22 BY .81
          BGCOLOR 7 FGCOLOR 15 
     Valor.numero_cheque AT ROW 9.62 COL 12 COLON-ALIGNED
          LABEL "N.Cheque"
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cheque.numero_cheque AT ROW 9.62 COL 56 COLON-ALIGNED
          LABEL "N.Cheque"
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Valor.fecha_emision AT ROW 10.69 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cheque.fecha_emision AT ROW 10.69 COL 56 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Valor.dias_clearing AT ROW 11.77 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cheque.dias_clearing AT ROW 11.77 COL 56 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Valor.fecha_deposito AT ROW 12.85 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cheque.fecha_deposito AT ROW 12.85 COL 56 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Valor.fecha_acredita AT ROW 13.92 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR 15 FGCOLOR 9 
.
/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME D-Dialog
     Cheque.fecha_acredita AT ROW 13.92 COL 56 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Valor.estado AT ROW 15 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR 7 FGCOLOR 15 
     btn_grabar AT ROW 17.15 COL 5
     btn_cancel AT ROW 17.15 COL 33
     btn_salir AT ROW 17.15 COL 62
     "   Importe" VIEW-AS TEXT
          SIZE 10 BY .62 AT ROW 3.96 COL 17
     "   Valores de Cambio" VIEW-AS TEXT
          SIZE 16 BY .62 AT ROW 3.96 COL 60
     "   Cheques" VIEW-AS TEXT
          SIZE 10 BY .62 AT ROW 7.19 COL 63
     "   Valores" VIEW-AS TEXT
          SIZE 10 BY .62 AT ROW 7.19 COL 18
     RECT-6 AT ROW 16.62 COL 3
     RECT-5 AT ROW 4.23 COL 46
     RECT-4 AT ROW 7.46 COL 46
     RECT-3 AT ROW 4.23 COL 3
     RECT-2 AT ROW 7.46 COL 3
     RECT-1 AT ROW 1.27 COL 3
     SPACE(2.13) SKIP(15.65)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         FONT 4
         TITLE "Indique valores y sus datos".


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartDialog
   Allow: Basic,Browse,DB-Fields,Query,Smart
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS


/* ***************  Runtime Attributes and UIB Settings  ************** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX D-Dialog
                                                                        */
ASSIGN 
       FRAME D-Dialog:SCROLLABLE       = FALSE
       FRAME D-Dialog:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN Valor.cdg_banco IN FRAME D-Dialog
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cuenta_bancaria.cdg_cuenta_ban IN FRAME D-Dialog
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Valor.numero_cheque IN FRAME D-Dialog
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cheque.numero_cheque IN FRAME D-Dialog
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Caj_detalle.observacion IN FRAME D-Dialog
   EXP-LABEL                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX D-Dialog
/* Query rebuild information for DIALOG-BOX D-Dialog
     _TblList          = "sic.Rubro,sic.Caj_detalle OF sic.Rubro,sic.Valor OF sic.Caj_detalle,sic.Banco OF sic.Rubro,sic.Cheque OF sic.Caj_detalle,sic.Cuenta_bancaria OF sic.Caj_detalle"
     _Options          = "SHARE-LOCK"
     _Query            is NOT OPENED
*/  /* DIALOG-BOX D-Dialog */
&ANALYZE-RESUME

 


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB D-Dialog 
/* ************************* Included-Libraries *********************** */

{src/adm/method/containr.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME D-Dialog
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL D-Dialog D-Dialog
ON WINDOW-CLOSE OF FRAME D-Dialog /* Indique valores y sus datos */
DO:  
  /* Add Trigger to equate WINDOW-CLOSE to END-ERROR. */
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK D-Dialog 


/* ***************************  Main Block  *************************** */

{src/adm/template/dialogmn.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-create-objects D-Dialog _ADM-CREATE-OBJECTS
PROCEDURE adm-create-objects :
/*------------------------------------------------------------------------------
  Purpose:     Create handles for all SmartObjects used in this procedure.
               After SmartObjects are initialized, then SmartLinks are added.
  Parameters:  <none>
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available D-Dialog _ADM-ROW-AVAILABLE
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI D-Dialog _DEFAULT-DISABLE
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI D-Dialog _DEFAULT-ENABLE
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
  IF AVAILABLE Banco THEN 
    DISPLAY Banco.abrevia 
      WITH FRAME D-Dialog.
  IF AVAILABLE Caj_detalle THEN 
    DISPLAY Caj_detalle.observacion Caj_detalle.cambio Caj_detalle.tipo_mov 
          Caj_detalle.importe Caj_detalle.divisas 
      WITH FRAME D-Dialog.
  IF AVAILABLE Cheque THEN 
    DISPLAY Cheque.numero_cheque Cheque.fecha_emision Cheque.dias_clearing 
          Cheque.fecha_deposito Cheque.fecha_acredita 
      WITH FRAME D-Dialog.
  IF AVAILABLE Cuenta_bancaria THEN 
    DISPLAY Cuenta_bancaria.cdg_cuenta_ban Cuenta_bancaria.denominacion_cta 
      WITH FRAME D-Dialog.
  IF AVAILABLE Rubro THEN 
    DISPLAY Rubro.cdg_rubro Rubro.nombre 
      WITH FRAME D-Dialog.
  IF AVAILABLE Valor THEN 
    DISPLAY Valor.cdg_banco Valor.cdg_sucurbanco Valor.numero_cheque 
          Valor.fecha_emision Valor.dias_clearing Valor.fecha_deposito 
          Valor.fecha_acredita Valor.estado 
      WITH FRAME D-Dialog.
  ENABLE RECT-6 RECT-5 RECT-4 RECT-3 RECT-2 RECT-1 Rubro.cdg_rubro Rubro.nombre 
         Caj_detalle.observacion Caj_detalle.cambio Caj_detalle.tipo_mov 
         Caj_detalle.importe Caj_detalle.divisas Valor.cdg_banco 
         Valor.cdg_sucurbanco Banco.abrevia Cuenta_bancaria.cdg_cuenta_ban 
         Cuenta_bancaria.denominacion_cta Valor.numero_cheque 
         Cheque.numero_cheque Valor.fecha_emision Cheque.fecha_emision 
         Valor.dias_clearing Cheque.dias_clearing Valor.fecha_deposito 
         Cheque.fecha_deposito Valor.fecha_acredita Cheque.fecha_acredita 
         Valor.estado btn_grabar btn_cancel btn_salir 
      WITH FRAME D-Dialog.
  VIEW FRAME D-Dialog.
  {&OPEN-BROWSERS-IN-QUERY-D-Dialog}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records D-Dialog _ADM-SEND-RECORDS
PROCEDURE send-records :
/*------------------------------------------------------------------------------
  Purpose:     Send record ROWID's for all tables used by
               this file.
  Parameters:  see template/snd-head.i
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.               */
  {src/adm/template/snd-head.i}

  /* For each requested table, put it's ROWID in the output list.      */
  {src/adm/template/snd-list.i "Rubro"}
  {src/adm/template/snd-list.i "Caj_detalle"}
  {src/adm/template/snd-list.i "Valor"}
  {src/adm/template/snd-list.i "Banco"}
  {src/adm/template/snd-list.i "Cheque"}
  {src/adm/template/snd-list.i "Cuenta_bancaria"}

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


