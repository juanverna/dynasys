/*=================================================================================*/
/*             HACE EL CALCULO DE LAS RETENCIONES DE GANANCIAS                     */
/*=================================================================================*/

/*=================================================================================*/
/*                              TABLAS TEMPORALES                                  */
/*=================================================================================*/

DEFINE TEMP-TABLE T-Opg_header              NO-UNDO LIKE Opg_header.
DEFINE TEMP-TABLE T-Opg_detalle             NO-UNDO LIKE Opg_detalle.
DEFINE TEMP-TABLE T-Caj_header              NO-UNDO LIKE Caj_header.    
DEFINE TEMP-TABLE T-Caj_detalle             NO-UNDO LIKE Caj_detalle.    
DEFINE TEMP-TABLE T-Pagos_x_actividad       NO-UNDO LIKE Pagos_x_actividad.    
DEFINE TEMP-TABLE T-Pagos_x_actividad_det   NO-UNDO LIKE Pagos_x_actividad_det.    
DEFINE TEMP-TABLE T-Certificado_gan         NO-UNDO LIKE Certificado_gan. 
DEFINE TEMP-TABLE T-Cert_gan-detalle        NO-UNDO LIKE Cert_gan-detalle. 

/*=================================================================================*/
/*                                 PARAMETROS                                      */
/*=================================================================================*/

DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Opg_header.      
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Opg_detalle.     
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Caj_header.      
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Caj_detalle.     
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Pagos_x_actividad.     
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Pagos_x_actividad_det.    
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Certificado_gan. 
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Cert_gan-detalle. 

/*=================================================================================*/
/*                                VARIABLES                                        */
/*=================================================================================*/

DEFINE VARIABLE x-pago_neto     LIKE Fac_detalle_prv.subtotal_neto.
DEFINE VARIABLE x-subtotal_neto LIKE Fac_detalle_prv.subtotal_neto.
DEFINE VARIABLE x-imp_total     LIKE Fac_header_prv.imp_total.
DEFINE VARIABLE x-factor_cambio AS DECIMAL DECIMALS 4.
DEFINE VARIABLE x-prc_excencion LIKE Proveedor_excen_gan.prc_excencion.

/*=================================================================================*/
/*                              FRAMES Y BUFFERS                                   */
/*=================================================================================*/


/*=================================================================================*/
/*                              BLOQUE PRINCIPAL                                   */
/*=================================================================================*/

FIND FIRST T-Opg_header EXCLUSIVE-LOCK.
FIND Proveedor  OF T-Opg_header NO-LOCK.
FIND FIRST T-Caj_header EXCLUSIVE-LOCK.
FIND Empresa OF T-Opg_header NO-LOCK.
FIND Tipocomprobante OF T-Opg_header NO-LOCK.

EMPTY TEMP-TABLE T-Pagos_x_actividad.
EMPTY TEMP-TABLE T-Certificado_gan. 

   /* Recorre el detalle de la O/P y halla los totales a pagar por cada actividad */

T-Opg_header.imp_neto = 0.
FOR EACH T-Opg_detalle   OF T-Opg_header NO-LOCK,
    EACH Tipocomprobante OF T-Opg_header
    WHERE Tipocomprobante.debita = TRUE
    AND Tipocomprobante.es_monetario = TRUE NO-LOCK,
    FIRST Fac_header_prv OF Proveedor
         WHERE Fac_header_prv.cdg_empresa = T-Opg_header.cdg_empresa
           AND Fac_header_prv.tip_comprob = T-Opg_detalle.tip_cancela
           AND Fac_header_prv.prf_comprob = T-Opg_detalle.prf_cancela
           AND Fac_header_prv.nro_comprob = T-Opg_detalle.nro_cancela NO-LOCK,
         FIRST Moneda OF Fac_header_prv NO-LOCK,
         EACH Fac_detalle_prv OF Fac_header_prv, 
         FIRST Articulo OF Fac_detalle_prv,
         FIRST Familia_ganancias OF Articulo, 
         FIRST Famganancias_regimen OF Familia_ganancias
               WHERE Famganancias_regimen.cdg_condiva = T-Opg_header.cdg_condiva
                     BREAK BY Famganancias_regimen.cdg_tiporetgan:

    FIND T-Pagos_x_actividad 
        WHERE T-Pagos_x_actividad.cdg_tiporetgan =  Famganancias_regimen.cdg_tiporetgan
              NO-ERROR.
    IF NOT AVAILABLE T-Pagos_x_actividad
    THEN DO:
         CREATE T-Pagos_x_actividad.
         ASSIGN T-Pagos_x_actividad.cdg_tiporetgan =  Famganancias_regimen.cdg_tiporetgan.
    END.           

    ASSIGN x-subtotal_neto = Fac_detalle_prv.subtotal_neto * Fac_header_prv.cambio
           x-factor_cambio = ( T-Opg_detalle.imp_pesos + T-Opg_detalle.difcambio ) / T-Opg_detalle.imp_pesos.

    IF T-Opg_detalle.importe = Fac_header_prv.imp_total
    THEN DO:
        x-pago_neto = x-subtotal_neto * x-factor_cambio.
    END.
    ELSE DO:
        x-pago_neto = x-subtotal_neto * x-factor_cambio * ROUND(  T-Opg_detalle.importe / Fac_header_prv.imp_total , 4).
    END.

    T-Pagos_x_actividad.imp_estepago = T-Pagos_x_actividad.imp_estepago + x-pago_neto.

    CREATE T-Pagos_x_actividad_det.
    BUFFER-COPY T-Pagos_x_actividad TO T-Pagos_x_actividad_det
        ASSIGN T-Pagos_x_actividad_det.tip_comprob      = Fac_header_prv.tip_comprob    
               T-Pagos_x_actividad_det.prf_comprob      = Fac_header_prv.prf_comprob    
               T-Pagos_x_actividad_det.nro_comprob      = Fac_header_prv.nro_comprob    
               T-Pagos_x_actividad_det.nro_vencimiento  = T-Opg_detalle.nro_vencimiento
               T-Pagos_x_actividad_det.pago_neto        = x-pago_neto.

    IF LAST-OF(Famganancias_regimen.cdg_tiporetgan)
    THEN DO:

        T-Opg_header.imp_neto = T-Opg_header.imp_neto + T-Pagos_x_actividad.imp_estepago.

        FIND FIRST Acumulado_pagos OF Proveedor
             WHERE Acumulado_pagos.cdg_empresa  = T-Opg_header.cdg_empresa
               AND Acumulado_pagos.ano          = YEAR(T-Opg_header.fecha)
               AND Acumulado_pagos.mes          = MONTH(T-Opg_header.fecha) 
               AND Acumulado_pagos.cdg_tiporetgan = Famganancias_regimen.cdg_tiporetgan
                   NO-LOCK NO-ERROR.

        IF AVAILABLE Acumulado_pagos 
        THEN DO:
            T-Pagos_x_actividad.tot_pagado   = Acumulado_pagos.total_pagado.
            T-Pagos_x_actividad.tot_retenido = Acumulado_pagos.total_retganan.
        END.          
        ELSE DO:
            T-Pagos_x_actividad.tot_pagado   = 0.
            T-Pagos_x_actividad.tot_retenido = 0.
        END.          

        T-Pagos_x_actividad.tot_a_pagar   = T-Pagos_x_actividad.tot_pagado + T-Pagos_x_actividad.imp_estepago.

        FIND Tipo_actividad OF T-Pagos_x_actividad NO-LOCK.
        FIND FIRST Rango_retgan OF Tipo_actividad 
             WHERE Rango_retgan.hasta_importe >= T-Pagos_x_actividad.tot_a_pagar 
               AND Rango_retgan.desde_importe <= T-Pagos_x_actividad.tot_a_pagar 
               AND Rango_retgan.desde_fecha   <= T-Opg_header.fecha         
               AND Rango_retgan.hasta_fecha   >= T-Opg_header.fecha
                   NO-LOCK.

        ASSIGN T-Pagos_x_actividad.imp_basico     = Rango_retgan.imp_basico
               T-Pagos_x_actividad.alicuota       = Rango_retgan.alicuota
               T-Pagos_x_actividad.hasta_importe  = Rango_retgan.hasta_importe
               T-Pagos_x_actividad.desde_importe  = Rango_retgan.desde_importe
               T-Pagos_x_actividad.base_imponible = T-Pagos_x_actividad.tot_a_pagar - Rango_retgan.desde_importe.

        T-Pagos_x_actividad.tot_a_retener = Rango_retgan.imp_basico +
                       ROUND(  T-Pagos_x_actividad.base_imponible *
                                    Rango_retgan.alicuota / 100 , 2 ).

        FIND FIRST Proveedor_excen_gan OF Proveedor
            WHERE Proveedor_excen_gan.cdg_empresa     = T-Opg_header.cdg_empresa 
              AND Proveedor_excen_gan.cdg_tiporetgan  = T-Pagos_x_actividad.cdg_tiporetgan
              AND Proveedor_excen_gan.fch_desde       <= T-Opg_header.fecha
              AND Proveedor_excen_gan.fch_hasta       >= T-Opg_header.fecha
                  NO-LOCK NO-ERROR.

        IF AVAILABLE Proveedor_excen_gan 
            THEN ASSIGN T-Pagos_x_actividad.prc_excencion = Proveedor_excen_gan.prc_excencion
                        T-Pagos_x_actividad.tot_a_retener = T-Pagos_x_actividad.tot_a_retener *
                                                            ( 1 - Proveedor_excen_gan.prc_excencion / 100 ).

        T-Pagos_x_actividad.imp_estareten  = T-Pagos_x_actividad.tot_a_retener - T-Pagos_x_actividad.tot_retenido.

        IF T-Pagos_x_actividad.imp_estareten > Tipo_actividad.imp_retmin
        THEN DO:

           FIND FIRST T-Caj_detalle OF T-Caj_header 
                WHERE T-Caj_detalle.cdg_rubro = Tipo_actividad.cdg_rubro 
                      EXCLUSIVE-LOCK NO-ERROR.

           IF NOT AVAILABLE T-Caj_detalle
           THEN DO:
              CREATE T-Caj_detalle.
              ASSIGN T-Caj_header.ultima_linea      = T-Caj_header.ultima_linea + 1
                     T-Caj_detalle.nro_transaccion  = T-Caj_header.nro_transaccion
                     T-Caj_detalle.nro_linea        = T-Caj_header.ultima_linea
                     T-Caj_detalle.tipo_mov         = T-Caj_header.tipo_mov
                     T-Caj_detalle.cdg_rubro        = Tipo_actividad.cdg_rubro.
           END.

           T-Caj_detalle.importe = T-Pagos_x_actividad.imp_estareten.               /* Asigna nuevo importe   */

           CREATE T-Certificado_gan.
           ASSIGN T-Certificado_gan.cdg_empresa              = T-Opg_header.cdg_empresa
                  T-Certificado_gan.cdg_tiporetgan           = T-Pagos_x_actividad.cdg_tiporetgan
                  T-Certificado_gan.fecha_emision            = T-Opg_header.fecha
                  T-Certificado_gan.nro_certifgan            = T-Caj_detalle.nro_linea
                  T-Certificado_gan.nro_linea                = T-Caj_detalle.nro_linea
                  T-Certificado_gan.nro_proveedor            = T-Opg_header.nro_proveedor
                  T-Certificado_gan.nro_transaccion          = T-Caj_detalle.nro_transaccion

                  T-Certificado_gan.imp_retenido             = T-Pagos_x_actividad.imp_estareten 
                  T-Certificado_gan.imp_pagado               = T-Pagos_x_actividad.imp_estepago
                  T-Certificado_gan.imp_basico               = T-Pagos_x_actividad.imp_basico
                  T-Certificado_gan.base_imponible           = T-Pagos_x_actividad.base_imponible
                  T-Certificado_gan.alicuota                 = T-Pagos_x_actividad.alicuota
                  T-Certificado_gan.imponible_anterior       = T-Pagos_x_actividad.tot_pagado
                  T-Certificado_gan.total_retenido_anterior  = T-Pagos_x_actividad.tot_retenido
                  T-Certificado_gan.no_sujeto_a_retencion    = T-Pagos_x_actividad.desde_importe

                  T-Caj_detalle.observacion                  = "Nro.Cert.:" + 
                                                              STRING(T-Certificado_gan.nro_certifgan,"999999") + " - " +
                                                              Tipo_actividad.nom_tipactiv.
           FOR EACH T-Pagos_x_actividad_det WHERE T-Pagos_x_actividad_det.cdg_tiporetgan = T-Pagos_x_actividad.cdg_tiporetgan:
               CREATE T-Cert_gan-detalle.
               BUFFER-COPY T-Pagos_x_actividad_det TO T-Cert_gan-detalle
                   ASSIGN T-Cert_gan-detalle.nro_certifgan = T-Certificado_gan.nro_certifgan.
           END.

        END. /* Del agregado de la retencion */
        ELSE DO: /* No hay retencion por no exceder el minimo */

           FIND FIRST T-Caj_detalle OF T-Caj_header 
                WHERE T-Caj_detalle.cdg_rubro = Tipo_actividad.cdg_rubro 
                      EXCLUSIVE-LOCK NO-ERROR.

           IF AVAILABLE T-Caj_detalle
           THEN DO:
               FOR EACH T-Certificado_gan OF T-Caj_detalle:
                   DELETE T-Certificado_gan.
               END.
              DELETE T-Caj_detalle.
           END.

           T-Pagos_x_actividad.imp_estareten = 0.

        END.

    END.           

END.    

OUTPUT TO "c:\sic-temp\retenganancias.txt".
PUT "Corrida:" TODAY "-" STRING(TIME,"HH:MM:SS") SKIP.
FOR EACH T-Pagos_x_actividad, Tipo_actividad OF T-Pagos_x_actividad BY T-Pagos_x_actividad.cdg_tiporetgan:
    DISPLAY T-Pagos_x_actividad EXCEPT nro_ordpago WITH 1 COLUMN SIDE-LABELS .
    PUT "---------------------" SKIP.
END.
OUTPUT CLOSE.

/*=================================================================================*/
/*                           P R O C E D I M I E N T O S                           */
/*=================================================================================*/

PROCEDURE SHOW_VAL:

   DEFINE INPUT PARAMETER c AS CHARACTER.
   DEFINE INPUT PARAMETER v AS DECIMAL.

   DEFINE VARIABLE k AS INTEGER.
   
   FIND LAST X_Calculo OF T-Opg_header NO-ERROR.
   IF AVAILABLE X_Calculo THEN k = X_Calculo.secuencia + 1.
                          ELSE k = 1.

   CREATE X_Calculo.
   ASSIGN X_Calculo.nro_ordpag = T-Opg_header.nro_ordpag
          X_Calculo.secuencia  = k
          X_Calculo.concepto   = c
          X_Calculo.importe    = v.
   
/*
   DISPLAY v_con v_val
           WITH FRAME aa.
   DOWN WITH FRAME aa.        
*/           
END PROCEDURE.           

