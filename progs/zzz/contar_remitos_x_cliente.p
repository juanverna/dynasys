DEF VAR k AS INTEGER.
k = 0.
FOR EACH rem_header BREAK BY nro_cliente:
    k = k + 1.
    IF LAST-OF(rem_header.nro_cliente)
       THEN do:
            IF k > 9
               THEN DO:
                    FIND cliente OF rem_header.
                    DISPLAY cdg_cliente k.
               END.
            k = 0.
    END.

END.
