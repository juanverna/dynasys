/*===================================================*/
/* Tabla cdg_tabla frm-tabla err-noesta err-distinto */
/*===================================================*/

  IF NOT AVAILABLE {1}
  THEN DO:
     RUN PONMENSJ.P (INPUT "{4}").
     RETURN.
  END.
  ELSE DO:
       IF ( INPUT FRAME {3} {1}.{2} ) <> {1}.{2}
       THEN DO:
            RUN PONMENSJ.P (INPUT "{5}").
            RETURN.
       END.
  END.     
