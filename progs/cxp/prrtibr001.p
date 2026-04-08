/*=================================================================================*/
/*         IMPRESION DE CERTIFICADO DE RETENCION DE INGRESOS BRUTOS                */
/*=================================================================================*/

DEFINE INPUT PARAMETER que_certificado AS ROWID.
/*
{VRSHARED.I}
{VPERSINM.I}
*/
{NOMMESES.I}

DEFINE VARIABLE nreng       AS INTEGER.
DEFINE VARIABLE nmax_det    AS INTEGER INITIAL 13.
DEFINE VARIABLE linea0      AS INTEGER.

DEFINE VARIABLE que_mes     AS CHARACTER FORMAT "X(15)".
DEFINE VARIABLE que_ano     AS CHARACTER FORMAT "X(4)".
DEFINE VARIABLE f-titulo    AS CHARACTER FORMAT "X(75)".

FUNCTION nomcampo RETURNS CHARACTER (INPUT prefijo AS CHARACTER, INPUT k AS INTEGER).
    RETURN prefijo + STRING(k,"99"). 
END FUNCTION.   

/*=================================================================================*/
/*                                BLOQUE PRINCIPAL                                 */
/*=================================================================================*/

DO TRANSACTION:

    FIND FIRST Empresa.
    FIND Certificado_ibr  WHERE ROWID(Certificado_ibr) = que_certificado EXCLUSIVE-LOCK.
    FIND Proveedor           OF Certificado_ibr NO-LOCK.
    FIND FIRST Domicilio_prv OF Proveedor NO-LOCK.
    FIND Provincia           OF Domicilio_prv NO-LOCK.
    FIND Tipo_retibr      OF Certificado_ibr NO-LOCK.
    FIND Opg_header       WHERE Opg_header.nro_transaccion = Certificado_ibr.nro_transaccion NO-LOCK.
    
    que_mes = nom_mes [ MONTH(Certificado_ibr.fecha_deposito) ].
    que_ano = STRING(YEAR(Certificado_ibr.fecha_deposito),"9999").
    
    OUTPUT TO "./prl/certfibr.txt".
    
    PUT "C01," + STRING(Certificado_ibr.nro_certifibr,"999999") FORMAT "X(10)" SKIP.
    PUT "C02," + STRING(Certificado_ibr.fecha_emision,"99/99/9999") FORMAT "X(14)" SKIP.
    PUT "C03," + "(" + Proveedor.cdg_proveedor + ") " + Proveedor.nombre FORMAT "X(50)" SKIP.
    PUT "C04," + Domicilio_prv.direccion FORMAT "X(50)" SKIP.
    PUT "C05," + "(" + Domicilio_prv.cdg_postal  + ") " + Domicilio_prv.localidad FORMAT "X(50)" SKIP.
    PUT "C06," + Provincia.nombre FORMAT "X(50)" SKIP.
    PUT "C07," + Proveedor.numero_ibr FORMAT "X(20)" SKIP.
    PUT "C08," + Tipo_retibr.nom_retibr FORMAT "X(40)" SKIP.
    PUT "C09," + STRING(Opg_header.nro_comprob,"999999") FORMAT "X(10)" SKIP.

    linea0 = 1.
    FOR EACH Cert_ibr-detalle OF Certificado_ibr NO-LOCK:
    
        FIND FIRST Cta_cte_prv 
             WHERE Cta_cte_prv.nro_comprob      = Cert_ibr-detalle.nro_comprob 
               AND Cta_cte_prv.prf_comprob      = Cert_ibr-detalle.prf_comprob 
               AND Cta_cte_prv.tip_comprob      = Cert_ibr-detalle.tip_comprob
               AND Cta_cte_prv.nro_vencimiento  = Cert_ibr-detalle.nro_vencimiento
               AND Proveedor.nro_proveedor      = Cta_cte_prv.nro_proveedor 
                   NO-LOCK.

        PUT nomcampo( INPUT "DO", INPUT linea0 ) + ","
                    Cert_ibr-detalle.tip_comprob + " " + 
                    STRING(Cert_ibr-detalle.prf_comprob,"9999") + " " +
                    STRING(Cert_ibr-detalle.nro_comprob,"99999999") + "   " +
                    STRING(Cta_cte_prv.fecha_emision,"99/99/99") FORMAT "X(34)" SKIP.

        PUT nomcampo( INPUT "IM", INPUT linea0 ) + ","
                    STRING(Cert_ibr-detalle.base_imponible,"Z,ZZZ,ZZ9.99-") FORMAT "X(18)" SKIP.

        PUT nomcampo( INPUT "CA", INPUT linea0 ) + ","
                    STRING(Cert_ibr-detalle.alicuota,"ZZ9.99") FORMAT "X(12)" SKIP.

        PUT nomcampo( INPUT "CJ", INPUT linea0 ) + "," 
                     STRING(Cert_ibr-detalle.imp_retenido,"Z,ZZZ,ZZ9.99-") FORMAT "X(18)" SKIP.

        linea0 = linea0 + 1.

    END.

    nreng = linea0.
    DO linea0 = nreng TO nmax_det:
        PUT nomcampo( INPUT "DO", INPUT linea0 ) + "," FORMAT "X(22)" SKIP.
        PUT nomcampo( INPUT "IM", INPUT linea0 ) + "," FORMAT "X(18)" SKIP.
        PUT nomcampo( INPUT "CA", INPUT linea0 ) + "," FORMAT "X(18)" SKIP.
        PUT nomcampo( INPUT "CJ", INPUT linea0 ) + "," FORMAT "X(18)" SKIP.
    END.
    
    PUT "F01," + STRING(Certificado_ibr.imp_pagado,"Z,ZZZ,ZZ9.99-") FORMAT "X(18)" SKIP.
    PUT "F02," + STRING(Certificado_ibr.imp_retenido,"Z,ZZZ,ZZ9.99-") FORMAT "X(18)" SKIP.

    PUT "!PAGE!" SKIP.
    OUTPUT CLOSE.

    OS-COMMAND SILENT  ".\prl\proform .\prl\certfibr.prn < .\prl\certfibr.txt > .\prl\certfibr.lst".
    OS-COMMAND SILENT  "copy .\prl\certfibr.lst prn /b".
    
    Certificado_ibr.emitido = YES.
    
END.
