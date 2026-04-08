DEFINE BUFFER B FOR Partida.
DEFINE BUFFER P FOR Partida.

FOR EACH P:

    FOR EACH Empresa WHERE Empresa.cdg_empresa <> P.cdg_empresa:
        FIND Articulo OF P NO-ERROR.
        IF AVAILABLE Articulo
        THEN DO:
            FIND B WHERE B.cdg_empresa = Empresa.cdg_empresa
                     AND B.nro_articulo = P.nro_articulo
                     AND B.cdg_partida  = P.cdg_partida
                         NO-ERROR.
                         
            IF NOT AVAILABLE B             
            THEN DO:
                 CREATE B.
                 BUFFER-COPY P TO B 
                             ASSIGN B.cdg_empresa = Empresa.cdg_empresa
                                    B.nro_partida = Articulo.ult_partida + 1
                                    Articulo.ult_partida = B.nro_partida.
            END.
        END.
        ELSE DO:
            IF AVAILABLE P THEN DELETE P.
        END.    
    
    END.
END.    
