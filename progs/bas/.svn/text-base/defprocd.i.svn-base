PROCEDURE BORRA_{1}:

          que_borro = "Borrando {1}...".
          DISPLAY que_borro WITH FRAME l.
          DOWN WITH FRAME l.

          FOR EACH {1} EXCLUSIVE-LOCK:
              DELETE {1}.
          END.    

END PROCEDURE.          
