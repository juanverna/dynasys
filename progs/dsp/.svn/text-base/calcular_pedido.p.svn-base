/*===============================================================================================*/
/*                 REALIZA EL CALCULO DE UNA FACTURA EN LAS TABLAS TEMPORALES                    */
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

DEFINE VARIABLE x-tasa           AS DECIMAL DECIMALS 4.
DEFINE VARIABLE tasa_iva         AS DECIMAL.
DEFINE VARIABLE hubo_iva         AS LOGICAL.
DEFINE VARIABLE v-debug          AS LOGICAL.
DEFINE VARIABLE letra_comp       AS CHARACTER.
DEFINE VARIABLE v-saldo_renglon  AS DECIMAL.
DEFINE VARIABLE v-aux_importe    AS DECIMAL.

/*===============================================================================================*/
/*                                       PROCESO                                                 */
/*===============================================================================================*/

   FIND FIRST T-Ped_header EXCLUSIVE-LOCK.

   EMPTY TEMP-TABLE T-Sub_header_vta.
   EMPTY TEMP-TABLE T-Sub_detalle_vta.

   letra_comp = SUBSTRING(T-Ped_header.tip_comprob,2,1).

   /*FIND Obra OF T-Ped_header NO-LOCK.*/
   FIND Cliente OF T-Ped_header NO-LOCK.
   FIND Familia_cliente OF Cliente NO-LOCK.
   FIND Tipocomprobante OF T-Ped_header NO-LOCK.
              
              /*-------------------------------------------*/
              /* Crear registro de encabezado de subdiario */
              /*-------------------------------------------*/

   CREATE T-Sub_header_vta.
   ASSIGN T-Sub_header_vta.cdg_empresa = T-Ped_header.cdg_empresa
          T-Sub_header_vta.tip_comprob = T-Ped_header.tip_comprob
          T-Sub_header_vta.prf_comprob = T-Ped_header.prf_comprob
          T-Sub_header_vta.nro_comprob = T-Ped_header.nro_comprob
          T-Sub_header_vta.fecha       = T-Ped_header.fecha
          T-Sub_header_vta.nro_cuenta  = Familia_cliente.nro_cuenta
          T-Sub_header_vta.nro_entidad = T-Ped_header.nro_entidad 
        /*T-Sub_header_vta.nro_obra    = Obra.nro_obra */.

             /*---------------------------------------------*/    
             /* Borramos los importes de las bonificaciones */
             /* y las tablas temporales de los impuestos    */
             /*---------------------------------------------*/

   FOR EACH T-Ped_header-bon OF T-Ped_header EXCLUSIVE-LOCK:
       T-Ped_header-bon.importe = 0.
   END.

   EMPTY TEMP-TABLE T-Ped_header_impuesto  NO-ERROR.
   EMPTY TEMP-TABLE T-Ped_detalle_impuesto NO-ERROR.

        /*-----------------------------------------------------------------------------*/
        /* Recorre el detalle de facturas. El subtotal BRUTO es el que surge del       */
        /* PRECIO * CANTIDAD y descontadas las bonificaciones POR ARTICULO. En base a  */
        /* el, se descuentas prorrateadas las bonificaciones GENERALES y se hala el    */
        /* subtotal NETO. Los brutos y netos que terminan en "cf" son los calculos pa- */
        /* ra consumidor final                                                         */
        /*-----------------------------------------------------------------------------*/
  
   T-Ped_header.imp_iva  = 0.
   T-Ped_header.imp_descuentos = 0.

   FOR EACH T-Ped_detalle OF T-Ped_header EXCLUSIVE-LOCK, Articulo NO-LOCK OF T-Ped_detalle, 
            Familia_articulo NO-LOCK OF Articulo, Familia_impositiva OF Articulo NO-LOCK:

       RUN calcular_subtotales_detalle. /* Halla los subtotales bruto como cantidad x precio y descuenta bonificaciones */
       IF Tipocomprobante.aplica_impuestos
           THEN RUN aplicar_impuestos.   /* Aplica los impuestos específicos del detalle y prorratea los generales       */

                 /* ------------------------------------------------- */
                 /* Busca y crea si no existe el detalle de subdiario */
                 /* ------------------------------------------------- */

       IF CAN-FIND(FIRST Entidad_distribucion 
                          WHERE Entidad_distribucion.cdg_empresa = T-Ped_header.cdg_empresa
                            AND Entidad_distribucion.nro_entidad = T-Ped_detalle.nro_entidad)
           THEN RUN crear_imputacion_distribuida.
           ELSE RUN crear_imputacion_directa.            

   END. /* De recorrer el detalle */             


        /* --------------------------------------------------------------------------- */
        /* Halla el total neto y bruto de la factura para calcular impuestos generales */
        /* En el imp_total acumula los subtotales a consumidor final, ya que lo usa en */
        /* el parrafo de abajo para calcular el importe de iva por diferencia entre el */
        /* importe total y el importe neto.                                            */
        /* --------------------------------------------------------------------------- */
        
   T-Ped_header.imp_neto  = 0.
   T-Ped_header.imp_bruto = 0.
   T-Ped_header.imp_descuentos = 0.

   FOR EACH T-Ped_detalle OF T-Ped_header NO-LOCK:

       T-Ped_header.imp_neto  = T-Ped_header.imp_neto  + T-Ped_detalle.subtotal_neto.
       T-Ped_header.imp_bruto = T-Ped_header.imp_bruto + T-Ped_detalle.subtotal_bruto.
       T-Ped_header.imp_descuentos = T-Ped_header.imp_descuentos + T-Ped_detalle.subtotal_bruto -
                                     T-Ped_detalle.subtotal_neto.
   END.

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
           T-Ped_header_impuesto.importe = T-Ped_header_impuesto.importe  + T-Ped_detalle_impuesto.importe.
     
       END.
   END.

   T-Ped_header.imp_total = T-Ped_header.imp_neto.
   FOR EACH T-Ped_header_impuesto OF T-Ped_header:
       T-Ped_header.imp_total = T-Ped_header.imp_total + T-Ped_header_impuesto.importe.
   END.

   FOR EACH T-Ped_header-bon OF T-Ped_header:
       T-Ped_header.imp_descuentos = T-Ped_header.imp_descuentos  + T-Ped_header-bon.importe.
   END.

   ASSIGN
          T-Sub_header_vta.imp_total   = T-Ped_header.imp_total.

/*===============================================================================================*/
/*                                PROCEDIMIENTOS                                                 */
/*===============================================================================================*/

PROCEDURE calcular_subtotales_detalle:

          /* --------------------------------------------------- */
          /*     Halla el total bruto del renglón de factura     */
          /* --------------------------------------------------- */

    IF Articulo.extendida
    THEN DO:
       T-Ped_detalle.subtotal_general = 
           ( IF T-Ped_detalle.cantidad <> 0 
                THEN ROUND( T-Ped_detalle.precio * T-Ped_detalle.cantidad , 2 )
                ELSE T-Ped_detalle.precio ).
    END.
    ELSE DO:
       T-Ped_detalle.subtotal_general = 
           ( IF T-Ped_detalle.a_granel 
                THEN ROUND( T-Ped_detalle.precio * T-Ped_detalle.granel   , 2 )
                ELSE ROUND( T-Ped_detalle.precio * T-Ped_detalle.cantidad , 2 ) ).
    
    END.            

          /* --------------------------------------------------- */
          /* Descuenta las bonificaciones del renglon de detalle */
          /* generando el importe BRUTO del renglon.             */
          /* --------------------------------------------------- */

    T-Ped_detalle.subtotal_bruto = T-Ped_detalle.subtotal_general.
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
    FOR EACH T-Ped_header-bon OF T-Ped_header:
    
        v-aux_importe  = ROUND(T-Ped_detalle.subtotal_neto * T-Ped_header-bon.porcentaje / 100, 2 ).
        T-Ped_header-bon.importe    = T-Ped_header-bon.importe     + v-aux_importe.
        T-Ped_detalle.subtotal_neto = T-Ped_detalle.subtotal_neto  - v-aux_importe.

    END.

END PROCEDURE.

PROCEDURE aplicar_impuestos:

    FIND Familia_impositiva OF Articulo NO-LOCK.

    FOR EACH Impuesto_condicion OF  Familia_impositiva 
       WHERE Impuesto_condicion.cdg_condiva = T-Ped_header.cdg_condiva
         AND Impuesto_condicion.cdg_empresa = T-Ped_header.cdg_empresa 
         AND Impuesto_condicion.fch_desde <= T-Ped_header.fecha_iva
         AND Impuesto_condicion.fch_hasta >= T-Ped_header.fecha_iva
         AND CAN-DO(Impuesto_condicion.lista_provincias,T-Ped_header.cdg_provincia)
         NO-LOCK, Impuesto OF Impuesto_condicion NO-LOCK:
              
          FIND FIRST  Cliente_excencion OF Cliente 
                      WHERE Cliente_excencion.cdg_empresa  = T-Ped_header.cdg_empresa
                        AND Cliente_excencion.cdg_impuesto = Impuesto_condicion.cdg_impuesto
                        AND Cliente_excencion.fch_desde <= T-Ped_header.fecha_iva
                        AND Cliente_excencion.fch_hasta >= T-Ped_header.fecha_iva NO-LOCK NO-ERROR.
      
          IF NOT AVAILABLE Cliente_excencion
             THEN x-tasa = Impuesto_condicion.tasa.
             ELSE x-tasa = Impuesto_condicion.tasa * ( 1 - Cliente_excencion.prc_excencion  / 100.0 ).
          
          CREATE T-Ped_detalle_impuesto.
          ASSIGN T-Ped_detalle_impuesto.nro_pedido  = T-Ped_detalle.nro_pedido
                 T-Ped_detalle_impuesto.nro_linea    = T-Ped_detalle.nro_linea
                 T-Ped_detalle_impuesto.cdg_impuesto = Impuesto_condicion.cdg_impuesto
                 T-Ped_detalle_impuesto.tasa         = x-tasa
                 T-Ped_detalle_impuesto.importe      = T-Ped_detalle.subtotal_neto * x-tasa / 100.0.

          IF Impuesto.es_iva
          THEN DO:
              T-Ped_detalle.subtotal_bruto_cf = T-Ped_detalle.subtotal_bruto + T-Ped_detalle_impuesto.importe.             
              T-Ped_detalle.precio_cf = T-Ped_detalle.precio * ( 1 + x-tasa / 100.0 ).
          END.
                  
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
               ASSIGN
                      T-Sub_detalle_vta.cdg_empresa    = T-Ped_header.cdg_empresa
                      T-Sub_detalle_vta.tip_comprob    = T-Ped_header.tip_comprob
                      T-Sub_detalle_vta.prf_comprob    = T-Ped_header.prf_comprob
                      T-Sub_detalle_vta.nro_comprob    = T-Ped_header.nro_comprob
                      T-Sub_detalle_vta.nro_cuenta     = Impuesto.nro_cuenta
                      T-Sub_detalle_vta.tipo           = 2.
          END.

          T-Sub_detalle_vta.valor = T-Sub_detalle_vta.valor  + T-Ped_detalle_impuesto.importe.
    
    END.
    
END PROCEDURE.

PROCEDURE crear_imputacion_directa:

    FIND FIRST Familia_cuenta OF Familia_articulo 
         WHERE Familia_cuenta.cdg_imputacion = T-Ped_header.cdg_imputacion 
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
       ASSIGN
              T-Sub_detalle_vta.cdg_empresa    = T-Ped_header.cdg_empresa
              T-Sub_detalle_vta.tip_comprob    = T-Ped_header.tip_comprob
              T-Sub_detalle_vta.prf_comprob    = T-Ped_header.prf_comprob
              T-Sub_detalle_vta.nro_comprob    = T-Ped_header.nro_comprob
              T-Sub_detalle_vta.nro_cuenta     = Familia_cuenta.nro_cuenta
              T-Sub_detalle_vta.nro_entidad    = T-Ped_header.nro_entidad
              T-Sub_detalle_vta.nro_obra       = T-Ped_detalle.nro_obra
              T-Sub_detalle_vta.tipo           = 1.
    END.

    T-Sub_detalle_vta.valor = T-Sub_detalle_vta.valor + T-Ped_detalle.subtotal_neto.

END PROCEDURE.

PROCEDURE crear_imputacion_distribuida:

    FIND FIRST Familia_cuenta OF Familia_articulo 
         WHERE Familia_cuenta.cdg_imputacion = {1}Ped_header.cdg_imputacion 
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
           ASSIGN
                  T-Sub_detalle_vta.cdg_empresa    = T-Ped_header.cdg_empresa
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

END PROCEDURE.
