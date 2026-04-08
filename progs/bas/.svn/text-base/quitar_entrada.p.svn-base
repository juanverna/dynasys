/*========================================================================*/
/*     QUITA UNA ENTRADA DE UNA LISTA SEPARADA POR UN CARACTER DADO       */
/*========================================================================*/    


    DEFINE INPUT        PARAMETER p-nombre_entrada  AS CHARACTER.
    DEFINE INPUT-OUTPUT PARAMETER p-lista_entradas  AS CHARACTER.
    DEFINE INPUT        PARAMETER p-separador       AS CHARACTER.

/*========================================================================*/
/*                              VARIABLES                                 */
/*========================================================================*/    

    DEFINE VARIABLE         x-lista_entradas        AS CHARACTER.
    DEFINE VARIABLE         j-entrada               AS INTEGER.

/*========================================================================*/
/*                               PROCESO                                  */
/*========================================================================*/    

    IF p-lista_entradas = p-nombre_entrada
    THEN DO:
        x-lista_entradas = "".
    END.
    ELSE DO:
        x-lista_entradas = "".
        DO j-entrada = 1 TO NUM-ENTRIES(p-lista_entradas):
            IF ENTRY(j-entrada,p-lista_entradas,p-separador) <> p-nombre_entrada
                 THEN x-lista_entradas = p-separador + x-lista_entradas + ENTRY(j-entrada,p-lista_entradas,p-separador).
        END.
        x-lista_entradas = SUBSTRING(x-lista_entradas,2).
    END.
             
    p-lista_entradas = x-lista_entradas.
