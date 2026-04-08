  IF ver_por = 1
  THEN DO:
     OPEN QUERY qry_empleados
     FOR EACH Empleado WHERE Empleado.nro_legajo >= des_legajo
                         AND Empleado.nro_legajo <= has_legajo
                         AND LOOKUP(Empleado.cdg_estado,sel_codigos) <> 0
                         AND Empleado.cdg_forma = "{1}"
                          BY Empleado.nro_legajo.
  END.
  ELSE DO:
     OPEN QUERY qry_empleados
     FOR EACH Empleado WHERE Empleado.nombre >= des_nombre
                         AND Empleado.nombre <= has_nombre
                         AND LOOKUP(Empleado.cdg_estado,sel_codigos) <> 0
                         AND Empleado.cdg_forma = "{1}"
                          BY Empleado.nombre.
  END.