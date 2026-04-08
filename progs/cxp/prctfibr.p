/*=================================================================================*/
/*               IMPRESION DE CERTIFICADO DE RETENCION DE GANANCIAS                */
/*=================================================================================*/

DEFINE INPUT PARAMETER que_certificado AS ROWID.

DEFINE VARIABLE que_rutina             AS CHARACTER.
DEFINE VARIABLE ncopias                AS INTEGER.
DEFINE VARIABLE j                      AS INTEGER.

{VRSHARED.I}
{VPERSINM.I}

RUN getparametro.p (  INPUT  "NFRETIBR",
                      OUTPUT v-valor_c,
                      OUTPUT v-valor_d,
                      OUTPUT v-valor_l,
                      OUTPUT v-valor_n,
                      OUTPUT v-observacion ).
que_rutina = "PRRTIBR" + STRING(v-valor_n, "999") + ".P".

RUN getparametro.p (  INPUT  "NCOPRIBR",
                      OUTPUT v-valor_c,
                      OUTPUT v-valor_d,
                      OUTPUT v-valor_l,
                      OUTPUT v-valor_n,
                      OUTPUT v-observacion ).

ncopias = v-valor_n.

DO j = 1 TO ncopias:
   RUN VALUE(que_rutina) (INPUT que_certificado).
END.

