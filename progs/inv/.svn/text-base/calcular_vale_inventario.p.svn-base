/*=================================================================================*/
/*                         EMISION DE LOS VALES DE INVENTARIO                      */
/*=================================================================================*/

/*=================================================================================*/
/*                              TABLAS TEMPORALES                                  */
/*=================================================================================*/

DEFINE TEMP-TABLE T-Valeinv_hd          NO-UNDO LIKE Valeinv_hd.       
DEFINE TEMP-TABLE T-Valeinv_dt          NO-UNDO LIKE Valeinv_dt.
DEFINE TEMP-TABLE T-Sub_header_inv      NO-UNDO LIKE Sub_header_inv.
DEFINE TEMP-TABLE T-Sub_detalle_inv     NO-UNDO LIKE Sub_detalle_inv.

/*=================================================================================*/
/*                                  PARAMETROS                                     */
/*=================================================================================*/

DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Valeinv_hd.       
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Valeinv_dt.       
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Sub_header_inv.   
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Sub_detalle_inv.

/*=================================================================================*/
/*                                  VARIABLES                                     */
/*=================================================================================*/

DEFINE VARIABLE v-cdg_existencia AS INTEGER INITIAL 1.
DEFINE VARIABLE v-cdg_consumo    AS INTEGER INITIAL 2.

/*=================================================================================*/
/*                                  PROCESO                                        */
/*=================================================================================*/

FIND FIRST T-Valeinv_hd.
FIND Tipocomprobante OF T-Valeinv_hd NO-LOCK.

/*---------------------------------------------------------------*/
/* Realiza las imputaciones de consumo. Si es un vale de ingreso */
/* se debitan las existencias y se acreditan los consumos        */
/*---------------------------------------------------------------*/

IF Tipocomprobante.debita
    THEN ASSIGN v-cdg_existencia = 1
                v-cdg_consumo    = 2.
    ELSE ASSIGN v-cdg_existencia = 2
                v-cdg_consumo    = 1.


CREATE T-Sub_header_inv.
BUFFER-COPY T-Valeinv_hd TO T-Sub_header_inv.

FOR EACH T-Valeinv_dt EXCLUSIVE-LOCK OF T-Valeinv_hd, Deposito OF T-Valeinv_dt,
           Articulo OF T-Valeinv_dt, Familia_articulo OF Articulo:

    FIND FIRST T-Sub_detalle_inv 
         WHERE T-Sub_detalle_inv.cdg_empresa    = T-Valeinv_hd.cdg_empresa
           AND T-Sub_detalle_inv.tip_comprob    = T-Valeinv_hd.tip_comprob
           AND T-Sub_detalle_inv.prf_comprob    = T-Valeinv_hd.prf_comprob
           AND T-Sub_detalle_inv.nro_comprob    = T-Valeinv_hd.nro_comprob
           AND T-Sub_detalle_inv.nro_cuenta     = Familia_articulo.nro_cuenta_existencia
           AND T-Sub_detalle_inv.nro_entidad    = Deposito.nro_entidad
           AND T-Sub_detalle_inv.nro_obra       = T-Valeinv_dt.nro_obra
           AND T-Sub_detalle_inv.tipo           = v-cdg_existencia
               EXCLUSIVE-LOCK NO-ERROR.

    IF NOT AVAILABLE T-Sub_detalle_inv 
    THEN DO:
       CREATE T-Sub_detalle_inv.
       ASSIGN T-Sub_detalle_inv.cdg_empresa    = T-Valeinv_hd.cdg_empresa
              T-Sub_detalle_inv.tip_comprob    = T-Valeinv_hd.tip_comprob
              T-Sub_detalle_inv.prf_comprob    = T-Valeinv_hd.prf_comprob
              T-Sub_detalle_inv.nro_comprob    = T-Valeinv_hd.nro_comprob
              T-Sub_detalle_inv.nro_cuenta     = Familia_articulo.nro_cuenta_existencia
              T-Sub_detalle_inv.nro_entidad    = Deposito.nro_entidad
              T-Sub_detalle_inv.nro_obra       = T-Valeinv_dt.nro_obra
              T-Sub_detalle_inv.tipo           = v-cdg_existencia.
    END.

    T-Valeinv_dt.subtotal = 
        ( IF T-Valeinv_dt.a_granel 
             THEN ROUND( T-Valeinv_dt.costo * T-Valeinv_dt.granel   , 2 )
             ELSE ROUND( T-Valeinv_dt.costo * T-Valeinv_dt.cantidad , 2 ) ).

    T-Sub_detalle_inv.valor = T-Sub_detalle_inv.valor + T-Valeinv_dt.subtotal.
    T-Valeinv_hd.imp_total  = T-Valeinv_hd.imp_total + T-Valeinv_dt.subtotal.

END.             

T-Sub_header_inv.imp_total = T-Valeinv_hd.imp_total.

          /*--------------------------------------------------------------*/
          /* Volvemos a recorrer el detalle de manera de calcular la otra */
          /* porcion del asiento                                          */
          /*--------------------------------------------------------------*/

FOR EACH T-Valeinv_dt EXCLUSIVE-LOCK OF T-Valeinv_hd, Deposito OF T-Valeinv_dt,
           Articulo OF T-Valeinv_dt, Familia_articulo OF Articulo:

    FIND FIRST T-Sub_detalle_inv 
         WHERE T-Sub_detalle_inv.cdg_empresa    = T-Valeinv_hd.cdg_empresa
           AND T-Sub_detalle_inv.tip_comprob    = T-Valeinv_hd.tip_comprob
           AND T-Sub_detalle_inv.prf_comprob    = T-Valeinv_hd.prf_comprob
           AND T-Sub_detalle_inv.nro_comprob    = T-Valeinv_hd.nro_comprob
           AND T-Sub_detalle_inv.nro_cuenta     = Familia_articulo.nro_cuenta_consumo 
           AND T-Sub_detalle_inv.nro_entidad    = T-Valeinv_hd.nro_entidad
           AND T-Sub_detalle_inv.nro_obra       = T-Valeinv_dt.nro_obra
           AND T-Sub_detalle_inv.tipo           = v-cdg_consumo
               EXCLUSIVE-LOCK NO-ERROR.

    IF NOT AVAILABLE T-Sub_detalle_inv 
    THEN DO:
       CREATE T-Sub_detalle_inv.
       ASSIGN
              T-Sub_detalle_inv.cdg_empresa    = T-Valeinv_hd.cdg_empresa
              T-Sub_detalle_inv.tip_comprob    = T-Valeinv_hd.tip_comprob
              T-Sub_detalle_inv.prf_comprob    = T-Valeinv_hd.prf_comprob
              T-Sub_detalle_inv.nro_comprob    = T-Valeinv_hd.nro_comprob
              T-Sub_detalle_inv.nro_cuenta     = Familia_articulo.nro_cuenta_consumo
              T-Sub_detalle_inv.nro_entidad    = T-Valeinv_hd.nro_entidad
              T-Sub_detalle_inv.nro_obra       = T-Valeinv_dt.nro_obra
              T-Sub_detalle_inv.tipo           = v-cdg_consumo.
    END.

    T-Valeinv_dt.subtotal = 
        ( IF T-Valeinv_dt.a_granel 
             THEN ROUND( T-Valeinv_dt.costo * T-Valeinv_dt.granel   , 2 )
             ELSE ROUND( T-Valeinv_dt.costo * T-Valeinv_dt.cantidad , 2 ) ).

    T-Sub_detalle_inv.valor = T-Sub_detalle_inv.valor + T-Valeinv_dt.subtotal.

END.             
