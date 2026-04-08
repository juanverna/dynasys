/*=================================================================================*/
/*                    EMISION DE COMPROBANTES DE DESPACHO                          */
/*=================================================================================*/
DEFINE TEMP-TABLE T-Rem_header               NO-UNDO LIKE Rem_header.
DEFINE TEMP-TABLE T-Rem_detalle              NO-UNDO LIKE Rem_detalle.
DEFINE TEMP-TABLE T-Registrable-remito       NO-UNDO LIKE Registrable-remito.
DEFINE TEMP-TABLE T-Rem_header-bon           NO-UNDO LIKE Rem_header-bon.
DEFINE TEMP-TABLE T-Rem_detalle-bon          NO-UNDO LIKE Rem_detalle-bon.
DEFINE TEMP-TABLE T-Remito-pedido            NO-UNDO LIKE Remito-pedido.
DEFINE TEMP-TABLE T-Sub_header_inv           NO-UNDO LIKE Sub_header_inv.
DEFINE TEMP-TABLE T-Sub_detalle_inv          NO-UNDO LIKE Sub_detalle_inv.
                                                                                                   
/*=================================================================================*/
/*                        DEFINICION DE PARAMETROS                                 */
/*=================================================================================*/
DEFINE INPUT PARAMETER P-Btn-Tipo_remito AS CHARACTER.
DEFINE INPUT PARAMETER TABLE FOR T-Rem_header.
DEFINE INPUT PARAMETER TABLE FOR T-Rem_detalle.
DEFINE INPUT PARAMETER TABLE FOR T-Registrable-remito.
DEFINE INPUT PARAMETER TABLE FOR T-Rem_header-bon.
DEFINE INPUT PARAMETER TABLE FOR T-Rem_detalle-bon.
DEFINE INPUT PARAMETER TABLE FOR T-Remito-pedido.
DEFINE INPUT PARAMETER TABLE FOR T-Sub_header_inv.
DEFINE INPUT PARAMETER TABLE FOR T-Sub_detalle_inv.

/*=================================================================================*/
/*                          VARIABLES Y BUFFERS                                    */
/*=================================================================================*/

DEFINE NEW SHARED VARIABLE act_cctstk AS ROWID.

/* {VRSHARED.I} */

{VPERSINM.I}
    
DEFINE VARIABLE rid_remito          AS ROWID.

DEFINE VARIABLE saldo_remito        AS DECIMAL.
DEFINE VARIABLE aux_nro_vencimiento AS INTEGER.
DEFINE VARIABLE j                   AS INTEGER.
DEFINE VARIABLE ncopias             AS INTEGER.

DEFINE VARIABLE v-prox_docum        LIKE Parametro.cdg_parametro.

DEFINE VARIABLE modo_emision        AS INTEGER INITIAL 0.
DEFINE VARIABLE indep               AS INTEGER INITIAL 0.
DEFINE VARIABLE rem_y_fac           AS INTEGER INITIAL 1.
DEFINE VARIABLE Rem_y_rem           AS INTEGER INITIAL 2.
DEFINE VARIABLE lado_a_lado         AS INTEGER INITIAL 3.

DEFINE VARIABLE que_rutina          AS CHARACTER.
DEFINE BUFFER B-Rem_detalle FOR Rem_detalle.

/*=================================================================================*/
/*                               BLOQUE PRINCIPAL                                  */
/*=================================================================================*/

/* DO TRANSACTION: */

/*---------------------------------------------------------------------------------*/
/*                       ASIGNAMOS EL NUMERO DE COMPROBANTE                        */
/*---------------------------------------------------------------------------------*/
 
    FIND FIRST T-Rem_header EXCLUSIVE-LOCK.

    FIND Tipocomprobante OF T-Rem_header NO-LOCK NO-ERROR.

   
    FIND Condicion_impos OF T-Rem_header NO-LOCK.

   

    IF Tipocomprobante.autonumerado 
    THEN DO:
        
        v-prox_docum = Tipocomprobante.prefijo_contador + STRING(T-Rem_header.prf_comprob,"9999").
        T-Rem_header.tip_comprob =  Tipocomprobante.tip_comprob.    
        IF Tipocomprobante.usa_letra
        THEN DO:
            v-prox_docum = REPLACE(v-prox_docum,"*",Condicion_impos.tipo_factura).
            T-Rem_header.tip_comprob = REPLACE(T-Rem_header.tip_comprob,"*",Condicion_impos.tipo_factura).
        END.

   
             IF P-Btn-Tipo_remito = "A"  THEN DO:
                 FIND Parametro WHERE Parametro.cdg_parametro = v-prox_docum 
                                  AND Parametro.cdg_empresa   = T-Rem_header.cdg_empresa 
                                      EXCLUSIVE-LOCK NO-ERROR.          
                    IF NOT AVAILABLE Parametro 
                        THEN DO:
                         CREATE Parametro.
                         ASSIGN Parametro.cdg_empresa   = T-Rem_header.cdg_empresa
                                Parametro.cdg_parametro = v-prox_docum
                                Parametro.descripcion   = "Contador autoagregado por " + PROGRAM-NAME(1)
                                Parametro.observacion   = ""
                                Parametro.tipo          = "N"
                                Parametro.valor_n       = 1.
                        END.         
                
               ASSIGN
               T-Rem_header.nro_comprob = Parametro.valor_n
               Parametro.valor_n        = Parametro.valor_n + 1.
           
           END. 
    END.
       

   

   
/*---------------------------------------------------------------------------------*/
/*                       GENERA EL ASIENTO CONTABLE DE LOS REMITOS                 */
/*---------------------------------------------------------------------------------*/

    RUN calcular_compdespacho.p ( INPUT-OUTPUT TABLE T-Rem_header,
                                  INPUT-OUTPUT TABLE T-Rem_detalle,
                                  INPUT-OUTPUT TABLE T-Sub_header_inv,
                                  INPUT-OUTPUT TABLE T-Sub_detalle_inv).
    
/*---------------------------------------------------------------------------------*/
/*                     BAJAMOS LAS TABLAS TEMPORALES                               */
/*---------------------------------------------------------------------------------*/
    
    FIND FIRST T-Rem_header.

    CREATE Rem_header.
    BUFFER-COPY T-Rem_header TO Rem_header
        ASSIGN  Rem_header.nro_remito = NEXT-VALUE(proxima_transaccion).

    FOR EACH T-Rem_detalle:
       CREATE Rem_detalle.
       BUFFER-COPY T-Rem_detalle TO Rem_detalle
           ASSIGN  Rem_detalle.nro_remito = Rem_header.nro_remito.
    END.
    
    FOR EACH T-Registrable-remito:
       CREATE Registrable-remito.
       BUFFER-COPY T-Registrable-remito TO Registrable-remito
           ASSIGN  Registrable-remito.nro_remito = Rem_header.nro_remito.
    END.

    FOR EACH T-Rem_header-bon:
       CREATE Rem_header-bon.
       BUFFER-COPY T-Rem_header-bon TO Rem_header-bon
           ASSIGN  Rem_header-bon.nro_remito = Rem_header.nro_remito.
    END.

    FOR EACH T-Rem_detalle-bon:
       CREATE Rem_detalle-bon.
       BUFFER-COPY T-Rem_detalle-bon TO Rem_detalle-bon
           ASSIGN  Rem_detalle-bon.nro_remito = Rem_header.nro_remito.
    END.

    FOR EACH T-Remito-pedido:
       CREATE Remito-pedido.
       BUFFER-COPY T-Remito-pedido TO Remito-pedido
           ASSIGN  Remito-pedido.nro_remito = Rem_header.nro_remito.
    END.

    FOR EACH T-Sub_header_inv:
       CREATE Sub_header_inv.
       BUFFER-COPY T-Sub_header_inv TO Sub_header_inv.
    END.
    
    FOR EACH T-Sub_detalle_inv:
       CREATE Sub_detalle_inv.
       BUFFER-COPY T-Sub_detalle_inv TO Sub_detalle_inv.
    END.
        
/*---------------------------------------------------------------------------------*/
/*                 TRAEMOS TABLAS RELACIONADAS QUE HARAN FALTA                     */
/*---------------------------------------------------------------------------------*/
    
    FIND Cliente OF Rem_header NO-LOCK.
    FIND Domicilio OF Rem_header NO-LOCK NO-ERROR.
    IF AVAILABLE Domicilio
        THEN ASSIGN Rem_header.cdg_provincia = Domicilio.cdg_provincia
                    Rem_header.cuit          = Cliente.cuit
                    Rem_header.direccion     = Domicilio.direccion
                    Rem_header.localidad     = Domicilio.localidad
                    Rem_header.nombre        = Cliente.nom_cliente
                    Rem_header.nro_entidad   = Cliente.nro_entidad.
    
    FIND Deposito OF Rem_header NO-LOCK.
    FIND Condicion_impos OF Rem_header NO-LOCK.
    FIND Imputacion OF Rem_header NO-LOCK.
    
    FIND Deposito OF Rem_header NO-LOCK.
    FIND Vendedor OF Rem_header NO-LOCK.
    FIND Obra WHERE Obra.cdg_obra = Vendedor.cdg_vendedor NO-LOCK NO-ERROR.
    
/*---------------------------------------------------------------------------------*/
/*                                      STOCK                                      */
/*---------------------------------------------------------------------------------*/
    
    FOR EACH Rem_detalle OF Rem_header EXCLUSIVE-LOCK, EACH Articulo OF Rem_detalle NO-LOCK:
        IF AVAILABLE Obra THEN
        Rem_detalle.nro_obra = Obra.nro_obra.
    
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
             
             FIND Partida OF Rem_detalle EXCLUSIVE-LOCK NO-ERROR.

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
    
             IF Tipocomprobante.debita
             THEN DO:
                 ASSIGN Articulo-deposito.remanente_cantidad = Articulo-deposito.remanente_cantidad - Rem_detalle.cantidad
                        Articulo-deposito.remanente_granel   = Articulo-deposito.remanente_granel - Rem_detalle.granel
                        Partida.remanente_cantidad           = Partida.remanente_cantidad - Rem_detalle.cantidad
                        Partida.remanente_granel             = Partida.remanente_granel - Rem_detalle.granel
                        Partida-deposito.remanente_cantidad  = Partida-deposito.remanente_cantidad - Rem_detalle.cantidad
                        Partida-deposito.remanente_granel    = Partida-deposito.remanente_granel - Rem_detalle.granel.
             END.
             ELSE DO:
                 ASSIGN Articulo-deposito.remanente_cantidad = Articulo-deposito.remanente_cantidad + Rem_detalle.cantidad
                        Articulo-deposito.remanente_granel   = Articulo-deposito.remanente_granel + Rem_detalle.granel
                        Partida.remanente_cantidad           = Partida.remanente_cantidad + Rem_detalle.cantidad
                        Partida.remanente_granel             = Partida.remanente_granel + Rem_detalle.granel
                        Partida-deposito.remanente_cantidad  = Partida-deposito.remanente_cantidad + Rem_detalle.cantidad
                        Partida-deposito.remanente_granel    = Partida-deposito.remanente_granel + Rem_detalle.granel.
             END.
        END.
    
        CREATE Cct_stock.
        ASSIGN
                 Cct_stock.nro_deposito   = Deposito.nro_deposito
                 Cct_stock.tipo_mov       = ( IF Tipocomprobante.debita THEN "E" ELSE "I" )
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
       
       act_cctstk = ROWID(Cct_stock).
       RUN ACUMSTCK.P ("A").
       

       
       IF Rem_header.sin_cargo
       THEN DO:
    
           FIND Acum_ventas
                WHERE Acum_ventas.nro_cliente  = Rem_header.nro_cliente
                  AND Acum_ventas.fecha        = DATE(MONTH(Rem_header.fecha),1,YEAR(Rem_header.fecha))
                  AND Acum_ventas.nro_articulo = Articulo.nro_articulo
                  AND Acum_ventas.cdg_empresa  = Rem_header.cdg_empresa
                  EXCLUSIVE-LOCK NO-ERROR.
    
           IF NOT AVAILABLE Acum_ventas
           THEN DO:
              CREATE Acum_ventas.
              ASSIGN Acum_ventas.nro_cliente  = Rem_header.nro_cliente
                     Acum_ventas.fecha        = DATE(MONTH(Rem_header.fecha),1,YEAR(Rem_header.fecha))
                     Acum_ventas.nro_articulo = Articulo.nro_articulo
                     Acum_ventas.cdg_empresa  = Rem_header.cdg_empresa.
           END.
           
           IF Tipocomprobante.debita
           THEN DO:
              ASSIGN
                 Acum_ventas.cantidad_sc = Acum_ventas.cantidad_sc + Rem_detalle.cantidad
                 Acum_ventas.granel_sc   = Acum_ventas.granel_sc   + Rem_detalle.granel.
           END.      
           ELSE DO:
              ASSIGN
                 Acum_ventas.cantidad_sc = Acum_ventas.cantidad_sc - Rem_detalle.cantidad
                 Acum_ventas.granel_sc   = Acum_ventas.granel_sc   - Rem_detalle.granel.
           END.      
         
           Rem_header.proc_estad   = YES.
    
       END.

       FOR EACH Remito-pedido WHERE Remito-pedido.nro_remito     = Rem_detalle.nro_remito
                                AND Remito-pedido.nro_linea-rem  = Rem_detalle.nro_linea NO-LOCK:
          
           FIND Ped_detalle WHERE Ped_detalle.nro_pedido = Remito-pedido.nro_pedido
                              AND Ped_detalle.nro_linea  = Remito-pedido.nro_linea-ped EXCLUSIVE-LOCK.
                                         
           IF Tipocomprobante.debita
           THEN DO:
               ASSIGN Ped_detalle.cantidad_cum = Ped_detalle.cantidad_cum + Remito-pedido.cantidad
                      Ped_detalle.granel_cum   = Ped_detalle.granel_cum   + Remito-pedido.granel.
           END.
           ELSE DO:
               ASSIGN Ped_detalle.cantidad_cum = Ped_detalle.cantidad_cum - Remito-pedido.cantidad
                      Ped_detalle.granel_cum   = Ped_detalle.granel_cum   - Remito-pedido.granel.
           END.

           ASSIGN Ped_detalle.cantidad_ult = IF Ped_detalle.cantidad_cum < Ped_detalle.cantidad 
                                                THEN Ped_detalle.cantidad - Ped_detalle.cantidad_cum
                                                ELSE 0
                  Ped_detalle.granel_ult   = IF Ped_detalle.granel_cum < Ped_detalle.granel
                                                THEN Ped_detalle.granel - Ped_detalle.granel_cum
                                                ELSE 0.
           
              IF Ped_detalle.cantidad_cum >= Ped_detalle.cantidad  AND
              Ped_detalle.granel_cum >= Ped_detalle.granel
              THEN ASSIGN
                        Ped_detalle.cdg_estado  = "CC"
                        Ped_detalle.cumplido    = YES.
       
           FIND Ped_header OF Ped_detalle EXCLUSIVE-LOCK.
           IF NOT CAN-FIND(FIRST Ped_detalle OF Ped_header 
                                 WHERE LOOKUP(Ped_detalle.cdg_estado, "AN/CC/IR/RE", "/") = 0 )
              THEN Ped_header.cdg_estado = "CC". 
    
       END.
    
    END.
    
    rid_remito = ROWID(Rem_header).
    
    IF P-Btn-Tipo_remito = "A"  THEN 
    RELEASE Parametro.        
    
    RELEASE Rem_header.
    RELEASE Rem_detalle.
    RELEASE Ped_header.
    RELEASE Ped_detalle.
    RELEASE Cct_stock.

 /* Finaliza la transaccion de emision */

   
   

/*=================================================================================*/
/*                           IMPRESION DEL COMPROBANTE                             */
/*=================================================================================*/

 {imprimir_remito_bdu.i "Rem_header"}.

/*=================================================================================*/
/*                                  PROCEDIMIENTOS                                 */
/*=================================================================================*/
