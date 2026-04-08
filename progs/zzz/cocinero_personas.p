FOR EACH contrato_hd WHERE nro_persona <> 0:
FIND cliente OF contrato_hd.
FIND domicilio OF cliente.
DEFINE BUFFER bpersona FOR persona.
find cliente-contacto OF domicilio WHERE preferido no-error.
    IF NOT AVAILABLE cliente-contacto THEN NEXT.
    IF contrato_hd.nro_persona = cliente-contacto.nro_persona  THEN NEXT.
    FIND persona WHERE persona.nro_persona = cliente-contacto.nro_persona.
    FIND bpersona WHERE bpersona.nro_persona = contrato_hd.nro_persona NO-ERROR.
    IF NOT AVAILABLE bpersona  THEN do:
        contrato_hd.nro_persona = cliente-contacto.nro_persona.
        NEXT.
    END.
    IF NOT CAN-FIND(FIRST cliente-contacto WHERE cliente-contacto.nro_persona = contrato_hd.nro_persona) THEN
    DO:
        contrato_hd.nro_persona = cliente-contacto.nro_persona.
        IF AVAILABLE bpersona THEN DELETE bpersona.
    END.
END.
