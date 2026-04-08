ON CHOOSE OF btn_GRABAR IN FRAME {1}
DO:
   codigo_salir = CD_GRABAR.
   APPLY "U1" TO FRAME {1}.
   
END.

ON CHOOSE OF btn_CANCEL IN FRAME {1}
DO:
   codigo_salir = CD_CANCELAR.
   APPLY "U1" TO FRAME {1}.
   
END.

ON CHOOSE OF btn_SALIR IN FRAME {1}
DO:
   codigo_salir = CD_SALIR.
   APPLY "U1" TO FRAME {1}.
  
END.

ON END-ERROR OF FRAME {1}
DO:
  APPLY "CHOOSE" TO btn_salir IN FRAME {1}.
  RETURN NO-APPLY.
END.  