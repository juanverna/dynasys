{findempresa.i}
{html.i}
{tiempo.i}
{crystal_dyna.p}
{advtexto.i}
FUNCTION fmoroso
    RETURNS DATE
      ( nro_admin AS INT ) :
    /*------------------------------------------------------------------------------
      Purpose:  
        Notes:  
    ------------------------------------------------------------------------------*/
    DEFINE VAR fpremoroso AS DATE NO-UNDO.
    DEFINE VAR fmoroso AS DATE NO-UNDO.
    DEFINE VAR p-precorte AS DATE NO-UNDO.
    p-precorte = DATE(MONTH(TODAY),1,YEAR(TODAY)) - 1.
    p-precorte = DATE(MONTH(p-precorte),1,YEAR(p-precorte)).
    fpremoroso = DATE(MONTH(p-precorte - 1 ),1,YEAR(p-precorte - 1)).
    fmoroso = fpremoroso + 9.
    FIND restriccion WHERE restriccion.cdg_restriccion = "CORTE" NO-LOCK NO-ERROR.
    FIND cliente_restriccion OF restriccion WHERE cliente_restriccion.nro_cliente = nro_admin NO-LOCK NO-ERROR.
    IF AVAILABLE cliente_restriccion 
    THEN do:
    fmoroso = fmoroso - INT(cliente_restriccion.valor).
    END.
    REPEAT:
         IF es_habil(fmoroso,"23456") THEN LEAVE.
         fmoroso = fmoroso - 1.
    END.

      RETURN fmoroso.   /* Function return value. */

    END FUNCTION.

FUNCTION fcorte
RETURNS DATE
  ( nro_admin AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
    DEFINE VAR p-corte AS DATE.
    DEFINE VAR p-precorte AS DATE.
    p-precorte = DATE(MONTH(TODAY),1,YEAR(TODAY)) - 1.
    p-precorte = DATE(MONTH(p-precorte),1,YEAR(p-precorte)).
    FIND restriccion WHERE restriccion.cdg_restriccion = "CORTE" NO-LOCK NO-ERROR.
    IF NOT AVAILABLE restriccion THEN DO:
        display "No existe la restriccion tipo CORTE" .
        leave.
    END.
    FIND cliente_restriccion WHERE cliente_restriccion.nro_restriccion = nro_admin and
         cliente_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
    IF NOT AVAILABLE cliente_restriccion THEN p-corte = p-precorte + 9.
    ELSE do:
            p-corte = p-precorte + INT(cliente_restriccion.valor) - 1 NO-ERROR.
            IF ERROR-STATUS:ERROR THEN p-corte = p-precorte + INT(cliente_restriccion.valor) - 2 NO-ERROR.
            IF ERROR-STATUS:ERROR THEN p-corte = p-precorte + INT(cliente_restriccion.valor) - 3 NO-ERROR.
            IF ERROR-STATUS:ERROR THEN p-corte = p-precorte + INT(cliente_restriccion.valor) - 4 NO-ERROR.
    END.
    REPEAT:
         IF es_habil(p-corte,"23456") THEN LEAVE.
         p-corte = p-corte + 1.
    END.
    /*p-corte esta ok*/
RETURN p-corte.

END FUNCTION.
  DEF VAR reenvio AS LOGICAL INITIAL false.
  DEF BUFFER bevento FOR evento.
  DEF BUFFER btarea FOR tarea.
  DEF VAR ReportePath AS CHAR NO-UNDO.
  DEF VAR cFullPath AS CHAR NO-UNDO.
  DEF VAR xFullPath AS CHAR NO-UNDO.
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
  DEFINE VAR rest AS LOGICAL NO-UNDO.
  DEFINE VAR one AS LOGICAL INIT YES.
  DEFINE VAR savdir AS CHARACTER NO-UNDO.
  DEFINE VAR logo AS CHAR INITIAL "logopau.jpg" NO-UNDO.
  DEFINE VAR logof AS CHAR NO-UNDO.
  DEFINE BUFFER administrador FOR cliente.
  DEFINE VAR proxHabil AS DATE NO-UNDO.
  DEFINE VAR dtproxHabil AS DATETIME NO-UNDO.
  proxHabil = resta_dia_habil(TODAY,2,"23456" ).
  dtproxhabil = datetime(proxHabil ).
FIND usuario WHERE usuario.cdg_usuario = userid("sic") .
OUTPUT TO c:\dynasys10\logs\gen_emailcobranzas.LOG APPEND.
DISPLAY "Fecha corrida" NOW.
FIND FIRST empresa NO-LOCK.
IF usuario.cdg_empresa = "" THEN usuario.cdg_empresa = empresa.cdg_empresa.
/*generacion de las emails a la visualizacion de tareas + 2 dias habiles*/
/*si se le envio email manualmente no lo vuelve a enviar el sistema*/
FIND usuario WHERE usuario.cdg_usuario = USERID("sic").
FOR EACH user_empresa OF usuario BY  User_empresa.rige_desde DESC:
  LEAVE.
END.
IF NOT AVAILABLE USER_empresa THEN DO:
  DISPLAY "No se encuentra USER_empresa".
  leave.
END.
IF USER_empresa.email = "" THEN DO:
  display "El generador batch no tiene direccion de email registrada" .
  LEAVE.
END.
/********************************************************
* Control de TAREAS
*********************************************************/

FOR EACH tarea WHERE tarea.cdg_tipotarea = "C" AND tarea.estado = "A" 
        AND Tarea.visualizar = dtproxHabil NO-LOCK :

    FIND cliente OF tarea NO-LOCK.
    IF INDEX(tarea.descripcion,"EMAIL Estado deuda a ") <> 0 AND NOT reenvio THEN NEXT.
    /*rest = FALSE.
    FIND restriccion WHERE restriccion.cdg_restriccion = "EMAIL" NO-LOCK.
    FIND cliente_restriccion OF cliente WHERE cliente_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
    IF AVAILABLE cliente_restriccion THEN DO:
        rest = LOOKUP("COBTAREA",cliente_restriccion.valor,"|") > 0.
    END.
    IF NOT rest THEN NEXT. */
    DISPLAY "TAREA" tarea.nro_tarea.
    savdir = getCurrentDirectory().
    RUN fullpath ( logo, INPUT "", OUTPUT logof ).
    /*recuperando datos para enviar el email*/
    
    FIND administrador WHERE cliente.nro_admin = administrador.nro_cliente NO-LOCK.
    FIND FIRST domicilio OF cliente NO-LOCK NO-ERROR.
    FOR each Cliente-contacto OF Domicilio , Persona OF Cliente-contacto WHERE persona.email <> "" AND  can-do(Cliente-contacto.canal-email,"COB") :
        LEAVE.
    END.
    IF NOT AVAILABLE persona THEN DO:
      FIND btarea WHERE ROWId(btarea) = ROWID(tarea) EXCLUSIVE-LOCK.
      btarea.descripcion = agregaAdvTexto("EMAIL No hay definida una persona de contacto" , tarea.descripcion ).
      display "No hay definida una persona de contacto, el email no puede ser enviado".
      next.
    END.
    IF persona.email = "" THEN DO: 
      FIND btarea WHERE ROWId(btarea) = ROWID(tarea) EXCLUSIVE-LOCK.
      btarea.descripcion = agregaAdvTexto("EMAIL La Persona " + persona.nombre + " no tiene un email registroado" , tarea.descripcion ).
      DISPLAY "La Persona " + persona.nombre + " no tiene un email registroado , vefique".
      next.
    END.
    exfile = "DeudaconPaulista.pdf".
    exportFileName = SESSION:TEMP-DIR + exfile.
    OS-DELETE value(exportFileName).
    IF ERROR-STATUS:ERROR THEN DO:
      FIND btarea WHERE ROWId(btarea) = ROWID(tarea) EXCLUSIVE-LOCK.
      btarea.descripcion = agregaAdvTexto("EMAIL El archivo " + exportFileName + " esta siendo usado por otro usuario" , tarea.descripcion ).

      DISPLAY "El archivo " + exportFileName + " esta siendo usado por otro usuario".      next.
    END.
    RUN prinresumenes-email.p ( INPUT Empresa.cdg_empresa,
                               INPUT administrador.cdg_cliente,
                               INPUT administrador.cdg_cliente,
                               INPUT fcorte(administrador.nro_cliente),
                               INPUT 01/01/3000,
                               INPUT "*", /*todos los puntos de venta*/
                               INPUT 1,
                               INPUT fmoroso(administrador.nro_cliente) ,
                               OUTPUT xfile).  
    
    IF xfile = ? THEN DO:
      /*MESSAGE "No registra deuda no se envia el email" VIEW-AS ALERT-BOX INFORMATION.*/
      next.
    END.
    ReportePath = "pendiente_cobranemail.rpt".
    RUN fullPath (ReportePath, '.rpt':U, OUTPUT cFullPath).
    IF cFullPath = ? 
    THEN DO:
      RUN mensajepar.p (INPUT ReportePath, INPUT "CREP000").
      next.
    END.

    CREATE "CrystalRuntime.Application" chApplication.
    chReport = chApplication:OpenReport(cFullPath, {&crOpenReportByTempCopy}).
    chReport:DiscardSavedData(). /*eliminando lo previamente grabado*/
    xFullPath = xfile.
    chReport:Database:Tables:item(1):setTableLocation(xFullPath, '', '').
    RUN crearReporte(chReport,"pdf",/*ViewReport*/ NO,/*PrinterName*/ "",
                   /*exportToDisk*/ TRUE, INPUT-OUTPUT exportFileName ).
    IF ERROR-STATUS:ERROR THEN DO:     
          FIND btarea WHERE ROWId(btarea) = ROWID(tarea) EXCLUSIVE-LOCK.
          btarea.descripcion = agregaAdvTexto("EMAIL Existio un problema al generar el reporte" , tarea.descripcion ).
          display "Existio un problema al generar el reporte".
          next.
    END.
    RELEASE OBJECT chReport. 
    chReport = ?.
    RELEASE OBJECT chApplication.
    chApplication = ?.
    RUN setCurrentDirectoryA(savDir).
    
    msg1 = '<HTML><HEAD><TITLE></TITLE><META HTTP-EQUIV="Content-Type" content="text/html; charset=UTF-8"></HEAD><BODY><p><font face=Tahoma>Atte Adm. '  + html-encode(administrador.nom_cliente) + ':</font></p>'.
    msg3 = '<p><font face=Tahoma>Enviamos nuestro resumen de cuenta, el cual contiene el detalle de facturas y monto adeudado. </font></p><p><font face=Tahoma>En caso de haber facturas cuyo atraso en el pago es mayor al habitual, las encontrar&aacute; resaltadas.</font></p>'.
    msg4 = '<p><font face=Tahoma>Si prefiere pagos por transferencia los datos son: CBU 2850503930023018338010 CUIT 30-64560111-0. Rogamos enviar comprobante indicando Nro. de Factura.</font></p><p><font face=Tahoma>Recuerde comunicarnos cualquier inquietud relacionada con nuestros servicios, nuestra pol&iacute;tica de calidad persigue su entera satisfacci&oacute;n y la de sus clientes.</font></p><p><font face=Tahoma>Aprovechamos la oportunidad para saludarlo atte.</font></p><p><font face=Tahoma>' + 'Paulista cobranzas' + '</font></p>'.
    msg2='<br><p><font face=Tahoma>Nos dirigimos a Uds. a fin de solicitar fecha y horario de pago del mes en curso.</font></p>'.
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
    objField:Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = "admin@paulistaservicios.com.ar".
    objField:Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "joseantonio$568".      
    objField:Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = TRUE.
    objField:Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 100.  
    objField:Update.
    objMessage:Configuration = objConf.
    objMessage:TO = persona.email.
    objMessage:FROM =  USER_empresa.email.
    /*objMessage:Subject = IF anal.accion = "EVENTO" AND anal.fecha<>? THEN "Paulista - Estado de deuda" ELSE "Paulista - Solicitud de fecha de pago".*/
    objMessage:Subject = "Paulista - Solicitud de fecha de pago".
    objMessage:HTMLBody = msg1 + msg2 + msg3 + msg4 + firma.
    /* desde un archivo 'objMessage.CreateMHTMLBody "file://c|/temp/test.htm"*/
    objMessage:AddAttachment( "file://" + exportFileName,"","" ).
    objBP = objMessage:AddRelatedBodyPart("file://" + logof, logo, 0, , ).
    objBP:Fields:Item("urn:schemas:mailheader:Content-ID") = "<" + logo + ">".
    objBP:Fields:Update.
    objMessage:SEND.
    PAUSE 2.
    
    FIND btarea WHERE ROWId(btarea) = ROWID(tarea) EXCLUSIVE-LOCK.
    btarea.descripcion = agregaAdvTexto("EMAIL Estado deuda a " + persona.email , tarea.descripcion ).
    RELEASE OBJECT objField NO-ERROR.
    RELEASE OBJECT objBP NO-ERROR.
    RELEASE OBJECT objMessage NO-ERROR.
    RELEASE OBJECT objConf NO-ERROR.
    objConf=?.
    objMessage=?.  
    objBP=?. 
    objField = ?.
END.

/********************************************************
* Control de EVENTOS
*********************************************************/

FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "CO" NO-LOCK.
FOR EACH evento WHERE evento.nro_tipo_evento = tipo_evento.nro_tipo_evento AND 
    NOT evento.anulado AND evento.fasignado = proxHabil AND evento.frealizado = ? 
        NO-LOCK :

    FIND cliente OF evento NO-LOCK NO-ERROR.
    IF NOT AVAILABLE cliente THEN NEXT.
    IF evento.origen = "TAREA"  THEN DO:
        FIND tarea WHERE tarea.nro_tarea = evento.nro_identificacion NO-LOCK.
        IF INDEX(tarea.descripcion,"EMAIL Estado deuda a ") <> 0 AND NOT reenvio THEN NEXT.
    END.
    rest = FALSE.
    IF INDEX(evento.observacion ,"EMAIL Estado deuda a ") <> 0 AND NOT reenvio THEN NEXT.
    FIND restriccion WHERE restriccion.cdg_restriccion = "EMAIL" NO-LOCK.
    FIND cliente_restriccion OF cliente WHERE cliente_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
    IF AVAILABLE cliente_restriccion THEN DO:
        rest = LOOKUP("COBEVENTO",cliente_restriccion.valor,"|") > 0.
    END.
    IF NOT rest THEN NEXT.
    DISPLAY "EVENTO" evento.nro_evento.
    savdir = getCurrentDirectory().
    RUN fullpath ( logo, INPUT "", OUTPUT logof ).
    /*recuperando datos para enviar el email*/
    
    FIND administrador WHERE cliente.nro_admin = administrador.nro_cliente NO-LOCK.
    FIND FIRST domicilio OF cliente NO-LOCK NO-ERROR.
    FOR each Cliente-contacto OF Domicilio , Persona OF Cliente-contacto WHERE persona.email <> "" AND  can-do(Cliente-contacto.canal-email,"COB") :
        LEAVE.
    END.
    IF NOT AVAILABLE persona THEN DO:
      FIND bevento WHERE ROWId(bevento) = ROWID(evento) EXCLUSIVE-LOCK.
      bevento.observacion = agregaAdvTexto("EMAIL no hay definida ninguna persona de contacto" , evento.observacion ).
      DISPLAY evento.nro_evento "No hay definida una persona de contacto, el email no puede ser enviado".
      next.
    END.
    IF persona.email = "" THEN DO: 
      FIND bevento WHERE ROWId(bevento) = ROWID(evento) EXCLUSIVE-LOCK.
      bevento.observacion = agregaAdvTexto("EMAIL La persona " + persona.nombre + " no tiene un email registroado" , evento.observacion ).
      DISPLAY evento.nro_evento "La persona " persona.nombre " no tiene un email registroado , vefique".
      next.
    END.
    exfile = "DeudaconPaulista.pdf".
    exportFileName = SESSION:TEMP-DIR + exfile.
    OS-DELETE value(exportFileName).
    IF ERROR-STATUS:ERROR THEN DO:
      DISPLAY evento.nro_evento "El archivo " exportFileName " esta siendo usado por otro usuario" .
      next.
    END.
    RUN prinresumenes-email.p ( INPUT Empresa.cdg_empresa,
                               INPUT administrador.cdg_cliente,
                               INPUT administrador.cdg_cliente,
                               INPUT fcorte(administrador.nro_cliente),
                               INPUT 01/01/3000,
                               INPUT "*", /*todos los puntos de venta*/
                               INPUT 1,
                               INPUT fmoroso(administrador.nro_cliente) ,
                               OUTPUT xfile).  
    
    IF xfile = ? THEN DO:
      /*MESSAGE "No registra deuda no se envia el email" VIEW-AS ALERT-BOX INFORMATION.*/
      next.
    END.
    ReportePath = "pendiente_cobranemail.rpt".
    RUN fullPath (ReportePath, '.rpt':U, OUTPUT cFullPath).
    IF cFullPath = ? 
    THEN DO:
      RUN mensajepar.p (INPUT ReportePath, INPUT "CREP000").
      next.
    END.

    CREATE "CrystalRuntime.Application" chApplication.
    chReport = chApplication:OpenReport(cFullPath, {&crOpenReportByTempCopy}).
    chReport:DiscardSavedData(). /*eliminando lo previamente grabado*/
    xFullPath = xfile.
    chReport:Database:Tables:item(1):setTableLocation(xFullPath, '', '').
    RUN crearReporte(chReport,"pdf",/*ViewReport*/ NO,/*PrinterName*/ "",
                   /*exportToDisk*/ TRUE, INPUT-OUTPUT exportFileName ).
    IF ERROR-STATUS:ERROR THEN DO:  
          FIND bevento WHERE ROWId(bevento) = ROWID(evento) EXCLUSIVE-LOCK.  
          bevento.observacion = agregaAdvTexto("EMAIL no se pudo enviar por problema al generar el reporte", evento.observacion ).
          DISPLAY evento.nro_evento "Existio un problema al generar el reporte en evento" .
          next.
    END.
    RELEASE OBJECT chReport. 
    chReport = ?.
    RELEASE OBJECT chApplication.
    chApplication = ?.
    RUN setCurrentDirectoryA(savDir).
    
    msg1 = '<HTML><HEAD><TITLE></TITLE><META HTTP-EQUIV="Content-Type" content="text/html; charset=UTF-8"></HEAD><BODY><p><font face=Tahoma>Atte Adm. '  + html-encode(administrador.nom_cliente) + ':</font></p>'.
    msg3 = '<p><font face=Tahoma>Enviamos nuestro resumen de cuenta, el cual contiene el detalle de facturas y monto adeudado. </font></p><p><font face=Tahoma>En caso de haber facturas cuyo atraso en el pago es mayor al habitual, las encontrar&aacute; resaltadas.</font></p>'.
    msg4 = '<p><font face=Tahoma>Si prefiere pagos por transferencia los datos son: CBU 2850503930023018338010 CUIT 30-64560111-0. Rogamos enviar comprobante indicando Nro. de Factura.</font></p><p><font face=Tahoma>Recuerde comunicarnos cualquier inquietud relacionada con nuestros servicios, nuestra pol&iacute;tica de calidad persigue su entera satisfacci&oacute;n y la de sus clientes.</font></p><p><font face=Tahoma>Aprovechamos la oportunidad para saludarlo atte.</font></p><p><font face=Tahoma>' + 'Paulista cobranzas' + '</font></p>'.
    msg2 = '<p><font face=Tahoma>Nuestro cobrador concurrir&aacute; a sus oficinas el d&iacute;a ' + STRING(evento.fasignado) + '</font></p>'.
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
    objField:Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = "admin@paulistaservicios.com.ar".
    objField:Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "joseantonio$568".      
    objField:Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = TRUE.
    objField:Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 100.  
    objField:Update.
    objMessage:Configuration = objConf.
    objMessage:TO = persona.email.
    objMessage:FROM =  USER_empresa.email.
    objMessage:Subject = "Paulista - Estado de deuda".
    objMessage:HTMLBody = msg1 + msg2 + msg3 + msg4 + firma.
    /* desde un archivo 'objMessage.CreateMHTMLBody "file://c|/temp/test.htm"*/
    objMessage:AddAttachment( "file://" + exportFileName,"","" ).
    objBP = objMessage:AddRelatedBodyPart("file://" + logof, logo, 0, , ).
    objBP:Fields:Item("urn:schemas:mailheader:Content-ID") = "<" + logo + ">".
    objBP:Fields:Update.
    objMessage:Send.
    PAUSE 2.
    FIND bevento WHERE ROWId(bevento) = ROWID(evento) EXCLUSIVE-LOCK.
    bevento.observacion = agregaAdvTexto("EMAIL Estado deuda a " + persona.email , evento.observacion ).
    RELEASE OBJECT objField NO-ERROR.
    RELEASE OBJECT objBP NO-ERROR.
    RELEASE OBJECT objMessage NO-ERROR.
    RELEASE OBJECT objConf NO-ERROR.
    objConf=?.
    objMessage=?.  
    objBP=?. 
    objField = ?.
END.
