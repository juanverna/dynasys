/*=================================================================================*/
/*             HACE EL CALCULO DE LAS RETENCIONES DE I.V.A.                        */
/*=================================================================================*/

DEFINE TEMP-TABLE T-Opg_header              NO-UNDO LIKE Opg_header.
DEFINE TEMP-TABLE T-Opg_detalle             NO-UNDO LIKE Opg_detalle.
DEFINE TEMP-TABLE T-Caj_header              NO-UNDO LIKE Caj_header.    
DEFINE TEMP-TABLE T-Caj_detalle             NO-UNDO LIKE Caj_detalle.    
DEFINE TEMP-TABLE T-Pagos_x_retiva          NO-UNDO LIKE Pagos_x_retiva.    
DEFINE TEMP-TABLE T-Pagos_x_retiva_det      NO-UNDO LIKE Pagos_x_retiva_det.    
DEFINE TEMP-TABLE T-Certificado_iva         NO-UNDO LIKE Certificado_iva. 
DEFINE TEMP-TABLE T-Cert_iva-detalle        NO-UNDO LIKE Cert_iva-detalle.

/*=================================================================================*/
/*                                 PARAMETROS                                      */
/*=================================================================================*/

DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Opg_header.      
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Opg_detalle.     
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Caj_header.      
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Caj_detalle.     
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Pagos_x_retiva.     
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Pagos_x_retiva_det.     
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Certificado_iva.     
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Cert_iva-detalle. 

/*=================================================================================*/
/*                         VARIABLES, FRAMES Y BUFFERS                             */
/*=================================================================================*/

DEFINE BUFFER B-Fac_header_prv FOR Fac_header_prv.

DEFINE VARIABLE aux_importe AS DECIMAL.
DEFINE VARIABLE x-alicuota  AS DECIMAL.
DEFINE VARIABLE a_retener   AS DECIMAL.

/*=================================================================================*/
/*                               BLOQUE PRINCIPAL                                  */
/*=================================================================================*/

{findempresa.i}

FIND FIRST T-Opg_header EXCLUSIVE-LOCK.
FIND Proveedor  OF T-Opg_header NO-LOCK.
FIND FIRST T-Caj_header EXCLUSIVE-LOCK.
FIND Empresa OF T-Opg_header NO-LOCK.
FIND Tipocomprobante OF T-Opg_header NO-LOCK.

EMPTY TEMP-TABLE T-Pagos_x_retiva.
EMPTY TEMP-TABLE T-Pagos_x_retiva_det.

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
         FIRST Familia_retiva OF Articulo, 
         FIRST Famretiva_regimen OF Familia_retiva
               WHERE Famretiva_regimen.cdg_condiva = T-Opg_header.cdg_condiva
    BREAK BY Famretiva_regimen.cdg_tiporetiva:

    /* Arma una query para saber si el renglon de factura está afectado por el IVA */

    OPEN QUERY q-ivadetalle 
    FOR EACH Fac_detalle_prv_impuesto OF Fac_detalle_prv,
             FIRST Impuesto OF Fac_detalle_prv_impuesto WHERE Impuesto.es_iva
                   NO-LOCK.
    GET FIRST q-ivadetalle.

    IF AVAILABLE Fac_detalle_prv_impuesto /* El detalle de la factura tiene iva */
    THEN DO:

             /* Halla el importe neto del pago y la retencion correspondiente */
    
        
        RUN retener_iva_monto.p (INPUT  Famretiva_regimen.cdg_tiporetiva,
                                 INPUT  T-Opg_header.fecha,
                                 INPUT  Fac_detalle_prv_impuesto.importe,
                                 OUTPUT aux_importe,
                                 OUTPUT x-alicuota).

        a_retener = 0. 

        IF aux_importe <> 0
        THEN DO:
            CASE Proveedor.plib_iva:
               WHEN 100.0
               THEN DO:
                   a_retener = 0.
               END.
               WHEN 0.0
               THEN DO:
                   a_retener = aux_importe.
               END.
               OTHERWISE
               DO:
                   a_retener = ROUND( aux_importe * ( 1 - Proveedor.plib_iva / 100 ), 2).
               END.
            END CASE.

            IF a_retener <> 0
            THEN DO:
                FIND T-Pagos_x_retiva 
                    WHERE T-Pagos_x_retiva.cdg_tiporetiva =  Famretiva_regimen.cdg_tiporetiva
                          NO-ERROR.
                IF NOT AVAILABLE T-Pagos_x_retiva
                THEN DO:
                     CREATE T-Pagos_x_retiva.
                     ASSIGN T-Pagos_x_retiva.cdg_tiporetiva =  Famretiva_regimen.cdg_tiporetiva.
                END.           

                T-Pagos_x_retiva.imp_estepago = T-Pagos_x_retiva.imp_estepago + Fac_detalle_prv_impuesto.monto_imponible.
                T-Pagos_x_retiva.imp_retenido = T-Pagos_x_retiva.imp_retenido + a_retener.

                FIND FIRST T-Pagos_x_retiva_det
                    WHERE T-Pagos_x_retiva_det.tip_comprob     = Fac_header_prv.tip_comprob  
                      AND T-Pagos_x_retiva_det.prf_comprob     = Fac_header_prv.prf_comprob  
                      AND T-Pagos_x_retiva_det.nro_comprob     = Fac_header_prv.nro_comprob  
                      AND T-Pagos_x_retiva_det.nro_proveedor   = Fac_header_prv.nro_proveedor
                          NO-ERROR.

                IF NOT AVAILABLE T-Pagos_x_retiva_det
                THEN DO:
                    CREATE T-Pagos_x_retiva_det.
                    ASSIGN T-Pagos_x_retiva_det.tip_comprob     = Fac_header_prv.tip_comprob  
                           T-Pagos_x_retiva_det.prf_comprob     = Fac_header_prv.prf_comprob  
                           T-Pagos_x_retiva_det.nro_comprob     = Fac_header_prv.nro_comprob  
                           T-Pagos_x_retiva_det.nro_proveedor   = Fac_header_prv.nro_proveedor.
                END.

            END.

        END.

        /* Halla el total pagado para esta actividad a efectos de acumular esta retención */

    END.

END.  /* De recorrer el detalle para calcular retenciones de I.V.A. */

                /* Compara, por actividad, los acumulados con el pago */
                /* para hacer el calculo de las retenciones           */

FOR EACH T-Pagos_x_retiva, 
         Tipo_retiva WHERE Tipo_retiva.cdg_tiporetiva = T-Pagos_x_retiva.cdg_tiporetiva 
                              BY T-Pagos_x_retiva.cdg_tiporetiva:

    T-Pagos_x_retiva.imp_pagado   = T-Pagos_x_retiva.imp_estepago.

                /* El importe total a tener quedo en T-Pagos_x_retiva.imp_retenido */
                /* Ahora, con ese importe genera los rubros del caja           */

    FIND FIRST T-Caj_detalle OF T-Caj_header 
         WHERE T-Caj_detalle.cdg_rubro = Tipo_retiva.cdg_rubro 
               EXCLUSIVE-LOCK NO-ERROR.

    IF T-Pagos_x_retiva.imp_retenido > Tipo_retiva.imp_retmin
    THEN DO:

       IF NOT AVAILABLE T-Caj_detalle
       THEN DO:
          CREATE T-Caj_detalle.
          ASSIGN T-Caj_header.ultima_linea      = T-Caj_header.ultima_linea + 1
                 T-Caj_detalle.nro_transaccion  = T-Caj_header.nro_transaccion
                 T-Caj_detalle.nro_linea        = T-Caj_header.ultima_linea
                 T-Caj_detalle.tipo_mov         = T-Caj_header.tipo_mov
                 T-Caj_detalle.cdg_rubro        = Tipo_retiva.cdg_rubro.
       END.
 
       T-Caj_header.ingreso = T-Caj_header.ingreso - T-Caj_detalle.importe.        /* Resta importe anterior */
       T-Caj_detalle.importe = T-Pagos_x_retiva.imp_retenido.               /* Asigna nuevo importe   */
       T-Caj_header.ingreso = T-Caj_header.ingreso + T-Caj_detalle.importe.        /* Suma  importe actual   */

    END. /* Del agregado de la retencion */
    ELSE DO: /* No hay retencion por no exceder el minimo */

       IF AVAILABLE T-Caj_detalle
       THEN DO:
          T-Caj_header.ingreso = T-Caj_header.ingreso - T-Caj_detalle.importe. /* Resta importe anterior */
          DELETE T-Caj_detalle.
       END.
       
    END.

END.

OUTPUT TO "c:\sic-temp\reteniva.txt".
PUT STRING(TIME,"hh:mm:ss") SKIP "==============" SKIP.
FOR EACH T-Pagos_x_retiva, Tipo_retiva OF T-Pagos_x_retiva BY T-Pagos_x_retiva.cdg_tiporetiva:
    DISPLAY T-Pagos_x_retiva EXCEPT nro_ordpago WITH 1 COLUMN SIDE-LABELS .
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

