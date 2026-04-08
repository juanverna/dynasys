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

DEFINE VARIABLE v-font AS INTEGER INITIAL 2.
DEFINE VARIABLE v-flag AS INTEGER INITIAL 0.
DEFINE VARIABLE v-lins AS INTEGER INITIAL 72.
{windows.i}
{crystal_dyna.p}

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
&Scoped-Define ENABLED-OBJECTS Btn-excel b-ejecutar btn_salir 
&Scoped-Define DISPLAYED-OBJECTS v-estado 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR W-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of handles for SmartObjects                              */
DEFINE VARIABLE h_v-cotiza-moneda AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-id-clasearticulo AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-lst_atributos_articulo AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-lst_punto-vta AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-rng-fechas AS HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON b-ejecutar 
     LABEL "Ejecutar" 
     SIZE 22 BY 1.33.

DEFINE BUTTON Btn-excel 
     IMAGE-UP FILE "excel.gif":U NO-FOCUS
     LABEL "&Modifica" 
     SIZE 24 BY 1.33 TOOLTIP "Modifica el registro actual"
     FONT 4.

DEFINE BUTTON btn_salir DEFAULT 
     LABEL "&Salir" 
     SIZE 22 BY 1.33
     BGCOLOR 8 .

DEFINE VARIABLE v-estado AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 100 BY 1
     BGCOLOR 1 FGCOLOR 14 FONT 6 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Btn-excel AT ROW 21.71 COL 42 WIDGET-ID 6
     v-estado AT ROW 20.48 COL 12 COLON-ALIGNED NO-LABEL
     b-ejecutar AT ROW 21.67 COL 67
     btn_salir AT ROW 21.67 COL 91
     "  Lista de puntos de venta a considerar" VIEW-AS TEXT
          SIZE 100 BY 1 AT ROW 8.62 COL 14 WIDGET-ID 2
          BGCOLOR 5 FGCOLOR 15 FONT 6
     "  Rango de fechas de los movimientos:" VIEW-AS TEXT
          SIZE 100 BY 1 AT ROW 4.48 COL 14
          BGCOLOR 5 FGCOLOR 15 FONT 6
     " Moneda en la que se expresan los importes:" VIEW-AS TEXT
          SIZE 100 BY 1 AT ROW 16.38 COL 14
          BGCOLOR 5 FGCOLOR 15 FONT 6
     "  Lista de atributos de los artículos a considerar:" VIEW-AS TEXT
          SIZE 100 BY 1 AT ROW 12.57 COL 14
          BGCOLOR 5 FGCOLOR 15 FONT 6
     "  Primer nodo de la clasificación a listar:" VIEW-AS TEXT
          SIZE 100 BY 1 AT ROW 1.14 COL 14
          BGCOLOR 5 FGCOLOR 15 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 122.2 BY 24.


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
         TITLE              = "Estadistística de ventas clasificada"
         HEIGHT             = 22.91
         WIDTH              = 120.6
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

{rutimpresion.i}
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
ASSIGN 
       Btn-excel:HIDDEN IN FRAME F-Main           = TRUE.

/* SETTINGS FOR FILL-IN v-estado IN FRAME F-Main
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(W-Win)
THEN W-Win:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON END-ERROR OF W-Win /* Estadistística de ventas clasificada */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-CLOSE OF W-Win /* Estadistística de ventas clasificada */
DO:
  /* This ADM code must be left here in order for the SmartWindow
     and its descendents to terminate properly on exit. */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME b-ejecutar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b-ejecutar W-Win
ON CHOOSE OF b-ejecutar IN FRAME F-Main /* Ejecutar */
DO:
  RUN lst-ejecutar(1).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn-excel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn-excel W-Win
ON CHOOSE OF Btn-excel IN FRAME F-Main /* Modifica */
DO:
  RUN lst-ejecutar(2).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_salir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_salir W-Win
ON CHOOSE OF btn_salir IN FRAME F-Main /* Salir */
DO:
    RUN salir.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK W-Win 


/* ***************************  Main Block  *************************** */
{windows.i}
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
             INPUT  'v-id-clasearticulo.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-id-clasearticulo ).
       RUN set-position IN h_v-id-clasearticulo ( 2.43 , 14.00 ) NO-ERROR.
       /* Size in UIB:  ( 1.86 , 100.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-rng-fechas.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-rng-fechas ).
       RUN set-position IN h_v-rng-fechas ( 5.57 , 14.00 ) NO-ERROR.
       /* Size in UIB:  ( 2.43 , 100.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-lst_punto-vta.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-lst_punto-vta ).
       RUN set-position IN h_v-lst_punto-vta ( 9.86 , 14.00 ) NO-ERROR.
       /* Size in UIB:  ( 2.43 , 100.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-lst_atributos_articulo.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-lst_atributos_articulo ).
       RUN set-position IN h_v-lst_atributos_articulo ( 13.76 , 14.00 ) NO-ERROR.
       /* Size in UIB:  ( 2.43 , 100.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-cotiza-moneda-solo.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-cotiza-moneda ).
       RUN set-position IN h_v-cotiza-moneda ( 17.57 , 14.00 ) NO-ERROR.
       /* Size in UIB:  ( 2.62 , 100.00 ) */

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-id-clasearticulo ,
             v-estado:HANDLE IN FRAME F-Main , 'BEFORE':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-rng-fechas ,
             h_v-id-clasearticulo , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-lst_punto-vta ,
             h_v-rng-fechas , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-lst_atributos_articulo ,
             h_v-lst_punto-vta , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-cotiza-moneda ,
             h_v-lst_atributos_articulo , 'AFTER':U ).
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
  ENABLE Btn-excel b-ejecutar btn_salir 
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

  {setwintit.i "SIC/FAC" "Estadistística de ventas clasificada"}

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
  DEFINE INPUT PARAMETER modo AS INT.
  DEFINE VARIABLE primer_nodo       AS CHARACTER.

  DEFINE VARIABLE ver_por           AS LOGICAL.
  DEFINE VARIABLE des_fecha         AS DATE.
  DEFINE VARIABLE has_fecha         AS DATE.
  DEFINE VARIABLE error_rango       AS LOGICAL.
  DEFINE VARIABLE error_fecha       AS LOGICAL.
  DEFINE VARIABLE hay_error         AS LOGICAL.
  DEFINE VARIABLE p-prfs            AS CHARACTER.
  DEFINE VARIABLE p-cdg_moneda      AS CHARACTER.
  DEFINE VARIABLE p-lista_atributos AS CHARACTER.
  DEFINE VARIABLE p-ver_cotizacion  AS INTEGER.  
  DEFINE VARIABLE p-fecha           AS DATE.    
  DEFINE VAR MINVALC AS DECIMAL NO-UNDO.
  DEFINE VAR FDESTC AS char NO-UNDO.
  DEFINE VAR xfile AS CHAR NO-UNDO.
    
  DEFINE VARIABLE chApplication AS COM-HANDLE NO-UNDO.
  DEFINE VARIABLE chReport      AS COM-HANDLE NO-UNDO.
  DEFINE VARIABLE chParamDefs   AS COM-HANDLE NO-UNDO.
  DEFINE VARIABLE chParamDef   AS COM-HANDLE NO-UNDO.
  DEFINE VARIABLE cFullPath     AS CHARACTER NO-UNDO. 
  DEFINE VARIABLE xFullPath     AS CHARACTER NO-UNDO. 
  DEFINE VARIABLE exportFileName AS CHARACTER NO-UNDO. 

  RUN dar_rango IN h_v-id-clasearticulo ( OUTPUT primer_nodo,
                                          OUTPUT error_rango ).
  IF error_rango 
  THEN DO:
       RUN ver-error-rango ( "Clase de Articulos" ).
       hay_error = error_rango.
  END.     

  RUN dar_rango IN h_v-rng-fechas    ( OUTPUT des_fecha, 
                                       OUTPUT has_fecha, 
                                       OUTPUT error_rango ).

  IF error_rango 
  THEN DO:
       RUN ver-error-rango ( "Fechas" ).
       hay_error = error_rango.
  END.     

  RUN dar_rango IN h_v-lst_punto-vta    ( OUTPUT p-prfs,  
                                                 OUTPUT error_rango ).


    IF error_rango 
    THEN DO:
         RUN ver-error-rango ( "Lista de puntos de venta" ).
         hay_error = YES.
    END. 


  RUN dar_parametros IN h_v-cotiza-moneda    ( OUTPUT p-cdg_moneda ,
                                               OUTPUT error_rango ).
  FIND moneda WHERE moneda.cdg_moneda = p-cdg_moneda.
      
  IF error_fecha 
  THEN DO:
       RUN ver-error-fecha ( "Fecha de Cotización" ).
       hay_error = error_fecha.
  END. 

  RUN dar_rango IN h_v-lst_atributos_articulo    ( OUTPUT p-lista_atributos,  
                                                   OUTPUT error_rango ).
       
  IF error_rango 
  THEN DO:
       RUN ver-error-rango ( "Lista de Atributos de Artículos" ).
       hay_error = YES.
  END. 
  
  IF NOT hay_error
  THEN DO:

       RUN setear-botones ( NO ).        
       v-estado:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "Ejecutando Proceso ...".
       RUN lstot_ventas_clasificadasprf.p ( INPUT primer_nodo,
                                         INPUT des_fecha,
                                         INPUT has_fecha,
                                         INPUT p-prfs,
                                         INPUT p-cdg_moneda,
                                         INPUT p-ver_cotizacion,
                                         INPUT p-fecha,
                                         INPUT p-lista_atributos,
                                         OUTPUT xfile,
                                         INPUT modo
                                         ).   
        IF modo = 1 THEN DO:
            
            RUN fullPath ("Ventasxptovta", '.rpt':U, OUTPUT cFullPath).
            IF cFullPath = ? 
            THEN DO:
                RUN mensajepar.p (INPUT "Ventasxptovta.rpt", INPUT "CREP000").
                RETURN ERROR.
            END.
    
           CREATE "CrystalRuntime.Application" chApplication.
           chReport = chApplication:OpenReport(cFullPath, {&crOpenReportByTempCopy}).
           chReport:DiscardSavedData(). /*eliminando lo previamente grabado*/
           RUN fullpath ( INPUT xfile, INPUT "", OUTPUT xFullPath ).
           chReport:Database:Tables:item(1):setTableLocation(xFullPath, '', '').
           setParametro( chReport , "nodo" , primer_nodo ).
           setParametro( chReport , "desde" , STRING(des_fecha ) ).
           setParametro( chReport , "hasta" , string(has_fecha) ).
           setParametro( chReport , "moneda", Moneda.descripcion ).
           RUN getparametro_c.p (INPUT "FDESTC" , OUTPUT FDESTC).
           
            RUN crearReporte(chReport,FDESTC,/*ViewReport*/ TRUE,/*PrinterName*/ "",
                             /*exportToDisk*/ FALSE, INPUT-OUTPUT exportFileName ).        
            /*RUN borra-temp (exportFileName,output err_no).*/
            RELEASE OBJECT chReport. 
            chReport = ?.
            RELEASE OBJECT chApplication.
            chApplication = ?.
        END.
        
       IF modo = 1 THEN
       v-estado:SCREEN-VALUE in FRAME {&FRAME-NAME} = "Proceso Terminado. Ingresando Parametros ...".
       IF modo = 2 THEN
       v-estado:SCREEN-VALUE in FRAME {&FRAME-NAME} = "Se ha generado " + xfile.
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

