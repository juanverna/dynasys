FOR EACH Rem_header EXCLUSIVE-LOCK:

    Rem_header.tip_comprob = "RM".

    FIND Deposito OF Rem_header NO-LOCK.
    FOR EACH Rem_detalle OF Rem_header EXCLUSIVE-LOCK, EACH Articulo OF Rem_detalle NO-LOCK:
    
        IF TRUE /*Articulo.hay_partida*/ /* Todos los articulos tienen partidas, sean reales o ficticias */
        THEN DO:
    
             FIND Articulo-deposito 
                  WHERE Articulo-deposito.nro_articulo = Articulo.nro_articulo
                    AND Articulo-deposito.nro_deposito = Deposito.nro_deposito 
                    AND Articulo-deposito.cdg_empresa  = Rem_header.cdg_empresa 
                        EXCLUSIVE-LOCK NO-ERROR.
    
             IF NOT AVAILABLE Articulo-deposito
             THEN DO:
                  CREATE Articulo-deposito.
                  ASSIGN Articulo-deposito.nro_articulo = Articulo.nro_articulo
                         Articulo-deposito.nro_deposito = Deposito.nro_deposito 
                         Articulo-deposito.cdg_empresa  = Rem_header.cdg_empresa .
             END.
             
             FIND Partida OF Rem_detalle EXCLUSIVE-LOCK.
    
             IF NOT AVAILABLE Partida
             THEN DO:
                  BELL.
                  MESSAGE "El articulo " Articulo.cdg_articulo Articulo.descripcion " tiene "
                          "habilitadas las partidas pero no tiene ninguna ingresada. Nro.:"
                          STRING(Rem_detalle.nro_partida)
                          VIEW-AS ALERT-BOX ERROR
                  TITLE "Error de consistencia en la definicion del articulo".
             END.
    
             FIND Partida-deposito  
                  WHERE Partida-deposito.nro_deposito = Deposito.nro_deposito 
                    AND Partida-deposito.nro_articulo = Rem_detalle.nro_articulo
                    AND Partida-deposito.nro_partida  = Rem_detalle.nro_partida
                    AND Partida-deposito.cdg_empresa  = Rem_header.cdg_empresa
                        EXCLUSIVE-LOCK NO-ERROR.
    
             IF NOT AVAILABLE Partida-deposito
             THEN DO:
                  CREATE Partida-deposito.
                  ASSIGN Partida-deposito.nro_deposito = Deposito.nro_deposito
                         Partida-deposito.nro_articulo = Rem_detalle.nro_articulo
                         Partida-deposito.nro_partida  = Rem_detalle.nro_partida
                         Partida-deposito.cdg_empresa  = Rem_header.cdg_empresa.
             END.
    
             ASSIGN 
                  Articulo-deposito.remanente_cantidad = Articulo-deposito.remanente_cantidad - Rem_detalle.cantidad.
                  Articulo-deposito.remanente_granel   = Articulo-deposito.remanente_granel - Rem_detalle.granel.
                  Partida.remanente_cantidad           = Partida.remanente_cantidad - Rem_detalle.cantidad.
                  Partida.remanente_granel             = Partida.remanente_granel - Rem_detalle.granel.
                  Partida-deposito.remanente_cantidad  = Partida-deposito.remanente_cantidad - Rem_detalle.cantidad.
                  Partida-deposito.remanente_granel    = Partida-deposito.remanente_granel - Rem_detalle.granel.
        END.
    
        CREATE Cct_stock.
        ASSIGN
                 Cct_stock.nro_deposito   = Deposito.nro_deposito
                 Cct_stock.tipo_mov       = ( IF Rem_header.tip_comprob = "RM" THEN "E" ELSE "I" )
                 Cct_stock.tip_comprob    = Rem_header.tip_comprob
                 Cct_stock.prf_comprob    = Rem_header.prf_comprob
                 Cct_stock.nro_comprob    = Rem_header.nro_comprob
                 Cct_stock.fecha          = Rem_header.fecha
                 Cct_stock.nro_linea      = Rem_detalle.nro_linea
                 Cct_stock.cantidad       = Rem_detalle.cantidad
                 Cct_stock.granel         = Rem_detalle.granel
                 Cct_stock.nro_articulo   = Rem_detalle.nro_articulo
                 Cct_stock.nro_partida    = Rem_detalle.nro_partida
                 Cct_stock.nro_entidad    = Rem_header.nro_cliente
                 Cct_stock.cdg_empresa    = Rem_header.cdg_empresa.
    
    END.
END.
