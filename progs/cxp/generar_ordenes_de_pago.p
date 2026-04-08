/*=================================================================================*/
/* GENERA UN CONJUNTO DE ORDENES DE PAGO DE FACTURAS INCLUIDAS EN UN LOTE DE PAGO  */
/*=================================================================================*/

/*=================================================================================*/
/*                        DEFINICION DE PARAMETROS                                 */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_lote AS ROWID.

/*=================================================================================*/
/*                          VARIABLES Y BUFFERS                                    */
/*=================================================================================*/

DEFINE VARIABLE v_liberacion          AS LOGICAL.
DEFINE VARIABLE v_programacion        AS LOGICAL.

DEFINE VARIABLE rid_factura           AS ROWID.
DEFINE VARIABLE v-debug               AS LOGICAL.
DEFINE VARIABLE es_ultimo             AS LOGICAL.

DEFINE VARIABLE codigo_iva            AS INTEGER INITIAL 1.
DEFINE VARIABLE prciva                LIKE Impuesto.tasa FORMAT "Z,ZZZ,ZZ9.99-".

DEFINE VARIABLE aux_importe           AS DECIMAL.
DEFINE VARIABLE saldo_factura         AS DECIMAL.

DEFINE VARIABLE j                     AS INTEGER.
DEFINE VARIABLE ncopias               AS INTEGER.

DEFINE VARIABLE modo_emision          AS INTEGER INITIAL 0.
DEFINE VARIABLE indep                 AS INTEGER INITIAL 0.
DEFINE VARIABLE rem_y_fac             AS INTEGER INITIAL 1.
DEFINE VARIABLE fac_y_rem             AS INTEGER INITIAL 2.
DEFINE VARIABLE lado_a_lado           AS INTEGER INITIAL 3.

DEFINE VARIABLE v-pc_name             AS CHARACTER.

DEFINE VARIABLE equiv_granel          LIKE Fac_detalle_prv.granel.

DEFINE VARIABLE v-mes                 LIKE Fac_header_prv.mes.
DEFINE VARIABLE v-ano                 LIKE Fac_header_prv.ano.
DEFINE VARIABLE v-prox_docum   AS CHARACTER.

/*=================================================================================*/
/*                          TRANSACCION PROPIAMENTE DICHA                          */
/*=================================================================================*/

{findempresa.i}

DO TRANSACTION:

/*---------------------------------------------------------------------------------*/
/*              ASIGNAMOS EL NUMERO SI EL COMPROBANTE ES AUTONUMERADO              */
/*---------------------------------------------------------------------------------*/

    RUN pcname1.p ( OUTPUT v-pc_name ).

    FIND Lote_pago WHERE ROWID(Lote_pago) = rid_lote NO-LOCK.
    FOR EACH Lote-factura OF Lote_pago, Proveedor OF Lote-factura BREAK BY Proveedor.cdg_proveedor:

        IF FIRST-OF(Proveedor.cdg_proveedor) 
        THEN DO:

            FIND FIRST Domicilio_prv OF Proveedor NO-LOCK.
            FIND Familia_proveedor OF Proveedor NO-LOCK.
            CREATE Opg_header.
            ASSIGN Opg_header.ano               = YEAR(Lote_pago.fecha_pago)    
                   Opg_header.anulado           = NO                            
                   Opg_header.cambio            = 1 /* OJO !!!!! */               
                   Opg_header.cdg_comprobante   = "ORDENPAG"                      
                   Opg_header.cdg_condiva       = Proveedor.cdg_condiva           
                   Opg_header.cdg_empresa       = Empresa.cdg_empresa             
                   Opg_header.cdg_imputacion    = 1 /* ojo */                     
                   Opg_header.cdg_postal        = Domicilio_prv.cdg_postal        
                   Opg_header.cdg_provincia     = Domicilio_prv.cdg_provincia     
                   Opg_header.cdg_tiporetgan    = "0000"                          
                   Opg_header.cdg_tiporetibr    = "0000"                          
                   Opg_header.cdg_tiporetiva    = "0000"                          
                   Opg_header.cdg_tiporetsus    = "0000"                          
                   Opg_header.cuit              = Proveedor.cuit                  
                   Opg_header.direccion         = Domicilio_prv.direccion         
                   Opg_header.entregada         = NO                              
                   Opg_header.estado            = "E"                             
                   Opg_header.fch_cambio        = Lote_pago.fecha_pago          
                   Opg_header.fecha             = Lote_pago.fecha_pago         
                   Opg_header.fecha_grab        = TODAY                         
                   Opg_header.fecha_iva         = Lote_pago.fecha_pago          
                   Opg_header.hora              = STRING(TIME,"HH:MM:SS")                           
                   Opg_header.hora_grab         = TIME                          
                   Opg_header.imp_bruto         = 0                             
                   Opg_header.imp_difcambio     = 0                             
                   Opg_header.imp_neto          = 0                             
                   Opg_header.imp_pesos         = 0                             
                   Opg_header.imp_total         = 0                             
                   Opg_header.leyenda           = ""                            
                   Opg_header.leyenda_cc        = ""                            
                   Opg_header.localidad         = Domicilio_prv.localidad       
                   Opg_header.mes               = MONTH(Lote_pago.fecha_pago)   
                   Opg_header.nombre            = Proveedor.nombre               
                   Opg_header.nro_cndventa      = 0                              
                   Opg_header.nro_comprob       = 0                              
                   Opg_header.nro_domicilio     = Domicilio_prv.nro_domicilio    
                   Opg_header.nro_entidad       = 0                              
                   Opg_header.nro_moneda        = Lote_pago.nro_moneda           
                   Opg_header.nro_obra          = 0                              
                   Opg_header.nro_ordpago       = NEXT-VALUE(proxima_transaccion)
                   Opg_header.nro_proveedor     = Proveedor.nro_proveedor
                   Opg_header.nro_transaccion   = 0                  
                   Opg_header.nro_usuario       = Usuario.nro_usuario
                   Opg_header.num_sucursal      = ""       
                   Opg_header.origen            = "A"      
                   Opg_header.pc_name           = v-pc_name
                   Opg_header.prf_comprob       = 0  
                   Opg_header.tipo_pago         = 1
                   Opg_header.tip_comprob       = "OP"
                   Opg_header.tot_iva           = 0  
                   Opg_header.tot_neto          = 0  
                   Opg_header.tot_total         = 0  
                   Opg_header.ultima_linea      = 0.                              .        

        END.

        CREATE Opg_detalle.
        ASSIGN Opg_header.ultima_linea         = Opg_header.ultima_linea + 1
               Opg_detalle.cambio              = 1 /*Lote-factura.cambio*/
               Opg_detalle.cdg_emprecancela    = Opg_header.cdg_empresa 
               Opg_detalle.descuento           = 0
               Opg_detalle.difcambio           = 0
               Opg_detalle.importe             = Lote-factura.importe 
               Opg_detalle.imp_este-pago       = Lote-factura.importe 
               Opg_detalle.imp_pesos           = Lote-factura.importe 
               Opg_detalle.imp_retenibr        = 0
               Opg_detalle.imp_reteniva        = 0
               Opg_detalle.imp_retensus        = 0
               Opg_detalle.nro_cancela         = Lote-factura.nro_comprob 
               Opg_detalle.nro_linea           = Opg_header.ultima_linea
               Opg_detalle.nro_ordpago         = Opg_header.nro_ordpago
               Opg_detalle.nro_vencimiento     = Lote-factura.nro_vencimiento
               Opg_detalle.prf_cancela         = Lote-factura.prf_comprob 
               Opg_detalle.tip_cancela         = Lote-factura.tip_comprob
               Opg_header.imp_total            = Opg_header.imp_total + Lote-factura.importe.

        IF LAST-OF(Proveedor.cdg_proveedor) 
        THEN DO:

            CREATE Caj_header.
            BUFFER-COPY Opg_header TO Caj_header
                ASSIGN  Caj_header.cdg_caja         = Lote_pago.cdg_caja
                        Caj_header.contable         = NO
                        Caj_header.estado           = "E"
                        Caj_header.hora             = TIME 
                        Caj_header.importe          = Opg_header.imp_total
                        Caj_header.ingreso          = Opg_header.imp_total
                        Caj_header.monto_letras     = ""
                        Caj_header.nro_cliente      = 0
                        Caj_header.nro_cuenta       = 0
                        Caj_header.nro_entidad      = 0
                        Caj_header.nro_obra         = 0
                        Caj_header.nro_transaccion  = NEXT-VALUE(proxima_transaccion)
                        Caj_header.origen           = "A"
                        Caj_header.tipo_mov         = "E"
                        Caj_header.ultima_linea     = 1
                        Opg_header.nro_transaccion  = Caj_header.nro_transaccion.

            CREATE Caj_detalle.
            ASSIGN Caj_detalle.cambio          = 0
                   Caj_detalle.cdg_cuenta_ban  = Lote_pago.cdg_cuenta_ban
                   Caj_detalle.cdg_rubro       = Lote_pago.cdg_rubro
                   Caj_detalle.divisas         = 0
                   Caj_detalle.importe         = Caj_header.importe
                   Caj_detalle.nro_cheque      = 0
                   Caj_detalle.nro_entidad     = 0
                   Caj_detalle.nro_linea       = 1
                   Caj_detalle.nro_transaccion = Caj_header.nro_transaccion
                   Caj_detalle.nro_valor       = 0
                   Caj_detalle.observacion     = ""
                   Caj_detalle.tipo_mov        = "E".

            FIND Rubro OF Lote_pago NO-LOCK.
            CASE Rubro.tipo:
                WHEN "D"
                THEN DO:
                END.
                WHEN "P"
                THEN DO:
                END.
                WHEN "A"
                THEN DO:
                END.
            END CASE.

            CREATE Caja-imputacion.
            ASSIGN Caja-imputacion.nro_cuenta        = Familia_proveedor.nro_cuenta
                   Caja-imputacion.nro_entidad       = 0
                   Caja-imputacion.nro_obra          = 0
                   Caja-imputacion.nro_transaccion   = Caj_header.nro_transaccion
                   Caja-imputacion.observacion       = ""
                   Caja-imputacion.valor             = Caj_header.importe.


        END.
        
    END.

/*   
/*---------------------------------------------------------------------------------*/
/*                 TRAEMOS TABLAS RELACIONADAS QUE HARAN FALTA                     */
/*---------------------------------------------------------------------------------*/

    FIND Proveedor  OF Fac_header_prv NO-LOCK.
    FIND Familia_proveedor OF Proveedor NO-LOCK.
    FIND Imputacion OF Fac_header_prv NO-LOCK NO-ERROR.

    RUN getparametro.p (  INPUT  "AUTOLIBE",
                          OUTPUT v-valor_c,
                          OUTPUT v-valor_d,
                          OUTPUT v-valor_l,
                          OUTPUT v-valor_n,
                          OUTPUT v-observacion ).
    v_liberacion = v-valor_l.

    RUN getparametro.p (  INPUT  "AUTOPROG",
                          OUTPUT v-valor_c,
                          OUTPUT v-valor_d,
                          OUTPUT v-valor_l,
                          OUTPUT v-valor_n,
                          OUTPUT v-observacion ).
    v_programacion = v-valor_l.

/*---------------------------------------------------------------------------------*/
/*              MONTO EN LETRAS Y NOMINAMOS EL SUBDIARIO DE VENTAS                 */
/*---------------------------------------------------------------------------------*/
    

    IF Fac_header_prv.leyenda <> ""
        THEN RUN RENGLONS.P (INPUT  Fac_header_prv.leyenda, 
                             INPUT  90,
                             OUTPUT Fac_header_prv.leyenda,
                             INPUT  "|").
/*    
    ASSIGN Sub_header_prv.nombre        = Fac_header_prv.nombre
           Sub_header_prv.cuit          = Fac_header_prv.cuit
           Sub_header_prv.cdg_provincia = Fac_header_prv.cdg_provincia.
*/    
/*---------------------------------------------------------------------------------*/
/* Debe agrearse este campo en Fac_header_prv:                                         */
/*     Sub_header_prv.cdg_tipactiv  = Fac_header_prv.cdg_tipactiv.                     */
/*---------------------------------------------------------------------------------*/

/*---------------------------------------------------------------------------------*/
/*                               CUENTA CORRIENTE                                  */
/*---------------------------------------------------------------------------------*/

 IF Fac_header_prv.nro_rendgastos <> 0
 THEN DO:
     FIND Rendgastos_hd WHERE Rendgastos_hd.nro_rendgastos = Fac_header_prv.nro_rendgastos EXCLUSIVE-LOCK.
     IF Tipocomprobante.debita
         THEN Rendgastos_hd.imp_rendicion = Rendgastos_hd.imp_rendicion - Fac_header_prv.imp_total.
         ELSE Rendgastos_hd.imp_rendicion = Rendgastos_hd.imp_rendicion + Fac_header_prv.imp_total.
 END.
 ELSE DO:
     IF Tipocomprobante.afecta_cc
     THEN DO:
        
        IF Fac_header_prv.cta_cte
        THEN DO:
        
            FIND Condicion_venta OF Fac_header_prv NO-LOCK.
                                                                                  
            IF Condicion_venta.diferencia_iva
               THEN saldo_factura = Fac_header_prv.imp_total - Fac_header_prv.imp_iva.
               ELSE saldo_factura = Fac_header_prv.imp_total.
    
            
            FOR EACH Subcondicion OF Condicion_venta BREAK BY Subcondicion.nro_cndventa:
    
                CREATE Cta_cte_prv.
                ASSIGN Cta_cte_prv.cdg_empresa          = Fac_header_prv.cdg_empresa
                       Cta_cte_prv.tip_comprob          = Fac_header_prv.tip_comprob
                       Cta_cte_prv.prf_comprob          = Fac_header_prv.prf_comprob
                       Cta_cte_prv.nro_comprob          = Fac_header_prv.nro_comprob
                       Cta_cte_prv.nro_vencimiento      = Subcondicion.nro_subcondicion
                       Cta_cte_prv.cambio               = Fac_header_prv.cambio
                       Cta_cte_prv.nro_moneda           = Fac_header_prv.nro_moneda
                       Cta_cte_prv.cdg_imputacion       = Fac_header_prv.cdg_imputacion
                       Cta_cte_prv.cdg_tiporetgan       = Fac_header_prv.cdg_tiporetgan
                       Cta_cte_prv.cdg_tiporetibr       = Fac_header_prv.cdg_tiporetibr
                       Cta_cte_prv.cdg_tiporetiva       = Fac_header_prv.cdg_tiporetiva
                       Cta_cte_prv.cdg_tiporetsus       = Fac_header_prv.cdg_tiporetsus 
                       Cta_cte_prv.fecha_emision        = Fac_header_prv.fecha
                       Cta_cte_prv.fecha_vencimiento    = Fac_header_prv.fecha + Subcondicion.dias
                       Cta_cte_prv.nro_proveedor        = Fac_header_prv.nro_proveedor
                       Cta_cte_prv.imp_neto             = Fac_header_prv.imp_neto
                       Cta_cte_prv.imp_iva              = Fac_header_prv.imp_iva
                       Cta_cte_prv.imp_total            = Fac_header_prv.imp_total
                       Cta_cte_prv.leyenda              = Fac_header_prv.leyenda_cc
                       Cta_cte_prv.liberada             = v_liberacion
                       Cta_cte_prv.programada           = v_programacion.
    
                IF Condicion_venta.diferencia_iva 
                THEN DO:
                     IF Condicion_venta.nro_veniva = Subcondicion.nro_subcondicion
                     THEN DO:
                          IF Tipocomprobante.debita
                          THEN DO:
                               Cta_cte_prv.credito  = 0.
                               Cta_cte_prv.debito   = Fac_header_prv.imp_iva.
                          END.
                          ELSE DO:
                               Cta_cte_prv.credito  = Fac_header_prv.imp_iva.
                               Cta_cte_prv.debito   = 0.
                          END.          
                          Cta_cte_prv.imp_iva = Fac_header_prv.imp_iva.
                     END.
                     ELSE DO:
                          es_ultimo = LAST(Subcondicion.nro_cndventa).
                          RUN calcular_vencimiento.
                     END.   
                END.
                ELSE DO:
                     es_ultimo = LAST(Subcondicion.nro_cndventa).
                     RUN calcular_vencimiento.
                END.   
    
                IF v_liberacion
                THEN ASSIGN
                       Cta_cte_prv.imp_programado   = Cta_cte_prv.credito 
                       Cta_cte_prv.fecha_programada = Cta_cte_prv.fecha_vencimiento 
                       Cta_cte_prv.liberada         = YES
                       Cta_cte_prv.programada       = YES.
    
            END.
    
            IF Fac_header_prv.prc_canje <> 0
            THEN DO:
                 RUN hacer_canje.
            END.
    
        END.
    
     END.
 END.

 rid_factura = ROWID(Fac_header_prv).

 RELEASE Parametro.        
 RELEASE Fac_header_prv.
 RELEASE Fac_detalle_prv.
 RELEASE Cta_cte_prv.
 RELEASE Rendgastos_hd.
*/
END. /* Finaliza la transaccion de emision */
/*
/*---------------------------------------------------------------------------------*/
/*                         IMPRESION DEL COMPROBANTE                               */
/*---------------------------------------------------------------------------------*/

RUN imprimir_comprobante_proveedor.p ( rid_factura ). 

/*---------------------------------------------------------------------------------*/
/*                                  PROCEDIMIENTOS                                 */
/*---------------------------------------------------------------------------------*/

PROCEDURE calcular_vencimiento:

   IF NOT Condicion_venta.diferencia_iva 
      THEN  aux_importe = ROUND(Fac_header_prv.imp_total * Subcondicion.prc_cancelacion / 100 , 2).
      ELSE  aux_importe = ROUND((Fac_header_prv.imp_total - Fac_header_prv.imp_iva ) * Subcondicion.prc_cancelacion / 100 , 2).

   IF Tipocomprobante.debita
   THEN DO:
        Cta_cte_prv.credito  = 0.
        Cta_cte_prv.debito   = aux_importe.
   END.
   ELSE DO:
        Cta_cte_prv.credito  = aux_importe.
        Cta_cte_prv.debito   = 0.
   END.

   IF es_ultimo
   THEN DO:
      IF Tipocomprobante.debita
      THEN DO:
           Cta_cte_prv.credito  = 0.
           Cta_cte_prv.debito   = saldo_factura.
      END.
      ELSE DO:
           Cta_cte_prv.credito  = saldo_factura.
           Cta_cte_prv.debito   = 0.
      END.
   END.
   ELSE DO:
      saldo_factura = saldo_factura - aux_importe.
   END.
       
END PROCEDURE.       

PROCEDURE hacer_canje:

    RUN getparametro.p (  INPUT  "HABCANJE",
                          OUTPUT v-valor_c,
                          OUTPUT v-valor_d,
                          OUTPUT v-valor_l,
                          OUTPUT v-valor_n,
                          OUTPUT v-observacion ).
    IF v-valor_l
       THEN RUN crear_canje.p ( INPUT ROWID(Fac_header_prv)).
       ELSE MESSAGE "Las operaciones de CANJE no se hallan habilitadas en esta instalación"
            VIEW-AS ALERT-BOX WARNING TITLE "AVISO".
            
END PROCEDURE.
*/

PROCEDURE crear_encabezado_opago:



END PROCEDURE.
