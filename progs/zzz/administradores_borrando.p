OUTPUT TO c:\administradores_borrados1.d.
DEFINE BUFFER administrador FOR cliente.
    FOR EACH administrador WHERE cdg_cliente BEGINS "A":
        FIND cliente WHERE cliente.nom_cliente = administrador.nom_cliente AND 
            rowid(cliente) <> rowid(administrador) AND 
            cliente.cdg_cliente BEGINS "C" NO-ERROR.
        IF NOT AVAILABLE cliente THEN NEXT.
        FIND fac_header WHERE fac_header.nro_cliente = administrador.nro_cliente NO-ERROR.
        IF AVAILABLE fac_header THEN NEXT.
        FIND fac_header WHERE fac_header.nro_administrador = administrador.nro_cliente NO-ERROR.
        IF AVAILABLE fac_header THEN NEXT.
        EXPORT administrador.
        /*DELETE administrador.*/
        DISPLAY cliente.cdg_cliente administrador.cdg_cliente.
    END.

