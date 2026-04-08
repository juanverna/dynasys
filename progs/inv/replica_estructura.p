DEFINE BUFFER B-Nueva FOR clase_de_articulo.
DEFINE VARIABLE QUE AS CHARACTER.
REPEAT:
    UPDATE QUE.
    FOR EACH Clase_de_articulo WHERE Clase_de_articulo.cdg_clase BEGINS ".F.AH.20":
        /*DISPLAY cdg_clase CDG_SUBCLASE.*/
        
        CREATE B-Nueva.
        BUFFER-COPY Clase_de_articulo TO B-Nueva
            ASSIGN B-Nueva.cdg_subclase = REPLACE(Clase_de_articulo.cdg_subclase,"F.AH.20.","F.AH.25.")
                   B-Nueva.cdg_clase    = REPLACE(Clase_de_articulo.cdg_clase,"F.AH.20","F.AH.25" ).
                   
           
    END.
END.
