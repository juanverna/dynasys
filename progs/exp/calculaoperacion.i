
   
   FOR EACH {1}B-Ped_detalle OF {1}Ped_header EXCLUSIVE-LOCK, Articulo OF {1}B-Ped_detalle, Familia_articulo OF Articulo:
  
                              /* Calcula subtotal bruto del renglon */
  
            IF Articulo.extendida
            THEN DO:
               {1}B-Ped_detalle.subtotal_bruto = 
                   ( IF {1}B-Ped_detalle.cantidad_sol <> 0 
                        THEN ROUND( {1}B-Ped_detalle.precio * {1}B-Ped_detalle.cantidad_sol , 2 )
                        ELSE {1}B-Ped_detalle.precio ).
               {1}B-Ped_detalle.subtotal_bruto_cf = 
                   ( IF {1}B-Ped_detalle.cantidad_sol <> 0 
                        THEN ROUND( {1}B-Ped_detalle.precio_cf * {1}B-Ped_detalle.cantidad_sol , 2 )
                        ELSE {1}B-Ped_detalle.precio_cf ).
            END.
            ELSE DO:
               {1}B-Ped_detalle.subtotal_bruto = 
                   ( IF {1}B-Ped_detalle.a_granel 
                        THEN ROUND( {1}B-Ped_detalle.precio * {1}B-Ped_detalle.granel   , 2 )
                        ELSE ROUND( {1}B-Ped_detalle.precio * {1}B-Ped_detalle.cantidad_sol , 2 ) ).
               {1}B-Ped_detalle.subtotal_bruto_cf = 
                   ( IF {1}B-Ped_detalle.a_granel 
                        THEN ROUND( {1}B-Ped_detalle.precio_cf * {1}B-Ped_detalle.granel   , 2 )
                        ELSE ROUND( {1}B-Ped_detalle.precio_cf * {1}B-Ped_detalle.cantidad_sol , 2 ) ).
  
            END.            
  
       END. /* De recorrer el detalle */             
    
    
       IF v-debug THEN MESSAGE "Del detalle de artículos"
                                  VIEW-AS ALERT-BOX MESSAGE.
    
            /* --------------------------------------------------------------------------- */
            /* Halla el total neto y bruto de la factura para calcular impuestos generales */
            /* Si la factura es B, enEn el imp_total acumula los subtotales a consumidor   */
            /* final, los que usa el parrafo de abajo para calcular el importe de iva por  */
            /* diferencia entre el importe total y el importe neto.                        */
            /* --------------------------------------------------------------------------- */
            
       {1}Ped_header.imp_neto  = 0.
       {1}Ped_header.imp_bruto = 0.
       {1}Ped_header.imp_total = 0.
    
       FOR EACH {1}B-Ped_detalle OF {1}Ped_header NO-LOCK:
    
           {1}Ped_header.imp_neto  = {1}Ped_header.imp_neto  + {1}B-Ped_detalle.subtotal_neto.
           {1}Ped_header.imp_bruto = {1}Ped_header.imp_bruto + {1}B-Ped_detalle.subtotal_bruto.
    
       END.
    

