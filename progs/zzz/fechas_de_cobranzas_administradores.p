    {tiempo.i}
    DEFINE VAR aa AS INT.
    DEFINE TEMP-TABLE admin
        FIELD cdg_cliente AS CHAR
        FIELD nro_cliente AS INT
        FIELD nombre AS CHAR FORMAT "X(20)"
        FIELD dias AS CHAR FORMAT "X(40)"
        INDEX nro_cliente nro_cliente.
    FOR EACH rendicion_hd WHERE st_tesoreria = "1" AND rendicion_hd.fecha > 01/01/2012 BREAK BY nro_admin :
    IF FIRST-OF(nro_admin) THEN DO:
        FIND cliente WHERE cliente.nro_cliente = rendicion_hd.nro_admin NO-LOCK NO-ERROR.
        IF NOT AVAILABLE cliente  THEN NEXT.
        /*FIND FIRST evento WHERE NOT evento.anulado AND evento.nro_cliente = cliente.nro_cliente AND evento.nro_evento < 4 AND evento.frealizado > 05/01/2012 NO-LOCK NO-ERROR.*/
        /*IF NOT AVAILABLE evento THEN NEXT.*/
        CREATE admin.
        admin.nro_cliente = cliente.nro_cliente.
        admin.cdg_cliente = cliente.cdg_cliente.
        admin.nombre = cliente.nom_cliente.
    END.
    IF NOT AVAILABLE admin THEN NEXT.
    aa = INTERVAL( rendicion_hd.fecha , primerdia(rendicion_hd.fecha ) , "weeks" ) + 1 .
    /*admin.dia = admin.dia + "," +  string( IF aa = 5 THEN 4 ELSE aa  ) + string( WEEKDAY(rendicion_hd.fecha) ).*/
    admin.dias = admin.dias + "," + STRING( day( rendicion_hd.fecha ) ).
END.
OUTPUT TO c:\admin.txt.
FOR EACH admin:
    
    admin.dias = SUBSTRING( admin.dias , 2 ) .
    EXPORT admin.
END.
