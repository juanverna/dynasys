/*Crea TEMP-TABLE base DEL analisis ANAGUA*/
DEFINE TEMP-TABLE resultados
    FIELD Determinacion AS CHAR
    FIELD Valor1 AS CHAR
    FIELD Valor2 AS CHAR
    FIELD Unidad AS CHAR
    FIELD Limite AS CHAR.

DEFINE VAR archivo AS CHAR INITIAL "c:\dynasys10\progs\opr\ANAGUA.xml".
DEFINE VAR retOK AS LOGICAL.

CREATE resultados.
ASSIGN 
    Determinacion = "RECUENTO TOTAL DE BACTERIAS AEROBIAS MESOFILAS"
    Valor1 = ""
    Valor2 = ""
    Unidad = "U.F.C./ml"
    Limite = "Hasta 500 UFC/ml".
CREATE resultados.
ASSIGN 
    Determinacion = "RECUENTO DE COLIFORMES TOTALES y FECALES"
    Valor1 = "<3"
    Valor2 = "<3"
    Unidad = "/100ml (NMP)"
    Limite = "3/100ml".
CREATE resultados.
ASSIGN 
    Determinacion = "PRESENCIA DE ESCHERICHIA COLI"
    Valor1 = "Ausencia"
    Valor2 = "Ausencia"
    Unidad = "/100ml"
    Limite = "Ausencia en 100ml".
CREATE resultados.
ASSIGN 
    Determinacion = "PRESENCIA DE PSEUDOMONAS AERUGINOSA"
    Valor1 = "Ausencia"
    Valor2 = "Ausencia"
    Unidad = "/100ml"
    Limite = "Ausencia en 100ml".

retOK = TEMP-TABLE resultados:WRITE-XML("file", 
                                    archivo,
                                    FALSE, 
                                    ?, 
                                    ?, 
                                    YES, 
                                    YES). 

