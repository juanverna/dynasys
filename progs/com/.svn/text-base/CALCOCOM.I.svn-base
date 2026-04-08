
   DEFINE VARIABLE aux_impuesto AS DECIMAL.

        /*-----------------------------------------------------------------------------*/
        /*             Calcula el bruto y el neto de las O/Compra                      */
        /*-----------------------------------------------------------------------------*/

   {1}Ocm_header.imp_neto  = 0.
   {1}Ocm_header.imp_total = 0.

   FOR EACH B-Ocm_detalle OF {1}Ocm_header EXCLUSIVE-LOCK, Articulo OF B-Ocm_detalle, Familia_articulo OF Articulo:
      
              /* Acumula el neto de la OCM */

       IF Articulo.extendida
       THEN DO:
          aux_importe = 
              ( IF B-Ocm_detalle.cantidad <> 0 
                   THEN ROUND( B-Ocm_detalle.precio * B-Ocm_detalle.cantidad , 2 )
                   ELSE B-Ocm_detalle.precio ).
       END.
       ELSE DO:
          aux_importe = 
              ( IF B-Ocm_detalle.a_granel 
                   THEN ROUND( B-Ocm_detalle.precio * B-Ocm_detalle.granel   , 2 )
                   ELSE ROUND( B-Ocm_detalle.precio * B-Ocm_detalle.cantidad , 2 ) ).
       END.            


       {1}Ocm_header.imp_neto  = {1}Ocm_header.imp_neto  + aux_importe.
       {1}Ocm_header.imp_total = {1}Ocm_header.imp_total + aux_importe.

              /* Calcula y suma el total de impuestos por articulo */

       /*
       aux_impuesto = 0.
       FOR EACH Articulo-impuesto OF Familia_articulo WHERE Articulo-impuesto.para_venta, 
                Impuesto OF Articulo-impuesto:
 
           aux_impuesto = aux_impuesto + ROUND(aux_importe * Articulo-impuesto.tasa / 100 ,2 ).
             


       END. /* Del detalle de impuestos por artículo */

       {1}Ocm_header.imp_total = {1}Ocm_header.imp_total + aux_impuesto.
       */

   END. /* De recorrer el detalle creando imputaciones */             


       /* Halla el total de la o/compra calculando y sumando los impuestos */

   FIND Condicion_impos OF {1}Ocm_header NO-LOCK.
   FOR EACH Impuesto_condicion OF Condicion_impos 
       WHERE  Impuesto_condicion.cdg_empresa = Empresa.cdg_empresa NO-LOCK, 
              Impuesto OF Impuesto_condicion NO-LOCK:

       aux_impuesto = ROUND({1}Ocm_header.imp_neto * Impuesto_condicion.tasa / 100,2).
       {1}Ocm_header.imp_total = {1}Ocm_header.imp_total + aux_impuesto.


   END.


