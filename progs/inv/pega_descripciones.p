DEFINE BUFFER Subclase FOR Clase_de_articulo.
DEFINE BUFFER Clase    FOR Clase_de_articulo.
DEFINE BUFFER Superior FOR Clase_de_articulo.
DEFINE VARIABLE v-nom AS CHARACTER FORMAT "X(70)".
DEFINE VARIABLE v-cod AS CHARACTER FORMAT "X(12)".
DEFINE VARIABLE v-sup AS CHARACTER FORMAT "X(12)".
DEFINE VARIABLE j-wrd AS INTEGER.
DEFINE VARIABLE x-reemplazo AS CHARACTER.
DEFINE VARIABLE s-reemplazo AS CHARACTER. 
DEFINE VARIABLE reemplazo AS CHARACTER EXTENT 50.

RUN getparametro_o.p ( INPUT "EQVDESCR", OUTPUT s-reemplazo ).

DO j-wrd = 1 TO NUM-ENTRIES(s-reemplazo,",").
    reemplazo [ j-wrd ] = ENTRY(j-wrd,s-reemplazo,",").
END.

FOR EACH Clase WHERE NOT CAN-FIND(FIRST Subclase WHERE Subclase.cdg_clase = Clase.cdg_subclase) 
                 AND Clase.cdg_clase BEGINS ".F.AH.20" NO-LOCK:

    v-cod = REPLACE(Clase.cdg_subclase,".","").
    v-nom = Clase.nombre_subclase.
    v-sup = Clase.cdg_clase.

    FIND Superior WHERE Superior.cdg_subclase = v-sup NO-LOCK NO-ERROR.

    DO WHILE AVAILABLE Superior:

        v-nom = Superior.nombre_subclase + " " + v-nom.
        v-sup = Superior.cdg_clase.
        FIND Superior WHERE Superior.cdg_subclase = v-sup NO-LOCK NO-ERROR.

    END.

    x-reemplazo = reemplazo [ 1 ].
    DO j-wrd = 1 TO 50 WHILE x-reemplazo <> "$=$":
        v-nom = REPLACE(v-nom,ENTRY(1,x-reemplazo,"="),ENTRY(2,x-reemplazo,"=")).
        x-reemplazo = reemplazo [ j-wrd + 1 ].
    END.

    DISPLAY j-wrd v-cod v-nom WITH STREAM-IO WIDTH 132.

END.
