{tt2xls.i}
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



FUNCTION rdur  RETURNS INTEGER (OUTPUT muestras AS CHAR,OUTPUT muestrasdef AS CHAR,OUTPUT tmuestras AS CHAR,OUTPUT ttur AS CHAR) :
/*------------------------------------------------------------------------------
  Purpose:  Duracion media
    Notes:  Se tiene en cuenta de descartar valores  alejados +- 20% de la media
------------------------------------------------------------------------------*/
DEFINE VAR kk AS INT NO-UNDO.
DEFINE VAR pp1 AS INT NO-UNDO.
DEFINE VAR media AS INT NO-UNDO.
DEFINE VAR suma AS INT NO-UNDO.
DEFINE BUFFER bevento FOR evento.
DEFINE BUFFER brecurso_agenda FOR recurso_agenda.
DEFINE VAR pp AS INT INITIAL 4 NO-UNDO.
DEFINE VAR i AS INT NO-UNDO.
pp1 = 0.
suma = 0.

IF evento.origen = "CONTRATO" THEN DO:
    FOR EACH bevento WHERE bevento.origen = evento.origen AND evento.periodo >= 201301 AND
        bevento.nro_identificacion = evento.nro_identificacion AND
        bevento.sub_evento = evento.sub_evento AND
         NOT bevento.anulado AND bevento.frealizado<>? BY bevento.fasignado DESCENDING:
        bevento.durac = duref(bevento.hora_desde, bevento.hora_hasta).
        IF bevento.durac = ?  THEN NEXT.
        muestras = muestras + "," + string(bevento.durac).
        /*calculando el turno en el dia del operario*/
        FIND FIRST recurso_agenda OF bevento NO-ERROR.
        IF AVAILABLE recurso_agenda THEN DO:
            i = 0.
            FOR EACH brecurso_agenda WHERE brecurso_agenda.cdg_recurso = recurso_agenda.cdg_recurso AND
                brecurso_agenda.fecha = recurso_agenda.fecha , evento OF brecurso_agenda ,recurso OF recurso_agenda BY Evento.hora_desde :
                i = i + 1.
                
                IF brecurso_agenda.nro_evento = recurso_agenda.nro_evento THEN DO:
                        tmuestras = tmuestras + "," + recurso.turno + STRING(i,"9").
                        LEAVE.
                END.
            END.
        END.
        pp1 = pp1 + 1.
        IF pp1 > pp THEN LEAVE.
    END.
    muestras = SUBSTRING(muestras,2).
    tmuestras = SUBSTRING(tmuestras,2).
    pp1 = 0.
    Do i = 1 TO NUM-ENTRIES(muestras):
        kk = int(ENTRY(i,muestras)).
        IF kk < 20 OR kk > 300 THEN NEXT.
        pp1 = pp1 + 1.
        suma = suma + kk.
    END.
    
    media = suma / pp1.
    pp1 = 0.
    suma = 0.

    /*limpiando*/

    muestrasdef = "".
    pp1 = 0.
    Do i = 1 TO NUM-ENTRIES(muestras):
        kk = int(ENTRY(i,muestras)).
        IF kk < media * .8 OR kk > media * 1.2 THEN NEXT.
           pp1 = pp1 + 1.
           muestrasdef = muestrasdef + "," + STRING(kk).
           suma = suma + kk.
    END.
    muestrasdef = SUBSTRING(muestrasdef,2).
    media = suma / pp1.
    /*Turnos*/
    ttur = "".
    DO i = 1 TO NUM-ENTRIES(tmuestras):
        IF ttur = "" THEN
            ttur = ENTRY(i,tmuestras).
        ELSE DO:
            IF ttur <> ENTRY(i,tmuestras) THEN DO:
                ttur = SUBSTRING(ttur,1,1) + "*".
                LEAVE.
            END.
        END.
    END.
    RETURN media.
END.
ELSE  RETURN ?.
END FUNCTION.

DEFINE VAR mu AS CHAR NO-UNDO.
DEFINE VAR mudef AS CHAR NO-UNDO.
DEFINE VAR tmu AS CHAR NO-UNDO.
DEFINE VAR tmudef AS CHAR NO-UNDO.
DEFINE VAR ttur AS CHAR NO-UNDO.

DEFINE VAR rr AS INT NO-UNDO.
DEFINE TEMP-TABLE aexcel
    FIELD cdg_cliente LIKE cliente.cdg_cliente
    FIELD direccion LIKE cliente.direccion
    FIELD duracion AS INT LABEL "DUO"
    FIELD rr1 AS INT LABEL "RDU"
    FIELD rr2 AS INT LABEL "SDU"
    FIELD muestras AS CHAR LABEL "MUESTRAS"
    FIELD muestrasdef AS CHAR LABEL "MUDEF"
    FIELD tteo AS CHAR LABEL "TTEO"
    FIELD Tmuestras AS CHAR LABEL "MTUR"
    FIELD rtu AS CHAR LABEL "RTU".

DEFINE VAR w AS INT NO-UNDO.
DEFINE VAR teodur AS INT NO-UNDO.
DEFINE VAR teotur AS CHAR NO-UNDO.
                SESSION:IMMEDIATE-DISPLAY = TRUE.
    FOR EACH evento WHERE evento.periodo >= 201501 AND evento.origen = "contrato" AND NOT anulado, cliente OF evento:
        PAUSE 0.
        DISPLAY evento.nro_evento.
    FIND contrato_hd WHERE evento.nro_identificacion = contrato_hd.nro_contrato.
    FIND FIRST contrato_restriccion OF contrato_hd WHERE contrato_restriccion.nro_restriccion = 16 NO-ERROR.
    teodur = IF AVAILABLE contrato_restriccion THEN int(contrato_restriccion.valor) ELSE "-9999".
    FIND FIRST contrato_restriccion OF contrato_hd WHERE contrato_restriccion.nro_restriccion = 19 NO-ERROR.
    teotur = IF AVAILABLE contrato_restriccion THEN replace(contrato_restriccion.valor,"|","") ELSE "**".
    rr = rdur( OUTPUT mu , OUTPUT mudef, OUTPUT tmu, OUTPUT ttur ).
    FIND aexcel WHERE aexcel.cdg_cliente = cliente.cdg_cliente NO-ERROR.
    IF AVAILABLE aexcel THEN NEXT.
    W = w + 1.
    IF w > 3000000 THEN LEAVE.
    IF rr <> ? THEN DO:
        CREATE aexcel.
        ASSIGN aexcel.direccion = cliente.direccion
            aexcel.cdg_cliente = cliente.cdg_cliente
            aexcel.duracion = teodur
            aexcel.rr1 = rr
            aexcel.rr2 = int( (rr + 4 )/ 10) * 10
            aexcel.muestras = mu
            aexcel.muestrasdef = mudef
            aexcel.Tmuestras = Tmu
            aexcel.Tteo = Teotur
            aexcel.RTU = TTUR.
            FIND FIRST contrato_restriccion OF contrato_hd WHERE contrato_restriccion.nro_restriccion = 16 NO-ERROR.
            IF AVAILABLE contrato_restriccion THEN DO:
                contrato_restriccion.valor = string(rr2,">>9").
            END.
    END.
    ELSE DO:
        CREATE aexcel.
        ASSIGN aexcel.direccion = cliente.direccion
            aexcel.cdg_cliente = cliente.cdg_cliente
            aexcel.duracion = teodur
            aexcel.rr1 = 0
            aexcel.rr2 = 0
            aexcel.muestras = mu
            aexcel.muestrasdef = mudef
            aexcel.Tmuestras = Tmu
            aexcel.Tteo = Teotur
            aexcel.RTU = TTUR.
    END.
END.
FOR EACH evento WHERE evento.frealizado = ? AND periodo >= 201704 AND evento.origen = "contrato"
    AND NOT evento.anulado, 
    cliente OF evento:
    FIND contrato_hd WHERE evento.nro_identificacion = contrato_hd.nro_contrato.
    FIND FIRST contrato_restriccion OF contrato_hd WHERE contrato_restriccion.nro_restriccion = 16 NO-ERROR.
    IF AVAILABLE contrato_restriccion THEN 
        evento.duracion = int(contrato_restriccion.valor).
END. 
   RUN pTT2XLS                                                                
     ( INPUT TEMP-TABLE aexcel:DEFAULT-BUFFER-HANDLE,                         
       INPUT 'c:\temp\duracion2.xls',                                                 
       INPUT 'PageSetup:PrintGridlines=Y|PageSetup:PrintTitleRows=$1:$1' ). 
