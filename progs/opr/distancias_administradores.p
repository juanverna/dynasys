{GeoLibrary.i}
    DEFINE BUFFER administrador FOR cliente.
        DEFINE TEMP-TABLE dd
            FIELD nro_cliente LIKE cliente.nro_cliente
            FIELD imp AS DECIMAL
            FIELD veces AS INT
                INDEX nro_cliente nro_cliente.
FOR first cliente WHERE cliente.direccion CONTAINS "Cabrera 3568":
END.

FOR EACH rendicion_hd WHERE rendicion_hd.fch_rendicion >= 08/01/2014 AND 
    rendicion_hd.fch_rendicion < 09/01/2014:
    FIND dd WHERE dd.nro_cliente = rendicion_hd.nro_administrador NO-ERROR.
    IF NOT AVAILABLE dd THEN DO:
    CREATE dd.
    ASSIGN dd.nro_cliente = rendicion_hd.nro_administrador.
    END.
    ASSIGN dd.veces = dd.veces + 1
           dd.imp = dd.imp + rendicion_hd.imp_imputado.
END.
OUTPUT TO c:\temp\distancia_administradores.csv.
EXPORT DELIMITER ";" "CODIGO" "NOMBRE" "DIRECCION" "DISTANCIA" "IMPORTE" "VECES".
FOR EACH dd:
    FIND administrador WHERE administrador.nro_cliente = dd.nro_cliente NO-LOCK.
EXPORT DELIMITER ";" administrador.cdg_cliente administrador.nom_cliente administrador.direccion distGeodesicaUTM( administrador.geoX , administrador.geoY , cliente.geoX , cliente.geoY )
    dd.imp dd.veces.
END.
    
