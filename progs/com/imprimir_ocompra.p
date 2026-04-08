/*=================================================================================*/
/*                 PROCESO DE IMPRESION DE UNA ORDEN DE COMPRA                       */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_ocompra AS ROWID.

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

{parlocales.i}

DEFINE VARIABLE j                     AS INTEGER.
DEFINE VARIABLE ncopias               AS INTEGER.

DEFINE VARIABLE que_rutina            AS CHARACTER.

/*=================================================================================*/
/*                           IMPRESION DEL COMPROBANTE                             */
/*=================================================================================*/

RUN getparametro.p (  INPUT  "NCOPIAPD",
                      OUTPUT v-valor_c,
                      OUTPUT v-valor_d,
                      OUTPUT v-valor_l,
                      OUTPUT v-valor_n,
                      OUTPUT v-observacion ).
ncopias = v-valor_n.

RUN getparametro.p (  INPUT  "NFOCOMPR",
                      OUTPUT v-valor_c,
                      OUTPUT v-valor_d,
                      OUTPUT v-valor_l,
                      OUTPUT v-valor_n,
                      OUTPUT v-observacion ).

que_rutina = "PROCM" + STRING(v-valor_n, "999") + ".P".

RUN getparametro.p (  INPUT  "FACTHOJA",
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
   RUN VALUE(que_rutina) (INPUT rid_ocompra).
END.

