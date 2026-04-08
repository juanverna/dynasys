    {tiempo.i}
    DEFINE VAR i AS INT.
    FOR EACH evento WHERE evento.nro_planasignar = 7720 AND NOT anulad AND fasignado <> fmin
AND nro_tipo_evento = 13:
    i = 0.
    REPEAT:
        IF es_habil(fmin + i,"23456")  THEN LEAVE.
        i = i + 1.
    END.
    evento.fasignado = fmin + i.
    FOR EACH recurso_agenda OF evento:
        recurso_agenda.fecha = fmin + i.
    END.
    DISPLAY evento.nro_evento.
    END.
