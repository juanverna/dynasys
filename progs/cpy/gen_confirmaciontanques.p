/*tareas de confirmacion*/
{stavisado.i}
{tiempo.i}
OUTPUT TO c:\dynasys10\logs\gen_confirmaciontanques.LOG APPEND.
DISPLAY "Fecha corrida" NOW.
DEFINE VAR hoy AS DATE NO-UNDO. 
DEFINE VAR rok like tarea.nro_tarea NO-UNDO.
DEFINE VAR mindia AS DATE NO-UNDO.
hoy = TODAY .
mindia = suma_dia_habil(hoy,4,"23456").
FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "LT" NO-LOCK.
FIND FIRST recurso WHERE CAN-DO(recurso.habilidades,"T@1") NO-LOCK NO-ERROR.
FIND usuario OF recurso NO-LOCK NO-ERROR.
FOR EACH evento WHERE evento.nro_tipo_evento = tipo_evento.nro_tipo_evento AND
        evento.fasignado <= mindia AND
        evento.frealizado = ? AND evento.evaluar AND NOT evento.anulado:
  FIND FIRST tarea OF evento WHERE tarea.cdg_tipotarea = "T" AND 
      ( tarea.estado = "A" or tarea.estado = "R" ) NO-LOCK NO-ERROR.
  IF AVAILABLE tarea THEN NEXT.
  /*en todos los casos genero la tarea de confirmacion*/
  RUN crea_tarea.p ( evento.nro_evento , evento.nro_cliente , "T" , "Confirmar Tanque" , "Confirmar LT:" + string(evento.fasignado) , resta_dia_habil(evento.fasignado,3,"23456")  ,"ENC", OUTPUT rok ).
END.
FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "RT" NO-LOCK.
FIND FIRST recurso WHERE CAN-DO(recurso.habilidades,"T@1") NO-LOCK NO-ERROR.
FIND usuario OF recurso NO-LOCK NO-ERROR.
FOR EACH evento WHERE evento.nro_tipo_evento = tipo_evento.nro_tipo_evento AND
        evento.fasignado <= mindia AND
        evento.frealizado = ? AND evento.evaluar AND NOT evento.anulado:
  FIND FIRST tarea OF evento WHERE tarea.cdg_tipotarea = "T" AND 
      ( tarea.estado = "A" or tarea.estado = "R" ) NO-LOCK NO-ERROR.
  IF AVAILABLE tarea THEN NEXT.
  /*en todos los casos genero la tarea de confirmacion*/
  RUN crea_tarea.p ( evento.nro_evento , evento.nro_cliente , "T" , "Confirmar Reparacion" , "Confirmar RT:" + string(evento.fasignado) , resta_dia_habil(evento.fasignado,3,"23456")  ,"ENC", OUTPUT rok ).
END.
