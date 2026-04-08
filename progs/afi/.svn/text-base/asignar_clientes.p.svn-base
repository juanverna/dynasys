/*=======================================================================*/
/*        CREA LOS REGISTROS DE CLIENTES ASOCIADOS A LOS GRUPOS          */
/*=======================================================================*/

DEFINE STREAM Errores.
OUTPUT STREAM Errores TO "c:\txts\sincliente.err".

FOR EACH Grupofam WHERE Grupofam.cdg_estado = "A" 
                        USE-INDEX para_cupones:

    FIND Cliente WHERE Cliente.cdg_cliente  = Grupofam.cdg_empresa + Grupofam.cdg_grupofam
                        NO-ERROR.
    IF AVAILABLE Cliente 
    THEN DO:
        Grupofam.nro_cliente = Cliente.nro_cliente.
        Cliente.nom_cliente = Grupofam.nom_grupofam.
    END.               
    ELSE DO:
        PUT STREAM Errores Grupofam.cdg_empresa " " Grupofam.cdg_grupofam  SKIP.
    END.
END.

OUTPUT STREAM Errores CLOSE.
