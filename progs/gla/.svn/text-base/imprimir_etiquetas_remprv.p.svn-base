/*============================================================================================*/
/*                    IMPRIME LAS ETIQUETAS DE UNA SOLICITUD DE RETIRO                        */
/*============================================================================================*/

DEFINE INPUT PARAMETER rid_solicitud AS ROWID.

FIND Rem_header_prv WHERE ROWID(Rem_header_prv) = rid_solicitud NO-LOCK.

FOR EACH Rem_detalle_prv OF Rem_header_prv, FIRST Articulo OF Rem_detalle_prv:
    IF Articulo.es_registrable
    THEN DO:
        FOR EACH Registrable-remprov OF Rem_detalle_prv:
            FIND FIRST Etiqueta 
                 WHERE Etiqueta.nro_articulo     = Articulo.nro_articulo
                   AND Etiqueta.nro_registrable  = Registrable-remprov.nro_registrable
                       NO-LOCK NO-ERROR.
            IF NOT AVAILABLE Etiqueta
            THEN DO TRANSACTION:
                CREATE Etiqueta.
                ASSIGN Etiqueta.nro_articulo     = Articulo.nro_articulo
                       Etiqueta.nro_registrable  = Registrable-remprov.nro_registrable
                       Etiqueta.num_etiqueta     = NEXT-VALUE(proxima_etiqueta).
            END.
            RUN pretiqueta.p ( INPUT Etiqueta.num_etiqueta, INPUT 1 ).
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
        RUN pretiqueta.p ( INPUT Etiqueta.num_etiqueta, INPUT Rem_detalle_prv.cantidad ).
    END.
    
END.
