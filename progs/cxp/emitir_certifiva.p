/*=================================================================================*/
/*       EMISION E IMPRESION DE CERTIFICADOS DE RETENCION DE I.V.A.                */
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
FIND Empresa OF Opg_header NO-LOCK.

FOR EACH Pagos_x_retiva OF Opg_header NO-LOCK, Tipo_retiva OF Pagos_x_retiva NO-LOCK:

    FIND Parametro WHERE Parametro.cdg_empresa   = Empresa.cdg_empresa 
                     AND Parametro.cdg_parametro = "PXCTFIVA"
                         EXCLUSIVE-LOCK NO-ERROR.

    IF NOT AVAILABLE Parametro
    THEN DO:
         CREATE Parametro.
         ASSIGN 
                Parametro.cdg_empresa   = Empresa.cdg_empresa
                Parametro.cdg_parametro = "PXCTFIVA"
                Parametro.descripcion   = "Proximo numero de cert.ret.IVA a emitir" + PROGRAM-NAME(1)
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

    MESSAGE "por bajar certificado" Pagos_x_retiva.cdg_tiporetiva "numero" Parametro.valor_n
        VIEW-AS ALERT-BOX INFO BUTTONS OK.

    FIND FIRST Caj_detalle OF Caj_header WHERE Caj_detalle.cdg_rubro = Tipo_retiva.cdg_rubro EXCLUSIVE-LOCK.

    CREATE Certificado_iva.
    ASSIGN Certificado_iva.cdg_empresa      = Opg_header.cdg_empresa
           Certificado_iva.cdg_tiporetiva   = Pagos_x_retiva.cdg_tiporetiva
           Certificado_iva.fecha_deposito   = DATE(que_mes,15,que_ano)
           Certificado_iva.fecha_emision    = Opg_header.fecha
           Certificado_iva.imp_retenido     = Pagos_x_retiva.imp_retenido
           Certificado_iva.nro_linea        = Caj_detalle.nro_linea
           Certificado_iva.nro_proveedor    = Opg_header.nro_proveedor
           Certificado_iva.nro_transaccion  = Caj_detalle.nro_transaccion
           Caj_detalle.observacion          = "Nro.Cert.:" + STRING(Certificado_iva.nro_certifiva,"999999")
           Certificado_iva.nro_certifiva    = Parametro.valor_n
           Parametro.valor_n                = Parametro.valor_n + 1.

    FOR EACH Pagos_x_retiva_det WHERE Pagos_x_retiva_det.nro_ordpago = Pagos_x_retiva.nro_ordpago NO-LOCK:

        CREATE Cert_iva-detalle.
        ASSIGN /*Cert_iva-detalle.imp_retenido    = Pagos_x_retiva_det.imp_retenido*/
               Cert_iva-detalle.nro_certifiva   = Certificado_iva.nro_certifiva
               Cert_iva-detalle.nro_comprob     = Pagos_x_retiva_det.nro_comprob
               Cert_iva-detalle.prf_comprob     = Pagos_x_retiva_det.prf_comprob
               Cert_iva-detalle.tip_comprob     = Pagos_x_retiva_det.tip_comprob
             /*Cert_iva-detalle.nro_vencimiento = Pagos_x_retiva_det.nro_vencimiento*/
               Cert_iva-detalle.nro_secuencia   = 0.

    END. /* Termina de recorrer el detalle de Opg para los certificados. */


    RELEASE Parametro.       


    RUN getparametro.p (  INPUT  "EMIRTIVA",
                          OUTPUT v-valor_c,
                          OUTPUT v-valor_d,
                          OUTPUT v-valor_l,
                          OUTPUT v-valor_n,
                          OUTPUT v-observacion ).
    IF NOT v-valor_l 
    THEN DO:
         RUN getparametro.p (  INPUT  "NCOPRIVA",
                               OUTPUT v-valor_c,
                               OUTPUT v-valor_d,
                               OUTPUT v-valor_l,
                               OUTPUT v-valor_n,
                               OUTPUT v-observacion ).
         ncopias = IF AVAILABLE Parametro THEN v-valor_n ELSE 1.
         DO j = 1 TO ncopias:
              RUN PRCTFIVA.P ( INPUT ROWID(Certificado_iva) ).
         END.
    END.     
   
END.    
