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

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartWindow
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER WINDOW

/* Name of first Frame and/or Browse and/or first Query                 */
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
DEFINE VARIABLE h_v-rng-cliente AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-rng-cobrador AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-rng-fechas AS HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE VARIABLE v-estado AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 89 BY 1
     BGCOLOR 1 FGCOLOR 14 FONT 6 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     v-estado AT ROW 18.24 COL 12 COLON-ALIGNED NO-LABEL
     "  Rango de Fechas de Transacciones:" VIEW-AS TEXT
          SIZE 89 BY .81 AT ROW 5.57 COL 14
          BGCOLOR 5 FGCOLOR 15 FONT 6
     "  Rango de Cobradores a Considerar:" VIEW-AS TEXT
          SIZE 89 BY .81 AT ROW 1.52 COL 14
          BGCOLOR 5 FGCOLOR 15 FONT 6
     "  Rango de Clientes a Considerar:" VIEW-AS TEXT
          SIZE 89 BY .81 AT ROW 9.33 COL 14
          BGCOLOR 5 FGCOLOR 15 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 160 BY 26.33.


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
         TITLE              = "Documentos x Cobrador"
         HEIGHT             = 26.33
         WIDTH              = 160
         MAX-HEIGHT         = 26.33
         MAX-WIDTH          = 160
         VIRTUAL-HEIGHT     = 26.33
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
                                                                        */
/* SETTINGS FOR FILL-IN v-estado IN FRAME F-Main
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(W-Win)
THEN W-Win:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON END-ERROR OF W-Win /* Documentos x Cobrador */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-CLOSE OF W-Win /* Documentos x Cobrador */
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
             INPUT  '//milenium/desa/v9/sic/r3.5/emiliano/v-rng-cobrador.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-rng-cobrador ).
       RUN set-position IN h_v-rng-cobrador ( 2.67 , 14.00 ) NO-ERROR.
       /* Size in UIB:  ( 2.43 , 89.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  '//milenium/desa/v9/sic/r3.5/emiliano/v-rng-fechas.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-rng-fechas ).
       RUN set-position IN h_v-rng-fechas ( 6.48 , 14.00 ) NO-ERROR.
       /* Size in UIB:  ( 2.43 , 89.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  '//milenium/desa/v9/sic/r3.5/emiliano/v-rng-cliente.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-rng-cliente ).
       RUN set-position IN h_v-rng-cliente ( 10.29 , 14.00 ) NO-ERROR.
       /* Size in UIB:  ( 2.43 , 91.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'p-ejecutarPAU.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_p-ejecutar ).
       RUN set-position IN h_p-ejecutar ( 19.86 , 14.00 ) NO-ERROR.
       /* Size in UIB:  ( 2.43 , 89.00 ) */

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-rng-cobrador ,
             v-estado:HANDLE IN FRAME F-Main , 'BEFORE':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-rng-fechas ,
             h_v-rng-cobrador , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-rng-cliente ,
             h_v-rng-fechas , 'AFTER':U ).
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

  {setwintit.i "SIC/CXC" "Documentos por Cobrador"}

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

  DEFINE VARIABLE des_cobrador        LIKE Cobrador.cdg_cobrador.
  DEFINE VARIABLE has_cobrador        LIKE Cobrador.cdg_cobrador.
  DEFINE VARIABLE des_cliente         AS CHARACTER.
  DEFINE VARIABLE has_cliente         AS CHARACTER.
  DEFINE VARIABLE des_nombre          AS CHARACTER.
  DEFINE VARIABLE has_nombre          AS CHARACTER.
  DEFINE VARIABLE des_fecha           AS DATE.
  DEFINE VARIABLE has_fecha           AS DATE.
  DEFINE VARIABLE ver_por             AS INTEGER.
  DEFINE VARIABLE v-consolidado       AS LOGICAL.
  DEFINE VARIABLE error_rango         AS LOGICAL.
  DEFINE VARIABLE hay_error           AS LOGICAL.

  RUN dar_rango IN h_v-rng-cliente ( OUTPUT des_cliente, 
                                     OUTPUT has_cliente, 
                                     OUTPUT des_nombre, 
                                     OUTPUT has_nombre, 
                                     OUTPUT ver_por,
                                     OUTPUT error_rango ).
  IF error_rango 
  THEN DO:
       RUN ver-error-rango ( "clientes" ).
       hay_error = error_rango.
  END.     
  
  RUN dar_rango IN h_v-rng-cobrador  ( OUTPUT des_cobrador, 
                                       OUTPUT has_cobrador, 
                                       OUTPUT error_rango ).
  IF error_rango 
  THEN DO:
       RUN ver-error-rango ( "Cobradores" ).
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


  IF NOT hay_error
  THEN DO:

       RUN setear-botones ( NO ).        
       v-estado:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "Ejecutando Proceso ...".


       RUN lsanaliticoxcob.p (  INPUT  des_cobrador,
                                INPUT  has_cobrador,
                                INPUT  des_cliente,
                                INPUT  has_cliente,
                                INPUT  des_nombre,
                                INPUT  has_nombre,
                                INPUT  ver_por,
                                INPUT  des_fecha,
                                INPUT  has_fecha).

       v-estado:SCREEN-VALUE in FRAME {&FRAME-NAME} = "Proceso Terminado. Ingresando Parametros ...".
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

