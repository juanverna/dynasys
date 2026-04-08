/*=================================================================================*/
/*         IMPRESION DE CERTIFICADO DE RETENCION DE INGRESOS BRUTOS                */
/*=================================================================================*/

DEFINE INPUT PARAMETER que_certificado AS ROWID.

{VRSHARED.I}
{VPERSINM.I}
{NOMMESES.I}

DEFINE VARIABLE que_mes  AS CHARACTER FORMAT "X(15)".
DEFINE VARIABLE que_ano  AS CHARACTER FORMAT "X(4)".
DEFINE VARIABLE f-titulo AS CHARACTER FORMAT "X(75)".

DEFINE FRAME frm-certificado
    "Establecimientos San Ignacio S.A."
    "CONSTANCIA DE RETENCION NRO:"  TO 70
    Certificado_ibr.nro_certifibr AT 71
    SKIP
    "Ruta Nac. 11 Km 447 - TE (0342)4950900"
    "Fecha:" TO 70
    Certificado_ibr.fecha_emision       AT 71
    SKIP
    "(3017) Sauce Viejo - Pcia. de Santa Fe" 
    SKIP
    "====================================================================================="
    SKIP
    "IMPUESTO SOBRE LOS INGRESOS BRUTOS"
    SKIP
    "PROVINCIA DE SANTA FE                          Agente de Retencion Nro.: 450-100948-8" 
    SKIP
    "-------------------------------------------------------------------------------------"
    SKIP
    "Contribuyente                : ["
    Proveedor.cdg_proveedor
    "]"
    Proveedor.nombre
    SKIP 
    "Domicilio                    :"
    Domicilio_prv.direccion
    SKIP 
    "                             :"
    Provincia.nombre
    SKIP 
    "Inscripcion Ingresos Brutos  :"
    Proveedor.numero_ibr
    SKIP 
    "Orden de Pago                :" Opg_header.nro_comprob 
    SKIP
    "=====================================================================================" SKIP
    " Comprobante          Fecha   Base  Imponible     Alicuota     Total Retenido         " SKIP
    "-------------------------------------------------------------------------------------"
     WITH USE-TEXT STREAM-IO WIDTH 132 NO-LABEL.

FORM 
    Cert_ibr-detalle.tip_comprob     
    Cert_ibr-detalle.prf_comprob     
    Cert_ibr-detalle.nro_comprob  FORMAT "99999999"
    SPACE(3)
    Cta_cte_prv.fecha_emision
    SPACE(3)
    Cert_ibr-detalle.base_imponible    
    SPACE(5)
    Cert_ibr-detalle.alicuota    
    SPACE(7)
    Cert_ibr-detalle.imp_retenido    
    WITH USE-TEXT STREAM-IO WIDTH 132 NO-LABEL DOWN FRAME frm-detalle.

/*=================================================================================*/
/*                                BLOQUE PRINCIPAL                                 */
/*=================================================================================*/

DO TRANSACTION:

    FIND FIRST Empresa.
    FIND Certificado_ibr  WHERE ROWID(Certificado_ibr) = que_certificado EXCLUSIVE-LOCK.
    FIND Proveedor           OF Certificado_ibr NO-LOCK.
    FIND FIRST Domicilio_prv OF Proveedor NO-LOCK.
    FIND Provincia           OF Domicilio_prv NO-LOCK.
    FIND Tipo_retibr         OF Certificado_ibr NO-LOCK.
    FIND Opg_header       WHERE Opg_header.nro_transaccion = Certificado_ibr.nro_transaccion NO-LOCK.
    
    que_mes = nom_mes [ MONTH(Certificado_ibr.fecha_deposito) ].
    que_ano = STRING(YEAR(Certificado_ibr.fecha_deposito),"9999").
    
    OUTPUT TO PRINTER PAGE-SIZE 36.
    
    PUT CONTROL CHR(18).
    PUT CONTROL "~033C$".
    PUT CONTROL CHR(27) + CHR(67) + CHR(0) + CHR(36). /* Hoja de 6 pulgadas */
    
    DISPLAY Certificado_ibr.nro_certifibr
            Certificado_ibr.fecha_emision       
            Certificado_ibr.imp_retenido
            Certificado_ibr.imp_pagado 
            Proveedor.cdg_proveedor
            Proveedor.cdg_proveedor
            Proveedor.nombre
            Proveedor.numero_ibr
            Provincia.nombre
            Domicilio_prv.direccion
            Provincia.nombre
            Opg_header.nro_comprob
            WITH FRAME frm-certificado.
    
    FOR EACH Cert_ibr-detalle OF Certificado_ibr NO-LOCK:
    
        FIND FIRST Cta_cte_prv 
             WHERE Cta_cte_prv.nro_comprob      = Cert_ibr-detalle.nro_comprob 
               AND Cta_cte_prv.prf_comprob      = Cert_ibr-detalle.prf_comprob 
               AND Cta_cte_prv.tip_comprob      = Cert_ibr-detalle.tip_comprob
               AND Cta_cte_prv.nro_vencimiento  = Cert_ibr-detalle.nro_vencimiento
               AND Proveedor.nro_proveedor      = Cta_cte_prv.nro_proveedor 
                   NO-LOCK.

        DISPLAY Cert_ibr-detalle.tip_comprob     
                Cert_ibr-detalle.prf_comprob     
                Cert_ibr-detalle.nro_comprob     
                Cta_cte_prv.fecha_emision
                Cert_ibr-detalle.base_imponible    
                Cert_ibr-detalle.alicuota    
                Cert_ibr-detalle.imp_retenido    
                WITH FRAME frm-detalle.
                
       DOWN WITH FRAME frm-detalle.         
                
    END.
    
    UNDERLINE
        Cert_ibr-detalle.tip_comprob     
        Cert_ibr-detalle.prf_comprob     
        Cert_ibr-detalle.nro_comprob     
        Cta_cte_prv.fecha_emision
        Cert_ibr-detalle.base_imponible    
        Cert_ibr-detalle.alicuota    
        Cert_ibr-detalle.imp_retenido    
        WITH FRAME frm-detalle.
    
    DISPLAY
        Certificado_ibr.imp_pagado   @ Cert_ibr-detalle.base_imponible    
        Certificado_ibr.imp_retenido @ Cert_ibr-detalle.imp_retenido    
        WITH FRAME frm-detalle.
    
    PAGE.   
    OUTPUT CLOSE.
    
    Certificado_ibr.emitido = YES.
    
END.
