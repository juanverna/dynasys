    DEFINE BUFFER administrador FOR cliente.
    FOR EACH cliente:
        FIND administrador WHERE administrador.nro_cliente = cliente.nro_administrador NO-ERROR.
        IF NOT AVAILABLE ADMINISTRADOR THEN DISPLAY cliente.NOM_CLIENTE.
END.
