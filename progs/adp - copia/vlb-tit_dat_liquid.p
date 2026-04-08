
/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:Tit_dat_liquid                             */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Tit_dat_liquid AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Tit_dat_liquid WHERE ROWID(Tit_dat_liquid) = rid_Tit_dat_liquid NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Accion_concepto WHERE Accion_concepto.cdg_datliq = Tit_dat_liquid.cdg_datliq) OR
     CAN-FIND(FIRST Accion_dato WHERE Accion_dato.cdg_datliq = Tit_dat_liquid.cdg_datliq) OR
     CAN-FIND(FIRST Datos_liq WHERE Datos_liq.cdg_datliq = Tit_dat_liquid.cdg_datliq) OR
     CAN-FIND(FIRST Datos_liq_ant WHERE Datos_liq_ant.cdg_datliq = Tit_dat_liquid.cdg_datliq) 
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.
