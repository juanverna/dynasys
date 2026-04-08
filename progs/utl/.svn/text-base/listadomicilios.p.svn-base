    OUTPUT TO "c:\sic-temp\domics.txt".
    FOR EACH cliente:
    FIND domicilio OF cliente NO-ERROR.
    EXPORT  DELIMITER ";" cliente.cdg_cliente 
            cliente.nom_cliente
            cliente.cuit
            domicilio.direccion     WHEN AVAILABLE domicilio
            domicilio.cdg_postal    WHEN AVAILABLE domicilio
            domicilio.localidad     WHEN AVAILABLE domicilio
            domicilio.cdg_provincia WHEN AVAILABLE domicilio.
            
END.
