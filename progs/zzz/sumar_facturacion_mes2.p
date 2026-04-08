DEFINE VARIABLE k AS INTEGER.
DEFINE VARIABLE tt AS DECIMAL.
DEFINE VARIABLE kg AS INTEGER.
DEFINE VARIABLE ttg AS DECIMAL.
OUTPUT TO "c:\sic-temp\facturasnov3.txt" PAGE-SIZE 0.
tt = 0.
k = 0.

FOR EACH Fac_header WHERE Fac_header.fecha >= date(11,03,2006) 
    AND Fac_header.fecha < date(12,07,2006) 
    BREAK BY prf_comprob WITH FRAME aa DOWN:
    k = k + 1.
    tt = tt + fac_header.imp_total.

    IF LAST-OF(prf_comprob)
    THEN DO:
        DISPLAY prf_comprob k tt WITH STREAM-IO.
        kg = kg + k.
        ttg = ttg + tt.
        tt = 0.
        k = 0.
    END.

END.

DISPLAY kg ttg WITH STREAM-IO.
