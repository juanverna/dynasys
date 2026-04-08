/*=================================================================================*/
/*                    EMISION DE COMPROBANTES DE DESPACHO                          */
/*=================================================================================*/
DEFINE TEMP-TABLE T-Transdep_hd               NO-UNDO LIKE Transdep_hd.
DEFINE TEMP-TABLE T-Transdep_dt              NO-UNDO LIKE Transdep_dt.
DEFINE TEMP-TABLE T-Registrable-Transdep           NO-UNDO LIKE Registrable-Transdep.
/* DEFINE TEMP-TABLE T-Transdep_hd-bon           NO-UNDO LIKE Transdep_hd-bon. */
/* DEFINE TEMP-TABLE T-Transdep_dt-bon          NO-UNDO LIKE Transdep_dt-bon. */
DEFINE TEMP-TABLE T-Remito-pedido                NO-UNDO LIKE Remito-pedido.
DEFINE TEMP-TABLE T-Sub_header_inv               NO-UNDO LIKE Sub_header_inv.
DEFINE TEMP-TABLE T-Sub_detalle_inv              NO-UNDO LIKE Sub_detalle_inv.
                                                                                                   
/*=================================================================================*/
/*                        DEFINICION DE PARAMETROS                                 */
/*=================================================================================*/

DEFINE INPUT PARAMETER P-Btn-Tipo_remito AS CHARACTER.
DEFINE INPUT PARAMETER TABLE FOR T-Transdep_hd.
DEFINE INPUT PARAMETER TABLE FOR T-Transdep_dt.
DEFINE INPUT PARAMETER TABLE FOR T-Registrable-Transdep.
/* DEFINE INPUT PARAMETER TABLE FOR T-Transdep_hd-bon.  */
/* DEFINE INPUT PARAMETER TABLE FOR T-Transdep_dt-bon. */
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
DEFINE BUFFER B-Transdep_dt FOR Transdep_dt.

/*=================================================================================*/
/*                               BLOQUE PRINCIPAL                                  */
/*=================================================================================*/

/* DO TRANSACTION: */

/*---------------------------------------------------------------------------------*/
/*                       ASIGNAMOS EL NUMERO DE COMPROBANTE                        */
/*---------------------------------------------------------------------------------*/
    FIND FIRST T-Transdep_hd EXCLUSIVE-LOCK.

    FIND Tipocomprobante OF T-Transdep_hd NO-LOCK.
/*     FIND Condicion_impos OF T-Transdep_hd NO-LOCK. */

    IF Tipocomprobante.autonumerado
    THEN DO:
        v-prox_docum = Tipocomprobante.prefijo_contador + STRING(T-Transdep_hd.prf_comprob,"9999").

        T-Transdep_hd.tip_comprob =  Tipocomprobante.tip_comprob.    
/*         IF Tipocomprobante.usa_letra                                                                          */
/*                                                                                                               */
/*         THEN DO:                                                                                              */
/*             v-prox_docum = REPLACE(v-prox_docum,"*",Condicion_impos.tipo_factura).                            */
/*             T-Transdep_hd.tip_comprob = REPLACE(T-Transdep_hd.tip_comprob,"*",Condicion_impos.tipo_factura).  */
/*         END.                                                                                                  */
        
        IF P-Btn-Tipo_remito = "A"  THEN DO:

        FIND Parametro WHERE Parametro.cdg_parametro = v-prox_docum 
                         AND Parametro.cdg_empresa   = T-Transdep_hd.cdg_empresa 
                             EXCLUSIVE-LOCK NO-ERROR.
        
        IF NOT AVAILABLE Parametro
        THEN DO:
             CREATE Parametro.
             ASSIGN Parametro.cdg_empresa   = T-Transdep_hd.cdg_empresa
                    Parametro.cdg_parametro = v-prox_docum
                    Parametro.descripcion   = "Contador autoagregado por " + PROGRAM-NAME(1)
                    Parametro.observacion   = ""
                    Parametro.tipo          = "N"
                    Parametro.valor_n       = 1.
        END.         
      
        ASSIGN
           T-Transdep_hd.nro_comprob = Parametro.valor_n
           Parametro.valor_n        = Parametro.valor_n + 1.
        END.
    END.
/*---------------------------------------------------------------------------------*/
/*                       GENERA EL ASIENTO CONTABLE DE LOS REMITOS                 */
/*---------------------------------------------------------------------------------*/
/*     RUN calcular_compdespacho.p ( INPUT-OUTPUT TABLE T-Transdep_hd,   */
/*                                   INPUT-OUTPUT TABLE T-Transdep_dt,  */
/*                                   INPUT-OUTPUT TABLE T-Sub_header_inv,   */
/*                                   INPUT-OUTPUT TABLE T-Sub_detalle_inv). */
/*                                                                          */
/*---------------------------------------------------------------------------------*/
/*                     BAJAMOS LAS TABLAS TEMPORALES                               */
/*---------------------------------------------------------------------------------*/
    FIND FIRST T-Transdep_hd.

    CREATE Transdep_hd.

    BUFFER-COPY T-Transdep_hd TO Transdep_hd
        ASSIGN  Transdep_hd.nro_transdep = NEXT-VALUE(proxima_transaccion).

    FOR EACH T-Transdep_dt:
       CREATE Transdep_dt.
       BUFFER-COPY T-Transdep_dt TO Transdep_dt
           ASSIGN  Transdep_dt.nro_transdep = Transdep_hd.nro_transdep.
    END.
    

    FOR EACH T-Registrable-Transdep:
       CREATE Registrable-Transdep.
       BUFFER-COPY T-Registrable-Transdep TO Registrable-Transdep
           ASSIGN  Registrable-Transdep.nro_Transdep = Transdep_hd.nro_transdep.
    END.

/*     FOR EACH T-Transdep_hd-bon:                                            */
/*        CREATE Transdep_hd-bon.                                             */
/*        BUFFER-COPY T-Transdep_hd-bon TO Transdep_hd-bon                 */
/*            ASSIGN  Transdep_hd-bon.nro_remito = Transdep_hd.nro_remito. */
/*     END.                                                                      */

/*     FOR EACH T-Transdep_dt-bon:                                            */
/*        CREATE Transdep_dt-bon.                                             */
/*        BUFFER-COPY T-Transdep_dt-bon TO Transdep_dt-bon                */
/*            ASSIGN  Transdep_dt-bon.nro_remito = Transdep_hd.nro_remito. */
/*     END.                                                                       */
    FOR EACH T-Remito-pedido:
       CREATE Remito-pedido.
       BUFFER-COPY T-Remito-pedido TO Remito-pedido
           ASSIGN  Remito-pedido.nro_remito = Transdep_hd.nro_transdep.
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
/*         FIND Deposito OF Transdep_hd NO-LOCK NO-ERROR.  */
/*         IF AVAILABLE  Deposito THEN                                      */
/*          ASSIGN Transdep_hd.cdg_provincia = Deposito.cdg_provincia       */
/*                     Transdep_hd.cuit          = deposito.cuit            */
/*                     Transdep_hd.direccion     = Domicilio_prv.direccion  */
/*                     Transdep_hd.localidad     = Domicilio_prv.localidad  */
/*                     Transdep_hd.nombre        = Proveedor.nombre         */
/*                     Transdep_hd.nro_entidad   = Proveedor.nro_entidad.   */
    
    FIND Deposito OF Transdep_hd NO-LOCK.
/*     FIND Condicion_impos OF Transdep_hd NO-LOCK.  */
/*     FIND Imputacion OF Transdep_hd NO-LOCK.       */
/*                                                   */
/*     FIND Deposito OF Transdep_hd NO-LOCK.         */
/*     FIND Vendedor OF Transdep_hd NO-LOCK.                       */
/*     FIND Obra WHERE Obra.cdg_obra = Vendedor.cdg_vendedor NO-LOCK. */
    
/*---------------------------------------------------------------------------------*/
/*                                      STOCK                                      */
/*---------------------------------------------------------------------------------*/

    FOR EACH Transdep_dt OF Transdep_hd EXCLUSIVE-LOCK, EACH Articulo OF Transdep_dt NO-LOCK:
    
/*         Transdep_dt.nro_obra = Obra.nro_obra. */
/*                                                   */
        IF TRUE /*Articulo.hay_partida*/ /* Todos los articulos tienen partidas, sean reales o ficticias */
        THEN DO:
    
             FIND Articulo-deposito 
                  WHERE Articulo-deposito.nro_articulo = Articulo.nro_articulo
                    AND Articulo-deposito.nro_deposito = Deposito.nro_deposito 
                    AND Articulo-deposito.cdg_empresa  = Transdep_hd.cdg_empresa 
                        EXCLUSIVE-LOCK NO-ERROR.
    
             IF NOT AVAILABLE Articulo-deposito
             THEN DO:
                  CREATE Articulo-deposito.
                  ASSIGN Articulo-deposito.nro_articulo = Articulo.nro_articulo
                         Articulo-deposito.nro_deposito = Deposito.nro_deposito 
                         Articulo-deposito.cdg_empresa  = Transdep_hd.cdg_empresa .
             END.        
             
             FIND Partida OF Transdep_dt EXCLUSIVE-LOCK NO-ERROR.

             IF NOT AVAILABLE Partida
             THEN DO:
                  BELL.
                  MESSAGE "El articulo " Articulo.cdg_articulo Articulo.descripcion " tiene "
                          "habilitadas las partidas pero no tiene ninguna ingresada. Nro.:"
                          STRING(Transdep_dt.nro_partida)
                          VIEW-AS ALERT-BOX ERROR
                  TITLE "Error de consistencia en la definicion del articulo".
             END.
    
             FIND Partida-deposito  
                  WHERE Partida-deposito.nro_deposito = Deposito.nro_deposito 
                    AND Partida-deposito.nro_articulo = Transdep_dt.nro_articulo
                    AND Partida-deposito.nro_partida  = Transdep_dt.nro_partida
                    AND Partida-deposito.cdg_empresa  = Transdep_hd.cdg_empresa
                        EXCLUSIVE-LOCK NO-ERROR.
    
             IF NOT AVAILABLE Partida-deposito
             THEN DO:
                  CREATE Partida-deposito.
                  ASSIGN Partida-deposito.nro_deposito = Deposito.nro_deposito
                         Partida-deposito.nro_articulo = Transdep_dt.nro_articulo
                         Partida-deposito.nro_partida  = Transdep_dt.nro_partida
                         Partida-deposito.cdg_empresa  = Transdep_hd.cdg_empresa.
             END.
    
             IF Tipocomprobante.debita
             THEN DO:
                 ASSIGN Articulo-deposito.remanente_cantidad = Articulo-deposito.remanente_cantidad - Transdep_dt.cantidad
                        Articulo-deposito.remanente_granel   = Articulo-deposito.remanente_granel - Transdep_dt.granel
                        Partida.remanente_cantidad           = Partida.remanente_cantidad - Transdep_dt.cantidad
                        Partida.remanente_granel             = Partida.remanente_granel - Transdep_dt.granel
                        Partida-deposito.remanente_cantidad  = Partida-deposito.remanente_cantidad - Transdep_dt.cantidad
                        Partida-deposito.remanente_granel    = Partida-deposito.remanente_granel - Transdep_dt.granel.
             END.
             ELSE DO:
                 ASSIGN Articulo-deposito.remanente_cantidad = Articulo-deposito.remanente_cantidad + Transdep_dt.cantidad
                        Articulo-deposito.remanente_granel   = Articulo-deposito.remanente_granel + Transdep_dt.granel
                        Partida.remanente_cantidad           = Partida.remanente_cantidad + Transdep_dt.cantidad
                        Partida.remanente_granel             = Partida.remanente_granel + Transdep_dt.granel
                        Partida-deposito.remanente_cantidad  = Partida-deposito.remanente_cantidad + Transdep_dt.cantidad
                        Partida-deposito.remanente_granel    = Partida-deposito.remanente_granel + Transdep_dt.granel.
             END.
        END.
    
        CREATE Cct_stock.
        ASSIGN
                 Cct_stock.nro_deposito   = Deposito.nro_deposito
                 Cct_stock.tipo_mov       = ( IF Tipocomprobante.debita THEN "E" ELSE "I" )
                 Cct_stock.tip_comprob    = Transdep_hd.tip_comprob
                 Cct_stock.prf_comprob    = Transdep_hd.prf_comprob
                 Cct_stock.nro_comprob    = Transdep_hd.nro_comprob
                 Cct_stock.fecha          = Transdep_hd.fecha
                 Cct_stock.nro_linea      = Transdep_dt.nro_linea
                 Cct_stock.cantidad       = Transdep_dt.cantidad
                 Cct_stock.granel         = Transdep_dt.granel
                 Cct_stock.nro_articulo   = Transdep_dt.nro_articulo
                 Cct_stock.nro_partida    = Transdep_dt.nro_partida
                 Cct_stock.nro_entidad    = Transdep_hd.nro_deposito
                 Cct_stock.cdg_empresa    = Transdep_hd.cdg_empresa.
       
       act_cctstk = ROWID(Cct_stock).
       RUN ACUMSTCK.P ("A").
       
       
/*        IF Transdep_hd.sin_cargo  */
/*        THEN DO:                  */
/*                                                                                                           */
/*            FIND Acum_ventas                                                                               */
/*                 WHERE Acum_ventas.nro_cliente  = Transdep_hd.nro_proveedor                                */
/*                   AND Acum_ventas.fecha        = DATE(MONTH(Transdep_hd.fecha),1,YEAR(Transdep_hd.fecha)) */
/*                   AND Acum_ventas.nro_articulo = Articulo.nro_articulo                                    */
/*                   AND Acum_ventas.cdg_empresa  = Transdep_hd.cdg_empresa                                  */
/*                   EXCLUSIVE-LOCK NO-ERROR.                                                                */
/*                                                                                                           */
/*            IF NOT AVAILABLE Acum_ventas                                                                   */
/*            THEN DO:                                                                                       */
/*               CREATE Acum_ventas.                                                                         */
/*               ASSIGN Acum_ventas.nro_cliente  = Transdep_hd.nro_proveedor                                 */
/*                      Acum_ventas.fecha        = DATE(MONTH(Transdep_hd.fecha),1,YEAR(Transdep_hd.fecha))  */
/*                      Acum_ventas.nro_articulo = Articulo.nro_articulo                                     */
/*                      Acum_ventas.cdg_empresa  = Transdep_hd.cdg_empresa.                                  */
/*            END.  */
/*                                                                                                           */
/*            IF Tipocomprobante.debita                                                       */
/*            THEN DO:                                                                        */
/*               ASSIGN                                                                       */
/*                  Acum_ventas.cantidad_sc = Acum_ventas.cantidad_sc + Transdep_dt.cantidad  */
/*                  Acum_ventas.granel_sc   = Acum_ventas.granel_sc   + Transdep_dt.granel.   */
/*            END.                                                                            */
/*            ELSE DO:                                                                        */
/*               ASSIGN                                                                       */
/*                  Acum_ventas.cantidad_sc = Acum_ventas.cantidad_sc - Transdep_dt.cantidad  */
/*                  Acum_ventas.granel_sc   = Acum_ventas.granel_sc   - Transdep_dt.granel.   */
/*            END.                                                                            */
/*                                                                                            */
           Transdep_hd.proc_estad   = YES.
    
       END.
          
       FOR EACH Remito-pedido WHERE Remito-pedido.nro_remito     = Transdep_dt.nro_transdep                                AND Remito-pedido.nro_linea-rem  = Transdep_dt.nro_linea NO-LOCK:
          
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
    
    
    
    rid_remito = ROWID(Transdep_hd).
    IF P-Btn-Tipo_remito = "A"  THEN
    RELEASE Parametro.        
    RELEASE Transdep_hd.
    RELEASE Transdep_dt.
    RELEASE Ped_header.
    RELEASE Ped_detalle.
    RELEASE Cct_stock.

 /* Finaliza la transaccion de emision */

/*=================================================================================*/
/*                           IMPRESION DEL COMPROBANTE                             */
/*=================================================================================*/
/*   RUN prprv122.p (INPUT ROWID(Transdep_hd)).  */
    
 {imprimir_remito_tra.i "Transdep_hd"}.

/*=================================================================================*/
/*                                  PROCEDIMIENTOS                                 */
/*=================================================================================*/
