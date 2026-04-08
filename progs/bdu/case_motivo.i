CASE Motivo_retiro.habilitado_para:
    WHEN "C"
    THEN DO:
        IF FIRST-OF(Sre_header.nro_solicitud) THEN DO:
            FIND FIRST Rem_header WHERE Rem_header.nro_solicitud = Sre_header.nro_solicitud AND Rem_header.anulado = NO NO-LOCK NO-ERROR.
            IF AVAILABLE Rem_header 
                THEN DISPLAY Rem_header.tip_comprob @ v-tip_comprob 
                             Rem_header.prf_comprob @ v-prf_comprob
                             Rem_header.nro_comprob @ v-nro_comprob
                             WITH FRAME frm-listado.
        END.
    END.
    WHEN "P"
    THEN DO:
        IF FIRST-OF(Sre_header.nro_solicitud) THEN DO:
            FIND FIRST Rem_header_prv WHERE Rem_header_prv.nro_solicitud = Sre_header.nro_solicitud AND Rem_header_prv.anulado = NO NO-LOCK NO-ERROR.
            IF AVAILABLE Rem_header_prv
                THEN DISPLAY Rem_header_prv.tip_comprob @ v-tip_comprob
                             Rem_header_prv.prf_comprob @ v-prf_comprob
                             Rem_header_prv.nro_comprob @ v-nro_comprob
                             WITH FRAME frm-listado.
        END.
    END.
    WHEN "D"
    THEN DO:
        IF FIRST-OF(Sre_header.nro_solicitud) THEN DO:
            FIND FIRST Transdep_hd WHERE Transdep_hd.nro_solicitud = Sre_header.nro_solicitud AND Transdep_hd.anulado = NO NO-LOCK NO-ERROR.
            IF AVAILABLE Transdep_hd 
                THEN DISPLAY Transdep_hd.tip_comprob @ v-tip_comprob
                             Transdep_hd.prf_comprob @ v-prf_comprob
                             Transdep_hd.nro_comprob @ v-nro_comprob
                             WITH FRAME frm-listado.
        END.
    END.
END CASE.
