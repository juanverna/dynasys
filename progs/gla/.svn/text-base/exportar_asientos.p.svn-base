/*===========================================================================================================*/
/*                EXPORTA UNA SERIE DE ASIENTOS EN UN GRUPO DE ARCHIVOS SECUENCIALES                         */
/*===========================================================================================================*/

DEFINE STREAM Encabezado.
DEFINE STREAM Totales.
DEFINE STREAM Detalle.

OUTPUT STREAM Encabezado TO "c:\sic-temp\encabezado.txt" PAGE-SIZE 0.
OUTPUT STREAM Totales    TO "c:\sic-temp\totales.txt" PAGE-SIZE 0.
OUTPUT STREAM Detalle    TO "c:\sic-temp\detalle.txt" PAGE-SIZE 0.

FOR EACH Asn_header 
    WHERE Asn_header.origen = "M" 
      AND Asn_header.cdg_sigla-sic = "GLA" 
      AND ( Asn_header.fecha = 07/31/2004 OR Asn_header.fecha = 08/31/2004 OR Asn_header.fecha = 09/30/2004 ):
    EXPORT STREAM Encabezado DELIMITER "!" Asn_header.
    FOR EACH Asn_detalle OF Asn_header:
        EXPORT STREAM Detalle DELIMITER "!" Asn_detalle.
    END.
    FOR EACH Asn_totales OF Asn_header:
        EXPORT STREAM Totales DELIMITER "!" Asn_totales.
    END.
END.

OUTPUT STREAM Encabezado CLOSE.
OUTPUT STREAM Totales    CLOSE.
OUTPUT STREAM Detalle    CLOSE.

