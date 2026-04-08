DEFINE VARIABLE v-total_rec  AS  DECIMAL.
DEFINE VARIABLE v-cuenta_rec AS  INTEGER.
DEFINE VARIABLE v-desfecha   AS  DATE.
DEFINE VARIABLE v-hasfecha   AS  DATE.

UPDATE v-desfecha COLUMN-LABEL "Desde!Fecha"
       v-hasfecha COLUMN-LABEL "Hasta!Fecha"
            WITH FRAME F.

IF v-desfecha = DATE("") OR v-hasfecha = DATE("") 
    THEN DO:
        
        MESSAGE "Debe ingresar una fecha." VIEW-AS ALERT-BOX TITLE "Error...".
    END.

FOR EACH Rec_header WHERE Rec_header.fecha >= v-desfecha /*desde fecha*/   
                      AND Rec_header.fecha <= v-hasfecha /*hasta fecha*/
                      AND Rec_header.cdg_empresa = "F"    /*Codigo de Empresa*/,
                Cliente OF Rec_header NO-LOCK:

        v-total_rec = v-total_rec + Rec_header.imp_total.
        v-cuenta_rec = v-cuenta_rec + 1.

        DISPLAY 
            Rec_header.fecha_grab  COLUMN-LABEL "Fecha"
            Rec_header.tip_comprob COLUMN-LABEL "Tipo!Comprob"
            Rec_header.prf_comprob COLUMN-LABEL "Prf!Comprob"
            Rec_header.nro_comprob COLUMN-LABEL "Nro!Comprob"
            Rec_header.imp_total   COLUMN-LABEL "Total"
            Cliente.cdg_cliente    COLUMN-LABEL "Cdg!Cliente"
                WITH STREAM-IO.
END.

DISPLAY 
    v-cuenta_rec COLUMN-LABEL "Cantidad"
    v-total_rec  COLUMN-LABEL "Total"
        WITH STREAM-IO.
