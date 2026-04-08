/*===========================================================================*/
/*         DETERMINA SI LAS OBRAS ESTAN HABILITADAS EN ESTA INSTALACION      */
/*===========================================================================*/

DEFINE OUTPUT PARAMETER hay_obras AS LOGICAL.

{parlocales.i}

RUN getparametro.p (  INPUT  "HAYOBRAS",
                      OUTPUT v-valor_c,
                      OUTPUT v-valor_d,
                      OUTPUT v-valor_l,
                      OUTPUT v-valor_n,
                      OUTPUT v-observacion ).

IF v-valor_l = ? 
   THEN v-valor_l = NO.

hay_obras = v-valor_l.
