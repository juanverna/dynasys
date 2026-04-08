/*====================================================================================*/
/*                 IMPRESION DE UN LOTE DE FACTURAS CONSECUTIVAS                      */
/*====================================================================================*/

DEFINE INPUT PARAMETER p-tip_comprob LIKE Fac_header.tip_comprob.
DEFINE INPUT PARAMETER p-prf_comprob LIKE Fac_header.prf_comprob.
DEFINE INPUT PARAMETER p-des_nrocomp LIKE Fac_header.nro_comprob.
DEFINE INPUT PARAMETER p-has_nrocomp LIKE Fac_header.nro_comprob.

/*====================================================================================*/
/*                                    VARIABLES                                       */
/*====================================================================================*/

DEFINE VARIABLE que_rutina           AS CHARACTER.
DEFINE VARIABLE j                    AS INTEGER.
DEFINE VARIABLE ncopias              AS INTEGER.
DEFINE INPUT PARAMETER lista_tipos  AS CHARACTER.
{parlocales.i}

{findempresa.i}

/*====================================================================================*/
/*                                 BLOQUE PRINCIPAL                                   */
/*====================================================================================*/

DO TRANSACTION:

    RUN getparametro.p (  INPUT  "CREDEBFC",
                      OUTPUT v-valor_c,
                      OUTPUT v-valor_d,
                      OUTPUT v-valor_l,
                      OUTPUT v-valor_n,
                      OUTPUT v-observacion ).

IF v-valor_l THEN lista_tipos = "F"  + SUBSTRING( p-tip_comprob , 2 ) + ",C" + SUBSTRING( p-tip_comprob , 2 ) + ",D" + SUBSTRING(  p-tip_comprob , 2 ).
ELSE lista_tipos = p-tip_comprob.

    FOR EACH Fac_header 
        WHERE Fac_header.cdg_empresa  = Empresa.cdg_empresa
        AND CAN-DO(lista_tipos,Fac_header.tip_comprob)
          AND Fac_header.prf_comprob  = p-prf_comprob
          AND Fac_header.nro_comprob  <= p-has_nrocomp
          AND Fac_header.nro_comprob  >= p-des_nrocomp
              EXCLUSIVE-LOCK:
    
        RUN imprimir_factura.
        ASSIGN fac_header.impreso = "S".

    END.

END.

/*====================================================================================*/
/*                            P R O C E D I M I E N T O S                             */
/*====================================================================================*/

PROCEDURE imprimir_factura:
    RUN imprimir_comprobante_cliente.p ( INPUT ROWID(fac_header) ).
END PROCEDURE.
