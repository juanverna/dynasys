/*=================================================================================*/
/*                    EMISION DE FACTURAS/DEVOLUCIONES A CLIENTES                  */
/*=================================================================================*/

DEFINE TEMP-TABLE T-Fac_header_prv               NO-UNDO LIKE Fac_header_prv.
DEFINE TEMP-TABLE T-Fac_detalle_prv              NO-UNDO LIKE Fac_detalle_prv.
DEFINE TEMP-TABLE T-Sub_header_prv               NO-UNDO LIKE Sub_header_prv.
DEFINE TEMP-TABLE T-Sub_detalle_prv              NO-UNDO LIKE Sub_detalle_prv.
DEFINE TEMP-TABLE T-Fac_header_prv_impuesto      NO-UNDO LIKE Fac_header_prv_impuesto.
DEFINE TEMP-TABLE T-Fac_detalle_prv_impuesto     NO-UNDO LIKE Fac_detalle_prv_impuesto.
                                                                                                   
/*=================================================================================*/
/*                        DEFINICION DE PARAMETROS                                 */
/*=================================================================================*/

DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Fac_header_prv.
DEFINE INPUT PARAMETER TABLE FOR T-Fac_detalle_prv.
DEFINE INPUT PARAMETER TABLE FOR T-Sub_header_prv. 
DEFINE INPUT PARAMETER TABLE FOR T-Sub_detalle_prv.
DEFINE INPUT PARAMETER TABLE FOR T-Fac_header_prv_impuesto.
DEFINE INPUT PARAMETER TABLE FOR T-Fac_detalle_prv_impuesto.

/*=================================================================================*/
/*                          VARIABLES Y BUFFERS                                    */
/*=================================================================================*/

{VRSHARED.I "new"}

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

DEFINE VARIABLE que_rutina            AS CHARACTER.

DEFINE VARIABLE equiv_granel          LIKE Fac_detalle_prv.granel.

DEFINE VARIABLE v-mes                 LIKE Fac_header_prv.mes.
DEFINE VARIABLE v-ano                 LIKE Fac_header_prv.ano.
DEFINE VARIABLE v-prox_docum          AS CHARACTER.

DEFINE VARIABLE v-tip_comprob         LIKE T-Fac_header_prv.tip_comprob.
DEFINE VARIABLE v-prf_comprob         LIKE T-Fac_header_prv.prf_comprob.
DEFINE VARIABLE v-nro_comprob         LIKE T-Fac_header_prv.nro_comprob.

/*=================================================================================*/
/*                          TRANSACCION PROPIAMENTE DICHA                          */
/*=================================================================================*/

/*---------------------------------------------------------------------------------*/
/*              ASIGNAMOS EL NUMERO SI EL COMPROBANTE ES AUTONUMERADO              */
/*---------------------------------------------------------------------------------*/

FOR EACH T-Fac_header_prv EXCLUSIVE-LOCK:

    FIND Tipocomprobante OF T-Fac_header_prv NO-LOCK.
    FIND Condicion_impos OF T-Fac_header_prv NO-LOCK.

    IF Tipocomprobante.autonumerado
    THEN DO:

        ASSIGN
            v-tip_comprob = T-Fac_header_prv.tip_comprob
            v-prf_comprob = T-Fac_header_prv.prf_comprob
            v-nro_comprob = T-Fac_header_prv.nro_comprob.

        FIND FIRST Tipo_puntovta OF Tipocomprobante
            WHERE Tipo_puntovta.preferido 
              AND Tipo_puntovta.cdg_empresa = T-Fac_header_prv.cdg_empresa NO-LOCK.

        v-prox_docum = Tipocomprobante.prefijo_contador + STRING(Tipo_puntovta.cdg_puntovta,"9999").
        T-Fac_header_prv.tip_comprob =  Tipocomprobante.tip_comprob.    
        T-Fac_header_prv.prf_comprob = Tipo_puntovta.cdg_puntovta.
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
/*
/*---------------------------------------------------------------------------------*/
/*                      RECALCULO DEL COMPROBANTE                                  */
/*---------------------------------------------------------------------------------*/

    RUN calcular_diferencia_cambio.p (
                             INPUT-OUTPUT TABLE T-Fac_header_prv,
                             INPUT-OUTPUT TABLE T-Fac_detalle_prv,
                             INPUT-OUTPUT TABLE T-Sub_header_prv,
                             INPUT-OUTPUT TABLE T-Sub_detalle_prv,
                             INPUT-OUTPUT TABLE T-Fac_header_prv_impuesto,
                             INPUT-OUTPUT TABLE T-Fac_detalle_prv_impuesto).
*/
/*---------------------------------------------------------------------------------*/
/*                     BAJAMOS LAS TABLAS TEMPORALES                               */
/*---------------------------------------------------------------------------------*/

    FIND FIRST Vigencia_cai 
         WHERE Vigencia_cai.cdg_empresa = T-Fac_header_prv.cdg_empresa
           AND Vigencia_cai.tip_comprob = T-Fac_header_prv.tip_comprob
           AND Vigencia_cai.prf_comprob = T-Fac_header_prv.prf_comprob
           AND Vigencia_cai.rige_hasta  >= T-Fac_header_prv.fecha
               NO-LOCK NO-ERROR.
    IF AVAILABLE Vigencia_cai
        THEN ASSIGN T-Fac_header_prv.cai = Vigencia_cai.cai
                    T-Fac_header_prv.rige_hasta = Vigencia_cai.rige_hasta.

    CREATE Fac_header_prv.
    BUFFER-COPY T-Fac_header_prv TO Fac_header_prv
        ASSIGN  Fac_header_prv.nro_facprov = NEXT-VALUE(proxima_transaccion).
    
    FOR EACH T-Fac_detalle_prv OF T-Fac_header_prv:
       CREATE Fac_detalle_prv.
       BUFFER-COPY T-Fac_detalle_prv TO Fac_detalle_prv
           ASSIGN  Fac_detalle_prv.nro_facprov = Fac_header_prv.nro_facprov.
    END.
    
    FOR EACH T-Fac_header_prv_impuesto OF T-Fac_header_prv:
       CREATE Fac_header_prv_impuesto.
       BUFFER-COPY T-Fac_header_prv_impuesto TO Fac_header_prv_impuesto
           ASSIGN  Fac_header_prv_impuesto.nro_facprov = Fac_header_prv.nro_facprov.
    END.
    
    FOR EACH T-Fac_detalle_prv_impuesto OF T-Fac_header_prv:
       CREATE Fac_detalle_prv_impuesto.
       BUFFER-COPY T-Fac_detalle_prv_impuesto TO Fac_detalle_prv_impuesto
           ASSIGN  Fac_detalle_prv_impuesto.nro_facprov = Fac_header_prv.nro_facprov.
    END.

    FOR EACH T-Sub_header_prv 
          WHERE T-Sub_header_prv.tip_comprob = v-tip_comprob
            AND T-Sub_header_prv.prf_comprob = v-prf_comprob
            AND T-Sub_header_prv.nro_comprob = v-nro_comprob:

        CREATE Sub_header_prv.
        BUFFER-COPY T-Sub_header_prv TO Sub_header_prv
            ASSIGN Sub_header_prv.tip_comprob = T-Fac_header_prv.tip_comprob
                   Sub_header_prv.prf_comprob = T-Fac_header_prv.prf_comprob
                   Sub_header_prv.nro_comprob = T-Fac_header_prv.nro_comprob.

    END.

    FOR EACH T-Sub_detalle_prv 
          WHERE T-Sub_detalle_prv.tip_comprob = v-tip_comprob
            AND T-Sub_detalle_prv.prf_comprob = v-prf_comprob
            AND T-Sub_detalle_prv.nro_comprob = v-nro_comprob:

        CREATE Sub_detalle_prv.
        BUFFER-COPY T-Sub_detalle_prv TO Sub_detalle_prv
            ASSIGN Sub_detalle_prv.tip_comprob = T-Fac_header_prv.tip_comprob
                   Sub_detalle_prv.prf_comprob = T-Fac_header_prv.prf_comprob
                   Sub_detalle_prv.nro_comprob = T-Fac_header_prv.nro_comprob.

    END.

    
/*---------------------------------------------------------------------------------*/
/*                 TRAEMOS TABLAS RELACIONADAS QUE HARAN FALTA                     */
/*---------------------------------------------------------------------------------*/

    FIND Proveedor  OF Fac_header_prv NO-LOCK.
    FIND Familia_proveedor OF Proveedor NO-LOCK.
    FIND Imputacion OF Fac_header_prv NO-LOCK NO-ERROR.
  /*FIND Deposito OF Fac_header_prv NO-LOCK.*/
    
/*---------------------------------------------------------------------------------*/
/*                                  MONTO EN LETRAS                                */
/*---------------------------------------------------------------------------------*/
    
    RUN TOLETRAS.P (INPUT  Fac_header_prv.imp_total, OUTPUT Fac_header_prv.monto_letras ).

/*---------------------------------------------------------------------------------*/
/*                               CUENTA CORRIENTE                                  */
/*---------------------------------------------------------------------------------*/

    IF Tipocomprobante.afecta_cc
    THEN DO:
    
        IF Fac_header_prv.cta_cte
        THEN DO:
        
           FIND Condicion_venta OF Fac_header_prv NO-LOCK.
           ASSIGN
                v-mes = Fac_header_prv.mes
                v-ano = Fac_header_prv.ano
                saldo_factura = Fac_header_prv.imp_total
                aux_nro_vencimiento = 0.
        
           FOR EACH Subcondicion OF Condicion_venta BREAK BY Subcondicion.nro_cndventa:
        
               aux_nro_vencimiento = aux_nro_vencimiento + 1.

               CREATE Cta_cte_prv.
               BUFFER-COPY Fac_header_prv TO Cta_cte_prv
                   ASSIGN Cta_cte_prv.nro_vencimiento      = aux_nro_vencimiento
                          Cta_cte_prv.fecha_emision        = Fac_header_prv.fecha
                          Cta_cte_prv.leyenda              = Fac_header_prv.leyenda_cc
                          Cta_cte_prv.mes                  = v-mes
                          Cta_cte_prv.ano                  = v-ano
                          Cta_cte_prv.es_difcambio         = YES.
        
               IF Condicion_venta.dias = 0 
               THEN DO: /* Modo fechas en sumar dias  */
                    Cta_cte_prv.fecha_vencimiento    = Fac_header_prv.fecha + Subcondicion.dias.
               END.
               ELSE DO: /* Modo fechas en sumar meses */
                    RUN sumarmeses.p ( INPUT Cta_cte_prv.fecha_emision, 
                                       INPUT Subcondicion.dias, 
                                       OUTPUT Cta_cte_prv.fecha_vencimiento ).    
               END.
        
               v-mes = v-mes + 1.
               IF v-mes = 13 
               THEN DO:
                    v-mes = 1.
                    v-ano = v-ano + 1.
               END.
        
               IF Condicion_venta.diferencia_iva AND Condicion_venta.nro_veniva = aux_nro_vencimiento
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
               END.
               ELSE DO:
                  es_ultimo = LAST(Subcondicion.nro_cndventa).
                  RUN calcular_vencimiento.
               END.   
        
           END.
           /*    
           act_ctacte = ROWID(Cta_cte_prv).
           RUN ACUMCCTE.P (INPUT "A").
           */
        END.

    END.
    
    rid_factura = ROWID(Fac_header_prv).
    
    RELEASE Parametro.        
    RELEASE Fac_header_prv.
    RELEASE Fac_detalle_prv.
    RELEASE Cta_cte_prv.

/*---------------------------------------------------------------------------------*/
/*                         IMPRESION DEL COMPROBANTE                               */
/*---------------------------------------------------------------------------------*/

  /*RUN imprimir_comprobante_proveedor.p ( rid_factura ). */

END. /* Finaliza la transaccion de emision */

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

