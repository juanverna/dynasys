/*==================================================================================================*/
/*                  RETROCEDE EL POSTEO DE UN DETERMINADO ASIENTO Y LO ELIMINA                      */
/*==================================================================================================*/

DEFINE INPUT PARAMETER p-nro_asiento LIKE Asn_header.nro_asiento.
DEFINE OUTPUT PARAMETER p-rc AS INTEGER.

/*==================================================================================================*/
/*                                            PROCESO                                               */
/*==================================================================================================*/

FIND Asn_header WHERE Asn_header.nro_asiento = p-nro_asiento EXCLUSIVE-LOCK NO-ERROR.
IF AVAILABLE Asn_header
THEN DO:
    CASE Asn_header.tabla_comprobante:
        WHEN "Fac_header_prv"
        THEN DO:
            FIND Fac_header_prv WHERE Fac_header_prv.nro_facprov = Asn_header.nro_idcabecera NO-LOCK NO-ERROR.
            IF AVAILABLE Fac_header_prv 
            THEN DO:
                FIND Sub_header_prv OF Fac_header_prv EXCLUSIVE-LOCK.
                Sub_header_prv.contable = NO.
                RELEASE Sub_header_prv.
                RUN borrar_asiento.
                p-rc = 0.
            END.
            ELSE DO:
                p-rc = 2.
            END.

        END.
        WHEN "Caj_header"
        THEN DO:
            FIND Caj_header WHERE Caj_header.nro_transaccion = Asn_header.nro_idcabecera EXCLUSIVE-LOCK NO-ERROR.
            IF AVAILABLE Caj_header 
            THEN DO:
                Caj_header.contable = NO.
                RELEASE Caj_header.
                RUN borrar_asiento.
                p-rc = 0.
            END.
            ELSE DO:
                p-rc = 3.
            END.
        END.
        OTHERWISE
        DO:
            p-rc = 4.
        END.
    END CASE.
END.
ELSE DO:
    p-rc = 1.
END.

/*==================================================================================================*/
/*                                    PROCEDIMIENTOS INTERNOS                                       */
/*==================================================================================================*/

PROCEDURE borrar_asiento:

    FOR EACH asn_totales OF asn_header:
        DELETE asn_totales.
    END.
    FOR EACH asn_detalle OF asn_header:
        DELETE asn_detalle.
    END.
    DELETE asn_header.

END PROCEDURE.
