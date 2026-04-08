
OUTPUT TO VALUE(REPLACE(archivo,"XXX","{2}")). 
FOR EACH W-Docids:
    FOR EACH {1} WHERE {1}.{&NRO_INTERNO} = W-Docids.{&NRO_INTERNO}:
        EXPORT DELIMITER "|" {1}.
    END.    
END.
OUTPUT CLOSE.
