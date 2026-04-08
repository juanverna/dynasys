/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:Empleado                             */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Empleado AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Empleado WHERE ROWID(Empleado) = rid_Empleado NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Acumulado_retemp WHERE Acumulado_retemp.nro_empleado = Empleado.nro_empleado) OR
     CAN-FIND(FIRST Anticipo_sue WHERE Anticipo_sue.nro_empleado = Empleado.nro_empleado) OR
     CAN-FIND(FIRST Aud_liquidacion WHERE Aud_liquidacion.nro_empleado = Empleado.nro_empleado) OR
     CAN-FIND(FIRST Concepto_Empleado WHERE Concepto_Empleado.nro_empleado = Empleado.nro_empleado) OR
     CAN-FIND(FIRST Concepto_empleado_ant WHERE Concepto_empleado_ant.nro_empleado = Empleado.nro_empleado) OR
     CAN-FIND(FIRST Cta_cte_emp WHERE Cta_cte_emp.nro_empleado = Empleado.nro_empleado) OR
     CAN-FIND(FIRST Datos_liq WHERE Datos_liq.nro_empleado = Empleado.nro_empleado) OR
     CAN-FIND(FIRST Datos_liq_ant WHERE Datos_liq_ant.nro_empleado = Empleado.nro_empleado) OR
     CAN-FIND(FIRST Empleado-ddjj WHERE Empleado-ddjj.nro_empleado = Empleado.nro_empleado) OR
     CAN-FIND(FIRST Empleado-ddjj_ant WHERE Empleado-ddjj_ant.nro_empleado = Empleado.nro_empleado) OR
     CAN-FIND(FIRST Empleado-entidad WHERE Empleado-entidad.nro_empleado = Empleado.nro_empleado) OR
     CAN-FIND(FIRST Empleado_supertabla WHERE Empleado_supertabla.nro_empleado = Empleado.nro_empleado) OR
     CAN-FIND(FIRST Familiar WHERE Familiar.nro_empleado = Empleado.nro_empleado) OR
     CAN-FIND(FIRST Franco_empleado WHERE Franco_empleado.nro_empleado = Empleado.nro_empleado) OR
     CAN-FIND(FIRST Horario WHERE Horario.nro_empleado = Empleado.nro_empleado) OR
     CAN-FIND(FIRST Hst_afjp WHERE Hst_afjp.nro_empleado = Empleado.nro_empleado) OR
     CAN-FIND(FIRST Parte_diario WHERE Parte_diario.nro_empleado = Empleado.nro_empleado) OR
     CAN-FIND(FIRST Parte_novedades WHERE Parte_novedades.nro_empleado = Empleado.nro_empleado) OR
     CAN-FIND(FIRST Rcb_header WHERE Rcb_header.nro_empleado = Empleado.nro_empleado) OR
     CAN-FIND(FIRST Recurso WHERE Recurso.nro_empleado = Empleado.nro_empleado) OR
     CAN-FIND(FIRST Sre_header WHERE Sre_header.nro_empleado_aut = Empleado.nro_empleado) OR
     CAN-FIND(FIRST Sre_header WHERE Sre_header.nro_empleado_sol = Empleado.nro_empleado)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.
