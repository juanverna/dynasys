/*===============================================================================================*/
/*                 REALIZA EL CALCULO DE UN COMPROBANTE DE CLIENTE                               */
/*===============================================================================================*/

/*===============================================================================================*/
/*                           DEFINICION DE LAS TABLAS TEMPORALES                                 */
/*===============================================================================================*/

   DEFINE TEMP-TABLE T-Ped_header               NO-UNDO LIKE Ped_header.
   DEFINE TEMP-TABLE T-Ped_detalle              NO-UNDO LIKE Ped_detalle.
   DEFINE TEMP-TABLE T-Sub_header_vta           NO-UNDO LIKE Sub_header_vta.
   DEFINE TEMP-TABLE T-Sub_detalle_vta          NO-UNDO LIKE Sub_detalle_vta.
   DEFINE TEMP-TABLE T-Ped_header-bon           NO-UNDO LIKE Ped_header-bon.
   DEFINE TEMP-TABLE T-Ped_detalle-bon          NO-UNDO LIKE Ped_detalle-bon.
   DEFINE TEMP-TABLE T-Ped_header_impuesto      NO-UNDO LIKE Ped_header_impuesto.
   DEFINE TEMP-TABLE T-Ped_detalle_impuesto     NO-UNDO LIKE Ped_detalle_impuesto.
                                                                                                       
/*===============================================================================================*/
/*                               DEFINICION DE PARAMETROS                                        */
/*===============================================================================================*/
    
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Ped_header.
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Ped_detalle.
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Sub_header_vta.
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Sub_detalle_vta.
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Ped_header-bon.
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Ped_detalle-bon.
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Ped_header_impuesto.
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Ped_detalle_impuesto.

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

   FIND FIRST T-Ped_header EXCLUSIVE-LOCK.
   FIND Punto-venta WHERE Punto-venta.cdg_empresa  = T-Ped_header.cdg_empresa
                      AND Punto-venta.cdg_puntovta = T-Ped_header.prf_comprob
                          NO-LOCK.

   FIND Tipocomprobante OF T-Ped_header NO-LOCK.
   /*FIND Obra OF T-Ped_header NO-LOCK.*/
   FIND Cliente OF T-Ped_header NO-LOCK.
   FIND Familia_cliente OF Cliente NO-LOCK.

/*----------------------------------------------------------------------------------------------*/
/*                        Crear registro de encabezado de subdiario                             */
/*----------------------------------------------------------------------------------------------*/
              
   EMPTY TEMP-TABLE T-Sub_header_vta.
   EMPTY TEMP-TABLE T-Sub_detalle_vta.

   CREATE T-Sub_header_vta.
   BUFFER-COPY T-Ped_header TO T-Sub_header_vta
        ASSIGN T-Sub_header_vta.nro_cuenta      = Familia_cliente.nro_cuenta
             /*T-Sub_header_vta.nro_obra        = Obra.nro_obra*/.

/*----------------------------------------------------------------------------------------------*/
/*    Borramos los importes de las bonificaciones y las tablas temporales de los impuestos      */
/*----------------------------------------------------------------------------------------------*/

   FOR EACH T-Ped_header-bon OF T-Ped_header EXCLUSIVE-LOCK:
       T-Ped_header-bon.importe = 0.
   END.

   EMPTY TEMP-TABLE T-Ped_header_impuesto  NO-ERROR.
   EMPTY TEMP-TABLE T-Ped_detalle_impuesto NO-ERROR.

/*----------------------------------------------------------------------------------------------*/
/* Recorre el detalle de facturas. El subtotal GENERAL es el que surge del PRECIO * CANTIDAD.   */
/* Descontadas las bonificaciones POR ARTICULO se obtiene el subtotal BRUTO. En base a  el, se  */
/* descuentas prorrateadas las bonificaciones GENERALES y se halla el subtotal NETO. Los brutos */
/* y netos que terminan en "cf" son los calculos para consumidor final                          */
/*----------------------------------------------------------------------------------------------*/

   T-Ped_header.imp_iva  = 0.

   FOR EACH T-Ped_detalle OF T-Ped_header EXCLUSIVE-LOCK, Articulo NO-LOCK OF T-Ped_detalle, 
            Familia_articulo NO-LOCK OF Articulo, Familia_impositiva OF Articulo NO-LOCK:

       RUN calcular_subtotales_detalle. 
       IF Tipocomprobante.aplica_impuestos
       THEN DO:
           RUN aplicar_impuestos_destino. 
           IF T-Ped_header.cdg_provincia <> Punto-venta.cdg_provincia 
               AND Cliente.convenio_sino 
               AND CAN-FIND(FIRST Cliente_jurisdiccion OF Cliente WHERE Cliente_jurisdiccion.cdg_provincia = Punto-venta.cdg_provincia )
               THEN RUN aplicar_impuestos_origen.
       END.

       IF Articulo.sumaneto = 1
       THEN DO:
           IF CAN-FIND(FIRST Entidad_distribucion 
                              WHERE Entidad_distribucion.cdg_empresa = T-Ped_header.cdg_empresa
                                AND Entidad_distribucion.nro_entidad = T-Ped_detalle.nro_entidad)
               THEN RUN crear_imputacion_distribuida.
               ELSE RUN crear_imputacion_directa.            
       END.

   END. /* De recorrer el detalle */             

/*----------------------------------------------------------------------------------------------*/
/*          Halla el total neto y bruto de la factura para calcular impuestos generales         */
/*----------------------------------------------------------------------------------------------*/
        
   T-Ped_header.imp_neto  = 0.
   T-Ped_header.imp_bruto = 0.
   T-Ped_header.imp_descuentos = 0.

   FOR EACH T-Ped_detalle OF T-Ped_header NO-LOCK, Articulo OF T-Ped_detalle NO-LOCK:

       IF Articulo.sumaneto = 1
       THEN DO:
           T-Ped_header.imp_neto  = T-Ped_header.imp_neto  + T-Ped_detalle.subtotal_neto.
           T-Ped_header.imp_bruto = T-Ped_header.imp_bruto + T-Ped_detalle.subtotal_bruto.
           IF Tipocomprobante.aplica_bonificaciones
              THEN T-Ped_header.imp_descuentos = T-Ped_header.imp_descuentos + T-Ped_detalle.subtotal_bruto -
                                                 T-Ped_detalle.subtotal_neto.
       END.
   END.

/*----------------------------------------------------------------------------------------------*/
/*                      Acumula los impuestos de detalle en la cabecera                         */
/*----------------------------------------------------------------------------------------------*/

   IF Tipocomprobante.aplica_impuestos
   THEN DO:

       FOR EACH T-Ped_detalle_impuesto OF T-Ped_header: 
           
           FIND FIRST T-Ped_header_impuesto OF T-Ped_header
                      WHERE T-Ped_header_impuesto.cdg_impuesto = T-Ped_detalle_impuesto.cdg_impuesto
                        AND T-Ped_header_impuesto.tasa         = T-Ped_detalle_impuesto.tasa
                            EXCLUSIVE-LOCK NO-ERROR.
           IF NOT AVAILABLE T-Ped_header_impuesto
           THEN DO:
                CREATE T-Ped_header_impuesto.
                ASSIGN T-Ped_header_impuesto.nro_pedido  = T-Ped_detalle_impuesto.nro_pedido
                       T-Ped_header_impuesto.cdg_impuesto = T-Ped_detalle_impuesto.cdg_impuesto
                       T-Ped_header_impuesto.tasa         = T-Ped_detalle_impuesto.tasa.
           END.
           T-Ped_header_impuesto.importe  = T-Ped_header_impuesto.importe  + T-Ped_detalle_impuesto.importe.
           T-Ped_header_impuesto.monto_imponible = T-Ped_header_impuesto.monto_imponible  + T-Ped_detalle_impuesto.monto_imponible.

       END.
       
       T-Ped_header.imp_iva = 0.
       T-Ped_header.imp_total = T-Ped_header.imp_neto.
       FOR EACH T-Ped_header_impuesto OF T-Ped_header, Impuesto OF T-Ped_header_impuesto:
           
           FIND FIRST Impuesto_condicion 
               WHERE Impuesto_condicion.cdg_impuesto = T-Ped_header_impuesto.cdg_impuesto 
                 AND Impuesto_condicion.cdg_condiva = T-Ped_header.cdg_condiva
                     NO-LOCK.
           
           IF ROUND(T-Ped_header_impuesto.monto_imponible * T-Ped_header.cambio,2) >= Impuesto_condicion.valor_minimo AND
              ROUND(T-Ped_header_impuesto.importe * T-Ped_header.cambio,2) >= Impuesto_condicion.imp_minimo
           THEN DO:

               T-Ped_header.imp_total = T-Ped_header.imp_total + T-Ped_header_impuesto.importe.
               IF Impuesto.es_iva
                  THEN T-Ped_header.imp_iva = T-Ped_header.imp_iva + T-Ped_header_impuesto.importe.

               FIND  T-Sub_detalle_vta 
                    WHERE T-Sub_detalle_vta.cdg_empresa    = T-Ped_header.cdg_empresa
                      AND T-Sub_detalle_vta.tip_comprob    = T-Ped_header.tip_comprob
                      AND T-Sub_detalle_vta.prf_comprob    = T-Ped_header.prf_comprob
                      AND T-Sub_detalle_vta.nro_comprob    = T-Ped_header.nro_comprob
                      AND T-Sub_detalle_vta.nro_cuenta     = Impuesto.nro_cuenta
                      AND T-Sub_detalle_vta.tipo           = 2
                           EXCLUSIVE-LOCK NO-ERROR.

               IF NOT AVAILABLE T-Sub_detalle_vta 
               THEN DO:
                    CREATE T-Sub_detalle_vta.
                    ASSIGN T-Sub_detalle_vta.cdg_empresa    = T-Ped_header.cdg_empresa
                           T-Sub_detalle_vta.tip_comprob    = T-Ped_header.tip_comprob
                           T-Sub_detalle_vta.prf_comprob    = T-Ped_header.prf_comprob
                           T-Sub_detalle_vta.nro_comprob    = T-Ped_header.nro_comprob
                           T-Sub_detalle_vta.nro_cuenta     = Impuesto.nro_cuenta
                           T-Sub_detalle_vta.tipo           = 2.
               END.

               T-Sub_detalle_vta.valor = T-Sub_detalle_vta.valor  + T-Ped_header_impuesto.importe.

           END.
           ELSE DO:

               FOR EACH T-Ped_detalle_impuesto OF T-Ped_header
                        WHERE T-Ped_detalle_impuesto.cdg_impuesto = T-Ped_header_impuesto.cdg_impuesto:
                   DELETE T-Ped_detalle_impuesto.
               END.

               DELETE T-Ped_header_impuesto.

           END.
       
       END.
   
   END.
   ELSE DO:
       T-Ped_header.imp_total = T-Ped_header.imp_neto.
   END.

/*----------------------------------------------------------------------------------------------*/
/*                      Acumula las bonificaciones de la cabecera                               */
/*----------------------------------------------------------------------------------------------*/

   IF Tipocomprobante.aplica_bonificaciones
   THEN DO:
       FOR EACH T-Ped_header-bon OF T-Ped_header:
           T-Ped_header.imp_descuentos = T-Ped_header.imp_descuentos  + T-Ped_header-bon.importe.
       END.
   END.
   
   ASSIGN T-Sub_header_vta.imp_total   = T-Ped_header.imp_total.

/*===============================================================================================*/
/*                                PROCEDIMIENTOS                                                 */
/*===============================================================================================*/

PROCEDURE calcular_subtotales_detalle:

          /* --------------------------------------------------- */
          /*  El precio a CF es el precio + impuestos. SI no hay */
          /*  impuestos, el precio_cf quedará igual al precio    */
          /* --------------------------------------------------- */

    T-Ped_detalle.precio_cf = T-Ped_detalle.precio.      
    
          /* --------------------------------------------------- */
          /*     Halla el total bruto del renglón de factura     */
          /* --------------------------------------------------- */

    IF Articulo.extendida
    THEN DO:
       T-Ped_detalle.subtotal_general = 
           ( IF T-Ped_detalle.cantidad <> 0 
                THEN ROUND( T-Ped_detalle.precio * ( T-Ped_detalle.cantidad - T-Ped_detalle.cantidad_cum ) , 2 )
                ELSE T-Ped_detalle.precio ).
    END.
    ELSE DO:
       T-Ped_detalle.subtotal_general = 
           ( IF T-Ped_detalle.a_granel 
                THEN ROUND( T-Ped_detalle.precio * ( T-Ped_detalle.granel - T-Ped_detalle.granel_cum ) , 2 )
                ELSE ROUND( T-Ped_detalle.precio * ( T-Ped_detalle.cantidad  - T-Ped_detalle.cantidad_cum ) , 2 ) ).
    
    END.            
    
    T-Ped_detalle.subtotal_bruto = T-Ped_detalle.subtotal_general.
    T-Ped_detalle.subtotal_bruto_cf = T-Ped_detalle.subtotal_general.

    IF Tipocomprobante.aplica_bonificaciones
    THEN DO:

          /* --------------------------------------------------- */
          /* Descuenta las bonificaciones del renglon de detalle */
          /* generando el importe BRUTO del renglon.             */
          /* --------------------------------------------------- */

        FOR EACH T-Ped_detalle-bon OF T-Ped_detalle EXCLUSIVE-LOCK, 
                Bonificacion OF T-Ped_detalle-bon:
        
           T-Ped_detalle-bon.importe = ROUND(T-Ped_detalle.subtotal_bruto *
                                       T-Ped_detalle-bon.porcentaje / 100 ,2 ).
        
           T-Ped_detalle.subtotal_bruto = T-Ped_detalle.subtotal_bruto - T-Ped_detalle-bon.importe.
        
        END. /* De las bonificaciones del detalle */

         /* ---------------------------------------------------- */
         /* Descuenta las bonificaciones globales prorrateadas   */
         /* en cada renglon de factura, generando el NETO y      */
         /* acumulando los descuentos totales para rehacer el    */
         /* total de la factura antes de las bonificaciones      */
         /* ---------------------------------------------------- */

        T-Ped_detalle.subtotal_neto    = T-Ped_detalle.subtotal_bruto.
        T-Ped_detalle.subtotal_neto_cf = T-Ped_detalle.subtotal_bruto.

        FOR EACH T-Ped_header-bon OF T-Ped_header:
        
            v-aux_importe  = ROUND(T-Ped_detalle.subtotal_neto * T-Ped_header-bon.porcentaje / 100, 2 ).
            T-Ped_header-bon.importe    = T-Ped_header-bon.importe     + v-aux_importe.
            T-Ped_detalle.subtotal_neto = T-Ped_detalle.subtotal_neto  - v-aux_importe.
    
        END.

    END.
    ELSE DO:
        T-Ped_detalle.subtotal_neto       = T-Ped_detalle.subtotal_bruto.
        T-Ped_detalle.subtotal_neto_cf    = T-Ped_detalle.subtotal_bruto.
    END.

END PROCEDURE.

PROCEDURE aplicar_impuestos_destino:

    FIND Familia_impositiva OF Articulo NO-LOCK.

    FOR EACH Impuesto_condicion OF  Familia_impositiva 
       WHERE Impuesto_condicion.cdg_condiva = T-Ped_header.cdg_condiva
         AND Impuesto_condicion.cdg_empresa = T-Ped_header.cdg_empresa 
         AND Impuesto_condicion.fch_desde <= T-Ped_header.fecha_iva
         AND Impuesto_condicion.fch_hasta >= T-Ped_header.fecha_iva
         AND CAN-DO(Impuesto_condicion.lista_provincias,T-Ped_header.cdg_provincia) NO-LOCK, 
             Impuesto OF Impuesto_condicion NO-LOCK:
              
          FIND FIRST  Cliente_excencion OF Cliente 
                      WHERE Cliente_excencion.cdg_empresa  = T-Ped_header.cdg_empresa
                        AND Cliente_excencion.cdg_impuesto = Impuesto_condicion.cdg_impuesto
                        AND Cliente_excencion.fch_desde <= T-Ped_header.fecha_iva
                        AND Cliente_excencion.fch_hasta >= T-Ped_header.fecha_iva NO-LOCK NO-ERROR.

          IF NOT AVAILABLE Cliente_excencion
             THEN x-tasa = Impuesto_condicion.tasa.
             ELSE x-tasa = Impuesto_condicion.tasa * ( 1 - Cliente_excencion.prc_excencion  / 100.0 ).
          
          x-monto_imponible = T-Ped_detalle.subtotal_neto.
          IF Impuesto_condicion.cdg_impuesto = 10
          THEN DO:
              FOR EACH T-Ped_detalle_impuesto OF T-Ped_detalle, FIRST B-Impuesto OF T-Ped_detalle_impuesto WHERE B-Impuesto.es_iva:
                  x-monto_imponible = x-monto_imponible + T-Ped_detalle_impuesto.importe.
              END.
          END.
          x-importe = x-monto_imponible * x-tasa / 100.0.

          IF x-importe <> 0
          THEN DO:
              CREATE T-Ped_detalle_impuesto.
              ASSIGN T-Ped_detalle_impuesto.nro_pedido     = T-Ped_detalle.nro_pedido
                     T-Ped_detalle_impuesto.nro_linea       = T-Ped_detalle.nro_linea
                     T-Ped_detalle_impuesto.cdg_impuesto    = Impuesto_condicion.cdg_impuesto
                     T-Ped_detalle_impuesto.tasa            = x-tasa
                     T-Ped_detalle_impuesto.monto_imponible = x-monto_imponible
                     T-Ped_detalle_impuesto.importe         = x-importe.
    
              IF Impuesto.es_iva
              THEN DO:
                  T-Ped_detalle.subtotal_bruto_cf = T-Ped_detalle.subtotal_bruto + T-Ped_detalle_impuesto.importe.             
                  T-Ped_detalle.precio_cf = T-Ped_detalle.precio * ( 1 + x-tasa / 100.0 ).
              END.
          END.
    
    END.
    
END PROCEDURE.

PROCEDURE aplicar_impuestos_origen:

    FIND Familia_impositiva OF Articulo NO-LOCK.

    FOR EACH Impuesto_condicion OF  Familia_impositiva 
       WHERE Impuesto_condicion.cdg_condiva = T-Ped_header.cdg_condiva
         AND Impuesto_condicion.cdg_empresa = T-Ped_header.cdg_empresa 
         AND Impuesto_condicion.fch_desde <= T-Ped_header.fecha_iva
         AND Impuesto_condicion.fch_hasta >= T-Ped_header.fecha_iva
         AND CAN-DO(Impuesto_condicion.lista_provincias,Punto-venta.cdg_provincia) NO-LOCK, 
             FIRST Impuesto OF Impuesto_condicion WHERE Impuesto.tipo_impuesto = "IB" NO-LOCK:
              
          FIND FIRST  Cliente_excencion OF Cliente 
                      WHERE Cliente_excencion.cdg_empresa  = T-Ped_header.cdg_empresa
                        AND Cliente_excencion.cdg_impuesto = Impuesto_condicion.cdg_impuesto
                        AND Cliente_excencion.fch_desde <= T-Ped_header.fecha_iva
                        AND Cliente_excencion.fch_hasta >= T-Ped_header.fecha_iva NO-LOCK NO-ERROR.

          IF NOT AVAILABLE Cliente_excencion
             THEN x-tasa = Impuesto_condicion.tasa.
             ELSE x-tasa = Impuesto_condicion.tasa * ( 1 - Cliente_excencion.prc_excencion  / 100.0 ).
          
          x-monto_imponible = T-Ped_detalle.subtotal_neto.
          x-importe = x-monto_imponible * x-tasa / 100.0.

          IF x-importe <> 0
          THEN DO:
              CREATE T-Ped_detalle_impuesto.
              ASSIGN T-Ped_detalle_impuesto.nro_pedido     = T-Ped_detalle.nro_pedido
                     T-Ped_detalle_impuesto.nro_linea       = T-Ped_detalle.nro_linea
                     T-Ped_detalle_impuesto.cdg_impuesto    = Impuesto_condicion.cdg_impuesto
                     T-Ped_detalle_impuesto.tasa            = x-tasa
                     T-Ped_detalle_impuesto.monto_imponible = x-monto_imponible
                     T-Ped_detalle_impuesto.importe         = x-importe.
          END.
    
    END.
    
END PROCEDURE.

PROCEDURE crear_imputacion_directa:
    /*          
    FIND FIRST Familia_cuenta OF Familia_articulo 
         WHERE Familia_cuenta.cdg_imputacion = T-Ped_header.cdg_imputacion 
           AND Familia_cuenta.cdg_empresa    = T-Ped_header.cdg_empresa 
               NO-LOCK.
    
    FIND  T-Sub_detalle_vta 
         WHERE T-Sub_detalle_vta.cdg_empresa   = T-Ped_header.cdg_empresa
           AND T-Sub_detalle_vta.tip_comprob   = T-Ped_header.tip_comprob
           AND T-Sub_detalle_vta.prf_comprob   = T-Ped_header.prf_comprob
           AND T-Sub_detalle_vta.nro_comprob   = T-Ped_header.nro_comprob
           AND T-Sub_detalle_vta.nro_cuenta    = Familia_cuenta.nro_cuenta
           AND T-Sub_detalle_vta.nro_entidad   = T-Ped_header.nro_entidad
           AND T-Sub_detalle_vta.nro_obra      = T-Ped_detalle.nro_obra
         EXCLUSIVE-LOCK NO-ERROR.

    IF NOT AVAILABLE T-Sub_detalle_vta 
    THEN DO:
       CREATE T-Sub_detalle_vta.
       ASSIGN T-Sub_detalle_vta.cdg_empresa    = T-Ped_header.cdg_empresa
              T-Sub_detalle_vta.tip_comprob    = T-Ped_header.tip_comprob
              T-Sub_detalle_vta.prf_comprob    = T-Ped_header.prf_comprob
              T-Sub_detalle_vta.nro_comprob    = T-Ped_header.nro_comprob
              T-Sub_detalle_vta.nro_cuenta     = Familia_cuenta.nro_cuenta
              T-Sub_detalle_vta.nro_entidad    = T-Ped_header.nro_entidad
              T-Sub_detalle_vta.nro_obra       = T-Ped_detalle.nro_obra
              T-Sub_detalle_vta.tipo           = 1.
    END.

    T-Sub_detalle_vta.valor = T-Sub_detalle_vta.valor + T-Ped_detalle.subtotal_neto.
    */
END PROCEDURE.

PROCEDURE crear_imputacion_distribuida:
    /*
    FIND FIRST Familia_cuenta OF Familia_articulo 
         WHERE Familia_cuenta.cdg_imputacion = T-Ped_header.cdg_imputacion 
           AND Familia_cuenta.cdg_empresa    = T-Ped_header.cdg_empresa 
               NO-LOCK.

    v-saldo_renglon = T-Ped_detalle.subtotal_neto.
    FOR EACH Entidad_distribucion 
        WHERE Entidad_distribucion.cdg_empresa = T-Ped_header.cdg_empresa
          AND Entidad_distribucion.nro_entidad = T-Ped_detalle.nro_entidad
              BREAK BY Entidad_distribucion.nro_entidad:

        FIND T-Sub_detalle_vta 
             WHERE T-Sub_detalle_vta.cdg_empresa    = T-Ped_header.cdg_empresa
               AND T-Sub_detalle_vta.tip_comprob    = T-Ped_header.tip_comprob
               AND T-Sub_detalle_vta.prf_comprob    = T-Ped_header.prf_comprob
               AND T-Sub_detalle_vta.nro_comprob    = T-Ped_header.nro_comprob
               AND T-Sub_detalle_vta.nro_cuenta     = Familia_cuenta.nro_cuenta
               AND T-Sub_detalle_vta.nro_entidad    = Entidad_distribucion.nro_entidad-dis
               AND T-Sub_detalle_vta.nro_obra       = T-Ped_detalle.nro_obra
             EXCLUSIVE-LOCK NO-ERROR.

        IF NOT AVAILABLE T-Sub_detalle_vta 
        THEN DO:
           CREATE T-Sub_detalle_vta.
           ASSIGN T-Sub_detalle_vta.cdg_empresa    = T-Ped_header.cdg_empresa
                  T-Sub_detalle_vta.tip_comprob    = T-Ped_header.tip_comprob
                  T-Sub_detalle_vta.prf_comprob    = T-Ped_header.prf_comprob
                  T-Sub_detalle_vta.nro_comprob    = T-Ped_header.nro_comprob
                  T-Sub_detalle_vta.nro_cuenta     = Familia_cuenta.nro_cuenta
                  T-Sub_detalle_vta.nro_entidad    = Entidad_distribucion.nro_entidad-dis
                  T-Sub_detalle_vta.nro_obra       = T-Ped_detalle.nro_obra
                  T-Sub_detalle_vta.tipo           = 1.
        END.

        IF LAST-OF(Entidad_distribucion.nro_entidad)
           THEN v-aux_importe = v-saldo_renglon.
           ELSE v-aux_importe = ROUND(T-Ped_detalle.subtotal_neto * Entidad_distribucion.porcentaje / 100.0 ,2).

        T-Sub_detalle_vta.valor = T-Sub_detalle_vta.valor + v-aux_importe.
        v-saldo_renglon = v-saldo_renglon - v-aux_importe.
    END.
    */
END PROCEDURE.
