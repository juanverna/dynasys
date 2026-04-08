/*=================================================================================*/
/*         EMISION E IMPRESION DE CERTIFICADOS DE RETENCION DE GANANCIAS           */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_opago AS ROWID.

/*=================================================================================*/
/*                                    VARIABLES                                    */
/*=================================================================================*/

{VPERSINM.I}
{NOMMESES.I}
{parlocales.i}

DEFINE VARIABLE que_mes             AS INTEGER.
DEFINE VARIABLE que_ano             AS INTEGER.

DEFINE VARIABLE ncopias             AS INTEGER.
DEFINE VARIABLE j                   AS INTEGER.

DEFINE VARIABLE monto_imponible_actual AS DECIMAL.

/*=================================================================================*/
/*                                 BLOQUE PRINCIPAL                                */
/*=================================================================================*/

FIND Opg_header WHERE ROWID(Opg_header) = rid_opago NO-LOCK.
FIND Proveedor  OF Opg_header NO-LOCK.
FIND Caj_header WHERE Caj_header.nro_transaccion = Opg_header.nro_transaccion NO-LOCK.   

FOR EACH Caj_detalle EXCLUSIVE-LOCK OF Caj_header, FIRST Rubro OF Caj_detalle WHERE Rubro.es_retencion = "GAN":
    RUN emitir_certificado.      
END.    

/*=================================================================================*/
/*                                PROCEDIMIENTOS                                   */
/*=================================================================================*/

PROCEDURE emitir_certificado:

    FIND Parametro WHERE Parametro.cdg_empresa   = Opg_header.cdg_empresa 
                     AND Parametro.cdg_parametro = "PXCTFGAN"
                         EXCLUSIVE-LOCK NO-ERROR.
    IF NOT AVAILABLE Parametro
    THEN DO:
       CREATE Parametro.
       ASSIGN 
              Parametro.cdg_empresa   = Opg_header.cdg_empresa
              Parametro.cdg_parametro = "PXCTFGAN"
              Parametro.descripcion   = "Proximo numero de cert.ret.gancias. a emitir " + PROGRAM-NAME(1)
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

    FIND FIRST Tipo_actividad  OF Rubro NO-LOCK.
    FIND Pagos_x_actividad OF Opg_header 
        WHERE Pagos_x_actividad.cdg_tiporetgan = Tipo_actividad.cdg_tiporetgan NO-LOCK.

    RELEASE Parametro.       

    /*-----------------------------------------------------------------------------------*/
    /* Verifica si SIC está configurado para emitir el certificado de retencion con la   */
    /* orden de pago en forma simultanea o si esto se realiza en forma diferida          */
    /*-----------------------------------------------------------------------------------*/
    
    RUN getparametro.p (  INPUT  "EMIRTGAN",
                          OUTPUT v-valor_c,
                          OUTPUT v-valor_d,
                          OUTPUT v-valor_l,
                          OUTPUT v-valor_n,
                          OUTPUT v-observacion ).
    IF NOT v-valor_l 
    THEN DO:
         RUN getparametro.p (  INPUT  "NCOPRGAN",
                               OUTPUT v-valor_c,
                               OUTPUT v-valor_d,
                               OUTPUT v-valor_l,
                               OUTPUT v-valor_n,
                               OUTPUT v-observacion ).

         ncopias = IF AVAILABLE Parametro THEN v-valor_n ELSE 1.
         DO j = 1 TO ncopias:
              RUN PRCTFGAN.P ( INPUT ROWID(Certificado_gan) ).
         END.
    END.     

END PROCEDURE.
