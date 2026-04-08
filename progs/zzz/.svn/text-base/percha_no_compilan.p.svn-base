DEFINE VARIABLE linea AS CHARACTER FORMAT "x(30)".
DEFINE VARIABLE v-nombre AS CHARACTER FORMAT "x(30)".

DEFINE VARIABLE nl AS INTEGER.

DEFINE TEMP-TABLE Nocompila
    FIELD nombre AS CHARACTER FORMAT "X(40)"
    INDEX por_nombres IS PRIMARY UNIQUE nombre.

INPUT FROM "C:\desa\v9\sic\r3.5.2\progs\compile.log".

REPEAT:
    IMPORT UNFORMATTED linea.
    IF linea BEGINS "Compiling"
    THEN DO:
        nl = NUM-ENTRIES(linea,"\").
        v-nombre = ENTRY(nl - 1, linea,"\") + "\" + ENTRY(nl, linea,"\").
    END.

    IF linea BEGINS "**"
    THEN DO:
        FIND Nocompila WHERE Nocompila.nombre = v-nombre NO-ERROR.
        IF NOT AVAILABLE Nocompila
        THEN DO:
            CREATE Nocompila.
            ASSIGN Nocompila.nombre = v-nombre.
        END.
    END.
END.

OUTPUT TO "C:\desa\v9\sic\r3.5.2\progs\cremano.bat" PAGE-SIZE 0.
FOR EACH Nocompila:
    PUT UNFORMATTED "DEL .\" Nocompila.nombre SKIP.
END.
OUTPUT CLOSE.
