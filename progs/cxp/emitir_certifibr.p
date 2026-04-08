/*=================================================================================*/
/*       EMISION E IMPRESION DE CERTIFICADOS DE RETENCION DE INGRESOS BRUTOS       */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_opago AS ROWID.

/*=================================================================================*/
/*                                 VARIABLES                                       */
/*=================================================================================*/

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

FOR EACH Pagos_x_retibr OF Opg_header WHERE Pagos_x_retibr.imp_retenido <> 0 NO-LOCK, Tipo_retibr OF Pagos_x_retibr NO-LOCK:

    FIND Parametro WHERE Parametro.cdg_empresa   = Empresa.cdg_empresa 
                   AND Parametro.cdg_parametro = "PXCTFIBR"
                       EXCLUSIVE-LOCK NO-ERROR.
    
    IF NOT AVAILABLE Parametro
    THEN DO:
        CREATE Parametro.
        ASSIGN 
            Parametro.cdg_empresa   = Empresa.cdg_empresa
            Parametro.cdg_parametro = "PXCTFIBR"
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
    
    FIND FIRST Caj_detalle OF Caj_header WHERE Caj_detalle.cdg_rubro = Tipo_retibr.cdg_rubro EXCLUSIVE-LOCK.
    
    CREATE Certificado_ibr.
    ASSIGN Certificado_ibr.cdg_empresa      = Opg_header.cdg_empresa
           Certificado_ibr.cdg_tiporetibr   = Pagos_x_retibr.cdg_tiporetibr
           Certificado_ibr.fecha_deposito   = DATE(que_mes,15,que_ano)
           Certificado_ibr.fecha_emision    = Opg_header.fecha
           Certificado_ibr.imp_retenido     = Pagos_x_retibr.imp_retenido
           Certificado_ibr.nro_linea        = Caj_detalle.nro_linea
           Certificado_ibr.nro_proveedor    = Opg_header.nro_proveedor
           Certificado_ibr.nro_transaccion  = Caj_detalle.nro_transaccion
           Caj_detalle.observacion          = "Nro.Cert.:" + STRING(Certificado_ibr.nro_certifibr,"999999")
           Certificado_ibr.nro_certifibr    = Parametro.valor_n
           Parametro.valor_n                = Parametro.valor_n + 1.
    
    FOR EACH Pagos_x_retibr_det WHERE Pagos_x_retibr_det.nro_ordpago = Pagos_x_retibr.nro_ordpago NO-LOCK:

        CREATE Cert_ibr-detalle.
        ASSIGN /*Cert_ibr-detalle.imp_retenido    = Pagos_x_retibr_det.imp_retenido*/
               Cert_ibr-detalle.nro_certifibr   = Certificado_ibr.nro_certifibr
               Cert_ibr-detalle.nro_comprob     = Pagos_x_retibr_det.nro_comprob
               Cert_ibr-detalle.prf_comprob     = Pagos_x_retibr_det.prf_comprob
               Cert_ibr-detalle.tip_comprob     = Pagos_x_retibr_det.tip_comprob.
             /*Cert_ibr-detalle.nro_vencimiento = Pagos_x_retibr_det.nro_vencimiento*/
             /* Cert_ibr-detalle.nro_secuencia   = 0.*/
    
    END. /* Termina de recorrer el detalle de Opg para los certificados. */
    
    
    RELEASE Parametro.       
    
    RUN getparametro.p (  INPUT  "EMIRTIBR",
                        OUTPUT v-valor_c,
                        OUTPUT v-valor_d,
                        OUTPUT v-valor_l,
                        OUTPUT v-valor_n,
                        OUTPUT v-observacion ).
    IF NOT v-valor_l 
    THEN DO:

       RUN getparametro.p (  INPUT  "NCOPRIBR",
                             OUTPUT v-valor_c,
                             OUTPUT v-valor_d,
                             OUTPUT v-valor_l,
                             OUTPUT v-valor_n,
                             OUTPUT v-observacion ).
       ncopias = IF AVAILABLE Parametro THEN v-valor_n ELSE 1.
       DO j = 1 TO ncopias:
            RUN imprimir_certificado_ibr.p ( INPUT ROWID(Certificado_ibr) ).
       END.

    END.     
          
END.          

