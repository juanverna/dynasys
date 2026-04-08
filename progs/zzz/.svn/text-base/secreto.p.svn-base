DEFINE VARIABLE alfabeto AS CHARACTER FORMAT "X(50)" INITIAL "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ 0123456789".
DEFINE VARIABLE palabra  AS CHARACTER                INITIAL "FIDELCASTRO".
DEFINE VARIABLE cryptado AS CHARACTER FORMAT "X(50)" INITIAL "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ0123456789".
DEFINE VARIABLE ja       AS INTEGER.
DEFINE VARIABLE directo  AS CHARACTER FORMAT "X(30)".
DEFINE VARIABLE secreto  AS CHARACTER FORMAT "X(30)".

cryptado = palabra.
ja = 1.
DO ja = 1 TO LENGTH(alfabeto):
    IF INDEX(palabra,SUBSTRING(alfabeto,ja,1)) = 0 
        THEN cryptado = cryptado + SUBSTRING(alfabeto,ja,1).
END.

REPEAT:
    UPDATE directo secreto.
    IF directo <> ""
    THEN DO:
        secreto = "".
        DO ja = 1 TO LENGTH(directo):
            secreto = secreto + SUBSTRING(cryptado,INDEX(alfabeto,SUBSTRING(directo,ja,1)),1).
        END.
    END.
    ELSE DO:
        directo = "".
        DO ja = 1 TO LENGTH(secreto):
            directo = directo + SUBSTRING(alfabeto,INDEX(cryptado,SUBSTRING(secreto,ja,1)),1).
        END.
    END.

END.
