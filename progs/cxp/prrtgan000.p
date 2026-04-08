/*=================================================================================*/
/*  IMPRESION DE CERTIFICADO DE RETENCION DE GANANCIAS MODELO DE SAN IGNACIO       */
/*=================================================================================*/

DEFINE INPUT PARAMETER que_certificado AS ROWID.

{VRSHARED.I}
{VPERSINM.I}
{NOMMESES.I}

DEFINE VARIABLE que_fecha AS CHARACTER FORMAT "X(25)".
DEFINE VARIABLE que_mes   AS CHARACTER FORMAT "X(15)".
DEFINE VARIABLE que_ano   AS CHARACTER FORMAT "X(4)".

DEFINE VARIABLE importe_subtotal         LIKE Certificado_gan.imp_pagado.
DEFINE VARIABLE acumulado_actual         LIKE Certificado_gan.imp_pagado.
DEFINE VARIABLE total_retenido_del_mes   LIKE Certificado_gan.imp_pagado.

DEFINE FRAME frm-certificado
    "Establecimientos San Ignacio S.A."
    "CONSTANCIA DE RETENCION NRO:"  TO 70
    Certificado_gan.nro_certifgan AT 71
    SKIP
    "Ruta Nac. 11 Km 447 - TE (0342)4950900"
    "Fecha:" TO 70
    Certificado_gan.fecha_emision       AT 71
    SKIP
    "(3017) Sauce Viejo - Pcia. de Santa Fe" 
    SKIP
    "====================================================================================="
    SKIP
    "IMPUESTO A LAS GANANCIAS"
    SKIP
    "Resol.Gral. Nro. 2784 - DGI   Agente de Retencion Nro. (Reemp.Gral F.372) : 115.857-3" 
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
    "C.U.I.T.                     :"
    Proveedor.cuit
    SKIP 
    "Concepto de la Retencion     :" Tipo_actividad.nom_tipactiv 
    SKIP 
    "Orden de Pago                :" Opg_header.nro_comprob 
    SKIP
    "====================================================================================="
    SKIP
    "Importe del Pago                                       :" Certificado_gan.imp_pagado
    SKIP
    "Monto Imponible                                        :" Certificado_gan.base_imponible
    SKIP
    "Monto Imponible anterior acumulado en el mes           :" Certificado_gan.imponible_anterior
    SKIP
    "                                                       :  --------------------------"
    SKIP
    "                           Subtotal                    :" importe_subtotal
    SKIP
    "Monto no sujeto a retencion                            :" Certificado_gan.no_sujeto_a_retencion
    SKIP
    "                                                       :  --------------------------"
    SKIP
    "Monto Imponible actual acumulado en el mes             :" acumulado_actual
    SKIP
    "                           Alicuota                    :" Certificado_gan.alicuota "%"
    SKIP
    "Retencion total a efectuar en el mes                   :" total_retenido_del_mes
    SKIP
    "Importe anteriormente retenido                         :" Certificado_gan.total_retenido_anterior
    SKIP
    "                                                       :  --------------------------"
    SKIP
    "Importe retenido en este acto                          :" Certificado_gan.imp_retenido
    SKIP
    "====================================================================================="
    SKIP(1)
    "El importe retenido se declara en Formulario 384 correspondiente a " que_fecha
     WITH USE-TEXT STREAM-IO WIDTH 132 NO-LABEL.

/*=================================================================================*/
/*                                BLOQUE PRINCIPAL                                 */
/*=================================================================================*/

FIND FIRST Empresa.

FIND Certificado_gan WHERE ROWID(Certificado_gan) = que_certificado EXCLUSIVE-LOCK.

FIND Proveedor           OF Certificado_gan NO-LOCK.
FIND FIRST Domicilio_prv OF Proveedor       NO-LOCK.
FIND Provincia           OF Domicilio_prv   NO-LOCK.
FIND Tipo_actividad      OF Certificado_gan NO-LOCK.
FIND Opg_header WHERE Opg_header.nro_transaccion = Certificado_gan.nro_transaccion NO-LOCK.

que_mes = nom_mes [ MONTH(Certificado_gan.fecha_deposito) ].
que_ano = STRING(YEAR(Certificado_gan.fecha_deposito),"9999").
que_fecha = TRIM(que_mes) + " de " + que_ano + " .".

ASSIGN
    importe_subtotal        = Certificado_gan.base_imponible + 
                              Certificado_gan.imponible_anterior
    acumulado_actual        = importe_subtotal - Certificado_gan.no_sujeto_a_retencion
    total_retenido_del_mes  = Certificado_gan.imp_retenido + 
                              Certificado_gan.total_retenido_anterior.

OUTPUT TO PRINTER PAGE-SIZE 36.

PUT CONTROL CHR(18).
PUT CONTROL "~033C$".
PUT CONTROL CHR(27) + CHR(67) + CHR(0) + CHR(36). /* Hoja de 6 pulgadas */

DISPLAY Certificado_gan.nro_certifgan
        Certificado_gan.fecha_emision
        Proveedor.cdg_proveedor
        Proveedor.nombre
        Domicilio_prv.direccion
        Provincia.nombre
        Proveedor.cuit
        Tipo_actividad.nom_tipactiv 
        Opg_header.nro_comprob 
        Certificado_gan.imp_pagado
        Certificado_gan.base_imponible
        Certificado_gan.imponible_anterior
        importe_subtotal
        Certificado_gan.no_sujeto_a_retencion
        acumulado_actual
        Certificado_gan.alicuota
        total_retenido_del_mes
        Certificado_gan.total_retenido_anterior
        Certificado_gan.imp_retenido
        que_fecha
        WITH FRAME frm-certificado.

PAGE.

OUTPUT CLOSE.

Certificado_gan.emitido = YES.

