DEFINE {1} SHARED VARIABLE ver_por AS INTEGER LABEL "Ordenado Por" VIEW-AS RADIO-SET 
                HORIZONTAL RADIO-BUTTONS "Codigo",  1 , "Nombre", 0 INITIAL 0.

DEFINE {1} SHARED VARIABLE des_legajo LIKE Empleado.nro_legajo LABEL "Desde Empleado".
DEFINE {1} SHARED VARIABLE has_legajo LIKE Empleado.nro_legajo LABEL "Hasta Empleado".
DEFINE {1} SHARED VARIABLE des_nombre   LIKE Empleado.nombre.
DEFINE {1} SHARED VARIABLE has_nombre   LIKE Empleado.nombre.