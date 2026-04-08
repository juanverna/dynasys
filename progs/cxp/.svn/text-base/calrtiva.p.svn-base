/*=================================================================================*/
/*             HACE EL CALCULO DE LAS RETENCIONES DE I.V.A.                        */
/*=================================================================================*/

DEFINE INPUT PARAMETER que_orden AS ROWID.

DEFINE BUFFER B-Cta_cte_prv FOR Cta_cte_prv.

DEFINE WORK-TABLE Pagos_por_ac
FIELD cdg_tiporetiva LIKE Tipo_retiva.cdg_tiporetiva
FIELD imp_estepago   AS DECIMAL
FIELD imp_pagado     AS DECIMAL
FIELD imp_retenido   AS DECIMAL.

DEFINE VARIABLE v_con          AS CHARACTER FORMAT "X(45)".
DEFINE VARIABLE v_val          AS DECIMAL FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE aux_importe    AS DECIMAL FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE base_imponible AS DECIMAL.

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

                /*  Si es el primer vencimiento (es el primer pago) Busca cta.cte. para */
                /*  conocer el importe de IVA por el cual corresponden las retenciones  */

    IF Opg_detalle.nro_vencimiento = 1
    THEN DO:

             /* S¢lo calculamos retenciones si la factura no tiene pagos aplicados */

         IF NOT CAN-FIND(FIRST Aplicacion_pagos_prv OF Proveedor
                         WHERE Aplicacion_pagos_prv.cdg_empresa     = Opg_header.cdg_empresa
                           AND Aplicacion_pagos_prv.tip_cancela     = Opg_detalle.tip_cancela
                           AND Aplicacion_pagos_prv.prf_cancela     = Opg_detalle.prf_cancela
                           AND Aplicacion_pagos_prv.nro_cancela     = Opg_detalle.nro_cancela 
                           AND Aplicacion_pagos_prv.nro_ven_cancela = Opg_detalle.nro_vencimiento 
                           AND Aplicacion_pagos_prv.tip_comprob     = "OP"                           
                               NO-LOCK)
         THEN DO:

                  /* Halla el registro a cancelar para conocer el importe de IVA */

              FIND FIRST Cta_cte_prv OF Proveedor
                   WHERE Cta_cte_prv.cdg_empresa     = Opg_header.cdg_empresa
                     AND Cta_cte_prv.tip_comprob     = Opg_detalle.tip_cancela
                     AND Cta_cte_prv.prf_comprob     = Opg_detalle.prf_cancela
                     AND Cta_cte_prv.nro_comprob     = Opg_detalle.nro_cancela 
                     AND Cta_cte_prv.nro_vencimiento = Opg_detalle.nro_vencimiento NO-LOCK.
                     
                        /* Inicialmente, la base imponible es toda la factura */

              base_imponible = Cta_cte_prv.imp_iva. 
              
                        /* Resta los creditos de la base imponible */

              FOR EACH Aplicacion_pagos_prv OF Proveedor
                         WHERE Aplicacion_pagos_prv.cdg_empresa     = Opg_header.cdg_empresa
                           AND Aplicacion_pagos_prv.tip_cancela     = Opg_detalle.tip_cancela
                           AND Aplicacion_pagos_prv.prf_cancela     = Opg_detalle.prf_cancela
                           AND Aplicacion_pagos_prv.nro_cancela     = Opg_detalle.nro_cancela 
                           AND (    Aplicacion_pagos_prv.tip_comprob = "CA" 
                                 OR Aplicacion_pagos_prv.tip_comprob = "CB" )
                                    NO-LOCK:

                   FIND FIRST B-Cta_cte_prv OF Proveedor
                        WHERE B-Cta_cte_prv.cdg_empresa     = Opg_header.cdg_empresa
                          AND B-Cta_cte_prv.tip_comprob     = Aplicacion_pagos_prv.tip_comprob
                          AND B-Cta_cte_prv.prf_comprob     = Aplicacion_pagos_prv.prf_comprob
                          AND B-Cta_cte_prv.nro_comprob     = Aplicacion_pagos_prv.nro_comprob 
                          AND B-Cta_cte_prv.nro_vencimiento = Aplicacion_pagos_prv.nro_vencimiento NO-LOCK.

                   base_imponible = base_imponible - B-Cta_cte_prv.imp_iva * 
                                                     Aplicacion_pagos_prv.importe / 
                                                     B-Cta_cte_prv.imp_total .
                   
              END.

              FIND FIRST Rango_retiva 
                   WHERE Rango_retiva.cdg_tiporetiva  = Cta_cte_prv.cdg_tiporetiva
                     AND Rango_retiva.desde_fecha   <= Opg_header.fecha
                     AND Rango_retiva.hasta_fecha   >= Opg_header.fecha
                     AND Rango_retiva.desde_importe <= base_imponible
                     AND Rango_retiva.hasta_importe >= base_imponible NO-LOCK.

              IF Rango_retiva.alicuota <> 0
              THEN DO:

                   FIND FIRST Pagos_por_ac 
                        WHERE Pagos_por_ac.cdg_tiporetiva = Cta_cte_prv.cdg_tiporetiva NO-ERROR.
         
                   IF NOT AVAILABLE Pagos_por_ac
                   THEN DO:
                      CREATE Pagos_por_ac.
                      ASSIGN Pagos_por_ac.cdg_tiporetiva =  Cta_cte_prv.cdg_tiporetiva.
                   END.           

                   aux_importe = ROUND(base_imponible * Rango_retiva.alicuota / 100, 2).
                   IF aux_importe <= Rango_retiva.imp_basico
                      THEN aux_importe = 0.

                   Opg_detalle.imp_reteniva = aux_importe.
                   Pagos_por_ac.imp_estepago = Pagos_por_ac.imp_estepago +  Opg_detalle.importe.
                   Pagos_por_ac.imp_retenido = Pagos_por_ac.imp_retenido +  aux_importe.
              
              END.

         END.   

    END. /* Del c lculo de retenciones para una factura */

END.  /* De recorrer el detalle para calcular retenciones */

                /* Compara, por actividad, los acumulados con el pago */
                /* para hacer el calculo de las retenciones           */

FOR EACH Pagos_por_ac, 
         Tipo_retiva WHERE Tipo_retiva.cdg_tiporetiva = Pagos_por_ac.cdg_tiporetiva 
                              BY Pagos_por_ac.cdg_tiporetiva:

            RUN SHOW_VAL ( INPUT "A pagar IVA" + Tipo_retiva.nom_retiva , 
                           INPUT Pagos_por_ac.imp_estepago).

    Pagos_por_ac.imp_pagado   = Pagos_por_ac.imp_estepago.

                /* El importe total a tener quedo en Pagos_por_ac.imp_retenido */
                /* Ahora, con ese importe genera los rubros del caja           */

    FIND FIRST Caj_detalle OF Caj_header 
         WHERE Caj_detalle.cdg_rubro = Tipo_retiva.cdg_rubro 
               EXCLUSIVE-LOCK NO-ERROR.

    IF Pagos_por_ac.imp_retenido > Tipo_retiva.imp_retmin
    THEN DO:

       IF NOT AVAILABLE Caj_detalle
       THEN DO:
          CREATE Caj_detalle.
          ASSIGN Caj_header.ultima_linea      = Caj_header.ultima_linea + 1
                 Caj_detalle.nro_transaccion  = Caj_header.nro_transaccion
                 Caj_detalle.nro_linea        = Caj_header.ultima_linea
                 Caj_detalle.tipo_mov         = Caj_header.tipo_mov
                 Caj_detalle.cdg_rubro        = Tipo_retiva.cdg_rubro.
       END.
 
       Caj_header.ingreso = Caj_header.ingreso - Caj_detalle.importe. /* Resta importe anterior */
       Caj_detalle.importe = Pagos_por_ac.imp_retenido.               /* Asigna nuevo importe   */
       Caj_header.ingreso = Caj_header.ingreso + Caj_detalle.importe. /* Suma  importe actual   */

    END. /* Del agregado de la retencion */
    ELSE DO: /* No hay retencion por no exceder el minimo */

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
