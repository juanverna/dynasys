/*=================================================================================*/
/*                    EMISION DE FACTURAS/DEVOLUCIONES A CLIENTES                  */
/*=================================================================================*/

DEFINE TEMP-TABLE T-Fac_header_prv               NO-UNDO LIKE Fac_header_prv.
DEFINE TEMP-TABLE T-Fac_detalle_prv              NO-UNDO LIKE Fac_detalle_prv.
DEFINE TEMP-TABLE T-Sub_header_prv               NO-UNDO LIKE Sub_header_prv.
DEFINE TEMP-TABLE T-Sub_detalle_prv              NO-UNDO LIKE Sub_detalle_prv.
DEFINE TEMP-TABLE T-Fac_header_prv_bon           NO-UNDO LIKE Fac_header_prv_bon.
DEFINE TEMP-TABLE T-Fac_detalle_prv_bon          NO-UNDO LIKE Fac_detalle_prv_bon.
DEFINE TEMP-TABLE T-Fac_header_prv_impuesto      NO-UNDO LIKE Fac_header_prv_impuesto.
DEFINE TEMP-TABLE T-Fac_detalle_prv_impuesto     NO-UNDO LIKE Fac_detalle_prv_impuesto.
                                                                                                   
/*=================================================================================*/
/*                        DEFINICION DE PARAMETROS                                 */
/*=================================================================================*/

DEFINE INPUT PARAMETER TABLE FOR T-Fac_header_prv.
DEFINE INPUT PARAMETER TABLE FOR T-Fac_detalle_prv.
DEFINE INPUT PARAMETER TABLE FOR T-Sub_header_prv.
DEFINE INPUT PARAMETER TABLE FOR T-Sub_detalle_prv.
DEFINE INPUT PARAMETER TABLE FOR T-Fac_header_prv_bon.
DEFINE INPUT PARAMETER TABLE FOR T-Fac_detalle_prv_bon.
DEFINE INPUT PARAMETER TABLE FOR T-Fac_header_prv_impuesto.
DEFINE INPUT PARAMETER TABLE FOR T-Fac_detalle_prv_impuesto.

/*=================================================================================*/
/*                          VARIABLES Y BUFFERS                                    */
/*=================================================================================*/

{VRSHARED.I "new"}

DEFINE VARIABLE v_liberacion          AS LOGICAL.
DEFINE VARIABLE v_programacion        AS LOGICAL.

DEFINE VARIABLE rid_factura           AS ROWID.
DEFINE VARIABLE v-debug               AS LOGICAL.
DEFINE VARIABLE es_ultimo             AS LOGICAL.

DEFINE VARIABLE codigo_iva            AS INTEGER INITIAL 1.
DEFINE VARIABLE prciva                LIKE Impuesto.tasa FORMAT "Z,ZZZ,ZZ9.99-".

DEFINE VARIABLE aux_importe           AS DECIMAL.
DEFINE VARIABLE saldo_factura         AS DECIMAL.
DEFINE VARIABLE aux_nro_vencimiento   AS INTEGER.
DEFINE VARIABLE j                     AS INTEGER.
DEFINE VARIABLE ncopias               AS INTEGER.

DEFINE VARIABLE modo_emision          AS INTEGER INITIAL 0.
DEFINE VARIABLE indep                 AS INTEGER INITIAL 0.
DEFINE VARIABLE rem_y_fac             AS INTEGER INITIAL 1.
DEFINE VARIABLE fac_y_rem             AS INTEGER INITIAL 2.
DEFINE VARIABLE lado_a_lado           AS INTEGER INITIAL 3.

DEFINE VARIABLE que_rutina            AS CHARACTER.

DEFINE VARIABLE equiv_granel          LIKE Fac_detalle_prv.granel.

DEFINE VARIABLE v-mes                 LIKE Fac_header_prv.mes.
DEFINE VARIABLE v-ano                 LIKE Fac_header_prv.ano.
DEFINE VARIABLE v-prox_docum   AS CHARACTER.

/*=================================================================================*/
/*                          TRANSACCION PROPIAMENTE DICHA                          */
/*=================================================================================*/

DO TRANSACTION:

/*---------------------------------------------------------------------------------*/
/*              ASIGNAMOS EL NUMERO SI EL COMPROBANTE ES AUTONUMERADO              */
/*---------------------------------------------------------------------------------*/

    FIND FIRST T-Fac_header_prv EXCLUSIVE-LOCK.
    FIND Tipocomprobante OF T-Fac_header_prv NO-LOCK.
    FIND Condicion_impos OF T-Fac_header_prv NO-LOCK.

    IF Tipocomprobante.autonumerado
    THEN DO:

        v-prox_docum = Tipocomprobante.prefijo_contador + STRING(T-Fac_header_prv.prf_comprob,"9999").
        T-Fac_header_prv.tip_comprob =  Tipocomprobante.tip_comprob.    
        IF Tipocomprobante.usa_letra
        THEN DO:
            v-prox_docum = REPLACE(v-prox_docum,"*",Condicion_impos.tipo_factura).
            T-Fac_header_prv.tip_comprob = REPLACE(T-Fac_header_prv.tip_comprob,"*",Condicion_impos.tipo_factura).
        END.
    
        FIND Parametro WHERE Parametro.cdg_parametro = v-prox_docum 
                         AND Parametro.cdg_empresa   = T-Fac_header_prv.cdg_empresa 
                             EXCLUSIVE-LOCK NO-ERROR.
    
        IF NOT AVAILABLE Parametro
        THEN DO:
             CREATE Parametro.
             ASSIGN Parametro.cdg_empresa   = T-Fac_header_prv.cdg_empresa
                    Parametro.cdg_parametro = v-prox_docum
                    Parametro.descripcion   = "Contador autoagregado por " + PROGRAM-NAME(1)
                    Parametro.observacion   = ""
                    Parametro.tipo          = "N"
                    Parametro.valor_n       = 1.
        END.         
        
        ASSIGN
           T-Fac_header_prv.nro_comprob = Parametro.valor_n
           Parametro.valor_n        = Parametro.valor_n + 1.

    END.
/*---------------------------------------------------------------------------------*/
/*                      RECALCULO DEL COMPROBANTE                                  */
/*---------------------------------------------------------------------------------*/

    RUN calcular_comprobante_proveedor.p (
                             INPUT-OUTPUT TABLE T-Fac_header_prv,
                             INPUT-OUTPUT TABLE T-Fac_detalle_prv,
                             INPUT-OUTPUT TABLE T-Sub_header_prv,
                             INPUT-OUTPUT TABLE T-Sub_detalle_prv,
                             INPUT-OUTPUT TABLE T-Fac_header_prv_bon,
                             INPUT-OUTPUT TABLE T-Fac_detalle_prv_bon,
                             INPUT-OUTPUT TABLE T-Fac_header_prv_impuesto,
                             INPUT-OUTPUT TABLE T-Fac_detalle_prv_impuesto).

/*---------------------------------------------------------------------------------*/
/*                     BAJAMOS LAS TABLAS TEMPORALES                               */
/*---------------------------------------------------------------------------------*/

    FIND FIRST T-Fac_header_prv.

    CREATE Fac_header_prv.
    BUFFER-COPY T-Fac_header_prv TO Fac_header_prv
        ASSIGN  Fac_header_prv.nro_facprov = NEXT-VALUE(proxima_transaccion).
    
    FOR EACH T-Fac_detalle_prv:
       CREATE Fac_detalle_prv.
       BUFFER-COPY T-Fac_detalle_prv TO Fac_detalle_prv
           ASSIGN  Fac_detalle_prv.nro_facprov = Fac_header_prv.nro_facprov.
    END.
    
    FOR EACH T-Fac_header_prv_bon:
       CREATE Fac_header_prv_bon.
       BUFFER-COPY T-Fac_header_prv_bon TO Fac_header_prv_bon
           ASSIGN  Fac_header_prv_bon.nro_facprov = Fac_header_prv.nro_facprov.
    END.
    
    FOR EACH T-Fac_detalle_prv_bon:
       CREATE Fac_detalle_prv_bon.
       BUFFER-COPY T-Fac_detalle_prv_bon TO Fac_detalle_prv_bon
           ASSIGN  Fac_detalle_prv_bon.nro_facprov = Fac_header_prv.nro_facprov.
    END.
    
    FOR EACH T-Fac_header_prv_impuesto:
       CREATE Fac_header_prv_impuesto.
       BUFFER-COPY T-Fac_header_prv_impuesto TO Fac_header_prv_impuesto
           ASSIGN  Fac_header_prv_impuesto.nro_facprov = Fac_header_prv.nro_facprov.
    END.
    
    FOR EACH T-Fac_detalle_prv_impuesto:
       CREATE Fac_detalle_prv_impuesto.
       BUFFER-COPY T-Fac_detalle_prv_impuesto TO Fac_detalle_prv_impuesto
           ASSIGN  Fac_detalle_prv_impuesto.nro_facprov = Fac_header_prv.nro_facprov.
    END.

    FOR EACH T-Sub_header_prv:
       CREATE Sub_header_prv.
       BUFFER-COPY T-Sub_header_prv TO Sub_header_prv.
    END.

    FOR EACH T-Sub_detalle_prv:
       CREATE Sub_detalle_prv.
       BUFFER-COPY T-Sub_detalle_prv TO Sub_detalle_prv.
    END.

    
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
    
 IF Tipocomprobante.afecta_cc
 THEN DO:
    
    IF Fac_header_prv.cta_cte
    THEN DO:
    
        FIND Condicion_venta OF Fac_header_prv NO-LOCK.

        IF Condicion_venta.diferencia_iva
           THEN saldo_factura = Fac_header_prv.imp_total - Fac_header_prv.imp_iva.
           ELSE saldo_factura = Fac_header_prv.imp_total.

        aux_nro_vencimiento = 0.
        FOR EACH Subcondicion OF Condicion_venta BREAK BY Subcondicion.nro_cndventa:

            aux_nro_vencimiento = aux_nro_vencimiento + 1.

            CREATE Cta_cte_prv.
            ASSIGN Cta_cte_prv.cdg_empresa          = Fac_header_prv.cdg_empresa
                   Cta_cte_prv.tip_comprob          = Fac_header_prv.tip_comprob
                   Cta_cte_prv.prf_comprob          = Fac_header_prv.prf_comprob
                   Cta_cte_prv.nro_comprob          = Fac_header_prv.nro_comprob
                   Cta_cte_prv.nro_vencimiento      = aux_nro_vencimiento
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
                 IF Condicion_venta.nro_veniva = aux_nro_vencimiento
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

 rid_factura = ROWID(Fac_header_prv).

 RELEASE Parametro.        
 RELEASE Fac_header_prv.
 RELEASE Fac_detalle_prv.
 RELEASE Cta_cte_prv.

END. /* Finaliza la transaccion de emision */
         
/*
OUTPUT TO "c:\sic-temp\emifactu.txt" PAGED.

FOR EACH Fac_detalle_prv OF Fac_header_prv:
    DISPLAY Fac_detalle_prv.a_granel 
            Fac_detalle_prv.cantidad 
            Fac_detalle_prv.costo 
            Fac_detalle_prv.granel 
            Fac_detalle_prv.nro_linea 
            Fac_detalle_prv.precio 
            Fac_detalle_prv.precio_cf 
            Fac_detalle_prv.subtotal_bruto 
            Fac_detalle_prv.subtotal_bruto_cf 
            Fac_detalle_prv.subtotal_neto 
            Fac_detalle_prv.subtotal_neto_cf
            WITH STREAM-IO.
            
END.
OUTPUT CLOSE.
*/

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
