DEFINE VARIABLE v-mes         LIKE Fac_header.mes.                   
DEFINE VARIABLE v-ano         LIKE Fac_header.ano.                   
DEFINE VARIABLE saldo_factura LIKE Fac_header.imp_total.
DEFINE VARIABLE aux_importe   LIKE Fac_header.imp_total.
DEFINE VARIABLE aux_nro_vencimiento AS INTEGER.
DEFINE VARIABLE es_ultimo     AS LOGICAL.

OUTPUT TO "c:\sic-temp\logctacte.txt".

FOR EACH Fac_header WHERE NOT Fac_header.anulado:

    FIND FIRST Cta_cte WHERE Cta_cte.cdg_empresa = Fac_header.cdg_empresa
                         AND Cta_cte.tip_comprob = Fac_header.tip_comprob
                         AND Cta_cte.prf_comprob = Fac_header.prf_comprob
                         AND Cta_cte.nro_comprob = Fac_header.nro_comprob
                             NO-LOCK NO-ERROR.
    IF NOT AVAILABLE Cta_cte
    THEN DO:
        FIND Cliente         OF Fac_header NO-LOCK.
        FIND Condicion_venta OF Fac_header NO-LOCK.
        FIND Tipocomprobante OF Fac_header NO-LOCK.
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
                       Cta_cte.nro_cobrador         = Cliente.nro_cobrador.

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
    
        DISPLAY  Cta_cte.cdg_empresa
                 Cta_cte.tip_comprob
                 Cta_cte.prf_comprob
                 Cta_cte.nro_comprob
                 Cta_cte.debito
                 Cta_cte.credito
                 Fac_header.imp_total
                  WITH STREAM-IO FRAME aa DOWN WIDTH 360.

       DOWN WITH FRAME aa.

       IF Tipocomprobante.debita
       THEN DO:
            Cta_cte.credito  = Cta_cte.debito.
       END.
       ELSE DO:
            Cta_cte.debito   = Cta_cte.credito.
       END.          

       IF Tipocomprobante.debita
       THEN DO:

           CREATE  Rec_header.
           BUFFER-COPY Fac_header TO Rec_header
               ASSIGN  Rec_header.nro_recibo      = Fac_header.nro_factura /*NEXT-VALUE(proxima_transaccion) */
                       Rec_header.cdg_comprobante =  IF Fac_header.cdg_comprobante = "FACTUCLI" THEN "RECIBCLI" ELSE "RECIBCLM"
                       Rec_header.origen          = "A"            
                       Rec_header.tip_comprob     = "R" + SUBSTRING(Fac_header.tip_comprob,2,1)
                       Rec_header.nro_cobrador    = 1
                       Rec_header.ultima_linea    = 1.

           CREATE Rec_detalle.
           ASSIGN Rec_detalle.descuento       = 0.0  
                  Rec_detalle.importe         = Fac_header.imp_total
                  Rec_detalle.nro_recibo      = Rec_header.nro_recibo
                  Rec_detalle.nro_moneda      = 1
                  Rec_detalle.nro_linea       = 1
                  Rec_detalle.tip_cancela     = Fac_header.tip_comprob
                  Rec_detalle.prf_cancela     = Fac_header.prf_comprob
                  Rec_detalle.nro_cancela     = Fac_header.nro_comprob
                  Rec_detalle.nro_vencimiento = 1.

           CREATE Totales_recibo.
           BUFFER-COPY Rec_header TO Totales_recibo.

           CREATE Cta_cte.
           BUFFER-COPY Rec_header TO Cta_cte
               ASSIGN Cta_cte.debito            = Rec_header.imp_total
                      Cta_cte.credito           = Rec_header.imp_total
                      Cta_cte.fecha_emision     = Rec_header.fecha
                      Cta_cte.fecha_vencimiento = Rec_header.fecha.

           CREATE Aplicacion_pagos.
           ASSIGN Aplicacion_pagos.cdg_empresa      = Rec_header.cdg_empresa
                  Aplicacion_pagos.importe          = Rec_header.imp_total
                  Aplicacion_pagos.descuento        = Rec_detalle.descuento
                  Aplicacion_pagos.tip_cancela      = Rec_detalle.tip_cancela
                  Aplicacion_pagos.prf_cancela      = Rec_detalle.prf_cancela
                  Aplicacion_pagos.nro_cancela      = Rec_detalle.nro_cancela
                  Aplicacion_pagos.nro_ven_cancela  = Rec_detalle.nro_vencimiento
                  Aplicacion_pagos.tip_comprob      = Rec_header.tip_comprob
                  Aplicacion_pagos.prf_comprob      = Rec_header.prf_comprob
                  Aplicacion_pagos.nro_comprob      = Rec_header.nro_comprob           
                  Aplicacion_pagos.nro_vencimiento  = Cta_cte.nro_vencimiento.

           RUN completar_auditoria.p ( OUTPUT Aplicacion_pagos.nro_usuario,
                                       OUTPUT Aplicacion_pagos.fecha_grab,
                                       OUTPUT Aplicacion_pagos.hora_grab,
                                       OUTPUT Aplicacion_pagos.pc_name).

       END.
                                                
                                                
    END.

END.

OUTPUT CLOSE.

/*===========================================================================================*/
/*                                    PROCEDIMIENTOS                                         */
/*===========================================================================================*/

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
