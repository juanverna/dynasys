/*=================================================================================*/
/*                   PRODUCE LA ANULACION DE UN ASIENTO CONTABLE                   */
/*=================================================================================*/

DEFINE INPUT PARAMETER  rid_asiento   AS ROWID.
DEFINE OUTPUT PARAMETER puede_anular  AS LOGICAL.

/*=================================================================================*/
/*                             VARIABLES Y BUFFERS                                 */
/*=================================================================================*/

{VPERSINM.I}

/*=================================================================================*/
/*                               BLOQUE PRINCIPAL                                  */
/*=================================================================================*/

{findempresa.i}

DO TRANSACTION:
    FIND Asn_header WHERE ROWID(Asn_header) = rid_asiento EXCLUSIVE-LOCK.
    FOR EACH Asn_detalle OF Asn_header EXCLUSIVE-LOCK:
        DELETE Asn_detalle.
    END.
    DELETE Asn_header.
END.


