/*=================================================================================*/
/*              Genera los datos de liquidacion de un empleado                     */
/*=================================================================================*/

/*{VPERSINM.I}*/

{VRSHARED.I}

FIND Empleado  WHERE ROWID(Empleado)  = act_empleado NO-LOCK.
FOR EACH Tit_dat_liquid WHERE Tit_dat_liquid.obligatorio NO-LOCK:
    FIND FIRST Datos_liq OF Empleado WHERE Datos_liq.cdg_datliq = Tit_dat_liquid.cdg_datliq NO-LOCK NO-ERROR.
    IF NOT AVAILABLE Datos_liq
    THEN DO:
       CREATE Datos_liq.
       ASSIGN Datos_liq.cdg_datliq      = Tit_dat_liquid.cdg_datliq
              Datos_liq.nro_empleado    = Empleado.nro_empleado
              Datos_liq.sec_liquidacion = Empleado.ult_liquidacion.
    END.
END.                      
