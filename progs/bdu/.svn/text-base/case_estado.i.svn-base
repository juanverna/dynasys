
CASE Sre_header.cdg_estado:
    WHEN "XX"
    THEN DO:
        IF FIRST-OF(Sre_header.cdg_estado) THEN
                DISPLAY "No Finalizado" @ v-dsc_estado
                        WITH FRAME frm-listado.
    END.
    WHEN "IN"
    THEN DO:
        IF  FIRST-OF(Sre_header.cdg_estado) THEN
                DISPLAY "Ingresado" @ v-dsc_estado
                        WITH FRAME frm-listado.
    END.
    WHEN "AA"
    THEN DO:
        IF FIRST-OF(Sre_header.cdg_estado) THEN
                DISPLAY "Aprobado" @ v-dsc_estado
                        WITH FRAME frm-listado.
    END.
    WHEN "RZ"
    THEN DO:
        IF FIRST-OF(Sre_header.cdg_estado) THEN
                DISPLAY "Rechazado" @ v-dsc_estado
                        WITH FRAME frm-listado.
    END.
    WHEN "Z"
    THEN DO:
        IF FIRST-OF(Sre_header.cdg_estado) THEN
                DISPLAY "Anulado" @ v-dsc_estado
                        WITH FRAME frm-listado.
    END.
    WHEN "RE"
    THEN DO:
        IF FIRST-OF(Sre_header.cdg_estado) THEN
                DISPLAY "Remitido" @ v-dsc_estado
                        WITH FRAME frm-listado.
    END.
    WHEN "PR"
    THEN DO:
        IF FIRST-OF(Sre_header.cdg_estado) THEN
                DISPLAY "Pendiente de Retorno" @ v-dsc_estado
                        WITH FRAME frm-listado.
    END.
    WHEN "CU"
    THEN DO:
        IF FIRST-OF(Sre_header.cdg_estado) THEN
                DISPLAY "Cumplido" @ v-dsc_estado
                        WITH FRAME frm-listado.
    END.
    WHEN "FI"
    THEN DO:
        IF FIRST-OF(Sre_header.cdg_estado) THEN
                DISPLAY "Finalizado" @ v-dsc_estado
                        WITH FRAME frm-listado.
    END.
END CASE.
