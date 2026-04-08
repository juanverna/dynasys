 /*interfaz con movildyna
ver los eventos de cobranzas pendientes de los proximos 7 dias y armar los archivos */
/*los eventos no se repiten solo hay uno por cada cobranza abierta*/

{ftp.i}
{httpget.i }
{advtexto.i}
{tiempo.i}
{VRSHARED.I NEW}
FUNCTION telef RETURNS CHAR ( aa AS CHAR ):
    DEFINE VAR s AS CHAR NO-UNDO.
    DEFINE VAR t AS INT NO-UNDO.
    REPEAT t = 1 TO NUM-ENTRIES( aa , "|") :
        IF ENTRY( 2 , ENTRY( t , aa , "|") , "!") <> "" THEN
            s = s + ";" + ENTRY( 2 , ENTRY( t , aa , "|" ) , "!").
    END.
    RETURN SUBSTRING(s,2).
END.

SESSION:NUMERIC-FORMAT = "American" .  
DEFINE BUFFER administrador FOR cliente.
DEF VAR nroco LIKE evento.nro_tipo_evento NO-UNDO.
DEF VAR fmin AS DATE NO-UNDO.
DEF VAR fmax AS DATE NO-UNDO.
DEFINE VAR p-has_fecha AS DATE NO-UNDO.
DEFINE VAR p-vencimiento AS DATE NO-UNDO.
DEFINE VAR p-punto-vta AS CHAR INITIAL "*" NO-UNDO.
p-has_fecha = TODAY.
p-vencimiento = 01/01/3000.
DEFINE STREAM adm.
DEFINE STREAM ctacte.
DEFINE STREAM ruth.
DEFINE STREAM rutd.
DEFINE STREAM descrec.
DEFINE STREAM cobranza.
DEFINE STREAM factura.
DEFINE STREAM valores.
DEFINE VAR saldoact AS DECIMAL.
DEFINE VAR k AS INT NO-UNDO.
DEFINE VAR dia AS INT NO-UNDO.
DEFINE VAR AHORA AS CHAR NO-UNDO.
DEFINE VAR ERRORESFECHA AS CHAR NO-UNDO.
DEFINE VAR EF AS CHAR NO-UNDO.

DEFINE TEMP-TABLE T-Caja-imputacion NO-UNDO LIKE Caja-imputacion.
DEFINE TEMP-TABLE T-Caj_detalle NO-UNDO LIKE Caj_detalle.
DEFINE TEMP-TABLE T-Caj_header NO-UNDO LIKE Caj_header.
DEFINE TEMP-TABLE T-Cheque NO-UNDO LIKE Cheque.
DEFINE TEMP-TABLE T-comprobante_rendicion NO-UNDO LIKE comprobante_rendicion.
DEFINE TEMP-TABLE T-Rendicion_hd NO-UNDO LIKE Rendicion_hd.
DEFINE TEMP-TABLE T-Valor NO-UNDO LIKE Valor.
DEFINE BUFFER brendicion_hd FOR rendicion_hd.
DEFINE VAR mdcorre AS char NO-UNDO.


PROCEDURE fin_error:
    DEFINE INPUT PARAMETER msg AS CHAR.
      MESSAGE msg.
      IF hInternetSession <> ?  THEN
      CloseInternetConnection( hInternetSession ).
      hInternetSession = ? NO-ERROR. 
      hFTPSession = ? NO-ERROR.
      QUIT.
END PROCEDURE.

PROCEDURE crear_caja:
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
        ASSIGN T-Caj_header.fecha           = TODAY /*T-Rendicion_hd.fch_rendicion*/
               T-Caj_header.hora            = TIME
               T-Caj_header.ultima_linea    = 0
               T-Caj_header.importe         = abs(T-Rendicion_hd.imp_imputado)
               T-Caj_header.emitir          = NO
               T-Caj_header.cdg_caja        = Caja.cdg_caja
               T-Caj_header.nro_cuenta      = Familia_cliente.nro_cuenta
               T-Caj_header.observacion     = Administrador.cdg_cliente + "-" + Administrador.nom_cliente
               T-Caj_header.nro_cliente     = Administrador.nro_cliente
               T-Caj_header.tipo_mov        = IF T-Rendicion_hd.imp_imputado >= 0 THEN "I" ELSE "E"
               T-Caj_header.nro_moneda      = Moneda.nro_moneda
               T-Caj_header.cdg_comprobante = "RECIBCLI".

    EMPTY TEMP-TABLE T-Caja-imputacion.
    RUN crear_caja_imputacion.

END PROCEDURE.

PROCEDURE crear_caja_imputacion:
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

.
fmin = TODAY.
fmax = suma_dia_habil(fmin, 7,"23456").
ahora = STRING(YEAR(TODAY) * 10000 + MONTH(TODAY) * 100 + DAY(TODAY)) + "-" + STRING(time, "HH:MM").
ahora = REPLACE(ahora,":","-").

{findempresa.i}
   
RUN getparametro_c.p("MDCORRE",OUTPUT mdcorre).
IF mdcorre <> "" THEN DO:
    MESSAGE "El sincronicador de Movildyna lo esta ejecutando " mdcorre SKIP
        "si es un error elimine el parametro MDCORRE en blanco" VIEW-AS ALERT-BOX ERROR.
    RETURN.
END.
RUN setparametro.p( "MDCORRE" , USERID , 0 , FALSE , 0 ,"").

IF NOT SETUSERID("MOVILDYN","MOVILDYN") THEN do:
    MESSAGE "Error al setear el uid".
    RETURN ERROR.
END.  

OUTPUT TO "C:\Dynasys10\logs\Movildyna.LOG" APPEND.
MESSAGE NOW.

MESSAGE "Comienzo de Sincronizacion Movildyna" VIEW-AS ALERT-BOX INFORMATION.
OS-DELETE VALUE(SESSION:TEMP-DIR + "aacobranza.md").
OS-DELETE VALUE(SESSION:TEMP-DIR + "aafactura.md").
OS-DELETE VALUE(SESSION:TEMP-DIR + "aavalores.md").
IF SEARCH( SESSION:TEMP-DIR + "aacobranza.md") <> ? THEN do:
    MESSAGE "No se puede continuar no borra " + SESSION:TEMP-DIR + "aacobranza.md" VIEW-AS ALERT-BOX INFORMATION.
    CloseInternetConnection( hInternetSession ).
    hInternetSession = ?. 
    hFTPSession = ?.
    RUN setparametro.p("MDCORRE","",0,FALSE,0,"").
    RETURN.
END.
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
        replace(administrador.nom_cliente,"'","")  
        replace(administrador.direccion,"'","") 
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
        if(evento.hora_desde = ?) THEN "" ELSE evento.hora_desde
        if(evento.hora_hasta = ?) THEN "" ELSE evento.hora_hasta.

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
                IF NOT CAN-DO( "F*,D*" , cta_cte.tip_comprob ) THEN NEXT.

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
                    replace(fac_header.direccion,"'","")  /*en vez de fac_header.nombre*/.
    END. /* De los movimientos de un administador */
END.

/*mandar al site*/
OUTPUT STREAM adm CLOSE.
OUTPUT STREAM ctacte CLOSE.
OUTPUT STREAM ruth CLOSE.
OUTPUT STREAM rutd CLOSE.
OUTPUT STREAM descrec CLOSE.
DEFINE TEMP-TABLE cobranza
    FIELD v-cdg_cobrador AS CHAR
    FIELD v-cdg_cliente  AS CHAR
    FIELD nro_cobSRV AS char
    FIELD v_fecha_visita AS CHAR
    FIELD hdesde AS CHAR
    FIELD hhasta AS CHAR
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
DEFINE VAR evento_curso LIKE evento.nro_evento.
DEFINE VAR  v_prox_cob AS CHAR NO-UNDO.

DEFINE VAR cURL AS CHAR INITIAL "paulista.fvsys.com.ar" NO-UNDO.
DEFINE VAR cUser AS CHAR INITIAL "mdpaulista@fvsys.com.ar" NO-UNDO.
DEFINE VAR cPasswd AS CHAR INITIAL "vero2471" NO-UNDO.
DEFINE VARIABLE vhost AS CHARACTER  NO-UNDO.
DEFINE VARIABLE vport AS CHARACTER  NO-UNDO.
DEFINE VARIABLE vpath AS CHARACTER  NO-UNDO.
DEFINE VARIABLE vfile AS CHARACTER  NO-UNDO.
DEFINE VAR enviar AS CHAR INITIAL "clientes.md,ctacte.md,rutheader.md,rutdet.md,descrec.md".
DEFINE VAR traer AS CHAR INITIAL "aacobranza.md,aafactura.md,aavalores.md".
DEFINE VAR estado AS CHAR NO-UNDO.
DEFINE VAR acumulado AS DECIMAL.
DEFINE VAR acumulFAC AS DECIMAL .
DEFINE VAR todook AS LOGICAL.
DEFINE VAR cobi AS CHAR.
DEFINE VAR codcta AS INT NO-UNDO.
estado = "".
if not ConnectWinInet() THEN DO:
      RUN fin_error ( substitute('No se puede establecer conexion con &1.',
                         cURL) ).
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
  IF SEARCH( vfile ) = ? THEN DO:
      RUN fin_error ( "Error al hacer la bajada " + vfile ) .
  END. 
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
  IF SEARCH( vfile ) = ? THEN DO:
      RUN fin_error ( "Error al hacer la sincronizacion en el server " + vfile ).
  END. 
END.


/*aplicar la cobranza desde los archivos la cobranza esta siempre balanceada*/
IF SEARCH( SESSION:TEMP-DIR + "aacobranza.md" ) = ?  THEN DO:
    RUN fin_error (  "Error al traer archivo cobranzas" ).
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
    cobranza.hdesde = SUBSTRING( v_fecha_visita , 12,5 ).
    cobranza.hhasta = ajuh( string( addmil( aint( cobranza.hdesde ), 30 ) ) ).
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
        nro_tipo_valor
        codban
        numsub
        numche
        v_prox_cob
        importe
        tipo_cheque.
    IF VALORES.nro_cobSRV = "" THEN UNDO, LEAVE.
    valores.fecha = DATE( int(SUBSTRING( v_prox_cob , 6,2)), int(SUBSTRING( v_prox_cob,9,2 )), int(SUBSTRING( v_prox_cob,1,4))).    
END.
INPUT STREAM valores CLOSE.
todook = FALSE.
  DO TRANSACTION:
    FOR EACH cobranza WHERE COBRANZA.NRO_COBsrv <> "":
        FIND rendicion_hd WHERE Rendicion_hd.nro_cobSVR = int(cobranza.nro_cobsrv) AND
             rendicion_hd.st_tesoreria <> "A" NO-LOCK NO-ERROR.
         IF AVAILABLE rendicion_hd THEN UNDO,NEXT.
        todook=TRUE.
        EMPTY TEMP-TABLE t-rendicion_hd.
        EMPTY TEMP-TABLE t-caj_header.
        EMPTY TEMP-TABLE t-caj_detalle.
        EMPTY TEMP-TABLE t-valor.
        EMPTY TEMP-TABLE t-cheque.
        FIND administrador WHERE Administrador.cdg_cliente = v-cdg_cliente NO-ERROR.
        IF NOT AVAILABLE administrador THEN do:
            MESSAGE "Administrador "  + v-cdg_cliente + " no registrado" .
            UNDO,LEAVE.
        END.
        FIND Cobrador WHERE Cobrador.cdg_cobrador = v-cdg_cobrador NO-LOCK NO-ERROR.
        IF NOT AVAILABLE Cobrador THEN do:
            MESSAGE  "Cobrador " + v-cdg_cobrador + " no registrado" .
            UNDO,LEAVE.
        END.
        CREATE T-Rendicion_hd.
         ASSIGN T-Rendicion_hd.canal = "MD"
                T-Rendicion_hd.nro_cobSVR = int(cobranza.nro_cobsrv)
                T-Rendicion_hd.tipo = "1"
                T-Rendicion_hd.cdg_empresa        = Empresa.cdg_empresa
                T-Rendicion_hd.fch_rendicion      = d_fch_cob
                T-Rendicion_hd.abierta            = YES
                T-Rendicion_hd.nro_administrador  = Administrador.nro_cliente
                T-Rendicion_hd.nro_cobrador = Cobrador.nro_cobrador.
         FIND tipo_evento WHERE cdg_tipo_evento = "CO" NO-LOCK NO-ERROR.
         IF NOT AVAILABLE  tipo_evento THEN do:
             MESSAGE "Tipo Evento CO no registrado".
             UNDO,LEAVE.
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
          ASSIGN evento.frealizado = d_fch_cob
                 evento.hora_desde = cobranza.hdesde
                 evento.hora_hasta = cobranza.hhasta
                 evento.duracion = adur(cobranza.hdesde,cobranza.hhasta) 
                 t-rendicion_hd.nro_evento = evento_curso
                 evento.observacion = agregaAdvTexto("MD-Carga cobranza [SRV" + STRING(cobranza.nro_cobsrv) + "]" ,evento.observacion).
          FOR EACH recurso_agenda OF evento:
              recurso_agenda.fecha = evento.frealizado.
          END.
          IF d_prox_cob <> d_fch_cob THEN DO:
              FIND restriccion no-lock WHERE restriccion.cdg_restriccion = "FECHAI" NO-ERROR.
              FIND FIRST cliente_restriccion OF administrador WHERE cliente_restriccion.nro_restriccion = restriccion.nro_restriccion NO-ERROR.
              IF NOT AVAILABLE cliente_restriccion THEN DO:
                  CREATE cliente_restriccion.
                  ASSIGN cliente_restriccion.nro_cliente = administrador.nro_cliente
                         cliente_restriccion.nro_restriccion = restriccion.nro_restriccion
                         cliente_restriccion.valor = STRING(d_prox_cob).
              END.
              ELSE DO:
                  ASSIGN cliente_restriccion.valor = STRING(d_prox_cob).
                  IF NOT es_habil(d_prox_cob,"23456") THEN DO:
                      MESSAGE "Cuidado la cobranza" cobranza.nro_cobSRV administrador.cdg_cliente cobrador.cdg_cobrador
                          "asigno prox fecha NO HABIL".
                      erroresfecha = erroresfecha + "," + cobranza.nro_cobSRV.
                  END.
              END.
          END.
          RUN crear_caja.
          T-Caj_header.observacion = "[SRV" + STRING(cobranza.nro_cobsrv) + "] " + T-Caj_header.observacion.
          /*va a terceros o propios eso lo define los comprobantes que integran la cobranza con uno solo de FC va todo a terceros*/
          /*valores Cobrados*/
          k = 0.
          acumulado = 0.
          acumulfac = 0.
          FIND FIRST T-Caj_header EXCLUSIVE-LOCK.
/*valores*/          
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
                      IF CAN-FIND(FIRST bfactura WHERE bfactura.nro_cobSRV = cobranza.nro_cobSRV AND bfactura.tip_comprob = "FC") then
                          if valores.tipo_cheque = "1" THEN valores.rubro = 4.
                          ELSE valores.rubro = 5.
                      ELSE do:
                          if valores.tipo_cheque = "1" THEN valores.rubro = 2.
                          ELSE valores.rubro = 3.
                      END.
                      codcta = 0.
                      REPEAT:
                          FIND FIRST T-valor WHERE T-valor.cdg_empresa = T-Caj_header.cdg_empresa AND 
                                       T-Valor.cdg_sucurbanc = int(valores.numsub) AND
                                       T-Valor.numero_cheque =  int(valores.numche) AND
                                       T-Valor.cdg_banco = int(codban)  AND
                                       t-valor.numero_cuenta_val = STRING(codcta) NO-ERROR.
                          IF AVAILABLE T-valor THEN codcta = codcta + 1.

                          FIND FIRST valor WHERE valor.cdg_empresa = T-Caj_header.cdg_empresa AND 
                                       Valor.cdg_sucurbanc = int(valores.numsub) AND
                                       Valor.numero_cheque =  int(valores.numche) AND
                                       Valor.cdg_banco = int(codban) AND
                                       valor.numero_cuenta_val = STRING(codcta) NO-LOCK NO-ERROR.
                          IF NOT AVAILABLE valor THEN LEAVE.
                          codcta = codcta + 1.
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
                               t-valor.nro_cliente = Administrador.nro_cliente
                               T-Valor.numero_cheque = int(valores.numche)
                               t-valor.numero_cuenta_val =  STRING(codcta).
                      codcta = 0.

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
                     MESSAGE "Factura " + factura.tip_comprob + string(factura.prf_comprob,"9999") + "-" + string(factura.nro_comprob,"9(8)") + " no registrado" .
                     UNDO,LEAVE.
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
                        t-caj_header.importe = abs(T-Rendicion_hd.imp_imputado).
                        T-Caj_header.tipo_mov = IF T-Rendicion_hd.imp_imputado >= 0 THEN "I" ELSE "E".
                        acumulfac = acumulfac + factura.importe.
          END.
          IF ABS(acumulfac - acumulado) < 2 AND ABS(acumulfac - acumulado) <> 0 THEN DO: /*si es menor a dos pesos redondeo*/
              CREATE t-Caj_detalle.
              ASSIGN k = k + 1
                     t-Caj_detalle.importe = acumulfac - acumulado
                     t-caj_detalle.nro_linea = k
                     t-Caj_detalle.tipo_mov = IF t-Caj_detalle.importe >= 0 THEN "I" ELSE "E"
                     t-caj_detalle.cdg_rubro = 99
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
    END.
    IF todook THEN DO: 
        cobi = "".
        ef = "".
        FOR EACH cobranza WHERE cobranza.nro_cobSRV <> "":
            cobi = cobi + "," + TRIM(cobranza.nro_cobSRV).
            IF LOOKUP(TRIM(cobranza.nro_cobSRV), ERRORESFECHA ) <> 0 THEN DO:
                FIND rendicion_hd WHERE Rendicion_hd.nro_cobSVR = int(cobranza.nro_cobsrv) AND 
                    rendicion_hd.st_tesoreria <> "A" NO-LOCK NO-ERROR.
                ef = ef + STRING( rendicion_hd.nro_rendicion ).
            END.
            ef = "Mal Fecha Prox.Cobranza:" + SUBSTRING(ef,2).
        END.
        cobi = SUBSTRING(cobi,2).
        RUN adecomm/_tmpfile.p ("i", ".htm", OUTPUT vfile).
        RUN UrlParser(INPUT "Http://" + cURL + "/xconf-paulista.php?cob=" + cobi , OUTPUT vhost, OUTPUT vport, OUTPUT vpath).
        MESSAGE "CONFIRMADO" cobi.
        RUN HTTPGet(vhost, vport, vpath, vfile).
        IF SEARCH( vfile ) = ? THEN DO:
          message "Error al confirmar " + cobi .
          UNDO,LEAVE.
        END. 
    END.
  END.
MESSAGE "Fin Sincronismo" VIEW-AS ALERT-BOX INFORMATION.
RUN setparametro.p("MDCORRE","",0,FALSE,0,"").
RUN fin_error ("Fin Sincronismo " + ef).

