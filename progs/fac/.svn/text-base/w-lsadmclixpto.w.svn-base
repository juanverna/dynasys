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



    DEFINE TEMP-TABLE ff
       FIELD tip_comprob                like fac_header.tip_comprob             
       FIELD prf_comprob                like fac_header.prf_comprob             
       FIELD nro_comprob                like fac_header.nro_comprob             
       FIELD cdg_condiva                like fac_header.cdg_condiva             
       FIELD cdg_administrador          like fac_header.cdg_administrador       
       FIELD cdg_empresa                like fac_header.cdg_empresa             
       FIELD codigo_cliente             like fac_header.codigo_cliente          
       FIELD direccion                  like fac_header.direccion               
       FIELD direccion_administrador    like fac_header.direccion_administrador 
       FIELD estado                     like fac_header.estado
       FIELD fecha                      like fac_header.fecha  
       FIELD cdg_articulo               LIKE articulo.cdg_articulo
       FIELD descripcion                LIKE articulo.descripcion
       FIELD cdg_clase                  LIKE articulo.cdg_subclase
       FIELD imp_total                  like sic.Fac_detalle.subtotal_gral_cf               
       FIELD nom_Administrador          like fac_header.nom_Administrador       
       FIELD nombre                     like fac_header.nombre                  
       FIELD nro_administrador          like fac_header.nro_administrador       
       FIELD nro_cliente                like fac_header.nro_cliente             
       FIELD nro_contrato               like fac_header.nro_contrato .           

DEFINE DATASET dset FOR ff.
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
&Scoped-Define DISPLAYED-OBJECTS v-estado 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR W-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of handles for SmartObjects                              */
DEFINE VARIABLE h_p-ejecutar AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-id-clasearticulo AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-lst-empresas AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-lst_punto-vta AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-rng-fechas AS HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE VARIABLE v-estado AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 100 BY 1
     BGCOLOR 1 FGCOLOR 14 FONT 6 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     v-estado AT ROW 16.48 COL 10 COLON-ALIGNED NO-LABEL
     "  Lista de empresas a considerar:" VIEW-AS TEXT
          SIZE 100 BY 1 AT ROW 1.24 COL 13 WIDGET-ID 6
          BGCOLOR 5 FGCOLOR 15 FONT 6
     "  Lista de puntos de venta a considerar" VIEW-AS TEXT
          SIZE 100 BY 1 AT ROW 8.86 COL 12 WIDGET-ID 4
          BGCOLOR 5 FGCOLOR 15 FONT 6
     "  Lista de empresas a considerar:" VIEW-AS TEXT
          SIZE 100 BY 1 AT ROW 5.05 COL 13
          BGCOLOR 5 FGCOLOR 15 FONT 6
     "  Primer nodo de la clasificación a listar:" VIEW-AS TEXT
          SIZE 100 BY 1 AT ROW 12.91 COL 12 WIDGET-ID 8
          BGCOLOR 5 FGCOLOR 15 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 119.8 BY 20.


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
         TITLE              = "Comprobantes impagos a fecha"
         HEIGHT             = 20.19
         WIDTH              = 119.8
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
ON END-ERROR OF W-Win /* Comprobantes impagos a fecha */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-CLOSE OF W-Win /* Comprobantes impagos a fecha */
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
             INPUT  'v-rng-fechas.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-rng-fechas ).
       RUN set-position IN h_v-rng-fechas ( 2.43 , 13.00 ) NO-ERROR.
       /* Size in UIB:  ( 2.43 , 100.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-lst-empresas.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-lst-empresas ).
       RUN set-position IN h_v-lst-empresas ( 6.24 , 12.00 ) NO-ERROR.
       /* Size in UIB:  ( 2.43 , 100.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-lst_punto-vta.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-lst_punto-vta ).
       RUN set-position IN h_v-lst_punto-vta ( 10.29 , 12.00 ) NO-ERROR.
       /* Size in UIB:  ( 2.43 , 100.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-id-clasearticulo.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-id-clasearticulo ).
       RUN set-position IN h_v-id-clasearticulo ( 14.33 , 12.00 ) NO-ERROR.
       /* Size in UIB:  ( 1.86 , 100.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'p-CRejecutarSPPAU.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_p-ejecutar ).
       RUN set-position IN h_p-ejecutar ( 17.67 , 12.00 ) NO-ERROR.
       /* Size in UIB:  ( 2.14 , 103.00 ) */

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-rng-fechas ,
             v-estado:HANDLE IN FRAME F-Main , 'BEFORE':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-lst-empresas ,
             h_v-rng-fechas , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-lst_punto-vta ,
             h_v-lst-empresas , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-id-clasearticulo ,
             h_v-lst_punto-vta , 'AFTER':U ).
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE factulis W-Win 
PROCEDURE factulis :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 DEFINE INPUT PARAMETER des_fecha AS DATE.
 define INPUT PARAMETER has_fecha AS DATE.
 DEFINE INPUT PARAMETER v-lista_empresas AS CHAR.
 DEFINE INPUT PARAMETER v-lista_punto-vta AS CHAR.
 DEFINE INPUT PARAMETER primernodo AS CHAR.
 DEFINE INPUT-OUTPUT PARAMETER xfile AS CHAR.

 EMPTY TEMP-TABLE ff.
 FOR EACH fac_header WHERE NOT anulado AND
     fac_header.fecha >= des_fecha AND fac_header.fecha <= has_fecha:
    IF NOT can-do(v-lista_empresas, fac_header.cdg_empresa) THEN NEXT.
    IF NOT can-do(v-lista_punto-vta, string(fac_header.prf_comprob,"9999")) THEN NEXT.
    FOR EACH fac_detalle OF fac_header:
        FIND articulo OF fac_detalle NO-LOCK.
        IF NOT Articulo.cdg_subclase BEGINS primernodo  THEN NEXT .
        CREATE ff.
        BUFFER-COPY fac_header EXCEPT  imp_total TO ff .
        ASSIGN  ff.imp_total    = Fac_detalle.subtotal_gral
                ff.cdg_articulo = articulo.cdg_articulo
                ff.descripcion  = articulo.descripcion
                ff.cdg_clase    = articulo.cdg_subclase .              
    END.
 END.
 
IF xfile = "" OR xfile = ?
      THEN xfile = tempfile("") + ".xml".

DATASET dset:WRITE-XML ("FILE", xfile, TRUE,
                                       ?,"",YES,YES).
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

  {setwintit.i "SIC/CXC" "Facturas por Administrador/Punto Venta/Cliente"}

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
  DEFINE VARIABLE v-lista_empresas   AS CHARACTER.
  DEFINE VARIABLE v-lista_punto-vta  AS CHARACTER.
  DEFINE VARIABLE des_fecha          AS DATE.
  DEFINE VARIABLE has_fecha          AS DATE.
  DEFINE VARIABLE error_rango        AS LOGICAL.
  DEFINE VARIABLE hay_error          AS LOGICAL.
  DEFINE VARIABLE primer_nodo       AS CHARACTER.

  DEFINE VAR FDESTC AS char NO-UNDO.
  DEFINE VAR xfile AS CHAR NO-UNDO.
    
  DEFINE VARIABLE chApplication AS COM-HANDLE NO-UNDO.
  DEFINE VARIABLE chReport      AS COM-HANDLE NO-UNDO.
  DEFINE VARIABLE chParamDefs   AS COM-HANDLE NO-UNDO.
  DEFINE VARIABLE chParamDef   AS COM-HANDLE NO-UNDO.
  DEFINE VARIABLE cFullPath     AS CHARACTER NO-UNDO. 
  DEFINE VARIABLE xFullPath     AS CHARACTER NO-UNDO. 
  DEFINE VARIABLE exportFileName AS CHARACTER NO-UNDO. 

  RUN dar_rango IN h_v-rng-fechas ( OUTPUT des_fecha, 
                                     OUTPUT has_fecha, 
                                     OUTPUT error_rango ).
 IF error_rango 
  THEN DO:
       RUN ver-error-rango ( "Fechas").
       hay_error = error_rango.
  END.     

  RUN dar_rango IN h_v-lst-empresas ( OUTPUT  v-lista_empresas,
                                      OUTPUT  error_rango ).

  IF error_rango 
  THEN DO:
       RUN ver-error-rango ( "Empresas" ).
       hay_error = error_rango.
  END.     


  RUN dar_rango IN h_v-lst_punto-vta ( OUTPUT  v-lista_punto-vta,
                                      OUTPUT  error_rango ).

  IF error_rango 
  THEN DO:
       RUN ver-error-rango ( "Puntos de Venta" ).
       hay_error = error_rango.
  END. 
  RUN dar_rango IN h_v-id-clasearticulo ( OUTPUT primer_nodo,
                                          OUTPUT error_rango ).
  IF error_rango 
  THEN DO:
       RUN ver-error-rango ( "Clase de Articulos" ).
       hay_error = error_rango.
  END.     

  IF NOT hay_error
  THEN DO:

       RUN setear-botones ( NO ).        
       v-estado:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "Ejecutando Proceso ...".
xfile = "c:\sic-temp\ff.xml".
       RUN factulis      ( INPUT des_fecha , 
                           INPUT has_fecha , 
                           INPUT v-lista_empresas,
                           INPUT v-lista_punto-vta,
                           INPUT primer_nodo, 
                           INPUT-OUTPUT xfile).
/*VentasxadmptovtaTBL.rpt*/ 

       RUN fullPath ("VentasxadmptovtaTBL", '.rpt':U, OUTPUT cFullPath).
       IF cFullPath = ? 
       THEN DO:
           RUN mensajepar.p (INPUT "clasificacionprf.rpt", INPUT "CREP000").
           RETURN ERROR.
       END.

      CREATE "CrystalRuntime.Application" chApplication.
      chReport = chApplication:OpenReport(cFullPath, {&crOpenReportByTempCopy}).
      chReport:DiscardSavedData(). /*eliminando lo previamente grabado*/
      RUN fullpath ( INPUT xfile, INPUT "", OUTPUT xFullPath ).
      chReport:Database:Tables:item(1):setTableLocation(xFullPath, '', '').
      setParametro( chReport , "desde" , STRING(des_fecha ) ).
      setParametro( chReport , "hasta" , string(has_fecha) ).
      setParametro( chReport , "primer_nodo" , primer_nodo ).
      RUN getparametro_c.p (INPUT "FDESTC" , OUTPUT FDESTC).

       RUN crearReporte(chReport,FDESTC,/*ViewReport*/ TRUE,/*PrinterName*/ "",
                        /*exportToDisk*/ FALSE, INPUT-OUTPUT exportFileName ).        
       /*RUN borra-temp (exportFileName,output err_no).*/
       RELEASE OBJECT chReport. 
       chReport = ?.
       RELEASE OBJECT chApplication.
       chApplication = ?.


       v-estado:SCREEN-VALUE in FRAME {&FRAME-NAME} = "Proceso Terminado. Ingresando Parametros ...".
       RUN setear-botones ( YES ).        

  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pendiente_cob W-Win 
PROCEDURE pendiente_cob :
/*------------------------------------------------------------------------------
  Purpose:     imprime el resumen de cobranza para el cliente
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEFINE INPUT PARAMETER p-cdg_empresa AS CHAR NO-UNDO.
DEFINE INPUT PARAMETER p-cdg_dadm    AS CHAR NO-UNDO.
DEFINE INPUT PARAMETER p-cdg_hadm    AS CHAR NO-UNDO.
DEFINE INPUT PARAMETER p-hfecha      AS DATE NO-UNDO.
DEFINE INPUT PARAMETER p-vencimiento AS DATE NO-UNDO.
DEFINE INPUT PARAMETER p-punto-vta   AS CHARACTER NO-UNDO.
DEFINE INPUT PARAMETER p-ver_por     AS integer NO-UNDO.
DEF VAR xfile AS CHAR NO-UNDO.
DEF VAR ReportePath AS CHAR NO-UNDO.
DEF VAR cFullPath AS CHAR NO-UNDO.
DEF VAR XFullPath AS CHAR NO-UNDO.
DEF VAR exportFileName AS CHAR NO-UNDO.

  DEFINE VARIABLE chApplication AS COM-HANDLE NO-UNDO.
  DEFINE VARIABLE chReport      AS COM-HANDLE NO-UNDO.
  
  

  RUN prinresumenes.p ( INPUT p-cdg_empresa,
                             INPUT p-cdg_dadm,
                             INPUT p-cdg_hadm,
                             INPUT p-hfecha ,
                             INPUT p-vencimiento,
                             INPUT p-punto-vta,
                             INPUT p-ver_por,
                             OUTPUT xfile). 

ReportePath = "pendiente_cobranzas".
       RUN fullPath (ReportePath, '.rpt':U, OUTPUT cFullPath).
IF cFullPath = ? 
THEN DO:
    RUN mensajepar.p (INPUT ReportePath, INPUT "CREP000").
    RETURN NO-apply.
END.

CREATE "CrystalRuntime.Application" chApplication.
chReport = chApplication:OpenReport(cFullPath, {&crOpenReportByTempCopy}).
chReport:DiscardSavedData(). /*eliminando lo previamente grabado*/
RUN fullpath ( INPUT xfile, INPUT "", OUTPUT xFullPath ).
chReport:Database:Tables:item(1):setTableLocation(xFullPath, '', '').
setParametro(chReport, "ver_por" , string(p-ver_por)).
setParametro(chReport, "has_fecha" , string(p-hfecha)).
RUN crearReporte(chReport,"rpt",/*ViewReport*/ TRUE,/*PrinterName*/ "",
                 /*exportToDisk*/ FALSE, INPUT-OUTPUT exportFileName ).        
RELEASE OBJECT chReport. 
chReport = ?.
RELEASE OBJECT chApplication.
chApplication = ?.

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

