DEFINE VARIABLE WL-CEM-LEGAJO         AS INTEGER.
DEFINE VARIABLE WL-CEM-CODIGO         AS INTEGER.
DEFINE VARIABLE WL-CEM-NUMLIQ         AS INTEGER.
DEFINE VARIABLE WL-CEM-DESFEC         AS CHARACTER.
DEFINE VARIABLE WL-CEM-HASFEC         AS CHARACTER.

FOR EACH Concepto_empleado:
    DELETE Concepto_empleado.
END.    

INPUT FROM "CODEMPLE.TXT".

REPEAT:

  IMPORT DELIMITER ","
         WL-CEM-LEGAJO
         WL-CEM-CODIGO
         WL-CEM-NUMLIQ
         WL-CEM-DESFEC
         WL-CEM-HASFEC.

           
  FIND FIRST Empleado  WHERE Empleado.nro_legajo   = WL-CEM-LEGAJO.
  FIND FIRST Concepto  WHERE Concepto.cdg_concepto = WL-CEM-CODIGO NO-ERROR.
  IF AVAILABLE Concepto
  THEN DO:
     CREATE Concepto_empleado.
     ASSIGN  
         Concepto_empleado.nro_de_liq   = WL-CEM-NUMLIQ.
         Concepto_empleado.nro_empleado = Empleado.nro_empleado.
         Concepto_empleado.nro_concepto = Concepto.nro_concepto.
  END.
  ELSE DO:
     DISPLAY WL-CEM-LEGAJO WL-CEM-CODIGO.
  END.         
END.         