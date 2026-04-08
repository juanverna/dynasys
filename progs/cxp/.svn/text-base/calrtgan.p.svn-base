/*=================================================================================*/
/*             HACE EL CALCULO DE LAS RETENCIONES DE GANANCIAS                     */
/*=================================================================================*/

DEFINE INPUT PARAMETER que_orden AS ROWID.

DEFINE WORK-TABLE Pagos_por_ac
FIELD cdg_tiporetgan LIKE Tipo_actividad.cdg_tiporetgan
FIELD imp_estepago   AS DECIMAL
FIELD imp_pagado     AS DECIMAL
FIELD imp_retenido   AS DECIMAL.


DEFINE VARIABLE v_con  AS CHARACTER FORMAT "X(45)".
DEFINE VARIABLE v_val  AS DECIMAL   FORMAT "->,>>>,>>9.99".

FORM
  v_con v_val
  WITH FRAME aa NO-LABELS STREAM-IO DOWN.


{VRSHARED.I}
{VPERSINM.I}

FIND Opg_header WHERE ROWID(Opg_header) = que_orden  EXCLUSIVE-LOCK.
FIND Proveedor  OF Opg_header NO-LOCK.
FIND Caj_header WHERE Caj_header.nro_transaccion = Opg_header.nro_transaccion EXCLUSIVE-LOCK.

   /* Recorre el detalle de la O/P y halla los totales a pagar por cada actividad */

Opg_header.imp_neto = 0.
FOR EACH Opg_detalle OF Opg_header NO-LOCK:

    IF Opg_detalle.tip_cancela <> "OP"
    THEN DO:
         FIND FIRST Cta_cte_prv OF Proveedor
              WHERE Cta_cte_prv.cdg_empresa = Opg_header.cdg_empresa
                AND Cta_cte_prv.tip_comprob = Opg_detalle.tip_cancela
                AND Cta_cte_prv.prf_comprob = Opg_detalle.prf_cancela
                AND Cta_cte_prv.nro_comprob = Opg_detalle.nro_cancela NO-LOCK.

         FIND FIRST Pagos_por_ac 
              WHERE Pagos_por_ac.cdg_tiporetgan = Cta_cte_prv.cdg_tiporetgan NO-ERROR.
         
         IF NOT AVAILABLE Pagos_por_ac
         THEN DO:
              CREATE Pagos_por_ac.
              ASSIGN Pagos_por_ac.cdg_tiporetgan =  Cta_cte_prv.cdg_tiporetgan.
         END.           


        IF Opg_detalle.importe = Cta_cte_prv.imp_total
        THEN DO:
             Pagos_por_ac.imp_estepago = Pagos_por_ac.imp_estepago + 
                                         Cta_cte_prv.imp_neto.
        END.
        ELSE DO:
             Pagos_por_ac.imp_estepago = Pagos_por_ac.imp_estepago + 
                                         ROUND( Opg_detalle.importe * 
                                          ( Cta_cte_prv.imp_neto / Cta_cte_prv.imp_total ), 2) .
        END.

    END.

END.    

                /* Compara, por actividad, los acumulados con el pago */
                /* para hacer el calculo de las retenciones           */


FOR EACH Pagos_por_ac, 
         Tipo_actividad WHERE Tipo_actividad.cdg_tiporetgan = Pagos_por_ac.cdg_tiporetgan 
                              BY Pagos_por_ac.cdg_tiporetgan:

            RUN SHOW_VAL ( INPUT "A pagar " + Tipo_actividad.nom_tipactiv , 
                           INPUT Pagos_por_ac.imp_estepago).

    FIND FIRST Acumulado_pagos OF Proveedor
         WHERE Acumulado_pagos.cdg_empresa  = Opg_header.cdg_empresa
           AND Acumulado_pagos.ano          = YEAR(Opg_header.fecha)
           AND Acumulado_pagos.mes          = MONTH(Opg_header.fecha) 
           AND Acumulado_pagos.cdg_tiporetgan = Pagos_por_ac.cdg_tiporetgan
               EXCLUSIVE-LOCK NO-ERROR.

    IF NOT AVAILABLE Acumulado_pagos 
    THEN DO:
       CREATE Acumulado_pagos.
       ASSIGN 
              Acumulado_pagos.cdg_empresa   = Opg_header.cdg_empresa
              Acumulado_pagos.ano           = YEAR(Opg_header.fecha)
              Acumulado_pagos.mes           = MONTH(Opg_header.fecha)
              Acumulado_pagos.nro_proveedor = Proveedor.nro_proveedor
              Acumulado_pagos.cdg_tiporetgan  = Pagos_por_ac.cdg_tiporetgan.
              
    END.          

            RUN SHOW_VAL ( INPUT "        Acumulado pagado", 
                           INPUT Acumulado_pagos.total_pagado ).

            RUN SHOW_VAL ( INPUT "                  retenido", 
                           INPUT Acumulado_pagos.total_retganan ).


    Pagos_por_ac.imp_pagado   = Acumulado_pagos.total_pagado + Pagos_por_ac.imp_estepago.
    Pagos_por_ac.imp_retenido = 0.

    Opg_header.imp_neto = Opg_header.imp_neto + Pagos_por_ac.imp_estepago.

    FIND FIRST Rango_retgan OF Tipo_actividad 
         WHERE Rango_retgan.hasta_importe >= Pagos_por_ac.imp_pagado  AND
               Rango_retgan.desde_importe <= Pagos_por_ac.imp_pagado  AND
               Rango_retgan.desde_fecha   <= Opg_header.fecha         AND
               Opg_header.fecha           <= Rango_retgan.hasta_fecha NO-LOCK.

            RUN SHOW_VAL ( INPUT "        Rango " + STRING(Rango_retgan.desde_importe) 
                          + " " + STRING(Rango_retgan.hasta_importe) + " =>>", 
                           INPUT Pagos_por_ac.imp_pagado ).

    Pagos_por_ac.imp_retenido  = Rango_retgan.imp_basico +
                   ROUND(( Pagos_por_ac.imp_pagado - Rango_retgan.desde_importe ) *
                                Rango_retgan.alicuota / 100 , 2 ) - 
                           Acumulado_pagos.total_retganan.

    RUN SHOW_VAL ( INPUT "        Calcula ", 
                   INPUT Pagos_por_ac.imp_retenido ).


                /* El importe total a tener quedo en Pagos_por_ac.imp_retenido */
                /* Ahora, con ese importe genera los rubros del caja           */

    FIND FIRST Caj_detalle OF Caj_header 
         WHERE Caj_detalle.cdg_rubro = Tipo_actividad.cdg_rubro 
               EXCLUSIVE-LOCK NO-ERROR.

    IF Pagos_por_ac.imp_retenido > Tipo_actividad.imp_retmin
    THEN DO:

       IF NOT AVAILABLE Caj_detalle
       THEN DO:
          CREATE Caj_detalle.
          ASSIGN Caj_header.ultima_linea      = Caj_header.ultima_linea + 1
                 Caj_detalle.nro_transaccion  = Caj_header.nro_transaccion
                 Caj_detalle.nro_linea        = Caj_header.ultima_linea
                 Caj_detalle.tipo_mov         = Caj_header.tipo_mov
                 Caj_detalle.cdg_rubro        = Tipo_actividad.cdg_rubro.
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

