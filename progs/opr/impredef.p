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


/*genera el xml para los analisis y definitivos segun corresponda*/
DEFINE TEMP-TABLE aimp
    FIELD c_nro_tipo_evento LIKE tipo_evento.nro_tipo_evento COLUMN-LABEL "Tipo!Evento"
    FIELD nro_evento AS INT LABEL "EVENTO"
    FIELD recurso LIKE evento.recurso 
    FIELD turno LIKE evento.turno
    FIELD aviso_evento AS INT LABEL "AVISO EVENTO"
    FIELD aviso_fasignado AS DATE LABEL "REPARTIR"
    FIELD aviso_recurso AS CHAR LABEL "RECURSO"
    FIELD ftipo AS CHAR LABEL "ESPECIAL".

DEFINE BUFFER administracion FOR cliente.
/*ojo se se cambia lo mismo esta en v-evento1.w*/
DEFINE VAR estado_var AS CHAR INITIAL "Sin Observacion*,Sin Observacion,Verificar estado Tapas,Verificar estado Mamposteria".

{resultados.i}
{nommeses.i}

DEFINE TEMP-TABLE lstorden
    FIELD ind AS INT
    FIELD nro_evento AS int 
    FIELD direccion LIKE cliente.direccion
    FIELD fecha_analisis AS date
    FIELD fa_dia AS INT
    FIELD fa_mes AS character
    FIELD fa_ano AS CHARACTER
    FIELD estado_tanque AS CHAR
    FIELD frealizado LIKE evento.frealizado
    FIELD fvencimiento LIKE evento.frealizado
    FIELD Fecha_toma  LIKE evento_protocolo.Fecha_toma 
    FIELD extrajo  LIKE evento_protocolo.extrajo 
    FIELD nro_protocolo LIKE evento_protocolo.nro_protocolo
    FIELD nro_certificado AS CHAR
    FIELD letraprefijo AS CHAR
    FIELD referencia AS CHAR
    FIELD laboratorio LIKE evento_protocolo.laboratorio
    FIELD recurso LIKE Recurso.nom_recurso
    INDEX ind ind.

DEFINE TEMP-TABLE lstdetalle LIKE resultados
        FIELD ind LIKE lstorden.ind.

{crystal_dyna.p}

DEFINE INPUT PARAMETER TABLE FOR aimp.

DEFINE VAR i AS INT NO-UNDO.
DEFINE VAR k AS INT NO-UNDO.
DEFINE VAR ccant AS INT NO-UNDO.

DEFINE VAR ldato AS LONGCHAR.
DEFINE VAR retok AS LOGICAL.
DEFINE VAR dset AS HANDLE.
DEFINE VAR auxd AS DATE.

DEF VAR ReportePath AS CHAR NO-UNDO.
    DEF VAR cFullPath AS CHAR NO-UNDO.
    DEF VAR XFullPath AS CHAR NO-UNDO.
    
DEFINE DATASET dset FOR lstorden,lstdetalle 
    DATA-RELATION FOR lstorden, lstdetalle  NESTED
    RELATION-FIELDS ( ind,ind).
DEFINE VAR vind AS INT.
DEFINE VAR nrocerti LIKE certificados.nro_certificado.
DEFINE VAR letraprefijo LIKE certificados.letraprefijo.
DEFINE VAR vmcba AS LOGICAL.
vind = 0.

FIND restriccion no-lock WHERE restriccion.cdg_restriccion = "CERTILT".
FOR EACH aimp :
    vind = vind + 1.
    FIND evento WHERE evento.nro_evento = aimp.nro_evento NO-LOCK.
    FIND recurso WHERE recurso.cdg_recurso = ENTRY(1,evento.recursos) NO-LOCK.
    FIND evento_protocolo OF evento NO-ERROR.
    FIND cliente OF evento NO-LOCK.
    
    IF evento.nro_certif <> 0 THEN DO:
    ftipo = evento.tipo_certif.
    nrocerti = evento.nro_certificado.
    letraprefijo = evento.letraprefijo.
    END.
    ELSE DO:
        ftipo = IF cliente.cdg_provincia = "01" THEN "M" ELSE "P".
    END.                                                      
    IF evento.nro_certificado = 0 THEN DO:
        RUN nuevo_certif.p(ftipo , evento.nro_tipo_evento, OUTPUT ftipo , OUTPUT nrocerti ,OUTPUT letraprefijo ).
        IF nrocerti = 0 THEN RETURN ERROR.
        evento.tipo_certif = ftipo.
        evento.nro_certif = nrocerti.
        evento.letraprefijo = letraprefijo.
    END.

    IF evento.frealizado=? OR evento.anulado OR NOT AVAILABLE evento_protocolo THEN NEXT.
    IF index("PI",evento_protocolo.estado) = 0  THEN NEXT.
    ldato = evento_protocolo.dato.
    k = 0.
    retOK = TEMP-TABLE resultados:READ-XML("LONGCHAR", 
                       ldato, 
                       "EMPTY", 
                       ?, 
                       ?, 
                       ?, 
                       ?).    

    FIND cliente OF evento NO-LOCK.
    FIND administracion WHERE administracion.nro_cliente = cliente.nro_admin.

    CREATE lstorden.
        ASSIGN lstorden.nro_evento = evento.nro_evento
               lstorden.direccion = cliente.direccion
               lstorden.Frealizado = evento.frealizado
               lstorden.fecha_analisis = evento_protocolo.fecha_analisis
               lstorden.laboratorio = evento_protocolo.laboratorio
               lstorden.Fecha_toma = evento_protocolo.Fecha_toma 
               lstorden.extrajo = evento_protocolo.extrajo 
               lstorden.nro_protocolo = evento_protocolo.nro_protocolo
               lstorden.fvencimiento = sumarmeses(evento.frealizado,6)
               lstorden.referencia = administracion.nom_cli
               lstorden.ind = vind.
               lstorden.nro_certificado = string(nrocerti,"9999999").
               lstorden.letraprefijo = letraprefijo.
               lstorden.fa_dia = DAY(evento_protocolo.fecha_analisis).
               lstorden.fa_mes = nom_mes[ month(evento_protocolo.fecha_analisis) ].
               lstorden.fa_ano = string(year(evento_protocolo.fecha_analisis),">>>9").
               lstorden.recurso = recurso.nom_recurso + " DNI:" + recurso.dni.
               lstorden.estado_tanque = entry(evento.entrega + 1 ,estado_var).
               evento_protocolo.nro_certificado = nrocerti.
               evento_protocolo.letraprefijo = letraprefijo.
               evento_protocolo.tipo_certif = ftipo.
               IF evento_protocolo.fecha_entrega = ? THEN do:
                  evento_protocolo.fecha_entrega = TODAY.
                  evento_protocolo.estado = "I".
               END.
               
        IF retok THEN
            FOR EACH resultados:
                CREATE lstdetalle.
                BUFFER-COPY resultados TO lstdetalle
                    ASSIGN lstdetalle.ind =  vind.
            END.
            FOR EACH resultados:
                DELETE resultados.
            END.
     
END.

IF NOT AVAILABLE evento THEN RETURN.

ReportePath = "definit_" + STRING( evento.nro_tipo_evento ).
RUN fullPath ( ReportePath, '.rpt':U, OUTPUT cFullPath).

IF cFullPath = ? THEN DO:
 MESSAGE "No se encuentra el archivo de impresion " ReportePath SKIP
         "para el Protocolo del evento" VIEW-AS ALERT-BOX INFORMATION.
 RETURN NO-apply.
END.
xfile = TempFile("") + ".xml".

DATASET dset:WRITE-XML ("FILE", xfile, FALSE,?,"",YES,YES).

CREATE "CrystalRuntime.Application" chApplication.
chReport = chApplication:OpenReport(cFullPath, {&crOpenReportByTempCopy}).
chReport:DiscardSavedData(). /*eliminando lo previamente grabado*/
RUN fullpath ( INPUT xfile  , INPUT "", OUTPUT xFullPath ).
chReport:Database:Tables:item(1):setTableLocation(xFullPath, '', '').

RUN crearReporte(chReport,"rpt", /*ViewReport*/ FALSE , /*PrinterName*/ "?EX",
                 /*exportToDisk*/ FALSE, INPUT-OUTPUT exportFileName ). 
RELEASE OBJECT chReport. 
chReport = ?.
RELEASE OBJECT chApplication.
chApplication = ?.
