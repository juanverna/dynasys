{tiempo.i}
FUNCTION duref
RETURNS INT
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

FUNCTION rdur 
RETURNS INTEGER
  ( rr AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  Duracion media
    Notes:  Se tiene en cuenta de descartar valores  alejados +- 20% de la media
------------------------------------------------------------------------------*/
DEFINE VAR kk AS INT NO-UNDO.
DEFINE VAR pp1 AS INT NO-UNDO.
DEFINE VAR media AS INT NO-UNDO.
DEFINE VAR suma AS INT NO-UNDO.
DEFINE VAR pp AS INT INITIAL 5 NO-UNDO. /*cantidad de periodos maximos de analisis*/
DEFINE BUFFER bevento FOR evento.
DEFINE BUFFER weve FOR evento.
pp1 = 0.
suma = 0.
FIND weve WHERE weve.nro_evento = rr NO-LOCK.
CASE weve.origen:
WHEN "CONTRATO" THEN DO:
    FOR EACH bevento WHERE bevento.origen = weve.origen AND 
        bevento.nro_identificacion = weve.nro_identificacion AND
        bevento.sub_evento = weve.sub_evento AND
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
        FOR EACH bevento WHERE bevento.origen = weve.origen AND 
        bevento.nro_identificacion = weve.nro_identificacion AND
        bevento.sub_evento = weve.sub_evento AND
         NOT bevento.anulado AND bevento.frealizado<>? BY bevento.fasignado DESCENDING:
            kk = duref(bevento.hora_desde, bevento.hora_hasta).
            IF kk <= media * .8 OR kk >= media * 1.2 THEN NEXT.
        pp1 = pp1 + 1.
        suma = suma + duref(bevento.hora_desde, bevento.hora_hasta).
        IF pp1 > pp THEN LEAVE.
    END.
    media = suma / pp1.
    RETURN media.
END.
WHEN "COBRANZA" THEN DO:
    FOR EACH bevento WHERE bevento.nro_cliente = weve.nro_cliente AND 
        bevento.nro_tipo_evento = weve.nro_tipo_evento AND
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
        FOR EACH bevento WHERE bevento.nro_cliente = weve.nro_cliente AND 
        bevento.nro_tipo_evento = weve.nro_tipo_evento AND
        NOT bevento.anulado AND bevento.frealizado<>? BY bevento.fasignado DESCENDING:
            kk = duref(bevento.hora_desde, bevento.hora_hasta).
            IF kk <= media * .8 OR kk >= media * 1.2 THEN NEXT.
        pp1 = pp1 + 1.
        suma = suma + duref(bevento.hora_desde, bevento.hora_hasta).
        IF pp1 > pp THEN LEAVE.
    END.
    media = suma / pp1.
    RETURN media.
END.
OTHERWISE RETURN ?.
END.
END FUNCTION.


FUNCTION vadur
RETURNS INTEGER
  ( d AS CHAR, h AS CHAR ,du AS INT) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEF VAR v AS DECIMAL NO-UNDO.
v = ahdec( aint( h ) ) - ahdec( aint( d ) ).
IF v = ? THEN RETURN du.
RETURN INT( v * 60 ).
END FUNCTION.

DEFINE VAR v-origen AS CHAR INITIAL "*". 
DEFINE VAR ctipo AS CHAR INITIAL "FU".
DEFINE VAR v-mes AS INT INITIAL 8.
DEFINE VAR v-ano AS INT INITIAL 2011.
DEFINE VAR pridia AS DATE.
DEFINE VAR ultdia AS DATE.
DEFINE VAR num-eventos AS INT .
DEFINE VAR i AS INT.
DEFINE VAR cnecesarios AS INT.
DEFINE VAR cteventos AS INT.
DEFINE VAR cdisponibles AS INT.
DEFINE TEMP-TABLE tt
FIELD vm AS INT
FIELD va AS INT
FIELD rdur AS decimal
FIELD tip AS CHAR
FIELD ce AS INT
FIELD cn AS INT
FIELD cd AS INT.
{tt2xls.i}
REPEAT v-ano = 2009 TO 2011:
REPEAT v-mes = 1 TO 12:
cteventos = 0.
cnecesarios = 0.
cdisponibles = 0.  
num-eventos = 0. 
    pridia = DATE(v-mes,1,v-ano).
        ultdia = pridia + 32.
        ultdia = DATE(MONTH(ultdia),1,YEAR(ultdia)) - 1.
    
    FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = ctipo.
     FOR EACH evento WHERE 
         /*evento.origen = v-origen AND*/
         evento.frealizado <> ? AND /*
         evento.fasignado = ? AND */
         evento.nro_tipo_evento = tipo_evento.nro_tipo_evento AND
         evento.evaluar = TRUE AND
         NOT evento.anulado AND
         evento.fmax >= pridia AND
         evento.fmin <= ultdia NO-LOCK:
          num-eventos = num-eventos + 1.
          i = IF NUM-ENTRIES( evento.recursos ) <> 0 THEN NUM-ENTRIES( evento.recursos ) ELSE 1.
          cnecesarios = cnecesarios + i * vadur(evento.hora_desde,evento.hora_hasta,evento.durac).
          cteventos = num-eventos.
          
     END.
    
    FOR EACH recurso_capacidad WHERE recurso_capacidad.fecha >= pridia AND recurso_capacidad.fecha <= ultdia AND
             recurso_capacidad.nro_tipo_evento = tipo_evento.nro_tipo_evento NO-LOCK:
               FIND recurso OF recurso_capacidad NO-LOCK NO-ERROR.
               IF AVAILABLE recurso THEN DO:
                   FIND feriado WHERE feriado.fecha = recurso_capacidad.fecha NO-LOCK NO-ERROR.
                   IF AVAILABLE feriado THEN NEXT.
                   FIND recurso_horasxdia WHERE recurso_horasxdia.cdg_recurso = recurso_capacidad.cdg_recurso AND
                        recurso_horasxdia.fecha = recurso_capacidad.fecha NO-LOCK NO-ERROR.
                   IF NOT AVAILABLE recurso_horasxdia THEN NEXT.
                   IF recurso_horasxdia.horas > recurso_capacidad.capacidad THEN
                        cdisponibles = cdisponibles +  recurso_horasxdia.horas.
                   ELSE
                        cdisponibles = cdisponibles +  recurso_capacidad.capacidad.
               END.
         END.      
    DISPLAY v-mes v-ano cteventos  cnecesarios cdisponibles.   
CREATE tt.
ASSIGN 
tt.vm = v-mes
tt.va = v-ano
tt.tip = ctipo
tt.ce = cteventos
tt.cn = cnecesarios
tt.cd = cdisponibles.
END.
END.
RUN pTT2XLS                                                              
   ( INPUT TEMP-TABLE tt:DEFAULT-BUFFER-HANDLE,                       
     INPUT 'c:\temp\usorecursos.xls',                                               
     INPUT 'PageSetup:PrintGridlines=Y|PageSetup:PrintTitleRows=$1:$1' ). 
