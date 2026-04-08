DEFINE VARIABLE que_dia AS INTEGER.
DEFINE VARIABLE que_mes AS INTEGER.
DEFINE VARIABLE que_ano AS INTEGER.
DEFINE VARIABLE resto   AS INTEGER.

DEFINE VARIABLE voy_fecha AS DATE.
STOP.
FOR EACH Contrato_hd WHERE Contrato_hd.cant_periodos <> 0 AND contrato_hd.estado = "A":

    /*
    ASSIGN que_mes = Contrato_hd.primer_mes + Contrato_hd.cant_periodos
           que_ano = Contrato_hd.primer_ano.
    */
    ASSIGN que_mes = MONTH(Contrato_hd.rige_desde) + Contrato_hd.cant_periodos - 1
           que_ano = YEAR(Contrato_hd.rige_desde).

    DO WHILE que_mes > 12:
        que_mes = que_mes - 12.
        que_ano = que_ano + 1.
    END.

    que_dia = 1.
    RUN findemes.p ( INPUT-OUTPUT que_dia, INPUT que_mes, INPUT que_ano ).
    ASSIGN Contrato_hd.rige_hasta = DATE (que_mes, que_dia, que_ano ).

    voy_fecha = Contrato_hd.rige_desde.
    Contrato_hd.resto_periodos = Contrato_hd.cant_periodos.
    DO WHILE Contrato_hd.resto_periodos > 0 AND voy_fecha < 03/31/2006:

        ASSIGN Contrato_hd.resto_periodos = Contrato_hd.resto_periodos - 1 
               que_mes = MONTH(voy_fecha)
               que_ano = YEAR(voy_fecha).

        IF que_mes > 12
            THEN ASSIGN que_mes = que_mes - 12
                        que_ano = que_ano + 1.
    
        que_dia = 1.
        RUN findemes.p ( INPUT-OUTPUT que_dia, INPUT que_mes, INPUT que_ano ).
        ASSIGN voy_fecha = DATE (que_mes, que_dia, que_ano ).
    END.
    IF Contrato_hd.resto_periodos > 0 THEN
    DISPLAY Contrato_hd.nro_contrato Contrato_hd.rige_desde Contrato_hd.rige_hasta Contrato_hd.cant_periodos Contrato_hd.resto_periodos
        WITH STREAM-IO. 

END.
