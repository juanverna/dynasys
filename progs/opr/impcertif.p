FUNCTION sumarmeses RETURNS DATE
    (fechaini AS DATE, meses AS INT ):
DEFINE VAR dia AS INT.
DEFINE VAR mes AS INT.
DEFINE VAR anio AS INT.
DEFINE VAR ff AS DATE.
DEFINE VAR k AS INT NO-UNDO.


/*recortamos la cadena separandola en 
 //tres variables de dia, mes y año*/
dia = day(fechaini).
mes = month(fechaini).
anio = year(fechaini).
 
 /*/Sumamos los meses requeridos*/

 anio = anio + TRUNCATE( meses / 12 , 0).
 mes = mes + ( meses MOD 12).
 
 /*Comprobamos que al sumar no nos hayamos
 //pasado del año, si es así incrementamos
 //el año*/
 if ( mes > 12)
 THEN DO:
  mes = mes - 12.
  anio = anio + 1.
 END.
 
 ff = DATE( mes , dia , anio ) NO-ERROR.
 IF ERROR-STATUS:ERROR THEN
     DO k = dia TO 28 BY -1:
         ff = DATE( mes , k , anio ) NO-ERROR.
     END.
 RETURN ff .
 
 
END FUNCTION.
/*------------------------------------------------------------------------------
  Purpose:     imprime el certificado solo para fumi y para LT
  Parameters:  <none>
  Notes: El evento ya esta disponible y seleccionado      
------------------------------------------------------------------------------*/
DEFINE INPUT PARAM pnro LIKE evento.nro_evento. 
DEFINE INPUT PARAM momento AS CHAR.
DEFINE INPUT PARAM impnro AS int.
DEFINE VAR fr AS DATE NO-UNDO.
DEFINE VAR ffr AS CHAR NO-UNDO.
DEFINE BUFFER bevento FOR evento.

    DEFINE TEMP-TABLE parametros
    FIELD direccion      AS CHAR
    FIELD razon          AS CHAR
    FIELD mesano         AS CHAR
    FIELD operario      AS CHAR
    FIELD proserv       AS CHAR
    FIELD frecuencia    AS CHAR
    FIELD letraprefijo     AS CHAR
    FIELD nrocertif     AS CHAR
    FIELD fa_dia AS INT
    FIELD fa_mes AS character
    FIELD fa_ano AS CHARACTER
    FIELD estado_tanque AS CHAR
    FIELD frealizado LIKE evento.frealizado
    FIELD laboratorio LIKE evento_protocolo.laboratorio
    FIELD recurso LIKE Recurso.nom_recurso.

/*DEFINE VAR nro_tipo_evento_ec LIKE evento.nro_tipo_evento NO-UNDO.*/
{advtexto.i}
{extrae.i}
{crystal_dyna.p}
 DEFINE VAR cFullPath AS CHAR NO-UNDO.
  DEFINE VAR xFullPath AS CHAR NO-UNDO.
  DEFINE VAR ReportePath AS CHAR NO-UNDO.
 DEFINE VAR dset AS HANDLE. 
{nommeses.i}
DEFINE VAR ERROR_nro AS INT NO-UNDO.
DEFINE VAR frecuenciacar AS CHAR INITIAL "Mensual,Bimestral,Trimestral,ada 4 meses,Cara 5 meses,Cara 6 meses,Cara 7 meses,Cara 8 meses,Cara 9 meses,Cara 10 meses,Cara 11 meses,Anual".
DEFINE VAR estado_var AS CHAR INITIAL "Sin Observacion*,Sin Observacion,Verificar estado Tapas,Verificar estado Mamposteria".
DEFINE BUFFER administracion FOR cliente.
DEFINE VAR nrocerti LIKE certificados.nro_certificado.
DEFINE VAR letraprefijo LIKE certificados.letraprefijo.
DEFINE VAR ftipo AS CHAR NO-UNDO.
DEFINE VAR frecuencia AS CHAR NO-UNDO.
DEFINE VAR proxserv AS CHAR NO-UNDO.
DEFINE VAR k AS INT NO-UNDO.
DEFINE VAR listaev AS CHAR NO-UNDO.
DEFINE VAR proxasignado AS DATE NO-UNDO.
FIND impresora WHERE impresora.cdg_impresora = impnro NO-LOCK NO-ERROR.
IF NOT AVAILABLE impresora THEN DO:
    MESSAGE "No se encuentra la impresora para el canal " impnro  skip
            "Corrija e intente nuevamente" VIEW-AS ALERT-BOX ERROR.
    RETURN ERROR.
END.
/*FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "EC" NO-LOCK.
nro_tipo_evento_ec = tipo_evento.nro_tipo_evento.*/
frecuencia = "".
FIND evento WHERE evento.nro_evento = pnro NO-LOCK NO-ERROR.
IF NOT AVAILABLE evento THEN RETURN.
FIND cliente OF evento NO-LOCK NO-ERROR.
IF NOT AVAILABLE cliente THEN RETURN.
FIND administracion WHERE cliente.nro_admin = administracion.nro_cliente NO-LOCK.
IF NOT AVAILABLE administracion THEN RETURN.
FIND restriccion WHERE restriccion.cdg_restriccion BEGINS "CERTI" AND restriccion.nro_tipo_evento = evento.nro_tipo_evento NO-LOCK NO-ERROR.
IF NOT AVAILABLE restriccion THEN RETURN.
IF evento.origen = "MANUAL" THEN RETURN.
IF evento.anulado THEN RETURN.

/*esta parte depende del tipo de nro de evento*/

IF evento.origen = "CONTRATO" THEN DO:
    FIND contrato_hd NO-LOCK WHERE contrato_hd.nro_contrato = evento.nro_identificacion.
    IF NOT AVAILABLE contrato_hd THEN RETURN.
    /*IF int(contrato_hd.modo_facturacion) > 1 THEN RETURN. */
    IF evento.nro_tipo_evento = 1 AND Contrato_hd.numero_eventos <> evento.sub_evento THEN RETURN.
    IF evento.nro_tipo_evento = 3 AND evento.sub_evento <> 1 THEN RETURN.
    FIND FIRST contrato_restriccion OF restriccion WHERE contrato_restriccion.nro_contrato = evento.nro_identificacion and
           contrato_restriccion.sub_evento = 1 NO-LOCK NO-ERROR.
    IF AVAILABLE contrato_restriccion AND contrato_restriccion.valor <> momento AND momento <> "*" THEN RETURN.
    frecuencia = ENTRY( int(contrato_hd.modo_facturacion) , frecuenciacar ).
END.
ELSE IF evento.origen BEGINS "REMIT" THEN DO:
    FIND tarea NO-LOCK WHERE tarea.nro_evento = evento.nro_evento NO-ERROR.
    IF NOT AVAILABLE tarea THEN RETURN.
    IF NOT logical(extrae("certifica",tarea.datos-template)) THEN RETURN.
END.
ELSE RETURN.

IF evento.frealizado = ? AND evento.fasignado = ? THEN DO:
    MESSAGE "El evento no esta realizado ni asignado" SKIP
            "no puede imprimirse el certificado" VIEW-AS ALERT-BOX ERROR.
    RETURN ERROR.
END.
ffr = "Realz:".
fr = evento.frealizado.
IF fr = ? THEN do:
    fr = evento.fasignado.
    ffr = "Asign:".
END.
FIND cliente OF evento NO-LOCK.
IF evento.frealizado <> ?  THEN evento.nro_certif = evento.nro_evento.
IF evento.nro_certif <> 0 THEN DO:
    ftipo = evento.tipo_certif.
    nrocerti = evento.nro_certificado.
    letraprefijo = evento.letraprefijo.
END.
ELSE DO:
    ftipo = IF cliente.cdg_provincia = "01" THEN "M" ELSE "P".
END.                                                      
IF evento.nro_certificado = 0 THEN DO:
    RUN nuevo_certif.p(ftipo , evento.nro_tipo_evento, OUTPUT ftipo,OUTPUT nrocerti ,OUTPUT letraprefijo ).
    IF nrocerti = 0 THEN RETURN ERROR.
    FIND CURRENT evento EXCLUSIVE-LOCK.
    evento.tipo_certif = ftipo.
    evento.nro_certif = nrocerti.
    evento.letraprefijo = letraprefijo.
    FIND CURRENT evento NO-LOCK.
END.

ReportePath = trim( "certif_" + STRING( evento.nro_tipo_evento ) + trim(ftipo) + trim(impresora.driver) ).
/*MESSAGE ReportePath .*/
RUN fullPath (ReportePath, '.rpt':U, OUTPUT cFullPath).
IF cFullPath = ? 
THEN DO:
    RUN mensajepar.p (INPUT ReportePath, INPUT "CREP000").
    RETURN ERROR.
END.

FIND recurso NO-LOCK WHERE recurso.cdg_recurso = ENTRY(1,evento.recursos).
/*proximo evento*/
/*armo una lista de dias asignados*/

listaev = "".
REPEAT k = 1 TO evento.sub_evento:
    FOR EACH bevento NO-LOCK WHERE bevento.nro_tipo_evento = evento.nro_tipo_evento AND
    bevento.nro_cliente = evento.nro_cliente AND NOT bevento.anulado AND 
    bevento.periodo = evento.periodo AND
    bevento.sub_evento =  k AND
    bevento.nro_identificacion = evento.nro_identificacion BY bevento.fasignado: 
    IF LOOKUP(string( day( bevento.fasignado) ,"99" ),proxserv ) = 0 THEN
       listaev = listaev + "," + STRING(bevento.nro_evento).
    END.
END.
/*proximos eventos*/
IF evento.nro_tipo_evento = 3 THEN 
    proxserv = string(fr + 180).
ELSE DO:
      REPEAT k = 1 TO evento.sub_evento:
        FOR EACH bevento NO-LOCK WHERE bevento.nro_tipo_evento = evento.nro_tipo_evento AND
            bevento.nro_cliente = evento.nro_cliente AND NOT bevento.anulado AND 
            bevento.periodo > evento.periodo AND
            bevento.sub_evento =  k AND
            bevento.nro_identificacion = evento.nro_identificacion BY bevento.fasignado: 
            IF LOOKUP(string( day( bevento.fasignado) ,"99" ),proxserv ) = 0 THEN DO:
                  proxserv = proxserv + "," + string( day( bevento.fasignado) ,"99" ) .
                  proxasignado = bevento.fasignado.
            END.
            LEAVE.
        END.
      END.
      proxserv = SUBSTRING(proxserv,2) + SUBSTRING( string(proxasignado,"99/99/9999") , 3 ).
      proxserv = REPLACE(proxserv,","," y ").
      IF proxserv = ? THEN  proxserv = "Vencimiento: 30 dias".
      ELSE proxserv = "Proximo Servicio: " + proxserv.
END.
listaev = SUBSTRING(listaev,2).
CREATE "CrystalRuntime.Application" chApplication.
chReport = chApplication:OpenReport(cFullPath, {&crOpenReportByTempCopy}).
chReport:DiscardSavedData(). /*eliminando lo previamente grabado*/
CREATE parametros.
ASSIGN   parametros.direccion  = cliente.direccion + " - " + cliente.localidad.
         parametros.mesano  =  string(fr,"99/99/9999").  
         parametros.razon = Cliente.nom_cliente.
         parametros.letraprefijo = letraprefijo.
         IF evento.nro_tipo_evento = 3 THEN do:
             FIND evento_protocolo OF evento NO-LOCK NO-ERROR.
             IF AVAILABLE evento_protocolo THEN DO:
                parametros.fa_dia = DAY(evento_protocolo.fecha_analisis).
                parametros.fa_mes = nom_mes[ month(evento_protocolo.fecha_analisis) ].
                parametros.fa_ano = string(year(evento_protocolo.fecha_analisis),">>>9").
             END.
         END.
         parametros.recurso = recurso.nom_recurso + " DNI:" + recurso.dni.
         parametros.estado_tanque = entry(evento.entrega + 1 ,estado_var).
         parametros.operario =  if available recurso then Recurso.nom_recurso else " ".   
         parametros.proserv   = proxserv.
         parametros.frealizado = fr.  
         parametros.frecuencia = frecuencia. 
         parametros.nrocertif = STRING(nrocerti).
         parametros.nrocertif = STRING(nrocerti).
        xfile = tempfile("") + ".xml". 
TEMP-TABLE  parametros:WRITE-XML ("FILE", xfile, FALSE,
                                     ?,"",YES,YES).

 chReport:Database:Tables:item(1):setTableLocation(xfile, '', '').

RUN crearReporte(chReport,"rpt",/*ViewReport*/ FALSE, /*impresora*/ impresora.nombre , 
    /*exportToDisk*/ FALSE, INPUT-OUTPUT exportFileName ).        
    RELEASE OBJECT chReport. 
    chReport = ?.
    RELEASE OBJECT chApplication.
    chApplication = ?.
   /*RUN borra_temp ( INPUT xfile, OUTPUT ERROR_nro ).*/
REPEAT k = 1 TO NUM-ENTRIES(listaev):
    FIND evento WHERE evento.nro_evento = int( entry( k , listaev )) EXCLUSIVE-LOCK.
    evento.nro_certificado =  nrocerti.
    evento.letraprefijo = letraprefijo.
    evento.tipo_certif = ftipo.
    evento.observacion = agregaAdvTexto("Certif Imp " + ffr + STRING( fr ),evento.observacion).
END.

