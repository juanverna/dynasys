/*=================================================================================*/
/*                    EMISION DE FACTURAS/DEVOLUCIONES A CLIENTES                  */
/*=================================================================================*/

DEFINE TEMP-TABLE T-Fac_header               NO-UNDO LIKE Fac_header.
DEFINE TEMP-TABLE T-Fac_detalle              NO-UNDO LIKE Fac_detalle.
DEFINE TEMP-TABLE T-Sub_header_vta           NO-UNDO LIKE Sub_header_vta.
DEFINE TEMP-TABLE T-Sub_detalle_vta          NO-UNDO LIKE Sub_detalle_vta.
DEFINE TEMP-TABLE T-Fac_header_impuesto      NO-UNDO LIKE Fac_header_impuesto.
DEFINE TEMP-TABLE T-Fac_detalle_impuesto     NO-UNDO LIKE Fac_detalle_impuesto.
                                                                                                   
/*=================================================================================*/
/*                        DEFINICION DE PARAMETROS                                 */
/*=================================================================================*/

DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Fac_header.
DEFINE INPUT PARAMETER TABLE FOR T-Fac_detalle.
DEFINE INPUT PARAMETER TABLE FOR T-Sub_header_vta. 
DEFINE INPUT PARAMETER TABLE FOR T-Sub_detalle_vta.
DEFINE INPUT PARAMETER TABLE FOR T-Fac_header_impuesto.
DEFINE INPUT PARAMETER TABLE FOR T-Fac_detalle_impuesto.

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

DEFINE VARIABLE equiv_granel          LIKE Fac_detalle.granel.

DEFINE VARIABLE v-mes                 LIKE Fac_header.mes.
DEFINE VARIABLE v-ano                 LIKE Fac_header.ano.
DEFINE VARIABLE v-prox_docum          AS CHARACTER.

DEFINE VARIABLE v-tip_comprob         LIKE T-Fac_header.tip_comprob.
DEFINE VARIABLE v-prf_comprob         LIKE T-Fac_header.prf_comprob.
DEFINE VARIABLE v-nro_comprob         LIKE T-Fac_header.nro_comprob.

/*=================================================================================*/
/*                          TRANSACCION PROPIAMENTE DICHA                          */
/*=================================================================================*/

/*---------------------------------------------------------------------------------*/
/*              ASIGNAMOS EL NUMERO SI EL COMPROBANTE ES AUTONUMERADO              */
/*---------------------------------------------------------------------------------*/

FOR EACH T-Fac_header EXCLUSIVE-LOCK:

    FIND Tipocomprobante OF T-Fac_header NO-LOCK.
    FIND Condicion_impos OF T-Fac_header NO-LOCK.

    IF Tipocomprobante.autonumerado
    THEN DO:

        ASSIGN
            v-tip_comprob = T-Fac_header.tip_comprob
            v-prf_comprob = T-Fac_header.prf_comprob
            v-nro_comprob = T-Fac_header.nro_comprob.

        FIND FIRST Tipo_puntovta OF Tipocomprobante
            WHERE Tipo_puntovta.preferido 
              AND Tipo_puntovta.cdg_empresa = T-Fac_header.cdg_empresa NO-LOCK.

        v-prox_docum = Tipocomprobante.prefijo_contador + STRING(Tipo_puntovta.cdg_puntovta,"9999").
        T-Fac_header.tip_comprob =  Tipocomprobante.tip_comprob.    
        T-Fac_header.prf_comprob = Tipo_puntovta.cdg_puntovta.
        IF Tipocomprobante.usa_letra
        THEN DO:
            v-prox_docum = REPLACE(v-prox_docum,"*",Condicion_impos.tipo_factura).
            T-Fac_header.tip_comprob = REPLACE(T-Fac_header.tip_comprob,"*",Condicion_impos.tipo_factura).
        END.
    
        FIND Parametro WHERE Parametro.cdg_parametro = v-prox_docum 
                         AND Parametro.cdg_empresa   = T-Fac_header.cdg_empresa 
                             EXCLUSIVE-LOCK NO-ERROR.
    
        IF NOT AVAILABLE Parametro
        THEN DO:
             CREATE Parametro.
             ASSIGN Parametro.cdg_empresa   = T-Fac_header.cdg_empresa
                    Parametro.cdg_parametro = v-prox_docum
                    Parametro.descripcion   = "Contador autoagregado por " + PROGRAM-NAME(1)
                    Parametro.observacion   = ""
                    Parametro.tipo          = "N"
                    Parametro.valor_n       = 1.
        END.         
        
        ASSIGN
           T-Fac_header.nro_comprob = Parametro.valor_n
           Parametro.valor_n        = Parametro.valor_n + 1.

    END.
/*
/*---------------------------------------------------------------------------------*/
/*                      RECALCULO DEL COMPROBANTE                                  */
/*---------------------------------------------------------------------------------*/

    RUN calcular_diferencia_cambio.p (
                             INPUT-OUTPUT TABLE T-Fac_header,
                             INPUT-OUTPUT TABLE T-Fac_detalle,
                             INPUT-OUTPUT TABLE T-Sub_header_vta,
                             INPUT-OUTPUT TABLE T-Sub_detalle_vta,
                             INPUT-OUTPUT TABLE T-Fac_header_impuesto,
                             INPUT-OUTPUT TABLE T-Fac_detalle_impuesto).
*/
/*---------------------------------------------------------------------------------*/
/*                     BAJAMOS LAS TABLAS TEMPORALES                               */
/*---------------------------------------------------------------------------------*/

    FIND FIRST Vigencia_cai 
         WHERE Vigencia_cai.cdg_empresa = T-Fac_header.cdg_empresa
           AND Vigencia_cai.tip_comprob = T-Fac_header.tip_comprob
           AND Vigencia_cai.prf_comprob = T-Fac_header.prf_comprob
           AND Vigencia_cai.rige_hasta  >= T-Fac_header.fecha
               NO-LOCK NO-ERROR.
    IF AVAILABLE Vigencia_cai
        THEN ASSIGN T-Fac_header.cai = Vigencia_cai.cai
                    T-Fac_header.rige_hasta = Vigencia_cai.rige_hasta.

    CREATE Fac_header.
    BUFFER-COPY T-Fac_header TO Fac_header
        ASSIGN  Fac_header.nro_factura = NEXT-VALUE(proxima_transaccion).
    
    FOR EACH T-Fac_detalle OF T-Fac_header:
       CREATE Fac_detalle.
       BUFFER-COPY T-Fac_detalle TO Fac_detalle
           ASSIGN  Fac_detalle.nro_factura = Fac_header.nro_factura.
    END.
    
    FOR EACH T-Fac_header_impuesto OF T-Fac_header:
       CREATE Fac_header_impuesto.
       BUFFER-COPY T-Fac_header_impuesto TO Fac_header_impuesto
           ASSIGN  Fac_header_impuesto.nro_factura = Fac_header.nro_factura.
    END.
    
    FOR EACH T-Fac_detalle_impuesto OF T-Fac_header:
       CREATE Fac_detalle_impuesto.
       BUFFER-COPY T-Fac_detalle_impuesto TO Fac_detalle_impuesto
           ASSIGN  Fac_detalle_impuesto.nro_factura = Fac_header.nro_factura.
    END.

    FOR EACH T-Sub_header_vta 
          WHERE T-Sub_header_vta.tip_comprob = v-tip_comprob
            AND T-Sub_header_vta.prf_comprob = v-prf_comprob
            AND T-Sub_header_vta.nro_comprob = v-nro_comprob:

        CREATE Sub_header_vta.
        BUFFER-COPY T-Sub_header_vta TO Sub_header_vta
            ASSIGN Sub_header_vta.tip_comprob = T-Fac_header.tip_comprob
                   Sub_header_vta.prf_comprob = T-Fac_header.prf_comprob
                   Sub_header_vta.nro_comprob = T-Fac_header.nro_comprob.

    END.

    FOR EACH T-Sub_detalle_vta 
          WHERE T-Sub_detalle_vta.tip_comprob = v-tip_comprob
            AND T-Sub_detalle_vta.prf_comprob = v-prf_comprob
            AND T-Sub_detalle_vta.nro_comprob = v-nro_comprob:

        CREATE Sub_detalle_vta.
        BUFFER-COPY T-Sub_detalle_vta TO Sub_detalle_vta
            ASSIGN Sub_detalle_vta.tip_comprob = T-Fac_header.tip_comprob
                   Sub_detalle_vta.prf_comprob = T-Fac_header.prf_comprob
                   Sub_detalle_vta.nro_comprob = T-Fac_header.nro_comprob.

    END.

    
/*---------------------------------------------------------------------------------*/
/*                 TRAEMOS TABLAS RELACIONADAS QUE HARAN FALTA                     */
/*---------------------------------------------------------------------------------*/

    FIND Cliente  OF Fac_header NO-LOCK.
    FIND Familia_cliente OF Cliente NO-LOCK.
    FIND Imputacion OF Fac_header NO-LOCK NO-ERROR.
  /*FIND Deposito OF Fac_header NO-LOCK.*/
    
/*---------------------------------------------------------------------------------*/
/*                                  MONTO EN LETRAS                                */
/*---------------------------------------------------------------------------------*/
    
    RUN TOLETRAS.P (INPUT  Fac_header.imp_total, OUTPUT Fac_header.monto_letras ).

/*---------------------------------------------------------------------------------*/
/*                               CUENTA CORRIENTE                                  */
/*---------------------------------------------------------------------------------*/
    
    IF Tipocomprobante.afecta_cc
    THEN DO:
    
        IF Fac_header.cta_cte
        THEN DO:
        
           FIND Condicion_venta OF Fac_header NO-LOCK.
           ASSIGN
                v-mes = Fac_header.mes
                v-ano = Fac_header.ano
                saldo_factura = Fac_header.imp_total
                aux_nro_vencimiento = 0.
        
           FOR EACH Subcondicion OF Condicion_venta BREAK BY Subcondicion.nro_cndventa:
        
               aux_nro_vencimiento = aux_nro_vencimiento + 1.
               
               CREATE Cta_cte.
               BUFFER-COPY Fac_header TO Cta_cte
                   ASSIGN Cta_cte.nro_vencimiento      = aux_nro_vencimiento
                          Cta_cte.fecha_emision        = Fac_header.fecha
                          Cta_cte.leyenda              = Fac_header.leyenda_cc
                          Cta_cte.mes                  = v-mes
                          Cta_cte.ano                  = v-ano
                          Cta_cte.es_difcambio         = YES.
        
               IF Condicion_venta.dias = 0 
               THEN DO: /* Modo fechas en sumar dias  */
                    Cta_cte.fecha_vencimiento    = Fac_header.fecha + Subcondicion.dias.
               END.
               ELSE DO: /* Modo fechas en sumar meses */
                    RUN sumarmeses.p ( INPUT Cta_cte.fecha_emision, 
                                       INPUT Subcondicion.dias, 
                                       OUTPUT Cta_cte.fecha_vencimiento ).    
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
                         Cta_cte.credito  = 0.
                         Cta_cte.debito   = Fac_header.imp_iva.
                    END.
                    ELSE DO:
                         Cta_cte.credito  = Fac_header.imp_iva.
                         Cta_cte.debito   = 0.
                    END.          
               END.
               ELSE DO:
                  es_ultimo = LAST(Subcondicion.nro_cndventa).
                  RUN calcular_vencimiento.
               END.   
        
           END.
           /*    
           act_ctacte = ROWID(Cta_cte).
           RUN ACUMCCTE.P (INPUT "A").
           */
        END.

    END.
    
    rid_factura = ROWID(Fac_header).
    
    RELEASE Parametro.        
    RELEASE Fac_header.
    RELEASE Fac_detalle.
    RELEASE Cta_cte.

/*---------------------------------------------------------------------------------*/
/*                         IMPRESION DEL COMPROBANTE                               */
/*---------------------------------------------------------------------------------*/

    RUN imprimir_comprobante_cliente.p ( rid_factura ). 

END. /* Finaliza la transaccion de emision */

/*---------------------------------------------------------------------------------*/
/*                                  PROCEDIMIENTOS                                 */
/*---------------------------------------------------------------------------------*/

PROCEDURE calcular_vencimiento:

   IF NOT Condicion_venta.diferencia_iva 
      THEN  aux_importe = ROUND(Fac_header.imp_total * Subcondicion.prc_cancelacion / 100 , 2).
      ELSE  aux_importe = ROUND((Fac_header.imp_total - Fac_header.imp_iva ) * Subcondicion.prc_cancelacion / 100 , 2).

   IF Tipocomprobante.debita
   THEN DO:
        Cta_cte.credito  = 0.
        Cta_cte.debito   = aux_importe.
   END.
   ELSE DO:
        Cta_cte.credito  = aux_importe.
        Cta_cte.debito   = 0.
   END.

   IF es_ultimo
   THEN DO:
      IF Tipocomprobante.debita
      THEN DO:
           Cta_cte.credito  = 0.
           Cta_cte.debito   = saldo_factura.
      END.
      ELSE DO:
           Cta_cte.credito  = saldo_factura.
           Cta_cte.debito   = 0.
      END.
   END.
   ELSE DO:
      saldo_factura = saldo_factura - aux_importe.
   END.
       
END PROCEDURE.       

