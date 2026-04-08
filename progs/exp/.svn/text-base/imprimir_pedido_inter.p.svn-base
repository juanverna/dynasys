/*=================================================================================*/
/*                    IMPRESION DE FACTURAS A CLIENTES                             */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_pedido  AS ROWID.

/*=================================================================================*/
/*                                VARIABLES                                        */
/*=================================================================================*/

{parlocales.i}

DEFINE VARIABLE que_rutina          AS CHARACTER.
DEFINE VARIABLE ncopias             AS INTEGER.
DEFINE VARIABLE j                   AS INTEGER.

/*=================================================================================*/
/*                         INICIALIZACION DE LA EMISION                            */
/*=================================================================================*/

RUN getparametro.p (  INPUT  "NCOPIAPD",
                      OUTPUT v-valor_c,
                      OUTPUT v-valor_d,
                      OUTPUT v-valor_l,
                      OUTPUT v-valor_n,
                      OUTPUT v-observacion ).
ncopias = v-valor_n.

RUN getparametro.p (  INPUT  "NFPEDIDO",
                      OUTPUT v-valor_c,
                      OUTPUT v-valor_d,
                      OUTPUT v-valor_l,
                      OUTPUT v-valor_n,
                      OUTPUT v-observacion ).

que_rutina = "PRFEX" + STRING(v-valor_n, "999") + ".P".

RUN getparametro.p (  INPUT  "PEDIHOJA",
                      OUTPUT v-valor_c,
                      OUTPUT v-valor_d,
                      OUTPUT v-valor_l,
                      OUTPUT v-valor_n,
                      OUTPUT v-observacion ).
DO j = 1 TO ncopias:
    IF v-valor_l
    THEN DO:
       MESSAGE "Por Favor, coloque formulario en la impresora para"
               + " imprimir copia de pedido Nro.:" + STRING(j,"9")
               VIEW-AS ALERT-BOX MESSAGE TITLE "Pausa de impresion".
    END.
    RUN VALUE(que_rutina) (INPUT rid_pedido).

END.
