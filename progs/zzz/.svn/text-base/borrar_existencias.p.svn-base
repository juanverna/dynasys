FOR EACH Cct_stock WHERE tip_comprob BEGINS "V" OR tip_comprob BEGINS "O":

    FIND Articulo OF Cct_stock.

    FOR EACH Articulo-deposito OF Articulo:

        ASSIGN Articulo-deposito.encompra_cantidad     = 0
               Articulo-deposito.encompra_granel       = 0
               Articulo-deposito.remanente_cantidad    = 0
               Articulo-deposito.remanente_granel      = 0
               Articulo-deposito.reservado_cantidad    = 0
               Articulo-deposito.reservado_granel      = 0.

    END.

    FOR EACH Partida-deposito OF Articulo:

        ASSIGN Partida-deposito.encompra_cantidad      = 0
               Partida-deposito.encompra_granel        = 0
               Partida-deposito.remanente_cantidad     = 0
               Partida-deposito.remanente_granel       = 0
               Partida-deposito.reservado_cantidad     = 0
               Partida-deposito.reservado_granel       = 0.

    END.

    FOR EACH Partida OF Articulo:

        ASSIGN Partida.encompra_cantidad               = 0
               Partida.encompra_granel                 = 0
               Partida.remanente_cantidad              = 0
               Partida.remanente_granel                = 0
               Partida.reservado_cantidad              = 0
               Partida.reservado_granel                = 0.

    END.

    DELETE Cct_stock.

END.
