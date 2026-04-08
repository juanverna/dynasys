/*crea una nota de credito basado en una factura a fin de cancelarla*/
DEFINE INPUT PARAMETER pnro LIKE fac_header.nro_factura.
DEFINE VAR tc AS CHAR.
DEFINE TEMP-TABLE T-Fac_header NO-UNDO LIKE Fac_header.       
DEFINE TEMP-TABLE T-Fac_detalle NO-UNDO like Fac_detalle.      
DEFINE TEMP-TABLE T-Registrable-factura NO-UNDO like Registrable-factura .    
DEFINE TEMP-TABLE T-Sub_header_vta NO-UNDO like Sub_header_vta .       
DEFINE TEMP-TABLE T-Sub_detalle_vta NO-UNDO LIKE Sub_detalle_vta.      
DEFINE TEMP-TABLE T-Fac_header-bon NO-UNDO LIKE Fac_header-bon.       
DEFINE TEMP-TABLE T-Fac_detalle-bon NO-UNDO like Fac_detalle-bon.      
DEFINE TEMP-TABLE T-Fac_header_impuesto NO-UNDO like Fac_header_impuesto.  
DEFINE TEMP-TABLE T-Fac_detalle_impuesto NO-UNDO like Fac_detalle_impuesto.
DEFINE BUFFER cc_debitan FOR cta_cte.
DEFINE BUFFER cc_acreditan FOR cta_cte.

FUNCTION pagado 
    RETURNS CHARACTER
  ( /* parameter-definitions */ ) :
    DEF VAR PAGA AS CHAR NO-UNDO.
      FIND cta_cte WHERE
      cta_cte.cdg_empresa = fac_header.cdg_empresa AND
      cta_cte.tip_comprob = fac_header.tip_comprob AND
      cta_cte.prf_comprob = fac_header.prf_comprob AND
      cta_cte.nro_comprob = fac_header.nro_comprob NO-LOCK NO-ERROR.
   
IF AVAILABLE cta_cte THEN DO:
      IF cta_cte.credito = 0 AND cta_cte.debito = 0 THEN paga = "S".
      ELSE DO:
          IF cta_cte.credito = 0 OR cta_cte.debito = 0 
              THEN paga = "N".
              ELSE IF cta_cte.credito = cta_cte.debito 
                  THEN paga = "S".
                  ELSE paga = "P".
      END.
  END.
  ELSE paga = "?".
     
RETURN paga.
END FUNCTION.

FIND fac_header WHERE fac_header.nro_factura = pnro.
IF pagado() <> "N" THEN RETURN ERROR.
fac_header.nro_contrato = 0.
FIND cta_cte WHERE
      cta_cte.cdg_empresa = fac_header.cdg_empresa AND
      cta_cte.tip_comprob = fac_header.tip_comprob AND
      cta_cte.prf_comprob = fac_header.prf_comprob AND
      cta_cte.nro_comprob = fac_header.nro_comprob.
cta_cte.nro_contrato = 0.
create T-Fac_header.
BUFFER-COPY fac_header TO T-Fac_header
    ASSIGN T-Fac_header.nro_comprob = 0
           T-Fac_header.tip_comprob = "N" + substring(fac_header.tip_comprob,2,1)
           T-Fac_header.nro_factura = 0
           T-Fac_header.cdg_comprobante = "CREDICLI"
           T-Fac_header.estado = "P"
           T-Fac_header.impreso = ""
           t-Fac_header.cai = ""
           t-fac_header.nro_contrato = 0
           t-fac_header.fecha = TODAY
           T-fac_header.leyenda_cc = "Sobre Factura " + fac_header.tip_comprob + "-" + string(fac_header.prf_comprob,"9999") + "-" + string(fac_header.nro_comprob,"99999999").
FOR EACH fac_detalle OF fac_header:
    CREATE T-Fac_detalle.
    BUFFER-COPY fac_detalle TO T-Fac_detalle
        ASSIGN T-Fac_detalle.nro_factura = T-Fac_header.nro_factura.
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
FIND FIRST T-Fac_header.
FIND cc_acreditan WHERE
        cc_acreditan.cdg_empresa = t-fac_header.cdg_empresa AND
        cc_acreditan.tip_comprob = t-fac_header.tip_comprob AND
        cc_acreditan.prf_comprob = t-fac_header.prf_comprob AND
        cc_acreditan.nro_comprob = t-fac_header.nro_comprob.
    
        FIND cc_debitan WHERE
            cc_debitan.cdg_empresa = fac_header.cdg_empresa AND
            cc_debitan.tip_comprob = fac_header.tip_comprob AND
            cc_debitan.prf_comprob = fac_header.prf_comprob AND
            cc_debitan.nro_comprob = fac_header.nro_comprob.
        
        CREATE Aplicacion_pagos.                    
                ASSIGN Aplicacion_pagos.cdg_empresa      = CC_debitan.cdg_empresa
                       Aplicacion_pagos.descuento        = 0
                       Aplicacion_pagos.importe          = CC_debitan.debito -
                                                               CC_debitan.credito

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

                       CC_debitan.credito = CC_debitan.debito.
FIND contrato_hd WHERE contrato_hd.nro_contrato = fac_header.nro_contrato.
Contrato_hd.resto_periodos = contrato_hd.resto_periodos + 1.
