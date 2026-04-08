/*=================================================================================================*/
/*  VERIFICA SI UN DETERMINADO PROGAMA HA INTERVENIDO EN LA SECUENCIA DE LLAMADAS. (stack)         */
/*=================================================================================================*/

    DEFINE INPUT  PARAMETER p-programa  AS CHARACTER.
    DEFINE OUTPUT PARAMETER p-intervino AS LOGICAL.
    
    DEFINE VARIABLE quien_llama         AS CHARACTER.
    DEFINE VARIABLE i                   AS INTEGER.
    DEFINE VARIABLE j                   AS INTEGER.

/*=================================================================================================*/
/*                                 BLOQUE PRINCIPAL                                                */
/*=================================================================================================*/

    i = 2. /* Salteamos el programa actual: PROGRAM-NAME(1) */
    detodo:
    DO WHILE quien_llama <> ?:
        quien_llama = PROGRAM-NAME(i).
        DO j = 1 TO NUM-ENTRIES(p-programa,","):
            IF ENTRY(1,quien_llama,".") = ENTRY(1,entry( j , p-programa , "," ),".") OR i = 100
                THEN LEAVE detodo.
        END.
            i = i + 1.
    END.
    
    p-intervino = i < 100 AND i > 2 AND quien_llama <> ?.

