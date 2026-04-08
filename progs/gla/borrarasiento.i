    IF AVAILABLE Asn_header
    THEN DO:
    /*    MESSAGE "Nueva"
            VIEW-AS ALERT-BOX INFO BUTTONS OK. */
        FIND CURRENT Asn_header EXCLUSIVE-LOCK.
        FOR EACH Asn_detalle OF Asn_header EXCLUSIVE-LOCK:
            DELETE Asn_detalle.
        END.
        FOR EACH Asn_totales OF Asn_header EXCLUSIVE-LOCK:
            DELETE Asn_totales.
        END.
        DELETE Asn_header.
    END.
