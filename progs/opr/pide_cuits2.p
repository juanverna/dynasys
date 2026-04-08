{html.i}
{findempresa.i}

DEFINE VAR adtest AS CHAR INITIAL  "". /*;gustavo@paulistaservicios.com.ar;fernando@paulistaservicios.com.ar;veronica@paulistaservicios.com.ar".*/
DEFINE VAR msg31 AS CHAR NO-UNDO.
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
DEFINE VAR logo AS CHAR INITIAL "logopau.jpg" NO-UNDO.
DEFINE VAR logof AS CHAR NO-UNDO.

DEFINE BUFFER administracion FOR cliente.
    {crystal_dyna.p}
DEFINE TEMP-TABLE ttcli 
    FIELD nro_cliente LIKE cliente.nro_cliente
    FIELD nro_administrador LIKE cliente.nro_administrador
    FIELD nom_cliente LIKE Cliente.nom_cliente
    FIELD direccion LIKE cliente.direccion
    FIELD cuit LIKE cliente.cuit
    INDEX nro_cliente nro_cliente
    INDEX nro_administrador nro_administrador.

FOR EACH evento NO-LOCK WHERE evento.frealizado >= TODAY - 360
    AND ( evento.nro_tipo_evento = 3 OR evento.nro_tipo_evento = 1) 
    AND NOT evento.anulado:
    FIND cliente OF evento NO-LOCK NO-ERROR.
    IF NOT AVAILABLE cliente THEN NEXT.
    IF cliente.cuit <> ""  THEN NEXT.
    FIND ttcli OF cliente NO-ERROR.
    IF NOT AVAILABLE ttcli THEN DO:
        CREATE ttcli.
        BUFFER-COPY cliente TO ttcli.
    END.

END.

OUTPUT TO c:\dynasys10\logs\listapidecuit3.LOG.
FOR EACH ttcli BREAK BY ttcli.nro_administrador:
        FIND cliente WHERE ttcli.nro_cliente = cliente.nro_cliente NO-LOCK.
        FIND administracion WHERE administracion.nro_cliente  = ttcli.nro_administrador.
        DISPLAY cliente.cdg_cliente FORMAT "x(5)" ttcli.nom_cliente ttcli.direccion administracion.cdg_cliente FORMAT "x(5)" administracion.nom_cliente FORMAT "x(14)" WITH WIDTH 150.
    END.

OUTPUT CLOSE.
STOP.
    
/*
OUTPUT TO c:\dynasys10\logs\pidecuit4.LOG APPEND.
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
DEFINE VAR pok AS LOGICAL.
RUN fullpath ( logo, INPUT "", OUTPUT logof ).

FOR EACH ttcli WHERE ttcli.nro_administrador >= 826 BREAK BY ttcli.nro_administrador:

    
        msg31= msg31 + '<tr><td>'+ html-encode(ttcli.nom_cliente) + '</td><td>' + html-encode(ttcli.direccion) + '</td><td>' + ttcli.cuit + '</td></tr>'.
    IF LAST-OF(ttcli.nro_administrador) THEN DO:
        FIND administracion WHERE administracion.nro_cliente = ttcli.nro_administrador NO-LOCK NO-ERROR.
        IF administracion.cdg_cliente = "A0004" THEN NEXT.
        IF administracion.cdg_cliente = "A1535" THEN NEXT.
        IF NOT AVAILABLE administracion THEN do:
            MESSAGE NOW administracion.cdg_cliente "ERROR URGENTE Administracion no registrada".
            msg31="". next.
        END.
        

        
        FIND FIRST domicilio NO-LOCK OF administracion.
        FOR each Cliente-contacto OF Domicilio , Persona OF Cliente-contacto WHERE persona.email <> "" AND  can-do(Cliente-contacto.canal-email,"ADM"):
                LEAVE.
        END.
        IF NOT AVAILABLE persona THEN do:
            MESSAGE now administracion.cdg_cliente "ERROR NO Email Certif[falta persona]".
            msg31="". next.
        END.
        
        /*listo enviar email a la persona seleccionada*/
        IF persona.email = "" THEN do:
            MESSAGE now administracion.cdg_cliente "ERROR NO TIENE EMAIL " + persona.nombre .
            msg31="". next.
        END.
        IF num-entries(persona.email,"@") <> 2 THEN DO:
                  MESSAGE now administracion.cdg_cliente "EMAIL INVALIDO".
                  msg31="". next.
              END.
        IF NUM-ENTRIES( entry( 2 , persona.email, "@" ) , ".") < 2 THEN DO:
                  MESSAGE now administracion.cdg_cliente "EMAIL INVALIDO".
                  msg31="". next.
        END.
    
        msg1 = '<HTML><HEAD><TITLE></TITLE><META HTTP-EQUIV="Content-Type" content="text/html; charset=UTF-8"></HEAD><BODY><p><font face=Tahoma>Atte Adm. '  + html-encode(administracion.nom_cliente) + '</font></p>'.
        msg3 = '<p><font face=Tahoma>Ratificacion de CUIT Clientes Factura Electronica.</font></p><p>Teniendo en cuenta la implementación del sistema de facturación electrónica establecido por la AFIP, solicitamos por favor ratifique y/o informe RAZON SOCIAL, DOMICILIO (si difiere de la razón social) y CUIT de aquellos consorcios que su administración tiene con nosotros.</p><table border="1"  style="width:100%"><tr><th>Razon Social</th><th>Domicilio</TH><th>CUIT</th></tr>'.
        msg4 = '</table><p><font face=Tahoma>Recuerde comunicarnos cualquier inquietud relacionada con nuestros servicios, nuestra pol&iacute;tica de calidad persigue su entera satisfacci&oacute;n y la de sus clientes.</font></p><p><font face=Tahoma>Aprovechamos la oportunidad para saludarlo atte.</font></p><p><font face=Tahoma>' + 'Paulista' + '</font></p>'.
                firma= '<p><span><img width=87 height=67 src="cid:logopau.jpg" v:shapes="_x0000_s1026"></span><font face=Tahoma>Tel: 4961-1900</font></p><p><font face=Tahoma><a href="mailto:info@paulistaservicios.com.ar" title="mailto:info@paulistaservicios.com.ar">info@paulistaservicios.com.ar</a></font></p><p><font face=Tahoma><a href="skype:paulistaservicios" title="Skype:paulistaservicios">Skype:paulistaservicios</font></p><p></BODY></HTML>'.
        
        /*mandando el email*/
        
        CREATE "CDO.Message" objMessage.
        CREATE "CDO.Configuration" objConf.
        objField = objConf:FIELDS.
        objField:Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2. /*cdoSendUsingPort*/
        objField:Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "smtp.gmail.com". 
        objField:Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 465. 
        objField:Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1.      
        objField:Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = "nahuel@paulistaservicios.com.ar".
        objField:Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "joseantonio$568".      
        objField:Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = TRUE.
        objField:Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 100.  
        objField:Update.
        objMessage:Configuration = objConf.
        objMessage:TO = IF adtest = "" THEN persona.email ELSE adtest.
        objMessage:FROM =  USER_empresa.email.
        objMessage:Subject = "Paulista - Solicitud de CUIT FACTURA ELECTRONICA".
        objMessage:HTMLBody = msg1 + msg3 + msg31 + msg4 + firma.
        objBP = objMessage:AddRelatedBodyPart("file://" + logof, logo, 0, , ).
        objBP:Fields:Item("urn:schemas:mailheader:Content-ID") = "<" + logo + ">".
        objBP:Fields:Update.
        objMessage:Send.
        
        IF ERROR-STATUS:ERROR THEN do:
            RELEASE OBJECT objField NO-ERROR.
            RELEASE OBJECT objBP NO-ERROR.
            RELEASE OBJECT objMessage NO-ERROR.
            RELEASE OBJECT objConf NO-ERROR.
            RETURN ERROR.
        END.
        msg31="".
        MESSAGE now administracion.cdg_cliente.
        RELEASE OBJECT objField NO-ERROR.
        RELEASE OBJECT objBP NO-ERROR.
        RELEASE OBJECT objMessage NO-ERROR.
        RELEASE OBJECT objConf NO-ERROR.
        objConf=?.
        objMessage=?.  
        objBP=?. 
        objField = ?.
        PAUSE 2.
    END.
END. */
