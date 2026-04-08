/*=================================================================================*/
/*                      EMITE UNA NOTA DE DEBITO A UN PROVEEDOR                    */
/*=================================================================================*/

DEFINE INPUT PARAMETER act_ordpago AS ROWID.

/*=================================================================================*/
/*                               VARIABLES Y BUFFERS                               */
/*=================================================================================*/

{VRSHARED.I}
{VPERSINM.I}

DEFINE VARIABLE saldo_recibo        AS DECIMAL.
DEFINE VARIABLE saldo_descuento     AS DECIMAL.
DEFINE VARIABLE prop_descuento      AS DECIMAL.

DEFINE BUFFER B-Sub_header_prv      FOR Sub_header_prv.
DEFINE BUFFER B-Sub_detalle_prv     FOR Sub_detalle_prv.

/*=================================================================================*/
/*                           INICIALIZACION DE LA EMISION                          */
/*=================================================================================*/
FIND Opg_header WHERE ROWID(Opg_header) = act_ordpago EXCLUSIVE-LOCK.
FIND Imputacion OF Opg_header NO-LOCK.
FIND Proveedor  OF Opg_header NO-LOCK.


IF Opg_header.estado = "E"  /* Hacemos si la orden de pago esta en firme */
THEN DO:

/*=================================================================================*/
/*   CANCELACION DE DOCUMENTOS E INCORPORACION DE CREDITOS/DEBITOS AL SUBDIARIO    */
/*=================================================================================*/

    saldo_recibo = Opg_header.imp_total.
    FOR EACH Opg_detalle OF Opg_header:
    
        FIND Cta_cte_prv WHERE Cta_cte_prv.nro_proveedor   = Opg_header.nro_proveedor
                           AND Cta_cte_prv.cdg_empresa     = Opg_header.cdg_empresa
                           AND Cta_cte_prv.tip_comprob     = Opg_detalle.tip_cancela
                           AND Cta_cte_prv.prf_comprob     = Opg_detalle.prf_cancela
                           AND Cta_cte_prv.nro_comprob     = Opg_detalle.nro_cancela
                           AND Cta_cte_prv.nro_vencimiento = Opg_detalle.nro_vencimiento
                           EXCLUSIVE-LOCK NO-ERROR.
        IF NOT AVAILABLE Cta_cte_prv
        THEN DO:
            MESSAGE 
                  "Opg_header.nro_proveedor      "  Opg_header.nro_proveedor      SKIP
                  "Opg_header.cdg_empresa        "  Opg_header.cdg_empresa        SKIP
                  "Opg_detalle.tip_cancela       "  Opg_detalle.tip_cancela       SKIP
                  "Opg_detalle.prf_cancela       "  Opg_detalle.prf_cancela       SKIP
                  "Opg_detalle.nro_cancela       "  Opg_detalle.nro_cancela       SKIP
                  "Opg_detalle.nro_vencimiento   "  Opg_detalle.nro_vencimiento   SKIP
                   VIEW-AS ALERT-BOX INFO BUTTONS OK.
        END.
        ELSE DO:
        
    
            IF LOOKUP(Cta_cte_prv.tip_comprob,str_debitan_prv) = 0
            THEN DO:
                         /* importe > 0 */
                Cta_cte_prv.debito = Cta_cte_prv.debito + Opg_detalle.importe.
                IF Cta_cte_prv.credito <> Cta_cte_prv.debito
                THEN DO:
                     ASSIGN
                         Cta_cte_prv.fecha_programada = ?
                         Cta_cte_prv.imp_programado = 0
                         Cta_cte_prv.programada = NO.
                END.         
                saldo_recibo = saldo_recibo - Opg_detalle.importe.
            END.
            ELSE DO:
                         /* importe < 0 */
                Cta_cte_prv.credito = Cta_cte_prv.credito - Opg_detalle.importe.
                saldo_recibo = saldo_recibo - Opg_detalle.importe.
            END.
        
                             /*-------------------------------------------*/    
                             /*   GENERA HISTORIA DE APLICACION DE PAGOS  */
                             /*-------------------------------------------*/
                                 
            CREATE Aplicacion_pagos_prv.                    
            ASSIGN Aplicacion_pagos_prv.descuento        = Opg_detalle.descuento
                   Aplicacion_pagos_prv.importe          = Opg_detalle.importe
                   Aplicacion_pagos_prv.cdg_empresa      = Opg_header.cdg_empresa
                                                           
                                 /*------------------------------------*/
                                 /* documento cancelado ( o aplicado ) */
                                 /*------------------------------------*/
        
                   Aplicacion_pagos_prv.tip_cancela      = Cta_cte_prv.tip_comprob
                   Aplicacion_pagos_prv.prf_cancela      = Cta_cte_prv.prf_comprob
                   Aplicacion_pagos_prv.nro_cancela      = Cta_cte_prv.nro_comprob
                   Aplicacion_pagos_prv.nro_ven_cancela  = Cta_cte_prv.nro_vencimiento
        
                               /*---------------------------------------*/
                               /* documento que cancela ( o aplicador ) */
                               /*---------------------------------------*/
        
                   Aplicacion_pagos_prv.nro_proveedor    = Opg_header.nro_proveedor
                   Aplicacion_pagos_prv.tip_comprob      = Opg_header.tip_comprob
                   Aplicacion_pagos_prv.prf_comprob      = Opg_header.prf_comprob
                   Aplicacion_pagos_prv.nro_comprob      = Opg_header.nro_comprob
                   Aplicacion_pagos_prv.nro_vencimiento  = 1
        
                               /*---------------------------------------*/
        
                   Cta_cte_prv.imputado = NO.
        
            IF Opg_detalle.descuento <> 0 THEN RUN agregar_subdiario.

        END. /* Del if available cta_cte*/

    END. /* Fin de la cancelaci¢n de documentos */
    
    CREATE Cta_cte_prv.
    ASSIGN Cta_cte_prv.nro_proveedor        = Opg_header.nro_proveedor
           Cta_cte_prv.cdg_empresa          = Opg_header.cdg_empresa
           Cta_cte_prv.tip_comprob          = Opg_header.tip_comprob
           Cta_cte_prv.prf_comprob          = Opg_header.prf_comprob
           Cta_cte_prv.nro_comprob          = Opg_header.nro_comprob
           Cta_cte_prv.nro_vencimiento      = 1
           Cta_cte_prv.cambio               = Opg_header.cambio
           Cta_cte_prv.nro_moneda           = Opg_header.nro_moneda
           Cta_cte_prv.cdg_imputacion       = Opg_header.cdg_imputacion
           Cta_cte_prv.credito              = Opg_header.imp_total - saldo_recibo
           Cta_cte_prv.debito               = Opg_header.imp_total 
           Cta_cte_prv.fecha_emision        = Opg_header.fecha
           Cta_cte_prv.fecha_vencimiento    = Opg_header.fecha
           Cta_cte_prv.cdg_tiporetgan       = Opg_header.cdg_tiporetgan
           Cta_cte_prv.cdg_tiporetibr       = Opg_header.cdg_tiporetibr
           Cta_cte_prv.cdg_tiporetiva       = Opg_header.cdg_tiporetiva
           Cta_cte_prv.cdg_tiporetsus       = Opg_header.cdg_tiporetsus
           Cta_cte_prv.liberada             = YES
           Cta_cte_prv.programada           = YES
           Cta_cte_prv.fecha_programada     = Opg_header.fecha.
    
    act_ctacte_prv = ROWID(Cta_cte_prv).
    RUN ACUMCCPV.P (INPUT "A").

END. /* Del IF que testea el estado = "E" */

/*=================================================================================*/
/*                   EMISION E IMPRESION DE CERTIFICADOS DE RETENCION              */
/*=================================================================================*/

FIND Caj_header WHERE Caj_header.nro_transaccion = Opg_header.nro_transaccion NO-LOCK.
act_caj_head = ROWID(Caj_header).

{findparametro.i "AGRETIVA" "es_agretiva" "valor_l"}
{findparametro.i "AGRETIBR" "es_agretibr" "valor_l"}
{findparametro.i "AGRETGAN" "es_agretgan" "valor_l"}
{findparametro.i "AGRETSUS" "es_agretsus" "valor_l"}

IF es_agretgan THEN RUN emitir_certifgan.p (INPUT ROWID(Opg_header)).
IF es_agretibr THEN RUN emitir_certifibr.p (INPUT ROWID(Opg_header)).
IF es_agretiva THEN RUN emitir_certifiva.p (INPUT ROWID(Opg_header)).
IF es_agretsus THEN RUN emitir_certifsus.p (INPUT ROWID(Opg_header)).

IF Opg_header.tip_comprob = "OP" 
       THEN RUN acumular_pagos.p (INPUT ROWID(Opg_header), INPUT "A").

/*=================================================================================*/
/*                         NOMINA LOS CHEQUES Y VALORES                            */
/*=================================================================================*/

FOR EACH Caj_detalle OF Caj_header NO-LOCK:
   
    FIND Valor OF Caj_detalle EXCLUSIVE-LOCK NO-ERROR.
    IF AVAILABLE Valor 
    THEN DO:
         ASSIGN
           Valor.nro_proveedor = Opg_header.nro_proveedor
           Valor.fecha_salida  = Opg_header.fecha.
    END.     
   
    FIND Cheque OF Caj_detalle EXCLUSIVE-LOCK NO-ERROR.
    IF AVAILABLE Cheque 
    THEN DO:
         ASSIGN
           Cheque.nro_proveedor = Opg_header.nro_proveedor
           Cheque.orden         = Proveedor.orden_cheque
           Cheque.fecha_salida  = Opg_header.fecha.
    END.
   
END.    

/*=================================================================================*/
/*                           IMPRESION DEL COMPROBANTE                             */
/*=================================================================================*/

RUN imprimir_opago.p ( INPUT ROWID(Opg_header) ).

/*=================================================================================*/
/*                              PROCEDIMIENTOS                                     */
/*=================================================================================*/

PROCEDURE agregar_subdiario:

   IF NOT AVAILABLE Sub_header_prv   /* Creamos el registro de subdiario si no existe */
   THEN DO:
      CREATE Sub_header_prv.
      ASSIGN
             Sub_header_prv.cdg_empresa   = Opg_header.cdg_empresa
             Sub_header_prv.nro_proveedor = Opg_header.nro_proveedor
             Sub_header_prv.tip_comprob   = Opg_header.tip_comprob
             Sub_header_prv.prf_comprob   = 0
             Sub_header_prv.nro_comprob   = Opg_header.nro_comprob
             Sub_header_prv.fecha         = Opg_header.fecha
             Sub_header_prv.imp_total     = Opg_header.imp_bruto - Opg_header.imp_total.
             Sub_header_prv.nro_cuenta    = Cuenta.nro_cuenta.
   END.

   FIND B-Sub_header_prv OF Cta_cte_prv NO-LOCK. /* Recorremos subdiario del documento */
   saldo_descuento = Opg_detalle.descuento.
   FOR EACH  B-Sub_detalle_prv
       WHERE B-Sub_header_prv.cdg_empresa   = B-Sub_detalle_prv.cdg_empresa
         AND B-Sub_header_prv.tip_comprob   = B-Sub_detalle_prv.tip_comprob
         AND B-Sub_header_prv.prf_comprob   = B-Sub_detalle_prv.prf_comprob
         AND B-Sub_header_prv.nro_comprob   = B-Sub_detalle_prv.nro_comprob
         AND B-Sub_header_prv.nro_proveedor = B-Sub_detalle_prv.nro_proveedor
             BREAK BY B-Sub_detalle_prv.nro_comprob:

       FIND Sub_detalle_prv
           WHERE Sub_detalle_prv.cdg_empresa    = Opg_header.cdg_empresa
             AND Sub_detalle_prv.nro_proveedor  = Opg_header.nro_proveedor
             AND Sub_detalle_prv.tip_comprob    = Opg_header.tip_comprob
             AND Sub_detalle_prv.prf_comprob    = 0
             AND Sub_detalle_prv.nro_comprob    = Opg_header.nro_comprob
             AND Sub_detalle_prv.nro_cuenta     = B-Sub_detalle_prv.nro_cuenta
                 EXCLUSIVE-LOCK NO-ERROR.

       IF NOT AVAILABLE Sub_detalle_prv
       THEN DO:
          CREATE Sub_detalle_prv.
          ASSIGN
              Sub_detalle_prv.cdg_empresa    = Opg_header.cdg_empresa
              Sub_detalle_prv.nro_proveedor  = Opg_header.nro_proveedor
              Sub_detalle_prv.tip_comprob    = Opg_header.tip_comprob
              Sub_detalle_prv.prf_comprob    = 0
              Sub_detalle_prv.nro_comprob    = Opg_header.nro_comprob
              Sub_detalle_prv.nro_cuenta     = B-Sub_detalle_prv.nro_cuenta
              Sub_detalle_prv.tipo           = B-Sub_detalle_prv.tipo.
       END.

       IF LAST-OF(B-Sub_detalle_prv.nro_comprob)
       THEN DO:
          Sub_detalle_prv.valor = Sub_detalle_prv.valor + saldo_descuento.
       END.
       ELSE DO:
          prop_descuento = ROUND(Opg_detalle.descuento * B-Sub_detalle_prv.valor / B-Sub_header_prv.imp_total, 2).
          Sub_detalle_prv.valor = Sub_detalle_prv.valor + prop_descuento.
          saldo_descuento   = saldo_descuento   - prop_descuento.
       END.

   END.

END PROCEDURE.
