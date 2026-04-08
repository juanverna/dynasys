{tiempo.i}

FUNCTION duref RETURNS INT
  ( d AS CHAR, h AS CHAR ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEFINE VAR hh1 AS DECIMAL NO-UNDO.
DEFINE VAR mm1 AS DECIMAL NO-UNDO.
DEFINE VAR hh2 AS DECIMAL NO-UNDO.
DEFINE VAR mm2 AS DECIMAL NO-UNDO.


h = REPLACE(h,":","").
d = REPLACE(d,":","").
hh1 = INT(h).
h = STRING(hh1,"9999").
hh1 = INT(d).
d = STRING(hh1,"9999").

hh1 = INT( SUBSTRING(d,1,2) ).
mm1 = INT( SUBSTRING(d,3,2) ).
hh2 = INT( SUBSTRING(h,1,2) ).
mm2 = INT( SUBSTRING(h,3,2) ).

mm1 = mm1 / 60.
mm2 = mm2 / 60.
hh1 = hh1 + mm1.
hh2 = hh2 + mm2.

RETURN INT((hh2 - hh1) * 60 ).   /* Function return value. */

END FUNCTION.

FUNCTION erdur RETURNS INTEGER ( rr AS INT ): 
    DEFINE VAR kk AS INT NO-UNDO.
DEFINE VAR pp1 AS INT NO-UNDO.
DEFINE VAR fecha_prev AS DATE NO-UNDO.
DEFINE VAR media AS INT NO-UNDO.
DEFINE VAR suma AS INT NO-UNDO.
DEFINE VAR pp AS INT INITIAL 5 NO-UNDO. /*cantidad de periodos maximos de analisis*/
DEFINE BUFFER bevento FOR evento.
DEFINE BUFFER weve FOR evento.

pp1 = 0.
suma = 0.
FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "LT" NO-LOCK.
    FOR EACH bevento WHERE evento.nro_cliente = rr AND bevento.nro_tipo_evento = tipo_evento.nro_tipo_evento AND
        NOT bevento.anulado AND bevento.frealizado<>? BY bevento.fasignado DESCENDING:
        kk = abs(duref(bevento.hora_desde, bevento.hora_hasta)).
        IF kk = 0 THEN NEXT.
        pp1 = pp1 + 1.
        suma = suma + kk.
        IF pp1 > pp THEN LEAVE.
    END.
    media = suma / pp1.
    pp1 = 0.
    suma = 0.
    FOR EACH bevento WHERE bevento.nro_cliente = rr AND bevento.nro_tipo_evento = tipo_evento.nro_tipo_evento AND
        NOT bevento.anulado AND bevento.frealizado<>? BY bevento.fasignado DESCENDING:
            kk = duref(bevento.hora_desde, bevento.hora_hasta).
            IF kk <= media * .8 OR kk >= media * 1.2 THEN NEXT.
        pp1 = pp1 + 1.
        suma = suma + duref(bevento.hora_desde, bevento.hora_hasta).
        IF pp1 > pp THEN LEAVE.
    END.
    media = suma / pp1.
    RETURN media.
END FUNCTION. 


DEFINE BUFFER bcontrato_hd FOR contrato_hd.
DEFINE VAR dd AS DATE NO-UNDO.
DEFINE VAR hh AS DATE NO-UNDO.
DEFINE VAR kk AS DATE NO-UNDO.
DEFINE VAR k AS INT NO-UNDO.
DEFINE VAR sololistar AS LOGICAL INITIAL FALSE.
DEFINE VAR diabase AS DATE NO-UNDO.
DEFINE VAR i AS INT NO-UNDO.
DEFINE VAR soloh AS CHAR NO-UNDO.
DEFINE VAR solog AS INT NO-UNDO.
DEFIN VAR fecha_prev AS DATE NO-UNDO.
DEFINE VAR hoy AS DATE NO-UNDO.
DEFINE VAR pimp_servicio LIKE contrato_hd.imp_total NO-UNDO.
DEFINE VAR pimp_firma LIKE contrato_hd.imp_total NO-UNDO.
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
               IF NOT CAN-DO(soloh, "C" ) THEN next.
               CREATE tt.
               ASSIGN tt.cdg_recurso = recurso.cdg_recurso
                      tt.nom_recurso = Recurso.nom_recurso.
                      tt.grado = solog.
    END.
  END.

OUTPUT TO c:\dynasys10\logs\genera_tarea_tanques.log APPEND.
DISPLAY "Fecha corrida" NOW.
{advtexto.i}
    hoy = today.
diabase = hoy.
dd = DATE(MONTH(diabase),1,YEAR(diabase)).
dd = sumarmeses(dd,2).
hh = dd + 32.
hh = DATE(MONTH(hh),1,YEAR(hh)).
hh = hh - 1.


FOR EACH contrato_hd WHERE contrato_hd.estado = "A" AND contrato_hd.fecha_baja = ? AND
        contrato_hd.cant_periodos <> 0 AND NOT contrato_hd.anulado AND
        contrato_hd.nro_tipo_evento = 3:
        FOR EACH contrato_dt WHERE contrato_dt.nro_articulo = 0:
             DELETE contrato_dt.
        END.
            FIND FIRST contrato_dt OF contrato_hd NO-ERROR.
        IF NOT AVAILABLE contrato_dt THEN NEXT.
        FIND articulo OF contrato_dt NO-LOCK NO-ERROR.
        if NOT AVAILABLE articulo THEN NEXT.

        FIND cliente OF contrato_hd NO-LOCK NO-ERROR.
        IF NOT AVAILABLE cliente THEN NEXT.

        FIND FIRST evento WHERE evento.nro_tipo_evento = contrato_hd.nro_tipo_evento AND
             evento.origen = "contrato" AND evento.nro_identificacion = contrato_hd.nro_contrato AND
             evento.frealizado <> ? AND
             NOT evento.anulado NO-ERROR.
        IF NOT AVAILABLE evento THEN NEXT.

        kk = sumarmeses(evento.frealizado,contrato_hd.nro_plazo).
        fecha_prev = kk.
/*IF evento.frealizado < 07/30/2013 OR kk>hh THEN NEXT.*/
        IF kk<dd OR kk>hh THEN NEXT.

    FIND FIRST tarea WHERE Tarea.origen = "CONTRATO" AND 
               tarea.nro_identificacion = evento.nro_identificacion  and
               tarea.cdg_tipotarea = "L" NO-LOCK NO-ERROR.
    IF AVAILABLE tarea THEN NEXT.
/*por si se renovo directamente*/    
    FIND FIRST bcontrato_hd WHERE bcontrato_hd.fecha_baja = ? AND
        bcontrato_hd.cant_periodos <> 0 AND NOT bcontrato_hd.anulado AND
        bcontrato_hd.rige_desde > contrato_hd.rige_hasta AND
        bcontrato_hd.nro_tipo_evento = 3 NO-ERROR.
        IF AVAILABLE bcontrato_hd THEN NEXT.

    
        DISPLAY evento.nro_tipo_evento 
                evento.nro_evento 
                cliente.cdg_cliente 
                contrato_hd.nro_contrato 
                evento.frealizado 
                tarea.estado WHEN AVAILABLE tarea.
    IF sololistar THEN DO:
        NEXT.
    END.
    FIND bcontrato_hd WHERE bcontrato_hd.nro_contrato = evento.nro_identificacion NO-LOCK NO-ERROR.
    CREATE tarea.
    ASSIGN
          Tarea.nro_identificacion = evento.nro_identificacion
          tarea.origen = "CONTRATO"
          Tarea.cdg_tipotarea = "L" 
          Tarea.comunicarsepor = "T".
          tarea.descripcion = agregaAdvTexto("Renovacion CTO:" + string(evento.nro_identificacion) , tarea.descripcion ).
    ASSIGN
          Tarea.direccion=cliente.direccion 
          Tarea.nro_tipo_evento = 3
          Tarea.estado="A" 
          Tarea.visualizar = diabase
          Tarea.fecha_alta = TODAY 
          Tarea.hora_alta = string(time,"HH:MM") 
          Tarea.fecha_reportado=diabase 
          Tarea.fecha_resuelto=? 
          Tarea.geolat=cliente.geolat
          Tarea.geolong = cliente.geolong
          Tarea.geoX = cliente.geoX
          Tarea.geoY = cliente.geoY
          Tarea.horas_estimadas = 480
          Tarea.localidad = cliente.localidad
          Tarea.nom_cliente = Cliente.nom_cliente
          Tarea.nro_cliente = cliente.nro_cliente
          Tarea.nro_tarea = NEXT-VALUE(proxima_tarea)
          Tarea.telefonos = cliente.telefono
          Tarea.nro_administrador = cliente.nro_admin
          Tarea.cdg_proyecto = "G".
          REPEAT:
             IF NOT es_habil(date(tarea.visualizar),"23456") THEN
                       tarea.visualizar = ADD-INTERVAL(tarea.visualizar,-1,"days").
             ELSE LEAVE.
          END.

          FOR EACH tt BY tt.grado:
                        tarea.cdg_recurso = tt.cdg_recurso.
                        LEAVE.
          END.
          /*Tarea.datos-template = "imp_servicio|" + STRING(bcontrato_hd.imp_total) + "|durac|"  + string( erdur(tarea.nro_cliente) ) + "|" +
          "cant_periodos|" + STRING(bcontrato_hd.cant_periodos)+ "|prf|" + STRING(bcontrato_hd.prf_contrato)   .*/
          FIND lista_precios WHERE lista_precios.cdg_lista = contrato_hd.cdg_lista NO-LOCK NO-ERROR.
          FIND articulo WHERE articulo.cdg_articulo = "23F" NO-LOCK NO-ERROR.
          FIND contrato_dt OF contrato_hd WHERE contrato_dt.nro_articulo = articulo.nro_articulo NO-LOCK NO-ERROR.
          IF AVAILABLE contrato_dt THEN DO:
               IF NOT AVAILABLE articulo THEN NEXT.
               IF AVAILABLE lista_precios THEN DO:
                   FIND LAST Articulo_precio OF Articulo 
                   WHERE Articulo_precio.cdg_lista   = Lista_precios.cdg_lista 
                     AND Articulo_precio.cdg_empresa = contrato_hd.cdg_empresa
                     AND Articulo_precio.fch_desde <= contrato_hd.rige_desde
                       NO-LOCK NO-ERROR.
                   IF NOT AVAILABLE articulo_precio THEN
                       pimp_firma = contrato_dt.precio_cf.
                   ELSE 
                      pimp_firma = Articulo_precio.precio_cf.
               END.
               ELSE pimp_firma = contrato_dt.precio_cf.
          END.

          FIND lista_precios WHERE lista_precios.cdg_lista = contrato_hd.cdg_lista NO-LOCK NO-ERROR.
          FIND articulo WHERE articulo.cdg_articulo = "23F" NO-LOCK NO-ERROR.
          FIND FIRST contrato_dt OF contrato_hd WHERE contrato_dt.nro_articulo <> articulo.nro_articulo NO-LOCK NO-ERROR.
          IF AVAILABLE contrato_dt THEN DO:
               IF NOT AVAILABLE articulo THEN NEXT.
               IF AVAILABLE lista_precios THEN DO:
                   FIND LAST Articulo_precio OF Articulo 
                   WHERE Articulo_precio.cdg_lista   = Lista_precios.cdg_lista 
                     AND Articulo_precio.cdg_empresa = contrato_hd.cdg_empresa
                     AND Articulo_precio.fch_desde <= fecha_prev
                       NO-LOCK NO-ERROR.
                   IF NOT AVAILABLE articulo_precio THEN
                       pimp_servicio = contrato_dt.precio_cf.
                   ELSE 
                      pimp_servicio = Articulo_precio.precio_cf.
               END.
               ELSE pimp_servicio = contrato_dt.precio_cf.
          END.
          
          tarea.datos-template =  "lista_precio|" + string(contrato_hd.cdg_lista) + "|imp_servicio|" + STRING(pimp_servicio) + "|imp_firma|" + STRING(pimp_firma) + "|durac|480"  + "|" +
              "cant_periodos|" + STRING(contrato_hd.cant_periodos)+ "|prf|1".
          Tarea.titulo = "Renovacion CTO:" + string(evento.nro_identificacion).
          Tarea.fecha_prevista  = diavalido( MONTH(dd) , DAY(evento.frealizado) , year(dd) )  NO-ERROR.


        k = 0.
        DO WHILE Tarea.fecha_prevista = ? or WEEKDAY(Tarea.fecha_prevista) = 7 OR AVAILABLE feriado :
            k = k + 1.
            Tarea.fecha_prevista = DATE( MONTH(dd) , DAY(evento.frealizado) - k , year(dd) )  NO-ERROR.
            FIND feriado WHERE feriado.fecha = Tarea.fecha_prevista NO-LOCK NO-ERROR.
        END.
END.
/*forzar la restriccion a laboratorio 0*/

 FIND restriccion no-lock WHERE restriccion.nro_tipo_evento = 3 AND
    restriccion.cdg_restriccion BEGINS "ANAGUA".
 FOR EACH evento WHERE evento.nro_tipo_evento = 3 AND evento.fasignado >= hoy:
         FOR EACH contrato_hd WHERE contrato_hd.nro_contrato = evento.nro_identificacion:
                  FIND FIRST contrato_restriccion WHERE contrato_restriccion.nro_contrato = contrato_hd.nro_contrato and
                          contrato_restriccion.sub_evento = 1 AND 
                          contrato_restriccion.nro_restriccion = restriccion.nro_restriccion NO-ERROR.
        
                  IF AVAILABLE contrato_restriccion THEN DO:
                      contrato_restriccion.valor = "0".
                  END.
                  ELSE DO:
                      CREATE contrato_restriccion.
                      ASSIGN contrato_restriccion.nro_contrato = contrato_hd.nro_contrato
                          contrato_restriccion.sub_evento = 1
                          contrato_restriccion.nro_restriccion = restriccion.nro_restriccion.
                      contrato_restriccion.valor = "0".
                  END.
         END.
 END.

