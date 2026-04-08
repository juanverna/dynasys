/*=================================================================================*/
/*     CALCULA TODAS LAS RETENCIONES DE IMPUESTOS QUE DEBEN HACERSE EN UN PAGO     */
/*=================================================================================*/

/*=================================================================================*/
/*                              TABLAS TEMPORALES                                  */
/*=================================================================================*/

DEFINE TEMP-TABLE T-Opg_header              NO-UNDO LIKE Opg_header.
DEFINE TEMP-TABLE T-Opg_detalle             NO-UNDO LIKE Opg_detalle.
DEFINE TEMP-TABLE T-Caj_header              NO-UNDO LIKE Caj_header.    
DEFINE TEMP-TABLE T-Caj_detalle             NO-UNDO LIKE Caj_detalle.    
DEFINE TEMP-TABLE T-Pagos_x_actividad       NO-UNDO LIKE Pagos_x_actividad.    
DEFINE TEMP-TABLE T-Pagos_x_actividad_det   NO-UNDO LIKE Pagos_x_actividad_det.    
DEFINE TEMP-TABLE T-Pagos_x_retiva          NO-UNDO LIKE Pagos_x_retiva.    
DEFINE TEMP-TABLE T-Pagos_x_retiva_det      NO-UNDO LIKE Pagos_x_retiva_det.    
DEFINE TEMP-TABLE T-Pagos_x_retibr          NO-UNDO LIKE Pagos_x_retibr.    
DEFINE TEMP-TABLE T-Pagos_x_retibr_det      NO-UNDO LIKE Pagos_x_retibr_det.    
DEFINE TEMP-TABLE T-Pagos_x_retsus          NO-UNDO LIKE Pagos_x_retsus.    
DEFINE TEMP-TABLE T-Pagos_x_retsus_det      NO-UNDO LIKE Pagos_x_retsus_det.    
DEFINE TEMP-TABLE T-Certificado_gan         NO-UNDO LIKE Certificado_gan. 
DEFINE TEMP-TABLE T-Cert_gan-detalle        NO-UNDO LIKE Cert_gan-detalle. 
DEFINE TEMP-TABLE T-Certificado_iva         NO-UNDO LIKE Certificado_iva. 
DEFINE TEMP-TABLE T-Cert_iva-detalle        NO-UNDO LIKE Cert_iva-detalle.
DEFINE TEMP-TABLE T-Certificado_ibr         NO-UNDO LIKE Certificado_ibr. 
DEFINE TEMP-TABLE T-Cert_ibr-detalle        NO-UNDO LIKE Cert_ibr-detalle.
DEFINE TEMP-TABLE T-Certificado_sus         NO-UNDO LIKE Certificado_sus. 
DEFINE TEMP-TABLE T-Cert_sus-detalle        NO-UNDO LIKE Cert_sus-detalle.

/*=================================================================================*/
/*                                 PARAMETROS                                      */
/*=================================================================================*/

DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Opg_header.             
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Opg_detalle.            
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Caj_header.             
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Caj_detalle.            
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Pagos_x_actividad.      
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Pagos_x_actividad_det.  
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Pagos_x_retiva.         
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Pagos_x_retiva_det.     
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Pagos_x_retibr.         
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Pagos_x_retibr_det.     
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Pagos_x_retsus.         
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Pagos_x_retsus_det.     
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Certificado_gan.        
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Cert_gan-detalle.       
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Certificado_iva.        
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Cert_iva-detalle.       
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Certificado_ibr.        
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Cert_ibr-detalle.       
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Certificado_sus.        
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Cert_sus-detalle.       

/*=================================================================================*/
/*                              VARIABLES LOCALES                                  */
/*=================================================================================*/

DEFINE VARIABLE es_agretiva  AS LOGICAL INITIAL NO.
DEFINE VARIABLE es_agretibr  AS LOGICAL INITIAL NO.
DEFINE VARIABLE es_agretgan  AS LOGICAL INITIAL NO.
DEFINE VARIABLE es_agretsus  AS LOGICAL INITIAL NO.

{parlocales.i}

/*=================================================================================*/
/*                              BLOQUE PRINCIPAL                                   */
/*=================================================================================*/

FIND FIRST T-Opg_header EXCLUSIVE-LOCK.
FIND Empresa OF T-Opg_header NO-LOCK.

/*---------------------------------------------------------------------------------*/
/*           DETERMINA SI ES AGENTE DE RETENCION DE CADA IMPUESTO                  */
/*---------------------------------------------------------------------------------*/

{findparametro.i "AGRETGAN" "es_agretgan" "valor_l"}
{findparametro.i "AGRETIBR" "es_agretibr" "valor_l"}
{findparametro.i "AGRETIVA" "es_agretiva" "valor_l"}
{findparametro.i "AGRETSUS" "es_agretsus" "valor_l"}

FIND Proveedor OF T-Opg_header NO-LOCK.

/*---------------------------------------------------------------------------------*/
/* DETERMINA SI, SIENDO AGENTE DE RETENCION DE CADA IMPUESTO, DEBE RETENERLE       */
/* EL PROVEEDOR EN FUNCION DE LAS EXCEPCIONES QUE EL MISMO PUEDA REGISTRAR         */
/*---------------------------------------------------------------------------------*/

IF es_agretiva 
THEN DO:
    RUN retener_iva.p ( INPUT-OUTPUT TABLE T-Opg_header,      
                        INPUT-OUTPUT TABLE T-Opg_detalle,     
                        INPUT-OUTPUT TABLE T-Caj_header,      
                        INPUT-OUTPUT TABLE T-Caj_detalle,
                        INPUT-OUTPUT TABLE T-Pagos_x_retiva,
                        INPUT-OUTPUT TABLE T-Pagos_x_retiva_det,
                        INPUT-OUTPUT TABLE T-Certificado_iva,     
                        INPUT-OUTPUT TABLE T-Cert_iva-detalle).

    FIND FIRST T-Opg_header.
END.

IF es_agretgan 
THEN DO:
    RUN retener_ganancias.p ( INPUT-OUTPUT TABLE T-Opg_header,      
                              INPUT-OUTPUT TABLE T-Opg_detalle,     
                              INPUT-OUTPUT TABLE T-Caj_header,      
                              INPUT-OUTPUT TABLE T-Caj_detalle,
                              INPUT-OUTPUT TABLE T-Pagos_x_actividad,
                              INPUT-OUTPUT TABLE T-Pagos_x_actividad_det,
                              INPUT-OUTPUT TABLE T-Certificado_gan,
                              INPUT-OUTPUT TABLE T-Cert_gan-detalle). 

    FIND FIRST T-Opg_header.
END.

IF es_agretibr 
THEN DO:
    RUN retener_ibrutos.p ( INPUT-OUTPUT TABLE T-Opg_header,      
                            INPUT-OUTPUT TABLE T-Opg_detalle,     
                            INPUT-OUTPUT TABLE T-Caj_header,      
                            INPUT-OUTPUT TABLE T-Caj_detalle,
                            INPUT-OUTPUT TABLE T-Pagos_x_retibr,
                            INPUT-OUTPUT TABLE T-Pagos_x_retibr_det,
                            INPUT-OUTPUT TABLE T-Certificado_ibr,     
                            INPUT-OUTPUT TABLE T-Cert_ibr-detalle).

    FIND FIRST T-Opg_header.
END.

IF es_agretsus 
THEN DO:
    RUN retener_suss.p ( INPUT-OUTPUT TABLE T-Opg_header,      
                         INPUT-OUTPUT TABLE T-Opg_detalle,     
                         INPUT-OUTPUT TABLE T-Caj_header,      
                         INPUT-OUTPUT TABLE T-Caj_detalle,
                         INPUT-OUTPUT TABLE T-Pagos_x_retsus,
                         INPUT-OUTPUT TABLE T-Pagos_x_retsus_det,
                         INPUT-OUTPUT TABLE T-Certificado_sus,     
                         INPUT-OUTPUT TABLE T-Cert_sus-detalle).

END.
