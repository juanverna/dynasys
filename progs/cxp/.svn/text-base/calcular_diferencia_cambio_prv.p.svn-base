/*===============================================================================================*/
/*             REALIZA EL CALCULO DE LOC COMPROBANTES DE DIFERENCIA DE CAMBIO                    */
/*===============================================================================================*/

/*===============================================================================================*/
/*                           DEFINICION DE LAS TABLAS TEMPORALES                                 */
/*===============================================================================================*/

   DEFINE TEMP-TABLE T-Fac_header_prv               NO-UNDO LIKE Fac_header_prv.
   DEFINE TEMP-TABLE T-Fac_detalle_prv              NO-UNDO LIKE Fac_detalle_prv.
   DEFINE TEMP-TABLE T-Sub_header_prv               NO-UNDO LIKE Sub_header_prv.
   DEFINE TEMP-TABLE T-Sub_detalle_prv              NO-UNDO LIKE Sub_detalle_prv.
   DEFINE TEMP-TABLE T-Fac_header_prv_impuesto      NO-UNDO LIKE Fac_header_prv_impuesto.
   DEFINE TEMP-TABLE T-Fac_detalle_prv_impuesto     NO-UNDO LIKE Fac_detalle_prv_impuesto.
                                                                                                       
/*===============================================================================================*/
/*                               DEFINICION DE PARAMETROS                                        */
/*===============================================================================================*/
    
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Fac_header_prv.
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Fac_detalle_prv.
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Sub_header_prv.
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Sub_detalle_prv.
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Fac_header_prv_impuesto.
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Fac_detalle_prv_impuesto.

/*===============================================================================================*/
/*                               DEFINICION DE VARIABLES                                         */
/*===============================================================================================*/

   DEFINE VARIABLE x-tasa             AS DECIMAL DECIMALS 4.
   DEFINE VARIABLE x-importe          AS DECIMAL.
   DEFINE VARIABLE x-monto_imponible  AS DECIMAL.
   DEFINE VARIABLE tasa_iva           AS DECIMAL.
   DEFINE VARIABLE hubo_iva           AS LOGICAL.
   DEFINE VARIABLE v-debug            AS LOGICAL.
   DEFINE VARIABLE v-saldo_renglon    AS DECIMAL.
   DEFINE VARIABLE v-aux_importe      AS DECIMAL.

   DEFINE BUFFER B-Impuesto FOR Impuesto.

/*===============================================================================================*/
/*                                       PROCESO                                                 */
/*===============================================================================================*/

EMPTY TEMP-TABLE T-Sub_header_prv       NO-ERROR.
EMPTY TEMP-TABLE T-Sub_detalle_prv      NO-ERROR.
EMPTY TEMP-TABLE T-Fac_header_prv_impuesto  NO-ERROR.
EMPTY TEMP-TABLE T-Fac_detalle_prv_impuesto NO-ERROR.

FOR EACH T-Fac_header_prv EXCLUSIVE-LOCK:

   FIND Tipocomprobante OF T-Fac_header_prv NO-LOCK.
   /*
   FIND Obra OF T-Fac_header_prv NO-LOCK.
   */
   FIND Proveedor OF T-Fac_header_prv NO-LOCK.
   FIND Familia_proveedor OF Proveedor NO-LOCK.

/*----------------------------------------------------------------------------------------------*/
/*                        Crear registro de encabezado de subdiario                             */
/*----------------------------------------------------------------------------------------------*/
              
   CREATE T-Sub_header_prv.
   BUFFER-COPY T-Fac_header_prv TO T-Sub_header_prv
        ASSIGN T-Sub_header_prv.nro_cuenta      = Familia_proveedor.nro_cuenta
            /* T-Sub_header_prv.nro_obra        = Obra.nro_obra */ .

/*----------------------------------------------------------------------------------------------*/
/*    Borramos los importes de las bonificaciones y las tablas temporales de los impuestos      */
/*----------------------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------------------*/
/* Recorre el detalle de facturas. El subtotal GENERAL es el que surge del PRECIO * CANTIDAD.   */
/* Descontadas las bonificaciones POR ARTICULO se obtiene el subtotal BRUTO. En base a  el, se  */
/* descuentas prorrateadas las bonificaciones GENERALES y se halla el subtotal NETO. Los brutos */
/* y netos que terminan en "cf" son los calculos para consumidor final                          */
/*----------------------------------------------------------------------------------------------*/

   T-Fac_header_prv.imp_iva  = 0.

   FOR EACH T-Fac_detalle_prv OF T-Fac_header_prv EXCLUSIVE-LOCK, Articulo NO-LOCK OF T-Fac_detalle_prv, 
            Familia_articulo NO-LOCK OF Articulo, Familia_impositiva OF Articulo NO-LOCK:
      
       RUN calcular_subtotales_detalle. 
       IF Tipocomprobante.aplica_impuestos
          THEN RUN aplicar_impuestos. 

       IF Articulo.sumaneto = 1
       THEN DO:
           IF CAN-FIND(FIRST Entidad_distribucion 
                              WHERE Entidad_distribucion.cdg_empresa = T-Fac_header_prv.cdg_empresa
                                AND Entidad_distribucion.nro_entidad = T-Fac_detalle_prv.nro_entidad)
               THEN RUN crear_imputacion_distribuida.
               ELSE RUN crear_imputacion_directa.            
       END.

   END. /* De recorrer el detalle */             

/*----------------------------------------------------------------------------------------------*/
/*          Halla el total neto y bruto de la factura para calcular impuestos generales         */
/*----------------------------------------------------------------------------------------------*/
        
   T-Fac_header_prv.imp_neto  = 0.
   T-Fac_header_prv.imp_bruto = 0.
   T-Fac_header_prv.imp_descuentos = 0.

   FOR EACH T-Fac_detalle_prv OF T-Fac_header_prv NO-LOCK, Articulo OF T-Fac_detalle_prv NO-LOCK:

       IF Articulo.sumaneto = 1
       THEN DO:
           T-Fac_header_prv.imp_neto  = T-Fac_header_prv.imp_neto  + T-Fac_detalle_prv.subtotal_neto.
           T-Fac_header_prv.imp_bruto = T-Fac_header_prv.imp_bruto + T-Fac_detalle_prv.subtotal_bruto.
           IF Tipocomprobante.aplica_bonificaciones
              THEN T-Fac_header_prv.imp_descuentos = T-Fac_header_prv.imp_descuentos + T-Fac_detalle_prv.subtotal_bruto -
                                                 T-Fac_detalle_prv.subtotal_neto.
       END.
   END.

/*----------------------------------------------------------------------------------------------*/
/*                      Acumula los impuestos de detalle en la cabecera                         */
/*----------------------------------------------------------------------------------------------*/

   IF Tipocomprobante.aplica_impuestos
   THEN DO:

       FOR EACH T-Fac_detalle_prv_impuesto OF T-Fac_header_prv: 
           
           FIND FIRST T-Fac_header_prv_impuesto OF T-Fac_header_prv
                      WHERE T-Fac_header_prv_impuesto.cdg_impuesto = T-Fac_detalle_prv_impuesto.cdg_impuesto
                        AND T-Fac_header_prv_impuesto.tasa         = T-Fac_detalle_prv_impuesto.tasa
                            EXCLUSIVE-LOCK NO-ERROR.
           IF NOT AVAILABLE T-Fac_header_prv_impuesto
           THEN DO:
                CREATE T-Fac_header_prv_impuesto.
                ASSIGN T-Fac_header_prv_impuesto.nro_facprov  = T-Fac_detalle_prv_impuesto.nro_facprov
                       T-Fac_header_prv_impuesto.cdg_impuesto = T-Fac_detalle_prv_impuesto.cdg_impuesto
                       T-Fac_header_prv_impuesto.tasa         = T-Fac_detalle_prv_impuesto.tasa.
           END.
           T-Fac_header_prv_impuesto.importe  = T-Fac_header_prv_impuesto.importe  + T-Fac_detalle_prv_impuesto.importe.
           T-Fac_header_prv_impuesto.monto_imponible = T-Fac_header_prv_impuesto.monto_imponible  + T-Fac_detalle_prv_impuesto.monto_imponible.

       END.
       
       T-Fac_header_prv.imp_iva = 0.
       T-Fac_header_prv.imp_total = T-Fac_header_prv.imp_neto.
       FOR EACH T-Fac_header_prv_impuesto OF T-Fac_header_prv, Impuesto OF T-Fac_header_prv_impuesto:
           
           FIND FIRST Impuesto_condicion 
               WHERE Impuesto_condicion.cdg_impuesto = T-Fac_header_prv_impuesto.cdg_impuesto 
                 AND Impuesto_condicion.cdg_condiva = T-Fac_header_prv.cdg_condiva
                     NO-LOCK.
           
           IF ROUND(T-Fac_header_prv_impuesto.monto_imponible * T-Fac_header_prv.cambio,2) >= Impuesto_condicion.valor_minimo AND
              ROUND(T-Fac_header_prv_impuesto.importe * T-Fac_header_prv.cambio,2) >= Impuesto_condicion.imp_minimo
           THEN DO:

               T-Fac_header_prv.imp_total = T-Fac_header_prv.imp_total + T-Fac_header_prv_impuesto.importe.
               IF Impuesto.es_iva
                  THEN T-Fac_header_prv.imp_iva = T-Fac_header_prv.imp_iva + T-Fac_header_prv_impuesto.importe.

               FIND  T-Sub_detalle_prv 
                    WHERE T-Sub_detalle_prv.cdg_empresa    = T-Fac_header_prv.cdg_empresa
                      AND T-Sub_detalle_prv.tip_comprob    = T-Fac_header_prv.tip_comprob
                      AND T-Sub_detalle_prv.prf_comprob    = T-Fac_header_prv.prf_comprob
                      AND T-Sub_detalle_prv.nro_comprob    = T-Fac_header_prv.nro_comprob
                      AND T-Sub_detalle_prv.nro_cuenta     = Impuesto.nro_cuenta
                      AND T-Sub_detalle_prv.tipo           = 2
                           EXCLUSIVE-LOCK NO-ERROR.

               IF NOT AVAILABLE T-Sub_detalle_prv 
               THEN DO:
                    CREATE T-Sub_detalle_prv.
                    ASSIGN T-Sub_detalle_prv.cdg_empresa    = T-Fac_header_prv.cdg_empresa
                           T-Sub_detalle_prv.tip_comprob    = T-Fac_header_prv.tip_comprob
                           T-Sub_detalle_prv.prf_comprob    = T-Fac_header_prv.prf_comprob
                           T-Sub_detalle_prv.nro_comprob    = T-Fac_header_prv.nro_comprob
                           T-Sub_detalle_prv.nro_cuenta     = Impuesto.nro_cuenta
                           T-Sub_detalle_prv.tipo           = 2.
               END.

               T-Sub_detalle_prv.valor = T-Sub_detalle_prv.valor  + T-Fac_header_prv_impuesto.importe.

           END.
           ELSE DO:

               FOR EACH T-Fac_detalle_prv_impuesto OF T-Fac_header_prv
                        WHERE T-Fac_detalle_prv_impuesto.cdg_impuesto = T-Fac_header_prv_impuesto.cdg_impuesto:
                   DELETE T-Fac_detalle_prv_impuesto.
               END.

               DELETE T-Fac_header_prv_impuesto.

           END.
       
       END.
   
   END.
   ELSE DO:
       T-Fac_header_prv.imp_total = T-Fac_header_prv.imp_neto.
   END.

/*----------------------------------------------------------------------------------------------*/
/*                      Acumula las bonificaciones de la cabecera                               */
/*----------------------------------------------------------------------------------------------*/

   
   ASSIGN T-Sub_header_prv.imp_total   = T-Fac_header_prv.imp_total.

END. /* De los encabezados de comprobantes */


/*===============================================================================================*/
/*                                PROCEDIMIENTOS                                                 */
/*===============================================================================================*/

PROCEDURE calcular_subtotales_detalle:
    
          /* --------------------------------------------------- */
          /*     Halla el total bruto del renglón de factura     */
          /* --------------------------------------------------- */

    IF Articulo.extendida
    THEN DO:
       T-Fac_detalle_prv.subtotal_general = 
           ( IF T-Fac_detalle_prv.cantidad <> 0 
                THEN ROUND( T-Fac_detalle_prv.precio * T-Fac_detalle_prv.cantidad , 2 )
                ELSE T-Fac_detalle_prv.precio ).
    END.
    ELSE DO:
       T-Fac_detalle_prv.subtotal_general = 
           ( IF T-Fac_detalle_prv.a_granel 
                THEN ROUND( T-Fac_detalle_prv.precio * T-Fac_detalle_prv.granel   , 2 )
                ELSE ROUND( T-Fac_detalle_prv.precio * T-Fac_detalle_prv.cantidad , 2 ) ).
    
    END.            
    
    T-Fac_detalle_prv.subtotal_bruto = T-Fac_detalle_prv.subtotal_general.
    T-Fac_detalle_prv.subtotal_neto       = T-Fac_detalle_prv.subtotal_bruto.

END PROCEDURE.

PROCEDURE aplicar_impuestos:

    FIND Familia_impositiva OF Articulo NO-LOCK.

    FOR EACH Impuesto_condicion OF  Familia_impositiva 
       WHERE Impuesto_condicion.cdg_condiva = T-Fac_header_prv.cdg_condiva
         AND Impuesto_condicion.cdg_empresa = T-Fac_header_prv.cdg_empresa 
         AND Impuesto_condicion.fch_desde <= T-Fac_header_prv.fecha_iva
         AND Impuesto_condicion.fch_hasta >= T-Fac_header_prv.fecha_iva
         AND CAN-DO(Impuesto_condicion.lista_provincias,T-Fac_header_prv.cdg_provincia)
         NO-LOCK, Impuesto OF Impuesto_condicion NO-LOCK:
              
          FIND FIRST  Proveedor_excencion OF Proveedor 
                      WHERE Proveedor_excencion.cdg_empresa  = T-Fac_header_prv.cdg_empresa
                        AND Proveedor_excencion.cdg_impuesto = Impuesto_condicion.cdg_impuesto
                        AND Proveedor_excencion.fch_desde <= T-Fac_header_prv.fecha_iva
                        AND Proveedor_excencion.fch_hasta >= T-Fac_header_prv.fecha_iva NO-LOCK NO-ERROR.
      /*
                         MESSAGE "Condiva:" T-Fac_header_prv.cdg_condiva  SKIP
                                 "Empresa:" T-Fac_header_prv.cdg_empresa  SKIP
                                 "Fecha IVA:" T-Fac_header_prv.fecha_iva  SKIP
                                 "Impuesto:" Impuesto_condicion.cdg_impuesto SKIP
                                 "Hay Excencion:" AVAILABLE Proveedor_excencion SKIP
                                 "Habilitado:" Impuesto_condicion.lista_provincias SKIP
                                 "Provincia:" T-Fac_header_prv.cdg_provincia
                                  VIEW-AS ALERT-BOX MESSAGE.
      */

          IF NOT AVAILABLE Proveedor_excencion
             THEN x-tasa = Impuesto_condicion.tasa.
             ELSE x-tasa = Impuesto_condicion.tasa * ( 1 - Proveedor_excencion.prc_excencion  / 100.0 ).
          
          x-monto_imponible = T-Fac_detalle_prv.subtotal_neto.
          IF Impuesto_condicion.cdg_impuesto = 10
          THEN DO:
              FOR EACH T-Fac_detalle_prv_impuesto OF T-Fac_detalle_prv, FIRST B-Impuesto OF T-Fac_detalle_prv_impuesto WHERE B-Impuesto.es_iva:
                  x-monto_imponible = x-monto_imponible + T-Fac_detalle_prv_impuesto.importe.
              END.
          END.
          x-importe = x-monto_imponible * x-tasa / 100.0.

          IF x-importe <> 0
          THEN DO:
              CREATE T-Fac_detalle_prv_impuesto.
              ASSIGN T-Fac_detalle_prv_impuesto.nro_facprov     = T-Fac_detalle_prv.nro_facprov
                     T-Fac_detalle_prv_impuesto.nro_linea       = T-Fac_detalle_prv.nro_linea
                     T-Fac_detalle_prv_impuesto.cdg_impuesto    = Impuesto_condicion.cdg_impuesto
                     T-Fac_detalle_prv_impuesto.tasa            = x-tasa
                     T-Fac_detalle_prv_impuesto.monto_imponible = x-monto_imponible
                     T-Fac_detalle_prv_impuesto.importe         = x-importe.
    
          END.
    
    END.
    
END PROCEDURE.

PROCEDURE crear_imputacion_directa:
          
    FIND FIRST Familia_cuenta OF Familia_articulo 
         WHERE Familia_cuenta.cdg_imputacion = T-Fac_header_prv.cdg_imputacion 
               NO-LOCK.
           
    FIND  T-Sub_detalle_prv 
         WHERE T-Sub_detalle_prv.cdg_empresa   = T-Fac_header_prv.cdg_empresa
           AND T-Sub_detalle_prv.tip_comprob   = T-Fac_header_prv.tip_comprob
           AND T-Sub_detalle_prv.prf_comprob   = T-Fac_header_prv.prf_comprob
           AND T-Sub_detalle_prv.nro_comprob   = T-Fac_header_prv.nro_comprob
           AND T-Sub_detalle_prv.nro_cuenta    = Familia_cuenta.nro_cuenta
           AND T-Sub_detalle_prv.nro_entidad   = T-Fac_header_prv.nro_entidad
           AND T-Sub_detalle_prv.nro_obra      = T-Fac_detalle_prv.nro_obra
         EXCLUSIVE-LOCK NO-ERROR.

    IF NOT AVAILABLE T-Sub_detalle_prv 
    THEN DO:
       CREATE T-Sub_detalle_prv.
       ASSIGN T-Sub_detalle_prv.cdg_empresa    = T-Fac_header_prv.cdg_empresa
              T-Sub_detalle_prv.tip_comprob    = T-Fac_header_prv.tip_comprob
              T-Sub_detalle_prv.prf_comprob    = T-Fac_header_prv.prf_comprob
              T-Sub_detalle_prv.nro_comprob    = T-Fac_header_prv.nro_comprob
              T-Sub_detalle_prv.nro_cuenta     = Familia_cuenta.nro_cuenta
              T-Sub_detalle_prv.nro_entidad    = T-Fac_header_prv.nro_entidad
              T-Sub_detalle_prv.nro_obra       = T-Fac_detalle_prv.nro_obra
              T-Sub_detalle_prv.tipo           = 1.
    END.

    T-Sub_detalle_prv.valor = T-Sub_detalle_prv.valor + T-Fac_detalle_prv.subtotal_neto.

END PROCEDURE.

PROCEDURE crear_imputacion_distribuida:

    FIND FIRST Familia_cuenta OF Familia_articulo 
         WHERE Familia_cuenta.cdg_imputacion = T-Fac_header_prv.cdg_imputacion 
               NO-LOCK.

    v-saldo_renglon = T-Fac_detalle_prv.subtotal_neto.
    FOR EACH Entidad_distribucion 
        WHERE Entidad_distribucion.cdg_empresa = T-Fac_header_prv.cdg_empresa
          AND Entidad_distribucion.nro_entidad = T-Fac_detalle_prv.nro_entidad
              BREAK BY Entidad_distribucion.nro_entidad:

        FIND T-Sub_detalle_prv 
             WHERE T-Sub_detalle_prv.cdg_empresa    = T-Fac_header_prv.cdg_empresa
               AND T-Sub_detalle_prv.tip_comprob    = T-Fac_header_prv.tip_comprob
               AND T-Sub_detalle_prv.prf_comprob    = T-Fac_header_prv.prf_comprob
               AND T-Sub_detalle_prv.nro_comprob    = T-Fac_header_prv.nro_comprob
               AND T-Sub_detalle_prv.nro_cuenta     = Familia_cuenta.nro_cuenta
               AND T-Sub_detalle_prv.nro_entidad    = Entidad_distribucion.nro_entidad-dis
               AND T-Sub_detalle_prv.nro_obra       = T-Fac_detalle_prv.nro_obra
             EXCLUSIVE-LOCK NO-ERROR.

        IF NOT AVAILABLE T-Sub_detalle_prv 
        THEN DO:
           CREATE T-Sub_detalle_prv.
           ASSIGN T-Sub_detalle_prv.cdg_empresa    = T-Fac_header_prv.cdg_empresa
                  T-Sub_detalle_prv.tip_comprob    = T-Fac_header_prv.tip_comprob
                  T-Sub_detalle_prv.prf_comprob    = T-Fac_header_prv.prf_comprob
                  T-Sub_detalle_prv.nro_comprob    = T-Fac_header_prv.nro_comprob
                  T-Sub_detalle_prv.nro_cuenta     = Familia_cuenta.nro_cuenta
                  T-Sub_detalle_prv.nro_entidad    = Entidad_distribucion.nro_entidad-dis
                  T-Sub_detalle_prv.nro_obra       = T-Fac_detalle_prv.nro_obra
                  T-Sub_detalle_prv.tipo           = 1.
        END.

        IF LAST-OF(Entidad_distribucion.nro_entidad)
           THEN v-aux_importe = v-saldo_renglon.
           ELSE v-aux_importe = ROUND(T-Fac_detalle_prv.subtotal_neto * Entidad_distribucion.porcentaje / 100.0 ,2).

        T-Sub_detalle_prv.valor = T-Sub_detalle_prv.valor + v-aux_importe.
        v-saldo_renglon = v-saldo_renglon - v-aux_importe.
    END.

END PROCEDURE.
