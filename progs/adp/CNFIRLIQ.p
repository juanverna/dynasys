/*=================================================================================*/
/*                           CONFIRMA O RETROCEDE UNA LIQUIDACION                  */
/*=================================================================================*/

{VRSHARED.I}

DEFINE VARIABLE mensaje AS CHARACTER FORMAT "X(40)".


DEFINE BUTTON btn_confirmar
     LABEL "&Confirmar":L 
     SIZE 20 BY 0.9 FONT 6.

DEFINE BUTTON btn_salir
     LABEL "&Salir":L 
     SIZE 20 BY 0.9 FONT 6.

DEFINE BUTTON BTN_RETROCEDER
     LABEL "&Retroceder":L 
     SIZE 20 BY 0.9 FONT 6.

FORM

    SKIP(1)    
    Liquidacion.sec_liquidacion     COLON 12  FGCOLOR fg_c BGCOLOR bg_c
    Liquidacion.descripcion         NO-LABEL  FGCOLOR fg_c BGCOLOR bg_c
    Liquidacion.fecha               NO-LABEL  FGCOLOR fg_c BGCOLOR bg_c   
    SKIP(1)
    SPACE(4)
    btn_confirmar SPACE(2) btn_salir SPACE(2) btn_retroceder SPACE(1)
    SKIP(1)
    WITH FRAME frm-confirmar TITLE "Confirmar/Retroceder Liquidacion" 
         SIDE-LABELS FGCOLOR f-fg_c BGCOLOR f-bg_c THREE-D
         VIEW-AS DIALOG-BOX CENTERED FONT 6.

FORM
  mensaje FONT 8
  WITH FRAME espere NO-LABEL FGCOLOR 14 BGCOLOR 4 
       VIEW-AS DIALOG-BOX TITLE "Aguarde un momento por favor".
  

/*=================================================================================*/
/*                                  TRIGGERS DE PROCESO                            */
/*=================================================================================*/

ON CHOOSE OF btn_confirmar IN FRAME frm-confirmar
DO:

   mensaje = "Confirmando liquidacion ...".
   DISPLAY mensaje WITH FRAME espere.

   FOR EACH Datos_liq_ant EXCLUSIVE-LOCK:
       DELETE Datos_liq_ant.
   END.    

   FOR EACH Concepto_empleado_ant EXCLUSIVE-LOCK:
       DELETE Concepto_empleado_ant.
   END.    

   FOR EACH Empleado-ddjj_ant EXCLUSIVE-LOCK:
       DELETE Empleado-ddjj_ant.
   END.    

   FOR EACH Rcb_header OF Liquidacion, Empleado OF Rcb_header:

       CREATE Cta_cte_emp.
       ASSIGN Cta_cte_emp.nro_empleado    = Rcb_header.nro_empleado
              Cta_cte_emp.tip_comprob     = Rcb_header.tip_comprob
              Cta_cte_emp.nro_comprob     = Rcb_header.nro_comprob
              Cta_cte_emp.sec_liquidacion = Rcb_header.sec_liquidacion
              Cta_cte_emp.debito          = Rcb_header.a_pagar
              Cta_cte_emp.fecha_emision   = Rcb_header.fecha
              Cta_cte_emp.nro_documento   = Rcb_header.nro_recibo
              Cta_cte_emp.estado          = 1.

       /*
       FIND FIRST Total_remunerativo 
            WHERE Total_remunerativo.nro_empleado  = Rcb_header.nro_empleado
              AND Total_remunerativo.fecha         = DATE(Liquidacion.n_periodo,1,Liquidacion.ano)
                  EXCLUSIVE-LOCK NO-ERROR.

       IF NOT AVAILABLE Total_remunerativo
       THEN DO:
            CREATE Total_remunerativo.
            ASSIGN Total_remunerativo.nro_empleado = Rcb_header.nro_empleado
                   Total_remunerativo.fecha        = DATE(Liquidacion.n_periodo,1,Liquidacion.ano).
       END.
       
       Total_remunerativo.importe    = Total_remunerativo.importe + Rcb_header.remunerativo.
       Total_remunerativo.cdg_estado = Empleado.cdg_estado.
       RELEASE Total_remunerativo.
       */

   END.

   FIND CURRENT Liquidacion EXCLUSIVE-LOCK.
   Liquidacion.firme = YES.
   APPLY "U1" TO FRAME frm-confirmar.
   
END.   

ON CHOOSE OF btn_salir IN FRAME frm-confirmar
DO:

   APPLY "U1" TO FRAME frm-confirmar.
   
END.   

ON CHOOSE OF btn_retroceder IN FRAME frm-confirmar
DO:

   DO TRANSACTION:
      mensaje = "Retrocediendo liquidacion ...".
      DISPLAY mensaje WITH FRAME espere.

                   /* Borra los recibos y las imputaciones contables */       
  
      FOR EACH Rcb_header 
               WHERE Rcb_header.sec_liquidacion = 
                     Liquidacion.sec_liquidacion EXCLUSIVE-LOCK:

          FOR EACH Rcb_detalle OF Rcb_header EXCLUSIVE-LOCK:
              DELETE Rcb_detalle.
          END.

          FIND Sub_header_syj OF Rcb_header EXCLUSIVE-LOCK.
          FOR EACH Sub_detalle_syj OF Sub_header_syj EXCLUSIVE-LOCK:
              DELETE Sub_detalle_syj.
          END.
          DELETE Sub_header_syj.
          DELETE Rcb_header.

      END.

                /* Restaura los Datos de liquidacion anteriores */       

      FOR EACH Empleado 
          WHERE Empleado.ult_liquidacion = Liquidacion.sec_liquidacion EXCLUSIVE-LOCK:

          FIND FIRST Empleado-ddjj OF Empleado 
               WHERE Empleado-ddjj.sec_liquidacion = Empleado.ult_liquidacion EXCLUSIVE-LOCK.
          DELETE Empleado-ddjj.     

          FOR EACH Concepto_empleado OF Empleado 
              WHERE Concepto_empleado.sec_liquidacion = Empleado.ult_liquidacion EXCLUSIVE-LOCK:
              DELETE Concepto_empleado.
          END.    
       
          FOR EACH Datos_liq OF Empleado 
              WHERE Datos_liq.sec_liquidacion = Empleado.ult_liquidacion EXCLUSIVE-LOCK:
              DELETE Datos_liq.
          END.    

          FIND LAST Datos_liq OF Empleado NO-ERROR.
          Empleado.ult_liquidacion = Datos_liq.sec_liquidacion.

      END.    

      FIND Liquidacion WHERE ROWID(Liquidacion) = act_liquidacion EXCLUSIVE-LOCK.
      Liquidacion.procesada = NO.
      Liquidacion.ult_recibo = 0.
      APPLY "U1" TO FRAME frm-confirmar.

   END. /* De la transaccion */   

END.   
    

/*=================================================================================*/
/*                           CONFIRMA O RETROCEDE UNA LIQUIDACION                  */
/*=================================================================================*/

FIND LAST Liquidacion WHERE Liquidacion.procesada 
                         AND NOT Liquidacion.firme EXCLUSIVE-LOCK NO-ERROR.
IF NOT AVAILABLE Liquidacion
THEN DO:
   RUN PONMENSJ.P ( INPUT "LIQU010").
   RETURN.
END.
                            
DISPLAY    Liquidacion.sec_liquidacion
           Liquidacion.descripcion 
           Liquidacion.fecha        
           WITH FRAME frm-confirmar.

act_liquidacion = ROWID(Liquidacion).
ENABLE btn_confirmar btn_salir btn_retroceder
       WITH FRAME frm-confirmar.
WAIT-FOR U1 OF FRAME frm-confirmar.

/*=================================================================================*/
/*                           P R O C E D I M I E N T O S                           */
/*=================================================================================*/


