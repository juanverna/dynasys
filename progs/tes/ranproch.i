DEFINE {1} SHARED VARIABLE ver_por AS INTEGER LABEL "Ordenado Por" VIEW-AS RADIO-SET 
                HORIZONTAL RADIO-BUTTONS "Codigo",  1 , "Nombre", 0 INITIAL 1.
DEFINE {1} SHARED VARIABLE por_cod AS INTEGER INITIAL 1.
DEFINE {1} SHARED VARIABLE por_nom AS INTEGER INITIAL 0.
DEFINE {1} SHARED VARIABLE des_codigo LIKE Proveedor.cdg_Proveedor  LABEL "Desde Proveedor".
DEFINE {1} SHARED VARIABLE has_codigo LIKE Proveedor.cdg_Proveedor  LABEL "Hasta Proveedor".
DEFINE {1} SHARED VARIABLE des_nombre LIKE Proveedor.nombre.
DEFINE {1} SHARED VARIABLE has_nombre LIKE Proveedor.nombre.
DEFINE QUERY qry_Proveedor FOR Proveedor.