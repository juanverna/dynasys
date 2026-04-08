/*=================================================================================*/
/*       BAJA UNA RENDICION A LA BASE DE DATOS Y ACTUALIZA EN CONSECUENCIA         */
/*=================================================================================*/

DEFINE TEMP-TABLE T-Rendicion_hd    NO-UNDO LIKE Rendicion_hd.
DEFINE TEMP-TABLE T-comprobante_rendicion NO-UNDO LIKE comprobante_rendicion.
DEFINE TEMP-TABLE T-Caj_header      NO-UNDO LIKE Caj_header.         
DEFINE TEMP-TABLE T-Caj_detalle     NO-UNDO LIKE Caj_detalle.        
DEFINE TEMP-TABLE T-Caja-imputacion NO-UNDO LIKE Caja-imputacion.    
DEFINE TEMP-TABLE T-Cheque          NO-UNDO LIKE Cheque.             
DEFINE TEMP-TABLE T-Valor           NO-UNDO LIKE Valor.              

/*=================================================================================*/
/*                                PARAMETROS                                       */
/*=================================================================================*/

DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Rendicion_hd.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-comprobante_rendicion.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Caj_header.         
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Caj_detalle.        
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Caja-imputacion.    
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Cheque.             
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Valor.              

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

DEFINE TEMP-TABLE T-Fac_detalle          NO-UNDO LIKE Fac_detalle.
DEFINE TEMP-TABLE T-Fac_detalle-bon      NO-UNDO LIKE Fac_detalle-bon.
DEFINE TEMP-TABLE T-Fac_detalle_impuesto NO-UNDO LIKE Fac_detalle_impuesto.
DEFINE TEMP-TABLE T-Fac_header           NO-UNDO LIKE Fac_header.
DEFINE TEMP-TABLE T-Fac_header-bon       NO-UNDO LIKE Fac_header-bon.
DEFINE TEMP-TABLE T-Fac_header_impuesto  NO-UNDO LIKE Fac_header_impuesto.
DEFINE TEMP-TABLE T-Registrable-factura  NO-UNDO LIKE Registrable-factura.
DEFINE TEMP-TABLE T-Sub_detalle_vta      NO-UNDO LIKE Sub_detalle_vta.
DEFINE TEMP-TABLE T-Sub_header_vta       NO-UNDO LIKE Sub_header_vta.

DEFINE BUFFER N-Rec_header               FOR Rec_header.
DEFINE BUFFER N-Cta_Cte                  FOR Cta_Cte.
DEFINE BUFFER Comprobantefactura         FOR Tipocomprobante.

DEFINE VARIABLE rid_rendicion            AS ROWID.

/*=================================================================================*/
/*                                    PROCESO                                      */
/*=================================================================================*/

DO TRANSACTION:
    FIND FIRST T-Rendicion_hd.
    ASSIGN T-Rendicion_hd.nro_rendicion = NEXT-VALUE(proxima_rendicion).
    
    RUN bajar_valores.

    BUFFER-COPY T-Rendicion_hd TO Rendicion_hd.

    FOR EACH T-comprobante_rendicion WHERE T-comprobante_rendicion.nro_rendicion <> T-Rendicion_hd.nro_rendicion:
        ASSIGN T-comprobante_rendicion.nro_rendicion = T-Rendicion_hd.nro_rendicion.
        CREATE comprobante_rendicion.
        BUFFER-COPY T-comprobante_rendicion TO comprobante_rendicion.
    END.
    
    FOR EACH comprobante_rendicion OF Rendicion_hd, FIRST Fac_header OF comprobante_rendicion EXCLUSIVE-LOCK:
    
        /* ---------------------------------------------- */
        /* Proceso de aplicacion de la cuenta corriente   */
        /* Crea el registro de Rec_header correspondiente */
        /* ---------------------------------------------- */

        IF LOOKUP(SUBSTRING(fac_header.tip_comprob,1,1),"F,D") <> 0 
        THEN DO:
                RUN crear_recibo_factura.   
        END.
        ELSE DO: /* Es un credito, creamos el debito para cancelar */
                RUN crear_nota_debito.   
            
        END.
        
    END.
    
    Rendicion_hd.abierta = NO.
    Rendicion_hd.st_tesoreria = "1".
    
    rid_rendicion = ROWID(Rendicion_hd).
    FIND rubro WHERE rubro.cdg_rubro = 100 NO-LOCK.
    FIND FIRST caj_detalle Of caj_header WHERE rubro.cdg_rubro = caj_detalle.cdg_rubro NO-LOCK NO-ERROR.
        IF AVAILABLE caj_detalle THEN RUN pgenerahatprov.p ( caj_header.nro_transaccion ).

    RELEASE fac_header.
    RELEASE Rendicion_hd.

END.

/* no es nesesario en este caso
RUN prinvale.p ( INPUT rid_rendicion ).
*/


/*=================================================================================*/
/*                        P R O C E D I M I E N T O S                              */
/*=================================================================================*/

PROCEDURE crear_recibo_factura:
    /*como primer recibo se crea el recibo con el mismo numero de la factura
      si se realizo un pago parcial, RP en vez R con numeracion independiente
      son RECIBCLP ( Recibos de Pago Parcial )*/

    DEF VAR pago_parcial AS LOGICAL NO-UNDO.
    DEF VAR nrorec AS INT NO-UNDO.
    FIND FIRST Cta_cte WHERE Cta_cte.cdg_empresa     = fac_header.cdg_empresa
                      AND Cta_cte.tip_comprob     = "R" + SUBSTRING(fac_header.tip_comprob,2,1) 
                      AND Cta_cte.prf_comprob     = fac_header.prf_comprob
                      AND Cta_cte.nro_comprob     = fac_header.nro_comprob
                      NO-ERROR.
    pago_parcial = AVAILABLE cta_cte.

    IF pago_parcial THEN DO:
        FIND tipocomprobante WHERE tipocomprobante.tip_comprob = "RP" NO-ERROR.
        IF NOT AVAILABLE tipocomprobante THEN DO:
            MESSAGE "ERROR DE IMPLEMENTACION - NO PROSIGA " SKIP
                "NO SE ENCUENTRA LA DEFINICION DE RECIBOS DE PAGO PARCIAL" VIEW-AS ALERT-BOX ERROR.
            undo,LEAVE.
        END.
        FIND Parametro WHERE Parametro.cdg_parametro = Tipocomprobante.prefijo_contador + STRING(Fac_header.prf_comprob,"9999") 
              AND Parametro.cdg_empresa   = Fac_header.cdg_empresa 
                 EXCLUSIVE-LOCK NO-ERROR.

        IF NOT AVAILABLE Parametro
        THEN DO:
             CREATE Parametro.
             ASSIGN Parametro.cdg_empresa   = Fac_header.cdg_empresa
                    Parametro.cdg_parametro = Tipocomprobante.prefijo_contador + STRING(Fac_header.prf_comprob,"9999") 
                    Parametro.descripcion   = "Contador autoagregado por " + PROGRAM-NAME(1)
                    Parametro.observacion   = ""
                    Parametro.tipo          = "N"
                    Parametro.valor_n       = 1.
        END.         
        ASSIGN
           nrorec   = Parametro.valor_n
           Parametro.valor_n        = Parametro.valor_n + 1.
    END.
    ELSE 
        ASSIGN
           nrorec   = fac_header.nro_comprob.

        CREATE  Rec_header.
        BUFFER-COPY Fac_header TO Rec_header
        ASSIGN  Rec_header.nro_usuario    = Rendicion_hd.nro_usuario 
                Rec_header.nro_rendicion  = Rendicion_hd.nro_rendicion 
                Rec_header.nro_cobrador   = Rendicion_hd.nro_cobrador 
                Rec_header.fecha          = Rendicion_hd.fch_rendicion 
                Rec_header.nro_recibo     = NEXT-VALUE(proxima_transaccion) 
                Rec_header.origen         = "A"            
                Rec_header.imp_total      = comprobante_rendicion.este_pago 
                Rec_header.imp_bruto      = comprobante_rendicion.este_pago
                Rec_header.tip_comprob    = IF pago_parcial THEN "RP" ELSE "R" + SUBSTRING(Fac_header.tip_comprob,2,1)
                Rec_header.ultima_linea   = 1
                rec_header.prf_comprob    = fac_header.prf_comprob
                rec_header.nro_comprob    = nrorec.

    
    RUN TOLETRAS.P (INPUT  Rec_header.imp_total, OUTPUT Rec_header.monto_letras ).

    CREATE Rec_detalle.
    ASSIGN Rec_detalle.descuento       = 0.0  
           Rec_detalle.importe         = comprobante_rendicion.este_pago
           Rec_detalle.nro_recibo      = Rec_header.nro_recibo
           Rec_detalle.nro_moneda      = Rec_header.nro_moneda
           Rec_detalle.nro_linea       = 1
           Rec_detalle.tip_cancela     = Fac_header.tip_comprob
           Rec_detalle.prf_cancela     = Fac_header.prf_comprob
           Rec_detalle.nro_cancela     = Fac_header.nro_comprob
           Rec_detalle.nro_vencimiento = 1.

    CREATE Totales_recibo.
    BUFFER-COPY Rec_header TO Totales_recibo.
    RUN emitir_recibo.p ( INPUT ROWID(Rec_header) ) .

END PROCEDURE.

PROCEDURE crear_nota_debito:

    RUN borrar_tablas_temporales.
    
    FIND FIRST Relacion_comprobante 
         WHERE Relacion_comprobante.cdg_comproborigen = Fac_header.cdg_comprobante
           AND Relacion_comprobante.cdg_empresa       = Fac_header.cdg_empresa
           AND Relacion_comprobante.modo_relacion     = "A" /* (S)iguiente o (A)nula */
               NO-LOCK NO-ERROR.
    IF NOT AVAILABLE relacion_comprobante THEN DO:
        MESSAGE "ERROR de IMPLEMENTACION" SKIP
            "No prosiga si avisar" SKIP
            "Falta relacion comprobante " Fac_header.cdg_comprobante " tipo A para empresa " Fac_header.cdg_empresa
            VIEW-AS ALERT-BOX ERROR.
        RETURN ERROR.
    END.


    FIND Comprobantefactura 
        WHERE Comprobantefactura.cdg_comprobante = Relacion_comprobante.cdg_comprobdestino 
          AND Comprobantefactura.cdg_empresa     = Relacion_comprobante.cdg_empresa
              NO-LOCK.

    CREATE  T-Fac_header.
    BUFFER-COPY Fac_header TO T-Fac_header
        ASSIGN  T-Fac_header.nro_usuario        = Rendicion_hd.nro_usuario 
                T-Fac_header.fecha              = Rendicion_hd.fch_rendicion 
                T-Fac_header.nro_factura        = NEXT-VALUE(proxima_transaccion) 
                T-Fac_header.origen             = "A"      
                T-Fac_header.tip_comprob        = "D" + SUBSTRING(Fac_header.tip_comprob,2,1)
                T-Fac_header.cdg_comprobante    = Comprobantefactura.cdg_comprobante.

    RUN TOLETRAS.P (INPUT  T-Fac_header.imp_total, OUTPUT T-Fac_header.monto_letras ).

    FOR EACH Fac_detalle OF Fac_header:
        CREATE T-Fac_detalle.
        BUFFER-COPY Fac_detalle TO T-Fac_detalle
             ASSIGN T-Fac_detalle.nro_factura = 0
                    T-Fac_detalle.detallada = "RN-0000-" + string(Rendicion_hd.nro_rendicion,"99999999").
    END.

    RUN emitir_comprobante_cliente.p ( 
                          INPUT-OUTPUT TABLE T-Fac_header,
                          INPUT-OUTPUT TABLE T-Fac_detalle,
                          INPUT-OUTPUT TABLE T-Registrable-factura,
                          INPUT-OUTPUT TABLE T-Sub_header_vta,
                          INPUT-OUTPUT TABLE T-Sub_detalle_vta,
                          INPUT-OUTPUT TABLE T-Fac_header-bon,
                          INPUT-OUTPUT TABLE T-Fac_detalle-bon,
                          INPUT-OUTPUT TABLE T-Fac_header_impuesto,
                          INPUT-OUTPUT TABLE T-Fac_detalle_impuesto).
            /*aplicacion entre los documentos cancelados*/
    FIND FIRST t-fac_header.

    FIND FIRST Cta_cte WHERE Cta_cte.cdg_empresa  = fac_header.cdg_empresa
                      AND Cta_cte.tip_comprob     = Fac_header.tip_comprob  
                      AND Cta_cte.prf_comprob     = Fac_header.prf_comprob  
                      AND Cta_cte.nro_comprob     = Fac_header.nro_comprob  
                      NO-ERROR.
    FIND FIRST N-Cta_cte WHERE N-Cta_cte.cdg_empresa  = t-fac_header.cdg_empresa
                      AND N-Cta_cte.tip_comprob       = t-Fac_header.tip_comprob  
                      AND N-Cta_cte.prf_comprob       = t-Fac_header.prf_comprob  
                      AND N-Cta_cte.nro_comprob       = t-Fac_header.nro_comprob  
                      NO-ERROR.
    
                    CREATE Aplicacion_pagos.                    
                    ASSIGN Aplicacion_pagos.cdg_empresa      = cta_cte.cdg_empresa
                           Aplicacion_pagos.descuento        = 0
                           Aplicacion_pagos.importe          = cta_cte.credito - cta_cte.debito
   
                                          /* documento cancelado ( o aplicado ) */
                
                           Aplicacion_pagos.tip_comprob      = cta_cte.tip_comprob
                           Aplicacion_pagos.prf_comprob      = cta_cte.prf_comprob
                           Aplicacion_pagos.nro_comprob      = cta_cte.nro_comprob
                           Aplicacion_pagos.nro_vencimiento  = cta_cte.nro_vencimiento
                
                                          /* documento que cancela ( o aplicador ) */
                
                           Aplicacion_pagos.tip_cancela      = N-cta_cte.tip_comprob
                           Aplicacion_pagos.prf_cancela      = N-cta_cte.prf_comprob
                           Aplicacion_pagos.nro_cancela      = N-cta_cte.nro_comprob
                           Aplicacion_pagos.nro_ven_cancela  = N-cta_cte.nro_vencimiento
   
   
                                        /* actualizacion de saldos de comprobantes */
   
                           N-cta_cte.credito = N-cta_cte.credito + Aplicacion_pagos.importe
                           N-cta_cte.debito = N-cta_cte.credito
                           cta_cte.debito = cta_cte.credito
                           cta_cte.selectado = NO
                           N-cta_cte.selectado  = NO.


END PROCEDURE.

PROCEDURE borrar_tablas_temporales :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   EMPTY TEMP-TABLE T-Fac_header.
   EMPTY TEMP-TABLE T-Fac_detalle.
   EMPTY TEMP-TABLE T-Fac_header-bon.
   EMPTY TEMP-TABLE T-Fac_detalle-bon.
   EMPTY TEMP-TABLE T-Sub_detalle_vta.
   EMPTY TEMP-TABLE T-Sub_header_vta.
   EMPTY TEMP-TABLE T-Fac_header_impuesto.
   EMPTY TEMP-TABLE T-Fac_detalle_impuesto.
       
END PROCEDURE.

PROCEDURE bajar_valores:

    FIND Cliente WHERE CLiente.nro_cliente = T-Rendicion_hd.nro_administrador NO-LOCK.

    FIND FIRST T-Caj_header.
    ASSIGN T-Caj_header.nro_transaccion = NEXT-VALUE(proxima_transaccion).
    CREATE Caj_header.
    BUFFER-COPY T-Caj_header TO Caj_header
        ASSIGN Caj_header.cdg_empresa = T-Rendicion_hd.cdg_empresa
               Caj_header.tip_comprob = "RN" /*T-Rendicion_hd.tip_comprob*/
               Caj_header.prf_comprob = 0 /*T-Rendicion_hd.prf_comprob*/
               Caj_header.hora            = TIME
               Caj_header.nro_comprob = T-Rendicion_hd.nro_rendicion
               T-Rendicion_hd.nro_transaccion = Caj_header.nro_transaccion.

    FOR EACH T-Caja-imputacion:
        CREATE Caja-imputacion.
        BUFFER-COPY T-Caja-imputacion TO Caja-imputacion
            ASSIGN Caja-imputacion.nro_transaccion = Caj_header.nro_transaccion.
    END.
    
    FOR EACH T-Caj_detalle WHERE t-Caj_detalle.nro_transaccion  = 0, Rubro OF T-Caj_detalle NO-LOCK:

        CREATE Caj_detalle.
        BUFFER-COPY T-Caj_detalle TO Caj_detalle
            ASSIGN Caj_detalle.nro_transaccion = Caj_header.nro_transaccion
                   t-Caj_detalle.nro_transaccion = Caj_detalle.nro_transaccion
                   t-caj_header.nro_transaccion = Caj_detalle.nro_transaccion.

        CASE Rubro.tipo:
            WHEN "P" 
            THEN DO:
                FIND T-Cheque OF T-Caj_detalle NO-LOCK.
                CREATE Cheque.
                BUFFER-COPY T-Cheque TO Cheque
                    ASSIGN Cheque.nro_transaccion = Caj_header.nro_transaccion
                           Cheque.nro_cheque = NEXT-VALUE(proximo_cheque)
                           Caj_detalle.nro_cheque = Cheque.nro_cheque.
                RELEASE Cheque.
            END.
            WHEN "V" 
            THEN DO:
                FIND T-Valor OF T-Caj_detalle NO-LOCK.
                CREATE Valor.
                BUFFER-COPY T-Valor TO Valor
                    ASSIGN Valor.nro_transaccion = Caj_header.nro_transaccion
                           Valor.nro_valor = NEXT-VALUE(proximo_valor)
                           Valor.fecha_recepcion = Caj_header.fecha
                           Valor.nro_cliente = Cliente.nro_cliente
                           Valor.cdg_caja = Caj_header.cdg_caja
                           Valor.estado = "00"
                           Caj_detalle.nro_valor = Valor.nro_valor.
                RELEASE Valor.
            END.

        END CASE.
        RELEASE Caj_detalle.

    END.
    RUN emitir_movcaja.p ( INPUT ROWID(Caj_header)).
    
END PROCEDURE.




