PROCEDURE calcular_asiento_contable:
   
   FIND Tipocomprobante OF T-Fac_header_prv NO-LOCK.    
        
   FIND Proveedor OF T-Sub_header_prv NO-LOCK NO-ERROR.
   CREATE T-Asn_header.
   ASSIGN T-Asn_header.anulado           = NO
          T-Asn_header.cdg_empresa       = T-Sub_header_prv.cdg_empresa
          T-Asn_header.cdg_sigla-sic     = "CXP"
          T-Asn_header.nro_idcabecera    = T-Fac_header_prv.nro_facprov 
          T-Asn_header.tabla_comprobante = "Fac_header_prv"
          T-Asn_header.reexpresa_saldos  = Tipocomprobante.reexpresa_movimiento
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
              T-Asn_detalle.debito         = Sub_header_prv.imp_total
              T-Asn_detalle.cambio         = Sub_header_prv.cambio
              T-Asn_detalle.cambio_dolar   = 1
              T-Asn_detalle.fecha_mayor    = T-Asn_header.fecha
              T-Asn_detalle.nro_asiento    = T-Asn_header.nro_asiento
              T-Asn_detalle.nro_cuenta     = Sub_header_prv.nro_cuenta
              T-Asn_detalle.nro_entidad    = Sub_header_prv.nro_entidad
              T-Asn_detalle.nro_linea      = T-Asn_header.ultima_linea
              T-Asn_detalle.nro_moneda     = Sub_header_prv.nro_moneda
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
       ASSIGN T-Asn_header.ultima_linea    = T-Asn_header.ultima_linea + 1
              T-Asn_detalle.cdg_empresa    = T-Asn_header.cdg_empresa
              T-Asn_detalle.fecha_mayor    = T-Asn_header.fecha
              T-Asn_detalle.leyen_detalle  = T-Asn_header.leyenda
              T-Asn_detalle.nro_asiento    = T-Asn_header.nro_asiento
              T-Asn_detalle.nro_cuenta     = Sub_detalle_prv.nro_cuenta
              T-Asn_detalle.nro_entidad    = Sub_detalle_prv.nro_entidad
              T-Asn_detalle.nro_linea      = T-Asn_header.ultima_linea
              T-Asn_detalle.nro_moneda     = Sub_header_prv.nro_moneda
              T-Asn_detalle.nro_obra       = Sub_detalle_prv.nro_obra  
              T-Asn_detalle.nro_subcuenta  = 0
              T-Asn_detalle.cambio         = Sub_header_prv.cambio
              T-Asn_detalle.cambio_dolar   = 1.

       IF Tipocomprobante.debita
       THEN DO:
           T-Asn_detalle.credito  = Sub_detalle_prv.valor.
           T-Asn_detalle.debito   = 0.
       END.
       ELSE DO:
           T-Asn_detalle.credito  = 0.
           T-Asn_detalle.debito   = Sub_detalle_prv.valor.
       END.


   END. /* De los detalles de subdiario de Compras */
       
   IF NOT Tipocomprobante.debita /* Acreditamos encabezado si corresponde */
   THEN DO: 
      
       CREATE T-Asn_detalle.
       ASSIGN T-Asn_header.ultima_linea    = T-Asn_header.ultima_linea + 1
              T-Asn_detalle.cdg_empresa    = T-Asn_header.cdg_empresa
              T-Asn_detalle.credito        = Sub_header_prv.imp_total
              T-Asn_detalle.debito         = 0

              T-Asn_detalle.cambio         = Sub_header_prv.cambio
              T-Asn_detalle.cambio_dolar   = 1

              T-Asn_detalle.fecha_mayor    = T-Asn_header.fecha
              T-Asn_detalle.leyen_detalle  = T-Asn_header.leyenda
              T-Asn_detalle.nro_asiento    = T-Asn_header.nro_asiento
              T-Asn_detalle.nro_cuenta     = Sub_header_prv.nro_cuenta
              T-Asn_detalle.nro_entidad    = Sub_header_prv.nro_entidad
              T-Asn_detalle.nro_linea      = T-Asn_header.ultima_linea
              T-Asn_detalle.nro_moneda     = Sub_header_prv.nro_moneda
              T-Asn_detalle.nro_obra       = 0
              T-Asn_detalle.nro_subcuenta  = 0.

    END.     

    IF T-Asn_header.reexpresa_saldos
        THEN RUN reexpresar_asiento.

    FOR EACH T-Asn_detalle OF T-Asn_header:
        RUN acumular_debcred.
    END.

    FOR EACH T-Asn_totales OF T-Asn_header
        WHERE T-Asn_totales.tot_debitos <> T-Asn_totales.tot_creditos
          AND T-Asn_totales.reexpresion:

        RUN planchar_redondeos.

    END. 

    T-Sub_header_prv.contable = YES.

END.

PROCEDURE acumular_debcred:

   FIND T-Asn_totales
       WHERE T-Asn_totales.nro_asiento = T-Asn_header.nro_asiento
         AND T-Asn_totales.nro_moneda  = T-Asn_detalle.nro_moneda 
         AND T-Asn_totales.reexpresion = T-Asn_detalle.reexpresion 
             NO-ERROR.

   IF NOT AVAILABLE T-Asn_totales
   THEN DO:
       CREATE T-Asn_totales.
       ASSIGN T-Asn_totales.nro_asiento = T-Asn_header.nro_asiento 
              T-Asn_totales.nro_moneda = T-Asn_detalle.nro_moneda
              T-Asn_totales.reexpresion = T-Asn_detalle.reexpresion.
   END.

   ASSIGN T-Asn_totales.tot_debitos  = T-Asn_totales.tot_debitos  + T-Asn_detalle.debito
          T-Asn_totales.tot_creditos = T-Asn_totales.tot_creditos + T-Asn_detalle.credito
          T-Asn_totales.diferencia = T-Asn_totales.tot_debitos - T-Asn_totales.tot_creditos.

END PROCEDURE.

PROCEDURE reexpresar_asiento :

   DEFINE VARIABLE x-cotiza_origen AS DATE.

   FOR EACH T-Asn_detalle OF T-Asn_header WHERE NOT T-Asn_detalle.reexpresion:

      /* ----------------------------------------------------------------------------- */
      /* Recorre las monedas para las cuales la cuenta del movimiento reexpresa saldos */
      /* ----------------------------------------------------------------------------- */
    
      FOR EACH  Cuenta-moneda 
          WHERE Cuenta-moneda.nro_cuenta = T-Asn_detalle.nro_cuenta 
            AND Cuenta-moneda.reexpresa_saldos: 
    
          /* ---------------------------------------- */
          /* Busca la reexpresion en esta moneda.     */
          /* ---------------------------------------- */
    
          FIND T-Reexpresion 
               WHERE T-Reexpresion.nro_asiento = T-Asn_detalle.nro_asiento
                 AND T-Reexpresion.nro_linea   = T-Asn_detalle.nro_linea
                 AND T-Reexpresion.nro_moneda  = Cuenta-moneda.nro_moneda
                 AND T-Reexpresion.reexpresion
                     EXCLUSIVE-LOCK NO-ERROR.
    
          /* ---------------------------------------- */
          /* Si no esta, la crea, asignando el cambio */
          /* ---------------------------------------- */
    
          IF NOT AVAILABLE T-Reexpresion
          THEN DO:
              CREATE T-Reexpresion.
              BUFFER-COPY T-Asn_detalle TO T-Reexpresion
                    ASSIGN T-Reexpresion.nro_moneda  = Cuenta-moneda.nro_moneda
                           T-Reexpresion.reexpresion = YES.
              
              IF Cuenta-moneda.nro_moneda <> T-Asn_header.nro_moneda
              THEN DO:     
                  FIND Moneda OF T-Reexpresion NO-LOCK.
                  RUN cotizar_moneda.p  ( INPUT   Moneda.cdg_moneda, 
                                          INPUT   T-Asn_header.cdg_empresa,  
                                          INPUT   T-Asn_header.fecha, 
                                          OUTPUT  T-Reexpresion.cambio, 
                                          OUTPUT  x-cotiza_origen).
                  
              END.
    
          END.           
    
          IF Cuenta-moneda.nro_moneda <> T-Asn_header.nro_moneda
          THEN DO:     
              ASSIGN T-Reexpresion.debito  = T-Asn_detalle.debito  /  T-Reexpresion.cambio * T-Asn_detalle.cambio
                     T-Reexpresion.credito = T-Asn_detalle.credito /  T-Reexpresion.cambio * T-Asn_detalle.cambio.
          END.
          ELSE DO:
              ASSIGN T-Reexpresion.debito  = T-Asn_detalle.debito  
                     T-Reexpresion.credito = T-Asn_detalle.credito
                     T-Reexpresion.cambio  = T-Asn_detalle.cambio.
          END.
    
      END.

   END.

END PROCEDURE.

PROCEDURE planchar_redondeos:

   DEFINE VARIABLE v-saldo_diferencia  AS DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Diferencia".

   v-saldo_diferencia = ABS(T-Asn_totales.tot_debitos - T-Asn_totales.tot_creditos).

   IF v-saldo_diferencia < 1
   THEN DO:

       DO WHILE v-saldo_diferencia <> 0:

           FOR EACH T-Asn_detalle OF T-Asn_header 
               WHERE T-Asn_detalle.reexpresion 
                 AND T-Asn_detalle.nro_moneda = T-Asn_totales.nro_moneda
                     BY T-Asn_detalle.debito + T-Asn_detalle.credito DESCENDING WHILE v-saldo_diferencia <> 0:

               IF T-Asn_totales.tot_debitos > T-Asn_totales.tot_creditos 
               THEN DO:
                   IF T-Asn_detalle.debito <> 0
                       THEN ASSIGN T-Asn_detalle.debito = T-Asn_detalle.debito - 0.01
                                   T-Asn_totales.tot_debitos = T-Asn_totales.tot_debitos - 0.01.
                       ELSE ASSIGN T-Asn_detalle.credito = T-Asn_detalle.credito + 0.01
                                   T-Asn_totales.tot_creditos = T-Asn_totales.tot_creditos + 0.01.
    
                END.
                ELSE DO:
                    IF T-Asn_detalle.debito <> 0
                        THEN ASSIGN T-Asn_detalle.debito = T-Asn_detalle.debito + 0.01
                                    T-Asn_totales.tot_debitos = T-Asn_totales.tot_debitos + 0.01.
                        ELSE ASSIGN T-Asn_detalle.credito = T-Asn_detalle.credito - 0.01
                                    T-Asn_totales.tot_creditos = T-Asn_totales.tot_creditos - 0.01.
                END.
            
                v-saldo_diferencia = v-saldo_diferencia - 0.01.
    
           END.

       END.
    
       T-Asn_totales.diferencia = T-Asn_totales.tot_debitos - T-Asn_totales.tot_creditos.

   END.

END PROCEDURE.
