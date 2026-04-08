FOR EACH rem_header WHERE origen = "C":
    FOR EACH Rem_detalle OF Rem_header:
        DELETE Rem_detalle.
    END.
    DELETE Rem_header.
END.
