/*=================================================================================*/
/*           EMISION E IMPRESION DE CERTIFICADOS DE RETENCION DE SUSS              */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_opago AS ROWID.

{parlocales.i}
{VPERSINM.I}

DEFINE VARIABLE que_mes             AS INTEGER.
DEFINE VARIABLE que_ano             AS INTEGER.

DEFINE VARIABLE ncopias             AS INTEGER.
DEFINE VARIABLE j                   AS INTEGER.

/*=================================================================================*/
/*                                 BLOQUE PRINCIPAL                                */
/*=================================================================================*/

FIND Opg_header WHERE ROWID(Opg_header) = rid_opago NO-LOCK.
FIND Caj_header WHERE Caj_header.nro_transaccion = Opg_header.nro_transaccion NO-LOCK.   

FOR EACH Caj_detalle EXCLUSIVE-LOCK OF Caj_header, Rubro OF Caj_detalle:

       IF Rubro.es_retencion = "SUS" /* El rubro es una retencion de Ingresos Brutos */
       THEN DO:
      
          {findempresa.i}
    
          FIND Parametro WHERE Parametro.cdg_empresa   = Empresa.cdg_empresa 
                           AND Parametro.cdg_parametro = "PXCTFSUS"
                               EXCLUSIVE-LOCK NO-ERROR.
     
          IF NOT AVAILABLE Parametro
          THEN DO:
             CREATE Parametro.
             ASSIGN 
                    Parametro.cdg_empresa   = Empresa.cdg_empresa
                    Parametro.cdg_parametro = "PXCTFSUS"
                    Parametro.descripcion   = "Proximo numero de cert.ret.In.Brutos a emitir" + PROGRAM-NAME(1)
                    Parametro.observacion   = ""
                    Parametro.tipo          = "N"
                    Parametro.valor_n       = 1.
          END.        

          que_ano = YEAR(Opg_header.fecha).
          que_mes = MONTH(Opg_header.fecha) + 1.
          IF que_mes = 13 
          THEN DO:
             que_ano = que_ano + 1.
             que_mes = 1.
          END.  

          CREATE Certificado_sus.
          ASSIGN Certificado_sus.cdg_tiporetsus   = Opg_header.cdg_tiporetsus
                 Certificado_sus.fecha_deposito   = DATE(que_mes,15,que_ano)
                 Certificado_sus.fecha_emision    = Opg_header.fecha
                 Certificado_sus.imp_retenido     = Caj_detalle.importe
                 Certificado_sus.imp_pagado       = Opg_header.imp_total
                 Certificado_sus.nro_certifsus    = Parametro.valor_n
                 Certificado_sus.nro_linea        = Caj_detalle.nro_linea
                 Certificado_sus.nro_proveedor    = Opg_header.nro_proveedor
                 Certificado_sus.nro_transaccion  = Caj_detalle.nro_transaccion
                 Parametro.valor_n                = Parametro.valor_n + 1.

          ASSIGN
                 Caj_detalle.observacion          = "Nro.Cert.:" + 
                                                     STRING(Certificado_sus.nro_certifsus,"999999").

          RUN armar_detalle.
          
          RELEASE Parametro.       

          RUN getparametro.p (  INPUT  "EMIRTSUS",
                                OUTPUT v-valor_c,
                                OUTPUT v-valor_d,
                                OUTPUT v-valor_l,
                                OUTPUT v-valor_n,
                                OUTPUT v-observacion ).
          IF NOT v-valor_l 
          THEN DO:
               RUN getparametro.p (  INPUT  "NCOPRSUS",
                                     OUTPUT v-valor_c,
                                     OUTPUT v-valor_d,
                                     OUTPUT v-valor_l,
                                     OUTPUT v-valor_n,
                                     OUTPUT v-observacion ).
               ncopias = IF AVAILABLE Parametro THEN v-valor_n ELSE 1.
               DO j = 1 TO ncopias:
                    RUN PRCTFSUS.P ( INPUT ROWID(Certificado_sus) ).
               END.
          END.     
          
       END.          

END.    

/*=================================================================================*/
/*                                PROCEDIMIENTOS                                   */
/*=================================================================================*/

PROCEDURE armar_detalle:

    FOR EACH Opg_detalle OF Opg_header WHERE Opg_detalle.imp_retensus <> 0:
    
          CREATE Cert_sus-detalle.
          ASSIGN Cert_sus-detalle.imp_retenido    = Opg_detalle.imp_retensus
                 Cert_sus-detalle.alicuota        = Opg_detalle.alicuota_sus
                 Cert_sus-detalle.nro_certifsus   = Certificado_sus.nro_certifsus
                 Cert_sus-detalle.nro_comprob     = Opg_detalle.nro_cancela
                 Cert_sus-detalle.prf_comprob     = Opg_detalle.prf_cancela
                 Cert_sus-detalle.tip_comprob     = Opg_detalle.tip_cancela
                 Cert_sus-detalle.nro_vencimiento = Opg_detalle.nro_vencimiento.
    
          FIND FIRST Cta_cte_prv 
               WHERE Cta_cte_prv.nro_proveedor   = Opg_header.nro_proveedor
                 AND Cta_cte_prv.tip_comprob     = Opg_detalle.tip_cancela
                 AND Cta_cte_prv.prf_comprob     = Opg_detalle.prf_cancela
                 AND Cta_cte_prv.nro_comprob     = Opg_detalle.nro_cancela 
                 AND Cta_cte_prv.nro_vencimiento = Opg_detalle.nro_vencimiento NO-LOCK.
      
               /* Halla el importe neto del pago y la retencion correspondiente */
      
          IF Opg_detalle.importe = Cta_cte_prv.imp_total
          THEN DO:
               Cert_sus-detalle.base_imponible = Cta_cte_prv.imp_neto.
          END.
          ELSE DO:
               Cert_sus-detalle.base_imponible = ROUND( Opg_detalle.importe * 
                               ( Cta_cte_prv.imp_neto / Cta_cte_prv.imp_total ), 2) .
          END.
    
    END.

END PROCEDURE.
