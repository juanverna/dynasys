{tiempo.i}
{extrae.i}

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



FOR EACH tarea WHERE tarea.cdg_tipotarea = "L" AND tarea.estado = "A" :
FIND cliente WHERE cliente.nro_cliente = tarea.nro_admin.
IF extrae( "imp_servicio",tarea.dato) = ? THEN do:
 FIND contrato_hd WHERE contrato_hd.nro_contrato = tarea.nro_identificacion.
 Tarea.datos-template = "imp_servicio|" + STRING(contrato_hd.imp_total) + "|durac|"  + string( erdur(tarea.nro_cliente) ) + "|" +
          "cant_periodos|" + STRING(contrato_hd.cant_periodos)+ "|prf|" + STRING(contrato_hd.prf_contrato).
END.
END.
         
