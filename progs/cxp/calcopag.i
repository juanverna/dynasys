IF {1}Opg_header.tipo_pago = 1
THEN DO:

     {1}Opg_header.imp_total = 0.
     {1}Opg_header.imp_bruto = 0.

     FOR EACH {1}Opg_detalle OF {1}Opg_header:

         {1}Opg_header.imp_total = {1}Opg_header.imp_total + ( {1}Opg_detalle.importe - 
                                                         {1}Opg_detalle.descuento ).
         {1}Opg_header.imp_bruto = {1}Opg_header.imp_bruto +   {1}Opg_detalle.importe.

     END.       
END.     
ELSE DO:
     {1}Opg_header.imp_bruto = {1}Opg_header.imp_total.
END.
