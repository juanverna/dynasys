/*=================================================================================*/
/*                         EMISION DE LOS VALES DE INVENTARIO                      */
/*=================================================================================*/

/*=================================================================================*/
/*                              TABLAS TEMPORALES                                  */
/*=================================================================================*/

DEFINE TEMP-TABLE T-Valeinv_hd          NO-UNDO LIKE Valeinv_hd.       
DEFINE TEMP-TABLE T-Valeinv_dt          NO-UNDO LIKE Valeinv_dt.
DEFINE TEMP-TABLE T-Registrable_vale    NO-UNDO LIKE Registrable_vale.
DEFINE TEMP-TABLE T-Sub_header_inv      NO-UNDO LIKE Sub_header_inv.
DEFINE TEMP-TABLE T-Sub_detalle_inv     NO-UNDO LIKE Sub_detalle_inv.

/*=================================================================================*/
/*                                  PARAMETROS                                     */
/*=================================================================================*/

DEFINE INPUT PARAMETER TABLE FOR T-Valeinv_hd.       
DEFINE INPUT PARAMETER TABLE FOR T-Valeinv_dt.       
DEFINE INPUT PARAMETER TABLE FOR T-Registrable_vale. 
DEFINE INPUT PARAMETER TABLE FOR T-Sub_header_inv.   
DEFINE INPUT PARAMETER TABLE FOR T-Sub_detalle_inv.

/*=================================================================================*/
/*                           VARIABLES                                             */
/*=================================================================================*/

/*{VRSHARED.I}
{VPERSINM.I}*/

DEFINE VARIABLE v-prox_docum        AS CHARACTER.

DEFINE VARIABLE que_rutina          AS CHARACTER.
DEFINE BUFFER B-Valeinv_dt          FOR Valeinv_dt.

/*=================================================================================*/
/*                     ARRANCA LA TRANSACCION DE ACTUALIZACION                     */
/*=================================================================================*/

DO ON ERROR UNDO, LEAVE: /* ARRANCAMOS AQUI LA TRANSACCION */

    FIND FIRST T-Valeinv_hd EXCLUSIVE-LOCK.
    FIND Tipocomprobante OF T-Valeinv_hd NO-LOCK.
    

    IF Tipocomprobante.autonumerado
    THEN DO:

        v-prox_docum = Tipocomprobante.prefijo_contador + STRING(T-Valeinv_hd.prf_comprob,"9999").
        T-Valeinv_hd.tip_comprob =  Tipocomprobante.tip_comprob.    

        FIND Parametro WHERE Parametro.cdg_parametro = v-prox_docum 
                         AND Parametro.cdg_empresa   = T-Valeinv_hd.cdg_empresa 
                             EXCLUSIVE-LOCK NO-ERROR.
          
        IF NOT AVAILABLE Parametro
        THEN DO:
             CREATE Parametro.
             ASSIGN Parametro.cdg_empresa   = T-Valeinv_hd.cdg_empresa
                    Parametro.cdg_parametro = v-prox_docum
                    Parametro.descripcion   = "Contador autoagregado por " + PROGRAM-NAME(1)
                    Parametro.observacion   = ""
                    Parametro.tipo          = "N"
                    Parametro.valor_n       = 1.
        END.         
        
        ASSIGN
           T-Valeinv_hd.nro_comprob = Parametro.valor_n
           Parametro.valor_n        = Parametro.valor_n + 1.

    END.


/*---------------------------------------------------------------------------------*/
/*                      RECALCULO DEL COMPROBANTE                                  */
/*---------------------------------------------------------------------------------*/

    RUN calcular_vale_inventario.p ( INPUT-OUTPUT TABLE T-Valeinv_hd,
                                     INPUT-OUTPUT TABLE T-Valeinv_dt,
                                     INPUT-OUTPUT TABLE T-Sub_header_inv,
                                     INPUT-OUTPUT TABLE T-Sub_detalle_inv).

/*---------------------------------------------------------------------------------*/
/*           BAJAMOS LAS TABLAS TEMPORALES A LA BASE DE DATOS                      */
/*---------------------------------------------------------------------------------*/

    FIND FIRST T-Valeinv_hd.

    RUN completar_auditoria.p ( OUTPUT T-Valeinv_hd.nro_usuario,
                                OUTPUT T-Valeinv_hd.fecha_grab, 
                                OUTPUT T-Valeinv_hd.hora_grab,  
                                OUTPUT T-Valeinv_hd.pc_name).    

    CREATE Valeinv_hd.
    BUFFER-COPY T-Valeinv_hd TO Valeinv_hd
        ASSIGN  Valeinv_hd.nro_valeinv = NEXT-VALUE(proxima_transaccion).
    
    FOR EACH T-Valeinv_dt:
       CREATE Valeinv_dt.
       BUFFER-COPY T-Valeinv_dt TO Valeinv_dt
           ASSIGN  Valeinv_dt.nro_valeinv = Valeinv_hd.nro_valeinv.
    END.

/*---------------------------------------------------------------------------------*/
/*                     GENERA IMPUTACION CONTABLE DEL COMPROBANTE                  */
/*---------------------------------------------------------------------------------*/

    FOR EACH T-Sub_header_inv WHERE T-Sub_header_inv.nro_comprob <> 0:

        CREATE Sub_header_inv.
        BUFFER-COPY T-Sub_header_inv TO Sub_header_inv.
        
        FOR EACH T-Sub_detalle_inv OF T-Sub_header_inv:
           CREATE Sub_detalle_inv.
           BUFFER-COPY T-Sub_detalle_inv TO Sub_detalle_inv.
        END.

    END.

/*---------------------------------------------------------------------------------*/
/*                                      STOCK                                      */
/*---------------------------------------------------------------------------------*/

    FOR EACH Valeinv_dt OF Valeinv_hd EXCLUSIVE-LOCK, EACH Articulo OF Valeinv_dt NO-LOCK:

        FIND Articulo-deposito 
              WHERE Articulo-deposito.nro_articulo = Valeinv_dt.nro_articulo
                AND Articulo-deposito.nro_deposito = Valeinv_dt.nro_deposito 
                AND Articulo-deposito.cdg_empresa  = Valeinv_hd.cdg_empresa 
                    EXCLUSIVE-LOCK NO-ERROR.

        IF NOT AVAILABLE Articulo-deposito
        THEN DO:
            CREATE Articulo-deposito.
            ASSIGN Articulo-deposito.nro_deposito = Valeinv_dt.nro_deposito
                   Articulo-deposito.nro_articulo = Valeinv_dt.nro_articulo
                   Articulo-deposito.cdg_empresa  = Valeinv_hd.cdg_empresa.
         
        END.

        FIND Partida-deposito
              WHERE Partida-deposito.nro_deposito = Valeinv_dt.nro_deposito
                AND Partida-deposito.nro_articulo = Valeinv_dt.nro_articulo
                AND Partida-deposito.nro_partida  = Valeinv_dt.nro_partida
                AND Partida-deposito.cdg_empresa  = Valeinv_hd.cdg_empresa
                    EXCLUSIVE-LOCK NO-ERROR.

        IF NOT AVAILABLE Partida-deposito
        THEN DO:
            CREATE Partida-deposito.
            ASSIGN Partida-deposito.nro_deposito = Valeinv_dt.nro_deposito
                   Partida-deposito.nro_articulo = Valeinv_dt.nro_articulo
                   Partida-deposito.nro_partida  = Valeinv_dt.nro_partida
                   Partida-deposito.cdg_empresa  = Valeinv_hd.cdg_empresa.
        END.

        FIND Partida OF Valeinv_dt EXCLUSIVE-LOCK.

        IF Tipocomprobante.debita 
        THEN DO:
            ASSIGN Articulo-deposito.remanente_cantidad = Articulo-deposito.remanente_cantidad + Valeinv_dt.cantidad.
                   Articulo-deposito.remanente_granel   = Articulo-deposito.remanente_granel + Valeinv_dt.granel.
                   Partida.remanente_cantidad           = Partida.remanente_cantidad + Valeinv_dt.cantidad.
                   Partida.remanente_granel             = Partida.remanente_granel + Valeinv_dt.granel.
                   Partida-deposito.remanente_cantidad  = Partida-deposito.remanente_cantidad + Valeinv_dt.cantidad.
                   Partida-deposito.remanente_granel    = Partida-deposito.remanente_granel + Valeinv_dt.granel.
        END.
        ELSE DO:
            ASSIGN Articulo-deposito.remanente_cantidad = Articulo-deposito.remanente_cantidad - Valeinv_dt.cantidad.
                   Articulo-deposito.remanente_granel   = Articulo-deposito.remanente_granel - Valeinv_dt.granel.
                   Partida.remanente_cantidad           = Partida.remanente_cantidad - Valeinv_dt.cantidad.
                   Partida.remanente_granel             = Partida.remanente_granel - Valeinv_dt.granel.
                   Partida-deposito.remanente_cantidad  = Partida-deposito.remanente_cantidad - Valeinv_dt.cantidad.
                   Partida-deposito.remanente_granel    = Partida-deposito.remanente_granel - Valeinv_dt.granel.
        END.
    

        CREATE Cct_stock.
        ASSIGN Cct_stock.cdg_empresa    = Valeinv_hd.cdg_empresa
               Cct_stock.nro_deposito   = Valeinv_dt.nro_deposito
               Cct_stock.tipo_mov       = IF Tipocomprobante.debita  THEN "I" ELSE "E"
               Cct_stock.tip_comprob    = Valeinv_hd.tip_comprob
               Cct_stock.nro_comprob    = Valeinv_hd.nro_comprob
               Cct_stock.fecha          = Valeinv_hd.fecha
               Cct_stock.nro_linea      = Valeinv_dt.nro_linea
               Cct_stock.cantidad       = Valeinv_dt.cantidad
               Cct_stock.granel         = Valeinv_dt.granel
               Cct_stock.nro_articulo   = Valeinv_dt.nro_articulo
               Cct_stock.nro_partida    = Valeinv_dt.nro_partida
               Cct_stock.nro_entidad    = Valeinv_dt.nro_entidad
               Cct_stock.observacion    = Valeinv_dt.observacion.
        
        RUN acumular_movimiento_stock.p ( INPUT ROWID(Cct_stock), INPUT "A").

    END.


/*=================================================================================*/
/*                     FINALIZA LA TRANSACCION DE ACTUALIZACION                    */
/*=================================================================================*/

END.  /* FIN DE LA TRANSACCION */

/*=================================================================================*/
/*                           IMPRESION DEL COMPROBANTE                             */
/*=================================================================================*/

RUN imprimir_vale_inventario.p ( INPUT ROWID(Valeinv_hd) ).

/*=================================================================================*/
/*                                  PROCEDIMIENTOS                                 */
/*=================================================================================*/

