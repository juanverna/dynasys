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
DEFINE VAR frecuencia AS CHAR NO-UNDO.
DEFINE BUFFER bevento FOR evento.
DEFINE VAR listaev AS CHAR NO-UNDO.
DEFINE VAR k AS INT NO-UNDO.
frecuencia = "".
/*colo emite email con el certificado si ya ha sido impreso con anterioridad*/
FIND evento WHERE evento.nro_evento = pnro NO-ERROR.
IF NOT AVAILABLE evento THEN LEAVE.
IF evento.nro_certif = 0 THEN RETURN.
IF evento.nro_tipo_evento <> 1 THEN RETURN. /*SOLO PARA FU */
savdir = getCurrentDirectory().
RUN fullpath ( logo, INPUT "", OUTPUT logof ).
FIND usuario WHERE usuario.cdg_usuario = USERID("sic").
FOR EACH user_empresa OF usuario BY  User_empresa.rige_desde DESC:
    LEAVE.
END.
IF NOT AVAILABLE USER_empresa THEN DO:
    MESSAGE "Usted no tiene la direccion de email registrada" skip
            "no se enviara email" VIEW-AS ALERT-BOX ERROR.
    RETURN ERROR.
END.
IF USER_empresa.email = "" THEN DO:
    MESSAGE "Usted no tiene direccion de email registrada" SKIP
            "no se enviara el email" VIEW-AS ALERT-BOX ERROR.
    RETURN ERROR.
END.
FIND cliente OF evento NO-LOCK NO-ERROR.

exportFileName=replace(cliente.direccion," " , "_"  ).
exportFileName=replace(exportFileName,"/" , "_"  ).
exportFileName=replace(exportFileName,"*" , "_"  ).
exportFileName=replace(exportFileName,"\" , "_"  ).
exportFileName=replace(exportFileName,'"' , "_"  ).
exportFileName=replace(exportFileName,"'" , "_"  ).
exportFileName=replace(exportFileName,"|" , "_"  ).
exportFileName=replace(exportFileName,"<" , "_"  ).
exportFileName=replace(exportFileName,">" , "_"  ).

exportFileName = SESSION:TEMP-DIR + exportFileName + ".pdf".
OS-DELETE value(exportFileName).
IF ERROR-STATUS:ERROR THEN DO:
    MESSAGE "El archivo " exportFileName " esta siendo usado por otro usuario" SKIP 
            "no se puede proseguir" VIEW-AS alert-box error.
    RETURN ERROR.
END.
/*a quien le enviamos a partir del evento buscar administracion y preferido*/
FIND administracion WHERE administracion.nro_cliente = cliente.nro_admin NO-LOCK NO-ERROR.
IF NOT AVAILABLE administracion THEN LEAVE.
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
   evento.observacion = agregaAdvTexto("ERROR NO Email Certif[falta restrccion EMAIL)",evento.observacion).
   LEAVE.
END.
IF LOOKUP("CERTIF",cliente_restriccion.valor,"|") = 0 THEN DO:
   evento.observacion = agregaAdvTexto("ERROR NO se envia EMAIL por restrccion)",evento.observacion).
   LEAVE.
END.
FIND restriccion WHERE restriccion.cdg_restriccion BEGINS "CERTI" AND restriccion.nro_tipo_evento = evento.nro_tipo_evento NO-LOCK NO-ERROR.
IF NOT AVAILABLE restriccion THEN RETURN.


IF evento.origen = "CONTRATO" THEN DO:
    FIND contrato_hd NO-LOCK WHERE contrato_hd.nro_contrato = evento.nro_identificacion.
    IF NOT AVAILABLE contrato_hd THEN RETURN.
    IF Contrato_hd.numero_eventos <> evento.sub_evento THEN RETURN.
    FIND FIRST contrato_restriccion OF restriccion WHERE contrato_restriccion.nro_contrato = evento.nro_identificacion and
           contrato_restriccion.sub_evento = 1 NO-LOCK NO-ERROR.
    IF NOT AVAILABLE contrato_restriccion THEN RETURN.
    frecuencia = ENTRY( int(contrato_hd.modo_facturacion) , frecuenciacar ).
END.


FIND contrato_hd WHERE contrato_hd.nro_contrato = evento.nro_identificacion.
FIND contrato_restriccion OF restriccion WHERE contrato_restriccion.nro_contrato = evento.nro_identificacion NO-LOCK NO-ERROR.
IF NOT AVAILABLE contrato_restriccion THEN RETURN.
/*creando el certificado*/
ffr = "Realz:".
fr = evento.frealizado.
IF fr = ? THEN do:
    fr = evento.fasignado.
    ffr = "Asign:".
END.
    
/*veamos el tipo de certificado a emitir*/

ReportePath = "certif_" + trim(string(evento.nro_tipo_evento)) + TRIM(evento.tipo_certif) + "Email".
RUN fullPath (ReportePath, '.rpt':U, OUTPUT cFullPath).
IF cFullPath = ? 
THEN DO:
    RUN mensajepar.p (INPUT ReportePath, INPUT "CREP000").
    RETURN ERROR.
END.

FIND recurso NO-LOCK WHERE recurso.cdg_recurso = ENTRY(1,evento.recursos) NO-ERROR.
IF NOT AVAILABLE recurso THEN DO:
    MESSAGE "Recurso " evento.recursos " no disponible" VIEW-AS ALERT-BOX ERROR.
    RETURN ERROR.
END.

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
           parametros.mesano  =  string(fr,"99/99/9999").    
           parametros.operario =  if available recurso then Recurso.nom_recurso else " ".   
           parametros.proserv   = proxserv.
           parametros.frecuencia = frecuencia. 
           parametros.nrocertif = STRING(evento.nro_certi).
          xfile = tempfile("") + ".xml". 
  TEMP-TABLE  parametros:WRITE-XML ("FILE", xfile, FALSE,
                                       ?,"",YES,YES).

   chReport:Database:Tables:item(1):setTableLocation(xfile, '', '').

    RUN crearReporte(chReport,"pdf",/*ViewReport*/ NO,/*PrinterName*/ "",
                 /*exportToDisk*/ TRUE, INPUT-OUTPUT exportFileName ).
    IF ERROR-STATUS:ERROR THEN DO:     
        MESSAGE "Existio un problema al generar el reporte" SKIP "no puede continuar" VIEW-AS ALERT-BOX ERROR.
        RETURN ERROR.
    END.    
        RELEASE OBJECT chReport. 
        chReport = ?.
        RELEASE OBJECT chApplication.
        chApplication = ?.
       RUN borra_temp ( INPUT xfile, OUTPUT ERROR_nro ).
REPEAT k = 1 TO NUM-ENTRIES(listaev):
  FIND bevento WHERE bevento.nro_evento = INT( ENTRY(k,listaev) ) EXCLUSIVE-LOCK.
  bevento.observacion = agregaAdvTexto("Certif Imp " + ffr + STRING( fr ),bevento.observacion).
END.

RUN setCurrentDirectoryA(savDir).
MESSAGE "Se ha generado el certificado en " exportFileName VIEW-AS ALERT-BOX INFORMATION.




