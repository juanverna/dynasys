FUNCTION fncumpleatributos RETURNS LOGICAL
    ( INPUT lista_atributos AS CHARACTER, INPUT lista_filtro AS CHARACTER ):

    DEFINE VARIABLE j-atrib AS INTEGER.
    DEFINE VARIABLE cumple  AS LOGICAL.

    IF Articulo.lista_atributos = "" THEN RETURN TRUE.

    DO j-atrib = 1 TO NUM-ENTRIES(lista_atributos,",") WHILE NOT cumple:
        cumple = CAN-DO(lista_filtro,ENTRY(j-atrib,lista_atributos,",")).
    END.

    RETURN cumple.

END FUNCTION.

