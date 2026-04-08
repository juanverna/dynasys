{findempresa.i}
{html.i}
{tiempo.i}
{crystal_dyna.p}
{advtexto.i}
DEFINE VAR p-des_fecha AS DATE    LABEL "Hasta" INITIAL 12/01/2014.               
DEFINE VAR p-has_fecha AS DATE    LABEL "Desde" INITIAL 12/31/2014.
DEFINE VAR p-periodo   AS INT NO-UNDO LABEL "Periodo" INITIAL "201411".
DEF    VAR      ReportePath AS CHAR  NO-UNDO.
DEF    VAR      cFullPath   AS CHAR  NO-UNDO.
DEF    VAR      xFullPath   AS CHAR  NO-UNDO.
DEF    VARIABLE oSuccessful AS LOGICAL    NO-UNDO.
DEF    VARIABLE vmessage    AS CHAR  NO-UNDO.
DEFINE VAR      i           AS INT    NO-UNDO.
DEFINE VAR      msg1        AS CHAR NO-UNDO.
DEFINE VAR      msg2        AS CHAR NO-UNDO.
DEFINE VAR      msg3        AS CHAR NO-UNDO.
DEFINE VAR      msg31       AS CHAR NO-UNDO.
DEFINE VAR      msg4        AS CHAR NO-UNDO.
DEFINE VAR      firma       AS CHAR  NO-UNDO.
DEFINE VAR      img64       AS CHAR  NO-UNDO.
DEFINE VAR      objMessage  AS COM-HANDLE NO-UNDO.
DEFINE VAR      objConf     AS COM-HANDLE NO-UNDO.
DEFINE VAR      objField    AS COM-HANDLE NO-UNDO.
DEFINE VAR      objBP       AS COM-HANDLE NO-UNDO.
DEFINE VAR      logo        AS CHAR  INITIAL "logopau.jpg" NO-UNDO.
DEFINE VAR      logof       AS CHAR  NO-UNDO.
DEFINE BUFFER administrador FOR cliente.
DEFINE VAR aa          AS CHAR NO-UNDO.

RUN fullpath ( logo, INPUT "", OUTPUT logof ).
FIND usuario WHERE usuario.cdg_usuario = userid("sic") .
OUTPUT TO c:\dynasys10\logs\porferiados.LOG APPEND.
PUT "Fecha corrida" NOW SKIP.
FIND FIRST empresa NO-LOCK.
IF usuario.cdg_empresa = "" THEN usuario.cdg_empresa = empresa.cdg_empresa.
/*generacion de las emails a la visualizacion de tareas + 2 dias habiles*/
/*si se le envio email manualmente no lo vuelve a enviar el sistema*/
FIND usuario WHERE usuario.cdg_usuario = USERID("sic").
FOR EACH user_empresa OF usuario BY  User_empresa.rige_desde DESC:
    LEAVE.
END.
IF NOT AVAILABLE USER_empresa THEN 
DO:
    PUT "No se encuentra USER_empresa" SKIP.
    leave.
END.
IF USER_empresa.email = "" THEN 
DO:
    PUT "El generador batch no tiene direccion de email registrada" SKIP.
    LEAVE.
END.

FOR EACH Contrato_hd 
    WHERE contrato_hd.estado = "A" AND ( Contrato_hd.rige_desde <= p-has_fecha  
    AND Contrato_hd.rige_hasta >= p-des_fecha )
    AND ( Contrato_hd.primer_ano * 100 + Contrato_hd.primer_mes <= p-periodo )
    AND ( Contrato_hd.resto_periodos > 0  or Contrato_hd.cant_periodos = 0 ) 
    AND contrato_hd.fecha_baja = ? 
    NO-LOCK,
    FIRST Cliente OF Contrato_hd NO-LOCK ,
    FIRST administrador WHERE administrador.nro_cliente = cliente.nro_administrador AND administrador.nom_cliente > "ANFER" NO-LOCK
    BREAK BY administrador.nom_cliente
    BY cliente.direccion
    BY Contrato_hd.num_contrato :
    FIND FIRST domicilio OF administrador NO-LOCK.
    RELEASE persona.
    FOR each Cliente-contacto OF Domicilio NO-LOCK , Persona OF Cliente-contacto NO-LOCK WHERE persona.email <> "" AND  can-do(Cliente-contacto.canal-email,"ADM") :
        LEAVE.
    END.
    IF NOT AVAILABLE persona THEN DO:
        PUT "No se encuentre persona para adm " administrador.cdg_cliente SKIP.
        NEXT.
    END.
    aa = "".
    FOR EACH evento WHERE evento.nro_identificacion = contrato_hd.nro_contrato AND evento.origen = "CONTRATO" AND evento.fasignado = 12/1/2014 /*AND evento.fasignado <= 12/31/2014*/ AND NOT evento.anulado AND evento.nro_tipo_evento = contrato_hd.nro_tipo_evento BY evento.fasignado :
        IF INDEX(evento.observacion,"EMAIL Feriados Diciembre") <> 0 THEN DO:
            PUT evento.nro_evento "ya emitido" SKIP.
            NEXT.
        END.
        aa = aa + " " + STRING( evento.fasignado).
        evento.observacion = agregaAdvTexto( "EMAIL Feriados Diciembre" , evento.observacion ).
    END.
    IF aa <> "" THEN DO:
        msg31 = msg31 + '<tr><td>'+ cliente.direccion  + '</td>'.
        msg31 = msg31 + '<td>' + aa + '</td></tr>'. 
    END.

    IF LAST-OF(administrador.nom_cliente) THEN DO:
        PUT administrador.cdg_cliente SKIP.
        IF msg31 = "" THEN NEXT.
        msg1 = '<HTML><HEAD><TITLE></TITLE><META HTTP-EQUIV="Content-Type" content="text/html; charset=UTF-8"></HEAD><BODY><p><font face=Tahoma>Atte Adm. '  + html-encode(administrador.nom_cliente) + ':</font></p>'.
        msg2 = '<p><font face=Tahoma></font><p>Habitualmente el mes de diciembre tiene una cantidad de días no laborables (formales y no formales) mayor que el resto de los meses.<br>Por este motivo, y con el fin de prever inconvenientes en la prestación de nuestros servicios, estamos enviando  durante Noviembre  a los edificios abonados una esquela en la que solicitamos respetar la fecha programada para el servicio del próximo mes, dado que la reprogramación de las desinsectaciones que no puedan realizarse resulta muy complejo por falta de días.<br>Ponemos en su conocimiento esta circunstancia para solicitarle que tenga la amabilidad hacer la misma recomendación a los encargados, y así poder prestar nuestro servicio normalmente.</p>'.
        msg3 = '<table border="1" style="background-color:#FFFFCC;border-collapse:collapse;border:1px solid #FFCC00;color:#000000;width:90%" cellpadding="3" cellspacing="3">' + 
	'<tr><th>Direccion</td><td>Fecha</th></tr>'+ msg31 + '</table>'. 
        msg4 = '<p><font face=Tahoma><br>Su colaboración es valiosa, y evitará la interrupción del servicio mensual por razones ajenas a nuestras posibilidades.<br>Agradeceremos nos informen de ser posible, aquellos edificios cuyos encargados/as gocen de vacaciones durante el próximo mes y nos remitan el teléfono del suplente para una mejor coordinación.<br>Quedamos a sus órdenes para cualquier consulta.</p>'.
        firma= '<p><span><img width=87 height=67 src="cid:logopau.jpg" v:shapes="_x0000_s1026"></span><font face=Tahoma>Tel: 4961-1900</font></p><p><font face=Tahoma><a href="mailto:info@paulistaservicios.com.ar" title="mailto:info@paulistaservicios.com.ar">info@paulistaservicios.com.ar</a></font></p><p><font face=Tahoma><a href="skype:paulistaservicios" title="Skype:paulistaservicios">Skype:paulistaservicios</font></p><p></BODY></HTML>'.
        
        /*mandando el email*/
        CREATE "CDO.Message" objMessage.
        CREATE "CDO.Configuration" objConf.
        objField = objConf:FIELDS.
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
        objMessage:FROM = "admin@paulistaservicios.com.ar". /* USER_empresa.email.*/
        objMessage:Subject = "Paulista - Feriados Diciembre".
        objMessage:HTMLBody = msg1 + msg2 + msg3 + msg4 + firma.
        objBP = objMessage:AddRelatedBodyPart("file://" + logof, logo, 0, , ).
        objBP:Fields:Item("urn:schemas:mailheader:Content-ID") = "<" + logo + ">".
        objBP:Fields:Update.
        objMessage:SEND.
        PAUSE 2.
        RELEASE OBJECT objField NO-ERROR.
        RELEASE OBJECT objBP NO-ERROR.
        RELEASE OBJECT objMessage NO-ERROR.
        RELEASE OBJECT objConf NO-ERROR.
        objConf=?.
        objMessage=?.  
        objBP=?. 
        objField = ?.
        msg31 = "".
    END.

END.

