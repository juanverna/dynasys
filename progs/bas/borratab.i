  mensaje = "Borrando {1}".
  nreg = 0.
  DISPLAY mensaje WITH FRAME AAA.
  FOR EACH {1} EXCLUSIVE-LOCK:
       DELETE {1}.
       nreg = nreg + 1.
       display nreg WITH FRAME AAA.
  END.    

