/*=================================================================================*/
/*  IMPRESION DE CERTIFICADO DE RETENCION DE GANANCIAS MODELO DE SAN IGNACIO       */
/*=================================================================================*/

DEFINE INPUT PARAMETER que_certificado AS ROWID.

/*{VRSHARED.I}
{VPERSINM.I}*/
{NOMMESES.I}

DEFINE VARIABLE que_fecha AS CHARACTER FORMAT "X(25)".
DEFINE VARIABLE que_mes   AS CHARACTER FORMAT "X(15)".
DEFINE VARIABLE que_ano   AS CHARACTER FORMAT "X(4)".

DEFINE VARIABLE importe_subtotal         LIKE Certificado_gan.imp_pagado.
DEFINE VARIABLE acumulado_actual         LIKE Certificado_gan.imp_pagado.
DEFINE VARIABLE total_retenido_del_mes   LIKE Certificado_gan.imp_pagado.

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

ASSIGN
    importe_subtotal        = Certificado_gan.base_imponible + 
                              Certificado_gan.imponible_anterior
    acumulado_actual        = importe_subtotal - Certificado_gan.no_sujeto_a_retencion
    total_retenido_del_mes  = Certificado_gan.imp_retenido + 
                              Certificado_gan.total_retenido_anterior.
    que_fecha               = TRIM(nom_mes [ MONTH(Certificado_gan.fecha_deposito) ]) + 
                              " de " + 
                              STRING(YEAR(Certificado_gan.fecha_deposito),"9999") + ".".

OUTPUT TO "./prl/certfgan.txt".

PUT "C01," + STRING(Certificado_gan.nro_certifgan,"999999") FORMAT "X(10)" SKIP.
PUT "C02," + STRING(Certificado_gan.fecha_emision,"99/99/9999") FORMAT "X(14)" SKIP.
PUT "C03," + "(" + Proveedor.cdg_proveedor + ") " + Proveedor.nombre FORMAT "X(50)" SKIP.
PUT "C04," + Domicilio_prv.direccion FORMAT "X(50)" SKIP.
PUT "C05," + "(" + Domicilio_prv.cdg_postal  + ") " + Domicilio_prv.localidad FORMAT "X(50)" SKIP.
PUT "C06," + Provincia.nombre FORMAT "X(50)" SKIP.
PUT "C07," + Proveedor.cuit FORMAT "X(20)" SKIP.
PUT "C08," + Tipo_actividad.nom_tipactiv FORMAT "X(40)" SKIP.
PUT "C09," + STRING(Opg_header.nro_comprob,"999999") FORMAT "X(10)" SKIP.
PUT "C10," + STRING(Certificado_gan.imp_pagado,"ZZ,ZZZ,ZZ9.99") FORMAT "X(18)" SKIP.
PUT "C11," + STRING(Certificado_gan.base_imponible,"ZZ,ZZZ,ZZ9.99") FORMAT "X(18)" SKIP.
PUT "C12," + STRING(Certificado_gan.imponible_anterior,"ZZ,ZZZ,ZZ9.99") FORMAT "X(18)" SKIP.
PUT "C13," + STRING(importe_subtotal,"ZZ,ZZZ,ZZ9.99") FORMAT "X(18)" SKIP.
PUT "C14," + STRING(Certificado_gan.no_sujeto_a_retencion,"ZZ,ZZZ,ZZ9.99") FORMAT "X(18)" SKIP.
PUT "C15," + STRING(acumulado_actual,"ZZ,ZZZ,ZZ9.99") FORMAT "X(18)" SKIP.
PUT "C16," + STRING(Certificado_gan.alicuota,"ZZ,ZZZ,ZZ9.99") FORMAT "X(18)" SKIP.
PUT "C17," + STRING(total_retenido_del_mes,"ZZ,ZZZ,ZZ9.99") FORMAT "X(18)" SKIP.
PUT "C18," + STRING(Certificado_gan.total_retenido_anterior,"ZZ,ZZZ,ZZ9.99") FORMAT "X(18)" SKIP.
PUT "C19," + STRING(Certificado_gan.imp_retenido,"ZZ,ZZZ,ZZ9.99") FORMAT "X(18)" SKIP.
PUT "C20," + que_fecha FORMAT "X(25)" SKIP.
PUT "!PAGE!" SKIP.

OUTPUT CLOSE.
Certificado_gan.emitido = YES.

OS-COMMAND SILENT ".\prl\proform .\prl\certfgan.prn < .\prl\certfgan.txt > .\prl\impresion.lst".
OS-COMMAND SILENT "copy .\prl\impresion.lst prn /b".
