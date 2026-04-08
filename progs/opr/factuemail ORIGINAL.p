/*envia emails de facturas pasadas como parametro al destino pasado como parametro*/
/*en los facturas pueden venir de varios tipos distintos siempre que sean electronicas sino se dara error
si alguna de los comprobantes le falta el cae se dara error factuemail*/
{advtexto.i}
{crystal_dyna.p}
{html.i}
{findempresa.i}
 

DEFINE TEMP-TABLE facturas NO-UNDO
    FIELD orden AS INT
    FIELD rfac AS rowid.
DEFINE INPUT PARAMETER pemail AS CHAR NO-UNDO.
DEFINE INPUT PARAMETER pnombre AS CHAR NO-UNDO.
DEFINE INPUT PARAMETER TABLE FOR facturas. 

DEFINE TEMP-TABLE archivos NO-UNDO
        FIELD archivo AS CHAR
        FIELD direccion AS CHAR
        FIELD comprobante AS CHAR
        FIELD fecha AS DATE
        FIELD cuit AS CHAR FORMAT "X(13)" 
        /*FIELD neto AS char
        FIELD iva AS CHAR*/
        FIELD tot AS char.

DEFINE VAR ReportePath AS CHAR NO-UNDO.
DEFINE VAR cFullPath AS CHAR NO-UNDO.
DEFINE VAR xFullPath AS CHAR NO-UNDO.

FUNCTION formularioFAC RETURNS CHARACTER
      ( INPUT rid_factura AS ROWID ) :
    /*------------------------------------------------------------------------------
      Purpose:  retorna el formulario a utilizar
    ------------------------------------------------------------------------------*/
    DEFINE VARIABLE que_formulario      AS CHARACTER NO-UNDO.
    DEFINE VARIABLE x-formulario        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE j                   AS INTEGER NO-UNDO.
    
    {parlocales.i}

    FIND Fac_header WHERE ROWID(Fac_header) = rid_factura NO-LOCK.

    FIND Tipocomprobante OF Fac_header NO-LOCK.
    IF Tipocomprobante.usa_letra
       THEN FIND Condicion_impos OF Fac_header NO-LOCK.

    x-formulario = Tipocomprobante.prefijo_formulario.
    IF Tipocomprobante.usa_letra
       THEN x-formulario = REPLACE(x-formulario,"*",Condicion_impos.tipo_factura). 

    RUN getparametro.p (  INPUT  x-formulario,
                          OUTPUT v-valor_c,
                          OUTPUT v-valor_d,
                          OUTPUT v-valor_l,
                          OUTPUT v-valor_n,
                          OUTPUT v-observacion ).
    que_formulario = Tipocomprobante.prefijo_programa + STRING(v-valor_n, "999").
    IF Tipocomprobante.usa_letra
       THEN que_formulario = REPLACE(que_formulario,"*",Condicion_impos.tipo_factura).

    FIND Punto-venta 
        WHERE Punto-venta.cdg_empresa = Fac_header.cdg_empresa
          AND Punto-venta.cdg_puntovta = Fac_header.prf_comprob
              NO-LOCK.

    que_formulario = que_formulario + TRIM(Punto-venta.impresor).

    RETURN que_formulario.   /* Function return value. */

END FUNCTION.


/*proceso*/
/*a quien le enviamos*/
FIND usuario WHERE usuario.cdg_usuario = USERID("sic").
FOR EACH user_empresa OF usuario BY  User_empresa.rige_desde DESC:
    LEAVE.
END.
IF NOT AVAILABLE USER_empresa THEN 
    RETURN error "Usted no tiene la direccion de email registrada ,no se enviara email" .
IF USER_empresa.email = "" THEN 
    RETURN ERROR "Usted no tiene direccion de email registrada, no se enviara el email" .

          
FOR EACH facturas BY orden:
    FIND fac_header WHERE ROWID(fac_header) = facturas.rfac NO-LOCK.
    IF fac_header.cai = "" THEN RETURN ERROR fac_header.tip_comprob + "-" + string(fac_header.prf_comprob) + "-" + string(fac_header.nro_comprob) + " no tiene CAE".
    FIND punto-venta WHERE punto-venta.cdg_puntovta = fac_header.prf_comprob NO-LOCK NO-ERROR. 
    IF punto-venta.impresor <> "E" THEN RETURN ERROR fac_header.tip_comprob + "-" + string(fac_header.prf_comprob) + "-" + string(fac_header.nro_comprob) + " no es electronica".
END.
/*procesar todo ok el lote*/
FOR EACH facturas BY orden:
    FIND fac_header WHERE ROWID(fac_header) = facturas.rfac NO-LOCK.
    ReportePath = "FAC/" + formularioFAC( ROWID(fac_header) ).
    RUN VALUE( reportePath + "MR.p")  ( 
                            INPUT fac_header.tip_comprob,
                            INPUT fac_header.prf_comprob,
                            INPUT fac_header.nro_comprob,
                            INPUT fac_header.nro_comprob,
                            INPUT fac_header.cdg_empresa,
                            INPUT TRUE,
                            OUTPUT xfile
                           ).
    RUN fullPath (ReportePath, '.rpt':U, OUTPUT cFullPath).
    IF cFullPath = ? THEN
            RETURN ERROR fac_header.tip_comprob + "-" + string(fac_header.prf_comprob) + "-" + string(fac_header.nro_comprob) + " impresor " + ReportePath + ".rpt no encontrado".
    exportFileName=replace(fac_header.tip_comprob + "-" + string(fac_header.prf_comprob) + "-" + string(fac_header.nro_comprob) + "-" + fac_header.direccion ,"  " , " "  ).
    exportFileName=replace(exportFileName," " , "_"  ).
    exportFileName=replace(exportFileName,"/" , "_"  ).
    exportFileName=replace(exportFileName,"*" , "_"  ).
    exportFileName=replace(exportFileName,"\" , "_"  ).
    exportFileName=replace(exportFileName,'"' , "_"  ).
    exportFileName=replace(exportFileName,"'" , "_"  ).
    exportFileName=replace(exportFileName,"|" , "_"  ).
    exportFileName=replace(exportFileName,"<" , "_"  ).
    exportFileName=replace(exportFileName,">" , "_"  ).
    exportFileName = SESSION:TEMP-DIR + "Fact_" + exportFileName + ".pdf".
    IF SEARCH( exportFileName ) <> ? THEN DO:
       OS-DELETE value(exportFileName).
       IF ERROR-STATUS:ERROR THEN 
        RETURN ERROR "El archivo " + exportFileName + " esta siendo usado por otro usuario".   
    END.
    CREATE "CrystalRuntime.Application" chApplication.
        chReport = chApplication:OpenReport(cFullPath, {&crOpenReportByTempCopy}).
        chReport:DiscardSavedData(). /*eliminando lo previamente grabado*/
    RUN fullpath ( INPUT xfile, INPUT "", OUTPUT xFullPath ).
        chReport:Database:Tables:item(1):setTableLocation(xFullPath, '', '').
    RUN crearReporte(chReport,"pdf",/*ViewReport*/ FALSE, /*impresora*/ "" , 
            /*exportToDisk*/ true, INPUT-OUTPUT exportFileName ).        
    RELEASE OBJECT chReport. 
    chReport = ?.
    RELEASE OBJECT chApplication.
    chApplication = ?.   
    CREATE archivos.
    ASSIGN archivos.archivo = exportFileName
           archivos.direccion = fac_header.direccion
           comprobante = fac_header.tip_comprob + "-" + string(fac_header.prf_comprob) + "-" + string(fac_header.nro_comprob)
           fecha = fac_header.fecha
           cuit = IF fac_header.cod_docu <> "NO" THEN fac_header.cuit ELSE ""
           /*neto = IF substring(fac_header.tip_comprob,2,1) = "A" THEN STRING(fac_header.imp_neto,">>>>>>9.<<") ELSE ""
           iva = IF substring(fac_header.tip_comprob,2,1) = "A" THEN STRING(fac_header.imp_iva,">>>>>>9.<<") ELSE ""*/
           tot = string(fac_header.imp_total,">>>>>>9.99").
END.

/*enviar el email con todos los archivos atachados*/

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

DEFINE VAR savdir AS CHARACTER NO-UNDO.
DEFINE VAR logo AS CHAR INITIAL "logopau.jpg" NO-UNDO.
DEFINE VAR logof AS CHAR NO-UNDO.
DEFINE VAR k AS INT NO-UNDO.
DEFINE VAR adtest AS CHAR NO-UNDO .
DEFINE VAR objBP AS COM-HANDLE.

savdir = getCurrentDirectory().
RUN fullpath ( logo, INPUT "", OUTPUT logof ).

IF adtest =  "" THEN
    OUTPUT TO c:\dynasys10\logs\emailfacturas.txt APPEND.

RUN setCurrentDirectoryA(savDir).
msg1 = '<HTML><HEAD><TITLE></TITLE><META HTTP-EQUIV="Content-Type" content="text/html; charset=UTF-8"></HEAD><BODY><p><font face=Tahoma>Atte '  + html-encode(pnombre) + '</font></p>'.
msg2 = '<p><font face=Tahoma>Remitimos las facturas realizadas correspondientes a:  </font></p>'.
msg3 = '<style type="text/css">.tg  ~{border-collapse:collapse;border-spacing:0;~~}
.tg td~{font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;~}
.tg th~{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;~}
.tg .tg-ea1g~{font-weight:bold;background-color:#ff0000;color:#ffffff~}
.tg .tg-ozx2~{font-weight:bold;background-color:#ff0000;color:#ffffff;text-align:center~}
@media screen and (max-width: 767px) ~{.tg ~{width: auto !important;~}.tg col ~{width: auto !important;~}.tg-wrap ~{overflow-x: auto;-webkit-overflow-scrolling: touch;~}~}</style>
<div class="tg-wrap"><table class="tg">
  <tr>
    <th class="tg-ozx2">Fecha</th>
    <th class="tg-ea1g">Comprobante</th>
    <th class="tg-ea1g">CUIT/CDS/CUIL</th>
    <th class="tg-ea1g">Direccion</th>
    <th class="tg-ea1g">Total</th>
  </tr>'.
FOR EACH archivos NO-LOCK:
    msg3 = msg3 + '<tr><td class="tg-031e">' + string(archivos.fecha) + '</td>
    <td class="tg-031e">' + archivos.comprobante + '</td>
    <td class="tg-031e">' + archivos.cuit + '</td>
    <td class="tg-031e">' + archivos.direccion + '</td>
    <td class="tg-031e">' + archivos.tot + '</td>
  </tr>'.
END.
msg3 = msg3 + '</table>'.
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
objField:Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = "admin@paulistaservicios.com.ar".
objField:Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "joseantonio$568".      
objField:Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = TRUE.
objField:Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 100.  
objField:Update.
objMessage:Configuration = objConf.
objMessage:TO = IF adtest = "" THEN pemail ELSE adtest.
objMessage:FROM =  USER_empresa.email.
objMessage:Subject = "Paulista - Facturas ".
objMessage:HTMLBody = msg1 + msg3 + msg4 + firma.
/* desde un archivo 'objMessage.CreateMHTMLBody "file://c|/temp/test.htm"*/
FOR EACH archivos NO-LOCK:
objMessage:AddAttachment( "file://" + archivos.archivo,"","" ).
END.
objBP = objMessage:AddRelatedBodyPart("file://" + logof, logo, 0, , ).
objBP:Fields:Item("urn:schemas:mailheader:Content-ID") = "<" + logo + ">".
objBP:Fields:Update.
objMessage:Send.
PAUSE 1.
IF ERROR-STATUS:ERROR THEN do:
    RELEASE OBJECT objField NO-ERROR.
    RELEASE OBJECT objBP NO-ERROR.
    RELEASE OBJECT objMessage NO-ERROR.
    RELEASE OBJECT objConf NO-ERROR.
    RETURN ERROR.
END.
FOR EACH facturas BY orden:
    FIND fac_header WHERE ROWID(fac_header) = facturas.rfac.
    IF adtest = "" THEN fac_header.observacion = agregaAdvTexto("EMAIL ENVIO FACTURA " + pemail , fac_header.observacion ).
END.
RELEASE OBJECT objField NO-ERROR.
RELEASE OBJECT objBP NO-ERROR.
RELEASE OBJECT objMessage NO-ERROR.
RELEASE OBJECT objConf NO-ERROR.
objConf=?.
objMessage=?.  
objBP=?. 
objField = ?.

