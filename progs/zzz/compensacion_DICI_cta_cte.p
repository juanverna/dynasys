/*Compensar movimientos DI y CI no pagados(o compensados) menores de 1 peso en forma automatica*/

FUNCTION pagado RETURNS CHARACTER
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
    DEFINE VAR paga AS CHAR NO-UNDO.
    FIND cta_cte WHERE
      cta_cte.cdg_empresa = fac_header.cdg_empresa AND
      cta_cte.tip_comprob = fac_header.tip_comprob AND
      cta_cte.prf_comprob = fac_header.prf_comprob AND
      cta_cte.nro_comprob = fac_header.nro_comprob NO-LOCK NO-ERROR.
  IF AVAILABLE cta_cte THEN DO:
IF cta_cte.credito = 0 and cta_cte.debito = 0  then paga = "S".
else
      IF cta_cte.credito = 0 OR cta_cte.debito = 0 
          THEN paga = "N".
          ELSE IF cta_cte.credito = cta_cte.debito 
              THEN paga = "S".
              ELSE paga = "P".
  END.
  ELSE paga = "?".
     
  RETURN paga.

END FUNCTION.

/*=================================================================================*/
/*                  DEFINICION DE TABLAS TEMPORALES DE ASIENTOS                    */
/*=================================================================================*/

DEFINE TEMP-TABLE T-Fac_header               NO-UNDO LIKE Fac_header.               
DEFINE TEMP-TABLE T-Fac_header-bon           NO-UNDO LIKE Fac_header-bon.
DEFINE TEMP-TABLE T-Registrable-factura      NO-UNDO LIKE Registrable-factura.
DEFINE TEMP-TABLE T-Fac_detalle              NO-UNDO LIKE Fac_detalle.              
DEFINE TEMP-TABLE T-Fac_detalle-bon          NO-UNDO LIKE Fac_detalle-bon.
DEFINE TEMP-TABLE T-Sub_header_vta           NO-UNDO LIKE Sub_header_vta.           
DEFINE TEMP-TABLE T-Sub_detalle_vta          NO-UNDO LIKE Sub_detalle_vta.          
DEFINE TEMP-TABLE T-Fac_header_impuesto      NO-UNDO LIKE Fac_header_impuesto.      
DEFINE TEMP-TABLE T-Fac_detalle_impuesto     NO-UNDO LIKE Fac_detalle_impuesto.     
DEFINE TEMP-TABLE T-Asn_header               NO-UNDO LIKE Asn_header.
DEFINE TEMP-TABLE T-Asn_detalle              NO-UNDO LIKE Asn_detalle.
DEFINE TEMP-TABLE T-Asn_totales              NO-UNDO LIKE Asn_totales.
DEFINE BUFFER CC_acreditan FOR Cta_cte.
DEFINE BUFFER CC_debitan FOR Cta_cte.
DEFINE BUFFER Moneda_local         FOR Moneda.

{modoscompensacion.i}
{parlocales.i}

/*=================================================================================*/
/*                              BLOQUE PRINCIPAL                                   */
/*=================================================================================*/
{FINDempresa.i}
FOR EACH fac_header WHERE NOT fac_header.anulado AND fac_header.prf_comprob = 99:
    
    IF fac_header.imp_total > 1 THEN NEXT.
    IF pagado() <> "N" THEN NEXT.
       EMPTY TEMP-TABLE T-Fac_header.               
   EMPTY TEMP-TABLE T-Fac_detalle.              
   EMPTY TEMP-TABLE T-Sub_header_vta.           
   EMPTY TEMP-TABLE T-Sub_detalle_vta.          
   EMPTY TEMP-TABLE T-Fac_header_impuesto.      
   EMPTY TEMP-TABLE T-Fac_detalle_impuesto. 
   RUN compensar_cuenta_corriente.
/*compensar CI con DI*/
/*ojo que esto es solo para esta compensacion ya que anula completamente el impacto en la CC*/
             FIND FIRST t-fac_header NO-ERROR.   
             
             FIND CC_acreditan where
                 CC_acreditan.tip_comprob = fac_header.tip_comprob AND
                 CC_acreditan.nro_comprob = fac_header.nro_comprob AND
                 CC_acreditan.prf_comprob = fac_header.prf_comprob AND
                 CC_acreditan.cdg_empresa = fac_header.cdg_empresa EXCLUSIVE-LOCK.
             FIND CC_debitan where
                 CC_debitan.tip_comprob = t-fac_header.tip_comprob AND
                 CC_debitan.nro_comprob = t-fac_header.nro_comprob AND
                 CC_debitan.prf_comprob = t-fac_header.prf_comprob AND
                 CC_debitan.cdg_empresa = t-fac_header.cdg_empresa EXCLUSIVE-LOCK.
   
             CREATE Aplicacion_pagos.                    
             ASSIGN Aplicacion_pagos.cdg_empresa      = CC_acreditan.cdg_empresa
                    Aplicacion_pagos.descuento        = 0
                    Aplicacion_pagos.importe          = fac_header.imp_total
                                    
                                  /* documento cancelado ( o aplicado ) */
        
                    Aplicacion_pagos.tip_cancela      = CC_debitan.tip_comprob
                    Aplicacion_pagos.prf_cancela      = CC_debitan.prf_comprob
                    Aplicacion_pagos.nro_cancela      = CC_debitan.nro_comprob
                    Aplicacion_pagos.nro_ven_cancela  = CC_debitan.nro_vencimiento
        
                                  /* documento que cancela ( o aplicador ) */
        
                    Aplicacion_pagos.tip_comprob      = CC_acreditan.tip_comprob
                    Aplicacion_pagos.prf_comprob      = CC_acreditan.prf_comprob
                    Aplicacion_pagos.nro_comprob      = CC_acreditan.nro_comprob
                    Aplicacion_pagos.nro_vencimiento  = CC_acreditan.nro_vencimiento
   
   
                                /* actualizacion de saldos de comprobantes */
   
                    CC_acreditan.debito = CC_acreditan.debito + Aplicacion_pagos.importe
                    CC_debitan.credito = CC_debitan.credito + Aplicacion_pagos.importe
                    CC_debitan.selectado = NO.
                    CC_acreditan.selectado = NO.
END.
   

/*=================================================================================*/
/*                              PROCEDIMIENTOS                                     */
/*=================================================================================*/

PROCEDURE compensar_cuenta_corriente:
   
   
   EMPTY TEMP-TABLE T-Fac_header.               
   EMPTY TEMP-TABLE T-Fac_detalle.              
   EMPTY TEMP-TABLE T-Sub_header_vta.           
   EMPTY TEMP-TABLE T-Sub_detalle_vta.          
   EMPTY TEMP-TABLE T-Fac_header_impuesto.      
   EMPTY TEMP-TABLE T-Fac_detalle_impuesto.     

   /*realiza el contra movimiento de CI un DI Y viseversa Y los compensa*/
   /*Que comprobante anula*/
   FIND relacion_comprobante WHERE Relacion_comprobante.cdg_comproborigen = fac_header.cdg_comprobante 
       AND modo_relacion = "A" NO-LOCK.
       .
       

   CREATE T-Fac_header.
   BUFFER-COPY fac_header TO T-Fac_header 
        ASSIGN T-Fac_header.origen            = "R"
               T-Fac_header.estado            = "P"
               T-Fac_header.cta_cte           = YES 
               T-Fac_header.nro_factura       = 0
               T-Fac_header.hora              = ""
               T-Fac_header.fecha             = TODAY
               T-Fac_header.fecha_iva         = T-Fac_header.fecha
               T-Fac_header.fecha_precios     = T-Fac_header.fecha
               T-Fac_header.impreso           = ""
               T-Fac_header.imp_total         = ABS(fac_header.imp_total )
               T-Fac_header.mes               = MONTH(T-Fac_header.fecha) 
               T-Fac_header.ano               = YEAR(T-Fac_header.fecha)
               t-fac_header.cdg_comprobante   = Relacion_comprobante.cdg_comprobdestino
               T-Fac_header.prf_comprob       = Fac_header.prf_comprob
               Fac_header.ultima_linea        = 0
               T-Fac_header.nro_comprob       = T-Fac_header.nro_factura.

   FOR EACH fac_detalle OF fac_header:
               CREATE T-Fac_detalle.
               ASSIGN T-Fac_header.ultima_linea  = T-Fac_header.ultima_linea + 1
                      T-Fac_detalle.nro_factura  = T-Fac_header.nro_factura
                      T-Fac_detalle.nro_linea    = T-Fac_header.ultima_linea
                      T-Fac_detalle.cantidad     = 1
                      T-Fac_detalle.granel       = 1
                      T-Fac_detalle.nro_articulo = fac_detalle.nro_articulo
                      T-Fac_detalle.detallada    = "COMPENSACION AUT." + T-Fac_detalle.detallada
                      T-Fac_detalle.precio       = T-Fac_header.imp_total.
   END.
   
   RUN emitir_comprobante_cliente.p ( INPUT-OUTPUT TABLE T-Fac_header,
                                      INPUT-OUTPUT TABLE T-Fac_detalle,
                                      INPUT-OUTPUT TABLE T-Registrable-factura,
                                      INPUT-OUTPUT TABLE T-Sub_header_vta,
                                      INPUT-OUTPUT TABLE T-Sub_detalle_vta,
                                      INPUT-OUTPUT TABLE T-Fac_header-bon,
                                      INPUT-OUTPUT TABLE T-Fac_detalle-bon,
                                      INPUT-OUTPUT TABLE T-Fac_header_impuesto,
                                      INPUT-OUTPUT TABLE T-Fac_detalle_impuesto).

END PROCEDURE.
