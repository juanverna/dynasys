fecha_lis = TODAY.
hora_lis = STRING(TIME,"HH:MM:SS").

arch_salida = PROGRAM-NAME(1).
arch_salida = LC( "C:\sah-temp\" +  SUBSTRING(arch_salida,1,INDEX(arch_salida,".") - 1) + ".lst").
OUTPUT TO VALUE(arch_salida) PAGE-SIZE {1}. 
