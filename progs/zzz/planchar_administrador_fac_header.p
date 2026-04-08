    DEFINE BUFFER administrador FOR cliente.
    FOR EACH fac_header:
    FIND administrador WHERE fac_header.nro_administrador = administrador.nro_cliente NO-ERROR.
    IF NOT AVAILABLE administrador THEN DO:
        FIND administrador WHERE fac_header.nro_cliente = administrador.nro_cliente NO-ERROR.
        fac_header.nro_administrador = administrador.nro_cliente.
        fac_header.cdg_administrador = administrador.cdg_cliente.
        Fac_header.direccion_administrador = administrador.direccion.
        Fac_header.nom_Administrador = administrador.nom_cliente.
        fac_header.mostrar_admin = administrador.mostrar_admin.
    END.
    IF fac_header.cdg_administrador <> administrador.cdg_cliente and
        fac_header.cdg_administrador <> "A0999" THEN
    DO:
        fac_header.nro_administrador = administrador.nro_cliente.
        fac_header.cdg_administrador = administrador.cdg_cliente.
        Fac_header.direccion_administrador = administrador.direccion.
        Fac_header.nom_Administrador = administrador.nom_cliente.
        fac_header.mostrar_admin = administrador.mostrar_admin.
        
    END.
    END.
