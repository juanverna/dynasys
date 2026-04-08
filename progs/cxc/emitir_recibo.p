/*=================================================================================*/
/*                    EMISION DE RECIBOS DE PAGO                                   */
/*=================================================================================*/

/* ------------------------------------------------------------------------------ */
/* 24/06/05 Se elimino la consideración del subdiario de ventas ya que no se so-  */
/* portan mas los descuentos directos en el recibo de pago. Todos los descuentos  */
/* y recargos que se ejecuten con respecto a un pago deben hacerse emitiendo la   */
/* nota de crédito o débito correspondiente, al igual que se hace con las dife-   */
/* rencias de cambio                                                              */
/* ------------------------------------------------------------------------------ */

DEFINE INPUT PARAMETER rid_recibo   AS ROWID.

/*=================================================================================*/
/*                          TABLAS TEMPORALES                                      */
/*=================================================================================*/

DEFINE TEMP-TABLE T-Fac_header           NO-UNDO LIKE Fac_header.
DEFINE TEMP-TABLE T-Fac_detalle          NO-UNDO LIKE Fac_detalle.
DEFINE TEMP-TABLE T-Fac_header_impuesto  NO-UNDO LIKE Fac_header_impuesto.
DEFINE TEMP-TABLE T-Fac_detalle_impuesto NO-UNDO LIKE Fac_detalle_impuesto.

/*=================================================================================*/
/*                          VARIABLES Y BUFFERS                                    */
/*=================================================================================*/

{parlocales.i}

DEFINE VARIABLE str_debitan    AS   CHARACTER FORMAT "X(35)".

DEFINE VARIABLE saldo_recibo        AS DECIMAL.
DEFINE VARIABLE saldo_factura       AS DECIMAL.
DEFINE VARIABLE monto_imputado      AS DECIMAL.

DEFINE VARIABLE saldo_importe       LIKE Rec_detalle.importe.
DEFINE VARIABLE prop_importe        LIKE Rec_detalle.importe.
DEFINE VARIABLE aux_nro_vencimiento AS INTEGER.

DEFINE VARIABLE v-nro_usuario       LIKE Aplicacion_pagos.nro_usuario.
DEFINE VARIABLE v-fecha_grab        LIKE Aplicacion_pagos.fecha_grab. 
DEFINE VARIABLE v-hora_grab         LIKE Aplicacion_pagos.hora_grab.  
DEFINE VARIABLE v-pc_name           LIKE Aplicacion_pagos.pc_name.   

DEFINE BUFFER B-Sub_header_vta      FOR Sub_header_vta.
DEFINE BUFFER B-Sub_detalle_vta     FOR Sub_detalle_vta.
DEFINE BUFFER B-Rec_detalle         FOR Rec_detalle.
DEFINE BUFFER Moneda_local          FOR Moneda.
DEFINE BUFFER Comprobante_cc        FOR Tipocomprobante.
/*=================================================================================*/
/*                         INICIALIZACION DE LA EMISION                            */
/*=================================================================================*/

DEFINE VARIABLE str_debitan_ventas    AS CHARACTER  NO-UNDO.
RUN cargar_debitan.p ( INPUT "Ventas", OUTPUT str_debitan ).
ASSIGN str_debitan_ventas =  str_debitan.
RUN cargar_debitan.p ( INPUT "Tesoreria", OUTPUT str_debitan ).
ASSIGN str_debitan = string(str_debitan_ventas + str_debitan).

{findempresa.i}

FIND Rec_header WHERE ROWID(Rec_header) = rid_recibo EXCLUSIVE-LOCK.

FIND Condicion_impos OF Rec_header NO-LOCK.
FIND Imputacion      OF Rec_header NO-LOCK.
FIND Cliente         OF Rec_header NO-LOCK.
FIND Moneda          OF Rec_header NO-LOCK.
FIND Familia_cliente OF Cliente NO-LOCK.
FIND Cuenta          OF Familia_cliente NO-LOCK.

/*=================================================================================*/
/*                             CANCELACION DE DOCUMENTOS                           */
/*=================================================================================*/

saldo_recibo = Rec_header.imp_bruto.
{findempresa.i}

FIND Tipocomprobante OF Rec_header NO-LOCK NO-ERROR.
IF NOT AVAILABLE Tipocomprobante 
THEN DO:
    MESSAGE "No se puede Emitir el recibo porque" SKIP
            "No existe el Comprobante" Rec_header.cdg_comprobante SKIP
            "para la empresa" Rec_header.cdg_empresa
        VIEW-AS ALERT-BOX INFO BUTTONS OK.
END.
ELSE DO: 
    IF Cliente.tiene_ctacte AND Tipocomprobante.afecta_cc
    THEN DO:
        FOR EACH Rec_detalle OF Rec_header:
        
            /*----------------------------------------------------------------------------------*/
            /*      CANCELACION DE LOS REGISTROS DE CUENTA CORRIENTE DEL DETALLE DE RECIBO      */
            /*----------------------------------------------------------------------------------*/
    
            FIND Cta_cte WHERE Cta_cte.cdg_empresa = Rec_header.cdg_empresa
                           AND Cta_cte.tip_comprob = Rec_detalle.tip_cancela
                           AND Cta_cte.prf_comprob = Rec_detalle.prf_cancela
                           AND Cta_cte.nro_comprob = Rec_detalle.nro_cancela
                           AND Cta_cte.nro_vencimiento = Rec_detalle.nro_vencimiento
                               EXCLUSIVE-LOCK.                             
            IF NOT AVAILABLE Cta_cte 
            THEN DO:
                 MESSAGE "no encontro ctacte " SKIP
                "Rec_header.cdg_empresa      :"    Rec_header.cdg_empresa      SKIP
                "Rec_detalle.tip_cancela     :"    Rec_detalle.tip_cancela     SKIP
                "Rec_detalle.prf_cancela     :"    Rec_detalle.prf_cancela     SKIP
                "Rec_detalle.nro_cancela     :"    Rec_detalle.nro_cancela     SKIP
                "Rec_detalle.nro_vencimiento :"    Rec_detalle.nro_vencimiento SKIP
                      VIEW-AS ALERT-BOX MESSAGE TITLE "emitir_recibo".
            END.
            ELSE DO:
                FIND FIRST Comprobante_cc 
                    WHERE Comprobante_cc.cdg_comprobante = Cta_cte.cdg_comprobante
                      AND Comprobante_cc.cdg_empresa     = Cta_cte.cdg_empresa
                          NO-LOCK NO-ERROR.
                IF NOT AVAILABLE Comprobante_cc
                    THEN MESSAGE Cta_cte.cdg_comprobante Cta_cte.cdg_empresa     
                            VIEW-AS ALERT-BOX INFO BUTTONS OK TITLE "ERROR DE IMPLEMENTACION:Comprobante no hallado".
                IF Comprobante_cc.debita
                THEN DO:
                    IF Rec_detalle.es_difcambio
                        THEN ASSIGN Cta_cte.credito = Cta_cte.credito + Rec_detalle.difcambio
                                    saldo_recibo = saldo_recibo - Rec_detalle.difcambio.
                        ELSE ASSIGN Cta_cte.credito = Cta_cte.credito + Rec_detalle.importe
                                    saldo_recibo = saldo_recibo - Rec_detalle.importe.

                END.
                ELSE DO:
                    IF Rec_detalle.es_difcambio
                        THEN ASSIGN Cta_cte.debito = Cta_cte.debito - Rec_detalle.difcambio /* Rec_detalle.importe es < 0 */
                                    saldo_recibo = saldo_recibo - Rec_detalle.difcambio.
                        ELSE ASSIGN Cta_cte.debito = Cta_cte.debito - Rec_detalle.importe /* Rec_detalle.importe es < 0 */
                                    saldo_recibo = saldo_recibo - Rec_detalle.importe.
                 END.
            
                Cta_cte.imputado = NO.
            END.

        END. /* Fin de recorrer el detalle del recibo */
    
    /*=================================================================================*/
    /*                 INCORPORACION A LA CUENTA CORRIENTE                             */
    /*=================================================================================*/
    
    /*----------------------------------------------------------------------------------*/
    /*         INCORPORA EN LA CUENTA CORRIENTE EL COMPONENTE DE CADA MONEDA            */
    /*----------------------------------------------------------------------------------*/
    
        aux_nro_vencimiento = 0.

        RUN completar_auditoria.p ( OUTPUT v-nro_usuario,
                                    OUTPUT v-fecha_grab,
                                    OUTPUT v-hora_grab,
                                    OUTPUT v-pc_name).

        FOR EACH Totales_recibo OF Rec_header NO-LOCK, Moneda OF Totales_recibo NO-LOCK:

            /*----------------------------------------------------------------------------------*/
            /*     GENERA EL MOVIMIENTO DE CUENTA CORRIENTE QUE CORRESPONDE AL RECIBO           */
            /*----------------------------------------------------------------------------------*/

            CREATE Cta_cte.
            BUFFER-COPY Rec_header TO Cta_cte.
                ASSIGN Cta_cte.nro_moneda        = Totales_recibo.nro_moneda
                       Cta_cte.nro_vencimiento   = aux_nro_vencimiento 
                       Cta_cte.fecha_emision     = Rec_header.fecha
                       Cta_cte.fecha_vencimiento = Rec_header.fecha
                       aux_nro_vencimiento       = aux_nro_vencimiento + 1.

            IF Moneda.es_local
                THEN ASSIGN Cta_cte.credito      = Totales_recibo.imp_total + Rec_header.imp_difcambio
                            Cta_cte.debito       = IF Rec_header.tipo_pago = 1 
                                                      THEN Totales_recibo.imp_total + Rec_header.imp_difcambio
                                                      ELSE 0.
                ELSE ASSIGN Cta_cte.credito      = Totales_recibo.imp_total
                            Cta_cte.debito       = IF Rec_header.tipo_pago = 1 
                                                     THEN Totales_recibo.imp_total
                                                     ELSE 0.

            /*----------------------------------------------------------------------------------*/
            /*     GENERA EL REGISTRO DE APLICACION DE PAGOS PARA CADA DOCUMENTO CANCELADO      */
            /*----------------------------------------------------------------------------------*/

            FOR EACH Rec_detalle OF Rec_header WHERE Rec_detalle.nro_moneda = Totales_recibo.nro_moneda:

                CREATE Aplicacion_pagos.
                ASSIGN Aplicacion_pagos.cdg_empresa      = Rec_header.cdg_empresa
                       Aplicacion_pagos.importe          = IF Rec_detalle.es_difcambio 
                                                              THEN Rec_detalle.difcambio 
                                                              ELSE Rec_detalle.importe
                       Aplicacion_pagos.descuento        = Rec_detalle.descuento
                       Aplicacion_pagos.tip_cancela      = Rec_detalle.tip_cancela
                       Aplicacion_pagos.prf_cancela      = Rec_detalle.prf_cancela
                       Aplicacion_pagos.nro_cancela      = Rec_detalle.nro_cancela
                       Aplicacion_pagos.nro_ven_cancela  = Rec_detalle.nro_vencimiento
                       Aplicacion_pagos.tip_comprob      = Rec_header.tip_comprob
                       Aplicacion_pagos.prf_comprob      = Rec_header.prf_comprob
                       Aplicacion_pagos.nro_comprob      = Rec_header.nro_comprob           
                       Aplicacion_pagos.nro_vencimiento  = Cta_cte.nro_vencimiento
                       Aplicacion_pagos.nro_usuario      = v-nro_usuario
                       Aplicacion_pagos.fecha_grab       = v-fecha_grab 
                       Aplicacion_pagos.hora_grab        = v-hora_grab  
                       Aplicacion_pagos.pc_name          = v-pc_name.   

            END.

        END.
/*    
    /*----------------------------------------------------------------------------------*/
    /* SI LA MONEDA NO ES LOCAL Y HAY DIFERENCIA DE CAMBIO, INCORPORA ESTA EN LOS       */
    /* EXPRESADOS EN MONEDA LOCAL.                                                      */
    /*----------------------------------------------------------------------------------*/
    
      /*IF NOT Moneda.es_local AND Rec_header.imp_difcambio <> 0*/
        IF Rec_header.imp_difcambio <> 0
        THEN DO:
            FIND Moneda_local WHERE Moneda_local.es_local NO-LOCK.
            CREATE Cta_cte.
            BUFFER-COPY Rec_header TO Cta_cte
                ASSIGN aux_nro_vencimiento          = aux_nro_vencimiento + 1
                       Cta_cte.nro_vencimiento      = aux_nro_vencimiento
                       Cta_cte.nro_moneda           = Moneda_local.nro_moneda
                       Cta_cte.fecha_emision        = Rec_header.fecha
                       Cta_cte.fecha_vencimiento    = Rec_header.fecha
                       Cta_cte.credito              = Rec_header.imp_difcambio
                       Cta_cte.debito               = IF Rec_header.tipo_pago = 1 
                                                         THEN Rec_header.imp_difcambio 
                                                         ELSE 0.
        END.
*/    
    END. /* De actualizar la cuenta corriente */
    
    /*=================================================================================*/
    /*                           IMPRESION DEL COMPROBANTE                             */
    /*=================================================================================*/
    
    /*RUN actualiza_notas_debito(INPUT ROWID(Rec_header)).*/
/*    RUN imprimir_recibo.p ( INPUT ROWID(Rec_header)).*/
END. /* del else */

PROCEDURE actualiza_notas_debito:

    DEFINE INPUT PARAMETER rid-recibo AS ROWID.
    
    
    
    DEFINE BUFFER b_caj_detalle FOR caj_detalle.
    
    DEFINE VARIABLE cotiza_dolar AS DECIMAL    NO-UNDO.
    DEFINE VARIABLE todo_ok      AS LOGICAL    NO-UNDO.
    RUN getparametro.p (  INPUT  "DFMONEDA",
                              OUTPUT v-valor_c,
                              OUTPUT v-valor_d,
                              OUTPUT v-valor_l,
                              OUTPUT v-valor_n,
                              OUTPUT v-observacion ).

    FIND Moneda WHERE Moneda.cdg_moneda = v-valor_c NO-LOCK.
    RUN getparametro.p (  INPUT  "DFNROCAJ",
                          OUTPUT v-valor_c,
                          OUTPUT v-valor_d,
                          OUTPUT v-valor_l,
                          OUTPUT v-valor_n,
                          OUTPUT v-observacion ).
    
    cotiza_dolar = 0.
    FIND LAST  Cotizacion
                WHERE Cotizacion.nro_moneda  = Moneda.nro_moneda
                AND   Cotizacion.cdg_empresa = Empresa.cdg_empresa
                AND   Cotizacion.fch_cotizacion <= TODAY
                NO-LOCK NO-ERROR.
    IF AVAILABLE Cotizacion 
        THEN cotiza_dolar = Cotizacion.cambio.

    FIND FIRST Rec_header WHERE ROWID(Rec_header) = rid-recibo NO-LOCK NO-ERROR.
    IF AVAILABLE Rec_header 
    THEN DO:                                            

       FIND FIRST Caj_header 
            WHERE Caj_header.nro_transaccion = Rec_header.nro_transaccion 
            NO-LOCK NO-ERROR.
       IF AVAILABLE Caj_header 
       THEN DO:
           FIND FIRST Cliente OF Caj_header NO-LOCK NO-ERROR.
           IF Cliente.tiene_ctacte 
           THEN DO:
               FOR EACH  Caj_detalle
                   WHERE Caj_detalle.nro_transaccion   = Caj_header.nro_transaccion
                   AND   Caj_detalle.nro_transrechazo <> 0 NO-LOCK :


                    FIND FIRST b_caj_detalle
                          WHERE b_caj_detalle.nro_transaccion = Caj_detalle.nro_transrechazo
                          AND   b_caj_detalle.importe         = Caj_detalle.importe
                                NO-LOCK NO-ERROR.
                      
                     FIND FIRST Motivo_rechazo
                          WHERE Motivo_rechazo.cdg_motivo_rechazo = b_Caj_detalle.cdg_motivo_rechazo
                                NO-LOCK NO-ERROR.
                   IF AVAILABLE Motivo_rechazo          
                      AND Motivo_rechazo.genera_notadebito  
                   THEN DO:
                       
                       FIND FIRST Tipocomprobante
                            WHERE Tipocomprobante.cdg_comprobante = Motivo_rechazo.cdg_comprobante_rch
                            AND   Tipocomprobante.cdg_empresa     = Empresa.cdg_empresa
                                  NO-LOCK NO-ERROR.
                       
                       IF AVAILABLE Tipocomprobante 
                          AND Tipocomprobante.afecta_cc 
                           THEN RUN generar_nota_debito.p  (INPUT  ROWID(b_caj_detalle),
                                                            INPUT  Motivo_rechazo.cdg_motivo_rechazo,
                                                            INPUT  Moneda.nro_moneda, 
                                                            INPUT  TODAY,
                                                            INPUT  cotiza_dolar,
                                                            INPUT  Caj_detalle.nro_transrechazo,
                                                            INPUT  Caj_detalle.observacion,
                                                            OUTPUT todo_ok).
                      
                   END.

               END.
           END.
       END.
    END.
                      
END PROCEDURE.

