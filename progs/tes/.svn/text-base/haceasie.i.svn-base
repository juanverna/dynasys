/*
RUN CREASNHD.P ( INPUT Caj_header.fecha, INPUT Caj_header.observacion, INPUT "CAJ" ).
FIND Asn_header WHERE ROWID(Asn_header) = act_asn_head EXCLUSIVE-LOCK.

IF Caj_header.tipo_mov = "E" 
THEN DO:

   FIND Cuenta OF Caj_header NO-LOCK.
   RUN CREASNDT.P ( INPUT Cuenta.cdg_cuenta, 
                    INPUT Caj_header.importe, 
                    INPUT 0, 
                    INPUT Caj_header.observacion ).

   FOR EACH Caj_detalle OF Caj_header, 
       Rubro OF Caj_detalle NO-LOCK, 
       Cuenta OF Rubro NO-LOCK: 
    
       IF Caj_detalle.tipo_mov = "E"
          THEN RUN CREASNDT.P ( INPUT Cuenta.cdg_cuenta, 
                                INPUT 0,
                                INPUT Caj_detalle.importe, 
                                INPUT Caj_header.observacion ).
          ELSE RUN CREASNDT.P ( INPUT Cuenta.cdg_cuenta, 
                                INPUT Caj_detalle.importe, 
                                INPUT 0,
                                INPUT Caj_header.observacion ).
   END.
   
END.
ELSE DO:   

   FOR EACH Caj_detalle OF Caj_header, 
       Rubro OF Caj_detalle NO-LOCK, 
       Cuenta OF Rubro NO-LOCK: 
    
       IF Caj_detalle.tipo_mov = "I"
          THEN RUN CREASNDT.P ( INPUT Cuenta.cdg_cuenta, 
                                INPUT Caj_detalle.importe, 
                                INPUT 0,
                                INPUT Caj_header.observacion ).
          ELSE RUN CREASNDT.P ( INPUT Cuenta.cdg_cuenta, 
                                INPUT 0,
                                INPUT Caj_detalle.importe, 
                                INPUT Caj_header.observacion ).

   END.

   FIND Cuenta OF Caj_header NO-LOCK.
   RUN CREASNDT.P ( INPUT Cuenta.cdg_cuenta, 
                    INPUT 0, 
                    INPUT Caj_header.importe, 
                    INPUT Caj_header.observacion ).   
                    
END.

MESSAGE "Impresion del comprobante de caja" VIEW-AS ALERT-BOX MESSAGE.
*/