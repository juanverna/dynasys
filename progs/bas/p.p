DEFINE TEMP-TABLE bb
    FIELD recurso AS CHAR
    FIELD durac AS INT
    FIELD nro AS INT
    FIELD periodo AS INT
    INDEX recurso recurso.
{tiempo.i}
DEFINE VAR k AS INT NO-UNDO.
DEFINE VAR cc AS INT NO-UNDO.
REPEAT k = 201301 TO 201309:
FOR EACH evento WHERE evento.nro_tipo_evento = 3 AND evento.periodo = k AND
    evento.frealizado <> ? AND NOT evento.anulado:
    REPEAT cc = 1 TO NUM-ENTRIES(evento.recurso):
        FIND bb WHERE bb.recurso = ENTRY(cc,evento.recurso) AND 
            durac = adur(Evento.hora_desde,evento.hora_hasta) NO-ERROR.
        IF NOT AVAILABLE bb  THEN DO:
            CREATE bb.
            ASSIGN bb.recurso = ENTRY(cc,evento.recurso)
                bb.durac = adur(evento.hora_desde,evento.hora_hasta)
                bb.periodo = k.
        END.
            bb.nro= bb.nro + 1.
    END.
END.

END.
OUTPUT TO "CLIPBOARD".
FOR EACH bb:
    DISPLAY bb.
END.
