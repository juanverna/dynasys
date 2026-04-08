/*=================================================================================*/
/*                    EMISION DE PEDIDOS DE CLIENTES                               */
/*=================================================================================*/

/*=================================================================================*/
/*                                 PARAMETROS                                      */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_pedido     AS ROWID.

/*=================================================================================*/
/*                          VARIABLES Y BUFFERS                                    */
/*=================================================================================*/

{VRSHARED.I}
{dfmodoexist.i}

/*=================================================================================*/
/*                            BLOQUE PRINCIPAL                                     */
/*=================================================================================*/
    
RUN getparametro.p (  INPUT  "HABAUTPD",
                      OUTPUT v-valor_c,
                      OUTPUT v-valor_d,
                      OUTPUT v-valor_l,
                      OUTPUT v-valor_n,
                      OUTPUT v-observacion ).

IF v-valor_l THEN RUN verificar_pedido.
RUN imprimir_pedido.p ( INPUT rid_pedido ).

/*=================================================================================*/
/*                              PROCEDIMIENTOS                                     */
/*=================================================================================*/

PROCEDURE verificar_pedido:

    /*---------------------------------------------------------------------------------*/
    /*                        VERIFICA CREDITO Y RESERVA LOS STOCKS                    */
    /*---------------------------------------------------------------------------------*/
    
    DO TRANSACTION:
    
        FIND Ped_header WHERE ROWID(Ped_header) = rid_pedido EXCLUSIVE-LOCK.
        
        FOR EACH Ped_detalle OF Ped_header:
            Ped_detalle.cdg_estado = Ped_header.cdg_estado.
        END.
    
        Ped_header.version = Ped_header.version + 1.
        
        RUN verificar_credito.p ( INPUT ROWID(Ped_header),
                                  OUTPUT Ped_header.cdg_estado).
        
        IF Ped_header.cdg_estado = "AA" /* No hay problemas de creditos, vemos el stock */
        THEN DO:
  
            FIND Deposito OF Ped_header NO-LOCK.
            FOR EACH Ped_detalle OF Ped_header EXCLUSIVE-LOCK,
                Articulo OF Ped_detalle NO-LOCK:
                /*
                RUN verificar_existencia.
                
                RUN crear_historia ( INPUT Ped_detalle.cdg_estado ) .
                */
            END.
  
        END.
        ELSE DO: /* Marcamos todos los renglones como retenidos por crédito */
  
            FOR EACH Ped_detalle OF Ped_header EXCLUSIVE-LOCK:
            
                FOR EACH Ped_detalle_entr OF Ped_detalle EXCLUSIVE-LOCK:
                    Ped_detalle_entr.cdg_estado = Ped_header.cdg_estado.
                END.          
                /*
                RUN crear_historia ( INPUT Ped_header.cdg_estado ).
                */
              
            END.
        END.
    
    END.

END PROCEDURE.

PROCEDURE verificar_existencia:
    
    DEFINE VARIABLE sal_cantidad   LIKE Cct_stock.cantidad.
    DEFINE VARIABLE sal_granel     LIKE Cct_stock.granel.
    DEFINE VARIABLE pre_cantidad   LIKE Cct_stock.cantidad.
    DEFINE VARIABLE pre_granel     LIKE Cct_stock.granel.

    FIND Partida OF Ped_detalle NO-LOCK.
    RUN calcular_stock.p ( INPUT   ROWID(Articulo),
                           INPUT   ROWID(Deposito),
                           INPUT   ROWID(Partida),
                           INPUT   Ped_detalle.fecha_temprana,
                           INPUT   dep_y_par,
                           OUTPUT  sal_cantidad,
                           OUTPUT  sal_granel,
                           OUTPUT  pre_cantidad,
                           OUTPUT  pre_granel).
                           
    IF pre_cantidad >= Ped_detalle.cantidad
       AND pre_granel >= Ped_detalle.granel
    THEN DO:
         Ped_detalle.cdg_estado = "AA".
         RUN reservar_stock.
    END.                      
    ELSE DO:
         Ped_detalle.cdg_estado = "ST".
    END.                      

    FOR EACH Ped_detalle_entr OF Ped_detalle EXCLUSIVE-LOCK:
        Ped_detalle_entr.cdg_estado = Ped_detalle.cdg_estado.
    END.          

END PROCEDURE.

PROCEDURE reservar_stock:

    FIND Articulo-deposito 
         WHERE Articulo-deposito.nro_articulo = Articulo.nro_articulo
           AND Articulo-deposito.nro_deposito = Deposito.nro_deposito 
           AND Articulo-deposito.cdg_empresa  = Ped_header.cdg_empresa 
               EXCLUSIVE-LOCK NO-ERROR.
 
    IF NOT AVAILABLE Articulo-deposito
    THEN DO:
         CREATE Articulo-deposito.
         ASSIGN Articulo-deposito.nro_articulo = Articulo.nro_articulo
                Articulo-deposito.nro_deposito = Deposito.nro_deposito 
                Articulo-deposito.cdg_empresa  = Ped_header.cdg_empresa.
    END.
    
    FIND Partida OF Ped_detalle EXCLUSIVE-LOCK.
 
    IF NOT AVAILABLE Partida
    THEN DO:
         BELL.
         MESSAGE "El articulo " Articulo.cdg_articulo Articulo.descripcion " tiene "
                 "habilitadas las partidas pero no tiene ninguna ingresada. Nro.:"
                 STRING(Ped_detalle.nro_partida)
                 VIEW-AS ALERT-BOX ERROR
         TITLE "Error de consistencia en la definicion del articulo".
    END.
 
    FIND Partida-deposito  
         WHERE Partida-deposito.nro_deposito = Deposito.nro_deposito 
           AND Partida-deposito.nro_articulo = Ped_detalle.nro_articulo
           AND Partida-deposito.nro_partida  = Ped_detalle.nro_partida
           AND Partida-deposito.cdg_empresa  = Ped_header.cdg_empresa
               EXCLUSIVE-LOCK NO-ERROR.
 
    IF NOT AVAILABLE Partida-deposito
    THEN DO:
         CREATE Partida-deposito.
         ASSIGN Partida-deposito.nro_deposito = Deposito.nro_deposito
                Partida-deposito.nro_articulo = Ped_detalle.nro_articulo
                Partida-deposito.nro_partida  = Ped_detalle.nro_partida
                Partida-deposito.cdg_empresa  = Ped_header.cdg_empresa.
    END.
 
    ASSIGN 
           Articulo-deposito.reservado_cantidad = Articulo-deposito.reservado_cantidad + Ped_detalle.cantidad.
           Articulo-deposito.reservado_granel   = Articulo-deposito.reservado_granel + Ped_detalle.granel.
           Partida.reservado_cantidad           = Partida.reservado_cantidad + Ped_detalle.cantidad.
           Partida.reservado_granel             = Partida.reservado_granel + Ped_detalle.granel.
           Partida-deposito.reservado_cantidad  = Partida-deposito.reservado_cantidad + Ped_detalle.cantidad.
           Partida-deposito.reservado_granel    = Partida-deposito.reservado_granel + Ped_detalle.granel.

    CREATE Cct_stock.
    ASSIGN
             Cct_stock.nro_deposito   = Deposito.nro_deposito
             Cct_stock.tipo_mov       = ( IF Ped_header.tip_comprob = "PD" THEN "E" ELSE "I" )
             Cct_stock.tip_comprob    = Ped_header.tip_comprob
             Cct_stock.prf_comprob    = Ped_header.prf_comprob
             Cct_stock.nro_comprob    = Ped_header.nro_comprob
             Cct_stock.fecha          = Ped_detalle.fecha_temprana
             Cct_stock.nro_linea      = Ped_detalle.nro_linea
             Cct_stock.cantidad       = Ped_detalle.cantidad
             Cct_stock.granel         = Ped_detalle.granel
             Cct_stock.nro_articulo   = Ped_detalle.nro_articulo
             Cct_stock.nro_partida    = Ped_detalle.nro_partida
             Cct_stock.nro_entidad    = Ped_header.nro_cliente
             Cct_stock.cdg_empresa    = Ped_header.cdg_empresa
             Cct_stock.presupuestado  = "R".
      
    
END PROCEDURE.
