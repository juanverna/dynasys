&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS W-Win 
/*------------------------------------------------------------------------

  File: 

  Description: from cntnrwin.w - ADM SmartWindow Template

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  History: 
          
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
{nrorelea.i}
{parlocales.i}

DEFINE TEMP-TABLE T-Parametros_reporte
    FIELD nombre_parametro AS CHARACTER
    FIELD valor_parametro  AS CHARACTER.

{tiempo.i}
FUNCTION facturado RETURNS DECIMAL ( rr AS INT ):
    DEFINE VAR tt AS DECIMAL NO-UNDO.
    tt = 0.
    FOR EACH fac_header WHERE fac_header.nro_contrato = rr AND fac_header.anulado = NO NO-LOCK:
    tt = tt + fac_header.imp_total.
    END.
    RETURN tt.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartWindow
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER WINDOW

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME F-Main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS Bstart 
&Scoped-Define DISPLAYED-OBJECTS v-estado 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR W-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of handles for SmartObjects                              */
DEFINE VARIABLE h_v-rng-fechas AS HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON Bstart 
     LABEL "Generar Consulta" 
     SIZE 23 BY 1.43.

DEFINE VARIABLE v-estado AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 100 BY 1
     BGCOLOR 1 FGCOLOR 14 FONT 6 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Bstart AT ROW 5.05 COL 40 WIDGET-ID 8
     v-estado AT ROW 6.71 COL 1 COLON-ALIGNED NO-LABEL
     "  Rango de fechas de los movimientos:" VIEW-AS TEXT
          SIZE 100 BY 1 AT ROW 1.24 COL 4
          BGCOLOR 5 FGCOLOR 15 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 106.2 BY 7.05.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartWindow
   Allow: Basic,Browse,DB-Fields,Query,Smart,Window
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW W-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Primera factura de contrato RT"
         HEIGHT             = 7.05
         WIDTH              = 106.2
         MAX-HEIGHT         = 27.67
         MAX-WIDTH          = 160
         VIRTUAL-HEIGHT     = 27.67
         VIRTUAL-WIDTH      = 160
         RESIZE             = no
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB W-Win 
/* ************************* Included-Libraries *********************** */

{crystal_dyna.p}
{winprocs.i}
{src/adm/method/containr.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW W-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME F-Main
   FRAME-NAME                                                           */
/* SETTINGS FOR FILL-IN v-estado IN FRAME F-Main
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(W-Win)
THEN W-Win:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON END-ERROR OF W-Win /* Primera factura de contrato RT */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-CLOSE OF W-Win /* Primera factura de contrato RT */
DO:
  /* This ADM code must be left here in order for the SmartWindow
     and its descendents to terminate properly on exit. */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bstart
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bstart W-Win
ON CHOOSE OF Bstart IN FRAME F-Main /* Generar Consulta */
DO:
  RUN lst-ejecutar.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK W-Win 


/* ***************************  Main Block  *************************** */

/* Include custom  Main Block code for SmartWindows. */
{src/adm/template/windowmn.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-create-objects W-Win  _ADM-CREATE-OBJECTS
PROCEDURE adm-create-objects :
/*------------------------------------------------------------------------------
  Purpose:     Create handles for all SmartObjects used in this procedure.
               After SmartObjects are initialized, then SmartLinks are added.
  Parameters:  <none>
------------------------------------------------------------------------------*/
  DEFINE VARIABLE adm-current-page  AS INTEGER NO-UNDO.

  RUN get-attribute IN THIS-PROCEDURE ('Current-Page':U).
  ASSIGN adm-current-page = INTEGER(RETURN-VALUE).

  CASE adm-current-page: 

    WHEN 0 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-rng-fechas.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-rng-fechas ).
       RUN set-position IN h_v-rng-fechas ( 2.43 , 4.00 ) NO-ERROR.
       /* Size in UIB:  ( 2.43 , 100.00 ) */

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-rng-fechas ,
             Bstart:HANDLE IN FRAME F-Main , 'BEFORE':U ).
    END. /* Page 0 */

  END CASE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available W-Win  _ADM-ROW-AVAILABLE
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI W-Win  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Delete the WINDOW we created */
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(W-Win)
  THEN DELETE WIDGET W-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI W-Win  _DEFAULT-ENABLE
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
  DISPLAY v-estado 
      WITH FRAME F-Main IN WINDOW W-Win.
  ENABLE Bstart 
      WITH FRAME F-Main IN WINDOW W-Win.
  {&OPEN-BROWSERS-IN-QUERY-F-Main}
  VIEW W-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-exit W-Win 
PROCEDURE local-exit :
/* -----------------------------------------------------------
  Purpose:  Starts an "exit" by APPLYing CLOSE event, which starts "destroy".
  Parameters:  <none>
  Notes:    If activated, should APPLY CLOSE, *not* dispatch adm-exit.   
-------------------------------------------------------------*/
   APPLY "CLOSE":U TO THIS-PROCEDURE.
   
   RETURN.
       
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-view W-Win 
PROCEDURE local-view :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'view':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  {setwintit.i "SIC/FAC" "Primera factura de contrato RT"}

  v-estado:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "Ingresando Parametros ...".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE lst-ejecutar W-Win 
PROCEDURE lst-ejecutar :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

 
  DEFINE VARIABLE des_fecha                 AS DATE NO-UNDO.
  DEFINE VARIABLE has_fecha                 AS DATE NO-UNDO.

  DEFINE VARIABLE error_rango               AS LOGICAL NO-UNDO.
  DEFINE VARIABLE error_fecha               AS LOGICAL NO-UNDO.
  DEFINE VARIABLE hay_error                 AS LOGICAL NO-UNDO.
  DEFINE VAR paga AS CHAR NO-UNDO.
  DEFINE BUFFER tfac FOR fac_header.
  hay_error = FALSE.

      RUN dar_rango IN h_v-rng-fechas    ( OUTPUT des_fecha, 
                                           OUTPUT has_fecha, 
                                           OUTPUT error_rango ).
      IF error_rango 
      THEN DO:
           RUN ver-error-rango ( "Fechas" ).
           hay_error = error_rango.
      END.     

  IF NOT hay_error
  THEN DO:
       RUN setear-botones ( NO ).     
       OUTPUT TO c:\temp\primerfacRT.csv.
        EXPORT DELIMITER ";" "Fecha" "NroContrato" "NroFactura" "ImpTotal" "Periodos" "ImpFactura" "Facturado" "Estado".
        FOR EACH rendicion_hd WHERE fch_rendicion >= des_fecha AND fch_rendicion <= has_fecha AND rendicion_hd.st_tesoreria <> "A" NO-LOCK:
        FOR EACH comprobante_rendicion OF rendicion_hd:
                FIND fac_header WHERE comprobante_rendicion.prf_comprob = fac_header.prf_comprob AND 
                  comprobante_rendicion.tip_comprob = fac_header.tip_comprob AND
                  comprobante_rendicion.nro_comprob = fac_header.nro_comprob and
                  comprobante_rendicion.cdg_empresa = fac_header.cdg_empresa  NO-LOCK NO-ERROR.
                IF NOT AVAILABLE fac_header THEN NEXT.
                FIND contrato_hd WHERE fac_header.nro_contrato = contrato_hd.nro_contrato AND contrato_hd.nro_tipo_evento = 11 AND 
                    contrato_hd.fecha_baja = ? AND
                    contrato_hd.estado = "A" NO-LOCK NO-ERROR.
                IF NOT AVAILABLE contrato_hd THEN NEXT.
                IF CAN-FIND ( first tfac WHERE tfac.nro_contrato = contrato_hd.nro_contrato AND 
                        NOT tfac.anulado AND tfac.fecha < fac_header.fecha  ) THEN NEXT.
                EXPORT DELIMITER ";"  rendicion_hd.fecha contrato_hd.nro_contrato fac_header.tip_comprob + "-" + string( fac_header.prf_comprob) + "-" + string( fac_header.nro_comprob)
                contrato_hd.imp_total cant_periodos fac_header.imp_total facturado( contrato_hd.nro_contrato) contrato_hd.estado.
            END.
        END.
       
       v-estado:SCREEN-VALUE in FRAME {&FRAME-NAME} = "Archivo c:\temp\primerfacRT.csv generado".
       RUN setear-botones ( YES ).        

  END.
       
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records W-Win  _ADM-SEND-RECORDS
PROCEDURE send-records :
/*------------------------------------------------------------------------------
  Purpose:     Send record ROWID's for all tables used by
               this file.
  Parameters:  see template/snd-head.i
------------------------------------------------------------------------------*/

  /* SEND-RECORDS does nothing because there are no External
     Tables specified for this SmartWindow, and there are no
     tables specified in any contained Browse, Query, or Frame. */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE setear-botones W-Win 
PROCEDURE setear-botones :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE INPUT PARAMETER p-estado AS LOGICAL.

    /*
    Btn_Done:SENSITIVE IN FRAME {&FRAME-NAME} = p-estado. 
    btn_ejecutar:SENSITIVE IN FRAME {&FRAME-NAME} = p-estado. 
    btn_imprimir:SENSITIVE IN FRAME {&FRAME-NAME} = p-estado. 
    btn_verlistado:SENSITIVE IN FRAME {&FRAME-NAME} = p-estado.
    */


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE state-changed W-Win 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ver-error-fecha W-Win 
PROCEDURE ver-error-fecha :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAMETER p-nombre AS CHARACTER.
  
  MESSAGE "Hay un error de " p-nombre VIEW-AS ALERT-BOX ERROR
          TITLE "Error de fecha".


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ver-error-rango W-Win 
PROCEDURE ver-error-rango :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER p-nombre AS CHARACTER.
  
  MESSAGE "Hay un error de rango de " p-nombre VIEW-AS ALERT-BOX ERROR
          TITLE "Error de rango".


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

