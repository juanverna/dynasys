/*===============================================================================================*/
/*             REALIZA EL CALCULO DE LOC COMPROBANTES DE DIFERENCIA DE CAMBIO                    */
/*===============================================================================================*/

/*===============================================================================================*/
/*                           DEFINICION DE LAS TABLAS TEMPORALES                                 */
/*===============================================================================================*/

   DEFINE TEMP-TABLE T-Fac_header               NO-UNDO LIKE Fac_header.
   DEFINE TEMP-TABLE T-Fac_detalle              NO-UNDO LIKE Fac_detalle.
   DEFINE TEMP-TABLE T-Sub_header_vta           NO-UNDO LIKE Sub_header_vta.
   DEFINE TEMP-TABLE T-Sub_detalle_vta          NO-UNDO LIKE Sub_detalle_vta.
   DEFINE TEMP-TABLE T-Fac_header-bon           NO-UNDO LIKE Fac_header-bon.
   DEFINE TEMP-TABLE T-Fac_detalle-bon          NO-UNDO LIKE Fac_detalle-bon.
   DEFINE TEMP-TABLE T-Fac_header_impuesto      NO-UNDO LIKE Fac_header_impuesto.
   DEFINE TEMP-TABLE T-Fac_detalle_impuesto     NO-UNDO LIKE Fac_detalle_impuesto.
                                                                                                       
/*===============================================================================================*/
/*                               DEFINICION DE PARAMETROS                                        */
/*===============================================================================================*/
    
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Fac_header.
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Fac_detalle.
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Sub_header_vta.
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Sub_detalle_vta.
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Fac_header-bon.
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Fac_detalle-bon.
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Fac_header_impuesto.
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Fac_detalle_impuesto.

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

EMPTY TEMP-TABLE T-Sub_header_vta       NO-ERROR.
EMPTY TEMP-TABLE T-Sub_detalle_vta      NO-ERROR.
EMPTY TEMP-TABLE T-Fac_header_impuesto  NO-ERROR.
EMPTY TEMP-TABLE T-Fac_detalle_impuesto NO-ERROR.

FOR EACH T-Fac_header EXCLUSIVE-LOCK:


   FIND Tipocomprobante OF T-Fac_header NO-LOCK.
   /*
   FIND Obra OF T-Fac_header NO-LOCK.
   */
   FIND Cliente OF T-Fac_header NO-LOCK.
   FIND Familia_cliente OF Cliente NO-LOCK.

/*----------------------------------------------------------------------------------------------*/
/*                        Crear registro de encabezado de subdiario                             */
/*----------------------------------------------------------------------------------------------*/
              
   CREATE T-Sub_header_vta.
   BUFFER-COPY T-Fac_header TO T-Sub_header_vta
        ASSIGN T-Sub_header_vta.nro_cuenta      = Familia_cliente.nro_cuenta
            /* T-Sub_header_vta.nro_obra        = Obra.nro_obra */ .

/*----------------------------------------------------------------------------------------------*/
/*    Borramos los importes de las bonificaciones y las tablas temporales de los impuestos      */
/*----------------------------------------------------------------------------------------------*/

   FOR EACH T-Fac_header-bon OF T-Fac_header EXCLUSIVE-LOCK:
       T-Fac_header-bon.importe = 0.
   END.

/*----------------------------------------------------------------------------------------------*/
/* Recorre el detalle de facturas. El subtotal GENERAL es el que surge del PRECIO * CANTIDAD.   */
/* Descontadas las bonificaciones POR ARTICULO se obtiene el subtotal BRUTO. En base a  el, se  */
/* descuentas prorrateadas las bonificaciones GENERALES y se halla el subtotal NETO. Los brutos */
/* y netos que terminan en "cf" son los calculos para consumidor final                          */
/*----------------------------------------------------------------------------------------------*/

   T-Fac_header.imp_iva  = 0.

   FOR EACH T-Fac_detalle OF T-Fac_header EXCLUSIVE-LOCK, Articulo NO-LOCK OF T-Fac_detalle, 
            Familia_articulo NO-LOCK OF Articulo, Familia_impositiva OF Articulo NO-LOCK:
      
       RUN calcular_subtotales_detalle. 
       IF Tipocomprobante.aplica_impuestos
          THEN RUN aplicar_impuestos. 

       IF Articulo.sumaneto = 1
       THEN DO:
           IF CAN-FIND(FIRST Entidad_distribucion 
                              WHERE Entidad_distribucion.cdg_empresa = T-Fac_header.cdg_empresa
                                AND Entidad_distribucion.nro_entidad = T-Fac_detalle.nro_entidad)
               THEN RUN crear_imputacion_distribuida.
               ELSE RUN crear_imputacion_directa.            
       END.

   END. /* De recorrer el detalle */             

/*----------------------------------------------------------------------------------------------*/
/*          Halla el total neto y bruto de la factura para calcular impuestos generales         */
/*----------------------------------------------------------------------------------------------*/
        
   T-Fac_header.imp_neto  = 0.
   T-Fac_header.imp_bruto = 0.
   T-Fac_header.imp_descuentos = 0.

   FOR EACH T-Fac_detalle OF T-Fac_header NO-LOCK, Articulo OF T-Fac_detalle NO-LOCK:

       IF Articulo.sumaneto = 1
       THEN DO:
           T-Fac_header.imp_neto  = T-Fac_header.imp_neto  + T-Fac_detalle.subtotal_neto.
           T-Fac_header.imp_bruto = T-Fac_header.imp_bruto + T-Fac_detalle.subtotal_bruto.
           IF Tipocomprobante.aplica_bonificaciones
              THEN T-Fac_header.imp_descuentos = T-Fac_header.imp_descuentos + T-Fac_detalle.subtotal_bruto -
                                                 T-Fac_detalle.subtotal_neto.
       END.
   END.

/*----------------------------------------------------------------------------------------------*/
/*                      Acumula los impuestos de detalle en la cabecera                         */
/*----------------------------------------------------------------------------------------------*/

   IF Tipocomprobante.aplica_impuestos
   THEN DO:

       FOR EACH T-Fac_detalle_impuesto OF T-Fac_header: 
           
           FIND FIRST T-Fac_header_impuesto OF T-Fac_header
                      WHERE T-Fac_header_impuesto.cdg_impuesto = T-Fac_detalle_impuesto.cdg_impuesto
                        AND T-Fac_header_impuesto.tasa         = T-Fac_detalle_impuesto.tasa
                            EXCLUSIVE-LOCK NO-ERROR.
           IF NOT AVAILABLE T-Fac_header_impuesto
           THEN DO:
                CREATE T-Fac_header_impuesto.
                ASSIGN T-Fac_header_impuesto.nro_factura  = T-Fac_detalle_impuesto.nro_factura
                       T-Fac_header_impuesto.cdg_impuesto = T-Fac_detalle_impuesto.cdg_impuesto
                       T-Fac_header_impuesto.tasa         = T-Fac_detalle_impuesto.tasa.
           END.
           T-Fac_header_impuesto.importe  = T-Fac_header_impuesto.importe  + T-Fac_detalle_impuesto.importe.
           T-Fac_header_impuesto.monto_imponible = T-Fac_header_impuesto.monto_imponible  + T-Fac_detalle_impuesto.monto_imponible.

       END.
       
       T-Fac_header.imp_iva = 0.
       T-Fac_header.imp_total = T-Fac_header.imp_neto.
       FOR EACH T-Fac_header_impuesto OF T-Fac_header, Impuesto OF T-Fac_header_impuesto:
           
           FIND FIRST Impuesto_condicion 
               WHERE Impuesto_condicion.cdg_impuesto = T-Fac_header_impuesto.cdg_impuesto 
                 AND Impuesto_condicion.cdg_condiva = T-Fac_header.cdg_condiva
                     NO-LOCK.
           
           IF ROUND(T-Fac_header_impuesto.monto_imponible * T-Fac_header.cambio,2) >= Impuesto_condicion.valor_minimo AND
              ROUND(T-Fac_header_impuesto.importe * T-Fac_header.cambio,2) >= Impuesto_condicion.imp_minimo
           THEN DO:

               T-Fac_header.imp_total = T-Fac_header.imp_total + T-Fac_header_impuesto.importe.
               IF Impuesto.es_iva
                  THEN T-Fac_header.imp_iva = T-Fac_header.imp_iva + T-Fac_header_impuesto.importe.

               FIND  T-Sub_detalle_vta 
                    WHERE T-Sub_detalle_vta.cdg_empresa    = T-Fac_header.cdg_empresa
                      AND T-Sub_detalle_vta.tip_comprob    = T-Fac_header.tip_comprob
                      AND T-Sub_detalle_vta.prf_comprob    = T-Fac_header.prf_comprob
                      AND T-Sub_detalle_vta.nro_comprob    = T-Fac_header.nro_comprob
                      AND T-Sub_detalle_vta.nro_cuenta     = Impuesto.nro_cuenta
                      AND T-Sub_detalle_vta.tipo           = 2
                           EXCLUSIVE-LOCK NO-ERROR.

               IF NOT AVAILABLE T-Sub_detalle_vta 
               THEN DO:
                    CREATE T-Sub_detalle_vta.
                    ASSIGN T-Sub_detalle_vta.cdg_empresa    = T-Fac_header.cdg_empresa
                           T-Sub_detalle_vta.tip_comprob    = T-Fac_header.tip_comprob
                           T-Sub_detalle_vta.prf_comprob    = T-Fac_header.prf_comprob
                           T-Sub_detalle_vta.nro_comprob    = T-Fac_header.nro_comprob
                           T-Sub_detalle_vta.nro_cuenta     = Impuesto.nro_cuenta
                           T-Sub_detalle_vta.tipo           = 2.
               END.

               T-Sub_detalle_vta.valor = T-Sub_detalle_vta.valor  + T-Fac_header_impuesto.importe.

           END.
           ELSE DO:

               FOR EACH T-Fac_detalle_impuesto OF T-Fac_header
                        WHERE T-Fac_detalle_impuesto.cdg_impuesto = T-Fac_header_impuesto.cdg_impuesto:
                   DELETE T-Fac_detalle_impuesto.
               END.

               DELETE T-Fac_header_impuesto.

           END.
       
       END.
   
   END.
   ELSE DO:
       T-Fac_header.imp_total = T-Fac_header.imp_neto.
   END.

/*----------------------------------------------------------------------------------------------*/
/*                      Acumula las bonificaciones de la cabecera                               */
/*----------------------------------------------------------------------------------------------*/

   IF Tipocomprobante.aplica_bonificaciones
   THEN DO:
       FOR EACH T-Fac_header-bon OF T-Fac_header:
           T-Fac_header.imp_descuentos = T-Fac_header.imp_descuentos  + T-Fac_header-bon.importe.
       END.
   END.
   
   ASSIGN T-Sub_header_vta.imp_total   = T-Fac_header.imp_total.

END. /* De los encabezados de comprobantes */


/*===============================================================================================*/
/*                                PROCEDIMIENTOS                                                 */
/*===============================================================================================*/

PROCEDURE calcular_subtotales_detalle:

          /* --------------------------------------------------- */
          /*  El precio a CF es el precio + impuestos. SI no hay */
          /*  impuestos, el precio_cf quedará igual al precio    */
          /* --------------------------------------------------- */

    T-Fac_detalle.precio_cf = T-Fac_detalle.precio.      
    
          /* --------------------------------------------------- */
          /*     Halla el total bruto del renglón de factura     */
          /* --------------------------------------------------- */

    IF Articulo.extendida
    THEN DO:
       T-Fac_detalle.subtotal_general = 
           ( IF T-Fac_detalle.cantidad <> 0 
                THEN ROUND( T-Fac_detalle.precio * T-Fac_detalle.cantidad , 2 )
                ELSE T-Fac_detalle.precio ).
    END.
    ELSE DO:
       T-Fac_detalle.subtotal_general = 
           ( IF T-Fac_detalle.a_granel 
                THEN ROUND( T-Fac_detalle.precio * T-Fac_detalle.granel   , 2 )
                ELSE ROUND( T-Fac_detalle.precio * T-Fac_detalle.cantidad , 2 ) ).
    
    END.            
    
    T-Fac_detalle.subtotal_bruto = T-Fac_detalle.subtotal_general.
    T-Fac_detalle.subtotal_bruto_cf = T-Fac_detalle.subtotal_general.

    IF Tipocomprobante.aplica_bonificaciones
    THEN DO:

          /* --------------------------------------------------- */
          /* Descuenta las bonificaciones del renglon de detalle */
          /* generando el importe BRUTO del renglon.             */
          /* --------------------------------------------------- */

        FOR EACH T-Fac_detalle-bon OF T-Fac_detalle EXCLUSIVE-LOCK, 
                Bonificacion OF T-Fac_detalle-bon:
        
           T-Fac_detalle-bon.importe = ROUND(T-Fac_detalle.subtotal_bruto *
                                       T-Fac_detalle-bon.porcentaje / 100 ,2 ).
        
           T-Fac_detalle.subtotal_bruto = T-Fac_detalle.subtotal_bruto - T-Fac_detalle-bon.importe.
        
        END. /* De las bonificaciones del detalle */

         /* ---------------------------------------------------- */
         /* Descuenta las bonificaciones globales prorrateadas   */
         /* en cada renglon de factura, generando el NETO y      */
         /* acumulando los descuentos totales para rehacer el    */
         /* total de la factura antes de las bonificaciones      */
         /* ---------------------------------------------------- */

        T-Fac_detalle.subtotal_neto    = T-Fac_detalle.subtotal_bruto.
        T-Fac_detalle.subtotal_neto_cf = T-Fac_detalle.subtotal_bruto.

        FOR EACH T-Fac_header-bon OF T-Fac_header:
        
            v-aux_importe  = ROUND(T-Fac_detalle.subtotal_neto * T-Fac_header-bon.porcentaje / 100, 2 ).
            T-Fac_header-bon.importe    = T-Fac_header-bon.importe     + v-aux_importe.
            T-Fac_detalle.subtotal_neto = T-Fac_detalle.subtotal_neto  - v-aux_importe.
    
        END.

    END.
    ELSE DO:
        T-Fac_detalle.subtotal_neto       = T-Fac_detalle.subtotal_bruto.
        T-Fac_detalle.subtotal_neto_cf    = T-Fac_detalle.subtotal_bruto.
    END.

END PROCEDURE.

PROCEDURE aplicar_impuestos:

    FIND Familia_impositiva OF Articulo NO-LOCK.

    FOR EACH Impuesto_condicion OF  Familia_impositiva 
       WHERE Impuesto_condicion.cdg_condiva = T-Fac_header.cdg_condiva
         AND Impuesto_condicion.cdg_empresa = T-Fac_header.cdg_empresa 
         AND Impuesto_condicion.fch_desde <= T-Fac_header.fecha_iva
         AND Impuesto_condicion.fch_hasta >= T-Fac_header.fecha_iva
         AND CAN-DO(Impuesto_condicion.lista_provincias,T-Fac_header.cdg_provincia)
         NO-LOCK, Impuesto OF Impuesto_condicion NO-LOCK:
              
          FIND FIRST  Cliente_excencion OF Cliente 
                      WHERE Cliente_excencion.cdg_empresa  = T-Fac_header.cdg_empresa
                        AND Cliente_excencion.cdg_impuesto = Impuesto_condicion.cdg_impuesto
                        AND Cliente_excencion.fch_desde <= T-Fac_header.fecha_iva
                        AND Cliente_excencion.fch_hasta >= T-Fac_header.fecha_iva NO-LOCK NO-ERROR.
      /*
                         MESSAGE "Condiva:" T-Fac_header.cdg_condiva  SKIP
                                 "Empresa:" T-Fac_header.cdg_empresa  SKIP
                                 "Fecha IVA:" T-Fac_header.fecha_iva  SKIP
                                 "Impuesto:" Impuesto_condicion.cdg_impuesto SKIP
                                 "Hay Excencion:" AVAILABLE Cliente_excencion SKIP
                                 "Habilitado:" Impuesto_condicion.lista_provincias SKIP
                                 "Provincia:" T-Fac_header.cdg_provincia
                                  VIEW-AS ALERT-BOX MESSAGE.
      */

          IF NOT AVAILABLE Cliente_excencion
             THEN x-tasa = Impuesto_condicion.tasa.
             ELSE x-tasa = Impuesto_condicion.tasa * ( 1 - Cliente_excencion.prc_excencion  / 100.0 ).
          
          x-monto_imponible = T-Fac_detalle.subtotal_neto.
          IF Impuesto_condicion.cdg_impuesto = 10
          THEN DO:
              FOR EACH T-Fac_detalle_impuesto OF T-Fac_detalle, FIRST B-Impuesto OF T-Fac_detalle_impuesto WHERE B-Impuesto.es_iva:
                  x-monto_imponible = x-monto_imponible + T-Fac_detalle_impuesto.importe.
              END.
          END.
          x-importe = x-monto_imponible * x-tasa / 100.0.

          IF x-importe <> 0
          THEN DO:
              CREATE T-Fac_detalle_impuesto.
              ASSIGN T-Fac_detalle_impuesto.nro_factura     = T-Fac_detalle.nro_factura
                     T-Fac_detalle_impuesto.nro_linea       = T-Fac_detalle.nro_linea
                     T-Fac_detalle_impuesto.cdg_impuesto    = Impuesto_condicion.cdg_impuesto
                     T-Fac_detalle_impuesto.tasa            = x-tasa
                     T-Fac_detalle_impuesto.monto_imponible = x-monto_imponible
                     T-Fac_detalle_impuesto.importe         = x-importe.
    
              IF Impuesto.es_iva
              THEN DO:
                  T-Fac_detalle.subtotal_bruto_cf = T-Fac_detalle.subtotal_bruto + T-Fac_detalle_impuesto.importe.             
                  T-Fac_detalle.precio_cf = T-Fac_detalle.precio * ( 1 + x-tasa / 100.0 ).
              END.
          END.
    
    END.
    
END PROCEDURE.

PROCEDURE crear_imputacion_directa:
          
    FIND FIRST Familia_cuenta OF Familia_articulo 
         WHERE Familia_cuenta.cdg_imputacion = T-Fac_header.cdg_imputacion 
               NO-LOCK.
    
    FIND  T-Sub_detalle_vta 
         WHERE T-Sub_detalle_vta.cdg_empresa   = T-Fac_header.cdg_empresa
           AND T-Sub_detalle_vta.tip_comprob   = T-Fac_header.tip_comprob
           AND T-Sub_detalle_vta.prf_comprob   = T-Fac_header.prf_comprob
           AND T-Sub_detalle_vta.nro_comprob   = T-Fac_header.nro_comprob
           AND T-Sub_detalle_vta.nro_cuenta    = Familia_cuenta.nro_cuenta
           AND T-Sub_detalle_vta.nro_entidad   = T-Fac_header.nro_entidad
           AND T-Sub_detalle_vta.nro_obra      = T-Fac_detalle.nro_obra
         EXCLUSIVE-LOCK NO-ERROR.

    IF NOT AVAILABLE T-Sub_detalle_vta 
    THEN DO:
       CREATE T-Sub_detalle_vta.
       ASSIGN T-Sub_detalle_vta.cdg_empresa    = T-Fac_header.cdg_empresa
              T-Sub_detalle_vta.tip_comprob    = T-Fac_header.tip_comprob
              T-Sub_detalle_vta.prf_comprob    = T-Fac_header.prf_comprob
              T-Sub_detalle_vta.nro_comprob    = T-Fac_header.nro_comprob
              T-Sub_detalle_vta.nro_cuenta     = Familia_cuenta.nro_cuenta
              T-Sub_detalle_vta.nro_entidad    = T-Fac_header.nro_entidad
              T-Sub_detalle_vta.nro_obra       = T-Fac_detalle.nro_obra
              T-Sub_detalle_vta.tipo           = 1.
    END.

    T-Sub_detalle_vta.valor = T-Sub_detalle_vta.valor + T-Fac_detalle.subtotal_neto.

END PROCEDURE.

PROCEDURE crear_imputacion_distribuida:

    FIND FIRST Familia_cuenta OF Familia_articulo 
         WHERE Familia_cuenta.cdg_imputacion = T-Fac_header.cdg_imputacion 
               NO-LOCK.

    v-saldo_renglon = T-Fac_detalle.subtotal_neto.
    FOR EACH Entidad_distribucion 
        WHERE Entidad_distribucion.cdg_empresa = T-Fac_header.cdg_empresa
          AND Entidad_distribucion.nro_entidad = T-Fac_detalle.nro_entidad
              BREAK BY Entidad_distribucion.nro_entidad:

        FIND T-Sub_detalle_vta 
             WHERE T-Sub_detalle_vta.cdg_empresa    = T-Fac_header.cdg_empresa
               AND T-Sub_detalle_vta.tip_comprob    = T-Fac_header.tip_comprob
               AND T-Sub_detalle_vta.prf_comprob    = T-Fac_header.prf_comprob
               AND T-Sub_detalle_vta.nro_comprob    = T-Fac_header.nro_comprob
               AND T-Sub_detalle_vta.nro_cuenta     = Familia_cuenta.nro_cuenta
               AND T-Sub_detalle_vta.nro_entidad    = Entidad_distribucion.nro_entidad-dis
               AND T-Sub_detalle_vta.nro_obra       = T-Fac_detalle.nro_obra
             EXCLUSIVE-LOCK NO-ERROR.

        IF NOT AVAILABLE T-Sub_detalle_vta 
        THEN DO:
           CREATE T-Sub_detalle_vta.
           ASSIGN T-Sub_detalle_vta.cdg_empresa    = T-Fac_header.cdg_empresa
                  T-Sub_detalle_vta.tip_comprob    = T-Fac_header.tip_comprob
                  T-Sub_detalle_vta.prf_comprob    = T-Fac_header.prf_comprob
                  T-Sub_detalle_vta.nro_comprob    = T-Fac_header.nro_comprob
                  T-Sub_detalle_vta.nro_cuenta     = Familia_cuenta.nro_cuenta
                  T-Sub_detalle_vta.nro_entidad    = Entidad_distribucion.nro_entidad-dis
                  T-Sub_detalle_vta.nro_obra       = T-Fac_detalle.nro_obra
                  T-Sub_detalle_vta.tipo           = 1.
        END.

        IF LAST-OF(Entidad_distribucion.nro_entidad)
           THEN v-aux_importe = v-saldo_renglon.
           ELSE v-aux_importe = ROUND(T-Fac_detalle.subtotal_neto * Entidad_distribucion.porcentaje / 100.0 ,2).

        T-Sub_detalle_vta.valor = T-Sub_detalle_vta.valor + v-aux_importe.
        v-saldo_renglon = v-saldo_renglon - v-aux_importe.
    END.

END PROCEDURE.
