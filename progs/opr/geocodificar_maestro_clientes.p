/*geocodificar maestro de clientes*/
{geolibrary.i}

    DEFINE VAR v-altura AS CHAR NO-UNDO.
    DEFINE VAR v-direccion AS CHAR NO-UNDO.
    DEFINE VAR v-extra AS CHAR NO-UNDO.
    FOR EACH cliente WHERE int(cliente.geolat) = 0:
/*          PAUSE 0. */
        DISPLAY cdg_cliente cliente.direccion .
        RUN geocodingOPT( toxAL(cliente.direccion,OUTPUT v-extra) + " " + cliente.localidad, OUTPUT TABLE internal-ttgeo).
/*       IF cliente.geolat <> 0 THEN DO:
        cliente.geoX = X(cliente.geolat,cliente.geolong).
        cliente.geoY = Y(cliente.geolat,cliente.geolong).
        DISPLAY cliente.direccion cliente.geolat cliente.geolong.
        PAUSE 0.
    END.        */
        FOR EACH internal-ttgeo:
            DISPLAY internal-ttgeo.
        END.
    END.
