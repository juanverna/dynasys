{resultados.i}
    DEFINE VAR retOK AS LOGICAL.
 DEFINE VAR ldato AS LONGCHAR.
    FIND evento_protocolo WHERE nro_evento = 952273.
CREATE resultados.
ASSIGN 
    Determinacion = "[M1]RECUENTO AEROBIAS MESOFILAS"
    Valor1 = string(RANDOM(5,20))
    Valor2 = ""
    Unidad = "U.F.C./ml"
    Limite = "Hasta 500 UFC/ml".
CREATE resultados.
ASSIGN 
    Determinacion = "[M1]RECUENTO COLIFORMES TOT/FECALES"
    Valor1 = "<3"
    Valor2 = "<3"
    Unidad = "/100ml (NMP)"
    Limite = "3/100ml".
CREATE resultados.
ASSIGN 
    Determinacion = "[M1]PRESENCIA ESCHERICHIA COLI"
    Valor1 = "Ausencia"
    Valor2 = "Ausencia"
    Unidad = "/100ml"
    Limite = "Ausencia en 100ml".
CREATE resultados.
ASSIGN 
    Determinacion = "[M1]PRESENCIA PSEUDOMONAS AERUGINOSA"
    Valor1 = "Ausencia"
    Valor2 = "Ausencia"
    Unidad = "/100ml"
    Limite = "Ausencia en 100ml".
CREATE resultados.
ASSIGN 
    Determinacion = "[M2]RECUENTO AEROBIAS MESOFILAS"
    Valor1 = string(RANDOM(5,20))
    Valor2 = ""
    Unidad = "U.F.C./ml"
    Limite = "Hasta 500 UFC/ml".
CREATE resultados.
ASSIGN 
    Determinacion = "[M2]RECUENTO COLIFORMES TOT./FECALES"
    Valor1 = "<3"
    Valor2 = "<3"
    Unidad = "/100ml (NMP)"
    Limite = "3/100ml".
CREATE resultados.
ASSIGN 
    Determinacion = "[M2]PRESENCIA ESCHERICHIA COLI"
    Valor1 = "Ausencia"
    Valor2 = "Ausencia"
    Unidad = "/100ml"
    Limite = "Ausencia en 100ml".
CREATE resultados.
ASSIGN 
    Determinacion = "[M2]PRESENCIA PSEUDOMONAS AERUGINOSA"
    Valor1 = "Ausencia"
    Valor2 = "Ausencia"
    Unidad = "/100ml"
    Limite = "Ausencia en 100ml".

    retOK = TEMP-TABLE resultados:WRITE-XML("longchar", 
                                    ldato,
                                    FALSE, 
                                    ?, 
                                    ?, 
                                    YES, 
                                    YES). 
    evento_protocolo.dato = ldato.

