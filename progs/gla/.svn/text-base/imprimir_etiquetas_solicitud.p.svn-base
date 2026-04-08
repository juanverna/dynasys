/*============================================================================================*/
/*                    IMPRIME LAS ETIQUETAS DE UNA SOLICITUD DE RETIRO                        */
/*============================================================================================*/

DEFINE INPUT PARAMETER rid_solicitud AS ROWID.

DEFINE VARIABLE j AS INTEGER.
DEFINE VARIABLE v-impresora AS CHARACTER.

{xprint.i}

RUN LoadXprint.

DEFINE VARIABLE M AS MEMPTR NO-UNDO.
DEFINE VARIABLE A AS CHAR   NO-UNDO.

SET-SIZE(M) = 256.                       
RUN PrinterDialog( M ).

A = GET-STRING(M, 1).

SET-SIZE(M) = 0.

v-impresora = ENTRY(1, A).

/* "Format Name :" ENTRY(2, A)                      */
/* "Dim :" ENTRY(3, A) "x" ENTRY(4, A) "(tenth mm)" */
/* "Orientation :" ENTRY(5, A)                      */


RUN UnLoadXprint.

IF v-impresora = "" THEN RETURN. /*NO IMPRIME*/

FIND Sre_header WHERE ROWID(Sre_header) = rid_solicitud NO-LOCK.

FOR EACH Sre_detalle OF Sre_header, FIRST Articulo OF Sre_detalle BY Articulo.cdg_articulo:
    IF Articulo.es_registrable
    THEN DO:
        FOR EACH Registrable-solicitud OF Sre_detalle:

            FIND FIRST Etiqueta 
                 WHERE Etiqueta.nro_articulo     = Articulo.nro_articulo
                   AND Etiqueta.nro_registrable  = Registrable-solicitud.nro_registrable
                       NO-LOCK NO-ERROR.
            IF NOT AVAILABLE Etiqueta
            THEN DO TRANSACTION:
                CREATE Etiqueta.
                ASSIGN Etiqueta.nro_articulo     = Articulo.nro_articulo
                       Etiqueta.nro_registrable  = Registrable-solicitud.nro_registrable
                       Etiqueta.num_etiqueta     = NEXT-VALUE(proxima_etiqueta).
            END.
            
            RUN pretiqueta.p ( INPUT Etiqueta.num_etiqueta, INPUT 1, INPUT v-impresora).
        END.

    END.
    ELSE DO:
        FIND FIRST Etiqueta 
             WHERE Etiqueta.nro_articulo     = Articulo.nro_articulo
               AND Etiqueta.nro_registrable  = 0
                   NO-LOCK NO-ERROR.
        IF NOT AVAILABLE Etiqueta
        THEN DO TRANSACTION:
            CREATE Etiqueta.
            ASSIGN Etiqueta.nro_articulo     = Articulo.nro_articulo
                   Etiqueta.nro_registrable  = 0
                   Etiqueta.num_etiqueta     = NEXT-VALUE(proxima_etiqueta).
        END.

        IF Sre_detalle.modo_etiquetas = "J" 
        THEN DO:
            RUN pretiqueta.p ( INPUT Etiqueta.num_etiqueta, INPUT Sre_detalle.cantidad, INPUT v-impresora).
        END.
        ELSE DO:
            DO j = 1 TO Sre_detalle.cantidad:
                RUN pretiqueta.p ( INPUT Etiqueta.num_etiqueta, INPUT 1, INPUT v-impresora).
            END.
        END.
    END.
    
END.
