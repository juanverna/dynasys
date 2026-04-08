
ON CHOOSE OF btn_IMPRIMIR IN FRAME frm-rango
DO:
  RUN PRINFILE.P ( INPUT "{1}", INPUT port ).
END.  

ON CHOOSE OF btn_verdatos
DO:
  HIDE FRAME frm-rango NO-PAUSE.
  RUN VERESULT.W ( INPUT "{1}", INPUT 8 ).
  VIEW FRAME frm-rango.
END.   
