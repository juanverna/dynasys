DEFINE VARIABLE nombre_copia AS CHARACTER EXTENT 8
    INITIAL ["Original","Duplicado","Triplicado","Cuadruplicado","Quintuplicado","Sextuplicado","Septuplicado","Octuplicado"].
DEFINE VARIABLE J AS INTEGER.

DO  j = 1 TO 8:
    CREATE parametro.
    ASSIGN parametro.cdg_empresa = "M"
           parametro.cdg_parametro = "NOMCOP" + STRING(j,"99")
           parametro.descripcion = "Nombre de la " + STRING(j,">9") + "-esima copia de comprobantes"
           parametro.valor_c = nombre_copia [ j ].
END.


