
  DEFINE VARIABLE v-lista AS CHARACTER.

  RUN getparametro_o.p ( INPUT "{1}", OUTPUT v-lista ).
  IF v-lista <> ?
  THEN DO:
        IF NOT CAN-DO(v-lista,USERID("sic")) 
        THEN DO:
              MESSAGE "Se intenta ejecutar una función no autorizada"
                      VIEW-AS ALERT-BOX ERROR TITLE "Error de seguridad".
              RETURN ERROR.        
        END.
  END.
  ELSE DO:
        MESSAGE "Se intenta ejecutar una función no definida"
                VIEW-AS ALERT-BOX ERROR TITLE "Error de seguridad".
        RETURN ERROR.        
  END.
