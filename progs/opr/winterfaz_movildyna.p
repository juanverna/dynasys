&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI ADM2
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME wWin
{adecomm/appserv.i}
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wWin 
/*------------------------------------------------------------------------

  File: 

  Description: from cntnrwin.w - ADM SmartWindow Template

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  History: New V9 Version - January 15, 1998
          
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AB.              */
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

{src/adm2/widgetprto.i}

{ftp.i}
{httpget.i }
{advtexto.i}
{tiempo.i}

    SESSION:NUMERIC-FORMAT = "American" .  
    DEFINE BUFFER administrador FOR cliente.
    DEFINE STREAM LOG.
    

    DEFINE VAR k AS INT NO-UNDO.
    DEFINE VAR dia AS INT NO-UNDO.
    DEFINE VAR AHORA AS CHAR NO-UNDO.
    DEF VAR nroco LIKE evento.nro_tipo_evento NO-UNDO.
    DEF VAR fmin AS DATE NO-UNDO.
    DEF VAR fmax AS DATE NO-UNDO.
    DEFINE VAR p-has_fecha AS DATE NO-UNDO.
    DEFINE VAR p-vencimiento AS DATE NO-UNDO.
    DEFINE VAR p-punto-vta AS CHAR INITIAL "*" NO-UNDO.
    p-has_fecha = TODAY.
    p-vencimiento = 01/01/3000.
    DEFINE STREAM valores.
    DEFINE VAR saldoact AS DECIMAL.
    
    DEFINE STREAM adm.
    DEFINE STREAM ctacte.
    DEFINE STREAM ruth.
    DEFINE STREAM rutd.
    DEFINE STREAM descrec.
    DEFINE STREAM cobranza.
    DEFINE STREAM factura.
    DEFINE TEMP-TABLE T-Caja-imputacion NO-UNDO LIKE Caja-imputacion.
    DEFINE TEMP-TABLE T-Caj_detalle NO-UNDO LIKE Caj_detalle.
    DEFINE TEMP-TABLE T-Caj_header NO-UNDO LIKE Caj_header.
    DEFINE TEMP-TABLE T-Cheque NO-UNDO LIKE Cheque.
    DEFINE TEMP-TABLE T-comprobante_rendicion NO-UNDO LIKE comprobante_rendicion.
    DEFINE TEMP-TABLE T-Rendicion_hd NO-UNDO LIKE Rendicion_hd.
    DEFINE TEMP-TABLE T-Valor NO-UNDO LIKE Valor.
    DEFINE TEMP-TABLE cobranza
    FIELD v-cdg_cobrador AS CHAR
    FIELD v-cdg_cliente  AS CHAR
    FIELD nro_cobSRV AS char
    FIELD v_fecha_visita AS CHAR
    FIELD hdesde AS CHAR
    FIELD d_fch_cob AS DATE
    FIELD d_prox_cob AS DATE
    INDEX nro_cobSRV nro_cobSRV.
    DEFINE TEMP-TABLE factura
    FIELD nro_cobSRV AS CHAR
    FIELD tip_comprob AS CHAR
    FIELD prf_comprob AS int
    FIELD nro_comprob AS int
    FIELD importe AS DECIMAL
    FIELD observ AS INT
    INDEX nro_cobSRV nro_cobSRV.
    DEFINE BUFFER bfactura FOR factura.
    DEFINE TEMP-TABLE valores
    FIELD nro_cobSRV AS CHAR
    FIELD nro_tipo_valor AS CHAR
    FIELD codban AS char
    FIELD numsub AS char
    FIELD numche AS CHAR
    FIELD fecha AS DATE
    FIELD importe AS DECIMAL
    FIELD tipo_cheque AS CHAR
    FIELD rubro LIKE Caj_detalle.cdg_rubro
    INDEX nro_cobSRV nro_cobSRV.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartWindow
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER WINDOW

&Scoped-define ADM-SUPPORTED-LINKS Data-Target,Data-Source,Page-Target,Update-Source,Update-Target,Filter-target,Filter-Source

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fMain

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fmesg BUTTON-1 
&Scoped-Define DISPLAYED-OBJECTS fmesg 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fmesg wWin 
FUNCTION fmesg RETURNS CHARACTER
  ( ch AS CHAR )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD telef wWin 
FUNCTION telef RETURNS CHARACTER
  (aa AS CHAR)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wWin AS WIDGET-HANDLE NO-UNDO.

/* Definitions of handles for OCX Containers                            */
DEFINE VARIABLE CtrlFrame AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE chCtrlFrame AS COMPONENT-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON BUTTON-1 
     LABEL "Iniciar" 
     SIZE 15 BY 1.14.

DEFINE VARIABLE fmesg AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 74 BY 1 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fMain
     fmesg AT ROW 5.76 COL 2 COLON-ALIGNED NO-LABEL WIDGET-ID 6
     BUTTON-1 AT ROW 7.43 COL 34 WIDGET-ID 4
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 8.57 WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartWindow
   Allow: Basic,Browse,DB-Fields,Query,Smart,Window
   Container Links: Data-Target,Data-Source,Page-Target,Update-Source,Update-Target,Filter-target,Filter-Source
   Other Settings: APPSERVER
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW wWin ASSIGN
         HIDDEN             = YES
         TITLE              = "Interface Movildyna"
         HEIGHT             = 8.62
         WIDTH              = 80
         MAX-HEIGHT         = 28.81
         MAX-WIDTH          = 146.2
         VIRTUAL-HEIGHT     = 28.81
         VIRTUAL-WIDTH      = 146.2
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB wWin 
/* ************************* Included-Libraries *********************** */

{src/adm2/containr.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW wWin
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fMain
   FRAME-NAME                                                           */
ASSIGN 
       fmesg:READ-ONLY IN FRAME fMain        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wWin)
THEN wWin:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 


/* **********************  Create OCX Containers  ********************** */

&ANALYZE-SUSPEND _CREATE-DYNAMIC

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN

CREATE CONTROL-FRAME CtrlFrame ASSIGN
       FRAME           = FRAME fMain:HANDLE
       ROW             = 1.95
       COLUMN          = 14
       HEIGHT          = 3.33
       WIDTH           = 54
       WIDGET-ID       = 2
       HIDDEN          = no
       SENSITIVE       = yes.

PROCEDURE adm-create-controls:
      CtrlFrame:NAME = "CtrlFrame":U .
/* CtrlFrame OCXINFO:CREATE-CONTROL from: {4A5E5E35-91F4-46B1-B62F-78148132EF93} type: XP_ProgressBar */
      CtrlFrame:MOVE-BEFORE(fmesg:HANDLE IN FRAME fMain).

END PROCEDURE.

&ENDIF

&ANALYZE-RESUME /* End of _CREATE-DYNAMIC */


/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wWin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON END-ERROR OF wWin /* Interface Movildyna */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON WINDOW-CLOSE OF wWin /* Interface Movildyna */
DO:
  /* This ADM code must be left here in order for the SmartWindow
     and its descendents to terminate properly on exit. */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-1 wWin
ON CHOOSE OF BUTTON-1 IN FRAME fMain /* Iniciar */
DO:
    /*{debug.i}*/
  RUN interfazrec.
  RUN interfazsal.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wWin 


/* ***************************  Main Block  *************************** */

/* Include custom  Main Block code for SmartWindows. */
{src/adm2/windowmn.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-create-objects wWin  _ADM-CREATE-OBJECTS
PROCEDURE adm-create-objects :
/*------------------------------------------------------------------------------
  Purpose:     Create handles for all SmartObjects used in this procedure.
               After SmartObjects are initialized, then SmartLinks are added.
  Parameters:  <none>
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE control_load wWin  _CONTROL-LOAD
PROCEDURE control_load :
/*------------------------------------------------------------------------------
  Purpose:     Load the OCXs    
  Parameters:  <none>
  Notes:       Here we load, initialize and make visible the 
               OCXs in the interface.                        
------------------------------------------------------------------------------*/

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN
DEFINE VARIABLE UIB_S    AS LOGICAL    NO-UNDO.
DEFINE VARIABLE OCXFile  AS CHARACTER  NO-UNDO.

OCXFile = SEARCH( "winterfaz_movildyna.wrx":U ).
IF OCXFile = ? THEN
  OCXFile = SEARCH(SUBSTRING(THIS-PROCEDURE:FILE-NAME, 1,
                     R-INDEX(THIS-PROCEDURE:FILE-NAME, ".":U), "CHARACTER":U) + "wrx":U).

IF OCXFile <> ? THEN
DO:
  ASSIGN
    chCtrlFrame = CtrlFrame:COM-HANDLE
    UIB_S = chCtrlFrame:LoadControls( OCXFile, "CtrlFrame":U)
  .
  RUN initialize-controls IN THIS-PROCEDURE NO-ERROR.
END.
ELSE MESSAGE "winterfaz_movildyna.wrx":U SKIP(1)
             "The binary control file could not be found. The controls cannot be loaded."
             VIEW-AS ALERT-BOX TITLE "Controls Not Loaded".

&ENDIF

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE crear_caja wWin 
PROCEDURE crear_caja :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE que_caja LIKE Caja.cdg_caja.

    RUN getparametro_n.p (  INPUT  "DFNROCAJ", OUTPUT que_caja ).
    FIND Caja WHERE Caja.cdg_caja = que_caja NO-LOCK.

    FIND Familia_cliente OF Administrador NO-LOCK.

    FIND FIRST Moneda WHERE Moneda.es_local NO-LOCK.
 
    CREATE T-Caj_header.
    BUFFER-COPY T-Rendicion_hd TO T-Caj_header
        ASSIGN T-Caj_header.fecha           = T-Rendicion_hd.fch_rendicion
               T-Caj_header.hora            = TIME
               T-Caj_header.ultima_linea    = 0
               T-Caj_header.importe         = T-Rendicion_hd.imp_imputado
               T-Caj_header.emitir          = NO
               T-Caj_header.cdg_caja        = Caja.cdg_caja
               T-Caj_header.nro_cuenta      = Familia_cliente.nro_cuenta
               T-Caj_header.observacion     = Administrador.cdg_cliente + "-" + Administrador.nom_cliente
               T-Caj_header.nro_cliente     = Administrador.nro_cliente
               T-Caj_header.tipo_mov        = "I"
               T-Caj_header.nro_moneda      = Moneda.nro_moneda
               T-Caj_header.cdg_comprobante = "RECIBCLI".

    EMPTY TEMP-TABLE T-Caja-imputacion.
    RUN crear_caja_imputacion.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE crear_caja_imputacion wWin 
PROCEDURE crear_caja_imputacion :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/


    CREATE T-Caja-imputacion.
    ASSIGN T-Caja-imputacion.nro_cuenta       = Familia_cliente.nro_cuenta
           T-Caja-imputacion.nro_entidad      = Caja.nro_entidad
           T-Caja-imputacion.nro_obra         = 0
           T-Caja-imputacion.nro_transaccion  = T-Caj_header.nro_transaccion
           T-Caja-imputacion.observacion      = ""
           T-Caja-imputacion.valor            = T-Caj_header.importe.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI wWin  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wWin)
  THEN DELETE WIDGET wWin.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI wWin  _DEFAULT-ENABLE
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
  DISPLAY fmesg 
      WITH FRAME fMain IN WINDOW wWin.
  ENABLE fmesg BUTTON-1 
      WITH FRAME fMain IN WINDOW wWin.
  {&OPEN-BROWSERS-IN-QUERY-fMain}
  VIEW wWin.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE exitObject wWin 
PROCEDURE exitObject :
/*------------------------------------------------------------------------------
  Purpose:  Window-specific override of this procedure which destroys 
            its contents and itself.
    Notes:  
------------------------------------------------------------------------------*/

  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE initializeObject wWin 
PROCEDURE initializeObject :
/*------------------------------------------------------------------------------
  Purpose:     Super Override
  Parameters:  
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  RUN SUPER.

  /* Code placed here will execute AFTER standard behavior.    */
  fmesg:SCREEN-VALUE IN FRAME {&FRAME-NAME}= "Esperando iniciar".
  IF NOT SETUSERID("MOVILDYN","movildyna") THEN do:
    MESSAGE "Error al setear el uid".
    RETURN ERROR.
  END.
  fmin = TODAY.
  fmax = suma_dia_habil(fmin, 7,"23456").
  ahora = STRING(YEAR(TODAY) * 10000 + MONTH(TODAY) * 100 + DAY(TODAY)) + "-" + STRING(time, "HH:MM").
  ahora = REPLACE(ahora,":","-").

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE interfazrec wWin 
PROCEDURE interfazrec :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
{findempresa.i}
fmesg( "Comienzo de Sincronizacion Movildyna" ).
OS-DELETE VALUE(SESSION:TEMP-DIR + "clientes.md").
OUTPUT STREAM adm TO value(SESSION:TEMP-DIR + "clientes.md").
OS-DELETE VALUE(SESSION:TEMP-DIR + "ctacte.md").
OUTPUT STREAM ctacte TO value(SESSION:TEMP-DIR + "ctacte.md").
OS-DELETE VALUE(SESSION:TEMP-DIR + "rutheader.d").
OUTPUT STREAM ruth TO value(SESSION:TEMP-DIR + "rutheader.md").
OS-DELETE VALUE(SESSION:TEMP-DIR + "rutdet.d").
OUTPUT STREAM rutd TO value(SESSION:TEMP-DIR + "rutdet.md").
OS-DELETE VALUE(SESSION:TEMP-DIR + "descrec.d").
OUTPUT STREAM descrec TO value(SESSION:TEMP-DIR + "descrec.md").
OS-DELETE VALUE(SESSION:TEMP-DIR + "aacobranza.md").
OS-DELETE VALUE(SESSION:TEMP-DIR + "aafactura.md").
OS-DELETE VALUE(SESSION:TEMP-DIR + "aavalores.md").

FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "CO" NO-LOCK.
nroco = tipo_evento.nro_tipo_evento.
EXPORT STREAM rutd DELIMITER ","
        "rus_cod"
        "rus_seq"
        "rus_cli"
        "rus_vta"
        "prefijo"
        "cola"
        "colb".
EXPORT STREAM adm DELIMITER ","
        "cli_cod"
        "cli_nom"
        "cli_dir"
        "cli_di2"
        "cli_di3"
        "cli_codpos"
        "cli_pais"
        "Cli_tel"
        "matriz"
        "cli_iva"
        "prefijo"
        "saldoact"
        "desc_glob"
        "cli_lim"
        "cuit"
        "nroIB"
        "porcpercIB"
        "condpag"
        "Tipo"
        "Entrega"
        "cli_pre"
        "lat"
        "long".
EXPORT STREAM ctacte DELIMITER "," 
        "prefijo"
        "cli_cod"
        "tip_comprob"
        "prf_comprob"
        "nro_comprob"
        "fecemi"
        "fecven"
        "imp_tot"
        "imp_deu"
        "descrip".
EXPORT STREAM ruth DELIMITER ","
        "prefijo"
        "dia"
        "rut_tip"
        "rut_des"
        "rut_cod"
        "cdg_vend".
EXPORT STREAM descrec DELIMITER ","
        "prefijo"
        "cli_cod"
        "des_plazo"
        "des_porc".
k = 0.
FOR EACH evento WHERE evento.nro_tipo_evento = nroco AND NOT evento.anulado AND
    evento.frealizado = ? AND evento.fasignado >=fmin AND 
    evento.fasignado <=fmax, administrador OF evento NO-LOCK BREAK BY evento.nro_cliente BY evento.fasignado BY evento.hora_desde BY evento.recursos  :
    FIND FIRST domicilio OF administrador NO-LOCK.
    find cliente-contacto OF domicilio WHERE cliente-contacto.preferido NO-LOCK NO-ERROR.
    IF AVAILABLE cliente-contacto THEN
        FIND persona OF cliente-contacto NO-LOCK NO-ERROR.

    IF NOT FIRST-OF(evento.nro_cliente) THEN NEXT.
    
    EXPORT STREAM adm DELIMITER ","
        administrador.cdg_cliente 
        administrador.nom_cliente 
        administrador.direccion 
        administrador.localidad 
        "" 
        administrador.cdg_postal 
        "Argentina"
        (IF AVAILABLE persona THEN telef(Persona.numeros_telefono) ELSE "") 
        administrador.cdg_cliente 
        73
        "AA"
        saldoact 
        "0"
        "0"
        administrador.cuit 
        ""
        "0.0"
        administrador.hat 
        ""
        ""
        "0" 
        administrador.geolat 
        administrador.geolong .
        
        k = k + 1.
        EXPORT STREAM rutd DELIMITER ","
        SUBSTRING(evento.recursos,3,1) + string(DAY(evento.fasignado),"99") + string(MONTH(evento.fasignado),"99") 
        k 
        administrador.cdg_cliente 
        ""
        "AA"
        evento.hora_desde
        evento.hora_hasta.

    IF FIRST-OF( evento.recursos ) THEN DO:
        dia = WEEKDAY(evento.fasignado) - 1.
        IF dia = 0 THEN dia = 7.
        EXPORT STREAM ruth DELIMITER ","
        "AA"
        dia
        "C"
        STRING(evento.recursos) + "-" + string(DAY(evento.fasignado),"99") + "-" + string(MONTH(evento.fasignado),"99") 
        SUBSTRING(evento.recursos,3,1) + string(DAY(evento.fasignado),"99") + string(MONTH(evento.fasignado),"99") 
        STRING(evento.recursos).
    END.

    EXPORT STREAM descrec DELIMITER ","
        "AA"
        administrador.cdg_cliente
        "0"
        administrador.hat.


    /*exportar las facturar pendientes*/

    FOR EACH Cta_cte NO-LOCK
                WHERE cta_cte.nro_administrador = administrador.nro_cliente
                  AND Cta_cte.cdg_empresa     = Empresa.cdg_empresa
                  AND Cta_cte.fecha_emision  <= p-has_fecha
                  AND Cta_cte.debito <> Cta_cte.credito 
                       BY cta_cte.fecha_emision:

                IF NOT CAN-DO(p-punto-vta, string(cta_cte.prf_comprob,"9999") ) THEN NEXT.
                IF cta_cte.fecha_vencimiento > p-vencimiento THEN NEXT.
                FIND FIRST Tipocomprobante OF Cta_cte NO-LOCK.
                FIND FIRST cliente OF cta_cte NO-LOCK. 

                FIND fac_header WHERE 
                    fac_header.cdg_empresa = cta_cte.cdg_empresa AND
                    fac_header.tip_comprob = cta_cte.tip_comprob AND
                    fac_header.prf_comprob = cta_cte.prf_comprob AND
                    fac_header.nro_comprob = cta_cte.nro_comprob NO-LOCK.

                /*salir con FACTURA*/
                EXPORT STREAM ctacte DELIMITER "," 
                    "AA" 
                    administrador.cdg_cliente 
                    cta_cte.tip_comprob 
                    cta_cte.prf_comprob 
                    cta_cte.nro_comprob 
                    fac_header.fecha 
                    cta_cte.fecha_vencimiento 
                    Fac_header.imp_total 
                    cta_cte.debito - cta_cte.credito 
                    fac_header.nombre.
    END. /* De los movimientos de un administador */
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE interfazsal wWin 
PROCEDURE interfazsal :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*mandar al site*/
OUTPUT STREAM adm CLOSE.
OUTPUT STREAM ctacte CLOSE.
OUTPUT STREAM ruth CLOSE.
OUTPUT STREAM rutd CLOSE.
OUTPUT STREAM descrec CLOSE.
DEFINE VAR evento_curso LIKE evento.nro_evento.
DEFINE VAR  v_prox_cob AS CHAR NO-UNDO.
DEFINE VAR cURL AS CHAR INITIAL "paulista.movildyna.com.ar" NO-UNDO.
DEFINE VAR cUser AS CHAR INITIAL "paulista@movildyna.com.ar" NO-UNDO.
DEFINE VAR cPasswd AS CHAR INITIAL "vero2471" NO-UNDO.
DEFINE VARIABLE vhost AS CHARACTER  NO-UNDO.
DEFINE VARIABLE vport AS CHARACTER  NO-UNDO.
DEFINE VARIABLE vpath AS CHARACTER  NO-UNDO.
DEFINE VARIABLE vfile AS CHARACTER  NO-UNDO.
DEFINE VAR enviar AS CHAR INITIAL "clientes.md,ctacte.md,rutheader.md,rutdet.md,descrec.md".
DEFINE VAR traer AS CHAR INITIAL "aacobranza.md,aafactura.md,aavalores.md".
DEFINE VAR estado AS CHAR NO-UNDO.
DEFINE VAR acumulado AS DECIMAL.
DEFINE VAR acumulFAC AS DECIMAL.
DEFINE VAR hhasta AS CHAR NO-UNDO.
estado = "".
if not ConnectWinInet() THEN DO:
      fmesg( substitute('No se puede establecer conexion con &1.',
                         cURL) ).
      RETURN.
END.


/*-----------------------------------------------------------------------
Start and FTP Sesion.
------------------------------------------------------------------------*/
if FTPConnect(cURL,cuser,cpasswd) then
do:
/*----------------------------------------------------------------------- 
 XBajada
------------------------------------------------------------------------*/
  REPEAT k = 1 TO NUM-ENTRIES(traer):
     FtpDeleteFile(ENTRY(k,traer)).
     estado = "R".
  END.

  RUN adecomm/_tmpfile.p ("i", ".htm", OUTPUT vfile).
  RUN UrlParser(INPUT "Http://" + cURL + "/xbajada-paulista.php", OUTPUT vhost, OUTPUT vport, OUTPUT vpath).
  RUN HTTPGet(vhost, vport, vpath, vfile).
END.

 /*----------------------------------------------------------------------- 
 Traer los archivos de resultado de la cobranza
------------------------------------------------------------------------*/

REPEAT k = 1 TO NUM-ENTRIES(traer):
     FtpGetFile(input SESSION:TEMP-DIR + ENTRY(k,traer),
     input ENTRY(k,traer) ).
     estado = "R".
     IF SEARCH( SESSION:TEMP-DIR + ENTRY(k,traer) ) <> ? THEN
        OS-COPY value(SESSION:TEMP-DIR + ENTRY(k,traer) ) value( "C:\Dynasys10\logs\MovildynaData\" + AHORA + ENTRY(k,traer) ). 
END.


if FTPConnect(cURL,cuser,cpasswd) then
do:
 /*----------------------------------------------------------------------- 
 Enviar nuevos datos
------------------------------------------------------------------------*/
REPEAT k = 1 TO NUM-ENTRIES(enviar):
     IF SEARCH( SESSION:TEMP-DIR + ENTRY(k,enviar) ) = ? THEN NEXT.
     FtpPutFile(input SESSION:TEMP-DIR + ENTRY(k,enviar), input ENTRY(k,enviar) ).
      estado = "T".
END.
REPEAT k = 1 TO NUM-ENTRIES(enviar):
    IF SEARCH( SESSION:TEMP-DIR + ENTRY(k,enviar) ) <> ? THEN
      OS-COPY value(SESSION:TEMP-DIR + ENTRY(k,enviar) ) value( "C:\Dynasys10\logs\MovildynaData\" + AHORA + ENTRY(k,enviar) ). 
END.

end.
/*----------------------------------------------------------------------- 
 SincroBAs
------------------------------------------------------------------------*/
IF estado = "T" THEN DO:
  RUN adecomm/_tmpfile.p ("i", ".htm", OUTPUT vfile).
  RUN UrlParser(INPUT "Http://" + cURL + "/sincro-paulista-si.php", OUTPUT vhost, OUTPUT vport, OUTPUT vpath).
  RUN HTTPGet(vhost, vport, vpath, vfile).
END.


/*aplicar la cobranza desde los archivos la cobranza esta siempre balanceada*/
IF SEARCH( SESSION:TEMP-DIR + "aacobranza.md" ) = ?  THEN DO:
    fmesg( "Error al traer archivo cobranzas").
    RETURN ERROR.
END.
/*generamos el backup para el posterior uso*/

INPUT STREAM cobranza FROM value(SESSION:TEMP-DIR + "aacobranza.md").
REPEAT:
    CREATE cobranza.
    IMPORT STREAM cobranza DELIMITER ";"
        COBRANZA.nro_cobSRV
        ^
        v-cdg_cobrador
        ^
        v-cdg_cliente
        v_fecha_visita
        v_prox_cob.
    IF COBRANZA.nro_cobSRV = "" THEN UNDO, LEAVE.
    d_fch_cob = DATE( int(SUBSTRING( v_fecha_visita , 6,2)), int(SUBSTRING( v_fecha_visita,9,2 )), int(SUBSTRING( v_fecha_visita,1,4))).
    hdesde = SUBSTRING( v_fecha_visita , 12,5 ).
    hhasta = ajuh( string( addmil( aint( hdesde ), 30 ) ) ).
    d_prox_cob = DATE( int(SUBSTRING( v_prox_cob , 6,2)), int(SUBSTRING( v_prox_cob,9,2 )), int(SUBSTRING( v_prox_cob,1,4))) NO-ERROR.
    IF ERROR-STATUS:ERROR THEN DO:
        d_prox_cob = d_fch_cob.
    END.
    /*ver de saltar el feriado*/
END.
INPUT STREAM cobranza CLOSE.
 
INPUT STREAM factura FROM value(SESSION:TEMP-DIR + "aafactura.md").
REPEAT:
    CREATE factura.
    IMPORT STREAM factura DELIMITER ";"
        FACTURA.nro_cobSRV
        ^
        ^
        ^
        factura.tip_comprob
        factura.prf_comprob
        factura.nro_comprob
        importe
        observ.
    IF FACTURA.nro_cobSRV = "" THEN UNDO, LEAVE.
END.
INPUT STREAM factura CLOSE.

INPUT STREAM valores FROM value(SESSION:TEMP-DIR + "aavalores.md").
REPEAT:
    CREATE valores.
    IMPORT STREAM valores DELIMITER ";"
        VALORES.nro_cobSRV
        ^
        ^
        ^
        VALORES.nro_tipo_valor
        VALORES.codban
        VALORES.numsub
        VALORES.numche
        v_prox_cob
        VALORES.importe
        VALORES.tipo_cheque.
    IF VALORES.nro_cobSRV = "" THEN UNDO, LEAVE.
    valores.fecha = DATE( int(SUBSTRING( v_prox_cob , 6,2)), int(SUBSTRING( v_prox_cob,9,2 )), int(SUBSTRING( v_prox_cob,1,4))).    
END.
INPUT STREAM valores CLOSE.


FOR EACH cobranza WHERE COBRANZA.NRO_COBsrv <> "":
    EMPTY TEMP-TABLE t-rendicion_hd.
    EMPTY TEMP-TABLE t-caj_header.
    EMPTY TEMP-TABLE t-caj_detalle.
    EMPTY TEMP-TABLE t-valor.
    EMPTY TEMP-TABLE t-cheque.
    FIND administrador WHERE Administrador.cdg_cliente = v-cdg_cliente NO-ERROR.
    IF NOT AVAILABLE administrador THEN do:
        fmesg ( "Administrador " + v-cdg_cliente + " no registrado" ).
        RETURN ERROR.
    END.
    FIND Cobrador WHERE Cobrador.cdg_cobrador = v-cdg_cobrador NO-LOCK NO-ERROR.
    IF NOT AVAILABLE Cobrador THEN do:
        fmesg( "Cobrador " + v-cdg_cobrador + " no registrado" ).
        RETURN ERROR.
    END.
    CREATE T-Rendicion_hd.
     ASSIGN T-Rendicion_hd.canal = "MD"
            T-Rendicion_hd.tipo = "1"
            T-Rendicion_hd.cdg_empresa        = Empresa.cdg_empresa
            T-Rendicion_hd.fch_rendicion      = d_fch_cob
            T-Rendicion_hd.abierta            = YES
            T-Rendicion_hd.nro_administrador  = Administrador.nro_cliente
            T-Rendicion_hd.nro_cobrador = Cobrador.nro_cobrador.
     FIND tipo_evento WHERE cdg_tipo_evento = "CO" NO-LOCK NO-ERROR.
     IF NOT AVAILABLE  tipo_evento THEN do:
         fmesg( "Tipo Evento CO no registrado" ).
         RETURN ERROR.
     END.
     FIND FIRST evento WHERE evento.nro_tipo_evento = tipo_evento.nro_tipo_evento AND
                 evento.nro_cliente = administrador.nro_cliente AND
                 evento.frealizado = ?  AND 
                 NOT evento.anulado NO-ERROR. 
      IF AVAILABLE evento THEN DO:
          evento_curso = evento.nro_evento.
      END.
      ELSE DO:
          CREATE evento.
          ASSIGN evento.nro_tipo_evento = tipo_evento.nro_tipo_evento
                 evento.recursos =  v-cdg_cobrador
                 evento.nro_cliente = administrador.nro_cliente
                 evento.observacion = agregaAdvTexto("MD-[SRV" + STRING(cobranza.nro_cobsrv) + "]",evento.observacion)
                 evento.nro_evento = NEXT-VALUE(proximo_evento)
                 evento.origen = "COBRANZA"
                 evento.nro_identificacion = 0
                 evento.fmin = d_fch_cob
                 evento.fmax = d_fch_cob
                 evento.turno = "**"
                 evento.fcreado = TODAY
                 evento.periodo = YEAR( d_fch_cob ) * 10 + MONTH( d_fch_cob ).
                 evento_curso = evento.nro_evento.
      END.
      ASSIGN evento.fasignado = d_fch_cob
             evento.frealizado = d_fch_cob
             evento.hora_desde = hdesde
             evento.duracion = adur(hdesde,hhasta) 
             evento.hora_hasta = hhasta
             t-rendicion_hd.nro_evento = evento_curso
             evento.observacion = agregaAdvTexto("MD-Carga cobranza [SRV" + STRING(cobranza.nro_cobsrv) + "]" ,evento.observacion).
      
      IF d_prox_cob <> d_fch_cob THEN DO:
          FIND restriccion no-lock WHERE restriccion.cdg_restriccion = "FECHAC" NO-ERROR.
          FIND FIRST cliente_restriccion OF administrador WHERE cliente_restriccion.nro_restriccion = restriccion.nro_restriccion NO-ERROR.
          IF NOT AVAILABLE cliente_restriccion THEN DO:
              CREATE cliente_restriccion.
              ASSIGN cliente_restriccion.nro_cliente = administrador.nro_cliente
                     cliente_restriccion.nro_restriccion = restriccion.nro_restriccion
                     cliente_restriccion.valor = "N|" + STRING(d_prox_cob).
          END.
          ELSE DO:
              ASSIGN ENTRY(2,cliente_restriccion.valor,"|") = STRING(d_prox_cob).
          END.
          /*IF NUM-ENTRIES(cliente_restriccion.valor,"|") < 2 THEN 
                cliente_restriccion.valor = cliente_restriccion.valor + "|?".
          ELSE DO:
                ASSIGN ENTRY(2,cliente_restriccion.valor,"|") = IF d_prox_cob = ? THEN "?" ELSE STRING(d_prox_cob).
          END.*/       
      END.
      RUN crear_caja.
      T-Caj_header.observacion = "[SRV" + STRING(cobranza.nro_cobsrv) + "] " + T-Caj_header.observacion.
      /*va a terceros o propios eso lo define los comprobantes que integran la cobranza con uno solo de FC va todo a terceros*/
      /*valores Cobrados*/
      k = 0.
      acumulado = 0.
      acumulfac = 0.
      FIND FIRST T-Caj_header EXCLUSIVE-LOCK.
      FOR EACH valores WHERE valores.nro_cobSRV = cobranza.nro_cobSRV:
          IF valores.importe = 0 THEN NEXT.
          CREATE t-caj_detalle.
          BUFFER-COPY t-caj_header TO t-caj_detalle.
          ASSIGN k = k + 1
                 t-Caj_detalle.importe = valores.importe
                 t-caj_detalle.nro_linea = k
                 t-Caj_detalle.tipo_mov = "I"
                 t-caj_detalle.observacion = "[SRV" + STRING(cobranza.nro_cobsrv) + "] ".
                 
          CASE nro_tipo_valor:
              WHEN "0" THEN do:
                  valores.rubro = 1.
              END.
              WHEN "2" THEN do:
                  valores.rubro = 40.
              END.
              WHEN "1" THEN do:
                  IF CAN-FIND(FIRST bfactura WHERE bfactura.nro_cobSRV = cobranza.nro_cobSRV AND bfactura.tip_comprob = "FC") THEN valores.rubro = 4.
                  ELSE do:
                      valores.rubro = 2.
                      IF valores.tipo_cheque = "2" THEN valores.rubro = 4. 
                      ELSE valores.rubro= 2.
                  END.
                  CREATE T-Valor.
                  ASSIGN   T-Valor.cdg_empresa     = T-Caj_header.cdg_empresa
                           T-Valor.nro_valor       = T-Caj_detalle.nro_linea
                           T-Valor.estado          = "**"
                           T-Caj_detalle.nro_valor = T-Valor.nro_valor
                           T-Valor.cdg_banco = int(codban)         
                           T-Valor.cdg_sucurbanco = int(valores.numsub)
                           T-Valor.dias_clearing = 2
                           T-Valor.fecha_acredita = valores.fecha + 2                       
                           T-Valor.fecha_deposito = valores.fecha  
                           T-Valor.fecha_emision = valores.fecha
                           T-valor.cdg_rubro = valores.rubro
                           T-Valor.numero_cheque = int(valores.numche).

               ASSIGN T-Valor.importe = T-Caj_detalle.importe.
                      
                      
              END.
              WHEN "-1" THEN do:
                  valores.rubro = 10.
              END.
              OTHERWISE valores.rubro = 1.
          END CASE.
          ASSIGN 
               t-caj_detalle.cdg_rubro = valores.rubro.           
               acumulado = acumulado + valores.importe.
      END.
      /*Facturas Cobradas llevar las facturas cobradas a T-caj_detalle*/
      FOR EACH factura WHERE factura.nro_cobSRV = cobranza.nro_cobSRV:
             FIND fac_header WHERE 
                    fac_header.cdg_empresa = T-Rendicion_hd.cdg_empresa  AND
                    fac_header.tip_comprob = factura.tip_comprob AND
                    fac_header.prf_comprob = factura.prf_comprob AND
                    fac_header.nro_comprob = factura.nro_comprob NO-LOCK NO-ERROR.
             IF NOT AVAILABLE fac_header THEN do:
                 fmesg( "Factura " + factura.tip_comprob  + string(factura.prf_comprob,"9999")  +  string(factura.nro_comprob,"99999999") + " no registrado" ).
                 RETURN ERROR.
             END.
             CREATE t-comprobante_rendicion.
             ASSIGN t-comprobante_rendicion.tip_comprob = factura.tip_comprob
                    t-comprobante_rendicion.prf_comprob = factura.prf_comprob
                    t-comprobante_rendicion.nro_comprob = factura.nro_comprob
                    t-comprobante_rendicion.cdg_empresa = T-Rendicion_hd.cdg_empresa 
                    t-comprobante_rendicion.este_pago = factura.importe
                    t-comprobante_rendicion.nro_comprob = fac_header.nro_comprob
                    t-comprobante_rendicion.nro_rendicion =  T-Rendicion_hd.nro_rendicion.
             ASSIGN T-Rendicion_hd.cant_recibos = T-Rendicion_hd.cant_recibos + 1
                    T-Rendicion_hd.imp_imputado = T-Rendicion_hd.imp_imputado + 
                                                  factura.importe
                    acumulfac = acumulfac + factura.importe.
      END.
      IF ABS(acumulfac - acumulado) > 1 THEN DO:
          CREATE t-Caj_detalle.
          ASSIGN k = k + 1
                 t-Caj_detalle.importe = acumulfac - acumulado
                 t-caj_detalle.nro_linea = k
                 t-Caj_detalle.tipo_mov = "I"
                 t-caj_detalle.cdg_rubro = 40
                 t-caj_detalle.observacion = "COMPENSA Automatica [SRV" + STRING(cobranza.nro_cobsrv) + "] ". /*Compensaciones creara un deb o credito adicional*/
      END.
      /*ver que pasa si no balancea siempre sobra en ese caso compensaria*/
      RUN completar_auditoria.p ( OUTPUT T-Rendicion_hd.nro_usuario,
                                  OUTPUT T-Rendicion_hd.fecha_grab,
                                  OUTPUT T-Rendicion_hd.hora_grab,
                                  OUTPUT T-Rendicion_hd.pc_name).
      RUN cierrarendicion.p ( INPUT-OUTPUT TABLE T-Rendicion_hd,
                              INPUT-OUTPUT TABLE T-comprobante_rendicion,
                              INPUT-OUTPUT TABLE T-Caj_header,       
                              INPUT-OUTPUT TABLE T-Caj_detalle,      
                              INPUT-OUTPUT TABLE T-Caja-imputacion,  
                              INPUT-OUTPUT TABLE T-Cheque,           
                              INPUT-OUTPUT TABLE T-Valor
                              ).
      EMPTY TEMP-TABLE T-Rendicion_hd.
      EMPTY TEMP-TABLE T-comprobante_rendicion.
      EMPTY TEMP-TABLE T-Caj_header.
      EMPTY TEMP-TABLE T-Caj_detalle.
      EMPTY TEMP-TABLE T-Caja-imputacion.
      EMPTY TEMP-TABLE T-Cheque.
      EMPTY TEMP-TABLE T-Valor.
      CloseInternetConnection( hInternetSession ).
      hInternetSession = ?. 
      hFTPSession = ?.
END.
fmesg( "Fin Sincronismo" ).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fmesg wWin 
FUNCTION fmesg RETURNS CHARACTER
  ( ch AS CHAR ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
  fmesg:SCREEN-VALUE IN FRAME {&FRAME-NAME} = ch.
  OUTPUT STREAM LOG TO "C:\Dynasys10\logs\Movildyna.LOG" APPEND.
  PUT STREAM LOG ch SKIP.
  OUTPUT STREAM LOG CLOSE.
  RETURN "".   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION telef wWin 
FUNCTION telef RETURNS CHARACTER
  (aa AS CHAR) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEFINE VAR s AS CHAR NO-UNDO.
    DEFINE VAR t AS INT NO-UNDO.
    REPEAT t = 1 TO NUM-ENTRIES( aa , "|") :
    IF ENTRY( 2 , ENTRY( t , aa , "|") , "!") <> "" THEN
    s = s + ";" + ENTRY( 2 , ENTRY( t , aa , "|" ) , "!").
    END.
    RETURN SUBSTRING(s,2).
    END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

