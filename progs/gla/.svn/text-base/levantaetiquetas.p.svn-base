/*=========================================================================================*/
/*   LEVANTA EL ARCHIVO DE DEFINICION DE ETIQUETAS DE COMANDO                              */
/*=========================================================================================*/

{dftabletiqueta.i}

DEFINE VARIABLE v-nro_articulo      LIKE T-Etiqueta.nro_articulo. 
DEFINE VARIABLE v-nro_registrable   LIKE T-Etiqueta.nro_registrable. 
DEFINE VARIABLE v-num_etiqueta      LIKE T-Etiqueta.num_etiqueta.
DEFINE VARIABLE v-descripcion       LIKE T-Etiqueta.descripcion.

INPUT FROM "c:\sic-temp\comandetiqueta.txt".
REPEAT :
    IMPORT DELIMITER "," v-num_etiqueta v-descripcion.
    CREATE T-Etiqueta.
    ASSIGN T-Etiqueta.nro_articulo      = v-num_etiqueta 
           T-Etiqueta.nro_registrable   = v-num_etiqueta 
           T-Etiqueta.num_etiqueta      = v-num_etiqueta
           T-Etiqueta.descripcion       = v-descripcion.
END.
INPUT CLOSE.

REPEAT:
    FOR EACH T-Etiqueta:
        DISPLAY T-Etiqueta.num_etiqueta T-Etiqueta.descripcion.
    END.
    UPDATE v-num_etiqueta.
    FIND T-Etiqueta WHERE T-Etiqueta.num_etiqueta = v-num_etiqueta.

    RUN pretiqueta_comando.p ( INPUT T-Etiqueta.num_etiqueta, 
                               INPUT "MASTELLONE HNOS S.A.",
                               INPUT T-Etiqueta.descripcion,
                               INPUT SESSION:PRINTER-NAME ).
END.
