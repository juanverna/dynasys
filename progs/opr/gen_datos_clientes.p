/*generacion de tareas de busqueda de informacion pendientes para contactos.
Se requiere que exista un contacto para la administracion y un encargado para el cliente*/
/*si hay una tareas del tipo I no genera otra adicional.*/
OUTPUT TO c:\dynasys10\logs\gen_datos_clientes.LOG APPEND.
DISPLAY "Fecha corrida" NOW.
{tiempo.i}
DEFINE VAR ddd AS DATE NO-UNDO.
DEFINE VAR hhh AS DATE NO-UNDO.
DEFINE VAR pperiodo AS INT NO-UNDO.
DEFINE VAR hoy AS DATE NO-UNDO.
  DEFINE VAR almenos AS LOGICAL NO-UNDO.
  DEFINE VAR ptel1 AS CHAR NO-UNDO.
  DEFINE VAR ptel2 AS CHAR NO-UNDO.
DEFINE VAR ii AS INT NO-UNDO.
DEFINE VAR kk AS INT NO-UNDO.
DEFINE BUFFER administracion FOR cliente.
DEFINE VAR rok like tarea.nro_tarea NO-UNDO.
DEFINE VAR n_o AS CHAR NO-UNDO.

hoy = TODAY.
pperiodo = YEAR(hoy) * 100 + month(hoy).
ddd = DATE(MONTH(hoy),1,year(hoy)).
hhh = DATE( MONTH(ddd + 32 ), 1 , YEAR( ddd + 32 ) ) - 1 .

DEFINE TEMP-TABLE procesados
    FIELD nroc LIKE tarea.nro_cliente.


/*se busca en los abonos en curso*/
EMPTY TEMP-TABLE procesados.
FOR EACH contrato_hd WHERE contrato_hd.estado = "A" AND contrato_hd.rige_hasta >= ddd AND
      contrato_hd.rige_desde <= hhh AND
      ( contrato_hd.cant_periodos = 0 )
      AND year(contrato_hd.rige_desde) * 100 + month(contrato_hd.rige_desde)  <= pperiodo and 
      not Contrato_hd.anulado and  ( contrato_hd.fecha_baja = ? OR year(contrato_hd.fecha_baja) * 100 + MONTH(contrato_hd.fecha_baja) > pperiodo ) 
      ,FIRST cliente OF contrato_hd ,FIRST administracion WHERE administracion.nro_cliente = cliente.nro_admin BREAK BY cliente.nro_admin:

/*el cliente tiene contacto del tipo ENCARGADO*/
    n_o = "".
    FIND restriccion WHERE restriccion.cdg_restriccion = "NO-ENC" NO-LOCK NO-ERROR.
    IF AVAILABLE restriccion THEN DO:
        FIND cliente_restriccion WHERE cliente_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
        IF AVAILABLE cliente_restriccion THEN 
                n_o = cliente_restriccion.valor.
    END.
    
    FIND cargo_persona WHERE cargo_persona.cdg_cargo = "ENC" NO-LOCK NO-ERROR.
    IF AVAILABLE cargo_persona AND n_o <> "" THEN DO:
            FIND domicilio OF cliente NO-LOCK.
       almenos=FALSE.
       FOR EACH cliente-contacto OF domicilio WHERE Cliente-contacto.cdg_cargo = cdg_cargo,
            FIRST Persona OF cliente-contacto NO-LOCK.
            ptel1 = "".
            ptel2 = "".
            DO ii = 1 TO NUM-ENTRIES(persona.numeros_telefono,"|"):
               IF entry(2,ENTRY(ii,persona.numeros_telefono,"|"),"!") <> "" THEN DO:
                   IF kk = 0 THEN DO:
                      ptel1 = entry(2,ENTRY(ii,persona.numeros_telefono,"|"),"!").
                      kk = 1.
                   END.
                   ELSE
                      ptel2 = entry(2,ENTRY(ii,persona.numeros_telefono,"|"),"!").
               END.
            END.
    
            IF index("0123456789-. " , substring( persona.nombre , 1 , 1 )) = 0 and ( LENGTH( ptel1 ) <> 0 OR LENGTH( ptel2 ) <> 0 ) THEN do:
                almenos=true.
                LEAVE.
            END.
       END.
       /*no se encontro ninguno?*/
        IF NOT almenos THEN DO:
            FIND procesados WHERE procesados.nroc = cliente.nro_cliente NO-ERROR.
            IF NOT AVAILABLE procesados THEN DO:
                    CREATE procesados.
                    ASSIGN procesados.nroc = cliente.nro_cliente.
            END.
            FIND FIRST tarea WHERE tarea.cdg_tipotarea = "I" AND tarea.nro_cliente = cliente.nro_cliente AND tarea.estado = "A" NO-LOCK NO-ERROR. 
            IF NOT AVAILABLE tarea THEN DO:
                RUN crea_tarea.p ( 0, cliente.nro_cliente, "I", "Datos Encargado", "", hoy, "*", OUTPUT rok).
                    END.
        END.
    END.
/*vamos con la administracion*/
    IF FIRST-OF(cliente.nro_admin) THEN DO:
        n_o = "".
        FIND restriccion WHERE restriccion.cdg_restriccion = "NO-ADM" NO-LOCK NO-ERROR.
        IF AVAILABLE restriccion THEN DO:
            FIND cliente_restriccion OF cliente WHERE cliente_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
            IF AVAILABLE cliente_restriccion THEN 
                    n_o = cliente_restriccion.valor.
        END.
    
        FIND cargo_persona WHERE cargo_persona.cdg_cargo = "ADM" AND n_o <> "" NO-LOCK NO-ERROR.
        IF AVAILABLE cargo_persona THEN DO:
                FIND domicilio OF administracion NO-LOCK.
           almenos=FALSE.
           FOR EACH cliente-contacto OF domicilio WHERE Cliente-contacto.cdg_cargo = cdg_cargo,
                FIRST Persona OF cliente-contacto NO-LOCK.
                ptel1 = "".
                ptel2 = "".
                DO ii = 1 TO NUM-ENTRIES(persona.numeros_telefono,"|"):
                   IF entry(2,ENTRY(ii,persona.numeros_telefono,"|"),"!") <> "" THEN DO:
                       IF kk = 0 THEN DO:
                          ptel1 = entry(2,ENTRY(ii,persona.numeros_telefono,"|"),"!").
                          kk = 1.
                       END.
                       ELSE
                          ptel2 = entry(2,ENTRY(ii,persona.numeros_telefono,"|"),"!").
                   END.
                END.
        
                IF index("0123456789-. " , substring( persona.nombre , 1 , 1 )) = 0 and ( LENGTH( ptel1 ) <> 0 OR LENGTH( ptel2 ) <> 0 )  THEN do:
                    FIND restriccion WHERE restriccion.cdg_restriccion = "EMAIL" NO-LOCK.
                    FIND cliente_restriccion OF cliente WHERE cliente_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK.
                    IF NOT AVAILABLE cliente_restriccion THEN DO:
                        almenos=true.
                        LEAVE.
                    END.
                    ELSE DO:
                        IF cliente_restriccion.valor <> "" THEN DO:
                            almenos = emailcheck(Persona.email).
                            LEAVE.
                        END.
                    END.
                END.
           END.
           /*si se encontro algun error procesar*/
            IF NOT almenos THEN DO:
                FIND procesados WHERE procesados.nroc = cliente.nro_cliente NO-ERROR.
                IF NOT AVAILABLE procesados THEN DO:
                        CREATE procesados.
                        ASSIGN procesados.nroc = cliente.nro_cliente.
                END.
                FIND FIRST tarea WHERE tarea.cdg_tipotarea = "I" AND tarea.nro_cliente = administracion.nro_cliente AND tarea.estado = "A" NO-LOCK NO-ERROR. 
                IF NOT AVAILABLE tarea THEN DO:
                    RUN crea_tarea.p ( 0, administracion.nro_cliente, "I", "Datos Administracion", "", hoy, "", OUTPUT rok).
                        END.
            END.
        END.
    END.
END.
/*borrando eliminando las tareas con datos ya corregidos*/
FOR EACH tarea WHERE tarea.cdg_tipotarea = "I" AND tarea.estado = "A":
        FIND procesados WHERE tarea.nro_cliente = procesados.nroc NO-ERROR.
        IF NOT AVAILABLE procesados THEN DELETE tarea. /*la borro no es una tarea de importancia para lo historico*/
END.
