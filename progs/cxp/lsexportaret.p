/*===========================================================================================*/
/*     GENERA LOS ARCHIVOS DE EXPORTACION PARA EL PROGRAMA DGI DE EMISION DE RETENCIONES     */
/*===========================================================================================*/

DEFINE INPUT PARAMETER des_fecha AS DATE LABEL "Desde Fecha" FORMAT "99/99/9999".
DEFINE INPUT PARAMETER has_fecha AS DATE LABEL "Hasta Fecha" FORMAT "99/99/9999".

/*===========================================================================================*/
/*                                       VARIABLES                                           */
/*===========================================================================================*/

{VRSHARED.I}
{WGLISTAR.I}

DEFINE VARIABLE r-sujeto     AS CHARACTER FORMAT "X(83)".
DEFINE VARIABLE r-retencion  AS CHARACTER FORMAT "X(192)".
DEFINE VARIABLE org_formato  AS CHARACTER.

DEFINE STREAM Sujetos.
DEFINE STREAM Retenciones.

/*===========================================================================================*/
/*                                       VARIABLES                                           */
/*===========================================================================================*/

org_formato = SESSION:NUMERIC-FORMAT.
SESSION:NUMERIC-FORMAT = "American".

OUTPUT STREAM Sujetos     TO VALUE(dire_tmp + "sujetos.txt").
OUTPUT STREAM Retenciones TO VALUE(dire_tmp + "retenciones.txt").

/*
r-sujeto = "|---+----1----+----2----+----3----+----4----+----5----+----6----+----7----+-----8--|".
PUT STREAM Sujetos r-sujeto SKIP.

r-retencion = "|---+----1----+----2----+----3----+----4----+----5----+----6----+----7----+-----8----+----9----+----1----+----2----+----3----+----4----+----5----+----6----+----7----+-----8----+----9-|".
PUT STREAM Retenciones r-retencion SKIP.
*/

FOR EACH Certificado_gan WHERE Certificado_gan.fecha_emision <= has_fecha
                           AND Certificado_gan.fecha_emision >= des_fecha, 
    Proveedor OF Certificado_gan BREAK BY Proveedor.cdg_proveedor
                                       BY Certificado_gan.fecha_emision:

  IF FIRST-OF(Proveedor.cdg_proveedor) 
     THEN RUN exportar_sujeto.
    
  RUN exportar_comprobante.
  
END.

OUTPUT STREAM Sujetos     CLOSE.          
OUTPUT STREAM Retenciones CLOSE. 

SESSION:NUMERIC-FORMAT = org_formato.

/*===========================================================================================*/
/*                               P R O C E D I M I E N T O S                                 */
/*===========================================================================================*/

PROCEDURE exportar_sujeto:

    DEFINE VARIABLE c AS INTEGER.

    FIND FIRST Domicilio_prv OF Proveedor NO-LOCK.

    r-sujeto = "". c = 1.
    OVERLAY(r-sujeto,c,11) = SUBSTRING(Proveedor.cuit,1,2) + 
                             SUBSTRING(Proveedor.cuit,4,8) + 
                             SUBSTRING(Proveedor.cuit,13,1). c = c + 11.
    OVERLAY(r-sujeto,c,20) = SUBSTRING(Proveedor.nombre,1,20). c = c + 20.
    OVERLAY(r-sujeto,c,20) = SUBSTRING(Domicilio_prv.direccion,1,20). c = c + 20.
    OVERLAY(r-sujeto,c,20) = SUBSTRING(Domicilio_prv.localidad,1,20). c = c + 20.
    OVERLAY(r-sujeto,c,02) = Domicilio_prv.cdg_provincia. c = c + 2.
    OVERLAY(r-sujeto,c,08) = Domicilio_prv.cdg_postal. c = c + 8.
    OVERLAY(r-sujeto,c,02) = "80". c = c + 2.
    
    PUT STREAM Sujetos r-sujeto SKIP.

END PROCEDURE.

PROCEDURE exportar_comprobante:

    DEFINE VARIABLE k AS INTEGER.

    FIND Opg_header OF Certificado_gan NO-LOCK.
    FIND Tipo_actividad OF Certificado_gan NO-LOCK.

    r-retencion = "". k = 1.
    OVERLAY(r-retencion,k,02) = "05". k = k + 2.
    OVERLAY(r-retencion,k,10) = STRING(Certificado_gan.fecha_emision,"99/99/9999"). k = k + 10.
    OVERLAY(r-retencion,k,10) = STRING(Opg_header.nro_comprob,"999999999999"). k = k + 10.
    OVERLAY(r-retencion,k,16) = STRING(Certificado_gan.imp_pagado,"9999999999999.99"). k = k + 16.
    OVERLAY(r-retencion,k,03) = "217". k = k + 3. /* Impuesto 217=ganancias */
    OVERLAY(r-retencion,k,03) = Tipo_actividad.cdg_regimen-gan. k = k + 3.   /* Regimen  */
    OVERLAY(r-retencion,k,01) = "1". k = k + 1.   /* Cod. Operacion 1=retencion*/
    OVERLAY(r-retencion,k,14) = STRING(Certificado_gan.base_imponible,"99999999999.99"). k = k + 14.
    OVERLAY(r-retencion,k,10) = STRING(Certificado_gan.fecha_emision,"99/99/9999"). k = k + 10.
    OVERLAY(r-retencion,k,02) = "01" /*STRING(Proveedor.cdg_condiva,"99")*/. k = k + 2. /* TRADUCIR!!!!! Forzamos 01=Inscripto*/
    OVERLAY(r-retencion,k,14) = STRING(Certificado_gan.imp_retenido,"99999999999.99"). k = k + 14.
    OVERLAY(r-retencion,k,06) = STRING(Proveedor.plib_ganancias,"999.99"). k = k + 6.
    OVERLAY(r-retencion,k,10) = FILL("¿",10). k = k + 10. /* Fecha Boletin, dejamos en blanco */
    OVERLAY(r-retencion,k,02) = "80". k = k + 2.
    OVERLAY(r-retencion,k,20) = SUBSTRING(Proveedor.cuit,1,2) + 
                                SUBSTRING(Proveedor.cuit,4,8) + 
                                SUBSTRING(Proveedor.cuit,13,1). k = k + 20.
    OVERLAY(r-retencion,k,14) = STRING(0,"99999999999999"). k = k + 14.
    OVERLAY(r-retencion,k,30) = FILL(" ",30). k = k + 30. /* Denom. Ordenante  */
    OVERLAY(r-retencion,k,01) = "0". k = k + 1. /* Acrecentamiento   */
    OVERLAY(r-retencion,k,11) = FILL(" ",11). k = k + 11.   /* CUIT del pais */
    OVERLAY(r-retencion,k,11) = FILL(" ",11). k = k + 11.   /* CUIT del ordenante */
    
    PUT STREAM Retenciones r-retencion SKIP.

END PROCEDURE.
