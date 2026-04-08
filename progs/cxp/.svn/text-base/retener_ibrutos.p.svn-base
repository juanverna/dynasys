/*=================================================================================*/
/*        HACE EL CALCULO DE LAS RETENCIONES DE INGRESOS BRUTOS PARA TODOS LOS     */
/*        DOCUMENTOS CANCELADOS EN UNA O/PAGO                                      */
/*=================================================================================*/

/*=================================================================================*/
/*                              TABLAS TEMPORALES                                  */
/*=================================================================================*/

DEFINE TEMP-TABLE T-Opg_header              NO-UNDO LIKE Opg_header.
DEFINE TEMP-TABLE T-Opg_detalle             NO-UNDO LIKE Opg_detalle.
DEFINE TEMP-TABLE T-Caj_header              NO-UNDO LIKE Caj_header.    
DEFINE TEMP-TABLE T-Caj_detalle             NO-UNDO LIKE Caj_detalle.    
DEFINE TEMP-TABLE T-Pagos_x_retibr          NO-UNDO LIKE Pagos_x_retibr.    
DEFINE TEMP-TABLE T-Pagos_x_retibr_det      NO-UNDO LIKE Pagos_x_retibr_det.    
DEFINE TEMP-TABLE T-Certificado_ibr         NO-UNDO LIKE Certificado_ibr. 
DEFINE TEMP-TABLE T-Cert_ibr-detalle        NO-UNDO LIKE Cert_ibr-detalle.

/*=================================================================================*/
/*                                 PARAMETROS                                      */
/*=================================================================================*/

DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Opg_header.      
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Opg_detalle.     
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Caj_header.      
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Caj_detalle.     
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Pagos_x_retibr.     
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Pagos_x_retibr_det.     
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Certificado_ibr.     
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Cert_ibr-detalle. 

/*=================================================================================*/
/*                                 VARIABLES                                       */
/*=================================================================================*/

DEFINE VARIABLE x-pago_neto     LIKE Fac_detalle_prv.subtotal_neto.
DEFINE VARIABLE x-subtotal_neto LIKE Fac_detalle_prv.subtotal_neto.
DEFINE VARIABLE x-imp_total     LIKE Fac_header_prv.imp_total.
DEFINE VARIABLE x-factor_cambio AS DECIMAL DECIMALS 4.

/*=================================================================================*/
/*                              FRAMES Y BUFFERS                                   */
/*=================================================================================*/

DEFINE BUFFER B-Fac_header_prv FOR Fac_header_prv.

DEFINE VARIABLE aux_importe AS DECIMAL.
DEFINE VARIABLE x-alicuota  AS DECIMAL.
DEFINE VARIABLE a_retener   AS DECIMAL.

/*=================================================================================*/
/*                                 VARIABLES                                       */
/*=================================================================================*/

DEFINE VARIABLE v_con              AS CHARACTER FORMAT "X(45)".
DEFINE VARIABLE v_val              AS DECIMAL   FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE neto_pago          AS DECIMAL   FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE total_retencion    AS DECIMAL   FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE neto_imponible     AS DECIMAL.
DEFINE VARIABLE v-alicuota         AS DECIMAL.

/*=================================================================================*/
/*                              BLOQUE PRINCIPAL                                   */
/*=================================================================================*/

{findempresa.i}

FIND FIRST T-Opg_header EXCLUSIVE-LOCK.
FIND Proveedor  OF T-Opg_header NO-LOCK.
FIND FIRST T-Caj_header EXCLUSIVE-LOCK.
FIND Empresa OF T-Opg_header NO-LOCK.
FIND Tipocomprobante OF T-Opg_header NO-LOCK.

EMPTY TEMP-TABLE T-Pagos_x_retibr.
EMPTY TEMP-TABLE T-Pagos_x_retibr_det.
EMPTY TEMP-TABLE T-Certificado_ibr.     
EMPTY TEMP-TABLE T-Cert_ibr-detalle. 

                         /* Halla las retenciones a efectuar por actividad */

FOR EACH T-Opg_detalle   OF T-Opg_header NO-LOCK,
    FIRST Tipocomprobante OF T-Opg_header
    WHERE Tipocomprobante.debita = TRUE
    AND Tipocomprobante.es_monetario = TRUE NO-LOCK,
    FIRST Fac_header_prv OF Proveedor
         WHERE Fac_header_prv.cdg_empresa = T-Opg_header.cdg_empresa
           AND Fac_header_prv.tip_comprob = T-Opg_detalle.tip_cancela
           AND Fac_header_prv.prf_comprob = T-Opg_detalle.prf_cancela
           AND Fac_header_prv.nro_comprob = T-Opg_detalle.nro_cancela NO-LOCK,
         EACH Fac_detalle_prv OF Fac_header_prv, 
         FIRST Articulo OF Fac_detalle_prv,
         FIRST Familia_retibr OF Articulo, 
         FIRST Famretibr_regimen OF Familia_retibr
               WHERE Famretibr_regimen.cdg_condiva = T-Opg_header.cdg_condiva
                     BREAK BY Famretibr_regimen.cdg_tiporetibr:

    /* Halla el total pagado para esta actividad a efectos de acumular esta retención */
           
    FIND FIRST T-Pagos_x_retibr 
         WHERE T-Pagos_x_retibr.cdg_tiporetibr = Famretibr_regimen.cdg_tiporetibr NO-ERROR.
  
    IF NOT AVAILABLE T-Pagos_x_retibr
    THEN DO:
       CREATE T-Pagos_x_retibr.
       ASSIGN T-Pagos_x_retibr.cdg_tiporetibr =  Famretibr_regimen.cdg_tiporetibr.
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

    T-Pagos_x_retibr.imp_estepago = T-Pagos_x_retibr.imp_estepago + x-pago_neto.

    FIND FIRST T-Pagos_x_retibr_det
         WHERE T-Pagos_x_retibr_det.tip_comprob     = Fac_header_prv.tip_comprob
           AND T-Pagos_x_retibr_det.prf_comprob     = Fac_header_prv.prf_comprob
           AND T-Pagos_x_retibr_det.nro_comprob     = Fac_header_prv.nro_comprob
           AND T-Pagos_x_retibr_det.nro_vencimiento = T-Opg_detalle.nro_cancela
           AND T-Pagos_x_retibr_det.cdg_tiporetibr  = T-Pagos_x_retibr.cdg_tiporetibr
               NO-ERROR.

    IF NOT AVAILABLE T-Pagos_x_retibr_det
    THEN DO:
        CREATE T-Pagos_x_retibr_det.
        BUFFER-COPY Fac_header_prv TO T-Pagos_x_retibr_det
            ASSIGN T-Pagos_x_retibr_det.cdg_tiporetibr = T-Pagos_x_retibr.cdg_tiporetibr
                   T-Pagos_x_retibr_det.nro_vencimiento = T-Opg_detalle.nro_vencimiento.
    END.

    ASSIGN T-Pagos_x_retibr_det.base_imponible = T-Pagos_x_retibr_det.base_imponible + x-pago_neto.


END.  /* De recorrer el detalle para calcular retenciones de Ingresos Brutos */

                /* -------------------------------------------------- */
                /* Compara, por actividad, los acumulados con el pago */
                /* para hacer el calculo de las retenciones           */
                /* -------------------------------------------------- */

FOR EACH T-Pagos_x_retibr, Tipo_retibr OF T-Pagos_x_retibr  
         BY T-Pagos_x_retibr.cdg_tiporetibr:

    RUN retener_ibr_monto.p (INPUT  T-Pagos_x_retibr.cdg_tiporetibr,
                             INPUT  T-Opg_header.fecha,
                             INPUT  T-Pagos_x_retibr.imp_estepago,
                             INPUT  Proveedor.convenio_sino,
                             INPUT  YES, /* activa importe minimo */
                             OUTPUT T-Pagos_x_retibr.imp_retenido,
                             OUTPUT T-Pagos_x_retibr.alicuota).


    FIND FIRST Proveedor_excen_ibr OF Proveedor
         WHERE Proveedor_excen_ibr.cdg_empresa     = T-Opg_header.cdg_empresa 
           AND Proveedor_excen_ibr.cdg_tiporetibr  = T-Pagos_x_retibr.cdg_tiporetibr
           AND Proveedor_excen_ibr.fch_desde       <= T-Opg_header.fecha
           AND Proveedor_excen_ibr.fch_hasta       >= T-Opg_header.fecha
               NO-LOCK NO-ERROR.

    IF AVAILABLE Proveedor_excen_ibr 
        THEN ASSIGN T-Pagos_x_retibr.prc_excencion = Proveedor_excen_ibr.prc_excencion
                    T-Pagos_x_retibr.imp_retenido = T-Pagos_x_retibr.imp_retenido *
                                            ( 1 - Proveedor_excen_ibr.prc_excencion / 100 ).

    FOR EACH T-Pagos_x_retibr_det WHERE T-Pagos_x_retibr_det.cdg_tiporetibr = T-Pagos_x_retibr.cdg_tiporetibr:
        ASSIGN T-Pagos_x_retibr_det.alicuota = T-Pagos_x_retibr.alicuota
               T-Pagos_x_retibr_det.tot_retenido = T-Pagos_x_retibr_det.base_imponible * T-Pagos_x_retibr_det.alicuota / 100.
    END.

         /* Chequea que exista el item de caja */
             
    FIND FIRST T-Caj_detalle OF T-Caj_header 
         WHERE T-Caj_detalle.cdg_rubro = Tipo_retibr.cdg_rubro 
               EXCLUSIVE-LOCK NO-ERROR.

    IF T-Pagos_x_retibr.imp_retenido > 0 
    THEN DO:

                 /* Si hay que retener y no esta, lo crea */

       IF NOT AVAILABLE T-Caj_detalle
       THEN DO:

           CREATE T-Caj_detalle.
           ASSIGN T-Caj_header.ultima_linea      = T-Caj_header.ultima_linea + 1
                  T-Caj_detalle.nro_transaccion  = T-Caj_header.nro_transaccion
                  T-Caj_detalle.nro_linea        = T-Caj_header.ultima_linea
                  T-Caj_detalle.tipo_mov         = T-Caj_header.tipo_mov
                  T-Caj_detalle.cdg_rubro        = Tipo_retibr.cdg_rubro.
                
           CREATE T-Certificado_ibr.
           ASSIGN T-Certificado_ibr.cdg_empresa      = T-Opg_header.cdg_empresa
                  T-Certificado_ibr.cdg_tiporetibr   = T-Pagos_x_retibr.cdg_tiporetibr
                  T-Certificado_ibr.fecha_emision    = T-Opg_header.fecha
                  T-Certificado_ibr.imp_retenido     = T-Pagos_x_retibr.imp_retenido
                  T-Certificado_ibr.nro_linea        = T-Caj_detalle.nro_linea
                  T-Certificado_ibr.nro_proveedor    = T-Opg_header.nro_proveedor
                  T-Certificado_ibr.nro_transaccion  = T-Caj_detalle.nro_transaccion
                  T-Certificado_ibr.nro_certifibr    = T-Caj_detalle.nro_linea
                  T-Caj_detalle.observacion          = "Nro.Cert.:" + STRING(T-Certificado_ibr.nro_certifibr,"999999").
            
           FOR EACH T-Pagos_x_retibr_det WHERE T-Pagos_x_retibr_det.nro_ordpago = T-Pagos_x_retibr.nro_ordpago NO-LOCK:
                        
               CREATE T-Cert_ibr-detalle.
               ASSIGN T-Cert_ibr-detalle.imp_retenido    = T-Pagos_x_retibr_det.tot_retenido
                      T-Cert_ibr-detalle.base_imponible  = T-Pagos_x_retibr_det.base_imponible
                      T-Cert_ibr-detalle.alicuota        = T-Pagos_x_retibr_det.alicuota
                      T-Cert_ibr-detalle.nro_certifibr   = T-Certificado_ibr.nro_certifibr
                      T-Cert_ibr-detalle.nro_comprob     = T-Pagos_x_retibr_det.nro_comprob
                      T-Cert_ibr-detalle.prf_comprob     = T-Pagos_x_retibr_det.prf_comprob
                      T-Cert_ibr-detalle.tip_comprob     = T-Pagos_x_retibr_det.tip_comprob
                      T-Cert_ibr-detalle.nro_vencimiento = T-Pagos_x_retibr_det.nro_vencimiento.
                    /* Cert_ibr-detalle.nro_secuencia   = 0.*/
            
           END. /* Termina de recorrer el detalle de Opg para los certificados. */

       END.
 
       ASSIGN T-Caj_header.ingreso = T-Caj_header.ingreso - T-Caj_detalle.importe.        /* Resta importe anterior */
              T-Caj_detalle.importe = T-Pagos_x_retibr.imp_retenido.               /* Asigna nuevo importe   */
              T-Caj_header.ingreso = T-Caj_header.ingreso + T-Caj_detalle.importe.        /* Suma  importe actual   */

    END. 
    ELSE DO: 
    
             /* Si no hay que retener y esta, lo elimina */

       IF AVAILABLE T-Caj_detalle
       THEN DO:
           ASSIGN T-Caj_header.ingreso = T-Caj_header.ingreso - T-Caj_detalle.importe. /* Resta importe anterior */
           DELETE T-Caj_detalle.
       END.
       
    END.

END.

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
   

END PROCEDURE.           
