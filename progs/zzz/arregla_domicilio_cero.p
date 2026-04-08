FOR EACH cliente WHERE CAN-FIND(FIRST domicilio OF cliente WHERE domicilio.nro_domicilio = 0):

     FOR EACH fac_header OF cliente WHERE fac_header.nro_domicilio = 0:
         fac_header.nro_domicilio = 1.
     END.

     FOR EACH rec_header OF cliente WHERE rec_header.nro_domicilio = 0:
         rec_header.nro_domicilio = 1.
     END.

     FOR EACH rem_header OF cliente WHERE rem_header.nro_domicilio = 0:
         rem_header.nro_domicilio = 1.
     END.
     
     FIND FIRST domicilio OF cliente WHERE domicilio.nro_domicilio = 0.
     domicilio.nro_domicilio = 1.
 
     DISPLAY cdg_cliente. 

END.
