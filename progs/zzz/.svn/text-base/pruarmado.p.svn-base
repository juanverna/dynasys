DEFINE VARIABLE t1 AS INTEGER.
DEFINE VARIABLE t2 AS INTEGER.

DEFINE TEMP-TABLE Acumulado NO-UNDO
   FIELD cdg_empresa         LIKE Empresa.cdg_empresa
   FIELD nro_cliente       AS INTEGER
   FIELD n-columna           AS INTEGER
   FIELD importe             AS DECIMAL FORMAT ">>,>>>,>>9.99-"
   INDEX por_fila_columna IS UNIQUE PRIMARY nro_cliente n-columna.
t1 = TIME.
RUN ARMAR_ANTICUACION.P ( OUTPUT TABLE Acumulado).
t2 = TIME - t1.
MESSAGE STRING(t2,"HH:MM:SS")
    VIEW-AS ALERT-BOX INFO BUTTONS OK TITLE "armado de la temporal" .
FOR EACH ACUMULADO WHERE n-columna = 0, FIRST cliente OF acumulado BY Cliente.cdg_cliente:
    DISPLAY cdg_cliente cliente.nom_cliente Acumulado.importe.

END.
