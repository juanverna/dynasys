     IF ROWID(Impresora) = ?
     THEN DO:
        RUN PONMENSJ.P (INPUT "IMPR000").
        RETURN.
     END.

     IF INPUT FRAME frm-impresora Impresora.nombre = "" OR 
        INPUT FRAME frm-impresora Impresora.nombre = ?  
     THEN DO:
        RUN PONMENSJ.P (INPUT "IMPR001").
        RETURN.
     END.            
     IF CAN-FIND(FIRST Impresora
                       WHERE Impresora.cdg_impresora = INPUT FRAME frm-impresora Impresora.cdg_impresora
                         AND ROWID(Impresora) <> act_impresora )
     THEN DO:
        RUN PONMENSJ.P (INPUT "IMPR002").
        RETURN.
     END.            
