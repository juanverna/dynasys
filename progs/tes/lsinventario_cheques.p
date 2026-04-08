DEFINE VARIABLE t-pesos_gral   LIKE valor.importe.
DEFINE VARIABLE t-cheques_gral AS INTEGER.

DEFINE VARIABLE t-pesos_caja   LIKE valor.importe.
DEFINE VARIABLE t-cheques_caja AS INTEGER.

DEFINE VARIABLE t-pesos_empre   LIKE valor.importe.
DEFINE VARIABLE t-cheques_empre AS INTEGER.


DEFINE FRAME frm-titulo HEADER
  
  "Cheques emitidos por fecha, al" AT 58
  
  "Pagina:" AT 161 PAGE-NUMBER FORMAT ">>9" AT 168
  SKIP
  SKIP(1)
  WITH WIDTH 180 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
  valor.cdg_caja 
  valor.cdg_empresa 
  valor.numero_cheque 
  valor.importe
  WITH WIDTH 180 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

FOR EACH Valor WHERE Valor.estado = "00" BREAK BY cdg_caja BY cdg_empresa:

    t-pesos_empre = t-pesos_empre + Valor.importe.
    t-cheques_empre = t-cheques_empre + 1.

    DISPLAY valor.cdg_caja 
            valor.cdg_empresa 
            valor.numero_cheque 
            valor.importe
            WITH FRAME frm-listado.

    IF LAST-OF(Valor.cdg_empresa) 
    THEN DO:

        UNDERLINE valor.importe WITH FRAME frm-listado.
        DISPLAY  t-cheques_empre @ Valor.numero_cheque
                 t-pesos_empre   @ Valor.importe
                 WITH FRAME frm-listado.

        DOWN WITH FRAME frm-listado.

        t-pesos_caja = t-pesos_caja + t-pesos_empre.
        t-cheques_caja = t-cheques_caja + t-cheques_empre.

        t-pesos_empre = 0.
        t-cheques_empre = 0.

    END.

    IF LAST-OF(Valor.cdg_caja) 
    THEN DO:

        UNDERLINE valor.importe WITH FRAME frm-listado.
        DISPLAY  t-cheques_caja    @ Valor.numero_cheque
                 t-pesos_caja  @ Valor.importe
                 WITH FRAME frm-listado.

       DOWN 1 WITH FRAME frm-listado.

        t-pesos_gral = t-pesos_gral + t-pesos_caja.
        t-cheques_gral = t-cheques_gral + t-cheques_caja.

        t-pesos_caja = 0.
        t-cheques_caja = 0.

    END.

END.
