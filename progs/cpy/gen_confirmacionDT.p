/*tareas de confirmacion*/
{stavisado.i}
{tiempo.i}
OUTPUT TO c:\dynasys10\logs\gen_confirmacionDT.LOG APPEND.
DISPLAY "Fecha corrida" NOW.
DEFINE VAR hoy AS DATE NO-UNDO.
DEFINE VAR rok like tarea.nro_tarea NO-UNDO.
DEFINE VAR mindia AS DATE NO-UNDO.
hoy = TODAY .
mindia = suma_dia_habil(hoy,4,"23456").
FIND restriccion WHERE restriccion.cdg_restriccion = "CONFDT" NO-LOCK NO-ERROR.
FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "DT" NO-LOCK.
FIND FIRST recurso WHERE CAN-DO(recurso.habilidades,"Y@1") NO-LOCK NO-ERROR.
FIND usuario OF recurso NO-LOCK NO-ERROR.
FOR EACH evento WHERE evento.nro_tipo_evento = tipo_evento.nro_tipo_evento AND
        evento.fasignado <= mindia AND
        evento.frealizado = ? AND evento.evaluar AND evento.sub_evento <= 1 AND NOT evento.anulado:
  FIND FIRST tarea OF evento WHERE tarea.cdg_tipotarea = "Y" and
        ( tarea.estado = "A" or tarea.estado = "R" ) NO-LOCK NO-ERROR.
  IF AVAILABLE tarea THEN NEXT.
  FIND contrato_restriccion WHERE contrato_restriccion.nro_contrato = evento.nro_identificacion and
      contrato_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
  IF NOT AVAILABLE contrato_restriccion THEN NEXT.

  RUN crea_tarea.p ( evento.nro_evento , evento.nro_cliente , "Y" , "Confirmar Destapacion " + contrato_restriccion.valor , "Confirmar FU:" + string(evento.fasignado) , resta_dia_habil(evento.fasignado,3,"23456") ,"ENC", OUTPUT rok ).
END.
