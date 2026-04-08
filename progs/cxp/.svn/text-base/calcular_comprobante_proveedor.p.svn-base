/*===============================================================================================*/
/*                 REALIZA EL CALCULO DE UN COMPROBANTE DE CLIENTE                               */
/*===============================================================================================*/

/*===============================================================================================*/
/*                           DEFINICION DE LAS TABLAS TEMPORALES                                 */
/*===============================================================================================*/

   DEFINE TEMP-TABLE T-Fac_header_prv           NO-UNDO LIKE Fac_header_prv.
   DEFINE TEMP-TABLE T-Fac_detalle_prv          NO-UNDO LIKE Fac_detalle_prv.
   DEFINE TEMP-TABLE T-Sub_header_prv           NO-UNDO LIKE Sub_header_prv.
   DEFINE TEMP-TABLE T-Sub_detalle_prv          NO-UNDO LIKE Sub_detalle_prv.
   DEFINE TEMP-TABLE T-Fac_header_prv_bon       NO-UNDO LIKE Fac_header_prv_bon.
   DEFINE TEMP-TABLE T-Fac_detalle_prv_bon      NO-UNDO LIKE Fac_detalle_prv_bon.
   DEFINE TEMP-TABLE T-Fac_header_prv_impuesto  NO-UNDO LIKE Fac_header_prv_impuesto.
   DEFINE TEMP-TABLE T-Fac_detalle_prv_impuesto NO-UNDO LIKE Fac_detalle_prv_impuesto.
   DEFINE TEMP-TABLE T-Asn_header               NO-UNDO LIKE Asn_header.
   DEFINE TEMP-TABLE T-Asn_detalle              NO-UNDO LIKE Asn_detalle.
   DEFINE TEMP-TABLE T-Asn_totales              NO-UNDO LIKE Asn_totales.

/*===============================================================================================*/
/*                               DEFINICION DE PARAMETROS                                        */
/*===============================================================================================*/
    
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Fac_header_prv.
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Fac_detalle_prv.
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Sub_header_prv.
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Sub_detalle_prv.
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Fac_header_prv_bon.
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Fac_detalle_prv_bon.
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Fac_header_prv_impuesto.
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Fac_detalle_prv_impuesto.
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Asn_header.
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Asn_detalle.
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Asn_totales.

/*===============================================================================================*/
/*                               DEFINICION DE VARIABLES                                         */
/*===============================================================================================*/

   DEFINE VARIABLE x-tasa           AS DECIMAL DECIMALS 4.
   DEFINE VARIABLE x-importe        AS DECIMAL.
   DEFINE VARIABLE v-debug          AS LOGICAL.
   DEFINE VARIABLE v-saldo_renglon  AS DECIMAL.
   DEFINE VARIABLE v-aux_importe    AS DECIMAL.
   
/*===============================================================================================*/
/*                                       PROCESO                                                 */
/*===============================================================================================*/

   {findempresa.i}

   FIND FIRST T-Fac_header_prv EXCLUSIVE-LOCK.
   FIND Tipocomprobante OF T-Fac_header_prv NO-LOCK.
   FIND Proveedor OF T-Fac_header_prv NO-LOCK.
   FIND Familia_proveedor OF Proveedor NO-LOCK.

/*----------------------------------------------------------------------------------------------*/
/*                              Borrado de las tablas temporales                                */
/*----------------------------------------------------------------------------------------------*/
              
   EMPTY TEMP-TABLE T-Sub_header_prv.
   EMPTY TEMP-TABLE T-Sub_detalle_prv.

   EMPTY TEMP-TABLE T-Asn_header.
   EMPTY TEMP-TABLE T-Asn_detalle.
   EMPTY TEMP-TABLE T-Asn_totales.

   EMPTY TEMP-TABLE T-Fac_header_prv_impuesto.
   EMPTY TEMP-TABLE T-Fac_detalle_prv_impuesto.

/*----------------------------------------------------------------------------------------------*/
/*                        Crear registro de encabezado de subdiario                             */
/*----------------------------------------------------------------------------------------------*/

   CREATE T-Sub_header_prv.
   BUFFER-COPY T-Fac_header_prv TO T-Sub_header_prv
       ASSIGN T-Sub_header_prv.imp_total   = 0
              T-Sub_header_prv.fecha = T-Fac_header_prv.fecha_iva.
   /*     T-Sub_header_prv.nro_obra        = Obra.nro_obra. */
   IF T-Fac_header_prv.nro_rendgastos = 0
   THEN DO:
       T-Sub_header_prv.nro_cuenta  = Familia_proveedor.nro_cuenta.
   END.
   ELSE DO:
       FIND Rendgastos_hd WHERE Rendgastos_hd.nro_rendgastos = T-Fac_header_prv.nro_rendgastos NO-LOCK.
       FIND Tipo_rendgastos OF Rendgastos_hd NO-LOCK.

       T-Sub_header_prv.nro_cuenta  = Tipo_rendgastos.nro_cuenta.
   END.


/*----------------------------------------------------------------------------------------------*/
/*                       Borramos los importes de las bonificaciones                            */
/*----------------------------------------------------------------------------------------------*/

   FOR EACH T-Fac_header_prv_bon OF T-Fac_header_prv EXCLUSIVE-LOCK:
       T-Fac_header_prv_bon.importe = 0.
   END.

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

       IF CAN-FIND(FIRST Entidad_distribucion 
                          WHERE Entidad_distribucion.cdg_empresa = T-Fac_header_prv.cdg_empresa
                            AND Entidad_distribucion.nro_entidad = T-Fac_detalle_prv.nro_entidad)
           THEN RUN crear_imputacion_distribuida.
           ELSE RUN crear_imputacion_directa.            

   END. /* De recorrer el detalle */             

/*----------------------------------------------------------------------------------------------*/
/* Halla el total neto y bruto de la factura para calcular impuestos generales En el imp_total  */
/* acumula los subtotales a consumidor final, ya que lo usa en el parrafo de abajo para calcu-  */
/* lar el importe de iva por diferencia entre el importe total y el importe neto.               */
/*----------------------------------------------------------------------------------------------*/
        
   T-Fac_header_prv.imp_neto  = 0.
   T-Fac_header_prv.imp_bruto = 0.
   T-Fac_header_prv.imp_descuentos = 0.

   FOR EACH T-Fac_detalle_prv OF T-Fac_header_prv NO-LOCK:
       FIND articulo OF T-Fac_detalle_prv NO-LOCK NO-ERROR.

       IF AVAILABLE articulo AND articulo.sumaneto = 1 THEN
       T-Fac_header_prv.imp_neto  = T-Fac_header_prv.imp_neto  + T-Fac_detalle_prv.subtotal_neto.
       
       T-Fac_header_prv.imp_bruto = T-Fac_header_prv.imp_bruto + T-Fac_detalle_prv.subtotal_bruto.
      

       IF Tipocomprobante.aplica_bonificaciones
          THEN T-Fac_header_prv.imp_descuentos = T-Fac_header_prv.imp_descuentos + T-Fac_detalle_prv.subtotal_bruto -
                                                 T-Fac_detalle_prv.subtotal_neto.
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
/*        T-Fac_header_prv.imp_total = T-Fac_header_prv.imp_neto.  */
       T-Fac_header_prv.imp_total = T-Fac_header_prv.imp_bruto.
       FOR EACH T-Fac_header_prv_impuesto OF T-Fac_header_prv, Impuesto OF T-Fac_header_prv_impuesto:
           
           FIND FIRST Impuesto_condicion 
               WHERE Impuesto_condicion.cdg_impuesto = T-Fac_header_prv_impuesto.cdg_impuesto 
                 AND Impuesto_condicion.cdg_condiva = T-Fac_header_prv.cdg_condiva
                     NO-LOCK.
           
           IF T-Fac_header_prv_impuesto.monto_imponible >= Impuesto_condicion.valor_minimo AND
              T-Fac_header_prv_impuesto.importe >= Impuesto_condicion.imp_minimo
           THEN DO:

               T-Fac_header_prv.imp_total = T-Fac_header_prv.imp_total + T-Fac_header_prv_impuesto.importe.
               IF Impuesto.es_iva
                  THEN T-Fac_header_prv.imp_iva = T-Fac_header_prv.imp_iva + T-Fac_header_prv_impuesto.importe.

               FIND  T-Sub_detalle_prv 
                    WHERE T-Sub_detalle_prv.cdg_empresa    = T-Fac_header_prv.cdg_empresa
                      AND T-Sub_detalle_prv.tip_comprob    = T-Fac_header_prv.tip_comprob
                      AND T-Sub_detalle_prv.prf_comprob    = T-Fac_header_prv.prf_comprob
                      AND T-Sub_detalle_prv.nro_comprob    = T-Fac_header_prv.nro_comprob
                      AND T-Sub_detalle_prv.nro_proveedor  = T-Fac_header_prv.nro_proveedor
                      AND T-Sub_detalle_prv.nro_cuenta     = Impuesto.nro_cuenta
                      AND T-Sub_detalle_prv.tipo           = 2
                           EXCLUSIVE-LOCK NO-ERROR.

               IF NOT AVAILABLE T-Sub_detalle_prv 
               THEN DO:
                    CREATE T-Sub_detalle_prv.
                    ASSIGN
                           T-Sub_detalle_prv.cdg_empresa    = T-Fac_header_prv.cdg_empresa
                           T-Sub_detalle_prv.tip_comprob    = T-Fac_header_prv.tip_comprob
                           T-Sub_detalle_prv.prf_comprob    = T-Fac_header_prv.prf_comprob
                           T-Sub_detalle_prv.nro_comprob    = T-Fac_header_prv.nro_comprob
                           T-Sub_detalle_prv.nro_proveedor  = T-Fac_header_prv.nro_proveedor
                           T-Sub_detalle_prv.nro_cuenta     = Impuesto.nro_cuenta
                           T-Sub_detalle_prv.tipo           = 2.
               END.

               T-Sub_detalle_prv.valor = T-Sub_detalle_prv.valor  + T-Fac_header_prv_impuesto.importe.

           END.
           ELSE DO:

               FOR EACH T-Fac_detalle_prv_impuesto 
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

   IF Tipocomprobante.aplica_bonificaciones
   THEN DO:
       FOR EACH T-Fac_header_prv_bon OF T-Fac_header_prv:
           T-Fac_header_prv.imp_descuentos = T-Fac_header_prv.imp_descuentos  + T-Fac_header_prv_bon.importe.
       END.
   END.
   
   ASSIGN T-Sub_header_prv.imp_total   = T-Fac_header_prv.imp_total.

/*----------------------------------------------------------------------------------------------*/
/*                      Calcula el asiento contable                                             */
/*----------------------------------------------------------------------------------------------*/

   RUN calcular_asiento_contable.

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
/*     MESSAGE T-Fac_detalle_prv.subtotal_neto VIEW-AS ALERT-BOX.                                              */
/*     MESSAGE articulo.cdg_articulo articulo.sumaneto VIEW-AS ALERT-BOX.                                      */
/*     IF Articulo.sumaneto = 0 THEN                                                                           */
/*     T-Fac_detalle_prv.subtotal_neto = T-Fac_detalle_prv.subtotal_neto - T-Fac_detalle_prv.subtotal_general. */
/* MESSAGE T-Fac_detalle_prv.subtotal_neto VIEW-AS ALERT-BOX.                                                  */
    
    T-Fac_detalle_prv.subtotal_bruto = T-Fac_detalle_prv.subtotal_general.

    IF Tipocomprobante.aplica_bonificaciones
    THEN DO:

          /* --------------------------------------------------- */
          /* Descuenta las bonificaciones del renglon de detalle */
          /* generando el importe BRUTO del renglon.             */
          /* --------------------------------------------------- */

        FOR EACH T-Fac_detalle_prv_bon OF T-Fac_detalle_prv EXCLUSIVE-LOCK:
        
           T-Fac_detalle_prv_bon.importe = ROUND(T-Fac_detalle_prv.subtotal_bruto *
                                       T-Fac_detalle_prv_bon.porcentaje / 100 ,2 ).
        
           T-Fac_detalle_prv.subtotal_bruto = T-Fac_detalle_prv.subtotal_bruto - T-Fac_detalle_prv_bon.importe.
        
        END. /* De las bonificaciones del detalle */

         /* ---------------------------------------------------- */
         /* Descuenta las bonificaciones globales prorrateadas   */
         /* en cada renglon de factura, generando el NETO y      */
         /* acumulando los descuentos totales para rehacer el    */
         /* total de la factura antes de las bonificaciones      */
         /* ---------------------------------------------------- */

        T-Fac_detalle_prv.subtotal_neto    = T-Fac_detalle_prv.subtotal_bruto.

        FOR EACH T-Fac_header_prv_bon OF T-Fac_header_prv:
        
            v-aux_importe  = ROUND(T-Fac_detalle_prv.subtotal_neto * T-Fac_header_prv_bon.porcentaje / 100, 2 ).
            T-Fac_header_prv_bon.importe    = T-Fac_header_prv_bon.importe     + v-aux_importe.
            T-Fac_detalle_prv.subtotal_neto = T-Fac_detalle_prv.subtotal_neto  - v-aux_importe.
    
        END.

    END.
    ELSE DO:
        T-Fac_detalle_prv.subtotal_neto       = T-Fac_detalle_prv.subtotal_bruto.
    END.

END PROCEDURE.

PROCEDURE aplicar_impuestos:
/* si el cliente es suceptible de aplicacion de impuertos 
pero el comprobante no es el correcto lo tomamos como gasto */
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

          IF NOT AVAILABLE Proveedor_excencion
             THEN x-tasa = Impuesto_condicion.tasa.
             ELSE x-tasa = Impuesto_condicion.tasa * ( 1 - Proveedor_excencion.prc_excencion  / 100.0 ).
          
          x-importe = T-Fac_detalle_prv.subtotal_neto * x-tasa / 100.0.

          IF x-importe <> 0
          THEN DO:
              CREATE T-Fac_detalle_prv_impuesto.
              ASSIGN T-Fac_detalle_prv_impuesto.nro_facprov  = T-Fac_detalle_prv.nro_facprov
                     T-Fac_detalle_prv_impuesto.nro_linea    = T-Fac_detalle_prv.nro_linea
                     T-Fac_detalle_prv_impuesto.cdg_impuesto = Impuesto_condicion.cdg_impuesto
                     T-Fac_detalle_prv_impuesto.tasa         = x-tasa
                     T-Fac_detalle_prv_impuesto.monto_imponible = T-Fac_detalle_prv.subtotal_neto
                     T-Fac_detalle_prv_impuesto.importe      = x-importe.
    
          END.
    
    END.
    
END PROCEDURE.

PROCEDURE crear_imputacion_directa:
          
    FIND FIRST Familia_cuenta OF Familia_articulo 
         WHERE Familia_cuenta.cdg_imputacion = T-Fac_header_prv.cdg_imputacion 
               NO-LOCK.
    
    FIND  T-Sub_detalle_prv 
         WHERE T-Sub_detalle_prv.cdg_empresa        = T-Fac_header_prv.cdg_empresa
           AND T-Sub_detalle_prv.tip_comprob        = T-Fac_header_prv.tip_comprob
           AND T-Sub_detalle_prv.prf_comprob        = T-Fac_header_prv.prf_comprob
           AND T-Sub_detalle_prv.nro_comprob        = T-Fac_header_prv.nro_comprob
           AND T-Sub_detalle_prv.nro_proveedor      = T-Fac_header_prv.nro_proveedor
           AND T-Sub_detalle_prv.nro_cuenta         = Familia_cuenta.nro_cuenta
           AND T-Sub_detalle_prv.nro_entidad        = T-Fac_detalle_prv.nro_entidad
           AND T-Sub_detalle_prv.nro_obra           = T-Fac_detalle_prv.nro_obra
           AND T-Sub_detalle_prv.lista_imputaciones = T-Fac_detalle_prv.lista_imputaciones
         EXCLUSIVE-LOCK NO-ERROR.

    IF NOT AVAILABLE T-Sub_detalle_prv 
    THEN DO:
       CREATE T-Sub_detalle_prv.
       ASSIGN T-Sub_detalle_prv.cdg_empresa        = T-Fac_header_prv.cdg_empresa
              T-Sub_detalle_prv.tip_comprob        = T-Fac_header_prv.tip_comprob
              T-Sub_detalle_prv.prf_comprob        = T-Fac_header_prv.prf_comprob
              T-Sub_detalle_prv.nro_comprob        = T-Fac_header_prv.nro_comprob
              T-Sub_detalle_prv.nro_proveedor      = T-Fac_header_prv.nro_proveedor
              T-Sub_detalle_prv.nro_cuenta         = Familia_cuenta.nro_cuenta
              T-Sub_detalle_prv.nro_entidad        = T-Fac_detalle_prv.nro_entidad
              T-Sub_detalle_prv.nro_obra           = T-Fac_detalle_prv.nro_obra
              T-Sub_detalle_prv.lista_imputaciones = T-Fac_detalle_prv.lista_imputaciones
              T-Sub_detalle_prv.num_subcolumna     = T-Fac_detalle_prv.num_subcolumna
              T-Sub_detalle_prv.tipo               = 1.
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
             WHERE T-Sub_detalle_prv.cdg_empresa        = T-Fac_header_prv.cdg_empresa
               AND T-Sub_detalle_prv.tip_comprob        = T-Fac_header_prv.tip_comprob
               AND T-Sub_detalle_prv.prf_comprob        = T-Fac_header_prv.prf_comprob
               AND T-Sub_detalle_prv.nro_comprob        = T-Fac_header_prv.nro_comprob
               AND T-Sub_detalle_prv.nro_proveedor      = T-Fac_header_prv.nro_proveedor
               AND T-Sub_detalle_prv.nro_cuenta         = Familia_cuenta.nro_cuenta
               AND T-Sub_detalle_prv.nro_entidad        = Entidad_distribucion.nro_entidad-dis
               AND T-Sub_detalle_prv.nro_obra           = T-Fac_detalle_prv.nro_obra
               AND T-Sub_detalle_prv.lista_imputaciones = T-Fac_detalle_prv.lista_imputaciones
             EXCLUSIVE-LOCK NO-ERROR.

        IF NOT AVAILABLE T-Sub_detalle_prv 
        THEN DO:
           CREATE T-Sub_detalle_prv.
           ASSIGN T-Sub_detalle_prv.cdg_empresa        = T-Fac_header_prv.cdg_empresa
                  T-Sub_detalle_prv.tip_comprob        = T-Fac_header_prv.tip_comprob
                  T-Sub_detalle_prv.prf_comprob        = T-Fac_header_prv.prf_comprob
                  T-Sub_detalle_prv.nro_comprob        = T-Fac_header_prv.nro_comprob
                  T-Sub_detalle_prv.nro_proveedor      = T-Fac_header_prv.nro_proveedor
                  T-Sub_detalle_prv.nro_cuenta         = Familia_cuenta.nro_cuenta
                  T-Sub_detalle_prv.nro_entidad        = Entidad_distribucion.nro_entidad-dis
                  T-Sub_detalle_prv.nro_obra           = T-Fac_detalle_prv.nro_obra
                  T-Sub_detalle_prv.lista_imputaciones = T-Fac_detalle_prv.lista_imputaciones
                  T-Sub_detalle_prv.num_subcolumna     = T-Fac_detalle_prv.num_subcolumna
                  T-Sub_detalle_prv.tipo               = 1.
        END.

        IF LAST-OF(Entidad_distribucion.nro_entidad)
           THEN v-aux_importe = v-saldo_renglon.
           ELSE v-aux_importe = ROUND(T-Fac_detalle_prv.subtotal_neto * Entidad_distribucion.porcentaje / 100.0 ,2).

        T-Sub_detalle_prv.valor = T-Sub_detalle_prv.valor + v-aux_importe.
        v-saldo_renglon = v-saldo_renglon - v-aux_importe.
    END.

END PROCEDURE.

PROCEDURE calcular_asiento_contable:
   
   FIND Tipocomprobante OF T-Fac_header_prv NO-LOCK.  
   FIND FIRST T-Sub_header_prv.

   FIND Proveedor OF T-Sub_header_prv NO-LOCK NO-ERROR.
   CREATE T-Asn_header.
   ASSIGN T-Asn_header.anulado           = NO
          T-Asn_header.cdg_empresa       = T-Sub_header_prv.cdg_empresa
          T-Asn_header.cdg_sigla-sic     = "CXP"
          T-Asn_header.nro_idcabecera    = T-Fac_header_prv.nro_facprov 
          T-Asn_header.tabla_comprobante = "Fac_header_prv"
          T-Asn_header.posteo            = "0"
          T-Asn_header.reexpresa_saldos  = Tipocomprobante.reexpresa_movimiento
          T-Asn_header.cambio            = T-Sub_header_prv.cambio
          T-Asn_header.cambio_dolar      = T-Sub_header_prv.cambio_dolar
          T-Asn_header.fecha             = T-Sub_header_prv.fecha
          T-Asn_header.leyenda           = T-Sub_header_prv.tip_comprob + " " +
                                           STRING(T-Sub_header_prv.prf_comprob,"9999") + " " +
                                           STRING(T-Sub_header_prv.nro_comprob,"99999999") +  " " +
                                           IF AVAILABLE Proveedor 
                                              THEN "[" + Proveedor.cdg_proveedor + "] " + Proveedor.nombre
                                              ELSE ""
          T-Asn_header.nro_asiento       = 0
          T-Asn_header.nro_comprob       = 0
          T-Asn_header.nro_usuario       = Usuario.nro_usuario
          T-Asn_header.origen            = "A"
          T-Asn_header.tip_comprob       = "AS"
          T-Asn_header.estado            = IF T-Sub_header_prv.contable THEN "*" ELSE "P".
          

   IF Tipocomprobante.debita  /* Debitamos encabezado si corresponde */
   THEN DO: 
       CREATE T-Asn_detalle.
       ASSIGN T-Asn_header.ultima_linea    = T-Asn_header.ultima_linea + 1
              T-Asn_detalle.cdg_empresa    = T-Asn_header.cdg_empresa
              T-Asn_detalle.credito        = 0
              T-Asn_detalle.debito         = T-Sub_header_prv.imp_total
              T-Asn_detalle.cambio         = T-Sub_header_prv.cambio
              T-Asn_detalle.cambio_dolar   = 1
              T-Asn_detalle.fecha_mayor    = T-Asn_header.fecha
              T-Asn_detalle.nro_asiento    = T-Asn_header.nro_asiento
              T-Asn_detalle.nro_cuenta     = T-Sub_header_prv.nro_cuenta
              T-Asn_detalle.nro_entidad    = T-Sub_header_prv.nro_entidad
              T-Asn_detalle.nro_linea      = T-Asn_header.ultima_linea
              T-Asn_detalle.nro_moneda     = T-Sub_header_prv.nro_moneda
              T-Asn_detalle.nro_obra       = 0
              T-Asn_detalle.nro_subcuenta  = 0.

   END.     

   FOR EACH T-Sub_detalle_prv WHERE T-Sub_detalle_prv.cdg_empresa   = T-Sub_header_prv.cdg_empresa
                                AND T-Sub_detalle_prv.tip_comprob   = T-Sub_header_prv.tip_comprob
                                AND T-Sub_detalle_prv.prf_comprob   = T-Sub_header_prv.prf_comprob
                                AND T-Sub_detalle_prv.nro_comprob   = T-Sub_header_prv.nro_comprob
                                AND T-Sub_detalle_prv.nro_proveedor = T-Sub_header_prv.nro_proveedor
                                    EXCLUSIVE-LOCK, Cuenta OF T-Sub_detalle_prv:

       CREATE T-Asn_detalle.
       BUFFER-COPY T-Sub_detalle_prv TO T-Asn_detalle
           ASSIGN T-Asn_header.ultima_linea    = T-Asn_header.ultima_linea + 1
                  T-Asn_detalle.cdg_empresa    = T-Asn_header.cdg_empresa
                  T-Asn_detalle.fecha_mayor    = T-Asn_header.fecha
                  T-Asn_detalle.leyen_detalle  = T-Asn_header.leyenda
                  T-Asn_detalle.nro_asiento    = T-Asn_header.nro_asiento
                  T-Asn_detalle.nro_linea      = T-Asn_header.ultima_linea
                  T-Asn_detalle.nro_subcuenta  = 0
                  T-Asn_detalle.cambio         = T-Sub_header_prv.cambio
                  T-Asn_detalle.cambio_dolar   = 1.

       IF Tipocomprobante.debita
       THEN DO:
           T-Asn_detalle.credito  = T-Sub_detalle_prv.valor.
           T-Asn_detalle.debito   = 0.
       END.
       ELSE DO:
           T-Asn_detalle.credito  = 0.
           T-Asn_detalle.debito   = T-Sub_detalle_prv.valor.
       END.


   END. /* De los detalles de subdiario de Compras */
       
   IF NOT Tipocomprobante.debita /* Acreditamos encabezado si corresponde */
   THEN DO: 

       CREATE T-Asn_detalle.
       ASSIGN T-Asn_header.ultima_linea    = T-Asn_header.ultima_linea + 1
              T-Asn_detalle.cdg_empresa    = T-Asn_header.cdg_empresa
              T-Asn_detalle.credito        = T-Sub_header_prv.imp_total
              T-Asn_detalle.debito         = 0

              T-Asn_detalle.cambio         = T-Sub_header_prv.cambio
              T-Asn_detalle.cambio_dolar   = 1

              T-Asn_detalle.fecha_mayor    = T-Asn_header.fecha
              T-Asn_detalle.leyen_detalle  = T-Asn_header.leyenda
              T-Asn_detalle.nro_asiento    = T-Asn_header.nro_asiento
              T-Asn_detalle.nro_cuenta     = T-Sub_header_prv.nro_cuenta
              T-Asn_detalle.nro_entidad    = T-Sub_header_prv.nro_entidad
              T-Asn_detalle.nro_linea      = T-Asn_header.ultima_linea
              T-Asn_detalle.nro_moneda     = T-Sub_header_prv.nro_moneda
              T-Asn_detalle.nro_obra       = 0
              T-Asn_detalle.nro_subcuenta  = 0.

    END.     

    RUN reexpresar_asiento.p ( INPUT-OUTPUT TABLE T-Asn_header,
                               INPUT-OUTPUT TABLE T-Asn_detalle,
                               INPUT-OUTPUT TABLE T-Asn_totales).
    FIND FIRST T-Asn_header.
    
    T-Sub_header_prv.contable = YES.

END PROCEDURE.

