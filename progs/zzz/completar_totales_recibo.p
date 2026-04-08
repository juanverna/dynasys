/* ======================================================================================== */
/*         COMPLETA LOS TOTALES DEL RECIBO POR CADA UNA DE LAS MONEDAS INVOLUCRADAS         */
/* ======================================================================================== */

FOR EACH Rec_header:
    CREATE Totales_recibo.
    BUFFER-COPY Rec_header TO Totales_recibo.
END.
