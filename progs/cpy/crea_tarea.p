{tiempo.i}
{advtexto.i}
{crystal_dyna.p}
{html.i}


/*crea tareas de un evento*/
/*para se fija si tiene que enviar email por el momento solo lo hace con la tarea J*/

DEFINE INPUT PARAMETER p-evento LIKE evento.nro_evento  NO-UNDO.
DEFINE INPUT PARAMETER p-nro_cliente LIKE cliente.nro_cliente NO-UNDO.
DEFINE INPUT PARAMETER p-cdg_tipotarea LIKE tarea.cdg_tipotarea  NO-UNDO.
DEFINE INPUT PARAMETER p-titulo LIKE tarea.titulo  NO-UNDO.
DEFINE INPUT PARAMETER p-descripcion LIKE tarea.descripcion  NO-UNDO.
DEFINE INPUT PARAMETER pvisualizar AS DATE  NO-UNDO.
DEFINE INPUT PARAMETER pcdg_cargo LIKE cargo.cdg_cargo  NO-UNDO.
DEFINE OUTPUT PARAMETER rok LIKE tarea.nro_tarea NO-UNDO.

DEFINE VAR i AS INT NO-UNDO.
DEFINE VAR soloh AS CHAR NO-UNDO.
DEFINE VAR solog AS INT NO-UNDO.
DEFINE TEMP-TABLE tt NO-UNDO
    FIELD cdg_recurso LIKE recurso.cdg_recurso
    FIELD nom_recurso LIKE Recurso.nom_recurso
    FIELD grado AS INT
    INDEX grado grado.
  FOR EACH Recurso BY Recurso.interno DESCENDING :
        soloh = "".
        solog = 0.
    DO i = 1 TO NUM-ENTRIES(recurso.habilidades):
                soloh = entry(1,ENTRY(i,recurso.habilidades),"@").
                solog = int(entry(2,ENTRY(i,recurso.habilidades),"@")) NO-ERROR.
               IF NOT CAN-DO(soloh, p-cdg_tipotarea ) THEN next.
               CREATE tt.
               ASSIGN tt.cdg_recurso = recurso.cdg_recurso
                      tt.nom_recurso = Recurso.nom_recurso.
                      tt.grado = solog.
    END.
  END.
rok = ?.


IF p-evento <> 0 THEN DO:
    FIND evento WHERE evento.nro_evento = p-evento.
    FIND cliente OF evento.
END.
ELSE
    FIND cliente WHERE cliente.nro_cliente = p-nro_cliente.


FIND FIRST cliente-contacto OF cliente WHERE cliente-contacto.cdg_cargo = pcdg_cargo NO-LOCK NO-ERROR.
CREATE tarea.
   ASSIGN

          Tarea.nro_evento = p-evento
          tarea.origen = IF p-evento <> 0 THEN evento.origen ELSE "MANUAL"
          Tarea.cdg_tipotarea = p-cdg_tipotarea
          Tarea.comunicarsepor = "T".
          tarea.descripcion = agregaAdvTexto(( IF p-descripcion = "" THEN p-titulo ELSE p-descripcion ) , tarea.descripcion ).
   ASSIGN
          Tarea.direccion = cliente.direccion 
          Tarea.estado = "A" 
          Tarea.fecha_alta = TODAY 
          Tarea.visualizar = pvisualizar
          Tarea.hora_alta = string(time,"HH:MM") 
          Tarea.fecha_reportado = TODAY 
          Tarea.fecha_resuelto = ? 
          Tarea.geolat = cliente.geolat
          Tarea.geolong = cliente.geolong
          Tarea.geoX = cliente.geoX
          Tarea.geoY = cliente.geoY
          Tarea.horas_estimadas = ?
          Tarea.localidad = cliente.localidad
          Tarea.nom_cliente = Cliente.nom_cliente
          Tarea.nro_cliente = cliente.nro_cliente
          Tarea.nro_tarea = NEXT-VALUE(proxima_tarea)
          Tarea.telefonos = cliente.telefono
          tarea.nro_admini = cliente.nro_admin
          Tarea.cdg_proyecto = "G"
          Tarea.datos-template = ?
          Tarea.titulo = p-titulo
          Tarea.fecha_prevista  = ?
          tarea.nro_identificacion = p-evento
          tarea.origen = "EVENTO".
          REPeat:
              IF NOT es_habil(date(tarea.visualizar),"23456") THEN
                  tarea.visualizar = ADD-INTERVAL(tarea.visualizar,-1,"days").
              ELSE LEAVE.
          END.
          FOR EACH tt BY tt.grado:
                tarea.cdg_recurso = tt.cdg_recurso.
                LEAVE.
          END.
          IF AVAILABLE cliente-contacto THEN DO:
                  tarea.nro_persona = cliente-contacto.nro_persona.
                  tarea.cdg_cargo = pcdg_cargo.
          END.
          rok = tarea.nro_tarea.
          tarea.turnogestion = aturno(cliente.horario_de_atencion).
          

