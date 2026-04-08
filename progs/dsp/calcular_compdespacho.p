/*===============================================================================================*/
/*                 REALIZA EL CALCULO DE UN COMPROBANTE DE CLIENTE                               */
/*===============================================================================================*/

/*===============================================================================================*/
/*                           DEFINICION DE LAS TABLAS TEMPORALES                                 */
/*===============================================================================================*/

DEFINE TEMP-TABLE T-Rem_header               NO-UNDO LIKE Rem_header.
DEFINE TEMP-TABLE T-Rem_detalle              NO-UNDO LIKE Rem_detalle.
DEFINE TEMP-TABLE T-Sub_header_inv           NO-UNDO LIKE Sub_header_inv.
DEFINE TEMP-TABLE T-Sub_detalle_inv          NO-UNDO LIKE Sub_detalle_inv.
                                                                                                   
/*===============================================================================================*/
/*                               DEFINICION DE PARAMETROS                                        */
/*===============================================================================================*/

DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Rem_header.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Rem_detalle.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Sub_header_inv.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Sub_detalle_inv.

/*===============================================================================================*/
/*                                       VARIABLES                                               */
/*===============================================================================================*/

DEFINE VARIABLE v-cuenta_debita   LIKE Familia_articulo.nro_cuenta_costo.
DEFINE VARIABLE v-cuenta_acredita LIKE Familia_articulo.nro_cuenta_existencia.

/*===============================================================================================*/
/*                                        PROCESO                                                */
/*===============================================================================================*/

FIND FIRST T-Rem_header EXCLUSIVE-LOCK.

FIND Tipocomprobante OF T-Rem_header NO-LOCK.
FIND Deposito OF T-Rem_header NO-LOCK.
/*FIND Obra OF T-Rem_header NO-LOCK.*/
FIND Cliente OF T-Rem_header NO-LOCK.
FIND Familia_cliente OF Cliente NO-LOCK.
              
/*----------------------------------------------------------------------------------------------*/
/*                        Crear registro de encabezado de subdiario                             */
/*----------------------------------------------------------------------------------------------*/

EMPTY TEMP-TABLE T-Sub_header_inv.
EMPTY TEMP-TABLE T-Sub_detalle_inv.

FIND Familia_cliente OF Cliente NO-LOCK.
CREATE T-Sub_header_inv.
ASSIGN T-Sub_header_inv.cdg_empresa     = T-Rem_header.cdg_empresa
       T-Sub_header_inv.tip_comprob     = T-Rem_header.tip_comprob
       T-Sub_header_inv.prf_comprob     = T-Rem_header.prf_comprob
       T-Sub_header_inv.nro_comprob     = T-Rem_header.nro_comprob
       T-Sub_header_inv.fecha           = T-Rem_header.fecha
       T-Sub_header_inv.nro_entidad     = T-Rem_header.nro_entidad
       T-Sub_header_inv.cdg_comprobante = T-Rem_header.cdg_comprobante
       T-Sub_header_inv.nro_cuenta      = Familia_cliente.nro_cuenta.

          /*--------------------------------------------------------------*/
          /* Realiza las imputaciones del remito. Es una salida de mercs. */
          /* se debitan los costos de ventas y acreditan las existencias. */
          /*--------------------------------------------------------------*/

T-Rem_header.imp_total = 0.
FOR EACH T-Rem_detalle EXCLUSIVE-LOCK OF T-Rem_header,
           Articulo OF T-Rem_detalle, Familia_articulo OF Articulo:

    IF Tipocomprobante.debita 
       THEN v-cuenta_debita = Familia_articulo.nro_cuenta_costo.
       ELSE v-cuenta_debita = Familia_articulo.nro_cuenta_existencia.


    FIND  T-Sub_detalle_inv 
         WHERE T-Sub_detalle_inv.cdg_empresa    = T-Rem_header.cdg_empresa
           AND T-Sub_detalle_inv.tip_comprob    = T-Rem_header.tip_comprob
           AND T-Sub_detalle_inv.prf_comprob    = T-Rem_header.prf_comprob
           AND T-Sub_detalle_inv.nro_comprob    = T-Rem_header.nro_comprob
           AND T-Sub_detalle_inv.nro_cuenta     = v-cuenta_debita
           AND T-Sub_detalle_inv.nro_entidad    = T-Rem_header.nro_entidad
           AND T-Sub_detalle_inv.nro_obra       = T-Rem_detalle.nro_obra 
           AND T-Sub_detalle_inv.tipo           = 1
               EXCLUSIVE-LOCK NO-ERROR.

    IF NOT AVAILABLE T-Sub_detalle_inv 
    THEN DO:
       CREATE T-Sub_detalle_inv.
       ASSIGN T-Sub_detalle_inv.cdg_empresa    = T-Rem_header.cdg_empresa
              T-Sub_detalle_inv.tip_comprob    = T-Rem_header.tip_comprob
              T-Sub_detalle_inv.prf_comprob    = T-Rem_header.prf_comprob
              T-Sub_detalle_inv.nro_comprob    = T-Rem_header.nro_comprob
              T-Sub_detalle_inv.nro_cuenta     = v-cuenta_debita
              T-Sub_detalle_inv.nro_entidad    = T-Rem_header.nro_entidad
              /*
              T-Sub_detalle_inv.nro_moneda     = T-Rem_header.nro_moneda 
              */
              T-Sub_detalle_inv.nro_obra       = T-Rem_detalle.nro_obra 
              T-Sub_detalle_inv.tipo           = 1.
    END.

    T-Rem_detalle.subtotal_neto = 
        ( IF T-Rem_detalle.a_granel 
             THEN ROUND( T-Rem_detalle.costo * T-Rem_detalle.granel   , 2 )
             ELSE ROUND( T-Rem_detalle.costo * T-Rem_detalle.cantidad , 2 ) ).

    T-Sub_detalle_inv.valor = T-Sub_detalle_inv.valor + T-Rem_detalle.subtotal_neto.
    T-Rem_header.imp_total  = T-Rem_header.imp_total + T-Rem_detalle.subtotal_neto.

END.             

T-Sub_header_inv.imp_total = T-Rem_header.imp_total.

          /*--------------------------------------------------------------*/
          /* Volvemos a recorrer el detalle de manera de calcular la otra */
          /* porcion del asiento                                          */
          /*--------------------------------------------------------------*/

FOR EACH T-Rem_detalle EXCLUSIVE-LOCK OF T-Rem_header,
           Articulo OF T-Rem_detalle, Familia_articulo OF Articulo:

    IF Tipocomprobante.debita 
       THEN v-cuenta_acredita = Familia_articulo.nro_cuenta_existencia.
       ELSE v-cuenta_acredita = Familia_articulo.nro_cuenta_costo.

    FIND  T-Sub_detalle_inv 
         WHERE T-Sub_detalle_inv.cdg_empresa    = T-Rem_header.cdg_empresa
           AND T-Sub_detalle_inv.tip_comprob    = T-Rem_header.tip_comprob
           AND T-Sub_detalle_inv.prf_comprob    = T-Rem_header.prf_comprob
           AND T-Sub_detalle_inv.nro_comprob    = T-Rem_header.nro_comprob
           AND T-Sub_detalle_inv.nro_cuenta     = v-cuenta_acredita
           AND T-Sub_detalle_inv.nro_entidad    = Deposito.nro_entidad
           /*
           AND T-Sub_detalle_inv.nro_obra       = T-Rem_detalle.nro_obra 
           */
           AND T-Sub_detalle_inv.tipo           = 2
               EXCLUSIVE-LOCK NO-ERROR.
         
    IF NOT AVAILABLE T-Sub_detalle_inv 
    THEN DO:
       CREATE T-Sub_detalle_inv.
       ASSIGN
              T-Sub_detalle_inv.cdg_empresa    = T-Rem_header.cdg_empresa
              T-Sub_detalle_inv.tip_comprob    = T-Rem_header.tip_comprob
              T-Sub_detalle_inv.prf_comprob    = T-Rem_header.prf_comprob
              T-Sub_detalle_inv.nro_comprob    = T-Rem_header.nro_comprob
              T-Sub_detalle_inv.nro_cuenta     = v-cuenta_acredita
              T-Sub_detalle_inv.nro_entidad    = Deposito.nro_entidad
              /*
              T-Sub_detalle_inv.nro_moneda     = T-Rem_header.nro_moneda 
              T-Sub_detalle_inv.nro_obra       = T-Rem_detalle.nro_obra 
              */
              T-Sub_detalle_inv.tipo           = 2.
    END.

    T-Rem_detalle.subtotal_neto = 
        ( IF T-Rem_detalle.a_granel 
             THEN ROUND( T-Rem_detalle.costo * T-Rem_detalle.granel   , 2 )
             ELSE ROUND( T-Rem_detalle.costo * T-Rem_detalle.cantidad , 2 ) ).

    T-Sub_detalle_inv.valor = T-Sub_detalle_inv.valor + T-Rem_detalle.subtotal_neto.

END.             
