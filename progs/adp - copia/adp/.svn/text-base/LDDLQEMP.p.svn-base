DEFINE VARIABLE WL-DLQ-LEGAJO         AS INTEGER.
DEFINE VARIABLE WL-DLQ-NUMERO         AS INTEGER.
DEFINE VARIABLE WL-DLQ-VALORN         AS DECIMAL.

FOR EACH Datos_liq:
    DELETE Datos_liq.
END.    


INPUT FROM "DATLIQUD.TXT".

REPEAT:

  IMPORT DELIMITER ","
         WL-DLQ-LEGAJO
         WL-DLQ-NUMERO
         WL-DLQ-VALORN.

  FIND FIRST Tit_dat_liquid WHERE Tit_dat_liquid.cdg_datliq = WL-DLQ-NUMERO NO-ERROR.
  IF AVAILABLE Tit_dat_liquid
  THEN DO:
     FIND FIRST Empleado    WHERE Empleado.nro_legajo   = WL-DLQ-LEGAJO.
     CREATE Datos_liq.
     ASSIGN
            Datos_liq.cdg_datliq    = WL-DLQ-NUMERO
            Datos_liq.nro_empleado  = Empleado.nro_empleado
            Datos_liq.valor         = WL-DLQ-VALORN.
  END.       

END.         