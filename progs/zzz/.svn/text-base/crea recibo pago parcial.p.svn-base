        DEFINE BUFFER rr FOR comprobante_rendicion.
        DEFINE BUFFER tt FOR rendicion_hd.
                DEF VAR pago_parcial AS LOGICAL NO-UNDO.
  STOP.      FIND rendicion_hd WHERE nro_rendicion = 10203 NO-ERROR.
        IF NOT AVAILABLE rendicion_hd THEN STOP.
        FIND FIRST comprobante_rendicion OF rendicion_hd.
         FIND fac_header WHERE 
            fac_header.cdg_empresa = comprobante_rendicion.cdg_empresa AND
            fac_header.tip_comprob = "FC" AND
            fac_header.prf_comprob = 9 AND
            fac_header.nro_comprob = 891 NO-LOCK.

        FIND FIRST Cta_cte WHERE Cta_cte.cdg_empresa     = fac_header.cdg_empresa
                          AND Cta_cte.tip_comprob     = "R" + SUBSTRING(fac_header.tip_comprob,2,1) 
                          AND Cta_cte.prf_comprob     = fac_header.prf_comprob
                          AND Cta_cte.nro_comprob     = fac_header.nro_comprob
                          NO-ERROR.
        pago_parcial = AVAILABLE cta_cte.

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
                rec_header.prf_comprob    = fac_header.prf_comprob.

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
               rec_header.nro_comprob   = Parametro.valor_n
               Parametro.valor_n        = Parametro.valor_n + 1.
        END.
        ELSE 
            ASSIGN
               rec_header.nro_comprob   = fac_header.nro_comprob.



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
