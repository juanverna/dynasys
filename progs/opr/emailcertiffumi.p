/*------------------------------------------------------------------------------
  Purpose:  Envia un email con el certificado del tabajo de fumigacion   
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
{findempresa.i} 
{nommeses.i}
{crystal_dyna.p}
{html.i}
{tiempo.i}
{advtexto.i}
    
DEFINE TEMP-TABLE parametros
    FIELD direccion      AS CHAR
    FIELD razon          AS CHAR
    FIELD mesano         AS CHAR
    FIELD operario      AS CHAR
    FIELD proserv       AS CHAR
    FIELD frecuencia    AS CHAR
    FIELD nrocertif     AS CHAR.
DEFINE INPUT PARAMETER pnro AS INT NO-UNDO.
DEFINE INPUT PARAMETER adtest AS CHAR.
DEFINE VAR frecuenciacar AS CHAR INITIAL "Mensual,Bimestral,Trimestral,ada 4 meses,Cara 5 meses,Cara 6 meses,Cara 7 meses,Cara 8 meses,Cara 9 meses,Cara 10 meses,Cara 11 meses,Anual".

DEFINE VAR ERROR_nro AS INT NO-UNDO.
DEF VAR ReportePath AS CHAR NO-UNDO.
DEF VAR cFullPath AS CHAR NO-UNDO.
DEF VAR xFullPath AS CHAR NO-UNDO.
DEFINE VAR proxasignado AS DATE NO-UNDO.

DEFINE VAR estado_var AS CHAR INITIAL "Sin Observacion*,Sin Observacion,Verificar estado Tapas,Verificar estado Mamposteria".
DEFINE VAR fr AS DATE NO-UNDO.
DEFINE VAR ffr AS CHAR NO-UNDO.
IF adtest = "" THEN
    OUTPUT TO c:\dynasys10\logs\emailcertif.txt APPEND.


DEF VARIABLE oSuccessful  AS LOGICAL NO-UNDO.
DEF VARIABLE vmessage  AS CHAR NO-UNDO.
DEFINE VAR i AS INT NO-UNDO.
DEFINE VAR msg1 AS CHAR.
DEFINE VAR msg2 AS CHAR.
DEFINE VAR msg3 AS CHAR.
DEFINE VAR msg4 AS CHAR.
DEFINE VAR firma AS CHAR NO-UNDO.
DEFINE VAR exfile AS CHAR NO-UNDO.
DEFINE VAR img64 AS CHAR NO-UNDO.
DEFINE VAR objMessage AS COM-HANDLE.
DEFINE VAR objConf AS COM-HANDLE.
DEFINE VAR objField AS COM-HANDLE.
DEFINE VAR objBP AS COM-HANDLE.

DEFINE VAR one AS LOGICAL INIT YES.
DEFINE VAR savdir AS CHARACTER NO-UNDO.
DEFINE VAR logo AS CHAR INITIAL "logopau.jpg" NO-UNDO.
DEFINE VAR logof AS CHAR NO-UNDO.
DEFINE BUFFER administracion FOR cliente.
DEFINE VAR proxserv AS CHAR NO-UNDO.
DEFINE VAR vmcba AS LOGICAL.
DEFINE VAR ftipo AS CHAR NO-UNDO.
DEFINE VAR frecuencia AS CHAR NO-UNDO.
DEFINE BUFFER bevento FOR evento.
DEFINE VAR listaev AS CHAR NO-UNDO.
DEFINE VAR k AS INT NO-UNDO.
frecuencia = "".
/*colo emite email con el certificado si ya ha sido impreso con anterioridad*/
FIND evento WHERE evento.nro_evento = pnro NO-ERROR.
IF NOT AVAILABLE evento THEN RETURN ERROR.
/*IF evento.nro_certif = 0 THEN RETURN ERROR.*/
IF evento.nro_tipo_evento <> 1 THEN RETURN ERROR. /*SOLO PARA FU */
savdir = getCurrentDirectory().
RUN fullpath ( logo, INPUT "", OUTPUT logof ).
FIND usuario WHERE usuario.cdg_usuario = USERID("sic").
FOR EACH user_empresa OF usuario BY  User_empresa.rige_desde DESC:
    LEAVE.
END.
IF NOT AVAILABLE USER_empresa THEN DO:
    MESSAGE "Usted no tiene la direccion de email registrada" skip
            "no se enviara email" .
    RETURN ERROR.
END.
IF USER_empresa.email = "" THEN DO:
    MESSAGE "Usted no tiene direccion de email registrada" SKIP
            "no se enviara el email" .
    RETURN ERROR.
END.
FIND cliente OF evento NO-LOCK NO-ERROR.
exFile=replace(cliente.direccion," " , "_"  ).
exFile=replace(exFile,"/" , "_"  ).
exFile=replace(exFile,"*" , "_"  ).
exFile=replace(exFile,"\" , "_"  ).
exFile=replace(exFile,'"' , "_"  ).
exFile=replace(exFile,"'" , "_"  ).
exFile=replace(exFile,"|" , "_"  ).
exFile=replace(exFile,"<" , "_"  ).
exFile=replace(exFile,">" , "_"  ).

exfile = "Certificado_" + exfile + ".pdf".
exportFileName = SESSION:TEMP-DIR + exfile.
OS-DELETE value(exportFileName).
IF ERROR-STATUS:ERROR THEN DO:
    MESSAGE "El archivo " exportFileName " esta siendo usado por otro usuario" SKIP 
            "no se puede proseguir" .
    RETURN ERROR.
END.
/*a quien le enviamos a partir del evento buscar administracion y preferido*/
FIND administracion WHERE administracion.nro_cliente = cliente.nro_admin NO-LOCK NO-ERROR.
IF NOT AVAILABLE administracion THEN RETURN error.
FIND FIRST domicilio OF administracion.
FOR each Cliente-contacto OF Domicilio , Persona OF Cliente-contacto WHERE persona.email <> "" AND  can-do(Cliente-contacto.canal-email,"CERT") :
        LEAVE.
END.
IF NOT AVAILABLE persona THEN do:
   evento.observacion = agregaAdvTexto("ERROR NO Email Certif[falta persona]",evento.observacion).
   LEAVE.
END.

/*listo enviar email a la persona seleccionada*/
FIND restriccion WHERE restriccion.cdg_restriccion BEGINS "EMAIL" NO-LOCK NO-ERROR.
IF NOT AVAILABLE restriccion THEN RETURN ERROR.
FIND cliente_restriccion OF administracion WHERE cliente_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
IF NOT AVAILABLE cliente_restriccion THEN DO:
   evento.observacion = agregaAdvTexto("ERROR NO Email Certif[falta restrccion EMAIL),se asume que se envia",evento.observacion).
END.
ELSE
IF LOOKUP("CERTIF",cliente_restriccion.valor,"|") = 0 THEN DO:
   evento.observacion = agregaAdvTexto("ERROR NO se envia EMAIL porque no hay CERTIF )",evento.observacion).
   LEAVE.
END.
FIND restriccion WHERE restriccion.cdg_restriccion BEGINS "CERTI" AND restriccion.nro_tipo_evento = evento.nro_tipo_evento NO-LOCK NO-ERROR.
IF NOT AVAILABLE restriccion THEN RETURN ERROR.


IF evento.origen = "CONTRATO" THEN DO:
    FIND contrato_hd NO-LOCK WHERE contrato_hd.nro_contrato = evento.nro_identificacion.
    IF NOT AVAILABLE contrato_hd THEN RETURN ERROR.
    IF Contrato_hd.numero_eventos <> evento.sub_evento THEN RETURN ERROR.
    FIND FIRST contrato_restriccion OF restriccion WHERE contrato_restriccion.nro_contrato = evento.nro_identificacion and
           contrato_restriccion.sub_evento = 1 NO-LOCK NO-ERROR.
    IF NOT AVAILABLE contrato_restriccion THEN RETURN ERROR.
    frecuencia = ENTRY( int(contrato_hd.modo_facturacion) , frecuenciacar ).
END.


IF persona.email = "" THEN do:
    evento.observacion = agregaAdvTexto("ERROR EMAIL Certificado la persona " + persona.nombre + " sin email" , evento.observacion ).
    RETURN ERROR.
END.
IF num-entries(persona.email,"@") <> 2 THEN DO:
          evento.observacion = agregaAdvTexto("ERROR EMAIL Certificado la persona " + persona.nombre + " email invalido" , evento.observacion ).
          RETURN ERROR.
      END.
IF NUM-ENTRIES( entry( 2 , persona.email, "@" ) , ".") < 2 THEN DO:
          evento.observacion = agregaAdvTexto("ERROR EMAIL Certificado la persona " + persona.nombre + " email invalido" , evento.observacion ).
          RETURN ERROR.
END.

FIND contrato_hd WHERE contrato_hd.nro_contrato = evento.nro_identificacion.
FIND contrato_restriccion OF restriccion WHERE contrato_restriccion.nro_contrato = evento.nro_identificacion NO-LOCK NO-ERROR.
IF NOT AVAILABLE contrato_restriccion THEN RETURN ERROR.
/*creando el certificado*/
ffr = "Realz:".
fr = evento.frealizado.
IF fr = ? THEN do:
    fr = evento.fasignado.
    ffr = "Asign:".
END.
    
/*veamos el tipo de certificado a emitir*/
vmcba = evento.fasignado >= 11/14/2011.
ftipo = evento.tipo_certif.

ReportePath = "certif_" +  trim( STRING(evento.nro_tipo_evento)) + trim(evento.tipo_certif ) + "email".
RUN fullPath (ReportePath, '.rpt':U, OUTPUT cFullPath).


IF cFullPath = ? 
THEN DO:
    RUN mensajepar.p (INPUT ReportePath, INPUT "CREP000").
    RETURN ERROR.
END.

FIND recurso NO-LOCK WHERE recurso.cdg_recurso = ENTRY(1,evento.recursos).

/*armo una lista de dias asignados*/
proxserv = "".
listaev = "".
REPEAT k = 1 TO evento.sub_evento:
    FOR EACH bevento NO-LOCK WHERE bevento.nro_tipo_evento = evento.nro_tipo_evento AND
    bevento.nro_cliente = evento.nro_cliente AND NOT bevento.anulado AND 
    bevento.periodo = evento.periodo AND
    bevento.sub_evento =  k AND
    bevento.nro_identificacion = evento.nro_identificacion BY bevento.fasignado: 
    IF LOOKUP(string( day( bevento.fasignado) ,">9" ),proxserv ) = 0 THEN
       listaev = listaev + "," + STRING(bevento.nro_evento).
    END.
END.
REPEAT k = 1 TO evento.sub_evento:
    FOR EACH bevento NO-LOCK WHERE bevento.nro_tipo_evento = evento.nro_tipo_evento AND
        bevento.nro_cliente = evento.nro_cliente AND NOT bevento.anulado AND 
        bevento.periodo > evento.periodo AND
        bevento.sub_evento =  k AND
        bevento.nro_identificacion = evento.nro_identificacion BY bevento.fasignado: 
        IF LOOKUP(string( day( bevento.fasignado) ,">9" ),proxserv ) = 0 THEN DO:
              proxserv = proxserv + "," + string( day( bevento.fasignado) ,">9" ) .
              proxasignado = bevento.fasignado.
        END.
        LEAVE.
    END.
END.
proxserv = SUBSTRING(proxserv,2) + SUBSTRING( string(proxasignado,"99/99/9999") , 3 ).
proxserv = REPLACE(proxserv,","," y ").
IF proxserv = "" THEN  proxserv = "Vencimiento: 30 dias".
ELSE proxserv = "Proximo Servicio: " + proxserv.
listaev = SUBSTRING(listaev,2).
    CREATE "CrystalRuntime.Application" chApplication.
    chReport = chApplication:OpenReport(cFullPath, {&crOpenReportByTempCopy}).
    chReport:DiscardSavedData(). /*eliminando lo previamente grabado*/
    CREATE parametros.
  ASSIGN   parametros.direccion  = cliente.direccion + " - " + cliente.localidad.
           parametros.razon = Cliente.nom_cliente.
           parametros.mesano  =  string(fr,"99/99/9999").    
           parametros.operario =  if available recurso then Recurso.nom_recurso else " ".   
           parametros.proserv   = proxserv.
           parametros.frecuencia = frecuencia. 
           parametros.nrocertif = STRING(evento.nro_evento).
          xfile = tempfile("") + ".xml". 
  TEMP-TABLE  parametros:WRITE-XML ("FILE", xfile, FALSE,
                                       ?,"",YES,YES).

   chReport:Database:Tables:item(1):setTableLocation(xfile, '', '').
     
    RUN crearReporte(chReport,"pdf",/*ViewReport*/ NO,/*PrinterName*/ "",
                 /*exportToDisk*/ TRUE, INPUT-OUTPUT exportFileName ).
    IF ERROR-STATUS:ERROR THEN DO:     
        MESSAGE "Existio un problema al generar el reporte" SKIP "no puede continuar" .
        RETURN ERROR.
    END.    
        RELEASE OBJECT chReport. 
        chReport = ?.
        RELEASE OBJECT chApplication.
        chApplication = ?.
       RUN borra_temp ( INPUT xfile, OUTPUT ERROR_nro ).
REPEAT k = 1 TO NUM-ENTRIES(listaev):
  FIND bevento WHERE bevento.nro_evento = INT( ENTRY(k,listaev) ) EXCLUSIVE-LOCK.
  bevento.observacion = agregaAdvTexto("Certif Impr. " + ffr + STRING( fr ),bevento.observacion).
END.

RUN setCurrentDirectoryA(savDir).
msg1 = '<HTML><HEAD><TITLE></TITLE><META HTTP-EQUIV="Content-Type" content="text/html; charset=UTF-8"></HEAD><BODY><p><font face=Tahoma>Atte Adm. '  + html-encode(administracion.nom_cliente) + '</font></p>'.
msg3 = '<p><font face=Tahoma>Enviamos el certificado del trabajo realizado en ' + html-encode(cliente.direccion) + '. </font></p>'.
msg4 = '<p><font face=Tahoma>Recuerde comunicarnos cualquier inquietud relacionada con nuestros servicios, nuestra pol&iacute;tica de calidad persigue su entera satisfacci&oacute;n y la de sus clientes.</font></p><p><font face=Tahoma>Aprovechamos la oportunidad para saludarlo atte.</font></p><p><font face=Tahoma>' + 'Paulista' + '</font></p>'.
        firma= '<p><span><img width=87 height=67 src="cid:logopau.jpg" v:shapes="_x0000_s1026"></span><font face=Tahoma>Tel: 4961-1900</font></p><p><font face=Tahoma><a href="mailto:info@paulistaservicios.com.ar" title="mailto:info@paulistaservicios.com.ar">info@paulistaservicios.com.ar</a></font></p><p><font face=Tahoma><a href="www.paulistaservicios.com.ar" title="www.paulistaservicios.com.ar">www.paulistaservicios.com.ar</font></p><p></BODY></HTML>'.
/*firma= '<p><font face=Tahoma>PAULISTA</font></p><p><font face=Tahoma>Tel: 4961-1900</font></p><p><font face=Tahoma><a href="mailto:info@paulistaservicios.com.ar" title="mailto:info@paulistaservicios.com.ar">info@paulistaservicios.com.ar</a></font></p><p><font face=Tahoma><a href="skype:paulistaservicios" title="Skype:paulistaservicios">Skype:paulistaservicios</font></p><p></BODY></HTML>'.*/

/*mandando el email*/

CREATE "CDO.Message" objMessage.
CREATE "CDO.Configuration" objConf.
objField = objConf:FIELDS.
/*
objField:Item( "http://schemas.microsoft.com/cdo/configuration/sendusing" ) = 1. /*cdoSendUsingPickup*/
objField:Item( "http://schemas.microsoft.com/cdo/configuration/smtpserverpickupdirectory" ) = "c:\temp\pickup" .*/
objField:Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2. /*cdoSendUsingPort*/
objField:Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "smtp.gmail.com". 
objField:Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 465. 
objField:Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1.      
objField:Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = "servicios@paulistaservicios.com.ar".
objField:Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "joseantonio$568".      
objField:Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = TRUE.
objField:Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 100.  
objField:Update.
objMessage:Configuration = objConf.
objMessage:TO = IF adtest = "" THEN persona.email ELSE adtest.
objMessage:FROM =  USER_empresa.email.
objMessage:Subject = "Paulista - Certificado " + html-encode(cliente.direccion).
objMessage:HTMLBody = msg1 + msg3 + msg4 + firma.
/* desde un archivo 'objMessage.CreateMHTMLBody "file://c|/temp/test.htm"*/
objMessage:AddAttachment( "file://" + exportFileName,"","" ).
objBP = objMessage:AddRelatedBodyPart("file://" + logof, logo, 0, , ).
objBP:Fields:Item("urn:schemas:mailheader:Content-ID") = "<" + logo + ">".
objBP:Fields:Update.
objMessage:Send.
PAUSE 2.
IF ERROR-STATUS:ERROR THEN do:
    RELEASE OBJECT objField NO-ERROR.
    RELEASE OBJECT objBP NO-ERROR.
    RELEASE OBJECT objMessage NO-ERROR.
    RELEASE OBJECT objConf NO-ERROR.
    RETURN ERROR.
END.

MESSAGE evento.nro_evento.
evento.observacion = agregaAdvTexto("EMAIL ENVIO Certificado" + persona.email , evento.observacion ).
evento.envio_email = TRUE.
RELEASE OBJECT objField NO-ERROR.
RELEASE OBJECT objBP NO-ERROR.
RELEASE OBJECT objMessage NO-ERROR.
RELEASE OBJECT objConf NO-ERROR.
objConf=?.
objMessage=?.  
objBP=?. 
objField = ?.




