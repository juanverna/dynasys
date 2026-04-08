/*========================================================================*/
/*    AGREGA UNA ENTRADA EN UNA LISTA SEPARADA POR UN CARACTER DADO       */
/*========================================================================*/    

    DEFINE INPUT        PARAMETER p-nombre_entrada       AS CHARACTER.
    DEFINE INPUT-OUTPUT PARAMETER p-lista_entradas       AS CHARACTER.
    DEFINE INPUT        PARAMETER p-separador            AS CHARACTER.

    IF p-lista_entradas <> ""
         THEN p-lista_entradas = p-lista_entradas + p-separador + p-nombre_entrada.
         ELSE p-lista_entradas = p-nombre_entrada.
    
