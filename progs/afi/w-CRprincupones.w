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
{impresoras.i}

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
&Scoped-Define DISPLAYED-OBJECTS v-estado 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD formulario W-Win 
FUNCTION formulario RETURNS CHARACTER
  ( INPUT rid_fac_header AS ROWID )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR W-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of handles for SmartObjects                              */
DEFINE VARIABLE h_p-ejecutar AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-rng-CRCupon AS HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE VARIABLE v-estado AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 100 BY 1
     BGCOLOR 9 FGCOLOR 14 FONT 6 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     v-estado AT ROW 7.91 COL 8 COLON-ALIGNED NO-LABEL
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 116.6 BY 12.52.


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
         TITLE              = "Impresión de Facturas"
         HEIGHT             = 10.86
         WIDTH              = 116.6
         MAX-HEIGHT         = 25.71
         MAX-WIDTH          = 160
         VIRTUAL-HEIGHT     = 25.71
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
ON END-ERROR OF W-Win /* Impresión de Facturas */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-CLOSE OF W-Win /* Impresión de Facturas */
DO:
  /* This ADM code must be left here in order for the SmartWindow
     and its descendents to terminate properly on exit. */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
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
             INPUT  'v-rng-CRCupon.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-rng-CRCupon ).
       RUN set-position IN h_v-rng-CRCupon ( 1.48 , 10.00 ) NO-ERROR.
       /* Size in UIB:  ( 5.95 , 100.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'p-CRejecutarSPPAU.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_p-ejecutar ).
       RUN set-position IN h_p-ejecutar ( 9.33 , 9.00 ) NO-ERROR.
       /* Size in UIB:  ( 2.14 , 103.00 ) */

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-rng-CRCupon ,
             v-estado:HANDLE IN FRAME F-Main , 'BEFORE':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_p-ejecutar ,
             v-estado:HANDLE IN FRAME F-Main , 'AFTER':U ).
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
  VIEW FRAME F-Main IN WINDOW W-Win.
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

  {setwintit.i "SIC/AFI" "Impresión de Recibos"}

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
  DEFINE VARIABLE v-tip_comprob      LIKE fac_header.tip_comprob.
  DEFINE VARIABLE v-prf_comprob      LIKE fac_header.prf_comprob.
  DEFINE VARIABLE v-des_nrocomprob   LIKE fac_header.nro_comprob.
  DEFINE VARIABLE v-has_nrocomprob   LIKE fac_header.nro_comprob.
  DEFINE VAR rdesde AS CHAR NO-UNDO.
  DEFINE VAR rhasta AS CHAR NO-UNDO.

  DEFINE VARIABLE error_rango      AS LOGICAL NO-UNDO.
  DEFINE VARIABLE hay_error        AS LOGICAL NO-UNDO.
  DEFINE VARIABLE ERROR_nro        AS INT NO-UNDO.
  DEFINE VAR cFullPath AS CHAR NO-UNDO.
  DEFINE VAR xFullPath AS CHAR NO-UNDO.
  DEFINE VAR ReportePath AS CHAR NO-UNDO.
  DEFINE VAR exportFileName AS CHAR NO-UNDO.
  DEF VAR xfile AS CHAR NO-UNDO.
  DEFINE VAR timpre AS INT NO-UNDO.
 
  
  {findempresa.i}
      RUN dar_rango IN h_v-rng-CRCupon  ( OUTPUT v-tip_comprob,
                                           OUTPUT v-prf_comprob,
                                           OUTPUT v-des_nrocomprob,
                                           OUTPUT v-has_nrocomprob,
                                           OUTPUT timpre,
                                           OUTPUT error_rango ).
      v-has_nrocomprob = v-des_nrocomprob.
      IF timpre = 0 THEN DO:
          MESSAGE "Seleccione la impresora por donde emitira los comprobantes" VIEW-AS ALERT-BOX INFORMATION.
          RETURN.
      END.

      IF error_rango 
      THEN DO:
           RUN ver-error-rango ( "Datos de rango" ).
           hay_error = error_rango.
      END.     
      FIND FIRST fac_header 
              WHERE fac_header.cdg_empresa  = empresa.cdg_empresa
              AND fac_header.tip_comprob  = v-tip_comprob
              AND fac_header.prf_comprob  = v-prf_comprob
              AND fac_header.nro_comprob  <= v-has_nrocomprob
              AND fac_header.nro_comprob  >= v-des_nrocomprob  NO-ERROR.
      IF fac_header.estado_2_impresion = "OT" THEN DO:
            MESSAGE "El recibo estaba a la espera de la OT" VIEW-AS ALERT-BOX INFORMATION.
      END.
      IF fac_header.estado_2_impresion = "I" THEN DO:
            MESSAGE "El recibo ya estaba impreso" VIEW-AS ALERT-BOX INFORMATION.
      END.
    
      IF NOT AVAILABLE fac_header THEN DO:
           RUN ver-error-rango ( "Ningun recibo en ese rango" ).
           hay_error = TRUE.
      END.
      IF ( v-has_nrocomprob <> v-des_nrocomprob) THEN DO:
           RUN ver-error-rango ( "La reimpresion que requieten OT es para un solo comprobante" ).
           hay_error = TRUE.            
      END.
  IF NOT hay_error
  THEN DO:
       ReportePath = "AFI/" + formulario( ROWID(fac_header) ).
       v-estado:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "Ejecutando Proceso ...".
       RUN AFI/CUP000.p    ( 
                            INPUT v-tip_comprob,
                            INPUT v-prf_comprob,
                            INPUT v-des_nrocomprob,
                            INPUT v-has_nrocomprob,
                            INPUT empresa.cdg_empresa,
                            INPUT FALSE,
                            OUTPUT xfile
                           ).
  
   /*a Imprimir*/
    RUN fullPath (ReportePath, '.rpt':U, OUTPUT cFullPath).
    IF cFullPath = ? 
    THEN DO:
        RUN mensajepar.p (INPUT ReportePath, INPUT "CREP000").
        RETURN ERROR.
    END.

    CREATE "CrystalRuntime.Application" chApplication.
    chReport = chApplication:OpenReport(cFullPath, {&crOpenReportByTempCopy}).
    chReport:DiscardSavedData(). /*eliminando lo previamente grabado*/
    RUN fullpath ( INPUT xfile, INPUT "", OUTPUT xFullPath ).
    chReport:Database:Tables:item(1):setTableLocation(xFullPath, '', '').
    RUN crearReporte(chReport,"rpt",/*ViewReport*/ FALSE, /*impresora*/ impreport(timpre) , 
        /*exportToDisk*/ FALSE, INPUT-OUTPUT exportFileName ).        
        RELEASE OBJECT chReport. 
        chReport = ?.
        RELEASE OBJECT chApplication.
        chApplication = ?.
      /* RUN borra_temp ( INPUT xfile, OUTPUT ERROR_nro ).*/
       v-estado:SCREEN-VALUE in FRAME {&FRAME-NAME} = "Proceso Terminado. Ingresando Parametros ...".   
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

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION formulario W-Win 
FUNCTION formulario RETURNS CHARACTER
  ( INPUT rid_fac_header AS ROWID ) :
/*------------------------------------------------------------------------------
  Purpose:  retorna el formulario a utilizar
    Notes:  La cantidad de copias no es un parametro ya que el formulario 
            define univocamente la cantidad de copias no es un dato separado
            es la definicion del mismo formulario
            
------------------------------------------------------------------------------*/
DEFINE VARIABLE que_formulario      AS CHARACTER.
DEFINE VARIABLE x-formulario        AS CHARACTER.
DEFINE VARIABLE j                   AS INTEGER.
{parlocales.i}
/*=================================================================================*/
/*                         INICIALIZACION DE LA EMISION                            */
/*=================================================================================*/

FIND fac_header WHERE ROWID(fac_header) = rid_fac_header EXCLUSIVE-LOCK.


FIND Punto-venta 
    WHERE Punto-venta.cdg_empresa = fac_header.cdg_empresa
      AND Punto-venta.cdg_puntovta = fac_header.prf_comprob
          NO-LOCK.

que_formulario = "CUP" + string(fac_header.prf_comprob,"9999").

RETURN que_formulario.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

