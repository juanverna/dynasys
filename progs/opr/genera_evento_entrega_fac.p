/*generador de eventos de reparto de facturas*/
OUTPUT TO c:\dynasys10\logs\gen_evento_entrega_fac.log APPEND.
DISPLAY "Fecha corrida" NOW.
DEFINE VAR lleva AS CHAR NO-UNDO.
DEFINE VAR prest AS CHAR NO-UNDO.
DEFINE VAR fmin AS DATE NO-UNDO.
DEFINE VAR fmax AS DATE NO-UNDO.
DEFINE VAR pdurac AS INT NO-UNDO INITIAL 15.
DEFINE VAR dformat AS CHAR NO-UNDO.
DEFINE VAR saltar AS LOGICAL NO-UNDO.
DEFINE VAR enproc_nro_evento AS INT NO-UNDO.
DEFINE VAR pperiodo AS INT NO-UNDO.
DEFINE BUFFER administrador FOR cliente.
DEFINE BUFFER coevento FOR evento.
DEFINE VAR dia AS DATE.

IF DAY(TODAY) >= 10 THEN LEAVE.
SETUSERID("BATCH","batch","sic").
{advtexto.i}
{findempresa.i}
{tiempo.i}
prest = "ENVFAC".
dia = primerdia(TODAY).
FIND evento 0 NO-ERROR.
IF AVAILABLE evento THEN DELETE evento.
FIND restriccion WHERE restriccion.cdg_restriccion = prest NO-LOCK NO-ERROR.


IF NOT AVAILABLE restriccion THEN DO:
    LEAVE.
END.

FOR EACH fac_header WHERE fac_header.fecha > dia:
    FIND evento WHERE evento.nro_evento = fac_header.nro_evento_correo NO-ERROR.
    IF NOT AVAILABLE evento THEN fac_header.nro_evento_correo = 0.
END.

FOR EACH fac_header WHERE fac_header.nro_evento_correo = 0 AND fac_header.fecha >= dia
     AND fac_header.estado = "E"
     AND NOT fac_header.anulado, 
     administrador WHERE administrador.nro_cliente = fac_header.nro_administrador NO-LOCK
    BREAK by fac_header.fecha BY Fac_header.nro_administrador:
    IF FIRST-OF(Fac_header.nro_administrador) THEN DO:
        lleva = "".
        enproc_nro_evento = NEXT-VALUE(proximo_evento).
    END.
    IF day(fac_header.fecha) > 10 THEN NEXT.
    FIND cliente_restriccion OF administrador 
          WHERE cliente_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
    IF available cliente_restriccion THEN DO:
                IF cliente_restriccion.valor = "N" THEN next.
    END.
    ELSE NEXT.

    lleva = lleva + "," + fac_header.tip_comprob + "-" + string(fac_header.prf_comprob,"9999") + "-" + string(fac_header.nro_comprob,"99999999").
    fac_header.nro_evento_correo = enproc_nro_evento.
    IF LAST-OF(fac_header.nro_administrador) THEN DO:
        CREATE evento.
        ASSIGN evento.nro_evento = enproc_nro_evento
               evento.nro_tipo_evento = restriccion.nro_tipo_evento
               evento.fasignado = ?
               evento.hora_desde = ?
               evento.hora_hasta = ?
               evento.nro_identificacion = 0
               evento.origen = "ENVIO"
               evento.nro_cliente = administrador.nro_cliente
               evento.FCreado = TODAY
               evento.periodo = YEAR(fac_header.fecha) * 100 + MONTH(fac_header.fecha)
               evento.fmax = DATE(MONTH(fac_header.fecha),13,YEAR(fac_header.fecha))
               evento.fmin = primerdia(fac_header.fecha)
               evento.duracion = pdurac
               evento.turno = "**"
               evento.recurso = "".
               evento.observacion = agregaAdvTexto( substring( lleva , 2 ), evento.observacion ).
               IF administrador.observacion <> "" THEN
                       evento.observacion = agregaAdvTexto(administrador.observacion , evento.observacion).
    END.
END.

/*aparear a eventos de cobranzas ya generados*/
find tipo_evento WHERE tipo_evento.cdg_tipo_evento = "CO".
pperiodo = YEAR(dia) * 100 + MONTH(dia).
FOR EACH evento WHERE evento.origen = "ENVIO" AND evento.periodo = pperiodo:
    FIND FIRST coevento WHERE evento.nro_cliente = coevento.nro_cliente and
    coevento.nro_tipo_evento = tipo_evento.nro_tipo_evento AND
    coevento.fasignado <= evento.fmax AND coevento.fasignado >= evento.fmin AND
    coevento.frealizado <> ? AND NOT coevento.anulado AND
           coevento.periodo = evento.periodo NO-LOCK NO-ERROR.
    IF AVAILABLE coevento THEN DO:
        evento.evsigue = coevento.nro_evento.
        evento.fasignado = coevento.fasignado.
        evento.recurso = coevento.recurso.
        evento.durac = 1.
        FIND recurso_agenda OF evento NO-ERROR.
        IF NOT AVAILABLE recurso_agenda THEN DO:
            CREATE recurso_agenda.
            ASSIGN recurso_agenda.nro_evento = evento.nro_evento.
        END.
            recurso_agenda.cdg_recurso = entry(1,evento.recurso).
            recurso_agenda.fecha = evento.fasignado.
    END.
END.




