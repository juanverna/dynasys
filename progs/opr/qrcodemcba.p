/*genera la oblea de un evento pasado como parametro*/
USING ThoughtWorks.QRCode.Codec.*.
USING System.Drawing.*.
    
DEFINE TEMP-TABLE oblea NO-UNDO
FIELD url2 LIKE evento.url2
FIELD frealizado LIKE evento.frealizado
FIELD fvencimiento LIKE evento.frealizado
FIELD nro_certif LIKE evento.nro_certif
FIELD tanques AS INT
FIELD cliente AS CHAR 
FIELD imagen AS char.
{advtexto.i}
{crystal_dyna.p}
{impresoras.i}  
{html.i}
{findempresa.i}
        
DEF VAR ReportePath AS CHAR NO-UNDO.
DEF VAR xFullPath AS CHAR NO-UNDO.
DEF VAR cFullPath AS CHAR NO-UNDO.
DEF VAR pemail AS CHAR NO-UNDO.
DEF VAR pnombre AS CHAR NO-UNDO.

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


DEFINE VAR one AS LOGICAL INIT YES.
DEFINE VAR savdir AS CHARACTER NO-UNDO.
DEFINE VAR logo AS CHAR INITIAL "logopau.jpg" NO-UNDO.
DEFINE VAR logof AS CHAR NO-UNDO.
DEFINE BUFFER administracion FOR cliente.
DEFINE VAR k AS INT NO-UNDO.

DEFINE VAR objBP AS COM-HANDLE.
DEFINE INPUT PARAMETER  pnro AS INT.
DEFINE INPUT PARAMETER adtest AS CHAR.

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

IF adtest = "" THEN
    OUTPUT TO c:\dynasys10\logs\emailcertif.txt APPEND.

FUNCTION qrcode RETURNS character ( pp AS CHAR ):
     
    DEFINE VARIABLE oEncoder AS ThoughtWorks.QRCode.Codec.QRCodeEncoder NO-UNDO.
    DEFINE VARIABLE oImage  AS System.Drawing.Image  NO-UNDO.
    DEFINE VAR cc AS CHAR NO-UNDO.
    oEncoder = NEW QRCodeEncoder().
    oEncoder:QRCodeVersion = 7.
    oEncoder:QRCodeErrorCorrect = ThoughtWorks.QRCode.Codec.QRCodeEncoder+ERROR_CORRECTION:L.
    oEncoder:qrcodeEncodeMode = ThoughtWorks.QRCode.Codec.QRCodeEncoder+ENCODE_MODE:byte.
    oImage = oEncoder:Encode("http://www.dghpsh.agcontrol.gob.ar/EDA/Mobile/CEDyT/GetOblea/" + pp ).
    DELETE OBJECT oEncoder.
    cc = TempFile("") + STRING(evento.url1) + ".bmp".
    oImage:Save( cc,System.Drawing.Imaging.ImageFormat:bmp).
    RETURN cc.
END FUNCTION.

FIND evento WHERE evento.nro_evento = pnro NO-ERROR.

IF NOT AVAILABLE evento THEN RETURN error.
FIND cliente NO-LOCK OF evento NO-ERROR.
IF NOT AVAILABLE cliente THEN RETURN ERROR.
FIND cliente_otros_datos OF cliente NO-LOCK NO-ERROR.
pemail = "".
pnombre = "".
/*le enviamos a los clientes que tengan explicitamente CERT y a los cando del administrador*/
FIND FIRST domicilio OF cliente NO-LOCK.
FOR EACH Cliente-contacto OF Domicilio WHERE index(Cliente-contacto.canal-email,"CERT") <> 0  NO-LOCK :
FIND Persona OF Cliente-contacto NO-LOCK NO-ERROR.
    IF AVAILABLE persona THEN DO:
        pnombre = pnombre + (IF pnombre <> "" THEN ", " ELSE "") + persona.nombre.
        pemail = pemail + (IF pemail <> "" THEN ";" ELSE "") + persona.email.
    END.
END.
FIND administracion WHERE administracion.nro_cliente = cliente.nro_admin NO-LOCK NO-ERROR.
IF NOT AVAILABLE administracion THEN do:
    MESSAGE NOW evento.nro_evento "ERROR URGENTE Administracion no registrada".
    RETURN error.
END.
FIND FIRST domicilio NO-LOCK OF administracion.
FOR EACH Cliente-contacto OF Domicilio WHERE can-do(Cliente-contacto.canal-email,"CERT")  NO-LOCK :
        FIND Persona OF Cliente-contacto NO-LOCK NO-ERROR.
        IF AVAILABLE persona THEN DO:
            pnombre = pnombre + (IF pnombre <> "" THEN ", " ELSE "") + persona.nombre.
            pemail = pemail + (IF pemail <> "" THEN ";" ELSE "") + persona.email.
        END.
END.
IF pemail = "" THEN do:
    MESSAGE now evento.nro_evento "ERROR NO Email Certif[falta persona]".
   IF adtest = "" THEN evento.observacion = agregaAdvTexto("ERROR NO Email Certif[falta persona]",evento.observacion).
   LEAVE.
END.

/*listo enviar email a la persona seleccionada*/
/*FIND restriccion WHERE restriccion.cdg_restriccion BEGINS "EMAIL" NO-LOCK NO-ERROR.
IF NOT AVAILABLE restriccion THEN RETURN ERROR.
FIND cliente_restriccion no-lock OF administracion WHERE cliente_restriccion.nro_restriccion = restriccion.nro_restriccion  NO-ERROR.
IF NOT AVAILABLE cliente_restriccion THEN DO:
/*     MESSAGE now evento.nro_evento "ERROR NO Email Certif[falta restrccion EMAIL),se asume que se envia".
   evento.observacion = agregaAdvTexto("ERROR NO Email Certif[falta restrccion EMAIL),se asume que se envia",evento.observacion).*/
END.
ELSE DO:
    IF lookup("CERTIF", cliente_restriccion.valor,"|") = 0 THEN DO:
        MESSAGE now evento.nro_evento "El administrador tiene restriccion de envio por email se imprimira".
        IF adtest = "" THEN evento.observacion = agregaAdvTexto("El administrador tiene restriccion de envio por email se imprimira",evento.observacion).
        IF adtest = "" THEN evento.envio_email = TRUE.
        RETURN ERROR.
    END.
END.*/

CREATE oblea.
ASSIGN oblea.url2 = evento.url2
       oblea.frealizado = evento.frealizado
       oblea.cliente = IF cliente.nom_cliente BEGINS "CP" THEN "CONSORCIO DE PROPIETARIOS" ELSE cliente.nom_cliente
       oblea.tanques = IF AVAILABLE cliente_otros_datos THEN cliente_otros_datos.tanques ELSE 0                                                  
       oblea.fvencimiento = evento.frealizado + IF evento.nro_tipo_evento = 1 THEN 30 ELSE 180
       oblea.nro_certif = evento.nro_certif.
       oblea.imagen = qrcode(evento.url1).
FIND FIRST oblea.
xfile = TempFile("") + STRING(evento.url1) + ".xml".

temp-table oblea:WRITE-XML ("FILE", xfile, TRUE,?,"",YES,YES).

ReportePath = "obleamcba-"+ STRING(evento.nro_tipo_evento,"99"). 
RUN fullPath (ReportePath, '.rpt':U, OUTPUT cFullPath).
IF cFullPath = ? 
THEN DO:
  MESSAGE now evento.nro_evento "No se encuentra el archivo de impresion " ReportePath SKIP
          "para el tipo de evento seleccionado" VIEW-AS ALERT-BOX ERROR.
    LEAVE.
END.
exportFileName=replace(cliente.direccion," " , "_"  ).
exportFileName=replace(exportFileName,"/" , "_"  ).
exportFileName=replace(exportFileName,"*" , "_"  ).
exportFileName=replace(exportFileName,"\" , "_"  ).
exportFileName=replace(exportFileName,'"' , "_"  ).
exportFileName=replace(exportFileName,"'" , "_"  ).
exportFileName=replace(exportFileName,"|" , "_"  ).
exportFileName=replace(exportFileName,"<" , "_"  ).
exportFileName=replace(exportFileName,">" , "_"  ).
exportFileName = SESSION:TEMP-DIR + "Oblea_" + exportFileName + ".pdf".
IF SEARCH( exportFileName ) <> ? THEN DO:
    OS-DELETE value(exportFileName).
    IF ERROR-STATUS:ERROR THEN DO:
        MESSAGE now evento.nro_evento "El archivo " exportFileName " esta siendo usado por otro usuario" SKIP 
                "no se puede proseguir" .
        RETURN ERROR.
    END.
END.
CREATE "CrystalRuntime.Application" chApplication.
chReport = chApplication:OpenReport(cFullPath, {&crOpenReportByTempCopy}).
chReport:DiscardSavedData(). 
RUN fullpath ( INPUT xfile, INPUT "", OUTPUT xFullPath ).
chReport:Database:Tables:item(1):setTableLocation(xFullPath, '', '').

RUN crearReporte(chReport,"pdf", /*ViewReport*/ no , /*PrinterName*/ "",
                 /*exportToDisk*/ true, INPUT-OUTPUT exportFileName ).        
RELEASE OBJECT chReport. 
chReport = ?.
RELEASE OBJECT chApplication.
chApplication = ?.
FIND FIRST oblea.
OS-DELETE value(oblea.imagen).
OS-DELETE value(xfile).
PAUSE 1.

RUN setCurrentDirectoryA(savDir).
msg1 = '<HTML><HEAD><TITLE></TITLE><META HTTP-EQUIV="Content-Type" content="text/html; charset=UTF-8"></HEAD><BODY><p><font face=Tahoma>Atte Adm. '  + html-encode(administracion.nom_cliente) + '</font></p>'.
msg3 = '<p><font face=Tahoma>Enviamos el certificado del trabajo realizado en ' + html-encode(cliente.direccion) + '. </font></p></p>'.
msg4 = '<p><font face=Tahoma>Recuerde comunicarnos cualquier inquietud relacionada con nuestros servicios, nuestra pol&iacute;tica de calidad persigue su entera satisfacci&oacute;n y la de sus clientes.</font></p><p><font face=Tahoma>Aprovechamos la oportunidad para saludarlo atte.</font></p><p><font face=Tahoma>' + 'Paulista' + '</font></p>'.
        firma= '<p><span><img width=87 height=67 src="cid:logopau.jpg" v:shapes="_x0000_s1026"></span><font face=Tahoma>Tel: 4961-1900</font></p><p><font face=Tahoma><a href="mailto:info@paulistaservicios.com.ar" title="mailto:info@paulistaservicios.com.ar">info@paulistaservicios.com.ar</a></font></p><p><font face=Tahoma><a href="skype:paulistaservicios" title="Skype:paulistaservicios">Skype:paulistaservicios</font></p><p></BODY></HTML>'.
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
objField:Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = "alejandra@paulistaservicios.com.ar".
objField:Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "joseantonio$568".      
objField:Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = TRUE.
objField:Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 100.  
objField:Update.
objMessage:Configuration = objConf.
objMessage:TO = IF adtest = "" THEN pemail ELSE adtest.
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
ELSE DO:
    MESSAGE now evento.nro_evento.
    IF adtest = "" THEN evento.observacion = agregaAdvTexto("EMAIL ENVIO Certificado" + pemail , evento.observacion ).
    IF adtest = "" THEN evento.envio_email = TRUE.
    RELEASE OBJECT objField NO-ERROR.
    RELEASE OBJECT objBP NO-ERROR.
    RELEASE OBJECT objMessage NO-ERROR.
    RELEASE OBJECT objConf NO-ERROR.
    objConf=?.
    objMessage=?.  
    objBP=?. 
    objField = ?.
END.
