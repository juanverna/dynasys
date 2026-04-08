define var tot_egresogr  as decimal.
define var tot_ingresong as decimal.
define var des_fecha as date initial "05/19/95".
define var has_fecha as date initial "05/22/95".

find caja 1.

   tot_egresogr = 0.
   tot_ingresong = 0.

   /* Busca por Acumulado_caja hasta el mes anterior a la fecha */
   FOR EACH Acumulado_caja OF Caja
       WHERE Acumulado_caja.mes <  MONTH(des_fecha)
         AND Acumulado_caja.ano <= YEAR(des_fecha):
                             
      tot_egresogr = tot_egresogr + Acumulado_caja.tot_egreso.
      tot_ingresong = tot_ingresong + Acumulado_caja.tot_ingreso.
      
      display    tot_egresogr tot_ingresong.
      
   END.

   /* Busca por Caj_header desde principio de mes a la fecha */
   FOR EACH Caj_header OF Caja
       WHERE Caj_header.fecha >= DATE(1,MONTH(des_fecha),YEAR(des_fecha))
         AND Caj_header.fecha <  des_fecha:

      IF Caj_header.tipo_mov = "E" 
         THEN tot_egresogr = tot_egresogr + Caj_header.importe.
         ELSE tot_ingresong = tot_ingresong + Caj_header.importe.

      display    importe tipo_mov tot_egresogr tot_ingresong.
      
   END.
