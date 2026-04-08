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
{crystal_dyna.p}

define temp-table t-contrato 
    field nombre like cliente.nom_cliente
    field direccion like cliente.direccion
    field cdg_cliente like cliente.cdg_cliente
    field nro_comprob like contrato_hd.nro_contrato
    field prf_comprob like contrato_hd.prf_contrato
    field numero_eventos like numero_eventos.

define temp-table t-restriccion 
    field valor like contrato_restriccion.Valor 
    field sub_evento like contrato_restriccion.sub_evento
    field nro_restriccion like contrato_restriccion.nro_restriccion
    field nro_contrato like contrato_restriccion.nro_contrato
    field cdg_restriccion like restriccion.cdg_restriccion
    field descripcion like restriccion.descripcion
    .

DEFINE DATASET dset FOR t-contrato , t-restriccion.

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD que_listado W-Win 
FUNCTION que_listado RETURNS CHARACTER
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR W-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of handles for SmartObjects                              */
DEFINE VARIABLE h_p-ejecutar AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-rng-fechas AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-rng-tipo_contrato AS HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE VARIABLE v-estado AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 100 BY 1
     BGCOLOR 9 FGCOLOR 11 FONT 6 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     v-estado AT ROW 8.86 COL 11 COLON-ALIGNED NO-LABEL WIDGET-ID 10
     "Rango de fechas" VIEW-AS TEXT
          SIZE 100 BY 1 AT ROW 4.81 COL 13 WIDGET-ID 6
          BGCOLOR 5 FGCOLOR 15 FONT 6
     "Tipos de contratos" VIEW-AS TEXT
          SIZE 100 BY 1 AT ROW 1 COL 12 WIDGET-ID 8
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
         HEIGHT             = 11.81
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
    /* Modificado para que el control retorne a la window padre al cerrar una windows hija */
    DEFINE VARIABLE h_parent AS HANDLE      NO-UNDO.
    h_parent = THIS-PROCEDURE:CURRENT-WINDOW:PARENT.
    APPLY "CLOSE":U TO THIS-PROCEDURE.
    CURRENT-WINDOW = h_parent.
    APPLY 'ENTRY' TO h_parent.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE activos W-Win 
PROCEDURE activos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*listado de contratos activos y su restricciones segun tipo entre fechas*/
define input parameter c_nro_tipo_evento as int no-undo.
define input parameter fdesde as date no-undo.
define input parameter fhasta as date no-undo.
define input param xfile as char no-undo.

DEFINE VARIABLE v-ciclo_facturacion       AS INTEGER    NO-UNDO.
define var i as int no-undo.
FOR EACH contrato_hd WHERE contrato_hd.estado = "A" AND contrato_hd.rige_hasta >= fhasta AND
      contrato_hd.rige_desde <= fdesde AND
      ( contrato_hd.cant_periodos = 0 OR resto_periodos > 0 )
      AND contrato_hd.primer_ano * 100 + contrato_hd.primer_mes  <= year(fhasta) * 100 + month(fhasta) and not Contrato_hd.anulado and  contrato_hd.fecha_baja = ?
      ,FIRST cliente OF contrato_hd :

      IF contrato_hd.nro_tipo_evento <> c_nro_tipo_evento THEN NEXT.
      v-ciclo_facturacion = INTEGER(Contrato_hd.modo_facturacion).
      FIND contrato_dt OF contrato_hd NO-ERROR.
      IF NOT AVAILABLE contrato_dt THEN NEXT.
      FIND articulo OF contrato_dt NO-ERROR.
      IF NOT AVAILABLE articulo THEN NEXT.
      create t-contrato.
      assign
            t-contrato.nombre = cliente.nom_cliente
            t-contrato.direccion = cliente.direccion
            t-contrato.cdg_cliente = cliente.cdg_cliente
            t-contrato.nro_comprob = contrato_hd.nro_contrato
            t-contrato.prf_comprob = contrato_hd.prf_contrato
            t-contrato.numero_eventos = contrato_hd.numero_eventos.
      DO i = 1 TO contrato_hd.numero_eventos:
          FOR each contrato_restriccion where 
                  contrato_restriccion.nro_contrato = contrato_hd.nro_contrato and
                  contrato_restriccion.sub_evento = i , 
                  restriccion of contrato_restriccion:
              create t-restriccion.
              assign     
                t-restriccion.valor = contrato_restriccion.Valor 
                t-restriccion.sub_evento = contrato_restriccion.sub_evento
                t-restriccion.nro_restriccion = contrato_restriccion.nro_restriccion
                t-restriccion.nro_contrato = contrato_restriccion.nro_contrato
                t-restriccion.cdg_restriccion = restriccion.cdg_restriccion
                t-restriccion.descripcion = restriccion.descripcion
                .
          END.

      END.
END.
IF xfile = "" THEN xfile = "c:\sic-temp\contr_activos.xml".
DATASET dset:WRITE-XML ("FILE", xfile, FALSE,
                                     ?,"",YES,YES).
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

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
             INPUT  'v-rng-tipo_contrato.r':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-rng-tipo_contrato ).
       RUN set-position IN h_v-rng-tipo_contrato ( 2.19 , 13.00 ) NO-ERROR.
       /* Size in UIB:  ( 2.43 , 100.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-rng-fechas.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-rng-fechas ).
       RUN set-position IN h_v-rng-fechas ( 6.00 , 13.00 ) NO-ERROR.
       /* Size in UIB:  ( 2.43 , 100.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'p-CRejecutarSP.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_p-ejecutar ).
       RUN set-position IN h_p-ejecutar ( 10.05 , 13.00 ) NO-ERROR.
       /* Size in UIB:  ( 2.38 , 100.00 ) */

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-rng-tipo_contrato ,
             v-estado:HANDLE IN FRAME F-Main , 'BEFORE':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-rng-fechas ,
             h_v-rng-tipo_contrato , 'AFTER':U ).
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

  {setwintit.i "SIC/CXC" "Contratos que generan eventos"}

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
  define input parameter v-formato_salida as char.
  define input parameter v-preview as logical.
  define input parameter v-fechalist as character.
  
  DEFINE VARIABLE v-lista_empresas   AS CHARACTER.
  DEFINE VARIABLE v-lista_punto-vta  AS CHARACTER.
  DEFINE VARIABLE des_fecha          AS DATE.
  DEFINE VARIABLE has_fecha          AS DATE.
  DEFINE VARIABLE error_rango        AS LOGICAL.
  DEFINE VARIABLE hay_error          AS LOGICAL.
  DEFINE VARIABLE primer_nodo       AS CHARACTER.
  define variable que_parametro as character no-undo.

  DEFINE VAR FDESTC AS char NO-UNDO.
  DEFINE VAR xfile AS CHAR NO-UNDO.
    
  DEFINE VARIABLE chApplication AS COM-HANDLE NO-UNDO.
  DEFINE VARIABLE chReport      AS COM-HANDLE NO-UNDO.
  DEFINE VARIABLE chParamDefs   AS COM-HANDLE NO-UNDO.
  DEFINE VARIABLE chParamDef   AS COM-HANDLE NO-UNDO.
  DEFINE VARIABLE cFullPath     AS CHARACTER NO-UNDO. 
  DEFINE VARIABLE xFullPath     AS CHARACTER NO-UNDO. 
  DEFINE VARIABLE exportFileName AS CHARACTER NO-UNDO. 
  define var p-tipo_contrato as character no-undo.

  IF v-fechalist = "Ejecutar" THEN DO:

      RUN dar_rango IN h_v-rng-tipo_contrato ( OUTPUT p-tipo_contrato,
                                            OUTPUT error_rango ).
      IF error_rango 
      THEN DO:
           RUN ver-error-rango ( "Tipo Contrato").
           hay_error = error_rango.
      END. 
    
      RUN dar_rango IN h_v-rng-fechas ( OUTPUT des_fecha, 
                                         OUTPUT has_fecha, 
                                         OUTPUT error_rango ).
     IF error_rango 
      THEN DO:
           RUN ver-error-rango ( "Fechas").
           hay_error = error_rango.
      END.     
  END.
  
  IF NOT hay_error
  THEN DO:

       RUN setear-botones ( NO ).        
       v-estado:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "Ejecutando Proceso ...".

       IF v-fechalist = "Ejecutar" 
       THEN DO:
           run activos (p-tipo_contrato,des_fecha,has_fecha,xfile).
           que_parametro =  "tipocontrato"  + CHR(1) + p-tipo_contrato                             + CHR(1) +
                            "desde"   + CHR(1) + STRING(des_fecha)                 + CHR(1) +
                            "hasta"   + CHR(1) + string(has_fecha).  
           RUN graba_temp ( INPUT que_listado(), INPUT que_parametro, INPUT xfile ).
      END.
      ELSE DO:
          RUN datoslistado(INPUT que_listado(), INPUT v-fechalist , OUTPUT que_parametro , INPUT-OUTPUT xfile ).
      END.

           RUN invocaCrystal( INPUT que_listado()  , 
                   INPUT que_parametro, 
                   INPUT "" ,  /*parametros*/
                   INPUT  /*reportFormat*/ v-formato_salida,
                   INPUT  /*ViewReport*/ v-preview ,
                   INPUT  /*printername*/ IF v-preview THEN "" ELSE "EX?",
                   INPUT /*exportToDisk*/ FALSE,
                   INPUT-OUTPUT  exportFileName ).

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

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION que_listado W-Win 
FUNCTION que_listado RETURNS CHARACTER
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

  RETURN "listar_contr_activos".   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

