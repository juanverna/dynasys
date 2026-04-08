{calculareicaja.i}
    DEFINE VAR d AS DATE INITIAL 01/01/2015.
DEFINE VAR r AS INT NO-UNDO.
DEFINE VAR te AS DECIMAL FORMAT ">>>>>>>>>>>>>>>>>.99".
DEFINE VAR ti AS DECIMAL FORMAT ">>>>>>>>>>>>>>>>>.99".
DEFINE VAR cte AS DECIMAL FORMAT ">>>>>>>>>>>>>>>>>.99".
DEFINE VAR cti AS DECIMAL FORMAT ">>>>>>>>>>>>>>>>>.99".
DEFINE VAR dte AS DECIMAL FORMAT ">>>>>>>>>>>>>>>>>.99".
DEFINE VAR dti AS DECIMAL FORMAT ">>>>>>>>>>>>>>>>>.99".
DEFINE VAR has_fecha AS DATE.
DEFINE VAR has_cal_hora AS INT.
has_fecha = TODAY.
DEFINE VAR has_hora AS INT INITIAL 2359.
has_cal_hora = truncate( has_hora / 100 , 0 ) * 3600 + (has_hora - TRUNCATE( has_hora / 100 , 0 ) * 100) * 60.
REPEAT r = 1 TO 15:
    RUN calcular_eiRubro( 1, 0,d,has_hora,NO,"P",OUTPUT te,OUTPUT ti).
    
    

    FOR EACH  Caj_header WHERE caj_header.cdg_caja = 1 AND
      (( Caj_header.fecha = d AND caj_header.hora >= has_cal_hora) OR
              caj_header.fecha > d )
      AND  (( Caj_header.fecha < has_fecha )
             OR (Caj_header.fecha = has_fecha and caj_header.hora <= has_cal_hora ))
      AND  Caj_header.estado <> "A" 
      
      BREAK BY(Caj_header.fecha) BY Caj_header.nro_transaccion
      WITH FRAME frm-listado:
      IF Caj_header.tipo_mov = "E" 
         THEN te = te + Caj_header.importe.
         ELSE ti = ti + Caj_header.importe.
              /*DISPLAY caj_header.fecha STRING(caj_header.hora,"hh:MM") Caj_header.tipo_mov Caj_header.importe.*/
    END.
          DISPLAY  d te - ti .
      
    te = 0.
    ti = 0.
    cte = 0.
    cti = 0.
    d = d + 1.
END.
