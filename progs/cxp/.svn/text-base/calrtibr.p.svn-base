/*=================================================================================*/
/*        HACE EL CALCULO DE LAS RETENCIONES DE INGRESOS BRUTOS PARA TODOS LOS     */
/*        DOCUMENTOS CANCELADOS EN UNA O/PAGO                                      */
/*=================================================================================*/

DEFINE INPUT PARAMETER que_orden AS ROWID.

DEFINE BUFFER B-Cta_cte_prv FOR Cta_cte_prv.

DEFINE WORK-TABLE Pagos_por_actividad
FIELD cdg_tiporetibr LIKE Tipo_retibr.cdg_tiporetibr
FIELD imp_estepago   AS DECIMAL
FIELD imp_pagado     AS DECIMAL
FIELD imp_retenido   AS DECIMAL.

DEFINE VARIABLE v_con          AS CHARACTER FORMAT "X(45)".
DEFINE VARIABLE v_val          AS DECIMAL   FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE neto_pago      AS DECIMAL   FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE total_retencion    AS DECIMAL   FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE neto_imponible AS DECIMAL.
DEFINE VARIABLE v-alicuota     AS DECIMAL.

FORM
  v_con v_val
  WITH FRAME aa NO-LABELS STREAM-IO DOWN.


{VRSHARED.I}
{VPERSINM.I}

FIND Opg_header WHERE ROWID(Opg_header) = que_orden  NO-LOCK.
FIND Proveedor  OF Opg_header NO-LOCK.
FIND Caj_header WHERE Caj_header.nro_transaccion = Opg_header.nro_transaccion EXCLUSIVE-LOCK.

                /* Halla las retenciones a efectuar por actividad */

FOR EACH Opg_detalle OF Opg_header EXCLUSIVE-LOCK:

       /* Halla el registro a cancelar para conocer el importe neto */

    IF Opg_detalle.tip_cancela <> "OP"
    THEN DO:
        FIND FIRST Cta_cte_prv OF Proveedor
             WHERE Cta_cte_prv.cdg_empresa     = Opg_header.cdg_empresa
               AND Cta_cte_prv.tip_comprob     = Opg_detalle.tip_cancela
               AND Cta_cte_prv.prf_comprob     = Opg_detalle.prf_cancela
               AND Cta_cte_prv.nro_comprob     = Opg_detalle.nro_cancela 
               AND Cta_cte_prv.nro_vencimiento = Opg_detalle.nro_vencimiento NO-LOCK.
    
             /* Halla el importe neto del pago y la retencion correspondiente */
    
        IF Opg_detalle.importe = Cta_cte_prv.imp_total
        THEN DO:
             neto_pago = Cta_cte_prv.imp_neto.
        END.
        ELSE DO:
             neto_pago = ROUND( Opg_detalle.importe * ( Cta_cte_prv.imp_neto / Cta_cte_prv.imp_total ), 2) .
        END.

        RUN RTIBRUDC.P ( INPUT  ROWID(Cta_cte_prv),
                         INPUT  Opg_detalle.importe,
                         OUTPUT Opg_detalle.imp_retenibr,
                         OUTPUT Opg_detalle.alicuota_ibr).

        /* Halla el total pagado para esta actividad a efectos de acumular esta retención */
               
        FIND FIRST Pagos_por_actividad 
             WHERE Pagos_por_actividad.cdg_tiporetibr = Cta_cte_prv.cdg_tiporetibr NO-ERROR.
      
        IF NOT AVAILABLE Pagos_por_actividad
        THEN DO:
           CREATE Pagos_por_actividad.
           ASSIGN Pagos_por_actividad.cdg_tiporetibr =  Cta_cte_prv.cdg_tiporetibr.
        END.           
     
        Pagos_por_actividad.imp_estepago = Pagos_por_actividad.imp_estepago + neto_pago.

    END.

END.  /* De recorrer el detalle para calcular retenciones de Ingresos Brutos */

                /* Compara, por actividad, los acumulados con el pago */
                /* para hacer el calculo de las retenciones           */

FOR EACH Pagos_por_actividad, Tipo_retibr OF Pagos_por_actividad  
         BY Pagos_por_actividad.cdg_tiporetibr:


    RUN RTIBRUMN.P (INPUT  Pagos_por_actividad.cdg_tiporetibr,
                    INPUT  Opg_header.fecha,
                    INPUT  Pagos_por_actividad.imp_estepago,
                    INPUT  Proveedor.convenio_sino,
                    INPUT  YES, /* activa importe minimo */
                    OUTPUT Pagos_por_actividad.imp_retenido).

             /* Chequea que exista el item de caja */
             
    FIND FIRST Caj_detalle OF Caj_header 
         WHERE Caj_detalle.cdg_rubro = Tipo_retibr.cdg_rubro 
               EXCLUSIVE-LOCK NO-ERROR.

    IF Pagos_por_actividad.imp_retenido > 0 
    THEN DO:

                 /* Si hay que retener y no esta, lo crea */

       IF NOT AVAILABLE Caj_detalle
       THEN DO:
          CREATE Caj_detalle.
          ASSIGN Caj_header.ultima_linea      = Caj_header.ultima_linea + 1
                 Caj_detalle.nro_transaccion  = Caj_header.nro_transaccion
                 Caj_detalle.nro_linea        = Caj_header.ultima_linea
                 Caj_detalle.tipo_mov         = Caj_header.tipo_mov
                 Caj_detalle.cdg_rubro        = Tipo_retibr.cdg_rubro.
       END.
 
       Caj_header.ingreso = Caj_header.ingreso - Caj_detalle.importe. /* Resta importe anterior */
       Caj_detalle.importe = Pagos_por_actividad.imp_retenido.               /* Asigna nuevo importe   */
       Caj_header.ingreso = Caj_header.ingreso + Caj_detalle.importe. /* Suma  importe actual   */

    END. 
    ELSE DO: 
    
             /* Si no hay que retener y esta, lo elimina */

       IF AVAILABLE Caj_detalle
       THEN DO:
          Caj_header.ingreso = Caj_header.ingreso - Caj_detalle.importe. /* Resta importe anterior */
          DELETE Caj_detalle.
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
   
   FIND LAST X_Calculo OF Opg_header NO-ERROR.
   IF AVAILABLE X_Calculo THEN k = X_Calculo.secuencia + 1.
                          ELSE k = 1.

   CREATE X_Calculo.
   ASSIGN X_Calculo.nro_ordpag = Opg_header.nro_ordpag
          X_Calculo.secuencia  = k
          X_Calculo.concepto   = c
          X_Calculo.importe    = v.
   
/*
   DISPLAY v_con v_val
           WITH FRAME aa.
   DOWN WITH FRAME aa.        
*/           

END PROCEDURE.           
