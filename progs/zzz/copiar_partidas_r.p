DEFINE BUFFER B-Partida FOR Partida.

FOR EACH Partida WHERE Partida.cdg_empresa = "F":

    FIND Articulo OF Partida NO-ERROR.
    IF AVAILABLE Articulo
    THEN DO:
        FIND B-Partida WHERE B-Partida.cdg_empresa = "R"
                         AND B-Partida.nro_articulo = Partida.nro_articulo
                         AND B-Partida.cdg_partida  = Partida.cdg_partida
                             NO-ERROR.

        IF NOT AVAILABLE B-Partida             
        THEN DO:
            CREATE B-Partida.
            BUFFER-COPY Partida TO B-Partida 
                 ASSIGN B-Partida.cdg_empresa = "R"
                        B-Partida.nro_partida = Articulo.ult_partida + 1
                         Articulo.ult_partida = B-Partida.nro_partida.
        END.
    END.
    ELSE DO:
        DELETE Partida.
    END.    
    
END.    
