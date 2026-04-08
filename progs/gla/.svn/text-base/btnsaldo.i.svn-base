ON CHOOSE OF btn_SALDO IN FRAME frm-Cuenta
DO:

   aux_debitogr = 0.
   aux_creditogr = 0.
   hasta_tipo = Asn_header.tip_comprob.
   hasta_numero = Asn_header.nro_comprob.
   hasta_linea = Asn_detalle.nro_linea.

   /* Busca por Acumulado_cuenta hasta el mes anterior a la fecha */
   FOR EACH Acumulado_cuenta OF Cuenta
       WHERE   DATE(Acumulado_cuenta.mes,1,Acumulado_cuenta.ano) < 
               DATE(MONTH(des_fecha),1,YEAR(des_fecha)):
                             
          aux_debitogr  = aux_debitogr + Acumulado_cuenta.tot_debitos.
          aux_creditogr = aux_creditogr + Acumulado_cuenta.tot_creditos.

   END.

   /* Busca por Movimiento desde principio de mes hasta el indicado */
   
   FOR EACH Asn_detalle OF Cuenta 
       WHERE Asn_detalle.fecha_mayor >= DATE(MONTH(des_fecha),1,YEAR(des_fecha)) 
         AND Asn_detalle.fecha_mayor <= has_fecha
         AND Asn_header.tip_comprob  <= hasta_tipo 
         AND Asn_header.nro_comprob  <= hasta_numero 
         AND Asn_detalle.nro_linea   <= hasta_linea
             BY Asn_detalle.fecha_mayor
             BY Asn_header.tip_comprob
             BY Asn_header.nro_comprob:

          aux_debitogr  = aux_debitogr + Asn_detalle.debito.
          aux_creditogr = aux_creditogr + Asn_detalle.credito.

   END.   
   
   MESSAGE "El saldo hasta el presente movimiento es de " 
           STRING(aux_debitogr - aux_creditogr, "ZZZZZZZ9.99-")
           VIEW-AS ALERT-BOX MESSAGE TITLE "Consulta de saldo".
   
END.

