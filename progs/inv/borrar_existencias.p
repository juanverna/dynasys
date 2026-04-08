/*====================================================================================*/
/*           INICIALIZA EL REGISTRO DE MOVIMIENTOS DE STOCK                           */
/*====================================================================================*/

FOR EACH acumulado_stock:
    DELETE acumulado_stock.
END.

FOR EACH Partida:
    ASSIGN Partida.remanente_granel    = 0
           Partida.remanente_cantidad  = 0
           Partida.reservado_granel    = 0
           Partida.reservado_cantidad  = 0.
END.

FOR EACH Partida-deposito:
    ASSIGN
       Partida-deposito.remanente_granel    = 0
       Partida-deposito.remanente_cantidad  = 0
       Partida-deposito.reservado_granel    = 0
       Partida-deposito.reservado_cantidad  = 0.
END.


FOR EACH Articulo-deposito:
    ASSIGN
       Articulo-deposito.remanente_granel    = 0
       Articulo-deposito.remanente_cantidad  = 0
       Articulo-deposito.reservado_granel    = 0
       Articulo-deposito.reservado_cantidad  = 0.
END.

MESSAGE "termino"
    VIEW-AS ALERT-BOX INFO BUTTONS OK.
