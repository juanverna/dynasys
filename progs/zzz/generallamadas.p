DEFINE STREAM Programa.
FOR EACH tipocomprobante:
    OUTPUT STREAM Programa TO VALUE("c:\desa\v9\sic\r3.4\progs\fac\run_" + Tipocomprobante.cdg_comprobante + ".p") PAGE-SIZE 0.
    PUT STREAM Programa UNFORMATTED "/*==========================================================================================*/" SKIP.
    PUT STREAM Programa UNFORMATTED "/*                            EJECUTA FACTURAS DE CLIENTES                                  */" SKIP.
    PUT STREAM Programa UNFORMATTED "/*==========================================================================================*/" SKIP.
    PUT STREAM Programa UNFORMATTED "                                                                                              " SKIP.
    PUT STREAM Programa UNFORMATTED "DEFINE INPUT-OUTPUT PARAMETER  rid_factura    AS ROWID.                                       " SKIP.
    PUT STREAM Programa UNFORMATTED "DEFINE INPUT        PARAMETER  modo           AS INTEGER.                                     " SKIP.
    PUT STREAM Programa UNFORMATTED "                                                                                              " SKIP.
    PUT STREAM Programa UNFORMATTED "RUN c-comprobante_cliente.w ( INPUT-OUTPUT rid_factura , INPUT modo ).                        " SKIP.
    PUT STREAM Programa UNFORMATTED "                                                                                              " SKIP.
    OUTPUT STREAM Programa CLOSE.
END.
