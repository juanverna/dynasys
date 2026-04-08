/*calculo de arrastre de saldos*/
/*si arrastrar saldo vale 1 es el saldo al ultimo cierre y devuelve datetime de la fecha del saldo
si vale 2 es el del dia anterior*/
PROCEDURE CALCULAR_EI:
    DEFINE INPUT PARAMETER pcaja LIKE caja.cdg_caja NO-UNDO.
   DEFINE INPUT PARAMETER has_fecha AS DATE NO-UNDO.
   DEFINE INPUT PARAMETER has_hora AS INT NO-UNDO.
   DEFINE INPUT PARAMETER consolidado AS LOGICAL NO-UNDO.
   DEFINE INPUT PARAMETER pcdg_empresa LIKE empresa.cdg_empresa NO-UNDO.
   DEFINE OUTPUT PARAMETER tot_egresogr AS DECIMAL NO-UNDO.
   DEFINE OUTPUT PARAMETER tot_ingresong AS DECIMAL NO-UNDO.
   DEFINE VAR hayacu AS LOGICAL NO-UNDO.
   DEF VAR has_cal_fecha AS DATE NO-UNDO.
   DEF VAR has_cal_hora AS INT NO-UNDO.
   tot_egresogr = 0.
   tot_ingresong = 0.
   has_cal_fecha = 01/01/1900.
   has_cal_hora = truncate( has_hora / 100 , 0 ) * 3600 + (has_hora - TRUNCATE( has_hora / 100 , 0 ) * 100) * 60.
      /* Busca por Acumulado_caja hasta el mes anterior a la fecha */
   hayacu = FALSE.
   FOR EACH Acumulado_caja NO-LOCK WHERE acumulado_caja.cdg_caja = pcaja 
       AND Acumulado_caja.ano * 100 +  Acumulado_caja.mes < YEAR(has_fecha) * 100 + MONTH(has_fecha)
       AND acumulado_caja.cdg_rubro = 0 
       AND NOT acumulado_caja.cerrado
       BY acumulado_caja.ano BY acumulado_caja.mes :
      hayacu = TRUE.                       
      tot_egresogr = tot_egresogr + Acumulado_caja.tot_egreso.
      tot_ingresong = tot_ingresong + Acumulado_caja.tot_ingreso.
      has_cal_fecha = DATE(acumulado_caja.mes,1,acumulado_caja.ano).
   END.
  
   has_cal_fecha = has_cal_fecha + 32.
   has_cal_fecha = DATE( MONTH(has_cal_fecha),1,YEAR(has_cal_fecha)).

   /* Busca por Caj_header desde principio de mes al dia anterior a la fecha*/
   FOR EACH Caj_header WHERE caj_header.cdg_caja = pcaja AND
         Caj_header.fecha > has_cal_fecha 
         AND Caj_header.fecha <  has_fecha 
         AND ( consolidado OR Caj_header.cdg_empresa = pcdg_empresa )
         AND Caj_header.estado <> "A" NO-LOCK:
      IF Caj_header.tipo_mov = "E" 
         THEN tot_egresogr = tot_egresogr + Caj_header.importe.
         ELSE tot_ingresong = tot_ingresong + Caj_header.importe.
   END.

   /*el dia pedido hasta anterior a la hora pedida*/
   FOR EACH Caj_header WHERE caj_header.cdg_caja = pcaja AND
         Caj_header.fecha = has_fecha 
         AND Caj_header.hora <  has_cal_hora
         AND ( consolidado OR Caj_header.cdg_empresa = pcdg_empresa )
         AND Caj_header.estado <> "A" NO-LOCK:
      IF Caj_header.tipo_mov = "E" 
         THEN tot_egresogr = tot_egresogr + Caj_header.importe.
         ELSE tot_ingresong = tot_ingresong + Caj_header.importe.
   END.
   

END PROCEDURE.

PROCEDURE CALCULAR_EIRUBRO:
    DEFINE INPUT PARAMETER pcaja LIKE caja.cdg_caja NO-UNDO.
   DEFINE INPUT PARAMETER pcdg_rubro LIKE acumulado_caja.cdg_rubro NO-UNDO.
   DEFINE INPUT PARAMETER has_fecha AS DATE NO-UNDO.
   DEFINE INPUT PARAMETER has_hora AS INT NO-UNDO.
   DEFINE INPUT PARAMETER consolidado AS LOGICAL NO-UNDO.
   DEFINE INPUT PARAMETER pcdg_empresa LIKE empresa.cdg_empresa NO-UNDO.
   DEFINE OUTPUT PARAMETER tot_egresogr AS DECIMAL NO-UNDO.
   DEFINE OUTPUT PARAMETER tot_ingresong AS DECIMAL NO-UNDO.
   DEFINE VAR hayacu AS LOGICAL NO-UNDO.
   DEF VAR has_cal_fecha AS DATE NO-UNDO.
   DEFINE VAR has_cal_hora AS INT NO-UNDO.
   IF pcdg_rubro = 0  THEN DO:
       RUN calcular_ei( pcaja, has_fecha,has_hora,consolidado,pcdg_empresa,OUTPUT tot_egresogr,OUTPUT tot_ingresong ).
       RETURN.
   END.
   tot_egresogr = 0.
   tot_ingresong = 0.
   has_cal_fecha = 01/01/1900.
   has_cal_hora = truncate( has_hora / 100 , 0 ) * 3600 + (has_hora - TRUNCATE( has_hora / 100 , 0 ) * 100) * 60.


   /* Busca por Acumulado_caja hasta el mes anterior a la fecha */
   hayacu = FALSE.
   FOR EACH Acumulado_caja NO-LOCK WHERE acumulado_caja.cdg_caja = pcaja AND
        acumulado_caja.cdg_rubro = pcdg_rubro AND
        Acumulado_caja.ano * 100 + Acumulado_caja.mes < YEAR(has_fecha) * 100 +  MONTH(has_fecha)
        AND NOT acumulado_caja.cerrado
       BY acumulado_caja.ano BY acumulado_caja.mes :
      hayacu = TRUE.                       
      tot_egresogr = tot_egresogr + Acumulado_caja.tot_egreso.
      tot_ingresong = tot_ingresong + Acumulado_caja.tot_ingreso.
      has_cal_fecha = DATE(acumulado_caja.mes,1,acumulado_caja.ano).
   END.
   has_cal_fecha = has_cal_fecha + 32.
   has_cal_fecha = DATE( MONTH(has_cal_fecha),1,YEAR(has_cal_fecha)).

   /* Busca por Caj_header ,Caj_detalle desde principio de mes a la fecha */
   FOR EACH Caj_header WHERE caj_header.cdg_caja = pcaja 
         AND Caj_header.fecha > has_cal_fecha 
         AND Caj_header.fecha <  has_fecha 
         AND (consolidado OR Caj_header.cdg_empresa = pcdg_empresa )
         AND Caj_header.estado <> "A" NO-LOCK:
      FOR EACH caj_detalle OF caj_header WHERE caj_detalle.cdg_rubro = pcdg_rubro NO-LOCK:
          IF Caj_header.tipo_mov = "E" 
             THEN tot_egresogr = tot_egresogr + Caj_detalle.importe.
             ELSE tot_ingresong = tot_ingresong + Caj_detalle.importe.
      END.
   END.
      /*hasta anterior a la hora pedida*/
      FOR EACH Caj_header WHERE caj_header.cdg_caja = pcaja 
         AND Caj_header.fecha = has_fecha 
         AND Caj_header.hora <  has_cal_hora
         AND (consolidado OR Caj_header.cdg_empresa = pcdg_empresa )
         AND Caj_header.estado <> "A" NO-LOCK:
      FOR EACH caj_detalle OF caj_header WHERE caj_detalle.cdg_rubro = pcdg_rubro NO-LOCK:
          IF Caj_header.tipo_mov = "E" 
             THEN tot_egresogr = tot_egresogr + Caj_detalle.importe.
             ELSE tot_ingresong = tot_ingresong + Caj_detalle.importe.
      END.
   END.
   
END PROCEDURE.
