/*===========================================================================================================*/
/*                IMPORTA UNA SERIE DE ASIENTOS EN UN GRUPO DE ARCHIVOS SECUENCIALES                         */
/*===========================================================================================================*/

DEFINE TEMP-TABLE T-Asn_header LIKE Asn_header.
DEFINE TEMP-TABLE T-Asn_detalle LIKE Asn_detalle.
DEFINE TEMP-TABLE T-Asn_totales LIKE Asn_totales.

DEFINE STREAM Encabezado.
DEFINE STREAM Totales.
DEFINE STREAM Detalle.

INPUT STREAM Encabezado FROM "c:\sic-temp\encabezado2.txt".
INPUT STREAM Totales    FROM "c:\sic-temp\totales2.txt".
INPUT STREAM Detalle    FROM "c:\sic-temp\detalle2.txt".

REPEAT:
    CREATE T-Asn_header.
    IMPORT STREAM Encabezado DELIMITER "!" T-Asn_header.
END.

REPEAT:
    CREATE T-Asn_detalle.
    IMPORT STREAM Detalle DELIMITER "!" T-Asn_detalle.
END.

REPEAT:
    CREATE T-Asn_totales.
    IMPORT STREAM Totales DELIMITER "!" T-Asn_totales.
END.

INPUT STREAM Encabezado CLOSE.
INPUT STREAM Totales    CLOSE.
INPUT STREAM Detalle    CLOSE.


FIND Parametro WHERE Parametro.cdg_empresa = "M" AND Parametro.cdg_parametro = "PROXNASN" EXCLUSIVE-LOCK.

FOR EACH T-Asn_header WHERE T-Asn_header.nro_asiento <> 0:

    CREATE Asn_header.
    BUFFER-COPY T-Asn_header TO Asn_header
        ASSIGN Asn_header.nro_asiento = NEXT-VALUE(proximo_asiento)
               Asn_header.nro_comprob = Parametro.valor_n
               Parametro.valor_n = Parametro.valor_n + 1.

    
    FOR EACH T-Asn_detalle OF T-Asn_header:
        CREATE Asn_detalle.
        BUFFER-COPY T-Asn_detalle TO Asn_detalle
            ASSIGN Asn_detalle.nro_asiento = Asn_header.nro_asiento.
    END.
    
    FOR EACH T-Asn_totales OF T-Asn_header:
        CREATE Asn_totales.
        BUFFER-COPY T-Asn_totales TO Asn_totales
            ASSIGN Asn_totales.nro_asiento = Asn_header.nro_asiento.
    END.
 
END.



